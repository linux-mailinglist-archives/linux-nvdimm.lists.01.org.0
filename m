Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6327B1F5495
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Jun 2020 14:23:47 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D1270100A22F9;
	Wed, 10 Jun 2020 05:23:45 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.96.170.134; helo=cloudserver094114.home.pl; envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN> 
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 83CD1100A457D
	for <linux-nvdimm@lists.01.org>; Wed, 10 Jun 2020 05:23:40 -0700 (PDT)
Received: from 89-64-83-71.dynamic.chello.pl (89.64.83.71) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 670f8dd764f22f7b; Wed, 10 Jun 2020 14:23:38 +0200
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Dan Williams <dan.j.williams@intel.com>, Erik Kaneda <erik.kaneda@intel.com>
Subject: [RFT][PATCH 1/3] ACPICA: Defer unmapping of memory used in memory opregions
Date: Wed, 10 Jun 2020 14:20:46 +0200
Message-ID: <4511068.xvW0IOXlyI@kreacher>
In-Reply-To: <318372766.6LKUBsbRXE@kreacher>
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com> <318372766.6LKUBsbRXE@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-ID-Hash: HUWSDLVLBW2GD4KDBIB4LBBE2TRZPSJZ
X-Message-ID-Hash: HUWSDLVLBW2GD4KDBIB4LBBE2TRZPSJZ
X-MailFrom: rjw@rjwysocki.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: rafael.j.wysocki@intel.com, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Myron Stowe <myron.stowe@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, Bob Moore <robert.moore@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HUWSDLVLBW2GD4KDBIB4LBBE2TRZPSJZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The ACPI OS layer in Linux uses RCU to protect the list of ACPI
memory mappings from being walked while it is being updated.  Among
other situations, that list can be walked in (NMI and non-NMI)
interrupt context, so using a sleeping lock to protect it is not
an option.

However, performance issues related to the RCU usage in there
appear, as described by Dan Williams:

"Recently a performance problem was reported for a process invoking
a non-trival ASL program. The method call in this case ends up
repetitively triggering a call path like:

    acpi_ex_store
    acpi_ex_store_object_to_node
    acpi_ex_write_data_to_field
    acpi_ex_insert_into_field
    acpi_ex_write_with_update_rule
    acpi_ex_field_datum_io
    acpi_ex_access_region
    acpi_ev_address_space_dispatch
    acpi_ex_system_memory_space_handler
    acpi_os_map_cleanup.part.14
    _synchronize_rcu_expedited.constprop.89
    schedule

The end result of frequent synchronize_rcu_expedited() invocation is
tiny sub-millisecond spurts of execution where the scheduler freely
migrates this apparently sleepy task. The overhead of frequent
scheduler invocation multiplies the execution time by a factor
of 2-3X."

The source of this is that acpi_ex_system_memory_space_handler()
unmaps the memory mapping currently cached by it at the access time
it that mapping doesn't cover the memory area being accessed.
Consequently, if there is a memory opregion with two fields
separated from each other by an unused chunk of address space that
is large enough for not being covered by a single mapping, and they
happen to be used in an alternating pattern, the unmapping will
occur on every acpi_ex_system_memory_space_handler() invocation for
that memory opregion and that will lead to significant overhead.

To remedy that, modify acpi_ex_system_memory_space_handler() so it
can defer the unmapping of the memory mapped by it till it is
deactivated if a special ACPI_OS_MAP_MEMORY_FAST_PATH() macro,
allowing its users to get an extra reference to a known-existing
memory mapping without actually mapping it again, is defined in the
OS layer.

Namely, make acpi_ex_system_memory_space_handler() manage an internal
list of memory mappings covering all memory accesses through it that
have occurred so far if ACPI_OS_MAP_MEMORY_FAST_PATH() is present, so
that every new mapping is added to that list with an extra reference
obtained via ACPI_OS_MAP_MEMORY_FAST_PATH() which prevents it from
being unmapped by acpi_ex_system_memory_space_handler() itself.
Of course, those mappings need to go away at one point, so change
acpi_ev_system_memory_region_setup() to unmap them when the memory
opregion holding them is deactivated.

This should reduce the acpi_ex_system_memory_space_handler() overhead
for memory opregions that do not appear and then go away immediately
after a single access.  [of course, ACPI_OS_MAP_MEMORY_FAST_PATH()
needs to be implemented by the OS for this change to take effect.]

Reported-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/evrgnini.c | 14 +++++-
 drivers/acpi/acpica/exregion.c | 90 ++++++++++++++++++++++++++++++++--
 include/acpi/actypes.h         |  8 +++
 3 files changed, 107 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index aefc0145e583..48a5e6eaf9b9 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -38,6 +38,9 @@ acpi_ev_system_memory_region_setup(acpi_handle handle,
 	union acpi_operand_object *region_desc =
 	    (union acpi_operand_object *)handle;
 	struct acpi_mem_space_context *local_region_context;
+#ifdef ACPI_OS_MAP_MEMORY_FAST_PATH
+	struct acpi_mem_mapping *mapping;
+#endif
 
 	ACPI_FUNCTION_TRACE(ev_system_memory_region_setup);
 
@@ -46,13 +49,22 @@ acpi_ev_system_memory_region_setup(acpi_handle handle,
 			local_region_context =
 			    (struct acpi_mem_space_context *)*region_context;
 
-			/* Delete a cached mapping if present */
+			/* Delete memory mappings if present */
 
 			if (local_region_context->mapped_length) {
 				acpi_os_unmap_memory(local_region_context->
 						     mapped_logical_address,
 						     local_region_context->
 						     mapped_length);
+#ifdef ACPI_OS_MAP_MEMORY_FAST_PATH
+				while (local_region_context->first_mapping) {
+					mapping = local_region_context->first_mapping;
+					local_region_context->first_mapping = mapping->next;
+					acpi_os_unmap_memory(mapping->logical_address,
+							     mapping->length);
+					ACPI_FREE(mapping);
+				}
+#endif
 			}
 			ACPI_FREE(local_region_context);
 			*region_context = NULL;
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index d15a66de26c0..703868db9551 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -44,6 +44,9 @@ acpi_ex_system_memory_space_handler(u32 function,
 	u32 length;
 	acpi_size map_length;
 	acpi_size page_boundary_map_length;
+#ifdef ACPI_OS_MAP_MEMORY_FAST_PATH
+	struct acpi_mem_mapping *mapping;
+#endif
 #ifdef ACPI_MISALIGNMENT_NOT_SUPPORTED
 	u32 remainder;
 #endif
@@ -102,7 +105,7 @@ acpi_ex_system_memory_space_handler(u32 function,
 					 mem_info->mapped_length))) {
 		/*
 		 * The request cannot be resolved by the current memory mapping;
-		 * Delete the existing mapping and create a new one.
+		 * Delete the current cached mapping and get a new one.
 		 */
 		if (mem_info->mapped_length) {
 
@@ -112,6 +115,40 @@ acpi_ex_system_memory_space_handler(u32 function,
 					     mem_info->mapped_length);
 		}
 
+#ifdef ACPI_OS_MAP_MEMORY_FAST_PATH
+		/*
+		 * Look for an existing saved mapping matching the request at
+		 * hand.  If found, bump up its reference counter in the OS
+		 * layer, cache it and carry out the access.
+		 */
+		for (mapping = mem_info->first_mapping; mapping;
+		     mapping = mapping->next) {
+			if (address < mapping->physical_address)
+				continue;
+
+			if ((u64)address + length >
+					(u64)mapping->physical_address +
+					mapping->length)
+				continue;
+
+			/*
+			 * When called on a known-existing memory mapping,
+			 * ACPI_OS_MAP_MEMORY_FAST_PATH() must return the same
+			 * logical address as before or NULL.
+			 */
+			if (!ACPI_OS_MAP_MEMORY_FAST_PATH(mapping->physical_address,
+							  mapping->length))
+				continue;
+
+			mem_info->mapped_logical_address =
+						mapping->logical_address;
+			mem_info->mapped_physical_address =
+						mapping->physical_address;
+			mem_info->mapped_length = mapping->length;
+			goto access;
+		}
+#endif /* ACPI_OS_MAP_MEMORY_FAST_PATH */
+
 		/*
 		 * October 2009: Attempt to map from the requested address to the
 		 * end of the region. However, we will never map more than one
@@ -143,9 +180,8 @@ acpi_ex_system_memory_space_handler(u32 function,
 
 		/* Create a new mapping starting at the address given */
 
-		mem_info->mapped_logical_address =
-		    acpi_os_map_memory(address, map_length);
-		if (!mem_info->mapped_logical_address) {
+		logical_addr_ptr = acpi_os_map_memory(address, map_length);
+		if (!logical_addr_ptr) {
 			ACPI_ERROR((AE_INFO,
 				    "Could not map memory at 0x%8.8X%8.8X, size %u",
 				    ACPI_FORMAT_UINT64(address),
@@ -156,10 +192,56 @@ acpi_ex_system_memory_space_handler(u32 function,
 
 		/* Save the physical address and mapping size */
 
+		mem_info->mapped_logical_address = logical_addr_ptr;
 		mem_info->mapped_physical_address = address;
 		mem_info->mapped_length = map_length;
+
+#ifdef ACPI_OS_MAP_MEMORY_FAST_PATH
+		/*
+		 * Get memory to save the new mapping for removal at the
+		 * operation region deactivation time.
+		 */
+		mapping = ACPI_ALLOCATE_ZEROED(sizeof(*mapping));
+		if (!mapping) {
+			/*
+			 * No room to save the new mapping, but this is not
+			 * critical.  Just log the error and carry out the
+			 * access as requested.
+			 */
+			ACPI_ERROR((AE_INFO,
+				    "Not enough memory to save memory mapping at 0x%8.8X%8.8X, size %u",
+				    ACPI_FORMAT_UINT64(address),
+				    (u32)map_length));
+			goto access;
+		}
+		/*
+		 * Bump up the mapping's reference counter in the OS layer to
+		 * prevent it from getting dropped prematurely.
+		 */
+		if (!ACPI_OS_MAP_MEMORY_FAST_PATH(address, map_length)) {
+			/*
+			 * Something has gone wrong, but this is not critical.
+			 * Log the error, free the memory that won't be used and
+			 * carry out the access as requested.
+			 */
+			ACPI_ERROR((AE_INFO,
+				    "Unable to save memory mapping at 0x%8.8X%8.8X, size %u",
+				    ACPI_FORMAT_UINT64(address),
+				    (u32)map_length));
+			ACPI_FREE(mapping);
+			goto access;
+		}
+		mapping->physical_address = address;
+		mapping->logical_address = logical_addr_ptr;
+		mapping->length = map_length;
+		mapping->next = mem_info->first_mapping;
+		mem_info->first_mapping = mapping;
 	}
 
+access:
+#else /* !ACPI_OS_MAP_MEMORY_FAST_PATH */
+	}
+#endif /* !ACPI_OS_MAP_MEMORY_FAST_PATH */
 	/*
 	 * Generate a logical pointer corresponding to the address we want to
 	 * access
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 4defed58ea33..64ab323b81b4 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -1200,12 +1200,20 @@ struct acpi_pci_id {
 	u16 function;
 };
 
+struct acpi_mem_mapping {
+	acpi_physical_address physical_address;
+	u8 *logical_address;
+	acpi_size length;
+	struct acpi_mem_mapping *next;
+};
+
 struct acpi_mem_space_context {
 	u32 length;
 	acpi_physical_address address;
 	acpi_physical_address mapped_physical_address;
 	u8 *mapped_logical_address;
 	acpi_size mapped_length;
+	struct acpi_mem_mapping *first_mapping;
 };
 
 /*
-- 
2.26.2



_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 966732038A7
	for <lists+linux-nvdimm@lfdr.de>; Mon, 22 Jun 2020 16:03:25 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 823BC10FC72A5;
	Mon, 22 Jun 2020 07:03:22 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.96.170.134; helo=cloudserver094114.home.pl; envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN> 
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CDBB310FC729B
	for <linux-nvdimm@lists.01.org>; Mon, 22 Jun 2020 07:03:19 -0700 (PDT)
Received: from 89-64-85-91.dynamic.chello.pl (89.64.85.91) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 053a9db2a1335a90; Mon, 22 Jun 2020 16:03:17 +0200
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Dan Williams <dan.j.williams@intel.com>, Erik Kaneda <erik.kaneda@intel.com>
Subject: [RFT][PATCH v2 3/4] ACPICA: Preserve memory opregion mappings if supported by OS
Date: Mon, 22 Jun 2020 16:01:55 +0200
Message-ID: <13749323.0m2ImmhSHx@kreacher>
In-Reply-To: <2713141.s8EVnczdoM@kreacher>
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com> <2713141.s8EVnczdoM@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-ID-Hash: LMYATE65NJSNLT7SO5OFU57MAFZEUXZT
X-Message-ID-Hash: LMYATE65NJSNLT7SO5OFU57MAFZEUXZT
X-MailFrom: rjw@rjwysocki.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: rafael.j.wysocki@intel.com, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Myron Stowe <myron.stowe@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, Bob Moore <robert.moore@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LMYATE65NJSNLT7SO5OFU57MAFZEUXZT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The ACPICA's strategy with respect to the handling of memory mappings
associated with memory operation regions is to avoid mapping the
entire region at once which may be problematic at least in principle
(for example, it may lead to conflicts with overlapping mappings
having different attributes created by drivers).  It may also be
wasteful, because memory opregions on some systems take up vast
chunks of address space while the fields in those regions actually
accessed by AML are sparsely distributed.

For this reason, a one-page "window" is mapped for a given opregion
on the first memory access through it and if that "window" does not
cover an address range accessed through that opregion subsequently,
it is unmapped and a new "window" is mapped to replace it.  Next,
if the new "window" is not sufficient to access memory through the
opregion in question in the future, it will be replaced with yet
another "window" and so on.  That may lead to a suboptimal sequence
of memory mapping and unmapping operations, for example if two fields
in one opregion separated from each other by a sufficiently wide
chunk of unused address space are accessed in an alternating pattern.

The situation may still be suboptimal if the deferred unmapping
introduced previously is supported by the OS layer.  For instance,
the alternating memory access pattern mentioned above may produce
a relatively long list of mappings to release with substantial
duplication among the entries in it, which could be avoided if
acpi_ex_system_memory_space_handler() did not release the mapping
used by it previously as soon as the current access was not covered
by it.

In order to improve that, modify acpi_ex_system_memory_space_handler()
to take advantage of the memory mappings reference counting at the OS
level if a suitable interface is provided.

Namely, if ACPI_USE_FAST_PATH_MAPPING is set, the OS is expected to
implement acpi_os_map_memory_fast_path() that will return NULL if
there is no mapping covering the given address range known to it.
If such a mapping is there, however, its reference counter will be
incremented and a pointer representing the requested virtual address
will be returned right away without any additional consequences.

That allows acpi_ex_system_memory_space_handler() to acquire
additional references to all new memory mappings with the help
of acpi_os_map_memory_fast_path() so as to retain them until the
memory opregions associated with them go away.  The function will
still use a new "window" mapping if the current one does not
cover the address range at hand, but it will avoid unmapping the
current one right away by adding it to a list of "known" mappings
associated with the given memory opregion which will be deleted at
the opregion deactivation time.  The mappings in that list can be
used every time a "new window" is needed so as to avoid overhead
related to the mapping and unmapping of memory.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/acinterp.h |   4 +
 drivers/acpi/acpica/evrgnini.c |   7 +-
 drivers/acpi/acpica/exregion.c | 159 ++++++++++++++++++++++++++++++++-
 3 files changed, 162 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpica/acinterp.h b/drivers/acpi/acpica/acinterp.h
index 1f1026fb06e9..db9c279baa2e 100644
--- a/drivers/acpi/acpica/acinterp.h
+++ b/drivers/acpi/acpica/acinterp.h
@@ -479,8 +479,12 @@ void acpi_ex_pci_cls_to_string(char *dest, u8 class_code[3]);
 
 u8 acpi_is_valid_space_id(u8 space_id);
 
+struct acpi_mem_space_context *acpi_ex_alloc_mem_space_context(void);
+
 void acpi_ex_unmap_region_memory(struct acpi_mem_space_context *mem_info);
 
+void acpi_ex_unmap_all_region_mappings(struct acpi_mem_space_context *mem_info);
+
 /*
  * exregion - default op_region handlers
  */
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index 9f33114a74ca..f6c5feea10bc 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -46,10 +46,10 @@ acpi_ev_system_memory_region_setup(acpi_handle handle,
 			local_region_context =
 			    (struct acpi_mem_space_context *)*region_context;
 
-			/* Delete a cached mapping if present */
+			/* Delete memory mappings if present */
 
 			if (local_region_context->mapped_length) {
-				acpi_ex_unmap_region_memory(local_region_context);
+				acpi_ex_unmap_all_region_mappings(local_region_context);
 			}
 			ACPI_FREE(local_region_context);
 			*region_context = NULL;
@@ -59,8 +59,7 @@ acpi_ev_system_memory_region_setup(acpi_handle handle,
 
 	/* Create a new context */
 
-	local_region_context =
-	    ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_mem_space_context));
+	local_region_context = acpi_ex_alloc_mem_space_context();
 	if (!(local_region_context)) {
 		return_ACPI_STATUS(AE_NO_MEMORY);
 	}
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index af777b7fccb0..9d97b6a67074 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -14,6 +14,40 @@
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("exregion")
 
+struct acpi_mem_mapping {
+	acpi_physical_address physical_address;
+	u8 *logical_address;
+	acpi_size length;
+	struct acpi_mem_mapping *next_mm;
+};
+
+struct acpi_mm_context {
+	struct acpi_mem_space_context mem_info;
+	struct acpi_mem_mapping *first_mm;
+};
+
+/*****************************************************************************
+ *
+ * FUNCTION:    acpi_ex_alloc_mem_space_context
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      Pointer to a new region context object.
+ *
+ * DESCRIPTION: Allocate memory for memory operation region representation.
+ *
+ ****************************************************************************/
+struct acpi_mem_space_context *acpi_ex_alloc_mem_space_context(void)
+{
+	ACPI_FUNCTION_TRACE(acpi_ex_alloc_mem_space_context);
+
+#ifdef ACPI_USE_FAST_PATH_MAPPING
+	return ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_mm_context));
+#else
+	return ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_mem_space_context));
+#endif
+}
+
 /*****************************************************************************
  *
  * FUNCTION:    acpi_ex_unmap_region_memory
@@ -40,6 +74,44 @@ void acpi_ex_unmap_region_memory(struct acpi_mem_space_context *mem_info)
 	return_VOID;
 }
 
+/*****************************************************************************
+ *
+ * FUNCTION:    acpi_ex_unmap_all_region_mappings
+ *
+ * PARAMETERS:  mem_info            - Region specific context
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Unmap all mappings associated with a memory operation region.
+ *
+ ****************************************************************************/
+void acpi_ex_unmap_all_region_mappings(struct acpi_mem_space_context *mem_info)
+{
+#ifdef ACPI_USE_FAST_PATH_MAPPING
+	struct acpi_mm_context *mm_context = (struct acpi_mm_context *)mem_info;
+	struct acpi_mem_mapping *mm;
+#endif
+
+	ACPI_FUNCTION_TRACE(acpi_ex_unmap_all_region_mappings);
+
+	acpi_ex_unmap_region_memory(mem_info);
+
+#ifdef ACPI_USE_FAST_PATH_MAPPING
+	while (mm_context->first_mm) {
+		mm = mm_context->first_mm;
+		mm_context->first_mm = mm->next_mm;
+#ifdef ACPI_USE_DEFERRED_UNMAPPING
+		acpi_os_unmap_deferred(mm->logical_address, mm->length);
+#else
+		acpi_os_unmap_memory(mm->logical_address, mm->length);
+#endif
+		ACPI_FREE(mm);
+	}
+#endif /* ACPI_USE_FAST_PATH_MAPPING */
+
+	return_VOID;
+}
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ex_system_memory_space_handler
@@ -70,6 +142,10 @@ acpi_ex_system_memory_space_handler(u32 function,
 	u32 length;
 	acpi_size map_length;
 	acpi_size page_boundary_map_length;
+#ifdef ACPI_USE_FAST_PATH_MAPPING
+	struct acpi_mm_context *mm_context = (struct acpi_mm_context *)mem_info;
+	struct acpi_mem_mapping *mm;
+#endif
 #ifdef ACPI_MISALIGNMENT_NOT_SUPPORTED
 	u32 remainder;
 #endif
@@ -128,7 +204,7 @@ acpi_ex_system_memory_space_handler(u32 function,
 					 mem_info->mapped_length))) {
 		/*
 		 * The request cannot be resolved by the current memory mapping;
-		 * Delete the existing mapping and create a new one.
+		 * Delete the current cached mapping and get a new one.
 		 */
 		if (mem_info->mapped_length) {
 
@@ -137,6 +213,36 @@ acpi_ex_system_memory_space_handler(u32 function,
 			acpi_ex_unmap_region_memory(mem_info);
 		}
 
+#ifdef ACPI_USE_FAST_PATH_MAPPING
+		/*
+		 * Look for an existing saved mapping matching the address range
+		 * at hand.  If found, make the OS layer bump up the reference
+		 * counter of that mapping, cache it and carry out the access.
+		 */
+		for (mm = mm_context->first_mm; mm; mm = mm->next_mm) {
+			if (address < mm->physical_address)
+				continue;
+
+			if ((u64)address + length >
+					(u64)mm->physical_address + mm->length)
+				continue;
+
+			/*
+			 * When called on a known-existing memory mapping,
+			 * acpi_os_map_memory_fast_path() must return the same
+			 * logical address as before or NULL.
+			 */
+			if (!acpi_os_map_memory_fast_path(mm->physical_address,
+							  mm->length))
+				continue;
+
+			mem_info->mapped_logical_address = mm->logical_address;
+			mem_info->mapped_physical_address = mm->physical_address;
+			mem_info->mapped_length = mm->length;
+			goto access;
+		}
+#endif /* ACPI_USE_FAST_PATH_MAPPING */
+
 		/*
 		 * October 2009: Attempt to map from the requested address to the
 		 * end of the region. However, we will never map more than one
@@ -168,9 +274,8 @@ acpi_ex_system_memory_space_handler(u32 function,
 
 		/* Create a new mapping starting at the address given */
 
-		mem_info->mapped_logical_address =
-		    acpi_os_map_memory(address, map_length);
-		if (!mem_info->mapped_logical_address) {
+		logical_addr_ptr = acpi_os_map_memory(address, map_length);
+		if (!logical_addr_ptr) {
 			ACPI_ERROR((AE_INFO,
 				    "Could not map memory at 0x%8.8X%8.8X, size %u",
 				    ACPI_FORMAT_UINT64(address),
@@ -181,10 +286,56 @@ acpi_ex_system_memory_space_handler(u32 function,
 
 		/* Save the physical address and mapping size */
 
+		mem_info->mapped_logical_address = logical_addr_ptr;
 		mem_info->mapped_physical_address = address;
 		mem_info->mapped_length = map_length;
+
+#ifdef ACPI_USE_FAST_PATH_MAPPING
+		/*
+		 * Create a new mm list entry to save the new mapping for
+		 * removal at the operation region deactivation time.
+		 */
+		mm = ACPI_ALLOCATE_ZEROED(sizeof(*mm));
+		if (!mm) {
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
+		 * Bump up the new mapping's reference counter in the OS layer
+		 * to prevent it from getting dropped prematurely.
+		 */
+		if (!acpi_os_map_memory_fast_path(address, map_length)) {
+			/*
+			 * Something has gone wrong, but this is not critical.
+			 * Log the error, free the mm list entry that won't be
+			 * used and carry out the access as requested.
+			 */
+			ACPI_ERROR((AE_INFO,
+				    "Unable to save memory mapping at 0x%8.8X%8.8X, size %u",
+				    ACPI_FORMAT_UINT64(address),
+				    (u32)map_length));
+			ACPI_FREE(mm);
+			goto access;
+		}
+		mm->physical_address = address;
+		mm->logical_address = logical_addr_ptr;
+		mm->length = map_length;
+		mm->next_mm = mm_context->first_mm;
+		mm_context->first_mm = mm;
 	}
 
+access:
+#else /* !ACPI_USE_FAST_PATH_MAPPING */
+	}
+#endif /* !ACPI_USE_FAST_PATH_MAPPING */
 	/*
 	 * Generate a logical pointer corresponding to the address we want to
 	 * access
-- 
2.26.2



_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

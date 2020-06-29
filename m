Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBA720D031
	for <lists+linux-nvdimm@lfdr.de>; Mon, 29 Jun 2020 18:34:58 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 99B66111B33D1;
	Mon, 29 Jun 2020 09:34:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.96.170.134; helo=cloudserver094114.home.pl; envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN> 
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4ABBF100A4626
	for <linux-nvdimm@lists.01.org>; Mon, 29 Jun 2020 09:34:54 -0700 (PDT)
Received: from 89-64-84-69.dynamic.chello.pl (89.64.84.69) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 39af2550cfacad4d; Mon, 29 Jun 2020 18:34:52 +0200
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Dan Williams <dan.j.williams@intel.com>, Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH v4 2/2] ACPICA: Preserve memory opregion mappings
Date: Mon, 29 Jun 2020 18:33:58 +0200
Message-ID: <1794490.F2OrUDcHQn@kreacher>
In-Reply-To: <1666722.UopIai5n7p@kreacher>
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com> <2788992.3K7huLjdjL@kreacher> <1666722.UopIai5n7p@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-ID-Hash: EKGSNOANCLGL6SKRDCOEHYCCM3GBPKNN
X-Message-ID-Hash: EKGSNOANCLGL6SKRDCOEHYCCM3GBPKNN
X-MailFrom: rjw@rjwysocki.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: rafael.j.wysocki@intel.com, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Myron Stowe <myron.stowe@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, Bob Moore <robert.moore@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EKGSNOANCLGL6SKRDCOEHYCCM3GBPKNN/>
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
if the new "window" is not sufficient to acess memory through the
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
to preserve all of the memory mappings created by it until the memory
regions associated with them go away.

Accordingly, update acpi_ev_system_memory_region_setup() to unmap all
memory associated with memory opregions that go away.

Reported-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/evrgnini.c | 14 ++++----
 drivers/acpi/acpica/exregion.c | 65 ++++++++++++++++++++++++----------
 include/acpi/actypes.h         | 12 +++++--
 3 files changed, 64 insertions(+), 27 deletions(-)

diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index aefc0145e583..89be3ccdad53 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -38,6 +38,7 @@ acpi_ev_system_memory_region_setup(acpi_handle handle,
 	union acpi_operand_object *region_desc =
 	    (union acpi_operand_object *)handle;
 	struct acpi_mem_space_context *local_region_context;
+	struct acpi_mem_mapping *mm;
 
 	ACPI_FUNCTION_TRACE(ev_system_memory_region_setup);
 
@@ -46,13 +47,14 @@ acpi_ev_system_memory_region_setup(acpi_handle handle,
 			local_region_context =
 			    (struct acpi_mem_space_context *)*region_context;
 
-			/* Delete a cached mapping if present */
+			/* Delete memory mappings if present */
 
-			if (local_region_context->mapped_length) {
-				acpi_os_unmap_memory(local_region_context->
-						     mapped_logical_address,
-						     local_region_context->
-						     mapped_length);
+			while (local_region_context->first_mm) {
+				mm = local_region_context->first_mm;
+				local_region_context->first_mm = mm->next_mm;
+				acpi_os_unmap_memory(mm->logical_address,
+						     mm->length);
+				ACPI_FREE(mm);
 			}
 			ACPI_FREE(local_region_context);
 			*region_context = NULL;
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index d15a66de26c0..fd68f2134804 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -41,6 +41,7 @@ acpi_ex_system_memory_space_handler(u32 function,
 	acpi_status status = AE_OK;
 	void *logical_addr_ptr = NULL;
 	struct acpi_mem_space_context *mem_info = region_context;
+	struct acpi_mem_mapping *mm = mem_info->cur_mm;
 	u32 length;
 	acpi_size map_length;
 	acpi_size page_boundary_map_length;
@@ -96,20 +97,38 @@ acpi_ex_system_memory_space_handler(u32 function,
 	 * Is 1) Address below the current mapping? OR
 	 *    2) Address beyond the current mapping?
 	 */
-	if ((address < mem_info->mapped_physical_address) ||
-	    (((u64) address + length) > ((u64)
-					 mem_info->mapped_physical_address +
-					 mem_info->mapped_length))) {
+	if (!mm || (address < mm->physical_address) ||
+	    ((u64) address + length > (u64) mm->physical_address + mm->length)) {
 		/*
-		 * The request cannot be resolved by the current memory mapping;
-		 * Delete the existing mapping and create a new one.
+		 * The request cannot be resolved by the current memory mapping.
+		 *
+		 * Look for an existing saved mapping covering the address range
+		 * at hand.  If found, save it as the current one and carry out
+		 * the access.
 		 */
-		if (mem_info->mapped_length) {
+		for (mm = mem_info->first_mm; mm; mm = mm->next_mm) {
+			if (mm == mem_info->cur_mm)
+				continue;
+
+			if (address < mm->physical_address)
+				continue;
+
+			if ((u64) address + length >
+					(u64) mm->physical_address + mm->length)
+				continue;
 
-			/* Valid mapping, delete it */
+			mem_info->cur_mm = mm;
+			goto access;
+		}
 
-			acpi_os_unmap_memory(mem_info->mapped_logical_address,
-					     mem_info->mapped_length);
+		/* Create a new mappings list entry */
+		mm = ACPI_ALLOCATE_ZEROED(sizeof(*mm));
+		if (!mm) {
+			ACPI_ERROR((AE_INFO,
+				    "Unable to save memory mapping at 0x%8.8X%8.8X, size %u",
+				    ACPI_FORMAT_UINT64(address),
+				    (u32)map_length));
+			return_ACPI_STATUS(AE_NO_MEMORY);
 		}
 
 		/*
@@ -143,29 +162,39 @@ acpi_ex_system_memory_space_handler(u32 function,
 
 		/* Create a new mapping starting at the address given */
 
-		mem_info->mapped_logical_address =
-		    acpi_os_map_memory(address, map_length);
-		if (!mem_info->mapped_logical_address) {
+		logical_addr_ptr = acpi_os_map_memory(address, map_length);
+		if (!logical_addr_ptr) {
 			ACPI_ERROR((AE_INFO,
 				    "Could not map memory at 0x%8.8X%8.8X, size %u",
 				    ACPI_FORMAT_UINT64(address),
 				    (u32)map_length));
-			mem_info->mapped_length = 0;
+			ACPI_FREE(mm);
 			return_ACPI_STATUS(AE_NO_MEMORY);
 		}
 
 		/* Save the physical address and mapping size */
 
-		mem_info->mapped_physical_address = address;
-		mem_info->mapped_length = map_length;
+		mm->logical_address = logical_addr_ptr;
+		mm->physical_address = address;
+		mm->length = map_length;
+
+		/*
+		 * Add the new entry to the mappigs list and save it as the
+		 * current mapping.
+		 */
+		mm->next_mm = mem_info->first_mm;
+		mem_info->first_mm = mm;
+
+		mem_info->cur_mm = mm;
 	}
 
+access:
 	/*
 	 * Generate a logical pointer corresponding to the address we want to
 	 * access
 	 */
-	logical_addr_ptr = mem_info->mapped_logical_address +
-	    ((u64) address - (u64) mem_info->mapped_physical_address);
+	logical_addr_ptr = mm->logical_address +
+		((u64) address - (u64) mm->physical_address);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "System-Memory (width %u) R/W %u Address=%8.8X%8.8X\n",
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index aa236b9e6f24..d005e35ab399 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -1201,12 +1201,18 @@ struct acpi_pci_id {
 	u16 function;
 };
 
+struct acpi_mem_mapping {
+	acpi_physical_address physical_address;
+	u8 *logical_address;
+	acpi_size length;
+	struct acpi_mem_mapping *next_mm;
+};
+
 struct acpi_mem_space_context {
 	u32 length;
 	acpi_physical_address address;
-	acpi_physical_address mapped_physical_address;
-	u8 *mapped_logical_address;
-	acpi_size mapped_length;
+	struct acpi_mem_mapping *cur_mm;
+	struct acpi_mem_mapping *first_mm;
 };
 
 /*
-- 
2.26.2



_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

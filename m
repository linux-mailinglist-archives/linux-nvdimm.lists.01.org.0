Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E10761F1C29
	for <lists+linux-nvdimm@lfdr.de>; Mon,  8 Jun 2020 17:33:27 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EC1F210112D70;
	Mon,  8 Jun 2020 08:33:24 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.96.170.134; helo=cloudserver094114.home.pl; envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN> 
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9BDFA10106A09
	for <linux-nvdimm@lists.01.org>; Mon,  8 Jun 2020 08:33:22 -0700 (PDT)
Received: from 89-64-83-206.dynamic.chello.pl (89.64.83.206) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 0a94423fed416ba5; Mon, 8 Jun 2020 17:33:19 +0200
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Dan Williams <dan.j.williams@intel.com>, Len Brown <lenb@kernel.org>
Subject: Re: [RFT][PATCH] ACPI: OSL: Use rwlock instead of RCU for memory management
Date: Mon, 08 Jun 2020 17:33:18 +0200
Message-ID: <3070471.70pOHYMNIP@kreacher>
In-Reply-To: <CAJZ5v0gAJyCi4YiVP4LuH3sCBWMArODDxkjKqk28Svug1+bTtw@mail.gmail.com>
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com> <CAPcyv4hWLKP7fdLhWLn8vxf5rJKvKyU0yLfDs0XMjW-9U9tM-g@mail.gmail.com> <CAJZ5v0gAJyCi4YiVP4LuH3sCBWMArODDxkjKqk28Svug1+bTtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-ID-Hash: 4J5LVUNDJT7CYEILUJVU4LPI5CE2DNES
X-Message-ID-Hash: 4J5LVUNDJT7CYEILUJVU4LPI5CE2DNES
X-MailFrom: rjw@rjwysocki.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Erik Kaneda <erik.kaneda@intel.com>, Myron Stowe <myron.stowe@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Bob Moore <robert.moore@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4J5LVUNDJT7CYEILUJVU4LPI5CE2DNES/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

On Saturday, June 6, 2020 8:56:26 AM CEST Rafael J. Wysocki wrote:
> On Fri, Jun 5, 2020 at 7:09 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Fri, Jun 5, 2020 at 7:06 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Subject: [PATCH] ACPI: OSL: Use rwlock instead of RCU for memory management
> > >
> > > The ACPI OS layer uses RCU to protect the list of ACPI memory
> > > mappings from being walked while it is updated.  Among other
> > > situations, that list can be walked in non-NMI interrupt context,
> > > so using a sleeping lock to protect it is not an option.
> > >
> > > However, performance issues related to the RCU usage in there
> > > appear, as described by Dan Williams:
> > >
> > > "Recently a performance problem was reported for a process invoking
> > > a non-trival ASL program. The method call in this case ends up
> > > repetitively triggering a call path like:
> > >
> > >     acpi_ex_store
> > >     acpi_ex_store_object_to_node
> > >     acpi_ex_write_data_to_field
> > >     acpi_ex_insert_into_field
> > >     acpi_ex_write_with_update_rule
> > >     acpi_ex_field_datum_io
> > >     acpi_ex_access_region
> > >     acpi_ev_address_space_dispatch
> > >     acpi_ex_system_memory_space_handler
> > >     acpi_os_map_cleanup.part.14
> > >     _synchronize_rcu_expedited.constprop.89
> > >     schedule
> > >
> > > The end result of frequent synchronize_rcu_expedited() invocation is
> > > tiny sub-millisecond spurts of execution where the scheduler freely
> > > migrates this apparently sleepy task. The overhead of frequent
> > > scheduler invocation multiplies the execution time by a factor
> > > of 2-3X."
> > >
> > > In order to avoid these issues, replace the RCU in the ACPI OS
> > > layer by an rwlock.
> > >
> > > That rwlock should not be frequently contended, so the performance
> > > impact of it is not expected to be significant.
> > >
> > > Reported-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >
> > > Hi Dan,
> > >
> > > This is a possible fix for the ACPI OSL RCU-related performance issues, but
> > > can you please arrange for the testing of it on the affected systems?
> >
> > Ugh, is it really this simple? I did not realize the read-side is NMI
> > safe. I'll take a look.
> 
> But if an NMI triggers while the lock is being held for writing, it
> will deadlock, won't it?
> 
> OTOH, according to the RCU documentation it is valid to call
> rcu_read_[un]lock() from an NMI handler (see Interrupts and NMIs in
> Documentation/RCU/Design/Requirements/Requirements.rst) so we are good
> from this perspective today.
> 
> Unless we teach APEI to avoid mapping lookups from
> apei_{read|write}(), which wouldn't be unreasonable by itself, we need
> to hold on to the RCU in ACPI OSL, so it looks like addressing the
> problem in ACPICA is the best way to do it (and the current ACPICA
> code in question is suboptimal, so it would be good to rework it
> anyway).
> 
> Cheers!

I've sent the prototype patch below to you, Bob and Erik in private, so
here it goes to the lists for completeness.

It introduces a "fast-path" variant of acpi_os_map_memory() that only
returns non-NULL if a matching mapping is already there in the list
and reworks acpi_ex_system_memory_space_handler() to use it.

The idea is to do a fast-path lookup first for every new mapping and
only run the full acpi_os_map_memory() if that returns NULL and then
save the mapping return by it and do a fast-path lookup for it again
to bump up its reference counter in the OSL layer.  That should prevent
the mappings from going away until the opregions that they belong to
go away (the opregion deactivation code is updated too to remove the
saved mappings), so in the cases when there's not too much opregion
creation and removal activity, it should make the RCU-related overhead
go away.

Please test.

Cheers!

---
 drivers/acpi/acpica/evrgnini.c    |   14 ++++++++-
 drivers/acpi/acpica/exregion.c    |   49 +++++++++++++++++++++++++++++--
 drivers/acpi/osl.c                |   59 ++++++++++++++++++++++++++++----------
 include/acpi/actypes.h            |    7 ++++
 include/acpi/platform/aclinuxex.h |    2 +
 5 files changed, 112 insertions(+), 19 deletions(-)

Index: linux-pm/drivers/acpi/osl.c
===================================================================
--- linux-pm.orig/drivers/acpi/osl.c
+++ linux-pm/drivers/acpi/osl.c
@@ -302,21 +302,8 @@ static void acpi_unmap(acpi_physical_add
 		iounmap(vaddr);
 }
 
-/**
- * acpi_os_map_iomem - Get a virtual address for a given physical address range.
- * @phys: Start of the physical address range to map.
- * @size: Size of the physical address range to map.
- *
- * Look up the given physical address range in the list of existing ACPI memory
- * mappings.  If found, get a reference to it and return a pointer to it (its
- * virtual address).  If not found, map it, add it to that list and return a
- * pointer to it.
- *
- * During early init (when acpi_permanent_mmap has not been set yet) this
- * routine simply calls __acpi_map_table() to get the job done.
- */
-void __iomem __ref
-*acpi_os_map_iomem(acpi_physical_address phys, acpi_size size)
+static void __iomem __ref *__acpi_os_map_iomem(acpi_physical_address phys,
+					       acpi_size size, bool fastpath)
 {
 	struct acpi_ioremap *map;
 	void __iomem *virt;
@@ -339,6 +326,11 @@ void __iomem __ref
 		goto out;
 	}
 
+	if (fastpath) {
+		mutex_unlock(&acpi_ioremap_lock);
+		return NULL;
+	}
+
 	map = kzalloc(sizeof(*map), GFP_KERNEL);
 	if (!map) {
 		mutex_unlock(&acpi_ioremap_lock);
@@ -366,6 +358,25 @@ out:
 	mutex_unlock(&acpi_ioremap_lock);
 	return map->virt + (phys - map->phys);
 }
+
+/**
+ * acpi_os_map_iomem - Get a virtual address for a given physical address range.
+ * @phys: Start of the physical address range to map.
+ * @size: Size of the physical address range to map.
+ *
+ * Look up the given physical address range in the list of existing ACPI memory
+ * mappings.  If found, get a reference to it and return a pointer representing
+ * its virtual address.  If not found, map it, add it to that list and return a
+ * pointer representing its virtual address.
+ *
+ * During early init (when acpi_permanent_mmap has not been set yet) call
+ * __acpi_map_table() to obtain the mapping.
+ */
+void __iomem __ref *acpi_os_map_iomem(acpi_physical_address phys,
+				      acpi_size size)
+{
+	return __acpi_os_map_iomem(phys, size, false);
+}
 EXPORT_SYMBOL_GPL(acpi_os_map_iomem);
 
 void *__ref acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
@@ -374,6 +385,24 @@ void *__ref acpi_os_map_memory(acpi_phys
 }
 EXPORT_SYMBOL_GPL(acpi_os_map_memory);
 
+/**
+ * acpi_os_map_memory_fastpath - Fast-path physical-to-virtual address mapping.
+ * @phys: Start of the physical address range to map.
+ * @size: Size of the physical address range to map.
+ *
+ * Look up the given physical address range in the list of existing ACPI memory
+ * mappings.  If found, get a reference to it and return a pointer representing
+ * its virtual address.  If not found, return NULL.
+ *
+ * During early init (when acpi_permanent_mmap has not been set yet) call
+ * __acpi_map_table() to obtain the mapping.
+ */
+void __ref *acpi_os_map_memory_fastpath(acpi_physical_address phys,
+					acpi_size size)
+{
+	return __acpi_os_map_iomem(phys, size, true);
+}
+
 /* Must be called with mutex_lock(&acpi_ioremap_lock) */
 static unsigned long acpi_os_drop_map_ref(struct acpi_ioremap *map)
 {
Index: linux-pm/include/acpi/actypes.h
===================================================================
--- linux-pm.orig/include/acpi/actypes.h
+++ linux-pm/include/acpi/actypes.h
@@ -1200,12 +1200,19 @@ struct acpi_pci_id {
 	u16 function;
 };
 
+struct acpi_mem_mapping {
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
Index: linux-pm/drivers/acpi/acpica/exregion.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/exregion.c
+++ linux-pm/drivers/acpi/acpica/exregion.c
@@ -44,6 +44,9 @@ acpi_ex_system_memory_space_handler(u32
 	u32 length;
 	acpi_size map_length;
 	acpi_size page_boundary_map_length;
+#ifdef ACPI_OS_MAP_MEMORY_FASTPATH
+	struct acpi_mem_mapping *new_mapping;
+#endif
 #ifdef ACPI_MISALIGNMENT_NOT_SUPPORTED
 	u32 remainder;
 #endif
@@ -143,9 +146,20 @@ acpi_ex_system_memory_space_handler(u32
 
 		/* Create a new mapping starting at the address given */
 
-		mem_info->mapped_logical_address =
-		    acpi_os_map_memory(address, map_length);
-		if (!mem_info->mapped_logical_address) {
+#ifdef ACPI_OS_MAP_MEMORY_FASTPATH
+		/* Look for an existing mapping matching the request at hand. */
+		logical_addr_ptr = acpi_os_map_memory_fastpath(address, length);
+		if (logical_addr_ptr) {
+			/*
+			 * A matching mapping has been found, so cache it and
+			 * carry our the access as requested.
+			 */
+			goto access;
+		}
+#endif /* ACPI_OS_MAP_MEMORY_FASTPATH */
+
+		logical_addr_ptr = acpi_os_map_memory(address, map_length);
+		if (!logical_addr_ptr) {
 			ACPI_ERROR((AE_INFO,
 				    "Could not map memory at 0x%8.8X%8.8X, size %u",
 				    ACPI_FORMAT_UINT64(address),
@@ -154,8 +168,37 @@ acpi_ex_system_memory_space_handler(u32
 			return_ACPI_STATUS(AE_NO_MEMORY);
 		}
 
+#ifdef ACPI_OS_MAP_MEMORY_FASTPATH
+		new_mapping = ACPI_ALLOCATE_ZEROED(sizeof(*new_mapping));
+		if (new_mapping) {
+			new_mapping->logical_address = logical_addr_ptr;
+			new_mapping->length = map_length;
+			new_mapping->next = mem_info->first_mapping;
+			mem_info->first_mapping = new_mapping;
+			/*
+			 * Carry out an extra fast-path lookup to get one more
+			 * reference to this mapping to prevent it from getting
+			 * dropped if a future access involving this region does
+			 * not fall into it.
+			 */
+			acpi_os_map_memory_fastpath(address, map_length);
+		} else {
+			/*
+			 * No room to save the new mapping, but this is not
+			 * critical.  Just log the error and carry out the
+			 * access as requested.
+			 */
+			ACPI_ERROR((AE_INFO,
+				    "Not enough memory to save memory mapping at 0x%8.8X%8.8X, size %u",
+				    ACPI_FORMAT_UINT64(address),
+				    (u32)map_length));
+		}
+
+access:
+#endif /* ACPI_OS_MAP_MEMORY_FASTPATH */
 		/* Save the physical address and mapping size */
 
+		mem_info->mapped_logical_address = logical_addr_ptr;
 		mem_info->mapped_physical_address = address;
 		mem_info->mapped_length = map_length;
 	}
Index: linux-pm/drivers/acpi/acpica/evrgnini.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evrgnini.c
+++ linux-pm/drivers/acpi/acpica/evrgnini.c
@@ -38,6 +38,9 @@ acpi_ev_system_memory_region_setup(acpi_
 	union acpi_operand_object *region_desc =
 	    (union acpi_operand_object *)handle;
 	struct acpi_mem_space_context *local_region_context;
+#ifdef ACPI_OS_MAP_MEMORY_FASTPATH
+	struct acpi_mem_mapping *mapping;
+#endif
 
 	ACPI_FUNCTION_TRACE(ev_system_memory_region_setup);
 
@@ -46,13 +49,22 @@ acpi_ev_system_memory_region_setup(acpi_
 			local_region_context =
 			    (struct acpi_mem_space_context *)*region_context;
 
-			/* Delete a cached mapping if present */
+			/* Delete memory mappings if present */
 
 			if (local_region_context->mapped_length) {
 				acpi_os_unmap_memory(local_region_context->
 						     mapped_logical_address,
 						     local_region_context->
 						     mapped_length);
+#ifdef ACPI_OS_MAP_MEMORY_FASTPATH
+				while (local_region_context->first_mapping) {
+					mapping = local_region_context->first_mapping;
+					local_region_context->first_mapping = mapping->next;
+					acpi_os_unmap_memory(mapping->logical_address,
+							     mapping->length);
+					ACPI_FREE(mapping);
+				}
+#endif /* ACPI_OS_MAP_MEMORY_FASTPATH */
 			}
 			ACPI_FREE(local_region_context);
 			*region_context = NULL;
Index: linux-pm/include/acpi/platform/aclinuxex.h
===================================================================
--- linux-pm.orig/include/acpi/platform/aclinuxex.h
+++ linux-pm/include/acpi/platform/aclinuxex.h
@@ -138,6 +138,8 @@ static inline void acpi_os_terminate_deb
 /*
  * OSL interfaces added by Linux
  */
+#define ACPI_OS_MAP_MEMORY_FASTPATH
+void *acpi_os_map_memory_fastpath(acpi_physical_address where, acpi_size length);
 
 #endif				/* __KERNEL__ */
 


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

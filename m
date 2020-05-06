Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FFB1C7E34
	for <lists+linux-nvdimm@lfdr.de>; Thu,  7 May 2020 01:55:25 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E44A2114CC969;
	Wed,  6 May 2020 16:53:29 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 925A9114CC968
	for <linux-nvdimm@lists.01.org>; Wed,  6 May 2020 16:53:27 -0700 (PDT)
IronPort-SDR: 9z9GbfZ5jKjdLdMatqlQPBp+i0jlr/a2H4NiO7DRUbGZwfFzw2vkFdG/lPHHaGYKOVg+9o79vP
 vZITXScDihrQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 16:55:20 -0700
IronPort-SDR: hDjKBQAjG74fdY55cMuXOXGU9I2V35Lv1XkTeGeBRGMBfl6opcQYgeYga3yzWKEjbxny2L0P4x
 0EMjz1nJqnNQ==
X-IronPort-AV: E=Sophos;i="5.73,361,1583222400";
   d="scan'208";a="461645509"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 16:55:19 -0700
Subject: [PATCH] ACPI: Drop rcu usage for MMIO mappings
From: Dan Williams <dan.j.williams@intel.com>
To: rafael.j.wysocki@intel.com
Date: Wed, 06 May 2020 16:39:09 -0700
Message-ID: <158880834905.2183490.15616329469420234017.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: 7C2RZKWPBIWAJ764C45VOQGTZCNT4JXL
X-Message-ID-Hash: 7C2RZKWPBIWAJ764C45VOQGTZCNT4JXL
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: stable@vger.kernel.org, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Erik Kaneda <erik.kaneda@intel.com>, Myron Stowe <myron.stowe@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7C2RZKWPBIWAJ764C45VOQGTZCNT4JXL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Recently a performance problem was reported for a process invoking a
non-trival ASL program. The method call in this case ends up
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
migrates this apparently sleepy task. The overhead of frequent scheduler
invocation multiplies the execution time by a factor of 2-3X.

For example, performance improves from 16 minutes to 7 minutes for a
firmware update procedure across 24 devices.

Perhaps the rcu usage was intended to allow for not taking a sleeping
lock in the acpi_os_{read,write}_memory() path which ostensibly could be
called from an APEI NMI error interrupt? Neither rcu_read_lock() nor
ioremap() are interrupt safe, so add a WARN_ONCE() to validate that rcu
was not serving as a mechanism to avoid direct calls to ioremap(). Even
the original implementation had a spin_lock_irqsave(), but that is not
NMI safe.

APEI itself already has some concept of avoiding ioremap() from
interrupt context (see erst_exec_move_data()), if the new warning
triggers it means that APEI either needs more instrumentation like that
to pre-emptively fail, or more infrastructure to arrange for pre-mapping
the resources it needs in NMI context.

Cc: <stable@vger.kernel.org>
Fixes: 620242ae8c3d ("ACPI: Maintain a list of ACPI memory mapped I/O remappings")
Cc: Len Brown <lenb@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: James Morse <james.morse@arm.com>
Cc: Erik Kaneda <erik.kaneda@intel.com>
Cc: Myron Stowe <myron.stowe@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/osl.c |  117 +++++++++++++++++++++++++---------------------------
 1 file changed, 57 insertions(+), 60 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 762c5d50b8fe..207528c71e9c 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -214,13 +214,13 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
 	return pa;
 }
 
-/* Must be called with 'acpi_ioremap_lock' or RCU read lock held. */
 static struct acpi_ioremap *
 acpi_map_lookup(acpi_physical_address phys, acpi_size size)
 {
 	struct acpi_ioremap *map;
 
-	list_for_each_entry_rcu(map, &acpi_ioremaps, list, acpi_ioremap_lock_held())
+	lockdep_assert_held(&acpi_ioremap_lock);
+	list_for_each_entry(map, &acpi_ioremaps, list)
 		if (map->phys <= phys &&
 		    phys + size <= map->phys + map->size)
 			return map;
@@ -228,7 +228,6 @@ acpi_map_lookup(acpi_physical_address phys, acpi_size size)
 	return NULL;
 }
 
-/* Must be called with 'acpi_ioremap_lock' or RCU read lock held. */
 static void __iomem *
 acpi_map_vaddr_lookup(acpi_physical_address phys, unsigned int size)
 {
@@ -263,7 +262,8 @@ acpi_map_lookup_virt(void __iomem *virt, acpi_size size)
 {
 	struct acpi_ioremap *map;
 
-	list_for_each_entry_rcu(map, &acpi_ioremaps, list, acpi_ioremap_lock_held())
+	lockdep_assert_held(&acpi_ioremap_lock);
+	list_for_each_entry(map, &acpi_ioremaps, list)
 		if (map->virt <= virt &&
 		    virt + size <= map->virt + map->size)
 			return map;
@@ -360,7 +360,7 @@ void __iomem __ref
 	map->size = pg_sz;
 	map->refcount = 1;
 
-	list_add_tail_rcu(&map->list, &acpi_ioremaps);
+	list_add_tail(&map->list, &acpi_ioremaps);
 
 out:
 	mutex_unlock(&acpi_ioremap_lock);
@@ -374,20 +374,13 @@ void *__ref acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
 }
 EXPORT_SYMBOL_GPL(acpi_os_map_memory);
 
-/* Must be called with mutex_lock(&acpi_ioremap_lock) */
-static unsigned long acpi_os_drop_map_ref(struct acpi_ioremap *map)
-{
-	unsigned long refcount = --map->refcount;
-
-	if (!refcount)
-		list_del_rcu(&map->list);
-	return refcount;
-}
-
-static void acpi_os_map_cleanup(struct acpi_ioremap *map)
+static void acpi_os_drop_map_ref(struct acpi_ioremap *map)
 {
-	synchronize_rcu_expedited();
+	lockdep_assert_held(&acpi_ioremap_lock);
+	if (--map->refcount > 0)
+		return;
 	acpi_unmap(map->phys, map->virt);
+	list_del(&map->list);
 	kfree(map);
 }
 
@@ -408,7 +401,6 @@ static void acpi_os_map_cleanup(struct acpi_ioremap *map)
 void __ref acpi_os_unmap_iomem(void __iomem *virt, acpi_size size)
 {
 	struct acpi_ioremap *map;
-	unsigned long refcount;
 
 	if (!acpi_permanent_mmap) {
 		__acpi_unmap_table(virt, size);
@@ -422,11 +414,8 @@ void __ref acpi_os_unmap_iomem(void __iomem *virt, acpi_size size)
 		WARN(true, PREFIX "%s: bad address %p\n", __func__, virt);
 		return;
 	}
-	refcount = acpi_os_drop_map_ref(map);
+	acpi_os_drop_map_ref(map);
 	mutex_unlock(&acpi_ioremap_lock);
-
-	if (!refcount)
-		acpi_os_map_cleanup(map);
 }
 EXPORT_SYMBOL_GPL(acpi_os_unmap_iomem);
 
@@ -461,7 +450,6 @@ void acpi_os_unmap_generic_address(struct acpi_generic_address *gas)
 {
 	u64 addr;
 	struct acpi_ioremap *map;
-	unsigned long refcount;
 
 	if (gas->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		return;
@@ -477,11 +465,8 @@ void acpi_os_unmap_generic_address(struct acpi_generic_address *gas)
 		mutex_unlock(&acpi_ioremap_lock);
 		return;
 	}
-	refcount = acpi_os_drop_map_ref(map);
+	acpi_os_drop_map_ref(map);
 	mutex_unlock(&acpi_ioremap_lock);
-
-	if (!refcount)
-		acpi_os_map_cleanup(map);
 }
 EXPORT_SYMBOL(acpi_os_unmap_generic_address);
 
@@ -700,55 +685,71 @@ int acpi_os_read_iomem(void __iomem *virt_addr, u64 *value, u32 width)
 	return 0;
 }
 
+static void __iomem *acpi_os_rw_map(acpi_physical_address phys_addr,
+				    unsigned int size, bool *did_fallback)
+{
+	void __iomem *virt_addr = NULL;
+
+	if (WARN_ONCE(in_interrupt(), "ioremap in interrupt context\n"))
+		return NULL;
+
+	/* Try to use a cached mapping and fallback otherwise */
+	*did_fallback = false;
+	mutex_lock(&acpi_ioremap_lock);
+	virt_addr = acpi_map_vaddr_lookup(phys_addr, size);
+	if (virt_addr)
+		return virt_addr;
+	mutex_unlock(&acpi_ioremap_lock);
+
+	virt_addr = acpi_os_ioremap(phys_addr, size);
+	*did_fallback = true;
+
+	return virt_addr;
+}
+
+static void acpi_os_rw_unmap(void __iomem *virt_addr, bool did_fallback)
+{
+	if (did_fallback) {
+		/* in the fallback case no lock is held */
+		iounmap(virt_addr);
+		return;
+	}
+
+	mutex_unlock(&acpi_ioremap_lock);
+}
+
 acpi_status
 acpi_os_read_memory(acpi_physical_address phys_addr, u64 *value, u32 width)
 {
-	void __iomem *virt_addr;
 	unsigned int size = width / 8;
-	bool unmap = false;
+	bool did_fallback = false;
+	void __iomem *virt_addr;
 	u64 dummy;
 	int error;
 
-	rcu_read_lock();
-	virt_addr = acpi_map_vaddr_lookup(phys_addr, size);
-	if (!virt_addr) {
-		rcu_read_unlock();
-		virt_addr = acpi_os_ioremap(phys_addr, size);
-		if (!virt_addr)
-			return AE_BAD_ADDRESS;
-		unmap = true;
-	}
-
+	virt_addr = acpi_os_rw_map(phys_addr, size, &did_fallback);
+	if (!virt_addr)
+		return AE_BAD_ADDRESS;
 	if (!value)
 		value = &dummy;
 
 	error = acpi_os_read_iomem(virt_addr, value, width);
 	BUG_ON(error);
 
-	if (unmap)
-		iounmap(virt_addr);
-	else
-		rcu_read_unlock();
-
+	acpi_os_rw_unmap(virt_addr, did_fallback);
 	return AE_OK;
 }
 
 acpi_status
 acpi_os_write_memory(acpi_physical_address phys_addr, u64 value, u32 width)
 {
-	void __iomem *virt_addr;
 	unsigned int size = width / 8;
-	bool unmap = false;
+	bool did_fallback = false;
+	void __iomem *virt_addr;
 
-	rcu_read_lock();
-	virt_addr = acpi_map_vaddr_lookup(phys_addr, size);
-	if (!virt_addr) {
-		rcu_read_unlock();
-		virt_addr = acpi_os_ioremap(phys_addr, size);
-		if (!virt_addr)
-			return AE_BAD_ADDRESS;
-		unmap = true;
-	}
+	virt_addr = acpi_os_rw_map(phys_addr, size, &did_fallback);
+	if (!virt_addr)
+		return AE_BAD_ADDRESS;
 
 	switch (width) {
 	case 8:
@@ -767,11 +768,7 @@ acpi_os_write_memory(acpi_physical_address phys_addr, u64 value, u32 width)
 		BUG();
 	}
 
-	if (unmap)
-		iounmap(virt_addr);
-	else
-		rcu_read_unlock();
-
+	acpi_os_rw_unmap(virt_addr, did_fallback);
 	return AE_OK;
 }
 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

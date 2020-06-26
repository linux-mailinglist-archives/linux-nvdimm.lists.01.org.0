Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA31A20B719
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Jun 2020 19:34:20 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B369C11001AC1;
	Fri, 26 Jun 2020 10:34:17 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.96.170.134; helo=cloudserver094114.home.pl; envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN> 
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 61FA510FE3541
	for <linux-nvdimm@lists.01.org>; Fri, 26 Jun 2020 10:34:15 -0700 (PDT)
Received: from 89-64-83-223.dynamic.chello.pl (89.64.83.223) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 85d3147370415763; Fri, 26 Jun 2020 19:34:13 +0200
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Dan Williams <dan.j.williams@intel.com>, Erik Kaneda <erik.kaneda@intel.com>
Subject: [RFT][PATCH v3 2/4] ACPI: OSL: Implement deferred unmapping of ACPI memory
Date: Fri, 26 Jun 2020 19:31:24 +0200
Message-ID: <4507864.RZ40Oy75i1@kreacher>
In-Reply-To: <2788992.3K7huLjdjL@kreacher>
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com> <2713141.s8EVnczdoM@kreacher> <2788992.3K7huLjdjL@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-ID-Hash: RKIONUBWARFHTU25TEUCMMYWWTYK5SJZ
X-Message-ID-Hash: RKIONUBWARFHTU25TEUCMMYWWTYK5SJZ
X-MailFrom: rjw@rjwysocki.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: rafael.j.wysocki@intel.com, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Myron Stowe <myron.stowe@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, Bob Moore <robert.moore@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RKIONUBWARFHTU25TEUCMMYWWTYK5SJZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Rework acpi_os_unmap_memory() so that it does not release the memory
mapping matching the given address range right away but queues it
up for later removal, implement acpi_os_release_unused_mappings()
that will remove the unused ACPI memory mappings and add invocations
of it to acpi_release_memory() and to the table loading/unloading
code, to get rid of memory mappings that may be left behind.

Reported-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_configfs.c      |   3 +
 drivers/acpi/osl.c                | 153 +++++++++++++++++++++++-------
 drivers/acpi/tables.c             |   2 +
 include/acpi/platform/aclinux.h   |   1 +
 include/acpi/platform/aclinuxex.h |   2 +
 5 files changed, 125 insertions(+), 36 deletions(-)

diff --git a/drivers/acpi/acpi_configfs.c b/drivers/acpi/acpi_configfs.c
index ece8c1a921cc..dd167ff87dc4 100644
--- a/drivers/acpi/acpi_configfs.c
+++ b/drivers/acpi/acpi_configfs.c
@@ -59,6 +59,8 @@ static ssize_t acpi_table_aml_write(struct config_item *cfg,
 		table->header = NULL;
 	}
 
+	acpi_os_release_unused_mappings();
+
 	return ret;
 }
 
@@ -224,6 +226,7 @@ static void acpi_table_drop_item(struct config_group *group,
 
 	ACPI_INFO(("Host-directed Dynamic ACPI Table Unload"));
 	acpi_unload_table(table->index);
+	acpi_os_release_unused_mappings();
 }
 
 static struct configfs_group_operations acpi_table_group_ops = {
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 762c5d50b8fe..749ae3e32193 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -77,12 +77,16 @@ struct acpi_ioremap {
 	void __iomem *virt;
 	acpi_physical_address phys;
 	acpi_size size;
-	unsigned long refcount;
+	union {
+		unsigned long refcount;
+		struct list_head gc;
+	} track;
 };
 
 static LIST_HEAD(acpi_ioremaps);
 static DEFINE_MUTEX(acpi_ioremap_lock);
 #define acpi_ioremap_lock_held() lock_is_held(&acpi_ioremap_lock.dep_map)
+static LIST_HEAD(unused_mappings);
 
 static void __init acpi_request_region (struct acpi_generic_address *gas,
 	unsigned int length, char *desc)
@@ -250,7 +254,7 @@ void __iomem *acpi_os_get_iomem(acpi_physical_address phys, unsigned int size)
 	map = acpi_map_lookup(phys, size);
 	if (map) {
 		virt = map->virt + (phys - map->phys);
-		map->refcount++;
+		map->track.refcount++;
 	}
 	mutex_unlock(&acpi_ioremap_lock);
 	return virt;
@@ -335,7 +339,7 @@ void __iomem __ref
 	/* Check if there's a suitable mapping already. */
 	map = acpi_map_lookup(phys, size);
 	if (map) {
-		map->refcount++;
+		map->track.refcount++;
 		goto out;
 	}
 
@@ -358,7 +362,7 @@ void __iomem __ref
 	map->virt = virt;
 	map->phys = pg_off;
 	map->size = pg_sz;
-	map->refcount = 1;
+	map->track.refcount = 1;
 
 	list_add_tail_rcu(&map->list, &acpi_ioremaps);
 
@@ -375,40 +379,39 @@ void *__ref acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
 EXPORT_SYMBOL_GPL(acpi_os_map_memory);
 
 /* Must be called with mutex_lock(&acpi_ioremap_lock) */
-static unsigned long acpi_os_drop_map_ref(struct acpi_ioremap *map)
+static bool acpi_os_drop_map_ref(struct acpi_ioremap *map, bool defer)
 {
-	unsigned long refcount = --map->refcount;
+	if (--map->track.refcount)
+		return true;
 
-	if (!refcount)
-		list_del_rcu(&map->list);
-	return refcount;
+	list_del_rcu(&map->list);
+
+	if (defer) {
+		INIT_LIST_HEAD(&map->track.gc);
+		list_add_tail(&map->track.gc, &unused_mappings);
+	}
+	return defer;
 }
 
-static void acpi_os_map_cleanup(struct acpi_ioremap *map)
+static void __acpi_os_map_cleanup(struct acpi_ioremap *map)
 {
-	synchronize_rcu_expedited();
 	acpi_unmap(map->phys, map->virt);
 	kfree(map);
 }
 
-/**
- * acpi_os_unmap_iomem - Drop a memory mapping reference.
- * @virt: Start of the address range to drop a reference to.
- * @size: Size of the address range to drop a reference to.
- *
- * Look up the given virtual address range in the list of existing ACPI memory
- * mappings, drop a reference to it and unmap it if there are no more active
- * references to it.
- *
- * During early init (when acpi_permanent_mmap has not been set yet) this
- * routine simply calls __acpi_unmap_table() to get the job done.  Since
- * __acpi_unmap_table() is an __init function, the __ref annotation is needed
- * here.
- */
-void __ref acpi_os_unmap_iomem(void __iomem *virt, acpi_size size)
+static void acpi_os_map_cleanup(struct acpi_ioremap *map)
+{
+	if (!map)
+		return;
+
+	synchronize_rcu_expedited();
+	__acpi_os_map_cleanup(map);
+}
+
+static void __ref __acpi_os_unmap_iomem(void __iomem *virt, acpi_size size,
+					bool defer)
 {
 	struct acpi_ioremap *map;
-	unsigned long refcount;
 
 	if (!acpi_permanent_mmap) {
 		__acpi_unmap_table(virt, size);
@@ -416,26 +419,97 @@ void __ref acpi_os_unmap_iomem(void __iomem *virt, acpi_size size)
 	}
 
 	mutex_lock(&acpi_ioremap_lock);
+
 	map = acpi_map_lookup_virt(virt, size);
 	if (!map) {
 		mutex_unlock(&acpi_ioremap_lock);
 		WARN(true, PREFIX "%s: bad address %p\n", __func__, virt);
 		return;
 	}
-	refcount = acpi_os_drop_map_ref(map);
+	if (acpi_os_drop_map_ref(map, defer))
+		map = NULL;
+
 	mutex_unlock(&acpi_ioremap_lock);
 
-	if (!refcount)
-		acpi_os_map_cleanup(map);
+	acpi_os_map_cleanup(map);
+}
+
+/**
+ * acpi_os_unmap_iomem - Drop a memory mapping reference.
+ * @virt: Start of the address range to drop a reference to.
+ * @size: Size of the address range to drop a reference to.
+ *
+ * Look up the given virtual address range in the list of existing ACPI memory
+ * mappings, drop a reference to it and unmap it if there are no more active
+ * references to it.
+ *
+ * During early init (when acpi_permanent_mmap has not been set yet) this
+ * routine simply calls __acpi_unmap_table() to get the job done.  Since
+ * __acpi_unmap_table() is an __init function, the __ref annotation is needed
+ * here.
+ */
+void __ref acpi_os_unmap_iomem(void __iomem *virt, acpi_size size)
+{
+	__acpi_os_unmap_iomem(virt, size, false);
 }
 EXPORT_SYMBOL_GPL(acpi_os_unmap_iomem);
 
+/**
+ * acpi_os_unmap_memory - Drop a memory mapping reference.
+ * @virt: Start of the address range to drop a reference to.
+ * @size: Size of the address range to drop a reference to.
+ *
+ * Look up the given virtual address range in the list of existing ACPI memory
+ * mappings, drop a reference to it and if there are no more active references
+ * to it, put it in the list of unused memory mappings.
+ *
+ * During early init (when acpi_permanent_mmap has not been set yet) this
+ * routine behaves like acpi_os_unmap_iomem().
+ */
 void __ref acpi_os_unmap_memory(void *virt, acpi_size size)
 {
-	return acpi_os_unmap_iomem((void __iomem *)virt, size);
+	__acpi_os_unmap_iomem((void __iomem *)virt, size, true);
 }
 EXPORT_SYMBOL_GPL(acpi_os_unmap_memory);
 
+/**
+ * acpi_os_release_unused_mappings - Release unused ACPI memory mappings.
+ */
+void acpi_os_release_unused_mappings(void)
+{
+	struct list_head list;
+
+	INIT_LIST_HEAD(&list);
+
+	/*
+	 * First avoid looking at mappings that may be added to the "unused"
+	 * list while the synchronize_rcu() below is running.
+	 */
+	mutex_lock(&acpi_ioremap_lock);
+
+	list_splice_init(&unused_mappings, &list);
+
+	mutex_unlock(&acpi_ioremap_lock);
+
+	if (list_empty(&list))
+		return;
+
+	/*
+	 * Wait for the possible users of the mappings in the "unused" list to
+	 * stop using them.
+	 */
+	synchronize_rcu();
+
+	/* Release the unused mappings in the list. */
+	do {
+		struct acpi_ioremap *map;
+
+		map = list_entry(list.next, struct acpi_ioremap, track.gc);
+		list_del(&map->track.gc);
+		__acpi_os_map_cleanup(map);
+	} while (!list_empty(&list));
+}
+
 int acpi_os_map_generic_address(struct acpi_generic_address *gas)
 {
 	u64 addr;
@@ -461,7 +535,6 @@ void acpi_os_unmap_generic_address(struct acpi_generic_address *gas)
 {
 	u64 addr;
 	struct acpi_ioremap *map;
-	unsigned long refcount;
 
 	if (gas->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		return;
@@ -472,16 +545,18 @@ void acpi_os_unmap_generic_address(struct acpi_generic_address *gas)
 		return;
 
 	mutex_lock(&acpi_ioremap_lock);
+
 	map = acpi_map_lookup(addr, gas->bit_width / 8);
 	if (!map) {
 		mutex_unlock(&acpi_ioremap_lock);
 		return;
 	}
-	refcount = acpi_os_drop_map_ref(map);
+	if (acpi_os_drop_map_ref(map, false))
+		map = NULL;
+
 	mutex_unlock(&acpi_ioremap_lock);
 
-	if (!refcount)
-		acpi_os_map_cleanup(map);
+	acpi_os_map_cleanup(map);
 }
 EXPORT_SYMBOL(acpi_os_unmap_generic_address);
 
@@ -1566,11 +1641,17 @@ static acpi_status acpi_deactivate_mem_region(acpi_handle handle, u32 level,
 acpi_status acpi_release_memory(acpi_handle handle, struct resource *res,
 				u32 level)
 {
+	acpi_status ret;
+
 	if (!(res->flags & IORESOURCE_MEM))
 		return AE_TYPE;
 
-	return acpi_walk_namespace(ACPI_TYPE_REGION, handle, level,
+	ret = acpi_walk_namespace(ACPI_TYPE_REGION, handle, level,
 				   acpi_deactivate_mem_region, NULL, res, NULL);
+
+	acpi_os_release_unused_mappings();
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(acpi_release_memory);
 
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 0e905c3d1645..939484a860a1 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -816,6 +816,8 @@ int __init acpi_table_init(void)
 		return -EINVAL;
 	acpi_table_initrd_scan();
 
+	acpi_os_release_unused_mappings();
+
 	check_multiple_madt();
 	return 0;
 }
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 987e2af7c335..784e294dc74c 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -133,6 +133,7 @@
 #define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_delete_raw_lock
 #define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_acquire_raw_lock
 #define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_release_raw_lock
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_release_unused_mappings
 
 /*
  * OSL interfaces used by debugger/disassembler
diff --git a/include/acpi/platform/aclinuxex.h b/include/acpi/platform/aclinuxex.h
index 04f88f2de781..ad6b905358c5 100644
--- a/include/acpi/platform/aclinuxex.h
+++ b/include/acpi/platform/aclinuxex.h
@@ -120,6 +120,8 @@ static inline void acpi_os_delete_raw_lock(acpi_raw_spinlock handle)
 	ACPI_FREE(handle);
 }
 
+void acpi_os_release_unused_mappings(void);
+
 static inline u8 acpi_os_readable(void *pointer, acpi_size length)
 {
 	return TRUE;
-- 
2.26.2



_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

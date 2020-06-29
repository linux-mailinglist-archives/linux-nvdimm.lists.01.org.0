Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 938C220D032
	for <lists+linux-nvdimm@lfdr.de>; Mon, 29 Jun 2020 18:34:59 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B2590111B33D4;
	Mon, 29 Jun 2020 09:34:57 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.96.170.134; helo=cloudserver094114.home.pl; envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN> 
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5AB05111B33D1
	for <linux-nvdimm@lists.01.org>; Mon, 29 Jun 2020 09:34:55 -0700 (PDT)
Received: from 89-64-84-69.dynamic.chello.pl (89.64.84.69) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 4a4c27ae3a89cb78; Mon, 29 Jun 2020 18:34:53 +0200
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Dan Williams <dan.j.williams@intel.com>, Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH v4 1/2] ACPI: OSL: Implement deferred unmapping of ACPI memory
Date: Mon, 29 Jun 2020 18:33:10 +0200
Message-ID: <7504970.auntBLC07g@kreacher>
In-Reply-To: <1666722.UopIai5n7p@kreacher>
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com> <2788992.3K7huLjdjL@kreacher> <1666722.UopIai5n7p@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-ID-Hash: XCXC23HYGBZNHOIPRPVM5ULCKSCN6OYT
X-Message-ID-Hash: XCXC23HYGBZNHOIPRPVM5ULCKSCN6OYT
X-MailFrom: rjw@rjwysocki.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: rafael.j.wysocki@intel.com, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Myron Stowe <myron.stowe@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, Bob Moore <robert.moore@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XCXC23HYGBZNHOIPRPVM5ULCKSCN6OYT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The ACPI OS layer in Linux uses RCU to protect the walkers of the
list of ACPI memory mappings from seeing an inconsistent state
while it is being updated.  Among other situations, that list can
be walked in (NMI and non-NMI) interrupt context, so using a
sleeping lock to protect it is not an option.

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
if that mapping doesn't cover the memory area being accessed.
Consequently, if there is a memory opregion with two fields
separated from each other by an unused chunk of address space that
is large enough for not being covered by a single mapping, and they
happen to be used in an alternating pattern, the unmapping will
occur on every acpi_ex_system_memory_space_handler() invocation for
that memory opregion and that will lead to significant overhead.

Moreover, acpi_ex_system_memory_space_handler() carries out the
memory unmapping with the namespace and interpreter mutexes held
which may lead to additional latency, because all of the tasks
wanting to acquire on of these mutexes need to wait for the
memory unmapping operation to complete.

To address that, rework acpi_os_unmap_memory() so that it does not
release the memory mapping covering the given address range right
away and instead make it queue up the mapping at hand for removal
via queue_rcu_work().

Reported-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/osl.c | 112 +++++++++++++++++++++++++++++++--------------
 1 file changed, 77 insertions(+), 35 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 762c5d50b8fe..5ced89a756a8 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -77,7 +77,10 @@ struct acpi_ioremap {
 	void __iomem *virt;
 	acpi_physical_address phys;
 	acpi_size size;
-	unsigned long refcount;
+	union {
+		unsigned long refcount;
+		struct rcu_work rwork;
+	} track;
 };
 
 static LIST_HEAD(acpi_ioremaps);
@@ -250,7 +253,7 @@ void __iomem *acpi_os_get_iomem(acpi_physical_address phys, unsigned int size)
 	map = acpi_map_lookup(phys, size);
 	if (map) {
 		virt = map->virt + (phys - map->phys);
-		map->refcount++;
+		map->track.refcount++;
 	}
 	mutex_unlock(&acpi_ioremap_lock);
 	return virt;
@@ -335,7 +338,7 @@ void __iomem __ref
 	/* Check if there's a suitable mapping already. */
 	map = acpi_map_lookup(phys, size);
 	if (map) {
-		map->refcount++;
+		map->track.refcount++;
 		goto out;
 	}
 
@@ -358,7 +361,7 @@ void __iomem __ref
 	map->virt = virt;
 	map->phys = pg_off;
 	map->size = pg_sz;
-	map->refcount = 1;
+	map->track.refcount = 1;
 
 	list_add_tail_rcu(&map->list, &acpi_ioremaps);
 
@@ -374,41 +377,46 @@ void *__ref acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
 }
 EXPORT_SYMBOL_GPL(acpi_os_map_memory);
 
+static void acpi_os_map_remove(struct acpi_ioremap *map)
+{
+	acpi_unmap(map->phys, map->virt);
+	kfree(map);
+}
+
+static void acpi_os_map_cleanup_deferred(struct work_struct *work)
+{
+	acpi_os_map_remove(container_of(to_rcu_work(work), struct acpi_ioremap,
+					track.rwork));
+}
+
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
+		INIT_RCU_WORK(&map->track.rwork, acpi_os_map_cleanup_deferred);
+		queue_rcu_work(system_wq, &map->track.rwork);
+	}
+	return defer;
 }
 
 static void acpi_os_map_cleanup(struct acpi_ioremap *map)
 {
+	if (!map)
+		return;
+
 	synchronize_rcu_expedited();
-	acpi_unmap(map->phys, map->virt);
-	kfree(map);
+	acpi_os_map_remove(map);
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
+static void __ref __acpi_os_unmap_iomem(void __iomem *virt, acpi_size size,
+					bool defer)
 {
 	struct acpi_ioremap *map;
-	unsigned long refcount;
 
 	if (!acpi_permanent_mmap) {
 		__acpi_unmap_table(virt, size);
@@ -416,23 +424,56 @@ void __ref acpi_os_unmap_iomem(void __iomem *virt, acpi_size size)
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
 
@@ -461,7 +502,6 @@ void acpi_os_unmap_generic_address(struct acpi_generic_address *gas)
 {
 	u64 addr;
 	struct acpi_ioremap *map;
-	unsigned long refcount;
 
 	if (gas->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		return;
@@ -472,16 +512,18 @@ void acpi_os_unmap_generic_address(struct acpi_generic_address *gas)
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
 
-- 
2.26.2



_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD322163D2
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jul 2020 04:15:52 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 20DFE1108DEAE;
	Mon,  6 Jul 2020 19:15:51 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C69501108DEA6
	for <linux-nvdimm@lists.01.org>; Mon,  6 Jul 2020 19:15:48 -0700 (PDT)
IronPort-SDR: WaTdcfrkKec9la5O/CZ+9y7dPnFm3B7nVb7brm1ohEKK18iQYW1B0pY3T8B0D7OeOfrkdO5a9B
 GBzOkhtE/k8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="212500813"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800";
   d="scan'208";a="212500813"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:15:48 -0700
IronPort-SDR: IcwpJjPaEOltlsXRlBhplEJH5rtqe525QdZcWSTp7pouBQnffs4MVQHgb+IW3UGrTZ5EgaadWM
 7glmLUkzMP4g==
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800";
   d="scan'208";a="314133911"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:15:48 -0700
Subject: [PATCH v2 11/12] PM,
 libnvdimm: Add 'mem-quiet' state and callback for firmware
 activation
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Mon, 06 Jul 2020 18:59:32 -0700
Message-ID: <159408717289.2385045.14094866475168644020.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159408711335.2385045.2567600405906448375.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159408711335.2385045.2567600405906448375.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: 5XFC2UAKYZL5P3MLLYXUQLWV7QZYYQ3B
X-Message-ID-Hash: 5XFC2UAKYZL5P3MLLYXUQLWV7QZYYQ3B
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5XFC2UAKYZL5P3MLLYXUQLWV7QZYYQ3B/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The runtime firmware activation capability of Intel NVDIMM devices
requires memory transactions to be disabled for 100s of microseconds.
This timeout is large enough to cause in-flight DMA to fail and other
application detectable timeouts. Arrange for firmware activation to be
executed while the system is "quiesced", all processes and device-DMA
frozen.

It is already required that invoking device ->freeze() callbacks is
sufficient to cease DMA. A device that continues memory writes outside
of user-direction violates expectations of the PM core to be to
establish a coherent hibernation image.

That said, RDMA devices are an example of a device that access memory
outside of user process direction. RDMA drivers also typically assume
the system they are operating in will never be hibernated. A solution
for RDMA collisions with firmware activation is outside the scope of
this change and may need to rely on being able to survive the platform
imposed memory controller quiesce period.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[rafael: move from suspend to hibernate post-freeze callback]
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/base/syscore.c      |   21 +++++++++++++++++++++
 drivers/nvdimm/bus.c        |   30 ++++++++++++++++++++++++++++++
 drivers/nvdimm/core.c       |    3 +++
 include/linux/syscore_ops.h |    2 ++
 kernel/power/hibernate.c    |   17 ++++++++++++-----
 kernel/power/main.c         |    1 +
 kernel/power/power.h        |    7 +++++++
 kernel/power/snapshot.c     |   13 +++++++++++++
 kernel/power/suspend.c      |   12 +++++++++++-
 9 files changed, 100 insertions(+), 6 deletions(-)

diff --git a/drivers/base/syscore.c b/drivers/base/syscore.c
index 0d346a307140..58c26281667c 100644
--- a/drivers/base/syscore.c
+++ b/drivers/base/syscore.c
@@ -108,6 +108,27 @@ void syscore_resume(void)
 	trace_suspend_resume(TPS("syscore_resume"), 0, false);
 }
 EXPORT_SYMBOL_GPL(syscore_resume);
+
+/**
+ * syscore_mem_quiet - Execute callbacks that need memory to be quiet (as
+ * if prepared to be snapshotted for hibernate)
+ *
+ * This function is executed in the hibernate path after device freeze
+ * callbacks.
+ */
+void syscore_mem_quiet(void)
+{
+	struct syscore_ops *ops;
+
+	list_for_each_entry(ops, &syscore_ops_list, node) {
+		if (!ops->mem_quiet)
+			continue;
+		if (initcall_debug)
+			pr_info("PM: Calling %pS\n", ops->mem_quiet);
+		ops->mem_quiet();
+	}
+}
+
 #endif /* CONFIG_PM_SLEEP */
 
 /**
diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 955265656b96..228b31f85c89 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -3,6 +3,7 @@
  * Copyright(c) 2013-2015 Intel Corporation. All rights reserved.
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/syscore_ops.h>
 #include <linux/libnvdimm.h>
 #include <linux/sched/mm.h>
 #include <linux/vmalloc.h>
@@ -1289,6 +1290,33 @@ static const struct file_operations nvdimm_fops = {
 	.llseek = noop_llseek,
 };
 
+static void trigger_fw_activate(struct nvdimm_bus_descriptor *nd_desc)
+{
+	if (!nd_desc->fw_ops)
+		return;
+	nd_desc->fw_ops->activate(nd_desc);
+}
+
+static void nvdimm_syscore_mem_quiet(void)
+{
+	struct nvdimm_bus *nvdimm_bus;
+
+	mutex_lock(&nvdimm_bus_list_mutex);
+	list_for_each_entry(nvdimm_bus, &nvdimm_bus_list, list) {
+		struct nvdimm_bus_descriptor *nd_desc = nvdimm_bus->nd_desc;
+		struct device *dev = &nvdimm_bus->dev;
+
+		nvdimm_bus_lock(dev);
+		trigger_fw_activate(nd_desc);
+		nvdimm_bus_unlock(dev);
+	}
+	mutex_unlock(&nvdimm_bus_list_mutex);
+}
+
+static struct syscore_ops nvdimm_syscore_ops = {
+	.mem_quiet = nvdimm_syscore_mem_quiet,
+};
+
 int __init nvdimm_bus_init(void)
 {
 	int rc;
@@ -1317,6 +1345,8 @@ int __init nvdimm_bus_init(void)
 	if (rc)
 		goto err_nd_bus;
 
+	register_syscore_ops(&nvdimm_syscore_ops);
+
 	return 0;
 
  err_nd_bus:
diff --git a/drivers/nvdimm/core.c b/drivers/nvdimm/core.c
index b1cc7b35bd51..0cbb5620cd45 100644
--- a/drivers/nvdimm/core.c
+++ b/drivers/nvdimm/core.c
@@ -417,6 +417,9 @@ static ssize_t firmware_activate_store(struct device *dev,
 	if (!nd_desc->fw_ops)
 		return -EOPNOTSUPP;
 
+	if (!sysfs_streq(buf, "activate"))
+		return -EINVAL;
+
 	nvdimm_bus_lock(dev);
 	state = nd_desc->fw_ops->activate_state(nd_desc);
 
diff --git a/include/linux/syscore_ops.h b/include/linux/syscore_ops.h
index ae4d48e4c970..b57f7a93de20 100644
--- a/include/linux/syscore_ops.h
+++ b/include/linux/syscore_ops.h
@@ -15,6 +15,7 @@ struct syscore_ops {
 	int (*suspend)(void);
 	void (*resume)(void);
 	void (*shutdown)(void);
+	void (*mem_quiet)(void);
 };
 
 extern void register_syscore_ops(struct syscore_ops *ops);
@@ -22,6 +23,7 @@ extern void unregister_syscore_ops(struct syscore_ops *ops);
 #ifdef CONFIG_PM_SLEEP
 extern int syscore_suspend(void);
 extern void syscore_resume(void);
+extern void syscore_mem_quiet(void);
 #endif
 extern void syscore_shutdown(void);
 
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 02ec716a4927..ccf2268b9f27 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -118,11 +118,18 @@ EXPORT_SYMBOL(system_entering_hibernation);
 #ifdef CONFIG_PM_DEBUG
 static void hibernation_debug_sleep(void)
 {
+	/*
+	 * The mem-quiet test state wants to get to syscore_mem_quiet()
+	 * as quickly as possible, skip all debug timeouts by default.
+	 */
+	if (pm_test_level == TEST_MEM_QUIET)
+		return;
+
 	pr_info("debug: Waiting for 5 seconds.\n");
 	mdelay(5000);
 }
 
-static int hibernation_test(int level)
+int hibernation_test(int level)
 {
 	if (pm_test_level == level) {
 		hibernation_debug_sleep();
@@ -130,9 +137,7 @@ static int hibernation_test(int level)
 	}
 	return 0;
 }
-#else /* !CONFIG_PM_DEBUG */
-static int hibernation_test(int level) { return 0; }
-#endif /* !CONFIG_PM_DEBUG */
+#endif /* CONFIG_PM_DEBUG */
 
 /**
  * platform_begin - Call platform to start hibernation.
@@ -400,11 +405,13 @@ int hibernation_snapshot(int platform_mode)
 
 	error = dpm_suspend(PMSG_FREEZE);
 
-	if (error || hibernation_test(TEST_DEVICES))
+	if (error || hibernation_test(TEST_DEVICES) || hibernation_test(TEST_MEM_QUIET))
 		platform_recover(platform_mode);
 	else
 		error = create_image(platform_mode);
 
+	syscore_mem_quiet();
+
 	/*
 	 * In the case that we call create_image() above, the control
 	 * returns here (1) after the image has been created or the
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 40f86ec4ab30..e1cebd0694b3 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -234,6 +234,7 @@ static const char * const pm_tests[__TEST_AFTER_LAST] = {
 	[TEST_PLATFORM] = "platform",
 	[TEST_DEVICES] = "devices",
 	[TEST_FREEZER] = "freezer",
+	[TEST_MEM_QUIET] = "mem-quiet",
 };
 
 static ssize_t pm_test_show(struct kobject *kobj, struct kobj_attribute *attr,
diff --git a/kernel/power/power.h b/kernel/power/power.h
index ba2094db6294..de7dd36865a5 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -233,6 +233,7 @@ enum {
 	TEST_PLATFORM,
 	TEST_DEVICES,
 	TEST_FREEZER,
+	TEST_MEM_QUIET,
 	/* keep last */
 	__TEST_AFTER_LAST
 };
@@ -246,6 +247,12 @@ extern int pm_test_level;
 #define pm_test_level	(TEST_NONE)
 #endif
 
+#ifdef CONFIG_PM_DEBUG
+int hibernation_test(int level);
+#else /* !CONFIG_PM_DEBUG */
+static inline int hibernation_test(int level) { return 0; }
+#endif /* !CONFIG_PM_DEBUG */
+
 #ifdef CONFIG_SUSPEND_FREEZER
 static inline int suspend_freeze_processes(void)
 {
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 881128b9351e..82fbc8150340 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1080,6 +1080,13 @@ int create_basic_memory_bitmaps(void)
 	struct memory_bitmap *bm1, *bm2;
 	int error = 0;
 
+	/*
+	 * No need to prep bitmaps in the case when the hibernate is
+	 * just being used trigger a memory quiesce point.
+	 */
+	if (hibernation_test(TEST_MEM_QUIET))
+		return 0;
+
 	if (forbidden_pages_map && free_pages_map)
 		return 0;
 	else
@@ -1129,6 +1136,9 @@ void free_basic_memory_bitmaps(void)
 {
 	struct memory_bitmap *bm1, *bm2;
 
+	if (hibernation_test(TEST_MEM_QUIET))
+		return;
+
 	if (WARN_ON(!(forbidden_pages_map && free_pages_map)))
 		return;
 
@@ -1702,6 +1712,9 @@ int hibernate_preallocate_memory(void)
 	ktime_t start, stop;
 	int error;
 
+	if (hibernation_test(TEST_MEM_QUIET))
+		return 0;
+
 	pr_info("Preallocating image memory\n");
 	start = ktime_get();
 
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 8b1bb5ee7e5d..ffaef2938ece 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -323,7 +323,17 @@ MODULE_PARM_DESC(pm_test_delay,
 static int suspend_test(int level)
 {
 #ifdef CONFIG_PM_DEBUG
-	if (pm_test_level == level) {
+	/*
+	 * The mem-quiet state has special meaning for the hibernate
+	 * path for the suspend path just treat it the same as
+	 * TEST_DEVICES
+	 */
+	int test_level = pm_test_level;
+
+	if (test_level == TEST_MEM_QUIET)
+		test_level = TEST_DEVICES;
+
+	if (test_level == level) {
 		pr_info("suspend debug: Waiting for %d second(s).\n",
 				pm_test_delay);
 		mdelay(pm_test_delay * 1000);
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

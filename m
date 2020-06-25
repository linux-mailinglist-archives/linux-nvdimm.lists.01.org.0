Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A58820A9A6
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Jun 2020 02:07:39 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0B8A011001ABD;
	Thu, 25 Jun 2020 17:07:38 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1D2E811001AB9
	for <linux-nvdimm@lists.01.org>; Thu, 25 Jun 2020 17:07:35 -0700 (PDT)
IronPort-SDR: M8N5JVyw7lRB2ZGY6Yf7mxT1jTh9i4YGI1EtP2ru27muGFQNVSiWhuIoEPTPfgMVJjzI3RZNzC
 J9gYn1X5s6+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="146633790"
X-IronPort-AV: E=Sophos;i="5.75,281,1589266800";
   d="scan'208";a="146633790"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 17:07:34 -0700
IronPort-SDR: vbOy0EkJBx4ysZTd5/AcJkQQVnL7b7ro0Mu2coswDb2tbdEdNB0gv2sGJggA3nJqQMGqnVRgXV
 vu4NeYqmg+nA==
X-IronPort-AV: E=Sophos;i="5.75,281,1589266800";
   d="scan'208";a="302171967"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 17:07:33 -0700
Subject: [PATCH 11/12] PM,
 libnvdimm: Add syscore_quiesced() callback for firmware activation
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Thu, 25 Jun 2020 16:51:19 -0700
Message-ID: <159312907937.1850128.15890323251117466770.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159312902033.1850128.1712559453279208264.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159312902033.1850128.1712559453279208264.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: 5KAIL36CCM2WXD7IKUAZLEKYTWKRA2VM
X-Message-ID-Hash: 5KAIL36CCM2WXD7IKUAZLEKYTWKRA2VM
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5KAIL36CCM2WXD7IKUAZLEKYTWKRA2VM/>
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
executed while the system is "quiesced" all suspend operations have
completed successfully.

Note that the placement of syscore_quiesced() before
suspend_disable_secondary_cpus() and the "TEST_PLATFORM" early exit in
suspend_enter():

        if (suspend_test(TEST_PLATFORM))
                goto Platform_wake;

...is a deliberate tradeoff. suspend_disable_secondary_cpus() causes
violence to drivers with many interrupts allocated (server-class network
adapters for example). So, allow for triggering firmware-activation
without requiring all irq vectors to be routed (oversubscribed) to a
single CPU.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/base/syscore.c      |   18 ++++++++++++++++++
 drivers/nvdimm/bus.c        |   30 ++++++++++++++++++++++++++++++
 drivers/nvdimm/core.c       |    3 +++
 include/linux/syscore_ops.h |    2 ++
 kernel/power/suspend.c      |    2 ++
 5 files changed, 55 insertions(+)

diff --git a/drivers/base/syscore.c b/drivers/base/syscore.c
index 0d346a307140..9fbe47d5b50a 100644
--- a/drivers/base/syscore.c
+++ b/drivers/base/syscore.c
@@ -108,6 +108,24 @@ void syscore_resume(void)
 	trace_suspend_resume(TPS("syscore_resume"), 0, false);
 }
 EXPORT_SYMBOL_GPL(syscore_resume);
+
+/**
+ * syscore_quiesced - Execute callbacks that need a quiesced system
+ *
+ * This function is executed after all syscore_suspend() callbacks have
+ * completed successfully.
+ */
+void syscore_quiesced(void)
+{
+	struct syscore_ops *ops;
+
+	list_for_each_entry(ops, &syscore_ops_list, node) {
+		if (!ops->quiesced)
+			continue;
+		ops->quiesced();
+	}
+}
+
 #endif /* CONFIG_PM_SLEEP */
 
 /**
diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 955265656b96..c1b6ffe3d2fc 100644
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
+static void nvdimm_syscore_quiesced(void)
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
+	.quiesced = nvdimm_syscore_quiesced,
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
index ae4d48e4c970..2bffe7cca613 100644
--- a/include/linux/syscore_ops.h
+++ b/include/linux/syscore_ops.h
@@ -15,6 +15,7 @@ struct syscore_ops {
 	int (*suspend)(void);
 	void (*resume)(void);
 	void (*shutdown)(void);
+	void (*quiesced)(void);
 };
 
 extern void register_syscore_ops(struct syscore_ops *ops);
@@ -22,6 +23,7 @@ extern void unregister_syscore_ops(struct syscore_ops *ops);
 #ifdef CONFIG_PM_SLEEP
 extern int syscore_suspend(void);
 extern void syscore_resume(void);
+extern void syscore_quiesced(void);
 #endif
 extern void syscore_shutdown(void);
 
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 8b1bb5ee7e5d..5929f49dc44c 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -414,6 +414,8 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 	if (error)
 		goto Platform_wake;
 
+	syscore_quiesced();
+
 	if (suspend_test(TEST_PLATFORM))
 		goto Platform_wake;
 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

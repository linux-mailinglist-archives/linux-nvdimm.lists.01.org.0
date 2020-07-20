Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B315E22723F
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 Jul 2020 00:24:28 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 78188124059B8;
	Mon, 20 Jul 2020 15:24:27 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3BCCB124059A8
	for <linux-nvdimm@lists.01.org>; Mon, 20 Jul 2020 15:24:25 -0700 (PDT)
IronPort-SDR: DaJmPA3aeMQWJ8tRfb0/p4N8PNNUpqIqOzDZfvSNNh5pl3iZzplbN9p6hv83ywH+9A2Kn0qGir
 l31H+QbvhcIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="168162232"
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800";
   d="scan'208";a="168162232"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 15:24:24 -0700
IronPort-SDR: 6FBNJWGcBCpI6Zitti5qkNj5ViUANRiDp9dki/pzUJ2cDoPQlHm56Ujj6bdgEFw/GG5LoCZKHw
 9QAL2uhUPbXw==
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800";
   d="scan'208";a="271553180"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 15:24:24 -0700
Subject: [PATCH v3 08/11] driver-core: Introduce DEVICE_ATTR_ADMIN_{RO,RW}
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Mon, 20 Jul 2020 15:08:07 -0700
Message-ID: <159528288766.993790.5647904882591265970.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159528284411.993790.11733759435137949717.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159528284411.993790.11733759435137949717.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: MUIT5JFSLVUJCH7KWX4XGBXMQH5JXYM2
X-Message-ID-Hash: MUIT5JFSLVUJCH7KWX4XGBXMQH5JXYM2
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MUIT5JFSLVUJCH7KWX4XGBXMQH5JXYM2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

A common pattern for using plain DEVICE_ATTR() instead of
DEVICE_ATTR_RO() and DEVICE_ATTR_RW() is for attributes that want to
limit read to only root.  I.e. many users of DEVICE_ATTR() are
specifying 0400 or 0600 for permissions.

Given the expectation that CAP_SYS_ADMIN is needed to access these
sensitive attributes add an explicit helper with the _ADMIN_ identifier
for DEVICE_ATTR_ADMIN_{RO,RW}.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/device.h |    4 ++++
 include/linux/sysfs.h  |    7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 15460a5ac024..d7c2570368fa 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -128,8 +128,12 @@ ssize_t device_store_bool(struct device *dev, struct device_attribute *attr,
 		__ATTR_PREALLOC(_name, _mode, _show, _store)
 #define DEVICE_ATTR_RW(_name) \
 	struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
+#define DEVICE_ATTR_ADMIN_RW(_name) \
+	struct device_attribute dev_attr_##_name = __ATTR_RW_MODE(_name, 0600)
 #define DEVICE_ATTR_RO(_name) \
 	struct device_attribute dev_attr_##_name = __ATTR_RO(_name)
+#define DEVICE_ATTR_ADMIN_RO(_name) \
+	struct device_attribute dev_attr_##_name = __ATTR_RO_MODE(_name, 0400)
 #define DEVICE_ATTR_WO(_name) \
 	struct device_attribute dev_attr_##_name = __ATTR_WO(_name)
 #define DEVICE_ULONG_ATTR(_name, _mode, _var) \
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 86067dbe7745..34e84122f635 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -123,6 +123,13 @@ struct attribute_group {
 	.show	= _name##_show,						\
 }
 
+#define __ATTR_RW_MODE(_name, _mode) {					\
+	.attr	= { .name = __stringify(_name),				\
+		    .mode = VERIFY_OCTAL_PERMISSIONS(_mode) },		\
+	.show	= _name##_show,						\
+	.store	= _name##_store,					\
+}
+
 #define __ATTR_WO(_name) {						\
 	.attr	= { .name = __stringify(_name), .mode = 0200 },		\
 	.store	= _name##_store,					\
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

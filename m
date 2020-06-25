Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF6820A99D
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Jun 2020 02:07:20 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B3FBB1102228E;
	Thu, 25 Jun 2020 17:07:19 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C32C811001ABD
	for <linux-nvdimm@lists.01.org>; Thu, 25 Jun 2020 17:07:18 -0700 (PDT)
IronPort-SDR: HrNP4ewzrVxgnPbHWrAiSS3pwW1NDffLjmNYLiYFzoleI+DvTQSb19n2gZUq3+ux78y7/VY5jI
 7lQI9955fNmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="144216645"
X-IronPort-AV: E=Sophos;i="5.75,281,1589266800";
   d="scan'208";a="144216645"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 17:07:18 -0700
IronPort-SDR: 76Ox8bokFZgyiPf263ilWt6Ewy5R1Ypt/xKK4Dm5hluCqIfGCUlvAhDrM6QsibCZ/3nZAGMAKW
 lHe2HlDkxb2g==
X-IronPort-AV: E=Sophos;i="5.75,281,1589266800";
   d="scan'208";a="453192861"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 17:07:18 -0700
Subject: [PATCH 08/12] driver-core: Introduce DEVICE_ATTR_ADMIN_{RO,RW}
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Thu, 25 Jun 2020 16:51:03 -0700
Message-ID: <159312906372.1850128.11611897078988158727.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159312902033.1850128.1712559453279208264.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159312902033.1850128.1712559453279208264.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: 2V2PQS7WROVGJQE3B2IKXJUP5LCL7MS3
X-Message-ID-Hash: 2V2PQS7WROVGJQE3B2IKXJUP5LCL7MS3
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2V2PQS7WROVGJQE3B2IKXJUP5LCL7MS3/>
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
sensitive attributes and an explicit helper with the _ADMIN_ identifier
for DEVICE_ATTR_ADMIN_{RO,RW}.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

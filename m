Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF3FEE948
	for <lists+linux-nvdimm@lfdr.de>; Mon,  4 Nov 2019 21:16:27 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 55651100EA546;
	Mon,  4 Nov 2019 12:19:13 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AF56E100EEBB5
	for <linux-nvdimm@lists.01.org>; Mon,  4 Nov 2019 12:19:10 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 12:16:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,268,1569308400";
   d="scan'208";a="232191599"
Received: from vverma7-desk1.amr.corp.intel.com (HELO vverma7-desk1.lm.intel.com) ([10.232.112.164])
  by fmsmga002.fm.intel.com with ESMTP; 04 Nov 2019 12:16:22 -0800
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH v3 2/2] ndctl/namespace: introduce ndctl_namespace_is_configuration_idle()
Date: Mon,  4 Nov 2019 13:16:15 -0700
Message-Id: <20191104201615.30828-2-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191104201615.30828-1-vishal.l.verma@intel.com>
References: <20191104201615.30828-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Message-ID-Hash: HLF2PQH7MTX6TRPWQ72WIYFIPFIKCSWN
X-Message-ID-Hash: HLF2PQH7MTX6TRPWQ72WIYFIPFIKCSWN
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HLF2PQH7MTX6TRPWQ72WIYFIPFIKCSWN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The motivation for this change is that we want to refrain from
(re)configuring what appear to be partially configured namespaces.
Namespaces may end up in a state that looks partially configured when
the kernel isn't able to enable a namespace due to mismatched
PAGE_SIZE expectations. In such cases, ndctl should not treat those
as unconfigured 'seed' namespaces, and reuse them.

Add a new ndctl_namespace_is_configuration_idle API, whish tests whether a
namespace is active, and whether it is partially configured. If neither
are true, then it can be used for (re)configuration. Additionally, deal
with the corner case of ND_DEVICE_NAMESPACE_IO (legacy PMEM) namespaces
which always appear as configured, since their size cannot be changed,
but they are also always re-configurable.

Use this API in namespace_reconfig() and namespace_create() to enable
this partial configuration detection.

Cc: Dan Williams <dan.j.williams@intel.com>
Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---

Changes in v3:
- Remove stray leftovers in sysfs.{c,h} and namespace_is_writable() from
  libndctl.c

Changes in v2:
- Remove sysfs_attr_writable, and just check for the nstype of
  ND_DEVICE_NAMESPACE_IO (Dan)
- Rename ndctl_namespace_is_configurable to
  ndctl_namespace_is_configuration_idle (Dan)


 ndctl/lib/libndctl.c   | 21 +++++++++++++++++++++
 ndctl/lib/libndctl.sym |  4 ++++
 ndctl/libndctl.h       |  1 +
 ndctl/namespace.c      |  6 +++---
 4 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index 6596f94..d6a2800 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -4182,6 +4182,27 @@ NDCTL_EXPORT int ndctl_namespace_is_configured(struct ndctl_namespace *ndns)
 	}
 }
 
+/*
+ * Check if a given 'seed' namespace is ok to configure.
+ * If a size or uuid is present, it is considered not configuration-idle,
+ * except in the case of legacy (ND_DEVICE_NAMESPACE_IO) namespaces. In
+ * that case, the size is never zero, but the namespace can still be
+ * reconfigured.
+ */
+NDCTL_EXPORT int ndctl_namespace_is_configuration_idle(
+		struct ndctl_namespace *ndns)
+{
+	if (ndctl_namespace_is_active(ndns))
+		return 0;
+	if (ndctl_namespace_is_configured(ndns)) {
+		if (ndctl_namespace_get_type(ndns) == ND_DEVICE_NAMESPACE_IO)
+			return 1;
+		return 0;
+	}
+	/* !active and !configured is configuration-idle */
+	return 1;
+}
+
 NDCTL_EXPORT void ndctl_namespace_get_uuid(struct ndctl_namespace *ndns, uuid_t uu)
 {
 	memcpy(uu, ndns->uuid, sizeof(uuid_t));
diff --git a/ndctl/lib/libndctl.sym b/ndctl/lib/libndctl.sym
index c93c1ee..4e76778 100644
--- a/ndctl/lib/libndctl.sym
+++ b/ndctl/lib/libndctl.sym
@@ -423,3 +423,7 @@ LIBNDCTL_21 {
 LIBNDCTL_22 {
 	ndctl_dimm_security_is_frozen;
 } LIBNDCTL_21;
+
+LIBNDCTL_23 {
+	ndctl_namespace_is_configuration_idle;
+} LIBNDCTL_22;
diff --git a/ndctl/libndctl.h b/ndctl/libndctl.h
index db398b3..9a53049 100644
--- a/ndctl/libndctl.h
+++ b/ndctl/libndctl.h
@@ -491,6 +491,7 @@ int ndctl_namespace_disable_safe(struct ndctl_namespace *ndns);
 bool ndctl_namespace_is_active(struct ndctl_namespace *ndns);
 int ndctl_namespace_is_valid(struct ndctl_namespace *ndns);
 int ndctl_namespace_is_configured(struct ndctl_namespace *ndns);
+int ndctl_namespace_is_configuration_idle(struct ndctl_namespace *ndns);
 int ndctl_namespace_delete(struct ndctl_namespace *ndns);
 int ndctl_namespace_set_uuid(struct ndctl_namespace *ndns, uuid_t uu);
 void ndctl_namespace_get_uuid(struct ndctl_namespace *ndns, uuid_t uu);
diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index ccd46d0..a07d7e2 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -779,7 +779,7 @@ static struct ndctl_namespace *region_get_namespace(struct ndctl_region *region)
 	/* prefer the 0th namespace if it is idle */
 	ndctl_namespace_foreach(region, ndns)
 		if (ndctl_namespace_get_id(ndns) == 0
-				&& !ndctl_namespace_is_active(ndns))
+				&& ndctl_namespace_is_configuration_idle(ndns))
 			return ndns;
 	return ndctl_region_get_namespace_seed(region);
 }
@@ -819,7 +819,7 @@ static int namespace_create(struct ndctl_region *region)
 		p.size = available;
 
 	ndns = region_get_namespace(region);
-	if (!ndns || ndctl_namespace_is_active(ndns)) {
+	if (!ndns || !ndctl_namespace_is_configuration_idle(ndns)) {
 		debug("%s: no %s namespace seed\n", devname,
 				ndns ? "idle" : "available");
 		return -EAGAIN;
@@ -1066,7 +1066,7 @@ static int namespace_reconfig(struct ndctl_region *region,
 	}
 
 	ndns = region_get_namespace(region);
-	if (!ndns || !ndctl_namespace_is_active(ndns)) {
+	if (!ndns || !ndctl_namespace_is_configuration_idle(ndns)) {
 		debug("%s: no %s namespace seed\n",
 				ndctl_region_get_devname(region),
 				ndns ? "idle" : "available");
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

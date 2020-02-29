Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EF417495C
	for <lists+linux-nvdimm@lfdr.de>; Sat, 29 Feb 2020 21:39:13 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9720310FC36FE;
	Sat, 29 Feb 2020 12:40:03 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 03D3810FC3765
	for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 12:40:02 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:39:10 -0800
X-IronPort-AV: E=Sophos;i="5.70,501,1574150400";
   d="scan'208";a="257481503"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:39:10 -0800
Subject: [ndctl PATCH 34/36] ndctl/list: Add option to list configured +
 disabled namespaces
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: vishal.l.verma@intel.com
Date: Sat, 29 Feb 2020 12:23:05 -0800
Message-ID: <158300778534.2141307.3858623337643122737.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: BJGXUR7XYK5TA4BY2E6E4NKEXVDK3QSC
X-Message-ID-Hash: BJGXUR7XYK5TA4BY2E6E4NKEXVDK3QSC
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BJGXUR7XYK5TA4BY2E6E4NKEXVDK3QSC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When inspecting namespaces multiple tools require the namespace to be
disabled so that the tool can change modes to inspect namespace
metadata, for example read-infoblock and check-namespace.

While a namespace is disabled it can be listed with "--idle", but that
will also include seed namespaces in the output. Add a --configured
option that lists includes namespaces with non-zero size in the listing.
For regions, dimms, and buses, it is equivalent to --idle.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ndctl/ndctl-list.txt |    6 ++++++
 ndctl/list.c                       |   23 ++++++++++++++++++-----
 util/json.c                        |    3 ++-
 util/json.h                        |    1 +
 4 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/Documentation/ndctl/ndctl-list.txt b/Documentation/ndctl/ndctl-list.txt
index bc725baa6656..7c7e3ac9d05c 100644
--- a/Documentation/ndctl/ndctl-list.txt
+++ b/Documentation/ndctl/ndctl-list.txt
@@ -179,6 +179,12 @@ include::xable-bus-options.txt[]
 --idle::
 	Include idle (not enabled) devices in the listing
 
+-c::
+--configured::
+	Include configured devices (non-zero sized namespaces)
+	regardless of whether they are enabled, or not. Other devices
+	besides namespaces are always considered "configured".
+
 -C::
 --capabilities::
 	Include region capabilities in the listing, i.e. supported
diff --git a/ndctl/list.c b/ndctl/list.c
index aedccfe8fe75..31fb1b9593a2 100644
--- a/ndctl/list.c
+++ b/ndctl/list.c
@@ -37,6 +37,7 @@ static struct {
 	bool human;
 	bool firmware;
 	bool capabilities;
+	bool configured;
 	int verbose;
 } list;
 
@@ -46,6 +47,8 @@ static unsigned long listopts_to_flags(void)
 
 	if (list.idle)
 		flags |= UTIL_JSON_IDLE;
+	if (list.configured)
+		flags |= UTIL_JSON_CONFIGURED;
 	if (list.media_errors)
 		flags |= UTIL_JSON_MEDIA_ERRORS;
 	if (list.dax)
@@ -165,7 +168,8 @@ static struct json_object *region_to_json(struct ndctl_region *region,
 		if (!util_dimm_filter(dimm, param.dimm))
 			continue;
 
-		if (!list.idle && !ndctl_dimm_is_enabled(dimm))
+		if (!list.configured && !list.idle
+				&& !ndctl_dimm_is_enabled(dimm))
 			continue;
 
 		if (!jmappings) {
@@ -242,8 +246,15 @@ static void filter_namespace(struct ndctl_namespace *ndns,
 	struct json_object *jndns;
 	struct list_filter_arg *lfa = ctx->list;
 	struct json_object *container = lfa->jregion ? lfa->jregion : lfa->jbus;
-
-	if (!list.idle && !ndctl_namespace_is_active(ndns))
+	unsigned long long size = ndctl_namespace_get_size(ndns);
+
+	if (ndctl_namespace_is_active(ndns))
+		/* pass */;
+	else if (list.idle)
+		/* pass */;
+	else if (list.configured && (size > 0 && size < ULLONG_MAX))
+		/* pass */;
+	else
 		return;
 
 	if (!lfa->jnamespaces) {
@@ -277,7 +288,7 @@ static bool filter_region(struct ndctl_region *region,
 	if (!list.regions)
 		return true;
 
-	if (!list.idle && !ndctl_region_is_enabled(region))
+	if (!list.configured && !list.idle && !ndctl_region_is_enabled(region))
 		return true;
 
 	if (!lfa->jregions) {
@@ -319,7 +330,7 @@ static void filter_dimm(struct ndctl_dimm *dimm, struct util_filter_ctx *ctx)
 	struct list_filter_arg *lfa = ctx->list;
 	struct json_object *jdimm;
 
-	if (!list.idle && !ndctl_dimm_is_enabled(dimm))
+	if (!list.configured && !list.idle && !ndctl_dimm_is_enabled(dimm))
 		return;
 
 	if (!lfa->jdimms) {
@@ -477,6 +488,8 @@ int cmd_list(int argc, const char **argv, struct ndctl_ctx *ctx)
 		OPT_BOOLEAN('C', "capabilities", &list.capabilities,
 				"include region capability info"),
 		OPT_BOOLEAN('i', "idle", &list.idle, "include idle devices"),
+		OPT_BOOLEAN('c', "configured", &list.configured,
+				"include configured namespaces, disabled or not"),
 		OPT_BOOLEAN('M', "media-errors", &list.media_errors,
 				"include media errors"),
 		OPT_BOOLEAN('u', "human", &list.human,
diff --git a/util/json.c b/util/json.c
index 50346c5bcbab..21ab25674624 100644
--- a/util/json.c
+++ b/util/json.c
@@ -339,7 +339,8 @@ struct json_object *util_daxctl_devs_to_list(struct daxctl_region *region,
 		if (!util_daxctl_dev_filter(dev, ident))
 			continue;
 
-		if (!(flags & UTIL_JSON_IDLE) && !daxctl_dev_get_size(dev))
+		if (!(flags & (UTIL_JSON_IDLE|UTIL_JSON_CONFIGURED))
+				&& !daxctl_dev_get_size(dev))
 			continue;
 
 		if (!jdevs) {
diff --git a/util/json.h b/util/json.h
index 7c3f64932cec..6d39d3aa4693 100644
--- a/util/json.h
+++ b/util/json.h
@@ -25,6 +25,7 @@ enum util_json_flags {
 	UTIL_JSON_HUMAN = (1 << 4),
 	UTIL_JSON_VERBOSE = (1 << 5),
 	UTIL_JSON_CAPABILITIES = (1 << 6),
+	UTIL_JSON_CONFIGURED = (1 << 7),
 };
 
 struct json_object;
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

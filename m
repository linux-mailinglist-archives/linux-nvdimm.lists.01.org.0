Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E748174947
	for <lists+linux-nvdimm@lfdr.de>; Sat, 29 Feb 2020 21:37:34 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 917B310FC358B;
	Sat, 29 Feb 2020 12:38:24 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3E74410FC340D
	for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 12:38:22 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:37:30 -0800
X-IronPort-AV: E=Sophos;i="5.70,501,1574150400";
   d="scan'208";a="232628832"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:37:29 -0800
Subject: [ndctl PATCH 15/36] ndctl/namespace: Disable autorecovery of
 create-namespace failures
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: vishal.l.verma@intel.com
Date: Sat, 29 Feb 2020 12:21:24 -0800
Message-ID: <158300768489.2141307.13494707984161864818.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: MG2Y2OSOYL3HGCJFTJQTMZ5SYOSG3WDT
X-Message-ID-Hash: MG2Y2OSOYL3HGCJFTJQTMZ5SYOSG3WDT
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MG2Y2OSOYL3HGCJFTJQTMZ5SYOSG3WDT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add an option to disable the behavior of cleaning up namespaces that
failed creation. This is useful for doing forensics on the label and
info-block state after the failure with assurances that the kernel has
not made further modifications.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ndctl/ndctl-create-namespace.txt |    9 +++++++++
 ndctl/namespace.c                              |   13 +++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/Documentation/ndctl/ndctl-create-namespace.txt b/Documentation/ndctl/ndctl-create-namespace.txt
index 7637e2403132..92a89dd71e82 100644
--- a/Documentation/ndctl/ndctl-create-namespace.txt
+++ b/Documentation/ndctl/ndctl-create-namespace.txt
@@ -229,6 +229,15 @@ OPTIONS
 	ndctl init-labels all
 	ndctl enable-region all
 
+-R::
+--autorecover::
+--no-autorecover::
+	By default, if a namespace creation attempt fails, ndctl will
+	cleanup the partially initialized namespace. Use
+	--no-autorecover to disable this behavior for debug and
+	development scenarios where it useful to have the label and
+	info-block state preserved after a failure.
+
 -v::
 --verbose::
 	Emit debug messages for the namespace creation process
diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index 91e25044145b..cd75038f5ae3 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -44,6 +44,7 @@ static struct parameters {
 	bool autolabel;
 	bool greedy;
 	bool verify;
+	bool autorecover;
 	bool human;
 	bool json;
 	const char *bus;
@@ -61,6 +62,7 @@ static struct parameters {
 	const char *infile;
 } param = {
 	.autolabel = true,
+	.autorecover = true,
 };
 
 const char *cmd_name = "namespace";
@@ -87,6 +89,7 @@ struct parsed_parameters {
 	unsigned long sector_size;
 	unsigned long align;
 	bool autolabel;
+	bool autorecover;
 };
 
 #define pr_verbose(fmt, ...) \
@@ -136,7 +139,8 @@ OPT_STRING('a', "align", &param.align, "align", \
 OPT_BOOLEAN('f', "force", &force, "reconfigure namespace even if currently active"), \
 OPT_BOOLEAN('L', "autolabel", &param.autolabel, "automatically initialize labels"), \
 OPT_BOOLEAN('c', "continue", &param.greedy, \
-	"continue creating namespaces as long as the filter criteria are met")
+	"continue creating namespaces as long as the filter criteria are met"), \
+OPT_BOOLEAN('R', "autorecover", &param.autorecover, "automatically cleanup on failure")
 
 #define CHECK_OPTIONS() \
 OPT_BOOLEAN('R', "repair", &repair, "perform metadata repairs"), \
@@ -474,7 +478,7 @@ static int setup_namespace(struct ndctl_region *region,
 			try(ndctl_pfn, set_align, pfn, p->align);
 		try(ndctl_pfn, set_namespace, pfn, ndns);
 		rc = ndctl_pfn_enable(pfn);
-		if (rc)
+		if (rc && p->autorecover)
 			ndctl_pfn_set_namespace(pfn, NULL);
 	} else if (p->mode == NDCTL_NS_MODE_DAX) {
 		struct ndctl_dax *dax = ndctl_region_get_dax_seed(region);
@@ -488,7 +492,7 @@ static int setup_namespace(struct ndctl_region *region,
 		try(ndctl_dax, set_align, dax, p->align);
 		try(ndctl_dax, set_namespace, dax, ndns);
 		rc = ndctl_dax_enable(dax);
-		if (rc)
+		if (rc && p->autorecover)
 			ndctl_dax_set_namespace(dax, NULL);
 	} else if (p->mode == NDCTL_NS_MODE_SAFE) {
 		struct ndctl_btt *btt = ndctl_region_get_btt_seed(region);
@@ -848,6 +852,7 @@ static int validate_namespace_options(struct ndctl_region *region,
 
 
 	p->autolabel = param.autolabel;
+	p->autorecover = param.autorecover;
 
 	return 0;
 }
@@ -906,7 +911,7 @@ static int namespace_create(struct ndctl_region *region)
 	}
 
 	rc = setup_namespace(region, ndns, &p);
-	if (rc) {
+	if (rc && p.autorecover) {
 		ndctl_namespace_set_enforce_mode(ndns, NDCTL_NS_MODE_RAW);
 		ndctl_namespace_delete(ndns);
 	}
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

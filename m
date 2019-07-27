Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF7F77C2C
	for <lists+linux-nvdimm@lfdr.de>; Sat, 27 Jul 2019 23:54:51 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3B177212E25B6;
	Sat, 27 Jul 2019 14:57:17 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.115; helo=mga14.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6D56E212E2590
 for <linux-nvdimm@lists.01.org>; Sat, 27 Jul 2019 14:57:15 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jul 2019 14:54:48 -0700
X-IronPort-AV: E=Sophos;i="5.64,315,1559545200"; d="scan'208";a="178765165"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jul 2019 14:54:48 -0700
Subject: [ndctl PATCH v2 13/26] ndctl/namespace: Disable autorecovery of
 create-namespace failures
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sat, 27 Jul 2019 14:40:30 -0700
Message-ID: <156426363088.531577.18014256906347104823.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156426356088.531577.14828880045306313118.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156426356088.531577.14828880045306313118.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

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
index 343733dedfd9..ed936c87e483 100644
--- a/Documentation/ndctl/ndctl-create-namespace.txt
+++ b/Documentation/ndctl/ndctl-create-namespace.txt
@@ -203,6 +203,15 @@ OPTIONS
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
index a3963d79831a..58fec194ab94 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -43,6 +43,7 @@ static struct parameters {
 	bool mode_default;
 	bool autolabel;
 	bool verify;
+	bool autorecover;
 	bool human;
 	bool json;
 	const char *bus;
@@ -60,6 +61,7 @@ static struct parameters {
 	const char *infile;
 } param = {
 	.autolabel = true,
+	.autorecover = true,
 };
 
 void builtin_xaction_namespace_reset(void)
@@ -84,6 +86,7 @@ struct parsed_parameters {
 	unsigned long sector_size;
 	unsigned long align;
 	bool autolabel;
+	bool autorecover;
 };
 
 #define pr_verbose(fmt, ...) \
@@ -127,7 +130,8 @@ OPT_STRING('t', "type", &param.type, "type", \
 OPT_STRING('a', "align", &param.align, "align", \
 	"specify the namespace alignment in bytes (default: 2M)"), \
 OPT_BOOLEAN('f', "force", &force, "reconfigure namespace even if currently active"), \
-OPT_BOOLEAN('L', "autolabel", &param.autolabel, "automatically initialize labels")
+OPT_BOOLEAN('L', "autolabel", &param.autolabel, "automatically initialize labels"), \
+OPT_BOOLEAN('R', "autorecover", &param.autorecover, "automatically cleanup on failure")
 
 #define CHECK_OPTIONS() \
 OPT_BOOLEAN('R', "repair", &repair, "perform metadata repairs"), \
@@ -444,7 +448,7 @@ static int setup_namespace(struct ndctl_region *region,
 			try(ndctl_pfn, set_align, pfn, p->align);
 		try(ndctl_pfn, set_namespace, pfn, ndns);
 		rc = ndctl_pfn_enable(pfn);
-		if (rc)
+		if (rc && p->autorecover)
 			ndctl_pfn_set_namespace(pfn, NULL);
 	} else if (p->mode == NDCTL_NS_MODE_DAX) {
 		struct ndctl_dax *dax = ndctl_region_get_dax_seed(region);
@@ -455,7 +459,7 @@ static int setup_namespace(struct ndctl_region *region,
 		try(ndctl_dax, set_align, dax, p->align);
 		try(ndctl_dax, set_namespace, dax, ndns);
 		rc = ndctl_dax_enable(dax);
-		if (rc)
+		if (rc && p->autorecover)
 			ndctl_dax_set_namespace(dax, NULL);
 	} else if (p->mode == NDCTL_NS_MODE_SAFE) {
 		struct ndctl_btt *btt = ndctl_region_get_btt_seed(region);
@@ -798,6 +802,7 @@ static int validate_namespace_options(struct ndctl_region *region,
 
 
 	p->autolabel = param.autolabel;
+	p->autorecover = param.autorecover;
 
 	return 0;
 }
@@ -852,7 +857,7 @@ static int namespace_create(struct ndctl_region *region)
 	}
 
 	rc = setup_namespace(region, ndns, &p);
-	if (rc) {
+	if (rc && p.autorecover) {
 		ndctl_namespace_set_enforce_mode(ndns, NDCTL_NS_MODE_RAW);
 		ndctl_namespace_delete(ndns);
 	}

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA097174943
	for <lists+linux-nvdimm@lfdr.de>; Sat, 29 Feb 2020 21:37:12 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1B67510FC3418;
	Sat, 29 Feb 2020 12:38:03 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E78D310FC3418
	for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 12:37:59 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:37:07 -0800
X-IronPort-AV: E=Sophos;i="5.70,501,1574150400";
   d="scan'208";a="262203359"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:37:07 -0800
Subject: [ndctl PATCH 11/36] ndctl/namespace: Validate resource alignment
 for dax-mode namespaces
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sat, 29 Feb 2020 12:21:02 -0800
Message-ID: <158300766271.2141307.12541085220843554138.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: RKFGYC3RLF6CKPWNRWAKCFHXDF5OBN2U
X-Message-ID-Hash: RKFGYC3RLF6CKPWNRWAKCFHXDF5OBN2U
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RKFGYC3RLF6CKPWNRWAKCFHXDF5OBN2U/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The kernel sets the default region alignment to 16M to promote
cross-arch compatible namespace creation. While ndctl never touches the
region alignment the end user might have changed it from its default.
Enforce 16MiB alignment for the namespace resource base by default for
dax-mode namespaces.

It is still possible to use a 2MiB region-align for dax-mode namespaces
on x86, but that requires --force to bypass this default alignment
check.

I chose a hard coded default value in ndctl with a --force to bypass the
check rather than having a new sysfs attribute to probe for this detail.
I.e. the kernel could export the minimum alignment for dax namespaces,
but since the minimum compat value is already known, no need for a trip
to the kernel.

Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ndctl/ndctl-create-namespace.txt |    8 ++++++++
 ndctl/namespace.c                              |   24 ++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/Documentation/ndctl/ndctl-create-namespace.txt b/Documentation/ndctl/ndctl-create-namespace.txt
index 8cd80fa789c1..7637e2403132 100644
--- a/Documentation/ndctl/ndctl-create-namespace.txt
+++ b/Documentation/ndctl/ndctl-create-namespace.txt
@@ -88,6 +88,14 @@ OPTIONS
 	    fault scenarios are supported. I.e. if a device is
 	    configured with a 2M alignment an attempt to fault a 4K
 	    aligned offset will result in SIGBUS.
+::
+	Note both 'fsdax' and 'devdax' mode require 16MiB physical
+	alignment to be cross-arch compatible. By default ndctl will
+	block attempts to create namespaces in these modes when the
+	physical starting address of the namespace is not 16MiB aligned.
+	The --force option tries to override this constraint if the
+	platform supports a smaller alignment, but this is not
+	recommended.
 
 -s::
 --size=::
diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index c4aab94abcd4..96d318166300 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -356,6 +356,24 @@ static bool do_setup_pfn(struct ndctl_namespace *ndns,
 	return false;
 }
 
+static int check_dax_align(struct ndctl_namespace *ndns)
+{
+	unsigned long long resource = ndctl_namespace_get_resource(ndns);
+	const char *devname = ndctl_namespace_get_devname(ndns);
+
+	if (resource == ULLONG_MAX) {
+		warning("%s unable to validate alignment\n", devname);
+		return 0;
+	}
+
+	if (IS_ALIGNED(resource, SZ_16M) || force)
+		return 0;
+
+	error("%s misaligned to 16M, adjust region alignment and retry\n",
+			devname);
+	return -EINVAL;
+}
+
 static int setup_namespace(struct ndctl_region *region,
 		struct ndctl_namespace *ndns, struct parsed_parameters *p)
 {
@@ -406,6 +424,9 @@ static int setup_namespace(struct ndctl_region *region,
 	if (do_setup_pfn(ndns, p)) {
 		struct ndctl_pfn *pfn = ndctl_region_get_pfn_seed(region);
 
+		rc = check_dax_align(ndns);
+		if (rc)
+			return rc;
 		try(ndctl_pfn, set_uuid, pfn, uuid);
 		try(ndctl_pfn, set_location, pfn, p->loc);
 		if (ndctl_pfn_has_align(pfn))
@@ -417,6 +438,9 @@ static int setup_namespace(struct ndctl_region *region,
 	} else if (p->mode == NDCTL_NS_MODE_DAX) {
 		struct ndctl_dax *dax = ndctl_region_get_dax_seed(region);
 
+		rc = check_dax_align(ndns);
+		if (rc)
+			return rc;
 		try(ndctl_dax, set_uuid, dax, uuid);
 		try(ndctl_dax, set_location, dax, p->loc);
 		/* device-dax assumes 'align' attribute present */
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

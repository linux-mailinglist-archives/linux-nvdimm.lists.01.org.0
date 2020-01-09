Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607BC135230
	for <lists+linux-nvdimm@lfdr.de>; Thu,  9 Jan 2020 05:33:36 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2DCCF10097E1D;
	Wed,  8 Jan 2020 20:36:53 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A24F710097E1A
	for <linux-nvdimm@lists.01.org>; Wed,  8 Jan 2020 20:36:50 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 20:33:30 -0800
X-IronPort-AV: E=Sophos;i="5.69,412,1571727600";
   d="scan'208";a="216177013"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 20:33:30 -0800
Subject: [ndctl PATCH] ndctl/namespace: Fix destroy-namespace accounting
 relative to seed devices
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Wed, 08 Jan 2020 20:17:28 -0800
Message-ID: <157854344810.1994459.8270881085555839853.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: DBUZID4CXPKKV7NRCFMBPT6TF3SE2IWI
X-Message-ID-Hash: DBUZID4CXPKKV7NRCFMBPT6TF3SE2IWI
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DBUZID4CXPKKV7NRCFMBPT6TF3SE2IWI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Seed namespaces are included in "ndctl destroy-namespace all". However
since the user never "creates" them it is surprising to see
"destroy-namespace" report 1 more namespace relative to the number that
have been created. Catch attempts to destroy a zero-sized namespace:

Before:
# ndctl create-namespace -s 500M
{
  "dev":"namespace1.0",
  "size":"492.00 MiB (515.90 MB)",
  "blockdev":"pmem1"
}
# ndctl create-namespace -s 500M
{
  "dev":"namespace1.1",
  "size":"492.00 MiB (515.90 MB)",
  "blockdev":"pmem1.1"
}
# ndctl create-namespace -s 500M
{
  "dev":"namespace1.2",
  "size":"492.00 MiB (515.90 MB)",
  "blockdev":"pmem1.2"
}
# ndctl destroy-namespace -r 1 all -f
destroyed 4 namespaces

After:
# ndctl create-namespace -s 500M
{
  "dev":"namespace1.0",
  "size":"492.00 MiB (515.90 MB)",
  "blockdev":"pmem1"
}
# ndctl create-namespace -s 500M
{
  "dev":"namespace1.3",
  "size":"492.00 MiB (515.90 MB)",
  "blockdev":"pmem1.3"
}
# ndctl create-namespace -s 500M
{
  "dev":"namespace1.1",
  "size":"492.00 MiB (515.90 MB)",
  "blockdev":"pmem1.1"
}
# ndctl destroy-namespace -r 1 all -f
destroyed 3 namespaces

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 ndctl/namespace.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index 2f463509f8ca..994b4e8791ea 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -907,6 +907,7 @@ static int namespace_destroy(struct ndctl_region *region,
 	struct ndctl_pfn *pfn = ndctl_namespace_get_pfn(ndns);
 	struct ndctl_dax *dax = ndctl_namespace_get_dax(ndns);
 	struct ndctl_btt *btt = ndctl_namespace_get_btt(ndns);
+	unsigned long long size;
 	bool did_zero = false;
 	int rc;
 
@@ -953,10 +954,19 @@ static int namespace_destroy(struct ndctl_region *region,
 		goto out;
 	}
 
+	size = ndctl_namespace_get_size(ndns);
+
 	rc = ndctl_namespace_delete(ndns);
 	if (rc)
 		debug("%s: failed to reclaim\n", devname);
 
+	/*
+	 * Don't report a destroyed namespace when no capacity was
+	 * allocated.
+	 */
+	if (size == 0 && rc == 0)
+		rc = 1;
+
 out:
 	return rc;
 }
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

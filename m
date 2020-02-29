Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FE6174946
	for <lists+linux-nvdimm@lfdr.de>; Sat, 29 Feb 2020 21:37:29 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7C27510FC358B;
	Sat, 29 Feb 2020 12:38:19 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 987B810FC3418
	for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 12:38:16 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:37:24 -0800
X-IronPort-AV: E=Sophos;i="5.70,501,1574150400";
   d="scan'208";a="351177021"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:37:24 -0800
Subject: [ndctl PATCH 14/36] ndctl/namespace: Always zero info-blocks
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: vishal.l.verma@intel.com
Date: Sat, 29 Feb 2020 12:21:19 -0800
Message-ID: <158300767949.2141307.3972886777511825287.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: TXIJTRXLUGBIVBXNGDVNM5IK733OOG5Y
X-Message-ID-Hash: TXIJTRXLUGBIVBXNGDVNM5IK733OOG5Y
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TXIJTRXLUGBIVBXNGDVNM5IK733OOG5Y/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Do not gate zeroing on whether a namespace is claimed by a personality.
The namespace might not have been able to be claimed due to info-block
corruption.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 ndctl/namespace.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index 9bc54abfd437..91e25044145b 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -984,9 +984,6 @@ static int namespace_destroy(struct ndctl_region *region,
 		struct ndctl_namespace *ndns)
 {
 	const char *devname = ndctl_namespace_get_devname(ndns);
-	struct ndctl_pfn *pfn = ndctl_namespace_get_pfn(ndns);
-	struct ndctl_dax *dax = ndctl_namespace_get_dax(ndns);
-	struct ndctl_btt *btt = ndctl_namespace_get_btt(ndns);
 	unsigned long long size;
 	bool did_zero = false;
 	int rc;
@@ -1009,13 +1006,11 @@ static int namespace_destroy(struct ndctl_region *region,
 
 	ndctl_namespace_set_enforce_mode(ndns, NDCTL_NS_MODE_RAW);
 
-	if (pfn || btt || dax) {
-		rc = zero_info_block(ndns);
-		if (rc < 0)
-			return rc;
-		if (rc == 0)
-			did_zero = true;
-	}
+	rc = zero_info_block(ndns);
+	if (rc < 0)
+		return rc;
+	if (rc == 0)
+		did_zero = true;
 
 	switch (ndctl_namespace_get_type(ndns)) {
         case ND_DEVICE_NAMESPACE_PMEM:
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

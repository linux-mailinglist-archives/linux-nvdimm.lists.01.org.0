Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F66EF10C
	for <lists+linux-nvdimm@lfdr.de>; Tue,  5 Nov 2019 00:09:14 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DF1BE100EA550;
	Mon,  4 Nov 2019 15:11:59 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4A5FD100EA542
	for <linux-nvdimm@lists.01.org>; Mon,  4 Nov 2019 15:11:57 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 15:09:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,268,1569308400";
   d="scan'208";a="195622120"
Received: from vverma7-desk1.amr.corp.intel.com (HELO vverma7-desk1.lm.intel.com) ([10.232.112.164])
  by orsmga008.jf.intel.com with ESMTP; 04 Nov 2019 15:09:09 -0800
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH 2/2] ndctl/namespace: For enable-namespace all, don't count no-op namespaces
Date: Mon,  4 Nov 2019 16:08:57 -0700
Message-Id: <20191104230857.28172-2-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191104230857.28172-1-vishal.l.verma@intel.com>
References: <20191104230857.28172-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Message-ID-Hash: CNCMHI4NUSXVMWYVO3XOZYBILGI75ADN
X-Message-ID-Hash: CNCMHI4NUSXVMWYVO3XOZYBILGI75ADN
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CNCMHI4NUSXVMWYVO3XOZYBILGI75ADN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When ndctl-enable-namespace is called for namespaces that are already
enabled, it shouldn't report that a positive number of namespaces were
enabled. Check whether the namespace is enabled, and if so, omit it from
the 'processed' count.

Since the indentation-heavy section for ACTION_ENABLE is getting larger
than a simgle libndctl call, break it out into its own namespace_enable()
helper.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 ndctl/namespace.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index ed0421b..cebc312 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -961,6 +961,20 @@ out:
 	return rc;
 }
 
+static int namespace_enable(struct ndctl_namespace *ndns)
+{
+	if (ndctl_namespace_is_enabled(ndns))
+		return 1;
+
+	if (ndctl_namespace_is_configuration_idle(ndns)) {
+		debug("%s: skip seed namespace\n",
+			ndctl_namespace_get_devname(ndns));
+		return 1;
+	}
+
+	return ndctl_namespace_enable(ndns);
+}
+
 static int enable_labels(struct ndctl_region *region)
 {
 	int mappings = ndctl_region_get_mappings(region);
@@ -1401,16 +1415,12 @@ static int do_xaction_namespace(const char *namespace,
 						(*processed)++;
 					break;
 				case ACTION_ENABLE:
-					if (ndctl_namespace_is_configuration_idle(ndns)) {
-						debug("%s: skip seed namespace\n",
-							ndctl_namespace_get_devname(ndns));
-						continue;
-					}
-					rc = ndctl_namespace_enable(ndns);
-					if (rc >= 0) {
+					rc = namespace_enable(ndns);
+					if (rc == 0)
 						(*processed)++;
+					/* return success if skipped */
+					if (rc > 0)
 						rc = 0;
-					}
 					break;
 				case ACTION_DESTROY:
 					rc = namespace_destroy(region, ndns);
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

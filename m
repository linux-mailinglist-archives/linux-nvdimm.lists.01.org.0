Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BFAF0411
	for <lists+linux-nvdimm@lfdr.de>; Tue,  5 Nov 2019 18:27:32 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 011E2100DC42C;
	Tue,  5 Nov 2019 09:30:11 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EF85F100DC426
	for <linux-nvdimm@lists.01.org>; Tue,  5 Nov 2019 09:30:08 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2019 09:27:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,271,1569308400";
   d="scan'208";a="232547289"
Received: from vverma7-desk1.amr.corp.intel.com (HELO vverma7-desk1.lm.intel.com) ([10.232.112.164])
  by fmsmga002.fm.intel.com with ESMTP; 05 Nov 2019 09:27:27 -0800
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH v2 2/2] ndctl/namespace: fix reported count for disable-namespace
Date: Tue,  5 Nov 2019 10:27:13 -0700
Message-Id: <20191105172713.3628-2-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191105172713.3628-1-vishal.l.verma@intel.com>
References: <20191105172713.3628-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Message-ID-Hash: MBHAEM2RCVFR4CQJ634P5M5U5AP7P5GS
X-Message-ID-Hash: MBHAEM2RCVFR4CQJ634P5M5U5AP7P5GS
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MBHAEM2RCVFR4CQJ634P5M5U5AP7P5GS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Make the count reported disable-namespace consistent with
enable-namespace by skipping namespaces that were already disabled.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 ndctl/namespace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index f2987ca..57998ce 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -1426,6 +1426,10 @@ static int do_xaction_namespace(const char *namespace,
 					continue;
 				switch (action) {
 				case ACTION_DISABLE:
+					if (!ndctl_namespace_is_enabled(ndns)) {
+						rc = 0;
+						continue;
+					}
 					rc = ndctl_namespace_disable_safe(ndns);
 					if (rc == 0)
 						(*processed)++;
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7164218FCB5
	for <lists+linux-nvdimm@lfdr.de>; Mon, 23 Mar 2020 19:33:32 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5F59D10FC3797;
	Mon, 23 Mar 2020 11:34:20 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 297A710FC3795
	for <linux-nvdimm@lists.01.org>; Mon, 23 Mar 2020 11:34:17 -0700 (PDT)
IronPort-SDR: 5e8qogPGXFZ2Exo5oOVGtdDvAnIN5idSmlqkvCzyeYARWAHUA//rnsQSeJ7M29olO3AX3W8BzF
 C5bxDP+2ftpw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 11:33:27 -0700
IronPort-SDR: B03f1vwCdxCHL3w4Yhekp9Z1aQnzlD41FgcEt06hKL3fts6nMv9Cr6uhYoUvbrWYG9I6n1RPcp
 RvzdasFQno8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,297,1580803200";
   d="scan'208";a="419597505"
Received: from vverma7-desk1.amr.corp.intel.com (HELO vverma7-desk1.lm.intel.com) ([10.232.112.164])
  by orsmga005.jf.intel.com with ESMTP; 23 Mar 2020 11:33:26 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH] ndctl/namespace: Fix a resource leak in file_write_infoblock
Date: Mon, 23 Mar 2020 12:33:21 -0600
Message-Id: <20200323183321.21889-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Message-ID-Hash: 4Q6SYEWNSW5PEIMYE3PMECONWI7LHFDW
X-Message-ID-Hash: 4Q6SYEWNSW5PEIMYE3PMECONWI7LHFDW
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4Q6SYEWNSW5PEIMYE3PMECONWI7LHFDW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Static analysis reported that we were leaking 'fd' in one case in the
above function, fix the error handling to go through the 'out' label.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 ndctl/namespace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index 21252b6..0550580 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -1958,8 +1958,10 @@ static int file_write_infoblock(const char *path)
 	}
 
 	buf = calloc(INFOBLOCK_SZ, 1);
-	if (!buf)
-		return -ENOMEM;
+	if (!buf) {
+		rc = -ENOMEM;
+		goto out;
+	}
 
 	switch (util_nsmode(param.mode)) {
 	case NDCTL_NS_MODE_FSDAX:
-- 
2.21.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

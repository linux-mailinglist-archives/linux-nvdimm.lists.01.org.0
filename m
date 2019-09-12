Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DCBB06E9
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Sep 2019 04:55:10 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CFB5021959CB2;
	Wed, 11 Sep 2019 19:55:14 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=216.40.44.115;
 helo=smtprelay.hostedemail.com; envelope-from=joe@perches.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from smtprelay.hostedemail.com (smtprelay0115.hostedemail.com
 [216.40.44.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5F8A7202C8097
 for <linux-nvdimm@lists.01.org>; Wed, 11 Sep 2019 19:55:13 -0700 (PDT)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay06.hostedemail.com (Postfix) with ESMTP id 4C50318225E0B;
 Thu, 12 Sep 2019 02:55:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2, 0, 0, , d41d8cd98f00b204, joe@perches.com, :::::::::::::::,
 RULES_HIT:41:69:355:379:541:800:960:966:973:988:989:1260:1345:1359:1437:1534:1542:1711:1730:1747:1777:1792:2196:2199:2393:2559:2562:3138:3139:3140:3141:3142:3353:3865:3866:3867:3868:4385:5007:6119:6261:7903:8603:10004:10848:11026:11658:11914:12043:12048:12296:12297:12555:12683:12895:14110:14181:14394:14721:21080:21627:30054,
 0,
 RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,
 CacheIP:none, Bayesian:0.5, 0.5, 0.5, Netcheck:none, DomainCache:0,
 MSF:not bulk, SPF:fn, MSBL:0, DNSBL:neutral, Custom_rules:0:0:0, LFtime:25,
 LUA_SUMMARY:none
X-HE-Tag: wash17_837480261ff44
X-Filterd-Recvd-Size: 3818
Received: from joe-laptop.perches.com (unknown [47.151.152.152])
 (Authenticated sender: joe@perches.com)
 by omf16.hostedemail.com (Postfix) with ESMTPA;
 Thu, 12 Sep 2019 02:55:03 +0000 (UTC)
From: Joe Perches <joe@perches.com>
To: Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Keith Busch <keith.busch@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 03/13] nvdimm: Use octal permissions
Date: Wed, 11 Sep 2019 19:54:33 -0700
Message-Id: <93cf2f046486416fbcea19a8194411e3f44fd2d3.1568256706.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1568256705.git.joe@perches.com>
References: <cover.1568256705.git.joe@perches.com>
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
Cc: linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
 linux-nvdimm@lists.01.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Avoid the use of the S_IRUGO define and use 0444 to improve readability
and use a more common kernel style.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/nvdimm/btt.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 6362d96dfc16..9cad4dca6eac 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -229,27 +229,24 @@ static void arena_debugfs_init(struct arena_info *a, struct dentry *parent,
 		return;
 	a->debugfs_dir = d;
 
-	debugfs_create_x64("size", S_IRUGO, d, &a->size);
-	debugfs_create_x64("external_lba_start", S_IRUGO, d,
-			   &a->external_lba_start);
-	debugfs_create_x32("internal_nlba", S_IRUGO, d, &a->internal_nlba);
-	debugfs_create_u32("internal_lbasize", S_IRUGO, d,
-			   &a->internal_lbasize);
-	debugfs_create_x32("external_nlba", S_IRUGO, d, &a->external_nlba);
-	debugfs_create_u32("external_lbasize", S_IRUGO, d,
-			   &a->external_lbasize);
-	debugfs_create_u32("nfree", S_IRUGO, d, &a->nfree);
-	debugfs_create_u16("version_major", S_IRUGO, d, &a->version_major);
-	debugfs_create_u16("version_minor", S_IRUGO, d, &a->version_minor);
-	debugfs_create_x64("nextoff", S_IRUGO, d, &a->nextoff);
-	debugfs_create_x64("infooff", S_IRUGO, d, &a->infooff);
-	debugfs_create_x64("dataoff", S_IRUGO, d, &a->dataoff);
-	debugfs_create_x64("mapoff", S_IRUGO, d, &a->mapoff);
-	debugfs_create_x64("logoff", S_IRUGO, d, &a->logoff);
-	debugfs_create_x64("info2off", S_IRUGO, d, &a->info2off);
-	debugfs_create_x32("flags", S_IRUGO, d, &a->flags);
-	debugfs_create_u32("log_index_0", S_IRUGO, d, &a->log_index[0]);
-	debugfs_create_u32("log_index_1", S_IRUGO, d, &a->log_index[1]);
+	debugfs_create_x64("size", 0444, d, &a->size);
+	debugfs_create_x64("external_lba_start", 0444, d, &a->external_lba_start);
+	debugfs_create_x32("internal_nlba", 0444, d, &a->internal_nlba);
+	debugfs_create_u32("internal_lbasize", 0444, d, &a->internal_lbasize);
+	debugfs_create_x32("external_nlba", 0444, d, &a->external_nlba);
+	debugfs_create_u32("external_lbasize", 0444, d, &a->external_lbasize);
+	debugfs_create_u32("nfree", 0444, d, &a->nfree);
+	debugfs_create_u16("version_major", 0444, d, &a->version_major);
+	debugfs_create_u16("version_minor", 0444, d, &a->version_minor);
+	debugfs_create_x64("nextoff", 0444, d, &a->nextoff);
+	debugfs_create_x64("infooff", 0444, d, &a->infooff);
+	debugfs_create_x64("dataoff", 0444, d, &a->dataoff);
+	debugfs_create_x64("mapoff", 0444, d, &a->mapoff);
+	debugfs_create_x64("logoff", 0444, d, &a->logoff);
+	debugfs_create_x64("info2off", 0444, d, &a->info2off);
+	debugfs_create_x32("flags", 0444, d, &a->flags);
+	debugfs_create_u32("log_index_0", 0444, d, &a->log_index[0]);
+	debugfs_create_u32("log_index_1", 0444, d, &a->log_index[1]);
 }
 
 static void btt_debugfs_init(struct btt *btt)
-- 
2.15.0

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

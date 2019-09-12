Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CBFB06EF
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Sep 2019 04:55:15 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0F3142194EB70;
	Wed, 11 Sep 2019 19:55:20 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=216.40.44.71;
 helo=smtprelay.hostedemail.com; envelope-from=joe@perches.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from smtprelay.hostedemail.com (smtprelay0071.hostedemail.com
 [216.40.44.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 8E1D3202C8099
 for <linux-nvdimm@lists.01.org>; Wed, 11 Sep 2019 19:55:18 -0700 (PDT)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay03.hostedemail.com (Postfix) with ESMTP id CF71E8024B57;
 Thu, 12 Sep 2019 02:55:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2, 0, 0, , d41d8cd98f00b204, joe@perches.com, :::::::::::::::,
 RULES_HIT:41:355:379:541:800:960:973:988:989:1260:1345:1359:1437:1534:1541:1711:1730:1747:1777:1792:2194:2199:2393:2559:2562:3138:3139:3140:3141:3142:3352:3865:3866:3868:3870:4321:5007:6261:10004:10848:11026:11658:11914:12048:12296:12297:12438:12555:12895:13069:13138:13231:13311:13357:14181:14384:14394:14721:21080:21324:21451:21627:30054,
 0,
 RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,
 CacheIP:none, Bayesian:0.5, 0.5, 0.5, Netcheck:none, DomainCache:0,
 MSF:not bulk, SPF:fn, MSBL:0, DNSBL:neutral, Custom_rules:0:0:0, LFtime:24,
 LUA_SUMMARY:none
X-HE-Tag: point24_847b19a4a084f
X-Filterd-Recvd-Size: 2396
Received: from joe-laptop.perches.com (unknown [47.151.152.152])
 (Authenticated sender: joe@perches.com)
 by omf16.hostedemail.com (Postfix) with ESMTPA;
 Thu, 12 Sep 2019 02:55:10 +0000 (UTC)
From: Joe Perches <joe@perches.com>
To: Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Keith Busch <keith.busch@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 05/13] nvdimm: Use "unsigned int" in preference to "unsigned"
Date: Wed, 11 Sep 2019 19:54:35 -0700
Message-Id: <11b118ab06da3d2c54fe3ec62f42bd89914878bc.1568256707.git.joe@perches.com>
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

Use the more common kernel type.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/nvdimm/label.c | 2 +-
 drivers/nvdimm/nd.h    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
index 2c780c5352dc..5700d9b35b8f 100644
--- a/drivers/nvdimm/label.c
+++ b/drivers/nvdimm/label.c
@@ -34,7 +34,7 @@ static u32 best_seq(u32 a, u32 b)
 		return a;
 }
 
-unsigned sizeof_namespace_label(struct nvdimm_drvdata *ndd)
+unsigned int sizeof_namespace_label(struct nvdimm_drvdata *ndd)
 {
 	return ndd->nslabel_size;
 }
diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index c10a4b94d44a..1636061b1f93 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -81,7 +81,7 @@ static inline struct nd_namespace_index *to_next_namespace_index(
 	return to_namespace_index(ndd, ndd->ns_next);
 }
 
-unsigned sizeof_namespace_label(struct nvdimm_drvdata *ndd);
+unsigned int sizeof_namespace_label(struct nvdimm_drvdata *ndd);
 
 #define namespace_label_has(ndd, field)			\
 	(offsetof(struct nd_namespace_label, field)	\
@@ -170,9 +170,9 @@ struct nd_blk_region {
 /*
  * Lookup next in the repeating sequence of 01, 10, and 11.
  */
-static inline unsigned nd_inc_seq(unsigned seq)
+static inline unsigned int nd_inc_seq(unsigned int seq)
 {
-	static const unsigned next[] = { 0, 2, 3, 1 };
+	static const unsigned int next[] = { 0, 2, 3, 1 };
 
 	return next[seq & 3];
 }
-- 
2.15.0

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

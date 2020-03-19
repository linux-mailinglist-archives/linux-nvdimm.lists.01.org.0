Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 646ED18C380
	for <lists+linux-nvdimm@lfdr.de>; Fri, 20 Mar 2020 00:09:44 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3708010FC36E2;
	Thu, 19 Mar 2020 16:10:33 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.185.47.144; helo=gateway22.websitewelcome.com; envelope-from=gustavo@embeddedor.com; receiver=<UNKNOWN> 
Received: from gateway22.websitewelcome.com (gateway22.websitewelcome.com [192.185.47.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 57E3810FC36DF
	for <linux-nvdimm@lists.01.org>; Thu, 19 Mar 2020 16:10:30 -0700 (PDT)
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
	by gateway22.websitewelcome.com (Postfix) with ESMTP id EA80650
	for <linux-nvdimm@lists.01.org>; Thu, 19 Mar 2020 18:09:38 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with SMTP
	id F4IEjZyQh8vkBF4IEjQzqM; Thu, 19 Mar 2020 18:09:38 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sQw+xjq5+WUJP7rhAnVh9p35OyAlvz4DhIGg/W9Bo1E=; b=ayDLz5wYvqjcoLy7zs/4VkaZlH
	Hd/BG0qT9NFzyMG5Ae+DNwyxzCjExZ5N0EZNw2RXcJdJDXu3OxqV2PNb1CT1Y+R6IqeNKOkaSEP13
	9PbapJaxcJq/0KPUVIp4W+XCx05fY3vN8+/9ENVO9l8PwuSkBBdGLKK5nkL11khGCsG6IFRg8CzzP
	bpw9bd3JfHFr5GxL3opfwYwOxpRO/ZzcrxSfr2E5H+dnlyxwvYJMIgkAsDEw7pxlo9RkbtFW4azjJ
	yJb9BDRaPt2/yJ9yUW32/nXW+VxAM3stl/9P4WTDiMObnNtnx7m4m68OFaqA+3uGkUVsxhSZ3gS9C
	qS91LuwQ==;
Received: from cablelink-189-218-116-241.hosts.intercable.net ([189.218.116.241]:54046 helo=embeddedor)
	by gator4166.hostgator.com with esmtpa (Exim 4.92)
	(envelope-from <gustavo@embeddedor.com>)
	id 1jF4ID-002QMW-CK; Thu, 19 Mar 2020 18:09:37 -0500
Date: Thu, 19 Mar 2020 18:09:37 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH][next] nvdimm: nd.h: Replace zero-length array with
 flexible-array member
Message-ID: <20200319230937.GA16648@embeddedor.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.01.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.218.116.241
X-Source-L: No
X-Exim-ID: 1jF4ID-002QMW-CK
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cablelink-189-218-116-241.hosts.intercable.net (embeddedor) [189.218.116.241]:54046
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 21
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Message-ID-Hash: G5ULPMLTMSX256NOU625R3VQ2AUXVQXG
X-Message-ID-Hash: G5ULPMLTMSX256NOU625R3VQ2AUXVQXG
X-MailFrom: gustavo@embeddedor.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/G5ULPMLTMSX256NOU625R3VQ2AUXVQXG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/nvdimm/nd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index c4d69c1cce55..85dbb2a322b9 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -39,7 +39,7 @@ struct nd_region_data {
 	int ns_count;
 	int ns_active;
 	unsigned int hints_shift;
-	void __iomem *flush_wpq[0];
+	void __iomem *flush_wpq[];
 };
 
 static inline void __iomem *ndrd_get_flush_wpq(struct nd_region_data *ndrd,
@@ -157,7 +157,7 @@ struct nd_region {
 	struct nd_interleave_set *nd_set;
 	struct nd_percpu_lane __percpu *lane;
 	int (*flush)(struct nd_region *nd_region, struct bio *bio);
-	struct nd_mapping mapping[0];
+	struct nd_mapping mapping[];
 };
 
 struct nd_blk_region {
-- 
2.23.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

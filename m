Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AAC18C37D
	for <lists+linux-nvdimm@lfdr.de>; Fri, 20 Mar 2020 00:07:45 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F2C6A10FC36C4;
	Thu, 19 Mar 2020 16:08:33 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.185.143.38; helo=gateway31.websitewelcome.com; envelope-from=gustavo@embeddedor.com; receiver=<UNKNOWN> 
Received: from gateway31.websitewelcome.com (gateway31.websitewelcome.com [192.185.143.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 77D8610FC363B
	for <linux-nvdimm@lists.01.org>; Thu, 19 Mar 2020 16:08:31 -0700 (PDT)
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
	by gateway31.websitewelcome.com (Postfix) with ESMTP id F22A677F9
	for <linux-nvdimm@lists.01.org>; Thu, 19 Mar 2020 18:07:39 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with SMTP
	id F4GJjlPRjAGTXF4GJjBLGW; Thu, 19 Mar 2020 18:07:39 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=10e20ftHbNBtdbV6audFvzsWbL3yXsySetTvF2M/Lq8=; b=O2K0uP9L/sLPmqZfto8eZ9Auuz
	3wwFpugnOnD//3aPNsBC2Yfrzs9P6q6SVPUTEmkWvRkFqr4geqD9awCrpXtgP7er9l3St8GVs32Hu
	11vLzovX1rQ/e+aP/2W7gAwQsVwPOL7QP/w7UlC8fD817SuFG+J3gBHp2Hwc6UcQUO21Ve7FkVTB8
	0LjnIhDC4DjjHNmIREHMNIJd7TRB5yDDzrEv5VJzOTWZTqXsKI7ISNA0pqQvKivZSC2Z6iEJ1DzPg
	knO42HE5DxsaCGw4WkYv3bYFHwApBAfTf3it+gbpU39jgYutPu98w1QiP748MluBFdyIXYhrALmwp
	bAt84OQA==;
Received: from cablelink-189-218-116-241.hosts.intercable.net ([189.218.116.241]:54038 helo=embeddedor)
	by gator4166.hostgator.com with esmtpa (Exim 4.92)
	(envelope-from <gustavo@embeddedor.com>)
	id 1jF4GI-002PZ0-A4; Thu, 19 Mar 2020 18:07:38 -0500
Date: Thu, 19 Mar 2020 18:07:37 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH][next] nvdimm: label.h: Replace zero-length array with
 flexible-array member
Message-ID: <20200319230737.GA16452@embeddedor.com>
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
X-Exim-ID: 1jF4GI-002PZ0-A4
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cablelink-189-218-116-241.hosts.intercable.net (embeddedor) [189.218.116.241]:54038
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 15
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Message-ID-Hash: SBEJL6QZF3LRDNEQ2USPV4TWFGEJ34BX
X-Message-ID-Hash: SBEJL6QZF3LRDNEQ2USPV4TWFGEJ34BX
X-MailFrom: gustavo@embeddedor.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SBEJL6QZF3LRDNEQ2USPV4TWFGEJ34BX/>
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
 drivers/nvdimm/label.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/label.h b/drivers/nvdimm/label.h
index 4c7b775c2811..956b6d1bd8cc 100644
--- a/drivers/nvdimm/label.h
+++ b/drivers/nvdimm/label.h
@@ -62,7 +62,7 @@ struct nd_namespace_index {
 	__le16 major;
 	__le16 minor;
 	__le64 checksum;
-	u8 free[0];
+	u8 free[];
 };
 
 /**
-- 
2.23.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

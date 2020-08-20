Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA6724C0A4
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Aug 2020 16:31:03 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 253A4134A64A9;
	Thu, 20 Aug 2020 07:31:00 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.35; helo=huawei.com; envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 29F56134A6496
	for <linux-nvdimm@lists.01.org>; Thu, 20 Aug 2020 07:30:56 -0700 (PDT)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
	by Forcepoint Email with ESMTP id 99608B060FFF36059465;
	Thu, 20 Aug 2020 22:30:51 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.174.177.253) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Thu, 20 Aug 2020 22:30:42 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Oliver O'Halloran <oohall@gmail.com>, Dan Williams
	<dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, linux-nvdimm
	<linux-nvdimm@lists.01.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] libnvdimm: eliminate a meaningless spinlock operation
Date: Thu, 20 Aug 2020 22:30:25 +0800
Message-ID: <20200820143027.3241-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200820143027.3241-1-thunder.leizhen@huawei.com>
References: <20200820143027.3241-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Message-ID-Hash: UFEM2EECSPH6YWZX2OTGFTWD36YAERJ5
X-Message-ID-Hash: UFEM2EECSPH6YWZX2OTGFTWD36YAERJ5
X-MailFrom: thunder.leizhen@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Zhen Lei <thunder.leizhen@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UFEM2EECSPH6YWZX2OTGFTWD36YAERJ5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

badrange_add() take the lock "badrange->lock", but it's released
immediately in add_badrange(), protect nothing. Because the static
function add_badrange() is only called by badrange_add(), so spread its
content into badrange_add(), and move "kfree(bre_new)" out of the lock
protection.

Fixes: b3b454f694db ("libnvdimm: fix clear poison locking with spinlock ...")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/nvdimm/badrange.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/nvdimm/badrange.c b/drivers/nvdimm/badrange.c
index 9fdba8c43e8605e..7f78b659057902d 100644
--- a/drivers/nvdimm/badrange.c
+++ b/drivers/nvdimm/badrange.c
@@ -45,12 +45,12 @@ static int alloc_and_append_badrange_entry(struct badrange *badrange,
 	return 0;
 }
 
-static int add_badrange(struct badrange *badrange, u64 addr, u64 length)
+int badrange_add(struct badrange *badrange, u64 addr, u64 length)
 {
 	struct badrange_entry *bre, *bre_new;
 
-	spin_unlock(&badrange->lock);
 	bre_new = kzalloc(sizeof(*bre_new), GFP_KERNEL);
+
 	spin_lock(&badrange->lock);
 
 	/*
@@ -63,6 +63,7 @@ static int add_badrange(struct badrange *badrange, u64 addr, u64 length)
 			/* If length has changed, update this list entry */
 			if (bre->length != length)
 				bre->length = length;
+			spin_unlock(&badrange->lock);
 			kfree(bre_new);
 			return 0;
 		}
@@ -72,22 +73,15 @@ static int add_badrange(struct badrange *badrange, u64 addr, u64 length)
 	 * as any overlapping ranges will get resolved when the list is consumed
 	 * and converted to badblocks
 	 */
-	if (!bre_new)
+	if (!bre_new) {
+		spin_unlock(&badrange->lock);
 		return -ENOMEM;
-	append_badrange_entry(badrange, bre_new, addr, length);
-
-	return 0;
-}
-
-int badrange_add(struct badrange *badrange, u64 addr, u64 length)
-{
-	int rc;
+	}
 
-	spin_lock(&badrange->lock);
-	rc = add_badrange(badrange, addr, length);
+	append_badrange_entry(badrange, bre_new, addr, length);
 	spin_unlock(&badrange->lock);
 
-	return rc;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(badrange_add);
 
-- 
1.8.3

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

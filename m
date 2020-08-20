Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E46524C0A1
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Aug 2020 16:31:00 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BE28B134A64A0;
	Thu, 20 Aug 2020 07:30:57 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.35; helo=huawei.com; envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 50489134A649A
	for <linux-nvdimm@lists.01.org>; Thu, 20 Aug 2020 07:30:55 -0700 (PDT)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
	by Forcepoint Email with ESMTP id CD1104045911F351B0E0;
	Thu, 20 Aug 2020 22:30:51 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.174.177.253) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Thu, 20 Aug 2020 22:30:41 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Oliver O'Halloran <oohall@gmail.com>, Dan Williams
	<dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, linux-nvdimm
	<linux-nvdimm@lists.01.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] libnvdimm: remove redundant list_empty() check in badrange.c
Date: Thu, 20 Aug 2020 22:30:24 +0800
Message-ID: <20200820143027.3241-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200820143027.3241-1-thunder.leizhen@huawei.com>
References: <20200820143027.3241-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Message-ID-Hash: WYRGLBRIFVTROJNTDQUGA2JKGUN4AQTE
X-Message-ID-Hash: WYRGLBRIFVTROJNTDQUGA2JKGUN4AQTE
X-MailFrom: thunder.leizhen@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Zhen Lei <thunder.leizhen@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WYRGLBRIFVTROJNTDQUGA2JKGUN4AQTE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In add_badrange() or badblocks_populate(), the list_empty() branch does
the same things as the code after list_for_each_entry(). And the
list_for_each_entry() will do noting when list_empty().

So the list_empty() branch can be removed without functional change, let
the code after list_for_each_entry() to do it.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/nvdimm/badrange.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/nvdimm/badrange.c b/drivers/nvdimm/badrange.c
index b9eeefa27e3a507..9fdba8c43e8605e 100644
--- a/drivers/nvdimm/badrange.c
+++ b/drivers/nvdimm/badrange.c
@@ -53,13 +53,6 @@ static int add_badrange(struct badrange *badrange, u64 addr, u64 length)
 	bre_new = kzalloc(sizeof(*bre_new), GFP_KERNEL);
 	spin_lock(&badrange->lock);
 
-	if (list_empty(&badrange->list)) {
-		if (!bre_new)
-			return -ENOMEM;
-		append_badrange_entry(badrange, bre_new, addr, length);
-		return 0;
-	}
-
 	/*
 	 * There is a chance this is a duplicate, check for those first.
 	 * This will be the common case as ARS_STATUS returns all known
@@ -215,9 +208,6 @@ static void badblocks_populate(struct badrange *badrange,
 {
 	struct badrange_entry *bre;
 
-	if (list_empty(&badrange->list))
-		return;
-
 	list_for_each_entry(bre, &badrange->list, list) {
 		u64 bre_end = bre->start + bre->length - 1;
 
-- 
1.8.3

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45296270D35
	for <lists+linux-nvdimm@lfdr.de>; Sat, 19 Sep 2020 12:47:09 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 151CA152ACFA7;
	Sat, 19 Sep 2020 03:47:08 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.35; helo=huawei.com; envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 124B5152A3653
	for <linux-nvdimm@lists.01.org>; Sat, 19 Sep 2020 03:46:53 -0700 (PDT)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id E36F54600D799DB3AC9E;
	Sat, 19 Sep 2020 18:46:50 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 18:46:40 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Oliver O'Halloran <oohall@gmail.com>, Dan Williams
	<dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, Markus
 Elfring <Markus.Elfring@web.de>, linux-nvdimm <linux-nvdimm@lists.01.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] libnvdimm/badrange: remove two redundant list_empty() branches
Date: Sat, 19 Sep 2020 18:45:45 +0800
Message-ID: <20200919104546.3848-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200919104546.3848-1-thunder.leizhen@huawei.com>
References: <20200919104546.3848-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Message-ID-Hash: SI3NWJ4T5D3CDON6IPFL3CBBBB7TQWVW
X-Message-ID-Hash: SI3NWJ4T5D3CDON6IPFL3CBBBB7TQWVW
X-MailFrom: thunder.leizhen@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Zhen Lei <thunder.leizhen@huawei.com>, Libin <huawei.libin@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SI3NWJ4T5D3CDON6IPFL3CBBBB7TQWVW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In add_badrange() or badblocks_populate(), the list_empty() branch does
the same things as the code after list_for_each_entry().

The pseudo code is as follows:
1)	if (list_empty()) {
		do things-A
		return Y;
	}

2)	list_for_each_entry()
		do things-B	//can only be entered if !list_empty()

3)	do things-A
        return Y;

It's very clear that, the processing result after deleting 1) is the same
as that before deleting 1).

So delete 1) to simplify code.

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

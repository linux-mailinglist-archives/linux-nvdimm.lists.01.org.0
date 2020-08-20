Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1DF24C0A0
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Aug 2020 16:30:59 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A0D3E134A649B;
	Thu, 20 Aug 2020 07:30:57 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.35; helo=huawei.com; envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4DFB8134A6496
	for <linux-nvdimm@lists.01.org>; Thu, 20 Aug 2020 07:30:55 -0700 (PDT)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
	by Forcepoint Email with ESMTP id C998F799B7358370849E;
	Thu, 20 Aug 2020 22:30:51 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.174.177.253) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Thu, 20 Aug 2020 22:30:43 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Oliver O'Halloran <oohall@gmail.com>, Dan Williams
	<dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, linux-nvdimm
	<linux-nvdimm@lists.01.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] libnvdimm: eliminate two unnecessary zero initializations in badrange.c
Date: Thu, 20 Aug 2020 22:30:26 +0800
Message-ID: <20200820143027.3241-4-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200820143027.3241-1-thunder.leizhen@huawei.com>
References: <20200820143027.3241-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Message-ID-Hash: UD2TJEL6VSD3YA2IOBISFO4EYD4KQXNQ
X-Message-ID-Hash: UD2TJEL6VSD3YA2IOBISFO4EYD4KQXNQ
X-MailFrom: thunder.leizhen@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Zhen Lei <thunder.leizhen@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UD2TJEL6VSD3YA2IOBISFO4EYD4KQXNQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Currently, the "struct badrange_entry" has three members: start, length,
list. In append_badrange_entry(), "start" and "length" will be assigned
later, and "list" does not need to be initialized before calling
list_add_tail(). That means, the kzalloc() in badrange_add() or
alloc_and_append_badrange_entry() can be replaced with kmalloc(), because
the zero initialization is not required.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/nvdimm/badrange.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/badrange.c b/drivers/nvdimm/badrange.c
index 7f78b659057902d..13145001c52ff39 100644
--- a/drivers/nvdimm/badrange.c
+++ b/drivers/nvdimm/badrange.c
@@ -37,7 +37,7 @@ static int alloc_and_append_badrange_entry(struct badrange *badrange,
 {
 	struct badrange_entry *bre;
 
-	bre = kzalloc(sizeof(*bre), flags);
+	bre = kmalloc(sizeof(*bre), flags);
 	if (!bre)
 		return -ENOMEM;
 
@@ -49,7 +49,7 @@ int badrange_add(struct badrange *badrange, u64 addr, u64 length)
 {
 	struct badrange_entry *bre, *bre_new;
 
-	bre_new = kzalloc(sizeof(*bre_new), GFP_KERNEL);
+	bre_new = kmalloc(sizeof(*bre_new), GFP_KERNEL);
 
 	spin_lock(&badrange->lock);
 
-- 
1.8.3

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

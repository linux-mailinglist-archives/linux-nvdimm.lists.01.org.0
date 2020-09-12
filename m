Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A81F7267792
	for <lists+linux-nvdimm@lfdr.de>; Sat, 12 Sep 2020 05:39:57 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F1A9E14781CAA;
	Fri, 11 Sep 2020 20:39:55 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.35; helo=huawei.com; envelope-from=yanaijie@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0A8CD14781CA7
	for <linux-nvdimm@lists.01.org>; Fri, 11 Sep 2020 20:39:53 -0700 (PDT)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id 05D30E854B4617ACA241;
	Sat, 12 Sep 2020 11:39:51 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Sat, 12 Sep 2020
 11:39:40 +0800
From: Jason Yan <yanaijie@huawei.com>
To: <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
	<dave.jiang@intel.com>, <akpm@linux-foundation.org>, <sfr@canb.auug.org.au>,
	<linux-nvdimm@lists.01.org>
Subject: [PATCH] device-dax: make dev_dax_kmem_probe() static
Date: Sat, 12 Sep 2020 11:39:01 +0800
Message-ID: <20200912033901.143382-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Message-ID-Hash: HR6HZBDIYO3HTAWNU2BEORV6UYF3KB4L
X-Message-ID-Hash: HR6HZBDIYO3HTAWNU2BEORV6UYF3KB4L
X-MailFrom: yanaijie@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HR6HZBDIYO3HTAWNU2BEORV6UYF3KB4L/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This eliminates the following sparse warning:

drivers/dax/kmem.c:38:5: warning: symbol 'dev_dax_kmem_probe' was not
declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/dax/kmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 7dcb2902e9b1..e79afbadd4e0 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -35,7 +35,7 @@ static int dax_kmem_range(struct dev_dax *dev_dax, int i, struct range *r)
 	return 0;
 }
 
-int dev_dax_kmem_probe(struct dev_dax *dev_dax)
+static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 {
 	int numa_node = dev_dax->target_node;
 	struct device *dev = &dev_dax->dev;
-- 
2.25.4
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

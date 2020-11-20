Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 238F12BA5E3
	for <lists+linux-nvdimm@lfdr.de>; Fri, 20 Nov 2020 10:21:42 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B3E80100EF271;
	Fri, 20 Nov 2020 01:21:39 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.35; helo=szxga07-in.huawei.com; envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN> 
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9B3DE100EF26F
	for <linux-nvdimm@lists.01.org>; Fri, 20 Nov 2020 01:21:37 -0800 (PST)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CcrdS5SW4z70n0;
	Fri, 20 Nov 2020 17:21:16 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.176.144) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Fri, 20 Nov 2020 17:21:25 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, linux-nvdimm
	<linux-nvdimm@lists.01.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] device-dax: delete a redundancy check in dev_dax_validate_align()
Date: Fri, 20 Nov 2020 17:20:57 +0800
Message-ID: <20201120092057.2144-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.176.144]
X-CFilter-Loop: Reflected
Message-ID-Hash: 4H6TIP53E3VOBW4YXXUGX7ZBSALCQKAC
X-Message-ID-Hash: 4H6TIP53E3VOBW4YXXUGX7ZBSALCQKAC
X-MailFrom: thunder.leizhen@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Zhen Lei <thunder.leizhen@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4H6TIP53E3VOBW4YXXUGX7ZBSALCQKAC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

After we have done the alignment check for the length of each range, the
alignment check for dev_dax_size(dev_dax) is no longer needed, because it
get the sum of the length of each range.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/dax/bus.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 1efae11d947a..35f9238c0139 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1109,16 +1109,9 @@ static ssize_t align_show(struct device *dev,
 
 static ssize_t dev_dax_validate_align(struct dev_dax *dev_dax)
 {
-	resource_size_t dev_size = dev_dax_size(dev_dax);
 	struct device *dev = &dev_dax->dev;
 	int i;
 
-	if (dev_size > 0 && !alloc_is_aligned(dev_dax, dev_size)) {
-		dev_dbg(dev, "%s: align %u invalid for size %pa\n",
-			__func__, dev_dax->align, &dev_size);
-		return -EINVAL;
-	}
-
 	for (i = 0; i < dev_dax->nr_range; i++) {
 		size_t len = range_len(&dev_dax->ranges[i].range);
 
-- 
2.26.0.106.g9fadedd

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

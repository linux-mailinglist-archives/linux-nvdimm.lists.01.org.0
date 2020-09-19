Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C8C270D68
	for <lists+linux-nvdimm@lfdr.de>; Sat, 19 Sep 2020 13:03:21 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 80933152A36F1;
	Sat, 19 Sep 2020 04:03:20 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.32; helo=huawei.com; envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 663B1152A36F0
	for <linux-nvdimm@lists.01.org>; Sat, 19 Sep 2020 04:03:05 -0700 (PDT)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
	by Forcepoint Email with ESMTP id 3D190658BE13BBBCAC36;
	Sat, 19 Sep 2020 19:03:03 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 19:02:57 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Oliver O'Halloran <oohall@gmail.com>, Dan Williams
	<dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, Markus
 Elfring <Markus.Elfring@web.de>, linux-nvdimm <linux-nvdimm@lists.01.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/1] libnvdimm/region: delete a piece of useless code in nd_region_create()
Date: Sat, 19 Sep 2020 19:02:45 +0800
Message-ID: <20200919110245.3965-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Message-ID-Hash: 3RIDRTQZXRQJE5JL7XSJYA5U7ARICYCL
X-Message-ID-Hash: 3RIDRTQZXRQJE5JL7XSJYA5U7ARICYCL
X-MailFrom: thunder.leizhen@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Zhen Lei <thunder.leizhen@huawei.com>, Libin <huawei.libin@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3RIDRTQZXRQJE5JL7XSJYA5U7ARICYCL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The code snippet is as follows:
	if (ndr_desc->flush)
1)		nd_region->flush = ndr_desc->flush;
	else
2)		nd_region->flush = NULL;

When entering the "else" branch, the value of ndr_desc->flush is NULL.
After replaced "NULL" with "ndr_desc->flush" at 2), we will find that
it becomes the same to 1).

So the above code snippet can be reduced to one statement:
nd_region->flush = ndr_desc->flush;

No functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
v1 --> v2:
1. Only the title and description are modified.

v1:
https://lkml.org/lkml/2020/8/19/1469

 drivers/nvdimm/region_devs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index ef23119db574663..7cf9c7d857909ce 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -1131,10 +1131,7 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 	nd_region->ndr_size = resource_size(ndr_desc->res);
 	nd_region->ndr_start = ndr_desc->res->start;
 	nd_region->align = default_align(nd_region);
-	if (ndr_desc->flush)
-		nd_region->flush = ndr_desc->flush;
-	else
-		nd_region->flush = NULL;
+	nd_region->flush = ndr_desc->flush;
 
 	nd_device_register(dev);
 
-- 
1.8.3

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

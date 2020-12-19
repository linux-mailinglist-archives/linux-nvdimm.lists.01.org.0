Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E11902DEDD2
	for <lists+linux-nvdimm@lfdr.de>; Sat, 19 Dec 2020 09:19:32 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E8FE4100EC1DD;
	Sat, 19 Dec 2020 00:19:30 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN> 
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3033F100ED489
	for <linux-nvdimm@lists.01.org>; Sat, 19 Dec 2020 00:19:28 -0800 (PST)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cydsh3D3wzksGC;
	Sat, 19 Dec 2020 16:18:32 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.9) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Sat, 19 Dec 2020 16:19:14 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, linux-nvdimm
	<linux-nvdimm@lists.01.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/1] device-dax: avoid an unnecessary check in alloc_dev_dax_range()
Date: Sat, 19 Dec 2020 16:18:40 +0800
Message-ID: <20201219081840.1149-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201219081840.1149-1-thunder.leizhen@huawei.com>
References: <20201219081840.1149-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Message-ID-Hash: KK74GCCCERUPKZSVON3MV4BYZVS5G6WI
X-Message-ID-Hash: KK74GCCCERUPKZSVON3MV4BYZVS5G6WI
X-MailFrom: thunder.leizhen@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Zhen Lei <thunder.leizhen@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KK74GCCCERUPKZSVON3MV4BYZVS5G6WI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Swap the calling sequence of krealloc() and __request_region(), call the
latter first. In this way, the value of dev_dax->nr_range does not need to
be considered when __request_region() failed.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/dax/bus.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index de7b74505e75e72..359e22ece425ad2 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -772,22 +772,14 @@ static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
 		return 0;
 	}
 
-	ranges = krealloc(dev_dax->ranges, sizeof(*ranges)
-			* (dev_dax->nr_range + 1), GFP_KERNEL);
-	if (!ranges)
+	alloc = __request_region(res, start, size, dev_name(dev), 0);
+	if (!alloc)
 		return -ENOMEM;
 
-	alloc = __request_region(res, start, size, dev_name(dev), 0);
-	if (!alloc) {
-		/*
-		 * If this was an empty set of ranges nothing else
-		 * will release @ranges, so do it now.
-		 */
-		if (!dev_dax->nr_range) {
-			kfree(ranges);
-			ranges = NULL;
-		}
-		dev_dax->ranges = ranges;
+	ranges = krealloc(dev_dax->ranges, sizeof(*ranges)
+			* (dev_dax->nr_range + 1), GFP_KERNEL);
+	if (!ranges) {
+		__release_region(res, alloc->start, resource_size(alloc));
 		return -ENOMEM;
 	}
 
-- 
2.26.0.106.g9fadedd

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

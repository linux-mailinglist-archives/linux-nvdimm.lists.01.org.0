Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 200672CFB2D
	for <lists+linux-nvdimm@lfdr.de>; Sat,  5 Dec 2020 12:48:03 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5BCDB100EBBC3;
	Sat,  5 Dec 2020 03:48:01 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.35; helo=szxga07-in.huawei.com; envelope-from=zhangqilong3@huawei.com; receiver=<UNKNOWN> 
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A35AD100EBBC1
	for <linux-nvdimm@lists.01.org>; Sat,  5 Dec 2020 03:47:54 -0800 (PST)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Cp78x6dXPz78jB
	for <linux-nvdimm@lists.01.org>; Sat,  5 Dec 2020 19:47:13 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Sat, 5 Dec 2020
 19:47:40 +0800
From: Zhang Qilong <zhangqilong3@huawei.com>
To: <dan.j.williams@intel.com>, <dave.jiang@intel.com>, <ira.weiny@intel.com>
Subject: [PATCH] libnvdimm/label: Return -ENXIO for no slot in __blk_label_update
Date: Sat, 5 Dec 2020 19:50:56 +0800
Message-ID: <20201205115056.2076523-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Message-ID-Hash: 63LIJ474BVDWYNP3VCK4N6YSHNRUUUBH
X-Message-ID-Hash: 63LIJ474BVDWYNP3VCK4N6YSHNRUUUBH
X-MailFrom: zhangqilong3@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/63LIJ474BVDWYNP3VCK4N6YSHNRUUUBH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Forget to set error code when nd_label_alloc_slot failed, and we
add it to avoid overwritten error code.

Fixes: 0ba1c634892b3 ("libnvdimm: write blk label set")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/nvdimm/label.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
index 47a4828b8b31..05c1f186a6be 100644
--- a/drivers/nvdimm/label.c
+++ b/drivers/nvdimm/label.c
@@ -999,8 +999,10 @@ static int __blk_label_update(struct nd_region *nd_region,
 		if (is_old_resource(res, old_res_list, old_num_resources))
 			continue; /* carry-over */
 		slot = nd_label_alloc_slot(ndd);
-		if (slot == UINT_MAX)
+		if (slot == UINT_MAX) {
+			rc = -ENXIO;
 			goto abort;
+		}
 		dev_dbg(ndd->dev, "allocated: %d\n", slot);
 
 		nd_label = to_label(ndd, slot);
-- 
2.25.4
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

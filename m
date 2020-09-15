Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D55269F12
	for <lists+linux-nvdimm@lfdr.de>; Tue, 15 Sep 2020 09:05:50 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D4F6413D4EA22;
	Tue, 15 Sep 2020 00:05:48 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.35; helo=huawei.com; envelope-from=jingxiangfeng@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1D8BC13D4EA20
	for <linux-nvdimm@lists.01.org>; Tue, 15 Sep 2020 00:05:44 -0700 (PDT)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id 984C68240D951E8B1533;
	Tue, 15 Sep 2020 15:05:41 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Tue, 15 Sep 2020 15:05:31 +0800
From: Jing Xiangfeng <jingxiangfeng@huawei.com>
To: <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
	<dave.jiang@intel.com>, <ira.weiny@intel.com>
Subject: [PATCH] libnvdimm: Fix dereference of pointer ndns before it is null checked
Date: Tue, 15 Sep 2020 15:06:09 +0800
Message-ID: <20200915070609.123591-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Message-ID-Hash: ZWONDC7EWIYLJGQMVUWIP3Y4OEH3RKZE
X-Message-ID-Hash: ZWONDC7EWIYLJGQMVUWIP3Y4OEH3RKZE
X-MailFrom: jingxiangfeng@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, jingxiangfeng@huawei.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZWONDC7EWIYLJGQMVUWIP3Y4OEH3RKZE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In current code, the pointer ndns is being dereferenced on the
initialization of pointer parent_uuid before ndns is null check. This
could lead to a potential null pointer dereference. Fix this by
dereferencing ndns after ndns has been null pointer sanity checked.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/nvdimm/pfn_devs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index 3e11ef8d3f5b..c443994f81f3 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -452,7 +452,7 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
 	unsigned long align, start_pad;
 	struct nd_pfn_sb *pfn_sb = nd_pfn->pfn_sb;
 	struct nd_namespace_common *ndns = nd_pfn->ndns;
-	const u8 *parent_uuid = nd_dev_to_uuid(&ndns->dev);
+	const u8 *parent_uuid;
 
 	if (!pfn_sb || !ndns)
 		return -ENODEV;
@@ -472,6 +472,7 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
 		return -ENODEV;
 	pfn_sb->checksum = cpu_to_le64(checksum);
 
+	parent_uuid = nd_dev_to_uuid(&ndns->dev);
 	if (memcmp(pfn_sb->parent_uuid, parent_uuid, 16) != 0)
 		return -ENODEV;
 
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

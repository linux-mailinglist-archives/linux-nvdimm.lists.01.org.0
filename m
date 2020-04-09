Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFB51A3134
	for <lists+linux-nvdimm@lfdr.de>; Thu,  9 Apr 2020 10:50:39 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F152710113FD5;
	Thu,  9 Apr 2020 01:51:26 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.35; helo=huawei.com; envelope-from=yanaijie@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 29D5810113FD3
	for <linux-nvdimm@lists.01.org>; Thu,  9 Apr 2020 01:51:24 -0700 (PDT)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
	by Forcepoint Email with ESMTP id 85441B20F450AD9E4EBA;
	Thu,  9 Apr 2020 16:50:32 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Thu, 9 Apr 2020
 16:50:25 +0800
From: Jason Yan <yanaijie@huawei.com>
To: <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
	<dave.jiang@intel.com>, <ira.weiny@intel.com>, <linux-nvdimm@lists.01.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] libnvdimm/security: make __nvdimm_security_overwrite_query() static
Date: Thu, 9 Apr 2020 16:48:57 +0800
Message-ID: <20200409084857.44169-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Message-ID-Hash: DNDGVMQEYR2KGJER3IVPTXV3MNJT6RSK
X-Message-ID-Hash: DNDGVMQEYR2KGJER3IVPTXV3MNJT6RSK
X-MailFrom: yanaijie@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jason Yan <yanaijie@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DNDGVMQEYR2KGJER3IVPTXV3MNJT6RSK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Fix the following sparse warning:

drivers/nvdimm/security.c:416:6: warning: symbol
'__nvdimm_security_overwrite_query' was not declared. Should it be
static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/nvdimm/security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
index 89b85970912d..11fb5ada70ad 100644
--- a/drivers/nvdimm/security.c
+++ b/drivers/nvdimm/security.c
@@ -413,7 +413,7 @@ static int security_overwrite(struct nvdimm *nvdimm, unsigned int keyid)
 	return rc;
 }
 
-void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
+static void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
 {
 	struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(&nvdimm->dev);
 	int rc;
-- 
2.17.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8161245CBD
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Aug 2020 09:00:42 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B3D78133DBA2A;
	Mon, 17 Aug 2020 00:00:40 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.190; helo=huawei.com; envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4F08B133DBA27
	for <linux-nvdimm@lists.01.org>; Mon, 17 Aug 2020 00:00:37 -0700 (PDT)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
	by Forcepoint Email with ESMTP id 6890FACFD3ACB203983A;
	Mon, 17 Aug 2020 15:00:33 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.174.177.253) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Mon, 17 Aug 2020 15:00:25 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: [PATCH 1/1] device-dax: fix mismatches of request_mem_region()
Date: Mon, 17 Aug 2020 14:59:26 +0800
Message-ID: <20200817065926.2239-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Message-ID-Hash: AQKIDVJM3XJF3RT4WYYP46GRL3PLZXFW
X-Message-ID-Hash: AQKIDVJM3XJF3RT4WYYP46GRL3PLZXFW
X-MailFrom: thunder.leizhen@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Zhen Lei <thunder.leizhen@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AQKIDVJM3XJF3RT4WYYP46GRL3PLZXFW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The resources allocated by request_mem_region() is better to use
release_mem_region() to free. These two functions are paired.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/dax/kmem.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 275aa5f873991af..9e38f9c2b6d7f02 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -82,8 +82,7 @@ int dev_dax_kmem_probe(struct device *dev)
 	rc = add_memory_driver_managed(numa_node, new_res->start,
 				       resource_size(new_res), kmem_name);
 	if (rc) {
-		release_resource(new_res);
-		kfree(new_res);
+		release_mem_region(kmem_start, kmem_size);
 		kfree(new_res_name);
 		return rc;
 	}
@@ -118,8 +117,7 @@ static int dev_dax_kmem_remove(struct device *dev)
 	}
 
 	/* Release and free dax resources */
-	release_resource(res);
-	kfree(res);
+	release_mem_region(kmem_start, kmem_size);
 	kfree(res_name);
 	dev_dax->dax_kmem_res = NULL;
 
-- 
1.8.3

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

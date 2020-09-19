Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E3A270D5C
	for <lists+linux-nvdimm@lfdr.de>; Sat, 19 Sep 2020 13:02:16 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 56658152B927B;
	Sat, 19 Sep 2020 04:02:14 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.32; helo=huawei.com; envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3895C152B9276
	for <linux-nvdimm@lists.01.org>; Sat, 19 Sep 2020 04:02:02 -0700 (PDT)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id 0B7B4FB3D20829E1D781;
	Sat, 19 Sep 2020 19:02:00 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 19:01:53 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Oliver O'Halloran <oohall@gmail.com>, Dan Williams
	<dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, Markus
 Elfring <Markus.Elfring@web.de>, linux-nvdimm <linux-nvdimm@lists.01.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/1] libnvdimm/namespace: avoid repeated judgment in nvdimm_namespace_disk_name()
Date: Sat, 19 Sep 2020 19:01:46 +0800
Message-ID: <20200919110146.3909-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Message-ID-Hash: TAC7GQBIYXJCZHXPVV5XHDIRDUHEDIWH
X-Message-ID-Hash: TAC7GQBIYXJCZHXPVV5XHDIRDUHEDIWH
X-MailFrom: thunder.leizhen@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Zhen Lei <thunder.leizhen@huawei.com>, Libin <huawei.libin@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TAC7GQBIYXJCZHXPVV5XHDIRDUHEDIWH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The judgment (suffix ? suffix : "") appears three times, we do this just
because the initial value of local variable "suffix" is NULL, should be
replaced with empty string "" to avoid null pointer reference. It's easy
to get rid of it as below:
-	const char *suffix = NULL;
+	const char *suffix = "";

To avoid having rows that exceed 80 columns, add a new local variable
"region_id".

No functional change, but it can reduce the code size.
Before:
   text    data     bss     dec     hex filename
  41749    3697      16   45462    b196 drivers/nvdimm/namespace_devs.o

After:
   text    data     bss     dec     hex filename
  41653    3697      16   45366    b136 drivers/nvdimm/namespace_devs.o

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
v1 --> v2:
1. Only the title and description are modified.

v1:
https://lore.kernel.org/patchwork/patch/1292584/

 drivers/nvdimm/namespace_devs.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 6da67f4d641a27c..ef2800c5da4c99c 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -157,7 +157,8 @@ const char *nvdimm_namespace_disk_name(struct nd_namespace_common *ndns,
 		char *name)
 {
 	struct nd_region *nd_region = to_nd_region(ndns->dev.parent);
-	const char *suffix = NULL;
+	const char *suffix = "";
+	int region_id = nd_region->id;
 
 	if (ndns->claim && is_nd_btt(ndns->claim))
 		suffix = "s";
@@ -173,17 +174,14 @@ const char *nvdimm_namespace_disk_name(struct nd_namespace_common *ndns,
 		}
 
 		if (nsidx)
-			sprintf(name, "pmem%d.%d%s", nd_region->id, nsidx,
-					suffix ? suffix : "");
+			sprintf(name, "pmem%d.%d%s", region_id, nsidx, suffix);
 		else
-			sprintf(name, "pmem%d%s", nd_region->id,
-					suffix ? suffix : "");
+			sprintf(name, "pmem%d%s", region_id, suffix);
 	} else if (is_namespace_blk(&ndns->dev)) {
 		struct nd_namespace_blk *nsblk;
 
 		nsblk = to_nd_namespace_blk(&ndns->dev);
-		sprintf(name, "ndblk%d.%d%s", nd_region->id, nsblk->id,
-				suffix ? suffix : "");
+		sprintf(name, "ndblk%d.%d%s", region_id, nsblk->id, suffix);
 	} else {
 		return NULL;
 	}
-- 
1.8.3

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

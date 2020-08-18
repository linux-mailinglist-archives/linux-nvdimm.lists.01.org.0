Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20477247C98
	for <lists+linux-nvdimm@lfdr.de>; Tue, 18 Aug 2020 05:16:53 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0092F1346F6B8;
	Mon, 17 Aug 2020 20:16:51 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.191; helo=huawei.com; envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1E04D13466233
	for <linux-nvdimm@lists.01.org>; Mon, 17 Aug 2020 20:16:47 -0700 (PDT)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
	by Forcepoint Email with ESMTP id A5084C25237E60BCD27C;
	Tue, 18 Aug 2020 11:16:45 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.174.177.253) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 18 Aug 2020 11:16:37 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Oliver O'Halloran <oohall@gmail.com>, Dan Williams
	<dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, linux-nvdimm
	<linux-nvdimm@lists.01.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] libnvdimm/bus: simplify walk_to_nvdimm_bus()
Date: Tue, 18 Aug 2020 11:15:56 +0800
Message-ID: <20200818031556.2921-4-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200818031556.2921-1-thunder.leizhen@huawei.com>
References: <20200818031556.2921-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Message-ID-Hash: KWMX46YIMK4NOQQM2EPIDAQ6YK3ZRVX4
X-Message-ID-Hash: KWMX46YIMK4NOQQM2EPIDAQ6YK3ZRVX4
X-MailFrom: thunder.leizhen@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Zhen Lei <thunder.leizhen@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KWMX46YIMK4NOQQM2EPIDAQ6YK3ZRVX4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

I first want to move dev_WARN_ONCE() after "if (dev)" branch, but further
I find the "if (dev)" can only be true when is_nvdimm_bus(dev) successed.

No functional change. In fact, the compiler can optimize it correctly. I
run "size drivers/nvdimm/bus.o" and find nothing has changed. So it's
just source code level optimization, make us can read it faster.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/nvdimm/bus.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 955265656b96c73..1d89114cb6ab93e 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -316,10 +316,9 @@ struct nvdimm_bus *walk_to_nvdimm_bus(struct device *nd_dev)
 
 	for (dev = nd_dev; dev; dev = dev->parent)
 		if (is_nvdimm_bus(dev))
-			break;
-	dev_WARN_ONCE(nd_dev, !dev, "invalid dev, not on nd bus\n");
-	if (dev)
-		return to_nvdimm_bus(dev);
+			return to_nvdimm_bus(dev);
+
+	dev_WARN_ONCE(nd_dev, 1, "invalid dev, not on nd bus\n");
 	return NULL;
 }
 
-- 
1.8.3

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

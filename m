Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9B8321340
	for <lists+linux-nvdimm@lfdr.de>; Mon, 22 Feb 2021 10:40:55 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 34621100EBB72;
	Mon, 22 Feb 2021 01:40:54 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=yang.lee@linux.alibaba.com; receiver=<UNKNOWN> 
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C3213100EBB6E
	for <linux-nvdimm@lists.01.org>; Mon, 22 Feb 2021 01:40:50 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UPEY.ri_1613986846;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UPEY.ri_1613986846)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 22 Feb 2021 17:40:47 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: dan.j.williams@intel.com
Subject: [PATCH] device-dax: Switch to using the new API kobj_to_dev()
Date: Mon, 22 Feb 2021 17:40:44 +0800
Message-Id: <1613986844-25539-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Message-ID-Hash: DCTET3JXDH63KJGPQ3TYZZQ5X5QTLSED
X-Message-ID-Hash: DCTET3JXDH63KJGPQ3TYZZQ5X5QTLSED
X-MailFrom: yang.lee@linux.alibaba.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DCTET3JXDH63KJGPQ3TYZZQ5X5QTLSED/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

fixed the following coccicheck:
./drivers/dax/bus.c:486:60-61: WARNING opportunity for kobj_to_dev()
./drivers/dax/bus.c:1215:60-61: WARNING opportunity for kobj_to_dev()

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/dax/bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 737b207..0e9207c 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -483,7 +483,7 @@ static ssize_t delete_store(struct device *dev, struct device_attribute *attr,
 static umode_t dax_region_visible(struct kobject *kobj, struct attribute *a,
 		int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct dax_region *dax_region = dev_get_drvdata(dev);
 
 	if (is_static(dax_region))
@@ -1212,7 +1212,7 @@ static ssize_t numa_node_show(struct device *dev,
 
 static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct dev_dax *dev_dax = to_dev_dax(dev);
 	struct dax_region *dax_region = dev_dax->region;
 
-- 
1.8.3.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

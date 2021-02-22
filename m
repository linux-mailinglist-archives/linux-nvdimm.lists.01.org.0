Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8863210B8
	for <lists+linux-nvdimm@lfdr.de>; Mon, 22 Feb 2021 07:10:38 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2EA09100EC1EB;
	Sun, 21 Feb 2021 22:10:35 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=115.124.30.44; helo=out30-44.freemail.mail.aliyun.com; envelope-from=yang.lee@linux.alibaba.com; receiver=<UNKNOWN> 
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2D82C100ED48A
	for <linux-nvdimm@lists.01.org>; Sun, 21 Feb 2021 22:10:31 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UPA9lM5_1613974228;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UPA9lM5_1613974228)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 22 Feb 2021 14:10:28 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: dan.j.williams@intel.com
Subject: [PATCH] ndtest: Switch to using the new API kobj_to_dev()
Date: Mon, 22 Feb 2021 14:10:22 +0800
Message-Id: <1613974222-45256-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Message-ID-Hash: QZCQQNP2MJCJ5FXTGP6NPNXXGIUS4NXR
X-Message-ID-Hash: QZCQQNP2MJCJ5FXTGP6NPNXXGIUS4NXR
X-MailFrom: yang.lee@linux.alibaba.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QZCQQNP2MJCJ5FXTGP6NPNXXGIUS4NXR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

fixed the following coccicheck:
./tools/testing/nvdimm/test/ndtest.c:785:60-61: WARNING opportunity for
kobj_to_dev()

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 tools/testing/nvdimm/test/ndtest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/test/ndtest.c
index 6862915..004a36f 100644
--- a/tools/testing/nvdimm/test/ndtest.c
+++ b/tools/testing/nvdimm/test/ndtest.c
@@ -782,7 +782,7 @@ static ssize_t format1_show(struct device *dev, struct device_attribute *attr,
 static umode_t ndtest_nvdimm_attr_visible(struct kobject *kobj,
 					struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nvdimm *nvdimm = to_nvdimm(dev);
 	struct ndtest_dimm *dimm = nvdimm_provider_data(nvdimm);
 
-- 
1.8.3.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

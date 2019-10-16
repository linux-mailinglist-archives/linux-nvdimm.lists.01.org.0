Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5209D85C7
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Oct 2019 04:16:16 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F169C10FCC630;
	Tue, 15 Oct 2019 19:19:12 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=115.124.30.42; helo=out30-42.freemail.mail.aliyun.com; envelope-from=zhangliguang@linux.alibaba.com; receiver=<UNKNOWN> 
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BB27710FCB783
	for <linux-nvdimm@lists.01.org>; Tue, 15 Oct 2019 19:19:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TfBKlGn_1571192160;
Received: from localhost(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0TfBKlGn_1571192160)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Oct 2019 10:16:08 +0800
From: luanshi <zhangliguang@linux.alibaba.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Keith Busch <keith.busch@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] libnvdimm: fix kernel-doc notation
Date: Wed, 16 Oct 2019 10:16:00 +0800
Message-Id: <1571192160-54202-1-git-send-email-zhangliguang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Message-ID-Hash: TVSLKKKTCFNSQYWZCYRAIRSWUEVLJHMS
X-Message-ID-Hash: TVSLKKKTCFNSQYWZCYRAIRSWUEVLJHMS
X-MailFrom: zhangliguang@linux.alibaba.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TVSLKKKTCFNSQYWZCYRAIRSWUEVLJHMS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Fix kernel-doc notation in drivers/nvdimm/namespace_devs.c.

Fixes: bf9bccc14c05 ("libnvdimm: pmem label sets and namespace instantiation.")
Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
---
 drivers/nvdimm/namespace_devs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index cca0a3b..5cfb1e9 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1900,7 +1900,7 @@ static int select_pmem_id(struct nd_region *nd_region, u8 *pmem_id)
 /**
  * create_namespace_pmem - validate interleave set labelling, retrieve label0
  * @nd_region: region with mappings to validate
- * @nspm: target namespace to create
+ * @ndindex: target namespace index to create
  * @nd_label: target pmem namespace label to evaluate
  */
 static struct device *create_namespace_pmem(struct nd_region *nd_region,
-- 
1.8.3.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

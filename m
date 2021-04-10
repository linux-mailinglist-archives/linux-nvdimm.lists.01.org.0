Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A81B235A98A
	for <lists+linux-nvdimm@lfdr.de>; Sat, 10 Apr 2021 02:33:49 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A0ED6100ED4BF;
	Fri,  9 Apr 2021 17:33:47 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.181.15.112; helo=m15112.mail.126.com; envelope-from=wangyingjie55@126.com; receiver=<UNKNOWN> 
Received: from m15112.mail.126.com (m15112.mail.126.com [220.181.15.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 24F1A100EF265
	for <linux-nvdimm@lists.01.org>; Fri,  9 Apr 2021 17:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=YjzmIwerweOGbfblgC
	/Ly+OrKlNwezN7iggMM3swgJM=; b=MJHaL0orm8TvdDuB7Ke+swd6jhy8BrifMI
	+AmmCaqyYsUXYS/mlvoGVJkb5MVHH8OlYONPAzTbVhf15OK1JCiodjpjbSWlC8pq
	Es3/zLe6WynvMoDcLRKBGHs0EpyF02SeZdbgyiAoQipLo2pQbY/zcpPjNl9+LSR6
	7yGPEDbrc=
Received: from localhost.localdomain (unknown [106.17.213.220])
	by smtp2 (Coremail) with SMTP id DMmowAA3nwNa8nBgdqQBAQ--.18230S2;
	Sat, 10 Apr 2021 08:33:32 +0800 (CST)
From: wangyingjie55@126.com
To: dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	ira.weiny@intel.com,
	linux-nvdimm@lists.01.org
Subject: [PATCH v1] libnvdimm, dax: Fix a missing check in nd_dax_probe()
Date: Fri,  9 Apr 2021 17:33:23 -0700
Message-Id: <1618014803-17231-1-git-send-email-wangyingjie55@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DMmowAA3nwNa8nBgdqQBAQ--.18230S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrW3XF15XF15Gw4rtry5urg_yoWfArXEkr
	17Zr929Fy0kwnayr4aqr1fWryvyrs29r18ur4jgw13Ar4Y9r13GFykur9xtrsagr48urnr
	ur1DXFnxZF15GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjeyI5UUUUU==
X-Originating-IP: [106.17.213.220]
X-CM-SenderInfo: 5zdqw5xlqjyxrhvvqiyswou0bp/1tbiJRxwp13WGyhjMQAAsE
Message-ID-Hash: LIJUL3B6IINDKLE6QOYHIDKUDBUXTWWR
X-Message-ID-Hash: LIJUL3B6IINDKLE6QOYHIDKUDBUXTWWR
X-MailFrom: wangyingjie55@126.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: wangyingjie55@126.com, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LIJUL3B6IINDKLE6QOYHIDKUDBUXTWWR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Yingjie Wang <wangyingjie55@126.com>

In nd_dax_probe(), nd_dax_alloc() may fail and return NULL.
Check for NULL before attempting to
use nd_dax to avoid a NULL pointer dereference.

Fixes: c5ed9268643c ("libnvdimm, dax: autodetect support")
Signed-off-by: Yingjie Wang <wangyingjie55@126.com>
---
 drivers/nvdimm/dax_devs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvdimm/dax_devs.c b/drivers/nvdimm/dax_devs.c
index 99965077bac4..b1426ac03f01 100644
--- a/drivers/nvdimm/dax_devs.c
+++ b/drivers/nvdimm/dax_devs.c
@@ -106,6 +106,8 @@ int nd_dax_probe(struct device *dev, struct nd_namespace_common *ndns)
 
 	nvdimm_bus_lock(&ndns->dev);
 	nd_dax = nd_dax_alloc(nd_region);
+	if (!nd_dax)
+		return -ENOMEM;
 	nd_pfn = &nd_dax->nd_pfn;
 	dax_dev = nd_pfn_devinit(nd_pfn, ndns);
 	nvdimm_bus_unlock(&ndns->dev);
-- 
2.7.4
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

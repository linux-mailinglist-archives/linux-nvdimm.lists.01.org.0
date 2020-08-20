Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B6124ACED
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Aug 2020 04:17:41 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 62FCD13515B4C;
	Wed, 19 Aug 2020 19:17:37 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.190; helo=huawei.com; envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 84CD713515B4D
	for <linux-nvdimm@lists.01.org>; Wed, 19 Aug 2020 19:17:32 -0700 (PDT)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
	by Forcepoint Email with ESMTP id 970854FFC53A1C5449FA;
	Thu, 20 Aug 2020 10:17:30 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.174.177.253) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 20 Aug 2020 10:17:19 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Oliver O'Halloran <oohall@gmail.com>, Dan Williams
	<dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, Markus
 Elfring <Markus.Elfring@web.de>, linux-nvdimm <linux-nvdimm@lists.01.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 7/7] libnvdimm: slightly simplify available_slots_show()
Date: Thu, 20 Aug 2020 10:16:41 +0800
Message-ID: <20200820021641.3188-8-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200820021641.3188-1-thunder.leizhen@huawei.com>
References: <20200820021641.3188-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Message-ID-Hash: LT44XQR3KW457YXGOYD6D47GGXJEWF2M
X-Message-ID-Hash: LT44XQR3KW457YXGOYD6D47GGXJEWF2M
X-MailFrom: thunder.leizhen@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Zhen Lei <thunder.leizhen@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LT44XQR3KW457YXGOYD6D47GGXJEWF2M/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The type of "nfree" is u32, so "nfree - 1" can only be overflowed when
"nfree" is zero. Replace "if (nfree - 1 > nfree)" with "if (nfree == 0)"
seems more clear. And remove the assignment "nfree = 0", no need for it.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/nvdimm/dimm_devs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index 61374def515552f..bf7d0cdc147cb39 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -347,10 +347,9 @@ static ssize_t available_slots_show(struct device *dev,
 
 	nvdimm_bus_lock(dev);
 	nfree = nd_label_nfree(ndd);
-	if (nfree - 1 > nfree) {
+	if (nfree == 0)
 		dev_WARN_ONCE(dev, 1, "we ate our last label?\n");
-		nfree = 0;
-	} else
+	else
 		nfree--;
 	rc = sprintf(buf, "%d\n", nfree);
 	nvdimm_bus_unlock(dev);
-- 
1.8.3

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

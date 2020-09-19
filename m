Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7C8270D73
	for <lists+linux-nvdimm@lfdr.de>; Sat, 19 Sep 2020 13:08:01 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EE81D13FF1A2C;
	Sat, 19 Sep 2020 04:07:59 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.35; helo=huawei.com; envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1B988152A8928
	for <linux-nvdimm@lists.01.org>; Sat, 19 Sep 2020 04:07:39 -0700 (PDT)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id 06206967FD2073886B18;
	Sat, 19 Sep 2020 19:07:36 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 19:07:27 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Oliver O'Halloran <oohall@gmail.com>, Dan Williams
	<dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, Markus
 Elfring <Markus.Elfring@web.de>, linux-nvdimm <linux-nvdimm@lists.01.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/1] libnvdimm: make sure EXPORT_SYMBOL_GPL(nvdimm_flush) close to its function
Date: Sat, 19 Sep 2020 19:07:07 +0800
Message-ID: <20200919110707.4021-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Message-ID-Hash: 6235XP5ZA3A4536VYMEECQT5T4CWTFRW
X-Message-ID-Hash: 6235XP5ZA3A4536VYMEECQT5T4CWTFRW
X-MailFrom: thunder.leizhen@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Zhen Lei <thunder.leizhen@huawei.com>, Libin <huawei.libin@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6235XP5ZA3A4536VYMEECQT5T4CWTFRW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Move EXPORT_SYMBOL_GPL(nvdimm_flush) close to nvdimm_flush(), currently
it's near to generic_nvdimm_flush().

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
---
v1 --> v2
1. add "Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>"

v1:
https://lkml.org/lkml/2020/8/20/904

 drivers/nvdimm/region_devs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 7cf9c7d857909ce..5df7c22df1529eb 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -1186,6 +1186,8 @@ int nvdimm_flush(struct nd_region *nd_region, struct bio *bio)
 
 	return rc;
 }
+EXPORT_SYMBOL_GPL(nvdimm_flush);
+
 /**
  * nvdimm_flush - flush any posted write queues between the cpu and pmem media
  * @nd_region: blk or interleaved pmem region
@@ -1217,7 +1219,6 @@ int generic_nvdimm_flush(struct nd_region *nd_region)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(nvdimm_flush);
 
 /**
  * nvdimm_has_flush - determine write flushing requirements
-- 
1.8.3

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

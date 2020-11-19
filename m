Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 307BC2B89F7
	for <lists+linux-nvdimm@lfdr.de>; Thu, 19 Nov 2020 03:06:12 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6CD5F100EBB7B;
	Wed, 18 Nov 2020 18:06:10 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN> 
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5D9EA100EBB7A
	for <linux-nvdimm@lists.01.org>; Wed, 18 Nov 2020 18:05:42 -0800 (PST)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cc3102Kh8z15KNh;
	Thu, 19 Nov 2020 10:05:24 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.176.144) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Thu, 19 Nov 2020 10:05:31 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown
	<lenb@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-acpi
	<linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/1] acpi/nfit: fix badrange insertion in nfit_handle_mce()
Date: Thu, 19 Nov 2020 09:57:46 +0800
Message-ID: <20201119015746.1990-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201119015746.1990-1-thunder.leizhen@huawei.com>
References: <20201119015746.1990-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.176.144]
X-CFilter-Loop: Reflected
Message-ID-Hash: DX7KL3WWHN24VWHETQRIXADOFY22C65V
X-Message-ID-Hash: DX7KL3WWHN24VWHETQRIXADOFY22C65V
X-MailFrom: thunder.leizhen@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Zhen Lei <thunder.leizhen@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DX7KL3WWHN24VWHETQRIXADOFY22C65V/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Make sure the badrange to be reported can always cover mce->addr.

Fixes: 9ffd6350a103 ("nfit: don't start a full scrub by default for an MCE")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
---
 drivers/acpi/nfit/mce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/mce.c b/drivers/acpi/nfit/mce.c
index ee8d9973f60b..053e719c7bea 100644
--- a/drivers/acpi/nfit/mce.c
+++ b/drivers/acpi/nfit/mce.c
@@ -63,7 +63,7 @@ static int nfit_handle_mce(struct notifier_block *nb, unsigned long val,
 
 		/* If this fails due to an -ENOMEM, there is little we can do */
 		nvdimm_bus_add_badrange(acpi_desc->nvdimm_bus,
-				ALIGN(mce->addr, L1_CACHE_BYTES),
+				ALIGN_DOWN(mce->addr, L1_CACHE_BYTES),
 				L1_CACHE_BYTES);
 		nvdimm_region_notify(nfit_spa->nd_region,
 				NVDIMM_REVALIDATE_POISON);
-- 
2.26.0.106.g9fadedd

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

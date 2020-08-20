Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA94924ACE5
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Aug 2020 04:17:35 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B2FC313515B54;
	Wed, 19 Aug 2020 19:17:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.191; helo=huawei.com; envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 134E313515B4A
	for <linux-nvdimm@lists.01.org>; Wed, 19 Aug 2020 19:17:28 -0700 (PDT)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id 71C0CF8ADFE834B79346;
	Thu, 20 Aug 2020 10:17:25 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.174.177.253) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 20 Aug 2020 10:17:18 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Oliver O'Halloran <oohall@gmail.com>, Dan Williams
	<dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, Markus
 Elfring <Markus.Elfring@web.de>, linux-nvdimm <linux-nvdimm@lists.01.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 5/7] libnvdimm: reduce an unnecessary if branch in nd_region_activate()
Date: Thu, 20 Aug 2020 10:16:39 +0800
Message-ID: <20200820021641.3188-6-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200820021641.3188-1-thunder.leizhen@huawei.com>
References: <20200820021641.3188-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Message-ID-Hash: XRQEHXQFLTPPUS3ZCEWQ3USO5IRKQOTY
X-Message-ID-Hash: XRQEHXQFLTPPUS3ZCEWQ3USO5IRKQOTY
X-MailFrom: thunder.leizhen@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Zhen Lei <thunder.leizhen@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XRQEHXQFLTPPUS3ZCEWQ3USO5IRKQOTY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

According to the original code logic:
if (!nvdimm->num_flush) {
	flush_data_size += sizeof(void *);
	//nvdimm->num_flush is zero now, add 1) have no side effects
} else {
	flush_data_size += sizeof(void *);
1)	flush_data_size += nvdimm->num_flush * sizeof(void *);
}

Obviously, the above code snippet can be reduced to one statement:
flush_data_size += (nvdimm->num_flush + 1) * sizeof(void *);

No functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/nvdimm/region_devs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 7cf9c7d857909ce..49be115c9189eff 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -77,11 +77,8 @@ int nd_region_activate(struct nd_region *nd_region)
 		}
 
 		/* at least one null hint slot per-dimm for the "no-hint" case */
-		flush_data_size += sizeof(void *);
+		flush_data_size += (nvdimm->num_flush + 1) * sizeof(void *);
 		num_flush = min_not_zero(num_flush, nvdimm->num_flush);
-		if (!nvdimm->num_flush)
-			continue;
-		flush_data_size += nvdimm->num_flush * sizeof(void *);
 	}
 	nvdimm_bus_unlock(&nd_region->dev);
 
-- 
1.8.3

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

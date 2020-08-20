Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E00824ACE3
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Aug 2020 04:17:34 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8C42E13515B50;
	Wed, 19 Aug 2020 19:17:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.32; helo=huawei.com; envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1418713515B4B
	for <linux-nvdimm@lists.01.org>; Wed, 19 Aug 2020 19:17:27 -0700 (PDT)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
	by Forcepoint Email with ESMTP id A1E6370C2325D2D4D4C7;
	Thu, 20 Aug 2020 10:17:25 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.174.177.253) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 20 Aug 2020 10:17:15 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Oliver O'Halloran <oohall@gmail.com>, Dan Williams
	<dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, Markus
 Elfring <Markus.Elfring@web.de>, linux-nvdimm <linux-nvdimm@lists.01.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/7] bugfix and optimize for drivers/nvdimm
Date: Thu, 20 Aug 2020 10:16:34 +0800
Message-ID: <20200820021641.3188-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Message-ID-Hash: VT76ZAYATALRGK75EO7MZE2EMUJHGR5L
X-Message-ID-Hash: VT76ZAYATALRGK75EO7MZE2EMUJHGR5L
X-MailFrom: thunder.leizhen@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Zhen Lei <thunder.leizhen@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VT76ZAYATALRGK75EO7MZE2EMUJHGR5L/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

v2 --> v3:
1. Fix spelling error of patch 1 subject: memmory --> memory
2. Add "Reviewed-by: Oliver O'Halloran <oohall@gmail.com>" into patch 1
3. Rewrite patch descriptions of Patch 1, 3, 4
4. Add 3 new trivial patches 5-7, I just found that yesterday.
5. Unify all "subsystem" names to "libnvdimm:"

v1 --> v2:
1. Add Fixes for Patch 1-2
2. Slightly change the subject and description of Patch 1
3. Add a new trivial Patch 4, I just found that yesterday.

v1:
I found a memleak when I learned the drivers/nvdimm code today. And I also
added a sanity check for priv->bus_desc.provider_name, because strdup()
maybe failed. Patch 3 is a trivial source code optimization.


Zhen Lei (7):
  libnvdimm: fix memory leaks in of_pmem.c
  libnvdimm: add sanity check for provider_name in
    of_pmem_region_probe()
  libnvdimm: simplify walk_to_nvdimm_bus()
  libnvdimm: reduce an unnecessary if branch in nd_region_create()
  libnvdimm: reduce an unnecessary if branch in nd_region_activate()
  libnvdimm: make sure EXPORT_SYMBOL_GPL(nvdimm_flush) close to its
    function
  libnvdimm: slightly simplify available_slots_show()

 drivers/nvdimm/bus.c         |  7 +++----
 drivers/nvdimm/dimm_devs.c   |  5 ++---
 drivers/nvdimm/of_pmem.c     |  7 +++++++
 drivers/nvdimm/region_devs.c | 13 ++++---------
 4 files changed, 16 insertions(+), 16 deletions(-)

-- 
1.8.3

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

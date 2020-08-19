Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38BE2492B6
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Aug 2020 04:05:52 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2CBF7134CA7F5;
	Tue, 18 Aug 2020 19:05:50 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.32; helo=huawei.com; envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9B9B6134C39BF
	for <linux-nvdimm@lists.01.org>; Tue, 18 Aug 2020 19:05:47 -0700 (PDT)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
	by Forcepoint Email with ESMTP id AC92C1B7B738A14D34C2;
	Wed, 19 Aug 2020 10:05:44 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.174.177.253) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Wed, 19 Aug 2020 10:05:32 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Oliver O'Halloran <oohall@gmail.com>, Dan Williams
	<dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, Markus
 Elfring <Markus.Elfring@web.de>, linux-nvdimm <linux-nvdimm@lists.01.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/4] bugfix and optimize for drivers/nvdimm
Date: Wed, 19 Aug 2020 10:04:59 +0800
Message-ID: <20200819020503.3079-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Message-ID-Hash: NL65EL73Q6MY4PYSFLAJDFGGWTNARWSW
X-Message-ID-Hash: NL65EL73Q6MY4PYSFLAJDFGGWTNARWSW
X-MailFrom: thunder.leizhen@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Zhen Lei <thunder.leizhen@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NL65EL73Q6MY4PYSFLAJDFGGWTNARWSW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

v1 --> v2:
1. Add Fixes for Patch 1-2
2. Slightly change the subject and description of Patch 1
3. Add a new trivial Patch 4, I just found that yesterday.

v1:
I found a memleak when I learned the drivers/nvdimm code today. And I also
added a sanity check for priv->bus_desc.provider_name, because strdup()
maybe failed. Patch 3 is a trivial source code optimization.

Zhen Lei (4):
  libnvdimm: fix memmory leaks in of_pmem.c
  libnvdimm: add sanity check for provider_name in
    of_pmem_region_probe()
  libnvdimm/bus: simplify walk_to_nvdimm_bus()
  libnvdimm/region: reduce an unnecessary if branch in
    nd_region_create()

 drivers/nvdimm/bus.c         | 7 +++----
 drivers/nvdimm/of_pmem.c     | 7 +++++++
 drivers/nvdimm/region_devs.c | 5 +----
 3 files changed, 11 insertions(+), 8 deletions(-)

-- 
1.8.3

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

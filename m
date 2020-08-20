Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEB724C0A3
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Aug 2020 16:31:02 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0B314134A64A6;
	Thu, 20 Aug 2020 07:30:59 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.35; helo=huawei.com; envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4F164134A6499
	for <linux-nvdimm@lists.01.org>; Thu, 20 Aug 2020 07:30:55 -0700 (PDT)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
	by Forcepoint Email with ESMTP id 9D0C37F4FFE6FC5DCB0D;
	Thu, 20 Aug 2020 22:30:51 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.174.177.253) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Thu, 20 Aug 2020 22:30:41 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Oliver O'Halloran <oohall@gmail.com>, Dan Williams
	<dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, linux-nvdimm
	<linux-nvdimm@lists.01.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] clean up some functions in nvdimm/badrange.c and namespace_devs.c
Date: Thu, 20 Aug 2020 22:30:23 +0800
Message-ID: <20200820143027.3241-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Message-ID-Hash: PVZUJKXH4LR7L5464OSMSBTCXEWGUZVQ
X-Message-ID-Hash: PVZUJKXH4LR7L5464OSMSBTCXEWGUZVQ
X-MailFrom: thunder.leizhen@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Zhen Lei <thunder.leizhen@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PVZUJKXH4LR7L5464OSMSBTCXEWGUZVQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When I learned the code of drivers/nvdimm, I found some places can be improved.

Zhen Lei (4):
  libnvdimm: remove redundant list_empty() check in badrange.c
  libnvdimm: eliminate a meaningless spinlock operation
  libnvdimm: eliminate two unnecessary zero initializations in
    badrange.c
  libnvdimm: avoid unnecessary judgments in nvdimm_namespace_disk_name()

 drivers/nvdimm/badrange.c       | 36 ++++++++++--------------------------
 drivers/nvdimm/namespace_devs.c | 12 +++++-------
 2 files changed, 15 insertions(+), 33 deletions(-)

-- 
1.8.3

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

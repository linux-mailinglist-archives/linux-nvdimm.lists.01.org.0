Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE80258A2A
	for <lists+linux-nvdimm@lfdr.de>; Tue,  1 Sep 2020 10:15:45 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B4BC9139DE86A;
	Tue,  1 Sep 2020 01:15:42 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.191; helo=huawei.com; envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 08210139DE865
	for <linux-nvdimm@lists.01.org>; Tue,  1 Sep 2020 01:15:38 -0700 (PDT)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id 02F76D09C7582586E238;
	Tue,  1 Sep 2020 16:15:34 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Tue, 1 Sep 2020 16:15:26 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Oliver O'Halloran <oohall@gmail.com>, Dan Williams
	<dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, Markus
 Elfring <Markus.Elfring@web.de>, linux-nvdimm <linux-nvdimm@lists.01.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/1] libnvdimm: fix memory leaks in of_pmem.c
Date: Tue, 1 Sep 2020 16:14:49 +0800
Message-ID: <20200901081450.1969-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Message-ID-Hash: 2PKY7PFNTKYLUEHB65I7SBPUDCOZYHOS
X-Message-ID-Hash: 2PKY7PFNTKYLUEHB65I7SBPUDCOZYHOS
X-MailFrom: thunder.leizhen@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Zhen Lei <thunder.leizhen@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2PKY7PFNTKYLUEHB65I7SBPUDCOZYHOS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

v3 --> v4
1. Merge patch 1 and 2 into one:
   https://lkml.org/lkml/2020/8/19/1464		Patch 1
   https://lkml.org/lkml/2020/8/19/1468		Patch 2
2. The part from patch 1 was reviewed by Oliver O'Halloran <oohall@gmail.com>

Zhen Lei (1):
  libnvdimm: fix memory leaks in of_pmem.c

 drivers/nvdimm/of_pmem.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
1.8.3

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

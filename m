Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7670D2DEDD1
	for <lists+linux-nvdimm@lfdr.de>; Sat, 19 Dec 2020 09:19:31 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CDA6C100ED489;
	Sat, 19 Dec 2020 00:19:29 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN> 
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E7CB7100EF25B
	for <linux-nvdimm@lists.01.org>; Sat, 19 Dec 2020 00:19:27 -0800 (PST)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cydsh31pmzksDV;
	Sat, 19 Dec 2020 16:18:32 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.9) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Sat, 19 Dec 2020 16:19:13 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, linux-nvdimm
	<linux-nvdimm@lists.01.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/1] device-dax: avoid an unnecessary check in alloc_dev_dax_range()
Date: Sat, 19 Dec 2020 16:18:39 +0800
Message-ID: <20201219081840.1149-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Message-ID-Hash: KLUVUQNU2YPMNCBW3WWY5IPUTKWDUT6R
X-Message-ID-Hash: KLUVUQNU2YPMNCBW3WWY5IPUTKWDUT6R
X-MailFrom: thunder.leizhen@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Zhen Lei <thunder.leizhen@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KLUVUQNU2YPMNCBW3WWY5IPUTKWDUT6R/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

v1 --> v2:
In v1, I use the "goto" statement to merge two identical __release_region() calls.
However, the new patch https://lkml.org/lkml/2020/12/18/735 deletes one of them, the
"goto" becomes worthless. So when krealloc() failed, directly call __release_region()
and return error code.


Zhen Lei (1):
  device-dax: avoid an unnecessary check in alloc_dev_dax_range()

 drivers/dax/bus.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

-- 
2.26.0.106.g9fadedd

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

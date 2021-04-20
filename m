Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F35365343
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Apr 2021 09:30:52 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 24DC5100EB33F;
	Tue, 20 Apr 2021 00:30:50 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.35; helo=szxga07-in.huawei.com; envelope-from=zou_wei@huawei.com; receiver=<UNKNOWN> 
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1FD8B100EB859
	for <linux-nvdimm@lists.01.org>; Tue, 20 Apr 2021 00:30:47 -0700 (PDT)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FPZzV6K2PzBrYk;
	Tue, 20 Apr 2021 15:28:22 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Tue, 20 Apr 2021 15:30:34 +0800
From: Zou Wei <zou_wei@huawei.com>
To: <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
	<dave.jiang@intel.com>, <santosh@fossix.org>, <ira.weiny@intel.com>,
	<akpm@linux-foundation.org>, <dan.carpenter@oracle.com>,
	<boris.ostrovsky@oracle.com>
Subject: [PATCH -next v2] tools/testing/nvdimm: Make symbol '__nfit_test_ioremap' static
Date: Tue, 20 Apr 2021 15:47:47 +0800
Message-ID: <1618904867-25275-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Message-ID-Hash: RL7JZEUIHFM6XFJEFWIUBUFM6KVK2ZNV
X-Message-ID-Hash: RL7JZEUIHFM6XFJEFWIUBUFM6KVK2ZNV
X-MailFrom: zou_wei@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Zou Wei <zou_wei@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RL7JZEUIHFM6XFJEFWIUBUFM6KVK2ZNV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The sparse tool complains as follows:

tools/testing/nvdimm/test/iomap.c:65:14: warning:
 symbol '__nfit_test_ioremap' was not declared. Should it be static?

This symbol is not used outside of iomap.c, so this
commit marks it static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 tools/testing/nvdimm/test/iomap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/nvdimm/test/iomap.c b/tools/testing/nvdimm/test/iomap.c
index c62d372..ed563bd 100644
--- a/tools/testing/nvdimm/test/iomap.c
+++ b/tools/testing/nvdimm/test/iomap.c
@@ -62,7 +62,7 @@ struct nfit_test_resource *get_nfit_res(resource_size_t resource)
 }
 EXPORT_SYMBOL(get_nfit_res);
 
-void __iomem *__nfit_test_ioremap(resource_size_t offset, unsigned long size,
+static void __iomem *__nfit_test_ioremap(resource_size_t offset, unsigned long size,
 		void __iomem *(*fallback_fn)(resource_size_t, unsigned long))
 {
 	struct nfit_test_resource *nfit_res = get_nfit_res(offset);
-- 
2.6.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 313EB298ACA
	for <lists+linux-nvdimm@lfdr.de>; Mon, 26 Oct 2020 11:53:53 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CBC29161898A0;
	Mon, 26 Oct 2020 03:53:50 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=zhangqilong3@huawei.com; receiver=<UNKNOWN> 
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 52CF51618989E
	for <linux-nvdimm@lists.01.org>; Mon, 26 Oct 2020 03:53:47 -0700 (PDT)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CKWsp365WzkZWt
	for <linux-nvdimm@lists.01.org>; Mon, 26 Oct 2020 18:53:50 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Mon, 26 Oct 2020
 18:53:39 +0800
From: Zhang Qilong <zhangqilong3@huawei.com>
To: <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
	<dave.jiang@intel.com>, <linux-nvdimm@lists.01.org>
Subject: [PATCH -next] device-dax: change error code from postive to negative in range_parse
Date: Mon, 26 Oct 2020 19:04:25 +0800
Message-ID: <20201026110425.136629-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Message-ID-Hash: TIIMLRJFFDYNIHSNXB2YRU4DHGHC7DAB
X-Message-ID-Hash: TIIMLRJFFDYNIHSNXB2YRU4DHGHC7DAB
X-MailFrom: zhangqilong3@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TIIMLRJFFDYNIHSNXB2YRU4DHGHC7DAB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

call trace:
	-> mapping_store()
		-> range_parse()
		......
		rc = -ENXIO;

According to context, the error return value of
range_parse should be negative.

Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/dax/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 27513d311242..e15a1a7c2853 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1047,7 +1047,7 @@ static ssize_t range_parse(const char *opt, size_t len, struct range *range)
 {
 	unsigned long long addr = 0;
 	char *start, *end, *str;
-	ssize_t rc = EINVAL;
+	ssize_t rc = -EINVAL;
 
 	str = kstrdup(opt, GFP_KERNEL);
 	if (!str)
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

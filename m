Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 134E72A9270
	for <lists+linux-nvdimm@lfdr.de>; Fri,  6 Nov 2020 10:24:24 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D92891673C06E;
	Fri,  6 Nov 2020 01:24:22 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=liuzhiqiang26@huawei.com; receiver=<UNKNOWN> 
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6DFF91673C06A
	for <linux-nvdimm@lists.01.org>; Fri,  6 Nov 2020 01:24:19 -0800 (PST)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CSFMC1yvVzLvLj
	for <linux-nvdimm@lists.01.org>; Fri,  6 Nov 2020 17:24:07 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.238) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Fri, 6 Nov 2020
 17:24:05 +0800
Subject: [ndctl PATCH 1/8] namespace: check whether pfn|dax|btt is NULL in
 setup_namespace
To: <vishal.l.verma@intel.com>
References: <bed3b3b3-1f30-6751-c0bf-15ecf70192f9@huawei.com>
From: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <4f51f398-08d0-15c9-fdcb-27b73db78d24@huawei.com>
Date: Fri, 6 Nov 2020 17:24:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <bed3b3b3-1f30-6751-c0bf-15ecf70192f9@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.174.176.238]
X-CFilter-Loop: Reflected
Message-ID-Hash: D35JIUS7T33H75KE56RXLU2Z3G4SSKRO
X-Message-ID-Hash: D35JIUS7T33H75KE56RXLU2Z3G4SSKRO
X-MailFrom: liuzhiqiang26@huawei.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, linfeilong <linfeilong@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/D35JIUS7T33H75KE56RXLU2Z3G4SSKRO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


In setup_namespace(), pfn|dax|btt is obtained by calling
ndctl_region_get_**_seed(), which may return NULL. So we
need to check whether pfn|dax|btt is NULL before accessing
them.

Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
 ndctl/namespace.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index e946bb6..257384d 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -549,6 +549,8 @@ static int setup_namespace(struct ndctl_region *region,

 	if (do_setup_pfn(ndns, p)) {
 		struct ndctl_pfn *pfn = ndctl_region_get_pfn_seed(region);
+		if (!pfn)
+			return -ENXIO;

 		rc = check_dax_align(ndns);
 		if (rc)
@@ -563,6 +565,8 @@ static int setup_namespace(struct ndctl_region *region,
 			ndctl_pfn_set_namespace(pfn, NULL);
 	} else if (p->mode == NDCTL_NS_MODE_DEVDAX) {
 		struct ndctl_dax *dax = ndctl_region_get_dax_seed(region);
+		if (!dax)
+			return -ENXIO;

 		rc = check_dax_align(ndns);
 		if (rc)
@@ -577,7 +581,8 @@ static int setup_namespace(struct ndctl_region *region,
 			ndctl_dax_set_namespace(dax, NULL);
 	} else if (p->mode == NDCTL_NS_MODE_SECTOR) {
 		struct ndctl_btt *btt = ndctl_region_get_btt_seed(region);
-
+		if (!btt)
+			return -ENXIO;
 		/*
 		 * Handle the case of btt on a pmem namespace where the
 		 * pmem kernel support is pre-v1.2 namespace labels
-- 
1.8.3.1


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

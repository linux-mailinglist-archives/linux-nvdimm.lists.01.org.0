Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 659852A9295
	for <lists+linux-nvdimm@lfdr.de>; Fri,  6 Nov 2020 10:28:27 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 136041674C107;
	Fri,  6 Nov 2020 01:28:26 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.35; helo=szxga07-in.huawei.com; envelope-from=liuzhiqiang26@huawei.com; receiver=<UNKNOWN> 
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 153431673C06B
	for <linux-nvdimm@lists.01.org>; Fri,  6 Nov 2020 01:28:23 -0800 (PST)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CSFS11LGjz73TD
	for <linux-nvdimm@lists.01.org>; Fri,  6 Nov 2020 17:28:17 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.238) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Fri, 6 Nov 2020
 17:28:12 +0800
Subject: [ndctl PATCH 8/8] Check whether seed is NULL in
 validate_namespace_options
To: <vishal.l.verma@intel.com>
References: <bed3b3b3-1f30-6751-c0bf-15ecf70192f9@huawei.com>
From: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <685bde1f-1c64-28db-d20d-a0876a7ee76a@huawei.com>
Date: Fri, 6 Nov 2020 17:28:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <bed3b3b3-1f30-6751-c0bf-15ecf70192f9@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.174.176.238]
X-CFilter-Loop: Reflected
Message-ID-Hash: 6QGO43VFZCVDFTSBD2YGNHFQETSOAZ4D
X-Message-ID-Hash: 6QGO43VFZCVDFTSBD2YGNHFQETSOAZ4D
X-MailFrom: liuzhiqiang26@huawei.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, linfeilong <linfeilong@huawei.com>, liuzhiqiang26@huawei.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6QGO43VFZCVDFTSBD2YGNHFQETSOAZ4D/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


In validate_namespace_options(), seed is obtained through
calling ndctl_region_get_namespace_seed(), which may return
NULL. If seed is NULL, we should return directly with error
code. In addition, we can use region_name var rather than
calling ndctl_region_get_devname() again.

Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
 ndctl/namespace.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index 257384d..5a92d62 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -847,8 +847,7 @@ static int validate_namespace_options(struct ndctl_region *region,
 	region_align = ndctl_region_get_align(region);
 	if (region_align < ULONG_MAX && p->size % region_align) {
 		err("%s: align setting is %#lx size %#llx is misaligned\n",
-				ndctl_region_get_devname(region), region_align,
-				p->size);
+				region_name, region_align, p->size);
 		return -EINVAL;
 	}

@@ -924,8 +923,13 @@ static int validate_namespace_options(struct ndctl_region *region,
 		} else {
 			struct ndctl_namespace *seed = ndns;

-			if (!seed)
+			if (!seed) {
 				seed = ndctl_region_get_namespace_seed(region);
+				if (!seed) {
+					err("%s: failed to get seed\n", region_name);
+					return -ENXIO;
+				}
+			}
 			num = ndctl_namespace_get_num_sector_sizes(seed);
 			for (i = 0; i < num; i++)
 				if (ndctl_namespace_get_supported_sector_size(seed, i)
@@ -953,9 +957,13 @@ static int validate_namespace_options(struct ndctl_region *region,
 		struct ndctl_namespace *seed;

 		seed = ndctl_region_get_namespace_seed(region);
+		if (!seed) {
+			err("%s: failed to get seed\n", region_name);
+			return -ENXIO;
+		}
 		if (ndctl_namespace_get_type(seed) == ND_DEVICE_NAMESPACE_BLK)
 			debug("%s: set_defaults() should preclude this?\n",
-				ndctl_region_get_devname(region));
+				region_name);
 		/*
 		 * Pick a default sector size for a pmem namespace based
 		 * on what the kernel supports.
-- 
1.8.3.1


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

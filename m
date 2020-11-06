Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7282A927C
	for <lists+linux-nvdimm@lfdr.de>; Fri,  6 Nov 2020 10:25:47 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 494471673C07D;
	Fri,  6 Nov 2020 01:25:46 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.32; helo=szxga06-in.huawei.com; envelope-from=liuzhiqiang26@huawei.com; receiver=<UNKNOWN> 
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3FF90163F9794
	for <linux-nvdimm@lists.01.org>; Fri,  6 Nov 2020 01:25:43 -0800 (PST)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CSFNy1pp3zhdbZ
	for <linux-nvdimm@lists.01.org>; Fri,  6 Nov 2020 17:25:38 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.238) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Fri, 6 Nov 2020
 17:25:32 +0800
Subject: [ndctl PATCH 3/8] libdaxctl: fix memory leakage in add_dax_region()
To: <vishal.l.verma@intel.com>
References: <bed3b3b3-1f30-6751-c0bf-15ecf70192f9@huawei.com>
From: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <7ae72048-0c26-9da2-41a9-c1b63a8db117@huawei.com>
Date: Fri, 6 Nov 2020 17:25:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <bed3b3b3-1f30-6751-c0bf-15ecf70192f9@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.174.176.238]
X-CFilter-Loop: Reflected
Message-ID-Hash: CIDKJXRYSFXY6YUOGO5YMZFIMKPNPPYX
X-Message-ID-Hash: CIDKJXRYSFXY6YUOGO5YMZFIMKPNPPYX
X-MailFrom: liuzhiqiang26@huawei.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, linfeilong <linfeilong@huawei.com>, liuzhiqiang26@huawei.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CIDKJXRYSFXY6YUOGO5YMZFIMKPNPPYX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


In add_dax_region(), region->devname is allocated by
calling strdup(), which may return NULL. So, we need
to check whether region->devname is NULL, and free
region->devname in err_read tag.

Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
 daxctl/lib/libdaxctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index ee4a069..d841b78 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -287,6 +287,8 @@ static struct daxctl_region *add_dax_region(void *parent, int id,
 	region->refcount = 1;
 	list_head_init(&region->devices);
 	region->devname = strdup(devpath_to_devname(base));
+	if (!region->devname)
+		goto err_read;

 	sprintf(path, "%s/%s/size", base, attrs);
 	if (sysfs_read_attr(ctx, path, buf) == 0)
@@ -314,6 +316,7 @@ static struct daxctl_region *add_dax_region(void *parent, int id,
  err_read:
 	free(region->region_buf);
 	free(region->region_path);
+	free(region->devname);
 	free(region);
  err_region:
 	free(path);
-- 
1.8.3.1

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

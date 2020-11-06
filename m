Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 154CC2A9287
	for <lists+linux-nvdimm@lfdr.de>; Fri,  6 Nov 2020 10:27:24 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B97C31674C0FC;
	Fri,  6 Nov 2020 01:27:22 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=liuzhiqiang26@huawei.com; receiver=<UNKNOWN> 
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C16811674C0FA
	for <linux-nvdimm@lists.01.org>; Fri,  6 Nov 2020 01:27:20 -0800 (PST)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CSFQl3vVWzkfw1
	for <linux-nvdimm@lists.01.org>; Fri,  6 Nov 2020 17:27:11 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.238) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Fri, 6 Nov 2020
 17:27:10 +0800
Subject: [ndctl PATCH 6/8] lib/inject: check whether cmd is created
 successfully
To: <vishal.l.verma@intel.com>
References: <bed3b3b3-1f30-6751-c0bf-15ecf70192f9@huawei.com>
From: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <8e8a88ee-a792-dc86-0fa7-b2609588fc88@huawei.com>
Date: Fri, 6 Nov 2020 17:27:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <bed3b3b3-1f30-6751-c0bf-15ecf70192f9@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.174.176.238]
X-CFilter-Loop: Reflected
Message-ID-Hash: 6ERQK2FU6K4XDAT36YP4DPO3FCHRMTGA
X-Message-ID-Hash: 6ERQK2FU6K4XDAT36YP4DPO3FCHRMTGA
X-MailFrom: liuzhiqiang26@huawei.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, linfeilong <linfeilong@huawei.com>, liuzhiqiang26@huawei.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6ERQK2FU6K4XDAT36YP4DPO3FCHRMTGA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


ndctl_bus_cmd_new_ars_cp() is called to create cmd,
which may return NULL. We need to check whether it
is NULL in callers, such as ndctl_namespace_get_clear_uint
and ndctl_namespace_injection_status.

Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
 ndctl/lib/inject.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/ndctl/lib/inject.c b/ndctl/lib/inject.c
index 815f254..b543fc7 100644
--- a/ndctl/lib/inject.c
+++ b/ndctl/lib/inject.c
@@ -114,6 +114,10 @@ static int ndctl_namespace_get_clear_unit(struct ndctl_namespace *ndns)
 	if (rc)
 		return rc;
 	cmd = ndctl_bus_cmd_new_ars_cap(bus, ns_offset, ns_size);
+	if (!cmd) {
+		err(ctx, "bus: %s failed to create cmd\n", ndctl_bus_get_provider(bus));
+		return -ENOTTY;
+	}
 	rc = ndctl_cmd_submit(cmd);
 	if (rc < 0) {
 		dbg(ctx, "Error submitting ars_cap: %d\n", rc);
@@ -457,6 +461,10 @@ NDCTL_EXPORT int ndctl_namespace_injection_status(struct ndctl_namespace *ndns)
 			return rc;

 		cmd = ndctl_bus_cmd_new_ars_cap(bus, ns_offset, ns_size);
+		if (!cmd) {
+			err(ctx, "bus: %s failed to create cmd\n", ndctl_bus_get_provider(bus));
+			return -ENOTTY;
+		}
 		rc = ndctl_cmd_submit(cmd);
 		if (rc < 0) {
 			dbg(ctx, "Error submitting ars_cap: %d\n", rc);
-- 
1.8.3.1


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

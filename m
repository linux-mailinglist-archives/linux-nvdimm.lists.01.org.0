Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33172CA453
	for <lists+linux-nvdimm@lfdr.de>; Tue,  1 Dec 2020 14:54:05 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 28CBF100EC1E4;
	Tue,  1 Dec 2020 05:54:04 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.32; helo=szxga06-in.huawei.com; envelope-from=wanghai38@huawei.com; receiver=<UNKNOWN> 
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E80F1100EC1E1
	for <linux-nvdimm@lists.01.org>; Tue,  1 Dec 2020 05:53:59 -0800 (PST)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Clk8S1HdBzhkcj;
	Tue,  1 Dec 2020 21:53:28 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Tue, 1 Dec 2020
 21:53:46 +0800
From: Wang Hai <wanghai38@huawei.com>
To: <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
	<dave.jiang@intel.com>
Subject: [PATCH] dax: fix memory leak when rmmod dax.ko
Date: Tue, 1 Dec 2020 21:59:29 +0800
Message-ID: <20201201135929.66530-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Message-ID-Hash: ANKNOEY3G6N7BUHR2NUZFBKED24RGCEI
X-Message-ID-Hash: ANKNOEY3G6N7BUHR2NUZFBKED24RGCEI
X-MailFrom: wanghai38@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ANKNOEY3G6N7BUHR2NUZFBKED24RGCEI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When I repeatedly modprobe and rmmod dax.ko, kmemleak report a
memory leak as follows:

unreferenced object 0xffff9a5588c05088 (size 8):
  comm "modprobe", pid 261, jiffies 4294693644 (age 42.063s)
...
  backtrace:
    [<00000000e007ced0>] kstrdup+0x35/0x70
    [<000000002ae73897>] kstrdup_const+0x3d/0x50
    [<000000002b00c9c3>] kvasprintf_const+0xbc/0xf0
    [<000000008023282f>] kobject_set_name_vargs+0x3b/0xd0
    [<00000000d2cbaa4e>] kobject_set_name+0x62/0x90
    [<00000000202e7a22>] bus_register+0x7f/0x2b0
    [<000000000b77792c>] 0xffffffffc02840f7
    [<000000002d5be5ac>] 0xffffffffc02840b4
    [<00000000dcafb7cd>] do_one_initcall+0x58/0x240
    [<00000000049fe480>] do_init_module+0x56/0x1e2
    [<0000000022671491>] load_module+0x2517/0x2840
    [<000000001a2201cb>] __do_sys_finit_module+0x9c/0xe0
    [<000000003eb304e7>] do_syscall_64+0x33/0x40
    [<0000000051c5fd06>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

When rmmod dax is executed, dax_bus_exit() is missing. This patch
can fix this bug.

Fixes: 9567da0b408a ("device-dax: Introduce bus + driver model")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/dax/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index edc279be3e59..cadbd0a1a1ef 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -752,6 +752,7 @@ static int __init dax_core_init(void)
 
 static void __exit dax_core_exit(void)
 {
+	dax_bus_exit();
 	unregister_chrdev_region(dax_devt, MINORMASK+1);
 	ida_destroy(&dax_minor_ida);
 	dax_fs_exit();
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

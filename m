Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CF42426FE
	for <lists+linux-nvdimm@lfdr.de>; Wed, 12 Aug 2020 10:56:16 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0C67F12F4631A;
	Wed, 12 Aug 2020 01:56:14 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.103.53.11; helo=mail5.wrs.com; envelope-from=qiang.zhang@windriver.com; receiver=<UNKNOWN> 
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CA8E712F3F3DD
	for <linux-nvdimm@lists.01.org>; Wed, 12 Aug 2020 01:56:12 -0700 (PDT)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 07C8tDEr000485
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
	Wed, 12 Aug 2020 01:55:33 -0700
Received: from pek-qzhang2-d1.wrs.com (128.224.162.183) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.487.0; Wed, 12 Aug 2020 01:55:03 -0700
From: <qiang.zhang@windriver.com>
To: <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>
Subject: [PATCH v2] libnvdimm: KASAN: global-out-of-bounds Read in internal_create_group
Date: Wed, 12 Aug 2020 16:55:01 +0800
Message-ID: <20200812085501.30963-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Message-ID-Hash: TENQWKJS5ASWIDCMC2U32OFZG4RWM5H7
X-Message-ID-Hash: TENQWKJS5ASWIDCMC2U32OFZG4RWM5H7
X-MailFrom: Qiang.Zhang@windriver.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TENQWKJS5ASWIDCMC2U32OFZG4RWM5H7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Zqiang <qiang.zhang@windriver.com>

Because the last member of the "nvdimm_firmware_attributes" array
was not assigned a null ptr, when traversal of "grp->attrs" array
is out of bounds in "create_files" func.

func:
	create_files:
		->for (i = 0, attr = grp->attrs; *attr && !error; i++, attr++)
			->....

BUG: KASAN: global-out-of-bounds in create_files fs/sysfs/group.c:43 [inline]
BUG: KASAN: global-out-of-bounds in internal_create_group+0x9d8/0xb20
fs/sysfs/group.c:149
Read of size 8 at addr ffffffff8a2e4cf0 by task kworker/u17:10/959

CPU: 2 PID: 959 Comm: kworker/u17:10 Not tainted 5.8.0-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Workqueue: events_unbound async_run_entry_fn
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0x5/0x497 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 create_files fs/sysfs/group.c:43 [inline]
 internal_create_group+0x9d8/0xb20 fs/sysfs/group.c:149
 internal_create_groups.part.0+0x90/0x140 fs/sysfs/group.c:189
 internal_create_groups fs/sysfs/group.c:185 [inline]
 sysfs_create_groups+0x25/0x50 fs/sysfs/group.c:215
 device_add_groups drivers/base/core.c:2024 [inline]
 device_add_attrs drivers/base/core.c:2178 [inline]
 device_add+0x7fd/0x1c40 drivers/base/core.c:2881
 nd_async_device_register+0x12/0x80 drivers/nvdimm/bus.c:506
 async_run_entry_fn+0x121/0x530 kernel/async.c:123
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

The buggy address belongs to the variable:
 nvdimm_firmware_attributes+0x10/0x40

Reported-by: syzbot+1cf0ffe61aecf46f588f@syzkaller.appspotmail.com
Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 v1->v2:
 Modify the description of the error.

 drivers/nvdimm/dimm_devs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index 61374def5155..b59032e0859b 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -529,6 +529,7 @@ static DEVICE_ATTR_ADMIN_RW(activate);
 static struct attribute *nvdimm_firmware_attributes[] = {
 	&dev_attr_activate.attr,
 	&dev_attr_result.attr,
+	NULL,
 };
 
 static umode_t nvdimm_firmware_visible(struct kobject *kobj, struct attribute *a, int n)
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

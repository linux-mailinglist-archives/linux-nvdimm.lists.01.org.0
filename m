Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2BF1A4CBE
	for <lists+linux-nvdimm@lfdr.de>; Sat, 11 Apr 2020 02:09:34 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E95DA10FC33FD;
	Fri, 10 Apr 2020 17:10:21 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B04AA10FC33E2
	for <linux-nvdimm@lists.01.org>; Fri, 10 Apr 2020 17:10:19 -0700 (PDT)
IronPort-SDR: 41kAuagkBToIbYJJMyczl41o3Dy+b/kwNNv60ckUwupzHIPNTwyTnwiaoJC1h64fEYeuyZsjTr
 TVlZY0/4pq8A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2020 17:09:30 -0700
IronPort-SDR: 7BcNaqm+J64TVfPlQwwzm/cOtuANdguHOHjksmNmSTEIHMGk5S30POGIjgV6PTeRG+dlD5DPFs
 rLLYJ61XL8WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,368,1580803200";
   d="scan'208";a="331316197"
Received: from vverma7-mobl4.lm.intel.com ([10.251.142.92])
  by orsmga001.jf.intel.com with ESMTP; 10 Apr 2020 17:09:29 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [PATCH] dax/kmem: refrain from adding memory into an impossible node
Date: Fri, 10 Apr 2020 18:09:16 -0600
Message-Id: <20200411000916.13656-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Message-ID-Hash: BGZBNNI5W2F4MLBDKISBDRUROON4XLN4
X-Message-ID-Hash: BGZBNNI5W2F4MLBDKISBDRUROON4XLN4
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BGZBNNI5W2F4MLBDKISBDRUROON4XLN4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

A misbehaving qemu created a situation where the ACPI SRAT table
advertised one fewer proximity domains than intended. The NFIT table did
describe all the expected proximity domains. This caused the device dax
driver to assign an impossible target_node to the device, and when
hotplugged as system memory, this would fail with the following
signature:

  [  +0.001627] BUG: kernel NULL pointer dereference, address: 0000000000000088
  [  +0.001331] #PF: supervisor read access in kernel mode
  [  +0.000975] #PF: error_code(0x0000) - not-present page
  [  +0.000976] PGD 80000001767d4067 P4D 80000001767d4067 PUD 10e0c4067 PMD 0
  [  +0.001338] Oops: 0000 [#1] SMP PTI
  [  +0.000676] CPU: 4 PID: 22737 Comm: kswapd3 Tainted: G           O      5.6.0-rc5 #9
  [  +0.001457] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
      BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
  [  +0.001990] RIP: 0010:prepare_kswapd_sleep+0x7c/0xc0
  [  +0.000780] Code: 89 df e8 87 fd ff ff 89 c2 31 c0 84 d2 74 e6 0f 1f 44
                      00 00 48 8b 05 fb af 7a 01 48 63 93 88 1d 01 00 48 8b
		      84 d0 20 0f 00 00 <48> 3b 98 88 00 00 00 75 28 f0 80 a0
		      80 00 00 00 fe f0 80 a3 38 20
  [  +0.002877] RSP: 0018:ffffc900017a3e78 EFLAGS: 00010202
  [  +0.000805] RAX: 0000000000000000 RBX: ffff8881209e0000 RCX: 0000000000000000
  [  +0.001115] RDX: 0000000000000003 RSI: 0000000000000000 RDI: ffff8881209e0e80
  [  +0.001098] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000008000
  [  +0.001092] R10: 0000000000000000 R11: 0000000000000003 R12: 0000000000000003
  [  +0.001092] R13: 0000000000000003 R14: 0000000000000000 R15: ffffc900017a3ec8
  [  +0.001091] FS:  0000000000000000(0000) GS:ffff888318c00000(0000) knlGS:0000000000000000
  [  +0.001275] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [  +0.000882] CR2: 0000000000000088 CR3: 0000000120b50002 CR4: 00000000001606e0
  [  +0.001095] Call Trace:
  [  +0.000388]  kswapd+0x103/0x520
  [  +0.000494]  ? finish_wait+0x80/0x80
  [  +0.000547]  ? balance_pgdat+0x5a0/0x5a0
  [  +0.000607]  kthread+0x120/0x140
  [  +0.000508]  ? kthread_create_on_node+0x60/0x60
  [  +0.000706]  ret_from_fork+0x3a/0x50

Add a check in the kmem driver to ensure that the target_node for the
device in question is in the nodes_possible mask.

Cc: Dan Williams <dan.j.williams@intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 drivers/dax/kmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 3d0a7e702c94..760c5b4e88c8 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -32,7 +32,7 @@ int dev_dax_kmem_probe(struct device *dev)
 	 * unavoidable performance issues.
 	 */
 	numa_node = dev_dax->target_node;
-	if (numa_node < 0) {
+	if (numa_node < 0 || !node_possible(numa_node)) {
 		dev_warn(dev, "rejecting DAX region %pR with invalid node: %d\n",
 			 res, numa_node);
 		return -EINVAL;
-- 
2.21.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

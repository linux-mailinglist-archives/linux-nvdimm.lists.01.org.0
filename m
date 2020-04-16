Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C211ACE72
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 Apr 2020 19:10:31 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DF182100DCB75;
	Thu, 16 Apr 2020 10:10:50 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A5D23100DCB74
	for <linux-nvdimm@lists.01.org>; Thu, 16 Apr 2020 10:10:48 -0700 (PDT)
IronPort-SDR: TMw0f/nm6HJ+MubHqiMcMkzWpbDr4cfIF1gPy7angkI9Jid4XmAqCvBYYW/vS6Z9iZV7Vf7JEo
 apIVylz5p24A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 10:10:26 -0700
IronPort-SDR: BUMyk+/UbxoauHN0IxO7bK+rlh2kh7Gv8MhlgQeL4SPuwWM2GSGRk5lomtWT8e1uo9Wki/3Y2B
 cQE7/YqBpMiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,391,1580803200";
   d="scan'208";a="242721569"
Received: from vverma7-mobl4.lm.intel.com ([10.254.27.78])
  by orsmga007.jf.intel.com with ESMTP; 16 Apr 2020 10:10:24 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-mm@kvack.org>
Subject: [PATCH v4] mm/memory_hotplug: refrain from adding memory into an impossible node
Date: Thu, 16 Apr 2020 11:10:19 -0600
Message-Id: <20200416171019.24433-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Message-ID-Hash: JA54IEDZA2FM32PZG6IL3QIK5TEZ6KLO
X-Message-ID-Hash: JA54IEDZA2FM32PZG6IL3QIK5TEZ6KLO
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Michal Hocko <mhocko@kernel.org>, David Hildenbrand <david@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JA54IEDZA2FM32PZG6IL3QIK5TEZ6KLO/>
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

Add a check in the add_memory path to fail if the node to which we
are adding memory is in the node_possible_map

Cc: Michal Hocko <mhocko@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 mm/memory_hotplug.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0a54ffac8c68..ddd3347edd54 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1005,6 +1005,11 @@ int __ref add_memory_resource(int nid, struct resource *res)
 	if (ret)
 		return ret;
 
+	if (!node_possible(nid)) {
+		WARN(1, "node %d was absent from the node_possible_map\n", nid);
+		return -ENXIO;
+	}
+
 	mem_hotplug_begin();
 
 	/*
-- 
2.21.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

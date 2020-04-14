Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1E21A8EC4
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 Apr 2020 00:50:44 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0132210FE2561;
	Tue, 14 Apr 2020 15:51:16 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 268F710FD2ADB
	for <linux-nvdimm@lists.01.org>; Tue, 14 Apr 2020 15:51:13 -0700 (PDT)
IronPort-SDR: mI75CQbYJUFtQ7ygP0wveIepp5v1SJkd9ChKTsrz14oRVJGMgtLmzYWMrs3CfyeEwr5gU391ly
 CIl4a6EHvREg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 15:50:39 -0700
IronPort-SDR: XOqQSIUAd9gaNqWGKGML5J57BUfvQ6ojIUcssQoCJCAXjsxqVIWHdBUI2cJCA1NhP6Ia9Gh7Z2
 nQ0LsGlZmBzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,384,1580803200";
   d="scan'208";a="298835830"
Received: from vverma7-mobl4.lm.intel.com ([10.251.131.109])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Apr 2020 15:50:38 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-mm@kvack.org>
Subject: [PATCH v2] mm/memory_hotplug: refrain from adding memory into an impossible node
Date: Tue, 14 Apr 2020 16:50:29 -0600
Message-Id: <20200414225029.709-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Message-ID-Hash: 4IBWIHD6DFODH5LJ7CBADYPVKBAPKNA4
X-Message-ID-Hash: 4IBWIHD6DFODH5LJ7CBADYPVKBAPKNA4
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, David Hildenbrand <david@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4IBWIHD6DFODH5LJ7CBADYPVKBAPKNA4/>
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

Add a check in the add_memory path to ensure that the node to which we
are adding memory is in the node_possible_map

Cc: David Hildenbrand <david@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 mm/memory_hotplug.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

v2:
- Centralize the check in the add_memory path (David)
- Instead of failing, add the memory to a nearby node, while warning
  (and tainting) to call out attention to the firmware bug (Dan)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0a54ffac8c68..022df38a5d8a 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -980,6 +980,28 @@ static int check_hotplug_memory_range(u64 start, u64 size)
 	return 0;
 }
 
+/*
+ * Check that the node provided for adding memory was valid.
+ * If not, find the nearest valid node and add the memory there while
+ * tainting the kernel and displaying a warning to bring attention to the
+ * underlying firmware problem.
+ * Return nid if valid, or an adjusted node number that can be used instead
+ * if the original nid was not valid
+ */
+static int check_hotplug_node(int nid)
+{
+	int alt_nid;
+
+	if (node_possible(nid))
+		return nid;
+
+	alt_nid = numa_map_to_online_node(nid);
+	WARN_TAINT(1, TAINT_FIRMWARE_WORKAROUND,
+		   "node %d expected, but was absent from the node_possible_map, using %d instead\n",
+		   nid, alt_nid);
+	return alt_nid;
+}
+
 static int online_memory_block(struct memory_block *mem, void *arg)
 {
 	return device_online(&mem->dev);
@@ -1005,6 +1027,10 @@ int __ref add_memory_resource(int nid, struct resource *res)
 	if (ret)
 		return ret;
 
+	nid = check_hotplug_node(nid);
+	if (nid < 0)
+		return -ENXIO;
+
 	mem_hotplug_begin();
 
 	/*
-- 
2.21.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

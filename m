Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9951DDC28
	for <lists+linux-nvdimm@lfdr.de>; Sun, 20 Oct 2019 05:23:56 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AC0451007B5DA;
	Sat, 19 Oct 2019 20:25:42 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B9E981007B67E
	for <linux-nvdimm@lists.01.org>; Sat, 19 Oct 2019 20:25:39 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2019 20:23:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,318,1566889200";
   d="scan'208";a="187207971"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.164])
  by orsmga007.jf.intel.com with ESMTP; 19 Oct 2019 20:23:43 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH v2 08/10] Documentation: clarify memory movablity for reconfigure-device
Date: Sat, 19 Oct 2019 21:23:30 -0600
Message-Id: <20191020032332.16776-9-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191020032332.16776-1-vishal.l.verma@intel.com>
References: <20191020032332.16776-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Message-ID-Hash: UVAJD3BPTMFVR4YTUNPIFASWE4AC7JXN
X-Message-ID-Hash: UVAJD3BPTMFVR4YTUNPIFASWE4AC7JXN
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Ben Olson <ben.olson@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UVAJD3BPTMFVR4YTUNPIFASWE4AC7JXN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Move the note about potential races in memory onlining into the
'Description' section to make it more prominent. Reword the note to talk
about the sources of such races, and talk about the new 'race detection'
semantics in daxctl.

Link: https://github.com/pmem/ndctl/issues/110
Reported-by: Ben Olson <ben.olson@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 .../daxctl/daxctl-reconfigure-device.txt      | 24 +++++++++++--------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/Documentation/daxctl/daxctl-reconfigure-device.txt b/Documentation/daxctl/daxctl-reconfigure-device.txt
index 196d692..4663529 100644
--- a/Documentation/daxctl/daxctl-reconfigure-device.txt
+++ b/Documentation/daxctl/daxctl-reconfigure-device.txt
@@ -97,6 +97,20 @@ error reconfiguring devices: Operation not supported
 reconfigured 0 devices
 ----
 
+'daxctl-reconfigure-device' nominally expects that it will online new memory
+blocks as 'movable', so that kernel data doesn't make it into this memory.
+However, there are other potential agents that may be configured to
+automatically online new hot-plugged memory as it appears. Most notably,
+these are the '/sys/devices/system/memory/auto_online_blocks' configuration,
+or system udev rules. If such an agent races to online memory sections, daxctl
+checks if the blocks were onlined as 'movable' memory. If this was not the
+case, and the memory blocks are found to be in a different zone, then a
+warning is displayed. If it is desired that a different agent control the
+onlining of memory blocks, and the associated memory zone, then it is
+recommended to use the --no-online option described below. This will abridge
+the device reconfiguration operation to just hotplugging the memory, and
+refrain from then onlining it.
+
 OPTIONS
 -------
 -r::
@@ -121,16 +135,6 @@ OPTIONS
 	brought online automatically and immediately with the 'online_movable'
 	policy. Use this option to disable the automatic onlining behavior.
 
-	NOTE: While this option prevents daxctl from automatically onlining
-	the memory sections, there may be other agents, notably system udev
-	rules, that online new memory sections as they appear. Coordinating
-	with such rules is out of scope of this utility, and the system
-	administrator is expected to remove them if they are undesirable.
-	If such an agent races to online memory sections, daxctl is prepared
-	to lose the race, and not fail the onlining operation as it only
-	cares that the memory section was onlined, not that it was the one
-	to do so.
-
 -f::
 --force::
 	When converting from "system-ram" mode to "devdax", it is expected
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

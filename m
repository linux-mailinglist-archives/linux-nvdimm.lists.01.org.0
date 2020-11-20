Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9542A2BB29D
	for <lists+linux-nvdimm@lfdr.de>; Fri, 20 Nov 2020 19:28:19 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E91CF100ED484;
	Fri, 20 Nov 2020 10:28:17 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AB7AB100ED483
	for <linux-nvdimm@lists.01.org>; Fri, 20 Nov 2020 10:28:15 -0800 (PST)
IronPort-SDR: tnZ7DIsrCDsXdtaseQnQqSq84dEOhGXZ4P6o6fwozvQcUlnJvSPknPDYsGQ795Knfk35B+eZgG
 O0iE0RF4eoPQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="150784486"
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400";
   d="scan'208";a="150784486"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 10:28:15 -0800
IronPort-SDR: Q3O3PelUozvsAwIsLFJYjoqAZ32eFUGMGUXFsA35UKca4UytL7TZE2ZjiqIY+zm6Ca0zAHCpU7
 zSy6CR7/Whsg==
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400";
   d="scan'208";a="369251032"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 10:28:14 -0800
Subject: [PATCH] libnvdimm/namespace: Fix reaping of invalidated
 block-window-namespace labels
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Fri, 20 Nov 2020 10:28:14 -0800
Message-ID: <160589689452.3253830.10997437402431159372.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: VEO4F46ROJ4OFQQ37CFZ7DEGID74JZTR
X-Message-ID-Hash: VEO4F46ROJ4OFQQ37CFZ7DEGID74JZTR
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: stable@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VEO4F46ROJ4OFQQ37CFZ7DEGID74JZTR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

A recent change to ndctl to attempt to reconfigure namespaces in place
uncovered a label accounting problem in block-window-type namespaces.
The ndctl "create.sh" test is able to trigger this signature:

 WARNING: CPU: 34 PID: 9167 at drivers/nvdimm/label.c:1100 __blk_label_update+0x9a3/0xbc0 [libnvdimm]
 [..]
 RIP: 0010:__blk_label_update+0x9a3/0xbc0 [libnvdimm]
 [..]
 Call Trace:
  uuid_store+0x21b/0x2f0 [libnvdimm]
  kernfs_fop_write+0xcf/0x1c0
  vfs_write+0xcc/0x380
  ksys_write+0x68/0xe0

When allocated capacity for a namespace is renamed (new UUID) the labels
with the old UUID need to be deleted. The ndctl behavior to always
destroy namespaces on reconfiguration hid this problem.

The immediate impact of this bug is limited since block-window-type
namespaces only seem to exist in the specification and not in any
shipping products. However, the label handling code is being reused for
other technologies like CXL region labels, so there is a benefit to
making sure both vertical labels sets (block-window) and horizontal
label sets (pmem) have a functional reference implementation in
libnvdimm.

Fixes: c4703ce11c23 ("libnvdimm/namespace: Fix label tracking error")
Cc: <stable@vger.kernel.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/label.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
index 47a4828b8b31..6f2be7a34598 100644
--- a/drivers/nvdimm/label.c
+++ b/drivers/nvdimm/label.c
@@ -980,6 +980,15 @@ static int __blk_label_update(struct nd_region *nd_region,
 		}
 	}
 
+	/* release slots associated with any invalidated UUIDs */
+	mutex_lock(&nd_mapping->lock);
+	list_for_each_entry_safe(label_ent, e, &nd_mapping->labels, list)
+		if (test_and_clear_bit(ND_LABEL_REAP, &label_ent->flags)) {
+			reap_victim(nd_mapping, label_ent);
+			list_move(&label_ent->list, &list);
+		}
+	mutex_unlock(&nd_mapping->lock);
+
 	/*
 	 * Find the resource associated with the first label in the set
 	 * per the v1.2 namespace specification.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

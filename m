Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22028320775
	for <lists+linux-nvdimm@lfdr.de>; Sat, 20 Feb 2021 22:57:02 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 49DD3100EC1EB;
	Sat, 20 Feb 2021 13:57:00 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9814D100EF275
	for <linux-nvdimm@lists.01.org>; Sat, 20 Feb 2021 13:56:57 -0800 (PST)
IronPort-SDR: 1VfPVEKpzDH6xq+TDxh7NCYIT2/4uXZnxw4dwq5F56r68PdZEU+BktNi3TlIXEBgNxrIkjOsNs
 X7v/GrRD6DRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9901"; a="203480424"
X-IronPort-AV: E=Sophos;i="5.81,193,1610438400";
   d="scan'208";a="203480424"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2021 13:56:56 -0800
IronPort-SDR: ikalQYO+NUG6LwPKxGUsVz2zehEYdZR8tpl7eBur99Bat7zOpmrK1Nv8jo4zm7iE2GYSTCnpYi
 Y1RHgj88+DOg==
X-IronPort-AV: E=Sophos;i="5.81,193,1610438400";
   d="scan'208";a="379397680"
Received: from aevangel-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.134.76])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2021 13:56:56 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: Dan Williams <dan.j.williams@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-nvdimm@lists.01.org
Subject: [PATCH] cxl/mem: Fixes to IOCTL interface
Date: Sat, 20 Feb 2021 13:56:41 -0800
Message-Id: <20210220215641.604535-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Message-ID-Hash: SLM35BIM5IDYTVKSJPNYX7FUOMRN234E
X-Message-ID-Hash: SLM35BIM5IDYTVKSJPNYX7FUOMRN234E
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alison Schofield <alison.schofield@intel.com>, Ben Widawsky <ben.widawsky@intel.com>, Al Viro <viro@zeniv.linux.org.uk>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SLM35BIM5IDYTVKSJPNYX7FUOMRN234E/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When submitting a command for userspace, input and output payload bounce
buffers are allocated. For a given command, both input and output
buffers may exist and so when allocation of the input buffer fails, the
output buffer must be freed. As far as I can tell, userspace can't
easily exploit the leak to OOM a machine unless the machine was already
near OOM state.

This bug was introduced in v5 of the patch and did not exist in prior
revisions.

While here, adjust the variable 'j' found in patch review by Konrad.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Reported-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com> (v2)
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/mem.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index df895bcca63a..626fd7066f4f 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -514,8 +514,10 @@ static int handle_mailbox_cmd_from_user(struct cxl_mem *cxlm,
 	if (cmd->info.size_in) {
 		mbox_cmd.payload_in = vmemdup_user(u64_to_user_ptr(in_payload),
 						   cmd->info.size_in);
-		if (IS_ERR(mbox_cmd.payload_in))
+		if (IS_ERR(mbox_cmd.payload_in)) {
+			kvfree(mbox_cmd.payload_out);
 			return PTR_ERR(mbox_cmd.payload_in);
+		}
 	}
 
 	rc = cxl_mem_mbox_get(cxlm);
@@ -696,7 +698,7 @@ static int cxl_query_cmd(struct cxl_memdev *cxlmd,
 	struct device *dev = &cxlmd->dev;
 	struct cxl_mem_command *cmd;
 	u32 n_commands;
-	int j = 0;
+	int cmds = 0;
 
 	dev_dbg(dev, "Query IOCTL\n");
 
@@ -714,10 +716,10 @@ static int cxl_query_cmd(struct cxl_memdev *cxlmd,
 	cxl_for_each_cmd(cmd) {
 		const struct cxl_command_info *info = &cmd->info;
 
-		if (copy_to_user(&q->commands[j++], info, sizeof(*info)))
+		if (copy_to_user(&q->commands[cmds++], info, sizeof(*info)))
 			return -EFAULT;
 
-		if (j == n_commands)
+		if (cmds == n_commands)
 			break;
 	}
 
-- 
2.30.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F968174953
	for <lists+linux-nvdimm@lfdr.de>; Sat, 29 Feb 2020 21:38:27 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9224B10FC3596;
	Sat, 29 Feb 2020 12:39:17 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2388D10FC341A
	for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 12:39:14 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:38:22 -0800
X-IronPort-AV: E=Sophos;i="5.70,501,1574150400";
   d="scan'208";a="262203525"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:38:22 -0800
Subject: [ndctl PATCH 25/36] ndctl/dimm: Rework iteration to drop unaligned
 pointers
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: vishal.l.verma@intel.com
Date: Sat, 29 Feb 2020 12:22:17 -0800
Message-ID: <158300773732.2141307.720285708132556948.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: PZIZ2HLJAINBJPNT3MPM7TXJXWRDLEIY
X-Message-ID-Hash: PZIZ2HLJAINBJPNT3MPM7TXJXWRDLEIY
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PZIZ2HLJAINBJPNT3MPM7TXJXWRDLEIY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Similar to ->get_firmware_status() introduce ->{get,set}_xfer() and
->{get,set}_offset() so that the iteration core can consult/update the
command data in place.

Link: https://github.com/pmem/ndctl/issues/131
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 ndctl/lib/libndctl.c |   60 ++++++++++++++++++++++++++++++++++++++++----------
 ndctl/lib/private.h  |    6 +++--
 2 files changed, 52 insertions(+), 14 deletions(-)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index 97fd98545440..a996bff66fb2 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -2523,6 +2523,36 @@ static u32 cmd_get_firmware_status(struct ndctl_cmd *cmd)
 	return -1U;
 }
 
+static void cmd_set_xfer(struct ndctl_cmd *cmd, u32 xfer)
+{
+	if (cmd->type == ND_CMD_GET_CONFIG_DATA)
+		cmd->get_data->in_length = xfer;
+	else
+		cmd->set_data->in_length = xfer;
+}
+
+static u32 cmd_get_xfer(struct ndctl_cmd *cmd)
+{
+	if (cmd->type == ND_CMD_GET_CONFIG_DATA)
+		return cmd->get_data->in_length;
+	return cmd->set_data->in_length;
+}
+
+static void cmd_set_offset(struct ndctl_cmd *cmd, u32 offset)
+{
+	if (cmd->type == ND_CMD_GET_CONFIG_DATA)
+		cmd->get_data->in_offset = offset;
+	else
+		cmd->set_data->in_offset = offset;
+}
+
+static u32 cmd_get_offset(struct ndctl_cmd *cmd)
+{
+	if (cmd->type == ND_CMD_GET_CONFIG_DATA)
+		return cmd->get_data->in_offset;
+	return cmd->set_data->in_offset;
+}
+
 NDCTL_EXPORT struct ndctl_cmd *ndctl_dimm_cmd_new_vendor_specific(
 		struct ndctl_dimm *dimm, unsigned int opcode, size_t input_size,
 		size_t output_size)
@@ -2659,9 +2689,11 @@ NDCTL_EXPORT struct ndctl_cmd *ndctl_dimm_cmd_new_cfg_read(struct ndctl_cmd *cfg
 	cmd->get_data->in_offset = 0;
 	cmd->get_data->in_length = cfg_size->get_size->max_xfer;
 	cmd->get_firmware_status = cmd_get_firmware_status;
+	cmd->get_xfer = cmd_get_xfer;
+	cmd->set_xfer = cmd_set_xfer;
+	cmd->get_offset = cmd_get_offset;
+	cmd->set_offset = cmd_set_offset;
 	cmd->iter.init_offset = 0;
-	cmd->iter.offset = &cmd->get_data->in_offset;
-	cmd->iter.xfer = &cmd->get_data->in_length;
 	cmd->iter.max_xfer = cfg_size->get_size->max_xfer;
 	cmd->iter.data = cmd->get_data->out_buf;
 	cmd->iter.total_xfer = cfg_size->get_size->config_size;
@@ -2680,9 +2712,11 @@ NDCTL_EXPORT struct ndctl_cmd *ndctl_dimm_cmd_new_cfg_read(struct ndctl_cmd *cfg
 static void iter_set_extent(struct ndctl_cmd_iter *iter, unsigned int len,
 		unsigned int offset)
 {
+	struct ndctl_cmd *cmd = container_of(iter, typeof(*cmd), iter);
+
 	iter->init_offset = offset;
-	*iter->offset = offset;
-	*iter->xfer = min(iter->max_xfer, len);
+	cmd->set_offset(cmd, offset);
+	cmd->set_xfer(cmd, min(cmd->get_xfer(cmd), len));
 	iter->total_xfer = len;
 }
 
@@ -2746,9 +2780,11 @@ NDCTL_EXPORT struct ndctl_cmd *ndctl_dimm_cmd_new_cfg_write(struct ndctl_cmd *cf
 	cmd->set_data->in_offset = cfg_read->iter.init_offset;
 	cmd->set_data->in_length = cfg_read->iter.max_xfer;
 	cmd->get_firmware_status = cmd_get_firmware_status;
+	cmd->get_xfer = cmd_get_xfer;
+	cmd->set_xfer = cmd_set_xfer;
+	cmd->get_offset = cmd_get_offset;
+	cmd->set_offset = cmd_set_offset;
 	cmd->iter.init_offset = cfg_read->iter.init_offset;
-	cmd->iter.offset = &cmd->set_data->in_offset;
-	cmd->iter.xfer = &cmd->set_data->in_length;
 	cmd->iter.max_xfer = cfg_read->iter.max_xfer;
 	cmd->iter.data = cmd->set_data->in_buf;
 	cmd->iter.total_xfer = cfg_read->iter.total_xfer;
@@ -2961,12 +2997,12 @@ static int do_cmd(int fd, int ioctl_cmd, struct ndctl_cmd *cmd)
 	}
 
 	for (offset = 0; offset < iter->total_xfer; offset += iter->max_xfer) {
-		*(cmd->iter.xfer) = min(iter->total_xfer - offset,
-				iter->max_xfer);
-		*(cmd->iter.offset) = offset;
+		cmd->set_xfer(cmd, min(iter->total_xfer - offset,
+				iter->max_xfer));
+		cmd->set_offset(cmd, offset);
 		if (iter->dir == WRITE)
 			memcpy(iter->data, iter->total_buf + offset,
-					*(cmd->iter.xfer));
+					cmd->get_xfer(cmd));
 		rc = ioctl(fd, ioctl_cmd, cmd->cmd_buf);
 		if (rc < 0) {
 			rc = -errno;
@@ -2975,9 +3011,9 @@ static int do_cmd(int fd, int ioctl_cmd, struct ndctl_cmd *cmd)
 
 		if (iter->dir == READ)
 			memcpy(iter->total_buf + offset, iter->data,
-					*(cmd->iter.xfer) - rc);
+					cmd->get_xfer(cmd) - rc);
 		if (cmd->get_firmware_status(cmd) || rc) {
-			rc = offset + *(cmd->iter.xfer) - rc;
+			rc = offset + cmd->get_xfer(cmd) - rc;
 			break;
 		}
 	}
diff --git a/ndctl/lib/private.h b/ndctl/lib/private.h
index 3c121bd00437..2e537f0a8649 100644
--- a/ndctl/lib/private.h
+++ b/ndctl/lib/private.h
@@ -252,10 +252,12 @@ struct ndctl_cmd {
 	int size;
 	int status;
 	u32 (*get_firmware_status)(struct ndctl_cmd *cmd);
+	u32 (*get_xfer)(struct ndctl_cmd *cmd);
+	u32 (*get_offset)(struct ndctl_cmd *cmd);
+	void (*set_xfer)(struct ndctl_cmd *cmd, u32 xfer);
+	void (*set_offset)(struct ndctl_cmd *cmd, u32 offset);
 	struct ndctl_cmd_iter {
 		u32 init_offset;
-		u32 *offset;
-		u32 *xfer; /* pointer to xfer length in cmd */
 		u8 *data; /* pointer to the data buffer location in cmd */
 		u32 max_xfer;
 		char *total_buf;
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

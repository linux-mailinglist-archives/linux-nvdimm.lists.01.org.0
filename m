Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC33E828A1
	for <lists+linux-nvdimm@lfdr.de>; Tue,  6 Aug 2019 02:23:30 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A7B6D2132996A;
	Mon,  5 Aug 2019 17:25:59 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.151; helo=mga17.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B118C21324661
 for <linux-nvdimm@lists.01.org>; Mon,  5 Aug 2019 17:25:58 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Aug 2019 17:23:28 -0700
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; d="scan'208";a="325474380"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Aug 2019 17:23:26 -0700
Subject: [ndctl PATCH v5 1/7] ndctl/dimm: Support small label reads/writes
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Mon, 05 Aug 2019 17:09:09 -0700
Message-ID: <156505014906.848599.409811181877888321.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156505014382.848599.16271067825582995055.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156505014382.848599.16271067825582995055.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

The initial ndctl label read/write implementation assumed that label
read / writes were relatively inexpensive, but that assumption is
invalid in practice. The process of reading a full label area can take
10s of seconds. Implement ndctl_cmd_cfg_{read,write}_set_extent() to
trim the label read/write commands to a range smaller than the full
label area.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 ndctl/lib/libndctl.c   |  107 +++++++++++++++++++++++++++++++++++++++++-------
 ndctl/lib/libndctl.sym |    6 +++
 ndctl/lib/private.h    |    1 
 ndctl/libndctl.h       |    4 ++
 4 files changed, 103 insertions(+), 15 deletions(-)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index 81e155171c8c..c1ecdd8c9c61 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -2582,6 +2582,7 @@ NDCTL_EXPORT struct ndctl_cmd *ndctl_dimm_cmd_new_cfg_read(struct ndctl_cmd *cfg
 	cmd->get_data->in_offset = 0;
 	cmd->get_data->in_length = cfg_size->get_size->max_xfer;
 	cmd->firmware_status = &cmd->get_data->status;
+	cmd->iter.init_offset = 0;
 	cmd->iter.offset = &cmd->get_data->in_offset;
 	cmd->iter.xfer = &cmd->get_data->in_length;
 	cmd->iter.max_xfer = cfg_size->get_size->max_xfer;
@@ -2593,10 +2594,43 @@ NDCTL_EXPORT struct ndctl_cmd *ndctl_dimm_cmd_new_cfg_read(struct ndctl_cmd *cfg
 		free(cmd);
 		return NULL;
 	}
+	cmd->source = cfg_size;
+	ndctl_cmd_ref(cfg_size);
 
 	return cmd;
 }
 
+static void iter_set_extent(struct ndctl_cmd_iter *iter, unsigned int len,
+		unsigned int offset)
+{
+	iter->init_offset = offset;
+	*iter->offset = offset;
+	*iter->xfer = min(iter->max_xfer, len);
+	iter->total_xfer = len;
+}
+
+NDCTL_EXPORT int ndctl_cmd_cfg_read_set_extent(struct ndctl_cmd *cfg_read,
+		unsigned int len, unsigned int offset)
+{
+	struct ndctl_ctx *ctx = ndctl_bus_get_ctx(cmd_to_bus(cfg_read));
+	struct ndctl_cmd *cfg_size = cfg_read->source;
+
+	if (cfg_read->type != ND_CMD_GET_CONFIG_DATA
+			|| cfg_read->status <= 0) {
+		dbg(ctx, "expected unsubmitted cfg_read command\n");
+		return -EINVAL;
+	}
+
+	if (offset + len > cfg_size->get_size->config_size) {
+		dbg(ctx, "read %d from %d exceeds %d\n", len, offset,
+				cfg_size->get_size->config_size);
+		return -EINVAL;
+	}
+
+	iter_set_extent(&cfg_read->iter, len, offset);
+	return 0;
+}
+
 NDCTL_EXPORT struct ndctl_cmd *ndctl_dimm_cmd_new_cfg_write(struct ndctl_cmd *cfg_read)
 {
 	struct ndctl_ctx *ctx = ndctl_bus_get_ctx(cmd_to_bus(cfg_read));
@@ -2632,10 +2666,11 @@ NDCTL_EXPORT struct ndctl_cmd *ndctl_dimm_cmd_new_cfg_write(struct ndctl_cmd *cf
 	cmd->type = ND_CMD_SET_CONFIG_DATA;
 	cmd->size = size;
 	cmd->status = 1;
-	cmd->set_data->in_offset = 0;
+	cmd->set_data->in_offset = cfg_read->iter.init_offset;
 	cmd->set_data->in_length = cfg_read->iter.max_xfer;
 	cmd->firmware_status = (u32 *) (cmd->cmd_buf
 		+ sizeof(struct nd_cmd_set_config_hdr) + cfg_read->iter.max_xfer);
+	cmd->iter.init_offset = cfg_read->iter.init_offset;
 	cmd->iter.offset = &cmd->set_data->in_offset;
 	cmd->iter.xfer = &cmd->set_data->in_length;
 	cmd->iter.max_xfer = cfg_read->iter.max_xfer;
@@ -2657,18 +2692,33 @@ NDCTL_EXPORT unsigned int ndctl_cmd_cfg_size_get_size(struct ndctl_cmd *cfg_size
 	return 0;
 }
 
+static ssize_t iter_access(struct ndctl_cmd_iter *iter, unsigned int len,
+		unsigned int offset)
+{
+	if (offset < iter->init_offset
+			|| offset > iter->init_offset + iter->total_xfer
+			|| len + offset < len)
+		return -EINVAL;
+	if (len + offset > iter->init_offset + iter->total_xfer)
+		len = iter->total_xfer - offset;
+	return len;
+}
+
 NDCTL_EXPORT ssize_t ndctl_cmd_cfg_read_get_data(struct ndctl_cmd *cfg_read,
-		void *buf, unsigned int len, unsigned int offset)
+		void *buf, unsigned int _len, unsigned int offset)
 {
+	struct ndctl_cmd_iter *iter;
+	ssize_t len;
+
 	if (cfg_read->type != ND_CMD_GET_CONFIG_DATA || cfg_read->status > 0)
 		return -EINVAL;
 	if (cfg_read->status < 0)
 		return cfg_read->status;
-	if (offset > cfg_read->iter.total_xfer || len + offset < len)
-		return -EINVAL;
-	if (len + offset > cfg_read->iter.total_xfer)
-		len = cfg_read->iter.total_xfer - offset;
-	memcpy(buf, cfg_read->iter.total_buf + offset, len);
+
+	iter = &cfg_read->iter;
+	len = iter_access(&cfg_read->iter, _len, offset);
+	if (len >= 0)
+		memcpy(buf, iter->total_buf + offset, len);
 	return len;
 }
 
@@ -2681,29 +2731,56 @@ NDCTL_EXPORT ssize_t ndctl_cmd_cfg_read_get_size(struct ndctl_cmd *cfg_read)
 	return cfg_read->iter.total_xfer;
 }
 
+NDCTL_EXPORT int ndctl_cmd_cfg_write_set_extent(struct ndctl_cmd *cfg_write,
+		unsigned int len, unsigned int offset)
+{
+	struct ndctl_ctx *ctx = ndctl_bus_get_ctx(cmd_to_bus(cfg_write));
+	struct ndctl_cmd *cfg_size, *cfg_read;
+
+	if (cfg_write->type != ND_CMD_SET_CONFIG_DATA
+			|| cfg_write->status <= 0) {
+		dbg(ctx, "expected unsubmitted cfg_write command\n");
+		return -EINVAL;
+	}
+
+	cfg_read = cfg_write->source;
+	cfg_size = cfg_read->source;
+
+	if (offset + len > cfg_size->get_size->config_size) {
+		dbg(ctx, "write %d from %d exceeds %d\n", len, offset,
+				cfg_size->get_size->config_size);
+		return -EINVAL;
+	}
+
+	iter_set_extent(&cfg_write->iter, len, offset);
+	return 0;
+}
+
 NDCTL_EXPORT ssize_t ndctl_cmd_cfg_write_set_data(struct ndctl_cmd *cfg_write,
-		void *buf, unsigned int len, unsigned int offset)
+		void *buf, unsigned int _len, unsigned int offset)
 {
+	ssize_t len;
+
 	if (cfg_write->type != ND_CMD_SET_CONFIG_DATA || cfg_write->status < 1)
 		return -EINVAL;
 	if (cfg_write->status < 0)
 		return cfg_write->status;
-	if (offset > cfg_write->iter.total_xfer || len + offset < len)
-		return -EINVAL;
-	if (len + offset > cfg_write->iter.total_xfer)
-		len = cfg_write->iter.total_xfer - offset;
-	memcpy(cfg_write->iter.total_buf + offset, buf, len);
+	len = iter_access(&cfg_write->iter, _len, offset);
+	if (len >= 0)
+		memcpy(cfg_write->iter.total_buf + offset, buf, len);
 	return len;
 }
 
 NDCTL_EXPORT ssize_t ndctl_cmd_cfg_write_zero_data(struct ndctl_cmd *cfg_write)
 {
+	struct ndctl_cmd_iter *iter = &cfg_write->iter;
+
 	if (cfg_write->type != ND_CMD_SET_CONFIG_DATA || cfg_write->status < 1)
 		return -EINVAL;
 	if (cfg_write->status < 0)
 		return cfg_write->status;
-	memset(cfg_write->iter.total_buf, 0, cfg_write->iter.total_xfer);
-	return cfg_write->iter.total_xfer;
+	memset(iter->total_buf + iter->init_offset, 0, iter->total_xfer);
+	return iter->total_xfer;
 }
 
 NDCTL_EXPORT void ndctl_cmd_unref(struct ndctl_cmd *cmd)
diff --git a/ndctl/lib/libndctl.sym b/ndctl/lib/libndctl.sym
index 297f03d7ae39..84359b97b793 100644
--- a/ndctl/lib/libndctl.sym
+++ b/ndctl/lib/libndctl.sym
@@ -410,3 +410,9 @@ LIBNDCTL_20 {
 global:
 	ndctl_bus_poll_scrub_completion;
 } LIBNDCTL_19;
+
+
+LIBNDCTL_21 {
+	ndctl_cmd_cfg_read_set_extent;
+	ndctl_cmd_cfg_write_set_extent;
+} LIBNDCTL_20;
diff --git a/ndctl/lib/private.h b/ndctl/lib/private.h
index 2ddc1d2c34f8..3fc0290ff6a7 100644
--- a/ndctl/lib/private.h
+++ b/ndctl/lib/private.h
@@ -254,6 +254,7 @@ struct ndctl_cmd {
 	int status;
 	u32 *firmware_status;
 	struct ndctl_cmd_iter {
+		u32 init_offset;
 		u32 *offset;
 		u32 *xfer; /* pointer to xfer length in cmd */
 		u8 *data; /* pointer to the data buffer location in cmd */
diff --git a/ndctl/libndctl.h b/ndctl/libndctl.h
index e378802ee4c1..310814fe924c 100644
--- a/ndctl/libndctl.h
+++ b/ndctl/libndctl.h
@@ -321,6 +321,10 @@ unsigned int ndctl_cmd_cfg_size_get_size(struct ndctl_cmd *cfg_size);
 ssize_t ndctl_cmd_cfg_read_get_data(struct ndctl_cmd *cfg_read, void *buf,
 		unsigned int len, unsigned int offset);
 ssize_t ndctl_cmd_cfg_read_get_size(struct ndctl_cmd *cfg_read);
+int ndctl_cmd_cfg_read_set_extent(struct ndctl_cmd *cfg_read,
+		unsigned int len, unsigned int offset);
+int ndctl_cmd_cfg_write_set_extent(struct ndctl_cmd *cfg_write,
+		unsigned int len, unsigned int offset);
 ssize_t ndctl_cmd_cfg_write_set_data(struct ndctl_cmd *cfg_write, void *buf,
 		unsigned int len, unsigned int offset);
 ssize_t ndctl_cmd_cfg_write_zero_data(struct ndctl_cmd *cfg_write);

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

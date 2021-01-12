Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A195F2F2422
	for <lists+linux-nvdimm@lfdr.de>; Tue, 12 Jan 2021 01:34:29 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4769C100EBB9E;
	Mon, 11 Jan 2021 16:34:28 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7638E100EB820
	for <linux-nvdimm@lists.01.org>; Mon, 11 Jan 2021 16:34:25 -0800 (PST)
IronPort-SDR: Y9bA2hEz9SbmVm8SvMtIu3ZsaDusbCsyz2T86PlzgYZnR2cuuu+WLcgyHmTFEDVQwLRcxc0crv
 iTm+9ojvY/5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="177185577"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400";
   d="scan'208";a="177185577"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 16:34:25 -0800
IronPort-SDR: DTgH3onCWBNNmuL4P0Y2H4ylW2IO4OBSEpoBsvh7papa74rKxEAXoxP0f/S09DQlX7l2jkAHKS
 uNAR5tkbZEyA==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400";
   d="scan'208";a="381212102"
Received: from ecbackus-mobl1.amr.corp.intel.com (HELO omniknight.intel.com) ([10.212.212.82])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 16:34:24 -0800
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-cxl@vger.kernel.org>
Subject: [ndctl RFC PATCH 4/5] libcxl: add accessors for retrieving 'Identify' information
Date: Mon, 11 Jan 2021 17:34:02 -0700
Message-Id: <20210112003403.2944568-5-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210112003403.2944568-1-vishal.l.verma@intel.com>
References: <20210112003403.2944568-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Message-ID-Hash: LAVQV2HSEDZS3CCUBEZ4VTDLXRTMSL4H
X-Message-ID-Hash: LAVQV2HSEDZS3CCUBEZ4VTDLXRTMSL4H
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Ben Widawsky <ben.widawsky@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LAVQV2HSEDZS3CCUBEZ4VTDLXRTMSL4H/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add APIs to access an incomplete list of fields from the 'Identify'
mailbox command. The fields added are fw_revision, partition_align, and
lsa_size.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 cxl/lib/private.h  | 19 +++++++++++++++++++
 cxl/lib/libcxl.c   | 44 ++++++++++++++++++++++++++++++++++++++++++++
 cxl/libcxl.h       |  3 +++
 cxl/lib/libcxl.sym |  3 +++
 4 files changed, 69 insertions(+)

diff --git a/cxl/lib/private.h b/cxl/lib/private.h
index c7ebfcb..19f3a37 100644
--- a/cxl/lib/private.h
+++ b/cxl/lib/private.h
@@ -60,6 +60,25 @@ struct cxl_cmd {
 	int status;
 };
 
+#define CXL_CMD_IDENTIFY_FW_REV_LENGTH 0x10
+
+struct cxl_cmd_identify {
+	char fw_revision[CXL_CMD_IDENTIFY_FW_REV_LENGTH];
+	le64 total_capacity;
+	le64 volatile_capacity;
+	le64 persistent_capacity;
+	le64 partition_align;
+	le16 info_event_log_size;
+	le16 warning_event_log_size;
+	le16 failure_event_log_size;
+	le16 fatal_event_log_size;
+	le32 lsa_size;
+	u8 poison_list_max_mer[3];
+	le16 inject_poison_limit;
+	u8 poison_caps;
+	u8 qos_telemetry_caps;
+} __packed;
+
 static inline int check_kmod(struct kmod_ctx *kmod_ctx)
 {
 	return kmod_ctx ? 0 : -ENXIO;
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 02bc316..d54da95 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -13,7 +13,10 @@
 #include <sys/sysmacros.h>
 #include <uuid/uuid.h>
 #include <ccan/list/list.h>
+#include <ccan/endian/endian.h>
+#include <ccan/minmax/minmax.h>
 #include <ccan/array_size/array_size.h>
+#include <ccan/short_types/short_types.h>
 
 #include <cxl_mem.h>
 #include <util/log.h>
@@ -624,6 +627,47 @@ CXL_EXPORT struct cxl_cmd *cxl_cmd_new_identify(struct cxl_memdev *memdev)
 	return cxl_cmd_new_generic(memdev, CXL_MEM_COMMAND_ID_IDENTIFY);
 }
 
+CXL_EXPORT int cxl_cmd_identify_get_fw_rev(struct cxl_cmd *cmd, char *fw_rev,
+		int fw_len)
+{
+	struct cxl_cmd_identify *id = (void *)cmd->send_cmd->out_payload;
+
+	if (cmd->send_cmd->id != CXL_MEM_COMMAND_ID_IDENTIFY)
+		return -EINVAL;
+	if (cmd->status < 0)
+		return cmd->status;
+
+	if (fw_len > 0)
+		memcpy(fw_rev, id->fw_revision,
+			min(fw_len, CXL_CMD_IDENTIFY_FW_REV_LENGTH));
+	return 0;
+}
+
+CXL_EXPORT unsigned long long cxl_cmd_identify_get_partition_align(
+		struct cxl_cmd *cmd)
+{
+	struct cxl_cmd_identify *id = (void *)cmd->send_cmd->out_payload;
+
+	if (cmd->send_cmd->id != CXL_MEM_COMMAND_ID_IDENTIFY)
+		return -EINVAL;
+	if (cmd->status < 0)
+		return cmd->status;
+
+	return le64_to_cpu(id->partition_align);
+}
+
+CXL_EXPORT unsigned int cxl_cmd_identify_get_lsa_size(struct cxl_cmd *cmd)
+{
+	struct cxl_cmd_identify *id = (void *)cmd->send_cmd->out_payload;
+
+	if (cmd->send_cmd->id != CXL_MEM_COMMAND_ID_IDENTIFY)
+		return -EINVAL;
+	if (cmd->status < 0)
+		return cmd->status;
+
+	return le32_to_cpu(id->lsa_size);
+}
+
 CXL_EXPORT struct cxl_cmd *cxl_cmd_new_raw(struct cxl_memdev *memdev)
 {
 	return cxl_cmd_new_generic(memdev, CXL_MEM_COMMAND_ID_RAW);
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 83888bc..caa2e76 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -55,6 +55,9 @@ int cxl_cmd_attach_payloads(struct cxl_cmd *cmd,
 void cxl_cmd_ref(struct cxl_cmd *cmd);
 void cxl_cmd_unref(struct cxl_cmd *cmd);
 int cxl_cmd_submit(struct cxl_cmd *cmd);
+int cxl_cmd_identify_get_fw_rev(struct cxl_cmd *cmd, char *fw_rev, int fw_len);
+unsigned long long cxl_cmd_identify_get_partition_align(struct cxl_cmd *cmd);
+unsigned int cxl_cmd_identify_get_lsa_size(struct cxl_cmd *cmd);
 
 #ifdef __cplusplus
 } /* extern "C" */
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 3583bab..41311d9 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -35,4 +35,7 @@ global:
 	cxl_cmd_ref;
 	cxl_cmd_unref;
 	cxl_cmd_submit;
+	cxl_cmd_identify_get_fw_rev;
+	cxl_cmd_identify_get_partition_align;
+	cxl_cmd_identify_get_lsa_size;
 } LIBCXL_2;
-- 
2.29.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

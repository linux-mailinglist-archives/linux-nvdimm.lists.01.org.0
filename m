Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6921731F3C5
	for <lists+linux-nvdimm@lfdr.de>; Fri, 19 Feb 2021 03:04:09 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 946C9100EAAFF;
	Thu, 18 Feb 2021 18:03:59 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5C271100F225C
	for <linux-nvdimm@lists.01.org>; Thu, 18 Feb 2021 18:03:54 -0800 (PST)
IronPort-SDR: DFrem6boY1sk1+7oB6t9SZstcwJ9ZcpbOR2hRwN26d90fTZyl3c6/Xe+tYFbmB9Df+6MYCJgGp
 CW/6JdPC2RLA==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="181151509"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400";
   d="scan'208";a="181151509"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 18:03:54 -0800
IronPort-SDR: yE4hbpsazOW2dDW3Kyx4/2Ey5+rOD+a6yEzkMov3VVFV+jzB5fM9nKj2pCIvYwsiCsjmRWtKBD
 SCPQBFjK6N/A==
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400";
   d="scan'208";a="513509666"
Received: from jnavar1-mobl4.amr.corp.intel.com (HELO omniknight.intel.com) ([10.213.167.18])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 18:03:53 -0800
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-cxl@vger.kernel.org>
Subject: [ndctl PATCH v2 08/13] libcxl: add GET_HEALTH_INFO mailbox command and accessors
Date: Thu, 18 Feb 2021 19:03:26 -0700
Message-Id: <20210219020331.725687-9-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210219020331.725687-1-vishal.l.verma@intel.com>
References: <20210219020331.725687-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Message-ID-Hash: L5CLLIM2ILRQV7HZ56647RBHFFNZTNVC
X-Message-ID-Hash: L5CLLIM2ILRQV7HZ56647RBHFFNZTNVC
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Ben Widawsky <ben.widawsky@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/L5CLLIM2ILRQV7HZ56647RBHFFNZTNVC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add libcxl APIs to create a new GET_HEALTH_INFO mailbox command, the
command output data structure (privately), and accessor APIs to return
the different fields in the health info output.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 cxl/lib/private.h  | 11 +++++++++
 cxl/lib/libcxl.c   | 61 ++++++++++++++++++++++++++++++++++++++++++++++
 cxl/libcxl.h       |  9 +++++++
 cxl/lib/libcxl.sym |  9 +++++++
 4 files changed, 90 insertions(+)

diff --git a/cxl/lib/private.h b/cxl/lib/private.h
index 3273f21..2232f4c 100644
--- a/cxl/lib/private.h
+++ b/cxl/lib/private.h
@@ -73,6 +73,17 @@ struct cxl_cmd_identify {
 	u8 qos_telemetry_caps;
 } __attribute__((packed));
 
+struct cxl_cmd_get_health_info {
+	u8 health_status;
+	u8 media_status;
+	u8 ext_status;
+	u8 life_used;
+	le16 temperature;
+	le32 dirty_shutdowns;
+	le32 volatile_errors;
+	le32 pmem_errors;
+} __attribute__((packed));
+
 static inline int check_kmod(struct kmod_ctx *kmod_ctx)
 {
 	return kmod_ctx ? 0 : -ENXIO;
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 4751cba..d595d36 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -678,6 +678,67 @@ CXL_EXPORT const char *cxl_cmd_get_devname(struct cxl_cmd *cmd)
 	return cxl_memdev_get_devname(cmd->memdev);
 }
 
+#define cmd_get_int(cmd, n, N, field) \
+do { \
+	struct cxl_cmd_##n *c = (void *)cmd->send_cmd->out.payload; \
+	if (cmd->send_cmd->id != CXL_MEM_COMMAND_ID_##N) \
+		return EINVAL; \
+	if (cmd->status < 0) \
+		return cmd->status; \
+	return le32_to_cpu(c->field); \
+} while(0);
+
+CXL_EXPORT struct cxl_cmd *cxl_cmd_new_get_health_info(
+		struct cxl_memdev *memdev)
+{
+	return cxl_cmd_new_generic(memdev, CXL_MEM_COMMAND_ID_GET_HEALTH_INFO);
+}
+
+#define cmd_health_get_int(c, f) \
+do { \
+	cmd_get_int(c, get_health_info, GET_HEALTH_INFO, f); \
+} while (0);
+
+CXL_EXPORT int cxl_cmd_get_health_info_get_health_status(struct cxl_cmd *cmd)
+{
+	cmd_health_get_int(cmd, health_status);
+}
+
+CXL_EXPORT int cxl_cmd_get_health_info_get_media_status(struct cxl_cmd *cmd)
+{
+	cmd_health_get_int(cmd, media_status);
+}
+
+CXL_EXPORT int cxl_cmd_get_health_info_get_ext_status(struct cxl_cmd *cmd)
+{
+	cmd_health_get_int(cmd, ext_status);
+}
+
+CXL_EXPORT int cxl_cmd_get_health_info_get_life_used(struct cxl_cmd *cmd)
+{
+	cmd_health_get_int(cmd, life_used);
+}
+
+CXL_EXPORT int cxl_cmd_get_health_info_get_temperature(struct cxl_cmd *cmd)
+{
+	cmd_health_get_int(cmd, temperature);
+}
+
+CXL_EXPORT int cxl_cmd_get_health_info_get_dirty_shutdowns(struct cxl_cmd *cmd)
+{
+	cmd_health_get_int(cmd, dirty_shutdowns);
+}
+
+CXL_EXPORT int cxl_cmd_get_health_info_get_volatile_errors(struct cxl_cmd *cmd)
+{
+	cmd_health_get_int(cmd, volatile_errors);
+}
+
+CXL_EXPORT int cxl_cmd_get_health_info_get_pmem_errors(struct cxl_cmd *cmd)
+{
+	cmd_health_get_int(cmd, pmem_errors);
+}
+
 CXL_EXPORT struct cxl_cmd *cxl_cmd_new_identify(struct cxl_memdev *memdev)
 {
 	return cxl_cmd_new_generic(memdev, CXL_MEM_COMMAND_ID_IDENTIFY);
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 9ed8c83..56ae4af 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -62,6 +62,15 @@ struct cxl_cmd *cxl_cmd_new_identify(struct cxl_memdev *memdev);
 int cxl_cmd_identify_get_fw_rev(struct cxl_cmd *cmd, char *fw_rev, int fw_len);
 unsigned long long cxl_cmd_identify_get_partition_align(struct cxl_cmd *cmd);
 unsigned int cxl_cmd_identify_get_lsa_size(struct cxl_cmd *cmd);
+struct cxl_cmd *cxl_cmd_new_get_health_info(struct cxl_memdev *memdev);
+int cxl_cmd_get_health_info_get_health_status(struct cxl_cmd *cmd);
+int cxl_cmd_get_health_info_get_media_status(struct cxl_cmd *cmd);
+int cxl_cmd_get_health_info_get_ext_status(struct cxl_cmd *cmd);
+int cxl_cmd_get_health_info_get_life_used(struct cxl_cmd *cmd);
+int cxl_cmd_get_health_info_get_temperature(struct cxl_cmd *cmd);
+int cxl_cmd_get_health_info_get_dirty_shutdowns(struct cxl_cmd *cmd);
+int cxl_cmd_get_health_info_get_volatile_errors(struct cxl_cmd *cmd);
+int cxl_cmd_get_health_info_get_pmem_errors(struct cxl_cmd *cmd);
 
 #ifdef __cplusplus
 } /* extern "C" */
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index d6aa0b2..e00443d 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -43,4 +43,13 @@ global:
 	cxl_cmd_identify_get_fw_rev;
 	cxl_cmd_identify_get_partition_align;
 	cxl_cmd_identify_get_lsa_size;
+	cxl_cmd_new_get_health_info;
+	cxl_cmd_get_health_info_get_health_status;
+	cxl_cmd_get_health_info_get_media_status;
+	cxl_cmd_get_health_info_get_ext_status;
+	cxl_cmd_get_health_info_get_life_used;
+	cxl_cmd_get_health_info_get_temperature;
+	cxl_cmd_get_health_info_get_dirty_shutdowns;
+	cxl_cmd_get_health_info_get_volatile_errors;
+	cxl_cmd_get_health_info_get_pmem_errors;
 } LIBCXL_2;
-- 
2.29.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

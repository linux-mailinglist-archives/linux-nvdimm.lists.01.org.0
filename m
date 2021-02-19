Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7197A31F3C6
	for <lists+linux-nvdimm@lfdr.de>; Fri, 19 Feb 2021 03:04:11 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BAFE3100EAB03;
	Thu, 18 Feb 2021 18:03:59 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 32D8D100F2276
	for <linux-nvdimm@lists.01.org>; Thu, 18 Feb 2021 18:03:55 -0800 (PST)
IronPort-SDR: kcp0dDVbWsxhXopCQzgHKLKfDH1Sptj6Fo1ohkzP75r6DQs8AN23RfbZy6CkrPypEZmnDiap6J
 9QB5qWmLD8sg==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="181151515"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400";
   d="scan'208";a="181151515"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 18:03:54 -0800
IronPort-SDR: kOoOP2zpdvVO3aqK0kJkDaT8nMMiPB6BLsgKEHSTYT0iHMmb5J1Sy+7/vvZZ28Qyo+qxFoBjmB
 3odPTbUeKcNw==
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400";
   d="scan'208";a="513509672"
Received: from jnavar1-mobl4.amr.corp.intel.com (HELO omniknight.intel.com) ([10.213.167.18])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 18:03:54 -0800
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-cxl@vger.kernel.org>
Subject: [ndctl PATCH v2 09/13] libcxl: add support for the 'GET_LSA' command
Date: Thu, 18 Feb 2021 19:03:27 -0700
Message-Id: <20210219020331.725687-10-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210219020331.725687-1-vishal.l.verma@intel.com>
References: <20210219020331.725687-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Message-ID-Hash: KXOUDIXKY4DY77I63DP2O5GSN4YSKMBP
X-Message-ID-Hash: KXOUDIXKY4DY77I63DP2O5GSN4YSKMBP
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Ben Widawsky <ben.widawsky@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KXOUDIXKY4DY77I63DP2O5GSN4YSKMBP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a command allocator and accessor APIs for the 'GET_LSA' mailbox
command.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 cxl/lib/private.h  |  5 +++++
 cxl/lib/libcxl.c   | 31 +++++++++++++++++++++++++++++++
 cxl/libcxl.h       |  3 +++
 cxl/lib/libcxl.sym |  2 ++
 4 files changed, 41 insertions(+)

diff --git a/cxl/lib/private.h b/cxl/lib/private.h
index 2232f4c..fb1dd8e 100644
--- a/cxl/lib/private.h
+++ b/cxl/lib/private.h
@@ -73,6 +73,11 @@ struct cxl_cmd_identify {
 	u8 qos_telemetry_caps;
 } __attribute__((packed));
 
+struct cxl_cmd_get_lsa_in {
+	le32 offset;
+	le32 length;
+} __attribute__((packed));
+
 struct cxl_cmd_get_health_info {
 	u8 health_status;
 	u8 media_status;
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index d595d36..2edb79e 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -804,6 +804,37 @@ CXL_EXPORT struct cxl_cmd *cxl_cmd_new_raw(struct cxl_memdev *memdev,
 	return cmd;
 }
 
+CXL_EXPORT struct cxl_cmd *cxl_cmd_new_get_lsa(struct cxl_memdev *memdev,
+		unsigned int offset, unsigned int length)
+{
+	struct cxl_cmd_get_lsa_in *get_lsa;
+	struct cxl_cmd *cmd;
+
+	cmd = cxl_cmd_new_generic(memdev, CXL_MEM_COMMAND_ID_GET_LSA);
+	if (!cmd)
+		return NULL;
+
+	get_lsa = (void *)cmd->send_cmd->in.payload;
+	get_lsa->offset = cpu_to_le32(offset);
+	get_lsa->length = cpu_to_le32(length);
+	return cmd;
+}
+
+#define cmd_get_void(cmd, N) \
+do { \
+	void *p = (void *)cmd->send_cmd->out.payload; \
+	if (cmd->send_cmd->id != CXL_MEM_COMMAND_ID_##N) \
+		return NULL; \
+	if (cmd->status < 0) \
+		return NULL; \
+	return p; \
+} while(0);
+
+CXL_EXPORT void *cxl_cmd_get_lsa_get_payload(struct cxl_cmd *cmd)
+{
+	cmd_get_void(cmd, GET_LSA);
+}
+
 CXL_EXPORT int cxl_cmd_submit(struct cxl_cmd *cmd)
 {
 	struct cxl_memdev *memdev = cmd->memdev;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 56ae4af..6edbd8d 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -71,6 +71,9 @@ int cxl_cmd_get_health_info_get_temperature(struct cxl_cmd *cmd);
 int cxl_cmd_get_health_info_get_dirty_shutdowns(struct cxl_cmd *cmd);
 int cxl_cmd_get_health_info_get_volatile_errors(struct cxl_cmd *cmd);
 int cxl_cmd_get_health_info_get_pmem_errors(struct cxl_cmd *cmd);
+struct cxl_cmd *cxl_cmd_new_get_lsa(struct cxl_memdev *memdev,
+		unsigned int offset, unsigned int length);
+void *cxl_cmd_get_lsa_get_payload(struct cxl_cmd *cmd);
 
 #ifdef __cplusplus
 } /* extern "C" */
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index e00443d..2c6193b 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -52,4 +52,6 @@ global:
 	cxl_cmd_get_health_info_get_dirty_shutdowns;
 	cxl_cmd_get_health_info_get_volatile_errors;
 	cxl_cmd_get_health_info_get_pmem_errors;
+	cxl_cmd_new_get_lsa;
+	cxl_cmd_get_lsa_get_payload;
 } LIBCXL_2;
-- 
2.29.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

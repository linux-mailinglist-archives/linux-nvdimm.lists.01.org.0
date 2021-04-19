Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB48936408E
	for <lists+linux-nvdimm@lfdr.de>; Mon, 19 Apr 2021 13:29:12 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 82D0E100EB839;
	Mon, 19 Apr 2021 04:29:11 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=209.85.214.180; helo=mail-pl1-f180.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1722F100EB838
	for <linux-nvdimm@lists.01.org>; Mon, 19 Apr 2021 04:29:09 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id u15so8962710plf.10
        for <linux-nvdimm@lists.01.org>; Mon, 19 Apr 2021 04:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2BnjbBxaWsdyVb9syIrgmIISJyliqSGiE2A8ive3aqQ=;
        b=jpo6eKEHXYPXQ/P9tY6+0bphWcKjVMVru0gXOj6endcvM6O21e/zaQEGiitosLP6wc
         CbQElQzja5o69sJTiRWxi/9FATlVrmnvmUuyevVp9jtIa5yiCK7HUQSYf21VKudMgs2J
         5ER3wmfIIwaN4/2oCPEZkYWAVNMtBm/6mUlse+W0rYG18PRJ+6RtrxHuR8Eb0pLFvPe0
         Se4cFO9Qkf+oqHQLlq0Fshs/j0HT9uirq5uk1yOquz2zxLrl9h/TV4aUkDZfmSkOBCp1
         StMCp9NDCZiDtm2YwuKt6WmsZ0W3RDZr0llDfSWqkkP8i0oJVQcrzqXalBGPfZ+ZQW0D
         Qk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2BnjbBxaWsdyVb9syIrgmIISJyliqSGiE2A8ive3aqQ=;
        b=qjw4S6Gn+4vbIHTQk6zCrj2CW3oByH/FyZJ2PEPLVSHCgzqzVtlNN+bBK6Q3zkgIBM
         EHxLfD2vr+dx94McRK89VjbdJYgGeyGj4tZc7NOfvYqqKvUevrEZ2GrJ1hmFY6OLXLLk
         TrOJ+epeq2qOTFleP0V8HsxT9RkXIluHlkpIBs7OupDD+zKfctkSjD709AoyCYL+IPt/
         fTiFQ+yPwLx4DRq/tcxpULv7WHnuXon1qRJZR7mgg+wLwz2TR5RDO+Ru+xMvq3PoLd+Y
         4r/kG/2ykvr1lonAIzao7OqQ2Qn1FliEJee+w6/De6qPmH7NELV/ionli3udWwFVmcbZ
         stPg==
X-Gm-Message-State: AOAM532qMR6MMKf4p2BnjLLbC/63k2fBXGmUkC1yJO2CbBDjPzm3KNqs
	vcS1ilu/Ei+K0X7xwnQ97LZ8LAnyXuW7FA==
X-Google-Smtp-Source: ABdhPJzrSLuZuYa8icm19KoirpAiKvbBuUdS43ST+rIE+7hfb4Jr7++GU4OOg709dTl9I/3V7UUWaQ==
X-Received: by 2002:a17:902:8c92:b029:e8:fa73:ad22 with SMTP id t18-20020a1709028c92b02900e8fa73ad22mr22165680plo.66.1618831688551;
        Mon, 19 Apr 2021 04:28:08 -0700 (PDT)
Received: from desktop.fossix.local ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id l3sm14276734pju.44.2021.04.19.04.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 04:28:08 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH 2/2] Error injection support for PAPR
Date: Mon, 19 Apr 2021 16:57:40 +0530
Message-Id: <20210419112740.695948-2-santosh@fossix.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210419112740.695948-1-santosh@fossix.org>
References: <20210419112740.695948-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: ANUK6HFLHX34ZG67YRNKSLLQ5ZUYO65K
X-Message-ID-Hash: ANUK6HFLHX34ZG67YRNKSLLQ5ZUYO65K
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Shivaprasad G Bhat <sbhat@linux.ibm.com>, Harish Sriram <harish@linux.ibm.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ANUK6HFLHX34ZG67YRNKSLLQ5ZUYO65K/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add support for error injection on PAPR family of devices. This is
particularly useful in running 'make check' on non-nfit platforms.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 ndctl/lib/libndctl.c  |   1 +
 ndctl/lib/papr.c      | 134 ++++++++++++++++++++++++++++++++++++++++++
 ndctl/lib/private.h   |   1 +
 ndctl/libndctl-papr.h |   7 +++
 4 files changed, 143 insertions(+)
 create mode 100644 ndctl/libndctl-papr.h

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index 2364578..2c2f485 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -904,6 +904,7 @@ static void *add_bus(void *parent, int id, const char *ctl_base)
 	else {
 		bus->has_of_node = 1;
 		bus_name = "papr";
+		bus->ops = papr_bus_ops;
 	}
 
 	sprintf(path, "%s/device/%s/dsm_mask", ctl_base, bus_name);
diff --git a/ndctl/lib/papr.c b/ndctl/lib/papr.c
index f94f8aa..6ac3d3e 100644
--- a/ndctl/lib/papr.c
+++ b/ndctl/lib/papr.c
@@ -12,6 +12,7 @@
 #include <util/log.h>
 #include <ndctl.h>
 #include <ndctl/libndctl.h>
+#include <ndctl/libndctl-papr.h>
 #include <lib/private.h>
 #include "papr.h"
 
@@ -38,6 +39,33 @@
 /* return the pdsm command */
 #define to_pdsm_cmd(C) ((enum papr_pdsm)to_ndcmd(C)->nd_command)
 
+/**
+ * ndctl_bus_is_papr_cmd_supported - check if command is supported on @bus.
+ * @bus: ndctl_bus instance
+ * @cmd: papr command number (defined as PAPR_PDSM_XXX in papr-pdsm.h)
+ *
+ * Return 1: command is supported. Return 0: command is not supported.
+ *
+ */
+NDCTL_EXPORT int ndctl_bus_is_papr_cmd_supported(struct ndctl_bus *bus,
+						 int cmd)
+{
+	return !!(bus->nfit_dsm_mask & (1ULL << cmd));
+}
+
+static int papr_is_errinj_supported(struct ndctl_bus *bus)
+{
+	if (!ndctl_bus_is_papr_scm(bus))
+		return 0;
+
+	if (ndctl_bus_is_papr_cmd_supported(bus, PAPR_PDSM_INJECT_SET) &&
+	    ndctl_bus_is_papr_cmd_supported(bus, PAPR_PDSM_INJECT_CLEAR) &&
+	    ndctl_bus_is_papr_cmd_supported(bus, PAPR_PDSM_INJECT_GET))
+		return 1;
+
+	return 0;
+}
+
 static bool papr_cmd_is_supported(struct ndctl_dimm *dimm, int cmd)
 {
 	/* Handle this separately to support monitor mode */
@@ -559,3 +587,109 @@ struct ndctl_dimm_ops * const papr_dimm_ops = &(struct ndctl_dimm_ops) {
 		= papr_cmd_smart_threshold_set_ctrl_temperature,
 	.smart_threshold_set_spares = papr_cmd_smart_threshold_set_spares,
 };
+
+static u32 bus_get_firmware_status(struct ndctl_cmd *cmd)
+{
+	struct nd_cmd_bus *cmd_bus = cmd->cmd_bus;
+
+	switch (cmd_bus->gen.nd_command) {
+	case PAPR_PDSM_INJECT_SET:
+		return cmd_bus->err_inj.status;
+	case PAPR_PDSM_INJECT_CLEAR:
+		return cmd_bus->err_inj_clr.status;
+	case PAPR_PDSM_INJECT_GET:
+		return cmd_bus->err_inj_stat.status;
+	}
+
+	return -1U;
+}
+
+static struct ndctl_cmd *papr_bus_cmd_new_err_inj(struct ndctl_bus *bus)
+{
+	size_t size, cmd_length;
+	struct nd_cmd_pkg *pkg;
+	struct ndctl_cmd *cmd;
+
+	cmd_length = sizeof(struct nd_cmd_ars_err_inj);
+	size = sizeof(*cmd) + sizeof(*pkg) + cmd_length;
+	cmd = calloc(1, size);
+	if (!cmd)
+		return NULL;
+
+	cmd->bus = bus;
+	ndctl_cmd_ref(cmd);
+	cmd->type = ND_CMD_CALL;
+	cmd->get_firmware_status = bus_get_firmware_status;
+	cmd->size = size;
+	cmd->status = 1;
+	pkg = (struct nd_cmd_pkg *)&cmd->cmd_buf[0];
+	pkg->nd_command = PAPR_PDSM_INJECT_SET;
+	pkg->nd_size_in = offsetof(struct nd_cmd_ars_err_inj, status);
+	pkg->nd_size_out = cmd_length - pkg->nd_size_in;
+	pkg->nd_fw_size = pkg->nd_size_out;
+
+	return cmd;
+}
+
+static struct ndctl_cmd *papr_bus_cmd_new_err_inj_clr(struct ndctl_bus *bus)
+{
+	size_t size, cmd_length;
+	struct nd_cmd_pkg *pkg;
+	struct ndctl_cmd *cmd;
+
+	cmd_length = sizeof(struct nd_cmd_ars_err_inj_clr);
+	size = sizeof(*cmd) + sizeof(*pkg) + cmd_length;
+	cmd = calloc(1, size);
+	if (!cmd)
+		return NULL;
+
+	cmd->bus = bus;
+	ndctl_cmd_ref(cmd);
+	cmd->type = ND_CMD_CALL;
+	cmd->get_firmware_status = bus_get_firmware_status;
+	cmd->size = size;
+	cmd->status = 1;
+	pkg = (struct nd_cmd_pkg *)&cmd->cmd_buf[0];
+	pkg->nd_command = PAPR_PDSM_INJECT_CLEAR;
+	pkg->nd_size_in = offsetof(struct nd_cmd_ars_err_inj_clr, status);
+	pkg->nd_size_out = cmd_length - pkg->nd_size_in;
+	pkg->nd_fw_size = pkg->nd_size_out;
+
+	return cmd;
+}
+
+static struct ndctl_cmd *papr_bus_cmd_new_err_inj_stat(struct ndctl_bus *bus,
+						u32 buf_size)
+{
+	size_t size, cmd_length;
+	struct nd_cmd_pkg *pkg;
+	struct ndctl_cmd *cmd;
+
+
+	cmd_length = sizeof(struct nd_cmd_ars_err_inj_stat);
+	size = sizeof(*cmd) + sizeof(*pkg) + cmd_length + buf_size;
+	cmd = calloc(1, size);
+	if (!cmd)
+		return NULL;
+
+	cmd->bus = bus;
+	ndctl_cmd_ref(cmd);
+	cmd->type = ND_CMD_CALL;
+	cmd->get_firmware_status = bus_get_firmware_status;
+	cmd->size = size;
+	cmd->status = 1;
+	pkg = (struct nd_cmd_pkg *)&cmd->cmd_buf[0];
+	pkg->nd_command = PAPR_PDSM_INJECT_GET;
+	pkg->nd_size_in = 0;
+	pkg->nd_size_out = cmd_length + buf_size;
+	pkg->nd_fw_size = pkg->nd_size_out;
+
+	return cmd;
+}
+
+struct ndctl_bus_ops *const papr_bus_ops = &(struct ndctl_bus_ops) {
+	.new_err_inj = papr_bus_cmd_new_err_inj,
+	.new_err_inj_clr = papr_bus_cmd_new_err_inj_clr,
+	.new_err_inj_stat = papr_bus_cmd_new_err_inj_stat,
+	.err_inj_supported = papr_is_errinj_supported,
+};
diff --git a/ndctl/lib/private.h b/ndctl/lib/private.h
index 0f36c67..96d890b 100644
--- a/ndctl/lib/private.h
+++ b/ndctl/lib/private.h
@@ -383,6 +383,7 @@ struct ndctl_bus_ops {
 };
 
 extern struct ndctl_bus_ops * const nfit_bus_ops;
+extern struct ndctl_bus_ops * const papr_bus_ops;
 
 struct ndctl_cmd *ndctl_bus_cmd_new_err_inj(struct ndctl_bus *bus);
 struct ndctl_cmd *ndctl_bus_cmd_new_err_inj_clr(struct ndctl_bus *bus);
diff --git a/ndctl/libndctl-papr.h b/ndctl/libndctl-papr.h
new file mode 100644
index 0000000..1658d8e
--- /dev/null
+++ b/ndctl/libndctl-papr.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: LGPL-2.1 */
+
+#ifndef __LIBNDCTL_PAPR_H__
+#define __LIBNDCTL_PAPR_H__
+
+int ndctl_bus_is_papr_cmd_supported(struct ndctl_bus *bus, int cmd);
+#endif
-- 
2.30.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

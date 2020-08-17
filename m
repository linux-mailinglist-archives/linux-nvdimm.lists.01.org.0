Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6E1245BC5
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Aug 2020 06:56:39 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 51875132B37A7;
	Sun, 16 Aug 2020 21:56:36 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1043; helo=mail-pj1-x1043.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5943F132B37A7
	for <linux-nvdimm@lists.01.org>; Sun, 16 Aug 2020 21:56:33 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id d4so7110038pjx.5
        for <linux-nvdimm@lists.01.org>; Sun, 16 Aug 2020 21:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TgKVTLr73vnJtidXc0n1q0VqQ4qGs2oqE+jHLQmFGT4=;
        b=auBUNj7STABTb8mIc60gTmFFDKnSqb3k8UqIpuulX7cf4+9HB1zpuEqo37I+d99Lxh
         8FNAmWPXDWwQ8pJee+/Nl6RX0ZoTefX4JzhMFanAktQ2zJrRfTRUsdNH2/7Ra8dnOJj/
         7e3lnluHNdDPzQuwceaw5I0NfnCPDXF00qJNDnog+GOpmW0i8FB0uMFFH6oH0657GRbM
         sfD5VuKjH1yg5OUKr28nWdW8qxugTzwQPYwSOeiDtBBR8ZwGKmLkHU+kxQM15dHS31Jw
         NIXk5PWngnQq6ONIieHACl/rj/RVHapQWM0xXkcVxmcVYhDm0KgIriX7f8zrbEndkHeH
         WkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TgKVTLr73vnJtidXc0n1q0VqQ4qGs2oqE+jHLQmFGT4=;
        b=b4x/5BJzePGFczHw2jWo2iKQXS9v5nzioifSIkkSeNl4Db975XsYMSkgFGavM57dIq
         cjVkBRJHhmYbQbbuCaPAj7+i+BuI8F4RflJw187EOo/CWe3Ohr+LYosHCsQaXQ582fGl
         3fOceUwWuxtBZNt8yRkcC/I/iaWGP9z/PvJ2+jaC2F6uQvORtw9SsNugJlwYFo8ZRVy2
         uwleGASlGMSHyrzl8Vg1dxMNtLUgdNkJG3oIRzKnTzgq9g1OdZjOieJ1OUOAyq3Yew5J
         rWsCDvCfx1mOlZVlLMhgU5fQAk2IzSSBoRzczFSrBIw8WvekRDu4aqeQ9529BOAF6+tg
         HxBA==
X-Gm-Message-State: AOAM530NJcO6yKkUkxysow0q1+d+qayT16R+fQ53amoDDOKnnIBlRKX0
	ak+3HMCFtR6ryZfjsCFDh+/fEBCS+ou/oQ==
X-Google-Smtp-Source: ABdhPJzajB5RvEOa7nvbpn0TXfPg3hhA3N9XtVfS7XEjpMmg2DL0Ko4DabQ4viSgwIX6AA39xUFQnQ==
X-Received: by 2002:a17:90a:f48d:: with SMTP id bx13mr11358723pjb.78.1597640192278;
        Sun, 16 Aug 2020 21:56:32 -0700 (PDT)
Received: from santosiv.in.ibm.com.com ([2401:4900:16ef:a7f1:9aa9:b61c:f8c8:81b2])
        by smtp.gmail.com with ESMTPSA id g9sm17849714pfr.172.2020.08.16.21.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 21:56:31 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>
Subject: [PATCH] Don't treat DSM commands as NFIT specific
Date: Mon, 17 Aug 2020 10:25:45 +0530
Message-Id: <20200817045545.906856-1-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Message-ID-Hash: 2LIHB5LLXG725537GOX6PFHAXVLN75I6
X-Message-ID-Hash: 2LIHB5LLXG725537GOX6PFHAXVLN75I6
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2LIHB5LLXG725537GOX6PFHAXVLN75I6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The DSM commands are treated exclusively as NFIT commands, remove NFIT
dependency on using DSM commands.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 ndctl/lib/inject.c     |  6 +++---
 ndctl/lib/libndctl.c   | 29 ++++++++++++++++++++++-------
 ndctl/lib/libndctl.sym |  4 ++++
 ndctl/lib/nfit.c       | 35 +++++++++--------------------------
 ndctl/lib/private.h    |  2 +-
 ndctl/libndctl-nfit.h  |  8 --------
 ndctl/libndctl.h       |  9 +++++++++
 7 files changed, 48 insertions(+), 45 deletions(-)

diff --git a/ndctl/lib/inject.c b/ndctl/lib/inject.c
index 815f254..ab0bee5 100644
--- a/ndctl/lib/inject.c
+++ b/ndctl/lib/inject.c
@@ -26,9 +26,9 @@ NDCTL_EXPORT int ndctl_bus_has_error_injection(struct ndctl_bus *bus)
 	if (!bus || !ndctl_bus_has_nfit(bus))
 		return 0;
 
-	if (ndctl_bus_is_nfit_cmd_supported(bus, NFIT_CMD_ARS_INJECT_SET) &&
-		ndctl_bus_is_nfit_cmd_supported(bus, NFIT_CMD_ARS_INJECT_GET) &&
-		ndctl_bus_is_nfit_cmd_supported(bus, NFIT_CMD_ARS_INJECT_CLEAR))
+	if (ndctl_bus_is_dsm_supported(bus, DSM_CMD_ARS_INJECT_SET) &&
+		ndctl_bus_is_dsm_supported(bus, DSM_CMD_ARS_INJECT_GET) &&
+		ndctl_bus_is_dsm_supported(bus, DSM_CMD_ARS_INJECT_CLEAR))
 		return 1;
 
 	return 0;
diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index 952192c..410fd16 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -884,12 +884,6 @@ static void *add_bus(void *parent, int id, const char *ctl_base)
 	else
 		bus->has_of_node = 1;
 
-	sprintf(path, "%s/device/nfit/dsm_mask", ctl_base);
-	if (sysfs_read_attr(ctx, path, buf) < 0)
-		bus->nfit_dsm_mask = 0;
-	else
-		bus->nfit_dsm_mask = strtoul(buf, NULL, 0);
-
 	sprintf(path, "%s/device/provider", ctl_base);
 	if (sysfs_read_attr(ctx, path, buf) < 0)
 		goto err_read;
@@ -898,12 +892,20 @@ static void *add_bus(void *parent, int id, const char *ctl_base)
 	if (!bus->provider)
 		goto err_read;
 
+	sprintf(path, "%s/device/%s/dsm_mask", ctl_base,
+		ndctl_bus_has_nfit(bus) ? "nfit" : bus->provider);
+	if (sysfs_read_attr(ctx, path, buf) < 0)
+		bus->dsm_mask = 0;
+	else
+		bus->dsm_mask = strtoul(buf, NULL, 0);
+
 	sprintf(path, "%s/device/wait_probe", ctl_base);
 	bus->wait_probe_path = strdup(path);
 	if (!bus->wait_probe_path)
 		goto err_read;
 
-	sprintf(path, "%s/device/nfit/scrub", ctl_base);
+	sprintf(path, "%s/device/%s/scrub", ctl_base,
+		ndctl_bus_has_nfit(bus) ? "nfit" : bus->provider);
 	bus->scrub_path = strdup(path);
 	if (!bus->scrub_path)
 		goto err_read;
@@ -1236,6 +1238,19 @@ NDCTL_EXPORT int ndctl_bus_is_cmd_supported(struct ndctl_bus *bus,
 	return !!(bus->cmd_mask & (1ULL << cmd));
 }
 
+/**
+ * ndctl_bus_is_cmd_supported - ask if command is supported on @bus.
+ * @bus: ndctl_bus instance
+ * @cmd: command number (defined as NFIT_CMD_XXX in libndctl-nfit.h)
+ *
+ * Return 1: command is supported. Return 0: command is not supported.
+ *
+ */
+NDCTL_EXPORT int ndctl_bus_is_dsm_supported(struct ndctl_bus *bus, int cmd)
+{
+	return !!(bus->dsm_mask & (1ULL << cmd));
+}
+
 NDCTL_EXPORT unsigned int ndctl_bus_get_revision(struct ndctl_bus *bus)
 {
 	return bus->revision;
diff --git a/ndctl/lib/libndctl.sym b/ndctl/lib/libndctl.sym
index 7ba1dcc..640342c 100644
--- a/ndctl/lib/libndctl.sym
+++ b/ndctl/lib/libndctl.sym
@@ -437,3 +437,7 @@ LIBNDCTL_24 {
 	ndctl_bus_is_papr_scm;
 	ndctl_region_has_numa;
 } LIBNDCTL_23;
+
+LIBNDCTL_25 {
+	ndctl_bus_is_dsm_supported;
+} LIBNDCTL_24;
diff --git a/ndctl/lib/nfit.c b/ndctl/lib/nfit.c
index f9fbe73..be252e0 100644
--- a/ndctl/lib/nfit.c
+++ b/ndctl/lib/nfit.c
@@ -20,39 +20,22 @@ static u32 bus_get_firmware_status(struct ndctl_cmd *cmd)
 	struct nd_cmd_bus *cmd_bus = cmd->cmd_bus;
 
 	switch (cmd_bus->gen.nd_command) {
-	case NFIT_CMD_TRANSLATE_SPA:
+	case DSM_CMD_TRANSLATE_SPA:
 		return cmd_bus->xlat_spa.status;
-	case NFIT_CMD_ARS_INJECT_SET:
+	case DSM_CMD_ARS_INJECT_SET:
 		return cmd_bus->err_inj.status;
-	case NFIT_CMD_ARS_INJECT_CLEAR:
+	case DSM_CMD_ARS_INJECT_CLEAR:
 		return cmd_bus->err_inj_clr.status;
-	case NFIT_CMD_ARS_INJECT_GET:
+	case DSM_CMD_ARS_INJECT_GET:
 		return cmd_bus->err_inj_stat.status;
 	}
 
 	return -1U;
 }
 
-/**
- * ndctl_bus_is_nfit_cmd_supported - ask nfit command is supported on @bus.
- * @bus: ndctl_bus instance
- * @cmd: nfit command number (defined as NFIT_CMD_XXX in libndctl-nfit.h)
- *
- * Return 1: command is supported. Return 0: command is not supported.
- *
- */
-NDCTL_EXPORT int ndctl_bus_is_nfit_cmd_supported(struct ndctl_bus *bus,
-                int cmd)
-{
-        return !!(bus->nfit_dsm_mask & (1ULL << cmd));
-}
-
 static int bus_has_translate_spa(struct ndctl_bus *bus)
 {
-	if (!ndctl_bus_has_nfit(bus))
-		return 0;
-
-	return ndctl_bus_is_nfit_cmd_supported(bus, NFIT_CMD_TRANSLATE_SPA);
+	return ndctl_bus_is_dsm_supported(bus, DSM_CMD_TRANSLATE_SPA);
 }
 
 static struct ndctl_cmd *ndctl_bus_cmd_new_translate_spa(struct ndctl_bus *bus)
@@ -76,7 +59,7 @@ static struct ndctl_cmd *ndctl_bus_cmd_new_translate_spa(struct ndctl_bus *bus)
 	cmd->size = size;
 	cmd->status = 1;
 	pkg = &cmd->cmd_bus->gen;
-	pkg->nd_command = NFIT_CMD_TRANSLATE_SPA;
+	pkg->nd_command = DSM_CMD_TRANSLATE_SPA;
 	pkg->nd_size_in = sizeof(unsigned long long);
 	pkg->nd_size_out = spa_length;
 	pkg->nd_fw_size = spa_length;
@@ -181,7 +164,7 @@ struct ndctl_cmd *ndctl_bus_cmd_new_err_inj(struct ndctl_bus *bus)
 	cmd->size = size;
 	cmd->status = 1;
 	pkg = (struct nd_cmd_pkg *)&cmd->cmd_buf[0];
-	pkg->nd_command = NFIT_CMD_ARS_INJECT_SET;
+	pkg->nd_command = DSM_CMD_ARS_INJECT_SET;
 	pkg->nd_size_in = offsetof(struct nd_cmd_ars_err_inj, status);
 	pkg->nd_size_out = cmd_length - pkg->nd_size_in;
 	pkg->nd_fw_size = pkg->nd_size_out;
@@ -208,7 +191,7 @@ struct ndctl_cmd *ndctl_bus_cmd_new_err_inj_clr(struct ndctl_bus *bus)
 	cmd->size = size;
 	cmd->status = 1;
 	pkg = (struct nd_cmd_pkg *)&cmd->cmd_buf[0];
-	pkg->nd_command = NFIT_CMD_ARS_INJECT_CLEAR;
+	pkg->nd_command = DSM_CMD_ARS_INJECT_CLEAR;
 	pkg->nd_size_in = offsetof(struct nd_cmd_ars_err_inj_clr, status);
 	pkg->nd_size_out = cmd_length - pkg->nd_size_in;
 	pkg->nd_fw_size = pkg->nd_size_out;
@@ -237,7 +220,7 @@ struct ndctl_cmd *ndctl_bus_cmd_new_err_inj_stat(struct ndctl_bus *bus,
 	cmd->size = size;
 	cmd->status = 1;
 	pkg = (struct nd_cmd_pkg *)&cmd->cmd_buf[0];
-	pkg->nd_command = NFIT_CMD_ARS_INJECT_GET;
+	pkg->nd_command = DSM_CMD_ARS_INJECT_GET;
 	pkg->nd_size_in = 0;
 	pkg->nd_size_out = cmd_length + buf_size;
 	pkg->nd_fw_size = pkg->nd_size_out;
diff --git a/ndctl/lib/private.h b/ndctl/lib/private.h
index c3d5fd7..a498542 100644
--- a/ndctl/lib/private.h
+++ b/ndctl/lib/private.h
@@ -175,7 +175,7 @@ struct ndctl_bus {
 	char *wait_probe_path;
 	char *scrub_path;
 	unsigned long cmd_mask;
-	unsigned long nfit_dsm_mask;
+	unsigned long dsm_mask;
 };
 
 /**
diff --git a/ndctl/libndctl-nfit.h b/ndctl/libndctl-nfit.h
index 8c4f72d..9c91d4a 100644
--- a/ndctl/libndctl-nfit.h
+++ b/ndctl/libndctl-nfit.h
@@ -23,14 +23,6 @@
  * libndctl-nfit.h : definitions for NFIT related commands/functions.
  */
 
-/* nfit command numbers which are called via ND_CMD_CALL */
-enum {
-	NFIT_CMD_TRANSLATE_SPA = 5,
-	NFIT_CMD_ARS_INJECT_SET = 7,
-	NFIT_CMD_ARS_INJECT_CLEAR = 8,
-	NFIT_CMD_ARS_INJECT_GET = 9,
-};
-
 /* error number of Translate SPA by firmware  */
 #define ND_TRANSLATE_SPA_STATUS_INVALID_SPA  2
 
diff --git a/ndctl/libndctl.h b/ndctl/libndctl.h
index dd21e2e..6390b2a 100644
--- a/ndctl/libndctl.h
+++ b/ndctl/libndctl.h
@@ -128,6 +128,7 @@ struct ndctl_bus *ndctl_bus_get_by_provider(struct ndctl_ctx *ctx,
 		const char *provider);
 const char *ndctl_bus_get_cmd_name(struct ndctl_bus *bus, int cmd);
 int ndctl_bus_is_cmd_supported(struct ndctl_bus *bus, int cmd);
+int ndctl_bus_is_dsm_supported(struct ndctl_bus *bus, int cmd);
 unsigned int ndctl_bus_get_revision(struct ndctl_bus *bus);
 unsigned int ndctl_bus_get_id(struct ndctl_bus *bus);
 const char *ndctl_bus_get_provider(struct ndctl_bus *bus);
@@ -740,6 +741,14 @@ int ndctl_dimm_master_secure_erase(struct ndctl_dimm *dimm, long key);
 #define NUMA_NO_NODE    (-1)
 #define NUMA_NO_ATTR    (-2)
 
+/* DSM numbers which are called via ND_CMD_CALL */
+enum {
+	DSM_CMD_TRANSLATE_SPA = 5,
+	DSM_CMD_ARS_INJECT_SET = 7,
+	DSM_CMD_ARS_INJECT_CLEAR = 8,
+	DSM_CMD_ARS_INJECT_GET = 9,
+};
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C84B382746
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 May 2021 10:43:30 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0859E100EB842;
	Mon, 17 May 2021 01:43:29 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 48AF1100EB83B
	for <linux-nvdimm@lists.01.org>; Mon, 17 May 2021 01:43:27 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id t4so2735460plc.6
        for <linux-nvdimm@lists.01.org>; Mon, 17 May 2021 01:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kVwRMqQfblsMi5FXrIvIdYptbC2Xvo3wnAjgGviHaI4=;
        b=vkQ/mJ/5dJNW9o8dw9bB3LGdJ9xbw3Qfqf23ygo71vuB+mj4C/DUdgK+w0YtW3Nt9b
         ebdTm9tepv64paMHhwscGWpOmImIrpM8kK4aAWjBpxhJG3dm9wMGAp42vIvZsTnJPR+c
         42mv10pNM/+R1x6dRaWSKoJcJZufJwb/akSheXh8FXWw4cINXhJVzcR/c9SfLtpXcnoj
         P5ORxmwc/+nqqnvu+dvHNjE/TuyJPW3jXuULYeJ9EClGAgKlm3IhSTinOKn80SZmFI7q
         3AacLgOvRxHWuIYOpPNz3Xxig+NBv+BgJxZbSJ2MKM7+DuqVF4Mi+Jq42QOL1Eyu5hsi
         lq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kVwRMqQfblsMi5FXrIvIdYptbC2Xvo3wnAjgGviHaI4=;
        b=jJUGoUykWq8feV0b4DkEGAM53LohsWzX8E3zBK1MykFYPZ3Ze4vVfGNPB/usUnpBO8
         Py9Lc4X/NzjGiTtNW6CDEfe+C61guFW+B2YaRw8my9rfu4SQEU9j+koQOs0LljclSvXz
         Spa9Rvuz1+50dVWhcuLJyqi3gwT/sDqlHTdkxm06rMC3KKJlNxjjq0q+A2XmBSJWH0rI
         1fdsUivA35ZpdAd19VLAIfHDb9CfEgQ9huG7xzGatPBstn1YDSShr2ogcSi43dH8NHmS
         +3uZu1tziiQIlABvJPTXFFW6+Bow66IgtZmcagl3gVYU1ce83m1KMpJT/jIfijBRJE7e
         36EA==
X-Gm-Message-State: AOAM531Y5tvTOWSnL0SNUT+KneJHFUWUd90XWg0Ig3zxoMm9j/gYKzC0
	h25kzTidUJhtevDmJ6AqvJNtcx0l10nYtg==
X-Google-Smtp-Source: ABdhPJzcFQIXF8+V3JUktvAp3iJYsePcTa7yjLrCp1ctPpRBIBhHVj/H65Yz6uY5WfxLhsBJuac6bw==
X-Received: by 2002:a17:90a:ca8d:: with SMTP id y13mr25416763pjt.40.1621241006625;
        Mon, 17 May 2021 01:43:26 -0700 (PDT)
Received: from desktop.fossix.local ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id z24sm2715254pfk.150.2021.05.17.01.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 01:43:26 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>
Subject: [ndctl v2 3/4] inject-error: Remove assumptions on error injection support
Date: Mon, 17 May 2021 14:12:58 +0530
Message-Id: <20210517084259.181236-3-santosh@fossix.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517084259.181236-1-santosh@fossix.org>
References: <20210517084259.181236-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: I4RZCYPUJBDOE2RVQQVFGCVXRGJBD7XB
X-Message-ID-Hash: I4RZCYPUJBDOE2RVQQVFGCVXRGJBD7XB
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Shivaprasad G Bhat <sbhat@linux.ibm.com>, Harish Sriram <harish@linux.ibm.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/I4RZCYPUJBDOE2RVQQVFGCVXRGJBD7XB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Currently the code assumes that only nfit supports error injection,
remove those assumptions before error injection support for PAPR is
added. Add bus operations similar to that of DIMM operations with
injection operations in it.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 ndctl/lib/inject.c   | 96 ++++++++++++++++++++------------------------
 ndctl/lib/libndctl.c | 11 +++--
 ndctl/lib/nfit.c     | 20 +++++++++
 ndctl/lib/private.h  | 14 +++++++
 4 files changed, 85 insertions(+), 56 deletions(-)

diff --git a/ndctl/lib/inject.c b/ndctl/lib/inject.c
index d61c02c..35fd11e 100644
--- a/ndctl/lib/inject.c
+++ b/ndctl/lib/inject.c
@@ -6,19 +6,15 @@
 #include <util/size.h>
 #include <ndctl/libndctl.h>
 #include <ccan/list/list.h>
-#include <ndctl/libndctl-nfit.h>
 #include <ccan/short_types/short_types.h>
 #include "private.h"
 
 NDCTL_EXPORT int ndctl_bus_has_error_injection(struct ndctl_bus *bus)
 {
-	/* Currently, only nfit buses have error injection */
-	if (!bus || !ndctl_bus_has_nfit(bus))
+	if (!bus)
 		return 0;
 
-	if (ndctl_bus_is_nfit_cmd_supported(bus, NFIT_CMD_ARS_INJECT_SET) &&
-		ndctl_bus_is_nfit_cmd_supported(bus, NFIT_CMD_ARS_INJECT_GET) &&
-		ndctl_bus_is_nfit_cmd_supported(bus, NFIT_CMD_ARS_INJECT_CLEAR))
+	if (bus->ops->err_inj_supported(bus))
 		return 1;
 
 	return 0;
@@ -151,7 +147,7 @@ static int ndctl_namespace_inject_one_error(struct ndctl_namespace *ndns,
 			length = clear_unit;
 	}
 
-	cmd = ndctl_bus_cmd_new_err_inj(bus);
+	cmd = bus->ops->new_err_inj(bus);
 	if (!cmd)
 		return -ENOMEM;
 
@@ -185,8 +181,6 @@ NDCTL_EXPORT int ndctl_namespace_inject_error2(struct ndctl_namespace *ndns,
 
 	if (!ndctl_bus_has_error_injection(bus))
 		return -EOPNOTSUPP;
-	if (!ndctl_bus_has_nfit(bus))
-		return -EOPNOTSUPP;
 
 	for (i = 0; i < count; i++) {
 		rc = ndctl_namespace_inject_one_error(ndns, block + i, flags);
@@ -231,7 +225,7 @@ static int ndctl_namespace_uninject_one_error(struct ndctl_namespace *ndns,
 			length = clear_unit;
 	}
 
-	cmd = ndctl_bus_cmd_new_err_inj_clr(bus);
+	cmd = bus->ops->new_err_inj_clr(bus);
 	if (!cmd)
 		return -ENOMEM;
 
@@ -263,8 +257,6 @@ NDCTL_EXPORT int ndctl_namespace_uninject_error2(struct ndctl_namespace *ndns,
 
 	if (!ndctl_bus_has_error_injection(bus))
 		return -EOPNOTSUPP;
-	if (!ndctl_bus_has_nfit(bus))
-		return -EOPNOTSUPP;
 
 	for (i = 0; i < count; i++) {
 		rc = ndctl_namespace_uninject_one_error(ndns, block + i,
@@ -445,51 +437,49 @@ NDCTL_EXPORT int ndctl_namespace_injection_status(struct ndctl_namespace *ndns)
 	if (!ndctl_bus_has_error_injection(bus))
 		return -EOPNOTSUPP;
 
-	if (ndctl_bus_has_nfit(bus)) {
-		rc = ndctl_namespace_get_injection_bounds(ndns, &ns_offset,
-			&ns_size);
-		if (rc)
-			return rc;
+	rc = ndctl_namespace_get_injection_bounds(ndns, &ns_offset,
+						  &ns_size);
+	if (rc)
+		return rc;
 
-		cmd = ndctl_bus_cmd_new_ars_cap(bus, ns_offset, ns_size);
-		if (!cmd) {
-			err(ctx, "%s: failed to create cmd\n",
-				ndctl_namespace_get_devname(ndns));
-			return -ENOTTY;
-		}
-		rc = ndctl_cmd_submit(cmd);
-		if (rc < 0) {
-			dbg(ctx, "Error submitting ars_cap: %d\n", rc);
-			goto out;
-		}
-		buf_size = ndctl_cmd_ars_cap_get_size(cmd);
-		if (buf_size == 0) {
-			dbg(ctx, "Got an invalid max_ars_out from ars_cap\n");
-			rc = -EINVAL;
-			goto out;
-		}
-		ndctl_cmd_unref(cmd);
+	cmd = ndctl_bus_cmd_new_ars_cap(bus, ns_offset, ns_size);
+	if (!cmd) {
+		err(ctx, "%s: failed to create cmd\n",
+		    ndctl_namespace_get_devname(ndns));
+		return -ENOTTY;
+	}
+	rc = ndctl_cmd_submit(cmd);
+	if (rc < 0) {
+		dbg(ctx, "Error submitting ars_cap: %d\n", rc);
+		goto out;
+	}
+	buf_size = ndctl_cmd_ars_cap_get_size(cmd);
+	if (buf_size == 0) {
+		dbg(ctx, "Got an invalid max_ars_out from ars_cap\n");
+		rc = -EINVAL;
+		goto out;
+	}
+	ndctl_cmd_unref(cmd);
 
-		cmd = ndctl_bus_cmd_new_err_inj_stat(bus, buf_size);
-		if (!cmd)
-			return -ENOMEM;
+	cmd = bus->ops->new_err_inj_stat(bus, buf_size);
+	if (!cmd)
+		return -ENOMEM;
 
-		pkg = (struct nd_cmd_pkg *)&cmd->cmd_buf[0];
-		err_inj_stat =
-			(struct nd_cmd_ars_err_inj_stat *)&pkg->nd_payload[0];
+	pkg = (struct nd_cmd_pkg *)&cmd->cmd_buf[0];
+	err_inj_stat =
+		(struct nd_cmd_ars_err_inj_stat *)&pkg->nd_payload[0];
 
-		rc = ndctl_cmd_submit(cmd);
-		if (rc < 0) {
-			dbg(ctx, "Error submitting command: %d\n", rc);
-			goto out;
-		}
-		rc = injection_status_to_bb(ndns, err_inj_stat,
-			ns_offset, ns_size);
-		if (rc) {
-			dbg(ctx, "Error converting status to badblocks: %d\n",
-				rc);
-			goto out;
-		}
+	rc = ndctl_cmd_submit(cmd);
+	if (rc < 0) {
+		dbg(ctx, "Error submitting command: %d\n", rc);
+		goto out;
+	}
+	rc = injection_status_to_bb(ndns, err_inj_stat,
+				    ns_offset, ns_size);
+	if (rc) {
+		dbg(ctx, "Error converting status to badblocks: %d\n",
+		    rc);
+		goto out;
 	}
 
  out:
diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index a148438..232c531 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -864,6 +864,7 @@ static void *add_bus(void *parent, int id, const char *ctl_base)
 	struct ndctl_ctx *ctx = parent;
 	struct ndctl_bus *bus, *bus_dup;
 	char *path = calloc(1, strlen(ctl_base) + 100);
+	char *bus_name;
 
 	if (!path)
 		return NULL;
@@ -893,15 +894,19 @@ static void *add_bus(void *parent, int id, const char *ctl_base)
 	} else {
 		bus->has_nfit = 1;
 		bus->revision = strtoul(buf, NULL, 0);
+		bus_name = "nfit";
+		bus->ops = nfit_bus_ops;
 	}
 
 	sprintf(path, "%s/device/of_node/compatible", ctl_base);
 	if (sysfs_read_attr(ctx, path, buf) < 0)
 		bus->has_of_node = 0;
-	else
+	else {
 		bus->has_of_node = 1;
+		bus_name = "papr";
+	}
 
-	sprintf(path, "%s/device/nfit/dsm_mask", ctl_base);
+	sprintf(path, "%s/device/%s/dsm_mask", ctl_base, bus_name);
 	if (sysfs_read_attr(ctx, path, buf) < 0)
 		bus->nfit_dsm_mask = 0;
 	else
@@ -920,7 +925,7 @@ static void *add_bus(void *parent, int id, const char *ctl_base)
 	if (!bus->wait_probe_path)
 		goto err_read;
 
-	sprintf(path, "%s/device/nfit/scrub", ctl_base);
+	sprintf(path, "%s/device/%s/scrub", ctl_base, bus_name);
 	bus->scrub_path = strdup(path);
 	if (!bus->scrub_path)
 		goto err_read;
diff --git a/ndctl/lib/nfit.c b/ndctl/lib/nfit.c
index d85682f..a37e50e 100644
--- a/ndctl/lib/nfit.c
+++ b/ndctl/lib/nfit.c
@@ -5,6 +5,19 @@
 #include "private.h"
 #include <ndctl/libndctl-nfit.h>
 
+static int nfit_is_errinj_supported(struct ndctl_bus *bus)
+{
+	if (!ndctl_bus_has_nfit(bus))
+		return 0;
+
+	if (ndctl_bus_is_nfit_cmd_supported(bus, NFIT_CMD_ARS_INJECT_SET) &&
+	    ndctl_bus_is_nfit_cmd_supported(bus, NFIT_CMD_ARS_INJECT_GET) &&
+	    ndctl_bus_is_nfit_cmd_supported(bus, NFIT_CMD_ARS_INJECT_CLEAR))
+		return 1;
+
+	return 0;
+}
+
 static u32 bus_get_firmware_status(struct ndctl_cmd *cmd)
 {
 	struct nd_cmd_bus *cmd_bus = cmd->cmd_bus;
@@ -234,3 +247,10 @@ struct ndctl_cmd *ndctl_bus_cmd_new_err_inj_stat(struct ndctl_bus *bus,
 
 	return cmd;
 }
+
+struct ndctl_bus_ops *const nfit_bus_ops = &(struct ndctl_bus_ops) {
+	.new_err_inj = ndctl_bus_cmd_new_err_inj,
+	.new_err_inj_clr = ndctl_bus_cmd_new_err_inj_clr,
+	.new_err_inj_stat = ndctl_bus_cmd_new_err_inj_stat,
+	.err_inj_supported = nfit_is_errinj_supported,
+};
diff --git a/ndctl/lib/private.h b/ndctl/lib/private.h
index 53fae0f..0f36c67 100644
--- a/ndctl/lib/private.h
+++ b/ndctl/lib/private.h
@@ -157,6 +157,7 @@ struct ndctl_bus {
 	struct list_head dimms;
 	struct list_head regions;
 	struct list_node list;
+	struct ndctl_bus_ops *ops;
 	int dimms_init;
 	int regions_init;
 	int has_nfit;
@@ -370,6 +371,19 @@ static inline int check_kmod(struct kmod_ctx *kmod_ctx)
 	return kmod_ctx ? 0 : -ENXIO;
 }
 
+int ndctl_bus_nfit_translate_spa(struct ndctl_bus *bus, unsigned long long addr,
+		unsigned int *handle, unsigned long long *dpa);
+
+struct ndctl_bus_ops {
+	int (*err_inj_supported)(struct ndctl_bus *bus);
+	struct ndctl_cmd *(*new_err_inj)(struct ndctl_bus *bus);
+	struct ndctl_cmd *(*new_err_inj_clr)(struct ndctl_bus *bus);
+	struct ndctl_cmd *(*new_err_inj_stat)(struct ndctl_bus *bus,
+					      u32 buf_len);
+};
+
+extern struct ndctl_bus_ops * const nfit_bus_ops;
+
 struct ndctl_cmd *ndctl_bus_cmd_new_err_inj(struct ndctl_bus *bus);
 struct ndctl_cmd *ndctl_bus_cmd_new_err_inj_clr(struct ndctl_bus *bus);
 struct ndctl_cmd *ndctl_bus_cmd_new_err_inj_stat(struct ndctl_bus *bus,
-- 
2.31.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

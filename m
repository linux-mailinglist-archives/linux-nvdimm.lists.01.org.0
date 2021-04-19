Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C36BD36408D
	for <lists+linux-nvdimm@lfdr.de>; Mon, 19 Apr 2021 13:29:00 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6130F100EB827;
	Mon, 19 Apr 2021 04:28:59 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=209.85.215.171; helo=mail-pg1-f171.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 82AC2100EB827
	for <linux-nvdimm@lists.01.org>; Mon, 19 Apr 2021 04:28:56 -0700 (PDT)
Received: by mail-pg1-f171.google.com with SMTP id s22so2933822pgk.6
        for <linux-nvdimm@lists.01.org>; Mon, 19 Apr 2021 04:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4RLmXRwmW+T6DAZQTMhxFE36+Gnct/DGOxLZ/JG/pfM=;
        b=q86XDDVWIYjyGG2BrE6hl3fkB+dYpdiTZEdUGf+n7TG7kZcMT69K/WR1pbB0VBIywc
         y4qHMkmeLivlUuE/Ax0PeOZJ7DPcPy4b+pyfYI7rMjCKNP6myqxdEXc/gEPQ58UKbbNS
         WOJu/VnuCO21DWgODeoGyb+VumZLYFIINFDmjWmz8QaRDf8H2MtnQPqNTd0lXswywslL
         51GToMBK3GiniMUysY4lRcB814B+TDJiuX1BP53TFm0eRjDJiN/EYWf9vxkKNjFaomV6
         zwGCzw+mIqHGAEIjRHHt7VFkZu9mv20dbYvHm9BQlJ0D1LscCXlha7ayWi3ZUEjYwoRU
         qNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4RLmXRwmW+T6DAZQTMhxFE36+Gnct/DGOxLZ/JG/pfM=;
        b=I4PdrlOucRjNRJSqNAuUZVfojFssg7fVWBtIUVqH7FmJFALTQR3jlBdTOwHm//llnD
         yfc3sQCdngWikIfsutvIbrgxAkWFWGTB3Wqf0E/R/1D/nsc+7Ie2krEOKjJ0kU8sNv88
         sZBh7l30z0fTYRjKXdsPsNu8I2tjKMOc6bp0jKkMU5gUrJo55VWvuPMHlT4xjBHvXPmO
         qPP+pB0DsWXSrVcHKcQzhZ5fZfSGpjbhpJzQ3XksXDfo7FbXei9/fbeQzZkuvvWrsuAq
         9Ib3i+yjOW2GGXmFFqYX6u0Y6IdyH4Xc3pe6vn+69UaitSXsyQrNtAPZrzcv7ieHMgAV
         tXPg==
X-Gm-Message-State: AOAM533VGpEzWnDPJrpRKA9x219h8CmzX3NlV2EdkWVWqhw6Y984iX+T
	LXtnRs9w0fUMvHGvpTinwM7XjdI1REqnUQ==
X-Google-Smtp-Source: ABdhPJzqiCfKnCmCyl/FC5Wf7u6+cy2/FAnHt4PDw6PrEmKA/ghD5fr2Wv8Kz/StemxlgEKwIlqH3w==
X-Received: by 2002:a63:7c53:: with SMTP id l19mr11102392pgn.96.1618831675763;
        Mon, 19 Apr 2021 04:27:55 -0700 (PDT)
Received: from desktop.fossix.local ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id l3sm14276734pju.44.2021.04.19.04.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 04:27:55 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH 1/2] inject-error: Remove assumptions on error injection support
Date: Mon, 19 Apr 2021 16:57:39 +0530
Message-Id: <20210419112740.695948-1-santosh@fossix.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Message-ID-Hash: HZPYW3EJSOMQ7CICDS3AOBBSVSFFEJ5H
X-Message-ID-Hash: HZPYW3EJSOMQ7CICDS3AOBBSVSFFEJ5H
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Shivaprasad G Bhat <sbhat@linux.ibm.com>, Harish Sriram <harish@linux.ibm.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HZPYW3EJSOMQ7CICDS3AOBBSVSFFEJ5H/>
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
This patch series is on top of Shiva's SMART test patches for PAPR[1].

[1]: https://lkml.kernel.org/r/161711738576.593.320964839920955692.stgit@9add658da52e

 ndctl/lib/inject.c   | 96 ++++++++++++++++++++------------------------
 ndctl/lib/libndctl.c | 11 +++--
 ndctl/lib/nfit.c     | 20 +++++++++
 ndctl/lib/private.h  | 12 ++++++
 4 files changed, 83 insertions(+), 56 deletions(-)

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
index 78e993a..2364578 100644
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
index 6f68fcf..8ad0056 100644
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
index c4a943d..0f36c67 100644
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
@@ -372,6 +373,17 @@ static inline int check_kmod(struct kmod_ctx *kmod_ctx)
 
 int ndctl_bus_nfit_translate_spa(struct ndctl_bus *bus, unsigned long long addr,
 		unsigned int *handle, unsigned long long *dpa);
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
2.30.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

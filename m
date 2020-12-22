Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B04202E0559
	for <lists+linux-nvdimm@lfdr.de>; Tue, 22 Dec 2020 05:25:35 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D97CB100EBB63;
	Mon, 21 Dec 2020 20:25:33 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 463E5100EBBDB
	for <linux-nvdimm@lists.01.org>; Mon, 21 Dec 2020 20:25:32 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id j1so6781774pld.3
        for <linux-nvdimm@lists.01.org>; Mon, 21 Dec 2020 20:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QrT0//FOQGYcrCSNZT5D5cD7tPEwG+7cOGTSWL9COig=;
        b=inrh0UdU+3gKyoD2FpMW+xvFYU9bGNfyZ1rnDFLvBDSbsskbWFhxPPxBw4HDtD92oW
         q4zZG/Wx0kJGdwKjey7usMUIYNqbFAEtdv7vKDyslktsK7n3bRXE0taD02z4DW4hayFf
         3iqIfOdThD8vng4awhly+Twnt7JHp+i7d7IV23R99JaSaOL1XpnmVxGhOBDkO5xP8Yrf
         jN7kYB/UgunlzoQlTgdmZrqxR1265IRReTJC/o5FAS6ikY82oVYNOSLLRo5mGYZIW21w
         hUSt6jUQdecNg/skUvXvRPbPeOLWAp3cOtSP55P8HvtNIlrD6maTBVtjvvREd2ZASIrf
         YvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QrT0//FOQGYcrCSNZT5D5cD7tPEwG+7cOGTSWL9COig=;
        b=lUDmzDupU7l4/EPe0pOUhubr2cqQg2dzU0Jxxp1xSg/yREZCX4YYylCWHQrPLMjTEb
         U9pjekqhehErkFCELLvQUj83RFNzME5BbdlbCpBcNKGAy1e/Ptn/LEInYw654rfqkU4+
         lPbzCc8nKqMDw6aQbTbjjVnvWlzihDvPLX4DUSa8ib8ltebHm2DxLO2ZK1pYDl1QUAQe
         DJ/U76Zrj8zDHOjEho+mBWNGbusONU2Ekz3j6cDL3p8O2g6GSOXzpmQAJAO4kRM4lWsm
         5BR/0XJn7jExWWrjhgwgtXfGQzt31klL5s3s/tZXaPOQw2TUEzZNedNYKs5EkHm0ysSj
         Ghig==
X-Gm-Message-State: AOAM531tEGcHoWuiNVP4Gvf9SpFGYpKs2TeNO1cEX2MmO9v6z+0r5/JG
	OVabJ/55XTZ5GrlQcA/mwFbFiFFQB2q42w==
X-Google-Smtp-Source: ABdhPJwxyW1zTT5p1ZLeVhCCVr6+eTPWyznoy0Ugd2DD1R0Au3KcAm5JFUBkxs4xD+Aq9KB5BhtQZg==
X-Received: by 2002:a17:90a:1bc7:: with SMTP id r7mr20913199pjr.33.1608611131482;
        Mon, 21 Dec 2020 20:25:31 -0800 (PST)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id z13sm17765992pjt.45.2020.12.21.20.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 20:25:31 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [ndctl 1/5] libndctl: test enablement for non-nfit devices
Date: Tue, 22 Dec 2020 09:55:12 +0530
Message-Id: <20201222042516.2984348-1-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201222042240.2983755-1-santosh@fossix.org>
References: <20201222042240.2983755-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: EXZBKAAE4HFDY2GCK2X22MMWR3DAYIK3
X-Message-ID-Hash: EXZBKAAE4HFDY2GCK2X22MMWR3DAYIK3
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EXZBKAAE4HFDY2GCK2X22MMWR3DAYIK3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Unify adding dimms for papr and nfit families, this will help in adding
all attributes needed for the unit tests too. We don't fail adding a dimm
if some of the dimm attributes are missing, so this will work fine on PAPR
platforms where most dimm attributes are provided.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 ndctl/lib/libndctl.c | 103 ++++++++++++++++---------------------------
 1 file changed, 38 insertions(+), 65 deletions(-)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index ad521d3..5f09628 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -1655,41 +1655,9 @@ static int ndctl_bind(struct ndctl_ctx *ctx, struct kmod_module *module,
 static int ndctl_unbind(struct ndctl_ctx *ctx, const char *devpath);
 static struct kmod_module *to_module(struct ndctl_ctx *ctx, const char *alias);
 
-static int add_papr_dimm(struct ndctl_dimm *dimm, const char *dimm_base)
-{
-	int rc = -ENODEV;
-	char buf[SYSFS_ATTR_SIZE];
-	struct ndctl_ctx *ctx = dimm->bus->ctx;
-	char *path = calloc(1, strlen(dimm_base) + 100);
-	const char * const devname = ndctl_dimm_get_devname(dimm);
-
-	dbg(ctx, "%s: Probing of_pmem dimm at %s\n", devname, dimm_base);
-
-	if (!path)
-		return -ENOMEM;
-
-	/* construct path to the papr compatible dimm flags file */
-	sprintf(path, "%s/papr/flags", dimm_base);
-
-	if (ndctl_bus_is_papr_scm(dimm->bus) &&
-	    sysfs_read_attr(ctx, path, buf) == 0) {
-
-		dbg(ctx, "%s: Adding papr-scm dimm flags:\"%s\"\n", devname, buf);
-		dimm->cmd_family = NVDIMM_FAMILY_PAPR;
-
-		/* Parse dimm flags */
-		parse_papr_flags(dimm, buf);
-
-		/* Allocate monitor mode fd */
-		dimm->health_eventfd = open(path, O_RDONLY|O_CLOEXEC);
-		rc = 0;
-	}
-
-	free(path);
-	return rc;
-}
-
-static int add_nfit_dimm(struct ndctl_dimm *dimm, const char *dimm_base)
+static int populate_dimm_attributes(struct ndctl_dimm *dimm,
+				    const char *dimm_base,
+				    const char *bus_prefix)
 {
 	int i, rc = -1;
 	char buf[SYSFS_ATTR_SIZE];
@@ -1703,7 +1671,7 @@ static int add_nfit_dimm(struct ndctl_dimm *dimm, const char *dimm_base)
 	 * 'unique_id' may not be available on older kernels, so don't
 	 * fail if the read fails.
 	 */
-	sprintf(path, "%s/nfit/id", dimm_base);
+	sprintf(path, "%s/%s/id", dimm_base, bus_prefix);
 	if (sysfs_read_attr(ctx, path, buf) == 0) {
 		unsigned int b[9];
 
@@ -1718,68 +1686,74 @@ static int add_nfit_dimm(struct ndctl_dimm *dimm, const char *dimm_base)
 		}
 	}
 
-	sprintf(path, "%s/nfit/handle", dimm_base);
+	sprintf(path, "%s/%s/handle", dimm_base, bus_prefix);
 	if (sysfs_read_attr(ctx, path, buf) < 0)
 		goto err_read;
 	dimm->handle = strtoul(buf, NULL, 0);
 
-	sprintf(path, "%s/nfit/phys_id", dimm_base);
+	sprintf(path, "%s/%s/phys_id", dimm_base, bus_prefix);
 	if (sysfs_read_attr(ctx, path, buf) < 0)
 		goto err_read;
 	dimm->phys_id = strtoul(buf, NULL, 0);
 
-	sprintf(path, "%s/nfit/serial", dimm_base);
+	sprintf(path, "%s/%s/serial", dimm_base, bus_prefix);
 	if (sysfs_read_attr(ctx, path, buf) == 0)
 		dimm->serial = strtoul(buf, NULL, 0);
 
-	sprintf(path, "%s/nfit/vendor", dimm_base);
+	sprintf(path, "%s/%s/vendor", dimm_base, bus_prefix);
 	if (sysfs_read_attr(ctx, path, buf) == 0)
 		dimm->vendor_id = strtoul(buf, NULL, 0);
 
-	sprintf(path, "%s/nfit/device", dimm_base);
+	sprintf(path, "%s/%s/device", dimm_base, bus_prefix);
 	if (sysfs_read_attr(ctx, path, buf) == 0)
 		dimm->device_id = strtoul(buf, NULL, 0);
 
-	sprintf(path, "%s/nfit/rev_id", dimm_base);
+	sprintf(path, "%s/%s/rev_id", dimm_base, bus_prefix);
 	if (sysfs_read_attr(ctx, path, buf) == 0)
 		dimm->revision_id = strtoul(buf, NULL, 0);
 
-	sprintf(path, "%s/nfit/dirty_shutdown", dimm_base);
+	sprintf(path, "%s/%s/dirty_shutdown", dimm_base, bus_prefix);
 	if (sysfs_read_attr(ctx, path, buf) == 0)
 		dimm->dirty_shutdown = strtoll(buf, NULL, 0);
 
-	sprintf(path, "%s/nfit/subsystem_vendor", dimm_base);
+	sprintf(path, "%s/%s/subsystem_vendor", dimm_base, bus_prefix);
 	if (sysfs_read_attr(ctx, path, buf) == 0)
 		dimm->subsystem_vendor_id = strtoul(buf, NULL, 0);
 
-	sprintf(path, "%s/nfit/subsystem_device", dimm_base);
+	sprintf(path, "%s/%s/subsystem_device", dimm_base, bus_prefix);
 	if (sysfs_read_attr(ctx, path, buf) == 0)
 		dimm->subsystem_device_id = strtoul(buf, NULL, 0);
 
-	sprintf(path, "%s/nfit/subsystem_rev_id", dimm_base);
+	sprintf(path, "%s/%s/subsystem_rev_id", dimm_base, bus_prefix);
 	if (sysfs_read_attr(ctx, path, buf) == 0)
 		dimm->subsystem_revision_id = strtoul(buf, NULL, 0);
 
-	sprintf(path, "%s/nfit/family", dimm_base);
+	sprintf(path, "%s/%s/family", dimm_base, bus_prefix);
 	if (sysfs_read_attr(ctx, path, buf) == 0)
 		dimm->cmd_family = strtoul(buf, NULL, 0);
 
-	sprintf(path, "%s/nfit/dsm_mask", dimm_base);
+	sprintf(path, "%s/%s/dsm_mask", dimm_base, bus_prefix);
 	if (sysfs_read_attr(ctx, path, buf) == 0)
 		dimm->nfit_dsm_mask = strtoul(buf, NULL, 0);
 
-	sprintf(path, "%s/nfit/format", dimm_base);
+	sprintf(path, "%s/%s/format", dimm_base, bus_prefix);
 	if (sysfs_read_attr(ctx, path, buf) == 0)
 		dimm->format[0] = strtoul(buf, NULL, 0);
 	for (i = 1; i < dimm->formats; i++) {
-		sprintf(path, "%s/nfit/format%d", dimm_base, i);
+		sprintf(path, "%s/%s/format%d", dimm_base, bus_prefix, i);
 		if (sysfs_read_attr(ctx, path, buf) == 0)
 			dimm->format[i] = strtoul(buf, NULL, 0);
 	}
 
-	sprintf(path, "%s/nfit/flags", dimm_base);
-	if (sysfs_read_attr(ctx, path, buf) == 0)
-		parse_nfit_mem_flags(dimm, buf);
+	sprintf(path, "%s/%s/flags", dimm_base, bus_prefix);
+	if (sysfs_read_attr(ctx, path, buf) == 0) {
+		if (ndctl_bus_has_nfit(dimm->bus))
+			parse_nfit_mem_flags(dimm, buf);
+		else if (ndctl_bus_is_papr_scm(dimm->bus)) {
+			dimm->cmd_family = NVDIMM_FAMILY_PAPR;
+			parse_papr_flags(dimm, buf);
+		}
+	}
 
 	dimm->health_eventfd = open(path, O_RDONLY|O_CLOEXEC);
 	rc = 0;
@@ -1801,7 +1775,8 @@ static void *add_dimm(void *parent, int id, const char *dimm_base)
 	if (!path)
 		return NULL;
 
-	sprintf(path, "%s/nfit/formats", dimm_base);
+	sprintf(path, "%s/%s/formats", dimm_base,
+		ndctl_bus_has_nfit(bus) ? "nfit" : "papr");
 	if (sysfs_read_attr(ctx, path, buf) < 0)
 		formats = 1;
 	else
@@ -1875,13 +1850,12 @@ static void *add_dimm(void *parent, int id, const char *dimm_base)
 	else
 		dimm->fwa_result = fwa_result_to_result(buf);
 
+	dimm->formats = formats;
 	/* Check if the given dimm supports nfit */
 	if (ndctl_bus_has_nfit(bus)) {
-		dimm->formats = formats;
-		rc = add_nfit_dimm(dimm, dimm_base);
-	} else if (ndctl_bus_has_of_node(bus)) {
-		rc = add_papr_dimm(dimm, dimm_base);
-	}
+		rc = populate_dimm_attributes(dimm, dimm_base, "nfit");
+	} else if (ndctl_bus_has_of_node(bus))
+		rc = populate_dimm_attributes(dimm, dimm_base, "papr");
 
 	if (rc == -ENODEV) {
 		/* Unprobed dimm with no family */
@@ -2540,13 +2514,12 @@ static void *add_region(void *parent, int id, const char *region_base)
 		goto err_read;
 	region->num_mappings = strtoul(buf, NULL, 0);
 
-	sprintf(path, "%s/nfit/range_index", region_base);
-	if (ndctl_bus_has_nfit(bus)) {
-		if (sysfs_read_attr(ctx, path, buf) < 0)
-			goto err_read;
-		region->range_index = strtoul(buf, NULL, 0);
-	} else
+	sprintf(path, "%s/%s/range_index", region_base,
+		ndctl_bus_has_nfit(bus) ? "nfit": "papr");
+	if (sysfs_read_attr(ctx, path, buf) < 0)
 		region->range_index = -1;
+	else
+		region->range_index = strtoul(buf, NULL, 0);
 
 	sprintf(path, "%s/read_only", region_base);
 	if (sysfs_read_attr(ctx, path, buf) < 0)
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

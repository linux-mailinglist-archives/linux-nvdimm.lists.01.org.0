Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4466D37F2DA
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 May 2021 08:13:01 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 839F2100F2257;
	Wed, 12 May 2021 23:12:59 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1FBA2100F2255
	for <linux-nvdimm@lists.01.org>; Wed, 12 May 2021 23:12:56 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d16so29007pfn.12
        for <linux-nvdimm@lists.01.org>; Wed, 12 May 2021 23:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ldw0NnK3agDWj5ekHEK7g3s2gQc83F6iEQZ6tWXyceE=;
        b=WrHDms0Ge1qmsG4tvkPF9OplzevscfoekilJH7S4sRJ1D0LHXO3lYPcBnL3MShyupm
         KO6cZFV5otrYIGLNBwyzVwowqCUMOOk32PDWRfKI74gA2om29seEyICSBNCxv7ZSpaww
         TAMVu48XzEu3G0Nh4k6BKWQE7cImCcqwGMFYnBtcimebJwnIa3AzqwlYzlhAztkd5xLQ
         l1kt3h2n5GPNRn5DuwpoHqAaKDorW7ripsAPdYno+RGWCp+A3tDn5gVXWSEEobq8d4l0
         fq7DOQoUh4qyHnpRHLZC6dSedyB9KlK85MscJTHgs8d98VVxewhQ/UxP9M2LL3QnnHdA
         nAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ldw0NnK3agDWj5ekHEK7g3s2gQc83F6iEQZ6tWXyceE=;
        b=O2naGG7ftomhiY39k7JUbvnOTqy843LlpbydmOXgcSoeg7EuhbioPJni1oShaHyzwy
         9WT90lWVWDa2Q45FUNmn+IstRYbCFtjQ7QAvzTNe3nGl1+UgwP744+jbg2/EmpnegPtL
         7SVDwYTRxqeAqh4KJfyFgNM0lmWwZp1MYOkiBJk9tAMKF9qH3jbwi2GRy4CNFaOuk0eg
         BoBp/of7q/NBvjkfxC0F2i4q/so4sTP9iSaXC1VONnpxpvjyzvJSKJKoF6mbN2ytTyEk
         fq6DkGc+lL6/QN1QSepFiCPqYcniLLNV1fP3+eiQB9WXAr2Jswv+JozEiBRVfg85FDZi
         S05A==
X-Gm-Message-State: AOAM531Nfix9j+pdEzj0GtnxPMq9wFiukMaOwWwEytf87hxEJT7biS4d
	I+u9U7k8fUXCdEJtHZUynbcGKxkf+mIWDg==
X-Google-Smtp-Source: ABdhPJyvcssk8zpTEplnbwns66QmjtQ/D4SCka+PiCMKW0jcBQUMQRWHUZCMQ+yikODrC42ID5FX/A==
X-Received: by 2002:a65:6402:: with SMTP id a2mr4864749pgv.49.1620886376062;
        Wed, 12 May 2021 23:12:56 -0700 (PDT)
Received: from desktop.fossix.local ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id gf21sm1422351pjb.20.2021.05.12.23.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 23:12:55 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>
Subject: [ndctl V5 1/4] libndctl: Unify adding dimms for papr and nfit families
Date: Thu, 13 May 2021 11:42:15 +0530
Message-Id: <20210513061218.760322-1-santosh@fossix.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Message-ID-Hash: L3K6KSWO2SMAMQA45WZM5EHYE63TQUVG
X-Message-ID-Hash: L3K6KSWO2SMAMQA45WZM5EHYE63TQUVG
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Shivaprasad G Bhat <sbhat@linux.ibm.com>, Harish Sriram <harish@linux.ibm.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/L3K6KSWO2SMAMQA45WZM5EHYE63TQUVG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In preparation for enabling tests on non-nfit devices, unify both, already very
similar, functions into one. This will help in adding all attributes needed for
the unit tests. Since the function doesn't fail if some of the dimm attributes
are missing, this will work fine on PAPR platforms though only part of the DIMM
attributes are provided (This doesn't mean that all of the DIMM attributes can
be missing).

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 ndctl/lib/libndctl.c | 103 ++++++++++++++++---------------------------
 1 file changed, 38 insertions(+), 65 deletions(-)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index 36fb6fe..26b9317 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -1646,41 +1646,9 @@ static int ndctl_bind(struct ndctl_ctx *ctx, struct kmod_module *module,
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
@@ -1694,7 +1662,7 @@ static int add_nfit_dimm(struct ndctl_dimm *dimm, const char *dimm_base)
 	 * 'unique_id' may not be available on older kernels, so don't
 	 * fail if the read fails.
 	 */
-	sprintf(path, "%s/nfit/id", dimm_base);
+	sprintf(path, "%s/%s/id", dimm_base, bus_prefix);
 	if (sysfs_read_attr(ctx, path, buf) == 0) {
 		unsigned int b[9];
 
@@ -1709,68 +1677,74 @@ static int add_nfit_dimm(struct ndctl_dimm *dimm, const char *dimm_base)
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
@@ -1792,7 +1766,8 @@ static void *add_dimm(void *parent, int id, const char *dimm_base)
 	if (!path)
 		return NULL;
 
-	sprintf(path, "%s/nfit/formats", dimm_base);
+	sprintf(path, "%s/%s/formats", dimm_base,
+		ndctl_bus_has_nfit(bus) ? "nfit" : "papr");
 	if (sysfs_read_attr(ctx, path, buf) < 0)
 		formats = 1;
 	else
@@ -1866,13 +1841,12 @@ static void *add_dimm(void *parent, int id, const char *dimm_base)
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
@@ -2531,13 +2505,12 @@ static void *add_region(void *parent, int id, const char *region_base)
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
2.31.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

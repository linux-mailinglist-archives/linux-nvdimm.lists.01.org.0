Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 965D2336D45
	for <lists+linux-nvdimm@lfdr.de>; Thu, 11 Mar 2021 08:48:52 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E0D38100EBB7F;
	Wed, 10 Mar 2021 23:48:49 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 87034100EC1CF
	for <linux-nvdimm@lists.01.org>; Wed, 10 Mar 2021 23:48:47 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id w7so6312170pll.8
        for <linux-nvdimm@lists.01.org>; Wed, 10 Mar 2021 23:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mzqNvkUHxoue4dx77KS8Amr+l5ruh8G1Jw6Gyh8awu4=;
        b=H9eA4yzkYd0X8PaoIW46UnjUc7Fkh3WhYUkRWZn0qtURKkuvv3ydBneNDsTLWbF7Em
         vrWwcItgcCMJfPPyU5iKQJAOk+zI4q6HkfR4bZ35Qh6ghKuZOdwLqdwkKJDeDRkqc6h/
         9/FHn4FwD/glDWtgO75MLRNBQc3iQ/Ul9dMenv0Lk/OIjz3moLMsz7RICvZG0iXcP5bE
         R7OnC5uoOsJaIjxwA6flNsJTP4jFbuJSbLF04CwPesupSvaFLhuAnsUK99NUv92AFJVL
         XJ/o1v/sPkoR1xlvjdGLgv4Z7uQVilwVoBMHlpQ7/m64ZWJPOZn0wyvUBRfEZ5i9zZQ0
         EHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mzqNvkUHxoue4dx77KS8Amr+l5ruh8G1Jw6Gyh8awu4=;
        b=FQaHK9889N2Yuxfneb3B48pHpHDfYiqvltbEjwXIzUul+7EsAlIfhGlySWvMOOZtB1
         8c3z4VKUmOIfg9EfXZF3K571y0AWQ+Jc1qfiFcHfbBYmbqa2PuUWMVzAUVGj7mUGu7By
         9hyuSvpnv21bMh37YFzVvJ4BYm0oZxVkagNQD7TYVA4Cu6dPDXK4usy2hfBes2yo+A5I
         ZWI3o8SqDQlYBRZzBeGGBSK228zvo6yYcUhvYeJImXhhq7Bi1jQRT2k1jbNBPKu+/uAi
         Q/jF+KMYTjwXy6w3pBNsanwhJZ+F5w44v3h4Ooa5yE2Q9T2EA7+0SbEsoSgNkdDsakda
         Zwrg==
X-Gm-Message-State: AOAM531eUbKfrHQPuYW6FZOXdWLzrkyzp7Aog1WjKdz56FZx6HuH8+YA
	L/UKPtPavg/oLhg7gnZYxLIdbD4NZA5Tww==
X-Google-Smtp-Source: ABdhPJxM2Vs+GMkQA8mgb13+2x73hSg7f1RL6COqMPgDaQAmH7eLTCbbgZnsLtX+Ql+R1/0xMYjn4g==
X-Received: by 2002:a17:90a:64c7:: with SMTP id i7mr7564116pjm.95.1615448926071;
        Wed, 10 Mar 2021 23:48:46 -0800 (PST)
Received: from localhost.localdomain ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id t13sm1528580pfe.161.2021.03.10.23.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 23:48:45 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [ndctl PATCH v3 1/4] libndctl: test enablement for non-nfit devices
Date: Thu, 11 Mar 2021 13:16:49 +0530
Message-Id: <20210311074652.2783560-1-santosh@fossix.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Message-ID-Hash: N2RCNQEDLPYDBU4RW76EMQET6VYUW3XM
X-Message-ID-Hash: N2RCNQEDLPYDBU4RW76EMQET6VYUW3XM
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/N2RCNQEDLPYDBU4RW76EMQET6VYUW3XM/>
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

v3:
* Drop patch which skips SMART tests, smart test enablement will be posted
  soon.

v2:
* Patch 2: Fix a bug, I skip erroring out if PAPR family, but condition had
  INTEL family instead. That change was there to test the same code on x86, but
  accidently committed. Now have a environment variable to force test PAPR
  family on x86.

* Patch 4: Remove stray code, artifact of refactoring in patch 1.

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
2.29.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD692AAAFA
	for <lists+linux-nvdimm@lfdr.de>; Sun,  8 Nov 2020 13:20:43 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6A42416217BC8;
	Sun,  8 Nov 2020 04:20:42 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4945116217BC6
	for <linux-nvdimm@lists.01.org>; Sun,  8 Nov 2020 04:20:40 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id b12so3192066plr.4
        for <linux-nvdimm@lists.01.org>; Sun, 08 Nov 2020 04:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jn2iLCMXvYiUMXoclcGQWJeYUqKt6prBAB0SwYg3z30=;
        b=z0EbmRDSWuzlirD7Cf9ToSz7PHP9WrU5rmAk0mNAbpLPIBgoNpiId5HAyjh/SGNqXx
         GhsL8HOz+Ar4TvwhUpeB0itO2Opr3Gt8sEusGCIdmht2CpsrfRk/TTBstYZJEttIRo6A
         x1XxZPld7WyXO0O7Csk3qdYqPdY7iC9P8SscszrtLPABXLDZBppRunYnX6m1x6awSRZY
         FOa7bIUqPVGDPVDVjimMVOHI+kvGqVUqGW7LbnI50sxYtU6mdrOeJMT6C72qiFz4S3X7
         t+DjfiZ/182Lnmywebv/osRuCjXwXYJ9NeEEz+Z4DbN8QPSpHNc+Vi+UQ7jaPnb8WbST
         5BEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jn2iLCMXvYiUMXoclcGQWJeYUqKt6prBAB0SwYg3z30=;
        b=a57rnj055A9B5LFDF8eljyadzBrJNPJYlcVpqyW/m3KjdmnppGQl6atY76UwmOHAbT
         MdVfUdLwJSdGrP0dTF3S8yZ9yM6tHWHBKju3/gsOBoudtSP0ZebXOjSUWPIf0DG6uvNI
         ZFQF5jFTR0U49zdnsA3anzsiDd7yKqe4wdOKh+a7m7ADGZHC4nYCJnD+R1kL3eOu9CvE
         IQkQJm/wz8Xum7do9AbroirjrcO6Nkh6Ey2Fi4+d9vrHBu6Ig7A9leXs6CjKaFi1PO01
         uc36qubgmBCw/L+LDVYlM6SLV+2zoWBsqNP22yoG7lyNj8sYp6IyjauhzNoLU1v64rbn
         kiqg==
X-Gm-Message-State: AOAM530En7S/9ALXYzaNXpJ4D/nC0DSLLdDdI142wYqe3aCImgXlFDlM
	UAMimWCXzCp79mC6drX/1/Bu+I1TpkgWxw==
X-Google-Smtp-Source: ABdhPJy7sVus9sa+5zTgNCesNF3Wx7kTmnPQMyB6VyJ24mrlWuiVfhpjQcaVh9hPBzGhIEVjXW9ouQ==
X-Received: by 2002:a17:902:342:b029:d5:ab9e:19ce with SMTP id 60-20020a1709020342b02900d5ab9e19cemr8920563pld.48.1604838039636;
        Sun, 08 Nov 2020 04:20:39 -0800 (PST)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id e7sm7441282pge.51.2020.11.08.04.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 04:20:39 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [ndctl RFC v4 2/3] Skip smart tests when non nfit devices present
Date: Sun,  8 Nov 2020 17:50:15 +0530
Message-Id: <20201108122016.2090891-2-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201108122016.2090891-1-santosh@fossix.org>
References: <20201108121723.2089939-1-santosh@fossix.org>
 <20201108122016.2090891-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: CJEBRKCVV3PQIRLXKWAS3EROEGMZGLCM
X-Message-ID-Hash: CJEBRKCVV3PQIRLXKWAS3EROEGMZGLCM
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CJEBRKCVV3PQIRLXKWAS3EROEGMZGLCM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 ndctl/lib/libndctl.c | 34 ++++++++++++++++++++++++++--------
 test/libndctl.c      |  3 ++-
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index d1f8e4e..26fc14c 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -815,8 +815,11 @@ static void parse_papr_flags(struct ndctl_dimm *dimm, char *flags)
 			dimm->flags.f_restore = 1;
 		else if (strcmp(start, "smart_notify") == 0)
 			dimm->flags.f_smart = 1;
+		else if (strcmp(start, "save_fail") == 0)
+			dimm->flags.f_save = 1;
 		start = end + 1;
 	}
+
 	if (end != start)
 		dbg(ctx, "%s: Flags:%s\n", ndctl_dimm_get_devname(dimm), flags);
 }
@@ -1044,7 +1047,8 @@ NDCTL_EXPORT int ndctl_bus_is_papr_scm(struct ndctl_bus *bus)
 	if (sysfs_read_attr(bus->ctx, bus->bus_buf, buf) < 0)
 		return 0;
 
-	return (strcmp(buf, "ibm,pmemory") == 0);
+	return (strcmp(buf, "ibm,pmemory") == 0 ||
+		strcmp(buf, "nvdimm_test") == 0);
 }
 
 /**
@@ -1661,6 +1665,7 @@ static void populate_dimm_attributes(struct ndctl_dimm *dimm,
 	char buf[SYSFS_ATTR_SIZE];
 	struct ndctl_ctx *ctx = dimm->bus->ctx;
 	char *path = calloc(1, strlen(dimm_base) + 100);
+	int i;
 
 	sprintf(path, "%s/phys_id", dimm_base);
 	if (sysfs_read_attr(ctx, path, buf) < 0)
@@ -1690,6 +1695,16 @@ static void populate_dimm_attributes(struct ndctl_dimm *dimm,
 			dimm->manufacturing_location = b[2];
 		}
 	}
+
+	sprintf(path, "%s/format", dimm_base);
+	if (sysfs_read_attr(ctx, path, buf) == 0)
+		dimm->format[0] = strtoul(buf, NULL, 0);
+	for (i = 1; i < dimm->formats; i++) {
+		sprintf(path, "%s/format%d", dimm_base, i);
+		if (sysfs_read_attr(ctx, path, buf) == 0)
+			dimm->format[i] = strtoul(buf, NULL, 0);
+	}
+
 	sprintf(path, "%s/subsystem_vendor", dimm_base);
 	if (sysfs_read_attr(ctx, path, buf) == 0)
 		dimm->subsystem_vendor_id = strtoul(buf, NULL, 0);
@@ -1853,7 +1868,8 @@ static void *add_dimm(void *parent, int id, const char *dimm_base)
 	if (!path)
 		return NULL;
 
-	sprintf(path, "%s/nfit/formats", dimm_base);
+	sprintf(path, "%s%s/formats", dimm_base,
+		ndctl_bus_has_nfit(bus) ? "/nfit" : "");
 	if (sysfs_read_attr(ctx, path, buf) < 0)
 		formats = 1;
 	else
@@ -1927,9 +1943,9 @@ static void *add_dimm(void *parent, int id, const char *dimm_base)
 	else
 		dimm->fwa_result = fwa_result_to_result(buf);
 
+	dimm->formats = formats;
 	/* Check if the given dimm supports nfit */
 	if (ndctl_bus_has_nfit(bus)) {
-		dimm->formats = formats;
 		rc = add_nfit_dimm(dimm, dimm_base);
 	} else if (ndctl_bus_has_of_node(bus)) {
 		rc = add_papr_dimm(dimm, dimm_base);
@@ -2592,13 +2608,15 @@ static void *add_region(void *parent, int id, const char *region_base)
 		goto err_read;
 	region->num_mappings = strtoul(buf, NULL, 0);
 
-	sprintf(path, "%s/nfit/range_index", region_base);
-	if (ndctl_bus_has_nfit(bus)) {
-		if (sysfs_read_attr(ctx, path, buf) < 0)
+	sprintf(path, "%s%s/range_index", region_base,
+		ndctl_bus_has_nfit(bus) ? "/nfit" : "");
+	if (sysfs_read_attr(ctx, path, buf) < 0) {
+		if (ndctl_bus_has_nfit(bus))
 			goto err_read;
-		region->range_index = strtoul(buf, NULL, 0);
+		else
+			region->range_index = -1;
 	} else
-		region->range_index = -1;
+		region->range_index = strtoul(buf, NULL, 0);
 
 	sprintf(path, "%s/read_only", region_base);
 	if (sysfs_read_attr(ctx, path, buf) < 0)
diff --git a/test/libndctl.c b/test/libndctl.c
index 994e0fa..b7e7b68 100644
--- a/test/libndctl.c
+++ b/test/libndctl.c
@@ -2427,7 +2427,8 @@ static int check_commands(struct ndctl_bus *bus, struct ndctl_dimm *dimm,
 	 * The kernel did not start emulating v1.2 namespace spec smart data
 	 * until 4.9.
 	 */
-	if (!ndctl_test_attempt(test, KERNEL_VERSION(4, 9, 0)))
+	if (!ndctl_test_attempt(test, KERNEL_VERSION(4, 9, 0))
+	    || !ndctl_bus_has_nfit(bus))
 		dimm_commands &= ~((1 << ND_CMD_SMART)
 				| (1 << ND_CMD_SMART_THRESHOLD));
 
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

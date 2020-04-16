Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 910CF1ABAE3
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 Apr 2020 10:15:35 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DABDD100DCB64;
	Thu, 16 Apr 2020 01:15:57 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1044; helo=mail-pj1-x1044.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 67E35100DCB60
	for <linux-nvdimm@lists.01.org>; Thu, 16 Apr 2020 01:14:16 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id z9so1037775pjd.2
        for <linux-nvdimm@lists.01.org>; Thu, 16 Apr 2020 01:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mNMxgvgDlnhCTFPybGkEUvjX9A0GCv+Wgr+d9SPw6Qg=;
        b=m4NTKELhUNL7fw/NlygjiH7vuhHQ1nw+GAOhjImplYnWjr2wzrKOtyX2GBBzMiFG5n
         lHpY4jejL5BEJvdIZB++GDlty0LPJq9U2BD3RiK6kl8+iQcgXsSouWgvuQ5FpJlKxGEb
         Cu0yu1b9oIoL9Q5n1T/K/6qGeX5QAN58xexeZKUmt4oeTKM/gA/9Y8how+h5d/HnCDEI
         +8oCUtLeQ8mACTjPSf29FbZZ97VAZvhZJCBTUhYILm16sHjRBPeUTRgJ2NFD7iz2v6mR
         zlF31UOD2SlYCpCW6qD5uVoL9tj0lEOEt02KTOk7iCtKBsw5HynCDEus7klNIigHG0gE
         1RFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mNMxgvgDlnhCTFPybGkEUvjX9A0GCv+Wgr+d9SPw6Qg=;
        b=IUnRU/fjKHrInaYnrsKFKQcQyjM8A6zJsqXXors0oO+IZH2Aoy3HL3Weuq//o1jJeT
         dczOMg5CsR8Jj1ZTDn9pJoTjhc7OBWMisZcMCl6UL3zxnHKfC3uGpkqlCo0XciHwDgGD
         RhTzLH0KGVQMWwP/e1qN8JVM4lwKktpr6TX/mkgRSgAg+kXZNSXSI5QS6U+dBC3Ijnlj
         lGRxtrwwJ+dVPiwMCgvDJ9I/KcyPVIwHaLDd8mn572sJL0YvGhYucjfIaGGqws5R9UnC
         FTkyxSBUGUBqTHEZDgV3MwMeMXB6s7PFrL/WTvWJlMMJO9BL6lFPivW0FyoFthorQOzz
         OctQ==
X-Gm-Message-State: AGi0Pua497fXHBAG2AtrIjhwqGojHQD9tvR8FoL5Sj/TeFaS/xgPdxAT
	V2k2be12nTt0wQf3PTBu3+CKyxCrfu8=
X-Google-Smtp-Source: APiQypItSySF9D7QiwK7XFgYSA0ZDrNlropzVPyXy3gcFNOLDdlim3m70J5H538D66Swr+ah44pOUA==
X-Received: by 2002:a17:90a:6486:: with SMTP id h6mr3787679pjj.51.1587024831851;
        Thu, 16 Apr 2020 01:13:51 -0700 (PDT)
Received: from santosiv.in.ibm.com ([2401:4900:2348:c4cf:97f8:ab74:4c:86fc])
        by smtp.gmail.com with ESMTPSA id c144sm4366465pfb.172.2020.04.16.01.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 01:13:51 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: linux-nvdimm@lists.01.org,
	Dan Williams <dan.j.williams@intel.com>
Subject: [ndctl PATCH v2] Skip region filtering if numa_node attribute is not present
Date: Thu, 16 Apr 2020 13:43:14 +0530
Message-Id: <20200416081314.2637325-1-santosh@fossix.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Message-ID-Hash: XSGVWJRGTVJ22DLRRDCWLFBIZZIZC5NB
X-Message-ID-Hash: XSGVWJRGTVJ22DLRRDCWLFBIZZIZC5NB
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: harish@linux.ibm.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XSGVWJRGTVJ22DLRRDCWLFBIZZIZC5NB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

For kernel versions older than 5.4, the numa_node attribute is not
present for regions; due to which `ndctl list -U 1` fails to list
namespaces.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 ndctl/lib/libndctl.c   | 13 ++++++++++---
 ndctl/lib/libndctl.sym |  1 +
 ndctl/libndctl.h       |  4 ++++
 util/filter.c          | 21 +++++++++++++++++++--
 4 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index ee737cb..fef9a43 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -2136,7 +2136,7 @@ static void *add_region(void *parent, int id, const char *region_base)
 	struct ndctl_bus *bus = parent;
 	struct ndctl_ctx *ctx = bus->ctx;
 	char *path = calloc(1, strlen(region_base) + 100);
-	int perm;
+	int perm, rc;
 
 	if (!path)
 		return NULL;
@@ -2186,10 +2186,12 @@ static void *add_region(void *parent, int id, const char *region_base)
 	region->module = to_module(ctx, buf);
 
 	sprintf(path, "%s/numa_node", region_base);
-	if (sysfs_read_attr(ctx, path, buf) == 0)
+	if ((rc = sysfs_read_attr(ctx, path, buf)) == 0)
 		region->numa_node = strtol(buf, NULL, 0);
+	else if (rc == -ENOENT)
+		region->numa_node = NUMA_NO_ATTR;
 	else
-		region->numa_node = -1;
+		region->numa_node = NUMA_NO_NODE;
 
 	sprintf(path, "%s/target_node", region_base);
 	if (sysfs_read_attr(ctx, path, buf) == 0)
@@ -2471,6 +2473,11 @@ NDCTL_EXPORT struct ndctl_dimm *ndctl_region_get_next_dimm(struct ndctl_region *
 	return NULL;
 }
 
+NDCTL_EXPORT int ndctl_region_has_numa(struct ndctl_region *region)
+{
+	return (region->numa_node != NUMA_NO_ATTR);
+}
+
 NDCTL_EXPORT int ndctl_region_get_numa_node(struct ndctl_region *region)
 {
 	return region->numa_node;
diff --git a/ndctl/lib/libndctl.sym b/ndctl/lib/libndctl.sym
index ac575a2..a9cba8c 100644
--- a/ndctl/lib/libndctl.sym
+++ b/ndctl/lib/libndctl.sym
@@ -430,4 +430,5 @@ LIBNDCTL_23 {
 	ndctl_region_get_target_node;
 	ndctl_region_get_align;
 	ndctl_region_set_align;
+	ndctl_region_has_numa;
 } LIBNDCTL_22;
diff --git a/ndctl/libndctl.h b/ndctl/libndctl.h
index 2580f43..5809ff3 100644
--- a/ndctl/libndctl.h
+++ b/ndctl/libndctl.h
@@ -385,6 +385,7 @@ struct ndctl_dimm *ndctl_region_get_first_dimm(struct ndctl_region *region);
 struct ndctl_dimm *ndctl_region_get_next_dimm(struct ndctl_region *region,
 		struct ndctl_dimm *dimm);
 int ndctl_region_get_numa_node(struct ndctl_region *region);
+int ndctl_region_has_numa(struct ndctl_region *region);
 int ndctl_region_get_target_node(struct ndctl_region *region);
 struct ndctl_region *ndctl_bus_get_region_by_physical_address(struct ndctl_bus *bus,
 		unsigned long long address);
@@ -734,6 +735,9 @@ int ndctl_dimm_master_secure_erase(struct ndctl_dimm *dimm, long key);
 #define ND_KEY_DESC_SIZE	128
 #define ND_KEY_CMD_SIZE		128
 
+#define NUMA_NO_NODE    (-1)
+#define NUMA_NO_ATTR    (-2)
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/util/filter.c b/util/filter.c
index af72793..41765b7 100644
--- a/util/filter.c
+++ b/util/filter.c
@@ -23,8 +23,6 @@
 #include <ndctl/libndctl.h>
 #include <daxctl/libdaxctl.h>
 
-#define NUMA_NO_NODE    (-1)
-
 struct ndctl_bus *util_bus_filter(struct ndctl_bus *bus, const char *__ident)
 {
 	char *end = NULL, *ident, *save;
@@ -467,7 +465,22 @@ int util_filter_walk(struct ndctl_ctx *ctx, struct util_filter_ctx *fctx,
 						param->namespace))
 				continue;
 
+			/*
+			 * if numa_node attribute is not available for regions
+			 * (which is true for pre 5.4 kernels), don't skip the
+			 * region if namespace is also requested, let the
+			 * namespace filter handle the NUMA node filtering.
+			 */
 			if (numa_node != NUMA_NO_NODE &&
+			    !ndctl_region_has_numa(region) &&
+			    !fctx->filter_namespace) {
+				fprintf(stderr,
+					"This kernel does not provide NUMA node information per-region\n");
+				continue;
+			}
+
+			if (ndctl_region_has_numa(region) &&
+			    numa_node != NUMA_NO_NODE &&
 			    ndctl_region_get_numa_node(region) != numa_node)
 				continue;
 
@@ -489,6 +502,10 @@ int util_filter_walk(struct ndctl_ctx *ctx, struct util_filter_ctx *fctx,
 				if (param->mode && util_nsmode(param->mode) != mode)
 					continue;
 
+				if (numa_node != NUMA_NO_NODE &&
+				    ndctl_namespace_get_numa_node(ndns) != numa_node)
+					continue;
+
 				fctx->filter_namespace(ndns, fctx);
 			}
 		}
-- 
2.25.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

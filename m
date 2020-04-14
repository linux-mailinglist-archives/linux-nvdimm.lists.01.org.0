Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F821A79B8
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 Apr 2020 13:38:43 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3837610FC51D9;
	Tue, 14 Apr 2020 04:39:17 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1044; helo=mail-pj1-x1044.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A5A8910113FD4
	for <linux-nvdimm@lists.01.org>; Tue, 14 Apr 2020 04:39:14 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ng8so5154298pjb.2
        for <linux-nvdimm@lists.01.org>; Tue, 14 Apr 2020 04:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/awmZGgPS6jFAVPTtAUF80oydFsYY+qRubd58VjFqWI=;
        b=Ic3Kt52rK9QAIlpVrIuNpT0IJvUSKQD+pHJapsHKv9Fcb+fxRnhkujDB7yEH0onNIB
         yMLy6fKPcYhUkOxKavv3+Rn8XZ2uuf7SEXDHTnT60yg0j77uFVhedAZGqIYo5I+GS0nG
         LuzDZzsoWD8ob7m3giKmTDofbfs04oLHD1o/xUMWULPFFIHfHblQEewywhf4Fbh8yCSs
         ZgjHOc1P0scIZ5vA7JHI+GxClisgnWTWU+aW9nZKdBSa3rFOeeaSeF5EU4B9f3KSdvRn
         JeZ4/XfHxpysU2LR8HB39PgR/EYWKyAsxKM9eEiQOLc8bw7JfNGoA1ONc5fEEXn7w8dC
         1lIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/awmZGgPS6jFAVPTtAUF80oydFsYY+qRubd58VjFqWI=;
        b=pb14sAA4bEf5NLYvgug42p9mMkPtBQdAZrDCOylE0sjyIwaQatP+CwWmPDTLQxcDZx
         zpWJelGyT9O0jcfoau3BPnylJWT65LEnBG4toTr7dPV5qtG3Z3BNqm1xGXOL/E00teYm
         tfrNZ4u8FJa3rjuYLn13iLxFGscsFGBQE1M6SUqg+1mufT74YqRSniMbXaRdbhEGl9JB
         B4bwXJoaGlYsrr4ND62tzjiKetjw7lGc1dZtDXbh1Ft6AQ6M6mHmHbhOk8hnWrLNYahJ
         yHSYXScQ0NJ9LOkCYm2lEUoT1P5saR3sAxoLTAobEDHEsMo55sLvWqOuzhimpg/9xECX
         +2Jw==
X-Gm-Message-State: AGi0Puay12IzmlwJBhDEJoLq30L13sFUDBoZSppFlJDQvbtGsiG4G82U
	W2sNlXl1x+viRLYs1gZxf9Bx+FH5G7o=
X-Google-Smtp-Source: APiQypJ/xF3aBgr9DqIATy1A8BDGeUgUIf3RndQrHSUxf00hG7e6SCENoC71jCMdx+NIrmN3W/qbBw==
X-Received: by 2002:a17:90a:f407:: with SMTP id ch7mr20863389pjb.72.1586864317385;
        Tue, 14 Apr 2020 04:38:37 -0700 (PDT)
Received: from santosiv.in.ibm.com ([2401:4900:360d:80fd:f85c:bf4e:4685:22fb])
        by smtp.gmail.com with ESMTPSA id w134sm10995737pfd.41.2020.04.14.04.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 04:38:36 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: linux-nvdimm@lists.01.org,
	Dan Williams <dan.j.williams@intel.com>
Subject: [ndctl PATCH] Skip region filtering if numa_node attribute is not present
Date: Tue, 14 Apr 2020 17:07:47 +0530
Message-Id: <20200414113747.1680093-1-santosh@fossix.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Message-ID-Hash: HURWMJ5FKGI4CAECBMMGUJGDN7BG4GDY
X-Message-ID-Hash: HURWMJ5FKGI4CAECBMMGUJGDN7BG4GDY
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: harish@linux.ibm.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HURWMJ5FKGI4CAECBMMGUJGDN7BG4GDY/>
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
 ndctl/lib/libndctl.c   | 11 +++++++++++
 ndctl/lib/libndctl.sym |  1 +
 ndctl/libndctl.h       |  1 +
 util/filter.c          | 12 +++++++++++-
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index ee737cb..fc82084 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -2471,6 +2471,17 @@ NDCTL_EXPORT struct ndctl_dimm *ndctl_region_get_next_dimm(struct ndctl_region *
 	return NULL;
 }
 
+NDCTL_EXPORT int ndctl_region_has_numa_attr(struct ndctl_region *region)
+{
+	char *path = region->region_buf;
+
+	sprintf(path, "%s/numa_node", region->region_path);
+	if (access(path, F_OK) != -1)
+		return 1;
+
+	return 0;
+}
+
 NDCTL_EXPORT int ndctl_region_get_numa_node(struct ndctl_region *region)
 {
 	return region->numa_node;
diff --git a/ndctl/lib/libndctl.sym b/ndctl/lib/libndctl.sym
index ac575a2..b7c72a2 100644
--- a/ndctl/lib/libndctl.sym
+++ b/ndctl/lib/libndctl.sym
@@ -430,4 +430,5 @@ LIBNDCTL_23 {
 	ndctl_region_get_target_node;
 	ndctl_region_get_align;
 	ndctl_region_set_align;
+	ndctl_region_has_numa_attr;
 } LIBNDCTL_22;
diff --git a/ndctl/libndctl.h b/ndctl/libndctl.h
index 2580f43..4e233d8 100644
--- a/ndctl/libndctl.h
+++ b/ndctl/libndctl.h
@@ -385,6 +385,7 @@ struct ndctl_dimm *ndctl_region_get_first_dimm(struct ndctl_region *region);
 struct ndctl_dimm *ndctl_region_get_next_dimm(struct ndctl_region *region,
 		struct ndctl_dimm *dimm);
 int ndctl_region_get_numa_node(struct ndctl_region *region);
+int ndctl_region_has_numa_attr(struct ndctl_region *region);
 int ndctl_region_get_target_node(struct ndctl_region *region);
 struct ndctl_region *ndctl_bus_get_region_by_physical_address(struct ndctl_bus *bus,
 		unsigned long long address);
diff --git a/util/filter.c b/util/filter.c
index af72793..8e60cfa 100644
--- a/util/filter.c
+++ b/util/filter.c
@@ -467,7 +467,13 @@ int util_filter_walk(struct ndctl_ctx *ctx, struct util_filter_ctx *fctx,
 						param->namespace))
 				continue;
 
-			if (numa_node != NUMA_NO_NODE &&
+			/*
+			 * if numa_node attribute is not available for regions
+			 * (which is true for pre 5.4 kernels), don't skip the
+			 * region, let namespace filter handle the filtering.
+			 */
+			if (ndctl_region_has_numa_attr(region) &&
+			    numa_node != NUMA_NO_NODE &&
 			    ndctl_region_get_numa_node(region) != numa_node)
 				continue;
 
@@ -489,6 +495,10 @@ int util_filter_walk(struct ndctl_ctx *ctx, struct util_filter_ctx *fctx,
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

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC11253D47
	for <lists+linux-nvdimm@lfdr.de>; Thu, 27 Aug 2020 07:40:54 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DEBB61252CA72;
	Wed, 26 Aug 2020 22:40:52 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DC85F1252CA6F
	for <linux-nvdimm@lists.01.org>; Wed, 26 Aug 2020 22:40:50 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k1so2621276pfu.2
        for <linux-nvdimm@lists.01.org>; Wed, 26 Aug 2020 22:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mdzET5yvTmbbtd4SlYxpwGhos/mC7IS5FoFiDgfZBCo=;
        b=0BJA5jioUYSpg0sMEifcgJfw+GYmvFs4oFrVg1Ivl3yVyfa+nBtB+7SDfhgk1VjPoQ
         wEobh8DPgSDkK8CdvyXpdREBht0T9hUPF2kYK1ALrZLirm1GIPD9WgS+NcA52z0rTEVy
         BOLofFaCV6hrXq/AtGiAhRghfn8U+B9T46tuiPTPZpDRV+khIWJjrSRzRgNziaHOM+UP
         daxAZ0YF8X9ho0ymP0kFmjyADna5DXwZ3Vx8ZkqJEwNXPxVh2G+xwJ23F71kJ115gHGe
         IP9kPkF1qycAyD2JvFlVg/Gd0Sy/uNvttX2fLBWUy3GcPZlrd9TrOBT/G6WGggnyJ7kU
         11dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mdzET5yvTmbbtd4SlYxpwGhos/mC7IS5FoFiDgfZBCo=;
        b=t3v2Lk2NywtAG5RQQgUOL4fxNffUCuclIGrp7V4ad4eG1nxdJuz9kxUcZD9menYRAZ
         MgNGB4zbpcbma2n8urJo0Kd2JncpJD81XCWCmLRgEbkBEJjkZUkmQzAIW2xHli0gqBBk
         7xmGq+7rJA0T9E16fW/xGRKoCBLNlEgUwUEwXpMSYjamFYqMyGqr60xabZkZ+EOdv8Ut
         QNpWb+8GOeuDqQO4zU5T1v8it1KGhpigPgJiOtFIQzTVly7u8Cfa8ZxNN9vqH239rcyx
         1Nir+44in1qHbbTLSWUGKMx2wcGYL+pBEEXFhifD1yGcpHD+b+hnkynlNbK9idP7tL3w
         4Bww==
X-Gm-Message-State: AOAM532lxVioQ4/43qQbAUVvSYdw0gMPrZxG2pSVdsoC4NMJVEfIEgAp
	D9guLzpnmVdvl+wJiIW3p0uhCJykVSB4Dw==
X-Google-Smtp-Source: ABdhPJw/g1YOjnjPTELYM7Lqda0z/jIcpNdLT8mNDiRsThsQYl8uPKIuPZORhzUxzqOHHF637Df4JA==
X-Received: by 2002:a17:902:7048:: with SMTP id h8mr14561957plt.225.1598506848588;
        Wed, 26 Aug 2020 22:40:48 -0700 (PDT)
Received: from santosiv.in.ibm.com.com ([203.223.190.240])
        by smtp.gmail.com with ESMTPSA id b185sm1079990pfg.71.2020.08.26.22.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 22:40:47 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH v2] namespace-action: Don't act on any seed namespaces
Date: Thu, 27 Aug 2020 11:10:16 +0530
Message-Id: <20200827054016.214041-1-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Message-ID-Hash: FZEEVH24YTV4G3X5QZIWZ2YZNX4KDZPT
X-Message-ID-Hash: FZEEVH24YTV4G3X5QZIWZ2YZNX4KDZPT
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Harish Sriram <harish@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FZEEVH24YTV4G3X5QZIWZ2YZNX4KDZPT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Catch seed namespaces early on. This will prevent checking for sizes in enable,
disable and destroy namespace code path, which in turn prevents the inconsistent
reporting in count of enabled/disabled namespaces.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 ndctl/lib/libndctl.c |  5 ----
 ndctl/namespace.c    | 57 +++++++++++++++++++++-----------------------
 2 files changed, 27 insertions(+), 35 deletions(-)

Changes from v2: Updated patch to return the proper error code. In V1, we return
the default -ENXIO even if we had skipped all the namespaces (when there are
only idle namespaces). In cases like that, we need to return zero, except when
creating namespaces, which may fail due to insufficient space.

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index ee737cb..d0599f7 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -4130,16 +4130,11 @@ NDCTL_EXPORT int ndctl_namespace_enable(struct ndctl_namespace *ndns)
 	const char *devname = ndctl_namespace_get_devname(ndns);
 	struct ndctl_ctx *ctx = ndctl_namespace_get_ctx(ndns);
 	struct ndctl_region *region = ndns->region;
-	unsigned long long size = ndctl_namespace_get_size(ndns);
 	int rc;
 
 	if (ndctl_namespace_is_enabled(ndns))
 		return 0;
 
-	/* Don't try to enable idle namespace (no capacity allocated) */
-	if (size == 0)
-		return -ENXIO;
-
 	rc = ndctl_bind(ctx, ndns->module, devname);
 
 	/*
diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index 0550580..ea540dd 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -1102,7 +1102,6 @@ static int namespace_destroy(struct ndctl_region *region,
 		struct ndctl_namespace *ndns)
 {
 	const char *devname = ndctl_namespace_get_devname(ndns);
-	unsigned long long size;
 	bool did_zero = false;
 	int rc;
 
@@ -1147,19 +1146,9 @@ static int namespace_destroy(struct ndctl_region *region,
 		goto out;
 	}
 
-	size = ndctl_namespace_get_size(ndns);
-
 	rc = ndctl_namespace_delete(ndns);
 	if (rc)
 		debug("%s: failed to reclaim\n", devname);
-
-	/*
-	 * Don't report a destroyed namespace when no capacity was
-	 * allocated.
-	 */
-	if (size == 0 && rc == 0)
-		rc = 1;
-
 out:
 	return rc;
 }
@@ -2128,8 +2117,9 @@ static int do_xaction_namespace(const char *namespace,
 			ndctl_namespace_foreach_safe(region, ndns, _n) {
 				ndns_name = ndctl_namespace_get_devname(ndns);
 
-				if (strcmp(namespace, "all") != 0
+				if ((strcmp(namespace, "all") != 0
 						&& strcmp(namespace, ndns_name) != 0)
+				    || ndctl_namespace_get_size(ndns) == 0)
 					continue;
 				switch (action) {
 				case ACTION_DISABLE:
@@ -2148,9 +2138,6 @@ static int do_xaction_namespace(const char *namespace,
 					rc = namespace_destroy(region, ndns);
 					if (rc == 0)
 						(*processed)++;
-					/* return success if skipped */
-					if (rc > 0)
-						rc = 0;
 					break;
 				case ACTION_CHECK:
 					rc = namespace_check(ndns, verbose,
@@ -2195,22 +2182,32 @@ static int do_xaction_namespace(const char *namespace,
 	if (ri_ctx.f_out && ri_ctx.f_out != stdout)
 		fclose(ri_ctx.f_out);
 
-	if (action == ACTION_CREATE && rc == -EAGAIN) {
-		/*
-		 * Namespace creation searched through all candidate
-		 * regions and all of them said "nope, I don't have
-		 * enough capacity", so report -ENOSPC. Except during
-		 * greedy namespace creation using --continue as we
-		 * may have created some namespaces already, and the
-		 * last one in the region search may preexist.
-		 */
-		if (param.greedy && (*processed) > 0)
-			rc = 0;
-		else
-			rc = -ENOSPC;
+	if (action == ACTION_CREATE) {
+		if (rc == -EAGAIN) {
+			/*
+			 * Namespace creation searched through all candidate
+			 * regions and all of them said "nope, I don't have
+			 * enough capacity", so report -ENOSPC. Except during
+			 * greedy namespace creation using --continue as we
+			 * may have created some namespaces already, and the
+			 * last one in the region search may preexist.
+			 */
+			if (param.greedy && (*processed) > 0)
+				rc = 0;
+			else
+				rc = -ENOSPC;
+		}
+
+		if (saved_rc)
+			rc = saved_rc;
+
+		return rc;
 	}
-	if (saved_rc)
-		rc = saved_rc;
+
+	/* If there is nothing processed, and if we have only skipped idle
+	 * namespaces, there shouldn't be any error */
+	if (rc == -ENXIO && !*processed)
+		rc = 0;
 
 	return rc;
 }
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

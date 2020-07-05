Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2A22149F0
	for <lists+linux-nvdimm@lfdr.de>; Sun,  5 Jul 2020 06:16:04 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 640F710FCC904;
	Sat,  4 Jul 2020 21:16:02 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E5D7E10FCC900
	for <linux-nvdimm@lists.01.org>; Sat,  4 Jul 2020 21:16:00 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id w19so3362994ply.9
        for <linux-nvdimm@lists.01.org>; Sat, 04 Jul 2020 21:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KoEguL5/giWK5s2yeoihpBKLkFCXGdzhNwuS/0t+e00=;
        b=GpX87OCVcJ4eQbMZo4d+nzw07DA/0jj+z50JXiIKNGh+nZHyfZVDyOY6g4POZUgQeB
         y/rNOSIWPytW6Y3hUAU7MfmvL0lR7dVzCBLR5n4xpN4BTg0wr9iYCBh7NUPb0FjIlYc/
         s8h0vTv3UpRIekaapM/VrLWari1tsboI4aRe3BslbfR6hMZJ8raNvrfCR2sy95DyOO0G
         ORXxE0Uu9jzPnzwFOC+g+Xet0S4hQ7O7ZaLT9AbyjUJDPk9+APOXwH27WPj4m7mlCaSb
         QB2hVRc3OLHT2KXRMkSF00aJykezS+9buve0ZXIeKnNAL4wO7YcS7WeO8/G8DAbJ+c0u
         hrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KoEguL5/giWK5s2yeoihpBKLkFCXGdzhNwuS/0t+e00=;
        b=NIYZglWr3KKtb6KXCgqCsp5bKEGIhqjDVZMMOSFxgOmN/AchMuFQ1hg9Jw94K36BN7
         BcurqndtKh4ZAY4n7x3F1cMYPbaVACH4vpJtKa+abQdaLs501VVZNox0rQSBbPsppNGy
         JXP/TYiLlT3yXZvElIWJJAoVooUSP2sg3siK3pJe6wYLRBZUW/Q0EhZro0zZhaKL4KmY
         3zYpvwXVOLOu3wq9HffksUpWFxx3a/dRJBR3OkIbQGAPGYH0zWrtxyUvTercltfnN9S0
         JYQLLOfK7BJ/OS+88xC1TLsHRaLkAc/Jm6C2QlPuuMfbS7YTH71UgOgW3BC28iCkRjb2
         R/Ng==
X-Gm-Message-State: AOAM5331UGFq0UyWGtF2sjrM9X56hjTXePCYXStZQrwHJhe2lmsFCxq1
	E//stNNrk4u1XsUMz7fD8Ow7/G4rQlU=
X-Google-Smtp-Source: ABdhPJwaMHZknr+szVI1MpKTzZZsFB9DCGCqOSUAhmSxpMqkTocbRCvJKRbN/jHcoC9FB3i9gi+L8w==
X-Received: by 2002:a17:90b:f16:: with SMTP id br22mr31156098pjb.170.1593922559777;
        Sat, 04 Jul 2020 21:15:59 -0700 (PDT)
Received: from santosiv.in.ibm.com.com ([203.223.190.240])
        by smtp.gmail.com with ESMTPSA id w68sm15762548pff.191.2020.07.04.21.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 21:15:59 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: linux-nvdimm@lists.01.org,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH ndctl] namespace-action: Don't act on any seed namespaces
Date: Sun,  5 Jul 2020 09:45:19 +0530
Message-Id: <20200705041519.3263863-1-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Message-ID-Hash: QHRHB4O4UJIBYCO6HP2RFVC54HPJVCIC
X-Message-ID-Hash: QHRHB4O4UJIBYCO6HP2RFVC54HPJVCIC
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, harish@linux.ibm.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QHRHB4O4UJIBYCO6HP2RFVC54HPJVCIC/>
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
 ndctl/lib/libndctl.c |  5 -----
 ndctl/namespace.c    | 14 ++------------
 2 files changed, 2 insertions(+), 17 deletions(-)

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
index 0550580..5a086d0 100644
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
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A7A2EBE67
	for <lists+linux-nvdimm@lfdr.de>; Wed,  6 Jan 2021 14:18:15 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B93B4100EB325;
	Wed,  6 Jan 2021 05:18:13 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=msuchanek@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8C681100EB324
	for <linux-nvdimm@lists.01.org>; Wed,  6 Jan 2021 05:18:11 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 23168AD12;
	Wed,  6 Jan 2021 13:18:10 +0000 (UTC)
From: Michal Suchanek <msuchanek@suse.de>
To: linux-nvdimm@lists.01.org
Subject: [PATCH ndctl rebased 3/3] namespace-action: Drop zero namespace checks.
Date: Wed,  6 Jan 2021 14:17:42 +0100
Message-Id: <eb4bc7885708fa13e3d37286bc4a4219b1e4e5b6.1609938610.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <e55ae2c17b8b9c3288491efe6214338118e8c5ae.1609938610.git.msuchanek@suse.de>
References: <e55ae2c17b8b9c3288491efe6214338118e8c5ae.1609938610.git.msuchanek@suse.de>
MIME-Version: 1.0
Message-ID-Hash: YFANYTTUGH4WAJKX73ABSVERUOOJ3TJF
X-Message-ID-Hash: YFANYTTUGH4WAJKX73ABSVERUOOJ3TJF
X-MailFrom: msuchanek@suse.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michal Suchanek <msuchanek@suse.de>, Harish Sriram <harish@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YFANYTTUGH4WAJKX73ABSVERUOOJ3TJF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Santosh Sivaraj <santosh@fossix.org>

With seed namespaces catched early on these checks for sizes in enable
and destroy namespace code path are not needed.

Reverts commit b9cb03f6d5a8 ("ndctl/namespace: Fix enable-namespace
error for seed namespaces")

Reverts commit e01045e58ad5 ("ndctl/namespace: Fix destroy-namespace
accounting relative to seed devices")

Fixes: b9cb03f6d5a8 ("ndctl/namespace: Fix enable-namespace error for seed namespaces")
Fixes: e01045e58ad5 ("ndctl/namespace: Fix destroy-namespace accounting relative to seed devices")
Link: https://patchwork.kernel.org/patch/11739975/
Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
[rebased on top of the previous patches]
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 ndctl/lib/libndctl.c |  5 -----
 ndctl/namespace.c    | 10 ----------
 2 files changed, 15 deletions(-)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index 36fb6fe0f4cf..9f50f76c57e4 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -4501,16 +4501,11 @@ NDCTL_EXPORT int ndctl_namespace_enable(struct ndctl_namespace *ndns)
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
index c3a058d8ff1a..4535372cb0f7 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -1161,15 +1161,12 @@ static int namespace_destroy(struct ndctl_region *region,
 		struct ndctl_namespace *ndns)
 {
 	const char *devname = ndctl_namespace_get_devname(ndns);
-	unsigned long long size;
 	int rc;
 
 	rc = namespace_prep_reconfig(region, ndns);
 	if (rc < 0)
 		return rc;
 
-	size = ndctl_namespace_get_size(ndns);
-
 	/* Labeled namespace, destroy label / allocation */
 	if (rc == 2) {
 		rc = ndctl_namespace_delete(ndns);
@@ -1177,13 +1174,6 @@ static int namespace_destroy(struct ndctl_region *region,
 			debug("%s: failed to reclaim\n", devname);
 	}
 
-	/*
-	 * Don't report a destroyed namespace when no capacity was
-	 * allocated.
-	 */
-	if (size == 0 && rc == 0)
-		rc = 1;
-
 	return rc;
 }
 
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

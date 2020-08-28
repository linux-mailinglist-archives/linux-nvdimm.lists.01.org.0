Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B040255805
	for <lists+linux-nvdimm@lfdr.de>; Fri, 28 Aug 2020 11:51:18 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2DE58128BF5BF;
	Fri, 28 Aug 2020 02:51:16 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=msuchanek@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E7A91128A7AD1
	for <linux-nvdimm@lists.01.org>; Fri, 28 Aug 2020 02:51:13 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 38F22AC97;
	Fri, 28 Aug 2020 09:51:45 +0000 (UTC)
From: Michal Suchanek <msuchanek@suse.de>
To: linux-nvdimm@lists.01.org
Subject: [PATCH 3/3] namespace-action: Drop zero namespace checks.
Date: Fri, 28 Aug 2020 11:51:05 +0200
Message-Id: <486878ed6f1d74827afb42543f3186fe386059de.1598608222.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <d2d35ad93256c3ff6dbd3f9c7bd237933c59ae26.1598608222.git.msuchanek@suse.de>
References: <d2d35ad93256c3ff6dbd3f9c7bd237933c59ae26.1598608222.git.msuchanek@suse.de>
MIME-Version: 1.0
Message-ID-Hash: 5UVOSAND6V4T5XFCRSUK47F6VMXGGJR7
X-Message-ID-Hash: 5UVOSAND6V4T5XFCRSUK47F6VMXGGJR7
X-MailFrom: msuchanek@suse.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michal Suchanek <msuchanek@suse.de>, Harish Sriram <harish@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5UVOSAND6V4T5XFCRSUK47F6VMXGGJR7/>
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

Link: https://patchwork.kernel.org/patch/11739975/
Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
[rebased on top of the previous patches]
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 ndctl/lib/libndctl.c |  5 -----
 ndctl/namespace.c    | 11 -----------
 2 files changed, 16 deletions(-)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index 952192c4c6b5..ecced5a3ae0b 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -4253,16 +4253,11 @@ NDCTL_EXPORT int ndctl_namespace_enable(struct ndctl_namespace *ndns)
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
index 835f4076008a..65bca9191603 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -1094,7 +1094,6 @@ static int namespace_destroy(struct ndctl_region *region,
 		struct ndctl_namespace *ndns)
 {
 	const char *devname = ndctl_namespace_get_devname(ndns);
-	unsigned long long size;
 	bool did_zero = false;
 	int rc;
 
@@ -1139,19 +1138,9 @@ static int namespace_destroy(struct ndctl_region *region,
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
-- 
2.28.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

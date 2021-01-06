Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3C62EBE65
	for <lists+linux-nvdimm@lfdr.de>; Wed,  6 Jan 2021 14:18:11 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A592B100EB322;
	Wed,  6 Jan 2021 05:18:09 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=msuchanek@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 93B61100EB320
	for <linux-nvdimm@lists.01.org>; Wed,  6 Jan 2021 05:18:06 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 15F07AD12;
	Wed,  6 Jan 2021 13:18:05 +0000 (UTC)
From: Michal Suchanek <msuchanek@suse.de>
To: linux-nvdimm@lists.01.org
Subject: [PATCH ndctl rebased 2/3] ndctl/namespace: Suppress -ENXIO when processing all namespaces.
Date: Wed,  6 Jan 2021 14:17:41 +0100
Message-Id: <32c8cd8d2716f5e52aebea4e4d303eeb4e0550f9.1609938610.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <e55ae2c17b8b9c3288491efe6214338118e8c5ae.1609938610.git.msuchanek@suse.de>
References: <e55ae2c17b8b9c3288491efe6214338118e8c5ae.1609938610.git.msuchanek@suse.de>
MIME-Version: 1.0
Message-ID-Hash: HCJGDHNV5FFPT5ZODOM4IJVTIS33QFOW
X-Message-ID-Hash: HCJGDHNV5FFPT5ZODOM4IJVTIS33QFOW
X-MailFrom: msuchanek@suse.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michal Suchanek <msuchanek@suse.de>, Harish Sriram <harish@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HCJGDHNV5FFPT5ZODOM4IJVTIS33QFOW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When processing all namespaces and no namespaces exist user gets the
default -ENXIO. Set default rc to 0 when processing all namespaces.
This avoids confusing error message printed in addition to the message
saying 0 namespaces were affected.

Before:

 # ndctl check-namespace all
namespace0.0: namespace_check: namespace0.0: check aborted, namespace online
error checking namespaces: Device or resource busy
checked 0 namespaces
 # ndctl disable-namespace all
disabled 1 namespace
 # ndctl check-namespace all
namespace0.0: namespace_check: Unable to recover any BTT info blocks
error checking namespaces: No such device or address
checked 0 namespaces
 # ndctl destroy-namespace all
destroyed 1 namespace
 # ndctl check-namespace all
error checking namespaces: No such device or address
checked 0 namespaces
 # ndctl destroy-namespace all
error destroying namespaces: No such device or address
destroyed 0 namespaces

After:

 # ndctl check-namespace all
namespace0.0: namespace_check: namespace0.0: check aborted, namespace online
error checking namespaces: Device or resource busy
checked 0 namespaces
 # ndctl disable-namespace namespace0.0
disabled 1 namespace
 # ndctl check-namespace all
namespace0.0: namespace_check: Unable to recover any BTT info blocks
error checking namespaces: No such device or address
checked 0 namespaces
 # ndctl destroy-namespace all
destroyed 1 namespace
 # ndctl check-namespace all
checked 0 namespaces
 # ndctl destroy-namespace all
destroyed 0 namespaces
 # ndctl destroy-namespace all
destroyed 0 namespaces

Note: this does change the return value from -ENXIO to 0 in the cases
when no namespaces exist and processing all namespaces was requested.

Link: https://patchwork.kernel.org/patch/11681431/
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Reviewed-by: Santosh S <santosh@fossix.org>
---
v2: fix the error code references in the commit message
---
 ndctl/namespace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index b9ffd21fe7bf..c3a058d8ff1a 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -2148,6 +2148,9 @@ static int do_xaction_namespace(const char *namespace,
 	if (!namespace && action != ACTION_CREATE)
 		return rc;
 
+	if (namespace && (strcmp(namespace, "all") == 0))
+		rc = 0;
+
 	if (verbose)
 		ndctl_set_log_priority(ctx, LOG_DEBUG);
 
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

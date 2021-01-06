Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7541B2EBE64
	for <lists+linux-nvdimm@lfdr.de>; Wed,  6 Jan 2021 14:18:09 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 91ADA100EB85F;
	Wed,  6 Jan 2021 05:18:06 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=msuchanek@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AA738100EB85D
	for <linux-nvdimm@lists.01.org>; Wed,  6 Jan 2021 05:18:03 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id E56D2AD12;
	Wed,  6 Jan 2021 13:18:01 +0000 (UTC)
From: Michal Suchanek <msuchanek@suse.de>
To: linux-nvdimm@lists.01.org
Subject: [PATCH ndctl rebased 1/3] ndctl/namespace: Skip seed namespaces when processing all namespaces.
Date: Wed,  6 Jan 2021 14:17:40 +0100
Message-Id: <e55ae2c17b8b9c3288491efe6214338118e8c5ae.1609938610.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Message-ID-Hash: 5SZUBJHLV66DZ2WSMHZCL22IMYNTZSWO
X-Message-ID-Hash: 5SZUBJHLV66DZ2WSMHZCL22IMYNTZSWO
X-MailFrom: msuchanek@suse.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michal Suchanek <msuchanek@suse.de>, Harish Sriram <harish@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5SZUBJHLV66DZ2WSMHZCL22IMYNTZSWO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The seed namespaces are exposed by the kernel but most operations are
not valid on seed namespaces.

When processing all namespaces the user gets confusing errors from ndctl
trying to process seed namespaces. The kernel does not provide any way
to tell that a namspace is seed namespace but skipping namespaces with
zero size and UUID is a good heuristic.

The user can still specify the namespace by name directly in case
processing it is desirable.

Fixes: #41
Link: https://patchwork.kernel.org/patch/11473645/
Reviewed-by: Santosh S <santosh@fossix.org>
Tested-by: Harish Sriram <harish@linux.ibm.com>
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 ndctl/namespace.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index 0c8df9fa8b47..b9ffd21fe7bf 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -2207,9 +2207,19 @@ static int do_xaction_namespace(const char *namespace,
 			ndctl_namespace_foreach_safe(region, ndns, _n) {
 				ndns_name = ndctl_namespace_get_devname(ndns);
 
-				if (strcmp(namespace, "all") != 0
-						&& strcmp(namespace, ndns_name) != 0)
-					continue;
+				if (strcmp(namespace, "all") == 0) {
+					static const uuid_t zero_uuid;
+					uuid_t uuid;
+
+					ndctl_namespace_get_uuid(ndns, uuid);
+					if (!ndctl_namespace_get_size(ndns) &&
+					    !memcmp(uuid, zero_uuid, sizeof(uuid_t)))
+						continue;
+				} else {
+					if (strcmp(namespace, ndns_name) != 0)
+						continue;
+				}
+
 				switch (action) {
 				case ACTION_DISABLE:
 					rc = ndctl_namespace_disable_safe(ndns);
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

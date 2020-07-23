Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C0122B53C
	for <lists+linux-nvdimm@lfdr.de>; Thu, 23 Jul 2020 19:52:01 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 302A212509DA5;
	Thu, 23 Jul 2020 10:51:59 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=msuchanek@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 71D1D12509DA1
	for <linux-nvdimm@lists.01.org>; Thu, 23 Jul 2020 10:51:55 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id EC587ABE9;
	Thu, 23 Jul 2020 17:52:01 +0000 (UTC)
From: Michal Suchanek <msuchanek@suse.de>
To: linux-nvdimm@lists.01.org
Subject: [PATCH 1/2] ndctl/namespace: skip zero namespaces when processing all namespaces.
Date: Thu, 23 Jul 2020 19:51:44 +0200
Message-Id: <ac216d4887a00c468acfb323920426135f6861dd.1595526596.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Message-ID-Hash: TH7AZMLM2I5BJDG2XIN6RUNY24U7BVBG
X-Message-ID-Hash: TH7AZMLM2I5BJDG2XIN6RUNY24U7BVBG
X-MailFrom: msuchanek@suse.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michal Suchanek <msuchanek@suse.de>, Harish Sriram <harish@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TH7AZMLM2I5BJDG2XIN6RUNY24U7BVBG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The kernel always creates zero length namespace with uuid 0 in each
region.

When processing all namespaces the user gets confusing errors from ndctl
trying to process this namespace. Skip it.

The user can still specify the namespace by name directly in case
processing it is desirable.

Fixes: #41
Reviewed-by: Santosh S <santosh@fossix.org>
Tested-by: Harish Sriram <harish@linux.ibm.com>
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 ndctl/namespace.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index e734248c9752..3fabe4799d75 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -2171,9 +2171,19 @@ static int do_xaction_namespace(const char *namespace,
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

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EC3DCFF1
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Oct 2019 22:23:18 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 570DB10FCB906;
	Fri, 18 Oct 2019 13:25:19 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9DAA610FCB903
	for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 13:25:14 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E1F3430833CB
	for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 20:23:08 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C5C2D600C1;
	Fri, 18 Oct 2019 20:23:08 +0000 (UTC)
Received: by segfault.boston.devel.redhat.com (Postfix, from userid 3734)
	id C6BDA21C9AD0; Fri, 18 Oct 2019 16:23:07 -0400 (EDT)
From: Jeff Moyer <jmoyer@redhat.com>
To: linux-nvdimm@lists.01.org
Cc: Jeff Moyer <jmoyer@redhat.com>
Subject: [ndctl patch 1/4] util/abspath: cleanup prefix_filename
Date: Fri, 18 Oct 2019 16:22:59 -0400
Message-Id: <20191018202302.8122-2-jmoyer@redhat.com>
In-Reply-To: <20191018202302.8122-1-jmoyer@redhat.com>
References: <20191018202302.8122-1-jmoyer@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 18 Oct 2019 20:23:08 +0000 (UTC)
Message-ID-Hash: N46UR2VWPVFJEYZ6UUJU3ECP672X6XBN
X-Message-ID-Hash: N46UR2VWPVFJEYZ6UUJU3ECP672X6XBN
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/N46UR2VWPVFJEYZ6UUJU3ECP672X6XBN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Static checkers complain about the unused assignment to pfx_len.
The code can obviously be simplified.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
---
 util/abspath.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/util/abspath.c b/util/abspath.c
index 09bbd27..e44236f 100644
--- a/util/abspath.c
+++ b/util/abspath.c
@@ -9,11 +9,7 @@ char *prefix_filename(const char *pfx, const char *arg)
 	struct strbuf path = STRBUF_INIT;
 	size_t pfx_len = pfx ? strlen(pfx) : 0;
 
-	if (!pfx_len)
-		;
-	else if (is_absolute_path(arg))
-		pfx_len = 0;
-	else
+	if (pfx_len && !is_absolute_path(arg))
 		strbuf_add(&path, pfx, pfx_len);
 
 	strbuf_addstr(&path, arg);
-- 
2.19.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

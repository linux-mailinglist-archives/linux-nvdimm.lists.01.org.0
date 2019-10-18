Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D3FDCFF2
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Oct 2019 22:23:19 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6A76910FCB90F;
	Fri, 18 Oct 2019 13:25:19 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9C32910FCB901
	for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 13:25:14 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E131818B20E6
	for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 20:23:08 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C516B7E2A;
	Fri, 18 Oct 2019 20:23:08 +0000 (UTC)
Received: by segfault.boston.devel.redhat.com (Postfix, from userid 3734)
	id D1CC521C9AD5; Fri, 18 Oct 2019 16:23:07 -0400 (EDT)
From: Jeff Moyer <jmoyer@redhat.com>
To: linux-nvdimm@lists.01.org
Cc: Jeff Moyer <jmoyer@redhat.com>
Subject: [ndctl patch 4/4] load-keys: get rid of duplicate assignment
Date: Fri, 18 Oct 2019 16:23:02 -0400
Message-Id: <20191018202302.8122-5-jmoyer@redhat.com>
In-Reply-To: <20191018202302.8122-1-jmoyer@redhat.com>
References: <20191018202302.8122-1-jmoyer@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Fri, 18 Oct 2019 20:23:08 +0000 (UTC)
Message-ID-Hash: EK2EH7W7AIFPU2F6EIN77VK6XVQF7VTZ
X-Message-ID-Hash: EK2EH7W7AIFPU2F6EIN77VK6XVQF7VTZ
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EK2EH7W7AIFPU2F6EIN77VK6XVQF7VTZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
---
 ndctl/load-keys.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ndctl/load-keys.c b/ndctl/load-keys.c
index 981f80f..f0b7a5a 100644
--- a/ndctl/load-keys.c
+++ b/ndctl/load-keys.c
@@ -185,7 +185,6 @@ static int load_keys(struct loadkeys *lk_ctx, const char *keypath,
 
 	rc = chdir(keypath);
 	if (rc < 0) {
-		rc = -errno;
 		fprintf(stderr, "Change current work dir to %s failed: %s\n",
 				param.key_path, strerror(errno));
 		rc = -errno;
-- 
2.19.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FAFDCFEF
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Oct 2019 22:23:15 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3433310FCB904;
	Fri, 18 Oct 2019 13:25:18 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9B6F310FCB900
	for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 13:25:14 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E279610F2E82
	for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 20:23:08 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C561560603;
	Fri, 18 Oct 2019 20:23:08 +0000 (UTC)
Received: by segfault.boston.devel.redhat.com (Postfix, from userid 3734)
	id C986A21C9AD3; Fri, 18 Oct 2019 16:23:07 -0400 (EDT)
From: Jeff Moyer <jmoyer@redhat.com>
To: linux-nvdimm@lists.01.org
Cc: Jeff Moyer <jmoyer@redhat.com>
Subject: [ndctl patch 2/4] fix building of tags tables
Date: Fri, 18 Oct 2019 16:23:00 -0400
Message-Id: <20191018202302.8122-3-jmoyer@redhat.com>
In-Reply-To: <20191018202302.8122-1-jmoyer@redhat.com>
References: <20191018202302.8122-1-jmoyer@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Fri, 18 Oct 2019 20:23:08 +0000 (UTC)
Message-ID-Hash: 6C6OVD45F2YARMTWHKD5ERAQSC53QK2I
X-Message-ID-Hash: 6C6OVD45F2YARMTWHKD5ERAQSC53QK2I
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6C6OVD45F2YARMTWHKD5ERAQSC53QK2I/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Make <tags-variant> currently fails with:

make[1]: *** No rule to make target 'libndctl.h', needed by 'tags-am'.  Stop.

The path to libndctl.h is wrong in ndctl/lib/Makefile.am.  Fix it.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
---
 ndctl/lib/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ndctl/lib/Makefile.am b/ndctl/lib/Makefile.am
index fb75fda..e4eb006 100644
--- a/ndctl/lib/Makefile.am
+++ b/ndctl/lib/Makefile.am
@@ -7,7 +7,7 @@ pkginclude_HEADERS = ../libndctl.h ../ndctl.h
 lib_LTLIBRARIES = libndctl.la
 
 libndctl_la_SOURCES =\
-	libndctl.h \
+	../libndctl.h \
 	private.h \
 	../../util/log.c \
 	../../util/log.h \
-- 
2.19.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EFE7D286
	for <lists+linux-nvdimm@lfdr.de>; Thu,  1 Aug 2019 03:01:03 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 059A6212FD4E1;
	Wed, 31 Jul 2019 18:03:32 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2001:41d0:602:dbe::8; helo=tartarus.angband.pl;
 envelope-from=kilobyte@angband.pl; receiver=linux-nvdimm@lists.01.org 
Received: from tartarus.angband.pl (tartarus.angband.pl
 [IPv6:2001:41d0:602:dbe::8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 2E769212FD41A
 for <linux-nvdimm@lists.01.org>; Wed, 31 Jul 2019 18:03:29 -0700 (PDT)
Received: from [2a02:a31c:853f:a300::4] (helo=valinor.angband.pl)
 by tartarus.angband.pl with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <kilobyte@angband.pl>)
 id 1hszSf-0002Pq-Bg; Thu, 01 Aug 2019 03:00:55 +0200
Received: from kilobyte by valinor.angband.pl with local (Exim 4.92)
 (envelope-from <kilobyte@valinor.angband.pl>)
 id 1hszSf-000Eou-4W; Thu, 01 Aug 2019 03:00:53 +0200
From: Adam Borowski <kilobyte@angband.pl>
To: linux-nvdimm@lists.01.org
Date: Thu,  1 Aug 2019 03:00:44 +0200
Message-Id: <20190801010044.56927-1-kilobyte@angband.pl>
X-Mailer: git-send-email 2.23.0.rc0
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:a31c:853f:a300::4
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on tartarus.angband.pl
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=8.0 tests=BAYES_00=-1.9, RDNS_NONE=0.793,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no languages=en
Subject: [PATCH] daxctl: link against libndctl,
 in case its use doesn't get pruned
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Adam Borowski <kilobyte@angband.pl>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

util/json.c uses libndctl symbols, and is included by daxctl.  These
functions should then get pruned as unused, but on some platforms the
toolchain fails to do so.

These platforms are ia64, hppa and 32-bit powerpc.  It's generally a
waste of our time to build ndctl there, but as the lack of a
build-dependency requires annoying workarounds higher in the stack,
this has been requested in https://bugs.debian.org/914348 -- and is
trivially fixable on the ndctl side.

Thanks to -Wl,--as-needed there's no harm to architectures where the
pruning works, thus let's not bother with detection.

As daxctl and libdaxctl are separate, there's no circular dependency.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 daxctl/Makefile.am | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/daxctl/Makefile.am b/daxctl/Makefile.am
index 94f73f9..a5487d6 100644
--- a/daxctl/Makefile.am
+++ b/daxctl/Makefile.am
@@ -21,4 +21,5 @@ daxctl_LDADD =\
 	lib/libdaxctl.la \
 	../libutil.a \
 	$(UUID_LIBS) \
-	$(JSON_LIBS)
+	$(JSON_LIBS) \
+	../ndctl/lib/libndctl.la
-- 
2.23.0.rc0

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

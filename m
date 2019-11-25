Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B08D2109170
	for <lists+linux-nvdimm@lfdr.de>; Mon, 25 Nov 2019 16:59:37 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7264810113308;
	Mon, 25 Nov 2019 08:02:58 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2001:41d0:602:dbe::8; helo=tartarus.angband.pl; envelope-from=kilobyte@angband.pl; receiver=<UNKNOWN> 
Received: from tartarus.angband.pl (tartarus.angband.pl [IPv6:2001:41d0:602:dbe::8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6516E10113307
	for <linux-nvdimm@lists.01.org>; Mon, 25 Nov 2019 08:02:54 -0800 (PST)
Received: from [2a02:a31c:853f:a300::4] (helo=valinor.angband.pl)
	by tartarus.angband.pl with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <kilobyte@angband.pl>)
	id 1iZGlo-00075q-RC; Mon, 25 Nov 2019 16:59:26 +0100
Received: from kilobyte by valinor.angband.pl with local (Exim 4.93-RC4)
	(envelope-from <kilobyte@valinor.angband.pl>)
	id 1iZGlo-000M37-1Z; Mon, 25 Nov 2019 16:59:24 +0100
From: Adam Borowski <kilobyte@angband.pl>
To: linux-nvdimm@lists.01.org,
	"Verma, Vishal L" <vishal.l.verma@intel.com>
Cc: Adam Borowski <kilobyte@angband.pl>
Date: Mon, 25 Nov 2019 16:59:19 +0100
Message-Id: <20191125155919.84706-1-kilobyte@angband.pl>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:a31c:853f:a300::4
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on tartarus.angband.pl
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=8.0 tests=BAYES_50=0.8,RDNS_NONE=0.793,
	SPF_PASS=-0.001 autolearn=no autolearn_force=no languages=en
Subject: [ndctl PATCH] Documentation: fix a typo in the ndctl-create-namespace man page
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Message-ID-Hash: VOUQJDOSMOVGGV47ELLW72SBBL2MHV4G
X-Message-ID-Hash: VOUQJDOSMOVGGV47ELLW72SBBL2MHV4G
X-MailFrom: kilobyte@angband.pl
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VOUQJDOSMOVGGV47ELLW72SBBL2MHV4G/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

"namepsace".

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 Documentation/ndctl/ndctl-create-namespace.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ndctl/ndctl-create-namespace.txt b/Documentation/ndctl/ndctl-create-namespace.txt
index e29a5e7..bf7486b 100644
--- a/Documentation/ndctl/ndctl-create-namespace.txt
+++ b/Documentation/ndctl/ndctl-create-namespace.txt
@@ -97,7 +97,7 @@ OPTIONS
 	suffixes "k" or "K" for KiB, "m" or "M" for MiB, "g" or "G" for
 	GiB and "t" or "T" for TiB.
 
-	For pmem namepsaces the size must be a multiple of the
+	For pmem namespaces the size must be a multiple of the
 	interleave-width and the namespace alignment (see
 	below).
 
-- 
2.24.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

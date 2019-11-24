Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEB8108507
	for <lists+linux-nvdimm@lfdr.de>; Sun, 24 Nov 2019 22:14:08 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C3C70100DC3EF;
	Sun, 24 Nov 2019 13:17:29 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5BC3D100DC3EE
	for <linux-nvdimm@lists.01.org>; Sun, 24 Nov 2019 13:17:27 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Nov 2019 13:14:03 -0800
X-IronPort-AV: E=Sophos;i="5.69,239,1571727600";
   d="scan'208";a="210912404"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Nov 2019 13:14:03 -0800
Subject: [PATCH v3 1/3] MAINTAINERS: Reclaim the P: tag for Maintainer Entry
 Profile
From: Dan Williams <dan.j.williams@intel.com>
To: corbet@lwn.net
Date: Sun, 24 Nov 2019 12:59:48 -0800
Message-ID: <157462918794.1729495.10838545318307341653.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157462918268.1729495.10257190766638995699.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157462918268.1729495.10257190766638995699.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: VV73YAJV37CWU7CIWE7772MIZRKOKOWJ
X-Message-ID-Hash: VV73YAJV37CWU7CIWE7772MIZRKOKOWJ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-doc@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VV73YAJV37CWU7CIWE7772MIZRKOKOWJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Fixup some P: entries to be M: and delete the others that do not include an
email address. The P: tag will be used to indicate the location of a
Profile for a given MAINTAINERS entry.

Cc: Joe Perches <joe@perches.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 MAINTAINERS |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e7a47b5210fd..3f171339df53 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -76,7 +76,6 @@ trivial patch so apply some common sense.
 
 Descriptions of section entries:
 
-	P: Person (obsolete)
 	M: Mail patches to: FullName <address@domain>
 	R: Designated reviewer: FullName <address@domain>
 	   These reviewers should be CCed on patches.
@@ -811,7 +810,7 @@ S:	Orphan
 F:	drivers/usb/gadget/udc/amd5536udc.*
 
 AMD GEODE PROCESSOR/CHIPSET SUPPORT
-P:	Andres Salomon <dilinger@queued.net>
+M:	Andres Salomon <dilinger@queued.net>
 L:	linux-geode@lists.infradead.org (moderated for non-subscribers)
 W:	http://www.amd.com/us-en/ConnectivitySolutions/TechnicalResources/0,,50_2334_2452_11363,00.html
 S:	Supported
@@ -10085,7 +10084,6 @@ F:	drivers/staging/media/tegra-vde/
 
 MEDIA INPUT INFRASTRUCTURE (V4L/DVB)
 M:	Mauro Carvalho Chehab <mchehab@kernel.org>
-P:	LinuxTV.org Project
 L:	linux-media@vger.kernel.org
 W:	https://linuxtv.org
 Q:	http://patchwork.kernel.org/project/linux-media/list/
@@ -13452,7 +13450,6 @@ S:	Maintained
 F:	arch/mips/ralink
 
 RALINK RT2X00 WIRELESS LAN DRIVER
-P:	rt2x00 project
 M:	Stanislaw Gruszka <sgruszka@redhat.com>
 M:	Helmut Schaa <helmut.schaa@googlemail.com>
 L:	linux-wireless@vger.kernel.org
@@ -13787,7 +13784,6 @@ S:	Supported
 F:	drivers/net/ethernet/rocker/
 
 ROCKETPORT DRIVER
-P:	Comtrol Corp.
 W:	http://www.comtrol.com
 S:	Maintained
 F:	Documentation/driver-api/serial/rocket.rst
@@ -14668,15 +14664,13 @@ F:	drivers/video/fbdev/simplefb.c
 F:	include/linux/platform_data/simplefb.h
 
 SIMTEC EB110ATX (Chalice CATS)
-P:	Ben Dooks
-P:	Vincent Sanders <vince@simtec.co.uk>
+M:	Vincent Sanders <vince@simtec.co.uk>
 M:	Simtec Linux Team <linux@simtec.co.uk>
 W:	http://www.simtec.co.uk/products/EB110ATX/
 S:	Supported
 
 SIMTEC EB2410ITX (BAST)
-P:	Ben Dooks
-P:	Vincent Sanders <vince@simtec.co.uk>
+M:	Vincent Sanders <vince@simtec.co.uk>
 M:	Simtec Linux Team <linux@simtec.co.uk>
 W:	http://www.simtec.co.uk/products/EB2410ITX/
 S:	Supported
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

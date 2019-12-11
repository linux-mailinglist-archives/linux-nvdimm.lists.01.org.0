Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB63711A0A5
	for <lists+linux-nvdimm@lfdr.de>; Wed, 11 Dec 2019 02:44:11 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1C02B10113602;
	Tue, 10 Dec 2019 17:47:32 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 475E710113507
	for <linux-nvdimm@lists.01.org>; Tue, 10 Dec 2019 17:47:29 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 17:44:07 -0800
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600";
   d="scan'208";a="207504762"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 17:44:07 -0800
Subject: [ndctl PATCH 1/4] ndctl/build: Do not use `check-news` when `NEWS`
 file is absent entirely.
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Tue, 10 Dec 2019 17:29:51 -0800
Message-ID: <157602779173.1290519.2114609018855604805.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: PIL6SVUJSCPEQA3RAZ2643MSPR32O2IV
X-Message-ID-Hash: PIL6SVUJSCPEQA3RAZ2643MSPR32O2IV
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Auke Kok <auke-jan.h.kok@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PIL6SVUJSCPEQA3RAZ2643MSPR32O2IV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Auke Kok <auke-jan.h.kok@intel.com>

Kill 'check-news' in AM_INIT_AUTOMAKE.

Signed-off-by: Auke Kok <auke-jan.h.kok@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 configure.ac |    1 -
 1 file changed, 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 4737cfff77f2..5ec8d2f87598 100644
--- a/configure.ac
+++ b/configure.ac
@@ -8,7 +8,6 @@ AC_INIT([ndctl],
 AC_CONFIG_SRCDIR([ndctl/lib/libndctl.c])
 AC_CONFIG_AUX_DIR([build-aux])
 AM_INIT_AUTOMAKE([
-	check-news
 	foreign
 	1.11
 	-Wall
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

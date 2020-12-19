Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E466C2DEDEC
	for <lists+linux-nvdimm@lfdr.de>; Sat, 19 Dec 2020 10:18:18 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 55011100ED4A3;
	Sat, 19 Dec 2020 01:18:17 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 19D80100EF254
	for <linux-nvdimm@lists.01.org>; Sat, 19 Dec 2020 01:18:13 -0800 (PST)
IronPort-SDR: QSrFOz9psk2FegOTfjCs+f4YAxYg6XHFp7EnnWXfopeyJJvdmrxVT46pfj7/VnMhnEsMOZjT+Q
 w5B46VkCT0Ig==
X-IronPort-AV: E=McAfee;i="6000,8403,9839"; a="175703437"
X-IronPort-AV: E=Sophos;i="5.78,433,1599548400";
   d="scan'208";a="175703437"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2020 01:18:13 -0800
IronPort-SDR: ndmDxcMmjP8GjSngRQ4Cwub8zf9HMDCeO9PnFmAvgEBWsVmVD2OzXGwt0FjKDGIntTbPLCH+Z/
 KsLGj/0P4F+w==
X-IronPort-AV: E=Sophos;i="5.78,433,1599548400";
   d="scan'208";a="454657716"
Received: from mvchisti-mobl1.amr.corp.intel.com (HELO omniknight.intel.com) ([10.251.13.237])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2020 01:18:12 -0800
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [ndctl PATCH] ndctl.spec.in: update for license reworks
Date: Sat, 19 Dec 2020 02:18:06 -0700
Message-Id: <20201219091806.119454-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Message-ID-Hash: Q5QUDWYFG4ACP6P4QU56MGCDARHZ7LF6
X-Message-ID-Hash: Q5QUDWYFG4ACP6P4QU56MGCDARHZ7LF6
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Q5QUDWYFG4ACP6P4QU56MGCDARHZ7LF6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Commit 14eacf0d694a ("Rework license identification") reworked license
identification, making the files listed in ndctl.spec.in for %license
obsolete. This updates those sections in the RPM spec to match the
current layout of license files.

Fixes: 14eacf0d694a ("Rework license identification")
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 ndctl.spec.in | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/ndctl.spec.in b/ndctl.spec.in
index 056c530..0563b2d 100644
--- a/ndctl.spec.in
+++ b/ndctl.spec.in
@@ -109,7 +109,7 @@ make check
 
 %files
 %defattr(-,root,root)
-%license util/COPYING licenses/BSD-MIT licenses/CC0
+%license LICENSES/preferred/GPL-2.0 LICENSES/other/MIT LICENSES/other/CC0-1.0
 %{_bindir}/ndctl
 %{_mandir}/man1/ndctl*
 %{bashcompdir}/
@@ -121,7 +121,7 @@ make check
 
 %files -n daxctl
 %defattr(-,root,root)
-%license util/COPYING licenses/BSD-MIT licenses/CC0
+%license LICENSES/preferred/GPL-2.0 LICENSES/other/MIT LICENSES/other/CC0-1.0
 %{_bindir}/daxctl
 %{_mandir}/man1/daxctl*
 %{_datadir}/daxctl/daxctl.conf
@@ -129,25 +129,25 @@ make check
 %files -n LNAME
 %defattr(-,root,root)
 %doc README.md
-%license COPYING licenses/BSD-MIT licenses/CC0
+%license LICENSES/preferred/LGPL-2.1 LICENSES/other/MIT LICENSES/other/CC0-1.0
 %{_libdir}/libndctl.so.*
 
 %files -n DAX_LNAME
 %defattr(-,root,root)
 %doc README.md
-%license COPYING licenses/BSD-MIT licenses/CC0
+%license LICENSES/preferred/LGPL-2.1 LICENSES/other/MIT LICENSES/other/CC0-1.0
 %{_libdir}/libdaxctl.so.*
 
 %files -n DNAME
 %defattr(-,root,root)
-%license COPYING
+%license LICENSES/preferred/LGPL-2.1
 %{_includedir}/ndctl/
 %{_libdir}/libndctl.so
 %{_libdir}/pkgconfig/libndctl.pc
 
 %files -n DAX_DNAME
 %defattr(-,root,root)
-%license COPYING
+%license LICENSES/preferred/LGPL-2.1
 %{_includedir}/daxctl/
 %{_libdir}/libdaxctl.so
 %{_libdir}/pkgconfig/libdaxctl.pc
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA4F285577
	for <lists+linux-nvdimm@lfdr.de>; Wed,  7 Oct 2020 02:33:52 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 495401564FF25;
	Tue,  6 Oct 2020 17:33:50 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6FE691564FF23
	for <linux-nvdimm@lists.01.org>; Tue,  6 Oct 2020 17:33:48 -0700 (PDT)
IronPort-SDR: PpxFK87G9JH1eoT6LoGtWAYJCpJEGs3WhRXfNa3pc58FDJrg10xdUKR1WvI4ReNWlpYUTxbQMU
 6xvmiZBpPPrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="226353944"
X-IronPort-AV: E=Sophos;i="5.77,344,1596524400";
   d="scan'208";a="226353944"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 17:33:47 -0700
IronPort-SDR: XtJZI8WpLo1nGKAfxDs6IXQ4HQZcfrGtMdexGl5fot0mI0QwUznf8LvotjPDVj38RFjS7162I1
 qiUFM/t9YcaQ==
X-IronPort-AV: E=Sophos;i="5.77,344,1596524400";
   d="scan'208";a="527691390"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 17:33:47 -0700
Subject: [ndctl PATCH] build: Use asciidoc instead of asciidoctor on RHEL
From: Dan Williams <dan.j.williams@intel.com>
To: vishal.l.verma@intel.com
Date: Tue, 06 Oct 2020 17:15:18 -0700
Message-ID: <160202971887.2226623.15926843846532516993.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: 3XL6XZPNQJCTRS2QDAJUT63YTXS7DKRO
X-Message-ID-Hash: 3XL6XZPNQJCTRS2QDAJUT63YTXS7DKRO
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3XL6XZPNQJCTRS2QDAJUT63YTXS7DKRO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Until RHEL moves to asciidoctor fallback to the old asciidoc for RHEL
builds.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 ndctl.spec.in |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/ndctl.spec.in b/ndctl.spec.in
index 94e15ad309c5..056c53069082 100644
--- a/ndctl.spec.in
+++ b/ndctl.spec.in
@@ -9,7 +9,12 @@ Source0:	https://github.com/pmem/%{name}/archive/v%{version}.tar.gz#/%{name}-%{v
 Requires:	LNAME%{?_isa} = %{version}-%{release}
 Requires:	DAX_LNAME%{?_isa} = %{version}-%{release}
 BuildRequires:	autoconf
+%if 0%{?rhel} < 9
+BuildRequires:	asciidoc
+%define asciidoc --disable-asciidoctor
+%else
 BuildRequires:	rubygem-asciidoctor
+%endif
 BuildRequires:	xmlto
 BuildRequires:	automake
 BuildRequires:	libtool
@@ -86,7 +91,7 @@ control API for these devices.
 %build
 echo %{version} > version
 ./autogen.sh
-%configure --disable-static --disable-silent-rules
+%configure --disable-static --disable-silent-rules %{?asciidoc}
 make %{?_smp_mflags}
 
 %install
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

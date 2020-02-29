Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 536DE174948
	for <lists+linux-nvdimm@lfdr.de>; Sat, 29 Feb 2020 21:37:38 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A4E8E10FC340B;
	Sat, 29 Feb 2020 12:38:28 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 02ADC10FC3405
	for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 12:38:26 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:37:35 -0800
X-IronPort-AV: E=Sophos;i="5.70,501,1574150400";
   d="scan'208";a="227910550"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:37:34 -0800
Subject: [ndctl PATCH 16/36] ndctl/build: Fix EXTRA_DIST already defined
 errors
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: vishal.l.verma@intel.com
Date: Sat, 29 Feb 2020 12:21:30 -0800
Message-ID: <158300768999.2141307.6599316446449107713.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: 7KH7JFK5BDUVSYT5RC74FVCZQQUGXS5R
X-Message-ID-Hash: 7KH7JFK5BDUVSYT5RC74FVCZQQUGXS5R
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7KH7JFK5BDUVSYT5RC74FVCZQQUGXS5R/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Append rather than assign files to EXTRA_DIST in test/Makefile.am to fix
warnings like:

test/Makefile.am:30: warning: EXTRA_DIST multiply defined in condition TRUE ...
Makefile.am.in:1: ... 'EXTRA_DIST' previously defined here
test/Makefile.am:1:   'Makefile.am.in' included from here

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test/Makefile.am |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/Makefile.am b/test/Makefile.am
index 58873a6bc341..bde491247a47 100644
--- a/test/Makefile.am
+++ b/test/Makefile.am
@@ -27,7 +27,7 @@ TESTS =\
 	max_available_extent_ns.sh \
 	pfn-meta-errors.sh
 
-EXTRA_DIST = $(TESTS) common \
+EXTRA_DIST += $(TESTS) common \
 		btt-pad-compat.xxd \
 		nmem1.bin nmem2.bin nmem3.bin nmem4.bin
 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

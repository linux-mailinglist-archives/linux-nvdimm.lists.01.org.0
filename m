Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1DB11A0A7
	for <lists+linux-nvdimm@lfdr.de>; Wed, 11 Dec 2019 02:44:22 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4237010113620;
	Tue, 10 Dec 2019 17:47:43 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 250371011361E
	for <linux-nvdimm@lists.01.org>; Tue, 10 Dec 2019 17:47:40 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 17:44:17 -0800
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600";
   d="scan'208";a="215624266"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 17:44:17 -0800
Subject: [ndctl PATCH 3/4] ndctl/build: Add `header` as a prereq to Make
 rule where it is consumed.
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Tue, 10 Dec 2019 17:30:02 -0800
Message-ID: <157602780196.1290519.15782744704303465909.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157602779173.1290519.2114609018855604805.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157602779173.1290519.2114609018855604805.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: PGDAOOFO6Y5KHO2YFZT6DMD57PDTCFUM
X-Message-ID-Hash: PGDAOOFO6Y5KHO2YFZT6DMD57PDTCFUM
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Auke Kok <auke-jan.h.kok@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PGDAOOFO6Y5KHO2YFZT6DMD57PDTCFUM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Auke Kok <auke-jan.h.kok@intel.com>

Ensure that changes to 'header' trigger a rebuild.

Signed-off-by: Auke Kok <auke-jan.h.kok@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Makefile.am |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 95950d4f708e..60a1998723c2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -38,7 +38,7 @@ do_sles_subst = sed -e 's,VERSION,$(VERSION),g' \
 rhel/ndctl.spec: ndctl.spec.in Makefile.am version.m4
 	$(AM_V_GEN)$(MKDIR_P) rhel; $(do_rhel_subst) < $< > $@
 
-sles/ndctl.spec: ndctl.spec.in Makefile.am version.m4
+sles/ndctl.spec: sles/header ndctl.spec.in Makefile.am version.m4
 	$(AM_V_GEN)$(MKDIR_P) sles; cat sles/header $< | $(do_sles_subst) > $@
 
 if ENABLE_BASH_COMPLETION
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

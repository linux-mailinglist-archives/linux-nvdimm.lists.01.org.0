Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60013174955
	for <lists+linux-nvdimm@lfdr.de>; Sat, 29 Feb 2020 21:38:41 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C69F410FC3596;
	Sat, 29 Feb 2020 12:39:31 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E0F4410FC3520
	for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 12:39:25 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:38:34 -0800
X-IronPort-AV: E=Sophos;i="5.70,501,1574150400";
   d="scan'208";a="273074026"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:38:33 -0800
Subject: [ndctl PATCH 27/36] ndctl/test: Relax dax_pmem_compat requirement
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sat, 29 Feb 2020 12:22:28 -0800
Message-ID: <158300774836.2141307.13052648687237614794.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: R2GVD5LWAH2R3FHHOZRR2H5GYFENVT4N
X-Message-ID-Hash: R2GVD5LWAH2R3FHHOZRR2H5GYFENVT4N
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jan Kara <jack@suse.cz>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/R2GVD5LWAH2R3FHHOZRR2H5GYFENVT4N/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

While there are some tests that require the new "dax-bus" device model,
none of the tests require compatibility mode. Drop the requirement so
the tests work with DEV_DAX_PMEM_COMPAT=n kernels.

Link: http://lore.kernel.org/r/20200123154720.12097-1-jack@suse.cz
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test/core.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/test/core.c b/test/core.c
index 888f5d8c0e42..dff842a9f378 100644
--- a/test/core.c
+++ b/test/core.c
@@ -180,6 +180,14 @@ int nfit_test_init(struct kmod_ctx **ctx, struct kmod_module **mod,
 
 retry:
 		rc = kmod_module_new_from_name(*ctx, name, mod);
+
+		/*
+		 * dax_pmem_compat is not required, missing is ok,
+		 * present-but-production is not ok.
+		 */
+		if (rc && strstr(name, "dax_pmem_compat"))
+			continue;
+
 		if (rc) {
 			log_err(&log_ctx, "%s.ko: missing\n", name);
 			break;
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

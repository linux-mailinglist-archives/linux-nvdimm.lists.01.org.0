Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C96178630
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Mar 2020 00:14:45 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2380E10FC3619;
	Tue,  3 Mar 2020 15:15:35 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 475FC10FC3617
	for <linux-nvdimm@lists.01.org>; Tue,  3 Mar 2020 15:15:32 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 15:14:41 -0800
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400";
   d="scan'208";a="258543880"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 15:14:40 -0800
Subject: [ndctl PATCH v2 2/2] ndctl/test: Relax dax_pmem_compat requirement
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Tue, 03 Mar 2020 14:58:35 -0800
Message-ID: <158327631566.2222444.16879386597302511191.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158300774836.2141307.13052648687237614794.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158300774836.2141307.13052648687237614794.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: 2CPK72PR7JNCLRITY76OF3K4F65757XP
X-Message-ID-Hash: 2CPK72PR7JNCLRITY76OF3K4F65757XP
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jan Kara <jack@suse.cz>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2CPK72PR7JNCLRITY76OF3K4F65757XP/>
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
index 3aa746fe6786..5118d86483d4 100644
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
+		if (rc && strcmp(name, "dax_pmem_compat") == 0)
+			continue;
+
 		if (rc) {
 			log_err(&log_ctx, "%s.ko: missing\n", name);
 			break;
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

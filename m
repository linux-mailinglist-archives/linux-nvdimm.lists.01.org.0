Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B4B3247A5
	for <lists+linux-nvdimm@lfdr.de>; Thu, 25 Feb 2021 00:48:33 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4D339100EB346;
	Wed, 24 Feb 2021 15:48:31 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=erwin.tsaur@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 94C04100EC1D5
	for <linux-nvdimm@lists.01.org>; Wed, 24 Feb 2021 15:48:29 -0800 (PST)
IronPort-SDR: VtT3alBYpKHn1pXR1Jo4QboGPCwHDYvJrPZEIn9E6ApfACSxMrAGll7SoACLTcnzQr7vIV/zhs
 vptQZRwnSJZg==
X-IronPort-AV: E=McAfee;i="6000,8403,9905"; a="185464392"
X-IronPort-AV: E=Sophos;i="5.81,203,1610438400";
   d="scan'208";a="185464392"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 15:48:28 -0800
IronPort-SDR: o86VkoNu65+aHA2VHimRvgdxJ+cQ9ddgscMGXQ0mwxtpJYQ+1jACpfx/Y7oHU9S58iJbgPoDz6
 NlDVC/a0xy2Q==
X-IronPort-AV: E=Sophos;i="5.81,203,1610438400";
   d="scan'208";a="391821210"
Received: from etsaur-mobl1.amr.corp.intel.com ([10.209.131.141])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 15:48:28 -0800
From: "Tsaur, Erwin" <erwin.tsaur@intel.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH] Expose ndctl_bus_nfit_translate_spa as a public function.
Date: Wed, 24 Feb 2021 15:48:14 -0800
Message-Id: <20210224234814.1021-1-erwin.tsaur@intel.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Message-ID-Hash: MHUJEUXEYESGKAWYQWI2JKWI3RJU4ZNS
X-Message-ID-Hash: MHUJEUXEYESGKAWYQWI2JKWI3RJU4ZNS
X-MailFrom: erwin.tsaur@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Tsaur, Erwin" <erwin.tsaur@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MHUJEUXEYESGKAWYQWI2JKWI3RJU4ZNS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The motivation is to allow access to ACPI defined NVDIMM Root Device _DSM Function Index 5(Translate SPA).  The rest of the _DSM functions, which are mostly ARS related, are already public.

Basically move ndctl_bus_nfit_translate_spa declaration from private.h to libndctl.h.
---
 ndctl/lib/libndctl.sym | 4 ++++
 ndctl/lib/nfit.c       | 2 +-
 ndctl/lib/private.h    | 2 --
 ndctl/libndctl.h       | 2 ++
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/ndctl/lib/libndctl.sym b/ndctl/lib/libndctl.sym
index 0a82616..58afb74 100644
--- a/ndctl/lib/libndctl.sym
+++ b/ndctl/lib/libndctl.sym
@@ -451,3 +451,7 @@ LIBNDCTL_25 {
 	ndctl_bus_clear_fw_activate_nosuspend;
 	ndctl_bus_activate_firmware;
 } LIBNDCTL_24;
+
+LIBNDCTL_26 {
+	ndctl_bus_nfit_translate_spa;
+} LIBNDCTL_25;
diff --git a/ndctl/lib/nfit.c b/ndctl/lib/nfit.c
index 6f68fcf..d85682f 100644
--- a/ndctl/lib/nfit.c
+++ b/ndctl/lib/nfit.c
@@ -114,7 +114,7 @@ static int is_valid_spa(struct ndctl_bus *bus, unsigned long long spa)
  *
  * If success, returns zero, store dimm's @handle, and @dpa.
  */
-int ndctl_bus_nfit_translate_spa(struct ndctl_bus *bus,
+NDCTL_EXPORT int ndctl_bus_nfit_translate_spa(struct ndctl_bus *bus,
 	unsigned long long address, unsigned int *handle, unsigned long long *dpa)
 {
 
diff --git a/ndctl/lib/private.h b/ndctl/lib/private.h
index ede1300..8f4510e 100644
--- a/ndctl/lib/private.h
+++ b/ndctl/lib/private.h
@@ -370,8 +370,6 @@ static inline int check_kmod(struct kmod_ctx *kmod_ctx)
 	return kmod_ctx ? 0 : -ENXIO;
 }
 
-int ndctl_bus_nfit_translate_spa(struct ndctl_bus *bus, unsigned long long addr,
-		unsigned int *handle, unsigned long long *dpa);
 struct ndctl_cmd *ndctl_bus_cmd_new_err_inj(struct ndctl_bus *bus);
 struct ndctl_cmd *ndctl_bus_cmd_new_err_inj_clr(struct ndctl_bus *bus);
 struct ndctl_cmd *ndctl_bus_cmd_new_err_inj_stat(struct ndctl_bus *bus,
diff --git a/ndctl/libndctl.h b/ndctl/libndctl.h
index 60e1288..ee517a7 100644
--- a/ndctl/libndctl.h
+++ b/ndctl/libndctl.h
@@ -237,6 +237,8 @@ unsigned long long ndctl_cmd_clear_error_get_cleared(
 		struct ndctl_cmd *clear_err);
 unsigned int ndctl_cmd_ars_cap_get_clear_unit(struct ndctl_cmd *ars_cap);
 int ndctl_cmd_ars_stat_get_flag_overflow(struct ndctl_cmd *ars_stat);
+int ndctl_bus_nfit_translate_spa(struct ndctl_bus *bus, unsigned long long addr,
+		unsigned int *handle, unsigned long long *dpa);
 
 /*
  * Note: ndctl_cmd_smart_get_temperature is an alias for
-- 
2.30.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

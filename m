Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FB832BB12
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Mar 2021 22:11:40 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0FC36100EB35A;
	Wed,  3 Mar 2021 13:11:39 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=erwin.tsaur@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8B15D100EB357
	for <linux-nvdimm@lists.01.org>; Wed,  3 Mar 2021 13:11:36 -0800 (PST)
IronPort-SDR: 6sFPLHrblAXS/D8rzxRXaZRwaLLbR/tSk+KyselmcKdf7gtdLiIV944LLcUFLvylxiescEMiez
 yU46mL33QgRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="166535898"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400";
   d="scan'208";a="166535898"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 13:11:35 -0800
IronPort-SDR: MObz3YjQt1eTt4k9MXtw2vtV0CWHHlTu5VuWykKHQXQXwf8zLimCX40WQrdYybDiJH9pxm1imN
 tFZ2YePgFfdg==
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400";
   d="scan'208";a="428409968"
Received: from etsaur-mobl1.amr.corp.intel.com ([10.209.143.16])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 13:11:34 -0800
From: "Tsaur, Erwin" <erwin.tsaur@intel.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH v2] Expose ndctl_bus_nfit_translate_spa as a public function.
Date: Wed,  3 Mar 2021 13:10:09 -0800
Message-Id: <20210303211009.2913-1-erwin.tsaur@intel.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Message-ID-Hash: E37O244244FXWIVMWTBOM6JNZ37P726F
X-Message-ID-Hash: E37O244244FXWIVMWTBOM6JNZ37P726F
X-MailFrom: erwin.tsaur@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Tsaur, Erwin" <erwin.tsaur@intel.com>, Verma@ml01.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/E37O244244FXWIVMWTBOM6JNZ37P726F/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The motivation is to allow access to ACPI defined NVDIMM Root Device
_DSM Function Index 5(Translate SPA).  The rest of the _DSM functions,
which are mostly ARS related, are already public.

Basically move ndctl_bus_nfit_translate_spa declaration from private.h
to libndctl.h.

Changes from V1:
- Group function declaration in libndctl.h with other ndctl_bus_* functions.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Verma, Vishal L <vishal.l.verma@intel.com>
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
index 60e1288..87d07b7 100644
--- a/ndctl/libndctl.h
+++ b/ndctl/libndctl.h
@@ -152,6 +152,8 @@ int ndctl_bus_clear_fw_activate_noidle(struct ndctl_bus *bus);
 int ndctl_bus_set_fw_activate_nosuspend(struct ndctl_bus *bus);
 int ndctl_bus_clear_fw_activate_nosuspend(struct ndctl_bus *bus);
 int ndctl_bus_activate_firmware(struct ndctl_bus *bus, enum ndctl_fwa_method method);
+int ndctl_bus_nfit_translate_spa(struct ndctl_bus *bus, unsigned long long addr,
+		unsigned int *handle, unsigned long long *dpa);
 
 struct ndctl_dimm;
 struct ndctl_dimm *ndctl_dimm_get_first(struct ndctl_bus *bus);
-- 
2.30.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

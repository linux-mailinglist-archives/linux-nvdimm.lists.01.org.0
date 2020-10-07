Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B855A2868BD
	for <lists+linux-nvdimm@lfdr.de>; Wed,  7 Oct 2020 22:00:10 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E0E64156A2E90;
	Wed,  7 Oct 2020 13:00:08 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1B5AE156A2E81
	for <linux-nvdimm@lists.01.org>; Wed,  7 Oct 2020 13:00:01 -0700 (PDT)
IronPort-SDR: UU1FqxODGZbBYEf46yN7VueQveiqEe2W89Rv2WxDOfV/Vs2+UusSaguCb3irOwLKp+tfRzvsky
 MUzjoMlJcxjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="151995080"
X-IronPort-AV: E=Sophos;i="5.77,348,1596524400";
   d="scan'208";a="151995080"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 11:43:04 -0700
IronPort-SDR: 28VHoGOndfRnWTasoHT1hQdzfg/1H2hWmZA8KwIuABiy+4waKFUCmBCW10nvcxycazrmxxsp0F
 uzTinV6I+Ylg==
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400";
   d="scan'208";a="297604799"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 11:43:02 -0700
Subject: [PATCH] x86/mce: Gate copy_mc_fragile() export by
 CONFIG_COPY_MC_TEST=y
From: Dan Williams <dan.j.williams@intel.com>
To: bp@alien8.de
Date: Wed, 07 Oct 2020 11:24:32 -0700
Message-ID: <160209507277.2768223.9933672492157583642.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <20201007111447.GA23257@zn.tnic>
References: <20201007111447.GA23257@zn.tnic>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: ULM2VJ44YFXKTCV2RCEPOPAEG7FXMDXB
X-Message-ID-Hash: ULM2VJ44YFXKTCV2RCEPOPAEG7FXMDXB
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ULM2VJ44YFXKTCV2RCEPOPAEG7FXMDXB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

It appears that modpost is not happy about exporting assembly symbols
that are not consumed in the same build. As Boris reports:

    WARNING: modpost: EXPORT symbol "copy_mc_fragile" [vmlinux] version generation failed, symbol will not be versioned.

The export is only consumed in the CONFIG_COPY_MC_TEST=y case, and even
then not in a way that modpost could see. CONFIG_COPY_MC_TEST uses a
module built in tools/testing/nvdimm/ to exercise the copy_mc_fragile()
corner cases.  Given the test already requires manually editing the
config entry for CONFIG_COPY_MC_TEST to make it "def_bool y" the
additional dependency to require is CONFIG_MODVERSIONS=n is not too
onerous.

Alternatively, COPY_MC_TEST and its related infrastructure could just be
ripped out because it has served its purpose. For now, just stop
exporting the symbol by default, and add the MODVERSIONS dependency to
the test.

Fixes: ec6347bb4339 ("x86, powerpc: Rename memcpy_mcsafe() to copy_mc_to_{user, kernel}()")
Reported-by: Borislav Petkov <bp@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/Kconfig.debug    |    1 +
 arch/x86/lib/copy_mc_64.S |    2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 27b5e2bc6a01..6f0f5d8ac62e 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -63,6 +63,7 @@ config EARLY_PRINTK_USB_XDBC
 	  crashes or need a very simple printk logging facility.
 
 config COPY_MC_TEST
+	depends on !MODVERSIONS
 	def_bool n
 
 config EFI_PGT_DUMP
diff --git a/arch/x86/lib/copy_mc_64.S b/arch/x86/lib/copy_mc_64.S
index 892d8915f609..50fb05256751 100644
--- a/arch/x86/lib/copy_mc_64.S
+++ b/arch/x86/lib/copy_mc_64.S
@@ -88,7 +88,9 @@ SYM_FUNC_START(copy_mc_fragile)
 .L_done:
 	ret
 SYM_FUNC_END(copy_mc_fragile)
+#ifdef CONFIG_COPY_MC_TEST
 EXPORT_SYMBOL_GPL(copy_mc_fragile)
+#endif
 
 	.section .fixup, "ax"
 	/*
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

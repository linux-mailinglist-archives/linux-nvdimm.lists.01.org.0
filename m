Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB633F249C
	for <lists+linux-nvdimm@lfdr.de>; Thu,  7 Nov 2019 02:57:27 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 57879100DC3FC;
	Wed,  6 Nov 2019 17:59:56 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D51FA100DC3F9
	for <linux-nvdimm@lists.01.org>; Wed,  6 Nov 2019 17:59:54 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 17:57:22 -0800
X-IronPort-AV: E=Sophos;i="5.68,276,1569308400";
   d="scan'208";a="377262864"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 17:57:22 -0800
Subject: [PATCH v8 03/12] x86/efi: Push EFI_MEMMAP check into leaf routines
From: Dan Williams <dan.j.williams@intel.com>
To: mingo@redhat.com
Date: Wed, 06 Nov 2019 17:43:05 -0800
Message-ID: <157309098587.1579826.3091374053198566488.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157309097008.1579826.12818463304589384434.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157309097008.1579826.12818463304589384434.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Message-ID-Hash: JMFCU6IXPBSETRYB47VRL2WCRIQGK37U
X-Message-ID-Hash: JMFCU6IXPBSETRYB47VRL2WCRIQGK37U
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-efi@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JMFCU6IXPBSETRYB47VRL2WCRIQGK37U/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In preparation for adding another EFI_MEMMAP dependent call that needs
to occur before e820__memblock_setup() fixup the existing efi calls to
check for EFI_MEMMAP internally. This ends up being cleaner than the
alternative of checking EFI_MEMMAP multiple times in setup_arch().

Cc: <x86@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/include/asm/efi.h      |    9 ++++++++-
 arch/x86/kernel/setup.c         |   18 ++++++++----------
 arch/x86/platform/efi/efi.c     |    3 +++
 arch/x86/platform/efi/quirks.c  |    3 +++
 drivers/firmware/efi/esrt.c     |    3 +++
 drivers/firmware/efi/fake_mem.c |    2 +-
 include/linux/efi.h             |    1 -
 7 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 43a82e59c59d..45f853bce869 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -140,7 +140,6 @@ extern void efi_delete_dummy_variable(void);
 extern void efi_switch_mm(struct mm_struct *mm);
 extern void efi_recover_from_page_fault(unsigned long phys_addr);
 extern void efi_free_boot_services(void);
-extern void efi_reserve_boot_services(void);
 
 struct efi_setup_data {
 	u64 fw_vendor;
@@ -244,6 +243,8 @@ static inline bool efi_is_64bit(void)
 extern bool efi_reboot_required(void);
 extern bool efi_is_table_address(unsigned long phys_addr);
 
+extern void efi_find_mirror(void);
+extern void efi_reserve_boot_services(void);
 #else
 static inline void parse_efi_setup(u64 phys_addr, u32 data_len) {}
 static inline bool efi_reboot_required(void)
@@ -254,6 +255,12 @@ static inline  bool efi_is_table_address(unsigned long phys_addr)
 {
 	return false;
 }
+static inline void efi_find_mirror(void)
+{
+}
+static inline void efi_reserve_boot_services(void)
+{
+}
 #endif /* CONFIG_EFI */
 
 #endif /* _ASM_X86_EFI_H */
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 77ea96b794bd..1c4b866bc184 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1122,17 +1122,15 @@ void __init setup_arch(char **cmdline_p)
 
 	reserve_bios_regions();
 
-	if (efi_enabled(EFI_MEMMAP)) {
-		efi_fake_memmap();
-		efi_find_mirror();
-		efi_esrt_init();
+	efi_fake_memmap();
+	efi_find_mirror();
+	efi_esrt_init();
 
-		/*
-		 * The EFI specification says that boot service code won't be
-		 * called after ExitBootServices(). This is, in fact, a lie.
-		 */
-		efi_reserve_boot_services();
-	}
+	/*
+	 * The EFI specification says that boot service code won't be
+	 * called after ExitBootServices(). This is, in fact, a lie.
+	 */
+	efi_reserve_boot_services();
 
 	/* preallocate 4k for mptable mpc */
 	e820__memblock_alloc_reserved_mpc_new();
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 425e025341db..e6e41b118d68 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -128,6 +128,9 @@ void __init efi_find_mirror(void)
 	efi_memory_desc_t *md;
 	u64 mirror_size = 0, total_size = 0;
 
+	if (!efi_enabled(EFI_MEMMAP))
+		return;
+
 	for_each_efi_memory_desc(md) {
 		unsigned long long start = md->phys_addr;
 		unsigned long long size = md->num_pages << EFI_PAGE_SHIFT;
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 3b9fd679cea9..7675cf754d90 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -320,6 +320,9 @@ void __init efi_reserve_boot_services(void)
 {
 	efi_memory_desc_t *md;
 
+	if (!efi_enabled(EFI_MEMMAP))
+		return;
+
 	for_each_efi_memory_desc(md) {
 		u64 start = md->phys_addr;
 		u64 size = md->num_pages << EFI_PAGE_SHIFT;
diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
index d6dd5f503fa2..2762e0662bf4 100644
--- a/drivers/firmware/efi/esrt.c
+++ b/drivers/firmware/efi/esrt.c
@@ -246,6 +246,9 @@ void __init efi_esrt_init(void)
 	int rc;
 	phys_addr_t end;
 
+	if (!efi_enabled(EFI_MEMMAP))
+		return;
+
 	pr_debug("esrt-init: loading.\n");
 	if (!esrt_table_exists())
 		return;
diff --git a/drivers/firmware/efi/fake_mem.c b/drivers/firmware/efi/fake_mem.c
index 9501edc0fcfb..526b45331d96 100644
--- a/drivers/firmware/efi/fake_mem.c
+++ b/drivers/firmware/efi/fake_mem.c
@@ -44,7 +44,7 @@ void __init efi_fake_memmap(void)
 	void *new_memmap;
 	int i;
 
-	if (!nr_fake_mem)
+	if (!efi_enabled(EFI_MEMMAP) || !nr_fake_mem)
 		return;
 
 	/* count up the number of EFI memory descriptor */
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 78c75992b313..44c85b559e15 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1045,7 +1045,6 @@ extern void efi_enter_virtual_mode (void);	/* switch EFI to virtual mode, if pos
 extern efi_status_t efi_query_variable_store(u32 attributes,
 					     unsigned long size,
 					     bool nonblocking);
-extern void efi_find_mirror(void);
 #else
 
 static inline efi_status_t efi_query_variable_store(u32 attributes,
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 248C551AA7
	for <lists+linux-nvdimm@lfdr.de>; Mon, 24 Jun 2019 20:34:10 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EEAFF2129DBBF;
	Mon, 24 Jun 2019 11:34:08 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.115; helo=mga14.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A64EF21296704
 for <linux-nvdimm@lists.01.org>; Mon, 24 Jun 2019 11:34:07 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Jun 2019 11:34:07 -0700
X-IronPort-AV: E=Sophos;i="5.63,413,1557212400"; d="scan'208";a="188004783"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Jun 2019 11:34:06 -0700
Subject: [PATCH v4 04/10] x86, efi: Push EFI_MEMMAP check into leaf routines
From: Dan Williams <dan.j.williams@intel.com>
To: x86@kernel.org
Date: Mon, 24 Jun 2019 11:19:49 -0700
Message-ID: <156140038957.2951909.3922978209175458460.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156140036490.2951909.1837804994781523185.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156140036490.2951909.1837804994781523185.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: ard.biesheuvel@linaro.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 tglx@linutronix.de, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

In preparation for adding another EFI_MEMMAP dependent call that needs
to occur before e820__memblock_setup() fixup the existing efi calls to
check for EFI_MEMMAP internally. This is cleaner than checking
EFI_MEMMAP multiple times in setup_arch().

Cc: <x86@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/include/asm/efi.h      |    9 ++++++++-
 arch/x86/kernel/setup.c         |   19 +++++++++----------
 arch/x86/platform/efi/efi.c     |    3 +++
 arch/x86/platform/efi/quirks.c  |    3 +++
 drivers/firmware/efi/esrt.c     |    3 +++
 drivers/firmware/efi/fake_mem.c |    2 +-
 include/linux/efi.h             |    2 --
 7 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 606a4b6a9812..7d52378e376a 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -140,7 +140,6 @@ extern void efi_delete_dummy_variable(void);
 extern void efi_switch_mm(struct mm_struct *mm);
 extern void efi_recover_from_page_fault(unsigned long phys_addr);
 extern void efi_free_boot_services(void);
-extern void efi_reserve_boot_services(void);
 
 struct efi_setup_data {
 	u64 fw_vendor;
@@ -243,12 +242,20 @@ static inline bool efi_is_64bit(void)
 
 extern bool efi_reboot_required(void);
 
+extern void efi_find_mirror(void);
+extern void efi_reserve_boot_services(void);
 #else
 static inline void parse_efi_setup(u64 phys_addr, u32 data_len) {}
 static inline bool efi_reboot_required(void)
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
index 08a5f4a131f5..b68fd57a8d26 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1103,21 +1103,20 @@ void __init setup_arch(char **cmdline_p)
 	cleanup_highmap();
 
 	memblock_set_current_limit(ISA_END_ADDRESS);
+
 	e820__memblock_setup();
 
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
index e1cb01a22fa8..4e8458b1ca30 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -103,6 +103,9 @@ void __init efi_find_mirror(void)
 	efi_memory_desc_t *md;
 	u64 mirror_size = 0, total_size = 0;
 
+	if (!efi_enabled(EFI_MEMMAP))
+		return;
+
 	for_each_efi_memory_desc(md) {
 		unsigned long long start = md->phys_addr;
 		unsigned long long size = md->num_pages << EFI_PAGE_SHIFT;
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index feb77777c8b8..50f7303da7be 100644
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
index 91368f5ce114..ea6ce3ef71f5 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1042,9 +1042,7 @@ extern void efi_enter_virtual_mode (void);	/* switch EFI to virtual mode, if pos
 extern efi_status_t efi_query_variable_store(u32 attributes,
 					     unsigned long size,
 					     bool nonblocking);
-extern void efi_find_mirror(void);
 #else
-
 static inline efi_status_t efi_query_variable_store(u32 attributes,
 						    unsigned long size,
 						    bool nonblocking)

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

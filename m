Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0ED43054F
	for <lists+linux-nvdimm@lfdr.de>; Fri, 31 May 2019 01:13:29 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A71AB2128A642;
	Thu, 30 May 2019 16:13:28 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.43; helo=mga05.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D40342128A638
 for <linux-nvdimm@lists.01.org>; Thu, 30 May 2019 16:13:26 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 30 May 2019 16:13:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,532,1549958400"; d="scan'208";a="180115547"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by fmsmga002.fm.intel.com with ESMTP; 30 May 2019 16:13:25 -0700
Subject: [PATCH v2 3/8] efi: Enumerate EFI_MEMORY_SP
From: Dan Williams <dan.j.williams@intel.com>
To: linux-efi@vger.kernel.org
Date: Thu, 30 May 2019 15:59:38 -0700
Message-ID: <155925717803.3775979.14412010256191901040.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155925716254.3775979.16716824941364738117.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155925716254.3775979.16716824941364738117.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-nvdimm@lists.01.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

UEFI 2.8 defines an EFI_MEMORY_SP attribute bit to augment the
interpretation of the EFI Memory Types as "reserved for a specific
purpose". The intent of this bit is to allow the OS to identify precious
or scarce memory resources and optionally manage it separately from
EfiConventionalMemory. As defined older OSes that do not know about this
attribute are permitted to ignore it and the memory will be handled
according to the OS default policy for the given memory type.

In other words, this "specific purpose" hint is deliberately weaker than
EfiReservedMemoryType in that the system continues to operate if the OS
takes no action on the attribute. The risk of taking no action is
potentially unwanted / unmovable kernel allocations from the designated
resource that prevent the full realization of the "specific purpose".
For example, consider a system with a high-bandwidth memory pool. Older
kernels are permitted to boot and consume that memory as conventional
"System-RAM" newer kernels may arrange for that memory to be set aside
by the system administrator for a dedicated high-bandwidth memory aware
application to consume.

Specifically, this mechanism allows for the elimination of scenarios
where platform firmware tries to game OS policy by lying about ACPI SLIT
values, i.e. claiming that a precious memory resource has a high
distance to trigger the OS to avoid it by default.

Implement simple detection of the bit for EFI memory table dumps and
save the kernel policy for a follow-on change.

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/firmware/efi/efi.c |    5 +++--
 include/linux/efi.h        |    1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 55b77c576c42..81db09485881 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -848,15 +848,16 @@ char * __init efi_md_typeattr_format(char *buf, size_t size,
 	if (attr & ~(EFI_MEMORY_UC | EFI_MEMORY_WC | EFI_MEMORY_WT |
 		     EFI_MEMORY_WB | EFI_MEMORY_UCE | EFI_MEMORY_RO |
 		     EFI_MEMORY_WP | EFI_MEMORY_RP | EFI_MEMORY_XP |
-		     EFI_MEMORY_NV |
+		     EFI_MEMORY_NV | EFI_MEMORY_SP |
 		     EFI_MEMORY_RUNTIME | EFI_MEMORY_MORE_RELIABLE))
 		snprintf(pos, size, "|attr=0x%016llx]",
 			 (unsigned long long)attr);
 	else
 		snprintf(pos, size,
-			 "|%3s|%2s|%2s|%2s|%2s|%2s|%2s|%3s|%2s|%2s|%2s|%2s]",
+			 "|%3s|%2s|%2s|%2s|%2s|%2s|%2s|%2s|%3s|%2s|%2s|%2s|%2s]",
 			 attr & EFI_MEMORY_RUNTIME ? "RUN" : "",
 			 attr & EFI_MEMORY_MORE_RELIABLE ? "MR" : "",
+			 attr & EFI_MEMORY_SP      ? "SP"  : "",
 			 attr & EFI_MEMORY_NV      ? "NV"  : "",
 			 attr & EFI_MEMORY_XP      ? "XP"  : "",
 			 attr & EFI_MEMORY_RP      ? "RP"  : "",
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 6ebc2098cfe1..91368f5ce114 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -112,6 +112,7 @@ typedef	struct {
 #define EFI_MEMORY_MORE_RELIABLE \
 				((u64)0x0000000000010000ULL)	/* higher reliability */
 #define EFI_MEMORY_RO		((u64)0x0000000000020000ULL)	/* read-only */
+#define EFI_MEMORY_SP		((u64)0x0000000000040000ULL)	/* special purpose */
 #define EFI_MEMORY_RUNTIME	((u64)0x8000000000000000ULL)	/* range requires runtime mapping */
 #define EFI_MEMORY_DESCRIPTOR_VERSION	1
 

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

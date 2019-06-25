Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E098055355
	for <lists+linux-nvdimm@lfdr.de>; Tue, 25 Jun 2019 17:27:03 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 539462129F11B;
	Tue, 25 Jun 2019 08:27:02 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=45.249.212.32; helo=huawei.com;
 envelope-from=jonathan.cameron@huawei.com; receiver=linux-nvdimm@lists.01.org 
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 70B0321296B17
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 08:26:59 -0700 (PDT)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id EBA578A37B00BD432D76;
 Tue, 25 Jun 2019 23:26:50 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Tue, 25 Jun 2019
 23:26:48 +0800
Date: Tue, 25 Jun 2019 16:26:35 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 05/10] x86, efi: Reserve UEFI 2.8 Specific Purpose
 Memory for dax
Message-ID: <20190625162635.00006f12@huawei.com>
In-Reply-To: <156140039574.2951909.3007721710664432872.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156140036490.2951909.1837804994781523185.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156140039574.2951909.3007721710664432872.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
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
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 kbuild test robot <lkp@intel.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy
 Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andy Shevchenko <andy@infradead.org>, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, 24 Jun 2019 11:19:55 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> UEFI 2.8 defines an EFI_MEMORY_SP attribute bit to augment the
> interpretation of the EFI Memory Types as "reserved for a specific
> purpose".
> 
> The proposed Linux behavior for specific purpose memory is that it is
> reserved for direct-access (device-dax) by default and not available for
> any kernel usage, not even as an OOM fallback.  Later, through udev
> scripts or another init mechanism, these device-dax claimed ranges can
> be reconfigured and hot-added to the available System-RAM with a unique
> node identifier.
> 
> This patch introduces 2 new concepts at once given the entanglement
> between early boot enumeration relative to memory that can optionally be
> reserved from the kernel page allocator by default. The new concepts
> are:
> 
> - E820_TYPE_APPLICATION_RESERVED: Upon detecting the EFI_MEMORY_SP
>   attribute on EFI_CONVENTIONAL memory, update the E820 map with this
>   new type. Only perform this classification if the
>   CONFIG_EFI_SPECIFIC_DAX=y policy is enabled, otherwise treat it as
>   typical ram.
> 
> - IORES_DESC_APPLICATION_RESERVED: Add a new I/O resource descriptor for
>   a device driver to search iomem resources for application specific
>   memory. Teach the iomem code to identify such ranges as "Application
>   Reserved".
> 
> A follow-on change integrates parsing of the ACPI HMAT to identify the
> node and sub-range boundaries of EFI_MEMORY_SP designated memory. For
> now, just identify and reserve memory of this type.
> 
> For now this translation of EFI_CONVENTIONAL + EFI_MEMORY_SP is
> x86/E820-only, but other archs could choose to publish
> IORES_DESC_APPLICATION_RESERVED resources from their platform-firmware
> memory map handlers.
> 
> Cc: <x86@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Reported-by: kbuild test robot <lkp@intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
A few really minor things inline.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  arch/x86/Kconfig                  |   23 +++++++++++++++++++++++
>  arch/x86/boot/compressed/eboot.c  |    5 ++++-
>  arch/x86/boot/compressed/kaslr.c  |    3 ++-
>  arch/x86/include/asm/e820/types.h |    9 +++++++++
>  arch/x86/include/asm/efi.h        |   17 +++++++++++++++++
>  arch/x86/kernel/e820.c            |   12 ++++++++++--
>  arch/x86/kernel/setup.c           |    1 +
>  arch/x86/platform/efi/efi.c       |   37 +++++++++++++++++++++++++++++++++----
>  include/linux/ioport.h            |    1 +
>  9 files changed, 100 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 2bbbd4d1ba31..d8d3b4e87ac1 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1955,6 +1955,29 @@ config EFI_MIXED
>  
>  	   If unsure, say N.
>  
> +config EFI_APPLICATION_RESERVED
> +	bool "Reserve EFI Specific Purpose Memory"
> +	depends on ACPI_HMAT
> +	default ACPI_HMAT
> +	depends on EFI
> +	---help---
> +	  On systems that have mixed performance classes of memory EFI
> +	  may indicate specific purpose memory with an attribute (See
> +	  EFI_MEMORY_SP in UEFI 2.8). A memory range tagged with this
> +	  attribute may have unique performance characteristics compared
> +	  to the system's general purpose "System RAM" pool. On the
> +	  expectation that such memory has application specific usage,
> +	  and its base EFI memory type is "conventional" answer Y to
> +	  arrange for the kernel to reserve it as an "Application
> +	  Reserved" resource, and set aside for direct-access
> +	  (device-dax) by default. The memory range can later be
> +	  optionally assigned to the page allocator by system
> +	  administrator policy via the device-dax kmem facility. Say N
> +	  to have the kernel treat this memory as "System RAM" by
> +	  default.
> +
> +	  If unsure, say Y.
> +
>  config SECCOMP
>  	def_bool y
>  	prompt "Enable seccomp to safely compute untrusted bytecode"
> diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
> index 544ac4fafd11..a6c96eb6e633 100644
> --- a/arch/x86/boot/compressed/eboot.c
> +++ b/arch/x86/boot/compressed/eboot.c
> @@ -560,7 +560,10 @@ setup_e820(struct boot_params *params, struct setup_data *e820ext, u32 e820ext_s
>  		case EFI_BOOT_SERVICES_CODE:
>  		case EFI_BOOT_SERVICES_DATA:
>  		case EFI_CONVENTIONAL_MEMORY:
> -			e820_type = E820_TYPE_RAM;
> +			if (is_efi_application_reserved(d))
> +				e820_type = E820_TYPE_APPLICATION_RESERVED;
> +			else
> +				e820_type = E820_TYPE_RAM;
>  			break;
>  
>  		case EFI_ACPI_MEMORY_NVS:
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 2e53c056ba20..e8306f452182 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -757,7 +757,8 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
>  		 *
>  		 * Only EFI_CONVENTIONAL_MEMORY is guaranteed to be free.
>  		 */
> -		if (md->type != EFI_CONVENTIONAL_MEMORY)
> +		if (md->type != EFI_CONVENTIONAL_MEMORY
> +				|| is_efi_application_reserved(md))
>  			continue;
>  
>  		if (efi_mirror_found &&
> diff --git a/arch/x86/include/asm/e820/types.h b/arch/x86/include/asm/e820/types.h
> index c3aa4b5e49e2..41193c116a1f 100644
> --- a/arch/x86/include/asm/e820/types.h
> +++ b/arch/x86/include/asm/e820/types.h
> @@ -28,6 +28,15 @@ enum e820_type {
>  	 */
>  	E820_TYPE_PRAM		= 12,
>  
> +	/*
> +	 * Special-purpose / application-specific memory is indicated to
> +	 * the system via the EFI_MEMORY_SP attribute. Define an e820
> +	 * translation of this memory type for the purpose of
> +	 * reserving this range and marking it with the
> +	 * IORES_DESC_APPLICATION_RESERVED designation.
> +	 */
> +	E820_TYPE_APPLICATION_RESERVED	= 0xefffffff,
> +
>  	/*
>  	 * Reserved RAM used by the kernel itself if
>  	 * CONFIG_INTEL_TXT=y is enabled, memory of this type
> diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> index 7d52378e376a..4f80254e0541 100644
> --- a/arch/x86/include/asm/efi.h
> +++ b/arch/x86/include/asm/efi.h
> @@ -141,6 +141,19 @@ extern void efi_switch_mm(struct mm_struct *mm);
>  extern void efi_recover_from_page_fault(unsigned long phys_addr);
>  extern void efi_free_boot_services(void);
>  
> +#ifdef CONFIG_EFI_APPLICATION_RESERVED
> +static inline bool is_efi_application_reserved(efi_memory_desc_t *md)
> +{
> +	return md->type == EFI_CONVENTIONAL_MEMORY
> +		&& (md->attribute & EFI_MEMORY_SP);
> +}
> +#else
> +static inline bool is_efi_application_reserved(efi_memory_desc_t *md)
> +{
> +	return false;
> +}
> +#endif
> +
>  struct efi_setup_data {
>  	u64 fw_vendor;
>  	u64 runtime;
> @@ -244,6 +257,7 @@ extern bool efi_reboot_required(void);
>  
>  extern void efi_find_mirror(void);
>  extern void efi_reserve_boot_services(void);
> +extern void __init efi_find_application_reserved(void);
>  #else
>  static inline void parse_efi_setup(u64 phys_addr, u32 data_len) {}
>  static inline bool efi_reboot_required(void)
> @@ -256,6 +270,9 @@ static inline void efi_find_mirror(void)
>  static inline void efi_reserve_boot_services(void)
>  {
>  }
> +static inline void __init efi_find_application_reserved(void)
> +{
> +}
>  #endif /* CONFIG_EFI */
>  
>  #endif /* _ASM_X86_EFI_H */
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index 8f32e705a980..c5b91c2d0661 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -189,6 +189,7 @@ static void __init e820_print_type(enum e820_type type)
>  	switch (type) {
>  	case E820_TYPE_RAM:		/* Fall through: */
>  	case E820_TYPE_RESERVED_KERN:	pr_cont("usable");			break;
> +	case E820_TYPE_APPLICATION_RESERVED: pr_cont("application reserved");	break;
>  	case E820_TYPE_RESERVED:	pr_cont("reserved");			break;
>  	case E820_TYPE_ACPI:		pr_cont("ACPI data");			break;
>  	case E820_TYPE_NVS:		pr_cont("ACPI NVS");			break;
> @@ -1036,6 +1037,7 @@ static const char *__init e820_type_to_string(struct e820_entry *entry)
>  	case E820_TYPE_UNUSABLE:	return "Unusable memory";
>  	case E820_TYPE_PRAM:		return "Persistent Memory (legacy)";
>  	case E820_TYPE_PMEM:		return "Persistent Memory";
> +	case E820_TYPE_APPLICATION_RESERVED: return "Application Reserved";
>  	case E820_TYPE_RESERVED:	return "Reserved";
>  	default:			return "Unknown E820 type";
>  	}
> @@ -1051,6 +1053,7 @@ static unsigned long __init e820_type_to_iomem_type(struct e820_entry *entry)
>  	case E820_TYPE_UNUSABLE:	/* Fall-through: */
>  	case E820_TYPE_PRAM:		/* Fall-through: */
>  	case E820_TYPE_PMEM:		/* Fall-through: */
> +	case E820_TYPE_APPLICATION_RESERVED: /* Fall-through: */
>  	case E820_TYPE_RESERVED:	/* Fall-through: */
>  	default:			return IORESOURCE_MEM;
>  	}
> @@ -1063,6 +1066,7 @@ static unsigned long __init e820_type_to_iores_desc(struct e820_entry *entry)
>  	case E820_TYPE_NVS:		return IORES_DESC_ACPI_NV_STORAGE;
>  	case E820_TYPE_PMEM:		return IORES_DESC_PERSISTENT_MEMORY;
>  	case E820_TYPE_PRAM:		return IORES_DESC_PERSISTENT_MEMORY_LEGACY;
> +	case E820_TYPE_APPLICATION_RESERVED: return IORES_DESC_APPLICATION_RESERVED;
>  	case E820_TYPE_RESERVED_KERN:	/* Fall-through: */
>  	case E820_TYPE_RAM:		/* Fall-through: */
>  	case E820_TYPE_UNUSABLE:	/* Fall-through: */
> @@ -1078,13 +1082,14 @@ static bool __init do_mark_busy(enum e820_type type, struct resource *res)
>  		return true;
>  
>  	/*
> -	 * Treat persistent memory like device memory, i.e. reserve it
> -	 * for exclusive use of a driver
> +	 * Treat persistent memory and other special memory ranges like
> +	 * device memory, i.e. reserve it for exclusive use of a driver
>  	 */
>  	switch (type) {
>  	case E820_TYPE_RESERVED:
>  	case E820_TYPE_PRAM:
>  	case E820_TYPE_PMEM:
> +	case E820_TYPE_APPLICATION_RESERVED:
>  		return false;
>  	case E820_TYPE_RESERVED_KERN:
>  	case E820_TYPE_RAM:
> @@ -1285,6 +1290,9 @@ void __init e820__memblock_setup(void)
>  		if (end != (resource_size_t)end)
>  			continue;
>  
> +		if (entry->type == E820_TYPE_APPLICATION_RESERVED)
> +			memblock_reserve(entry->addr, entry->size);
> +
>  		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
>  			continue;
>  
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index b68fd57a8d26..3b9001b7c951 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1104,6 +1104,7 @@ void __init setup_arch(char **cmdline_p)
>  
>  	memblock_set_current_limit(ISA_END_ADDRESS);
>  
> +	efi_find_application_reserved();
>  	e820__memblock_setup();
>  
>  	reserve_bios_regions();
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index 4e8458b1ca30..4b4a9eb6d2c9 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -126,10 +126,18 @@ void __init efi_find_mirror(void)
>   * more than the max 128 entries that can fit in the e820 legacy
>   * (zeropage) memory map.
>   */
> +enum add_efi_mode {
> +	ADD_EFI_ALL,
> +	ADD_EFI_APPLICATION_RESERVED,
> +};

This enum rather separates the above comment from the function which
it describes. Perhaps reorganize or make the comment include
the function name so it's clear what 'Tell the kernel about...'
refers to.

>  
> -static void __init do_add_efi_memmap(void)
> +static void __init do_add_efi_memmap(enum add_efi_mode mode)

The mode parameter is somewhat confusing.  Perhaps some docs?

>  {
>  	efi_memory_desc_t *md;
> +	int add = 0;
> +
> +	if (!efi_enabled(EFI_MEMMAP))
> +		return;
>  
>  	for_each_efi_memory_desc(md) {
>  		unsigned long long start = md->phys_addr;
> @@ -142,7 +150,9 @@ static void __init do_add_efi_memmap(void)
>  		case EFI_BOOT_SERVICES_CODE:
>  		case EFI_BOOT_SERVICES_DATA:
>  		case EFI_CONVENTIONAL_MEMORY:
> -			if (md->attribute & EFI_MEMORY_WB)
> +			if (is_efi_application_reserved(md))
> +				e820_type = E820_TYPE_APPLICATION_RESERVED;
> +			else if (md->attribute & EFI_MEMORY_WB)
>  				e820_type = E820_TYPE_RAM;
>  			else
>  				e820_type = E820_TYPE_RESERVED;
> @@ -168,9 +178,22 @@ static void __init do_add_efi_memmap(void)
>  			e820_type = E820_TYPE_RESERVED;
>  			break;
>  		}
> +
> +		if (e820_type == E820_TYPE_APPLICATION_RESERVED)
> +			/* always add E820_TYPE_APPLICATION_RESERVED */;
> +		else if (mode != ADD_EFI_APPLICATION_RESERVED)
> +			continue;
> +
> +		add++;
>  		e820__range_add(start, size, e820_type);
>  	}
> -	e820__update_table(e820_table);
> +	if (add)

> +		e820__update_table(e820_table);
> +}
> +
> +void __init efi_find_application_reserved(void)
> +{
> +	do_add_efi_memmap(ADD_EFI_APPLICATION_RESERVED);
>  }
>  
>  int __init efi_memblock_x86_reserve_range(void)
> @@ -203,7 +226,7 @@ int __init efi_memblock_x86_reserve_range(void)
>  		return rv;
>  
>  	if (add_efi_memmap)
> -		do_add_efi_memmap();
> +		do_add_efi_memmap(ADD_EFI_ALL);
>  
>  	WARN(efi.memmap.desc_version != 1,
>  	     "Unexpected EFI_MEMORY_DESCRIPTOR version %ld",
> @@ -756,6 +779,12 @@ static bool should_map_region(efi_memory_desc_t *md)
>  	if (IS_ENABLED(CONFIG_X86_32))
>  		return false;
>  
> +	/*
> +	 * Specific purpose memory is reserved by default.
> +	 */
This file is pretty consistent on comment syntax with single line comments as.
/* Specific purpose memory is reserved by default. */

> +	if (is_efi_application_reserved(md))
> +		return false;
> +
>  	/*
>  	 * Map all of RAM so that we can access arguments in the 1:1
>  	 * mapping when making EFI runtime calls.
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index da0ebaec25f0..2d79841ee9b9 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -133,6 +133,7 @@ enum {
>  	IORES_DESC_PERSISTENT_MEMORY_LEGACY	= 5,
>  	IORES_DESC_DEVICE_PRIVATE_MEMORY	= 6,
>  	IORES_DESC_DEVICE_PUBLIC_MEMORY		= 7,
> +	IORES_DESC_APPLICATION_RESERVED		= 8,
>  };
>  
>  /* helpers to define resources */
> 


_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

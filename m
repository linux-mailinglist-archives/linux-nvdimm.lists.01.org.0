Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F1132816
	for <lists+linux-nvdimm@lfdr.de>; Mon,  3 Jun 2019 07:42:18 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A172A21281EE1;
	Sun,  2 Jun 2019 22:42:14 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=rppt@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 0A1E421A09130
 for <linux-nvdimm@lists.01.org>; Sun,  2 Jun 2019 22:42:12 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x535fS6T146753
 for <linux-nvdimm@lists.01.org>; Mon, 3 Jun 2019 01:42:11 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2svwak0h29-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvdimm@lists.01.org>; Mon, 03 Jun 2019 01:42:11 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-nvdimm@lists.01.org> from <rppt@linux.ibm.com>;
 Mon, 3 Jun 2019 06:42:08 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 3 Jun 2019 06:42:03 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x535g2TC27197572
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Jun 2019 05:42:02 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B628AE045;
 Mon,  3 Jun 2019 05:42:02 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 43A4FAE04D;
 Mon,  3 Jun 2019 05:42:01 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.53])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Mon,  3 Jun 2019 05:42:01 +0000 (GMT)
Date: Mon, 3 Jun 2019 08:41:59 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 4/8] x86, efi: Reserve UEFI 2.8 Specific Purpose
 Memory for dax
References: <155925716254.3775979.16716824941364738117.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155925718351.3775979.13546720620952434175.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <155925718351.3775979.13546720620952434175.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19060305-0020-0000-0000-000003432C4E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060305-0021-0000-0000-000021963D2F
Message-Id: <20190603054159.GA5747@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-03_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906030041
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
Cc: linux-efi@vger.kernel.org, kbuild test robot <lkp@intel.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, Darren Hart <dvhart@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Andy Shevchenko <andy@infradead.org>,
 linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Hi Dan,

On Thu, May 30, 2019 at 03:59:43PM -0700, Dan Williams wrote:
> UEFI 2.8 defines an EFI_MEMORY_SP attribute bit to augment the
> interpretation of the EFI Memory Types as "reserved for a special
> purpose".
> 
> The proposed Linux behavior for specific purpose memory is that it is
> reserved for direct-access (device-dax) by default and not available for
> any kernel usage, not even as an OOM fallback. Later, through udev
> scripts or another init mechanism, these device-dax claimed ranges can
> be reconfigured and hot-added to the available System-RAM with a unique
> node identifier.
> 
> This patch introduces 3 new concepts at once given the entanglement
> between early boot enumeration relative to memory that can optionally be
> reserved from the kernel page allocator by default. The new concepts
> are:
> 
> - E820_TYPE_SPECIFIC: Upon detecting the EFI_MEMORY_SP attribute on
>   EFI_CONVENTIONAL memory, update the E820 map with this new type. Only
>   perform this classification if the CONFIG_EFI_SPECIFIC_DAX=y policy is
>   enabled, otherwise treat it as typical ram.
> 
> - IORES_DESC_APPLICATION_RESERVED: Add a new I/O resource descriptor for
>   a device driver to search iomem resources for application specific
>   memory. Teach the iomem code to identify such ranges as "Application
>   Reserved".
> 
> - MEMBLOCK_APP_SPECIFIC: Given the memory ranges can fallback to the
>   traditional System RAM pool the expectation is that they will have
>   typical SRAT entries. In order to support a policy of device-dax by
>   default with the option to hotplug later, the numa initialization code
>   is taught to avoid marking online MEMBLOCK_APP_SPECIFIC regions.

I'd appreciate a more elaborate description how this flag is going to be
used.
 
> A follow-on change integrates parsing of the ACPI HMAT to identify the
> node and sub-range boundaries of EFI_MEMORY_SP designated memory. For
> now, just identify and reserve memory of this type.
> 
> Cc: <x86@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  arch/x86/Kconfig                  |   20 ++++++++++++++++++++
>  arch/x86/boot/compressed/eboot.c  |    5 ++++-
>  arch/x86/boot/compressed/kaslr.c  |    2 +-
>  arch/x86/include/asm/e820/types.h |    9 +++++++++
>  arch/x86/kernel/e820.c            |    9 +++++++--
>  arch/x86/kernel/setup.c           |    1 +
>  arch/x86/platform/efi/efi.c       |   37 +++++++++++++++++++++++++++++++++----
>  drivers/acpi/numa.c               |   15 ++++++++++++++-
>  include/linux/efi.h               |   14 ++++++++++++++
>  include/linux/ioport.h            |    1 +
>  include/linux/memblock.h          |    7 +++++++
>  mm/memblock.c                     |    4 ++++
>  12 files changed, 115 insertions(+), 9 deletions(-)
 
...

> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 08a5f4a131f5..ddde1c7b1f9a 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1109,6 +1109,7 @@ void __init setup_arch(char **cmdline_p)
> 
>  	if (efi_enabled(EFI_MEMMAP)) {
>  		efi_fake_memmap();
> +		efi_find_app_specific();
>  		efi_find_mirror();
>  		efi_esrt_init();
> 
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index e1cb01a22fa8..899f1305c77a 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -123,10 +123,15 @@ void __init efi_find_mirror(void)
>   * more than the max 128 entries that can fit in the e820 legacy
>   * (zeropage) memory map.
>   */
> +enum add_efi_mode {
> +	ADD_EFI_ALL,
> +	ADD_EFI_APP_SPECIFIC,
> +};
> 
> -static void __init do_add_efi_memmap(void)
> +static void __init do_add_efi_memmap(enum add_efi_mode mode)
>  {
>  	efi_memory_desc_t *md;
> +	int add = 0;
> 
>  	for_each_efi_memory_desc(md) {
>  		unsigned long long start = md->phys_addr;
> @@ -139,7 +144,9 @@ static void __init do_add_efi_memmap(void)
>  		case EFI_BOOT_SERVICES_CODE:
>  		case EFI_BOOT_SERVICES_DATA:
>  		case EFI_CONVENTIONAL_MEMORY:
> -			if (md->attribute & EFI_MEMORY_WB)
> +			if (is_efi_dax(md))
> +				e820_type = E820_TYPE_SPECIFIC;
> +			else if (md->attribute & EFI_MEMORY_WB)
>  				e820_type = E820_TYPE_RAM;
>  			else
>  				e820_type = E820_TYPE_RESERVED;
> @@ -165,9 +172,24 @@ static void __init do_add_efi_memmap(void)
>  			e820_type = E820_TYPE_RESERVED;
>  			break;
>  		}
> +
> +		if (e820_type == E820_TYPE_SPECIFIC) {
> +			memblock_remove(start, size);
> +			memblock_add_range(&memblock.reserved, start, size,
> +					MAX_NUMNODES, MEMBLOCK_APP_SPECIFIC);

Why cannot this happen at e820__memblock_setup()?
Then memblock_remove() call should not be required as nothing will
memblock_add() the region. 

> +		} else if (mode != ADD_EFI_APP_SPECIFIC)
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
> +void __init efi_find_app_specific(void)
> +{
> +	do_add_efi_memmap(ADD_EFI_APP_SPECIFIC);
>  }
> 
>  int __init efi_memblock_x86_reserve_range(void)
> @@ -200,7 +222,7 @@ int __init efi_memblock_x86_reserve_range(void)
>  		return rv;
> 
>  	if (add_efi_memmap)
> -		do_add_efi_memmap();
> +		do_add_efi_memmap(ADD_EFI_ALL);
> 
>  	WARN(efi.memmap.desc_version != 1,
>  	     "Unexpected EFI_MEMORY_DESCRIPTOR version %ld",
> @@ -753,6 +775,13 @@ static bool should_map_region(efi_memory_desc_t *md)
>  	if (IS_ENABLED(CONFIG_X86_32))
>  		return false;
> 
> +	/*
> +	 * Specific purpose memory assigned to device-dax is
> +	 * not mapped by default.
> +	 */
> +	if (is_efi_dax(md))
> +		return false;
> +
>  	/*
>  	 * Map all of RAM so that we can access arguments in the 1:1
>  	 * mapping when making EFI runtime calls.
> diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
> index 30995834ad70..9083bb8f611b 100644
> --- a/drivers/acpi/numa.c
> +++ b/drivers/acpi/numa.c
> @@ -260,7 +260,7 @@ void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
>  int __init
>  acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
>  {
> -	u64 start, end;
> +	u64 start, end, i, a_start, a_end;
>  	u32 hotpluggable;
>  	int node, pxm;
> 
> @@ -283,6 +283,19 @@ acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
>  	if (acpi_srat_revision <= 1)
>  		pxm &= 0xff;
> 
> +	/* Clamp Application Specific Memory */
> +	for_each_mem_range(i, &memblock.reserved, NULL, NUMA_NO_NODE,
> +			MEMBLOCK_APP_SPECIFIC, &a_start, &a_end, NULL) {
> +		pr_debug("%s: SP: %#llx %#llx SRAT: %#llx %#llx\n", __func__,
> +				a_start, a_end, start, end);
> +		if (a_start <= start && a_end >= end)
> +			goto out_err;
> +		if (a_start >= start && a_start < end)
> +			start = a_start;
> +		if (a_end <= end && end > start)
> +			end = a_end;
> +	}
> +
>  	node = acpi_map_pxm_to_node(pxm);
>  	if (node == NUMA_NO_NODE || node >= MAX_NUMNODES) {
>  		pr_err("SRAT: Too many proximity domains.\n");
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 91368f5ce114..b57b123cbdf9 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -129,6 +129,19 @@ typedef struct {
>  	u64 attribute;
>  } efi_memory_desc_t;
> 
> +#ifdef CONFIG_EFI_SPECIFIC_DAX
> +static inline bool is_efi_dax(efi_memory_desc_t *md)
> +{
> +	return md->type == EFI_CONVENTIONAL_MEMORY
> +		&& (md->attribute & EFI_MEMORY_SP);
> +}
> +#else
> +static inline bool is_efi_dax(efi_memory_desc_t *md)
> +{
> +	return false;
> +}
> +#endif
> +
>  typedef struct {
>  	efi_guid_t guid;
>  	u32 headersize;
> @@ -1043,6 +1056,7 @@ extern efi_status_t efi_query_variable_store(u32 attributes,
>  					     unsigned long size,
>  					     bool nonblocking);
>  extern void efi_find_mirror(void);
> +extern void efi_find_app_specific(void);
>  #else
> 
>  static inline efi_status_t efi_query_variable_store(u32 attributes,
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
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 676d3900e1bd..58c29180f2cd 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -35,12 +35,14 @@ extern unsigned long long max_possible_pfn;
>   * @MEMBLOCK_HOTPLUG: hotpluggable region
>   * @MEMBLOCK_MIRROR: mirrored region
>   * @MEMBLOCK_NOMAP: don't add to kernel direct mapping
> + * @MEMBLOCK_APP_SPECIFIC: reserved / application specific range
>   */
>  enum memblock_flags {
>  	MEMBLOCK_NONE		= 0x0,	/* No special request */
>  	MEMBLOCK_HOTPLUG	= 0x1,	/* hotpluggable region */
>  	MEMBLOCK_MIRROR		= 0x2,	/* mirrored region */
>  	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
> +	MEMBLOCK_APP_SPECIFIC	= 0x8,  /* reserved / application specific range */
>  };
> 
>  /**
> @@ -215,6 +217,11 @@ static inline bool memblock_is_mirror(struct memblock_region *m)
>  	return m->flags & MEMBLOCK_MIRROR;
>  }
> 
> +static inline bool memblock_is_app_specific(struct memblock_region *m)
> +{
> +	return m->flags & MEMBLOCK_APP_SPECIFIC;
> +}
> +
>  static inline bool memblock_is_nomap(struct memblock_region *m)
>  {
>  	return m->flags & MEMBLOCK_NOMAP;
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 6bbad46f4d2c..654fecb52ba5 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -982,6 +982,10 @@ static bool should_skip_region(struct memblock_region *m, int nid, int flags)
>  	if ((flags & MEMBLOCK_MIRROR) && !memblock_is_mirror(m))
>  		return true;
> 
> +	/* if we want specific memory skip non-specific memory regions */
> +	if ((flags & MEMBLOCK_APP_SPECIFIC) && !memblock_is_app_specific(m))
> +		return true;
> +

With this the MEMBLOCK_APP_SPECIFIC won't be skipped for traversals that
don't set memblock_flags explicitly. Is this the intention?

>  	/* skip nomap memory unless we were asked for it explicitly */
>  	if (!(flags & MEMBLOCK_NOMAP) && memblock_is_nomap(m))
>  		return true;
> 

-- 
Sincerely yours,
Mike.

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

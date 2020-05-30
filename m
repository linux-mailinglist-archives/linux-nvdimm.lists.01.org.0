Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 813811E8D5A
	for <lists+linux-nvdimm@lfdr.de>; Sat, 30 May 2020 05:09:26 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6B456100EAB57;
	Fri, 29 May 2020 20:04:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 385A6100F2260;
	Fri, 29 May 2020 20:04:54 -0700 (PDT)
IronPort-SDR: 8EDiZN0IaG/b/tN2cyqMc72U5zJjWs+LtyOQHA8EoDkn8CRXUzMj+PES8igimP/7dLqyjH5mFT
 tcnfaw1A2nNQ==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 20:09:21 -0700
IronPort-SDR: 2rBgKT2EwR3uzmhwwq0Fi+ATiTjJWOqcS6YNkP69+XVrMwdZG5GqE4omrG2Ui+lmD+VN36pu3e
 iFJ9kcqdAjHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,451,1583222400";
   d="gz'50?scan'50,208,50";a="303033898"
Received: from lkp-server01.sh.intel.com (HELO 9f9df8056aac) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 29 May 2020 20:09:16 -0700
Received: from kbuild by 9f9df8056aac with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1jers3-0000ZD-TU; Sat, 30 May 2020 03:09:15 +0000
Date: Sat, 30 May 2020 11:08:18 +0800
From: kbuild test robot <lkp@intel.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
	linux-nvdimm@lists.01.org
Subject: Re: [PATCH v3 5/7] powerpc/pmem/of_pmem: Update of_pmem to use the
 new barrier instruction.
Message-ID: <202005301104.KhDcZUvf%lkp@intel.com>
References: <20200519055502.128318-5-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200519055502.128318-5-aneesh.kumar@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: NKZ7GVJOHDDXYW7PIQHMS36E6GFAVYZB
X-Message-ID-Hash: NKZ7GVJOHDDXYW7PIQHMS36E6GFAVYZB
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: kbuild-all@lists.01.org, clang-built-linux@googlegroups.com, alistair@popple.id.au, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NKZ7GVJOHDDXYW7PIQHMS36E6GFAVYZB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi "Aneesh,

I love your patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on v5.7-rc7]
[cannot apply to next-20200529]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Aneesh-Kumar-K-V/powerpc-pmem-Restrict-papr_scm-to-P8-and-above/20200519-195350
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-randconfig-r016-20200529 (attached as .config)
compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 2d068e534f1671459e1b135852c1b3c10502e929)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

In file included from arch/powerpc/kernel/syscall_64.c:4:
In file included from arch/powerpc/include/asm/asm-prototypes.h:12:
>> arch/powerpc/include/asm/cacheflush.h:126:6: error: implicit declaration of function 'cpu_has_feature' [-Werror,-Wimplicit-function-declaration]
if (cpu_has_feature(CPU_FTR_ARCH_207S))
^
arch/powerpc/include/asm/cacheflush.h:126:6: note: did you mean 'mmu_has_feature'?
arch/powerpc/include/asm/mmu.h:234:20: note: 'mmu_has_feature' declared here
static inline bool mmu_has_feature(unsigned long feature)
^
In file included from arch/powerpc/kernel/syscall_64.c:4:
In file included from arch/powerpc/include/asm/asm-prototypes.h:17:
In file included from arch/powerpc/include/asm/mmu_context.h:12:
In file included from arch/powerpc/include/asm/cputhreads.h:7:
>> arch/powerpc/include/asm/cpu_has_feature.h:49:20: error: static declaration of 'cpu_has_feature' follows non-static declaration
static inline bool cpu_has_feature(unsigned long feature)
^
arch/powerpc/include/asm/cacheflush.h:126:6: note: previous implicit declaration is here
if (cpu_has_feature(CPU_FTR_ARCH_207S))
^
2 errors generated.
--
In file included from arch/powerpc/kernel/kprobes.c:23:
>> arch/powerpc/include/asm/cacheflush.h:126:6: error: implicit declaration of function 'cpu_has_feature' [-Werror,-Wimplicit-function-declaration]
if (cpu_has_feature(CPU_FTR_ARCH_207S))
^
arch/powerpc/include/asm/cacheflush.h:126:6: note: did you mean 'mmu_has_feature'?
arch/powerpc/include/asm/mmu.h:234:20: note: 'mmu_has_feature' declared here
static inline bool mmu_has_feature(unsigned long feature)
^
1 error generated.
--
In file included from arch/powerpc/kernel/optprobes.c:15:
>> arch/powerpc/include/asm/cacheflush.h:126:6: error: implicit declaration of function 'cpu_has_feature' [-Werror,-Wimplicit-function-declaration]
if (cpu_has_feature(CPU_FTR_ARCH_207S))
^
arch/powerpc/include/asm/cacheflush.h:126:6: note: did you mean 'mmu_has_feature'?
arch/powerpc/include/asm/mmu.h:234:20: note: 'mmu_has_feature' declared here
static inline bool mmu_has_feature(unsigned long feature)
^
arch/powerpc/kernel/optprobes.c:149:6: warning: no previous prototype for function 'patch_imm32_load_insns' [-Wmissing-prototypes]
void patch_imm32_load_insns(unsigned int val, kprobe_opcode_t *addr)
^
arch/powerpc/kernel/optprobes.c:149:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
void patch_imm32_load_insns(unsigned int val, kprobe_opcode_t *addr)
^
static
arch/powerpc/kernel/optprobes.c:167:6: warning: no previous prototype for function 'patch_imm64_load_insns' [-Wmissing-prototypes]
void patch_imm64_load_insns(unsigned long val, int reg, kprobe_opcode_t *addr)
^
arch/powerpc/kernel/optprobes.c:167:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
void patch_imm64_load_insns(unsigned long val, int reg, kprobe_opcode_t *addr)
^
static
2 warnings and 1 error generated.
--
In file included from arch/powerpc/kernel/epapr_paravirt.c:11:
>> arch/powerpc/include/asm/cacheflush.h:126:6: error: implicit declaration of function 'cpu_has_feature' [-Werror,-Wimplicit-function-declaration]
if (cpu_has_feature(CPU_FTR_ARCH_207S))
^
arch/powerpc/include/asm/cacheflush.h:126:6: note: did you mean 'mmu_has_feature'?
arch/powerpc/include/asm/mmu.h:234:20: note: 'mmu_has_feature' declared here
static inline bool mmu_has_feature(unsigned long feature)
^
In file included from arch/powerpc/kernel/epapr_paravirt.c:13:
In file included from arch/powerpc/include/asm/machdep.h:8:
In file included from include/linux/dma-mapping.h:11:
In file included from include/linux/scatterlist.h:9:
In file included from arch/powerpc/include/asm/io.h:33:
In file included from arch/powerpc/include/asm/delay.h:7:
In file included from arch/powerpc/include/asm/time.h:17:
>> arch/powerpc/include/asm/cpu_has_feature.h:49:20: error: static declaration of 'cpu_has_feature' follows non-static declaration
static inline bool cpu_has_feature(unsigned long feature)
^
arch/powerpc/include/asm/cacheflush.h:126:6: note: previous implicit declaration is here
if (cpu_has_feature(CPU_FTR_ARCH_207S))
^
In file included from arch/powerpc/kernel/epapr_paravirt.c:13:
In file included from arch/powerpc/include/asm/machdep.h:8:
In file included from include/linux/dma-mapping.h:11:
In file included from include/linux/scatterlist.h:9:
In file included from arch/powerpc/include/asm/io.h:605:
arch/powerpc/include/asm/io-defs.h:23:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
DEF_PCI_AC_RET(inb, u8, (unsigned long port), (port), pio, port)
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/include/asm/io.h:593:9: note: expanded from macro 'DEF_PCI_AC_RET'
return __do_##name al;                                                    ^~~~~~~~~~~~~~
<scratch space>:32:1: note: expanded from here
__do_inb
^
arch/powerpc/include/asm/io.h:524:53: note: expanded from macro '__do_inb'
#define __do_inb(port)          readb((PCI_IO_ADDR)_IO_BASE + port);
~~~~~~~~~~~~~~~~~~~~~ ^
In file included from arch/powerpc/kernel/epapr_paravirt.c:13:
In file included from arch/powerpc/include/asm/machdep.h:8:
In file included from include/linux/dma-mapping.h:11:
In file included from include/linux/scatterlist.h:9:
In file included from arch/powerpc/include/asm/io.h:605:
arch/powerpc/include/asm/io-defs.h:24:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
DEF_PCI_AC_RET(inw, u16, (unsigned long port), (port), pio, port)
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/include/asm/io.h:593:9: note: expanded from macro 'DEF_PCI_AC_RET'
return __do_##name al;                                                    ^~~~~~~~~~~~~~
<scratch space>:34:1: note: expanded from here
__do_inw
^
arch/powerpc/include/asm/io.h:525:53: note: expanded from macro '__do_inw'
#define __do_inw(port)          readw((PCI_IO_ADDR)_IO_BASE + port);
~~~~~~~~~~~~~~~~~~~~~ ^
In file included from arch/powerpc/kernel/epapr_paravirt.c:13:
In file included from arch/powerpc/include/asm/machdep.h:8:
In file included from include/linux/dma-mapping.h:11:
In file included from include/linux/scatterlist.h:9:
In file included from arch/powerpc/include/asm/io.h:605:
arch/powerpc/include/asm/io-defs.h:25:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
DEF_PCI_AC_RET(inl, u32, (unsigned long port), (port), pio, port)
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/include/asm/io.h:593:9: note: expanded from macro 'DEF_PCI_AC_RET'
return __do_##name al;                                                    ^~~~~~~~~~~~~~
<scratch space>:36:1: note: expanded from here
__do_inl
^
arch/powerpc/include/asm/io.h:526:53: note: expanded from macro '__do_inl'
#define __do_inl(port)          readl((PCI_IO_ADDR)_IO_BASE + port);
~~~~~~~~~~~~~~~~~~~~~ ^
In file included from arch/powerpc/kernel/epapr_paravirt.c:13:
In file included from arch/powerpc/include/asm/machdep.h:8:
In file included from include/linux/dma-mapping.h:11:
In file included from include/linux/scatterlist.h:9:
In file included from arch/powerpc/include/asm/io.h:605:
arch/powerpc/include/asm/io-defs.h:26:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
DEF_PCI_AC_NORET(outb, (u8 val, unsigned long port), (val, port), pio, port)
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/include/asm/io.h:602:3: note: expanded from macro 'DEF_PCI_AC_NORET'
__do_##name al;                                                    ^~~~~~~~~~~~~~
<scratch space>:38:1: note: expanded from here
__do_outb
^
arch/powerpc/include/asm/io.h:521:62: note: expanded from macro '__do_outb'
#define __do_outb(val, port)    writeb(val,(PCI_IO_ADDR)_IO_BASE+port);
~~~~~~~~~~~~~~~~~~~~~^
In file included from arch/powerpc/kernel/epapr_paravirt.c:13:
In file included from arch/powerpc/include/asm/machdep.h:8:
In file included from include/linux/dma-mapping.h:11:
In file included from include/linux/scatterlist.h:9:
In file included from arch/powerpc/include/asm/io.h:605:
arch/powerpc/include/asm/io-defs.h:27:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
DEF_PCI_AC_NORET(outw, (u16 val, unsigned long port), (val, port), pio, port)
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/include/asm/io.h:602:3: note: expanded from macro 'DEF_PCI_AC_NORET'
__do_##name al;                                                    ^~~~~~~~~~~~~~
<scratch space>:40:1: note: expanded from here
__do_outw
^
arch/powerpc/include/asm/io.h:522:62: note: expanded from macro '__do_outw'
#define __do_outw(val, port)    writew(val,(PCI_IO_ADDR)_IO_BASE+port);
~~~~~~~~~~~~~~~~~~~~~^
In file included from arch/powerpc/kernel/epapr_paravirt.c:13:
In file included from arch/powerpc/include/asm/machdep.h:8:
In file included from include/linux/dma-mapping.h:11:
In file included from include/linux/scatterlist.h:9:
In file included from arch/powerpc/include/asm/io.h:605:
arch/powerpc/include/asm/io-defs.h:28:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
DEF_PCI_AC_NORET(outl, (u32 val, unsigned long port), (val, port), pio, port)
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/include/asm/io.h:602:3: note: expanded from macro 'DEF_PCI_AC_NORET'
__do_##name al;                                 --
In file included from arch/powerpc/lib/pmem.c:10:
>> arch/powerpc/include/asm/cacheflush.h:126:6: error: implicit declaration of function 'cpu_has_feature' [-Werror,-Wimplicit-function-declaration]
if (cpu_has_feature(CPU_FTR_ARCH_207S))
^
arch/powerpc/include/asm/cacheflush.h:126:6: note: did you mean 'mmu_has_feature'?
arch/powerpc/include/asm/mmu.h:234:20: note: 'mmu_has_feature' declared here
static inline bool mmu_has_feature(unsigned long feature)
^
arch/powerpc/lib/pmem.c:44:6: error: implicit declaration of function 'cpu_has_feature' [-Werror,-Wimplicit-function-declaration]
if (cpu_has_feature(CPU_FTR_ARCH_207S))
^
arch/powerpc/lib/pmem.c:50:6: error: implicit declaration of function 'cpu_has_feature' [-Werror,-Wimplicit-function-declaration]
if (cpu_has_feature(CPU_FTR_ARCH_207S))
^
arch/powerpc/lib/pmem.c:57:6: warning: no previous prototype for function 'arch_wb_cache_pmem' [-Wmissing-prototypes]
void arch_wb_cache_pmem(void *addr, size_t size)
^
arch/powerpc/lib/pmem.c:57:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
void arch_wb_cache_pmem(void *addr, size_t size)
^
static
arch/powerpc/lib/pmem.c:64:6: warning: no previous prototype for function 'arch_invalidate_pmem' [-Wmissing-prototypes]
void arch_invalidate_pmem(void *addr, size_t size)
^
arch/powerpc/lib/pmem.c:64:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
void arch_invalidate_pmem(void *addr, size_t size)
^
static
2 warnings and 3 errors generated.

vim +/cpu_has_feature +126 arch/powerpc/include/asm/cacheflush.h

   113	
   114	#define copy_to_user_page(vma, page, vaddr, dst, src, len) \
   115		do { \
   116			memcpy(dst, src, len); \
   117			flush_icache_user_range(vma, page, vaddr, len); \
   118		} while (0)
   119	#define copy_from_user_page(vma, page, vaddr, dst, src, len) \
   120		memcpy(dst, src, len)
   121	
   122	
   123	#define arch_pmem_flush_barrier arch_pmem_flush_barrier
   124	static inline void  arch_pmem_flush_barrier(void)
   125	{
 > 126		if (cpu_has_feature(CPU_FTR_ARCH_207S))
   127			asm volatile(PPC_PHWSYNC ::: "memory");
   128	}
   129	#endif /* __KERNEL__ */
   130	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

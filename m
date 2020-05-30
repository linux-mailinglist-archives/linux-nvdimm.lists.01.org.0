Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 041691E8C97
	for <lists+linux-nvdimm@lfdr.de>; Sat, 30 May 2020 02:48:36 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2A64B100F2278;
	Fri, 29 May 2020 17:44:06 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CFE9D100F2261;
	Fri, 29 May 2020 17:44:03 -0700 (PDT)
IronPort-SDR: hBCp5TmbjXs14b16IEMEv04Hz9M80r1nYpBaPbEYT+7ryV1zOFg5Jii7fn7CokqqAcf4Zj5AH7
 xcjP8Xj8yf9w==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 17:48:30 -0700
IronPort-SDR: DgAaLBKj51JGwd6s2vPkHVzIJET00yc7SwkSYpMFDePW7dGG5u8WpzHF5mcA+8mnx7Z/yhrNQJ
 jjf286MDWV3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,450,1583222400";
   d="gz'50?scan'50,208,50";a="346431941"
Received: from lkp-server01.sh.intel.com (HELO 9f9df8056aac) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 29 May 2020 17:48:27 -0700
Received: from kbuild by 9f9df8056aac with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1jepfn-0000Xb-0K; Sat, 30 May 2020 00:48:27 +0000
Date: Sat, 30 May 2020 08:47:31 +0800
From: kbuild test robot <lkp@intel.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
	linux-nvdimm@lists.01.org
Subject: Re: [PATCH v3 3/7] powerpc/pmem: Add flush routines using new pmem
 store and sync instruction
Message-ID: <202005300807.k95zhma2%lkp@intel.com>
References: <20200519055502.128318-3-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200519055502.128318-3-aneesh.kumar@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: VRQA3DE2JBJIYK2SKH7CVEWWNBIOJFBF
X-Message-ID-Hash: VRQA3DE2JBJIYK2SKH7CVEWWNBIOJFBF
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: kbuild-all@lists.01.org, clang-built-linux@googlegroups.com, alistair@popple.id.au, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VRQA3DE2JBJIYK2SKH7CVEWWNBIOJFBF/>
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
[also build test ERROR on v5.7-rc7 next-20200529]
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

>> arch/powerpc/lib/pmem.c:44:6: error: implicit declaration of function 'cpu_has_feature' [-Werror,-Wimplicit-function-declaration]
if (cpu_has_feature(CPU_FTR_ARCH_207S))
^
arch/powerpc/lib/pmem.c:44:6: note: did you mean 'mmu_has_feature'?
arch/powerpc/include/asm/mmu.h:234:20: note: 'mmu_has_feature' declared here
static inline bool mmu_has_feature(unsigned long feature)
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
2 warnings and 2 errors generated.

vim +/cpu_has_feature +44 arch/powerpc/lib/pmem.c

    41	
    42	static inline void clean_pmem_range(unsigned long start, unsigned long stop)
    43	{
  > 44		if (cpu_has_feature(CPU_FTR_ARCH_207S))
    45			return __clean_pmem_range(start, stop);
    46	}
    47	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

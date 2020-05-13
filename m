Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E8A1D08DA
	for <lists+linux-nvdimm@lfdr.de>; Wed, 13 May 2020 08:44:55 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C2A8B11AD0999;
	Tue, 12 May 2020 23:42:17 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B505711AD0620;
	Tue, 12 May 2020 23:42:15 -0700 (PDT)
IronPort-SDR: ejmulMGS/tvoKRd0V5IXemUxCoHsX100QerNJ+PqE5UX+12SJAJI5Zmbi8H322EDQ8MoP7sNGY
 5qgbNzExZsEw==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 23:44:50 -0700
IronPort-SDR: m+GrZI82vskxK72fm/cQ3p6UfuX6BvZq2zsZLPC2QICJxDVSIUIRMMMFVmjYkeSfEZa1ov//jf
 ZaaL9VICi1Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,386,1583222400";
   d="gz'50?scan'50,208,50";a="371809547"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 12 May 2020 23:44:48 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
	(envelope-from <lkp@intel.com>)
	id 1jYl8J-000DiP-Cf; Wed, 13 May 2020 14:44:47 +0800
Date: Wed, 13 May 2020 14:44:19 +0800
From: kbuild test robot <lkp@intel.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
	linux-nvdimm@lists.01.org
Subject: Re: [PATCH v2 4/5] powerpc/pmem/of_pmem: Update of_pmem to use the
 new barrier instruction.
Message-ID: <202005131440.xcr4uAC8%lkp@intel.com>
References: <20200513034705.172983-4-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200513034705.172983-4-aneesh.kumar@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: AD3K64ZPNYNVVRYTGPYQREQ2HNZOYCC5
X-Message-ID-Hash: AD3K64ZPNYNVVRYTGPYQREQ2HNZOYCC5
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: kbuild-all@lists.01.org, alistair@popple.id.au, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AD3K64ZPNYNVVRYTGPYQREQ2HNZOYCC5/>
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
[also build test ERROR on linux-nvdimm/libnvdimm-for-next v5.7-rc5 next-20200512]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Aneesh-Kumar-K-V/powerpc-pmem-Add-new-instructions-for-persistent-storage-and-sync/20200513-133938
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-storcenter_defconfig (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day GCC_VERSION=9.3.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

WARNING: unmet direct dependencies detected for PPC_INDIRECT_PCI
Depends on PCI
Selected by
- MPC10X_BRIDGE
In file included from include/linux/highmem.h:12,
from include/linux/pagemap.h:11,
from include/linux/blkdev.h:16,
from include/linux/blk-cgroup.h:23,
from include/linux/writeback.h:14,
from include/linux/memcontrol.h:22,
from include/linux/swap.h:9,
from include/linux/suspend.h:5,
from arch/powerpc/kernel/asm-offsets.c:23:
arch/powerpc/include/asm/cacheflush.h: In function 'arch_pmem_flush_barrier':
>> arch/powerpc/include/asm/cacheflush.h:126:22: error: 'CPU_FTR_ARCH_31' undeclared (first use in this function); did you mean
126 | if (cpu_has_feature(CPU_FTR_ARCH_31))
| ^~~~~~~~~~~~~~~
| CPU_FTR_ARCH_300
arch/powerpc/include/asm/cacheflush.h:126:22: note: each undeclared identifier is reported only once for each function it appears in
Makefile arch block certs crypto drivers fs include init ipc kernel lib mm net scripts security sound source usr virt [scripts/Makefile.build:100: arch/powerpc/kernel/asm-offsets.s] Error 1
Target '__build' not remade because of errors.
Makefile arch block certs crypto drivers fs include init ipc kernel lib mm net scripts security sound source usr virt [Makefile:1141: prepare0] Error 2
Target 'prepare' not remade because of errors.
make: Makefile arch block certs crypto drivers fs include init ipc kernel lib mm net scripts security sound source usr virt [Makefile:180: sub-make] Error 2

vim +/CPU_FTR_ARCH_31 +126 arch/powerpc/include/asm/cacheflush.h

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
 > 126		if (cpu_has_feature(CPU_FTR_ARCH_31))
   127			asm volatile(PPC_PHWSYNC ::: "memory");
   128		else
   129			asm volatile("hwsync" ::: "memory");
   130	}
   131	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

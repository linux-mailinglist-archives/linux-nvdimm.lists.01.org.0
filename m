Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2DF1E9839
	for <lists+linux-nvdimm@lfdr.de>; Sun, 31 May 2020 16:46:34 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 53A33100E5D0A;
	Sun, 31 May 2020 07:41:54 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 33F3E100E5D06;
	Sun, 31 May 2020 07:41:47 -0700 (PDT)
IronPort-SDR: 4PtjmazEa+uGMgC3okFARgtcKg9fCU4shRerIXqWEIfNdYipR3KhC9ubew5W4x+hyLxIjNHsf4
 0/PTN5EjlNDw==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2020 07:46:25 -0700
IronPort-SDR: PpgP/s0AxpmY2Efc6stDFuVRj10UuMcOT+pAt8+BVjKYmrpv7+H/x0p1qLzYCq7LTcQHO35qEQ
 cN+jH4tj/JjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,457,1583222400";
   d="gz'50?scan'50,208,50";a="256533814"
Received: from lkp-server01.sh.intel.com (HELO 9f9df8056aac) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 31 May 2020 07:46:22 -0700
Received: from kbuild by 9f9df8056aac with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1jfPEE-0000z9-0e; Sun, 31 May 2020 14:46:22 +0000
Date: Sun, 31 May 2020 22:46:02 +0800
From: kbuild test robot <lkp@intel.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
	linux-nvdimm@lists.01.org
Subject: Re: [PATCH v4 5/8] powerpc/pmem/of_pmem: Update of_pmem to use the
 new barrier instruction.
Message-ID: <202005312249.xCyVwSwD%lkp@intel.com>
References: <20200529052820.151651-6-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200529052820.151651-6-aneesh.kumar@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: WLF2LGLLCAIMAF3CWORMOZUXOU5XENRU
X-Message-ID-Hash: WLF2LGLLCAIMAF3CWORMOZUXOU5XENRU
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: kbuild-all@lists.01.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WLF2LGLLCAIMAF3CWORMOZUXOU5XENRU/>
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
[also build test ERROR on linux-nvdimm/libnvdimm-for-next scottwood/next v5.7-rc7]
[cannot apply to next-20200529]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Aneesh-Kumar-K-V/Support-new-pmem-flush-and-sync-instructions-for-POWER/20200531-062841
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-ppc6xx_defconfig (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

In file included from arch/powerpc/include/asm/asm-prototypes.h:12,
from arch/powerpc/kernel/early_32.c:11:
arch/powerpc/include/asm/cacheflush.h: In function 'arch_pmem_flush_barrier':
arch/powerpc/include/asm/cacheflush.h:126:6: error: implicit declaration of function 'cpu_has_feature'; did you mean 'mmu_has_feature'? [-Werror=implicit-function-declaration]
126 |  if (cpu_has_feature(CPU_FTR_ARCH_207S))
|      ^~~~~~~~~~~~~~~
|      mmu_has_feature
In file included from arch/powerpc/include/asm/cputhreads.h:7,
from arch/powerpc/include/asm/mmu_context.h:12,
from arch/powerpc/include/asm/asm-prototypes.h:17,
from arch/powerpc/kernel/early_32.c:11:
arch/powerpc/include/asm/cpu_has_feature.h: At top level:
>> arch/powerpc/include/asm/cpu_has_feature.h:49:20: error: conflicting types for 'cpu_has_feature'
49 | static inline bool cpu_has_feature(unsigned long feature)
|                    ^~~~~~~~~~~~~~~
In file included from arch/powerpc/include/asm/asm-prototypes.h:12,
from arch/powerpc/kernel/early_32.c:11:
arch/powerpc/include/asm/cacheflush.h:126:6: note: previous implicit declaration of 'cpu_has_feature' was here
126 |  if (cpu_has_feature(CPU_FTR_ARCH_207S))
|      ^~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

vim +/cpu_has_feature +49 arch/powerpc/include/asm/cpu_has_feature.h

c812c7d8f1470a Aneesh Kumar K.V 2016-07-23  38  
4db7327194dba0 Kevin Hao        2016-07-23  39  	if (CPU_FTRS_ALWAYS & feature)
4db7327194dba0 Kevin Hao        2016-07-23  40  		return true;
4db7327194dba0 Kevin Hao        2016-07-23  41  
4db7327194dba0 Kevin Hao        2016-07-23  42  	if (!(CPU_FTRS_POSSIBLE & feature))
4db7327194dba0 Kevin Hao        2016-07-23  43  		return false;
4db7327194dba0 Kevin Hao        2016-07-23  44  
4db7327194dba0 Kevin Hao        2016-07-23  45  	i = __builtin_ctzl(feature);
4db7327194dba0 Kevin Hao        2016-07-23  46  	return static_branch_likely(&cpu_feature_keys[i]);
4db7327194dba0 Kevin Hao        2016-07-23  47  }
4db7327194dba0 Kevin Hao        2016-07-23  48  #else
b92a226e528423 Kevin Hao        2016-07-23 @49  static inline bool cpu_has_feature(unsigned long feature)
b92a226e528423 Kevin Hao        2016-07-23  50  {
b92a226e528423 Kevin Hao        2016-07-23  51  	return early_cpu_has_feature(feature);
b92a226e528423 Kevin Hao        2016-07-23  52  }
4db7327194dba0 Kevin Hao        2016-07-23  53  #endif
b92a226e528423 Kevin Hao        2016-07-23  54  

:::::: The code at line 49 was first introduced by commit
:::::: b92a226e528423b8d249dd09bb450d53361fbfcb powerpc: Move cpu_has_feature() to a separate file

:::::: TO: Kevin Hao <haokexin@gmail.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

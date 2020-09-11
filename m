Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9B62656F5
	for <lists+linux-nvdimm@lfdr.de>; Fri, 11 Sep 2020 04:21:47 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7408A14373019;
	Thu, 10 Sep 2020 19:21:45 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F28C714373018;
	Thu, 10 Sep 2020 19:21:41 -0700 (PDT)
IronPort-SDR: XlNTIDIbadTMoEJt5aceUiy10xKagvr6oDaxns6ZMRJ3/EflbSKDr+a+/aQ3Rj/0obJqtz3MRk
 dI+2djkNUH5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="176739879"
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600";
   d="gz'50?scan'50,208,50";a="176739879"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 19:21:41 -0700
IronPort-SDR: Wz+QqN5+gaYW9XSHpQcGUtjjHRkld++URLvFOE6vbozoPfyly6hf6DyVkzwD+Va4pywV/Gcokm
 bzElFeZ1R88Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600";
   d="gz'50?scan'50,208,50";a="318127151"
Received: from lkp-server01.sh.intel.com (HELO 12ff3cf3f2e9) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 10 Sep 2020 19:21:37 -0700
Received: from kbuild by 12ff3cf3f2e9 with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1kGYgy-0001B8-9k; Fri, 11 Sep 2020 02:21:36 +0000
Date: Fri, 11 Sep 2020 10:21:24 +0800
From: kernel test robot <lkp@intel.com>
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] mm/memory_hotplug: prepare passing flags to
 add_memory() and friends
Message-ID: <202009111020.boR8gVOT%lkp@intel.com>
References: <20200910091340.8654-4-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200910091340.8654-4-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: D4CTQUPUAAV7AZGWWTVUN7OXCKD3GQ4V
X-Message-ID-Hash: D4CTQUPUAAV7AZGWWTVUN7OXCKD3GQ4V
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: kbuild-all@lists.01.org, clang-built-linux@googlegroups.com, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/D4CTQUPUAAV7AZGWWTVUN7OXCKD3GQ4V/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi David,

I love your patch! Yet something to improve:

[auto build test ERROR on next-20200909]
[cannot apply to mmotm/master hnaz-linux-mm/master xen-tip/linux-next powerpc/next linus/master v5.9-rc4 v5.9-rc3 v5.9-rc2 v5.9-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/David-Hildenbrand/mm-memory_hotplug-selective-merging-of-system-ram-resources/20200910-171630
base:    7204eaa2c1f509066486f488c9dcb065d7484494
config: x86_64-randconfig-a016-20200909 (attached as .config)
compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 0a5dc7effb191eff740e0e7ae7bd8e1f6bdb3ad9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install x86_64 cross compiling tool for clang build
        # apt-get install binutils-x86-64-linux-gnu
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   WARNING: unmet direct dependencies detected for PHY_SAMSUNG_UFS
   Depends on OF && (ARCH_EXYNOS || COMPILE_TEST
   Selected by
   - SCSI_UFS_EXYNOS && SCSI_LOWLEVEL && SCSI && SCSI_UFSHCD_PLATFORM && (ARCH_EXYNOS || COMPILE_TEST
   In file included from arch/x86/kernel/asm-offsets.c:9:
   In file included from include/linux/crypto.h:20:
   In file included from include/linux/slab.h:15:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:853:
>> include/linux/memory_hotplug.h:354:55: error: unknown type name 'mhp_t'
   extern int __add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
   ^
   include/linux/memory_hotplug.h:355:53: error: unknown type name 'mhp_t'
   extern int add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
   ^
   include/linux/memory_hotplug.h:357:11: error: unknown type name 'mhp_t'
   mhp_t mhp_flags);
   ^
   include/linux/memory_hotplug.h:360:10: error: unknown type name 'mhp_t'
   mhp_t mhp_flags);
   ^
   4 errors generated.
   Makefile Module.symvers System.map arch block certs crypto drivers fs include init ipc kernel lib mm modules.builtin modules.builtin.modinfo modules.order net scripts security sound source tools usr virt vmlinux vmlinux.o vmlinux.symvers [scripts/Makefile.build:117: arch/x86/kernel/asm-offsets.s] Error 1
   Target '__build' not remade because of errors.
   Makefile Module.symvers System.map arch block certs crypto drivers fs include init ipc kernel lib mm modules.builtin modules.builtin.modinfo modules.order net scripts security sound source tools usr virt vmlinux vmlinux.o vmlinux.symvers [Makefile:1196: prepare0] Error 2
   Target 'prepare' not remade because of errors.
   make: Makefile Module.symvers System.map arch block certs crypto drivers fs include init ipc kernel lib mm modules.builtin modules.builtin.modinfo modules.order net scripts security sound source tools usr virt vmlinux vmlinux.o vmlinux.symvers [Makefile:185: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

# https://github.com/0day-ci/linux/commit/d88270d1c0783a7f99f24a85692be90fd2ae0d7d
git remote add linux-review https://github.com/0day-ci/linux
git fetch --no-tags linux-review David-Hildenbrand/mm-memory_hotplug-selective-merging-of-system-ram-resources/20200910-171630
git checkout d88270d1c0783a7f99f24a85692be90fd2ae0d7d
vim +/mhp_t +354 include/linux/memory_hotplug.h

   352	
   353	extern void __ref free_area_init_core_hotplug(int nid);
 > 354	extern int __add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

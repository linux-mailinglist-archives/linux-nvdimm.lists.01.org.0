Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4DF26A0F4
	for <lists+linux-nvdimm@lfdr.de>; Tue, 15 Sep 2020 10:34:34 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 64F19141048E6;
	Tue, 15 Sep 2020 01:34:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id ED715141048E0;
	Tue, 15 Sep 2020 01:34:29 -0700 (PDT)
IronPort-SDR: MqMABfUNrYHw1ssw5CdOuZcF6NM7IBLPQ72i29Ou/TqNRBYxH/sFDDWtTla9QOob0qmzcBA9gR
 v5e4V3Y2nVrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="220777137"
X-IronPort-AV: E=Sophos;i="5.76,429,1592895600";
   d="gz'50?scan'50,208,50";a="220777137"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 01:34:29 -0700
IronPort-SDR: cMdGwN/hJvDDAQDNGFAFhdopT8HFUFhef3UWh8ITDKEFpTezQkkH937bsxdQftdukwqlHg2uN/
 RwWkTv1gqCgw==
X-IronPort-AV: E=Sophos;i="5.76,429,1592895600";
   d="gz'50?scan'50,208,50";a="482681307"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 01:34:25 -0700
Date: Tue, 15 Sep 2020 16:46:06 +0800
From: kernel test robot <lkp@intel.com>
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] mm/memory_hotplug: prepare passing flags to
 add_memory() and friends
Message-ID: <20200915084606.GB20631@xsang-OptiPlex-9020>
MIME-Version: 1.0
In-Reply-To: <20200910091340.8654-4-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: 6IX4E3RRJY6VPDRITTFGQETKDIQQF6AW
X-Message-ID-Hash: 6IX4E3RRJY6VPDRITTFGQETKDIQQF6AW
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: kbuild-all@lists.01.org, clang-built-linux@googlegroups.com, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6IX4E3RRJY6VPDRITTFGQETKDIQQF6AW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi David,

I love your patch! Perhaps something to improve:

[auto build test WARNING on next-20200909]
[cannot apply to mmotm/master hnaz-linux-mm/master xen-tip/linux-next powerpc/next linus/master v5.9-rc4 v5.9-rc3 v5.9-rc2 v5.9-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/David-Hildenbrand/mm-memory_hotplug-selective-merging-of-system-ram-resources/20200910-171630
base:    7204eaa2c1f509066486f488c9dcb065d7484494
:::::: branch date: 9 hours ago
:::::: commit date: 9 hours ago
config: powerpc-randconfig-r011-20200909 (attached as .config)
compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 0a5dc7effb191eff740e0e7ae7bd8e1f6bdb3ad9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/powerpc/kernel/asm-offsets.c:14:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:15:
   In file included from include/linux/radix-tree.h:18:
   In file included from include/linux/xarray.h:14:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:853:
   include/linux/memory_hotplug.h:354:55: error: unknown type name 'mhp_t'
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
   In file included from arch/powerpc/kernel/asm-offsets.c:21:
>> include/linux/mman.h:137:9: warning: division by zero is undefined [-Wdivision-by-zero]
                  _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mman.h:115:21: note: expanded from macro '_calc_vm_trans'
      : ((x) & (bit1)) / ((bit1) / (bit2))))
                       ^ ~~~~~~~~~~~~~~~~~
   include/linux/mman.h:138:9: warning: division by zero is undefined [-Wdivision-by-zero]
                  _calc_vm_trans(flags, MAP_SYNC,       VM_SYNC      );
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mman.h:115:21: note: expanded from macro '_calc_vm_trans'
      : ((x) & (bit1)) / ((bit1) / (bit2))))
                       ^ ~~~~~~~~~~~~~~~~~
   2 warnings and 4 errors generated.
   make[2]: *** [scripts/Makefile.build:117: arch/powerpc/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1196: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:185: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

# https://github.com/0day-ci/linux/commit/d88270d1c0783a7f99f24a85692be90fd2ae0d7d
git remote add linux-review https://github.com/0day-ci/linux
git fetch --no-tags linux-review David-Hildenbrand/mm-memory_hotplug-selective-merging-of-system-ram-resources/20200910-171630
git checkout d88270d1c0783a7f99f24a85692be90fd2ae0d7d
vim +137 include/linux/mman.h

^1da177e4c3f41 Linus Torvalds  2005-04-16  128  
^1da177e4c3f41 Linus Torvalds  2005-04-16  129  /*
^1da177e4c3f41 Linus Torvalds  2005-04-16  130   * Combine the mmap "flags" argument into "vm_flags" used internally.
^1da177e4c3f41 Linus Torvalds  2005-04-16  131   */
^1da177e4c3f41 Linus Torvalds  2005-04-16  132  static inline unsigned long
^1da177e4c3f41 Linus Torvalds  2005-04-16  133  calc_vm_flag_bits(unsigned long flags)
^1da177e4c3f41 Linus Torvalds  2005-04-16  134  {
^1da177e4c3f41 Linus Torvalds  2005-04-16  135  	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
^1da177e4c3f41 Linus Torvalds  2005-04-16  136  	       _calc_vm_trans(flags, MAP_DENYWRITE,  VM_DENYWRITE ) |
b6fb293f2497a9 Jan Kara        2017-11-01 @137  	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
b6fb293f2497a9 Jan Kara        2017-11-01  138  	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      );
^1da177e4c3f41 Linus Torvalds  2005-04-16  139  }
00619bcc44d6b7 Jerome Marchand 2013-11-12  140  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

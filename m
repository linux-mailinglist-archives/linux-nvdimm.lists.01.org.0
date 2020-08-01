Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0F42350CE
	for <lists+linux-nvdimm@lfdr.de>; Sat,  1 Aug 2020 08:24:38 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ADD3412970916;
	Fri, 31 Jul 2020 23:24:36 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 260EC1296320E;
	Fri, 31 Jul 2020 23:24:34 -0700 (PDT)
IronPort-SDR: danqb40wy/bJy47zrb+4T/c/g92+Tk7olTLNxixQ6oSyiyz851GAG1mtaiAYjHf2JoDDorVai0
 pYnLbAEmFTWQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9699"; a="151879058"
X-IronPort-AV: E=Sophos;i="5.75,420,1589266800";
   d="gz'50?scan'50,208,50";a="151879058"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 23:24:33 -0700
IronPort-SDR: 89eYJjt/p9r1c9mD4I9ECtJRVrxot3b9oazl8DrQwYZOWSSVS6GAmIGvuLy3h3wBm5B+1PYSNE
 21iFVKHLyfhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,420,1589266800";
   d="gz'50?scan'50,208,50";a="365797724"
Received: from lkp-server01.sh.intel.com (HELO e21119890065) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 31 Jul 2020 23:24:29 -0700
Received: from kbuild by e21119890065 with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1k1kwW-0000LC-Vy; Sat, 01 Aug 2020 06:24:28 +0000
Date: Sat, 1 Aug 2020 14:24:04 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
Subject: Re: [PATCH v3 06/23] mm/memory_hotplug: Introduce default
 phys_to_target_node() implementation
Message-ID: <202008011427.pH9IrJnc%lkp@intel.com>
References: <159625233419.3040297.13342516597848248917.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <159625233419.3040297.13342516597848248917.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: NQ3OKGF3P63I6IKTHYV2RYRZNVCJQELP
X-Message-ID-Hash: NQ3OKGF3P63I6IKTHYV2RYRZNVCJQELP
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: kbuild-all@lists.01.org, clang-built-linux@googlegroups.com, David Hildenbrand <david@redhat.com>, Mike Rapoport <rppt@linux.ibm.com>, Jia He <justin.he@arm.com>, peterz@infradead.org, dave.hansen@linux.intel.com, ard.biesheuvel@linaro.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NQ3OKGF3P63I6IKTHYV2RYRZNVCJQELP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Dan,

I love your patch! Yet something to improve:

[auto build test ERROR on 01830e6c042e8eb6eb202e05d7df8057135b4c26]

url:    https://github.com/0day-ci/linux/commits/Dan-Williams/device-dax-Support-sub-dividing-soft-reserved-ranges/20200801-114823
base:    01830e6c042e8eb6eb202e05d7df8057135b4c26
config: s390-randconfig-r033-20200731 (attached as .config)
compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 5110fd0343c2d06c8ae538741fbef13ece5e68de)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=s390 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:14:
   In file included from include/linux/mm.h:10:
   In file included from include/linux/gfp.h:6:
   In file included from include/linux/mmzone.h:813:
>> include/linux/memory_hotplug.h:160:19: error: redefinition of 'phys_to_target_node'
   static inline int phys_to_target_node(u64 start)
                     ^
   include/linux/numa.h:38:19: note: previous definition is here
   static inline int phys_to_target_node(phys_addr_t addr)
                     ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:32:
   In file included from include/linux/kvm_para.h:5:
   In file included from include/uapi/linux/kvm_para.h:36:
   In file included from arch/s390/include/asm/kvm_para.h:25:
   In file included from arch/s390/include/asm/diag.h:12:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:72:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:45: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu(__raw_readw(PCI_IOBASE + addr));
                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:36:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:105:32: note: expanded from macro '__swab16'
           (__builtin_constant_p((__u16)(x)) ?     \
                                         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:32:
   In file included from include/linux/kvm_para.h:5:
   In file included from include/uapi/linux/kvm_para.h:36:
   In file included from arch/s390/include/asm/kvm_para.h:25:
   In file included from arch/s390/include/asm/diag.h:12:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:72:
   include/asm-generic/io.h:477:45: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu(__raw_readw(PCI_IOBASE + addr));
                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:36:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:106:21: note: expanded from macro '__swab16'
           ___constant_swab16(x) :                 \
                              ^
   include/uapi/linux/swab.h:15:12: note: expanded from macro '___constant_swab16'
           (((__u16)(x) & (__u16)0x00ffU) << 8) |                  \
                     ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:32:
   In file included from include/linux/kvm_para.h:5:
   In file included from include/uapi/linux/kvm_para.h:36:
   In file included from arch/s390/include/asm/kvm_para.h:25:
   In file included from arch/s390/include/asm/diag.h:12:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:72:
   include/asm-generic/io.h:477:45: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu(__raw_readw(PCI_IOBASE + addr));
                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:36:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:106:21: note: expanded from macro '__swab16'
           ___constant_swab16(x) :                 \
                              ^
   include/uapi/linux/swab.h:16:12: note: expanded from macro '___constant_swab16'
           (((__u16)(x) & (__u16)0xff00U) >> 8)))
                     ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:32:
   In file included from include/linux/kvm_para.h:5:
   In file included from include/uapi/linux/kvm_para.h:36:
   In file included from arch/s390/include/asm/kvm_para.h:25:
   In file included from arch/s390/include/asm/diag.h:12:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:72:
   include/asm-generic/io.h:477:45: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu(__raw_readw(PCI_IOBASE + addr));
                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:36:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:107:12: note: expanded from macro '__swab16'
           __fswab16(x))
                     ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:32:
   In file included from include/linux/kvm_para.h:5:
   In file included from include/uapi/linux/kvm_para.h:36:
   In file included from arch/s390/include/asm/kvm_para.h:25:
   In file included from arch/s390/include/asm/diag.h:12:

vim +/phys_to_target_node +160 include/linux/memory_hotplug.h

   151	
   152	#ifdef CONFIG_NUMA
   153	extern int memory_add_physaddr_to_nid(u64 start);
   154	extern int phys_to_target_node(u64 start);
   155	#else
   156	static inline int memory_add_physaddr_to_nid(u64 start)
   157	{
   158		return 0;
   159	}
 > 160	static inline int phys_to_target_node(u64 start)
   161	{
   162		return 0;
   163	}
   164	#endif
   165	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01995235377
	for <lists+linux-nvdimm@lfdr.de>; Sat,  1 Aug 2020 18:40:38 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EBDBE1293192F;
	Sat,  1 Aug 2020 09:40:35 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 099DA1293192B;
	Sat,  1 Aug 2020 09:40:32 -0700 (PDT)
IronPort-SDR: 4Jttg8XtIPo+g15r3Z1mqdrZyVg95CKR/AJVQ05a1DtDC+TQcaJCVs6FIyo+3utWP/RcV4EADs
 vSceH4YZoHxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9699"; a="216376710"
X-IronPort-AV: E=Sophos;i="5.75,423,1589266800";
   d="gz'50?scan'50,208,50";a="216376710"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2020 09:40:32 -0700
IronPort-SDR: 6AiQcKPzYevG9M/ekfTp9B0fhpqOxt4XO2M+/Z0E76WAKJVfTK7Xf+xV7LAVjc0izyqZXpz33A
 8tppLHsEsXMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,423,1589266800";
   d="gz'50?scan'50,208,50";a="331460661"
Received: from lkp-server01.sh.intel.com (HELO e21119890065) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 01 Aug 2020 09:40:28 -0700
Received: from kbuild by e21119890065 with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1k1uYd-0000YD-QQ; Sat, 01 Aug 2020 16:40:27 +0000
Date: Sun, 2 Aug 2020 00:39:47 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
Subject: Re: [PATCH v3 06/23] mm/memory_hotplug: Introduce default
 phys_to_target_node() implementation
Message-ID: <202008020034.hlUZFxY8%lkp@intel.com>
References: <159625233419.3040297.13342516597848248917.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <159625233419.3040297.13342516597848248917.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: MQAU6QMH5KP6BRSFX4HOJQGHNS56LE77
X-Message-ID-Hash: MQAU6QMH5KP6BRSFX4HOJQGHNS56LE77
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: kbuild-all@lists.01.org, David Hildenbrand <david@redhat.com>, Mike Rapoport <rppt@linux.ibm.com>, Jia He <justin.he@arm.com>, peterz@infradead.org, dave.hansen@linux.intel.com, ard.biesheuvel@linaro.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MQAU6QMH5KP6BRSFX4HOJQGHNS56LE77/>
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
config: x86_64-randconfig-a012-20200731 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-14) 9.3.0
reproduce (this is a W=1 build):
        # save the attached .config to linux build tree
        make W=1 ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/mmzone.h:813,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from include/linux/crypto.h:20,
                    from arch/x86/kernel/asm-offsets.c:9:
>> include/linux/memory_hotplug.h:160:19: error: redefinition of 'phys_to_target_node'
     160 | static inline int phys_to_target_node(u64 start)
         |                   ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/mmzone.h:14,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from include/linux/crypto.h:20,
                    from arch/x86/kernel/asm-offsets.c:9:
   include/linux/numa.h:38:19: note: previous definition of 'phys_to_target_node' was here
      38 | static inline int phys_to_target_node(phys_addr_t addr)
         |                   ^~~~~~~~~~~~~~~~~~~
   make[2]: *** [scripts/Makefile.build:114: arch/x86/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1197: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:185: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

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

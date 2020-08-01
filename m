Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B78522350BC
	for <lists+linux-nvdimm@lfdr.de>; Sat,  1 Aug 2020 08:14:35 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 84C4812970901;
	Fri, 31 Jul 2020 23:14:33 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DC644129708C0;
	Fri, 31 Jul 2020 23:14:30 -0700 (PDT)
IronPort-SDR: ddtSNb5xjt4fMkwVYo/5wEokfkeWcFUfOZ3gbjM5OL9jQJl1DlKGlFDDJ0WDKW+tDICZiJc+H/
 TvQsN2XkwTKg==
X-IronPort-AV: E=McAfee;i="6000,8403,9699"; a="153124064"
X-IronPort-AV: E=Sophos;i="5.75,420,1589266800";
   d="gz'50?scan'50,208,50";a="153124064"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 23:14:29 -0700
IronPort-SDR: 1gsV/I8NbV9uZQI/z/9YDyyNicLeFwmCocv8zU0hb04aRAW2mGCCE4mncNBonIQmX8U57vewCa
 MKe/Hi6TnROA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,420,1589266800";
   d="gz'50?scan'50,208,50";a="323485725"
Received: from lkp-server01.sh.intel.com (HELO e21119890065) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 31 Jul 2020 23:14:26 -0700
Received: from kbuild by e21119890065 with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1k1kmn-0000L3-EN; Sat, 01 Aug 2020 06:14:25 +0000
Date: Sat, 1 Aug 2020 14:14:21 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
Subject: Re: [PATCH v3 21/23] device-dax: Add an 'align' attribute
Message-ID: <202008011419.67BkWnAl%lkp@intel.com>
References: <159625241660.3040297.3801913809845542130.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <159625241660.3040297.3801913809845542130.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: UJMCRVZOLCRSC7NE4K3GPLFSEOO3C4RC
X-Message-ID-Hash: UJMCRVZOLCRSC7NE4K3GPLFSEOO3C4RC
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: kbuild-all@lists.01.org, Joao Martins <joao.m.martins@oracle.com>, peterz@infradead.org, dave.hansen@linux.intel.com, ard.biesheuvel@linaro.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UJMCRVZOLCRSC7NE4K3GPLFSEOO3C4RC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Dan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on 01830e6c042e8eb6eb202e05d7df8057135b4c26]

url:    https://github.com/0day-ci/linux/commits/Dan-Williams/device-dax-Support-sub-dividing-soft-reserved-ranges/20200801-114823
base:    01830e6c042e8eb6eb202e05d7df8057135b4c26
config: m68k-randconfig-r034-20200731 (attached as .config)
compiler: m68k-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

                    from include/linux/irqflags.h:16,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:7,
                    from include/linux/percpu-refcount.h:53,
                    from include/linux/memremap.h:6,
                    from drivers/dax/bus.c:3:
   drivers/dax/bus.c: In function 'dev_dax_shrink':
   include/linux/kernel.h:850:29: warning: comparison of distinct pointer types lacks a cast
     850 |   (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                             ^~
   include/linux/kernel.h:864:4: note: in expansion of macro '__typecheck'
     864 |   (__typecheck(x, y) && __no_side_effects(x, y))
         |    ^~~~~~~~~~~
   include/linux/kernel.h:874:24: note: in expansion of macro '__safe_cmp'
     874 |  __builtin_choose_expr(__safe_cmp(x, y), \
         |                        ^~~~~~~~~~
   include/linux/kernel.h:883:19: note: in expansion of macro '__careful_cmp'
     883 | #define min(x, y) __careful_cmp(x, y, <)
         |                   ^~~~~~~~~~~~~
   drivers/dax/bus.c:881:12: note: in expansion of macro 'min'
     881 |   shrink = min(to_shrink, range_len(range));
         |            ^~~
   In file included from include/linux/printk.h:405,
                    from include/linux/kernel.h:15,
                    from include/linux/list.h:9,
                    from include/linux/preempt.h:11,
                    from arch/m68k/include/asm/irqflags.h:6,
                    from include/linux/irqflags.h:16,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:7,
                    from include/linux/percpu-refcount.h:53,
                    from include/linux/memremap.h:6,
                    from drivers/dax/bus.c:3:
   drivers/dax/bus.c: In function 'dev_dax_validate_align':
   drivers/dax/bus.c:1062:16: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 6 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
    1062 |   dev_dbg(dev, "%s: align %u invalid for size %llu\n",
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:125:15: note: in definition of macro '__dynamic_func_call'
     125 |   func(&id, ##__VA_ARGS__);  \
         |               ^~~~~~~~~~~
   include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
     157 |  _dynamic_func_call(fmt,__dynamic_dev_dbg,   \
         |  ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:115:2: note: in expansion of macro 'dynamic_dev_dbg'
     115 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |  ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:115:23: note: in expansion of macro 'dev_fmt'
     115 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                       ^~~~~~~
   drivers/dax/bus.c:1062:3: note: in expansion of macro 'dev_dbg'
    1062 |   dev_dbg(dev, "%s: align %u invalid for size %llu\n",
         |   ^~~~~~~
   drivers/dax/bus.c:1062:50: note: format string is defined here
    1062 |   dev_dbg(dev, "%s: align %u invalid for size %llu\n",
         |                                               ~~~^
         |                                                  |
         |                                                  long long unsigned int
         |                                               %u
   In file included from include/linux/printk.h:405,
                    from include/linux/kernel.h:15,
                    from include/linux/list.h:9,
                    from include/linux/preempt.h:11,
                    from arch/m68k/include/asm/irqflags.h:6,
                    from include/linux/irqflags.h:16,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:7,
                    from include/linux/percpu-refcount.h:53,
                    from include/linux/memremap.h:6,
                    from drivers/dax/bus.c:3:
   drivers/dax/bus.c:1071:17: warning: format '%ld' expects argument of type 'long int', but argument 6 has type 'ssize_t' {aka 'int'} [-Wformat=]
    1071 |    dev_dbg(dev, "%s: align %u invalid for range %ld\n",
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:125:15: note: in definition of macro '__dynamic_func_call'
     125 |   func(&id, ##__VA_ARGS__);  \
         |               ^~~~~~~~~~~
   include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
     157 |  _dynamic_func_call(fmt,__dynamic_dev_dbg,   \
         |  ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:115:2: note: in expansion of macro 'dynamic_dev_dbg'
     115 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |  ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:115:23: note: in expansion of macro 'dev_fmt'
     115 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                       ^~~~~~~
   drivers/dax/bus.c:1071:4: note: in expansion of macro 'dev_dbg'
    1071 |    dev_dbg(dev, "%s: align %u invalid for range %ld\n",
         |    ^~~~~~~
   drivers/dax/bus.c:1071:51: note: format string is defined here
    1071 |    dev_dbg(dev, "%s: align %u invalid for range %ld\n",
         |                                                 ~~^
         |                                                   |
         |                                                   long int
         |                                                 %d
   In file included from include/asm-generic/pgtable-nopud.h:7,
                    from arch/m68k/include/asm/pgtable_no.h:5,
                    from arch/m68k/include/asm/pgtable.h:3,
                    from include/linux/pgtable.h:6,
                    from include/linux/mm.h:33,
                    from include/linux/dax.h:6,
                    from drivers/dax/bus.c:8:
>> include/asm-generic/pgtable-nop4d.h:11:20: error: 'PGDIR_SHIFT' undeclared (first use in this function); did you mean 'PUD_SHIFT'?
      11 | #define P4D_SHIFT  PGDIR_SHIFT
         |                    ^~~~~~~~~~~
   include/asm-generic/pgtable-nopud.h:18:19: note: in expansion of macro 'P4D_SHIFT'
      18 | #define PUD_SHIFT P4D_SHIFT
         |                   ^~~~~~~~~
   include/asm-generic/pgtable-nopud.h:20:28: note: in expansion of macro 'PUD_SHIFT'
      20 | #define PUD_SIZE   (1UL << PUD_SHIFT)
         |                            ^~~~~~~~~
   drivers/dax/bus.c:1078:7: note: in expansion of macro 'PUD_SIZE'
    1078 |  case PUD_SIZE:
         |       ^~~~~~~~
   include/asm-generic/pgtable-nop4d.h:11:20: note: each undeclared identifier is reported only once for each function it appears in
      11 | #define P4D_SHIFT  PGDIR_SHIFT
         |                    ^~~~~~~~~~~
   include/asm-generic/pgtable-nopud.h:18:19: note: in expansion of macro 'P4D_SHIFT'
      18 | #define PUD_SHIFT P4D_SHIFT
         |                   ^~~~~~~~~
   include/asm-generic/pgtable-nopud.h:20:28: note: in expansion of macro 'PUD_SHIFT'
      20 | #define PUD_SIZE   (1UL << PUD_SHIFT)
         |                            ^~~~~~~~~
   drivers/dax/bus.c:1078:7: note: in expansion of macro 'PUD_SIZE'
    1078 |  case PUD_SIZE:
         |       ^~~~~~~~
>> drivers/dax/bus.c:1082:7: error: 'PMD_SIZE' undeclared (first use in this function); did you mean 'P4D_SIZE'?
    1082 |  case PMD_SIZE:
         |       ^~~~~~~~
         |       P4D_SIZE

vim +1082 drivers/dax/bus.c

  1050	
  1051	static ssize_t dev_dax_validate_align(struct dev_dax *dev_dax)
  1052	{
  1053		resource_size_t dev_size = dev_dax_size(dev_dax);
  1054		struct device *dev = &dev_dax->dev;
  1055		ssize_t rc, i;
  1056	
  1057		if (dev->driver)
  1058			return -EBUSY;
  1059	
  1060		rc = -EINVAL;
  1061		if (dev_size > 0 && !alloc_is_aligned(dev_dax, dev_size)) {
  1062			dev_dbg(dev, "%s: align %u invalid for size %llu\n",
  1063				__func__, dev_dax->align, dev_size);
  1064			return rc;
  1065		}
  1066	
  1067		for (i = 0; i < dev_dax->nr_range; i++) {
  1068			size_t len = range_len(&dev_dax->ranges[i].range);
  1069	
  1070			if (!alloc_is_aligned(dev_dax, len)) {
  1071				dev_dbg(dev, "%s: align %u invalid for range %ld\n",
  1072					__func__, dev_dax->align, i);
  1073				return rc;
  1074			}
  1075		}
  1076	
  1077		switch (dev_dax->align) {
  1078		case PUD_SIZE:
  1079			if (!IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD))
  1080				break;
  1081			fallthrough;
> 1082		case PMD_SIZE:
  1083			if (!has_transparent_hugepage())
  1084				break;
  1085			fallthrough;
  1086		case PAGE_SIZE:
  1087			rc = 0;
  1088			break;
  1089		}
  1090	
  1091		return rc;
  1092	}
  1093	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

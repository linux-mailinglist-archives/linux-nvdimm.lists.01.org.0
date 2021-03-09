Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC2D332EB8
	for <lists+linux-nvdimm@lfdr.de>; Tue,  9 Mar 2021 20:08:50 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 18A8B100EB84C;
	Tue,  9 Mar 2021 11:08:49 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2E67A100EB844;
	Tue,  9 Mar 2021 11:08:44 -0800 (PST)
IronPort-SDR: qK01eevuCywm75jBxl9xNDp2VSwGEuyCtvMEbHfFvF2HVKr/MGA2E6Ha02InQMfQNrbGaqa+QR
 KLWr3LzAOEmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="175906604"
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400";
   d="gz'50?scan'50,208,50";a="175906604"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 11:08:41 -0800
IronPort-SDR: M1j+xlD5sLP8eMoADhfjgqlp0CoimhZsH3+sgy76Z2bg7yuOQgMhNshzarkv7oBOVKHyb7gZQV
 wk+3G2cgCa1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400";
   d="gz'50?scan'50,208,50";a="588546725"
Received: from lkp-server01.sh.intel.com (HELO 3e992a48ca98) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 09 Mar 2021 11:08:37 -0800
Received: from kbuild by 3e992a48ca98 with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1lJhie-0001mF-Q4; Tue, 09 Mar 2021 19:08:36 +0000
Date: Wed, 10 Mar 2021 03:07:36 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
	linux-nvdimm@lists.01.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] include: Remove pagemap.h from blkdev.h
Message-ID: <202103100300.wXlhemYV-lkp@intel.com>
References: <20210309181533.231573-1-willy@infradead.org>
MIME-Version: 1.0
In-Reply-To: <20210309181533.231573-1-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: VNZRACBDOVW7WIA4I4E7HOY3PH7XWK5A
X-Message-ID-Hash: VNZRACBDOVW7WIA4I4E7HOY3PH7XWK5A
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: kbuild-all@lists.01.org, Linux Memory Management List <linux-mm@kvack.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VNZRACBDOVW7WIA4I4E7HOY3PH7XWK5A/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi "Matthew,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on block/for-next]
[also build test ERROR on linus/master v5.12-rc2 next-20210309]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Matthew-Wilcox-Oracle/include-Remove-pagemap-h-from-blkdev-h/20210310-021720
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: powerpc64-randconfig-m031-20210309 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/b47f527df5ad6c9ece259086b85bf4f0dfd27025
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Matthew-Wilcox-Oracle/include-Remove-pagemap-h-from-blkdev-h/20210310-021720
        git checkout b47f527df5ad6c9ece259086b85bf4f0dfd27025
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/suspend.h:5,
                    from arch/powerpc/kernel/asm-offsets.c:23:
   include/linux/swap.h: In function 'find_get_incore_page':
>> include/linux/swap.h:578:9: error: implicit declaration of function 'find_get_page'; did you mean 'find_get_pid'? [-Werror=implicit-function-declaration]
     578 |  return find_get_page(mapping, index);
         |         ^~~~~~~~~~~~~
         |         find_get_pid
>> include/linux/swap.h:578:9: warning: returning 'int' from a function with return type 'struct page *' makes pointer from integer without a cast [-Wint-conversion]
     578 |  return find_get_page(mapping, index);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/suspend.h:5,
                    from arch/powerpc/kernel/asm-offsets.c:23:
   include/linux/swap.h: In function 'find_get_incore_page':
>> include/linux/swap.h:578:9: error: implicit declaration of function 'find_get_page'; did you mean 'find_get_pid'? [-Werror=implicit-function-declaration]
     578 |  return find_get_page(mapping, index);
         |         ^~~~~~~~~~~~~
         |         find_get_pid
>> include/linux/swap.h:578:9: warning: returning 'int' from a function with return type 'struct page *' makes pointer from integer without a cast [-Wint-conversion]
     578 |  return find_get_page(mapping, index);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:116: arch/powerpc/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1233: prepare0] Error 2
   make[1]: Target 'modules_prepare' not remade because of errors.
   make: *** [Makefile:215: __sub-make] Error 2
   make: Target 'modules_prepare' not remade because of errors.
--
   In file included from include/linux/suspend.h:5,
                    from arch/powerpc/kernel/asm-offsets.c:23:
   include/linux/swap.h: In function 'find_get_incore_page':
>> include/linux/swap.h:578:9: error: implicit declaration of function 'find_get_page'; did you mean 'find_get_pid'? [-Werror=implicit-function-declaration]
     578 |  return find_get_page(mapping, index);
         |         ^~~~~~~~~~~~~
         |         find_get_pid
>> include/linux/swap.h:578:9: warning: returning 'int' from a function with return type 'struct page *' makes pointer from integer without a cast [-Wint-conversion]
     578 |  return find_get_page(mapping, index);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:116: arch/powerpc/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1233: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:215: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +578 include/linux/swap.h

bd96b9eb7cfd6a Con Kolivas             2006-06-23  574  
61ef1865570452 Matthew Wilcox (Oracle  2020-10-13  575) static inline
61ef1865570452 Matthew Wilcox (Oracle  2020-10-13  576) struct page *find_get_incore_page(struct address_space *mapping, pgoff_t index)
61ef1865570452 Matthew Wilcox (Oracle  2020-10-13  577) {
61ef1865570452 Matthew Wilcox (Oracle  2020-10-13 @578) 	return find_get_page(mapping, index);
61ef1865570452 Matthew Wilcox (Oracle  2020-10-13  579) }
61ef1865570452 Matthew Wilcox (Oracle  2020-10-13  580) 

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

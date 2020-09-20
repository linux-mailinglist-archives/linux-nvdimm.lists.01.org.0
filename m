Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D230E2711BF
	for <lists+linux-nvdimm@lfdr.de>; Sun, 20 Sep 2020 04:10:58 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 915EA13DCA24B;
	Sat, 19 Sep 2020 19:10:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C550013DCA247;
	Sat, 19 Sep 2020 19:10:48 -0700 (PDT)
IronPort-SDR: 9OWSrDBgT0i8NAONji1aAINLECNnX/mJxkVQCMvgb4OxxK0YGagw8EgJNflfpLXlLGs4voXBsL
 JP1CFfpRJHXw==
X-IronPort-AV: E=McAfee;i="6000,8403,9749"; a="140196611"
X-IronPort-AV: E=Sophos;i="5.77,281,1596524400";
   d="gz'50?scan'50,208,50";a="140196611"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2020 19:10:47 -0700
IronPort-SDR: RV4tiF3PMqiQfVzoTLWvVFkKfAdlsKsD3amv57hk1/DplBu0n9xHTJRAUE1YX8skq64DLyFlQW
 3JvB5g4dbLfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,281,1596524400";
   d="gz'50?scan'50,208,50";a="453407247"
Received: from lkp-server01.sh.intel.com (HELO a05db971c861) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 19 Sep 2020 19:10:45 -0700
Received: from kbuild by a05db971c861 with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1kJooO-0001Ez-Rn; Sun, 20 Sep 2020 02:10:44 +0000
Date: Sun, 20 Sep 2020 10:10:16 +0800
From: kernel test robot <lkp@intel.com>
To: Jan Kara <jack@suse.cz>
Subject: [linux-nvdimm:libnvdimm-fixes 2/3] drivers/dax/super.c:31:5: error:
 redefinition of 'dax_read_lock'
Message-ID: <202009201011.whDg0a8t%lkp@intel.com>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: 6657IFUS6BBOJCET2UCRGWKVZWPCHSWQ
X-Message-ID-Hash: 6657IFUS6BBOJCET2UCRGWKVZWPCHSWQ
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: kbuild-all@lists.01.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6657IFUS6BBOJCET2UCRGWKVZWPCHSWQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git libnvdimm-fixes
head:   5ca46d3ef704a0d0ddd79a7dfa164a6a5b6ccef2
commit: 5ba388db58497496fbeb952c9454e8e6e59584ac [2/3] dm: Call proper helper to determine dax support
config: m68k-hp300_defconfig (attached as .config)
compiler: m68k-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 5ba388db58497496fbeb952c9454e8e6e59584ac
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/m68k/include/asm/page.h:60,
                    from arch/m68k/include/asm/thread_info.h:6,
                    from include/linux/thread_info.h:38,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:51,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:10,
                    from include/linux/pagemap.h:8,
                    from drivers/dax/super.c:5:
   include/linux/pfn_t.h: In function 'pfn_t_valid':
   arch/m68k/include/asm/page_mm.h:169:49: warning: ordered comparison of pointer with null pointer [-Wextra]
     169 | #define virt_addr_valid(kaddr) ((void *)(kaddr) >= (void *)PAGE_OFFSET && (void *)(kaddr) < high_memory)
         |                                                 ^~
   arch/m68k/include/asm/page_mm.h:170:25: note: in expansion of macro 'virt_addr_valid'
     170 | #define pfn_valid(pfn)  virt_addr_valid(pfn_to_virt(pfn))
         |                         ^~~~~~~~~~~~~~~
   include/linux/pfn_t.h:76:9: note: in expansion of macro 'pfn_valid'
      76 |  return pfn_valid(pfn_t_to_pfn(pfn));
         |         ^~~~~~~~~
   drivers/dax/super.c: At top level:
>> drivers/dax/super.c:31:5: error: redefinition of 'dax_read_lock'
      31 | int dax_read_lock(void)
         |     ^~~~~~~~~~~~~
   In file included from drivers/dax/super.c:16:
   include/linux/dax.h:205:19: note: previous definition of 'dax_read_lock' was here
     205 | static inline int dax_read_lock(void)
         |                   ^~~~~~~~~~~~~
>> drivers/dax/super.c:37:6: error: redefinition of 'dax_read_unlock'
      37 | void dax_read_unlock(int id)
         |      ^~~~~~~~~~~~~~~
   In file included from drivers/dax/super.c:16:
   include/linux/dax.h:210:20: note: previous definition of 'dax_read_unlock' was here
     210 | static inline void dax_read_unlock(int id)
         |                    ^~~~~~~~~~~~~~~
   drivers/dax/super.c:69:6: warning: no previous prototype for '__generic_fsdax_supported' [-Wmissing-prototypes]
      69 | bool __generic_fsdax_supported(struct dax_device *dax_dev,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/dax/super.c:167:6: warning: no previous prototype for '__bdev_dax_supported' [-Wmissing-prototypes]
     167 | bool __bdev_dax_supported(struct block_device *bdev, int blocksize)
         |      ^~~~~~~~~~~~~~~~~~~~
>> drivers/dax/super.c:325:6: error: redefinition of 'dax_supported'
     325 | bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
         |      ^~~~~~~~~~~~~
   In file included from drivers/dax/super.c:16:
   include/linux/dax.h:162:20: note: previous definition of 'dax_supported' was here
     162 | static inline bool dax_supported(struct dax_device *dax_dev,
         |                    ^~~~~~~~~~~~~
   drivers/dax/super.c:451:6: warning: no previous prototype for 'run_dax' [-Wmissing-prototypes]
     451 | void run_dax(struct dax_device *dax_dev)
         |      ^~~~~~~

# https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/commit/?id=5ba388db58497496fbeb952c9454e8e6e59584ac
git remote add linux-nvdimm https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git
git fetch --no-tags linux-nvdimm libnvdimm-fixes
git checkout 5ba388db58497496fbeb952c9454e8e6e59584ac
vim +/dax_read_lock +31 drivers/dax/super.c

72058005411ffd Dan Williams 2017-04-19  30  
7b6be8444e0f0d Dan Williams 2017-04-11 @31  int dax_read_lock(void)
7b6be8444e0f0d Dan Williams 2017-04-11  32  {
7b6be8444e0f0d Dan Williams 2017-04-11  33  	return srcu_read_lock(&dax_srcu);
7b6be8444e0f0d Dan Williams 2017-04-11  34  }
7b6be8444e0f0d Dan Williams 2017-04-11  35  EXPORT_SYMBOL_GPL(dax_read_lock);
7b6be8444e0f0d Dan Williams 2017-04-11  36  
7b6be8444e0f0d Dan Williams 2017-04-11 @37  void dax_read_unlock(int id)
7b6be8444e0f0d Dan Williams 2017-04-11  38  {
7b6be8444e0f0d Dan Williams 2017-04-11  39  	srcu_read_unlock(&dax_srcu, id);
7b6be8444e0f0d Dan Williams 2017-04-11  40  }
7b6be8444e0f0d Dan Williams 2017-04-11  41  EXPORT_SYMBOL_GPL(dax_read_unlock);
7b6be8444e0f0d Dan Williams 2017-04-11  42  

:::::: The code at line 31 was first introduced by commit
:::::: 7b6be8444e0f0dd675b54d059793423d3c9b4c03 dax: refactor dax-fs into a generic provider of 'struct dax_device' instances

:::::: TO: Dan Williams <dan.j.williams@intel.com>
:::::: CC: Dan Williams <dan.j.williams@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

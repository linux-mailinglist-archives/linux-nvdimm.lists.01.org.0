Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB9F27B871
	for <lists+linux-nvdimm@lfdr.de>; Tue, 29 Sep 2020 01:48:10 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6204A151D345D;
	Mon, 28 Sep 2020 16:48:08 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E3B52151D3458;
	Mon, 28 Sep 2020 16:48:05 -0700 (PDT)
IronPort-SDR: 4CAeZBYTjMBL2fkn39T7RPSESYxjIyr3T+oNbDdiatDLCvu0es0tb6ubkpsSXm32NX8EKnC//m
 KAem2LyohxLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="223673515"
X-IronPort-AV: E=Sophos;i="5.77,315,1596524400";
   d="gz'50?scan'50,208,50";a="223673515"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 16:48:03 -0700
IronPort-SDR: wvaYXah1fObSY4WhWd6WLCGDeFDlGVwDTy8jsPc4B3EEEc9spWbkssrsa5rUUnCw/UuyNUkOWd
 g9JhwvzO7O9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,315,1596524400";
   d="gz'50?scan'50,208,50";a="345073017"
Received: from lkp-server01.sh.intel.com (HELO 0e0978ea3297) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 28 Sep 2020 16:47:59 -0700
Received: from kbuild by 0e0978ea3297 with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1kN2sB-0000Rf-5u; Mon, 28 Sep 2020 23:47:59 +0000
Date: Tue, 29 Sep 2020 07:47:16 +0800
From: kernel test robot <lkp@intel.com>
To: nmeeramohide@micron.com, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-mm@kvack.org, linux-nvdimm@lists.01.org
Subject: Re: [PATCH 22/22] mpool: add Kconfig and Makefile
Message-ID: <202009290752.VLWnaMdz%lkp@intel.com>
References: <20200928164534.48203-23-nmeeramohide@micron.com>
MIME-Version: 1.0
In-Reply-To: <20200928164534.48203-23-nmeeramohide@micron.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: GJLVAE6O6OHSB4QUPASYIRUDWK2ZAWIL
X-Message-ID-Hash: GJLVAE6O6OHSB4QUPASYIRUDWK2ZAWIL
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: kbuild-all@lists.01.org, smoyer@micron.com, gbecker@micron.com, plabat@micron.com, jgroves@micron.com, Nabeel M Mohamed <nmeeramohide@micron.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GJLVAE6O6OHSB4QUPASYIRUDWK2ZAWIL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linux/master]
[also build test ERROR on linus/master v5.9-rc7 next-20200928]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/nmeeramohide-micron-com/add-Object-Storage-Media-Pool-mpool/20200929-004933
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git bcf876870b95592b52519ed4aafcf9d95999bc9c
config: m68k-allmodconfig (attached as .config)
compiler: m68k-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/0d485fc58582bd112bb72fe15f107e8cbe3536b0
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review nmeeramohide-micron-com/add-Object-Storage-Media-Pool-mpool/20200929-004933
        git checkout 0d485fc58582bd112bb72fe15f107e8cbe3536b0
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from arch/m68k/include/asm/io_mm.h:25,
                    from arch/m68k/include/asm/io.h:8,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from include/asm-generic/hardirq.h:13,
                    from ./arch/m68k/include/generated/asm/hardirq.h:1,
                    from include/linux/hardirq.h:10,
                    from include/linux/highmem.h:10,
                    from include/linux/pagemap.h:11,
                    from include/linux/blkdev.h:16,
                    from drivers/mpool/pd.c:15:
   arch/m68k/include/asm/raw_io.h: In function 'raw_rom_outsb':
   arch/m68k/include/asm/raw_io.h:83:7: warning: variable '__w' set but not used [-Wunused-but-set-variable]
      83 |  ({u8 __w, __v = (b);  u32 _addr = ((u32) (addr)); \
         |       ^~~
   arch/m68k/include/asm/raw_io.h:430:3: note: in expansion of macro 'rom_out_8'
     430 |   rom_out_8(port, *buf++);
         |   ^~~~~~~~~
   arch/m68k/include/asm/raw_io.h: In function 'raw_rom_outsw':
   arch/m68k/include/asm/raw_io.h:86:8: warning: variable '__w' set but not used [-Wunused-but-set-variable]
      86 |  ({u16 __w, __v = (w); u32 _addr = ((u32) (addr)); \
         |        ^~~
   arch/m68k/include/asm/raw_io.h:448:3: note: in expansion of macro 'rom_out_be16'
     448 |   rom_out_be16(port, *buf++);
         |   ^~~~~~~~~~~~
   arch/m68k/include/asm/raw_io.h: In function 'raw_rom_outsw_swapw':
   arch/m68k/include/asm/raw_io.h:90:8: warning: variable '__w' set but not used [-Wunused-but-set-variable]
      90 |  ({u16 __w, __v = (w); u32 _addr = ((u32) (addr)); \
         |        ^~~
   arch/m68k/include/asm/raw_io.h:466:3: note: in expansion of macro 'rom_out_le16'
     466 |   rom_out_le16(port, *buf++);
         |   ^~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from drivers/mpool/pd.c:14:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_mm.h:169:49: warning: ordered comparison of pointer with null pointer [-Wextra]
     169 | #define virt_addr_valid(kaddr) ((void *)(kaddr) >= (void *)PAGE_OFFSET && (void *)(kaddr) < high_memory)
         |                                                 ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/mpool/pd.c: In function 'pd_bio_rw':
>> drivers/mpool/pd.c:294:14: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     294 |   iov_base = (u64)iov[i].iov_base;
         |              ^
>> drivers/mpool/pd.c:224:13: warning: variable 'op' set but not used [-Wunused-but-set-variable]
     224 |  int i, cc, op;
         |             ^~
--
>> drivers/mpool/omf.c:27: warning: "STR" redefined
      27 | #define STR(x)  _STR(x)
         | 
   In file included from arch/m68k/include/asm/irqflags.h:8,
                    from include/linux/irqflags.h:16,
                    from include/linux/spinlock.h:54,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from drivers/mpool/omf.c:16:
   arch/m68k/include/asm/entry.h:244: note: this is the location of the previous definition
     244 | #define STR(X) STR1(X)
         | 
   drivers/mpool/omf.c:28:19: warning: 'mpool_sbver' defined but not used [-Wunused-const-variable=]
      28 | static const char mpool_sbver[] = "MPOOL_SBVER_" STR(OMF_SB_DESC_VER_LAST);
         |                   ^~~~~~~~~~~
--
   In file included from include/linux/printk.h:7,
                    from include/linux/kernel.h:15,
                    from include/asm-generic/bug.h:19,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from drivers/mpool/mdc.c:6:
   drivers/mpool/mdc.c: In function 'mp_mdc_read':
   include/linux/kern_levels.h:5:18: warning: format '%lu' expects argument of type 'long unsigned int', but argument 6 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
       5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
         |                  ^~~~~~
   include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SOH'
      11 | #define KERN_ERR KERN_SOH "3" /* error conditions */
         |                  ^~~~~~~~
   include/linux/printk.h:338:9: note: in expansion of macro 'KERN_ERR'
     338 |  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~
   drivers/mpool/mpool_printk.h:17:2: note: in expansion of macro 'pr_err'
      17 |  pr_err("%s: " _fmt ": errno %d", __func__, ## __VA_ARGS__, (_err))
         |  ^~~~~~
   drivers/mpool/mdc.c:458:3: note: in expansion of macro 'mp_pr_err'
     458 |   mp_pr_err("mpool %s, mdc %p read failed, mlog %p len %lu",
         |   ^~~~~~~~~
   drivers/mpool/mdc.c:458:58: note: format string is defined here
     458 |   mp_pr_err("mpool %s, mdc %p read failed, mlog %p len %lu",
         |                                                        ~~^
         |                                                          |
         |                                                          long unsigned int
         |                                                        %u
   In file included from include/linux/printk.h:7,
                    from include/linux/kernel.h:15,
                    from include/asm-generic/bug.h:19,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from drivers/mpool/mdc.c:6:
   drivers/mpool/mdc.c: In function 'mp_mdc_append':
>> include/linux/kern_levels.h:5:18: warning: format '%lu' expects argument of type 'long unsigned int', but argument 6 has type 'ssize_t' {aka 'int'} [-Wformat=]
       5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
         |                  ^~~~~~
   include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SOH'
      11 | #define KERN_ERR KERN_SOH "3" /* error conditions */
         |                  ^~~~~~~~
   include/linux/printk.h:338:9: note: in expansion of macro 'KERN_ERR'
     338 |  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~
   drivers/mpool/mpool_printk.h:39:3: note: in expansion of macro 'pr_err'
      39 |   pr_err("%s: " _fmt ": errno %d",  \
         |   ^~~~~~
   drivers/mpool/mdc.c:480:3: note: in expansion of macro 'mp_pr_rl'
     480 |   mp_pr_rl("mpool %s, mdc %p append failed, mlog %p, len %lu sync %d",
         |   ^~~~~~~~
   drivers/mpool/mdc.c:480:60: note: format string is defined here
     480 |   mp_pr_rl("mpool %s, mdc %p append failed, mlog %p, len %lu sync %d",
         |                                                          ~~^
         |                                                            |
         |                                                            long unsigned int
         |                                                          %u
--
   In file included from arch/m68k/include/asm/io_mm.h:25,
                    from arch/m68k/include/asm/io.h:8,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from include/asm-generic/hardirq.h:13,
                    from ./arch/m68k/include/generated/asm/hardirq.h:1,
                    from include/linux/hardirq.h:10,
                    from include/linux/highmem.h:10,
                    from include/linux/pagemap.h:11,
                    from include/linux/blkdev.h:16,
                    from drivers/mpool/mpctl.c:14:
   arch/m68k/include/asm/raw_io.h: In function 'raw_rom_outsb':
   arch/m68k/include/asm/raw_io.h:83:7: warning: variable '__w' set but not used [-Wunused-but-set-variable]
      83 |  ({u8 __w, __v = (b);  u32 _addr = ((u32) (addr)); \
         |       ^~~
   arch/m68k/include/asm/raw_io.h:430:3: note: in expansion of macro 'rom_out_8'
     430 |   rom_out_8(port, *buf++);
         |   ^~~~~~~~~
   arch/m68k/include/asm/raw_io.h: In function 'raw_rom_outsw':
   arch/m68k/include/asm/raw_io.h:86:8: warning: variable '__w' set but not used [-Wunused-but-set-variable]
      86 |  ({u16 __w, __v = (w); u32 _addr = ((u32) (addr)); \
         |        ^~~
   arch/m68k/include/asm/raw_io.h:448:3: note: in expansion of macro 'rom_out_be16'
     448 |   rom_out_be16(port, *buf++);
         |   ^~~~~~~~~~~~
   arch/m68k/include/asm/raw_io.h: In function 'raw_rom_outsw_swapw':
   arch/m68k/include/asm/raw_io.h:90:8: warning: variable '__w' set but not used [-Wunused-but-set-variable]
      90 |  ({u16 __w, __v = (w); u32 _addr = ((u32) (addr)); \
         |        ^~~
   arch/m68k/include/asm/raw_io.h:466:3: note: in expansion of macro 'rom_out_le16'
     466 |   rom_out_le16(port, *buf++);
         |   ^~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from drivers/mpool/mpctl.c:6:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_mm.h:169:49: warning: ordered comparison of pointer with null pointer [-Wextra]
     169 | #define virt_addr_valid(kaddr) ((void *)(kaddr) >= (void *)PAGE_OFFSET && (void *)(kaddr) < high_memory)
         |                                                 ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/mpool/mpctl.c: In function 'mpc_open':
>> drivers/mpool/mpctl.c:2393:23: warning: left shift count >= width of type [-Wshift-count-overflow]
    2393 |  i_size_write(ip, 1ul << 63);
         |                       ^~
--
   In file included from arch/m68k/include/asm/io_mm.h:25,
                    from arch/m68k/include/asm/io.h:8,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from include/asm-generic/hardirq.h:13,
                    from ./arch/m68k/include/generated/asm/hardirq.h:1,
                    from include/linux/hardirq.h:10,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from include/linux/cgroup.h:26,
                    from include/linux/memcontrol.h:13,
                    from drivers/mpool/mcache.c:7:
   arch/m68k/include/asm/raw_io.h: In function 'raw_rom_outsb':
   arch/m68k/include/asm/raw_io.h:83:7: warning: variable '__w' set but not used [-Wunused-but-set-variable]
      83 |  ({u8 __w, __v = (b);  u32 _addr = ((u32) (addr)); \
         |       ^~~
   arch/m68k/include/asm/raw_io.h:430:3: note: in expansion of macro 'rom_out_8'
     430 |   rom_out_8(port, *buf++);
         |   ^~~~~~~~~
   arch/m68k/include/asm/raw_io.h: In function 'raw_rom_outsw':
   arch/m68k/include/asm/raw_io.h:86:8: warning: variable '__w' set but not used [-Wunused-but-set-variable]
      86 |  ({u16 __w, __v = (w); u32 _addr = ((u32) (addr)); \
         |        ^~~
   arch/m68k/include/asm/raw_io.h:448:3: note: in expansion of macro 'rom_out_be16'
     448 |   rom_out_be16(port, *buf++);
         |   ^~~~~~~~~~~~
   arch/m68k/include/asm/raw_io.h: In function 'raw_rom_outsw_swapw':
   arch/m68k/include/asm/raw_io.h:90:8: warning: variable '__w' set but not used [-Wunused-but-set-variable]
      90 |  ({u16 __w, __v = (w); u32 _addr = ((u32) (addr)); \
         |        ^~~
   arch/m68k/include/asm/raw_io.h:466:3: note: in expansion of macro 'rom_out_le16'
     466 |   rom_out_le16(port, *buf++);
         |   ^~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from drivers/mpool/mcache.c:6:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_mm.h:169:49: warning: ordered comparison of pointer with null pointer [-Wextra]
     169 | #define virt_addr_valid(kaddr) ((void *)(kaddr) >= (void *)PAGE_OFFSET && (void *)(kaddr) < high_memory)
         |                                                 ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/mpool/mcache.c: In function 'mpc_readpages':
>> drivers/mpool/mcache.c:581:3: error: implicit declaration of function 'prefetchw' [-Werror=implicit-function-declaration]
     581 |   prefetchw(&page->flags);
         |   ^~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/mpool/reaper.c: In function 'mpc_reap_xvm_add':
>> drivers/mpool/reaper.c:577:12: warning: variable 'mult' set but not used [-Wunused-but-set-variable]
     577 |  uint idx, mult;
         |            ^~~~

vim +/prefetchw +581 drivers/mpool/mcache.c

3114e86da188ef1 Nabeel M Mohamed 2020-09-28  499  
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  500  static int mpc_readpages(struct file *file, struct address_space *mapping,
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  501  			 struct list_head *pages, uint nr_pages)
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  502  {
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  503  	struct workqueue_struct *wq;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  504  	struct readpage_work *w;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  505  	struct work_struct *work;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  506  	struct mpc_mbinfo *mbinfo;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  507  	struct mpc_unit *unit;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  508  	struct mpc_xvm *xvm;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  509  	struct page *page;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  510  	off_t offset, mbend;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  511  	uint mbnum, iovmax, i;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  512  	uint ra_pages_max;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  513  	ulong index;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  514  	gfp_t gfp;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  515  	u32 key;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  516  	int rc;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  517  
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  518  	unit = file->private_data;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  519  
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  520  	ra_pages_max = unit->un_ra_pages_max;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  521  	if (ra_pages_max < 1)
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  522  		return 0;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  523  
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  524  	page   = lru_to_page(pages);
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  525  	offset = page->index << PAGE_SHIFT;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  526  	index  = page->index;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  527  	work   = NULL;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  528  	w      = NULL;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  529  
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  530  	key = offset >> xvm_size_max;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  531  
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  532  	/*
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  533  	 * The idr value here (xvm) is pinned for the lifetime of the address map.
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  534  	 * Therefore, we can exit the rcu read-side critsec without worry that xvm will be
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  535  	 * destroyed before put_page() has been called on each and every page in the given
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  536  	 * list of pages.
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  537  	 */
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  538  	rcu_read_lock();
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  539  	xvm = idr_find(&unit->un_rgnmap.rm_root, key);
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  540  	rcu_read_unlock();
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  541  
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  542  	if (!xvm)
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  543  		return 0;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  544  
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  545  	offset %= (1ul << xvm_size_max);
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  546  
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  547  	mbnum = offset / xvm->xvm_bktsz;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  548  	if (mbnum >= xvm->xvm_mbinfoc)
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  549  		return 0;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  550  
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  551  	mbinfo = xvm->xvm_mbinfov + mbnum;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  552  
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  553  	mbend = mbnum * xvm->xvm_bktsz + mbinfo->mblen;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  554  	iovmax = MPC_RA_IOV_MAX;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  555  
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  556  	gfp = mapping_gfp_mask(mapping) & GFP_KERNEL;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  557  	wq = mpc_rgn2wq(xvm->xvm_rgn);
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  558  
f5867898fb79966 Nabeel M Mohamed 2020-09-28  559  	if (mpc_reap_xvm_duress(xvm))
f5867898fb79966 Nabeel M Mohamed 2020-09-28  560  		nr_pages = min_t(uint, nr_pages, 8);
f5867898fb79966 Nabeel M Mohamed 2020-09-28  561  
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  562  	nr_pages = min_t(uint, nr_pages, ra_pages_max);
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  563  
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  564  	for (i = 0; i < nr_pages; ++i) {
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  565  		page    = lru_to_page(pages);
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  566  		offset  = page->index << PAGE_SHIFT;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  567  		offset %= (1ul << xvm_size_max);
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  568  
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  569  		/* Don't read past the end of the mblock. */
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  570  		if (offset >= mbend)
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  571  			break;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  572  
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  573  		/* mblock reads must be logically contiguous. */
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  574  		if (page->index != index && work) {
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  575  			queue_work(wq, work);
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  576  			work = NULL;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  577  		}
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  578  
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  579  		index = page->index + 1; /* next expected page index */
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  580  
3114e86da188ef1 Nabeel M Mohamed 2020-09-28 @581  		prefetchw(&page->flags);
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  582  		list_del(&page->lru);
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  583  
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  584  		rc = add_to_page_cache_lru(page, mapping, page->index, gfp);
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  585  		if (rc) {
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  586  			if (work) {
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  587  				queue_work(wq, work);
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  588  				work = NULL;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  589  			}
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  590  			put_page(page);
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  591  			continue;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  592  		}
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  593  
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  594  		if (!work) {
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  595  			w = page_address(page);
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  596  			INIT_WORK(&w->w_work, mpc_readpages_cb);
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  597  			w->w_args.a_xvm = xvm;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  598  			w->w_args.a_mbdesc = mbinfo->mbdesc;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  599  			w->w_args.a_mboffset = offset % xvm->xvm_bktsz;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  600  			w->w_args.a_pagec = 0;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  601  			work = &w->w_work;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  602  
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  603  			iovmax = MPC_RA_IOV_MAX;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  604  			iovmax -= page->index % MPC_RA_IOV_MAX;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  605  		}
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  606  
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  607  		w->w_args.a_pagev[w->w_args.a_pagec++] = page;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  608  
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  609  		/*
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  610  		 * Restrict batch size to the number of struct kvecs
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  611  		 * that will fit into a page (minus our header).
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  612  		 */
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  613  		if (w->w_args.a_pagec >= iovmax) {
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  614  			queue_work(wq, work);
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  615  			work = NULL;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  616  		}
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  617  	}
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  618  
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  619  	if (work)
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  620  		queue_work(wq, work);
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  621  
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  622  	return 0;
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  623  }
3114e86da188ef1 Nabeel M Mohamed 2020-09-28  624  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

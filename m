Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2301D245CD
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 May 2019 03:59:34 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 45E822127421F;
	Mon, 20 May 2019 18:59:32 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=lkp@intel.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 990242194EB78
 for <linux-nvdimm@lists.01.org>; Mon, 20 May 2019 18:59:30 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 May 2019 18:59:29 -0700
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
 by orsmga007.jf.intel.com with ESMTP; 20 May 2019 18:59:27 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
 (envelope-from <lkp@intel.com>)
 id 1hSu3q-000I3D-HJ; Tue, 21 May 2019 09:59:26 +0800
Date: Tue, 21 May 2019 09:58:36 +0800
From: kbuild test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: [linux-nvdimm:libnvdimm-fixes 2/3] drivers//dax/super.c:76:6: error:
 redefinition of 'generic_fsdax_supported'
Message-ID: <201905210935.wDCQK2iU%lkp@intel.com>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Jan Kara <jack@suse.cz>, kbuild-all@01.org,
 Mike Snitzer <snitzer@redhat.com>, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git libnvdimm-fixes
head:   ac09ef3d6de21992ad8e372dc97017cc3c46e15e
commit: 17a1362dd849b1c01dedcda38a6c0f5e26582407 [2/3] dax: Arrange for dax_supported check to span multiple devices
config: i386-randconfig-x006-201920 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        git checkout 17a1362dd849b1c01dedcda38a6c0f5e26582407
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers//dax/super.c:76:6: error: redefinition of 'generic_fsdax_supported'
    bool generic_fsdax_supported(struct dax_device *dax_dev,
         ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers//dax/super.c:23:0:
   include/linux/dax.h:112:20: note: previous definition of 'generic_fsdax_supported' was here
    static inline bool generic_fsdax_supported(struct dax_device *dax_dev,
                       ^~~~~~~~~~~~~~~~~~~~~~~

vim +/generic_fsdax_supported +76 drivers//dax/super.c

    75	
  > 76	bool generic_fsdax_supported(struct dax_device *dax_dev,
    77			struct block_device *bdev, int blocksize, sector_t start,
    78			sector_t sectors)
    79	{
    80		bool dax_enabled = false;
    81		pgoff_t pgoff, pgoff_end;
    82		char buf[BDEVNAME_SIZE];
    83		void *kaddr, *end_kaddr;
    84		pfn_t pfn, end_pfn;
    85		sector_t last_page;
    86		long len, len2;
    87		int err, id;
    88	
    89		if (blocksize != PAGE_SIZE) {
    90			pr_debug("%s: error: unsupported blocksize for dax\n",
    91					bdevname(bdev, buf));
    92			return false;
    93		}
    94	
    95		err = bdev_dax_pgoff(bdev, start, PAGE_SIZE, &pgoff);
    96		if (err) {
    97			pr_debug("%s: error: unaligned partition for dax\n",
    98					bdevname(bdev, buf));
    99			return false;
   100		}
   101	
   102		last_page = PFN_DOWN((start + sectors - 1) * 512) * PAGE_SIZE / 512;
   103		err = bdev_dax_pgoff(bdev, last_page, PAGE_SIZE, &pgoff_end);
   104		if (err) {
   105			pr_debug("%s: error: unaligned partition for dax\n",
   106					bdevname(bdev, buf));
   107			return false;
   108		}
   109	
   110		id = dax_read_lock();
   111		len = dax_direct_access(dax_dev, pgoff, 1, &kaddr, &pfn);
   112		len2 = dax_direct_access(dax_dev, pgoff_end, 1, &end_kaddr, &end_pfn);
   113		dax_read_unlock(id);
   114	
   115		if (len < 1 || len2 < 1) {
   116			pr_debug("%s: error: dax access failed (%ld)\n",
   117					bdevname(bdev, buf), len < 1 ? len : len2);
   118			return false;
   119		}
   120	
   121		if (IS_ENABLED(CONFIG_FS_DAX_LIMITED) && pfn_t_special(pfn)) {
   122			/*
   123			 * An arch that has enabled the pmem api should also
   124			 * have its drivers support pfn_t_devmap()
   125			 *
   126			 * This is a developer warning and should not trigger in
   127			 * production. dax_flush() will crash since it depends
   128			 * on being able to do (page_address(pfn_to_page())).
   129			 */
   130			WARN_ON(IS_ENABLED(CONFIG_ARCH_HAS_PMEM_API));
   131			dax_enabled = true;
   132		} else if (pfn_t_devmap(pfn) && pfn_t_devmap(end_pfn)) {
   133			struct dev_pagemap *pgmap, *end_pgmap;
   134	
   135			pgmap = get_dev_pagemap(pfn_t_to_pfn(pfn), NULL);
   136			end_pgmap = get_dev_pagemap(pfn_t_to_pfn(end_pfn), NULL);
   137			if (pgmap && pgmap == end_pgmap && pgmap->type == MEMORY_DEVICE_FS_DAX
   138					&& pfn_t_to_page(pfn)->pgmap == pgmap
   139					&& pfn_t_to_page(end_pfn)->pgmap == pgmap
   140					&& pfn_t_to_pfn(pfn) == PHYS_PFN(__pa(kaddr))
   141					&& pfn_t_to_pfn(end_pfn) == PHYS_PFN(__pa(end_kaddr)))
   142				dax_enabled = true;
   143			put_dev_pagemap(pgmap);
   144			put_dev_pagemap(end_pgmap);
   145	
   146		}
   147	
   148		if (!dax_enabled) {
   149			pr_debug("%s: error: dax support not enabled\n",
   150					bdevname(bdev, buf));
   151			return false;
   152		}
   153		return true;
   154	}
   155	EXPORT_SYMBOL_GPL(generic_fsdax_supported);
   156	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

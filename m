Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB96D235103
	for <lists+linux-nvdimm@lfdr.de>; Sat,  1 Aug 2020 09:24:16 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C87F31296C743;
	Sat,  1 Aug 2020 00:24:14 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E91FC12955C42;
	Sat,  1 Aug 2020 00:24:11 -0700 (PDT)
IronPort-SDR: ZDMElViXdsaYMaAGDaFZwi5ONJ8mTIHe7IevhXCJabzNgyM9mzILgPw20rmefRn4XbMhZJPamC
 L8o6H+z+eQSQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9699"; a="170019077"
X-IronPort-AV: E=Sophos;i="5.75,420,1589266800";
   d="gz'50?scan'50,208,50";a="170019077"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2020 00:24:10 -0700
IronPort-SDR: rHX+sSIu6c6Wr/hSpCmy4e6z956yKJbEQBxhQ66LFc5SqKV0Kc1ZvHAGzFN8k/hIUdzjWrGlkK
 EnUvamij4/kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,420,1589266800";
   d="gz'50?scan'50,208,50";a="365805157"
Received: from lkp-server01.sh.intel.com (HELO e21119890065) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 01 Aug 2020 00:24:05 -0700
Received: from kbuild by e21119890065 with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1k1lsD-0000M7-6i; Sat, 01 Aug 2020 07:24:05 +0000
Date: Sat, 1 Aug 2020 15:23:17 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
Subject: Re: [PATCH v3 20/23] device-dax: Make align a per-device property
Message-ID: <202008011532.YC0rRGs1%lkp@intel.com>
References: <159625241066.3040297.5565166696242815434.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <159625241066.3040297.5565166696242815434.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: U4ODYH2RSXTXEWRVPAK7EFV37RHNWVZT
X-Message-ID-Hash: U4ODYH2RSXTXEWRVPAK7EFV37RHNWVZT
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: kbuild-all@lists.01.org, Joao Martins <joao.m.martins@oracle.com>, peterz@infradead.org, dave.hansen@linux.intel.com, ard.biesheuvel@linaro.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/U4ODYH2RSXTXEWRVPAK7EFV37RHNWVZT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Dan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on 01830e6c042e8eb6eb202e05d7df8057135b4c26]

url:    https://github.com/0day-ci/linux/commits/Dan-Williams/device-dax-Support-sub-dividing-soft-reserved-ranges/20200801-114823
base:    01830e6c042e8eb6eb202e05d7df8057135b4c26
config: s390-allyesconfig (attached as .config)
compiler: s390-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=s390 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/dax/device.c:54:20: warning: no previous prototype for 'dax_pgoff_to_phys' [-Wmissing-prototypes]
      54 | __weak phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
         |                    ^~~~~~~~~~~~~~~~~
   drivers/dax/device.c: In function '__dev_dax_pte_fault':
>> drivers/dax/device.c:80:21: warning: variable 'dax_region' set but not used [-Wunused-but-set-variable]
      80 |  struct dax_region *dax_region;
         |                     ^~~~~~~~~~
   drivers/dax/device.c: In function '__dev_dax_pmd_fault':
   drivers/dax/device.c:113:21: warning: variable 'dax_region' set but not used [-Wunused-but-set-variable]
     113 |  struct dax_region *dax_region;
         |                     ^~~~~~~~~~
   drivers/dax/device.c: At top level:
   drivers/dax/device.c:397:5: warning: no previous prototype for 'dev_dax_probe' [-Wmissing-prototypes]
     397 | int dev_dax_probe(struct dev_dax *dev_dax)
         |     ^~~~~~~~~~~~~

vim +/dax_region +80 drivers/dax/device.c

dee410792419aaa drivers/dax/dax.c    Dan Williams 2016-05-14   52  
efebc711180f7fe drivers/dax/dax.c    Dave Jiang   2017-04-07   53  /* see "strong" declaration in tools/testing/nvdimm/dax-dev.c */
736163671bcb163 drivers/dax/device.c Dan Williams 2017-05-04  @54  __weak phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
dee410792419aaa drivers/dax/dax.c    Dan Williams 2016-05-14   55  		unsigned long size)
dee410792419aaa drivers/dax/dax.c    Dan Williams 2016-05-14   56  {
4d3c109cf2a8406 drivers/dax/device.c Dan Williams 2020-07-31   57  	int i;
4d3c109cf2a8406 drivers/dax/device.c Dan Williams 2020-07-31   58  
4d3c109cf2a8406 drivers/dax/device.c Dan Williams 2020-07-31   59  	for (i = 0; i < dev_dax->nr_range; i++) {
4d3c109cf2a8406 drivers/dax/device.c Dan Williams 2020-07-31   60  		struct dev_dax_range *dax_range = &dev_dax->ranges[i];
4d3c109cf2a8406 drivers/dax/device.c Dan Williams 2020-07-31   61  		struct range *range = &dax_range->range;
4d3c109cf2a8406 drivers/dax/device.c Dan Williams 2020-07-31   62  		unsigned long long pgoff_end;
753a0850e707e9a drivers/dax/device.c Dan Williams 2017-07-14   63  		phys_addr_t phys;
dee410792419aaa drivers/dax/dax.c    Dan Williams 2016-05-14   64  
4d3c109cf2a8406 drivers/dax/device.c Dan Williams 2020-07-31   65  		pgoff_end = dax_range->pgoff + PHYS_PFN(range_len(range)) - 1;
4d3c109cf2a8406 drivers/dax/device.c Dan Williams 2020-07-31   66  		if (pgoff < dax_range->pgoff || pgoff > pgoff_end)
4d3c109cf2a8406 drivers/dax/device.c Dan Williams 2020-07-31   67  			continue;
4d3c109cf2a8406 drivers/dax/device.c Dan Williams 2020-07-31   68  		phys = PFN_PHYS(pgoff - dax_range->pgoff) + range->start;
e8f1f803fc7e653 drivers/dax/device.c Dan Williams 2020-07-31   69  		if (phys + size - 1 <= range->end)
dee410792419aaa drivers/dax/dax.c    Dan Williams 2016-05-14   70  			return phys;
4d3c109cf2a8406 drivers/dax/device.c Dan Williams 2020-07-31   71  		break;
dee410792419aaa drivers/dax/dax.c    Dan Williams 2016-05-14   72  	}
dee410792419aaa drivers/dax/dax.c    Dan Williams 2016-05-14   73  	return -1;
dee410792419aaa drivers/dax/dax.c    Dan Williams 2016-05-14   74  }
dee410792419aaa drivers/dax/dax.c    Dan Williams 2016-05-14   75  
226ab561075f6f8 drivers/dax/device.c Dan Williams 2018-07-13   76  static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
2232c6382a453db drivers/dax/device.c Dan Williams 2018-07-13   77  				struct vm_fault *vmf, pfn_t *pfn)
dee410792419aaa drivers/dax/dax.c    Dan Williams 2016-05-14   78  {
5f0694b300b9fb8 drivers/dax/dax.c    Dan Williams 2017-01-30   79  	struct device *dev = &dev_dax->dev;
dee410792419aaa drivers/dax/dax.c    Dan Williams 2016-05-14  @80  	struct dax_region *dax_region;
dee410792419aaa drivers/dax/dax.c    Dan Williams 2016-05-14   81  	phys_addr_t phys;
0134ed4fb9e7867 drivers/dax/dax.c    Dave Jiang   2017-03-10   82  	unsigned int fault_size = PAGE_SIZE;
dee410792419aaa drivers/dax/dax.c    Dan Williams 2016-05-14   83  
5f0694b300b9fb8 drivers/dax/dax.c    Dan Williams 2017-01-30   84  	if (check_vma(dev_dax, vmf->vma, __func__))
dee410792419aaa drivers/dax/dax.c    Dan Williams 2016-05-14   85  		return VM_FAULT_SIGBUS;
dee410792419aaa drivers/dax/dax.c    Dan Williams 2016-05-14   86  
5f0694b300b9fb8 drivers/dax/dax.c    Dan Williams 2017-01-30   87  	dax_region = dev_dax->region;
58e646f2ce61dc9 drivers/dax/device.c Joao Martins 2020-07-31   88  	if (dev_dax->align > PAGE_SIZE) {
6daaca522ab464d drivers/dax/device.c Dan Williams 2018-03-05   89  		dev_dbg(dev, "alignment (%#x) > fault size (%#x)\n",
58e646f2ce61dc9 drivers/dax/device.c Joao Martins 2020-07-31   90  			dev_dax->align, fault_size);
dee410792419aaa drivers/dax/dax.c    Dan Williams 2016-05-14   91  		return VM_FAULT_SIGBUS;
dee410792419aaa drivers/dax/dax.c    Dan Williams 2016-05-14   92  	}
dee410792419aaa drivers/dax/dax.c    Dan Williams 2016-05-14   93  
58e646f2ce61dc9 drivers/dax/device.c Joao Martins 2020-07-31   94  	if (fault_size != dev_dax->align)
0134ed4fb9e7867 drivers/dax/dax.c    Dave Jiang   2017-03-10   95  		return VM_FAULT_SIGBUS;
0134ed4fb9e7867 drivers/dax/dax.c    Dave Jiang   2017-03-10   96  
736163671bcb163 drivers/dax/device.c Dan Williams 2017-05-04   97  	phys = dax_pgoff_to_phys(dev_dax, vmf->pgoff, PAGE_SIZE);
dee410792419aaa drivers/dax/dax.c    Dan Williams 2016-05-14   98  	if (phys == -1) {
6daaca522ab464d drivers/dax/device.c Dan Williams 2018-03-05   99  		dev_dbg(dev, "pgoff_to_phys(%#lx) failed\n", vmf->pgoff);
dee410792419aaa drivers/dax/dax.c    Dan Williams 2016-05-14  100  		return VM_FAULT_SIGBUS;
dee410792419aaa drivers/dax/dax.c    Dan Williams 2016-05-14  101  	}
dee410792419aaa drivers/dax/dax.c    Dan Williams 2016-05-14  102  
e651e2e797b48fb drivers/dax/device.c Dan Williams 2020-07-31  103  	*pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
dee410792419aaa drivers/dax/dax.c    Dan Williams 2016-05-14  104  
2232c6382a453db drivers/dax/device.c Dan Williams 2018-07-13  105  	return vmf_insert_mixed(vmf->vma, vmf->address, *pfn);
dee410792419aaa drivers/dax/dax.c    Dan Williams 2016-05-14  106  }
dee410792419aaa drivers/dax/dax.c    Dan Williams 2016-05-14  107  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

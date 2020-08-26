Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C71C253504
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Aug 2020 18:35:53 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 94FEB12379ADA;
	Wed, 26 Aug 2020 09:35:51 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9A08D12372965;
	Wed, 26 Aug 2020 09:35:48 -0700 (PDT)
IronPort-SDR: Kd2/QHEv8oatxmFoW4xfe9gAFRCcoiuWPBvo1e4AHWoDT9wLNVCLM7PGy2JFppp/M86etkCtNn
 5gdDF23pkVJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="155590584"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600";
   d="gz'50?scan'50,208,50";a="155590584"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 09:35:44 -0700
IronPort-SDR: eL6HEcmetv9Ijxo1PJ8kx1rNWRTSa8Pd048zlNL5NT/Th5J2r3GICE2xMdcsuFVIncG8nkTa9U
 z9rVir9Fq8KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600";
   d="gz'50?scan'50,208,50";a="339223464"
Received: from lkp-server01.sh.intel.com (HELO 4f455964fc6c) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 26 Aug 2020 09:35:40 -0700
Received: from kbuild by 4f455964fc6c with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1kAyOh-0001Wf-St; Wed, 26 Aug 2020 16:35:39 +0000
Date: Thu, 27 Aug 2020 00:34:42 +0800
From: kernel test robot <lkp@intel.com>
To: YueHaibing <yuehaibing@huawei.com>, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com, ira.weiny@intel.com,
	mingo@kernel.org
Subject: Re: [PATCH] libnvdimm/e820: Fix build error without MEMORY_HOTPLUG
Message-ID: <202008270059.IZznvFGF%lkp@intel.com>
References: <20200826121800.732-1-yuehaibing@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200826121800.732-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: 2COYYWKY3HFOO4LPNANVD2NXJDPRG3PJ
X-Message-ID-Hash: 2COYYWKY3HFOO4LPNANVD2NXJDPRG3PJ
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: kbuild-all@lists.01.org, clang-built-linux@googlegroups.com, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2COYYWKY3HFOO4LPNANVD2NXJDPRG3PJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi YueHaibing,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linux-nvdimm/libnvdimm-for-next]
[also build test ERROR on v5.9-rc2 next-20200826]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/YueHaibing/libnvdimm-e820-Fix-build-error-without-MEMORY_HOTPLUG/20200826-202043
base:   https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git libnvdimm-for-next
config: x86_64-randconfig-a002-20200826 (attached as .config)
compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 7cfcecece0e0430937cf529ce74d3a071a4dedc6)
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

>> drivers/nvdimm/e820.c:21:19: error: redefinition of 'phys_to_target_node'
   static inline int phys_to_target_node(u64 start)
                     ^
   include/linux/numa.h:38:19: note: previous definition is here
   static inline int phys_to_target_node(phys_addr_t addr)
                     ^
   1 error generated.

# https://github.com/0day-ci/linux/commit/4c003ae129dccea4445a55e9e2c61de5922fbd37
git remote add linux-review https://github.com/0day-ci/linux
git fetch --no-tags linux-review YueHaibing/libnvdimm-e820-Fix-build-error-without-MEMORY_HOTPLUG/20200826-202043
git checkout 4c003ae129dccea4445a55e9e2c61de5922fbd37
vim +/phys_to_target_node +21 drivers/nvdimm/e820.c

    19	
    20	#ifndef CONFIG_MEMORY_HOTPLUG
  > 21	static inline int phys_to_target_node(u64 start)
    22	{
    23		return 0;
    24	}
    25	#endif
    26	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

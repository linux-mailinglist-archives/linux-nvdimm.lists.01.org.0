Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB7B25390F
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Aug 2020 22:22:30 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4E77F123B96D2;
	Wed, 26 Aug 2020 13:22:29 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E8FB21237CE35;
	Wed, 26 Aug 2020 13:22:26 -0700 (PDT)
IronPort-SDR: sDQQpiz5FkblXzxL+2Q9QQm0lWqy/1X+d1YxmaczwcztGXBKVdT95FXolLgMny+d7dKpOhy28Q
 k2st1ZuiPnGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="144141294"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600";
   d="gz'50?scan'50,208,50";a="144141294"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 13:22:26 -0700
IronPort-SDR: MpmsgelkE7IwBxBhV5yl/l0aIUybUotVhyljveY7l37ZtnjzhRsVgCVN5Z+Qk+xka742S1C/0d
 jQKJ/WkXfizA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600";
   d="gz'50?scan'50,208,50";a="474905230"
Received: from lkp-server01.sh.intel.com (HELO 4f455964fc6c) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 26 Aug 2020 13:22:23 -0700
Received: from kbuild by 4f455964fc6c with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1kB1w6-0001dy-G1; Wed, 26 Aug 2020 20:22:22 +0000
Date: Thu, 27 Aug 2020 04:22:00 +0800
From: kernel test robot <lkp@intel.com>
To: YueHaibing <yuehaibing@huawei.com>, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com, ira.weiny@intel.com,
	mingo@kernel.org
Subject: Re: [PATCH] libnvdimm/e820: Fix build error without MEMORY_HOTPLUG
Message-ID: <202008270417.2e1Gcd45%lkp@intel.com>
References: <20200826121800.732-1-yuehaibing@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200826121800.732-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: CV5NCA7WWOAZZ5TYFQYGHL4ZL5VQN2KK
X-Message-ID-Hash: CV5NCA7WWOAZZ5TYFQYGHL4ZL5VQN2KK
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: kbuild-all@lists.01.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CV5NCA7WWOAZZ5TYFQYGHL4ZL5VQN2KK/>
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
config: x86_64-randconfig-r014-20200826 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
reproduce (this is a W=1 build):
        # save the attached .config to linux build tree
        make W=1 ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/nvdimm/e820.c:21:19: error: static declaration of 'phys_to_target_node' follows non-static declaration
      21 | static inline int phys_to_target_node(u64 start)
         |                   ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/nodemask.h:96,
                    from arch/x86/include/asm/numa.h:5,
                    from arch/x86/include/asm/acpi.h:11,
                    from arch/x86/include/asm/fixmap.h:29,
                    from arch/x86/include/asm/apic.h:11,
                    from arch/x86/include/asm/smp.h:13,
                    from include/linux/smp.h:82,
                    from include/linux/percpu.h:7,
                    from include/linux/hrtimer.h:19,
                    from include/linux/sched.h:20,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/platform_device.h:13,
                    from drivers/nvdimm/e820.c:6:
   include/linux/numa.h:31:5: note: previous declaration of 'phys_to_target_node' was here
      31 | int phys_to_target_node(phys_addr_t addr);
         |     ^~~~~~~~~~~~~~~~~~~

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

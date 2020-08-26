Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AA92533AC
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Aug 2020 17:29:09 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 04449123F7817;
	Wed, 26 Aug 2020 08:29:08 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 95E98123F7814;
	Wed, 26 Aug 2020 08:29:05 -0700 (PDT)
IronPort-SDR: lgXbBTmacrLRA7AgxEiBstuYIK9oRNJBKx3uWNP8MKRlGc2l0B/iuGn/abhpsuYS5PeW13sqPi
 FJNuLhPApfUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="153734704"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600";
   d="gz'50?scan'50,208,50";a="153734704"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 08:29:04 -0700
IronPort-SDR: +j4QMSWPjttbWUDQpP/HaWBtJPelV+NICx/MaZFy2JvPntO9JgdHWLs/1+uxN3ukK/oP3tnO5r
 lQIqjhsn66kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600";
   d="gz'50?scan'50,208,50";a="500280485"
Received: from lkp-server01.sh.intel.com (HELO 4f455964fc6c) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 26 Aug 2020 08:29:01 -0700
Received: from kbuild by 4f455964fc6c with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1kAxMD-0001V1-4r; Wed, 26 Aug 2020 15:29:01 +0000
Date: Wed, 26 Aug 2020 23:28:16 +0800
From: kernel test robot <lkp@intel.com>
To: YueHaibing <yuehaibing@huawei.com>, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com, ira.weiny@intel.com,
	mingo@kernel.org
Subject: Re: [PATCH] libnvdimm/e820: Fix build error without MEMORY_HOTPLUG
Message-ID: <202008262303.XWo2bs0c%lkp@intel.com>
References: <20200826121800.732-1-yuehaibing@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200826121800.732-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: IMEPF6IWYJPVCMBVX5NHN5TT6POVUDMP
X-Message-ID-Hash: IMEPF6IWYJPVCMBVX5NHN5TT6POVUDMP
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: kbuild-all@lists.01.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IMEPF6IWYJPVCMBVX5NHN5TT6POVUDMP/>
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
config: i386-randconfig-a004-20200826 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
reproduce (this is a W=1 build):
        # save the attached .config to linux build tree
        make W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/nvdimm/e820.c:21:19: error: redefinition of 'phys_to_target_node'
      21 | static inline int phys_to_target_node(u64 start)
         |                   ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/nodemask.h:96,
                    from include/linux/sched.h:22,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/platform_device.h:13,
                    from drivers/nvdimm/e820.c:6:
   include/linux/numa.h:38:19: note: previous definition of 'phys_to_target_node' was here
      38 | static inline int phys_to_target_node(phys_addr_t addr)
         |                   ^~~~~~~~~~~~~~~~~~~

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

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F3F26FED3
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Sep 2020 15:40:44 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4F15713DEDE2D;
	Fri, 18 Sep 2020 06:40:42 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1B3A113AE0486;
	Fri, 18 Sep 2020 06:40:38 -0700 (PDT)
IronPort-SDR: IC6qf4Wb4E7OTPFB/JSsip/p9ydY3k4WiY5hHdmu6zYdthR6Ac/2u/KrIgdooYzy6Am8kAQ40z
 c6El+U8D21Vg==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="139424434"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400";
   d="gz'50?scan'50,208,50";a="139424434"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 06:40:38 -0700
IronPort-SDR: nINBXD5i+k6tLyxPEgdXiBtUbHm24izS/YyI9T/bMKZLOfodBwUdzRGwEnWZsAhhZjkWIBw92q
 VRfSoA3wh4Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400";
   d="gz'50?scan'50,208,50";a="344742737"
Received: from lkp-server01.sh.intel.com (HELO a05db971c861) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Sep 2020 06:40:35 -0700
Received: from kbuild by a05db971c861 with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1kJGct-0000Xt-8b; Fri, 18 Sep 2020 13:40:35 +0000
Date: Fri, 18 Sep 2020 21:39:38 +0800
From: kernel test robot <lkp@intel.com>
To: Jan Kara <jack@suse.cz>
Subject: [linux-nvdimm:libnvdimm-fixes 1/2] undefined reference to
 `dax_read_lock'
Message-ID: <202009182134.qUPG4tZ9%lkp@intel.com>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: 25EFVPSMVT4I2SRF2H65GES4FWSS2BZN
X-Message-ID-Hash: 25EFVPSMVT4I2SRF2H65GES4FWSS2BZN
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: kbuild-all@lists.01.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/25EFVPSMVT4I2SRF2H65GES4FWSS2BZN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git libnvdimm-fixes
head:   3305ce9e90c8f1fefdf75acfbb814574c12bfcc5
commit: ec5f196ad972cd740bcbe6ef9c89a8a92d54ba44 [1/2] dm: Call proper helper to determine dax support
config: parisc-defconfig (attached as .config)
compiler: hppa-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout ec5f196ad972cd740bcbe6ef9c89a8a92d54ba44
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=parisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   hppa-linux-ld: drivers/md/dm-table.o: in function `device_supports_dax':
>> (.text+0x5d4): undefined reference to `dax_read_lock'
>> hppa-linux-ld: (.text+0x5dc): undefined reference to `dax_read_unlock'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

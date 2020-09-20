Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9144427188D
	for <lists+linux-nvdimm@lfdr.de>; Mon, 21 Sep 2020 01:12:36 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 816F914DE080A;
	Sun, 20 Sep 2020 16:12:34 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D4F5814DE0804;
	Sun, 20 Sep 2020 16:12:32 -0700 (PDT)
IronPort-SDR: UY12L6I/PiMlKu8AcuWm4ULA7JvVv74gT83OkesBkCMBwVnqG+NVf8FZl4Bdy1wwMN+KekD4H0
 e1Fo28juG6kg==
X-IronPort-AV: E=McAfee;i="6000,8403,9750"; a="159583184"
X-IronPort-AV: E=Sophos;i="5.77,284,1596524400";
   d="gz'50?scan'50,208,50";a="159583184"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2020 16:12:32 -0700
IronPort-SDR: rx5D15ZKPTyyW65RNc8tSvTr0H4Xx8cDvyUei3CJWO+25PgBRbxX6PVLqAJjA/9FE4kPbARP6z
 Xpmn1i/UmFXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,284,1596524400";
   d="gz'50?scan'50,208,50";a="290526243"
Received: from lkp-server01.sh.intel.com (HELO 674716e234df) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 20 Sep 2020 16:12:29 -0700
Received: from kbuild by 674716e234df with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1kK8VR-00009z-6G; Sun, 20 Sep 2020 23:12:29 +0000
Date: Mon, 21 Sep 2020 07:12:11 +0800
From: kernel test robot <lkp@intel.com>
To: Jan Kara <jack@suse.cz>
Subject: [linux-nvdimm:libnvdimm-fixes 2/3] drivers/dax/super.c:325:6: error:
 redefinition of 'dax_supported'
Message-ID: <202009210706.QnE7d195%lkp@intel.com>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: KXTV3FVI6VHF5N4LYXRWPHJ4N4UJLQRZ
X-Message-ID-Hash: KXTV3FVI6VHF5N4LYXRWPHJ4N4UJLQRZ
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: kbuild-all@lists.01.org, clang-built-linux@googlegroups.com, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KXTV3FVI6VHF5N4LYXRWPHJ4N4UJLQRZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git libnvdimm-fixes
head:   d4c5da5049ac27c6ef8f6f98548c3a1ade352d25
commit: e2ec5128254518cae320d5dc631b71b94160f663 [2/3] dm: Call proper helper to determine dax support
config: x86_64-randconfig-a011-20200920 (attached as .config)
compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project f4e554180962aa6bc93678898b6933ea712bde50)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install x86_64 cross compiling tool for clang build
        # apt-get install binutils-x86-64-linux-gnu
        git checkout e2ec5128254518cae320d5dc631b71b94160f663
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/dax/super.c:325:6: error: redefinition of 'dax_supported'
   bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
        ^
   include/linux/dax.h:162:20: note: previous definition is here
   static inline bool dax_supported(struct dax_device *dax_dev,
                      ^
   drivers/dax/super.c:451:6: warning: no previous prototype for function 'run_dax' [-Wmissing-prototypes]
   void run_dax(struct dax_device *dax_dev)
        ^
   drivers/dax/super.c:451:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void run_dax(struct dax_device *dax_dev)
   ^
   static 
   1 warning and 1 error generated.

# https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/commit/?id=e2ec5128254518cae320d5dc631b71b94160f663
git remote add linux-nvdimm https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git
git fetch --no-tags linux-nvdimm libnvdimm-fixes
git checkout e2ec5128254518cae320d5dc631b71b94160f663
vim +/dax_supported +325 drivers/dax/super.c

b0686260fecaa9 Dan Williams 2017-01-26  324  
7bf7eac8d64805 Dan Williams 2019-05-16 @325  bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
7bf7eac8d64805 Dan Williams 2019-05-16  326  		int blocksize, sector_t start, sector_t len)
7bf7eac8d64805 Dan Williams 2019-05-16  327  {
e2ec5128254518 Jan Kara     2020-09-20  328  	if (!dax_dev)
e2ec5128254518 Jan Kara     2020-09-20  329  		return false;
e2ec5128254518 Jan Kara     2020-09-20  330  
7bf7eac8d64805 Dan Williams 2019-05-16  331  	if (!dax_alive(dax_dev))
7bf7eac8d64805 Dan Williams 2019-05-16  332  		return false;
7bf7eac8d64805 Dan Williams 2019-05-16  333  
7bf7eac8d64805 Dan Williams 2019-05-16  334  	return dax_dev->ops->dax_supported(dax_dev, bdev, blocksize, start, len);
7bf7eac8d64805 Dan Williams 2019-05-16  335  }
e2ec5128254518 Jan Kara     2020-09-20  336  EXPORT_SYMBOL_GPL(dax_supported);
7bf7eac8d64805 Dan Williams 2019-05-16  337  

:::::: The code at line 325 was first introduced by commit
:::::: 7bf7eac8d648057519adb6fce1e31458c902212c dax: Arrange for dax_supported check to span multiple devices

:::::: TO: Dan Williams <dan.j.williams@intel.com>
:::::: CC: Dan Williams <dan.j.williams@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

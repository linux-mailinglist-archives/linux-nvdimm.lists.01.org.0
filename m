Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E890E26FFFD
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Sep 2020 16:35:13 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5B13214E595F9;
	Fri, 18 Sep 2020 07:35:12 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 85B6913E19F38;
	Fri, 18 Sep 2020 07:35:09 -0700 (PDT)
IronPort-SDR: I0BLnj6xGUX7Q5N6iMx6wR3YC9z6H75wUIhAU9iIuB9lh4tlN0JmUn0Hp6I0ZnWNncRuZ4zGhn
 29fCCDXwtEgQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="244780121"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400";
   d="gz'50?scan'50,208,50";a="244780121"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 07:35:08 -0700
IronPort-SDR: CPUy8BRMJ3PAw+KNyREuqVa6XaOCQ5UY2t38BUOsruHUV/x5HdWnjCnvLA8cYvMgFjY3pSp1T9
 Mi6Ht52sTDuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400";
   d="gz'50?scan'50,208,50";a="320625707"
Received: from lkp-server01.sh.intel.com (HELO a05db971c861) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 18 Sep 2020 07:35:06 -0700
Received: from kbuild by a05db971c861 with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1kJHTd-0000Za-K3; Fri, 18 Sep 2020 14:35:05 +0000
Date: Fri, 18 Sep 2020 22:34:34 +0800
From: kernel test robot <lkp@intel.com>
To: Jan Kara <jack@suse.cz>
Subject: [linux-nvdimm:libnvdimm-fixes 1/2] drivers/md/dm-table.c:866:
 undefined reference to `dax_read_lock'
Message-ID: <202009182231.w59t9JsH%lkp@intel.com>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: 3LGMLDL32EHPMALPA3DOF2EYTKVCJRQJ
X-Message-ID-Hash: 3LGMLDL32EHPMALPA3DOF2EYTKVCJRQJ
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: kbuild-all@lists.01.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3LGMLDL32EHPMALPA3DOF2EYTKVCJRQJ/>
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
config: openrisc-randconfig-r022-20200918 (attached as .config)
compiler: or1k-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout ec5f196ad972cd740bcbe6ef9c89a8a92d54ba44
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=openrisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   or1k-linux-ld: drivers/md/dm-table.o: in function `device_supports_dax':
>> drivers/md/dm-table.c:866: undefined reference to `dax_read_lock'
   drivers/md/dm-table.c:866:(.text+0x84c): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `dax_read_lock'
>> or1k-linux-ld: drivers/md/dm-table.c:868: undefined reference to `dax_read_unlock'
   drivers/md/dm-table.c:868:(.text+0x854): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `dax_read_unlock'

# https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/commit/?id=ec5f196ad972cd740bcbe6ef9c89a8a92d54ba44
git remote add linux-nvdimm https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git
git fetch --no-tags linux-nvdimm libnvdimm-fixes
git checkout ec5f196ad972cd740bcbe6ef9c89a8a92d54ba44
vim +866 drivers/md/dm-table.c

   858	
   859	/* validate the dax capability of the target device span */
   860	int device_supports_dax(struct dm_target *ti, struct dm_dev *dev,
   861				sector_t start, sector_t len, void *data)
   862	{
   863		int blocksize = *(int *) data, id;
   864		bool rc;
   865	
 > 866		id = dax_read_lock();
   867		rc = dax_supported(dev->dax_dev, dev->bdev, blocksize, start, len);
 > 868		dax_read_unlock(id);
   869	
   870		return rc;
   871	}
   872	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

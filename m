Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3D74C78E
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Jun 2019 08:38:17 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A8C272129DB91;
	Wed, 19 Jun 2019 23:38:15 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=lkp@intel.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 1FD8F212963F0
 for <linux-nvdimm@lists.01.org>; Wed, 19 Jun 2019 23:38:12 -0700 (PDT)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Jun 2019 23:38:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,395,1557212400"; 
 d="gz'50?scan'50,208,50";a="162253281"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
 by fmsmga007.fm.intel.com with ESMTP; 19 Jun 2019 23:38:10 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
 (envelope-from <lkp@intel.com>)
 id 1hdqi1-000CKX-E0; Thu, 20 Jun 2019 14:38:09 +0800
Date: Thu, 20 Jun 2019 14:37:29 +0800
From: kbuild test robot <lkp@intel.com>
To: Pankaj Gupta <pagupta@redhat.com>
Subject: [linux-nvdimm:libnvdimm-for-next 6/15] drivers/md/dm-table.c:897:9:
 error: implicit declaration of function 'dax_synchronous'; did you mean
 'device_synchronous'?
Message-ID: <201906201425.V6gEPOVJ%lkp@intel.com>
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
Cc: kbuild-all@01.org, Mike Snitzer <snitzer@redhat.com>,
 linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git libnvdimm-for-next
head:   3b6047778c09037615e7b919c922081ef1a37a7f
commit: 38887edec2472179cc79bb45034731f5f816f064 [6/15] dm: enable synchronous dax
config: parisc-c3000_defconfig (attached as .config)
compiler: hppa-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 38887edec2472179cc79bb45034731f5f816f064
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=parisc 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/md/dm-table.c: In function 'device_synchronous':
>> drivers/md/dm-table.c:897:9: error: implicit declaration of function 'dax_synchronous'; did you mean 'device_synchronous'? [-Werror=implicit-function-declaration]
     return dax_synchronous(dev->dax_dev);
            ^~~~~~~~~~~~~~~
            device_synchronous
   drivers/md/dm-table.c: In function 'dm_table_set_restrictions':
>> drivers/md/dm-table.c:1925:4: error: implicit declaration of function 'set_dax_synchronous'; did you mean 'device_synchronous'? [-Werror=implicit-function-declaration]
       set_dax_synchronous(t->md->dax_dev);
       ^~~~~~~~~~~~~~~~~~~
       device_synchronous
   cc1: some warnings being treated as errors

vim +897 drivers/md/dm-table.c

   892	
   893	/* Check devices support synchronous DAX */
   894	static int device_synchronous(struct dm_target *ti, struct dm_dev *dev,
   895					       sector_t start, sector_t len, void *data)
   896	{
 > 897		return dax_synchronous(dev->dax_dev);
   898	}
   899	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

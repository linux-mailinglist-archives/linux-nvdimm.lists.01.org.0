Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF403151544
	for <lists+linux-nvdimm@lfdr.de>; Tue,  4 Feb 2020 06:18:04 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 945C410FC338F;
	Mon,  3 Feb 2020 21:21:20 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DD5F410FC337A;
	Mon,  3 Feb 2020 21:21:17 -0800 (PST)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2020 21:17:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,398,1574150400";
   d="gz'50?scan'50,208,50";a="224503039"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 03 Feb 2020 21:17:58 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
	(envelope-from <lkp@intel.com>)
	id 1iyqaz-00047V-CL; Tue, 04 Feb 2020 13:17:57 +0800
Date: Tue, 4 Feb 2020 13:17:00 +0800
From: kbuild test robot <lkp@intel.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 5/5] dax,iomap: Add helper dax_iomap_zero() to zero a
 range
Message-ID: <202002041335.cKPlPSLq%lkp@intel.com>
References: <20200203200029.4592-6-vgoyal@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200203200029.4592-6-vgoyal@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Message-ID-Hash: CXRNITTBJ7ASDRU6FU65IG6ZGT3N656I
X-Message-ID-Hash: CXRNITTBJ7ASDRU6FU65IG6ZGT3N656I
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, hch@infradead.org, dm-devel@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CXRNITTBJ7ASDRU6FU65IG6ZGT3N656I/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Vivek,

I love your patch! Yet something to improve:

[auto build test ERROR on dm/for-next]
[also build test ERROR on s390/features xfs-linux/for-next linus/master linux-nvdimm/libnvdimm-for-next v5.5 next-20200203]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Vivek-Goyal/dax-pmem-Provide-a-dax-operation-to-zero-range-of-memory/20200204-082750
base:   https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git for-next
config: s390-alldefconfig (attached as .config)
compiler: s390-linux-gcc (GCC) 7.5.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.5.0 make.cross ARCH=s390 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/s390/block/dcssblk.c:65:21: error: 'dcssblk_dax_zero_page_range' undeclared here (not in a function); did you mean 'generic_dax_zero_page_range'?
     .zero_page_range = dcssblk_dax_zero_page_range,
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~
                        generic_dax_zero_page_range
   drivers/s390/block/dcssblk.c:945:12: warning: 'dcssblk_dax_zero_page_range' defined but not used [-Wunused-function]
    static int dcssblk_dax_zero_page_range(struct dax_device *dax_dev,pgoff_t pgoff,
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +65 drivers/s390/block/dcssblk.c

b3a9a0c36e1f7b Dan Williams   2018-05-02  59  
7a2765f6e82063 Dan Williams   2017-01-26  60  static const struct dax_operations dcssblk_dax_ops = {
7a2765f6e82063 Dan Williams   2017-01-26  61  	.direct_access = dcssblk_dax_direct_access,
7bf7eac8d64805 Dan Williams   2019-05-16  62  	.dax_supported = generic_fsdax_supported,
5d61e43b3975c0 Dan Williams   2017-06-27  63  	.copy_from_iter = dcssblk_dax_copy_from_iter,
b3a9a0c36e1f7b Dan Williams   2018-05-02  64  	.copy_to_iter = dcssblk_dax_copy_to_iter,
c5cb636194a0d8 Vivek Goyal    2020-02-03 @65  	.zero_page_range = dcssblk_dax_zero_page_range,
^1da177e4c3f41 Linus Torvalds 2005-04-16  66  };
^1da177e4c3f41 Linus Torvalds 2005-04-16  67  

:::::: The code at line 65 was first introduced by commit
:::::: c5cb636194a0d8d33d549903c92189385db48406 s390,dax: Add dax zero_page_range operation to dcssblk driver

:::::: TO: Vivek Goyal <vgoyal@redhat.com>
:::::: CC: 0day robot <lkp@intel.com>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

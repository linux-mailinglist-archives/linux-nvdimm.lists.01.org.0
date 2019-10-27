Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D263AE69E4
	for <lists+linux-nvdimm@lfdr.de>; Sun, 27 Oct 2019 23:20:22 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BF984100EA617;
	Sun, 27 Oct 2019 15:21:16 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 268A6100EA612;
	Sun, 27 Oct 2019 15:21:14 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Oct 2019 15:20:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,237,1569308400";
   d="gz'50?scan'50,208,50";a="350536378"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 27 Oct 2019 15:20:09 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
	(envelope-from <lkp@intel.com>)
	id 1iOqtM-0005Cx-Kw; Mon, 28 Oct 2019 06:20:08 +0800
Date: Mon, 28 Oct 2019 06:19:50 +0800
From: kbuild test robot <lkp@intel.com>
To: Alastair D'Silva <alastair@au1.ibm.com>
Subject: Re: [PATCH 08/10] nvdimm: Add driver for OpenCAPI Storage Class
 Memory
Message-ID: <201910280620.f7EsMjTy%lkp@intel.com>
References: <20191025044721.16617-9-alastair@au1.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20191025044721.16617-9-alastair@au1.ibm.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Message-ID-Hash: GM36EKES4GFH2GVOX2KBCUGS7KQGMJ55
X-Message-ID-Hash: GM36EKES4GFH2GVOX2KBCUGS7KQGMJ55
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: kbuild-all@lists.01.org, alastair@d-silva.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, David Gibson <david@gibson.dropbear.id.au>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Thomas Gleixner <tglx@linutronix.de>, Hari Bathini <hbathini@linux.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Nicholas Piggin <npiggin@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.com>, Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Wei Yang <richard.weiy
 ang@gmail.com>, Qian Cai <cai@lca.pw>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GM36EKES4GFH2GVOX2KBCUGS7KQGMJ55/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Alastair,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on char-misc/char-misc-testing]
[cannot apply to v5.4-rc5 next-20191025]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Alastair-D-Silva/Add-support-for-OpenCAPI-SCM-devices/20191028-043750
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git da80d2e516eb858eb5bcca7fa5f5a13ed86930e4
config: s390-allmodconfig (attached as .config)
compiler: s390-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=s390 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/misc/ocxl/main.c: In function 'init_ocxl':
>> drivers/misc/ocxl/main.c:12:7: error: 'tlbie_capable' undeclared (first use in this function); did you mean 'iommu_capable'?
     if (!tlbie_capable)
          ^~~~~~~~~~~~~
          iommu_capable
   drivers/misc/ocxl/main.c:12:7: note: each undeclared identifier is reported only once for each function it appears in
--
   drivers/misc/ocxl/core.c: In function 'ocxl_function_open':
>> drivers/misc/ocxl/core.c:546:7: error: implicit declaration of function 'radix_enabled'; did you mean 'zdev_enabled'? [-Werror=implicit-function-declaration]
     if (!radix_enabled()) {
          ^~~~~~~~~~~~~
          zdev_enabled
   cc1: some warnings being treated as errors

vim +12 drivers/misc/ocxl/main.c

5ef3166e8a32d7 Frederic Barrat 2018-01-23   7  
5ef3166e8a32d7 Frederic Barrat 2018-01-23   8  static int __init init_ocxl(void)
5ef3166e8a32d7 Frederic Barrat 2018-01-23   9  {
5ef3166e8a32d7 Frederic Barrat 2018-01-23  10  	int rc = 0;
5ef3166e8a32d7 Frederic Barrat 2018-01-23  11  
2275d7b5754a57 Nicholas Piggin 2019-09-03 @12  	if (!tlbie_capable)
2275d7b5754a57 Nicholas Piggin 2019-09-03  13  		return -EINVAL;
2275d7b5754a57 Nicholas Piggin 2019-09-03  14  
5ef3166e8a32d7 Frederic Barrat 2018-01-23  15  	rc = ocxl_file_init();
5ef3166e8a32d7 Frederic Barrat 2018-01-23  16  	if (rc)
5ef3166e8a32d7 Frederic Barrat 2018-01-23  17  		return rc;
5ef3166e8a32d7 Frederic Barrat 2018-01-23  18  
5ef3166e8a32d7 Frederic Barrat 2018-01-23  19  	rc = pci_register_driver(&ocxl_pci_driver);
5ef3166e8a32d7 Frederic Barrat 2018-01-23  20  	if (rc) {
5ef3166e8a32d7 Frederic Barrat 2018-01-23  21  		ocxl_file_exit();
5ef3166e8a32d7 Frederic Barrat 2018-01-23  22  		return rc;
5ef3166e8a32d7 Frederic Barrat 2018-01-23  23  	}
5ef3166e8a32d7 Frederic Barrat 2018-01-23  24  	return 0;
5ef3166e8a32d7 Frederic Barrat 2018-01-23  25  }
5ef3166e8a32d7 Frederic Barrat 2018-01-23  26  

:::::: The code at line 12 was first introduced by commit
:::::: 2275d7b5754a573ffb2ca9e40bd0546eeb986696 powerpc/64s/radix: introduce options to disable use of the tlbie instruction

:::::: TO: Nicholas Piggin <npiggin@gmail.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

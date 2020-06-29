Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E01420D584
	for <lists+linux-nvdimm@lfdr.de>; Mon, 29 Jun 2020 21:28:21 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5E873111C7C4C;
	Mon, 29 Jun 2020 12:28:19 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0D3FC111B33D5;
	Mon, 29 Jun 2020 12:28:17 -0700 (PDT)
IronPort-SDR: TF0K/cjxMRi+aqGP54vtFSAdbUzw4qe3cgzRRFVRxbJjDissA66b85QpLn/w5BT2a6Qj4gr1XK
 TxDmd/R6RrpQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="164057209"
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800";
   d="gz'50?scan'50,208,50";a="164057209"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 12:28:16 -0700
IronPort-SDR: CDFnChUBtrqT9JOHzRECxVTTUmN7xj7TWTLBkwAmf27DdAP0N0Gjr+u7LkKu9jquD4ogX9TXYv
 m49P1kxpCEaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800";
   d="gz'50?scan'50,208,50";a="280972780"
Received: from lkp-server01.sh.intel.com (HELO 28879958b202) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 29 Jun 2020 12:28:12 -0700
Received: from kbuild by 28879958b202 with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1jpzRr-00019R-G8; Mon, 29 Jun 2020 19:28:11 +0000
Date: Tue, 30 Jun 2020 03:27:50 +0800
From: kernel test robot <lkp@intel.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
	linux-nvdimm@lists.01.org, dan.j.williams@intel.com
Subject: Re: [PATCH v6 4/8] libnvdimm/nvdimm/flush: Allow architecture to
 override the flush barrier
Message-ID: <202006300359.qHAg2InT%lkp@intel.com>
References: <20200629135722.73558-5-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200629135722.73558-5-aneesh.kumar@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: QMDKRW2PXKBWLCZX6L7GRN5DKGS4WLCS
X-Message-ID-Hash: QMDKRW2PXKBWLCZX6L7GRN5DKGS4WLCS
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: kbuild-all@lists.01.org, Jan Kara <jack@suse.cz>, msuchanek@suse.de, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QMDKRW2PXKBWLCZX6L7GRN5DKGS4WLCS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi "Aneesh,

I love your patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on linux-nvdimm/libnvdimm-for-next v5.8-rc3 next-20200629]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use  as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Aneesh-Kumar-K-V/Support-new-pmem-flush-and-sync-instructions-for-POWER/20200629-223649
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: mips-allyesconfig (attached as .config)
compiler: mips-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/md/dm-writecache.c: In function 'writecache_commit_flushed':
>> drivers/md/dm-writecache.c:539:3: error: implicit declaration of function 'arch_pmem_flush_barrier' [-Werror=implicit-function-declaration]
     539 |   arch_pmem_flush_barrier();
         |   ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/arch_pmem_flush_barrier +539 drivers/md/dm-writecache.c

   535	
   536	static void writecache_commit_flushed(struct dm_writecache *wc, bool wait_for_ios)
   537	{
   538		if (WC_MODE_PMEM(wc))
 > 539			arch_pmem_flush_barrier();
   540		else
   541			ssd_commit_flushed(wc, wait_for_ios);
   542	}
   543	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

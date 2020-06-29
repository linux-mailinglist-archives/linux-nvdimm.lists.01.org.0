Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AFF20D2BA
	for <lists+linux-nvdimm@lfdr.de>; Mon, 29 Jun 2020 20:54:04 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A38A0111B33DC;
	Mon, 29 Jun 2020 11:54:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0B604111B33D5;
	Mon, 29 Jun 2020 11:53:59 -0700 (PDT)
IronPort-SDR: zXnX4VPzb9C63P7NcA8l0kKn/m6gL/nYtRNOBG2CBEPaOU1NqE+ctA2oTq1MnmC3YvxkOZSx13
 9/dd22parURg==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="143513617"
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800";
   d="gz'50?scan'50,208,50";a="143513617"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 11:53:59 -0700
IronPort-SDR: ez7WknEKxGeFMnd0AC5DrmIZB+xqAk7jzBAaxJccx4N1fz1CW/U9gT4rWvsQyMPXlBn8hGHeCu
 pS8Nf/YNU8nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800";
   d="gz'50?scan'50,208,50";a="480890726"
Received: from lkp-server01.sh.intel.com (HELO 28879958b202) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jun 2020 11:53:55 -0700
Received: from kbuild by 28879958b202 with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1jpyug-00018Q-Qw; Mon, 29 Jun 2020 18:53:54 +0000
Date: Tue, 30 Jun 2020 02:53:37 +0800
From: kernel test robot <lkp@intel.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
	linux-nvdimm@lists.01.org, dan.j.williams@intel.com
Subject: Re: [PATCH v6 4/8] libnvdimm/nvdimm/flush: Allow architecture to
 override the flush barrier
Message-ID: <202006300210.ADlNY4uw%lkp@intel.com>
References: <20200629135722.73558-5-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200629135722.73558-5-aneesh.kumar@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: ZGSBPJVOTUFCVAVCNODJU274P4HIR3ZY
X-Message-ID-Hash: ZGSBPJVOTUFCVAVCNODJU274P4HIR3ZY
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: kbuild-all@lists.01.org, Jan Kara <jack@suse.cz>, msuchanek@suse.de, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZGSBPJVOTUFCVAVCNODJU274P4HIR3ZY/>
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
[cannot apply to scottwood/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use  as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Aneesh-Kumar-K-V/Support-new-pmem-flush-and-sync-instructions-for-POWER/20200629-223649
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: arc-allyesconfig (attached as .config)
compiler: arc-elf-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/nvdimm/region_devs.c: In function 'generic_nvdimm_flush':
>> drivers/nvdimm/region_devs.c:1215:2: error: implicit declaration of function 'arch_pmem_flush_barrier' [-Werror=implicit-function-declaration]
    1215 |  arch_pmem_flush_barrier();
         |  ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/arch_pmem_flush_barrier +1215 drivers/nvdimm/region_devs.c

  1178	
  1179	int nvdimm_flush(struct nd_region *nd_region, struct bio *bio)
  1180	{
  1181		int rc = 0;
  1182	
  1183		if (!nd_region->flush)
  1184			rc = generic_nvdimm_flush(nd_region);
  1185		else {
  1186			if (nd_region->flush(nd_region, bio))
  1187				rc = -EIO;
  1188		}
  1189	
  1190		return rc;
  1191	}
  1192	/**
  1193	 * nvdimm_flush - flush any posted write queues between the cpu and pmem media
  1194	 * @nd_region: blk or interleaved pmem region
  1195	 */
  1196	int generic_nvdimm_flush(struct nd_region *nd_region)
  1197	{
  1198		struct nd_region_data *ndrd = dev_get_drvdata(&nd_region->dev);
  1199		int i, idx;
  1200	
  1201		/*
  1202		 * Try to encourage some diversity in flush hint addresses
  1203		 * across cpus assuming a limited number of flush hints.
  1204		 */
  1205		idx = this_cpu_read(flush_idx);
  1206		idx = this_cpu_add_return(flush_idx, hash_32(current->pid + idx, 8));
  1207	
  1208		/*
  1209		 * The first arch_pmem_flush_barrier() is needed to 'sfence' all
  1210		 * previous writes such that they are architecturally visible for
  1211		 * the platform buffer flush. Note that we've already arranged for pmem
  1212		 * writes to avoid the cache via memcpy_flushcache().  The final
  1213		 * wmb() ensures ordering for the NVDIMM flush write.
  1214		 */
> 1215		arch_pmem_flush_barrier();
  1216		for (i = 0; i < nd_region->ndr_mappings; i++)
  1217			if (ndrd_get_flush_wpq(ndrd, i, 0))
  1218				writeq(1, ndrd_get_flush_wpq(ndrd, i, idx));
  1219		wmb();
  1220	
  1221		return 0;
  1222	}
  1223	EXPORT_SYMBOL_GPL(nvdimm_flush);
  1224	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

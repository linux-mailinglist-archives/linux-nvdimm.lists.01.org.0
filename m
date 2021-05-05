Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71817374B8B
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 May 2021 00:54:45 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D7B5F100F2271;
	Wed,  5 May 2021 15:54:42 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DE04B100F2265;
	Wed,  5 May 2021 15:54:38 -0700 (PDT)
IronPort-SDR: x0n+Hig7WAgbM9CaJ/8xv4CZLv4pPAkPypdsO7qTXL59EP+df8bBXTjlVe56kE34G1L/XREQ70
 z2i303/XIjFw==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="185787885"
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400";
   d="gz'50?scan'50,208,50";a="185787885"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 15:54:27 -0700
IronPort-SDR: FHzXTXi/FEumGYllfKzVAlHpS6GvwwH3vj4kyZTEbHKzeDbX7ghE8IrTdbeqQNewZcRQUBh7yU
 JRLmtu3JcWNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400";
   d="gz'50?scan'50,208,50";a="607552539"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 05 May 2021 15:54:25 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1leQPQ-000ACh-C3; Wed, 05 May 2021 22:54:24 +0000
Date: Thu, 6 May 2021 06:53:31 +0800
From: kernel test robot <lkp@intel.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
	linux-nvdimm@lists.01.org
Subject: Re: [PATCH] powerpc/papr_scm: Make 'perf_stats' invisible if
 perf-stats unavailable
Message-ID: <202105060645.yf56NIsK-lkp@intel.com>
References: <20210505191708.51939-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20210505191708.51939-1-vaibhav@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: DFXOAA7W3MG6X24H3TA56HHKAGGM7B6X
X-Message-ID-Hash: DFXOAA7W3MG6X24H3TA56HHKAGGM7B6X
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: kbuild-all@lists.01.org, Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DFXOAA7W3MG6X24H3TA56HHKAGGM7B6X/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Vaibhav,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on powerpc/next]
[also build test WARNING on v5.12 next-20210505]
[cannot apply to scottwood/next mpe/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Vaibhav-Jain/powerpc-papr_scm-Make-perf_stats-invisible-if-perf-stats-unavailable/20210506-031853
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-allyesconfig (attached as .config)
compiler: powerpc64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/8e7ce04ec36dea95fad178585b697a9c5b5c259d
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Vaibhav-Jain/powerpc-papr_scm-Make-perf_stats-invisible-if-perf-stats-unavailable/20210506-031853
        git checkout 8e7ce04ec36dea95fad178585b697a9c5b5c259d
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross W=1 ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/powerpc/platforms/pseries/papr_scm.c:903:9: warning: no previous prototype for 'papr_nd_attribute_visible' [-Wmissing-prototypes]
     903 | umode_t papr_nd_attribute_visible(struct kobject *kobj, struct attribute *attr,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/papr_nd_attribute_visible +903 arch/powerpc/platforms/pseries/papr_scm.c

   902	
 > 903	umode_t papr_nd_attribute_visible(struct kobject *kobj, struct attribute *attr,
   904					  int n)
   905	{
   906		struct device *dev = container_of(kobj, typeof(*dev), kobj);
   907		struct nvdimm *nvdimm = to_nvdimm(dev);
   908		struct papr_scm_priv *p = nvdimm_provider_data(nvdimm);
   909	
   910		/* For if perf-stats not available remove perf_stats sysfs */
   911		if (attr == &dev_attr_perf_stats.attr && p->stat_buffer_len == 0)
   912			return 0;
   913	
   914		return attr->mode;
   915	}
   916	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

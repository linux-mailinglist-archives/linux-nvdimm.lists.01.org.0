Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 176A61F40FB
	for <lists+linux-nvdimm@lfdr.de>; Tue,  9 Jun 2020 18:34:20 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B60F0100A461D;
	Tue,  9 Jun 2020 09:34:17 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0B54C100A6411;
	Tue,  9 Jun 2020 09:34:14 -0700 (PDT)
IronPort-SDR: 8D78g9+0Wegl3E0U4ZcVm5cuxIGF9qKgqFf6D9wnQmaOw+HbLgi6sDkJhepEr0T9BoRi4Z/P/8
 qPrm8EqnktOg==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 09:34:14 -0700
IronPort-SDR: FTyFDQpGDnD1wuD9lI0JbXVNQXqG9DHDJq/TnPhYhpRMiG+IsxEXkARf1Eu7vIHoeyDclimqTM
 9EkBdWU+rNHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,492,1583222400";
   d="gz'50?scan'50,208,50";a="418460025"
Received: from lkp-server01.sh.intel.com (HELO 4a187143b92d) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 09 Jun 2020 09:34:08 -0700
Received: from kbuild by 4a187143b92d with local (Exim 4.92)
	(envelope-from <lkp@intel.com>)
	id 1jihCR-00003w-QL; Tue, 09 Jun 2020 16:34:07 +0000
Date: Wed, 10 Jun 2020 00:33:10 +0800
From: kernel test robot <lkp@intel.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
	linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 5/6] ndctl/papr_scm,uapi: Add support for PAPR nvdimm
 specific methods
Message-ID: <202006100002.YBAi7It8%lkp@intel.com>
References: <20200608211026.67573-6-vaibhav@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200608211026.67573-6-vaibhav@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: TLVWRELBDBVWNSWMXMRO7DYCI67FPIRN
X-Message-ID-Hash: TLVWRELBDBVWNSWMXMRO7DYCI67FPIRN
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: kbuild-all@lists.01.org, clang-built-linux@googlegroups.com, Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TLVWRELBDBVWNSWMXMRO7DYCI67FPIRN/>
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
[also build test WARNING on linus/master v5.7 next-20200608]
[cannot apply to linux-nvdimm/libnvdimm-for-next scottwood/next]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Vaibhav-Jain/powerpc-papr_scm-Add-support-for-reporting-nvdimm-health/20200609-051451
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-randconfig-r031-20200608 (attached as .config)
compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project bc2b70982be8f5250cd0082a7190f8b417bd4dfe)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

In file included from <built-in>:1:
>> ./usr/include/asm/papr_pdsm.h:67:20: warning: field 'hdr' with variable sized type 'struct nd_cmd_pkg' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
struct nd_cmd_pkg hdr;  /* Package header containing sub-cmd */
^
1 warning generated.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

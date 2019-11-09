Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD2CF5D5D
	for <lists+linux-nvdimm@lfdr.de>; Sat,  9 Nov 2019 06:03:02 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 89137100EA52D;
	Fri,  8 Nov 2019 21:05:13 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AC8B1100EA62D;
	Fri,  8 Nov 2019 21:05:10 -0800 (PST)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2019 21:02:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,283,1569308400";
   d="gz'50?scan'50,208,50";a="213364631"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 08 Nov 2019 21:02:53 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
	(envelope-from <lkp@intel.com>)
	id 1iTIth-0000Cn-0N; Sat, 09 Nov 2019 13:02:53 +0800
Date: Sat, 9 Nov 2019 13:02:49 +0800
From: kbuild test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 16/16] libnvdimm/e820: Retrieve and populate correct
 'target_node' info
Message-ID: <201911091215.HPMYYO1z%lkp@intel.com>
References: <157309908326.1582359.13665017314935413372.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <157309908326.1582359.13665017314935413372.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Message-ID-Hash: QNJIVFY3QVCD6QUKLNT5RXVA6GED7IWJ
X-Message-ID-Hash: QNJIVFY3QVCD6QUKLNT5RXVA6GED7IWJ
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: kbuild-all@lists.01.org, linux-nvdimm@lists.01.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QNJIVFY3QVCD6QUKLNT5RXVA6GED7IWJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Dan,

I love your patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[cannot apply to v5.4-rc6 next-20191108]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Dan-Williams/Memory-Hierarchy-Enable-target-node-lookups-for-reserved-memory/20191109-080607
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: x86_64-randconfig-d002-201944 (attached as .config)
compiler: gcc-7 (Debian 7.4.0-14) 7.4.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: drivers/nvdimm/e820.o: in function `e820_register_one':
>> drivers/nvdimm/e820.c:27: undefined reference to `numa_map_to_online_node'

vim +27 drivers/nvdimm/e820.c

    18	
    19	static int e820_register_one(struct resource *res, void *data)
    20	{
    21		struct nd_region_desc ndr_desc;
    22		struct nvdimm_bus *nvdimm_bus = data;
    23		int nid = memory_add_physaddr_to_target_node(res->start);
    24	
    25		memset(&ndr_desc, 0, sizeof(ndr_desc));
    26		ndr_desc.res = res;
  > 27		ndr_desc.numa_node = numa_map_to_online_node(nid);
    28		ndr_desc.target_node = nid;
    29		set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
    30		if (!nvdimm_pmem_region_create(nvdimm_bus, &ndr_desc))
    31			return -ENXIO;
    32		return 0;
    33	}
    34	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

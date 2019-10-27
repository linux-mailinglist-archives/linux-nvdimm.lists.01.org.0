Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31722E69F3
	for <lists+linux-nvdimm@lfdr.de>; Sun, 27 Oct 2019 23:54:44 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2157C100EA618;
	Sun, 27 Oct 2019 15:55:38 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AFA77100EA612;
	Sun, 27 Oct 2019 15:55:35 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Oct 2019 15:54:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,237,1569308400";
   d="gz'50?scan'50,208,50";a="198491609"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 27 Oct 2019 15:54:32 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
	(envelope-from <lkp@intel.com>)
	id 1iOrQe-0001D7-5P; Mon, 28 Oct 2019 06:54:32 +0800
Date: Mon, 28 Oct 2019 06:53:34 +0800
From: kbuild test robot <lkp@intel.com>
To: Alastair D'Silva <alastair@au1.ibm.com>
Subject: Re: [PATCH 08/10] nvdimm: Add driver for OpenCAPI Storage Class
 Memory
Message-ID: <201910280616.xMDgVa1e%lkp@intel.com>
References: <20191025044721.16617-9-alastair@au1.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20191025044721.16617-9-alastair@au1.ibm.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Message-ID-Hash: DHIQQXZQXLF5EQNUD3GXHFFWVL6AGODH
X-Message-ID-Hash: DHIQQXZQXLF5EQNUD3GXHFFWVL6AGODH
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
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DHIQQXZQXLF5EQNUD3GXHFFWVL6AGODH/>
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
config: x86_64-allyesconfig (attached as .config)
compiler: gcc-7 (Debian 7.4.0-14) 7.4.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/nvdimm/ocxl-scm.c: In function 'scm_register_lpc_mem':
>> drivers/nvdimm/ocxl-scm.c:476:16: error: implicit declaration of function 'of_node_to_nid'; did you mean 'zone_to_nid'? [-Werror=implicit-function-declaration]
     target_node = of_node_to_nid(scm_data->pdev->dev.of_node);
                   ^~~~~~~~~~~~~~
                   zone_to_nid
   cc1: some warnings being treated as errors
--
   drivers/misc/ocxl/main.c: In function 'init_ocxl':
>> drivers/misc/ocxl/main.c:12:7: error: 'tlbie_capable' undeclared (first use in this function); did you mean 'ptracer_capable'?
     if (!tlbie_capable)
          ^~~~~~~~~~~~~
          ptracer_capable
   drivers/misc/ocxl/main.c:12:7: note: each undeclared identifier is reported only once for each function it appears in
--
>> drivers/misc/ocxl/config.c:4:10: fatal error: asm/pnv-ocxl.h: No such file or directory
    #include <asm/pnv-ocxl.h>
             ^~~~~~~~~~~~~~~~
   compilation terminated.
--
>> drivers/misc/ocxl/file.c:9:10: fatal error: asm/reg.h: No such file or directory
    #include <asm/reg.h>
             ^~~~~~~~~~~
   compilation terminated.
--
   drivers/misc/ocxl/mmio.c: In function 'ocxl_global_mmio_read32':
>> drivers/misc/ocxl/mmio.c:20:10: error: implicit declaration of function 'readl_be'; did you mean 'readsb'? [-Werror=implicit-function-declaration]
      *val = readl_be((char *)afu->global_mmio_ptr + offset);
             ^~~~~~~~
             readsb
   drivers/misc/ocxl/mmio.c: In function 'ocxl_global_mmio_read64':
>> drivers/misc/ocxl/mmio.c:45:10: error: implicit declaration of function 'readq_be'; did you mean 'readsb'? [-Werror=implicit-function-declaration]
      *val = readq_be((char *)afu->global_mmio_ptr + offset);
             ^~~~~~~~
             readsb
   drivers/misc/ocxl/mmio.c: In function 'ocxl_global_mmio_write32':
>> drivers/misc/ocxl/mmio.c:70:3: error: implicit declaration of function 'writel_be'; did you mean 'writesb'? [-Werror=implicit-function-declaration]
      writel_be(val, (char *)afu->global_mmio_ptr + offset);
      ^~~~~~~~~
      writesb
   drivers/misc/ocxl/mmio.c: In function 'ocxl_global_mmio_write64':
>> drivers/misc/ocxl/mmio.c:96:3: error: implicit declaration of function 'writeq_be'; did you mean 'writesb'? [-Werror=implicit-function-declaration]
      writeq_be(val, (char *)afu->global_mmio_ptr + offset);
      ^~~~~~~~~
      writesb
   cc1: some warnings being treated as errors
--
>> drivers/misc/ocxl/link.c:7:10: fatal error: asm/copro.h: No such file or directory
    #include <asm/copro.h>
             ^~~~~~~~~~~~~
   compilation terminated.
--
   drivers/misc/ocxl/context.c: In function 'ocxl_context_attach':
>> drivers/misc/ocxl/context.c:82:21: error: 'mm_context_t {aka struct <anonymous>}' has no member named 'id'
      pidr = mm->context.id;
                        ^
--
>> drivers/misc/ocxl/afu_irq.c:4:10: fatal error: asm/pnv-ocxl.h: No such file or directory
    #include <asm/pnv-ocxl.h>
             ^~~~~~~~~~~~~~~~
   compilation terminated.
--
   drivers/misc/ocxl/core.c: In function 'ocxl_function_open':
>> drivers/misc/ocxl/core.c:546:7: error: implicit declaration of function 'radix_enabled'; did you mean 'pat_enabled'? [-Werror=implicit-function-declaration]
     if (!radix_enabled()) {
          ^~~~~~~~~~~~~
          pat_enabled
   cc1: some warnings being treated as errors

vim +476 drivers/nvdimm/ocxl-scm.c

   402	
   403	/**
   404	 * scm_register_lpc_mem() - Discover persistent memory on a device and register it with the NVDIMM subsystem
   405	 * @scm_data: The SCM device data
   406	 * Return: 0 on success
   407	 */
   408	static int scm_register_lpc_mem(struct scm_data *scm_data)
   409	{
   410		struct nd_region_desc region_desc;
   411		struct nd_mapping_desc nd_mapping_desc;
   412		struct resource *lpc_mem;
   413		const struct ocxl_afu_config *config;
   414		const struct ocxl_fn_config *fn_config;
   415		int rc;
   416		unsigned long nvdimm_cmd_mask = 0;
   417		unsigned long nvdimm_flags = 0;
   418		int target_node;
   419		char serial[16+1];
   420	
   421		// Set up the reserved metadata area
   422		rc = ocxl_afu_map_lpc_mem(scm_data->ocxl_afu);
   423		if (rc < 0)
   424			return rc;
   425	
   426		lpc_mem = ocxl_afu_lpc_mem(scm_data->ocxl_afu);
   427		if (lpc_mem == NULL)
   428			return -EINVAL;
   429	
   430		config = ocxl_afu_config(scm_data->ocxl_afu);
   431		fn_config = ocxl_function_config(scm_data->ocxl_fn);
   432	
   433		rc = scm_reserve_metadata(scm_data, lpc_mem);
   434		if (rc)
   435			return rc;
   436	
   437		scm_data->bus_desc.attr_groups = scm_pmem_attribute_groups;
   438		scm_data->bus_desc.provider_name = "scm";
   439		scm_data->bus_desc.ndctl = scm_ndctl;
   440		scm_data->bus_desc.module = THIS_MODULE;
   441	
   442		scm_data->nvdimm_bus = nvdimm_bus_register(&scm_data->dev,
   443				       &scm_data->bus_desc);
   444		if (!scm_data->nvdimm_bus)
   445			return -EINVAL;
   446	
   447		scm_data->scm_res.start = (u64)lpc_mem->start + SCM_LABEL_AREA_SIZE;
   448		scm_data->scm_res.end = (u64)lpc_mem->start + config->lpc_mem_size - 1;
   449		scm_data->scm_res.name = "SCM persistent memory";
   450	
   451		set_bit(ND_CMD_GET_CONFIG_SIZE, &nvdimm_cmd_mask);
   452		set_bit(ND_CMD_GET_CONFIG_DATA, &nvdimm_cmd_mask);
   453		set_bit(ND_CMD_SET_CONFIG_DATA, &nvdimm_cmd_mask);
   454		set_bit(ND_CMD_SMART, &nvdimm_cmd_mask);
   455	
   456		set_bit(NDD_ALIASING, &nvdimm_flags);
   457	
   458		snprintf(serial, sizeof(serial), "%llx", fn_config->serial);
   459		nd_mapping_desc.nvdimm = __nvdimm_create(scm_data->nvdimm_bus, scm_data,
   460					 scm_dimm_attribute_groups,
   461					 nvdimm_flags, nvdimm_cmd_mask,
   462					 0, NULL, serial, &sec_ops);
   463		if (!nd_mapping_desc.nvdimm)
   464			return -ENOMEM;
   465	
   466		if (nvdimm_bus_check_dimm_count(scm_data->nvdimm_bus, 1))
   467			return -EINVAL;
   468	
   469		nd_mapping_desc.start = scm_data->scm_res.start;
   470		nd_mapping_desc.size = resource_size(&scm_data->scm_res);
   471		nd_mapping_desc.position = 0;
   472	
   473		scm_data->nd_set.cookie1 = fn_config->serial + 1; // allow for empty serial
   474		scm_data->nd_set.cookie2 = fn_config->serial + 1;
   475	
 > 476		target_node = of_node_to_nid(scm_data->pdev->dev.of_node);
   477	
   478		memset(&region_desc, 0, sizeof(region_desc));
   479		region_desc.res = &scm_data->scm_res;
   480		region_desc.attr_groups = scm_pmem_region_attribute_groups;
   481		region_desc.numa_node = NUMA_NO_NODE;
   482		region_desc.target_node = target_node;
   483		region_desc.num_mappings = 1;
   484		region_desc.mapping = &nd_mapping_desc;
   485		region_desc.nd_set = &scm_data->nd_set;
   486	
   487		set_bit(ND_REGION_PAGEMAP, &region_desc.flags);
   488		/*
   489		 * NB: libnvdimm copies the data from ndr_desc into it's own
   490		 * structures so passing a stack pointer is fine.
   491		 */
   492		scm_data->nd_region = nvdimm_pmem_region_create(scm_data->nvdimm_bus,
   493				      &region_desc);
   494		if (!scm_data->nd_region)
   495			return -EINVAL;
   496	
   497		dev_info(&scm_data->dev,
   498			 "Onlining %lluMB of persistent memory\n",
   499			 nd_mapping_desc.size / SZ_1M);
   500	
   501		return 0;
   502	}
   503	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

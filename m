Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E3FF7321
	for <lists+linux-nvdimm@lfdr.de>; Mon, 11 Nov 2019 12:33:11 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CE6D5100EA523;
	Mon, 11 Nov 2019 03:35:04 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AFB52100EA63E
	for <linux-nvdimm@lists.01.org>; Mon, 11 Nov 2019 03:35:01 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xABBX4mA106683;
	Mon, 11 Nov 2019 06:33:05 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2w75csknve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2019 06:33:05 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
	by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xABBUr2u002969;
	Mon, 11 Nov 2019 11:33:03 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
	by ppma04dal.us.ibm.com with ESMTP id 2w5n361ptc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2019 11:33:03 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
	by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xABBX1Xl53674440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2019 11:33:01 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91314AC060;
	Mon, 11 Nov 2019 11:33:01 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B391AC059;
	Mon, 11 Nov 2019 11:32:59 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.36.163])
	by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
	Mon, 11 Nov 2019 11:32:58 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 Q)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: "Alastair D'Silva" <alastair@au1.ibm.com>
Subject: Re: [PATCH 04/10] powerpc: Map & release OpenCAPI LPC memory
In-Reply-To: <20191025044721.16617-5-alastair@au1.ibm.com>
References: <20191025044721.16617-1-alastair@au1.ibm.com> <20191025044721.16617-5-alastair@au1.ibm.com>
Date: Mon, 11 Nov 2019 15:04:26 +0530
Message-ID: <8736euycwt.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-11_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=980 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911110109
Message-ID-Hash: OZ7I3KQGVCSNZGR3TVAJLW33NILTBMGV
X-Message-ID-Hash: OZ7I3KQGVCSNZGR3TVAJLW33NILTBMGV
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OZ7I3KQGVCSNZGR3TVAJLW33NILTBMGV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

"Alastair D'Silva" <alastair@au1.ibm.com> writes:

> From: Alastair D'Silva <alastair@d-silva.org>
>
> This patch adds platform support to map & release LPC memory.
>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  arch/powerpc/include/asm/pnv-ocxl.h   |  2 ++
>  arch/powerpc/platforms/powernv/ocxl.c | 41 +++++++++++++++++++++++++++
>  include/linux/memory_hotplug.h        |  5 ++++
>  mm/memory_hotplug.c                   |  3 +-
>  4 files changed, 50 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/pnv-ocxl.h b/arch/powerpc/include/asm/pnv-ocxl.h
> index 7de82647e761..f8f8ffb48aa8 100644
> --- a/arch/powerpc/include/asm/pnv-ocxl.h
> +++ b/arch/powerpc/include/asm/pnv-ocxl.h
> @@ -32,5 +32,7 @@ extern int pnv_ocxl_spa_remove_pe_from_cache(void *platform_data, int pe_handle)
>  
>  extern int pnv_ocxl_alloc_xive_irq(u32 *irq, u64 *trigger_addr);
>  extern void pnv_ocxl_free_xive_irq(u32 irq);
> +extern u64 pnv_ocxl_platform_lpc_setup(struct pci_dev *pdev, u64 size);
> +extern void pnv_ocxl_platform_lpc_release(struct pci_dev *pdev);
>  
>  #endif /* _ASM_PNV_OCXL_H */
> diff --git a/arch/powerpc/platforms/powernv/ocxl.c b/arch/powerpc/platforms/powernv/ocxl.c
> index 8c65aacda9c8..c6d4234e0aba 100644
> --- a/arch/powerpc/platforms/powernv/ocxl.c
> +++ b/arch/powerpc/platforms/powernv/ocxl.c
> @@ -475,6 +475,47 @@ void pnv_ocxl_spa_release(void *platform_data)
>  }
>  EXPORT_SYMBOL_GPL(pnv_ocxl_spa_release);
>  
> +u64 pnv_ocxl_platform_lpc_setup(struct pci_dev *pdev, u64 size)
> +{
> +	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
> +	struct pnv_phb *phb = hose->private_data;
> +	u32 bdfn = (pdev->bus->number << 8) | pdev->devfn;
> +	u64 base_addr = 0;
> +	int rc;
> +
> +	rc = opal_npu_mem_alloc(phb->opal_id, bdfn, size, &base_addr);
> +	if (rc) {
> +		dev_warn(&pdev->dev,
> +			 "OPAL could not allocate LPC memory, rc=%d\n", rc);
> +		return 0;
> +	}
> +
> +	base_addr = be64_to_cpu(base_addr);
> +
> +	rc = check_hotplug_memory_addressable(base_addr >> PAGE_SHIFT,
> +					      size >> PAGE_SHIFT);
> +	if (rc)
> +		return 0;
> +
> +	return base_addr;
> +}
> +EXPORT_SYMBOL_GPL(pnv_ocxl_platform_lpc_setup);
> +
> +void pnv_ocxl_platform_lpc_release(struct pci_dev *pdev)
> +{
> +	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
> +	struct pnv_phb *phb = hose->private_data;
> +	u32 bdfn = (pdev->bus->number << 8) | pdev->devfn;
> +	int rc;
> +
> +	rc = opal_npu_mem_release(phb->opal_id, bdfn);
> +	if (rc)
> +		dev_warn(&pdev->dev,
> +			 "OPAL reported rc=%d when releasing LPC memory\n", rc);
> +}
> +EXPORT_SYMBOL_GPL(pnv_ocxl_platform_lpc_release);
> +
> +
>  int pnv_ocxl_spa_remove_pe_from_cache(void *platform_data, int pe_handle)
>  {
>  	struct spa_data *data = (struct spa_data *) platform_data;
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index f46ea71b4ffd..3f5f1a642abe 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -339,6 +339,11 @@ static inline int remove_memory(int nid, u64 start, u64 size)
>  static inline void __remove_memory(int nid, u64 start, u64 size) {}
>  #endif /* CONFIG_MEMORY_HOTREMOVE */
>  
> +#if CONFIG_MEMORY_HOTPLUG_SPARSE
> +int check_hotplug_memory_addressable(unsigned long pfn,
> +		unsigned long nr_pages);
> +#endif /* CONFIG_MEMORY_HOTPLUG_SPARSE */
> +
>  extern void __ref free_area_init_core_hotplug(int nid);
>  extern int __add_memory(int nid, u64 start, u64 size);
>  extern int add_memory(int nid, u64 start, u64 size);
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 2cecf07b396f..b39827dbd071 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -278,7 +278,7 @@ static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
>  	return 0;
>  }
>  
> -static int check_hotplug_memory_addressable(unsigned long pfn,
> +int check_hotplug_memory_addressable(unsigned long pfn,
>  					    unsigned long nr_pages)
>  {
>  	const u64 max_addr = PFN_PHYS(pfn + nr_pages) - 1;
> @@ -294,6 +294,7 @@ static int check_hotplug_memory_addressable(unsigned long pfn,
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(check_hotplug_memory_addressable);
>  
>  /*
>   * Reasonably generic function for adding memory.  It is
> -- 
> 2.21.0

If you can rearrange the patch to show the callers in this same patch
that would make it easy to follow.

-aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

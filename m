Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0627215065E
	for <lists+linux-nvdimm@lfdr.de>; Mon,  3 Feb 2020 13:49:51 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D56A010FC319D;
	Mon,  3 Feb 2020 04:53:06 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.176.76.210; helo=huawei.com; envelope-from=jonathan.cameron@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 140C510FC319C
	for <linux-nvdimm@lists.01.org>; Mon,  3 Feb 2020 04:53:04 -0800 (PST)
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.108])
	by Forcepoint Email with ESMTP id 1E05179899897B42BEEF;
	Mon,  3 Feb 2020 12:49:45 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 LHREML711-CAH.china.huawei.com (10.201.108.34) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 3 Feb 2020 12:49:44 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 3 Feb 2020
 12:49:44 +0000
Date: Mon, 3 Feb 2020 12:49:42 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alastair D'Silva <alastair@au1.ibm.com>
Subject: Re: [PATCH v2 07/27] ocxl: Add functions to map/unmap LPC memory
Message-ID: <20200203124942.00003b68@Huawei.com>
In-Reply-To: <20191203034655.51561-8-alastair@au1.ibm.com>
References: <20191203034655.51561-1-alastair@au1.ibm.com>
	<20191203034655.51561-8-alastair@au1.ibm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Message-ID-Hash: 5BOP4G765Q4BDKEZRCRVEAVSIG6JTBSD
X-Message-ID-Hash: 5BOP4G765Q4BDKEZRCRVEAVSIG6JTBSD
X-MailFrom: jonathan.cameron@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: alastair@d-silva.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Rob Herring  <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>,  Krzysztof Kozlowski  <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan" <maddy@linux.vnet.ibm.com>, "=?ISO-8859-1?Q?C=E9dric?= Le Goater  <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>,  Hari Bathini  <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz" <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger
 .kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5BOP4G765Q4BDKEZRCRVEAVSIG6JTBSD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 3 Dec 2019 14:46:35 +1100
Alastair D'Silva <alastair@au1.ibm.com> wrote:

> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Add functions to map/unmap LPC memory
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  drivers/misc/ocxl/config.c        |  4 +++
>  drivers/misc/ocxl/core.c          | 50 +++++++++++++++++++++++++++++++
>  drivers/misc/ocxl/ocxl_internal.h |  3 ++
>  include/misc/ocxl.h               | 18 +++++++++++
>  4 files changed, 75 insertions(+)
> 
> diff --git a/drivers/misc/ocxl/config.c b/drivers/misc/ocxl/config.c
> index c8e19bfb5ef9..fb0c3b6f8312 100644
> --- a/drivers/misc/ocxl/config.c
> +++ b/drivers/misc/ocxl/config.c
> @@ -568,6 +568,10 @@ static int read_afu_lpc_memory_info(struct pci_dev *dev,
>  		afu->special_purpose_mem_size =
>  			total_mem_size - lpc_mem_size;
>  	}
> +
> +	dev_info(&dev->dev, "Probed LPC memory of %#llx bytes and special purpose memory of %#llx bytes\n",
> +		afu->lpc_mem_size, afu->special_purpose_mem_size);
> +

If we are being fussy, this block has nothing todo with the rest of the patch
so we should be seeing it here.

>  	return 0;
>  }
>  
> diff --git a/drivers/misc/ocxl/core.c b/drivers/misc/ocxl/core.c
> index 2531c6cf19a0..98611faea219 100644
> --- a/drivers/misc/ocxl/core.c
> +++ b/drivers/misc/ocxl/core.c
> @@ -210,6 +210,55 @@ static void unmap_mmio_areas(struct ocxl_afu *afu)
>  	release_fn_bar(afu->fn, afu->config.global_mmio_bar);
>  }
>  
> +int ocxl_afu_map_lpc_mem(struct ocxl_afu *afu)
> +{
> +	struct pci_dev *dev = to_pci_dev(afu->fn->dev.parent);
> +
> +	if ((afu->config.lpc_mem_size + afu->config.special_purpose_mem_size) == 0)
> +		return 0;
> +
> +	afu->lpc_base_addr = ocxl_link_lpc_map(afu->fn->link, dev);
> +	if (afu->lpc_base_addr == 0)
> +		return -EINVAL;
> +
> +	if (afu->config.lpc_mem_size) {

I was happy with the explicit check on 0 above, but we should be consistent.  Either
we make use of 0 == false, or we don't and explicitly check vs 0.

Hence

if (afu->config.pc_mem_size != 0) { 

here or

if (!(afu->config.pc_mem_size + afu->config.special_purpose_mem_size))
	return 0;

above.

> +		afu->lpc_res.start = afu->lpc_base_addr + afu->config.lpc_mem_offset;
> +		afu->lpc_res.end = afu->lpc_res.start + afu->config.lpc_mem_size - 1;
> +	}
> +
> +	if (afu->config.special_purpose_mem_size) {
> +		afu->special_purpose_res.start = afu->lpc_base_addr +
> +						 afu->config.special_purpose_mem_offset;
> +		afu->special_purpose_res.end = afu->special_purpose_res.start +
> +					       afu->config.special_purpose_mem_size - 1;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ocxl_afu_map_lpc_mem);
> +
> +struct resource *ocxl_afu_lpc_mem(struct ocxl_afu *afu)
> +{
> +	return &afu->lpc_res;
> +}
> +EXPORT_SYMBOL_GPL(ocxl_afu_lpc_mem);
> +
> +static void unmap_lpc_mem(struct ocxl_afu *afu)
> +{
> +	struct pci_dev *dev = to_pci_dev(afu->fn->dev.parent);
> +
> +	if (afu->lpc_res.start || afu->special_purpose_res.start) {
> +		void *link = afu->fn->link;
> +
> +		ocxl_link_lpc_release(link, dev);
> +
> +		afu->lpc_res.start = 0;
> +		afu->lpc_res.end = 0;
> +		afu->special_purpose_res.start = 0;
> +		afu->special_purpose_res.end = 0;
> +	}
> +}
> +
>  static int configure_afu(struct ocxl_afu *afu, u8 afu_idx, struct pci_dev *dev)
>  {
>  	int rc;
> @@ -251,6 +300,7 @@ static int configure_afu(struct ocxl_afu *afu, u8 afu_idx, struct pci_dev *dev)
>  
>  static void deconfigure_afu(struct ocxl_afu *afu)
>  {
> +	unmap_lpc_mem(afu);

Hmm. This breaks the existing balance between configure_afu and deconfigure_afu.

Given comments below on why we don't do map_lpc_mem in the afu bring up
(as it's a shared operation) it seems to me that we should be doing this
outside of the afu deconfigure.  Perhaps ocxl_function_close is appropriate?
I don't know this infrastructure well enough to be sure.

If it does need to be here, then a comment to give more info on
why would be great!

>  	unmap_mmio_areas(afu);
>  	reclaim_afu_pasid(afu);
>  	reclaim_afu_actag(afu);
> diff --git a/drivers/misc/ocxl/ocxl_internal.h b/drivers/misc/ocxl/ocxl_internal.h
> index 20b417e00949..9f4b47900e62 100644
> --- a/drivers/misc/ocxl/ocxl_internal.h
> +++ b/drivers/misc/ocxl/ocxl_internal.h
> @@ -52,6 +52,9 @@ struct ocxl_afu {
>  	void __iomem *global_mmio_ptr;
>  	u64 pp_mmio_start;
>  	void *private;
> +	u64 lpc_base_addr; /* Covers both LPC & special purpose memory */
> +	struct resource lpc_res;
> +	struct resource special_purpose_res;
>  };
>  
>  enum ocxl_context_status {
> diff --git a/include/misc/ocxl.h b/include/misc/ocxl.h
> index 06dd5839e438..6f7c02f0d5e3 100644
> --- a/include/misc/ocxl.h
> +++ b/include/misc/ocxl.h
> @@ -212,6 +212,24 @@ int ocxl_irq_set_handler(struct ocxl_context *ctx, int irq_id,
>  
>  // AFU Metadata
>  
> +/**
> + * Map the LPC system & special purpose memory for an AFU
> + *
> + * Do not call this during device discovery, as there may me multiple
> + * devices on a link, and the memory is mapped for the whole link, not
> + * just one device. It should only be called after all devices have
> + * registered their memory on the link.
> + *
> + * afu: The AFU that has the LPC memory to map
Run kernel-doc over these files and fix all the errors + warnings.

@afu: ..

and missing function name etc.


> + */
> +extern int ocxl_afu_map_lpc_mem(struct ocxl_afu *afu);
> +
> +/**
> + * Get the physical address range of LPC memory for an AFU
> + * afu: The AFU associated with the LPC memory
> + */
> +extern struct resource *ocxl_afu_lpc_mem(struct ocxl_afu *afu);
> +
>  /**
>   * Get a pointer to the config for an AFU
>   *

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

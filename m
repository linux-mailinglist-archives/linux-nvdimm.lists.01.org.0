Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F055150641
	for <lists+linux-nvdimm@lfdr.de>; Mon,  3 Feb 2020 13:37:39 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F188B10FC319C;
	Mon,  3 Feb 2020 04:40:38 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.176.76.210; helo=huawei.com; envelope-from=jonathan.cameron@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 76AF210FC319B
	for <linux-nvdimm@lists.01.org>; Mon,  3 Feb 2020 04:40:35 -0800 (PST)
Received: from lhreml704-cah.china.huawei.com (unknown [172.18.7.107])
	by Forcepoint Email with ESMTP id 3C5B5B98C4AD21534E93;
	Mon,  3 Feb 2020 12:37:15 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml704-cah.china.huawei.com (10.201.108.45) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 3 Feb 2020 12:37:14 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 3 Feb 2020
 12:37:14 +0000
Date: Mon, 3 Feb 2020 12:37:12 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alastair D'Silva <alastair@au1.ibm.com>
Subject: Re: [PATCH v2 06/27] ocxl: Tally up the LPC memory on a link &
 allow it to be mapped
Message-ID: <20200203123712.0000461a@Huawei.com>
In-Reply-To: <20191203034655.51561-7-alastair@au1.ibm.com>
References: <20191203034655.51561-1-alastair@au1.ibm.com>
	<20191203034655.51561-7-alastair@au1.ibm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Message-ID-Hash: L47EQMXYBN5RRJG2CN7C5NNYMSYAD36U
X-Message-ID-Hash: L47EQMXYBN5RRJG2CN7C5NNYMSYAD36U
X-MailFrom: jonathan.cameron@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: alastair@d-silva.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Rob Herring  <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>,  Krzysztof Kozlowski  <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan" <maddy@linux.vnet.ibm.com>, "=?ISO-8859-1?Q?C=E9dric?= Le Goater  <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>,  Hari Bathini  <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz" <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger
 .kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/L47EQMXYBN5RRJG2CN7C5NNYMSYAD36U/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 3 Dec 2019 14:46:34 +1100
Alastair D'Silva <alastair@au1.ibm.com> wrote:

> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Tally up the LPC memory on an OpenCAPI link & allow it to be mapped
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
Hi Alastair,

A few trivial comments inline.

Jonathan

> ---
>  drivers/misc/ocxl/core.c          | 10 ++++++
>  drivers/misc/ocxl/link.c          | 60 +++++++++++++++++++++++++++++++
>  drivers/misc/ocxl/ocxl_internal.h | 33 +++++++++++++++++
>  3 files changed, 103 insertions(+)
> 
> diff --git a/drivers/misc/ocxl/core.c b/drivers/misc/ocxl/core.c
> index b7a09b21ab36..2531c6cf19a0 100644
> --- a/drivers/misc/ocxl/core.c
> +++ b/drivers/misc/ocxl/core.c
> @@ -230,8 +230,18 @@ static int configure_afu(struct ocxl_afu *afu, u8 afu_idx, struct pci_dev *dev)
>  	if (rc)
>  		goto err_free_pasid;
>  
> +	if (afu->config.lpc_mem_size || afu->config.special_purpose_mem_size) {
> +		rc = ocxl_link_add_lpc_mem(afu->fn->link, afu->config.lpc_mem_offset,
> +					   afu->config.lpc_mem_size +
> +					   afu->config.special_purpose_mem_size);
> +		if (rc)
> +			goto err_free_mmio;
> +	}
> +
>  	return 0;
>  
> +err_free_mmio:
> +	unmap_mmio_areas(afu);
>  err_free_pasid:
>  	reclaim_afu_pasid(afu);
>  err_free_actag:
> diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
> index 58d111afd9f6..d8503f0dc6ec 100644
> --- a/drivers/misc/ocxl/link.c
> +++ b/drivers/misc/ocxl/link.c
> @@ -84,6 +84,11 @@ struct ocxl_link {
>  	int dev;
>  	atomic_t irq_available;
>  	struct spa *spa;
> +	struct mutex lpc_mem_lock;

Always a good idea to explicitly document what a lock is intended to protect.

> +	u64 lpc_mem_sz; /* Total amount of LPC memory presented on the link */
> +	u64 lpc_mem;
> +	int lpc_consumers;
> +
>  	void *platform_data;
>  };
>  static struct list_head links_list = LIST_HEAD_INIT(links_list);
> @@ -396,6 +401,8 @@ static int alloc_link(struct pci_dev *dev, int PE_mask, struct ocxl_link **out_l
>  	if (rc)
>  		goto err_spa;
>  
> +	mutex_init(&link->lpc_mem_lock);
> +
>  	/* platform specific hook */
>  	rc = pnv_ocxl_spa_setup(dev, link->spa->spa_mem, PE_mask,
>  				&link->platform_data);
> @@ -711,3 +718,56 @@ void ocxl_link_free_irq(void *link_handle, int hw_irq)
>  	atomic_inc(&link->irq_available);
>  }
>  EXPORT_SYMBOL_GPL(ocxl_link_free_irq);
> +
> +int ocxl_link_add_lpc_mem(void *link_handle, u64 offset, u64 size)
> +{
> +	struct ocxl_link *link = (struct ocxl_link *) link_handle;
> +
> +	// Check for overflow

Stray c++ style comment.

> +	if (offset > (offset + size))
> +		return -EINVAL;
> +
> +	mutex_lock(&link->lpc_mem_lock);
> +	link->lpc_mem_sz = max(link->lpc_mem_sz, offset + size);
> +
> +	mutex_unlock(&link->lpc_mem_lock);
> +
> +	return 0;
> +}
> +
> +u64 ocxl_link_lpc_map(void *link_handle, struct pci_dev *pdev)
> +{
> +	struct ocxl_link *link = (struct ocxl_link *) link_handle;
> +	u64 lpc_mem;
> +
> +	mutex_lock(&link->lpc_mem_lock);
> +	if (link->lpc_mem) {

If you don't modify this later in the series (I haven't read it all yet :),
it rather feels like it would be more compact and just as readable as
something like...

	if (!link->lpc_mem)
		link->lpc_mem = pnv_ocxl...

	if (link->lpc_mem)
		link->lpc_consumers++;
	mutex_unlock(&link->lpc_mem_lock);
		
	return link->lpc_mem;

> +		lpc_mem = link->lpc_mem;
> +
> +		link->lpc_consumers++;
> +		mutex_unlock(&link->lpc_mem_lock);
> +		return lpc_mem;
> +	}
> +
> +	link->lpc_mem = pnv_ocxl_platform_lpc_setup(pdev, link->lpc_mem_sz);
> +	if (link->lpc_mem)
> +		link->lpc_consumers++;
> +	lpc_mem = link->lpc_mem;
> +	mutex_unlock(&link->lpc_mem_lock);
> +
> +	return lpc_mem;
> +}
> +
> +void ocxl_link_lpc_release(void *link_handle, struct pci_dev *pdev)
> +{
> +	struct ocxl_link *link = (struct ocxl_link *) link_handle;
> +
> +	mutex_lock(&link->lpc_mem_lock);
> +	WARN_ON(--link->lpc_consumers < 0);
> +	if (link->lpc_consumers == 0) {
> +		pnv_ocxl_platform_lpc_release(pdev);
> +		link->lpc_mem = 0;
> +	}
> +
> +	mutex_unlock(&link->lpc_mem_lock);
> +}
> diff --git a/drivers/misc/ocxl/ocxl_internal.h b/drivers/misc/ocxl/ocxl_internal.h
> index 97415afd79f3..20b417e00949 100644
> --- a/drivers/misc/ocxl/ocxl_internal.h
> +++ b/drivers/misc/ocxl/ocxl_internal.h
> @@ -141,4 +141,37 @@ int ocxl_irq_offset_to_id(struct ocxl_context *ctx, u64 offset);
>  u64 ocxl_irq_id_to_offset(struct ocxl_context *ctx, int irq_id);
>  void ocxl_afu_irq_free_all(struct ocxl_context *ctx);
>  
> +/**
> + * ocxl_link_add_lpc_mem() - Increment the amount of memory required by an OpenCAPI link
> + *
> + * @link_handle: The OpenCAPI link handle
> + * @offset: The offset of the memory to add
> + * @size: The amount of memory to increment by
> + *
> + * Return 0 on success, negative on overflow
> + */
> +int ocxl_link_add_lpc_mem(void *link_handle, u64 offset, u64 size);
> +
> +/**
> + * ocxl_link_lpc_map() - Map the LPC memory for an OpenCAPI device
> + *
> + * Since LPC memory belongs to a link, the whole LPC memory available
> + * on the link bust be mapped in order to make it accessible to a device.

must

> + *
> + * @link_handle: The OpenCAPI link handle
> + * @pdev: A device that is on the link
> + */
> +u64 ocxl_link_lpc_map(void *link_handle, struct pci_dev *pdev);
> +
> +/**
> + * ocxl_link_lpc_release() - Release the LPC memory device for an OpenCAPI device
> + *
> + * Offlines LPC memory on an OpenCAPI link for a device. If this is the
> + * last device on the link to release the memory, unmap it from the link.
> + *
> + * @link_handle: The OpenCAPI link handle
> + * @pdev: A device that is on the link
> + */
> +void ocxl_link_lpc_release(void *link_handle, struct pci_dev *pdev);
> +
>  #endif /* _OCXL_INTERNAL_H_ */

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

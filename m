Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D5A316E4D
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Feb 2021 19:18:33 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D9B42100EA915;
	Wed, 10 Feb 2021 10:18:31 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.176.79.56; helo=frasgout.his.huawei.com; envelope-from=jonathan.cameron@huawei.com; receiver=<UNKNOWN> 
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 87901100EA914
	for <linux-nvdimm@lists.01.org>; Wed, 10 Feb 2021 10:18:29 -0800 (PST)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.207])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DbSYk6bX5z67kqq;
	Thu, 11 Feb 2021 02:13:30 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 10 Feb 2021 19:18:26 +0100
Received: from localhost (10.47.67.2) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 10 Feb
 2021 18:18:25 +0000
Date: Wed, 10 Feb 2021 18:17:25 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH v2 3/8] cxl/mem: Register CXL memX devices
Message-ID: <20210210181725.00007865@Huawei.com>
In-Reply-To: <20210210000259.635748-4-ben.widawsky@intel.com>
References: <20210210000259.635748-1-ben.widawsky@intel.com>
	<20210210000259.635748-4-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.47.67.2]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Message-ID-Hash: HPB234UZIRYHYAAOA57TCGWPNO7JYFVH
X-Message-ID-Hash: HPB234UZIRYHYAAOA57TCGWPNO7JYFVH
X-MailFrom: jonathan.cameron@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, "Chris Browy  <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>,  Dan Williams  <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, David Rientjes" <rientjes@google.com>, "Jon Masters  <jcm@jonmasters.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap" <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HPB234UZIRYHYAAOA57TCGWPNO7JYFVH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 9 Feb 2021 16:02:54 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> From: Dan Williams <dan.j.williams@intel.com>
> 
> Create the /sys/bus/cxl hierarchy to enumerate:
> 
> * Memory Devices (per-endpoint control devices)
> 
> * Memory Address Space Devices (platform address ranges with
>   interleaving, performance, and persistence attributes)
> 
> * Memory Regions (active provisioned memory from an address space device
>   that is in use as System RAM or delegated to libnvdimm as Persistent
>   Memory regions).
> 
> For now, only the per-endpoint control devices are registered on the
> 'cxl' bus. However, going forward it will provide a mechanism to
> coordinate cross-device interleave.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

One stray header, and a request for a tiny bit of reordering to
make it easier to chase through creation and destruction.

Either way with the header move to earlier patch I'm fine with this one.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl       |  26 ++
>  .../driver-api/cxl/memory-devices.rst         |  17 +
>  drivers/cxl/Makefile                          |   3 +
>  drivers/cxl/bus.c                             |  29 ++
>  drivers/cxl/cxl.h                             |   4 +
>  drivers/cxl/mem.c                             | 301 +++++++++++++++++-
>  6 files changed, 378 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-cxl
>  create mode 100644 drivers/cxl/bus.c
> 


> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 745f5e0bfce3..b3c56fa6e126 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -3,6 +3,7 @@
>  
>  #ifndef __CXL_H__
>  #define __CXL_H__
> +#include <linux/range.h>

Why is this coming in now? Feels like it should have been in earlier
patch that started using struct range

>  
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
> @@ -55,6 +56,7 @@
>  	(FIELD_GET(CXLMDEV_RESET_NEEDED_MASK, status) !=                       \
>  	 CXLMDEV_RESET_NEEDED_NOT)
>  
> +struct cxl_memdev;
>  /**
>   * struct cxl_mem - A CXL memory device
>   * @pdev: The PCI device associated with this CXL device.
> @@ -72,6 +74,7 @@
>  struct cxl_mem {
>  	struct pci_dev *pdev;
>  	void __iomem *regs;
> +	struct cxl_memdev *cxlmd;
>  
>  	void __iomem *status_regs;
>  	void __iomem *mbox_regs;
> @@ -90,4 +93,5 @@ struct cxl_mem {
>  	} ram;
>  };
>  
> +extern struct bus_type cxl_bus_type;
>  #endif /* __CXL_H__ */
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 0a868a15badc..8bbd2495e237 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -1,11 +1,36 @@
>

> +
> +static void cxl_memdev_release(struct device *dev)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +
> +	percpu_ref_exit(&cxlmd->ops_active);
> +	ida_free(&cxl_memdev_ida, cxlmd->id);
> +	kfree(cxlmd);
> +}
> +
...

> +static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
> +{
> +	struct pci_dev *pdev = cxlm->pdev;
> +	struct cxl_memdev *cxlmd;
> +	struct device *dev;
> +	struct cdev *cdev;
> +	int rc;
> +
> +	cxlmd = kzalloc(sizeof(*cxlmd), GFP_KERNEL);
> +	if (!cxlmd)
> +		return -ENOMEM;
> +	init_completion(&cxlmd->ops_dead);
> +
> +	/*
> +	 * @cxlm is deallocated when the driver unbinds so operations
> +	 * that are using it need to hold a live reference.
> +	 */
> +	cxlmd->cxlm = cxlm;
> +	rc = percpu_ref_init(&cxlmd->ops_active, cxlmdev_ops_active_release, 0,
> +			     GFP_KERNEL);
> +	if (rc)
> +		goto err_ref;
> +
> +	rc = ida_alloc_range(&cxl_memdev_ida, 0, CXL_MEM_MAX_DEVS, GFP_KERNEL);
> +	if (rc < 0)
> +		goto err_id;
> +	cxlmd->id = rc;
> +
> +	dev = &cxlmd->dev;
> +	device_initialize(dev);
> +	dev->parent = &pdev->dev;
> +	dev->bus = &cxl_bus_type;
> +	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
> +	dev->type = &cxl_memdev_type;
> +	dev_set_name(dev, "mem%d", cxlmd->id);
> +
> +	cdev = &cxlmd->cdev;
> +	cdev_init(cdev, &cxl_memdev_fops);
> +
> +	rc = cdev_device_add(cdev, dev);
> +	if (rc)
> +		goto err_add;
> +
> +	return devm_add_action_or_reset(dev->parent, cxlmdev_unregister, cxlmd);

This had me scratching my head. The cxlmdev_unregister() if called normally
or in the _or_reset() results in

	percpu_ref_kill(&cxlmd->ops_active);
	cdev_device_del(&cxlmd->cdev, dev);
	wait_for_completion(&cxlmd->ops_dead);
	cxlmd->cxlm = NULL;
	put_device(dev);
	/* If last ref this will result in */
		percpu_ref_exit(&cxlmd->ops_active);
		ida_free(&cxl_memdev_ida, cxlmd->id);
		kfree(cxlmd);

So it's doing all the correct things but not necessarily
in the obvious order.

For simplicity of review perhaps it's worth reordering probe a bit
to get the ida immediately after the cxlmd alloc and
for the cxlmdev_unregister() perhaps reorder the cdev_device_del()
before the percpu_ref_kill().

Trivial obvious as the ordering has no affect but makes it
easy for reviewers to tick off setup vs tear down parts.

> +
> +err_add:
> +	ida_free(&cxl_memdev_ida, cxlmd->id);
> +err_id:
> +	/*
> +	 * Theoretically userspace could have already entered the fops,
> +	 * so flush ops_active.
> +	 */
> +	percpu_ref_kill(&cxlmd->ops_active);
> +	wait_for_completion(&cxlmd->ops_dead);
> +	percpu_ref_exit(&cxlmd->ops_active);
> +err_ref:
> +	kfree(cxlmd);
> +
> +	return rc;
> +}
> +



_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

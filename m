Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BFC30C938
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Feb 2021 19:14:05 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 78030100EA2B9;
	Tue,  2 Feb 2021 10:14:03 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+78410b086ab5a19d433c+6372+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 833FE100EA2B8
	for <linux-nvdimm@lists.01.org>; Tue,  2 Feb 2021 10:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bJEP+2U5IHzdV2qfnQ7rYOCO3psxW3Bn2kjhHos5sUE=; b=wJAxx4saCmpOESyrOd9ngpJa8p
	WclqsGHnEBCWPZPSjwMviTo2DraBgO/ruRSqVc1jZKjk8P1ETlGUT0ZhoSJ33sXPtY4wPD7EvVtuh
	vCvgqYuU6TWVajw+XMVs3AHKvE5tj9r31Wn/vHI220bvXTQUv2tsHtmfxQzVKF/YsaUzbG3Vf9Ab3
	k/bav4UP053XTUZXT8EEZItKfYHXn9QYa4ayeq5KkBDZ9C0tBvTgz8TTDs1JdXN30lUSljn6FZsQA
	n63z8TKMycIgOhwJqOfnP/Y2l/w5Xc5shymhQEajRookQg5x/6X5bhabeGGdnWvfGkOTYGGBW5qIJ
	kuPLgAzg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
	id 1l70BW-00FZoh-LW; Tue, 02 Feb 2021 18:13:54 +0000
Date: Tue, 2 Feb 2021 18:13:54 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH 05/14] cxl/mem: Register CXL memX devices
Message-ID: <20210202181354.GE3708021@infradead.org>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-6-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210130002438.1872527-6-ben.widawsky@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: IWOUHRXHC7GQ26RLZINX7WOGECDC7VWV
X-Message-ID-Hash: IWOUHRXHC7GQ26RLZINX7WOGECDC7VWV
X-MailFrom: BATV+78410b086ab5a19d433c+6372+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IWOUHRXHC7GQ26RLZINX7WOGECDC7VWV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 25e08e5f40bd..33432a4cbe23 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3179,6 +3179,20 @@ struct device *get_device(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(get_device);
>  
> +/**
> + * get_live_device() - increment reference count for device iff !dead
> + * @dev: device.
> + *
> + * Forward the call to get_device() if the device is still alive. If
> + * this is called with the device_lock() held then the device is
> + * guaranteed to not die until the device_lock() is dropped.
> + */
> +struct device *get_live_device(struct device *dev)
> +{
> +	return dev && !dev->p->dead ? get_device(dev) : NULL;
> +}
> +EXPORT_SYMBOL_GPL(get_live_device);

Err, if you want to add new core functionality that needs to be in a
separate well documented prep patch, and also CCed to the relevant
maintainers.

>  	mutex_unlock(&cxlm->mbox.mutex);
>  }
>  
> +static int cxl_memdev_open(struct inode *inode, struct file *file)
> +{
> +	struct cxl_memdev *cxlmd =
> +		container_of(inode->i_cdev, typeof(*cxlmd), cdev);
> +
> +	file->private_data = cxlmd;

There is no good reason to ever mirror stuff from the inode into
file->private_data, as you can just trivially get at the original
location using file_inode(file).
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

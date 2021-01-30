Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41863098F2
	for <lists+linux-nvdimm@lfdr.de>; Sun, 31 Jan 2021 00:51:49 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 45C12100EBBA0;
	Sat, 30 Jan 2021 15:51:48 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=rientjes@google.com; receiver=<UNKNOWN> 
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 11527100EC1EE
	for <linux-nvdimm@lists.01.org>; Sat, 30 Jan 2021 15:51:46 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id z21so9418708pgj.4
        for <linux-nvdimm@lists.01.org>; Sat, 30 Jan 2021 15:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=GDv15DwnRp3MS5y0X9bL9QkhV0S8PjNmrscexBhhUtA=;
        b=Mniksk0+xMkFOMZyyZxYvBktssUOJFhazgAfgAHn9e+16eIYt+3GlpWg6E0DAJ8fYY
         WDuDlRb+ul9uZLNgaLXC4pv8dqBpjAjemOJWnSsOSyiy69MNK+dOs/FZDn7dLcxhzUNS
         59fLeXPXG9kHc1/bO/wl17ZNmqBSO12pGkj4fTSPU8f8wXSUykglI65cZ1o3wa7S+uC7
         WjnOnqrs8SPFn6yfNbHYcMWzjiHuBQaWXhxy6t+TrLWD5+PfN1LqKdWyN5QyGpSwfr9m
         ec4kibCqC+jcrS3ail6HKNoQTR0CkaVYGqzRs/nXdEYb5wVMTjzQ8l7kqTklE8pFArx7
         bm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=GDv15DwnRp3MS5y0X9bL9QkhV0S8PjNmrscexBhhUtA=;
        b=ICqPQ3U6Wq4vJyXGg7pmVQ8FZ1fZwLS2zlVVzrPrBUu5PCtROTFlyRoqs925AmVZEs
         hukCzT766U1LjuXKW7ZCel7BE4vmoziX0aq0JhX6l8vwfovozPYNy2dx69FtmD8PRxOL
         G5y6ePntNGZRaRsOBkCI2fM4+wkn0EoNlStXBIjzHYp+cQo80Cv7z7QomXTCGU+eXx7X
         dwYMxvKKmKmiacBL5nlGp4Ixw4fKE4byW/2SV+g0+bB6cH1KMaX+i0pk4D6uf3b+CLr4
         xtAV3qdWYNSJncSmdztzuClrDjSDyP6zqxLhw9nJO9vewRTbFcZWtulSV2yuKsvEh0J2
         Assw==
X-Gm-Message-State: AOAM5335Zzmhp8U4P/5xOC/L11BLnTo4sb8vfioRsUvggXf3S8UeOTTp
	DTKXjE0qLPjaxCOYqVclWZx/+Q==
X-Google-Smtp-Source: ABdhPJwbuQ4nVg0OQPgeWs57sXjRNYE2dA+6UJRCYf1jVILDhdLj6k91Bbw9k3VuSrWFNKVhFs7mpg==
X-Received: by 2002:a63:f405:: with SMTP id g5mr10896366pgi.276.1612050704574;
        Sat, 30 Jan 2021 15:51:44 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id a25sm12812739pgv.40.2021.01.30.15.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 15:51:43 -0800 (PST)
Date: Sat, 30 Jan 2021 15:51:42 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH 02/14] cxl/mem: Map memory device registers
In-Reply-To: <20210130002438.1872527-3-ben.widawsky@intel.com>
Message-ID: <792edaa-a11b-41c6-c2a1-2c72a3e4e815@google.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com> <20210130002438.1872527-3-ben.widawsky@intel.com>
MIME-Version: 1.0
Message-ID-Hash: 7SDV7C4PQK7IHPGJRYRM4K2FRSOZFPCU
X-Message-ID-Hash: 7SDV7C4PQK7IHPGJRYRM4K2FRSOZFPCU
X-MailFrom: rientjes@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7SDV7C4PQK7IHPGJRYRM4K2FRSOZFPCU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 29 Jan 2021, Ben Widawsky wrote:

> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> new file mode 100644
> index 000000000000..d81d0ba4617c
> --- /dev/null
> +++ b/drivers/cxl/cxl.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2020 Intel Corporation. */
> +
> +#ifndef __CXL_H__
> +#define __CXL_H__
> +
> +/**
> + * struct cxl_mem - A CXL memory device
> + * @pdev: The PCI device associated with this CXL device.
> + * @regs: IO mappings to the device's MMIO
> + */
> +struct cxl_mem {
> +	struct pci_dev *pdev;
> +	void __iomem *regs;
> +};
> +
> +#endif

Stupid question: can there be more than one CXL.mem capable logical 
device?  I only ask to determine if an ordinal is needed to enumerate 
multiple LDs.

> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index f4ee9a507ac9..a869c8dc24cc 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -4,6 +4,58 @@
>  #include <linux/pci.h>
>  #include <linux/io.h>
>  #include "pci.h"
> +#include "cxl.h"
> +
> +/**
> + * cxl_mem_create() - Create a new &struct cxl_mem.
> + * @pdev: The pci device associated with the new &struct cxl_mem.
> + * @reg_lo: Lower 32b of the register locator
> + * @reg_hi: Upper 32b of the register locator.
> + *
> + * Return: The new &struct cxl_mem on success, NULL on failure.
> + *
> + * Map the BAR for a CXL memory device. This BAR has the memory device's
> + * registers for the device as specified in CXL specification.
> + */
> +static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
> +				      u32 reg_hi)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct cxl_mem *cxlm;
> +	void __iomem *regs;
> +	u64 offset;
> +	u8 bar;
> +	int rc;
> +
> +	offset = ((u64)reg_hi << 32) | (reg_lo & CXL_REGLOC_ADDR_MASK);
> +	bar = (reg_lo >> CXL_REGLOC_BIR_SHIFT) & CXL_REGLOC_BIR_MASK;
> +
> +	/* Basic sanity check that BAR is big enough */
> +	if (pci_resource_len(pdev, bar) < offset) {
> +		dev_err(dev, "BAR%d: %pr: too small (offset: %#llx)\n", bar,
> +			&pdev->resource[bar], (unsigned long long)offset);
> +		return NULL;
> +	}
> +
> +	rc = pcim_iomap_regions(pdev, BIT(bar), pci_name(pdev));
> +	if (rc != 0) {
> +		dev_err(dev, "failed to map registers\n");
> +		return NULL;
> +	}
> +
> +	cxlm = devm_kzalloc(&pdev->dev, sizeof(*cxlm), GFP_KERNEL);
> +	if (!cxlm) {
> +		dev_err(dev, "No memory available\n");
> +		return NULL;
> +	}
> +
> +	regs = pcim_iomap_table(pdev)[bar];
> +	cxlm->pdev = pdev;
> +	cxlm->regs = regs + offset;
> +
> +	dev_dbg(dev, "Mapped CXL Memory Device resource\n");
> +	return cxlm;
> +}
>  
>  static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
>  {
> @@ -32,15 +84,42 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
>  static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct device *dev = &pdev->dev;
> -	int regloc;
> +	struct cxl_mem *cxlm;
> +	int rc, regloc, i;
> +
> +	rc = pcim_enable_device(pdev);
> +	if (rc)
> +		return rc;
>  
>  	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC);
>  	if (!regloc) {
>  		dev_err(dev, "register location dvsec not found\n");
>  		return -ENXIO;
>  	}
> +	regloc += 0xc; /* Skip DVSEC + reserved fields */

Assuming the DVSEC revision number is always 0x0 or there's no value in 
storing this in struct cxl_mem for the future.

Acked-by: David Rientjes <rientjes@google.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

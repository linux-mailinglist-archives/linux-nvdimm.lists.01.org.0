Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A8C30ADA7
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Feb 2021 18:22:13 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B45E6100EB834;
	Mon,  1 Feb 2021 09:22:11 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.176.79.56; helo=frasgout.his.huawei.com; envelope-from=jonathan.cameron@huawei.com; receiver=<UNKNOWN> 
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7D970100EB832
	for <linux-nvdimm@lists.01.org>; Mon,  1 Feb 2021 09:22:09 -0800 (PST)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.201])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DTvjR6tjtz67jtQ;
	Tue,  2 Feb 2021 01:15:55 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 1 Feb 2021 18:22:03 +0100
Received: from localhost (10.47.76.76) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Mon, 1 Feb 2021
 17:22:02 +0000
Date: Mon, 1 Feb 2021 17:21:18 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH 01/14] cxl/mem: Introduce a driver for CXL-2.0-Type-3
 endpoints
Message-ID: <20210201172118.0000673f@Huawei.com>
In-Reply-To: <20210130002438.1872527-2-ben.widawsky@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
	<20210130002438.1872527-2-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.47.76.76]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Message-ID-Hash: DXPYNYCNBD4N2J35H4X7LKLWRX66QC6I
X-Message-ID-Hash: DXPYNYCNBD4N2J35H4X7LKLWRX66QC6I
X-MailFrom: jonathan.cameron@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>, daniel.lll@alibaba-inc.com,
	jgroves <John@ml01.01.org>, Sean V <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DXPYNYCNBD4N2J35H4X7LKLWRX66QC6I/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 29 Jan 2021 16:24:25 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> From: Dan Williams <dan.j.williams@intel.com>
> 
> The CXL.mem protocol allows a device to act as a provider of "System
> RAM" and/or "Persistent Memory" that is fully coherent as if the memory
> was attached to the typical CPU memory controller.
> 
> With the CXL-2.0 specification a PCI endpoint can implement a "Type-3"
> device interface and give the operating system control over "Host
> Managed Device Memory". See section 2.3 Type 3 CXL Device.
> 
> The memory range exported by the device may optionally be described by
> the platform firmware memory map, or by infrastructure like LIBNVDIMM to
> provision persistent memory capacity from one, or more, CXL.mem devices.
> 
> A pre-requisite for Linux-managed memory-capacity provisioning is this
> cxl_mem driver that can speak the mailbox protocol defined in section
> 8.2.8.4 Mailbox Registers.
> 
> For now just land the initial driver boiler-plate and Documentation/
> infrastructure.
> 
> Link: https://www.computeexpresslink.org/download-the-specification
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Hi Ben,

One thing below about using defs from generic PCI headers where
they are not CXL specific.


> diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
> new file mode 100644
> index 000000000000..a8a9935fa90b
> --- /dev/null
> +++ b/drivers/cxl/pci.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> +#ifndef __CXL_PCI_H__
> +#define __CXL_PCI_H__
> +
> +#define PCI_CLASS_MEMORY_CXL	0x050210
> +
> +/*
> + * See section 8.1 Configuration Space Registers in the CXL 2.0
> + * Specification
> + */
> +#define PCI_EXT_CAP_ID_DVSEC		0x23
> +#define PCI_DVSEC_VENDOR_ID_CXL		0x1E98
> +#define PCI_DVSEC_VENDOR_ID_OFFSET	0x4
> +#define PCI_DVSEC_ID_CXL		0x0
> +#define PCI_DVSEC_ID_OFFSET		0x8

include/uapi/linux/pci-regs.h includes equivalents of generic parts of
this already though PCI_DVSEC_HEADER1 isn't exactly informative naming.

> +
> +#define PCI_DVSEC_ID_CXL_REGLOC		0x8
> +
> +#endif /* __CXL_PCI_H__ */
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

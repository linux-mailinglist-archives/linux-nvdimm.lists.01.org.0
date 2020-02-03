Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728B7150666
	for <lists+linux-nvdimm@lfdr.de>; Mon,  3 Feb 2020 13:54:01 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3702710FC319D;
	Mon,  3 Feb 2020 04:57:11 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.176.76.210; helo=huawei.com; envelope-from=jonathan.cameron@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DAE2F10FC319D
	for <linux-nvdimm@lists.01.org>; Mon,  3 Feb 2020 04:57:08 -0800 (PST)
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.107])
	by Forcepoint Email with ESMTP id 1DD08A477DD53B5A870A;
	Mon,  3 Feb 2020 12:53:49 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml709-cah.china.huawei.com (10.201.108.32) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 3 Feb 2020 12:53:48 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 3 Feb 2020
 12:53:48 +0000
Date: Mon, 3 Feb 2020 12:53:46 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alastair D'Silva <alastair@au1.ibm.com>
Subject: Re: [PATCH v2 08/27] ocxl: Save the device serial number in ocxl_fn
Message-ID: <20200203125346.0000503f@Huawei.com>
In-Reply-To: <20191203034655.51561-9-alastair@au1.ibm.com>
References: <20191203034655.51561-1-alastair@au1.ibm.com>
	<20191203034655.51561-9-alastair@au1.ibm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Message-ID-Hash: ZGV5YN2LHHYA6BIJG4IDJVPCZ4JBLQJH
X-Message-ID-Hash: ZGV5YN2LHHYA6BIJG4IDJVPCZ4JBLQJH
X-MailFrom: jonathan.cameron@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: alastair@d-silva.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Rob Herring  <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>,  Krzysztof Kozlowski  <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan" <maddy@linux.vnet.ibm.com>, "=?ISO-8859-1?Q?C=E9dric?= Le Goater  <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>,  Hari Bathini  <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz" <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger
 .kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZGV5YN2LHHYA6BIJG4IDJVPCZ4JBLQJH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 3 Dec 2019 14:46:36 +1100
Alastair D'Silva <alastair@au1.ibm.com> wrote:

> From: Alastair D'Silva <alastair@d-silva.org>
> 
> This patch retrieves the serial number of the card and makes it available
> to consumers of the ocxl driver via the ocxl_fn struct.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Acked-by: Andrew Donnellan <ajd@linux.ibm.com>
> ---
>  drivers/misc/ocxl/config.c | 46 ++++++++++++++++++++++++++++++++++++++
>  include/misc/ocxl.h        |  1 +
>  2 files changed, 47 insertions(+)
> 
> diff --git a/drivers/misc/ocxl/config.c b/drivers/misc/ocxl/config.c
> index fb0c3b6f8312..a9203c309365 100644
> --- a/drivers/misc/ocxl/config.c
> +++ b/drivers/misc/ocxl/config.c
> @@ -71,6 +71,51 @@ static int find_dvsec_afu_ctrl(struct pci_dev *dev, u8 afu_idx)
>  	return 0;
>  }
>  
> +/**

Make sure anything you mark as kernel doc with /** is valid
kernel-doc.

> + * Find a related PCI device (function 0)
> + * @device: PCI device to match
> + *
> + * Returns a pointer to the related device, or null if not found
> + */
> +static struct pci_dev *get_function_0(struct pci_dev *dev)
> +{
> +	unsigned int devfn = PCI_DEVFN(PCI_SLOT(dev->devfn), 0); // Look for function 0

Not sure the trailing comment adds much.

I'd personally not bother with this wrapper at all and just call
the pci functions directly where needed.

> +
> +	return pci_get_domain_bus_and_slot(pci_domain_nr(dev->bus),
> +					dev->bus->number, devfn);
> +}
> +
> +static void read_serial(struct pci_dev *dev, struct ocxl_fn_config *fn)
> +{
> +	u32 low, high;
> +	int pos;
> +
> +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DSN);
> +	if (pos) {
> +		pci_read_config_dword(dev, pos + 0x04, &low);
> +		pci_read_config_dword(dev, pos + 0x08, &high);
> +
> +		fn->serial = low | ((u64)high) << 32;
> +
> +		return;
> +	}
> +
> +	if (PCI_FUNC(dev->devfn) != 0) {
> +		struct pci_dev *related = get_function_0(dev);
> +
> +		if (!related) {
> +			fn->serial = 0;
> +			return;
> +		}
> +
> +		read_serial(related, fn);
> +		pci_dev_put(related);
> +		return;
> +	}
> +
> +	fn->serial = 0;
> +}
> +
>  static void read_pasid(struct pci_dev *dev, struct ocxl_fn_config *fn)
>  {
>  	u16 val;
> @@ -208,6 +253,7 @@ int ocxl_config_read_function(struct pci_dev *dev, struct ocxl_fn_config *fn)
>  	int rc;
>  
>  	read_pasid(dev, fn);
> +	read_serial(dev, fn);
>  
>  	rc = read_dvsec_tl(dev, fn);
>  	if (rc) {
> diff --git a/include/misc/ocxl.h b/include/misc/ocxl.h
> index 6f7c02f0d5e3..9843051c3c5b 100644
> --- a/include/misc/ocxl.h
> +++ b/include/misc/ocxl.h
> @@ -46,6 +46,7 @@ struct ocxl_fn_config {
>  	int dvsec_afu_info_pos; /* offset of the AFU information DVSEC */
>  	s8 max_pasid_log;
>  	s8 max_afu_index;
> +	u64 serial;
>  };
>  
>  enum ocxl_endian {

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

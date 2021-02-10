Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E1F316C82
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Feb 2021 18:24:16 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 820CD100EA903;
	Wed, 10 Feb 2021 09:24:14 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.176.79.56; helo=frasgout.his.huawei.com; envelope-from=jonathan.cameron@huawei.com; receiver=<UNKNOWN> 
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BFF41100EA902
	for <linux-nvdimm@lists.01.org>; Wed, 10 Feb 2021 09:24:11 -0800 (PST)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.206])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DbRK86P3Bz67mKc;
	Thu, 11 Feb 2021 01:17:32 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 10 Feb 2021 18:24:08 +0100
Received: from localhost (10.47.67.2) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 10 Feb
 2021 17:24:07 +0000
Date: Wed, 10 Feb 2021 17:23:07 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH v2 1/8] cxl/mem: Introduce a driver for CXL-2.0-Type-3
 endpoints
Message-ID: <20210210172307.000020d5@Huawei.com>
In-Reply-To: <20210210171220.67bncvfxqwg5wtu4@intel.com>
References: <20210210000259.635748-1-ben.widawsky@intel.com>
	<20210210000259.635748-2-ben.widawsky@intel.com>
	<20210210161707.000073ab@Huawei.com>
	<20210210171220.67bncvfxqwg5wtu4@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.47.67.2]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Message-ID-Hash: PUC4GJ4IM77AZWZZIKRGABKBI6R5MJT5
X-Message-ID-Hash: PUC4GJ4IM77AZWZZIKRGABKBI6R5MJT5
X-MailFrom: jonathan.cameron@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, "Chris Browy  <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>,  Dan Williams  <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, David Rientjes" <rientjes@google.com>, "Jon Masters  <jcm@jonmasters.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap" <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>, Jonathan Corbet <corbet@lwn.net>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PUC4GJ4IM77AZWZZIKRGABKBI6R5MJT5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 10 Feb 2021 09:12:20 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

...
   
> > > +}
> > > +
> > > +static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > > +{
> > > +	struct device *dev = &pdev->dev;
> > > +	int regloc;
> > > +
> > > +	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_OFFSET);
> > > +	if (!regloc) {
> > > +		dev_err(dev, "register location dvsec not found\n");
> > > +		return -ENXIO;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct pci_device_id cxl_mem_pci_tbl[] = {
> > > +	/* PCI class code for CXL.mem Type-3 Devices */
> > > +	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> > > +	  PCI_CLASS_MEMORY_CXL << 8 | CXL_MEMORY_PROGIF, 0xffffff, 0 },  
> > 
> > Having looked at this and thought 'thats a bit tricky to check'
> > I did a quick grep and seems the kernel is split between this approach
> > and people going with the mor readable c99 style initiators
> > 	.class = .. etc
> > 
> > Personally I'd find the c99 approach easier to read. 
> >   
> 
> Well, it's Dan's patch, but I did modify this last. I took a look around, and
> the best fit seems to me seems to be:
> -       { PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> -         PCI_CLASS_MEMORY_CXL << 8 | CXL_MEMORY_PROGIF, 0xffffff, 0 },
> +       { PCI_DEVICE_CLASS((PCI_CLASS_MEMORY_CXL << 8 | CXL_MEMORY_PROGIF), ~0)},
> 
> That work for you?
> 

Yes that's definitely nicer.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

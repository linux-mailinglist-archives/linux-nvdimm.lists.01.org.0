Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92717319FE7
	for <lists+linux-nvdimm@lfdr.de>; Fri, 12 Feb 2021 14:34:14 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B5167100EA2DD;
	Fri, 12 Feb 2021 05:34:12 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.176.79.56; helo=frasgout.his.huawei.com; envelope-from=jonathan.cameron@huawei.com; receiver=<UNKNOWN> 
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D8B98100EA2D9
	for <linux-nvdimm@lists.01.org>; Fri, 12 Feb 2021 05:34:09 -0800 (PST)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.206])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DcZB80s6bz67mLJ;
	Fri, 12 Feb 2021 21:30:24 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 12 Feb 2021 14:34:07 +0100
Received: from localhost (10.47.28.230) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 12 Feb
 2021 13:34:06 +0000
Date: Fri, 12 Feb 2021 13:33:04 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 3/8] cxl/mem: Register CXL memX devices
Message-ID: <20210212133304.00001f28@Huawei.com>
In-Reply-To: <CAPcyv4hgzv7B7sv85A3No-bAgeADqfrhRySBrQBx43HVEMfnzg@mail.gmail.com>
References: <20210210000259.635748-1-ben.widawsky@intel.com>
	<20210210000259.635748-4-ben.widawsky@intel.com>
	<20210210181725.00007865@Huawei.com>
	<20210211101746.00005e8c@Huawei.com>
	<CAPcyv4hgzv7B7sv85A3No-bAgeADqfrhRySBrQBx43HVEMfnzg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.47.28.230]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Message-ID-Hash: 7FZWL2N3PSRQDEDQV3QK4W47YPEAHPPF
X-Message-ID-Hash: 7FZWL2N3PSRQDEDQV3QK4W47YPEAHPPF
X-MailFrom: jonathan.cameron@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org, "Linux ACPI  <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, Jon Masters <jcm@jonmasters.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7FZWL2N3PSRQDEDQV3QK4W47YPEAHPPF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 11 Feb 2021 12:40:45 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> On Thu, Feb 11, 2021 at 2:19 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Wed, 10 Feb 2021 18:17:25 +0000
> > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> >  
> > > On Tue, 9 Feb 2021 16:02:54 -0800
> > > Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >  
> > > > From: Dan Williams <dan.j.williams@intel.com>
> > > >
> > > > Create the /sys/bus/cxl hierarchy to enumerate:
> > > >
> > > > * Memory Devices (per-endpoint control devices)
> > > >
> > > > * Memory Address Space Devices (platform address ranges with
> > > >   interleaving, performance, and persistence attributes)
> > > >
> > > > * Memory Regions (active provisioned memory from an address space device
> > > >   that is in use as System RAM or delegated to libnvdimm as Persistent
> > > >   Memory regions).
> > > >
> > > > For now, only the per-endpoint control devices are registered on the
> > > > 'cxl' bus. However, going forward it will provide a mechanism to
> > > > coordinate cross-device interleave.
> > > >
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>  
> > >
> > > One stray header, and a request for a tiny bit of reordering to
> > > make it easier to chase through creation and destruction.
> > >
> > > Either way with the header move to earlier patch I'm fine with this one.
> > >
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> >
> > Actually thinking more on this, what is the justification for the
> > complexity + overhead of a percpu_refcount vs a refcount  
> 
> A typical refcount does not have the block and drain semantics of a
> percpu_ref. I'm planning to circle back and make this a first class
> facility of the cdev interface borrowing the debugfs approach [1], but
> for now percpu_ref fits the bill locally.
> 
> > I don't think this is a high enough performance path for it to matter.
> > Perhaps I'm missing a usecase where it does?  
> 
> It's less about percpu_ref performance and more about the
> percpu_ref_tryget_live() facility.
> 
> [1]: http://lore.kernel.org/r/CAPcyv4jEYPsyh0bhbtKGRbK3bgp=_+=2rjx4X0gLi5-25VvDyg@mail.gmail.com

Thanks for the reference. Definitely a nasty corner to clean up so I'll
keep an eye open for a new version of that series.

Jonathan

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D6D3187A6
	for <lists+linux-nvdimm@lfdr.de>; Thu, 11 Feb 2021 11:02:58 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 90C3D100EA929;
	Thu, 11 Feb 2021 02:02:57 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.176.79.56; helo=frasgout.his.huawei.com; envelope-from=jonathan.cameron@huawei.com; receiver=<UNKNOWN> 
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9B349100EBB6A
	for <linux-nvdimm@lists.01.org>; Thu, 11 Feb 2021 02:02:55 -0800 (PST)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.206])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DbsWS2GH8z67mBT;
	Thu, 11 Feb 2021 17:57:56 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 11 Feb 2021 11:02:53 +0100
Received: from localhost (10.47.31.44) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Thu, 11 Feb
 2021 10:02:52 +0000
Date: Thu, 11 Feb 2021 10:01:52 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 2/8] cxl/mem: Find device capabilities
Message-ID: <20210211100152.00000667@Huawei.com>
In-Reply-To: <CAPcyv4i4_6HLNpw7p-1PD9cePuMuPkvUfx0ROT8M0Y7ftxzYfg@mail.gmail.com>
References: <20210210000259.635748-1-ben.widawsky@intel.com>
	<20210210000259.635748-3-ben.widawsky@intel.com>
	<20210210174104.0000710a@Huawei.com>
	<20210210185319.chharluce2ly4cne@intel.com>
	<CAPcyv4i4_6HLNpw7p-1PD9cePuMuPkvUfx0ROT8M0Y7ftxzYfg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.47.31.44]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Message-ID-Hash: KGDBUQ4JG6NCUWH7PWN4AFUQCL6U5QDH
X-Message-ID-Hash: KGDBUQ4JG6NCUWH7PWN4AFUQCL6U5QDH
X-MailFrom: jonathan.cameron@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org, "Linux ACPI  <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, Jon Masters <jcm@jonmasters.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KGDBUQ4JG6NCUWH7PWN4AFUQCL6U5QDH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 10 Feb 2021 11:54:29 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> > > ...
> > >  
> > > > +static void cxl_mem_mbox_timeout(struct cxl_mem *cxlm,
> > > > +                            struct mbox_cmd *mbox_cmd)
> > > > +{
> > > > +   struct device *dev = &cxlm->pdev->dev;
> > > > +
> > > > +   dev_dbg(dev, "Mailbox command (opcode: %#x size: %zub) timed out\n",
> > > > +           mbox_cmd->opcode, mbox_cmd->size_in);
> > > > +
> > > > +   if (IS_ENABLED(CONFIG_CXL_MEM_INSECURE_DEBUG)) {  
> > >
> > > Hmm.  Whilst I can see the advantage of this for debug, I'm not sure we want
> > > it upstream even under a rather evil looking CONFIG variable.
> > >
> > > Is there a bigger lock we can use to avoid chance of accidental enablement?  
> >
> > Any suggestions? I'm told this functionality was extremely valuable for NVDIMM,
> > though I haven't personally experienced it.  
> 
> Yeah, there was no problem with the identical mechanism in LIBNVDIMM
> land. However, I notice that the useful feature for LIBNVDIMM is the
> option to dump all payloads. This one only fires on timeouts which is
> less useful. So I'd say fix it to dump all payloads on the argument
> that the safety mechanism was proven with the LIBNVDIMM precedent, or
> delete it altogether to maintain v5.12 momentum. Payload dumping can
> be added later.

I think I'd drop it for now - feels like a topic that needs more discussion.

Also, dumping this data to the kernel log isn't exactly elegant - particularly
if we dump a lot more of it.  Perhaps tracepoints?

> 
> [..]
> > > > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > > > index e709ae8235e7..6267ca9ae683 100644
> > > > --- a/include/uapi/linux/pci_regs.h
> > > > +++ b/include/uapi/linux/pci_regs.h
> > > > @@ -1080,6 +1080,7 @@
> > > >
> > > >  /* Designated Vendor-Specific (DVSEC, PCI_EXT_CAP_ID_DVSEC) */
> > > >  #define PCI_DVSEC_HEADER1          0x4 /* Designated Vendor-Specific Header1 */
> > > > +#define PCI_DVSEC_HEADER1_LENGTH_MASK      0xFFF00000  
> > >
> > > Seems sensible to add the revision mask as well.
> > > The vendor id currently read using a word read rather than dword, but perhaps
> > > neater to add that as well for completeness?
> > >
> > > Having said that, given Bjorn's comment on clashes and the fact he'd rather see
> > > this stuff defined in drivers and combined later (see review patch 1 and follow
> > > the link) perhaps this series should not touch this header at all.  
> >
> > I'm fine to move it back.  
> 
> Yeah, we're playing tennis now between Bjorn's and Christoph's
> comments, but I like Bjorn's suggestion of "deduplicate post merge"
> given the bloom of DVSEC infrastructure landing at the same time.
I guess it may depend on timing of this.  Personally I think 5.12 may be too aggressive.

As long as Bjorn can take a DVSEC deduplication as an immutable branch then perhaps
during 5.13 this tree can sit on top of that.

Jonathan

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

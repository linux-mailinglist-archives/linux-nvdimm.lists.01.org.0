Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F510318F5B
	for <lists+linux-nvdimm@lfdr.de>; Thu, 11 Feb 2021 17:05:52 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7372B100EA92F;
	Thu, 11 Feb 2021 08:05:49 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7ADDA100EBB86
	for <linux-nvdimm@lists.01.org>; Thu, 11 Feb 2021 08:05:46 -0800 (PST)
IronPort-SDR: qoC0cCfaa6OcP/waSN1Oxi6A2rY8bN51k7EvjbIRb5hb/X0+zzImwWGCEF+BCEUWshzQjE14PR
 SLmBit3lkS5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="243757244"
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400";
   d="scan'208";a="243757244"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 08:04:38 -0800
IronPort-SDR: kQh2KysLd/vC5jPu93cDLmW2HWsnxnA1xndKMfK9uDSK6541kBYwVPYGyGzq2NHqFypOeB95A0
 PL7J7I7hj0MA==
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400";
   d="scan'208";a="380716457"
Received: from reknight-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.134.254])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 08:04:37 -0800
Date: Thu, 11 Feb 2021 08:04:36 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 2/8] cxl/mem: Find device capabilities
Message-ID: <20210211160436.qbvgfzqng37erwae@intel.com>
References: <20210210000259.635748-1-ben.widawsky@intel.com>
 <20210210000259.635748-3-ben.widawsky@intel.com>
 <20210210174104.0000710a@Huawei.com>
 <20210210185319.chharluce2ly4cne@intel.com>
 <CAPcyv4i4_6HLNpw7p-1PD9cePuMuPkvUfx0ROT8M0Y7ftxzYfg@mail.gmail.com>
 <20210211100152.00000667@Huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210211100152.00000667@Huawei.com>
Message-ID-Hash: FIEBO4TOIJA5KGCIRXPVYOW3N3WDNS6E
X-Message-ID-Hash: FIEBO4TOIJA5KGCIRXPVYOW3N3WDNS6E
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, Jon Masters <jcm@jonmasters.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <>
List-Archive: <>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21-02-11 10:01:52, Jonathan Cameron wrote:
> On Wed, 10 Feb 2021 11:54:29 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > > > ...
> > > >  
> > > > > +static void cxl_mem_mbox_timeout(struct cxl_mem *cxlm,
> > > > > +                            struct mbox_cmd *mbox_cmd)
> > > > > +{
> > > > > +   struct device *dev = &cxlm->pdev->dev;
> > > > > +
> > > > > +   dev_dbg(dev, "Mailbox command (opcode: %#x size: %zub) timed out\n",
> > > > > +           mbox_cmd->opcode, mbox_cmd->size_in);
> > > > > +
> > > > > +   if (IS_ENABLED(CONFIG_CXL_MEM_INSECURE_DEBUG)) {  
> > > >
> > > > Hmm.  Whilst I can see the advantage of this for debug, I'm not sure we want
> > > > it upstream even under a rather evil looking CONFIG variable.
> > > >
> > > > Is there a bigger lock we can use to avoid chance of accidental enablement?  
> > >
> > > Any suggestions? I'm told this functionality was extremely valuable for NVDIMM,
> > > though I haven't personally experienced it.  
> > 
> > Yeah, there was no problem with the identical mechanism in LIBNVDIMM
> > land. However, I notice that the useful feature for LIBNVDIMM is the
> > option to dump all payloads. This one only fires on timeouts which is
> > less useful. So I'd say fix it to dump all payloads on the argument
> > that the safety mechanism was proven with the LIBNVDIMM precedent, or
> > delete it altogether to maintain v5.12 momentum. Payload dumping can
> > be added later.
> 
> I think I'd drop it for now - feels like a topic that needs more discussion.
> 
> Also, dumping this data to the kernel log isn't exactly elegant - particularly
> if we dump a lot more of it.  Perhaps tracepoints?
> 

I'll drop it. It's also a small enough bit to add on for developers. When I post
v3, I will add that bit on top as an RFC. My personal preference FWIW is to use
debugfs to store the payload of the last executed command.

We went with this because of the mechanism's provenance (libnvdimm)

> > 
> > [..]
> > > > > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > > > > index e709ae8235e7..6267ca9ae683 100644
> > > > > --- a/include/uapi/linux/pci_regs.h
> > > > > +++ b/include/uapi/linux/pci_regs.h
> > > > > @@ -1080,6 +1080,7 @@
> > > > >
> > > > >  /* Designated Vendor-Specific (DVSEC, PCI_EXT_CAP_ID_DVSEC) */
> > > > >  #define PCI_DVSEC_HEADER1          0x4 /* Designated Vendor-Specific Header1 */
> > > > > +#define PCI_DVSEC_HEADER1_LENGTH_MASK      0xFFF00000  
> > > >
> > > > Seems sensible to add the revision mask as well.
> > > > The vendor id currently read using a word read rather than dword, but perhaps
> > > > neater to add that as well for completeness?
> > > >
> > > > Having said that, given Bjorn's comment on clashes and the fact he'd rather see
> > > > this stuff defined in drivers and combined later (see review patch 1 and follow
> > > > the link) perhaps this series should not touch this header at all.  
> > >
> > > I'm fine to move it back.  
> > 
> > Yeah, we're playing tennis now between Bjorn's and Christoph's
> > comments, but I like Bjorn's suggestion of "deduplicate post merge"
> > given the bloom of DVSEC infrastructure landing at the same time.
> I guess it may depend on timing of this.  Personally I think 5.12 may be too aggressive.
> 
> As long as Bjorn can take a DVSEC deduplication as an immutable branch then perhaps
> during 5.13 this tree can sit on top of that.
> 
> Jonathan
> 
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

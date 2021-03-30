Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A51D34ECD2
	for <lists+linux-nvdimm@lfdr.de>; Tue, 30 Mar 2021 17:43:24 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 93D22100EB839;
	Tue, 30 Mar 2021 08:43:21 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=13.77.154.182; helo=linux.microsoft.com; envelope-from=tyhicks@linux.microsoft.com; receiver=<UNKNOWN> 
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by ml01.01.org (Postfix) with ESMTP id 2C45A100EB835
	for <linux-nvdimm@lists.01.org>; Tue, 30 Mar 2021 08:43:18 -0700 (PDT)
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3BCFB20B5680;
	Tue, 30 Mar 2021 08:43:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3BCFB20B5680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1617118997;
	bh=Ex/hhLMgEI8y3lLUNawbT4uibtJe9r185X98zTx9OpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fbxuq7OjRALgIqrYnzNwxEn3DruP91PxGjvmVvQMXcFA5ZrGr/IQpPOPutFhR8y2z
	 DG17Q0Rg0FvbzATQeKVAy0s3sPXOhb2vlXCFT0SCBir2g3IrhJpFHsvLSjyz/mtpAc
	 2vXBQQ8SMF2LfFjxTjQv/8YZTcrPi2EOXBU+3Qf0=
Date: Tue, 30 Mar 2021 10:43:15 -0500
From: Tyler Hicks <tyhicks@linux.microsoft.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] libnvdimm/region: Allow setting align attribute on
 regions without mappings
Message-ID: <20210330154315.GD4749@sequoia>
References: <20210326152645.85225-1-tyhicks@linux.microsoft.com>
 <87h7ks7vm5.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87h7ks7vm5.fsf@linux.ibm.com>
Message-ID-Hash: 5LOGXTLTBVB7XEBISVBUEQ6AZ3RUIEBY
X-Message-ID-Hash: 5LOGXTLTBVB7XEBISVBUEQ6AZ3RUIEBY
X-MailFrom: tyhicks@linux.microsoft.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Pavel Tatashin <pasha.tatashin@soleen.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5LOGXTLTBVB7XEBISVBUEQ6AZ3RUIEBY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2021-03-30 16:32:10, Aneesh Kumar K.V wrote:
> Tyler Hicks <tyhicks@linux.microsoft.com> writes:
> 
> > The alignment constraint for namespace creation in a region was
> > increased, from 2M to 16M, for non-PowerPC architectures in v5.7 with
> > commit 2522afb86a8c ("libnvdimm/region: Introduce an 'align'
> > attribute"). The thought behind the change was that region alignment
> > should be uniform across all architectures and, since PowerPC had the
> > largest alignment constraint of 16M, all architectures should conform to
> > that alignment.
> >
> > The change regressed namespace creation in pre-defined regions that
> > relied on 2M alignment but a workaround was provided in the form of a
> > sysfs attribute, named 'align', that could be adjusted to a non-default
> > alignment value.
> >
> > However, the sysfs attribute's store function returned an error (-ENXIO)
> > when userspace attempted to change the alignment of a region that had no
> > mappings. This affected 2M aligned regions of volatile memory that were
> > defined in a device tree using "pmem-region" and created by the
> > of_pmem_region_driver, since those regions do not contain mappings
> > (ndr_mappings is 0).
> >
> > Allow userspace to set the align attribute on pre-existing regions that
> > do not have mappings so that namespaces can still be within those
> > regions, despite not being aligned to 16M.
> >
> > Fixes: 2522afb86a8c ("libnvdimm/region: Introduce an 'align' attribute")
> > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > ---
> >  drivers/nvdimm/region_devs.c | 33 ++++++++++++++++++---------------
> >  1 file changed, 18 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> > index ef23119db574..09cff8aa6b40 100644
> > --- a/drivers/nvdimm/region_devs.c
> > +++ b/drivers/nvdimm/region_devs.c
> > @@ -545,29 +545,32 @@ static ssize_t align_store(struct device *dev,
> >  		struct device_attribute *attr, const char *buf, size_t len)
> >  {
> >  	struct nd_region *nd_region = to_nd_region(dev);
> > -	unsigned long val, dpa;
> > -	u32 remainder;
> > +	unsigned long val;
> >  	int rc;
> >  
> >  	rc = kstrtoul(buf, 0, &val);
> >  	if (rc)
> >  		return rc;
> >  
> > -	if (!nd_region->ndr_mappings)
> > -		return -ENXIO;
> > -
> > -	/*
> > -	 * Ensure space-align is evenly divisible by the region
> > -	 * interleave-width because the kernel typically has no facility
> > -	 * to determine which DIMM(s), dimm-physical-addresses, would
> > -	 * contribute to the tail capacity in system-physical-address
> > -	 * space for the namespace.
> > -	 */
> > -	dpa = div_u64_rem(val, nd_region->ndr_mappings, &remainder);
> > -	if (!is_power_of_2(dpa) || dpa < PAGE_SIZE
> > -			|| val > region_size(nd_region) || remainder)
> > +	if (val > region_size(nd_region))
> >  		return -EINVAL;
> >  
> > +	if (nd_region->ndr_mappings) {
> > +		unsigned long dpa;
> > +		u32 remainder;
> > +
> > +		/*
> > +		 * Ensure space-align is evenly divisible by the region
> > +		 * interleave-width because the kernel typically has no facility
> > +		 * to determine which DIMM(s), dimm-physical-addresses, would
> > +		 * contribute to the tail capacity in system-physical-address
> > +		 * space for the namespace.
> > +		 */
> > +		dpa = div_u64_rem(val, nd_region->ndr_mappings, &remainder);
> > +		if (!is_power_of_2(dpa) || dpa < PAGE_SIZE || remainder)
> > +			return -EINVAL;
> > +	}
> 
> We still want
> 
> else {
> 
> if (!is_power_of_2(val) || val < PAGE_SIZE)
>          return -EINVAL?

Yes, very good point. I'll send out a v2 that ensures val is a power of
2 and at least page size.

Tyler

> 
> }
> > +
> >  	/*
> >  	 * Given that space allocation consults this value multiple
> >  	 * times ensure it does not change for the duration of the
> > -- 
> > 2.25.1
> > _______________________________________________
> > Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> > To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

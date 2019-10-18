Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D397DDCC73
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Oct 2019 19:18:40 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C8D5D10FC6E2D;
	Fri, 18 Oct 2019 10:20:45 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C36D710FC6E2C
	for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 10:20:43 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2019 10:18:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,312,1566889200";
   d="scan'208";a="371526850"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga005.jf.intel.com with ESMTP; 18 Oct 2019 10:18:35 -0700
Received: from fmsmsx157.amr.corp.intel.com (10.18.116.73) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 18 Oct 2019 10:18:35 -0700
Received: from fmsmsx114.amr.corp.intel.com ([169.254.6.30]) by
 FMSMSX157.amr.corp.intel.com ([169.254.14.192]) with mapi id 14.03.0439.000;
 Fri, 18 Oct 2019 10:18:35 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>, "Williams, Dan
 J" <dan.j.williams@intel.com>
Subject: Re: [PATCH] ndctl: Use the same align value as original namespace
 on reconfigure
Thread-Topic: [PATCH] ndctl: Use the same align value as original namespace
 on reconfigure
Thread-Index: AQHVTNrZ/ZRQIHs7z0GsAswmqKqShKcP47MAgAECIQCAUDJ5AIAAc3oA
Date: Fri, 18 Oct 2019 17:18:34 +0000
Message-ID: <4fa50f9c397533f9a615d59af8dd268106a7425e.camel@intel.com>
References: <20190807044416.30799-1-aneesh.kumar@linux.ibm.com>
	 <a6f0635109d75489144bd1b5985e8da44110b01b.camel@intel.com>
	 <87o909oca1.fsf@linux.ibm.com> <87d0eufj03.fsf@linux.ibm.com>
In-Reply-To: <87d0eufj03.fsf@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.164]
Content-ID: <12C9365D824DE2428ACFB59D8230052A@intel.com>
MIME-Version: 1.0
Message-ID-Hash: RQ3WA2VWVMC76MQUQPMARXMN5SZQAQZO
X-Message-ID-Hash: RQ3WA2VWVMC76MQUQPMARXMN5SZQAQZO
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RQ3WA2VWVMC76MQUQPMARXMN5SZQAQZO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Fri, 2019-10-18 at 15:55 +0530, Aneesh Kumar K.V wrote:
> Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com> writes:
> 
> > "Verma, Vishal L" <vishal.l.verma@intel.com> writes:
> > 
> > > On Wed, 2019-08-07 at 10:14 +0530, Aneesh Kumar K.V wrote:
> > > > When using reconfigure command to add a `name` to the namespace we end
> > > > up updating the align attribute. Avoid this by using the value from
> > > > the original namespace. Do this only if we are keeping the namespace mode
> > > > same.
> > > > 
> > > > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > > > ---
> > > >  ndctl/namespace.c | 16 ++++++++++++++++
> > > >  1 file changed, 16 insertions(+)
> > > 
> > > Hi Aneesh,
> > > 
> > > A few comments below:
> > > 
> > > > diff --git a/ndctl/namespace.c b/ndctl/namespace.c
> > > > index 1f212a2b3a9b..24e51bb35ae1 100644
> > > > --- a/ndctl/namespace.c
> > > > +++ b/ndctl/namespace.c
> > > > @@ -596,6 +596,22 @@ static int validate_namespace_options(struct ndctl_region *region,
> > > >  			return -ENXIO;
> > > >  		}
> > > >  	} else {
> > > > +
> > > > +		/*
> > > > +		 * If we are tryint to reconfigure with the same namespace mode
> > > 
> > >                              ^trying
> > > 
> > > > +		 * Use the align details from the origin namespace. Otherwise
> > > 
> > > s/origin/original/
> > > 
> > > > +		 * pick the align details from seed namespace
> > > > +		 */
> > > > +		if (ndns && p->mode == ndctl_namespace_get_mode(ndns)) {
> > > 
> > > Do we need to depend on the mode here?
> > > 
> > > I'm thinking it should be sufficient to do:
> > >   1. Check We're in 'reconfigure'
> > >   2. Check param.align was not supplied
> > >   3. Get alignment from the pfn/dax personality, and just use that.
> > > 
> > > Does this make sense (Maybe I'm missing something).
> > 
> > We want to use the align value from the seed when we are trying
> > to reconfigure a namespace with a different mode. ie, if we are moving a
> > fsdax namespace with align value 64K to a devdax, IMHO we should pick 16M
> > as alignment for devdax.
> > 
> > > > +			struct ndctl_pfn *ns_pfn = ndctl_namespace_get_pfn(ndns);
> > > > +			struct ndctl_dax *ns_dax = ndctl_namespace_get_dax(ndns);
> > > > +			if (ns_pfn)
> > > > +				p->align = ndctl_pfn_get_align(ns_pfn);
> > > > +			else if (ns_dax)
> > > > +				p->align = ndctl_dax_get_align(ns_dax);
> > > > +			else
> > > > +				p->align = sysconf(_SC_PAGE_SIZE);
> > > 
> > > Do we need the page size fallback here - there are other checks after
> > > this point that also do a similar fallback, do they not catch the
> > > default case?
> > 
> > I did that to simplify the code with that `else if`  
> > 
> > > > +		} else
> > > >  		/*
> > > >  		 * Use the seed namespace alignment as the default if we need
> > > >  		 * one. If we don't then use PAGE_SIZE so the size_align
> 
> Any update on this.?

Yes - I've applied it to the pending branch, and it will be in v67.


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

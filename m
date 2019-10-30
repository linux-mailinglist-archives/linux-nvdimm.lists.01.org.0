Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59781EA7DF
	for <lists+linux-nvdimm@lfdr.de>; Thu, 31 Oct 2019 00:39:37 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D6B3E100EA553;
	Wed, 30 Oct 2019 16:40:07 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EEC64100EEBB6
	for <linux-nvdimm@lists.01.org>; Wed, 30 Oct 2019 16:40:05 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2019 16:39:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,248,1569308400";
   d="scan'208";a="204030495"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga006.jf.intel.com with ESMTP; 30 Oct 2019 16:39:32 -0700
Received: from fmsmsx157.amr.corp.intel.com (10.18.116.73) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 30 Oct 2019 16:39:32 -0700
Received: from fmsmsx114.amr.corp.intel.com ([169.254.6.30]) by
 FMSMSX157.amr.corp.intel.com ([169.254.14.192]) with mapi id 14.03.0439.000;
 Wed, 30 Oct 2019 16:39:32 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>, "Williams, Dan
 J" <dan.j.williams@intel.com>
Subject: Re: [PATCH] Consider namespace with size as active namespace
Thread-Topic: [PATCH] Consider namespace with size as active namespace
Thread-Index: AQHVTNoevSJkuNOO50uoHLwICBXdRqdevqaAgABMUQCAFcc7gA==
Date: Wed, 30 Oct 2019 23:39:31 +0000
Message-ID: <211de3f5c7eafcdd64301954db2382888b7e9982.camel@intel.com>
References: <20190807043915.30239-1-aneesh.kumar@linux.ibm.com>
	 <73abe6519435d3c0cfab32633c969b5efe16c0e4.camel@intel.com>
	 <269a4c1c-f1c5-6b18-3482-a9640d0a816b@linux.ibm.com>
In-Reply-To: <269a4c1c-f1c5-6b18-3482-a9640d0a816b@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.164]
Content-ID: <7BCC9E34AFDE9C47A1AFD52CB8285FEB@intel.com>
MIME-Version: 1.0
Message-ID-Hash: WQ4ZGM7ADMK4O7362VXL2UKNTBN57V6N
X-Message-ID-Hash: WQ4ZGM7ADMK4O7362VXL2UKNTBN57V6N
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WQ4ZGM7ADMK4O7362VXL2UKNTBN57V6N/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2019-10-17 at 08:35 +0530, Aneesh Kumar K.V wrote:
> 
> > > ---
> > >   ndctl/namespace.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/ndctl/namespace.c b/ndctl/namespace.c
> > > index 58a9e3c53474..1f212a2b3a9b 100644
> > > --- a/ndctl/namespace.c
> > > +++ b/ndctl/namespace.c
> > > @@ -455,7 +455,8 @@ static int is_namespace_active(struct ndctl_namespace *ndns)
> > >   	return ndns && (ndctl_namespace_is_enabled(ndns)
> > >   		|| ndctl_namespace_get_pfn(ndns)
> > >   		|| ndctl_namespace_get_dax(ndns)
> > > -		|| ndctl_namespace_get_btt(ndns));
> > > +		|| ndctl_namespace_get_btt(ndns)
> > > +		|| ndctl_namespace_get_size(ndns));
> > >   }
> > >   
> > >   /*
[..]
> 
> > The failing unit tests are sector-mode.sh and dax.sh
> > 
> 
> I will see if i can run them on ppc64. We still had issues in getting 
> ndctl check to be running on ppc64.
> 

I dug into this a bit more.

The failure happens on 'legacy' namespaces (ND_DEVICE_NAMESPACE_IO).

There is an assumption that legacy namespaces cannot be fully deleted,
so as part of a reconfigure, when it comes time to delete the namespace
(ndctl_namespace_delete()), we refuse to do that, and bail, before
setting the size to zero.

libndctl.c:4467

	case ND_DEVICE_NAMESPACE_BLK:
		break;
	default:
		dbg(ctx, "%s: nstype: %d not deletable\n",
				ndctl_namespace_get_devname(ndns),
				ndctl_namespace_get_type(ndns));
		return 0;
	}

	rc = namespace_set_size(ndns, 0);
...

Indeed, destroy namespace wouldn't even get to that point, because that
assumption is repeated in namespace_destroy(), where we switch on
namespace type, and potentially skip over the ndctl_namespace_destroy
call entirely.

If setting the size to zero is now significant we'd need to rework both
of these sites. In destroy_namespace(), delay the did_zero checking
until after ndctl_namespace_delete(), and in ndctl_namespace_delete(),
set the size to zero before the type check.

Dan, does the above make sense - was there reason to refrain from
touching the size on legacy namespaces?

	-Vishal
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

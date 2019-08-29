Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C55F2A22F4
	for <lists+linux-nvdimm@lfdr.de>; Thu, 29 Aug 2019 20:05:07 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7464E2021DD44;
	Thu, 29 Aug 2019 11:06:58 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.93; helo=mga11.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B177720218C5B
 for <linux-nvdimm@lists.01.org>; Thu, 29 Aug 2019 11:06:57 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Aug 2019 11:05:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,444,1559545200"; d="scan'208";a="182419969"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga007.fm.intel.com with ESMTP; 29 Aug 2019 11:05:04 -0700
Received: from FMSMSX109.amr.corp.intel.com (10.18.116.9) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 29 Aug 2019 11:05:02 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.127]) by
 FMSMSX109.amr.corp.intel.com ([169.254.15.42]) with mapi id 14.03.0439.000;
 Thu, 29 Aug 2019 11:05:02 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH 3/3] ndctl/namespace: add a --continue option to
 create namespaces greedily
Thread-Topic: [ndctl PATCH 3/3] ndctl/namespace: add a --continue option to
 create namespaces greedily
Thread-Index: AQHVXf8uIV6SmGbMik61vVYfKtf7O6cR3gCAgAED54A=
Date: Thu, 29 Aug 2019 18:05:01 +0000
Message-ID: <44b020035e3245084b2310cfdfe496853e2cf18d.camel@intel.com>
References: <20190829001735.30289-1-vishal.l.verma@intel.com>
 <20190829001735.30289-4-vishal.l.verma@intel.com>
 <CAPcyv4gB-2hkPM=zKCigpDAUxQbzWFVRmZ=UnTF0wsBW3-nmsQ@mail.gmail.com>
In-Reply-To: <CAPcyv4gB-2hkPM=zKCigpDAUxQbzWFVRmZ=UnTF0wsBW3-nmsQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-ID: <DE2CD2E7813904448671A82F190A8EE3@intel.com>
MIME-Version: 1.0
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: "Scargall, Steve" <steve.scargall@intel.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, 2019-08-28 at 19:34 -0700, Dan Williams wrote:
> On Wed, Aug 28, 2019 at 5:17 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
> > Add a --continue option to ndctl-create-namespaces to allow the creation
> > of as many namespaces as possible, that meet the given filter
> > restrictions.
> > 
> > The creation loop will be aborted if a failure is encountered at any
> > point.
> > 
> > Link: https://github.com/pmem/ndctl/issues/106
> > Reported-by: Steve Scargal <steve.scargall@intel.com>
> > Cc: Jeff Moyer <jmoyer@redhat.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> > ---
> >  .../ndctl/ndctl-create-namespace.txt          |  7 ++++++
> >  ndctl/namespace.c                             | 25 +++++++++++++++----
> >  2 files changed, 27 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/ndctl/ndctl-create-namespace.txt b/Documentation/ndctl/ndctl-create-namespace.txt
> > index c9ae27c..55a8581 100644
> > --- a/Documentation/ndctl/ndctl-create-namespace.txt
> > +++ b/Documentation/ndctl/ndctl-create-namespace.txt
> > @@ -215,6 +215,13 @@ include::xable-region-options.txt[]
> >  --bus=::
> >  include::xable-bus-options.txt[]
> > 
> > +-c::
> > +--continue::
> > +       Do not stop after creating one namespace. Instead, greedily create as
> 
> I like the "greedy" terminology here because it makes the option seem
> a bit off-putting. "Do you really want to be greedy?"

Ha, I just borrowed it from regular expressions :)

> 
> > +       many namespaces as possible within the given --bus and --region filter
> > +       restrictions. This will abort if any creation attempt results in an
> > +       error.
> 
> Hmm, should "--continue --force" override that policy?

Yep that's a good idea, with a big note in the man page that errors
could be lost/meaningless in that case.

> 
> Otherwise this looks good to me.

Thanks, I'll send a new version with the above.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

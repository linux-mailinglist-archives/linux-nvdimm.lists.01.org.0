Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB572164F71
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Feb 2020 21:01:57 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4A1E510FC341C;
	Wed, 19 Feb 2020 12:02:48 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C5F1910FC3412
	for <linux-nvdimm@lists.01.org>; Wed, 19 Feb 2020 12:02:45 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2020 12:01:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,461,1574150400";
   d="scan'208";a="408549717"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga005.jf.intel.com with ESMTP; 19 Feb 2020 12:01:52 -0800
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 19 Feb 2020 12:01:52 -0800
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.48]) by
 FMSMSX114.amr.corp.intel.com ([169.254.6.55]) with mapi id 14.03.0439.000;
 Wed, 19 Feb 2020 12:01:51 -0800
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "jmoyer@redhat.com"
	<jmoyer@redhat.com>
Subject: Re: [ndctl PATCH] ndctl/list: Drop named list objects from verbose
 listing
Thread-Topic: [ndctl PATCH] ndctl/list: Drop named list objects from verbose
 listing
Thread-Index: AQHV51AWnmJff0QsXEycy1WlrjZqyagjY0mAgAATCwA=
Date: Wed, 19 Feb 2020 20:01:51 +0000
Message-ID: <03b5da834f0be8bc7110c459f3172732b96e85fa.camel@intel.com>
References: <157481532698.2805671.8095763752180655226.stgit@dwillia2-desk3.amr.corp.intel.com>
	 <x49sgj6law0.fsf@segfault.boston.devel.redhat.com>
	 <CAPcyv4ibE3ssieq=A5diqwRyiT6e3X=kcpQ3aA0vYneBpuSCAA@mail.gmail.com>
	 <x49k14ila4r.fsf@segfault.boston.devel.redhat.com>
	 <CAPcyv4hHU+RC6TZW94UrjFJZ1fsOU8Nug0GP+Mb5mBGW8qk+UQ@mail.gmail.com>
In-Reply-To: <CAPcyv4hHU+RC6TZW94UrjFJZ1fsOU8Nug0GP+Mb5mBGW8qk+UQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
x-originating-ip: [10.254.46.202]
Content-ID: <908B177C0285884F9FB6FC473700BA6E@intel.com>
MIME-Version: 1.0
Message-ID-Hash: 3NXZ2XCISABICJV5MEQMOBBKTOHR2G6W
X-Message-ID-Hash: 3NXZ2XCISABICJV5MEQMOBBKTOHR2G6W
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3NXZ2XCISABICJV5MEQMOBBKTOHR2G6W/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2020-02-19 at 10:53 -0800, Dan Williams wrote:
> 
> > > > Will this break existing code that parses the javascript output?
> > > 
> > > Always a potential for that. That said, I'd rather attempt to make it
> > > symmetric and replace it if someone screams, rather than let this
> > > quirk persist because it makes it impossible to ingest region data
> > > with the same script across -R and -Rv.
> > 
> > Yeah, I see where you're coming from.  However, script authors will
> > still have to deal with older versions of ndctl in the wild (for many
> > years).  If the decision was up to me, I'd live with the wart in favor
> > of not breaking scripts when ndctl gets updated.  Users hate that.
> 
> Let's do a compromise, because users also hate nonsensical legacy that
> they can't avoid. How about an environment variable,
> "NDCTL_LIST_LINT", that users can set to opt into the latest /
> cleanest output format with the understanding that the clean up may
> regress scripts that were dependent on the old bugs.
> 
Hm, this sounds good in concept, but how about waiting for this cleanup
to go in after the (yes, long pending) config rework. Then this can just
be a global config setting, and we won't have config things coming from
the environment as well (which this would be a first of).
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

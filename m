Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C2C164FD6
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Feb 2020 21:28:08 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 33DA310FC35AB;
	Wed, 19 Feb 2020 12:28:58 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E483310FC359F
	for <linux-nvdimm@lists.01.org>; Wed, 19 Feb 2020 12:28:55 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2020 12:28:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,461,1574150400";
   d="scan'208";a="236003326"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga003.jf.intel.com with ESMTP; 19 Feb 2020 12:28:02 -0800
Received: from fmsmsx122.amr.corp.intel.com (10.18.125.37) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 19 Feb 2020 12:28:02 -0800
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.48]) by
 fmsmsx122.amr.corp.intel.com ([169.254.5.169]) with mapi id 14.03.0439.000;
 Wed, 19 Feb 2020 12:28:02 -0800
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH] ndctl/list: Drop named list objects from verbose
 listing
Thread-Topic: [ndctl PATCH] ndctl/list: Drop named list objects from verbose
 listing
Thread-Index: AQHV51AWnmJff0QsXEycy1WlrjZqyagjY0mAgAATCwCAAAICgIAABU4A
Date: Wed, 19 Feb 2020 20:28:01 +0000
Message-ID: <00abe72085e75c1c54b87635c81352b628211707.camel@intel.com>
References: <157481532698.2805671.8095763752180655226.stgit@dwillia2-desk3.amr.corp.intel.com>
	 <x49sgj6law0.fsf@segfault.boston.devel.redhat.com>
	 <CAPcyv4ibE3ssieq=A5diqwRyiT6e3X=kcpQ3aA0vYneBpuSCAA@mail.gmail.com>
	 <x49k14ila4r.fsf@segfault.boston.devel.redhat.com>
	 <CAPcyv4hHU+RC6TZW94UrjFJZ1fsOU8Nug0GP+Mb5mBGW8qk+UQ@mail.gmail.com>
	 <03b5da834f0be8bc7110c459f3172732b96e85fa.camel@intel.com>
	 <CAPcyv4gVDEum7RiSMXug5fwNC04mEHo5MhAuUW37t4tN9y899A@mail.gmail.com>
In-Reply-To: <CAPcyv4gVDEum7RiSMXug5fwNC04mEHo5MhAuUW37t4tN9y899A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
x-originating-ip: [10.254.46.202]
Content-ID: <7E0A933F78523447AE3AC3D1CBBA0042@intel.com>
MIME-Version: 1.0
Message-ID-Hash: FYAECN5PMJDO7JEYRQPQ6X6OYY3XBBDP
X-Message-ID-Hash: FYAECN5PMJDO7JEYRQPQ6X6OYY3XBBDP
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FYAECN5PMJDO7JEYRQPQ6X6OYY3XBBDP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2020-02-19 at 12:09 -0800, Dan Williams wrote:
> > > 
> > > Let's do a compromise, because users also hate nonsensical legacy that
> > > they can't avoid. How about an environment variable,
> > > "NDCTL_LIST_LINT", that users can set to opt into the latest /
> > > cleanest output format with the understanding that the clean up may
> > > regress scripts that were dependent on the old bugs.
> > > 
> > Hm, this sounds good in concept, but how about waiting for this cleanup
> > to go in after the (yes, long pending) config rework. Then this can just
> > be a global config setting, and we won't have config things coming from
> > the environment as well (which this would be a first of).
> 
> That does make some sense, but I notice that git deals with "cosmetic"
> environment variables (GIT_EDITOR, GIT_PAGER, etc) in addition to its
> config file. So if we're borrowing from git, I'd also borrow that
> config vs environment logic.

True, that's reasonable. I guess I was hoping to avoid, if we can,
suddenly having a multitude of config sources, but env variables are
pretty standard and it should be fine to add them.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

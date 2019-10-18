Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 563B0DD0CF
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Oct 2019 23:04:13 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1698410FCB925;
	Fri, 18 Oct 2019 14:06:17 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4AF6D10FCB907
	for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 14:06:15 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2019 14:04:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,313,1566889200";
   d="scan'208";a="221866201"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga004.fm.intel.com with ESMTP; 18 Oct 2019 14:04:09 -0700
Received: from FMSMSX110.amr.corp.intel.com (10.18.116.10) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 18 Oct 2019 14:04:08 -0700
Received: from fmsmsx114.amr.corp.intel.com ([169.254.6.30]) by
 FMSMSX110.amr.corp.intel.com ([169.254.14.36]) with mapi id 14.03.0439.000;
 Fri, 18 Oct 2019 14:04:08 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH 10/10] daxctl: add --no-movable option for
 onlining memory
Thread-Topic: [ndctl PATCH 10/10] daxctl: add --no-movable option for
 onlining memory
Thread-Index: AQHVeXwNYof8P3wlPUeJIeTJEp1NPadhb/uAgAABjoA=
Date: Fri, 18 Oct 2019 21:04:07 +0000
Message-ID: <8b50ca67ffcd36bbc7fd0b23ad4f2e4607e56cbb.camel@intel.com>
References: <20191002234925.9190-1-vishal.l.verma@intel.com>
	 <20191002234925.9190-11-vishal.l.verma@intel.com>
	 <CAPcyv4hrxMFFK1wvCPkE1hMC8dyVFj3WUAzS4wgCBiuh0noa8w@mail.gmail.com>
In-Reply-To: <CAPcyv4hrxMFFK1wvCPkE1hMC8dyVFj3WUAzS4wgCBiuh0noa8w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.164]
Content-ID: <B3659591651F6C4FAF138BE965BBE971@intel.com>
MIME-Version: 1.0
Message-ID-Hash: QXJOW52NE473DJARR4WN7EXDXWSIFRVZ
X-Message-ID-Hash: QXJOW52NE473DJARR4WN7EXDXWSIFRVZ
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Olson, Ben" <ben.olson@intel.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Biesek, Michal" <michal.biesek@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QXJOW52NE473DJARR4WN7EXDXWSIFRVZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2019-10-18 at 13:58 -0700, Dan Williams wrote:
> 
> > +++ b/Documentation/daxctl/movable-options.txt
> > @@ -0,0 +1,10 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +-M::
> > +--no-movable::
> 
> If --movable is the default I would expect -M to be associated with
> --movable. Don't we otherwise get the --no-<option> handling for free
> with boolean options? I otherwise don't think we need a short option
> for the "no" case.

Yep we get the inverse options for booleans for free, but we can define
them either way - i.e. define it as --no-movable, and --movable is
implied, or the other way round.

But I agree it makes sense to remove the short option here.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2991F1ACD70
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 Apr 2020 18:18:44 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3565B100DCB75;
	Thu, 16 Apr 2020 09:19:04 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9037D100DCB73
	for <linux-nvdimm@lists.01.org>; Thu, 16 Apr 2020 09:19:01 -0700 (PDT)
IronPort-SDR: s2JkxesjAj5/YJKZCdWQ0jUXKjTqMYWZKy4KDV2ttpQVWxVbi5MJvPLT7Ss5LcQlUQR3hqmXrP
 MZ4gURrhk7DA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 09:18:38 -0700
IronPort-SDR: EEbC9NGL5HbCXisGOkwfQtymgNW0rrBzRSpopabchCNYQcm8mTrVp7K3FykPIRGMJUYcrxmSvV
 ezDBrN8AJbrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,391,1580803200";
   d="scan'208";a="332897670"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by orsmga001.jf.intel.com with ESMTP; 16 Apr 2020 09:18:38 -0700
Received: from orsmsx121.amr.corp.intel.com ([169.254.10.248]) by
 ORSMSX103.amr.corp.intel.com ([169.254.5.143]) with mapi id 14.03.0439.000;
 Thu, 16 Apr 2020 09:18:38 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "david@redhat.com" <david@redhat.com>, "mhocko@kernel.org"
	<mhocko@kernel.org>
Subject: Re: [PATCH v3] mm/memory_hotplug: refrain from adding memory into
 an impossible node
Thread-Topic: [PATCH v3] mm/memory_hotplug: refrain from adding memory into
 an impossible node
Thread-Index: AQHWEriRaezSbwIGuE+BiaITvAJR+Kh6dVgAgACkYQCAAKQMgIAAphcAgAAA2QCAAACNgA==
Date: Thu, 16 Apr 2020 16:18:37 +0000
Message-ID: <f3e3efff8f9584c42bd0145d94cb6f37a5461e6f.camel@intel.com>
References: <20200414235812.6158-1-vishal.l.verma@intel.com>
	 <20200415104338.GF4629@dhcp22.suse.cz>
	 <7a37b7c03e983ceb32337325fa2a724fa614607b.camel@intel.com>
	 <20200416061907.GA26707@dhcp22.suse.cz>
	 <4c806f6dc2bdb78dd3fb46814bc119df2815f8c2.camel@intel.com>
	 <16b04f11-f0d7-08e0-ac8c-72b1bd66f1c3@redhat.com>
In-Reply-To: <16b04f11-f0d7-08e0-ac8c-72b1bd66f1c3@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
x-originating-ip: [10.18.116.7]
Content-ID: <A910FBEB68A79843B2D9B72B97388CD9@intel.com>
MIME-Version: 1.0
Message-ID-Hash: X4Y5E7QXU644AIIEQTNYX43JEO3SUBXP
X-Message-ID-Hash: X4Y5E7QXU644AIIEQTNYX43JEO3SUBXP
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/X4Y5E7QXU644AIIEQTNYX43JEO3SUBXP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2020-04-16 at 18:16 +0200, David Hildenbrand wrote:
> > > 
> > > Doing that papers over something that is clearly a FW issue and makes
> > > it "my performance is suboptimal" deal with it OS problem.  Really, is
> > > this something we have to care about. Your changelog talks about a Qemu
> > > misconfiguration which is trivial to fix. Has this ever been observed
> > > with a real HW?
> > > 
> > Well - more of a qemu bug I think - I can share the details, but it just
> > looked like it was producing a bogus SRAT. I think it is plausible that
> > such a firmware bug can happen out in the wild. The NFIT tables would
> > just need to reference a 'proximity domain' that the SRAT hasn't
> > previously described, and hotplug will happily go add memory from the
> > NFIT and the backing node related data structures would be missing.
> > 
> > I'm not too opposed to erroring out, so long as we are ok with the fact
> > that we will leave some memory stranded until there's a firmware fix.
> 
> So let's reject it and print a warning, so we know it's a thing. If this
> actually shows up often in real live, we have good evidence that we
> should tolerate buggy firmwares instead of warning/rejecting.
> 
> (rejecting from inside add_memory() still makes sense IMHO)
> 
Sounds good, I'll send a v4.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

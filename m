Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2654C1ACD03
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 Apr 2020 18:13:42 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B4BB9100DCB6F;
	Thu, 16 Apr 2020 09:14:01 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C25F1100DCB6E
	for <linux-nvdimm@lists.01.org>; Thu, 16 Apr 2020 09:13:59 -0700 (PDT)
IronPort-SDR: j5EfdZeN3qOU2Z6ASPKAlEpVgg+v3dnGo/zv/Lhtkz6JUuMsV1emZDv87xD46kF9NVPb4ZZmFl
 BSrhcr+nTq6g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 09:13:37 -0700
IronPort-SDR: oyvGWJRwxmxeg313kU2xaTvOxa1jER47xqgKX6MtlF5XHYfD7gfrAI6kfX0028bHOB8QP4uKtm
 sCttT9NHRMEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,391,1580803200";
   d="scan'208";a="364040079"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga001.fm.intel.com with ESMTP; 16 Apr 2020 09:13:36 -0700
Received: from orsmsx122.amr.corp.intel.com (10.22.225.227) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Apr 2020 09:13:36 -0700
Received: from orsmsx121.amr.corp.intel.com ([169.254.10.248]) by
 ORSMSX122.amr.corp.intel.com ([169.254.11.34]) with mapi id 14.03.0439.000;
 Thu, 16 Apr 2020 09:13:36 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "mhocko@kernel.org" <mhocko@kernel.org>
Subject: Re: [PATCH v3] mm/memory_hotplug: refrain from adding memory into
 an impossible node
Thread-Topic: [PATCH v3] mm/memory_hotplug: refrain from adding memory into
 an impossible node
Thread-Index: AQHWEriRaezSbwIGuE+BiaITvAJR+Kh6dVgAgACkYQCAAKQMgIAAphcA
Date: Thu, 16 Apr 2020 16:13:35 +0000
Message-ID: <4c806f6dc2bdb78dd3fb46814bc119df2815f8c2.camel@intel.com>
References: <20200414235812.6158-1-vishal.l.verma@intel.com>
	 <20200415104338.GF4629@dhcp22.suse.cz>
	 <7a37b7c03e983ceb32337325fa2a724fa614607b.camel@intel.com>
	 <20200416061907.GA26707@dhcp22.suse.cz>
In-Reply-To: <20200416061907.GA26707@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
x-originating-ip: [10.18.116.7]
Content-ID: <241FC5E9AD55C143BA89F0AD6E772BA1@intel.com>
MIME-Version: 1.0
Message-ID-Hash: 7RERN2QYWTHFHSOTJNT5H543AJPJ5NVM
X-Message-ID-Hash: 7RERN2QYWTHFHSOTJNT5H543AJPJ5NVM
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "david@redhat.com" <david@redhat.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7RERN2QYWTHFHSOTJNT5H543AJPJ5NVM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2020-04-16 at 08:19 +0200, Michal Hocko wrote:
> On Wed 15-04-20 20:32:00, Verma, Vishal L wrote:
> > > 
> > > I really do not like this. Why should we try to be clever and change the
> > > node id requested by the caller? I would just stick with node_possible
> > > check and be done with this.
> > 
> > Hi Michal,
> > 
> > Being clever allows us to still use the memory even if it is in a non-
> > optimal configuration. Failing here leaves the user no path to add this
> > memory until the firmware is fixed. It is the tradeoff between some
> > usability vs. how loud we want to be for the failure.
> 
> Doing that papers over something that is clearly a FW issue and makes
> it "my performance is suboptimal" deal with it OS problem.  Really, is
> this something we have to care about. Your changelog talks about a Qemu
> misconfiguration which is trivial to fix. Has this ever been observed
> with a real HW?
> 
Well - more of a qemu bug I think - I can share the details, but it just
looked like it was producing a bogus SRAT. I think it is plausible that
such a firmware bug can happen out in the wild. The NFIT tables would
just need to reference a 'proximity domain' that the SRAT hasn't
previously described, and hotplug will happily go add memory from the
NFIT and the backing node related data structures would be missing.

I'm not too opposed to erroring out, so long as we are ok with the fact
that we will leave some memory stranded until there's a firmware fix.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

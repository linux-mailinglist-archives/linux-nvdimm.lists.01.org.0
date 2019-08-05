Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D718821A8
	for <lists+linux-nvdimm@lfdr.de>; Mon,  5 Aug 2019 18:26:34 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 742CA21309DD4;
	Mon,  5 Aug 2019 09:29:03 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.93; helo=mga11.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E37E621309DBF
 for <linux-nvdimm@lists.01.org>; Mon,  5 Aug 2019 09:29:01 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Aug 2019 09:26:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; d="scan'208";a="178891797"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga006.jf.intel.com with ESMTP; 05 Aug 2019 09:26:30 -0700
Received: from fmsmsx123.amr.corp.intel.com (10.18.125.38) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 5 Aug 2019 09:26:25 -0700
Received: from fmsmsx114.amr.corp.intel.com ([169.254.6.86]) by
 fmsmsx123.amr.corp.intel.com ([169.254.7.171]) with mapi id 14.03.0439.000;
 Mon, 5 Aug 2019 09:26:25 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 "vaibhav@linux.ibm.com" <vaibhav@linux.ibm.com>
Subject: Re: [PATCH] ndctl, check: Ensure mmap of BTT sections work with 64K
 page-size
Thread-Topic: [PATCH] ndctl, check: Ensure mmap of BTT sections work with
 64K page-size
Thread-Index: AQHVMhOUNpg7mwxJnEKc1iJ3aS10KabpFQiAgAQaNYCAADcAAA==
Date: Mon, 5 Aug 2019 16:26:24 +0000
Message-ID: <2cc108a1f65fb008670c272473df40e51e97b9ad.camel@intel.com>
References: <20190704025143.22856-1-vaibhav@linux.ibm.com>
 <b01607421be5f487662e973c30967a0bf8a8389d.camel@intel.com>
 <878ss721yq.fsf@vajain21.in.ibm.com>
In-Reply-To: <878ss721yq.fsf@vajain21.in.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-ID: <FFFB8529FE6CC145816D13356240EA53@intel.com>
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
Cc: "harish@linux.ibm.com" <harish@linux.ibm.com>,
 "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, 2019-08-05 at 18:39 +0530, Vaibhav Jain wrote:
> Thanks for reviewing this patch Vishal. I have prepped a v2 adressing
> all your review comments with one exception below:

No problem, thanks for fixing this.

> 
> "Verma, Vishal L" <vishal.l.verma@intel.com> writes:
> 
> > On Thu, 2019-07-04 at 08:21 +0530, Vaibhav Jain wrote:
> > > 
> > 
> > > +	if (addr != MAP_FAILED)
> > > +		addr = (void *) ((uintptr_t)addr + shift);
> > 
> > The (uintptr_t) cast should be ok to drop, for v66 we are removing
> > the
> > pointer arithmatic warning:
> > https://patchwork.kernel.org/patch/11062697/
> > 
> > In fact, since 'shift' is in bytes, isn't an unsigned int cast
> > actually *wrong*?
> Not sure if I understand your review comment correctly. With uintptr_t
> cast and 'shift' in bytes, addr will be assigned 'addr + shift'
> instead
> of 'addr + shift * sizeof (unsigned int)'
> 
> So I think the arithmetic I am doing here is correct.
> 
Yes you're right - I conflated a (uintptr_t) cast with an (unsigned int)
cast. The latter would actually be wrong, but I see now that uintptr_t
is correct. However, given the above patch where we drop the pointer
arithmetic warning, I think it should be OK to manipulate the void
pointer directly, and this makes the line cleaner and more concise.

Thanks,
	-Vishal


_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

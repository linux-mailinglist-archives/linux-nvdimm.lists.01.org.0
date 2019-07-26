Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1A3774FC
	for <lists+linux-nvdimm@lfdr.de>; Sat, 27 Jul 2019 01:30:56 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2BCB7212E159C;
	Fri, 26 Jul 2019 16:33:21 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.136; helo=mga12.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 7726A212E1597
 for <linux-nvdimm@lists.01.org>; Fri, 26 Jul 2019 16:33:19 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Jul 2019 16:30:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,312,1559545200"; d="scan'208";a="322201289"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
 by orsmga004.jf.intel.com with ESMTP; 26 Jul 2019 16:30:51 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.100]) by
 fmsmsx104.amr.corp.intel.com ([169.254.3.188]) with mapi id 14.03.0439.000;
 Fri, 26 Jul 2019 16:30:50 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH v7 11/13] contrib/ndctl: fix region-id completions
 for daxctl
Thread-Topic: [ndctl PATCH v7 11/13] contrib/ndctl: fix region-id
 completions for daxctl
Thread-Index: AQHVQmrdL6ii9tFlSUOXPFtnDD0T1abcq6aAgAFZLYA=
Date: Fri, 26 Jul 2019 23:30:50 +0000
Message-ID: <a6ca723887fab20429929217baa08ae26513eb26.camel@intel.com>
References: <20190724215741.18556-1-vishal.l.verma@intel.com>
 <20190724215741.18556-12-vishal.l.verma@intel.com>
 <CAPcyv4g82poaqSNZh+Q_QpdWVqjmz3C=BM74Guoe_Wj7bv6kwQ@mail.gmail.com>
In-Reply-To: <CAPcyv4g82poaqSNZh+Q_QpdWVqjmz3C=BM74Guoe_Wj7bv6kwQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-ID: <A67E4798195B8347A92385AE07A174F8@intel.com>
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
Cc: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>


On Thu, 2019-07-25 at 19:55 -0700, Dan Williams wrote:
> On Wed, Jul 24, 2019 at 2:58 PM Vishal Verma <vishal.l.verma@intel.com
> > wrote:
> > The completion helpers for daxctl assumed the region arguments for
> > specifying daxctl regions were the same as ndctl regions, i.e.
> > "regionX". This is not true - daxctl region arguments are a simple
> > numeric 'id'.
> 
> Oh, that's an unfortunate difference, but too late to change now I
> think, good find.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Yep - though I think I like --region=0 better than --region=region0,
less redundancy.  But agreed, probably too late to change.

Thanks for reviewing these!
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

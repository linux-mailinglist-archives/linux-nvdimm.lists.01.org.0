Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAD4A0E1E
	for <lists+linux-nvdimm@lfdr.de>; Thu, 29 Aug 2019 01:17:08 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 098B22021B705;
	Wed, 28 Aug 2019 16:19:05 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.126; helo=mga18.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 475022020D322
 for <linux-nvdimm@lists.01.org>; Wed, 28 Aug 2019 16:19:04 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Aug 2019 16:17:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; 
 d="scan'208,217";a="192761934"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga002.jf.intel.com with ESMTP; 28 Aug 2019 16:17:05 -0700
Received: from fmsmsx118.amr.corp.intel.com (10.18.116.18) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 28 Aug 2019 16:17:03 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.127]) by
 fmsmsx118.amr.corp.intel.com ([169.254.1.57]) with mapi id 14.03.0439.000;
 Wed, 28 Aug 2019 16:17:02 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "Scargall, Steve"
 <steve.scargall@intel.com>
Subject: Re: [ndctl RFC PATCH] ndctl/namespace: create namespaces greedily
Thread-Topic: [ndctl RFC PATCH] ndctl/namespace: create namespaces greedily
Thread-Index: AQHVXduAyVJpFM+Oz0CJvO6aRKhQIqcQ/oA3gAB+yoCAAAf4AIAAAbsAgAACwACAABJkAIAACuWA
Date: Wed, 28 Aug 2019 23:17:01 +0000
Message-ID: <9f412408dfb12a69767b5034435776a5853eb64f.camel@intel.com>
References: <20190828200204.21750-1-vishal.l.verma@intel.com>
 <x49y2zd6obc.fsf@segfault.boston.devel.redhat.com>
 <507921D13093A64EAF066075F3F6ED13076E485E@ORSMSX111.amr.corp.intel.com>
 <1ac1bafeaf3253fb9396c22db334b51deb653f0a.camel@intel.com>
 <ce15fdbdee2135a1b1d698f46d3cc7c9856bb381.camel@intel.com>
 <CAPcyv4gnfRv3uKAFj7gctLpZHphCc_3gPc7MzjbYmndK0aZE_w@mail.gmail.com>
 <507921D13093A64EAF066075F3F6ED13076E4922@ORSMSX111.amr.corp.intel.com>
In-Reply-To: <507921D13093A64EAF066075F3F6ED13076E4922@ORSMSX111.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-ID: <3AA41423B1AE7645BEF85244D223700D@intel.com>
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
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, 2019-08-28 at 15:38 -0700, Scargall, Steve wrote:
> Thanks for the clarification.  I have a much better understanding
> now. 
> 
> Updating the ndctl-create-namespace man page to clarify what '
> --region=all' does and does not do in combination with other arguments
> and options would be beneficial.   This would actually provide a more
> immediate solution to the problem.  It sounds like the general
> statement used in the other man pages can remain?  Or are there other
> exceptions?

Yep I have a patch clarifying the --region option for create-namespace.
'all' is used in two ways, --<object>=all  or ndctl-<action> all.

The former acts as a filter, where as the latter acts as a "act on all"
directive.

So 'ndctl disable-namespace --region=region0 all' disables all
namespaces on region0, where as
'ndctl disable-namespace --region=all all' is the same as omitting the
--region option (while still acceptable syntax), and acts on all
namespaces regardless of the region.

> 
> With the proposed implementation that bails out on first error, `
> --continue` seems reasonable vs. `--greedy`.  What do you think about
> `--all-regions` instead?  It is more meaningful towards its intended
> action or use-case, but would it cause confusion with `
> --regions=all`?   Documentation could provide the solution here.  We
> would have to choose an arbitrary short option since `-a` and `-r` are
> already taken.  

I prefer --continue/-c since it automatically extends to buses as well.
As a result, with these changes, 'ndctl create-namespace -c' will create
namespaces on all possible regions on all possible buses.

> 
> Whatever the final decision, we should test for and return a usage
> error for a mutually exclusive set of inputs, i.e. `ndctl create-
> namespace --all-regions --region=region0` doesn't make sense - either
> you want to perform the create operation on all regions or only in
> region0.

With --continue this isn't a big problem as the --region restriction
will render the --continue meaningless.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

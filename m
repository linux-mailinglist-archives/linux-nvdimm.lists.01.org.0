Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27922A94CC
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Sep 2019 23:17:08 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B436921962301;
	Wed,  4 Sep 2019 14:18:09 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.136; helo=mga12.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 8812720260CE3
 for <linux-nvdimm@lists.01.org>; Wed,  4 Sep 2019 14:18:08 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Sep 2019 14:17:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,468,1559545200"; d="scan'208";a="207625104"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga004.fm.intel.com with ESMTP; 04 Sep 2019 14:17:04 -0700
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 4 Sep 2019 14:17:04 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.127]) by
 fmsmsx156.amr.corp.intel.com ([169.254.13.146]) with mapi id 14.03.0439.000;
 Wed, 4 Sep 2019 14:17:04 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH 2/2] libdaxctl: fix device reconfiguration with
 builtin drivers
Thread-Topic: [ndctl PATCH 2/2] libdaxctl: fix device reconfiguration with
 builtin drivers
Thread-Index: AQHVYr1QvsvbA51m90uXy4ZXOZ4cwacbPpeAgAEvhYCAAAmcgIAABFYA
Date: Wed, 4 Sep 2019 21:17:03 +0000
Message-ID: <25878b6903086ee20d332a02cd784065d93cea61.camel@intel.com>
References: <20190904010819.11012-1-vishal.l.verma@intel.com>
 <20190904010819.11012-2-vishal.l.verma@intel.com>
 <CAPcyv4ipdLhKSUVZ-U3ZFpcuw=tJJTq1ZW5x6vJ-bJNReyjJbQ@mail.gmail.com>
 <be47815b3d454ce76a81799ba355b5579713c916.camel@intel.com>
 <CAPcyv4inooSbqCaAXJ4KzwVMxcDpfKpMD2QG5aXOP_sKnFy6UQ@mail.gmail.com>
In-Reply-To: <CAPcyv4inooSbqCaAXJ4KzwVMxcDpfKpMD2QG5aXOP_sKnFy6UQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.164]
Content-ID: <398BADBAFF19B540A2212D80CEB4B18E@intel.com>
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
Cc: "Brice.Goglin@inria.fr" <Brice.Goglin@inria.fr>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, 2019-09-04 at 14:01 -0700, Dan Williams wrote:
> On Wed, Sep 4, 2019 at 1:27 PM Verma, Vishal L <vishal.l.verma@intel.com> wrote:
> > On Tue, 2019-09-03 at 19:20 -0700, Dan Williams wrote:
> > > 
> > > Hmm, why wait until now to check if this list is NULL. How about fall
> > > back to kmod_module_new_from_name() at to_module_list() time? That
> > > would seem to simplify this follow up routine to not need to worry
> > > about working around a NULL list.
> > 
> > So we moved the list checking to later in the process around v4 of the
> > original series, so that we don't unnecessarily fail add_dax_dev() if
> > for some reason a list wasn't created.
> 
> Ah true, I forgot that wrinkle, however...
> 
> > Also, we use mod_name = dax_modules[mode] during an 'enable' to
> > determine the module name to use for the fallback - we wouldn't have
> > this at add_dax_dev() time.
> 
> Since modalias is already not reliable it seems the implementation
> should go ahead never do module lookups and just do everything based
> on module names.
> 
> In other words the libndctl panacea of not needing to hard code module
> names is already lost in libdaxctl land. If the code drops modalias
> usage does that clean up some of these flows?

Yep I think so - we use modalias to construct a lookup list, but we
still have to use the name to resolve to the final module based on the
mode. I think we can remove the list lookup and replace it with simply:

	kmod_module_new_from_name(ctx->kmod_ctx, mod_name, &kmod);

It would clean up the module related flows, but is there any
disadvantage to doing this?

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

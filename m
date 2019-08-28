Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36980A0DA8
	for <lists+linux-nvdimm@lfdr.de>; Thu, 29 Aug 2019 00:38:07 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4A55C2021B703;
	Wed, 28 Aug 2019 15:40:04 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.120; helo=mga04.intel.com;
 envelope-from=steve.scargall@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id F241620215F65
 for <linux-nvdimm@lists.01.org>; Wed, 28 Aug 2019 15:40:02 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Aug 2019 15:38:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; d="scan'208";a="188367003"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
 by FMSMGA003.fm.intel.com with ESMTP; 28 Aug 2019 15:38:03 -0700
Received: from orsmsx111.amr.corp.intel.com ([169.254.12.153]) by
 ORSMSX103.amr.corp.intel.com ([169.254.5.221]) with mapi id 14.03.0439.000;
 Wed, 28 Aug 2019 15:38:03 -0700
From: "Scargall, Steve" <steve.scargall@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "Verma, Vishal L"
 <vishal.l.verma@intel.com>
Subject: RE: [ndctl RFC PATCH] ndctl/namespace: create namespaces greedily
Thread-Topic: [ndctl RFC PATCH] ndctl/namespace: create namespaces greedily
Thread-Index: AQHVXduA+N8yR/vBCUmibT87zCoH+acQ/oGBgAAGVUCAAIBtgIAAAboAgAACwAD//4t24A==
Date: Wed, 28 Aug 2019 22:38:02 +0000
Message-ID: <507921D13093A64EAF066075F3F6ED13076E4922@ORSMSX111.amr.corp.intel.com>
References: <20190828200204.21750-1-vishal.l.verma@intel.com>
 <x49y2zd6obc.fsf@segfault.boston.devel.redhat.com>
 <507921D13093A64EAF066075F3F6ED13076E485E@ORSMSX111.amr.corp.intel.com>
 <1ac1bafeaf3253fb9396c22db334b51deb653f0a.camel@intel.com>
 <ce15fdbdee2135a1b1d698f46d3cc7c9856bb381.camel@intel.com>
 <CAPcyv4gnfRv3uKAFj7gctLpZHphCc_3gPc7MzjbYmndK0aZE_w@mail.gmail.com>
In-Reply-To: <CAPcyv4gnfRv3uKAFj7gctLpZHphCc_3gPc7MzjbYmndK0aZE_w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTViZjI5NDItMmUxYy00YjAwLTgzZDUtNTM3MDA2YTdhNDJhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMmpldmNpTDNMN3VwRUpneW9KdHRCV1R3RldNeHlLVkRUK3dWVVN4dXJQVjRhdzUzbURLT0R5OEFMK054ZW9LMiJ9
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
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

Thanks for the clarification.  I have a much better understanding now. 

Updating the ndctl-create-namespace man page to clarify what '--region=all' does and does not do in combination with other arguments and options would be beneficial.   This would actually provide a more immediate solution to the problem.  It sounds like the general statement used in the other man pages can remain?  Or are there other exceptions?

With the proposed implementation that bails out on first error, `--continue` seems reasonable vs. `--greedy`.  What do you think about `--all-regions` instead?  It is more meaningful towards its intended action or use-case, but would it cause confusion with `--regions=all`?   Documentation could provide the solution here.  We would have to choose an arbitrary short option since `-a` and `-r` are already taken.  

Whatever the final decision, we should test for and return a usage error for a mutually exclusive set of inputs, i.e. `ndctl create-namespace --all-regions --region=region0` doesn't make sense - either you want to perform the create operation on all regions or only in region0.

- Steve

-----Original Message-----
From: Dan Williams [mailto:dan.j.williams@intel.com] 
Sent: Wednesday, August 28, 2019 3:32 PM
To: Verma, Vishal L <vishal.l.verma@intel.com>
Cc: Scargall, Steve <steve.scargall@intel.com>; jmoyer@redhat.com; linux-nvdimm@lists.01.org
Subject: Re: [ndctl RFC PATCH] ndctl/namespace: create namespaces greedily

On Wed, Aug 28, 2019 at 2:22 PM Verma, Vishal L <vishal.l.verma@intel.com> wrote:
>
> On Wed, 2019-08-28 at 21:16 +0000, Verma, Vishal L wrote:
> > On Wed, 2019-08-28 at 13:47 -0700, Scargall, Steve wrote:
> > > Hi Jeff,
> > >
> > > The issue is more of repetition.   On an 8-socket system,  should a
> > > user really be expected to type 'ndctl create-namespace' eight times
> > > vs. running 'ndctl create-namespace --region=all' once?   SAP HANA is
> > > an example app the requires one namespace per region.  Scripting 
> > > is a viable solution, but that requires somebody to write the 
> > > script and do all the error checking & handling.  Each 
> > > OEM/ISV/SysAdmin would have their own script.  Pushing the logic 
> > > to ndctl seems to be a reasonable approach and let the user handle any errors returned by ndctl.
> >
> > A scripted solution can indeed be really simple - e.g.:
> >
> > # while read -r region; do  ndctl create-namespace 
> > --region="$region"; done < <(ndctl list --bus=nfit_test.0 -R  | jq 
> > -r '.[].dev')
> >
> > {
> >   "dev":"namespace5.0",
> >   "mode":"fsdax",
> >   "map":"dev",
> >   "size":"62.00 MiB (65.01 MB)",
> >   "uuid":"c8014457-c268-4f22-8eae-6386fbf08ceb",
> >   "sector_size":512,
> >   "align":2097152,
> >   "blockdev":"pmem5"
> > }
> > {
> >   "dev":"namespace4.0",
> >   "mode":"fsdax",
> >   "map":"dev",
> >   "size":"30.00 MiB (31.46 MB)",
> >   "uuid":"f9498ef6-cdd6-46c7-95f1-86469546ecb9",
> >   "sector_size":512,
> >   "align":2097152,
> >   "blockdev":"pmem4"
> > }
> >
> > > The ndctl-man-page implies the 'ndctl create-namespace --region=all'
> > > feature exists today:
> > >
> > >        -r, --region=
> > >
> > >            A regionX device name, or a region id number. The 
> > > keyword all can be specified to carry out the operation on every 
> > > region in the system, optionally filtered by bus id (see --bus=  option).
> > >
> >
> > This is true, but unfortunately, the implementation has treated 
> > create- namespace as an exception to this since the start, and I 
> > agree with Jeff that changing its behavior now can cause other 
> > Hyrum's law-esqe [1] breakage.
> >
> > I think however it should be easy to make a compromise, and retain 
> > the legacy behavior of create-namespace, while creating a new 
> > create- namespace-greedy command with the new semantics.
> >
> .. And it doesn't even need to be a new command, a simple --greedy 
> option to create-namespace should be sufficient.

Perhaps "--continue" to proceed with creating namespace after the first successful invocation. I agree with Jeff that changing the default semantics would be surprising. The man page can also be fixed up to make it clear that it's the "singleton region capacity search", not "all possible namespaces" that "-r all" implies.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

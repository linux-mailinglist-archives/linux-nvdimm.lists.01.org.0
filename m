Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8B4A0BCB
	for <lists+linux-nvdimm@lfdr.de>; Wed, 28 Aug 2019 22:47:47 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1D38820215F65;
	Wed, 28 Aug 2019 13:49:45 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.93; helo=mga11.intel.com;
 envelope-from=steve.scargall@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 730C8202110B9
 for <linux-nvdimm@lists.01.org>; Wed, 28 Aug 2019 13:49:44 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Aug 2019 13:47:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; d="scan'208";a="380537319"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
 by fmsmga005.fm.intel.com with ESMTP; 28 Aug 2019 13:47:41 -0700
Received: from orsmsx154.amr.corp.intel.com (10.22.226.12) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 28 Aug 2019 13:47:40 -0700
Received: from orsmsx111.amr.corp.intel.com ([169.254.12.153]) by
 ORSMSX154.amr.corp.intel.com ([169.254.11.172]) with mapi id 14.03.0439.000;
 Wed, 28 Aug 2019 13:47:40 -0700
From: "Scargall, Steve" <steve.scargall@intel.com>
To: Jeff Moyer <jmoyer@redhat.com>, "Verma, Vishal L"
 <vishal.l.verma@intel.com>
Subject: RE: [ndctl RFC PATCH] ndctl/namespace: create namespaces greedily
Thread-Topic: [ndctl RFC PATCH] ndctl/namespace: create namespaces greedily
Thread-Index: AQHVXduA+N8yR/vBCUmibT87zCoH+acQ/oGBgAAGVUA=
Date: Wed, 28 Aug 2019 20:47:39 +0000
Message-ID: <507921D13093A64EAF066075F3F6ED13076E485E@ORSMSX111.amr.corp.intel.com>
References: <20190828200204.21750-1-vishal.l.verma@intel.com>
 <x49y2zd6obc.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49y2zd6obc.fsf@segfault.boston.devel.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzkxZWY5OWEtNTdiNi00ZGVhLTgxY2UtMThjZjdhNjM4YWViIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicDRVZlZYTFwvMGVxUkpaTW5qUXlDRWNsaVNWb2NzYXVNUDNzQllqc2dsWmFXbGpWcDdxMXp5T1hFN25peHhzNXIifQ==
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

Hi Jeff,

The issue is more of repetition.   On an 8-socket system,  should a user really be expected to type 'ndctl create-namespace' eight times vs. running 'ndctl create-namespace --region=all' once?   SAP HANA is an example app the requires one namespace per region.  Scripting is a viable solution, but that requires somebody to write the script and do all the error checking & handling.  Each OEM/ISV/SysAdmin would have their own script.  Pushing the logic to ndctl seems to be a reasonable approach and let the user handle any errors returned by ndctl.

The ndctl-man-page implies the 'ndctl create-namespace --region=all' feature exists today:

       -r, --region=

           A regionX device name, or a region id number. The keyword all can be specified to carry out the operation on every region in the system, optionally filtered by bus id (see --bus=  option).

-Steve

-----Original Message-----
From: Jeff Moyer [mailto:jmoyer@redhat.com] 
Sent: Wednesday, August 28, 2019 2:13 PM
To: Verma, Vishal L <vishal.l.verma@intel.com>
Cc: linux-nvdimm@lists.01.org; Scargall, Steve <steve.scargall@intel.com>; Williams, Dan J <dan.j.williams@intel.com>
Subject: Re: [ndctl RFC PATCH] ndctl/namespace: create namespaces greedily

Vishal Verma <vishal.l.verma@intel.com> writes:

> When a --region=all option is supplied to ndctl-create-namespace, it 
> happily ignores it, since create-namespace has historically only 
> created one namespace per invocation.
>
> This can be cumbersome, so change create-namespace to create 
> namespaces greedily. When --region=all is specified, or if a --region 
> option is absent (same as 'all' from a filtering standpoint), create 
> namespaces on all regions.

Cumbersome?  Like, in the same way partitioning a disk is cumbersome?  I don't understand what the problem is, I guess.  If you want N namespaces of the same type/size/align, then script it.  Why does there have to be a command for that?  I definitely think that changing the behavior of create-namespace is a non-starter.

Cheers,
Jeff

>
> Note that this does has two important implications:
>
> 1. The user-facing behavior of create-namespace changes in a 
> potentially surprising way. It may be undesirable for an unadorned 
> 'ndctl create-namespace' command to suddenly start creating lots of namespaces.
>
> 2. Error handling becomes a bit inconsistent. As with all commands 
> accepting an 'all' option, error reporting becomes a bit tenuous. With 
> this change, we will continue to create namespaces so long as we don't 
> hit an error, but if we do, we bail and exit. Because of the special 
> ENOSPC detection and handling around this, it can be easy to construct 
> a scenario where en existing namespace on the last region in the scan 
> list happens to report an error exit, but if the existing namespace 
> was in a region at the start of the scan list, it gets passed over as 
> a "just try the next region"
>
> RFC comment: Maybe the solution is to keep the create-namespace 
> semantics unchanged, and introduce a new command - 'create-namespaces'
> or 'create-names-ace-greedy' with the new behavior. I'm not sure if 
> users will care deeply about either of the two points above, hence 
> sending this as an RFC.
>
> Link: https://github.com/pmem/ndctl/issues/106
> Reported-by: Steve Scargal <steve.scargall@intel.com>
> Cc: Jeff Moyer <jmoyer@redhat.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  ndctl/namespace.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/ndctl/namespace.c b/ndctl/namespace.c index 
> af20a42..856ad82 100644
> --- a/ndctl/namespace.c
> +++ b/ndctl/namespace.c
> @@ -1365,9 +1365,12 @@ static int do_xaction_namespace(const char *namespace,
>  				rc = namespace_create(region);
>  				if (rc == -EAGAIN)
>  					continue;
> -				if (rc == 0)
> -					*processed = 1;
> -				return rc;
> +				if (rc == 0) {
> +					(*processed)++;
> +					continue;
> +				} else {
> +					return rc;
> +				}
>  			}
>  			ndctl_namespace_foreach_safe(region, ndns, _n) {
>  				ndns_name = ndctl_namespace_get_devname(ndns);
> @@ -1487,6 +1490,8 @@ int cmd_create_namespace(int argc, const char **argv, struct ndctl_ctx *ctx)
>  		rc = do_xaction_namespace(NULL, ACTION_CREATE, ctx, &created);
>  	}
>  
> +	fprintf(stderr, "created %d namespace%s\n", created,
> +			created == 1 ? "" : "s");
>  	if (rc < 0 || (!namespace && created < 1)) {
>  		fprintf(stderr, "failed to %s namespace: %s\n", namespace
>  				? "reconfigure" : "create", strerror(-rc));
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

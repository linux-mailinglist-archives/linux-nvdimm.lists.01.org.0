Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 884AB9F362
	for <lists+linux-nvdimm@lfdr.de>; Tue, 27 Aug 2019 21:43:03 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 84BF02194EB7A;
	Tue, 27 Aug 2019 12:45:07 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.136; helo=mga12.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 1ED7320216B7E
 for <linux-nvdimm@lists.01.org>; Tue, 27 Aug 2019 12:44:13 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Aug 2019 12:42:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,438,1559545200"; d="scan'208";a="331927539"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by orsmga004.jf.intel.com with ESMTP; 27 Aug 2019 12:42:04 -0700
Received: from fmsmsx102.amr.corp.intel.com (10.18.124.200) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 27 Aug 2019 12:42:04 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.127]) by
 FMSMSX102.amr.corp.intel.com ([169.254.10.170]) with mapi id 14.03.0439.000;
 Tue, 27 Aug 2019 12:42:04 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH] ndctl/namespace: Fix 'clear-error -s' excessive
 scrubbing
Thread-Topic: [ndctl PATCH] ndctl/namespace: Fix 'clear-error -s' excessive
 scrubbing
Thread-Index: AQHVXQtu6wWGqNzLJEKxKuOZyoBpsKcP2kGA
Date: Tue, 27 Aug 2019 19:42:03 +0000
Message-ID: <95693f4ad905a91617fa498e0c91347ff1c3db37.camel@intel.com>
References: <156693231821.718166.10779376892986285406.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156693231821.718166.10779376892986285406.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-ID: <8F19E86C0CBB634E9FCD62632E6FB35B@intel.com>
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
Cc: "erwin.tsaur@oracle.com" <erwin.tsaur@oracle.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>


On Tue, 2019-08-27 at 11:58 -0700, Dan Williams wrote:
> Erwin reports:
>     The current implementation of ndctl clear-errors takes a very long time,
>     because a full scrub happens for every namespace.
> 
>     Doing a full system ARS scrub is obviously not necessary, it just needs
>     to happen once.
> 
> Indeed, it only needs to happen once per bus. Clear the 'scrub' option
> after one namespace_clear_bb() invocation, and reset it when looping to
> the next bus.
> 
> Link: https://github.com/pmem/ndctl/issues/104
> Reported-by: Erwin Tsaur <erwin.tsaur@oracle.com>
> Fixes: 2ba7b8277075 ("ndctl: add a 'clear-errors' command")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  ndctl/namespace.c |   18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)

Looks good, applied.

> 
> diff --git a/ndctl/namespace.c b/ndctl/namespace.c
> index bbc9107c6baa..c1af7d0db153 100644
> --- a/ndctl/namespace.c
> +++ b/ndctl/namespace.c
> @@ -1295,7 +1295,7 @@ static int raw_clear_badblocks(struct ndctl_namespace *ndns)
>  	return nstype_clear_badblocks(ndns, devname, begin, size);
>  }
>  
> -static int namespace_wait_scrub(struct ndctl_namespace *ndns)
> +static int namespace_wait_scrub(struct ndctl_namespace *ndns, bool do_scrub)
>  {
>  	const char *devname = ndctl_namespace_get_devname(ndns);
>  	struct ndctl_bus *bus = ndctl_namespace_get_bus(ndns);
> @@ -1309,7 +1309,7 @@ static int namespace_wait_scrub(struct ndctl_namespace *ndns)
>  	}
>  
>  	/* start a scrub if asked and if one isn't in progress */
> -	if (scrub && (!in_progress)) {
> +	if (do_scrub && (!in_progress)) {
>  		rc = ndctl_bus_start_scrub(bus);
>  		if (rc) {
>  			error("%s: Unable to start scrub: %s\n", devname,
> @@ -1332,7 +1332,7 @@ static int namespace_wait_scrub(struct ndctl_namespace *ndns)
>  	return 0;
>  }
>  
> -static int namespace_clear_bb(struct ndctl_namespace *ndns)
> +static int namespace_clear_bb(struct ndctl_namespace *ndns, bool do_scrub)
>  {
>  	struct ndctl_pfn *pfn = ndctl_namespace_get_pfn(ndns);
>  	struct ndctl_dax *dax = ndctl_namespace_get_dax(ndns);
> @@ -1347,7 +1347,7 @@ static int namespace_clear_bb(struct ndctl_namespace *ndns)
>  		return 1;
>  	}
>  
> -	rc = namespace_wait_scrub(ndns);
> +	rc = namespace_wait_scrub(ndns, do_scrub);
>  	if (rc)
>  		return rc;
>  
> @@ -1716,9 +1716,14 @@ static int do_xaction_namespace(const char *namespace,
>  		ndctl_set_log_priority(ctx, LOG_DEBUG);
>  
>          ndctl_bus_foreach(ctx, bus) {
> +		bool do_scrub;
> +
>  		if (!util_bus_filter(bus, param.bus))
>  			continue;
>  
> +		/* only request scrubbing once per bus */
> +		do_scrub = scrub;
> +
>  		ndctl_region_foreach(bus, region) {
>  			if (!util_region_filter(region, param.region))
>  				continue;
> @@ -1778,7 +1783,10 @@ static int do_xaction_namespace(const char *namespace,
>  						(*processed)++;
>  					break;
>  				case ACTION_CLEAR:
> -					rc = namespace_clear_bb(ndns);
> +					rc = namespace_clear_bb(ndns, do_scrub);
> +
> +					/* one scrub per bus is sufficient */
> +					do_scrub = false;
>  					if (rc == 0)
>  						(*processed)++;
>  					break;
> 

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A26B0756
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Sep 2019 05:53:25 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C36C921962301;
	Wed, 11 Sep 2019 20:53:28 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4D34A202C80B7
 for <linux-nvdimm@lists.01.org>; Wed, 11 Sep 2019 20:53:26 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Sep 2019 20:53:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; d="scan'208";a="268958277"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by orsmga001.jf.intel.com with ESMTP; 11 Sep 2019 20:53:20 -0700
Received: from fmsmsx117.amr.corp.intel.com (10.18.116.17) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 11 Sep 2019 20:52:50 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.68]) by
 fmsmsx117.amr.corp.intel.com ([169.254.3.133]) with mapi id 14.03.0439.000;
 Wed, 11 Sep 2019 20:52:50 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "joe@perches.com" <joe@perches.com>, "Williams, Dan J"
 <dan.j.williams@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Busch,
 Keith" <keith.busch@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH 11/13] nvdimm: Use more common logic testing styles and
 bare ; positions
Thread-Topic: [PATCH 11/13] nvdimm: Use more common logic testing styles and
 bare ; positions
Thread-Index: AQHVaRWKbif/DxojQEGXHgNOmHirzacn3kSA
Date: Thu, 12 Sep 2019 03:52:49 +0000
Message-ID: <706f6af6a6571a3bb2d35ec332fa572a990cbc48.camel@intel.com>
References: <cover.1568256705.git.joe@perches.com>
 <d6aa5b66936f2e0f132e893e10494aae6b74e886.1568256708.git.joe@perches.com>
In-Reply-To: <d6aa5b66936f2e0f132e893e10494aae6b74e886.1568256708.git.joe@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.254.21.217]
Content-ID: <9B343DDA310A65479EFFA2A81A767489@intel.com>
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
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, 2019-09-11 at 19:54 -0700, Joe Perches wrote:
> Avoid using uncommon logic testing styles to make the code a
> bit more like other kernel code.
> 
> e.g.:
> 	if (foo) {
> 		;
> 	} else {
> 		<code>
> 	}
> 
> is typically written
> 
> 	if (!foo) {
> 		<code>
> 	}
> 

A lot of times the excessive inversions seem to result in a net loss of
readability - e.g.:

<snip>

> diff --git a/drivers/nvdimm/region_devs.c
> b/drivers/nvdimm/region_devs.c
> index 65df07481909..6861e0997d21 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -320,9 +320,7 @@ static ssize_t set_cookie_show(struct device *dev,
>  	struct nd_interleave_set *nd_set = nd_region->nd_set;
>  	ssize_t rc = 0;
>  
> -	if (is_memory(dev) && nd_set)
> -		/* pass, should be precluded by region_visible */;

For one, the comment is lost

> -	else
> +	if (!(is_memory(dev) && nd_set))

And it takes a moment to resolve between things such as:

	if (!(A && B))
	  vs.
	if (!(A) && B)

And this is especially true if 'A' and 'B' are longer function calls,
split over multiple lines, or are themselves compound 'sections'.

I'm not opposed to /all/ such transformations -- for example, the ones
where the logical inversion can be 'consumed' by toggling a comparision
operator, as you have a few times in this patch, don't sacrifice any
readibility, and perhaps even improve it. 

>  		return -ENXIO;
>  
>  	/*
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

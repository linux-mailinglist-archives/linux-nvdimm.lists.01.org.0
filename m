Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D9D97A06
	for <lists+linux-nvdimm@lfdr.de>; Wed, 21 Aug 2019 14:56:12 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8373720212C91;
	Wed, 21 Aug 2019 05:57:20 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=msuchanek@suse.de;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id F351520212C87
 for <linux-nvdimm@lists.01.org>; Wed, 21 Aug 2019 05:57:19 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 83EB2AD3E;
 Wed, 21 Aug 2019 12:56:06 +0000 (UTC)
Date: Wed, 21 Aug 2019 14:56:05 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH v2 14/26] ndctl/namespace: Handle
 'create-namespace' in label-less mode
Message-ID: <20190821145605.206372a0@kitsune.suse.cz>
In-Reply-To: <156426363655.531577.4504452379578995249.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156426356088.531577.14828880045306313118.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156426363655.531577.4504452379578995249.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
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
Cc: linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Hello,

this patch is marked as superseded in the patchwork.

What is the intended replacement?

Thanks

Michal

On Sat, 27 Jul 2019 14:40:36 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> A common confusion with ndctl is that 'create-namespace' does not work
> in the label-less case. In the label-less case there is no capacity to
> allocate as the size if already hard-coded by the region boundary.
> 
> However, users typically do something like the following in the
> label-less case:
> 
>     # ndctl list
>     {
>       "dev":"namespace1.0",
>       "mode":"raw",
>       "size":"127.00 GiB (136.37 GB)",
>       "sector_size":512,
>       "blockdev":"pmem1"
>     }
> 
>     # ndctl destroy-namespace namespace1.0 -f
>     destroyed 1 namespace
> 
>     # ndctl create-namespace
>     failed to create namespace: Resource temporarily unavailable
> 
> In other words they destroy the raw mode namespace that they don't want,
> and seek to create a new default configuration namespace. Since there is
> no "available_capacity" in the label-less case the 'create' attempt
> fails.
> 
> Fix this by recognizing that the user wants a default sized namespace
> and just reconfigure the raw namespace.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  ndctl/namespace.c |   10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/ndctl/namespace.c b/ndctl/namespace.c
> index 58fec194ab94..e5a2b1341cdb 100644
> --- a/ndctl/namespace.c
> +++ b/ndctl/namespace.c
> @@ -837,9 +837,13 @@ static int namespace_create(struct ndctl_region *region)
>  		return -EAGAIN;
>  	}
>  
> -	available = ndctl_region_get_max_available_extent(region);
> -	if (available == ULLONG_MAX)
> -		available = ndctl_region_get_available_size(region);
> +	if (ndctl_region_get_nstype(region) == ND_DEVICE_NAMESPACE_IO)
> +		available = ndctl_region_get_size(region);
> +	else {
> +		available = ndctl_region_get_max_available_extent(region);
> +		if (available == ULLONG_MAX)
> +			available = ndctl_region_get_available_size(region);
> +	}
>  	if (!available || p.size > available) {
>  		debug("%s: insufficient capacity size: %llx avail: %llx\n",
>  			devname, p.size, available);

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

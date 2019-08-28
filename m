Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3020A09F4
	for <lists+linux-nvdimm@lfdr.de>; Wed, 28 Aug 2019 20:51:34 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2828D20215F5D;
	Wed, 28 Aug 2019 11:53:33 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.151; helo=mga17.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 30B0E2020F956
 for <linux-nvdimm@lists.01.org>; Wed, 28 Aug 2019 11:53:31 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Aug 2019 11:51:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; d="scan'208";a="175014339"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga008.jf.intel.com with ESMTP; 28 Aug 2019 11:51:30 -0700
Received: from fmsmsx157.amr.corp.intel.com (10.18.116.73) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 28 Aug 2019 11:51:30 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.127]) by
 FMSMSX157.amr.corp.intel.com ([169.254.14.57]) with mapi id 14.03.0439.000;
 Wed, 28 Aug 2019 11:51:29 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "Jiang, Dave"
 <dave.jiang@intel.com>, "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
 "Busch, Keith" <keith.busch@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH] libnvdimm, region: Use struct_size() in kzalloc()
Thread-Topic: [PATCH] libnvdimm, region: Use struct_size() in kzalloc()
Thread-Index: AQHVH9BpuhzKadnSBkOkhqdJ05WiaacR2OoA
Date: Wed, 28 Aug 2019 18:51:28 +0000
Message-ID: <3e80b36c86942278ee66aebdd5ea2632f104083a.camel@intel.com>
References: <20190610210613.GA21989@embeddedor>
In-Reply-To: <20190610210613.GA21989@embeddedor>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-ID: <D1589446AC767F47B8FEFD059DCEA60D@intel.com>
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
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, 2019-06-10 at 16:06 -0500, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is
> finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct nd_region {
> 	...
>         struct nd_mapping mapping[0];
> };
> 
> instance = kzalloc(sizeof(struct nd_region) + sizeof(struct
> nd_mapping) *
>                           count, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = kzalloc(struct_size(instance, mapping, count), GFP_KERNEL);
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/nvdimm/region_devs.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvdimm/region_devs.c
> b/drivers/nvdimm/region_devs.c
> index b4ef7d9ff22e..88becc87e234 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -1027,10 +1027,9 @@ static struct nd_region
> *nd_region_create(struct nvdimm_bus *nvdimm_bus,
>  		}
>  		region_buf = ndbr;
>  	} else {
> -		nd_region = kzalloc(sizeof(struct nd_region)
> -				+ sizeof(struct nd_mapping)
> -				* ndr_desc->num_mappings,
> -				GFP_KERNEL);
> +		nd_region = kzalloc(struct_size(nd_region, mapping,
> +						ndr_desc->num_mappings),
> +				    GFP_KERNEL);
>  		region_buf = nd_region;
>  	}
>  

Hi Gustavo,

The patch looks good to me, however it looks like it might've missed
some instances where this replacement can be performed?

One is just a few lines below from the above, in the 'else' block[1].
Additionally, maybe the Coccinelle script can be augmented to catch
devm_kzalloc instances as well - there is one of those in this file[2].

Thanks,
	-Vishal

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/tree/drivers/nvdimm/region_devs.c#n1030
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/tree/drivers/nvdimm/region_devs.c#n96



_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

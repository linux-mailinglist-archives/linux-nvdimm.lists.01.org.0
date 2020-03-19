Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4782B18C3E9
	for <lists+linux-nvdimm@lfdr.de>; Fri, 20 Mar 2020 00:47:50 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 211891007B1C6;
	Thu, 19 Mar 2020 16:48:39 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4600910097F3D
	for <linux-nvdimm@lists.01.org>; Thu, 19 Mar 2020 16:48:36 -0700 (PDT)
IronPort-SDR: IehQF8PJ3JKa2u0jhd1vqBmMrRhxw3/d2f6h9Qvuaya8cgvvlBHEscBJwTXGoqjQEH8z+BawYl
 tHwLUcMJRlSQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 16:47:45 -0700
IronPort-SDR: bHiYt5HDMIE9YwlgXNYceQMPMy1leuD0nyfCae+QpsBK3aDPbY2OM/ttnZi/gQiGEcEYRWqsQy
 /wmgw4ygKKLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,573,1574150400";
   d="scan'208";a="263895304"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga002.jf.intel.com with ESMTP; 19 Mar 2020 16:47:45 -0700
Date: Thu, 19 Mar 2020 16:47:44 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH][next] nvdimm: nd.h: Replace zero-length array with
 flexible-array member
Message-ID: <20200319234744.GA1688758@iweiny-DESK2.sc.intel.com>
References: <20200319230937.GA16648@embeddedor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200319230937.GA16648@embeddedor.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: YAPMU3HQN2QGCOYG2OG5CM6Z5OZE63EA
X-Message-ID-Hash: YAPMU3HQN2QGCOYG2OG5CM6Z5OZE63EA
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YAPMU3HQN2QGCOYG2OG5CM6Z5OZE63EA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Mar 19, 2020 at 06:09:37PM -0500, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:

"won't" be affected?

My reading of [1] indicates that this change will break the allocation in
nd_region_activate() because sizeof() can no longer be used on the base
structure?

What am I missing?

Ira

> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/nvdimm/nd.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
> index c4d69c1cce55..85dbb2a322b9 100644
> --- a/drivers/nvdimm/nd.h
> +++ b/drivers/nvdimm/nd.h
> @@ -39,7 +39,7 @@ struct nd_region_data {
>  	int ns_count;
>  	int ns_active;
>  	unsigned int hints_shift;
> -	void __iomem *flush_wpq[0];
> +	void __iomem *flush_wpq[];
>  };
>  
>  static inline void __iomem *ndrd_get_flush_wpq(struct nd_region_data *ndrd,
> @@ -157,7 +157,7 @@ struct nd_region {
>  	struct nd_interleave_set *nd_set;
>  	struct nd_percpu_lane __percpu *lane;
>  	int (*flush)(struct nd_region *nd_region, struct bio *bio);
> -	struct nd_mapping mapping[0];
> +	struct nd_mapping mapping[];
>  };
>  
>  struct nd_blk_region {
> -- 
> 2.23.0
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

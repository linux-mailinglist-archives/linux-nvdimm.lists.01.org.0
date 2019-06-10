Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73883BB7E
	for <lists+linux-nvdimm@lfdr.de>; Mon, 10 Jun 2019 20:00:48 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E10F421962301;
	Mon, 10 Jun 2019 11:00:46 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.126; helo=mga18.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C74C2211F9D6B
 for <linux-nvdimm@lists.01.org>; Mon, 10 Jun 2019 11:00:44 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Jun 2019 11:00:43 -0700
X-ExtLoop1: 1
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by FMSMGA003.fm.intel.com with ESMTP; 10 Jun 2019 11:00:43 -0700
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 10 Jun 2019 11:00:43 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.221]) by
 FMSMSX153.amr.corp.intel.com ([169.254.9.44]) with mapi id 14.03.0415.000;
 Mon, 10 Jun 2019 11:00:42 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>, "Williams, Dan
 J" <dan.j.williams@intel.com>
Subject: =?utf-8?B?UmU6IFtQQVRDSF0gbW0vbnZkaW1tOiBGaXggZW5kaWFuIGNvbnZlcnNpb24g?=
 =?utf-8?B?aXNzdWVzwqA=?=
Thread-Topic: =?utf-8?B?W1BBVENIXSBtbS9udmRpbW06IEZpeCBlbmRpYW4gY29udmVyc2lvbiBpc3N1?=
 =?utf-8?B?ZXPCoA==?=
Thread-Index: AQHVHPzvNVRBYBN6b0uXWFFw88SJnqaVqDUA
Date: Mon, 10 Jun 2019 18:00:42 +0000
Message-ID: <1ec64d511af872df7b0597895622eb196ac4dbc9.camel@intel.com>
References: <20190607064732.30384-1-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20190607064732.30384-1-aneesh.kumar@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-ID: <41D4EB0C81964E4BB929D8F7CE095E4A@intel.com>
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
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, 2019-06-07 at 12:17 +0530, Aneesh Kumar K.V wrote:
> nd_label->dpa issue was observed when trying to enable the namespace created
> with little-endian kernel on a big-endian kernel. That made me run
> `sparse` on the rest of the code and other changes are the result of that.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  drivers/nvdimm/btt.c            | 8 ++++----
>  drivers/nvdimm/namespace_devs.c | 7 ++++---
>  2 files changed, 8 insertions(+), 7 deletions(-)

The two BTT fixes seem like they may apply to stable as well, the
problematic code was introduced in relatively recent reworks/fixes.
Perhaps -

Fixes: d9b83c756953 ("libnvdimm, btt: rework error clearing")
Fixes: 9dedc73a4658 ("libnvdimm/btt: Fix LBA masking during 'free list' population")

Other than that, these look good to me.
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>

> 
> diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
> index 4671776f5623..4ac0f5dde467 100644
> --- a/drivers/nvdimm/btt.c
> +++ b/drivers/nvdimm/btt.c
> @@ -400,9 +400,9 @@ static int btt_flog_write(struct arena_info *arena, u32 lane, u32 sub,
>  	arena->freelist[lane].sub = 1 - arena->freelist[lane].sub;
>  	if (++(arena->freelist[lane].seq) == 4)
>  		arena->freelist[lane].seq = 1;
> -	if (ent_e_flag(ent->old_map))
> +	if (ent_e_flag(le32_to_cpu(ent->old_map)))
>  		arena->freelist[lane].has_err = 1;
> -	arena->freelist[lane].block = le32_to_cpu(ent_lba(ent->old_map));
> +	arena->freelist[lane].block = ent_lba(le32_to_cpu(ent->old_map));
>  
>  	return ret;
>  }
> @@ -568,8 +568,8 @@ static int btt_freelist_init(struct arena_info *arena)
>  		 * FIXME: if error clearing fails during init, we want to make
>  		 * the BTT read-only
>  		 */
> -		if (ent_e_flag(log_new.old_map) &&
> -				!ent_normal(log_new.old_map)) {
> +		if (ent_e_flag(le32_to_cpu(log_new.old_map)) &&
> +		    !ent_normal(le32_to_cpu(log_new.old_map))) {
>  			arena->freelist[i].has_err = 1;
>  			ret = arena_clear_freelist_error(arena, i);
>  			if (ret)
> diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
> index c4c5a191b1d6..500c37db496a 100644
> --- a/drivers/nvdimm/namespace_devs.c
> +++ b/drivers/nvdimm/namespace_devs.c
> @@ -1995,7 +1995,7 @@ static struct device *create_namespace_pmem(struct nd_region *nd_region,
>  		nd_mapping = &nd_region->mapping[i];
>  		label_ent = list_first_entry_or_null(&nd_mapping->labels,
>  				typeof(*label_ent), list);
> -		label0 = label_ent ? label_ent->label : 0;
> +		label0 = label_ent ? label_ent->label : NULL;
>  
>  		if (!label0) {
>  			WARN_ON(1);
> @@ -2330,8 +2330,9 @@ static struct device **scan_labels(struct nd_region *nd_region)
>  			continue;
>  
>  		/* skip labels that describe extents outside of the region */
> -		if (nd_label->dpa < nd_mapping->start || nd_label->dpa > map_end)
> -			continue;
> +		if (__le64_to_cpu(nd_label->dpa) < nd_mapping->start ||
> +		    __le64_to_cpu(nd_label->dpa) > map_end)
> +				continue;
>  
>  		i = add_namespace_resource(nd_region, nd_label, devs, count);
>  		if (i < 0)

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B412FCDCF
	for <lists+linux-nvdimm@lfdr.de>; Wed, 20 Jan 2021 11:24:07 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D4120100EB82F;
	Wed, 20 Jan 2021 02:24:05 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=mhocko@suse.com; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 14E1D100EB82E
	for <linux-nvdimm@lists.01.org>; Wed, 20 Jan 2021 02:24:03 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1611138241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pR0wawllqar92e+0i/G2KHzH+n7trSGvXHpnYgU8y9E=;
	b=OMcPSYXBHvSJXBnY9ADeFvqbIefQc34k/bofJwAESHWDlgJj6QJMQFpNonxfi7gFOPdNCo
	C/SRaUQwAARGE0wlbU87CkKpBkWAPMxm2XRePeEsoP4ORVMoSL4uGibNxEW2xHKP/lkivf
	4nMw4yVlBW2j+LG8oE/xHFp7HWrpbXo=
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 9833AAC97;
	Wed, 20 Jan 2021 10:24:01 +0000 (UTC)
Date: Wed, 20 Jan 2021 11:24:00 +0100
From: Michal Hocko <mhocko@suse.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 2/5] mm: Teach pfn_to_online_page() to consider
 subsection validity
Message-ID: <20210120102400.GG9371@dhcp22.suse.cz>
References: <161058499000.1840162.702316708443239771.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161058500148.1840162.4365921007820501696.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <161058500148.1840162.4365921007820501696.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID-Hash: 5ITDA62ZQ4IT4RMX2GBZRLBLNEB6HQGT
X-Message-ID-Hash: 5ITDA62ZQ4IT4RMX2GBZRLBLNEB6HQGT
X-MailFrom: mhocko@suse.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: akpm@linux-foundation.org, Qian Cai <cai@lca.pw>, Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5ITDA62ZQ4IT4RMX2GBZRLBLNEB6HQGT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed 13-01-21 16:43:21, Dan Williams wrote:
> pfn_section_valid() determines pfn validity on subsection granularity
> where pfn_valid() may be limited to coarse section granularity.
> Explicitly validate subsections after pfn_valid() succeeds.

The changelog is not really clear on the underlying problem. It would
benefit from some clarification. What about something like this?
"
pfn_to_online_page is primarily used to filter out offline or fully
uninitialized pages. pfn_valid resp. online_section_nr have a coarse
per memory section granularity. If a section shared with a partially
offline memory (e.g. part of ZONE_DEVICE) then pfn_to_online_page would
lead to a false positive on some pfns. Fix this by adding
pfn_section_valid check which is subsection aware.
"

> 
> Fixes: b13bc35193d9 ("mm/hotplug: invalid PFNs from pfn_to_online_page()")
> Cc: Qian Cai <cai@lca.pw>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Reported-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

With that feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memory_hotplug.c |   23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 55a69d4396e7..d0c81f7a3347 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -308,11 +308,26 @@ static int check_hotplug_memory_addressable(unsigned long pfn,
>  struct page *pfn_to_online_page(unsigned long pfn)
>  {
>  	unsigned long nr = pfn_to_section_nr(pfn);
> +	struct mem_section *ms;
> +
> +	if (nr >= NR_MEM_SECTIONS)
> +		return NULL;
> +
> +	ms = __nr_to_section(nr);
> +	if (!online_section(ms))
> +		return NULL;
> +
> +	/*
> +	 * Save some code text when online_section() +
> +	 * pfn_section_valid() are sufficient.
> +	 */
> +	if (IS_ENABLED(CONFIG_HAVE_ARCH_PFN_VALID) && !pfn_valid(pfn))
> +		return NULL;
> +
> +	if (!pfn_section_valid(ms, pfn))
> +		return NULL;
>  
> -	if (nr < NR_MEM_SECTIONS && online_section_nr(nr) &&
> -	    pfn_valid_within(pfn))
> -		return pfn_to_page(pfn);
> -	return NULL;
> +	return pfn_to_page(pfn);
>  }
>  EXPORT_SYMBOL_GPL(pfn_to_online_page);
>  
> 

-- 
Michal Hocko
SUSE Labs
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

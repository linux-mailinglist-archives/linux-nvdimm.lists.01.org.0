Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C66F2F4686
	for <lists+linux-nvdimm@lfdr.de>; Wed, 13 Jan 2021 09:31:01 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7F82B100EB338;
	Wed, 13 Jan 2021 00:30:59 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=osalvador@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D473A100EB337
	for <linux-nvdimm@lists.01.org>; Wed, 13 Jan 2021 00:30:56 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 0F71FAC8F;
	Wed, 13 Jan 2021 08:30:55 +0000 (UTC)
Date: Wed, 13 Jan 2021 09:30:52 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 2/6] mm: Teach pfn_to_online_page() to consider
 subsection validity
Message-ID: <20210113083048.GA23676@linux>
References: <161052331545.1805594.2356512831689786960.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161052332755.1805594.9846390935351758277.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <161052332755.1805594.9846390935351758277.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: S7TGLVYCOEILHW433C5GCDZ272GSTPGK
X-Message-ID-Hash: S7TGLVYCOEILHW433C5GCDZ272GSTPGK
X-MailFrom: osalvador@suse.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-mm@kvack.org, Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/S7TGLVYCOEILHW433C5GCDZ272GSTPGK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jan 12, 2021 at 11:35:27PM -0800, Dan Williams wrote:
> pfn_section_valid() determines pfn validity on subsection granularity
> where pfn_valid() may be limited to coarse section granularity.
> Explicitly validate subsections after pfn_valid() succeeds.
> 
> Fixes: b13bc35193d9 ("mm/hotplug: invalid PFNs from pfn_to_online_page()")
> Cc: Qian Cai <cai@lca.pw>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Reported-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/memory_hotplug.c |   24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 55a69d4396e7..9f37f8a68da4 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -308,11 +308,27 @@ static int check_hotplug_memory_addressable(unsigned long pfn,
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
> +	if (IS_ENABLED(CONFIG_HAVE_ARCH_PFN_VALID))
> +		if (!pfn_valid(pfn))
> +			return NULL;
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
Oscar Salvador
SUSE L3
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

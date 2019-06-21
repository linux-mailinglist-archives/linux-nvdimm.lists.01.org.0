Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329874E134
	for <lists+linux-nvdimm@lfdr.de>; Fri, 21 Jun 2019 09:23:52 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B45BD2129F0EA;
	Fri, 21 Jun 2019 00:23:50 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=david@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 3636D21297063
 for <linux-nvdimm@lists.01.org>; Fri, 21 Jun 2019 00:23:47 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0E9833082AE5;
 Fri, 21 Jun 2019 07:23:42 +0000 (UTC)
Received: from [10.36.117.46] (ovpn-117-46.ams2.redhat.com [10.36.117.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CF4319722;
 Fri, 21 Jun 2019 07:23:37 +0000 (UTC)
Subject: Re: [PATCH] mm/sparsemem: Cleanup 'section number' data types
To: Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
References: <156107543656.1329419.11505835211949439815.stgit@dwillia2-desk3.amr.corp.intel.com>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <68b71c3a-6fbd-ce39-2699-09c85212d9f5@redhat.com>
Date: Fri, 21 Jun 2019 09:23:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156107543656.1329419.11505835211949439815.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 21 Jun 2019 07:23:47 +0000 (UTC)
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
Cc: linux-mm@kvack.org, linux-nvdimm@lists.01.org,
 Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
 Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 21.06.19 02:06, Dan Williams wrote:
> David points out that there is a mixture of 'int' and 'unsigned long'
> usage for section number data types. Update the memory hotplug path to
> use 'unsigned long' consistently for section numbers.
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Reported-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Hi Andrew,
> 
> This patch belatedly fixes up David's review feedback about moving over
> to 'unsigned long' for section numbers. Let me know if you want me to
> respin the full series, or if you'll just apply / fold this patch on
> top.
> 
>  mm/memory_hotplug.c |   10 +++++-----
>  mm/sparse.c         |    8 ++++----
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 4e8e65954f31..92bc44a73fc5 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -288,8 +288,8 @@ static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
>  int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
>  		struct mhp_restrictions *restrictions)
>  {
> -	unsigned long i;
> -	int start_sec, end_sec, err;
> +	int err;
> +	unsigned long nr, start_sec, end_sec;
>  	struct vmem_altmap *altmap = restrictions->altmap;
>  
>  	if (altmap) {
> @@ -310,7 +310,7 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
>  
>  	start_sec = pfn_to_section_nr(pfn);
>  	end_sec = pfn_to_section_nr(pfn + nr_pages - 1);
> -	for (i = start_sec; i <= end_sec; i++) {
> +	for (nr = start_sec; nr <= end_sec; nr++) {
>  		unsigned long pfns;
>  
>  		pfns = min(nr_pages, PAGES_PER_SECTION
> @@ -541,7 +541,7 @@ void __remove_pages(struct zone *zone, unsigned long pfn,
>  		    unsigned long nr_pages, struct vmem_altmap *altmap)
>  {
>  	unsigned long map_offset = 0;
> -	int i, start_sec, end_sec;
> +	unsigned long nr, start_sec, end_sec;
>  
>  	if (altmap)
>  		map_offset = vmem_altmap_offset(altmap);
> @@ -553,7 +553,7 @@ void __remove_pages(struct zone *zone, unsigned long pfn,
>  
>  	start_sec = pfn_to_section_nr(pfn);
>  	end_sec = pfn_to_section_nr(pfn + nr_pages - 1);
> -	for (i = start_sec; i <= end_sec; i++) {
> +	for (nr = start_sec; nr <= end_sec; nr++) {
>  		unsigned long pfns;
>  
>  		cond_resched();
> diff --git a/mm/sparse.c b/mm/sparse.c
> index b77ca21a27a4..6c4eab2b2bb0 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -229,21 +229,21 @@ void subsection_mask_set(unsigned long *map, unsigned long pfn,
>  void __init subsection_map_init(unsigned long pfn, unsigned long nr_pages)
>  {
>  	int end_sec = pfn_to_section_nr(pfn + nr_pages - 1);
> -	int i, start_sec = pfn_to_section_nr(pfn);
> +	unsigned long nr, start_sec = pfn_to_section_nr(pfn);
>  
>  	if (!nr_pages)
>  		return;
>  
> -	for (i = start_sec; i <= end_sec; i++) {
> +	for (nr = start_sec; nr <= end_sec; nr++) {
>  		struct mem_section *ms;
>  		unsigned long pfns;
>  
>  		pfns = min(nr_pages, PAGES_PER_SECTION
>  				- (pfn & ~PAGE_SECTION_MASK));
> -		ms = __nr_to_section(i);
> +		ms = __nr_to_section(nr);
>  		subsection_mask_set(ms->usage->subsection_map, pfn, pfns);
>  
> -		pr_debug("%s: sec: %d pfns: %ld set(%d, %d)\n", __func__, i,
> +		pr_debug("%s: sec: %d pfns: %ld set(%d, %d)\n", __func__, nr,
>  				pfns, subsection_map_index(pfn),
>  				subsection_map_index(pfn + pfns - 1));
>  
> 

Thanks Dan!

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

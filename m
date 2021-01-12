Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 186892F2BD2
	for <lists+linux-nvdimm@lfdr.de>; Tue, 12 Jan 2021 10:53:58 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DB005100EB824;
	Tue, 12 Jan 2021 01:53:56 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=osalvador@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 31F2D100EB823
	for <linux-nvdimm@lists.01.org>; Tue, 12 Jan 2021 01:53:54 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 840D8AF58;
	Tue, 12 Jan 2021 09:53:52 +0000 (UTC)
Date: Tue, 12 Jan 2021 10:53:50 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 4/5] mm: Fix page reference leak in soft_offline_page()
Message-ID: <20210112095345.GA12534@linux>
References: <161044407603.1482714.16630477578392768273.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161044409809.1482714.11965583624142790079.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <161044409809.1482714.11965583624142790079.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: 7BOL65AHPCIE5GKL32HKLUMJTMULWELV
X-Message-ID-Hash: 7BOL65AHPCIE5GKL32HKLUMJTMULWELV
X-MailFrom: osalvador@suse.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Naoya Horiguchi <nao.horiguchi@gmail.com>, David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@kernel.org>, stable@vger.kernel.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7BOL65AHPCIE5GKL32HKLUMJTMULWELV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jan 12, 2021 at 01:34:58AM -0800, Dan Williams wrote:
> The conversion to move pfn_to_online_page() internal to
> soft_offline_page() missed that the get_user_pages() reference needs to
> be dropped when pfn_to_online_page() fails.

I would be more specific here wrt. get_user_pages (madvise).
soft_offline_page gets called from more places besides madvise_*.

> When soft_offline_page() is handed a pfn_valid() &&
> !pfn_to_online_page() pfn the kernel hangs at dax-device shutdown due to
> a leaked reference.
> 
> Fixes: feec24a6139d ("mm, soft-offline: convert parameter to pfn")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

LGTM, thanks for catching this:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

A nit below.

> ---
>  mm/memory-failure.c |   20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 5a38e9eade94..78b173c7190c 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1885,6 +1885,12 @@ static int soft_offline_free_page(struct page *page)
>  	return rc;
>  }
>  
> +static void put_ref_page(struct page *page)
> +{
> +	if (page)
> +		put_page(page);
> +}

I am not sure this warrants a function.
I would probably go with "if (ref_page).." in the two corresponding places,
but not feeling strong here.

> +
>  /**
>   * soft_offline_page - Soft offline a page.
>   * @pfn: pfn to soft-offline
> @@ -1910,20 +1916,26 @@ static int soft_offline_free_page(struct page *page)
>  int soft_offline_page(unsigned long pfn, int flags)
>  {
>  	int ret;
> -	struct page *page;
>  	bool try_again = true;
> +	struct page *page, *ref_page = NULL;
> +
> +	WARN_ON_ONCE(!pfn_valid(pfn) && (flags & MF_COUNT_INCREASED));

Did you see any scenario where this could happen? I understand that you are
adding this because we will leak a reference in case pfn is not valid anymore.

-- 
Oscar Salvador
SUSE L3
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

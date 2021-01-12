Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83302F2C6D
	for <lists+linux-nvdimm@lfdr.de>; Tue, 12 Jan 2021 11:17:02 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9E377100EB825;
	Tue, 12 Jan 2021 02:17:00 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 01BC3100EB824
	for <linux-nvdimm@lists.01.org>; Tue, 12 Jan 2021 02:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1610446616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U4eg0K2Y42rlDcaFlSc0InWSXj6Mh1nlrY28P8UwpZY=;
	b=Mxz2pj1Re1yrKZTwOGvFqLDqAFiPwJb9ULYOTIYJjw736yaJkrsWP1r4Es3DAYyLgkt3Vy
	IHp9hE0PAj64wrSgLqIUwKG369upUh4QsSdMf+rzr3Jo6QIXKUWk1WUycoYn2Q3cBmBQaw
	x2dqU2RUZd6aywuJqahIUDMwTcNpmE8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-xh76z7DZNvmKh8o0hMopaQ-1; Tue, 12 Jan 2021 05:16:53 -0500
X-MC-Unique: xh76z7DZNvmKh8o0hMopaQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1B37100F340;
	Tue, 12 Jan 2021 10:16:50 +0000 (UTC)
Received: from [10.36.115.140] (ovpn-115-140.ams2.redhat.com [10.36.115.140])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ABB495B4A1;
	Tue, 12 Jan 2021 10:16:48 +0000 (UTC)
Subject: Re: [PATCH v2 4/5] mm: Fix page reference leak in soft_offline_page()
To: Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org
References: <161044407603.1482714.16630477578392768273.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161044409809.1482714.11965583624142790079.stgit@dwillia2-desk3.amr.corp.intel.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <95b8c874-7236-dc84-ed36-c29b060ada7a@redhat.com>
Date: Tue, 12 Jan 2021 11:16:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <161044409809.1482714.11965583624142790079.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Message-ID-Hash: K3B3NGH5NUPUGL3UCINW3SEANO7C7DE3
X-Message-ID-Hash: K3B3NGH5NUPUGL3UCINW3SEANO7C7DE3
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Naoya Horiguchi <nao.horiguchi@gmail.com>, Michal Hocko <mhocko@kernel.org>, Oscar Salvador <osalvador@suse.de>, stable@vger.kernel.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/K3B3NGH5NUPUGL3UCINW3SEANO7C7DE3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12.01.21 10:34, Dan Williams wrote:
> The conversion to move pfn_to_online_page() internal to
> soft_offline_page() missed that the get_user_pages() reference needs to
> be dropped when pfn_to_online_page() fails.
> 
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
>  
>  	if (!pfn_valid(pfn))
>  		return -ENXIO;
> +	if (flags & MF_COUNT_INCREASED)
> +		ref_page = pfn_to_page(pfn);
> +
>  	/* Only online pages can be soft-offlined (esp., not ZONE_DEVICE). */
>  	page = pfn_to_online_page(pfn);
> -	if (!page)
> +	if (!page) {
> +		put_ref_page(ref_page);
>  		return -EIO;
> +	}
>  
>  	if (PageHWPoison(page)) {
>  		pr_info("%s: %#lx page already poisoned\n", __func__, pfn);
> -		if (flags & MF_COUNT_INCREASED)
> -			put_page(page);
> +		put_ref_page(ref_page);
>  		return 0;
>  	}

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

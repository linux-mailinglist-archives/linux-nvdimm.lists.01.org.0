Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4673C2F2BD1
	for <lists+linux-nvdimm@lfdr.de>; Tue, 12 Jan 2021 10:53:32 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BF5C0100EB823;
	Tue, 12 Jan 2021 01:53:30 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=63.128.21.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [63.128.21.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 07507100EB820
	for <linux-nvdimm@lists.01.org>; Tue, 12 Jan 2021 01:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1610445206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L1OJr5pkvyOvtq5VyxsZ17t2sX3sq4TUtZVIaiGCPDk=;
	b=G2zlMfyyFcWjMUXiErLh3yDHdWlO4ud1h1N9mG9dZ85LTJJeL6i5qezYYs6snR5+qub4Po
	upnQAvgPs+Nzy23oI5cuEnQqyn2g+BASPX+KkVWJXBVHvhJ08CaklGqiAum/cs/dIR+Rpe
	Bpt4ZB1hYw676xfzbbd46Ou32qVRlVo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-n6uSQp9IP7y6sUgC_oq6fw-1; Tue, 12 Jan 2021 04:53:21 -0500
X-MC-Unique: n6uSQp9IP7y6sUgC_oq6fw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34D2B1934100;
	Tue, 12 Jan 2021 09:53:20 +0000 (UTC)
Received: from [10.36.115.140] (ovpn-115-140.ams2.redhat.com [10.36.115.140])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6A09E77714;
	Tue, 12 Jan 2021 09:53:18 +0000 (UTC)
Subject: Re: [PATCH v2 2/5] mm: Teach pfn_to_online_page() to consider
 subsection validity
To: Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org
References: <161044407603.1482714.16630477578392768273.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161044408728.1482714.9086710868634042303.stgit@dwillia2-desk3.amr.corp.intel.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <0586c562-787c-4872-4132-18a49c3ffc8e@redhat.com>
Date: Tue, 12 Jan 2021 10:53:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <161044408728.1482714.9086710868634042303.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Message-ID-Hash: NI2MX3CG7N4GUCCET2GPP57PBLUFYKXF
X-Message-ID-Hash: NI2MX3CG7N4GUCCET2GPP57PBLUFYKXF
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@suse.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NI2MX3CG7N4GUCCET2GPP57PBLUFYKXF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12.01.21 10:34, Dan Williams wrote:
> pfn_section_valid() determines pfn validity on subsection granularity.
> 
> pfn_valid_within() internally uses pfn_section_valid(), but gates it
> with early_section() to preserve the traditional behavior of pfn_valid()
> before subsection support was added.
> 
> pfn_to_online_page() wants the explicit precision that pfn_valid() does
> not offer, so use pfn_section_valid() directly. Since
> pfn_to_online_page() already open codes the validity of the section
> number vs NR_MEM_SECTIONS, there's not much value to using
> pfn_valid_within(), just use pfn_section_valid(). This loses the
> valid_section() check that pfn_valid_within() was performing, but that
> was already redundant with the online check.
> 
> Fixes: b13bc35193d9 ("mm/hotplug: invalid PFNs from pfn_to_online_page()")
> Cc: Qian Cai <cai@lca.pw>
> Cc: Michal Hocko <mhocko@suse.com>
> Reported-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memory_hotplug.c |   16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 55a69d4396e7..a845b3979bc0 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -308,11 +308,19 @@ static int check_hotplug_memory_addressable(unsigned long pfn,
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
> +	if (!pfn_section_valid(ms, pfn))
> +		return NULL;

That's not sufficient for alternative implementations of pfn_valid().

You still need some kind of pfn_valid(pfn) for alternative versions of
pfn_valid(). Consider arm64 memory holes in the memmap. See their
current (yet to be fixed/reworked) pfn_valid() implementation.
(pfn_valid_within() is implicitly active on arm64)

Actually, I think we should add something like the following, to make
this clearer (pfn_valid_within() is confusing)

#ifdef CONFIG_HAVE_ARCH_PFN_VALID
	/* We might have to check for holes inside the memmap. */
	if (!pfn_valid())
		return NULL;
#endif

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
Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

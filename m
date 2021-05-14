Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2AC38056C
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 May 2021 10:43:41 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CD297100EAB00;
	Fri, 14 May 2021 01:43:38 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 772B7100EAAFD
	for <linux-nvdimm@lists.01.org>; Fri, 14 May 2021 01:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620981814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lsAavQGtZZQfxxuNta+2PaMZ+gKpW3kyTUx2+4IIAWk=;
	b=YxlcmwxVHOceWjTKAGrIUdEot99VucH4vxjA3qjNsFknrZE7IXHazHM13viWykVqBYy5X5
	VM71SW5cAV+9j5Ym6YI6WGbtkINZy3T2wJUjOcktgu6sJWqNVprSe1SzUqtQkob8aT1KH+
	jmNR+YduELejNqcSBKUmHafKfcTRvj0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-Hr_2ie9nN6m90Im7G9VNXg-1; Fri, 14 May 2021 04:43:32 -0400
X-MC-Unique: Hr_2ie9nN6m90Im7G9VNXg-1
Received: by mail-ej1-f70.google.com with SMTP id m18-20020a1709062352b02903d2d831f9baso1196513eja.20
        for <linux-nvdimm@lists.01.org>; Fri, 14 May 2021 01:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lsAavQGtZZQfxxuNta+2PaMZ+gKpW3kyTUx2+4IIAWk=;
        b=tEyCuOJIfOtmE2IVIzoWk9/EXyu3cmipuq3GrR15uFRwSEHZGyVXEAIpbcKiGtgYye
         zSDdJ84DTWevnkspSpzthddsJUqrDedY/DsVTv4uNXXkEhQ0IkQRH1khLtmdw7bkmULR
         hjB6QghRRGTWsrtmOET/LgXB9bxGjixPThPpN9YB4dsMYk83sj8ycYDWOaFnr9D6Qhmv
         AeDOjr7v1Gc7VD2FTqS7te14l6bKeUwkbzN9//PN4oyiOPzwIt0GsDnoUMc5NaQagAWk
         5RorSKyh4Fj552Icmc/9NUrHm6At3XHqmfkbinwiON6ejgkMEaBp8dwpg+hNqauVr+31
         w7Ow==
X-Gm-Message-State: AOAM533TDCicdalCrYVCRr1MoYV+NTj+jiHv9rKN8feOqAjQHTQO0Qhp
	vPBp42B7z1JDcLoYg8yF8UV2QX2LEOqKDim8cNEcOPl8/yXjpkoWXmcXMNoaWtZOcCE83lyNB57
	cGcKsKioBkTCIF3jzg2tL
X-Received: by 2002:a50:ed0c:: with SMTP id j12mr54641132eds.12.1620981811578;
        Fri, 14 May 2021 01:43:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypI4ge2hxqi/JfrvWJM2sA3w80IXDC+WmQ5wQdEdZZtqA+keJm9IEpbNTASfWRrXFPNSGQBQ==
X-Received: by 2002:a50:ed0c:: with SMTP id j12mr54641100eds.12.1620981811327;
        Fri, 14 May 2021 01:43:31 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6501.dip0.t-ipconnect.de. [91.12.101.1])
        by smtp.gmail.com with ESMTPSA id k12sm3969468edo.50.2021.05.14.01.43.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 01:43:31 -0700 (PDT)
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
References: <20210513184734.29317-1-rppt@kernel.org>
 <20210513184734.29317-4-rppt@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v19 3/8] set_memory: allow set_direct_map_*_noflush() for
 multiple pages
Message-ID: <858e5561-bc7d-4ce1-5cb8-3c333199d52a@redhat.com>
Date: Fri, 14 May 2021 10:43:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210513184734.29317-4-rppt@kernel.org>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Message-ID-Hash: 2LT7HWYHVG47WF4PM77YUIUXYYEAZNZ7
X-Message-ID-Hash: 2LT7HWYHVG47WF4PM77YUIUXYYEAZNZ7
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Hagen Paul Pfeifer <hagen@jauu.net>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, Kees Cook <keescook@chromium.org>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Palmer Dabbelt <palmerdabbelt@google.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rick Edgecombe <rick.p.edgecombe@intel.c
 om>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2LT7HWYHVG47WF4PM77YUIUXYYEAZNZ7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 13.05.21 20:47, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The underlying implementations of set_direct_map_invalid_noflush() and
> set_direct_map_default_noflush() allow updating multiple contiguous pages
> at once.
> 
> Add numpages parameter to set_direct_map_*_noflush() to expose this
> ability with these APIs.
> 

[...]

Finally doing some in-depth review, sorry for not having a detailed look 
earlier.


>   
> -int set_direct_map_invalid_noflush(struct page *page)
> +int set_direct_map_invalid_noflush(struct page *page, int numpages)
>   {
>   	struct page_change_data data = {
>   		.set_mask = __pgprot(0),
>   		.clear_mask = __pgprot(PTE_VALID),
>   	};
> +	unsigned long size = PAGE_SIZE * numpages;
>   

Nit: I'd have made this const and added an early exit for !numpages. But 
whatever you prefer.

>   	if (!debug_pagealloc_enabled() && !rodata_full)
>   		return 0;
>   
>   	return apply_to_page_range(&init_mm,
>   				   (unsigned long)page_address(page),
> -				   PAGE_SIZE, change_page_range, &data);
> +				   size, change_page_range, &data);
>   }
>   
> -int set_direct_map_default_noflush(struct page *page)
> +int set_direct_map_default_noflush(struct page *page, int numpages)
>   {
>   	struct page_change_data data = {
>   		.set_mask = __pgprot(PTE_VALID | PTE_WRITE),
>   		.clear_mask = __pgprot(PTE_RDONLY),
>   	};
> +	unsigned long size = PAGE_SIZE * numpages;
>   

Nit: dito

>   	if (!debug_pagealloc_enabled() && !rodata_full)
>   		return 0;
>   
>   	return apply_to_page_range(&init_mm,
>   				   (unsigned long)page_address(page),
> -				   PAGE_SIZE, change_page_range, &data);
> +				   size, change_page_range, &data);
>   }
>   


[...]

>   extern int kernel_set_to_readonly;
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 156cd235659f..15a55d6e9cec 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -2192,14 +2192,14 @@ static int __set_pages_np(struct page *page, int numpages)
>   	return __change_page_attr_set_clr(&cpa, 0);
>   }
>   
> -int set_direct_map_invalid_noflush(struct page *page)
> +int set_direct_map_invalid_noflush(struct page *page, int numpages)
>   {
> -	return __set_pages_np(page, 1);
> +	return __set_pages_np(page, numpages);
>   }
>   
> -int set_direct_map_default_noflush(struct page *page)
> +int set_direct_map_default_noflush(struct page *page, int numpages)
>   {
> -	return __set_pages_p(page, 1);
> +	return __set_pages_p(page, numpages);
>   }
>   

So, what happens if we succeeded setting 
set_direct_map_invalid_noflush() for some pages but fail when having to 
split a large mapping?

Did I miss something or would the current code not undo what it 
partially did? Or do we simply not care?

I guess to handle this cleanly we would either have to catch all error 
cases first (esp. splitting large mappings) before actually performing 
the set to invalid, or have some recovery code in place if possible.


AFAIKs, your patch #5 right now only calls it with 1 page, do we need 
this change at all? Feels like a leftover from older versions to me 
where we could have had more than a single page.

-- 
Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

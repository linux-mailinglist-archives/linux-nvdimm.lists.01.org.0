Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B614B365BFD
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Apr 2021 17:18:10 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F307E100F225F;
	Tue, 20 Apr 2021 08:18:08 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6DB40100F2253
	for <linux-nvdimm@lists.01.org>; Tue, 20 Apr 2021 08:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1618931885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I5ndW6k8mLw6k1PzLhNPYJ9rDrEc5/TU+m57YMg1P3Q=;
	b=UrPlVhjWDaLk4RVN4cLnO0aKDPAwwNIKl+B6u60ZjOfgyRA7XXvRLr8PdyMT0eehA8p6CQ
	pSx8VjU7tfQssUI+9T+SVOpRQoAP+4urmovYhb5p1RhF1ev9q5ucmHmXY5xedCzwk0L8Ov
	tIWjZ4L4+VM52H5OIjEwrypdPEirz1I=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-7fwl6S8WOBifmLfJAT1z_g-1; Tue, 20 Apr 2021 11:18:02 -0400
X-MC-Unique: 7fwl6S8WOBifmLfJAT1z_g-1
Received: by mail-ej1-f70.google.com with SMTP id d16-20020a1709066410b0290373cd3ce7e6so4900633ejm.14
        for <linux-nvdimm@lists.01.org>; Tue, 20 Apr 2021 08:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=I5ndW6k8mLw6k1PzLhNPYJ9rDrEc5/TU+m57YMg1P3Q=;
        b=ZQMLa5ghVX2Zr4i1aWq/GThU9Idkq4nupdpjgSxoTlZNO2PZ46mfneeikDlK+Z2wCa
         Ag/JWDpKTMV828iyExOUoHoE80Mkk+yAU1/6qTg1m4x/nP63O4NNj1NXU5z2e/+oeJQM
         EYktQUbnnudMzrs5x1bMJWO5QDTdCqnC50kpCqSlIkbfU9NuEE5ygSzsxFlNf5ikKRQX
         pxqvqVZ/c9kg5cEdzDE6waCoT2ctqSFWUI5pV2r0aQlCziQWFEfXVBiyaKNjb7EGEB5Q
         e3s+qUMp82MoSHLKsqhbK/Wq19x9CvD0Y/JGcIfqhrkQTTM2DpNGGqJy2nhw6hyUGAqy
         MRxQ==
X-Gm-Message-State: AOAM5321xid89QGCIfFnM610zC63MarNnt6Y1y5cKEGDex0+9VRmpnAH
	XemAWxB5eygpkqWV2uGZpEDk5e3WuaiRmq5m7iXt41krSF3HoLaiRLE8bAJKy92JsUpc2K09D08
	frcapOQ4Tt7uSdIt2rISL
X-Received: by 2002:aa7:c683:: with SMTP id n3mr32232732edq.214.1618931880951;
        Tue, 20 Apr 2021 08:18:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKrP/Z3igfJPaQi8yJZtC2FjNZPIjMXhA64NexGRfIVc/CrlZnXvE6wVD3xtThrpBxYqmr/Q==
X-Received: by 2002:aa7:c683:: with SMTP id n3mr32232708edq.214.1618931880725;
        Tue, 20 Apr 2021 08:18:00 -0700 (PDT)
Received: from [192.168.3.132] (p4ff2390a.dip0.t-ipconnect.de. [79.242.57.10])
        by smtp.gmail.com with ESMTPSA id a17sm13193206ejx.13.2021.04.20.08.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 08:18:00 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] secretmem/gup: don't check if page is secretmem
 without reference
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
References: <20210420150049.14031-1-rppt@kernel.org>
 <20210420150049.14031-2-rppt@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <f906a634-ee25-5a8b-6cdf-3651832dbe99@redhat.com>
Date: Tue, 20 Apr 2021 17:17:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210420150049.14031-2-rppt@kernel.org>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Message-ID-Hash: 4QSEVTB5EWNKE2OLX5BCEBBSTK4MBPCK
X-Message-ID-Hash: 4QSEVTB5EWNKE2OLX5BCEBBSTK4MBPCK
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixn
 er <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4QSEVTB5EWNKE2OLX5BCEBBSTK4MBPCK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 20.04.21 17:00, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The check in gup_pte_range() whether a page belongs to a secretmem mapping
> is performed before grabbing the page reference.
> 
> To avoid potential race move the check after try_grab_compound_head().
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>   mm/gup.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index c3a17b189064..6515f82b0f32 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2080,13 +2080,15 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>   		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
>   		page = pte_page(pte);
>   
> -		if (page_is_secretmem(page))
> -			goto pte_unmap;
> -
>   		head = try_grab_compound_head(page, 1, flags);
>   		if (!head)
>   			goto pte_unmap;
>   
> +		if (unlikely(page_is_secretmem(page))) {
> +			put_compound_head(head, 1, flags);
> +			goto pte_unmap;
> +		}
> +
>   		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
>   			put_compound_head(head, 1, flags);
>   			goto pte_unmap;
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

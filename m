Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F653659D5
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Apr 2021 15:20:12 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0F3FA100F2242;
	Tue, 20 Apr 2021 06:20:11 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8C622100EB35B
	for <linux-nvdimm@lists.01.org>; Tue, 20 Apr 2021 06:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1618924807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QYX7/AuHi6hgPHf6tRYqK2+HrNaM+fnSnNKD7KzrRzs=;
	b=fTJz8bd2ajNGxw3Wb3iuvAa697e6s5nqngRdfCpc4QSuwXa+4b3Ns021ap1NSxes5I1tkU
	vN00C0U/pMpPm++E9UBYrjezKjQRjvV3Xv818NwieI100DoaVSw8pF9PkD3vfPXuiMw1UX
	IInzwU2vtekwVA6cAfRr7XzgGkT2PtA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-DnuIzfQPNm2qwQFz99ZSkg-1; Tue, 20 Apr 2021 09:20:00 -0400
X-MC-Unique: DnuIzfQPNm2qwQFz99ZSkg-1
Received: by mail-wr1-f72.google.com with SMTP id v20-20020a5d59140000b02901028c7a1f7dso10862436wrd.18
        for <linux-nvdimm@lists.01.org>; Tue, 20 Apr 2021 06:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=QYX7/AuHi6hgPHf6tRYqK2+HrNaM+fnSnNKD7KzrRzs=;
        b=eKXo7pCmDvwykzQvylQ1NMURPje7GdMbiDj5FlALHwJ2EnDm6nhokId2bpifwFZgI8
         vkwDRBDSyv96kBDOHudVloigB2j5BoOm50t8MLaHowg+wYPhYrNUqSG7Ix6oIhAH9cId
         dZotCKkJBaTR2jwCUKpz1ltxv9ipxuv95J74+MaKtu0/kSsqhPIcXST9agJH8lAHw4wn
         dNcit+ZtE/2+7RHm2aMR8KI6f1GCMIZjzM0iCAPa3pIohtjGjIXXr0YjmyQ9wPe3wybQ
         UOYtx7qlH4ggNiH5XurtHs0TOfXfKWfE4oYUTIQmFRF5jNysVrtcaXmUDDxz+l/N3t/e
         WeYA==
X-Gm-Message-State: AOAM532wiwa3dsXNB8HKFjUaDbxTK8+LiHKEgOWPa7xNddwmokCvUWht
	WQrs0xjuz+jQhoemvX1FpR+A1y6yL6IEC+/pAsuj7YmlbTEIcje2RChD0LjMaSSZkJZE7436Hhf
	kA7GYetDzbaQqvQyXQVWT
X-Received: by 2002:a05:6000:128f:: with SMTP id f15mr20916798wrx.19.1618924799173;
        Tue, 20 Apr 2021 06:19:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfOGjRv02X/zmH7pcY7EIgqs8w+z5KR0gU0RfoaYN+dlGesRC5fI0lFDDiwZRbvB39JmbKYA==
X-Received: by 2002:a05:6000:128f:: with SMTP id f15mr20916761wrx.19.1618924798995;
        Tue, 20 Apr 2021 06:19:58 -0700 (PDT)
Received: from [192.168.3.132] (p4ff2390a.dip0.t-ipconnect.de. [79.242.57.10])
        by smtp.gmail.com with ESMTPSA id f6sm3291518wmf.28.2021.04.20.06.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 06:19:58 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] secretmem/gup: don't check if page is secretmem
 without reference
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
References: <20210420131611.8259-1-rppt@kernel.org>
 <20210420131611.8259-2-rppt@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <95b7fa81-f72e-c63f-0456-4c25dee8a5eb@redhat.com>
Date: Tue, 20 Apr 2021 15:19:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210420131611.8259-2-rppt@kernel.org>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Message-ID-Hash: 3K5EPOSMCU35CSWN4DNLWKZ7FZL7ZKQS
X-Message-ID-Hash: 3K5EPOSMCU35CSWN4DNLWKZ7FZL7ZKQS
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixn
 er <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3K5EPOSMCU35CSWN4DNLWKZ7FZL7ZKQS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 20.04.21 15:16, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The check in gup_pte_range() whether a page belongs to a secretmem mapping
> is performed before grabbing the page reference.
> 
> To avoid potential race move the check after try_grab_compound_head().
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>   mm/gup.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index c3a17b189064..4b58c016e949 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2080,13 +2080,13 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
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
> +		if (page_is_secretmem(page))
> +			goto pte_unmap;
> +

Looking at the hunk below, I wonder if you're missing a put_compound_head().

(also, I'd do if unlikely(page_is_secretmem()) but that's a different 
discussion)

>   		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
>   			put_compound_head(head, 1, flags);
>   			goto pte_unmap;
> 


-- 
Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

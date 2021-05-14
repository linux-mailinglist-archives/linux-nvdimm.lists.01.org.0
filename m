Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5D0380534
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 May 2021 10:28:05 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 41C7C100EBB97;
	Fri, 14 May 2021 01:28:04 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E4466100EC1E3
	for <linux-nvdimm@lists.01.org>; Fri, 14 May 2021 01:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620980879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1mI4ocY2raC+FaNmp1QLwbvQ7SwKQVD3QJeG7UD1jEM=;
	b=jQSIZJuwg3mxvsoLfCmRNAtWWy8oOC6ENhojXt+RPnQYLzt5QdNbFnBPxVDiSjDSBsm0/S
	SxMYM2aVM19w0J37TFjhCS0xhpSQTdtx/BWW1pc9hTOv3NGX/sicVHGmYDmGY+3d7xUSVi
	A5tVTSceSOdlxenphwKGWTIBIaDCZzk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-iENLPJSIPKOgTUatRLCSiA-1; Fri, 14 May 2021 04:27:56 -0400
X-MC-Unique: iENLPJSIPKOgTUatRLCSiA-1
Received: by mail-ej1-f69.google.com with SMTP id h4-20020a1709067184b02903cbbd4c3d8fso4499778ejk.6
        for <linux-nvdimm@lists.01.org>; Fri, 14 May 2021 01:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1mI4ocY2raC+FaNmp1QLwbvQ7SwKQVD3QJeG7UD1jEM=;
        b=i1whip7cVOKTBijkLNu4Qh3VQyJPRMqZHtK+GTYKX2NKK/n2V3Yagqy/a9gekAC9Le
         PQlqpZ28PK7NH9jmroGgkKLxTkH42l78VKNooZdiqh3Oje8ym5WFAYKJXU5yJib5LAzp
         bQsb/Ur91qfTsKPV3K6sPIHegt/0Skmz3yxVisqtr4mOQ3euEnZio5f9jB3Ban71NWvu
         XkISR6LrgPes6SNmHUl02RrDTNi2rV9LmtLhZG9zitv1aeRGHFv17ri66jHpKXLYr1av
         N4SC3mfrqM7Ok50Yf2DYG/OE/lTZuSPTERFEhUzaB73TwDrMkYafvfSu7c5eqkxT4yWL
         4Q/A==
X-Gm-Message-State: AOAM531GvfKZjekuVGZoXX7c+WcPVE9f1vJ0VAqar/ZJrBHl8maHAmIp
	RHv3lGAnXj1qzuvSj/SglmLESfoEjU3hmWUq1fRDeNc/A8Yx8yh+Dz+jpVBFwN42nirC+DrZhiu
	i6KHcrZ+yag6MaGVXQZbk
X-Received: by 2002:a17:907:2136:: with SMTP id qo22mr5727128ejb.246.1620980875434;
        Fri, 14 May 2021 01:27:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYM3IfGE3NxrG0ZrIWpmGkbHrM02LfrvrKJb1wjjik/A6PZcbISFg2IAai8LzSK6j7yfSBCQ==
X-Received: by 2002:a17:907:2136:: with SMTP id qo22mr5726935ejb.246.1620980873769;
        Fri, 14 May 2021 01:27:53 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6501.dip0.t-ipconnect.de. [91.12.101.1])
        by smtp.gmail.com with ESMTPSA id z26sm3292663ejl.38.2021.05.14.01.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 01:27:53 -0700 (PDT)
Subject: Re: [PATCH v19 1/8] mmap: make mlock_future_check() global
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
References: <20210513184734.29317-1-rppt@kernel.org>
 <20210513184734.29317-2-rppt@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <8bb6ca25-5d30-70e6-c590-5930832ec9b2@redhat.com>
Date: Fri, 14 May 2021 10:27:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210513184734.29317-2-rppt@kernel.org>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Message-ID-Hash: KOPB4F3PFPGBPOYJTGZL7YY7EUIARH5G
X-Message-ID-Hash: KOPB4F3PFPGBPOYJTGZL7YY7EUIARH5G
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Hagen Paul Pfeifer <hagen@jauu.net>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, Kees Cook <keescook@chromium.org>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Palmer Dabbelt <palmerdabbelt@google.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rick Edgecombe <rick.p.edgecombe@intel.c
 om>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KOPB4F3PFPGBPOYJTGZL7YY7EUIARH5G/>
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
> It will be used by the upcoming secret memory implementation.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Christopher Lameter <cl@linux.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Elena Reshetova <elena.reshetova@intel.com>
> Cc: Hagen Paul Pfeifer <hagen@jauu.net>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: James Bottomley <jejb@linux.ibm.com>
> Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Tycho Andersen <tycho@tycho.ws>
> Cc: Will Deacon <will@kernel.org>
> ---
>   mm/internal.h | 3 +++
>   mm/mmap.c     | 5 ++---
>   2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 54bd0dc2c23c..46eb82eaa195 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -373,6 +373,9 @@ static inline void munlock_vma_pages_all(struct vm_area_struct *vma)
>   extern void mlock_vma_page(struct page *page);
>   extern unsigned int munlock_vma_page(struct page *page);
>   
> +extern int mlock_future_check(struct mm_struct *mm, unsigned long flags,
> +			      unsigned long len);
> +
>   /*
>    * Clear the page's PageMlocked().  This can be useful in a situation where
>    * we want to unconditionally remove a page from the pagecache -- e.g.,
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 0584e540246e..81f5595a8490 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1352,9 +1352,8 @@ static inline unsigned long round_hint_to_min(unsigned long hint)
>   	return hint;
>   }
>   
> -static inline int mlock_future_check(struct mm_struct *mm,
> -				     unsigned long flags,
> -				     unsigned long len)
> +int mlock_future_check(struct mm_struct *mm, unsigned long flags,
> +		       unsigned long len)
>   {
>   	unsigned long locked, lock_limit;
>   
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

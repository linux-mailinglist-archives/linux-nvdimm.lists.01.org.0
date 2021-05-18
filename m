Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3D03876A2
	for <lists+linux-nvdimm@lfdr.de>; Tue, 18 May 2021 12:35:46 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1398C100F224B;
	Tue, 18 May 2021 03:35:45 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A2FB7100F2243
	for <linux-nvdimm@lists.01.org>; Tue, 18 May 2021 03:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1621334141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4vp8lNy9snZR0aaM1NkHvO7WK4qnZ3T1+NZIbLJBP3o=;
	b=IqXaHFo9zpj78XNPpcpDfJf4LPFKu0hP1fZbJXefD6Lnr/sM3c/nnVQOTnNm1kCoWUOQOB
	+5Ik0wgU6Og+rTEa0X9VRjxXLQn01jeSWAfSkO/bws4qSBV2t2cd9FimKdhL3dECNr7eZC
	SlU522kqhceEUPsWUrGp7VFVsxoVuOQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-AH4PXvlgN7SQnGVKRtWWCg-1; Tue, 18 May 2021 06:35:40 -0400
X-MC-Unique: AH4PXvlgN7SQnGVKRtWWCg-1
Received: by mail-wr1-f70.google.com with SMTP id 36-20020adf91a70000b029010ec34b3f27so5397947wri.10
        for <linux-nvdimm@lists.01.org>; Tue, 18 May 2021 03:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4vp8lNy9snZR0aaM1NkHvO7WK4qnZ3T1+NZIbLJBP3o=;
        b=KBj2NLL5N8+/HG5pkbpcOI0zDhc0sGBuplhiEFX12rpsjQm2JF2Ra2LO/SN7WEcSC9
         po75D9vGexcQVtnitF9kvNHfolrr5VXQ7gAqBOlE614emvVRF1H+Em7eGGNOC9YzAf4A
         MSvwjMlNsdD6Cbu7EOZf+OOKQt04Ortv8d6Y/EHFrX5IlEpumIMyaNcxanNWVDfVCOIW
         WyOLRZRTvGFQWthYj+uNBFmV/A/CRCpa0NKG5kzlrXC1wgBGu8fGAoLnsnhrke+kfim6
         YhIKxTyczSLuuqf0hm2/O2Ed97PYKiNClcRm33M2U44xmDH9gqBkE24ZXmy/rKEODpWx
         Rj7Q==
X-Gm-Message-State: AOAM533e4YP8bjUiY6wEjMhMvA2TiUeY6fmFhhka29TzXGuSHqOOms37
	YZ9ZhWTUojplWZjFkrZyOvW8Aj96BkI9HD5ShkdFH1JffDF+l087broorMvpNbivWiE620lqeXA
	spJDz7jqqrjTMM7s3jb/7
X-Received: by 2002:a5d:4c91:: with SMTP id z17mr6097383wrs.349.1621334139172;
        Tue, 18 May 2021 03:35:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwivDOaaOEtmmfekeSrzIxF+whFkS4KLINBSXbPJdxKCFo9r8ATuUwdqMoXxsMMTM3AMH6k8g==
X-Received: by 2002:a5d:4c91:: with SMTP id z17mr6097320wrs.349.1621334138962;
        Tue, 18 May 2021 03:35:38 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64fd.dip0.t-ipconnect.de. [91.12.100.253])
        by smtp.gmail.com with ESMTPSA id s15sm1725827wrt.54.2021.05.18.03.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 03:35:38 -0700 (PDT)
Subject: Re: [PATCH v19 5/8] mm: introduce memfd_secret system call to create
 "secret" memory areas
To: Michal Hocko <mhocko@suse.com>
References: <20210513184734.29317-1-rppt@kernel.org>
 <20210513184734.29317-6-rppt@kernel.org>
 <b625c5d7-bfcc-9e95-1f79-fc8b61498049@redhat.com>
 <YKDJ1L7XpJRQgSch@kernel.org> <YKOP5x8PPbqzcsdK@dhcp22.suse.cz>
 <8e114f09-60e4-2343-1c42-1beaf540c150@redhat.com>
 <YKOXbNWvUsqM4uxb@dhcp22.suse.cz>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <00644dd8-edac-d3fd-a080-0a175fa9bf13@redhat.com>
Date: Tue, 18 May 2021 12:35:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YKOXbNWvUsqM4uxb@dhcp22.suse.cz>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Message-ID-Hash: IPBAYYQGGXI7SELWSCLBDBSNLISXEK2J
X-Message-ID-Hash: IPBAYYQGGXI7SELWSCLBDBSNLISXEK2J
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Hagen Paul Pfeifer <hagen@jauu.net>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, Kees Cook <keescook@chromium.org>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Palmer Dabbelt <palmerdabbelt@google.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.ne
 t>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IPBAYYQGGXI7SELWSCLBDBSNLISXEK2J/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 18.05.21 12:31, Michal Hocko wrote:
> On Tue 18-05-21 12:06:42, David Hildenbrand wrote:
>> On 18.05.21 11:59, Michal Hocko wrote:
>>> On Sun 16-05-21 10:29:24, Mike Rapoport wrote:
>>>> On Fri, May 14, 2021 at 11:25:43AM +0200, David Hildenbrand wrote:
>>> [...]
>>>>>> +		if (!page)
>>>>>> +			return VM_FAULT_OOM;
>>>>>> +
>>>>>> +		err = set_direct_map_invalid_noflush(page, 1);
>>>>>> +		if (err) {
>>>>>> +			put_page(page);
>>>>>> +			return vmf_error(err);
>>>>>
>>>>> Would we want to translate that to a proper VM_FAULT_..., which would most
>>>>> probably be VM_FAULT_OOM when we fail to allocate a pagetable?
>>>>
>>>> That's what vmf_error does, it translates -ESOMETHING to VM_FAULT_XYZ.
>>>
>>> I haven't read through the rest but this has just caught my attention.
>>> Is it really reasonable to trigger the oom killer when you cannot
>>> invalidate the direct mapping. From a quick look at the code it is quite
>>> unlikely to se ENOMEM from that path (it allocates small pages) but this
>>> can become quite sublte over time. Shouldn't this simply SIGBUS if it
>>> cannot manipulate the direct mapping regardless of the underlying reason
>>> for that?
>>>
>>
>> OTOH, it means our kernel zones are depleted, so we'd better reclaim somehow
>> ...
> 
> Killing a userspace seems to be just a bad way around that.
> 
> Although I have to say openly that I am not a great fan of VM_FAULT_OOM
> in general. It is usually a a wrong way to tell the handle the failure
> because it happens outside of the allocation context so you lose all the
> details (e.g. allocation constrains, numa policy etc.). Also whenever
> there is ENOMEM then the allocation itself has already made sure that
> all the reclaim attempts have been already depleted. Just consider an
> allocation with GFP_NOWAIT/NO_RETRY or similar to fail and propagate
> ENOMEM up the call stack. Turning that into the OOM killer sounds like a
> bad idea to me.  But that is a more general topic. I have tried to bring
> this up in the past but there was not much of an interest to fix it as
> it was not a pressing problem...
> 

I'm certainly interested; it would mean that we actually want to try 
recovering from VM_FAULT_OOM in various cases, and as you state, we 
might have to supply more information to make that work reliably.

Having that said, I guess what we have here is just the same as when our 
process fails to allocate a generic page table in __handle_mm_fault(), 
when we fail p4d_alloc() and friends ...

-- 
Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

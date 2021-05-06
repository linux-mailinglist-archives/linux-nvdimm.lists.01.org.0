Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A34837593A
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 May 2021 19:24:58 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B9FF7100EAB4C;
	Thu,  6 May 2021 10:24:55 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id ED612100EAB48
	for <linux-nvdimm@lists.01.org>; Thu,  6 May 2021 10:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620321891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jExgBas4mYe2R7HQ1xBXEHvzUr1CEHDDU82ObrbRp1A=;
	b=Zprs+We8YJKNQI7wqY+jnyt7VOI7zKEjcB/hOByIA7M2n3owXFCC9SQSU6C01T4ocqQvFz
	gd9jobauY3TBt/B5+KeFFaYFmixYnYFr6mGuduCWsJsnr6RfwoAsO9rRDFocOXe6lZsufU
	bf2RysGPPpdOvYshmqMakHO2lDf75yY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-600-DWqXojxCPGqsXAO2-cTELg-1; Thu, 06 May 2021 13:24:50 -0400
X-MC-Unique: DWqXojxCPGqsXAO2-cTELg-1
Received: by mail-ed1-f71.google.com with SMTP id i2-20020a0564020542b02903875c5e7a00so3009948edx.6
        for <linux-nvdimm@lists.01.org>; Thu, 06 May 2021 10:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jExgBas4mYe2R7HQ1xBXEHvzUr1CEHDDU82ObrbRp1A=;
        b=nbLGZiLOUW4VmIUhof4D3vy0mBkEVIpodKJCi0MCVOVTpD3EUInvyZknXJcfr+FGf4
         Yng7Gx+F2MiAqj2Ckk0G5eWt7GcXdygdWF1jRU/CKsEOOBAV6o834AXmAjow1wi1MWvQ
         Wu6Lbn+jCO2Bx95YTC61AXijbQQeOIzorh5nSd1M89tmZCYT/y9fTLI0g8R62X+jV9h6
         2UWkszK2A/2O5Hwozge/OCQI/GwWnFN1ppWsAqBrM1WLeMPCbRuCMtVmteNvO/2xGT0G
         y6OvSWCRzglweImx/yDFq/RKXc83k3jPOIepxES4pRWn3MgAyqwTEj7mHvH0zl+xG1ng
         xY6w==
X-Gm-Message-State: AOAM532YWrzObkfGnPU/56kiPhNkDnsX5J5m3HnSJDLIC1WJapQ1t/yl
	Cs7xIYchL9VL2cV5ahSAicXXRq2RTXd9NGV6MG9PZzC3U2/YUmoe8/XP6iLHSgo3Vyhv4wYUDce
	B63Y9w69YRafW4GHVA7Wr
X-Received: by 2002:aa7:d952:: with SMTP id l18mr6506818eds.83.1620321888968;
        Thu, 06 May 2021 10:24:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0HYEbkAPLbEzE0RQH/Kg006zDXqRhpGiJee/o6TGxungGJENUOS9lWTxREQMEK2RJtQPDnQ==
X-Received: by 2002:aa7:d952:: with SMTP id l18mr6506560eds.83.1620321885798;
        Thu, 06 May 2021 10:24:45 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64ae.dip0.t-ipconnect.de. [91.12.100.174])
        by smtp.gmail.com with ESMTPSA id y19sm2147544edc.73.2021.05.06.10.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 10:24:45 -0700 (PDT)
To: jejb@linux.ibm.com, Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>
References: <20210303162209.8609-1-rppt@kernel.org>
 <20210505120806.abfd4ee657ccabf2f221a0eb@linux-foundation.org>
 <de27bfae0f4fdcbb0bb4ad17ec5aeffcd774c44b.camel@linux.ibm.com>
 <996dbc29-e79c-9c31-1e47-cbf20db2937d@redhat.com>
 <8eb933f921c9dfe4c9b1b304e8f8fa4fbc249d84.camel@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v18 0/9] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <a5b19a4f-5d7b-9840-fd70-67a39bc8969e@redhat.com>
Date: Thu, 6 May 2021 19:24:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <8eb933f921c9dfe4c9b1b304e8f8fa4fbc249d84.camel@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Message-ID-Hash: 3GD6NZRS7XCGWV5EHL7KMVMKF5IE4JWR
X-Message-ID-Hash: 3GD6NZRS7XCGWV5EHL7KMVMKF5IE4JWR
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Anderse
 n <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3GD6NZRS7XCGWV5EHL7KMVMKF5IE4JWR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

>>>> Is this intended to protect keys/etc after the attacker has
>>>> gained the ability to run arbitrary kernel-mode code?  If so,
>>>> that seems optimistic, doesn't it?
>>>
>>> Not exactly: there are many types of kernel attack, but mostly the
>>> attacker either manages to effect a privilege escalation to root or
>>> gets the ability to run a ROP gadget.  The object of this code is
>>> to be completely secure against root trying to extract the secret
>>> (some what similar to the lockdown idea), thus defeating privilege
>>> escalation and to provide "sufficient" protection against ROP
>>> gadget.
>>
>> What stops "root" from mapping /dev/mem and reading that memory?
> 
> /dev/mem uses the direct map for the copy at least for read/write, so
> it gets a fault in the same way root trying to use ptrace does.  I
> think we've protected mmap, but Mike would know that better than I.
> 

I'm more concerned about the mmap case -> remap_pfn_range(). Anybody 
going via the VMA shouldn't see the struct page, at least when 
vma_normal_page() is properly used; so you cannot detect secretmem
memory mapped via /dev/mem reliably. At least that's my theory :)

[...]

>> Also, there is a way to still read that memory when root by
>>
>> 1. Having kdump active (which would often be the case, but maybe not
>> to dump user pages )
>> 2. Triggering a kernel crash (easy via proc as root)
>> 3. Waiting for the reboot after kump() created the dump and then
>> reading the content from disk.
> 
> Anything that can leave physical memory intact but boot to a kernel
> where the missing direct map entry is restored could theoretically
> extract the secret.  However, it's not exactly going to be a stealthy
> extraction ...
> 
>> Or, as an attacker, load a custom kexec() kernel and read memory
>> from the new environment. Of course, the latter two are advanced
>> mechanisms, but they are possible when root. We might be able to
>> mitigate, for example, by zeroing out secretmem pages before booting
>> into the kexec kernel, if we care :)
> 
> I think we could handle it by marking the region, yes, and a zero on
> shutdown might be useful ... it would prevent all warm reboot type
> attacks.

Right. But I guess when you're actually root, you can just write a 
kernel module to extract the information you need (unless we have signed 
modules, so it could be harder/impossible).

-- 
Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

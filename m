Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8503758A5
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 May 2021 18:45:19 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E9A69100EB355;
	Thu,  6 May 2021 09:45:16 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 57842100EC1CF
	for <linux-nvdimm@lists.01.org>; Thu,  6 May 2021 09:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620319513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0s/7VDcOT9Z56vBvGNlao04OZufq+cCm9HLSATOe2hs=;
	b=G5LPTYpGrR3Su1IYZH1gXqMZwyHEAvgcI0l4Cj1aXNS6shNfJON3gJTdPjf3ompWBEJ2LN
	EQ4LMPXce2x77OY4EVTML8jSDO6jIkyQXqcVhLCqvdmiBIhWvEUTbl/ljZkurD2bJc2szN
	j7l5HSE1oWhHw/AzrwaZ+Rj07xVscEk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234--_YesuR3PlKBsvu_T8-73Q-1; Thu, 06 May 2021 12:45:10 -0400
X-MC-Unique: -_YesuR3PlKBsvu_T8-73Q-1
Received: by mail-ej1-f71.google.com with SMTP id z15-20020a170906074fb029038ca4d43d48so1949031ejb.17
        for <linux-nvdimm@lists.01.org>; Thu, 06 May 2021 09:45:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0s/7VDcOT9Z56vBvGNlao04OZufq+cCm9HLSATOe2hs=;
        b=r5+oXpz+rONxZYRPV49MEpk1qOvbPfG/9w3RSAVgzVtaYWt3uXVsylHbgztR6b4jSx
         8PsO//NyoZ5RNtkW91IYfO2G13+B0pcThmd/qJI17OYcorGjhHtUIR1TrM1rhz0A9HH+
         PmWwHpv1Y2+mb99jWpjMM/B0gvNSHJNCE2BIhKVeGjVxZzmvAqjlYV8TBEloEmC+p2Si
         BD6JlPmxK6WQTh+qGGpg1MulGv80cSmZL2DqcLQzfOhkY+FKhdSlKeVP+vj6Z58rbnNA
         vMn4MLCJTyP2LQ6eujEw/cn4BW8HcHwuN2Ru04FybNMqAYbn6rqGKWW+fJynp4RznEJC
         9n6g==
X-Gm-Message-State: AOAM5337a4tq1eyP2tgbidmYDqaDFZ+BkXD0GRsdOsM8xC68Q8W84i5i
	sf5Qa/448KsK/kb5PLSBGeYK/jPWnMNRsSPp0d+98RrWYBgJlGHBDTAGPavgkkxD5BGr7rtI+hR
	+BBGUIgsq84CXz4WI2lLI
X-Received: by 2002:a17:907:1c98:: with SMTP id nb24mr5478137ejc.206.1620319508732;
        Thu, 06 May 2021 09:45:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzw+5/fwG+KvK+SBzoVexxr801GBTZ6Zrmz5O+rAzTFPxJI4yj9g+Ax3izTWEuuMsZJC630XQ==
X-Received: by 2002:a17:907:1c98:: with SMTP id nb24mr5478083ejc.206.1620319508409;
        Thu, 06 May 2021 09:45:08 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64ae.dip0.t-ipconnect.de. [91.12.100.174])
        by smtp.gmail.com with ESMTPSA id f19sm2095318edu.12.2021.05.06.09.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 09:45:08 -0700 (PDT)
To: jejb@linux.ibm.com, Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>
References: <20210303162209.8609-1-rppt@kernel.org>
 <20210505120806.abfd4ee657ccabf2f221a0eb@linux-foundation.org>
 <de27bfae0f4fdcbb0bb4ad17ec5aeffcd774c44b.camel@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v18 0/9] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <996dbc29-e79c-9c31-1e47-cbf20db2937d@redhat.com>
Date: Thu, 6 May 2021 18:45:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <de27bfae0f4fdcbb0bb4ad17ec5aeffcd774c44b.camel@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Message-ID-Hash: EXQVSP7OQAMC32UVWMPOFXORBY2A4ASY
X-Message-ID-Hash: EXQVSP7OQAMC32UVWMPOFXORBY2A4ASY
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Anderse
 n <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EXQVSP7OQAMC32UVWMPOFXORBY2A4ASY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 06.05.21 17:26, James Bottomley wrote:
> On Wed, 2021-05-05 at 12:08 -0700, Andrew Morton wrote:
>> On Wed,  3 Mar 2021 18:22:00 +0200 Mike Rapoport <rppt@kernel.org>
>> wrote:
>>
>>> This is an implementation of "secret" mappings backed by a file
>>> descriptor.
>>>
>>> The file descriptor backing secret memory mappings is created using
>>> a dedicated memfd_secret system call The desired protection mode
>>> for the memory is configured using flags parameter of the system
>>> call. The mmap() of the file descriptor created with memfd_secret()
>>> will create a "secret" memory mapping. The pages in that mapping
>>> will be marked as not present in the direct map and will be present
>>> only in the page table of the owning mm.
>>>
>>> Although normally Linux userspace mappings are protected from other
>>> users, such secret mappings are useful for environments where a
>>> hostile tenant is trying to trick the kernel into giving them
>>> access to other tenants mappings.
>>
>> I continue to struggle with this and I don't recall seeing much
>> enthusiasm from others.  Perhaps we're all missing the value point
>> and some additional selling is needed.
>>
>> Am I correct in understanding that the overall direction here is to
>> protect keys (and perhaps other things) from kernel bugs?  That if
>> the kernel was bug-free then there would be no need for this
>> feature?  If so, that's a bit sad.  But realistic I guess.
> 
> Secret memory really serves several purposes. The "increase the level
> of difficulty of secret exfiltration" you describe.  And, as you say,
> if the kernel were bug free this wouldn't be necessary.
> 
> But also:
> 
>     1. Memory safety for use space code.  Once the secret memory is
>        allocated, the user can't accidentally pass it into the kernel to be
>        transmitted somewhere.

That's an interesting point I didn't realize so far.

>     2. It also serves as a basis for context protection of virtual
>        machines, but other groups are working on this aspect, and it is
>        broadly similar to the secret exfiltration from the kernel problem.
> 

I was wondering if this also helps against CPU microcode issues like 
spectre and friends.

>>
>> Is this intended to protect keys/etc after the attacker has gained
>> the ability to run arbitrary kernel-mode code?  If so, that seems
>> optimistic, doesn't it?
> 
> Not exactly: there are many types of kernel attack, but mostly the
> attacker either manages to effect a privilege escalation to root or
> gets the ability to run a ROP gadget.  The object of this code is to be
> completely secure against root trying to extract the secret (some what
> similar to the lockdown idea), thus defeating privilege escalation and
> to provide "sufficient" protection against ROP gadget.

What stops "root" from mapping /dev/mem and reading that memory?

IOW, would we want to enforce "CONFIG_STRICT_DEVMEM" with CONFIG_SECRETMEM?


Also, there is a way to still read that memory when root by

1. Having kdump active (which would often be the case, but maybe not to 
dump user pages )
2. Triggering a kernel crash (easy via proc as root)
3. Waiting for the reboot after kump() created the dump and then reading 
the content from disk.

Or, as an attacker, load a custom kexec() kernel and read memory from 
the new environment. Of course, the latter two are advanced mechanisms, 
but they are possible when root. We might be able to mitigate, for 
example, by zeroing out secretmem pages before booting into the kexec 
kernel, if we care :)

-- 
Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

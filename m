Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4E338058F
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 May 2021 10:51:10 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 81B32100EAB02;
	Fri, 14 May 2021 01:51:06 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1D3B0100EAB00
	for <linux-nvdimm@lists.01.org>; Fri, 14 May 2021 01:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620982263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6IAZwI0xwEgxZkIPkaUDpjaSLTjanXMP6EohDn10+Y=;
	b=Xv+lWXvkm9VVnT/h9b7j31O0ACc6iIGPBceKV8ZI4vqeVmNi+otiI+JFk2DQvV1Sq0xGT1
	A24kmoH9EbD5bwrnU/kf35gwtr/t+kO4AYWmNnLIh8jxvJhJfJ+lYMqYiXjfAbmgTJmaY/
	p6dspY58kMQhu3gFc9gYsiXWt3s0BsU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-hT97ZoBcMYSE8yde-d0Ocw-1; Fri, 14 May 2021 04:50:59 -0400
X-MC-Unique: hT97ZoBcMYSE8yde-d0Ocw-1
Received: by mail-ed1-f69.google.com with SMTP id d8-20020a0564020008b0290387d38e3ce0so16029938edu.1
        for <linux-nvdimm@lists.01.org>; Fri, 14 May 2021 01:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=A6IAZwI0xwEgxZkIPkaUDpjaSLTjanXMP6EohDn10+Y=;
        b=DtSj4v6OHsA+C6kRKjnzx+7Zgh0BgRaSuGWsFFXIgd57I75lfHoO78csIw3ivIODRN
         CPU7cBRWd+wCVrL++jI/APv0ixznbw7rIfbeaOtnEq4w4MUeDq/MQpIMa4wZg29cGPl5
         CppRwFaBqqwWlvmuJ8Jd3G3Ddr6nWLioTZn8+Ozbme+mFeYbxaYDW0WQr71mx7MaLu0V
         fIOpQz8fbt2qF0PHdczfeNw0CJgmOPEXC2H5nOxLZH12+43pXCsmDs43hfmAA/47yWyL
         X6CQgqr0uuwP5OeVcp0Dl5MZl8JsKnT9Kn+x16DV4wMnTvlRfXpEcwzBhknb5gtnJRgx
         RA9w==
X-Gm-Message-State: AOAM53285sPU3uFiPsnGPYoj3R1X9v5LyDVdGqcrwkNZkthwSyMPdLOV
	NAVacpP7iCy4/qoWdzdWU06Ma1Zg/9ZRVtzDF00sHCpkx5/le11PEBkfrFvtleh3z9JM4gDw67c
	9k0bginGol+0XD+Wqpsik
X-Received: by 2002:aa7:de02:: with SMTP id h2mr54907467edv.61.1620982258491;
        Fri, 14 May 2021 01:50:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbFV5SCx4C1Oa2Pq/TZ05TRM0enPIT1usIgqsxFBagAMreWK04a8ZIkxs0DNaI7qx1TZ7bmg==
X-Received: by 2002:aa7:de02:: with SMTP id h2mr54907444edv.61.1620982258235;
        Fri, 14 May 2021 01:50:58 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6501.dip0.t-ipconnect.de. [91.12.101.1])
        by smtp.gmail.com with ESMTPSA id yw9sm3241097ejb.91.2021.05.14.01.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 01:50:57 -0700 (PDT)
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
References: <20210513184734.29317-1-rppt@kernel.org>
 <20210513184734.29317-6-rppt@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v19 5/8] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <ea1ddcfa-f52d-9a7d-cb7b-8502b38a90da@redhat.com>
Date: Fri, 14 May 2021 10:50:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210513184734.29317-6-rppt@kernel.org>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Message-ID-Hash: JLGLWAQF3X67S6BSSYQY5LQXDGLGNBVH
X-Message-ID-Hash: JLGLWAQF3X67S6BSSYQY5LQXDGLGNBVH
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Hagen Paul Pfeifer <hagen@jauu.net>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, Kees Cook <keescook@chromium.org>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Palmer Dabbelt <palmerdabbelt@google.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rick Edgecombe <rick.p.edgecombe@intel.c
 om>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JLGLWAQF3X67S6BSSYQY5LQXDGLGNBVH/>
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
> Introduce "memfd_secret" system call with the ability to create
> memory areas visible only in the context of the owning process and
> not mapped not only to other processes but in the kernel page tables
> as well.
> 
> The secretmem feature is off by default and the user must explicitly
> enable it at the boot time.
> 
> Once secretmem is enabled, the user will be able to create a file 
> descriptor using the memfd_secret() system call. The memory areas
> created by mmap() calls from this file descriptor will be unmapped
> from the kernel direct map and they will be only mapped in the page
> table of the processes that have access to the file descriptor.
> 
> The file descriptor based memory has several advantages over the 
> "traditional" mm interfaces, such as mlock(), mprotect(), madvise().
> File descriptor approach allows explict and controlled sharing of the
> memory

s/explict/explicit/

> areas, it allows to seal the operations. Besides, file descriptor
> based memory paves the way for VMMs to remove the secret memory range
> from the userpace hipervisor process, for instance QEMU. Andy
> Lutomirski says:

s/userpace hipervisor/userspace hypervisor/

> 
> "Getting fd-backed memory into a guest will take some possibly major
> work in the kernel, but getting vma-backed memory into a guest
> without mapping it in the host user address space seems much, much
> worse."
> 
> memfd_secret() is made a dedicated system call rather than an
> extention to

s/extention/extension/

> memfd_create() because it's purpose is to allow the user to create
> more secure memory mappings rather than to simply allow file based
> access to the memory. Nowadays a new system call cost is negligible
> while it is way simpler for userspace to deal with a clear-cut system
> calls than with a multiplexer or an overloaded syscall. Moreover, the
> initial implementation of memfd_secret() is completely distinct from
> memfd_create() so there is no much sense in overloading
> memfd_create() to begin with. If there will be a need for code
> sharing between these implementation it can be easily achieved
> without a need to adjust user visible APIs.
> 
> The secret memory remains accessible in the process context using
> uaccess primitives, but it is not exposed to the kernel otherwise;
> secret memory areas are removed from the direct map and functions in
> the follow_page()/get_user_page() family will refuse to return a page
> that belongs to the secret memory area.
> 
> Once there will be a use case that will require exposing secretmem to
> the kernel it will be an opt-in request in the system call flags so
> that user would have to decide what data can be exposed to the
> kernel.

Maybe spell out an example: like page migration.

> 
> Removing of the pages from the direct map may cause its fragmentation
> on architectures that use large pages to map the physical memory
> which affects the system performance. However, the original Kconfig
> text for CONFIG_DIRECT_GBPAGES said that gigabyte pages in the direct
> map "... can improve the kernel's performance a tiny bit ..." (commit
> 00d1c5e05736 ("x86: add gbpages switches")) and the recent report [1]
> showed that "... although 1G mappings are a good default choice,
> there is no compelling evidence that it must be the only choice".
> Hence, it is sufficient to have secretmem disabled by default with
> the ability of a system administrator to enable it at boot time.

Maybe add a link to the Intel performance evaluation.

> 
> Pages in the secretmem regions are unevictable and unmovable to
> avoid accidental exposure of the sensitive data via swap or during
> page migration.
> 
> Since the secretmem mappings are locked in memory they cannot exceed 
> RLIMIT_MEMLOCK. Since these mappings are already locked independently
> from mlock(), an attempt to mlock()/munlock() secretmem range would
> fail and mlockall()/munlockall() will ignore secretmem mappings.

Maybe add something like "similar to pages pinned by VFIO".

> 
> However, unlike mlock()ed memory, secretmem currently behaves more
> like long-term GUP: secretmem mappings are unmovable mappings
> directly consumed by user space. With default limits, there is no
> excessive use of secretmem and it poses no real problem in
> combination with ZONE_MOVABLE/CMA, but in the future this should be
> addressed to allow balanced use of large amounts of secretmem along
> with ZONE_MOVABLE/CMA.
> 
> A page that was a part of the secret memory area is cleared when it
> is freed to ensure the data is not exposed to the next user of that
> page.

You could skip that with init_on_free (and eventually also with 
init_on_alloc) set to avoid double clearing.

> 
> The following example demonstrates creation of a secret mapping
> (error handling is omitted):
> 
> fd = memfd_secret(0); ftruncate(fd, MAP_SIZE); ptr = mmap(NULL,
> MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> 
> [1]
> https://lore.kernel.org/linux-mm/213b4567-46ce-f116-9cdf-bbd0c884eb3c@linux.intel.com/

[my mail client messed up the remainder of the mail for whatever reason, 
will comment in a separate mail if there is anything to comment :) ]

-- 
Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

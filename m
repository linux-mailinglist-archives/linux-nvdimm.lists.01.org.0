Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C73338063C
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 May 2021 11:27:57 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 01F57100EAB0B;
	Fri, 14 May 2021 02:27:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 59937100EAB09
	for <linux-nvdimm@lists.01.org>; Fri, 14 May 2021 02:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620984473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCFOeXXuHqZj/3n5W4PkDf5UJ0V8NO/Y5/poalLCeQU=;
	b=doEV/osVmgQ4E2qonk1MwbTRonAvztAxV0UpO6phcTOAXqfbH1NKOqZfCEHk9x2lVnOk2o
	csEOklxirAkGqsic5gcu/kDbCb5LToyo6pIxnlri6tuqCqPr/HC7oMpdZUdKA6QS0g9mMF
	u8gUE53evgj+umwiX02/idBTe9U3534=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-wbQtjLUtP02PELpDNB5Otg-1; Fri, 14 May 2021 05:27:51 -0400
X-MC-Unique: wbQtjLUtP02PELpDNB5Otg-1
Received: by mail-ej1-f72.google.com with SMTP id p25-20020a1709061419b0290378364a6464so9387755ejc.15
        for <linux-nvdimm@lists.01.org>; Fri, 14 May 2021 02:27:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lCFOeXXuHqZj/3n5W4PkDf5UJ0V8NO/Y5/poalLCeQU=;
        b=kBL+CXZ/UnNct+x4U/x/dgD59wYFWsfcft9XU7OGK7DAkEzd7eUxp1gxhVJPPyDWqf
         dK6N/9pqPrqdZaFB8FS/zdwHx6jd9mEjgo3sRSSJFkIzx4/k2MhWwU2OcwlAsvnmhTMX
         ULfR423Q+mZZ7HxGMwXmWY7GUz+MazdFPOCxLPhP5olkzmpIFwb8TjK3+3vvkP8lVaLi
         OKvILWa5S4x2zxZOKOfOgzUSsaFBCYZzaOLvB7fmoOGEGToZoR7A1516F5yp579aI1FU
         wVwNtWeYtP5+AYB8PlFVkwj7kKkBli6OyMPo3uoPfW4fJKBQEFucuARhdiezaLkWc/eh
         2dyA==
X-Gm-Message-State: AOAM532o997ra2eY545H2QPFhu9BFCgzYYY9vX1eWvJBMh25+Wt9IaZm
	/Zt6LiCq/cklErJMdfWMReW8XHmnNhKAkwYC1Vi+yjti7tYSRJnUwjk59/Qj/q30xRvW2qCv1bc
	kvqpGSZdecP+l3hIf/NEs
X-Received: by 2002:a05:6402:1713:: with SMTP id y19mr11073787edu.286.1620984470700;
        Fri, 14 May 2021 02:27:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfJBqZFBKWj/4MZ8aMrds7gZKR5l1ZQNZ/fzLhEZqsf7ePvhUBKvxtTbsw6S08p7GvU/DmLA==
X-Received: by 2002:a05:6402:1713:: with SMTP id y19mr11073750edu.286.1620984470525;
        Fri, 14 May 2021 02:27:50 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6501.dip0.t-ipconnect.de. [91.12.101.1])
        by smtp.gmail.com with ESMTPSA id t20sm3351530ejc.61.2021.05.14.02.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 02:27:50 -0700 (PDT)
Subject: Re: [PATCH v19 7/8] arch, mm: wire up memfd_secret system call where
 relevant
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
References: <20210513184734.29317-1-rppt@kernel.org>
 <20210513184734.29317-8-rppt@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <227cabb7-17a4-9b39-5893-df825fd2e29b@redhat.com>
Date: Fri, 14 May 2021 11:27:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210513184734.29317-8-rppt@kernel.org>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Message-ID-Hash: 7CQGWFPX23XKM5JSJG5ZVBFZWB2SEKT3
X-Message-ID-Hash: 7CQGWFPX23XKM5JSJG5ZVBFZWB2SEKT3
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Hagen Paul Pfeifer <hagen@jauu.net>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, Kees Cook <keescook@chromium.org>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Palmer Dabbelt <palmerdabbelt@google.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rick Edgecombe <rick.p.edgecombe@intel.c
 om>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7CQGWFPX23XKM5JSJG5ZVBFZWB2SEKT3/>
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
> Wire up memfd_secret system call on architectures that define
> ARCH_HAS_SET_DIRECT_MAP, namely arm64, risc-v and x86.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
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
>   arch/arm64/include/uapi/asm/unistd.h   | 1 +
>   arch/riscv/include/asm/unistd.h        | 1 +
>   arch/x86/entry/syscalls/syscall_32.tbl | 1 +
>   arch/x86/entry/syscalls/syscall_64.tbl | 1 +
>   include/linux/syscalls.h               | 1 +
>   include/uapi/asm-generic/unistd.h      | 7 ++++++-
>   scripts/checksyscalls.sh               | 4 ++++
>   7 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/uapi/asm/unistd.h b/arch/arm64/include/uapi/asm/unistd.h
> index f83a70e07df8..ce2ee8f1e361 100644
> --- a/arch/arm64/include/uapi/asm/unistd.h
> +++ b/arch/arm64/include/uapi/asm/unistd.h
> @@ -20,5 +20,6 @@
>   #define __ARCH_WANT_SET_GET_RLIMIT
>   #define __ARCH_WANT_TIME32_SYSCALLS
>   #define __ARCH_WANT_SYS_CLONE3
> +#define __ARCH_WANT_MEMFD_SECRET
>   
>   #include <asm-generic/unistd.h>
> diff --git a/arch/riscv/include/asm/unistd.h b/arch/riscv/include/asm/unistd.h
> index 977ee6181dab..6c316093a1e5 100644
> --- a/arch/riscv/include/asm/unistd.h
> +++ b/arch/riscv/include/asm/unistd.h
> @@ -9,6 +9,7 @@
>    */
>   
>   #define __ARCH_WANT_SYS_CLONE
> +#define __ARCH_WANT_MEMFD_SECRET
>   
>   #include <uapi/asm/unistd.h>
>   
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index 28a1423ce32e..e44519020a43 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -451,3 +451,4 @@
>   444	i386	landlock_create_ruleset	sys_landlock_create_ruleset
>   445	i386	landlock_add_rule	sys_landlock_add_rule
>   446	i386	landlock_restrict_self	sys_landlock_restrict_self
> +447	i386	memfd_secret		sys_memfd_secret
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index ecd551b08d05..a06f16106f24 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -368,6 +368,7 @@
>   444	common	landlock_create_ruleset	sys_landlock_create_ruleset
>   445	common	landlock_add_rule	sys_landlock_add_rule
>   446	common	landlock_restrict_self	sys_landlock_restrict_self
> +447	common	memfd_secret		sys_memfd_secret
>   
>   #
>   # Due to a historical design error, certain syscalls are numbered differently
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 050511e8f1f8..1a1b5d724497 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -1050,6 +1050,7 @@ asmlinkage long sys_landlock_create_ruleset(const struct landlock_ruleset_attr _
>   asmlinkage long sys_landlock_add_rule(int ruleset_fd, enum landlock_rule_type rule_type,
>   		const void __user *rule_attr, __u32 flags);
>   asmlinkage long sys_landlock_restrict_self(int ruleset_fd, __u32 flags);
> +asmlinkage long sys_memfd_secret(unsigned int flags);
>   
>   /*
>    * Architecture-specific system calls
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 6de5a7fc066b..28b388368cf6 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -873,8 +873,13 @@ __SYSCALL(__NR_landlock_add_rule, sys_landlock_add_rule)
>   #define __NR_landlock_restrict_self 446
>   __SYSCALL(__NR_landlock_restrict_self, sys_landlock_restrict_self)
>   
> +#ifdef __ARCH_WANT_MEMFD_SECRET
> +#define __NR_memfd_secret 447
> +__SYSCALL(__NR_memfd_secret, sys_memfd_secret)
> +#endif
> +
>   #undef __NR_syscalls
> -#define __NR_syscalls 447
> +#define __NR_syscalls 448
>   
>   /*
>    * 32 bit systems traditionally used different
> diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
> index a18b47695f55..b7609958ee36 100755
> --- a/scripts/checksyscalls.sh
> +++ b/scripts/checksyscalls.sh
> @@ -40,6 +40,10 @@ cat << EOF
>   #define __IGNORE_setrlimit	/* setrlimit */
>   #endif
>   
> +#ifndef __ARCH_WANT_MEMFD_SECRET
> +#define __IGNORE_memfd_secret
> +#endif
> +
>   /* Missing flags argument */
>   #define __IGNORE_renameat	/* renameat2 */
>   
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

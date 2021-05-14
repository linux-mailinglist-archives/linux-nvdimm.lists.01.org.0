Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FA3380635
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 May 2021 11:27:20 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B5123100EAB09;
	Fri, 14 May 2021 02:27:18 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 302A4100EAB06
	for <linux-nvdimm@lists.01.org>; Fri, 14 May 2021 02:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620984436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yW2asbdUagGat2ijahWn20ew93BwpmErRmbUGUDMNcY=;
	b=PesLttMemUFfXv4leFnnycKMR7EyGaoYpAU0v/r5JNdfxLgHyxhvVKxVgyPgmx44r89nP9
	10WPakKrV9JVSb8BKJGMMsZ+hUub63RAcAXtv+PL123B+nE0AfDbP39bZ241uPW4lmE0XM
	6e/IqPFzISJ2mkN1o9bFvg2F3HLhM5c=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-Adqst32oPomyvAaga7OCZg-1; Fri, 14 May 2021 05:27:14 -0400
X-MC-Unique: Adqst32oPomyvAaga7OCZg-1
Received: by mail-ej1-f71.google.com with SMTP id m18-20020a1709062352b02903d2d831f9baso1239510eja.20
        for <linux-nvdimm@lists.01.org>; Fri, 14 May 2021 02:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yW2asbdUagGat2ijahWn20ew93BwpmErRmbUGUDMNcY=;
        b=SSlUcFL0L/vX4JzVWJ1c4bbdFtRyjtgvOZSoFk5QlC3tjJecyx6NKVvY8xcY5mKYgN
         z1jBy3jrATwlIvLNRbRbf8JV/7Zg9RpcNBMVVvdKoWF/yhCbDhOxr2KsX4qzGZBu1z5i
         3atc7oDT9emXHkvlXWjE41gJB/MohlbNR0nYGv+dR3LDeV1uYidLhP8aARWURBg0PWtC
         vf4Q04RFVgJ3rx+/mDrlTO7n3CRnb9d3Hw6kxPtujApjp2zOi7cpz4WY/hpb+8SsGaH8
         P1K98d0ZW66uhhFpjeifAFajOn/jUWTG4MWBBT8MX0/9KgVZLCOUd/QM3RIY4QSncmra
         amOQ==
X-Gm-Message-State: AOAM531Ac1jRHCHxAA1f9pM3rrONve7sClpmVXLxRwNLl1gcXEwT8WTH
	sSJB/77T5dwp8K5TY8TtQ0dT0iEeuHZ2bTvjvRLr1t3jrc3WAiCorByB81zxeFOzvT4HV1MqO1I
	T7g800qKhv2XcrTIn2UXP
X-Received: by 2002:a05:6402:10c6:: with SMTP id p6mr55735288edu.241.1620984433538;
        Fri, 14 May 2021 02:27:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEtOCv5Ls17oMjk/nlAqkQoSV5N2CP4kQHSOXjzJBX9acMLtoFBB9xjtabyDhiKP+sEIswPA==
X-Received: by 2002:a05:6402:10c6:: with SMTP id p6mr55735269edu.241.1620984433367;
        Fri, 14 May 2021 02:27:13 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6501.dip0.t-ipconnect.de. [91.12.101.1])
        by smtp.gmail.com with ESMTPSA id m9sm3510728ejj.53.2021.05.14.02.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 02:27:13 -0700 (PDT)
Subject: Re: [PATCH v19 6/8] PM: hibernate: disable when there are active
 secretmem users
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
References: <20210513184734.29317-1-rppt@kernel.org>
 <20210513184734.29317-7-rppt@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <d243610c-78df-5e25-cb60-320e7a352d82@redhat.com>
Date: Fri, 14 May 2021 11:27:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210513184734.29317-7-rppt@kernel.org>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Message-ID-Hash: INY2MXBBOGLIVWG7TCK5KY463FW6WEBK
X-Message-ID-Hash: INY2MXBBOGLIVWG7TCK5KY463FW6WEBK
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Hagen Paul Pfeifer <hagen@jauu.net>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, Kees Cook <keescook@chromium.org>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Palmer Dabbelt <palmerdabbelt@google.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rick Edgecombe <rick.p.edgecombe@intel.c
 om>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/INY2MXBBOGLIVWG7TCK5KY463FW6WEBK/>
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
> It is unsafe to allow saving of secretmem areas to the hibernation
> snapshot as they would be visible after the resume and this essentially
> will defeat the purpose of secret memory mappings.
> 
> Prevent hibernation whenever there are active secret memory users.
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
>   include/linux/secretmem.h |  6 ++++++
>   kernel/power/hibernate.c  |  5 ++++-
>   mm/secretmem.c            | 15 +++++++++++++++
>   3 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
> index e617b4afcc62..21c3771e6a56 100644
> --- a/include/linux/secretmem.h
> +++ b/include/linux/secretmem.h
> @@ -30,6 +30,7 @@ static inline bool page_is_secretmem(struct page *page)
>   }
>   
>   bool vma_is_secretmem(struct vm_area_struct *vma);
> +bool secretmem_active(void);
>   
>   #else
>   
> @@ -43,6 +44,11 @@ static inline bool page_is_secretmem(struct page *page)
>   	return false;
>   }
>   
> +static inline bool secretmem_active(void)
> +{
> +	return false;
> +}
> +
>   #endif /* CONFIG_SECRETMEM */
>   
>   #endif /* _LINUX_SECRETMEM_H */
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index da0b41914177..559acef3fddb 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -31,6 +31,7 @@
>   #include <linux/genhd.h>
>   #include <linux/ktime.h>
>   #include <linux/security.h>
> +#include <linux/secretmem.h>
>   #include <trace/events/power.h>
>   
>   #include "power.h"
> @@ -81,7 +82,9 @@ void hibernate_release(void)
>   
>   bool hibernation_available(void)
>   {
> -	return nohibernate == 0 && !security_locked_down(LOCKDOWN_HIBERNATION);
> +	return nohibernate == 0 &&
> +		!security_locked_down(LOCKDOWN_HIBERNATION) &&
> +		!secretmem_active();
>   }
>   
>   /**
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 1ae50089adf1..7c2499e4de22 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -40,6 +40,13 @@ module_param_named(enable, secretmem_enable, bool, 0400);
>   MODULE_PARM_DESC(secretmem_enable,
>   		 "Enable secretmem and memfd_secret(2) system call");
>   
> +static atomic_t secretmem_users;
> +
> +bool secretmem_active(void)
> +{
> +	return !!atomic_read(&secretmem_users);
> +}
> +
>   static vm_fault_t secretmem_fault(struct vm_fault *vmf)
>   {
>   	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> @@ -94,6 +101,12 @@ static const struct vm_operations_struct secretmem_vm_ops = {
>   	.fault = secretmem_fault,
>   };
>   
> +static int secretmem_release(struct inode *inode, struct file *file)
> +{
> +	atomic_dec(&secretmem_users);
> +	return 0;
> +}
> +
>   static int secretmem_mmap(struct file *file, struct vm_area_struct *vma)
>   {
>   	unsigned long len = vma->vm_end - vma->vm_start;
> @@ -116,6 +129,7 @@ bool vma_is_secretmem(struct vm_area_struct *vma)
>   }
>   
>   static const struct file_operations secretmem_fops = {
> +	.release	= secretmem_release,
>   	.mmap		= secretmem_mmap,
>   };
>   
> @@ -202,6 +216,7 @@ SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
>   	file->f_flags |= O_LARGEFILE;
>   
>   	fd_install(fd, file);
> +	atomic_inc(&secretmem_users);
>   	return fd;
>   
>   err_put_fd:
> 

It looks a bit racy, but I guess we don't really care about these corner 
cases.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

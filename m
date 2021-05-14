Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924CB380537
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 May 2021 10:28:27 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5E54F100EAAFB;
	Fri, 14 May 2021 01:28:26 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A3A87100EBB97
	for <linux-nvdimm@lists.01.org>; Fri, 14 May 2021 01:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620980903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5w0DUc6v8+Ohu3/Un9/gp8Wn9KzAdxtOI/JJ1rmwYuM=;
	b=MFp+EYNbog+UbV2XVhYnOj/c1lOm9aOA/xV5gEKAbUNc96DQ1DGZ5eudogQW02T+1p8vdz
	zsuMpxLNWMCxbAC0kF5UMTbQU7AOgk/cMs3wZl44c729Uw0iOfiwRVRmYNIFd8+k3GUVC0
	0ybJIzxSzkSaz1XT9cYmp1f+sXfWXUs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-E_D9GpjMNIm-9dnzXfobQg-1; Fri, 14 May 2021 04:28:20 -0400
X-MC-Unique: E_D9GpjMNIm-9dnzXfobQg-1
Received: by mail-ed1-f70.google.com with SMTP id p8-20020aa7c8880000b029038ce714c8d6so1643019eds.10
        for <linux-nvdimm@lists.01.org>; Fri, 14 May 2021 01:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5w0DUc6v8+Ohu3/Un9/gp8Wn9KzAdxtOI/JJ1rmwYuM=;
        b=BOoVyDckO2N7IOOmLMIqdKQTj42NcJnEUh//JlWmW7t/07GuJilGsw5vH5a4l3Spyf
         Z5UkeMBvCpds6fjqmNfIgT2bGwGeSG7kXEqclFMXGninwr1qz6GgL0ye7Uqo3kCdZDSa
         tWuHzDTrcVW0l+t2FQJ/XhX9IsLwNlbBF1eQ6QywDYbJPxjjDAkkHOjYB7BC454A08d9
         bkgZ8d3vPQkRhxZm67tL09YzQnrA+7SazzJvbgHso8l08jzuSV0rg4i1J0x1hcx2GznY
         iaU4upDyX0wWHma2ASQn1T4JT9JQVgmJqRALJKtapbtec0+8QLYSIzdck7fqPz1v1n2J
         nGmQ==
X-Gm-Message-State: AOAM531+3dChrDwxBwlD+FPySILStZMFn0LPEUslMGDeMqZe3tLfH5AC
	GcyUidqVW04KkDkdpHmm2BuFraWl8LFFaY8nuqIhEtEMm44ARPw9rahaVTBIdDfYAPXUaqXCLJO
	vWMw9JFCEJQKMXxlBQa9V
X-Received: by 2002:aa7:c510:: with SMTP id o16mr54629581edq.310.1620980898812;
        Fri, 14 May 2021 01:28:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAa7CtEGRAWr1lF7BGwkWkyoH00MJ3yOs2g5NJWUfLIy+27BD8PFUUKz633oLeJlXdgmtb9Q==
X-Received: by 2002:aa7:c510:: with SMTP id o16mr54629525edq.310.1620980898588;
        Fri, 14 May 2021 01:28:18 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6501.dip0.t-ipconnect.de. [91.12.101.1])
        by smtp.gmail.com with ESMTPSA id s4sm4090012edq.96.2021.05.14.01.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 01:28:18 -0700 (PDT)
Subject: Re: [PATCH v19 2/8] riscv/Kconfig: make direct map manipulation
 options depend on MMU
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
References: <20210513184734.29317-1-rppt@kernel.org>
 <20210513184734.29317-3-rppt@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <adb9f79a-8b9a-0302-e83c-03ad17d3743b@redhat.com>
Date: Fri, 14 May 2021 10:28:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210513184734.29317-3-rppt@kernel.org>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Message-ID-Hash: SWZJD5O2PC6IFQYLGJVK3P6K3T3EZXVX
X-Message-ID-Hash: SWZJD5O2PC6IFQYLGJVK3P6K3T3EZXVX
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Hagen Paul Pfeifer <hagen@jauu.net>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, Kees Cook <keescook@chromium.org>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Palmer Dabbelt <palmerdabbelt@google.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rick Edgecombe <rick.p.edgecombe@intel.c
 om>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, kernel test robot <lkp@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SWZJD5O2PC6IFQYLGJVK3P6K3T3EZXVX/>
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
> ARCH_HAS_SET_DIRECT_MAP and ARCH_HAS_SET_MEMORY configuration options have
> no meaning when CONFIG_MMU is disabled and there is no point to enable
> them for the nommu case.
> 
> Add an explicit dependency on MMU for these options.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>   arch/riscv/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index a8ad8eb76120..c426e7d20907 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -26,8 +26,8 @@ config RISCV
>   	select ARCH_HAS_KCOV
>   	select ARCH_HAS_MMIOWB
>   	select ARCH_HAS_PTE_SPECIAL
> -	select ARCH_HAS_SET_DIRECT_MAP
> -	select ARCH_HAS_SET_MEMORY
> +	select ARCH_HAS_SET_DIRECT_MAP if MMU
> +	select ARCH_HAS_SET_MEMORY if MMU
>   	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
>   	select ARCH_HAS_STRICT_MODULE_RWX if MMU && !XIP_KERNEL
>   	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

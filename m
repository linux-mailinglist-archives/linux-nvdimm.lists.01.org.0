Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6035380663
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 May 2021 11:41:02 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 15309100EAB0D;
	Fri, 14 May 2021 02:41:01 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3B56E100EAB0B
	for <linux-nvdimm@lists.01.org>; Fri, 14 May 2021 02:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620985256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bvT1h5Dtf95/bClBJ8t/oO4/WMLk+en4nCrG5Kuj0DQ=;
	b=YHwHH2ihE7MF9kaK0vsik5rPLpZbkAUFbP8cqiMPKL842Jxo4sKcRWxdJaKlQxdLN0ogu5
	AhCDbUdwKZBMnFEFSiTR47nPfi/9qV7pOUIxsDX1FeV+S8ay0s+SgT0GdlGvkPlmz0S6Ij
	yW93BW+P5qecf0Cij/30E7Za6KCFfM8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-T2Ih2pAWNZiJ-fkHYtHeWQ-1; Fri, 14 May 2021 05:40:55 -0400
X-MC-Unique: T2Ih2pAWNZiJ-fkHYtHeWQ-1
Received: by mail-ed1-f69.google.com with SMTP id d8-20020a0564020008b0290387d38e3ce0so16092536edu.1
        for <linux-nvdimm@lists.01.org>; Fri, 14 May 2021 02:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bvT1h5Dtf95/bClBJ8t/oO4/WMLk+en4nCrG5Kuj0DQ=;
        b=rih9MomEfWTr5QDDN9TMSepGXGq2FMQgbKnLD8rbgsYr5HrI8fCeZf+kU1Q/teaJo1
         iJYza65hdDPPQJAjkuQe2iUhQ4jb1lThybWF25tiDkJZPAEwalho1sI3/i3FizfIB2hx
         7Uon4lr5puWoZQqd5R8Fi9qQ1ZKq9YCvZYQkaTtrQaGlzWthqianpWyG/oLZSZXyfEzn
         6gn/tnTcgkuRWo30eL0ogqIXmq6JKFMas2ywZYGbeLiLOv7rReUGqcxbSilGItWTdqjj
         2aN48E9o0D8XJPKaNwXsCMQ41vqbAf0M7EcDRqS0bV/Mk5X+IGSrE5KpHetLiy7MprMK
         GNiA==
X-Gm-Message-State: AOAM532iXRZkISoxTyWckIT0pFmmKeU+k99yPHM7f1GYqe61UE8i5PLE
	ukwSsM+GGLtpKcDGshhMSqzrEvoSOoEL7KMkbReck/ZRsex7H7oB5Fu3IjD/T8FhAmCtPZyD1Ao
	JzhOs8d1FhAZZKo1xCR/N
X-Received: by 2002:a05:6402:2d6:: with SMTP id b22mr55674430edx.274.1620985253912;
        Fri, 14 May 2021 02:40:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNzAwSfBkG72zB94sJxDLgDbZ+DEQn4gYm5J85sFFQeIUDMZK27eq70zvt8ZCsSnIvH+CO+w==
X-Received: by 2002:a05:6402:2d6:: with SMTP id b22mr55674419edx.274.1620985253764;
        Fri, 14 May 2021 02:40:53 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6501.dip0.t-ipconnect.de. [91.12.101.1])
        by smtp.gmail.com with ESMTPSA id g10sm2885347ejd.109.2021.05.14.02.40.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 02:40:53 -0700 (PDT)
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
References: <20210513184734.29317-1-rppt@kernel.org>
 <20210513184734.29317-9-rppt@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v19 8/8] secretmem: test: add basic selftest for
 memfd_secret(2)
Message-ID: <a573f11d-7716-46cd-1d08-6840560d6877@redhat.com>
Date: Fri, 14 May 2021 11:40:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210513184734.29317-9-rppt@kernel.org>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Message-ID-Hash: RFOI42QT5ABCVIMIWR755U5NFIHD33TX
X-Message-ID-Hash: RFOI42QT5ABCVIMIWR755U5NFIHD33TX
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Hagen Paul Pfeifer <hagen@jauu.net>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, Kees Cook <keescook@chromium.org>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Palmer Dabbelt <palmerdabbelt@google.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rick Edgecombe <rick.p.edgecombe@intel.c
 om>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RFOI42QT5ABCVIMIWR755U5NFIHD33TX/>
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
> The test verifies that file descriptor created with memfd_secret does not
> allow read/write operations, that secret memory mappings respect
> RLIMIT_MEMLOCK and that remote accesses with process_vm_read() and
> ptrace() to the secret memory fail.
> 

[...]

> @@ -0,0 +1,296 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright IBM Corporation, 2020

2021 ?


-- 
Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

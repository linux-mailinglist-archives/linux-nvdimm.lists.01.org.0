Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A893509C6
	for <lists+linux-nvdimm@lfdr.de>; Wed, 31 Mar 2021 23:52:26 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6B371100EB83D;
	Wed, 31 Mar 2021 14:52:24 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::72b; helo=mail-qk1-x72b.google.com; envelope-from=yury.norov@gmail.com; receiver=<UNKNOWN> 
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D4AE4100EB838
	for <linux-nvdimm@lists.01.org>; Wed, 31 Mar 2021 14:52:20 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id y5so289022qkl.9
        for <linux-nvdimm@lists.01.org>; Wed, 31 Mar 2021 14:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iVgFfy9Gk4TopgDWAZb3OEMFsekIXo3QttoRKgThI1I=;
        b=LlC/3vOcZu0Rh5837wBCMc/jMQBLoS5tu19QTNj1eof7IhHTCSrowwreYpcEeTbT5X
         NlWLfUqhbD9HhkHO9DsT4Tyx2dRlg91X71xYeCMm7fKtrUmafIBq7/LrPrNoupfhFp3m
         GewFfvppFWbs9VRkNf6T/omLtxmxV/Um2gbRVOo+AHZwOoh9mGFiVd9+oTJRsbPr+urV
         9+SzjFJBATN+dQCPHnqvB4BC59ngCo/QcWw7P40soldfgVxjJkBfgZEWDD018mop0vXZ
         RHFwc/5vTY5r72yfm8jOOOnGx6oz9cJw+eVDnJnP827bZO8OihlinIME1rTQWHzKsxKK
         ckUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iVgFfy9Gk4TopgDWAZb3OEMFsekIXo3QttoRKgThI1I=;
        b=ZvE+13tO2NWmCVLUQ9yC35cZi8Lc3b7NMvsD+bDABPfpc2ocbrZipbMO0pv9SFyGVD
         gbPkAyZ0AlhgaNp5oeoq80YRcFXGOVhBrPwyvxjLgB+KnUIj/pyyiKvY0FS7WPsnTKtf
         bDtMMdX1Kmd88SmVmqchANt3KqAWuLRrpsoBM9+Nw5aM5kZgRRd4KQl58qD7nOIcuYyW
         5izhB4po/e6/9kSIbhZUxOqvynI9w3PMFmfdd6BCA/ex55OEfzgPZGNBiqbuT9LyTGEy
         1wt4Z/bDidOHPbLybzS1j22jqWFmRLp1C5v7lSx0Wv5BPOFkzgEGX73Z6AaEkfNmewv0
         UBWg==
X-Gm-Message-State: AOAM533mfYJVUK97IBbqXYHTidzu1u8nT/c2ooHLjOEq7+Ac3m6QljLp
	KQc6YQ1PTFaqN/JTlrwhPPg=
X-Google-Smtp-Source: ABdhPJwK1AgyeLn7/B6+lfbSP03Q/ohuFDGUVnzdZCNHOlmGfkjpcbj+5GbXHWQQi4iDLVthXpiBHg==
X-Received: by 2002:a37:78b:: with SMTP id 133mr5361746qkh.109.1617227539232;
        Wed, 31 Mar 2021 14:52:19 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id d84sm2453310qke.53.2021.03.31.14.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 14:52:18 -0700 (PDT)
Date: Wed, 31 Mar 2021 14:52:18 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] memfd_secret: use unsigned int rather than long as
 syscall flags type
Message-ID: <20210331215218.GA3437@yury-ThinkPad>
References: <20210331142345.27532-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210331142345.27532-1-rppt@kernel.org>
Message-ID-Hash: 2E3BCV3JJLFPOWUX3EIRRTEAEASLQ5TB
X-Message-ID-Hash: 2E3BCV3JJLFPOWUX3EIRRTEAEASLQ5TB
X-MailFrom: yury.norov@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>,
  Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2E3BCV3JJLFPOWUX3EIRRTEAEASLQ5TB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 31, 2021 at 05:23:45PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Yuri Norov says:
> 
>   If parameter size is the same for native and compat ABIs, we may
>   wire a syscall made by compat client to native handler. This is
>   true for unsigned int, but not true for unsigned long or pointer.
> 
>   That's why I suggest using unsigned int and so avoid creating compat
>   entry point.
> 
> Use unsigned int as the type of the flags parameter in memfd_secret()
> system call.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Acked-by: Yury Norov <yury.norov@gmail.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

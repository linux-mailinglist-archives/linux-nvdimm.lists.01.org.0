Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAD426D332
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Sep 2020 07:46:30 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 54F07148165FB;
	Wed, 16 Sep 2020 22:46:28 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com; envelope-from=mtk.manpages@gmail.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 63C1B12716FE9
	for <linux-nvdimm@lists.01.org>; Wed, 16 Sep 2020 22:46:25 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id y6so1139815oie.5
        for <linux-nvdimm@lists.01.org>; Wed, 16 Sep 2020 22:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=03zgBdOmJo+1h1F3YVTbbY3y6xnSeDHzXEapmphTwIw=;
        b=bbKl9UWPeRhmTphLackrhk80UEzUzcPTNe72QmMk7/fs5a/LxCxtV+mb6MSWQFVDmC
         F22yt5hvhiNFb2j/gFnw8yxBQviOrz2mlbiqk83dwMA7AkjqITFQd1eVdq1X39tqelCL
         VQYLiT8PHgFrLapRSXmMmT+MgfubVdogkhnR8iaU9CBQieW2dO0skkpZLwguhZi/JnBV
         GroqbGpDUZEjnODXLPHpOPwc0N7/cjNeafIH1QgpKVpeU6uH1eY/RuZkMDyTnjr9U7fb
         tviHseO3/70GTW4fSLc2vk/vqzCFhAHroNAVb0ANnf+lzN+TxeDA/upoZku1GEWDb8D1
         7Ugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=03zgBdOmJo+1h1F3YVTbbY3y6xnSeDHzXEapmphTwIw=;
        b=DqbWoGPhaS+eEjCsD7wsNeH77KYsimZ9fcB7NNWJMYf9BqJpsRfwWDvJP9/jluhExi
         uY+Z61P+R6Dy/Ex34+V3x7cPFFxv7H4jTpNuTlH1Imp4tnBKwFrQYWRqpFAyXLNM4f4h
         qUZ4JG79I0DCJN8vNzA25+wYnwtqvFwQ0MuxT3gPq7Qbo4RQil1HXnoWfycRKvoikbkx
         j5K12XA92sPrdTIfgz9FpY2OWQ2Nwgopafd7XDxUO1iDRisxOwyOKpsEAUaj1UXQs39r
         rh2PHS6B8asiCmTW5fThLvxZIRtFGG42BCHhQK/+Z59XOHOkkSvFkPou55KscesJSdo8
         rnsQ==
X-Gm-Message-State: AOAM5316d3M6Ugla6JLc1h2C9MoGrklNY4tSDOw89lUZlLpyUls+50UM
	CaPD8Jm/GDmxCIcyxDLajWDWPS51pKouuyF2l/M=
X-Google-Smtp-Source: ABdhPJzQezUvckVK0wvtjtSXJuH78/qLicEZ94e9jzpjFRfX1+eKqEzksVrp0ORp5rdZVfo95r94sEe5o2dL6iEln5E=
X-Received: by 2002:a54:458f:: with SMTP id z15mr3791761oib.148.1600321584018;
 Wed, 16 Sep 2020 22:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200916073539.3552-1-rppt@kernel.org> <20200916162020.0d68c2bd6711024cfcaa8bd7@linux-foundation.org>
In-Reply-To: <20200916162020.0d68c2bd6711024cfcaa8bd7@linux-foundation.org>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date: Thu, 17 Sep 2020 07:46:12 +0200
Message-ID: <CAKgNAkiSRDoZWKkBLB03X_knOeoeKVTy2oLmMopZ5vK8UZSAPg@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] mm: introduce memfd_secret system call to create
 "secret" memory areas
To: Andrew Morton <akpm@linux-foundation.org>
Message-ID-Hash: OJIR62GGYFFQAARDDEQPRTYDKIBHAHAD
X-Message-ID-Hash: OJIR62GGYFFQAARDDEQPRTYDKIBHAHAD
X-MailFrom: mtk.manpages@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Rapoport <rppt@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-arm-kernel@lists.
 infradead.org, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: mtk.manpages@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OJIR62GGYFFQAARDDEQPRTYDKIBHAHAD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2020 at 01:20, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 16 Sep 2020 10:35:34 +0300 Mike Rapoport <rppt@kernel.org> wrote:
>
> > This is an implementation of "secret" mappings backed by a file descriptor.
> > I've dropped the boot time reservation patch for now as it is not strictly
> > required for the basic usage and can be easily added later either with or
> > without CMA.
>
> It seems early days for this, especially as regards reviewer buyin.
> But I'll toss it in there to get it some additional testing.
>
> A test suite in tools/testging/selftests/ would be helpful, especially
> for arch maintainers.
>
> I assume that user-facing manpage alterations are planned?

I was just about to write a mail into this thread when I saw this :-).

So far, I don't think I saw a manual page patch. Mike, how about it?

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

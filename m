Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EDF227DF2
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 Jul 2020 12:59:39 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A649F12452ED7;
	Tue, 21 Jul 2020 03:59:37 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com; envelope-from=mtk.manpages@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9DE7412452ED5
	for <linux-nvdimm@lists.01.org>; Tue, 21 Jul 2020 03:59:34 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id d4so14757019otk.2
        for <linux-nvdimm@lists.01.org>; Tue, 21 Jul 2020 03:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=/EF7Qison7+OGXQXe8tCTGM4PP/e4Mdg4NPhl6XK730=;
        b=Uk4f9jfGhs5DkBWkywVYSxv+RjvPtlBJKwNzxDQJRM4oyUlZeJHH9Ay0Dz9S3T+O86
         I1k8wcSU5qjlnQbQS1Cc5u/Di5a8oxU0TqNANIeZ+urK3ruLtTD1rFzoDtPyUq0zyw1t
         TKTa7dYj3q558MX8C2dCAhl0Kx3BnS6PKK14W3du9GA95iORa8+JZDbW/DQ6a9DT5Fmy
         8za6hMaHY5YNv55f0k+a+Ti8u5YKEfdRVS6vRWc0m6bcU1eZA57gEbg14Y3/HWJqEceg
         I6AApXJum8MPc7FIX+9Iv2OU5g/1PXoIJOC9VdOjehdpKQ5Gaotz84w3/VSWkS/6Omc3
         Mlbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=/EF7Qison7+OGXQXe8tCTGM4PP/e4Mdg4NPhl6XK730=;
        b=Yl2SUVm4/wIOctp7+tH+zy/+SLZJMuG1gcORHC2qewthY1GwyZCY3fyxeiliD6NBBd
         Rg4TgfxLyAd9EMxtSERPO33qIkBqXVQ03Qy9ikZtEcWqearMwSkDhvtdEWfsRyOuKzaX
         KUPqTFXQ8xGf4yC8hA/0UAjKUsrL0N+rSWIW5LrthYfVBPibI/JVhwfj72XSWLQ6nS0j
         Uks9lKnn4OVMstJrbpeERgrOcaZz4+FUN5TwZjM1m+/IFSc8hsyVUZvLC3pwBqY5g6V1
         vlfJFmIT4dJ5Np2B3/arztwj/JmTnDo7b7mIgIMxGSjIFqXThHEf8nTP6hpb2qFuB/Tj
         0OIg==
X-Gm-Message-State: AOAM530r7/3SBZ9FYjDdkpVG6/CyNd/I/5XtSRzGyu8MgrSsXkc02M9k
	JnZGdcgqFiQz3yLKpNjq93A3OCRGOeGI2CZ/vaA=
X-Google-Smtp-Source: ABdhPJwDn1K9lCXh3r6H2duEArkbw7P69YNYfj8OXMApUjXADa+z15C6AlqxraRlKJPBGg9bBd1HTcPmXTNgIEWHZIw=
X-Received: by 2002:a05:6830:2081:: with SMTP id y1mr23521903otq.114.1595329173244;
 Tue, 21 Jul 2020 03:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200720092435.17469-1-rppt@kernel.org> <20200720092435.17469-4-rppt@kernel.org>
In-Reply-To: <20200720092435.17469-4-rppt@kernel.org>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date: Tue, 21 Jul 2020 12:59:22 +0200
Message-ID: <CAKgNAkgdOZXsVVkYveqnjODOr_cHYWiRssw2Tu1dZEBd+GnOnA@mail.gmail.com>
Subject: Re: [PATCH 3/6] mm: introduce secretmemfd system call to create
 "secret" memory areas
To: Mike Rapoport <rppt@kernel.org>
Message-ID-Hash: X3D6QPYWEZHSQSNUP3W7MQO4NCDDKQYS
X-Message-ID-Hash: X3D6QPYWEZHSQSNUP3W7MQO4NCDDKQYS
X-MailFrom: mtk.manpages@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: lkml <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, "linux-fsdeve
 l@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: mtk.manpages@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/X3D6QPYWEZHSQSNUP3W7MQO4NCDDKQYS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Mike,

On Mon, 20 Jul 2020 at 11:26, Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> Introduce "secretmemfd" system call with the ability to create memory areas
> visible only in the context of the owning process and not mapped not only
> to other processes but in the kernel page tables as well.
>
> The user will create a file descriptor using the secretmemfd system call

Without wanting to start a bikeshed discussion, the more common
convention in recently added system calls is to use an underscore in
names that consist of multiple clearly distinct words. See many
examples in  https://man7.org/linux/man-pages/man2/syscalls.2.html.

Thus, I'd suggest at least secret_memfd().

Also, I wonder whether memfd_secret() might not be even better.
There's plenty of precedent for the naming style where related APIs
share a common prefix [1].

Thanks,

Michael

[1] Some examples:

       epoll_create(2)
       epoll_create1(2)
       epoll_ctl(2)
       epoll_pwait(2)
       epoll_wait(2)

       mq_getsetattr(2)
       mq_notify(2)
       mq_open(2)
       mq_timedreceive(2)
       mq_timedsend(2)
       mq_unlink(2)

       sched_get_affinity(2)
       sched_get_priority_max(2)
       sched_get_priority_min(2)
       sched_getaffinity(2)
       sched_getattr(2)
       sched_getparam(2)
       sched_getscheduler(2)
       sched_rr_get_interval(2)
       sched_set_affinity(2)
       sched_setaffinity(2)
       sched_setattr(2)
       sched_setparam(2)
       sched_setscheduler(2)
       sched_yield(2)

       timer_create(2)
       timer_delete(2)
       timer_getoverrun(2)
       timer_gettime(2)
       timer_settime(2)

       timerfd_create(2)
       timerfd_gettime(2)
       timerfd_settime(2)




-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EA125C9CF
	for <lists+linux-nvdimm@lfdr.de>; Thu,  3 Sep 2020 21:56:18 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6532713C44066;
	Thu,  3 Sep 2020 12:56:16 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::241; helo=mail-lj1-x241.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN> 
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1440B139F7CF0
	for <linux-nvdimm@lists.01.org>; Thu,  3 Sep 2020 12:56:13 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w3so5210195ljo.5
        for <linux-nvdimm@lists.01.org>; Thu, 03 Sep 2020 12:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+HyCacCrUTSO04Bcz2fAaxbtZLHd8zOfhLgllifmbhk=;
        b=B/wF0S73fEkmrWeW78FVYp9qaLcNFtik9sGGBc1uklYgCiZlOnL6UKyw8zxdwXKlmM
         yZe+asx0TMiJqjKXU+9nuISZd3LkJxAOGu4NBUmczdu3m4VNq8bXfQHWIGfk/u5osF/7
         jhDBu8BCJd9u28EonQab6s+MaaNgFFzQ7//vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+HyCacCrUTSO04Bcz2fAaxbtZLHd8zOfhLgllifmbhk=;
        b=HlNCP2UQmZC9SSsvZKR0LQiqUg5f+JFVO0IXylARTB3ZwVmzt9chqwfnzBaNnhezuU
         qTTxItW83jNYDJZNk5QwRNOYpJ7mtU+5EONsTYB18hnmEP7PezMmxjIIrfjgBPONs02E
         llA0XZNzMK/WOBFbzPOYZgc8kFuMGmJpv7xe9yyG5cGe8hS0VPE8aFYoGvoOz8Z1Ggwb
         7AT6QgNpqJ4O7YRSPjJO8Xa6PaPxNM3mZY4bssMpzNa5inh/JiU4lWSWJKEIwmKQanWW
         2U5uFQKfOnC6EeyAmf0bDimaTZu1eS/kD+MAc1//AdPOH2syicypyXMSTGFbX8+peDrB
         mHlQ==
X-Gm-Message-State: AOAM5305NDwVYkmVD+QtTJPRDPAjTZiCKmQJ2e6FfQZPbSOKy0eDOt/V
	TtMy6wFrFa/chdl14JM43KiBy6oL9wHesA==
X-Google-Smtp-Source: ABdhPJwgpEqBusBnPjjaFqgxt/zIeju7VshPQoFVNJdm0t4ty8dk4roSd9RwV+Sq06nQByRRW2kHlQ==
X-Received: by 2002:a2e:b0f2:: with SMTP id h18mr2109763ljl.231.1599162971158;
        Thu, 03 Sep 2020 12:56:11 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id r18sm799539ljn.92.2020.09.03.12.56.10
        for <linux-nvdimm@lists.01.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 12:56:10 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id u4so4339491ljd.10
        for <linux-nvdimm@lists.01.org>; Thu, 03 Sep 2020 12:56:10 -0700 (PDT)
X-Received: by 2002:a2e:3611:: with SMTP id d17mr6508lja.314.1599162969764;
 Thu, 03 Sep 2020 12:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2009031328040.6929@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2009031328040.6929@file01.intranet.prod.int.rdu2.redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 3 Sep 2020 12:55:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=whpJp9W_eyhqJU3Y2JsnX45xMfQHFNQSsb9dNirdMFnaA@mail.gmail.com>
Message-ID: <CAHk-=whpJp9W_eyhqJU3Y2JsnX45xMfQHFNQSsb9dNirdMFnaA@mail.gmail.com>
Subject: Re: a crash when running strace from persistent memory
To: Mikulas Patocka <mpatocka@redhat.com>, Peter Xu <peterx@redhat.com>
Message-ID-Hash: FUOMBXL2P4577GDNXXRNRGG57J3PT5VL
X-Message-ID-Hash: FUOMBXL2P4577GDNXXRNRGG57J3PT5VL
X-MailFrom: torvalds@linuxfoundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>, Oleg Nesterov <oleg@redhat.com>, Kirill Shutemov <kirill@shutemov.name>, Jan Kara <jack@suse.cz>, Andrea Arcangeli <aarcange@redhat.com>, Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FUOMBXL2P4577GDNXXRNRGG57J3PT5VL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Sep 3, 2020 at 12:24 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> There's a bug when you run strace from dax-based filesystem.
>
> -- create real or emulated persistent memory device (/dev/pmem0)
> mkfs.ext2 /dev/pmem0
> -- mount it
> mount -t ext2 -o dax /dev/pmem0 /mnt/test
> -- copy the system to it (well, you can copy just a few files that are
>    needed for running strace and ls)
> cp -ax / /mnt/test
> -- bind the system directories
> mount --bind /dev /mnt/test/dev
> mount --bind /proc /mnt/test/proc
> mount --bind /sys /mnt/test/sys
> -- run strace on the ls command
> chroot /mnt/test/ strace /bin/ls
>
> You get this warning and ls is killed with SIGSEGV.
>
> I bisected the problem and it is caused by the commit
> 17839856fd588f4ab6b789f482ed3ffd7c403e1f (gup: document and work around
> "COW can break either way" issue). When I revert the patch (on the kernel
> 5.9-rc3), the bug goes away.

Funky. I really don't see how it could cause that, but we have the
UDDF issue too, so I'm guessing I will have to fix it the radical way
with Peter Xu's series based on my "rip out COW special cases" patch.

Or maybe I'm just using that as an excuse for really wanting to apply
that series.. Because we can't just revert that GUP commit due to
security concerns.

> [   84.191504] WARNING: CPU: 6 PID: 1350 at mm/memory.c:2486 wp_page_copy.cold+0xdb/0xf6

I'm assuming this is the WARN_ON_ONCE(1) on line 2482, and you have
some extra debug patch that causes that line to be off by 4? Because
at least for me, line 2486 is actually an empty line in v5.9-rc3.

That said, I really think this is a pre-existing race, and all the
"COW can break either way" patch does is change the timing (presumably
due to the actual pattern of actually doing the COW changing).

See commit c3e5ea6ee574 ("mm: avoid data corruption on CoW fault into
PFN-mapped VMA") for background.

Mikulas, can you check that everything works ok for that case if you
apply Peter's series? See

    https://lore.kernel.org/lkml/20200821234958.7896-1-peterx@redhat.com/

or if you have 'b4' installed, use

    b4 am 20200821234958.7896-1-peterx@redhat.com

to get the series..

                     Linus
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BE726A88E
	for <lists+linux-nvdimm@lfdr.de>; Tue, 15 Sep 2020 17:16:29 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F3A051414FCDE;
	Tue, 15 Sep 2020 08:16:27 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 028F41414FCDC
	for <linux-nvdimm@lists.01.org>; Tue, 15 Sep 2020 08:16:24 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id n13so3393529edo.10
        for <linux-nvdimm@lists.01.org>; Tue, 15 Sep 2020 08:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Y/E8RIZkFddtFHwulQR49x2idyk01ZxBjW2bmut0Hc=;
        b=aYUToB6zrH24LY2xVmoAyJwITz8fGR6B9Qyvei4FahpHnuBBGJskZBN99qaAB3fUtt
         eplyUOquGjz16GIfT0XPfVfK6rWzZUl6W++JUAYHXdSONpYAZ7oJQoQpSO9WoXxERlUM
         BFE2EAtpbMqxL86TEUDW3nuKqnw5j+jNh6OhDaegsg2GfPGpcr4OuwCKUDkneHf+Y9xq
         aF/WATLPPJGPZQAXRmmcXIEywdheUmmHpm935jG7Gi26yjgWfBSUee5TXycCcQbZI8Xe
         L/4gjmmxDcj43zn6sB3SSphAW6uwaG7Mdenlq44BpIKgApFbwOJF1G6xT2ZkwdzYA6s7
         qSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Y/E8RIZkFddtFHwulQR49x2idyk01ZxBjW2bmut0Hc=;
        b=JgFS5PrMTBgvg0HDoaZK0Xuy2HYqxK9WvfW8ZL2UDEcp8SJpqtO7uWRrh9oYZSpF9j
         LBjxS+OLrUS2m1FNPEQBRGvwQRKrxYG6YRP7+8+uxTLRLUzy5TrAyAgisw3hW78qq+XC
         lfu4jlMjR4ew/USRHPApOQXXjBvdsJXjQIUKqVv52rWef0hvMq5vvIfWbamqohYhC0nk
         l8sziUSp6TCEEKDowhRQcjPkrbJRoG5RtwABpalFsoehBmuBj1Cf9133hL+ByX0hx8zH
         CqPy7+0S46LnK0Q85JxsulEI6gNwJTeUD6GXvU1o9ONmpFRR42xUVFzgc5w7zGOSHFqd
         ohQA==
X-Gm-Message-State: AOAM532TB9EE0bfmIpaSNxbilVryzlS/qQlAS5I0jzAJ+RC1f+NcFkOm
	eDl0H6QO8C0Tn05isPLBLXdaJSgR6BUNHFqbAZv6Fw==
X-Google-Smtp-Source: ABdhPJythHZ3a+LmcR0W/cN6t2efwSdOy7mTxn9YsBnVaa3RGCOahJdxMaNVwwar29AYxB16Vjz9H4YOkhyHfRSam2I=
X-Received: by 2002:aa7:d04d:: with SMTP id n13mr23655873edo.354.1600182982436;
 Tue, 15 Sep 2020 08:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2009140852030.22422@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2009140852030.22422@file01.intranet.prod.int.rdu2.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 15 Sep 2020 08:16:11 -0700
Message-ID: <CAPcyv4gh=QaDB61_9_QTgtt-pZuTFdR6td0orE0VMH6=6SA2vw@mail.gmail.com>
Subject: Re: [RFC] nvfs: a filesystem for persistent memory
To: Mikulas Patocka <mpatocka@redhat.com>
Message-ID-Hash: Z5LLXRXSFUXI2DZE4WTCYZFUCRVP65WN
X-Message-ID-Hash: Z5LLXRXSFUXI2DZE4WTCYZFUCRVP65WN
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Eric Sandeen <esandeen@redhat.com>, Dave Chinner <dchinner@redhat.com>, "Tadakamadla, Rajesh (DCIG/CDI/HPS Perf)" <rajesh.tadakamadla@hpe.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Z5LLXRXSFUXI2DZE4WTCYZFUCRVP65WN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Sep 15, 2020 at 5:35 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> Hi
>
> I am developing a new filesystem suitable for persistent memory - nvfs.

Nice!

> The goal is to have a small and fast filesystem that can be used on
> DAX-based devices. Nvfs maps the whole device into linear address space
> and it completely bypasses the overhead of the block layer and buffer
> cache.

So does device-dax, but device-dax lacks read(2)/write(2).

> In the past, there was nova filesystem for pmem, but it was abandoned a
> year ago (the last version is for the kernel 5.1 -
> https://github.com/NVSL/linux-nova ). Nvfs is smaller and performs better.
>
> The design of nvfs is similar to ext2/ext4, so that it fits into the VFS
> layer naturally, without too much glue code.
>
> I'd like to ask you to review it.
>
>
> tarballs:
>         http://people.redhat.com/~mpatocka/nvfs/
> git:
>         git://leontynka.twibright.com/nvfs.git
> the description of filesystem internals:
>         http://people.redhat.com/~mpatocka/nvfs/INTERNALS
> benchmarks:
>         http://people.redhat.com/~mpatocka/nvfs/BENCHMARKS
>
>
> TODO:
>
> - programs run approximately 4% slower when running from Optane-based
> persistent memory. Therefore, programs and libraries should use page cache
> and not DAX mapping.

This needs to be based on platform firmware data f(ACPI HMAT) for the
relative performance of a PMEM range vs DRAM. For example, this
tradeoff should not exist with battery backed DRAM, or virtio-pmem.

>
> - when the fsck.nvfs tool mmaps the device /dev/pmem0, the kernel uses
> buffer cache for the mapping. The buffer cache slows does fsck by a factor
> of 5 to 10. Could it be possible to change the kernel so that it maps DAX
> based block devices directly?

We've been down this path before.

5a023cdba50c block: enable dax for raw block devices
9f4736fe7ca8 block: revert runtime dax control of the raw block device
acc93d30d7d4 Revert "block: enable dax for raw block devices"

EXT2/4 metadata buffer management depends on the page cache and we
eliminated a class of bugs by removing that support. The problems are
likely tractable, but there was not a straightforward fix visible at
the time.

> - __copy_from_user_inatomic_nocache doesn't flush cache for leading and
> trailing bytes.

You want copy_user_flushcache(). See how fs/dax.c arranges for
dax_copy_from_iter() to route to pmem_copy_from_iter().
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

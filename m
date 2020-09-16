Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A901626C63A
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Sep 2020 19:40:30 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7424613D1E53E;
	Wed, 16 Sep 2020 10:40:28 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0127713D1E53B
	for <linux-nvdimm@lists.01.org>; Wed, 16 Sep 2020 10:40:25 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id t16so7157636edw.7
        for <linux-nvdimm@lists.01.org>; Wed, 16 Sep 2020 10:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uV0tE7wFf4iDXsIGWtEvvLMw+8GMDfCmV/fmV+L5rtE=;
        b=VUL59OIjIyapTdJmj8801q2Y3Mpvx7u/EUu0OW6UkOjIUtwW/SNHGKoOeax/rYuwFm
         BV+zC1jvzAnrHZ1+lB6gnvz/k34BGHKFYWsvs4xz5diwhGTkav8A0fXp1OSF1SVXrMNA
         GLgLeBWbfYQFhlJWYDSqhAvOOynHfdz3tdzgBr7WR0swtYyTgVYf3vz1RVxlC/uoAIWp
         pG98RBSBX5qWKRT1T68utMs4dX5/GL6lROu88danJYsXhPfOOipKUgyN/i0KEo2LcHRN
         nUr+R+oaGvfLrK5T8EnNypzlI70SgVNfFRidyM8avNMPlJwthJJAKYpib0C16t3rg8t/
         7lkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uV0tE7wFf4iDXsIGWtEvvLMw+8GMDfCmV/fmV+L5rtE=;
        b=fSmdwmACp8wp55EmjT1hFwJP1cVGDe/WvXqzyCbZYNBooxHpdA1iC81zk/bKjp7Ssv
         jKjyAlCUd4+ZB/nN79AaL6Tw5v+1KBB5Ocwx0XjkjS1sT6X7IeA9gLxHD0pNbX6F9x5b
         UfYvvapHUUh9hJkIGb/yb+XhVzw3VP4dljJAbhzuYcGWfHkBylV+6z/P3+IoMezng2na
         vr4XQoulGNqwHuyd/yY8RC+nkjIJcpza7qGES0RKsBXffJE9Jt0BhLEGlV1CG5Kicqz2
         VEr6qGS4JdrQafgRKcC9MV4pPSmtoHkLy7jIhIFGLpNOYWKz5qoQud5GXmHHxRZipfQw
         8r9Q==
X-Gm-Message-State: AOAM5301nXuJuCmVWzVJe12XrcaBvnRBltTpRgvFTQsa5MSjTQm7oxE5
	qpUW5PBIqdYIAiKiQ7IWh/6ioFFMsxi9ALBL4BuilA==
X-Google-Smtp-Source: ABdhPJzpHn0y6abLjMHwzZfMOYlSY1x/tDmVXtLr70lERpOAZ6Mr1OrxP6/6W1RpzzyfKPPPiW/omY0hhpf2kB2k3ag=
X-Received: by 2002:aa7:c148:: with SMTP id r8mr29631134edp.210.1600278024225;
 Wed, 16 Sep 2020 10:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2009140852030.22422@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gh=QaDB61_9_QTgtt-pZuTFdR6td0orE0VMH6=6SA2vw@mail.gmail.com>
 <alpine.LRH.2.02.2009151216050.16057@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009151332280.3851@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009160649560.20720@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gW6AvR+RaShHdQzOaEPv9nrq5myXDmywuoCTYDZxk-hw@mail.gmail.com> <alpine.LRH.2.02.2009161254400.745@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2009161254400.745@file01.intranet.prod.int.rdu2.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 16 Sep 2020 10:40:13 -0700
Message-ID: <CAPcyv4gD0ZFkfajKTDnJhEEjf+5Av-GH+cHRFoyhzGe8bNEgAA@mail.gmail.com>
Subject: Re: [PATCH] pmem: export the symbols __copy_user_flushcache and __copy_from_user_flushcache
To: Mikulas Patocka <mpatocka@redhat.com>
Message-ID-Hash: F32QT4FYXKTTY32AKZQBHAVIFRHRWBN3
X-Message-ID-Hash: F32QT4FYXKTTY32AKZQBHAVIFRHRWBN3
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Eric Sandeen <esandeen@redhat.com>, Dave Chinner <dchinner@redhat.com>, "Tadakamadla, Rajesh (DCIG/CDI/HPS Perf)" <rajesh.tadakamadla@hpe.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/F32QT4FYXKTTY32AKZQBHAVIFRHRWBN3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 16, 2020 at 10:24 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
>
>
> On Wed, 16 Sep 2020, Dan Williams wrote:
>
> > On Wed, Sep 16, 2020 at 3:57 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
> > >
> > >
> > >
> > > I'm submitting this patch that adds the required exports (so that we could
> > > use __copy_from_user_flushcache on x86, arm64 and powerpc). Please, queue
> > > it for the next merge window.
> >
> > Why? This should go with the first user, and it's not clear that it
> > needs to be relative to the current dax_operations export scheme.
>
> Before nvfs gets included in the kernel, I need to distribute it as a
> module. So, it would make my maintenance easier. But if you don't want to
> export it now, no problem, I can just copy __copy_user_flushcache from the
> kernel to the module.

That sounds a better plan than exporting symbols with no in-kernel consumer.

> > My first question about nvfs is how it compares to a daxfs with
> > executables and other binaries configured to use page cache with the
> > new per-file dax facility?
>
> nvfs is faster than dax-based filesystems on metadata-heavy operations
> because it doesn't have the overhead of the buffer cache and bios. See
> this: http://people.redhat.com/~mpatocka/nvfs/BENCHMARKS

...and that metadata problem is intractable upstream? Christoph poked
at bypassing the block layer for xfs metadata operations [1], I just
have not had time to carry that further.

[1]: "xfs: use dax_direct_access for log writes", although it seems
he's dropped that branch from his xfs.git
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 547F426C505
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Sep 2020 18:21:20 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6CC1C13FE81DA;
	Wed, 16 Sep 2020 09:21:18 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 84E9C13FE81B8
	for <linux-nvdimm@lists.01.org>; Wed, 16 Sep 2020 09:21:15 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id w1so6907872edr.3
        for <linux-nvdimm@lists.01.org>; Wed, 16 Sep 2020 09:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yFYB36o5sQGOopQLIZ3LmVh5DVkQCsLHuBBKUkF022U=;
        b=gfng9FWV0J0yb5BbFoXNVi6dZSBG/a54FXDC6xO+b/rTexcJnOWoPzO2/a311RfdwU
         DndBlAsVoWq4m+KQxFxruPUXfOu/H/4aLqR+oqmcepZCVdQTeqAY9wXyPg1oxjdISGWz
         gxKXAXmkYpxOqulD0ZtwHmI63UlmamOH+5KeY8Ewl5owECC7J4+/0xTe9BKFYWPLvR/G
         Gh4/swNnN+GowPmGP9+0t9WAvKqz9INT9J7grCQpb5LVfUk+xEjovR4QWxt/hEKBc/Ne
         MM/a/bzu/8Q2+EooAIv4i8PFQEts7EHmlv/ZDeS4LScQoEdZ9rnfCtw53Dx3UPFL411n
         3B7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yFYB36o5sQGOopQLIZ3LmVh5DVkQCsLHuBBKUkF022U=;
        b=hXsztMZ8VsGmE5s+T6n09vTfW4U0EbmO5vwkvyFyW48WrvlGeLFpas/Xs844WC6tk1
         UTwElil4ML+y31sPTpOvh7XYGsmxHWn/RpFmJiTjzkuisTnuxsVBTsBH1JwCnoqIeFRi
         BaHeHJZcG4pHxfFlgAl/BYKqdubVCIue0XycUbk4MKzbHs+QCN6HH9Dmt9CoKXZNYeYV
         pxmJ6bpTJsG/syvsWy0r63kkGy7i4KLrHoe0mhuUR+DYEGzUuWPR9ekhdYh3/DKPUMRr
         HiPIvJhdpk1p3k2nIqpweym5Hi2Hc9EICG8fh5NMSNLwJo462f9JnrbAApsgni8qxPmV
         7hyQ==
X-Gm-Message-State: AOAM531WWV227T2h9j+mW5d27gBmsyTmrWJxPe8udXSygswDiqTDoKgT
	PR/r6JWgbkj8CvScAStTF3RZ8nznzKK1QkhyJRw5KQ==
X-Google-Smtp-Source: ABdhPJwI88G6wJzJR/w0a81ppKmua0R7ZF2T841uxc4i05zvl4D9vTqu2QlDOKyf+whND4urfI7hRks/8DB+WSLHUoA=
X-Received: by 2002:aa7:d04d:: with SMTP id n13mr29447035edo.354.1600273273498;
 Wed, 16 Sep 2020 09:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2009140852030.22422@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gh=QaDB61_9_QTgtt-pZuTFdR6td0orE0VMH6=6SA2vw@mail.gmail.com>
 <alpine.LRH.2.02.2009151216050.16057@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009151332280.3851@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2009160649560.20720@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2009160649560.20720@file01.intranet.prod.int.rdu2.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 16 Sep 2020 09:21:02 -0700
Message-ID: <CAPcyv4gW6AvR+RaShHdQzOaEPv9nrq5myXDmywuoCTYDZxk-hw@mail.gmail.com>
Subject: Re: [PATCH] pmem: export the symbols __copy_user_flushcache and __copy_from_user_flushcache
To: Mikulas Patocka <mpatocka@redhat.com>
Message-ID-Hash: ZYXR272VH535Y4P4WKQXDAWPLARD4RDD
X-Message-ID-Hash: ZYXR272VH535Y4P4WKQXDAWPLARD4RDD
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Eric Sandeen <esandeen@redhat.com>, Dave Chinner <dchinner@redhat.com>, "Tadakamadla, Rajesh (DCIG/CDI/HPS Perf)" <rajesh.tadakamadla@hpe.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZYXR272VH535Y4P4WKQXDAWPLARD4RDD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 16, 2020 at 3:57 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
>
>
> On Tue, 15 Sep 2020, Mikulas Patocka wrote:
>
> >
> >
> > On Tue, 15 Sep 2020, Mikulas Patocka wrote:
> >
> > > > > - __copy_from_user_inatomic_nocache doesn't flush cache for leading and
> > > > > trailing bytes.
> > > >
> > > > You want copy_user_flushcache(). See how fs/dax.c arranges for
> > > > dax_copy_from_iter() to route to pmem_copy_from_iter().
> > >
> > > Is it something new for the kernel 5.10? I see only __copy_user_flushcache
> > > that is implemented just for x86 and arm64.
> > >
> > > There is __copy_from_user_flushcache implemented for x86, arm64 and power.
> > > It is used in lib/iov_iter.c under
> > > #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE - so should I use this?

Yes, but maybe not directly.

> > >
> > > Mikulas
> >
> > ... and __copy_user_flushcache is not exported for modules. So, I am stuck
> > with __copy_from_user_inatomic_nocache.
> >
> > Mikulas
>
> I'm submitting this patch that adds the required exports (so that we could
> use __copy_from_user_flushcache on x86, arm64 and powerpc). Please, queue
> it for the next merge window.

Why? This should go with the first user, and it's not clear that it
needs to be relative to the current dax_operations export scheme.

My first question about nvfs is how it compares to a daxfs with
executables and other binaries configured to use page cache with the
new per-file dax facility?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

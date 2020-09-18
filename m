Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 700F626EAB6
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Sep 2020 03:53:59 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 78DB613FD881F;
	Thu, 17 Sep 2020 18:53:57 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::642; helo=mail-ej1-x642.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D7E9A13568225
	for <linux-nvdimm@lists.01.org>; Thu, 17 Sep 2020 18:53:55 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id j11so6001241ejk.0
        for <linux-nvdimm@lists.01.org>; Thu, 17 Sep 2020 18:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GC2uboF6NMZuC9/ZByaXp1KFBIoZjwLF73X8h59tMWs=;
        b=0n1kgcoBcO/MRG9AAQs28nlby+4uxxdWNINGwW2Okw2teha+5tUcRRM1S51DHvxjbe
         R8Cq+ItKHDbs5yC2r01vwPHgrzycwMkOBbRrsESuJbMdrF8xDKW+v6w7S1lQVw6CX4P9
         M9/7dgueosqWOddYA7f6ndQv2GVxNDfUmiVHE9QYX1uxi2bJty6xyL5m9lsyI5Tr0Ip5
         vxRKjnhcKMG6MwVZlo/19T+6Z8bhvWhZgkjv7bAiYeodgKLsWm9r4VxuokZiIFVcibHq
         AM6HBNJxSr8ACewbKnPZO1qmqRKpaxVJT1GKpdKqb7WgNxAmeZKt4bXcW8QyoirezqiZ
         fWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GC2uboF6NMZuC9/ZByaXp1KFBIoZjwLF73X8h59tMWs=;
        b=uVH859xwSsd+AAzOxFfhpzD8uT6hnLu91Rj8MeW/5RlC2M79hcsKz7NXKVGqqNwIvE
         RULyg8Ljy8Es5awzir7K+oXXcGZvstyWlJA+TXiNzLh8VdxQk0xN95UZEmlj7KAQIRLH
         3R1twbCB11aYX2T+4VsY7wBwxux542fNwQlHPxZlyF8lRP3dMFahWZEZzs/1/4/OFkBu
         FN2rsf5QEhWp0dMEO7U1ET65UyWjnrV46J8+WlNe3eoHnxtsIae89cC7RjpAKnO/gjzL
         AIng8LlISbfQQ3wT0sDa+gWn1SJfuIeFwrRRymwHEtgeJ6kpWyPzMcbQwNvhoRb4+dBC
         HDAA==
X-Gm-Message-State: AOAM533S49kjPGVQsX7YGriZSgKnPQYpHuawgopHPCAAWR8ZWTsCRMpR
	8lZaKfBs8IoqyTls3i4wAoO4NCr3LR6rFW4RQLCK5g==
X-Google-Smtp-Source: ABdhPJy7DFdMdaS97xMoxRqS6WmXgsRrt5dbwajDW1OzguEa9uaz85Fv52jSvKPNcbb4yTlLVhfIEfhmycxKE179n6U=
X-Received: by 2002:a17:906:8143:: with SMTP id z3mr33115785ejw.323.1600394032604;
 Thu, 17 Sep 2020 18:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2009140852030.22422@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gh=QaDB61_9_QTgtt-pZuTFdR6td0orE0VMH6=6SA2vw@mail.gmail.com>
 <alpine.LRH.2.02.2009151216050.16057@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009151332280.3851@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009160649560.20720@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gW6AvR+RaShHdQzOaEPv9nrq5myXDmywuoCTYDZxk-hw@mail.gmail.com>
 <alpine.LRH.2.02.2009161254400.745@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gD0ZFkfajKTDnJhEEjf+5Av-GH+cHRFoyhzGe8bNEgAA@mail.gmail.com> <alpine.LRH.2.02.2009161451140.21915@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2009161451140.21915@file01.intranet.prod.int.rdu2.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 17 Sep 2020 18:53:41 -0700
Message-ID: <CAPcyv4gFz6vBVVp_aiX4i2rL+8fps3gTQGj5cYw8QESCf7=DfQ@mail.gmail.com>
Subject: Re: [PATCH] pmem: fix __copy_user_flushcache
To: Mikulas Patocka <mpatocka@redhat.com>
Message-ID-Hash: 7S2PZH5CIHFNKWBVYUCMOX7IVCIGX3I3
X-Message-ID-Hash: 7S2PZH5CIHFNKWBVYUCMOX7IVCIGX3I3
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Eric Sandeen <esandeen@redhat.com>, Dave Chinner <dchinner@redhat.com>, "Tadakamadla, Rajesh (DCIG/CDI/HPS Perf)" <rajesh.tadakamadla@hpe.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7S2PZH5CIHFNKWBVYUCMOX7IVCIGX3I3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 16, 2020 at 11:57 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
>
>
> On Wed, 16 Sep 2020, Dan Williams wrote:
>
> > On Wed, Sep 16, 2020 at 10:24 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
> > >
> > >
> > >
> > > On Wed, 16 Sep 2020, Dan Williams wrote:
> > >
> > > > On Wed, Sep 16, 2020 at 3:57 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > I'm submitting this patch that adds the required exports (so that we could
> > > > > use __copy_from_user_flushcache on x86, arm64 and powerpc). Please, queue
> > > > > it for the next merge window.
> > > >
> > > > Why? This should go with the first user, and it's not clear that it
> > > > needs to be relative to the current dax_operations export scheme.
> > >
> > > Before nvfs gets included in the kernel, I need to distribute it as a
> > > module. So, it would make my maintenance easier. But if you don't want to
> > > export it now, no problem, I can just copy __copy_user_flushcache from the
> > > kernel to the module.
> >
> > That sounds a better plan than exporting symbols with no in-kernel consumer.
>
> BTW, this function is buggy. Here I'm submitting the patch.
>
>
>
> From: Mikulas Patocka <mpatocka@redhat.com>
>
> If we copy less than 8 bytes and if the destination crosses a cache line,
> __copy_user_flushcache would invalidate only the first cache line. This
> patch makes it invalidate the second cache line as well.

Good catch.

> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org
>
> ---
>  arch/x86/lib/usercopy_64.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Index: linux-2.6/arch/x86/lib/usercopy_64.c
> ===================================================================
> --- linux-2.6.orig/arch/x86/lib/usercopy_64.c   2020-09-05 10:01:27.000000000 +0200
> +++ linux-2.6/arch/x86/lib/usercopy_64.c        2020-09-16 20:48:31.000000000 +0200
> @@ -120,7 +120,7 @@ long __copy_user_flushcache(void *dst, c
>          */
>         if (size < 8) {
>                 if (!IS_ALIGNED(dest, 4) || size != 4)
> -                       clean_cache_range(dst, 1);
> +                       clean_cache_range(dst, size);
>         } else {
>                 if (!IS_ALIGNED(dest, 8)) {
>                         dest = ALIGN(dest, boot_cpu_data.x86_clflush_size);
>

You can add:

Fixes: 0aed55af8834 ("x86, uaccess: introduce
copy_from_iter_flushcache for pmem / cache-bypass operations")
Reviewed-by: Dan Williams <dan.j.wiilliams@intel.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

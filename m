Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB88367334
	for <lists+linux-nvdimm@lfdr.de>; Wed, 21 Apr 2021 21:10:08 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 441F8100EBB81;
	Wed, 21 Apr 2021 12:10:06 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A8DE9100EC1CE
	for <linux-nvdimm@lists.01.org>; Wed, 21 Apr 2021 12:10:03 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id i3so24924960edt.1
        for <linux-nvdimm@lists.01.org>; Wed, 21 Apr 2021 12:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NBcAuPkDB8yn7vxrbycYSSA5wndCepu03NrNjeW39ik=;
        b=pthqRNwvDGzcKw29vq+beBkIOvNN/fF7gZ2Xe3IXaGqVyzwBsLaqthgSuIMoUo8IW+
         gumEibGbH+L9n3/IkDXke2EWisNXcNsuQf6FnbaaEy/QeVNwKXdGbkZ8gOO9PSRg/1tX
         kwpHvf8Dnvam7XnxffqBhiCqCrOzMrFlKJ0zzdSJYgIVgPVSylOM6txrHN/8UiwP6HfA
         yla17QS2aL3iB+isH0nkwPXzzVoti8Zr1k8OZUkULS65Qk4I6Ao+xwxtWVYQdJYqZq+u
         WaYCdpb8iRaFCZA0dUw7sziGDrn8XZ0N4rnmBOYyoVOkjZHatSAF/GDUpT6/5BGbcEFC
         b0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NBcAuPkDB8yn7vxrbycYSSA5wndCepu03NrNjeW39ik=;
        b=UFmhRRxDEXVI7dQtP2lXlJzOzO63AvRh3+I3fNZ/rcScSeVAMcKkxqs46Mcu5q6egc
         PibEpjiujSNjJ+2/m2mNglSp8hzAgajeTzNf3WMQbSelcuQtiLsLDLYUBdJKFmQgvMBH
         Y/DrdsCvRMGu6VfulSpjt0CaD/qgXRRXDZiLpIMN3U9UPvRRGsWZbvADqb5r6xhjcb03
         LKQ/xANc1Qs8vf1DsIbOo9jkpfWPML+BAVXm5Uvep+Xo5OOXGdnvWtxqPRMX2lnMNIhL
         htlxm40fNKsiSXil93+Z73y706HpYaVOmAIpq+nNeU/kM+FpeMSCk02QZK53iwKSXXc4
         XPOA==
X-Gm-Message-State: AOAM533XTRxLIv/JuJxTF6B7r4ZW6eX0ngKoo/t1wOLVBWNC67Q0hOk4
	zpvaar5pIlnEwpvfSBBcVW7Jqm+gwizgwdQxinTDBg==
X-Google-Smtp-Source: ABdhPJzUzvWoqsHVgj6q4VHtvt/KU0qakEZL3zMXCyN6iQAH2qDqBVdMEkOUp4sI5gEzwoBW8HbVmWc5LR0glCxieKk=
X-Received: by 2002:a50:e607:: with SMTP id y7mr40985113edm.18.1619032201627;
 Wed, 21 Apr 2021 12:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210419213636.1514816-1-vgoyal@redhat.com> <20210419213636.1514816-3-vgoyal@redhat.com>
 <20210420093420.2eed3939@bahia.lan> <20210420140033.GA1529659@redhat.com>
In-Reply-To: <20210420140033.GA1529659@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 21 Apr 2021 12:09:54 -0700
Message-ID: <CAPcyv4g2raipYhivwbiSvsHmSdgLO8wphh5dhY3hpjwko9G4Hw@mail.gmail.com>
Subject: Re: [Virtio-fs] [PATCH v3 2/3] dax: Add a wakeup mode parameter to put_unlocked_entry()
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID-Hash: DM56LTNCLWWF7MILCB4E665BFZ4IDAPC
X-Message-ID-Hash: DM56LTNCLWWF7MILCB4E665BFZ4IDAPC
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Greg Kurz <groug@kaod.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Miklos Szeredi <miklos@szeredi.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtio-fs-list <virtio-fs@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DM56LTNCLWWF7MILCB4E665BFZ4IDAPC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Apr 20, 2021 at 7:01 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Tue, Apr 20, 2021 at 09:34:20AM +0200, Greg Kurz wrote:
> > On Mon, 19 Apr 2021 17:36:35 -0400
> > Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > > As of now put_unlocked_entry() always wakes up next waiter. In next
> > > patches we want to wake up all waiters at one callsite. Hence, add a
> > > parameter to the function.
> > >
> > > This patch does not introduce any change of behavior.
> > >
> > > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > > ---
> > >  fs/dax.c | 13 +++++++------
> > >  1 file changed, 7 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/fs/dax.c b/fs/dax.c
> > > index 00978d0838b1..f19d76a6a493 100644
> > > --- a/fs/dax.c
> > > +++ b/fs/dax.c
> > > @@ -275,11 +275,12 @@ static void wait_entry_unlocked(struct xa_state *xas, void *entry)
> > >     finish_wait(wq, &ewait.wait);
> > >  }
> > >
> > > -static void put_unlocked_entry(struct xa_state *xas, void *entry)
> > > +static void put_unlocked_entry(struct xa_state *xas, void *entry,
> > > +                          enum dax_entry_wake_mode mode)
> > >  {
> > >     /* If we were the only waiter woken, wake the next one */
> >
> > With this change, the comment is no longer accurate since the
> > function can now wake all waiters if passed mode == WAKE_ALL.
> > Also, it paraphrases the code which is simple enough, so I'd
> > simply drop it.
> >
> > This is minor though and it shouldn't prevent this fix to go
> > forward.
> >
> > Reviewed-by: Greg Kurz <groug@kaod.org>
>
> Ok, here is the updated patch which drops that comment line.
>
> Vivek

Hi Vivek,

Can you get in the habit of not replying inline with new patches like
this? Collect the review feedback, take a pause, and resend the full
series so tooling like b4 and patchwork can track when a new posting
supersedes a previous one. As is, this inline style inflicts manual
effort on the maintainer.

>
> Subject: dax: Add a wakeup mode parameter to put_unlocked_entry()
>
> As of now put_unlocked_entry() always wakes up next waiter. In next
> patches we want to wake up all waiters at one callsite. Hence, add a
> parameter to the function.
>
> This patch does not introduce any change of behavior.
>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/dax.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> Index: redhat-linux/fs/dax.c
> ===================================================================
> --- redhat-linux.orig/fs/dax.c  2021-04-20 09:55:45.105069893 -0400
> +++ redhat-linux/fs/dax.c       2021-04-20 09:56:27.685822730 -0400
> @@ -275,11 +275,11 @@ static void wait_entry_unlocked(struct x
>         finish_wait(wq, &ewait.wait);
>  }
>
> -static void put_unlocked_entry(struct xa_state *xas, void *entry)
> +static void put_unlocked_entry(struct xa_state *xas, void *entry,
> +                              enum dax_entry_wake_mode mode)
>  {
> -       /* If we were the only waiter woken, wake the next one */
>         if (entry && !dax_is_conflict(entry))
> -               dax_wake_entry(xas, entry, WAKE_NEXT);
> +               dax_wake_entry(xas, entry, mode);
>  }
>
>  /*
> @@ -633,7 +633,7 @@ struct page *dax_layout_busy_page_range(
>                         entry = get_unlocked_entry(&xas, 0);
>                 if (entry)
>                         page = dax_busy_page(entry);
> -               put_unlocked_entry(&xas, entry);
> +               put_unlocked_entry(&xas, entry, WAKE_NEXT);
>                 if (page)
>                         break;
>                 if (++scanned % XA_CHECK_SCHED)
> @@ -675,7 +675,7 @@ static int __dax_invalidate_entry(struct
>         mapping->nrexceptional--;
>         ret = 1;
>  out:
> -       put_unlocked_entry(&xas, entry);
> +       put_unlocked_entry(&xas, entry, WAKE_NEXT);
>         xas_unlock_irq(&xas);
>         return ret;
>  }
> @@ -954,7 +954,7 @@ static int dax_writeback_one(struct xa_s
>         return ret;
>
>   put_unlocked:
> -       put_unlocked_entry(xas, entry);
> +       put_unlocked_entry(xas, entry, WAKE_NEXT);
>         return ret;
>  }
>
> @@ -1695,7 +1695,7 @@ dax_insert_pfn_mkwrite(struct vm_fault *
>         /* Did we race with someone splitting entry or so? */
>         if (!entry || dax_is_conflict(entry) ||
>             (order == 0 && !dax_is_pte_entry(entry))) {
> -               put_unlocked_entry(&xas, entry);
> +               put_unlocked_entry(&xas, entry, WAKE_NEXT);
>                 xas_unlock_irq(&xas);
>                 trace_dax_insert_pfn_mkwrite_no_entry(mapping->host, vmf,
>                                                       VM_FAULT_NOPAGE);
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

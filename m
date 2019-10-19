Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0B1DDB6E
	for <lists+linux-nvdimm@lfdr.de>; Sun, 20 Oct 2019 01:27:40 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B77061007B68D;
	Sat, 19 Oct 2019 16:29:35 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BC4081007B68C
	for <linux-nvdimm@lists.01.org>; Sat, 19 Oct 2019 16:29:33 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id o205so8159678oib.12
        for <linux-nvdimm@lists.01.org>; Sat, 19 Oct 2019 16:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3J1jZ/n3oL2BPGIWFZaJFKJlZuVwc5pXYUu/dIK5arI=;
        b=T+psi48ohJfRR1GMOlfSgYdd36qHs4P9a+xR60PQDWs3XG25CJh+FKeinlvLdnlLte
         oLrZIR2ogyz8jn3NT2WGneJtpW71T/aReyOSWiKqztT8WNXSJLeGenz7OYkdOS+p1SfO
         vwjaXIvW8eTssResIjsUvMEXNZ7ma8OGuIiL9wDfzZiaLTgffog1aifUBAZJNQ2/tfU3
         eu5jESGsp9//2zkHW0jD4WsqRgNh3Br8DxOTmSw1n4J410a1FaE51KOUW8YecPDEkld5
         GdekJkpvPWaJkfuY2VPbXoLS1kQIeymhGLSf4UGWu4Z+K/s+Y9QaOvUqpKtoYIdGRXRz
         qPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3J1jZ/n3oL2BPGIWFZaJFKJlZuVwc5pXYUu/dIK5arI=;
        b=GDecZRZwdiwq4eXaSumd2bwqPewDU2VwmtbwZqhaXy9Fyp5cwj0vjp5XQ/kbllrV5D
         zvaRAI8y8UnDNzDK1zhxd9x68lzpOcrqWOrFBpxBxuxSObOr5c7HHH2n+y4MqAvipHEe
         +txpbasSUWzpl71xSblcxt8Ef6r+7t3pGD3JQHj7P0GfdmbVc5QQfZ/exXUHZCZZfuoE
         5a2eIwgN+2On4/oSdO5lKpWTke1qYp3KhS5JOMRDba7OdgceA3lrhq95PfFrCYQEJfiP
         1cIM8ZjzoUKKmOYzGio9KHPXBQbRtHNVYIWRF5PGjjUt/8b+kliHI6Pl84nd3ZjABUMr
         HkNQ==
X-Gm-Message-State: APjAAAXuTsakG+AgN6vK2MAGenf/DvxUlHa02v+i+z2IDmji2k9RkGxf
	ljIcYLSWa0cfGe1mehSqkEBk1NF6hBKnD/gbA8PYvQ==
X-Google-Smtp-Source: APXvYqwTmZrTbxXuJ19lehyTkMwlX85En8TEvDWQiYgioR6j7EF0BYhEAUOgoPXcnncF+IB6q91TK5YYOJ0uaOHO+Yw=
X-Received: by 2002:aca:620a:: with SMTP id w10mr13893693oib.0.1571527655430;
 Sat, 19 Oct 2019 16:27:35 -0700 (PDT)
MIME-Version: 1.0
References: <157150237973.3940076.12626102230619807187.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20191019205003.GN32665@bombadil.infradead.org> <CAPcyv4jj-BqhPj3vB5=G7YfGPvBgugEZ39gf+3Wwn6BC1fAUJw@mail.gmail.com>
In-Reply-To: <CAPcyv4jj-BqhPj3vB5=G7YfGPvBgugEZ39gf+3Wwn6BC1fAUJw@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 19 Oct 2019 16:27:24 -0700
Message-ID: <CAPcyv4hDXWTEZC__3zK8PeJNStmsjwzAQb+CqDOUYjuLx0J9Ag@mail.gmail.com>
Subject: Re: [PATCH] fs/dax: Fix pmd vs pte conflict detection
To: Matthew Wilcox <willy@infradead.org>
Message-ID-Hash: RO6XTKP7O55TP6CUW6MAJCKOPFUDMUXA
X-Message-ID-Hash: RO6XTKP7O55TP6CUW6MAJCKOPFUDMUXA
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jeff Smits <jeff.smits@intel.com>, Doug Nelson <doug.nelson@intel.com>, stable <stable@vger.kernel.org>, Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RO6XTKP7O55TP6CUW6MAJCKOPFUDMUXA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Oct 19, 2019 at 4:09 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Sat, Oct 19, 2019 at 1:50 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Sat, Oct 19, 2019 at 09:26:19AM -0700, Dan Williams wrote:
> > > Check for NULL entries before checking the entry order, otherwise NULL
> > > is misinterpreted as a present pte conflict. The 'order' check needs to
> > > happen before the locked check as an unlocked entry at the wrong order
> > > must fallback to lookup the correct order.
> > >
> > > Reported-by: Jeff Smits <jeff.smits@intel.com>
> > > Reported-by: Doug Nelson <doug.nelson@intel.com>
> > > Cc: <stable@vger.kernel.org>
> > > Fixes: 23c84eb78375 ("dax: Fix missed wakeup with PMD faults")
> > > Cc: Jan Kara <jack@suse.cz>
> > > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > >  fs/dax.c |    5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/dax.c b/fs/dax.c
> > > index a71881e77204..08160011d94c 100644
> > > --- a/fs/dax.c
> > > +++ b/fs/dax.c
> > > @@ -221,10 +221,11 @@ static void *get_unlocked_entry(struct xa_state *xas, unsigned int order)
> > >
> > >       for (;;) {
> > >               entry = xas_find_conflict(xas);
> > > +             if (!entry || WARN_ON_ONCE(!xa_is_value(entry)))
> > > +                     return entry;
> > >               if (dax_entry_order(entry) < order)
> > >                       return XA_RETRY_ENTRY;
> > > -             if (!entry || WARN_ON_ONCE(!xa_is_value(entry)) ||
> > > -                             !dax_is_locked(entry))
> > > +             if (!dax_is_locked(entry))
> > >                       return entry;
> >
> > Yes, I think this works.  Should we also add:
> >
> >  static unsigned int dax_entry_order(void *entry)
> >  {
> > +       BUG_ON(!xa_is_value(entry));
> >         if (xa_to_value(entry) & DAX_PMD)
> >                 return PMD_ORDER;
> >         return 0;
> >  }
> >
> > which would have caught this logic error before it caused a performance
> > regression?
>
> Sounds good will add it to v2.

...except that there are multiple dax helpers that have the 'value'
entry assumption. I'd rather do all of them in a separate patch, or
none of them. It turns out that after this change all
dax_entry_order() invocations are now protected by a xa_is_value()
assert earlier in the calling function.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

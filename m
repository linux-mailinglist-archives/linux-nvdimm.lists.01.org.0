Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B085EE82
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Jul 2019 23:28:57 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 187B1212AD598;
	Wed,  3 Jul 2019 14:28:56 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5F996212AD58A
 for <linux-nvdimm@lists.01.org>; Wed,  3 Jul 2019 14:28:54 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id z23so3874993ote.13
 for <linux-nvdimm@lists.01.org>; Wed, 03 Jul 2019 14:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8Oa5fyrgRSaS4/rlLU6Dg1I751HN6ZGGg3XuTeNEsyA=;
 b=EVDV2i92j6Oc8X9cDYFxw3faBgrvRgokearOh6hTInPcfDEF/9Dw3KaF4Zq6F/M1Po
 7PhktLMJwFP6nTQp9RrenWueYOGk2EVUa/0Qx0+hUltXSvdhvIuEHI+qKgYeF3B1eFlS
 5Y3swajWUyLDnwgyIA3axCIg+XMQUJMGQtIBwCbx1V1d//Itvxh9xcx753a7zTQU7G7q
 9Zf9F4ew3jdtrywY3ZSbzOZTGZe1X8L9mb5LB87Kgaj4vPdRVLpEenwZhPzX+x7S/pLI
 SKnQAFXjTLXqteyTAJ1slhEtrupPHQDbOkd7sNBcRXPLRfHg2/4qMUGQWkb8jOyatu6m
 VoNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8Oa5fyrgRSaS4/rlLU6Dg1I751HN6ZGGg3XuTeNEsyA=;
 b=nbbarHgbln9irPy/z9MXWGzkSfBRqkSkRlHTfuUugF9GsqaLgtoe8rHDWGMAcrINXw
 TbHjV0dzLMnteMW5MXZkMAJPoRBVQQxhBvvx1ygdfrga16KfcAN3MGEHv2MxT8nP5dFP
 CE/GkHN3re9QxR2ujhbFHSc7DQoP5ZPh+iYDQTTPelInc9Yk5lJxInK032PmOC0qgkma
 xCW+7SNkDS80ORPQ+0SsZ0svoEQD+u6tUyXnioh0RfIcVW4CpKroFhZ5FjSHo4oqqobD
 MEH85sxAXGVF9rwB0IgC255FQev3gQ1pX8ki87AnfDeSJ2QTtaqN6anFAuFkJf/RYgPA
 Y1ew==
X-Gm-Message-State: APjAAAViifDB1pTFTaOTr8t6PsrKMNl4ktREA0p7BkEEQSEmPT1VhEv4
 dkL8D7/+IWLXiyrd2JezClvuXFVQSQQ2FUBXbVNB7g==
X-Google-Smtp-Source: APXvYqx/eeik3ZxIiy7z87X0O8OLG62WiPNdXk3FcnhR2wJoQDPQ4BqLvO7rM7/LGIyRCPcHEmicv2tHJYa45mbHcK0=
X-Received: by 2002:a9d:7248:: with SMTP id a8mr32385007otk.363.1562189332829; 
 Wed, 03 Jul 2019 14:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <156213869409.3910140.7715747316991468148.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190703121743.GH1729@bombadil.infradead.org>
 <CAPcyv4jgs5LTtTXR+2CyfbjJE85B_eoPFuXQsGBDnVMo41Jawg@mail.gmail.com>
 <20190703195302.GJ1729@bombadil.infradead.org>
In-Reply-To: <20190703195302.GJ1729@bombadil.infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 3 Jul 2019 14:28:41 -0700
Message-ID: <CAPcyv4iPNz=oJyc_EoE-mC11=gyBzwMKbmj1ZY_Yna54=cC=Mg@mail.gmail.com>
Subject: Re: [PATCH] dax: Fix missed PMD wakeups
To: Matthew Wilcox <willy@infradead.org>
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Seema Pandit <seema.pandit@intel.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, Boaz Harrosh <openosd@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, Robert Barror <robert.barror@intel.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jul 3, 2019 at 12:53 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Jul 03, 2019 at 10:01:37AM -0700, Dan Williams wrote:
> > On Wed, Jul 3, 2019 at 5:17 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Wed, Jul 03, 2019 at 12:24:54AM -0700, Dan Williams wrote:
> > > > This fix may increase waitqueue contention, but a fix for that is saved
> > > > for a larger rework. In the meantime this fix is suitable for -stable
> > > > backports.
> > >
> > > I think this is too big for what it is; just the two-line patch to stop
> > > incorporating the low bits of the PTE would be more appropriate.
> >
> > Sufficient, yes, "appropriate", not so sure. All those comments about
> > pmd entry size are stale after this change.
>
> But then they'll have to be put back in again.  This seems to be working
> for me, although I doubt I'm actually hitting the edge case that rocksdb
> hits:

Seems to be holding up under testing here, a couple comments...

>
> diff --git a/fs/dax.c b/fs/dax.c
> index 2e48c7ebb973..e77bd6aef10c 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -198,6 +198,10 @@ static void dax_wake_entry(struct xa_state *xas, void *entry, bool wake_all)
>   * if it did.
>   *
>   * Must be called with the i_pages lock held.
> + *
> + * If the xa_state refers to a larger entry, then it may return a locked
> + * smaller entry (eg a PTE entry) without waiting for the smaller entry
> + * to be unlocked.
>   */
>  static void *get_unlocked_entry(struct xa_state *xas)
>  {
> @@ -211,7 +215,8 @@ static void *get_unlocked_entry(struct xa_state *xas)
>         for (;;) {
>                 entry = xas_find_conflict(xas);
>                 if (!entry || WARN_ON_ONCE(!xa_is_value(entry)) ||
> -                               !dax_is_locked(entry))
> +                               !dax_is_locked(entry) ||
> +                               dax_entry_order(entry) < xas_get_order(xas))

Doesn't this potentially allow a locked entry to be returned for a
caller that expects all value entries are unlocked?

>                         return entry;
>
>                 wq = dax_entry_waitqueue(xas, entry, &ewait.key);
> @@ -253,8 +258,12 @@ static void wait_entry_unlocked(struct xa_state *xas, void *entry)
>
>  static void put_unlocked_entry(struct xa_state *xas, void *entry)
>  {
> -       /* If we were the only waiter woken, wake the next one */
> -       if (entry)
> +       /*
> +        * If we were the only waiter woken, wake the next one.
> +        * Do not wake anybody if the entry is locked; that indicates
> +        * we weren't woken.
> +        */
> +       if (entry && !dax_is_locked(entry))
>                 dax_wake_entry(xas, entry, false);
>  }
>
> diff --git a/include/linux/xarray.h b/include/linux/xarray.h
> index 052e06ff4c36..b17289d92af4 100644
> --- a/include/linux/xarray.h
> +++ b/include/linux/xarray.h
> @@ -1529,6 +1529,27 @@ static inline void xas_set_order(struct xa_state *xas, unsigned long index,
>  #endif
>  }
>
> +/**
> + * xas_get_order() - Get the order of the entry being operated on.
> + * @xas: XArray operation state.
> + *
> + * Return: The order of the entry.
> + */
> +static inline unsigned int xas_get_order(const struct xa_state *xas)
> +{
> +       unsigned int order = xas->xa_shift;
> +
> +#ifdef CONFIG_XARRAY_MULTI
> +       unsigned int sibs = xas->xa_sibs;
> +
> +       while (sibs) {
> +               order++;
> +               sibs /= 2;
> +       }

Use ilog2() here?
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

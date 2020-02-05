Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33A91538DA
	for <lists+linux-nvdimm@lfdr.de>; Wed,  5 Feb 2020 20:16:38 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C0D6410FC33EF;
	Wed,  5 Feb 2020 11:19:54 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 60F8110FC33EF
	for <linux-nvdimm@lists.01.org>; Wed,  5 Feb 2020 11:19:52 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id d62so1876273oia.11
        for <linux-nvdimm@lists.01.org>; Wed, 05 Feb 2020 11:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kG9teMHZvKj83PV4fp8fY8BsxTYQWRKjjz7ehdg3mrc=;
        b=0MJSlS3LElltcvef9nV/01pZjfF3M38v+aeQrKeioWE/Q4Mw1Tr6CVJ4oScY9Y+zo6
         Au4MzRMWSjFkDc1SRuoJklekirT4Zv++7WJHlKEK3SY8JmfR0uo6NSJURE570sNI+WPc
         1L6WLTzl1AyefFT0eAtp2sNpqcdunodBioxKTPM1SukW+yc9UYyN8b0Kq8A+sagH9eMg
         cDQNJqHAU8gZJF69/eud29MTwyx+2OsB20bPMTD/ONixJiLF2BdWKWeSgWVjPMHayo0n
         Vf4T5Clwaxtb2+Q8+jHgDkDkuc0+Rq9CNL4/twWJuUaXAk+eSMtnwSM7qVabkeKxjCHT
         7vuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kG9teMHZvKj83PV4fp8fY8BsxTYQWRKjjz7ehdg3mrc=;
        b=llE1jp+atfg/UmN+Nr249gtXXPmrdoozmb1MgWsNuLFb2i+9xYMZy/O1Z91JYhJCEA
         RhOR2tqWhWSUDKPQVq2v3Kk85HbBwRiTjmdnwzB3iHvVSTmSxRmle9Gk4ycOIVf0nRaD
         ftUCMdYM/6orBDZ410nbIN9iSQ0bhKHGB0My4yUYgmcmrB8ukU+oQZlHlkRysHfwOgcm
         g1lVlLinQS1Uy7/M0NZDWATaayppE6VdNrObITpQFD3n9uwuS20sWjZTrV7IX1gYGeZ3
         N1cObLGO/DW0HkCLZTBZ919a8tyhhfXH03deSf1UK4upw4I7Lna4e3Vegnh9035h/7Vg
         VMqA==
X-Gm-Message-State: APjAAAUt0PKnBn6vrcSw7kOCTulQHz6UDJP/rZ8wr5NlOsHRyfIRNZxb
	VPSrhJOMTjeSVFjdH3ZrZx8IQFGpnLhLLimm1p3f2g==
X-Google-Smtp-Source: APXvYqyVNLq2i8/hjZCiST+M1YV3UPsmOrpzvbKsuxqgVclij+tnQRYupZeiNQ0wj4OcisM5dHRF1f1HT0EGuVeFnTQ=
X-Received: by 2002:aca:aa0e:: with SMTP id t14mr4216930oie.149.1580930194138;
 Wed, 05 Feb 2020 11:16:34 -0800 (PST)
MIME-Version: 1.0
References: <20200205123826.kdvtsm47iy2ihw6r@kili.mountain>
 <CAPcyv4j12vgjgEgY3xAr9bpV8dd+3E7Q5Q3OFo2AXmwnN45PBA@mail.gmail.com>
 <20200205181040.GC24804@kadam> <CAPcyv4itFypOmv38Oo=DRWk_1Y3PFhPpYPDzxShmZVY9ZsTNLA@mail.gmail.com>
 <20200205190845.GD24804@kadam>
In-Reply-To: <20200205190845.GD24804@kadam>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 5 Feb 2020 11:16:22 -0800
Message-ID: <CAPcyv4jkTHeS2zTmYRoFi+evMemhmMkvPVcsBOQGXinGq6JyiQ@mail.gmail.com>
Subject: Re: [bug report] libnvdimm, nvdimm: dimm driver and base libnvdimm
 device-driver infrastructure
To: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID-Hash: 2M7HJNKQYERBAODFYXX36ER4X2J2BEQU
X-Message-ID-Hash: 2M7HJNKQYERBAODFYXX36ER4X2J2BEQU
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2M7HJNKQYERBAODFYXX36ER4X2J2BEQU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 5, 2020 at 11:08 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Wed, Feb 05, 2020 at 10:23:00AM -0800, Dan Williams wrote:
> > > > >    506          if (device_add(dev) != 0) {
> > > > >    507                  dev_err(dev, "%s: failed\n", __func__);
> > > > >    508                  put_device(dev);
> > > > >                         ^^^^^^^^^^^^^^^
> > > > >    509          }
> > > > >    510          put_device(dev);
> > > > >                 ^^^^^^^^^^^^^^
> > > > >    511          if (dev->parent)
> > > > >    512                  put_device(dev->parent);
> > > > >    513  }
> > > > >
> > > > > We call get_device() from __nd_device_register(), I guess.  It seems
> > > > > buggy to call put device twice on error.
> > > >
> > > > The registration path does:
> > > >
> > > >         get_device(dev);
> > > >
> > > >         async_schedule_dev_domain(nd_async_device_register, dev,
> > > >                                   &nd_async_domain);
> > > >
> > > > ...and device_add() does its own get_device().
> > >
> > > device_add() does its own put_device() at the end so it's a net zero.
> > >
> >
> > It does it's own, yes, but the put_device() after device_add() failure
> > is there to drop the reference taken by device_initialize().
> > Otherwise, device_add() has always documented:
> >
> >  * NOTE: _Never_ directly free @dev after calling this function, even
> >  * if it returned an error! Always use put_device() to give up your
> >  * reference instead.
> >
> > ...so what am I missing?
>
> The "never call kfree" is hopefully straight forward because the kobject
> needs to do its own cleanup.
>
> __nvdimm_create() allocates the dev.
> nd_device_register() calls device_initialize() which call kobject_init()
>    so the refcount is 1.
> __nd_device_register() call get_device() so the refcount is now two.
> nd_async_device_register() decrements the refcount once on success.
>
> But if device_add() fails then it decrements it twice.  Now the refcount
> is zero so we call nvdimm_release().  This leads to a use after free on
> the next line:
>
>         put_device(dev);
>         if (dev->parent)
>
> There is a trick here because depending on the debug options it
> might free immediately or it might call nvdimm_release() after 4
> seconds.  See kobject_release() for details.
>
> Either way if device_add() fails we return back to __nvdimm_create()
> and return the zero reference count "nvdimm" pointer, which is going
> to be a problem.

Ugh, sorry I thought you were pointing out that there's too many
put_device() not the use after free. Yes, the use after free is a bug
that needs fixing.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

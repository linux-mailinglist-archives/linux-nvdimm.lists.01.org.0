Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAA626E2DE
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Sep 2020 19:49:59 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 857F214F64309;
	Thu, 17 Sep 2020 10:49:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 79E2E14DF56FF
	for <linux-nvdimm@lists.01.org>; Thu, 17 Sep 2020 10:49:52 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id i1so3468540edv.2
        for <linux-nvdimm@lists.01.org>; Thu, 17 Sep 2020 10:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ENfhWQdf9K/5hVsb78ddr+SfWyrtJC6aLeg3pRwtv8E=;
        b=ZagEJYb4G77ctr6wrsRi7BBpBeLJ2RqKIFY0zNk7KAYFZ4WiLyu138ocQ4EkSgH0tI
         M8r3e98jaIBAgy5xhz9DbAIEU+bWqK2PGUkqf7lizCW8oHvqihNYWN+g6wqKd6fmdYEn
         eB80ZEiR0GSbWDG56a+pW3CcHFI2ypzpkzBH8zVchNeVHtPhB79FeA5au4NY3R1nrTCP
         PNLgCA2PtbGv/3gyq43USUbKMwx40WXontsRUa85MfFs0WTTdaES2vluCJM4SNC3YpHa
         15Ota/XfYTDpuvOVL+iaux66fZQGrSive5HJcUwu8polU9X4afnEkoFQXT9jZJZHY8Fh
         v28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ENfhWQdf9K/5hVsb78ddr+SfWyrtJC6aLeg3pRwtv8E=;
        b=La+Gj0+cYBpH/jLOaadjFnbuUNAqNn+bS9uHhggP+64R2Y7FMYDGYKs3C1RmDYkcka
         2eKRolXn4TftIX/M/C57AJ2r3U23vaV26F9ACd4zAr2FjWv80FIiCJBEXO6EqG2UxugJ
         Jr1Iz8PnMB0enBhpgGUKlyf/cG6m/32XtDr43fw5z/z/TYX6TE1HXmFrybYcK6yhooyQ
         hOv1M6H/bhcTIWRJfQfMOnQOs3SVq+JgY/p7fy4EUF5Bcos8tzWixGA3+4K3hlip7KUh
         nfrv8j8UiKjUyQlxmbC6gYUP/HDBnPiw7AavkOnrjhRVFqkt7L3QGxIrv64Rt45rpAVi
         7GFw==
X-Gm-Message-State: AOAM532ibjBvgTYvYFSXo5UTYdaXh5k0LG1/UVRvNuZGnWVhS4c8XEjV
	8EdpY7s6rgQ8CMIc5bOz1jh75b8Xquj9B/ZdppEcAA==
X-Google-Smtp-Source: ABdhPJw5xn889D+hWOJRrbU28Cy0Im5AQiVze3AY25ilOgeqW+PJamoqgBACx2e2kYcYfgSkjdkDpfVWyC25GyuP9yg=
X-Received: by 2002:a05:6402:180a:: with SMTP id g10mr33770887edy.18.1600364990787;
 Thu, 17 Sep 2020 10:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200916151445.450-1-jack@suse.cz> <CAPcyv4gfMY=k+SDsKWPPasZs9X=7schOgc=3VZSDj0kAbZcTTA@mail.gmail.com>
 <20200917104216.GB16097@quack2.suse.cz> <CAHKZfL0xC4OTe_HDg93HdinmxnpPVCAK3eweWCoo2CsbDTvNYA@mail.gmail.com>
In-Reply-To: <CAHKZfL0xC4OTe_HDg93HdinmxnpPVCAK3eweWCoo2CsbDTvNYA@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 17 Sep 2020 10:49:39 -0700
Message-ID: <CAPcyv4hfFg=+fX+iJtfNn29Q3-d+uy1U0EswM6035CV3VHJ2Ww@mail.gmail.com>
Subject: Re: [PATCH] dm: Call proper helper to determine dax support
To: Huang Adrian <adrianhuang0701@gmail.com>
Message-ID-Hash: 4QIK2BA2Y5DBVT6L36G64YTF5GBW57BZ
X-Message-ID-Hash: 4QIK2BA2Y5DBVT6L36G64YTF5GBW57BZ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>, Coly Li <colyli@suse.de>, Mikulas Patocka <mpatocka@redhat.com>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>, Adrian Huang12 <ahuang12@lenovo.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4QIK2BA2Y5DBVT6L36G64YTF5GBW57BZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Sep 17, 2020 at 7:58 AM Huang Adrian <adrianhuang0701@gmail.com> wrote:
>
> On Thu, Sep 17, 2020 at 6:42 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 17-09-20 02:28:57, Dan Williams wrote:
> > > On Wed, Sep 16, 2020 at 8:15 AM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > DM was calling generic_fsdax_supported() to determine whether a device
> > > > referenced in the DM table supports DAX. However this is a helper for "leaf" device drivers so that
> > > > they don't have to duplicate common generic checks. High level code
> > > > should call dax_supported() helper which that calls into appropriate
> > > > helper for the particular device. This problem manifested itself as
> > > > kernel messages:
> > > >
> > > > dm-3: error: dax access failed (-95)
> > > >
> > > > when lvm2-testsuite run in cases where a DM device was stacked on top of
> > > > another DM device.
> > > >
> > > > Fixes: 7bf7eac8d648 ("dax: Arrange for dax_supported check to span multiple devices")
> > > > Tested-by: Adrian Huang <ahuang12@lenovo.com>
> > > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > > ---
> > > >  drivers/dax/super.c   |  4 ++++
> > > >  drivers/md/dm-table.c |  3 +--
> > > >  include/linux/dax.h   | 11 +++++++++--
> > > >  3 files changed, 14 insertions(+), 4 deletions(-)
> > > >
> > > > This patch should go in together with Adrian's
> > > > https://lore.kernel.org/linux-nvdimm/20200916133923.31-1-adrianhuang0701@gmail.com
> > > >
> > > > diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> > > > index e5767c83ea23..b6284c5cae0a 100644
> > > > --- a/drivers/dax/super.c
> > > > +++ b/drivers/dax/super.c
> > > > @@ -325,11 +325,15 @@ EXPORT_SYMBOL_GPL(dax_direct_access);
> > > >  bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
> > > >                 int blocksize, sector_t start, sector_t len)
> > > >  {
> > > > +       if (!dax_dev)
> > > > +               return false;
> > > > +
> > >
> > > Hi Jan, Thanks for this.
> > >
> > > >         if (!dax_alive(dax_dev))
> > > >                 return false;
> > >
> > > One small fixup to quiet lockdep because dax_supported() calls
> > > dax_alive() it expects that dax_read_lock() is held. So I'm testing
> > > with this incremental change:
> > >
> > > diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> > > index bed1ff0744ec..229f461e7def 100644
> > > --- a/drivers/md/dm-table.c
> > > +++ b/drivers/md/dm-table.c
> > > @@ -860,9 +860,14 @@ EXPORT_SYMBOL_GPL(dm_table_set_type);
> > >  int device_supports_dax(struct dm_target *ti, struct dm_dev *dev,
> > >                         sector_t start, sector_t len, void *data)
> > >  {
> > > -       int blocksize = *(int *) data;
> > > +       int blocksize = *(int *) data, id;
> > > +       bool rc;
> > >
> > > -       return dax_supported(dev->dax_dev, dev->bdev, blocksize, start, len);
> > > +       id = dax_read_lock();
> > > +       rc = dax_supported(dev->dax_dev, dev->bdev, blocksize, start, len);
> > > +       dax_read_unlock(id);
> > > +
> > > +       return rc;
> > >  }
> >
> > Yeah, thanks for this! I was actually looking into this when writing the
> > patch and somehow convinced myself we will always be called through
> > bdev_dax_supported() which does dax_read_lock() for us. But apparently I
> > was wrong...
>
> Hold on. This patch hit another regression when I ran the full test of
> the lvm2-testsuite tool today.

Are you sure it's this patch?

The dax_read_lock() should have zero interaction with the
synchronize_srcu() that __dm_suspend() performs. The too srcu domains
should not conflict... I don't even see a dax_read_lock() in this
path.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

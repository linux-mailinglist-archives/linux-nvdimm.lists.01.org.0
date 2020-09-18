Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DA426FC9A
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Sep 2020 14:35:16 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B18F6150AE6CD;
	Fri, 18 Sep 2020 05:35:14 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::744; helo=mail-qk1-x744.google.com; envelope-from=adrianhuang0701@gmail.com; receiver=<UNKNOWN> 
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D860213F2CFFF
	for <linux-nvdimm@lists.01.org>; Fri, 18 Sep 2020 05:35:12 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id d20so5835402qka.5
        for <linux-nvdimm@lists.01.org>; Fri, 18 Sep 2020 05:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5HBCdC//R4zIGS8CTUeRsovMnhBhse73FMFaHrcL9mM=;
        b=fk4RbmIufQG7PANpz6uw7KN0rBZvg9uLFw6XHCTcwFydetI6ABvmJH5dzgIDT5Vpy0
         tO5pkVYUfZ+99+aFgmsx2Lz6Tva5qYjV1peCpko8PRwEbDg12WuP4oL9LYC3C/Wdx9t5
         b/QdMCBJoYPPCf5GQPaBbDxTtGileFaZVFO+BDV0D9j2euIBMrPO2PSk8jujQFLdMP1W
         1758z+AQxvoWy8ZR1kFz0DEDlFclPsfuL8Vn4Rrq3xIXCqrPaECGr4ethrbBqcMbajo6
         Mgn7cIcqu1BlNJUMbdfEx8kuaS0FDOpFRPUiw9ANt2gGxj7fyUbPeSV59OOypBXH/aex
         y00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5HBCdC//R4zIGS8CTUeRsovMnhBhse73FMFaHrcL9mM=;
        b=ghG2ekfalNKQFsM77yDyuykJN8O1QjlqcCDWWikeD50/mU98ndJ30eYkXjV4uwkewj
         PG9QGDdTD6zm1R3gYiEd2sMDBHexB6xUBPzYXLRmL2X2qwI0Ct4N7b9hqnC/pGh/nPkI
         RXOpXyhxPPfHvwbEl9c2WHgLUgCXc0QQbfAM0BdTQcXSfb9gbsaIxtKsZqkh1j7h4Mq3
         9aUCQ79wuH+FysIYF2uc+7/2KmvAmoBydGELc3qAB92G6ZS/SgVjWTesRpEezB7xGqOL
         53xTqs0W7dqqn1OPE1vt5h1lDYpH+MthtuqQ3sD37jKK5IvrmhKDmw50jfXEClQYYgpT
         tgog==
X-Gm-Message-State: AOAM530DsONpXQeYNIngZOTtNCybi0Q54Yhy20v99q/Kx9fSfMGCXSZH
	RHP9silbXeKyVieIeR85aUeA/APcnoBI0nVccP0=
X-Google-Smtp-Source: ABdhPJwfqN6VYsGo6Ca9flSUaOLFam++Tlgnpa+jEeYggJ3105e+1i3PQWQ170KOdl1Zl8GYWmt3C3VbsbdcT4EJ9jE=
X-Received: by 2002:a05:620a:1485:: with SMTP id w5mr30866870qkj.124.1600432511110;
 Fri, 18 Sep 2020 05:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200916151445.450-1-jack@suse.cz> <CAPcyv4gfMY=k+SDsKWPPasZs9X=7schOgc=3VZSDj0kAbZcTTA@mail.gmail.com>
 <20200917104216.GB16097@quack2.suse.cz> <CAHKZfL0xC4OTe_HDg93HdinmxnpPVCAK3eweWCoo2CsbDTvNYA@mail.gmail.com>
 <CAPcyv4hfFg=+fX+iJtfNn29Q3-d+uy1U0EswM6035CV3VHJ2Ww@mail.gmail.com>
In-Reply-To: <CAPcyv4hfFg=+fX+iJtfNn29Q3-d+uy1U0EswM6035CV3VHJ2Ww@mail.gmail.com>
From: Huang Adrian <adrianhuang0701@gmail.com>
Date: Fri, 18 Sep 2020 20:34:59 +0800
Message-ID: <CAHKZfL0wV8+Ek1xaWO3CeY6gorDBsM=W+cDqo0bwe1BaAoafrw@mail.gmail.com>
Subject: Re: [PATCH] dm: Call proper helper to determine dax support
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: P3PNI7UFK4YB5CUFZWDUFIS7OTXCSQWV
X-Message-ID-Hash: P3PNI7UFK4YB5CUFZWDUFIS7OTXCSQWV
X-MailFrom: adrianhuang0701@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>, Coly Li <colyli@suse.de>, Mikulas Patocka <mpatocka@redhat.com>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>, Adrian Huang12 <ahuang12@lenovo.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/P3PNI7UFK4YB5CUFZWDUFIS7OTXCSQWV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Sep 18, 2020 at 1:49 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Thu, Sep 17, 2020 at 7:58 AM Huang Adrian <adrianhuang0701@gmail.com> wrote:
> >
> > On Thu, Sep 17, 2020 at 6:42 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Thu 17-09-20 02:28:57, Dan Williams wrote:
> > > > On Wed, Sep 16, 2020 at 8:15 AM Jan Kara <jack@suse.cz> wrote:
> > > > >
> > > > > DM was calling generic_fsdax_supported() to determine whether a device
> > > > > referenced in the DM table supports DAX. However this is a helper for "leaf" device drivers so that
> > > > > they don't have to duplicate common generic checks. High level code
> > > > > should call dax_supported() helper which that calls into appropriate
> > > > > helper for the particular device. This problem manifested itself as
> > > > > kernel messages:
> > > > >
> > > > > dm-3: error: dax access failed (-95)
> > > > >
> > > > > when lvm2-testsuite run in cases where a DM device was stacked on top of
> > > > > another DM device.
> > > > >
> > > > > Fixes: 7bf7eac8d648 ("dax: Arrange for dax_supported check to span multiple devices")
> > > > > Tested-by: Adrian Huang <ahuang12@lenovo.com>
> > > > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > > > ---
> > > > >  drivers/dax/super.c   |  4 ++++
> > > > >  drivers/md/dm-table.c |  3 +--
> > > > >  include/linux/dax.h   | 11 +++++++++--
> > > > >  3 files changed, 14 insertions(+), 4 deletions(-)
> > > > >
> > > > > This patch should go in together with Adrian's
> > > > > https://lore.kernel.org/linux-nvdimm/20200916133923.31-1-adrianhuang0701@gmail.com
> > > > >
> > > > > diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> > > > > index e5767c83ea23..b6284c5cae0a 100644
> > > > > --- a/drivers/dax/super.c
> > > > > +++ b/drivers/dax/super.c
> > > > > @@ -325,11 +325,15 @@ EXPORT_SYMBOL_GPL(dax_direct_access);
> > > > >  bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
> > > > >                 int blocksize, sector_t start, sector_t len)
> > > > >  {
> > > > > +       if (!dax_dev)
> > > > > +               return false;
> > > > > +
> > > >
> > > > Hi Jan, Thanks for this.
> > > >
> > > > >         if (!dax_alive(dax_dev))
> > > > >                 return false;
> > > >
> > > > One small fixup to quiet lockdep because dax_supported() calls
> > > > dax_alive() it expects that dax_read_lock() is held. So I'm testing
> > > > with this incremental change:
> > > >
> > > > diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> > > > index bed1ff0744ec..229f461e7def 100644
> > > > --- a/drivers/md/dm-table.c
> > > > +++ b/drivers/md/dm-table.c
> > > > @@ -860,9 +860,14 @@ EXPORT_SYMBOL_GPL(dm_table_set_type);
> > > >  int device_supports_dax(struct dm_target *ti, struct dm_dev *dev,
> > > >                         sector_t start, sector_t len, void *data)
> > > >  {
> > > > -       int blocksize = *(int *) data;
> > > > +       int blocksize = *(int *) data, id;
> > > > +       bool rc;
> > > >
> > > > -       return dax_supported(dev->dax_dev, dev->bdev, blocksize, start, len);
> > > > +       id = dax_read_lock();
> > > > +       rc = dax_supported(dev->dax_dev, dev->bdev, blocksize, start, len);
> > > > +       dax_read_unlock(id);
> > > > +
> > > > +       return rc;
> > > >  }
> > >
> > > Yeah, thanks for this! I was actually looking into this when writing the
> > > patch and somehow convinced myself we will always be called through
> > > bdev_dax_supported() which does dax_read_lock() for us. But apparently I
> > > was wrong...
> >
> > Hold on. This patch hit another regression when I ran the full test of
> > the lvm2-testsuite tool today.
>
> Are you sure it's this patch?

I'm pretty sure I applied this patch with your fixup. I tested it for
three times:
    1. `lvm2-testsuite --only pvmove-abort-all.sh` is always passed
without the patch.
    2. `lvm2-testsuite --only pvmove-abort-all.sh` is always blocked
with the patch.

> The dax_read_lock() should have zero interaction with the
> synchronize_srcu() that __dm_suspend() performs. The too srcu domains
> should not conflict... I don't even see a dax_read_lock() in this
> path.

Yup, I understand your observation. The call trace didn't show the
dax_read_lock().

-- Adrian
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

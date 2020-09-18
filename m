Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9929926FD52
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Sep 2020 14:48:16 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C35CF13DE235B;
	Fri, 18 Sep 2020 05:48:14 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::744; helo=mail-qk1-x744.google.com; envelope-from=adrianhuang0701@gmail.com; receiver=<UNKNOWN> 
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B49DE13AAF6FF
	for <linux-nvdimm@lists.01.org>; Fri, 18 Sep 2020 05:48:12 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f142so5826008qke.13
        for <linux-nvdimm@lists.01.org>; Fri, 18 Sep 2020 05:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bmCVvODrB3h4F/sulZUaGyzKuWPKDmnNl6+iGQNr9wQ=;
        b=gXcJGAFOT+J5ajUNzBBL940fUFML3vIj0Qz/RJ844RP6UTUyrsX0211LcaJlIQ8mqz
         VEJkd8SlD3atrAPHLspDz6pdgb3dzbrbiGVOyB90lvWy6I2YJd378tPJ/nCKmDi4pbJd
         3xb87JlxSdVDpjEstKRdrY0k/5Uo1/ZQUhgpIZl+lNuYhtoZazV8xMwc/Oe98o1D7Dk5
         S8nOEQoCf9EzTN1pPdmv9pFK8Av/x5xtEcZr389eJo8nSubtHu+qtvA6D3zyLthvwzIk
         gKnuafMXPrwgNSMZH+E7oxEN1B6/wXN6THDzPhAYkl0CIEqpSSRod78W674TLPOvYx/m
         xPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bmCVvODrB3h4F/sulZUaGyzKuWPKDmnNl6+iGQNr9wQ=;
        b=syHeqSKYR3+cmkBGEL/7cm+ijW1gRr0fXyu72y0X3EVgr0lhrz7SrUi4CuAZvbAkVn
         5un3vxssTrpNmU8RzEn+u5a/nKivtx8fgOLMkGW3q60qfZ4JpY+aRBr+BcsSqA2S2rY5
         qivGqFXtJKRBBWHrXkt0bSjxl7mC0IGunkry7HXqPtMsmtKgWeo3oCShsO7pdd7BAFyE
         kp6vtN44bn+OzK0TJi2LvE6G7Vc0802oGKB569Fsd9+VL4dDDBTkNScB4nxxJU6UdbIC
         gO9HdMkewuno7HjEoaqGK99Hgm5u4f7IFDLPq2RGKwAVinn82dVU4fMfYxYPTa3EAJQZ
         KWvA==
X-Gm-Message-State: AOAM533Lf6mGbq39azroIYVo9pftEFnaZ48H8Ik7Ygqqn/xBMdt8ldJZ
	+/sMLNwJQG1THVDr6tGO3pKQKMZNJJRNugIV5a4=
X-Google-Smtp-Source: ABdhPJweqqqrJZ/anWSXP/idlilohuEfbiHic+TDvSPtnwttZYmHt+O/gwz6KNELh/TIHNDxHuMu8qaeRQOg6mE0si8=
X-Received: by 2002:a37:2713:: with SMTP id n19mr33615611qkn.497.1600433291575;
 Fri, 18 Sep 2020 05:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200916151445.450-1-jack@suse.cz> <CAPcyv4gfMY=k+SDsKWPPasZs9X=7schOgc=3VZSDj0kAbZcTTA@mail.gmail.com>
 <20200917104216.GB16097@quack2.suse.cz> <CAHKZfL0xC4OTe_HDg93HdinmxnpPVCAK3eweWCoo2CsbDTvNYA@mail.gmail.com>
 <CAPcyv4hfFg=+fX+iJtfNn29Q3-d+uy1U0EswM6035CV3VHJ2Ww@mail.gmail.com>
 <CAPcyv4iQyPP7_6EfwcHWiZ9Q_yxMPPbqL1_zjMQ=e4dsiH=fOA@mail.gmail.com> <CAHKZfL2pQ=wqVNPrf2q2GKGWz=S4NSKzPqJMsyd-yHKZu+EDGQ@mail.gmail.com>
In-Reply-To: <CAHKZfL2pQ=wqVNPrf2q2GKGWz=S4NSKzPqJMsyd-yHKZu+EDGQ@mail.gmail.com>
From: Huang Adrian <adrianhuang0701@gmail.com>
Date: Fri, 18 Sep 2020 20:48:00 +0800
Message-ID: <CAHKZfL3+qZw3Megt1ScVSoVUEMy+RjngP2CzYRAaD1xOgkigyA@mail.gmail.com>
Subject: Re: [PATCH] dm: Call proper helper to determine dax support
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: BWLATR2VTRQBSGVSHQFXJC2HRSWO7K4I
X-Message-ID-Hash: BWLATR2VTRQBSGVSHQFXJC2HRSWO7K4I
X-MailFrom: adrianhuang0701@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>, Coly Li <colyli@suse.de>, Mikulas Patocka <mpatocka@redhat.com>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>, Adrian Huang12 <ahuang12@lenovo.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BWLATR2VTRQBSGVSHQFXJC2HRSWO7K4I/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Sep 18, 2020 at 8:41 PM Huang Adrian <adrianhuang0701@gmail.com> wrote:
>
> On Fri, Sep 18, 2020 at 1:41 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Thu, Sep 17, 2020 at 10:49 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > On Thu, Sep 17, 2020 at 7:58 AM Huang Adrian <adrianhuang0701@gmail.com> wrote:
> > > >
> > > > On Thu, Sep 17, 2020 at 6:42 PM Jan Kara <jack@suse.cz> wrote:
> > > > >
> > > > > On Thu 17-09-20 02:28:57, Dan Williams wrote:
> > > > > > On Wed, Sep 16, 2020 at 8:15 AM Jan Kara <jack@suse.cz> wrote:
> > > > > > >
> > > > > > > DM was calling generic_fsdax_supported() to determine whether a device
> > > > > > > referenced in the DM table supports DAX. However this is a helper for "leaf" device drivers so that
> > > > > > > they don't have to duplicate common generic checks. High level code
> > > > > > > should call dax_supported() helper which that calls into appropriate
> > > > > > > helper for the particular device. This problem manifested itself as
> > > > > > > kernel messages:
> > > > > > >
> > > > > > > dm-3: error: dax access failed (-95)
> > > > > > >
> > > > > > > when lvm2-testsuite run in cases where a DM device was stacked on top of
> > > > > > > another DM device.
> > > > > > >
> > > > > > > Fixes: 7bf7eac8d648 ("dax: Arrange for dax_supported check to span multiple devices")
> > > > > > > Tested-by: Adrian Huang <ahuang12@lenovo.com>
> > > > > > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > > > > > ---
> > > > > > >  drivers/dax/super.c   |  4 ++++
> > > > > > >  drivers/md/dm-table.c |  3 +--
> > > > > > >  include/linux/dax.h   | 11 +++++++++--
> > > > > > >  3 files changed, 14 insertions(+), 4 deletions(-)
> > > > > > >
> > > > > > > This patch should go in together with Adrian's
> > > > > > > https://lore.kernel.org/linux-nvdimm/20200916133923.31-1-adrianhuang0701@gmail.com
> > > > > > >
> > > > > > > diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> > > > > > > index e5767c83ea23..b6284c5cae0a 100644
> > > > > > > --- a/drivers/dax/super.c
> > > > > > > +++ b/drivers/dax/super.c
> > > > > > > @@ -325,11 +325,15 @@ EXPORT_SYMBOL_GPL(dax_direct_access);
> > > > > > >  bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
> > > > > > >                 int blocksize, sector_t start, sector_t len)
> > > > > > >  {
> > > > > > > +       if (!dax_dev)
> > > > > > > +               return false;
> > > > > > > +
> > > > > >
> > > > > > Hi Jan, Thanks for this.
> > > > > >
> > > > > > >         if (!dax_alive(dax_dev))
> > > > > > >                 return false;
> > > > > >
> > > > > > One small fixup to quiet lockdep because dax_supported() calls
> > > > > > dax_alive() it expects that dax_read_lock() is held. So I'm testing
> > > > > > with this incremental change:
> > > > > >
> > > > > > diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> > > > > > index bed1ff0744ec..229f461e7def 100644
> > > > > > --- a/drivers/md/dm-table.c
> > > > > > +++ b/drivers/md/dm-table.c
> > > > > > @@ -860,9 +860,14 @@ EXPORT_SYMBOL_GPL(dm_table_set_type);
> > > > > >  int device_supports_dax(struct dm_target *ti, struct dm_dev *dev,
> > > > > >                         sector_t start, sector_t len, void *data)
> > > > > >  {
> > > > > > -       int blocksize = *(int *) data;
> > > > > > +       int blocksize = *(int *) data, id;
> > > > > > +       bool rc;
> > > > > >
> > > > > > -       return dax_supported(dev->dax_dev, dev->bdev, blocksize, start, len);
> > > > > > +       id = dax_read_lock();
> > > > > > +       rc = dax_supported(dev->dax_dev, dev->bdev, blocksize, start, len);
> > > > > > +       dax_read_unlock(id);
> > > > > > +
> > > > > > +       return rc;
> > > > > >  }
> > > > >
> > > > > Yeah, thanks for this! I was actually looking into this when writing the
> > > > > patch and somehow convinced myself we will always be called through
> > > > > bdev_dax_supported() which does dax_read_lock() for us. But apparently I
> > > > > was wrong...
> > > >
> > > > Hold on. This patch hit another regression when I ran the full test of
> > > > the lvm2-testsuite tool today.
> > >
> > > Are you sure it's this patch?
> > >
> > > The dax_read_lock() should have zero interaction with the
> > > synchronize_srcu() that __dm_suspend() performs. The too srcu domains
> > > should not conflict... I don't even see a dax_read_lock() in this
> > > path.
> >
> > Confirmed. I hit the hang in the lvm2-testsuite on vanilla 5.9-rc5.
> > So, I'm going to proceed with Jan's patch plus my fixup.
>
> Interestingly, the command `lvm2-testsuite --only pvmove-abort-all.sh`
> passed on vanilla 5.9-rc5 (on my two boxes).
> Is it the same symptom (call trace) with my reported one?
>
> Could you please run the above-mentioned command on your box (w/wo
> Jan's patch plus my fixup)?

Sorry, it should be "w/wo Jan's patch plus Dan's fixup" (I just copied
and pasted without modification).

-- Adrian
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

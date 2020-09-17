Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA14726D948
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Sep 2020 12:42:22 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DDF3C1481D086;
	Thu, 17 Sep 2020 03:42:20 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=jack@suse.cz; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E29251481D086
	for <linux-nvdimm@lists.01.org>; Thu, 17 Sep 2020 03:42:17 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 4B465AF39;
	Thu, 17 Sep 2020 10:42:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
	id 3A96B1E12E1; Thu, 17 Sep 2020 12:42:16 +0200 (CEST)
Date: Thu, 17 Sep 2020 12:42:16 +0200
From: Jan Kara <jack@suse.cz>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] dm: Call proper helper to determine dax support
Message-ID: <20200917104216.GB16097@quack2.suse.cz>
References: <20200916151445.450-1-jack@suse.cz>
 <CAPcyv4gfMY=k+SDsKWPPasZs9X=7schOgc=3VZSDj0kAbZcTTA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4gfMY=k+SDsKWPPasZs9X=7schOgc=3VZSDj0kAbZcTTA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: J3CS3MYH7OOMUHQFN757LWXIO5J6WRML
X-Message-ID-Hash: J3CS3MYH7OOMUHQFN757LWXIO5J6WRML
X-MailFrom: jack@suse.cz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>, Adrian Huang <adrianhuang0701@gmail.com>, Coly Li <colyli@suse.de>, Mikulas Patocka <mpatocka@redhat.com>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/J3CS3MYH7OOMUHQFN757LWXIO5J6WRML/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu 17-09-20 02:28:57, Dan Williams wrote:
> On Wed, Sep 16, 2020 at 8:15 AM Jan Kara <jack@suse.cz> wrote:
> >
> > DM was calling generic_fsdax_supported() to determine whether a device
> > referenced in the DM table supports DAX. However this is a helper for "leaf" device drivers so that
> > they don't have to duplicate common generic checks. High level code
> > should call dax_supported() helper which that calls into appropriate
> > helper for the particular device. This problem manifested itself as
> > kernel messages:
> >
> > dm-3: error: dax access failed (-95)
> >
> > when lvm2-testsuite run in cases where a DM device was stacked on top of
> > another DM device.
> >
> > Fixes: 7bf7eac8d648 ("dax: Arrange for dax_supported check to span multiple devices")
> > Tested-by: Adrian Huang <ahuang12@lenovo.com>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  drivers/dax/super.c   |  4 ++++
> >  drivers/md/dm-table.c |  3 +--
> >  include/linux/dax.h   | 11 +++++++++--
> >  3 files changed, 14 insertions(+), 4 deletions(-)
> >
> > This patch should go in together with Adrian's
> > https://lore.kernel.org/linux-nvdimm/20200916133923.31-1-adrianhuang0701@gmail.com
> >
> > diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> > index e5767c83ea23..b6284c5cae0a 100644
> > --- a/drivers/dax/super.c
> > +++ b/drivers/dax/super.c
> > @@ -325,11 +325,15 @@ EXPORT_SYMBOL_GPL(dax_direct_access);
> >  bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
> >                 int blocksize, sector_t start, sector_t len)
> >  {
> > +       if (!dax_dev)
> > +               return false;
> > +
> 
> Hi Jan, Thanks for this.
> 
> >         if (!dax_alive(dax_dev))
> >                 return false;
> 
> One small fixup to quiet lockdep because dax_supported() calls
> dax_alive() it expects that dax_read_lock() is held. So I'm testing
> with this incremental change:
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index bed1ff0744ec..229f461e7def 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -860,9 +860,14 @@ EXPORT_SYMBOL_GPL(dm_table_set_type);
>  int device_supports_dax(struct dm_target *ti, struct dm_dev *dev,
>                         sector_t start, sector_t len, void *data)
>  {
> -       int blocksize = *(int *) data;
> +       int blocksize = *(int *) data, id;
> +       bool rc;
> 
> -       return dax_supported(dev->dax_dev, dev->bdev, blocksize, start, len);
> +       id = dax_read_lock();
> +       rc = dax_supported(dev->dax_dev, dev->bdev, blocksize, start, len);
> +       dax_read_unlock(id);
> +
> +       return rc;
>  }

Yeah, thanks for this! I was actually looking into this when writing the
patch and somehow convinced myself we will always be called through
bdev_dax_supported() which does dax_read_lock() for us. But apparently I
was wrong...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

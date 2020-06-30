Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F5120F76E
	for <lists+linux-nvdimm@lfdr.de>; Tue, 30 Jun 2020 16:44:02 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A037311427DB7;
	Tue, 30 Jun 2020 07:44:00 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=msuchanek@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6FFA2111FF492
	for <linux-nvdimm@lists.01.org>; Tue, 30 Jun 2020 07:43:58 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 06EF1AB3D;
	Tue, 30 Jun 2020 14:43:57 +0000 (UTC)
Date: Tue, 30 Jun 2020 16:43:55 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Mike Snitzer <snitzer@redhat.com>
Subject: Re: dm writecache: reject asynchronous pmem.
Message-ID: <20200630144355.GA21462@kitsune.suse.cz>
References: <20200630123528.29660-1-msuchanek@suse.de>
 <alpine.LRH.2.02.2006300929580.4801@file01.intranet.prod.int.rdu2.redhat.com>
 <20200630141022.GZ21462@kitsune.suse.cz>
 <20200630133546.GA20439@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200630133546.GA20439@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: ZCNF3JBTYOHCFPIM37NQHN4B7XKNAE5G
X-Message-ID-Hash: ZCNF3JBTYOHCFPIM37NQHN4B7XKNAE5G
X-MailFrom: msuchanek@suse.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mikulas Patocka <mpatocka@redhat.com>, linux-nvdimm@lists.01.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Jan Kara <jack@suse.cz>, Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Yuval Shaia <yuval.shaia@oracle.com>, Cornelia Huck <cohuck@redhat.com>, Jakub Staron <jstaron@google.com>, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZCNF3JBTYOHCFPIM37NQHN4B7XKNAE5G/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2020 at 09:36:33AM -0400, Mike Snitzer wrote:
> On Tue, Jun 30 2020 at 10:10am -0400,
> Michal Such=E1nek <msuchanek@suse.de> wrote:
>=20
> > On Tue, Jun 30, 2020 at 09:32:01AM -0400, Mikulas Patocka wrote:
> > >=20
> > >=20
> > > On Tue, 30 Jun 2020, Michal Suchanek wrote:
> > >=20
> > > > The writecache driver does not handle asynchronous pmem. Reject it =
when
> > > > supplied as cache.
> > > >=20
> > > > Link: https://lore.kernel.org/linux-nvdimm/87lfk5hahc.fsf@linux.ibm=
.com/
> > > > Fixes: 6e84200c0a29 ("virtio-pmem: Add virtio pmem driver")
> > > >=20
> > > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > > ---
> > > >  drivers/md/dm-writecache.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >=20
> > > > diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
> > > > index 30505d70f423..57b0a972f6fd 100644
> > > > --- a/drivers/md/dm-writecache.c
> > > > +++ b/drivers/md/dm-writecache.c
> > > > @@ -2277,6 +2277,12 @@ static int writecache_ctr(struct dm_target *=
ti, unsigned argc, char **argv)
> > > > =20
> > > >  		wc->memory_map_size -=3D (uint64_t)wc->start_sector << SECTOR_SH=
IFT;
> > > > =20
> > > > +		if (!dax_synchronous(wc->ssd_dev->dax_dev)) {
> > > > +			r =3D -EOPNOTSUPP;
> > > > +			ti->error =3D "Asynchronous persistent memory not supported as =
pmem cache";
> > > > +			goto bad;
> > > > +		}
> > > > +
> > > >  		bio_list_init(&wc->flush_list);
> > > >  		wc->flush_thread =3D kthread_create(writecache_flush_thread, wc,=
 "dm_writecache_flush");
> > > >  		if (IS_ERR(wc->flush_thread)) {
> > > > --=20
> > >=20
> > > Hi
> > >=20
> > > Shouldn't this be in the "if (WC_MODE_PMEM(wc))" block?
> > That should be always the case at this point.
> > >=20
> > > WC_MODE_PMEM(wc) retrurns true if we are using persistent memory as a=
=20
> > > cache device, otherwise we are using generic block device as a cache =

> > > device.
> >
> > This is to prevent the situation where we have WC_MODE_PMEM(wc) but
> > cannot guarantee consistency because the async flush is not handled.
>=20
> The writecache operates in 2 modes.  SSD or PMEM.  Mikulas is saying
> your dax_synchronous() check should go within a WC_MODE_PMEM(wc) block
> because it doesn't make sense to do the check when in SSD mode.

Indeed, it's in the wrong if/else branch.

Thanks

Michal
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

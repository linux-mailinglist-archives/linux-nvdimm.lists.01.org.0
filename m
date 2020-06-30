Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF29020F75C
	for <lists+linux-nvdimm@lfdr.de>; Tue, 30 Jun 2020 16:38:09 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 10977111FF492;
	Tue, 30 Jun 2020 07:38:08 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.61; helo=us-smtp-1.mimecast.com; envelope-from=msnitzer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-1.mimecast.com [205.139.110.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D11E2111C7C55
	for <linux-nvdimm@lists.01.org>; Tue, 30 Jun 2020 07:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1593527884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VM53FIbl2A/0M0Rm8pcUNmxr8EzWR7FcO9KwzPs/7X0=;
	b=J+zaTP1GFbsD9pLEmHJpMrVxNvdGgvmq8OzGQQlyo2POt5HZJWZ8NvJP6+S+WnjU7ayQE2
	O3ThIely0m3wGyc8qoqRrZpQcy5NupQtY7xsbyqkZzD93C7aUt/3jiIocNSFRS1jDU4BfG
	qSOcIN/CsHh2ijGd5b4YY8I2pB5+0IE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-MC3MYsXGOoqGuodmnJV90A-1; Tue, 30 Jun 2020 10:38:00 -0400
X-MC-Unique: MC3MYsXGOoqGuodmnJV90A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 941FB100CCC0;
	Tue, 30 Jun 2020 14:37:58 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E33DE7169B;
	Tue, 30 Jun 2020 14:37:52 +0000 (UTC)
Date: Tue, 30 Jun 2020 09:36:33 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Subject: Re: dm writecache: reject asynchronous pmem.
Message-ID: <20200630133546.GA20439@redhat.com>
References: <20200630123528.29660-1-msuchanek@suse.de>
 <alpine.LRH.2.02.2006300929580.4801@file01.intranet.prod.int.rdu2.redhat.com>
 <20200630141022.GZ21462@kitsune.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200630141022.GZ21462@kitsune.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Message-ID-Hash: DYEDJAWGTAMZ4ZKJHY5XFORNUU2BBYNC
X-Message-ID-Hash: DYEDJAWGTAMZ4ZKJHY5XFORNUU2BBYNC
X-MailFrom: msnitzer@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mikulas Patocka <mpatocka@redhat.com>, linux-nvdimm@lists.01.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Jan Kara <jack@suse.cz>, Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Yuval Shaia <yuval.shaia@oracle.com>, Cornelia Huck <cohuck@redhat.com>, Jakub Staron <jstaron@google.com>, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DYEDJAWGTAMZ4ZKJHY5XFORNUU2BBYNC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30 2020 at 10:10am -0400,
Michal Such=E1nek <msuchanek@suse.de> wrote:

> On Tue, Jun 30, 2020 at 09:32:01AM -0400, Mikulas Patocka wrote:
> >=20
> >=20
> > On Tue, 30 Jun 2020, Michal Suchanek wrote:
> >=20
> > > The writecache driver does not handle asynchronous pmem. Reject it wh=
en
> > > supplied as cache.
> > >=20
> > > Link: https://lore.kernel.org/linux-nvdimm/87lfk5hahc.fsf@linux.ibm.c=
om/
> > > Fixes: 6e84200c0a29 ("virtio-pmem: Add virtio pmem driver")
> > >=20
> > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > ---
> > >  drivers/md/dm-writecache.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >=20
> > > diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
> > > index 30505d70f423..57b0a972f6fd 100644
> > > --- a/drivers/md/dm-writecache.c
> > > +++ b/drivers/md/dm-writecache.c
> > > @@ -2277,6 +2277,12 @@ static int writecache_ctr(struct dm_target *ti=
, unsigned argc, char **argv)
> > > =20
> > >  		wc->memory_map_size -=3D (uint64_t)wc->start_sector << SECTOR_SHIF=
T;
> > > =20
> > > +		if (!dax_synchronous(wc->ssd_dev->dax_dev)) {
> > > +			r =3D -EOPNOTSUPP;
> > > +			ti->error =3D "Asynchronous persistent memory not supported as pm=
em cache";
> > > +			goto bad;
> > > +		}
> > > +
> > >  		bio_list_init(&wc->flush_list);
> > >  		wc->flush_thread =3D kthread_create(writecache_flush_thread, wc, "=
dm_writecache_flush");
> > >  		if (IS_ERR(wc->flush_thread)) {
> > > --=20
> >=20
> > Hi
> >=20
> > Shouldn't this be in the "if (WC_MODE_PMEM(wc))" block?
> That should be always the case at this point.
> >=20
> > WC_MODE_PMEM(wc) retrurns true if we are using persistent memory as a=20
> > cache device, otherwise we are using generic block device as a cache=20
> > device.
>
> This is to prevent the situation where we have WC_MODE_PMEM(wc) but
> cannot guarantee consistency because the async flush is not handled.

The writecache operates in 2 modes.  SSD or PMEM.  Mikulas is saying
your dax_synchronous() check should go within a WC_MODE_PMEM(wc) block
because it doesn't make sense to do the check when in SSD mode.

Mike
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

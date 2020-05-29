Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F091E79DD
	for <lists+linux-nvdimm@lfdr.de>; Fri, 29 May 2020 11:52:57 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CE63712316A77;
	Fri, 29 May 2020 02:48:31 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=jack@suse.cz; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 01CA312316A75
	for <linux-nvdimm@lists.01.org>; Fri, 29 May 2020 02:48:29 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 36E5BAD89;
	Fri, 29 May 2020 09:52:51 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
	id 940641E1289; Fri, 29 May 2020 11:52:50 +0200 (CEST)
Date: Fri, 29 May 2020 11:52:50 +0200
From: Jan Kara <jack@suse.cz>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [RFC PATCH 1/2] libnvdimm: Add prctl control for disabling
 synchronous fault support.
Message-ID: <20200529095250.GP14550@quack2.suse.cz>
References: <20200529054141.156384-1-aneesh.kumar@linux.ibm.com>
 <20200529093310.GL25173@kitsune.suse.cz>
 <6183cf4a-d134-99e5-936e-ef35f530c2ec@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6183cf4a-d134-99e5-936e-ef35f530c2ec@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: TT6YMS4X5AWECJ35Q62CW7VY4NM5MOQ6
X-Message-ID-Hash: TT6YMS4X5AWECJ35Q62CW7VY4NM5MOQ6
X-MailFrom: jack@suse.cz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>, jack@suse.de, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TT6YMS4X5AWECJ35Q62CW7VY4NM5MOQ6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi!

On Fri 29-05-20 15:07:31, Aneesh Kumar K.V wrote:
> Thanks Michal. I also missed Jeff in this email thread.

And I think you'll also need some of the sched maintainers for the prctl
bits...

> On 5/29/20 3:03 PM, Michal Such=E1nek wrote:
> > Adding Jan
> >=20
> > On Fri, May 29, 2020 at 11:11:39AM +0530, Aneesh Kumar K.V wrote:
> > > With POWER10, architecture is adding new pmem flush and sync instruct=
ions.
> > > The kernel should prevent the usage of MAP_SYNC if applications are n=
ot using
> > > the new instructions on newer hardware.
> > >=20
> > > This patch adds a prctl option MAP_SYNC_ENABLE that can be used to en=
able
> > > the usage of MAP_SYNC. The kernel config option is added to allow the=
 user
> > > to control whether MAP_SYNC should be enabled by default or not.
> > >=20
> > > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
...
> > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > index 8c700f881d92..d5a9a363e81e 100644
> > > --- a/kernel/fork.c
> > > +++ b/kernel/fork.c
> > > @@ -963,6 +963,12 @@ __cacheline_aligned_in_smp DEFINE_SPINLOCK(mmlis=
t_lock);
> > >   static unsigned long default_dump_filter =3D MMF_DUMP_FILTER_DEFAUL=
T;
> > > +#ifdef CONFIG_ARCH_MAP_SYNC_DISABLE
> > > +unsigned long default_map_sync_mask =3D MMF_DISABLE_MAP_SYNC_MASK;
> > > +#else
> > > +unsigned long default_map_sync_mask =3D 0;
> > > +#endif
> > > +

I'm not sure CONFIG is really the right approach here. For a distro that wo=
uld
basically mean to disable MAP_SYNC for all PPC kernels unless application
explicitly uses the right prctl. Shouldn't we rather initialize
default_map_sync_mask on boot based on whether the CPU we run on requires
new flush instructions or not? Otherwise the patch looks sensible.

								Honza
--=20
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

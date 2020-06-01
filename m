Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAF41EA37A
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Jun 2020 14:07:14 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CC06A100DDCC0;
	Mon,  1 Jun 2020 05:02:28 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=msuchanek@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 38F86100DEFFD
	for <linux-nvdimm@lists.01.org>; Mon,  1 Jun 2020 05:02:26 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 58ABFABE6;
	Mon,  1 Jun 2020 12:07:09 +0000 (UTC)
Date: Mon, 1 Jun 2020 14:07:05 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [RFC PATCH 1/2] libnvdimm: Add prctl control for disabling
 synchronous fault support.
Message-ID: <20200601120705.GQ25173@kitsune.suse.cz>
References: <20200529054141.156384-1-aneesh.kumar@linux.ibm.com>
 <20200529093310.GL25173@kitsune.suse.cz>
 <6183cf4a-d134-99e5-936e-ef35f530c2ec@linux.ibm.com>
 <20200529095250.GP14550@quack2.suse.cz>
 <7e8ee9e3-4d4d-e4b9-913b-1c2448adc62a@linux.ibm.com>
 <20200601100925.GC3960@quack2.suse.cz>
 <2bf026cc-2ed0-70b6-bf99-ecfd0fa3dac4@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2bf026cc-2ed0-70b6-bf99-ecfd0fa3dac4@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: 32YSPLNUMQP44RYZIXM7PJEREEO43I3T
X-Message-ID-Hash: 32YSPLNUMQP44RYZIXM7PJEREEO43I3T
X-MailFrom: msuchanek@suse.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, jack@suse.de, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/32YSPLNUMQP44RYZIXM7PJEREEO43I3T/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 01, 2020 at 05:31:50PM +0530, Aneesh Kumar K.V wrote:
> On 6/1/20 3:39 PM, Jan Kara wrote:
> > On Fri 29-05-20 16:25:35, Aneesh Kumar K.V wrote:
> > > On 5/29/20 3:22 PM, Jan Kara wrote:
> > > > On Fri 29-05-20 15:07:31, Aneesh Kumar K.V wrote:
> > > > > Thanks Michal. I also missed Jeff in this email thread.
> > > >=20
> > > > And I think you'll also need some of the sched maintainers for the =
prctl
> > > > bits...
> > > >=20
> > > > > On 5/29/20 3:03 PM, Michal Such=E1nek wrote:
> > > > > > Adding Jan
> > > > > >=20
> > > > > > On Fri, May 29, 2020 at 11:11:39AM +0530, Aneesh Kumar K.V wrot=
e:
> > > > > > > With POWER10, architecture is adding new pmem flush and sync =
instructions.
> > > > > > > The kernel should prevent the usage of MAP_SYNC if applicatio=
ns are not using
> > > > > > > the new instructions on newer hardware.
> > > > > > >=20
> > > > > > > This patch adds a prctl option MAP_SYNC_ENABLE that can be us=
ed to enable
> > > > > > > the usage of MAP_SYNC. The kernel config option is added to a=
llow the user
> > > > > > > to control whether MAP_SYNC should be enabled by default or n=
ot.
> > > > > > >=20
> > > > > > > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > > > ...
> > > > > > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > > > > > index 8c700f881d92..d5a9a363e81e 100644
> > > > > > > --- a/kernel/fork.c
> > > > > > > +++ b/kernel/fork.c
> > > > > > > @@ -963,6 +963,12 @@ __cacheline_aligned_in_smp DEFINE_SPINLO=
CK(mmlist_lock);
> > > > > > >     static unsigned long default_dump_filter =3D MMF_DUMP_FIL=
TER_DEFAULT;
> > > > > > > +#ifdef CONFIG_ARCH_MAP_SYNC_DISABLE
> > > > > > > +unsigned long default_map_sync_mask =3D MMF_DISABLE_MAP_SYNC=
_MASK;
> > > > > > > +#else
> > > > > > > +unsigned long default_map_sync_mask =3D 0;
> > > > > > > +#endif
> > > > > > > +
> > > >=20
> > > > I'm not sure CONFIG is really the right approach here. For a distro=
 that would
> > > > basically mean to disable MAP_SYNC for all PPC kernels unless appli=
cation
> > > > explicitly uses the right prctl. Shouldn't we rather initialize
> > > > default_map_sync_mask on boot based on whether the CPU we run on re=
quires
> > > > new flush instructions or not? Otherwise the patch looks sensible.
> > > >=20
> > >=20
> > > yes that is correct. We ideally want to deny MAP_SYNC only w.r.t POWE=
R10.
> > > But on a virtualized platform there is no easy way to detect that. We=
 could
> > > ideally hook this into the nvdimm driver where we look at the new com=
pat
> > > string ibm,persistent-memory-v2 and then disable MAP_SYNC
> > > if we find a device with the specific value.
> >=20
> > Hum, couldn't we set some flag for nvdimm devices with
> > "ibm,persistent-memory-v2" property and then check it during mmap(2) ti=
me
> > and when the device has this propery and the mmap(2) caller doesn't have
> > the prctl set, we'd disallow MAP_SYNC? That should make things mostly
> > seamless, shouldn't it? Only apps that want to use MAP_SYNC on these
> > devices would need to use prctl(MMF_DISABLE_MAP_SYNC, 0) but then these
> > applications need to be aware of new instructions so this isn't that mu=
ch
> > additional burden...
>=20
> I am not sure application would want to add that much details/knowledge
> about a platform in their code. I was expecting application to do
>=20
> #ifdef __ppc64__
>         prctl(MAP_SYNC_ENABLE, 1, 0, 0, 0));
> #endif
>         a =3D mmap(NULL, PAGE_SIZE, PROT_READ|PROT_WRITE,
>                         MAP_SHARED_VALIDATE | MAP_SYNC, fd, 0);
>=20
>=20
> For that code all the complexity that we add w.r.t ibm,persistent-memory-=
v2
> is not useful. Do you see a value in making all these device specific rat=
her
> than a conditional on  __ppc64__?
If the vpmem devices continue to work with the old instruction on
POWER10 then it makes sense to make this per-device.

Also adding a message to kernel log in case the application does not do
the prctl would be helful for people migrating old code to POWER10.

Thanks

Michal
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

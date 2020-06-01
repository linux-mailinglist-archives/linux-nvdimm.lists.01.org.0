Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4ADA1EA194
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Jun 2020 12:09:31 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8ABD8100DEFFE;
	Mon,  1 Jun 2020 03:04:46 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=jack@suse.cz; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D7C1D100DEFFD
	for <linux-nvdimm@lists.01.org>; Mon,  1 Jun 2020 03:04:43 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 86A91AF7A;
	Mon,  1 Jun 2020 10:09:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
	id 567D31E0948; Mon,  1 Jun 2020 12:09:25 +0200 (CEST)
Date: Mon, 1 Jun 2020 12:09:25 +0200
From: Jan Kara <jack@suse.cz>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [RFC PATCH 1/2] libnvdimm: Add prctl control for disabling
 synchronous fault support.
Message-ID: <20200601100925.GC3960@quack2.suse.cz>
References: <20200529054141.156384-1-aneesh.kumar@linux.ibm.com>
 <20200529093310.GL25173@kitsune.suse.cz>
 <6183cf4a-d134-99e5-936e-ef35f530c2ec@linux.ibm.com>
 <20200529095250.GP14550@quack2.suse.cz>
 <7e8ee9e3-4d4d-e4b9-913b-1c2448adc62a@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7e8ee9e3-4d4d-e4b9-913b-1c2448adc62a@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: ECD4DSXEEM2QG5P7ZKQGP36T26V4TPFY
X-Message-ID-Hash: ECD4DSXEEM2QG5P7ZKQGP36T26V4TPFY
X-MailFrom: jack@suse.cz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>, jack@suse.de, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ECD4DSXEEM2QG5P7ZKQGP36T26V4TPFY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Fri 29-05-20 16:25:35, Aneesh Kumar K.V wrote:
> On 5/29/20 3:22 PM, Jan Kara wrote:
> > On Fri 29-05-20 15:07:31, Aneesh Kumar K.V wrote:
> > > Thanks Michal. I also missed Jeff in this email thread.
> >=20
> > And I think you'll also need some of the sched maintainers for the prctl
> > bits...
> >=20
> > > On 5/29/20 3:03 PM, Michal Such=E1nek wrote:
> > > > Adding Jan
> > > >=20
> > > > On Fri, May 29, 2020 at 11:11:39AM +0530, Aneesh Kumar K.V wrote:
> > > > > With POWER10, architecture is adding new pmem flush and sync inst=
ructions.
> > > > > The kernel should prevent the usage of MAP_SYNC if applications a=
re not using
> > > > > the new instructions on newer hardware.
> > > > >=20
> > > > > This patch adds a prctl option MAP_SYNC_ENABLE that can be used t=
o enable
> > > > > the usage of MAP_SYNC. The kernel config option is added to allow=
 the user
> > > > > to control whether MAP_SYNC should be enabled by default or not.
> > > > >=20
> > > > > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > ...
> > > > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > > > index 8c700f881d92..d5a9a363e81e 100644
> > > > > --- a/kernel/fork.c
> > > > > +++ b/kernel/fork.c
> > > > > @@ -963,6 +963,12 @@ __cacheline_aligned_in_smp DEFINE_SPINLOCK(m=
mlist_lock);
> > > > >    static unsigned long default_dump_filter =3D MMF_DUMP_FILTER_D=
EFAULT;
> > > > > +#ifdef CONFIG_ARCH_MAP_SYNC_DISABLE
> > > > > +unsigned long default_map_sync_mask =3D MMF_DISABLE_MAP_SYNC_MAS=
K;
> > > > > +#else
> > > > > +unsigned long default_map_sync_mask =3D 0;
> > > > > +#endif
> > > > > +
> >=20
> > I'm not sure CONFIG is really the right approach here. For a distro tha=
t would
> > basically mean to disable MAP_SYNC for all PPC kernels unless applicati=
on
> > explicitly uses the right prctl. Shouldn't we rather initialize
> > default_map_sync_mask on boot based on whether the CPU we run on requir=
es
> > new flush instructions or not? Otherwise the patch looks sensible.
> >=20
>=20
> yes that is correct. We ideally want to deny MAP_SYNC only w.r.t POWER10.
> But on a virtualized platform there is no easy way to detect that. We cou=
ld
> ideally hook this into the nvdimm driver where we look at the new compat
> string ibm,persistent-memory-v2 and then disable MAP_SYNC
> if we find a device with the specific value.

Hum, couldn't we set some flag for nvdimm devices with
"ibm,persistent-memory-v2" property and then check it during mmap(2) time
and when the device has this propery and the mmap(2) caller doesn't have
the prctl set, we'd disallow MAP_SYNC? That should make things mostly
seamless, shouldn't it? Only apps that want to use MAP_SYNC on these
devices would need to use prctl(MMF_DISABLE_MAP_SYNC, 0) but then these
applications need to be aware of new instructions so this isn't that much
additional burden...

> With that I am wondering should we even have this patch? Can we expect
> userspace get updated to use new instruction?.
>=20
> With ppc64 we never had a real persistent memory device available for end
> user to try. The available persistent memory stack was using vPMEM which =
was
> presented as a volatile memory region for which there is no need to use a=
ny
> of the flush instructions. We could safely assume that as we get
> applications certified/verified for working with pmem device on ppc64, th=
ey
> would all be using the new instructions?

This is a bit of a gamble... I don't have too much trust in certification /
verification because only the "big players" may do powerfail testing
throughout enough that they'd uncover these problems. So the question
really is: How many apps are out there using MAP_SYNC on ppc64? Hopefully
not many given the HW didn't ship yet as you wrote but I have no real clue.
Similarly there's a question: How many app writers will read manual for
older ppc64 architecture and write apps that won't work reliably on
POWER10? Again, I have no idea.

So the prctl would be IMHO a nice safety belt but I'm not 100% certain it
will be needed...

								Honza
--=20
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6960520AF89
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Jun 2020 12:20:25 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D661511022324;
	Fri, 26 Jun 2020 03:20:22 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=msuchanek@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E125510FCC904
	for <linux-nvdimm@lists.01.org>; Fri, 26 Jun 2020 03:20:19 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id F3E42B581;
	Fri, 26 Jun 2020 10:20:17 +0000 (UTC)
Date: Fri, 26 Jun 2020 12:20:16 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH v2 3/5] libnvdimm/nvdimm/flush: Allow architecture to
 override the flush barrier
Message-ID: <20200626102016.GP21462@kitsune.suse.cz>
References: <CAPcyv4g+oE305Q5bYWkNBKFifB9c0TZo6+hqFQnqiFqU5QFrhQ@mail.gmail.com>
 <87d070f2vs.fsf@linux.ibm.com>
 <CAPcyv4jZhYXEmYGzqGPjPtq9ZWJNtQyszN0V0Xcv0qtByK_KCw@mail.gmail.com>
 <x49o8qh9wu5.fsf@segfault.boston.devel.redhat.com>
 <ba91c061-41ef-5c54-8e9b-7b22e44577cd@linux.ibm.com>
 <CAPcyv4iG9GC42s5DaWWegH=Mi7XHgJoUghgOM9qMRrCg4wuMig@mail.gmail.com>
 <alpine.LRH.2.02.2005211442290.22894@file01.intranet.prod.int.rdu2.redhat.com>
 <20200522093127.GY25173@kitsune.suse.cz>
 <23e57565-be2a-a45c-f4d4-d8eca7262dea@linux.ibm.com>
 <alpine.LRH.2.02.2005220845200.17488@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2005220845200.17488@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: NBZJVPSJJH7GEXQCQVWO2LW5WFAYGHGI
X-Message-ID-Hash: NBZJVPSJJH7GEXQCQVWO2LW5WFAYGHGI
X-MailFrom: msuchanek@suse.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>, alistair@popple.id.au, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NBZJVPSJJH7GEXQCQVWO2LW5WFAYGHGI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2020 at 09:01:17AM -0400, Mikulas Patocka wrote:
>=20
>=20
> On Fri, 22 May 2020, Aneesh Kumar K.V wrote:
>=20
> > On 5/22/20 3:01 PM, Michal Such=C3=A1nek wrote:
> > > On Thu, May 21, 2020 at 02:52:30PM -0400, Mikulas Patocka wrote:
> > > >=20
> > > >=20
> > > > On Thu, 21 May 2020, Dan Williams wrote:
> > > >=20
> > > > > On Thu, May 21, 2020 at 10:03 AM Aneesh Kumar K.V
> > > > > <aneesh.kumar@linux.ibm.com> wrote:
> > > > > >=20
> > > > > > > Moving on to the patch itself--Aneesh, have you audited other
> > > > > > > persistent
> > > > > > > memory users in the kernel?  For example, drivers/md/dm-write=
cache.c
> > > > > > > does
> > > > > > > this:
> > > > > > >=20
> > > > > > > static void writecache_commit_flushed(struct dm_writecache *w=
c, bool
> > > > > > > wait_for_ios)
> > > > > > > {
> > > > > > >        if (WC_MODE_PMEM(wc))
> > > > > > >                wmb(); <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > >           else
> > > > > > >                   ssd_commit_flushed(wc, wait_for_ios);
> > > > > > > }
> > > > > > >=20
> > > > > > > I believe you'll need to make modifications there.
> > > > > > >=20
> > > > > >=20
> > > > > > Correct. Thanks for catching that.
> > > > > >=20
> > > > > >=20
> > > > > > I don't understand dm much, wondering how this will work with
> > > > > > non-synchronous DAX device?
> > > > >=20
> > > > > That's a good point. DM-writecache needs to be cognizant of things
> > > > > like virtio-pmem that violate the rule that persisent memory writ=
es
> > > > > can be flushed by CPU functions rather than calling back into the
> > > > > driver. It seems we need to always make the flush case a dax_oper=
ation
> > > > > callback to account for this.
> > > >=20
> > > > dm-writecache is normally sitting on the top of dm-linear, so it wo=
uld
> > > > need to pass the wmb() call through the dm core and dm-linear targe=
t ...
> > > > that would slow it down ... I remember that you already did it this=
 way
> > > > some times ago and then removed it.
> > > >=20
> > > > What's the exact problem with POWER? Could the POWER system have tw=
o types
> > > > of persistent memory that need two different ways of flushing?
> > >=20
> > > As far as I understand the discussion so far
> > >=20
> > >   - on POWER $oldhardware uses $oldinstruction to ensure pmem consist=
ency
> > >   - on POWER $newhardware uses $newinstruction to ensure pmem consist=
ency
> > >     (compatible with $oldinstruction on $oldhardware)
> >=20
> > Correct.
> >=20
> > >   - on some platforms instead of barrier instruction a callback into =
the
> > >     driver is issued to ensure consistency=20
> >=20
> > This is virtio-pmem only at this point IIUC.
> >=20
> > -aneesh
>=20
> And does the virtio-pmem driver track which pages are dirty? Or does it=20
> need to specify the range of pages to flush in the flush function?
>=20
> > > None of this is reflected by the dm driver.
>=20
> We could make a new dax method:
> void *(dax_get_flush_function)(void);
>=20
> This would return a pointer to "wmb()" on x86 and something else on Power.
>=20
> The method "dax_get_flush_function" would be called only once when=20
> initializing the writecache driver (because the call would be slow becaus=
e=20
> it would have to go through the DM stack) and then, the returned function=
=20
> would be called each time we need write ordering. The returned function=20
> would do just "sfence; ret".

Hello,

as far as I understand the code virtio_pmem has a fush function defined
which indeed can make use of the region properties, such as memory
range. If such function exists you need quivalent of sync() - call into
the device in question. If it does not calling arch_pmem_flush_barrier()
instead of wmb() should suffice.

I am not aware of an interface to determine if the flush function exists
for a particular region.

Thanks

Michal
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

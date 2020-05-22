Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CE41DE786
	for <lists+linux-nvdimm@lfdr.de>; Fri, 22 May 2020 15:01:36 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A7EA111FE8B0B;
	Fri, 22 May 2020 05:57:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=mpatocka@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EB63411FE8B0A
	for <linux-nvdimm@lists.01.org>; Fri, 22 May 2020 05:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1590152490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gFFp4PY2q6XngmMDcgxR3SERztb+l48+iSkbcR2vUwA=;
	b=WE6ke5zTieVUSNz9xKQTvi14tsHb7VomwS1jh1Cu2UAayn2OToX3ZWVcS5eOu7p8V9QvON
	7iMkONqDDMeskyRGscjIc1QvtoYcVb2WxngEv3SVxZdju2HaS4NdoExBVaA+u7xtLYeKN9
	UBiQ8957MkqPF8AQv763f1crRfaLfDY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-X2igJmbUOIG4NzTVRJjJzA-1; Fri, 22 May 2020 09:01:22 -0400
X-MC-Unique: X2igJmbUOIG4NzTVRJjJzA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78A8B8015D2;
	Fri, 22 May 2020 13:01:20 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A39505C1D0;
	Fri, 22 May 2020 13:01:19 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 04MD1Jp8020003;
	Fri, 22 May 2020 09:01:19 -0400
Received: from localhost (mpatocka@localhost)
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 04MD1Har019975;
	Fri, 22 May 2020 09:01:17 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date: Fri, 22 May 2020 09:01:17 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v2 3/5] libnvdimm/nvdimm/flush: Allow architecture to
 override the flush barrier
In-Reply-To: <23e57565-be2a-a45c-f4d4-d8eca7262dea@linux.ibm.com>
Message-ID: <alpine.LRH.2.02.2005220845200.17488@file01.intranet.prod.int.rdu2.redhat.com>
References: <20200513034705.172983-3-aneesh.kumar@linux.ibm.com> <CAPcyv4iAdrdMiSzVr1UL9Naya+Rq70WVuKqCCNFHe1C4n+E6Tw@mail.gmail.com> <87v9kspk3x.fsf@linux.ibm.com> <CAPcyv4g+oE305Q5bYWkNBKFifB9c0TZo6+hqFQnqiFqU5QFrhQ@mail.gmail.com> <87d070f2vs.fsf@linux.ibm.com>
 <CAPcyv4jZhYXEmYGzqGPjPtq9ZWJNtQyszN0V0Xcv0qtByK_KCw@mail.gmail.com> <x49o8qh9wu5.fsf@segfault.boston.devel.redhat.com> <ba91c061-41ef-5c54-8e9b-7b22e44577cd@linux.ibm.com> <CAPcyv4iG9GC42s5DaWWegH=Mi7XHgJoUghgOM9qMRrCg4wuMig@mail.gmail.com>
 <alpine.LRH.2.02.2005211442290.22894@file01.intranet.prod.int.rdu2.redhat.com> <20200522093127.GY25173@kitsune.suse.cz> <23e57565-be2a-a45c-f4d4-d8eca7262dea@linux.ibm.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-ID: <alpine.LRH.2.02.2005220857020.17488@file01.intranet.prod.int.rdu2.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: FPN4GU63KYOJAQ4YYYUDMXQ5LNOKR22T
X-Message-ID-Hash: FPN4GU63KYOJAQ4YYYUDMXQ5LNOKR22T
X-MailFrom: mpatocka@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: =?ISO-8859-15?Q?Michal_Such=E1nek?= <msuchanek@suse.de>, Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>, alistair@popple.id.au, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FPN4GU63KYOJAQ4YYYUDMXQ5LNOKR22T/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: TEXT/PLAIN; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable



On Fri, 22 May 2020, Aneesh Kumar K.V wrote:

> On 5/22/20 3:01 PM, Michal Such=C3=A1nek wrote:
> > On Thu, May 21, 2020 at 02:52:30PM -0400, Mikulas Patocka wrote:
> > >=20
> > >=20
> > > On Thu, 21 May 2020, Dan Williams wrote:
> > >=20
> > > > On Thu, May 21, 2020 at 10:03 AM Aneesh Kumar K.V
> > > > <aneesh.kumar@linux.ibm.com> wrote:
> > > > >=20
> > > > > > Moving on to the patch itself--Aneesh, have you audited other
> > > > > > persistent
> > > > > > memory users in the kernel?  For example, drivers/md/dm-writeca=
che.c
> > > > > > does
> > > > > > this:
> > > > > >=20
> > > > > > static void writecache_commit_flushed(struct dm_writecache *wc,=
 bool
> > > > > > wait_for_ios)
> > > > > > {
> > > > > >        if (WC_MODE_PMEM(wc))
> > > > > >                wmb(); <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > >           else
> > > > > >                   ssd_commit_flushed(wc, wait_for_ios);
> > > > > > }
> > > > > >=20
> > > > > > I believe you'll need to make modifications there.
> > > > > >=20
> > > > >=20
> > > > > Correct. Thanks for catching that.
> > > > >=20
> > > > >=20
> > > > > I don't understand dm much, wondering how this will work with
> > > > > non-synchronous DAX device?
> > > >=20
> > > > That's a good point. DM-writecache needs to be cognizant of things
> > > > like virtio-pmem that violate the rule that persisent memory writes
> > > > can be flushed by CPU functions rather than calling back into the
> > > > driver. It seems we need to always make the flush case a dax_operat=
ion
> > > > callback to account for this.
> > >=20
> > > dm-writecache is normally sitting on the top of dm-linear, so it would
> > > need to pass the wmb() call through the dm core and dm-linear target =
...
> > > that would slow it down ... I remember that you already did it this w=
ay
> > > some times ago and then removed it.
> > >=20
> > > What's the exact problem with POWER? Could the POWER system have two =
types
> > > of persistent memory that need two different ways of flushing?
> >=20
> > As far as I understand the discussion so far
> >=20
> >   - on POWER $oldhardware uses $oldinstruction to ensure pmem consisten=
cy
> >   - on POWER $newhardware uses $newinstruction to ensure pmem consisten=
cy
> >     (compatible with $oldinstruction on $oldhardware)
>=20
> Correct.
>=20
> >   - on some platforms instead of barrier instruction a callback into the
> >     driver is issued to ensure consistency=20
>=20
> This is virtio-pmem only at this point IIUC.
>=20
> -aneesh

And does the virtio-pmem driver track which pages are dirty? Or does it=20
need to specify the range of pages to flush in the flush function?

> > None of this is reflected by the dm driver.

We could make a new dax method:
void *(dax_get_flush_function)(void);

This would return a pointer to "wmb()" on x86 and something else on Power.

The method "dax_get_flush_function" would be called only once when=20
initializing the writecache driver (because the call would be slow because =

it would have to go through the DM stack) and then, the returned function=20
would be called each time we need write ordering. The returned function=20
would do just "sfence; ret".

Mikulas
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

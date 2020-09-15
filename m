Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D535226AE3B
	for <lists+linux-nvdimm@lfdr.de>; Tue, 15 Sep 2020 21:57:08 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0B5C013DEB058;
	Tue, 15 Sep 2020 12:57:07 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=63.128.21.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=msnitzer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [63.128.21.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2CECD13DEB055
	for <linux-nvdimm@lists.01.org>; Tue, 15 Sep 2020 12:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1600199823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O0X8UTmONpbP2JfCWh2lKiKC87/8M+iYu1O9R0xykBc=;
	b=gUEGB9gapr4gj78/ZjmE9Zxj6tUBmJ49WN0zvf0OqubHsC9XN14ha/a71iwRJ7UpLRGRVx
	gi1OfGe4B7TmhaWJPjc8u1K88VWH0H0ah6qWZC0WGvE4VaX1US5DxtU2b5F33v3/Wskgrk
	z2uo6sJ+PBlfe9KyWUQDcrN9i/GIats=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-wrcc3BqIOSGNOq_Pab5SJA-1; Tue, 15 Sep 2020 15:56:59 -0400
X-MC-Unique: wrcc3BqIOSGNOq_Pab5SJA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3969802B51;
	Tue, 15 Sep 2020 19:56:57 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A1E8319D7C;
	Tue, 15 Sep 2020 19:56:57 +0000 (UTC)
Date: Tue, 15 Sep 2020 15:56:56 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: =?utf-8?B?5Zue5aSN77yacmVncmVzc2lvbiBj?=
 =?utf-8?Q?aused_by_patch_6180bb446ab624b9ab8bf201ed251ca87f07b413=3F=3F_?=
 =?utf-8?Q?=28=22dax=3A_fix_detectio?= =?utf-8?Q?n?= of dax support for
 non-persistent memory block?? devices")
Message-ID: <20200915195656.GA21635@redhat.com>
References: <alpine.LRH.2.02.2009141131220.30651@file01.intranet.prod.int.rdu2.redhat.com>
 <211sy17ij47lox90ncna7kwk-k7cl0b-ubtml5jg8ocd-r7lb68jgkncbq5ng3g-koqyd471rzfh-t231u5-sxwvexwht98i-b7in5pxxck0j-3b40lqlmuelf13q0uk-ye4ohhsbgodw-xuloz9wpp7tf.1600139009031@email.android.com>
 <20200915080106.GG4863@quack2.suse.cz>
 <CAPcyv4jHG7Lp0RrX+WmNHY5iSE5FjgrvYxd_d6TN5CKfc5LReQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jHG7Lp0RrX+WmNHY5iSE5FjgrvYxd_d6TN5CKfc5LReQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=msnitzer@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Message-ID-Hash: B5NLOLLVH66YVGQAEZYY7GVXKIUNVNRO
X-Message-ID-Hash: B5NLOLLVH66YVGQAEZYY7GVXKIUNVNRO
X-MailFrom: msnitzer@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, "colyli@suse.de" <colyli@suse.de>, Adrian Huang <ahuang12@lenovo.com>, Jan Kara <jack@suse.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Mikulas Patocka <mpatocka@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/B5NLOLLVH66YVGQAEZYY7GVXKIUNVNRO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Sep 15 2020 at  3:49pm -0400,
Dan Williams <dan.j.williams@intel.com> wrote:

> On Tue, Sep 15, 2020 at 1:01 AM Jan Kara <jack@suse.cz> wrote:
> >
> > Hi!
> >
> > On Tue 15-09-20 11:03:29, colyli@suse.de wrote:
> > > Could you please to take a look? I am offline in the next two weeks.
> >
> > I just had a look into this. IMHO the justification in 6180bb446a "dax: fix
> > detection of dax support for non-persistent memory block devices" is just
> > bogus and people got confused by the previous condition
> >
> > if (!dax_dev && !bdev_dax_supported(bdev, blocksize))
> >
> > which was bogus as well. bdev_dax_supported() always returns false for bdev
> > that doesn't have dax_dev (naturally so). So in the original condition
> > there was no point in calling bdev_dax_supported() if we know dax_dev is
> > NULL.
> >
> > Then this was changed to:
> >
> > if (!dax_dev || !bdev_dax_supported(bdev, blocksize))
> >
> > which looks more sensible at the first sight. But only at the first sight -
> > if you look at wider context, __generic_fsdax_supported() is the bulk of
> > code that decides whether a device supports DAX so calling
> > bdev_dax_supported() from it indeed doesn't look as such a great idea. So
> > IMO the condition should be just:
> >
> > if (!dax_dev)
> >
> > I'll send a fix for this.
> 
> If you beat me to it, great, but you might be sleeping now. I agree
> the original condition was bogus and looks to be a result of previous
> non-thorough refactoring on my part. I think we can move that !dax_dev
> into dax_supported(). I'll take a look.

You trimmed the relevant portion of Jan's reply but: can you also
weigh-in one whether DM is using the wrong function to test for DAX?

Mike
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

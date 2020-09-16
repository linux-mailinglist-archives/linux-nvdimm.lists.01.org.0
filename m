Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2877726C212
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Sep 2020 13:25:00 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 55C02144137B1;
	Wed, 16 Sep 2020 04:24:58 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=jack@suse.cz; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A1F57143F0B9E
	for <linux-nvdimm@lists.01.org>; Wed, 16 Sep 2020 04:24:55 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 9C964B14C;
	Wed, 16 Sep 2020 11:25:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
	id 004841E12E1; Wed, 16 Sep 2020 13:24:53 +0200 (CEST)
Date: Wed, 16 Sep 2020 13:24:53 +0200
From: Jan Kara <jack@suse.cz>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: =?utf-8?B?5Zue5aSN77yacmVncmVzc2lvbiBj?=
 =?utf-8?Q?aused_by_patch_6180bb446ab624b9ab8bf201ed251ca87f07b413=3F=3F_?=
 =?utf-8?Q?=28=22dax=3A_fix_detectio?= =?utf-8?Q?n?= of dax support for
 non-persistent memory block?? devices")
Message-ID: <20200916112453.GE3607@quack2.suse.cz>
References: <alpine.LRH.2.02.2009141131220.30651@file01.intranet.prod.int.rdu2.redhat.com>
 <211sy17ij47lox90ncna7kwk-k7cl0b-ubtml5jg8ocd-r7lb68jgkncbq5ng3g-koqyd471rzfh-t231u5-sxwvexwht98i-b7in5pxxck0j-3b40lqlmuelf13q0uk-ye4ohhsbgodw-xuloz9wpp7tf.1600139009031@email.android.com>
 <20200915080106.GG4863@quack2.suse.cz>
 <CAPcyv4jHG7Lp0RrX+WmNHY5iSE5FjgrvYxd_d6TN5CKfc5LReQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4jHG7Lp0RrX+WmNHY5iSE5FjgrvYxd_d6TN5CKfc5LReQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: 6R7H2OUONKR6EH53ZDIG7LMIG3HRCTNI
X-Message-ID-Hash: 6R7H2OUONKR6EH53ZDIG7LMIG3HRCTNI
X-MailFrom: jack@suse.cz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, "colyli@suse.de" <colyli@suse.de>, Adrian Huang <ahuang12@lenovo.com>, Jan Kara <jack@suse.com>, Mike Snitzer <snitzer@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Mikulas Patocka <mpatocka@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6R7H2OUONKR6EH53ZDIG7LMIG3HRCTNI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue 15-09-20 12:49:10, Dan Williams wrote:
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

Adrian actually already submitted a fix here:

https://lore.kernel.org/linux-nvdimm/20200915075729.12518-1-adrianhuang0701@gmail.com/

so we're now refining the fix in that thread.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

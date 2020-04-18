Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FD21AF3F0
	for <lists+linux-nvdimm@lfdr.de>; Sat, 18 Apr 2020 20:57:28 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D18C010FC62E1;
	Sat, 18 Apr 2020 11:57:34 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=216.40.44.36; helo=smtprelay.hostedemail.com; envelope-from=joe@perches.com; receiver=<UNKNOWN> 
Received: from smtprelay.hostedemail.com (smtprelay0036.hostedemail.com [216.40.44.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AE2A110FC62E0
	for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 11:57:32 -0700 (PDT)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
	by smtprelay05.hostedemail.com (Postfix) with ESMTP id AB7DD1801C62B;
	Sat, 18 Apr 2020 18:57:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:968:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3871:4321:4605:5007:6742:6743:7875:10004:10400:10848:11026:11232:11473:11658:11914:12043:12297:12438:12740:12760:12895:13069:13311:13357:13439:14096:14097:14659:14721:21080:21627:21740:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: oven32_22ec242d00d03
X-Filterd-Recvd-Size: 2832
Received: from XPS-9350.home (unknown [47.151.136.130])
	(Authenticated sender: joe@perches.com)
	by omf13.hostedemail.com (Postfix) with ESMTPA;
	Sat, 18 Apr 2020 18:57:19 +0000 (UTC)
Message-ID: <d018321b0f281ff29efb04dd1496c8e6499812fb.camel@perches.com>
Subject: Re: [PATCH 7/9] drivers/base: fix empty-body warnings in
 devcoredump.c
From: Joe Perches <joe@perches.com>
To: Randy Dunlap <rdunlap@infradead.org>, Matthew Wilcox
 <willy@infradead.org>
Date: Sat, 18 Apr 2020 11:55:05 -0700
In-Reply-To: <b88d6f8b-e6af-7071-cefa-dc12e79116b6@infradead.org>
References: <20200418184111.13401-1-rdunlap@infradead.org>
	 <20200418184111.13401-8-rdunlap@infradead.org>
	 <20200418185033.GQ5820@bombadil.infradead.org>
	 <b88d6f8b-e6af-7071-cefa-dc12e79116b6@infradead.org>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Message-ID-Hash: HOIS7MGG3DFYZY6PSLVVJK2OYXPIN3OP
X-Message-ID-Hash: HOIS7MGG3DFYZY6PSLVVJK2OYXPIN3OP
X-MailFrom: joe@perches.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, linux-nvdimm@lists.01.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, Zzy Wysm <zzy@zzywysm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HOIS7MGG3DFYZY6PSLVVJK2OYXPIN3OP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, 2020-04-18 at 11:53 -0700, Randy Dunlap wrote:
> On 4/18/20 11:50 AM, Matthew Wilcox wrote:
> > On Sat, Apr 18, 2020 at 11:41:09AM -0700, Randy Dunlap wrote:
> > > @@ -294,11 +295,11 @@ void dev_coredumpm(struct device *dev, s
> > >  
> > >  	if (sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
> > >  			      "failing_device"))
> > > -		/* nothing - symlink will be missing */;
> > > +		do_empty(); /* nothing - symlink will be missing */
> > >  
> > >  	if (sysfs_create_link(&dev->kobj, &devcd->devcd_dev.kobj,
> > >  			      "devcoredump"))
> > > -		/* nothing - symlink will be missing */;
> > > +		do_empty(); /* nothing - symlink will be missing */
> > >  
> > >  	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
> > >  	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
> > 
> > Could just remove the 'if's?
> > 
> > +	sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
> > +			"failing_device");
> > 
> 
> OK.

sysfs_create_link is __must_check

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

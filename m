Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE751AF42A
	for <lists+linux-nvdimm@lfdr.de>; Sat, 18 Apr 2020 21:17:09 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9446F10FC62E8;
	Sat, 18 Apr 2020 12:17:15 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a01:4f8:191:4433::2; helo=sipsolutions.net; envelope-from=johannes@sipsolutions.net; receiver=<UNKNOWN> 
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id ED29F10FC62E7
	for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 12:17:13 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	(envelope-from <johannes@sipsolutions.net>)
	id 1jPswv-00APdE-Hr; Sat, 18 Apr 2020 21:16:21 +0200
Message-ID: <ae170e7c4988399e63a00ad8505e397665563d22.camel@sipsolutions.net>
Subject: Re: [PATCH 7/9] drivers/base: fix empty-body warnings in
 devcoredump.c
From: Johannes Berg <johannes@sipsolutions.net>
To: Matthew Wilcox <willy@infradead.org>, Joe Perches <joe@perches.com>
Date: Sat, 18 Apr 2020 21:16:19 +0200
In-Reply-To: <20200418191338.GR5820@bombadil.infradead.org>
References: <20200418184111.13401-1-rdunlap@infradead.org>
	 <20200418184111.13401-8-rdunlap@infradead.org>
	 <20200418185033.GQ5820@bombadil.infradead.org>
	 <b88d6f8b-e6af-7071-cefa-dc12e79116b6@infradead.org>
	 <d018321b0f281ff29efb04dd1496c8e6499812fb.camel@perches.com>
	 <20200418191338.GR5820@bombadil.infradead.org>
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Message-ID-Hash: P52MHTG7HUUI2JCYTO75TE54SFROILAX
X-Message-ID-Hash: P52MHTG7HUUI2JCYTO75TE54SFROILAX
X-MailFrom: johannes@sipsolutions.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, Zzy Wysm <zzy@zzywysm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/P52MHTG7HUUI2JCYTO75TE54SFROILAX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, 2020-04-18 at 12:13 -0700, Matthew Wilcox wrote:
> 
> > > > >  	if (sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
> > > > >  			      "failing_device"))
> > > > > -		/* nothing - symlink will be missing */;
> > > > > +		do_empty(); /* nothing - symlink will be missing */
> > > > >  
> > > > >  	if (sysfs_create_link(&dev->kobj, &devcd->devcd_dev.kobj,
> > > > >  			      "devcoredump"))
> > > > > -		/* nothing - symlink will be missing */;
> > > > > +		do_empty(); /* nothing - symlink will be missing */
> > > > >  
> > > > >  	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
> > > > >  	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
> > > > 
> > > > Could just remove the 'if's?
> > > > 
> > > > +	sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
> > > > +			"failing_device");
> > > > 
> > > 
> > > OK.
> > 
> > sysfs_create_link is __must_check
> 
> Oh, I missed the declaration -- I just saw the definition.  This is a
> situation where __must_check hurts us and it should be removed.
> 
> Or this code is wrong and it should be
> 
> 	WARN(sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
> 			"failing_device");

Perhaps it should be. I didn't think it really mattered _that_ much if
the symlink suddenly went missing, but OTOH I don't even know how it
could possibly fail.

johannes
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7461AF422
	for <lists+linux-nvdimm@lfdr.de>; Sat, 18 Apr 2020 21:14:03 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 369EC10FC62E6;
	Sat, 18 Apr 2020 12:14:09 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 22BC310FC62E5
	for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 12:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1Xuy0hbaik5jnBw+JX74GiEbxwfdlzrwJ6CXAcCNKJ0=; b=Pbh2gwHBC+0n9j0XheYbIXwFQj
	DLH/6PgobmCWmxlogha43zhUGSOtU89tXwjVH0o1Rho/S2T2EjJTPG70nmSsvSMvvLuonOlXdkiEF
	yGJpGvfRz2PkLCG7L7Uy3m9lgzRa8kBf6U42WpkqqxMc3bt3hK4TRhmhD0zC1q2wsbCa9130nX/Tr
	BTyG4Wi0/MtCFbctxHGNP3IoIr9AwF92URUTCaCCqCq81Wkivc6Os9SxUDznfhAgxmUgbP9sTqTjg
	OQaGKDbNC89jhx9AoLbm18DH/xji73LaoYjLqiNC454x2nCt2c/0XKhdkme0M37SQxFbl37OzjXm7
	wpboRveg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jPsuI-0002hx-99; Sat, 18 Apr 2020 19:13:38 +0000
Date: Sat, 18 Apr 2020 12:13:38 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 7/9] drivers/base: fix empty-body warnings in
 devcoredump.c
Message-ID: <20200418191338.GR5820@bombadil.infradead.org>
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-8-rdunlap@infradead.org>
 <20200418185033.GQ5820@bombadil.infradead.org>
 <b88d6f8b-e6af-7071-cefa-dc12e79116b6@infradead.org>
 <d018321b0f281ff29efb04dd1496c8e6499812fb.camel@perches.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d018321b0f281ff29efb04dd1496c8e6499812fb.camel@perches.com>
Message-ID-Hash: XQDLLJU6W7JK6ELAYP7Q6RBR7I6OQMXT
X-Message-ID-Hash: XQDLLJU6W7JK6ELAYP7Q6RBR7I6OQMXT
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, linux-nvdimm@lists.01.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, Zzy Wysm <zzy@zzywysm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XQDLLJU6W7JK6ELAYP7Q6RBR7I6OQMXT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Apr 18, 2020 at 11:55:05AM -0700, Joe Perches wrote:
> On Sat, 2020-04-18 at 11:53 -0700, Randy Dunlap wrote:
> > On 4/18/20 11:50 AM, Matthew Wilcox wrote:
> > > On Sat, Apr 18, 2020 at 11:41:09AM -0700, Randy Dunlap wrote:
> > > > @@ -294,11 +295,11 @@ void dev_coredumpm(struct device *dev, s
> > > >  
> > > >  	if (sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
> > > >  			      "failing_device"))
> > > > -		/* nothing - symlink will be missing */;
> > > > +		do_empty(); /* nothing - symlink will be missing */
> > > >  
> > > >  	if (sysfs_create_link(&dev->kobj, &devcd->devcd_dev.kobj,
> > > >  			      "devcoredump"))
> > > > -		/* nothing - symlink will be missing */;
> > > > +		do_empty(); /* nothing - symlink will be missing */
> > > >  
> > > >  	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
> > > >  	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
> > > 
> > > Could just remove the 'if's?
> > > 
> > > +	sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
> > > +			"failing_device");
> > > 
> > 
> > OK.
> 
> sysfs_create_link is __must_check

Oh, I missed the declaration -- I just saw the definition.  This is a
situation where __must_check hurts us and it should be removed.

Or this code is wrong and it should be

	WARN(sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
			"failing_device");

like drivers/pci/controller/vmd.c and drivers/i2c/i2c-mux.c

Either way, the do_empty() construct feels like the wrong way of covering
up the warning.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7E71AF3C7
	for <lists+linux-nvdimm@lfdr.de>; Sat, 18 Apr 2020 20:50:50 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CFB0910FC62DA;
	Sat, 18 Apr 2020 11:50:56 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 56BD510FC62D6
	for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 11:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M2qa3/vc2/myvbMk+MYALeJsSLdNzC1fZAyoJyG68gE=; b=musbWlm7i2hjImd1CYGB5QW7l8
	Wn/kGpq4MEnK3EQO7eZeKDFT8eS5LR23e3CnYhCDStAgjQAFY5YBGVt6kelglv19B681ienPPYSaq
	YfDJC+H0H5NLdOmuRZEmcigYq143fNpyKGLW6QQRzawQ8loN2w3Tr8KqH0mfYRp8Pfor829wVUHqA
	l1trL/tl9vJG07nJcZqpDQmkbddJurRYVp9wZ2ld/OgdRFRqUkk7SeljH7WfG/EzD5GnLgRWzeBn2
	+F+hn6JAaMQT4MLsGR2BZlvqMq0c/4rnwpzB0mmIRStMWYlkSjUiT2M0RY1BWI/jkco5Jw22oyFTf
	oqBggJew==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jPsXx-0005fx-6n; Sat, 18 Apr 2020 18:50:33 +0000
Date: Sat, 18 Apr 2020 11:50:33 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 7/9] drivers/base: fix empty-body warnings in
 devcoredump.c
Message-ID: <20200418185033.GQ5820@bombadil.infradead.org>
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-8-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200418184111.13401-8-rdunlap@infradead.org>
Message-ID-Hash: 4TEVYK7JJ3BNLAJSC5OTHTMID6ASC322
X-Message-ID-Hash: 4TEVYK7JJ3BNLAJSC5OTHTMID6ASC322
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, linux-nvdimm@lists.01.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, Zzy Wysm <zzy@zzywysm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4TEVYK7JJ3BNLAJSC5OTHTMID6ASC322/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Apr 18, 2020 at 11:41:09AM -0700, Randy Dunlap wrote:
> @@ -294,11 +295,11 @@ void dev_coredumpm(struct device *dev, s
>  
>  	if (sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
>  			      "failing_device"))
> -		/* nothing - symlink will be missing */;
> +		do_empty(); /* nothing - symlink will be missing */
>  
>  	if (sysfs_create_link(&dev->kobj, &devcd->devcd_dev.kobj,
>  			      "devcoredump"))
> -		/* nothing - symlink will be missing */;
> +		do_empty(); /* nothing - symlink will be missing */
>  
>  	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
>  	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);

Could just remove the 'if's?

+	sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
+			"failing_device");
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

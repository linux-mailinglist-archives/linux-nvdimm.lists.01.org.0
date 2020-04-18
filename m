Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A73A41AF46E
	for <lists+linux-nvdimm@lfdr.de>; Sat, 18 Apr 2020 21:54:18 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3316110FC62D3;
	Sat, 18 Apr 2020 12:54:24 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.131.102.5; helo=netrider.rowland.org; envelope-from=stern+5e9eda24@rowland.harvard.edu; receiver=<UNKNOWN> 
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by ml01.01.org (Postfix) with SMTP id 53B8510FC51C4
	for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 12:54:21 -0700 (PDT)
Received: (qmail 9694 invoked by uid 500); 18 Apr 2020 15:54:12 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Apr 2020 15:54:12 -0400
Date: Sat, 18 Apr 2020 15:54:12 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 5/9] usb: fix empty-body warning in sysfs.c
In-Reply-To: <20200418184409.GP5820@bombadil.infradead.org>
Message-ID: <Pine.LNX.4.44L0.2004181549020.8036-100000@netrider.rowland.org>
MIME-Version: 1.0
Message-ID-Hash: W7IV3XSFIAFVMVFUGY6GU45CMKQMGYLH
X-Message-ID-Hash: W7IV3XSFIAFVMVFUGY6GU45CMKQMGYLH
X-MailFrom: stern+5e9eda24@rowland.harvard.edu
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, linux-nvdimm@lists.01.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, Zzy Wysm <zzy@zzywysm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/W7IV3XSFIAFVMVFUGY6GU45CMKQMGYLH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, 18 Apr 2020, Matthew Wilcox wrote:

> On Sat, Apr 18, 2020 at 11:41:07AM -0700, Randy Dunlap wrote:
> > +++ linux-next-20200327/drivers/usb/core/sysfs.c
> > @@ -1263,7 +1263,7 @@ void usb_create_sysfs_intf_files(struct
> >  	if (!alt->string && !(udev->quirks & USB_QUIRK_CONFIG_INTF_STRINGS))
> >  		alt->string = usb_cache_string(udev, alt->desc.iInterface);
> >  	if (alt->string && device_create_file(&intf->dev, &dev_attr_interface))
> > -		;	/* We don't actually care if the function fails. */
> > +		do_empty(); /* We don't actually care if the function fails. */
> >  	intf->sysfs_files_created = 1;
> >  }
> 
> Why not just?
> 
> +	if (alt->string)
> +		device_create_file(&intf->dev, &dev_attr_interface);

This is another __must_check function call.

The reason we don't care if the call fails is because the file
being created holds the USB interface string descriptor, something
which is purely informational and hardly ever gets set (and no doubt
gets used even less often).

Is this another situation where the comment should be expanded and the 
code modified to include a useless test and cast-to-void?

Or should device_create_file() not be __must_check after all?

Greg?

Alan Stern
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

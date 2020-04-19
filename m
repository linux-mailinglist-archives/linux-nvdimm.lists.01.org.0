Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AC51AF8AE
	for <lists+linux-nvdimm@lfdr.de>; Sun, 19 Apr 2020 10:16:14 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6ACD910FC62F7;
	Sun, 19 Apr 2020 01:16:16 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=batv+8073abf7e593c145f889+6083+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EC6F110FC62E3
	for <linux-nvdimm@lists.01.org>; Sun, 19 Apr 2020 01:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5ESkbM+8vdIgFeaQKLQyxVIJU96HxbIdvJ6LQfSPcow=; b=pvwx1GcXIeC3t5uPawsWBkdVHQ
	iiXxl+0atw1Ow7dCeTaEPlV5pGZmU5NeEHgiD6GauX1slXAECXQsFNE9NMWu2519ywz/b+wff/WOX
	TMC/+MPMdjO3TT0Rftrna/Ci0Cahq1lB09MN0hgPjg6UlZQSvFQvI8Hl6eF9ZnaIwxOSfJg5ri8Io
	KIuagSQHqNGIuLyx0OKk7Kr7BqpWFvOxOSCJWQS71I0fmCgMrFQjcaFVpza7oTJ7VbiVVU4LRpdAF
	8xATbPDeZWMvxCY4UHfmtjy1TJqqQqEx8Dbn+J6I61UlAQZJU8HDszvtYFjQWk5yWngyPZTufulmD
	TFNoMHog==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jQ57G-0008EZ-Na; Sun, 19 Apr 2020 08:15:50 +0000
Date: Sun, 19 Apr 2020 01:15:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 8/9] dax: fix empty-body warnings in bus.c
Message-ID: <20200419081550.GA22341@infradead.org>
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-9-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200418184111.13401-9-rdunlap@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: PZ7LSVZFWOAR35KMIZ2RIDXDPJ4AF34M
X-Message-ID-Hash: PZ7LSVZFWOAR35KMIZ2RIDXDPJ4AF34M
X-MailFrom: BATV+8073abf7e593c145f889+6083+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, linux-nvdimm@lists.01.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, Zzy Wysm <zzy@zzywysm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PZ7LSVZFWOAR35KMIZ2RIDXDPJ4AF34M/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Apr 18, 2020 at 11:41:10AM -0700, Randy Dunlap wrote:
>  				rc = -ENOMEM;
>  		} else
> -			/* nothing to remove */;
> +			do_empty(); /* nothing to remove */
>  	} else if (action == ID_REMOVE) {
>  		list_del(&dax_id->list);
>  		kfree(dax_id);
>  	} else
> -		/* dax_id already added */;
> +		do_empty(); /* dax_id already added */

This is just nasty.  Please just always turn this bogus warning off
as the existing code is a perfectly readable idiom while the new code
is just nasty crap for no good reason at all.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

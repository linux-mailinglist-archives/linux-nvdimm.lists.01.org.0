Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD6C1CEECC
	for <lists+linux-nvdimm@lfdr.de>; Tue, 12 May 2020 10:08:28 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7B6B111A6261B;
	Tue, 12 May 2020 01:05:57 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=<UNKNOWN> 
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 192D311A618C9
	for <linux-nvdimm@lists.01.org>; Tue, 12 May 2020 01:05:55 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1BC1368BEB; Tue, 12 May 2020 10:08:21 +0200 (CEST)
Date: Tue, 12 May 2020 10:08:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: remove a few uses of ->queuedata
Message-ID: <20200512080820.GA2336@lst.de>
References: <20200508161517.252308-1-hch@lst.de> <CAPcyv4j3gVqrZWCCc2Q-6JizGAQXW0b+R1BcvWCZOvzaukGLQg@mail.gmail.com> <20200509082352.GB21834@lst.de> <CAPcyv4ggb7_rwzGbhHNXSHd+jjSpZC=+DMEztY6Cu8Bc=ZNzag@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4ggb7_rwzGbhHNXSHd+jjSpZC=+DMEztY6Cu8Bc=ZNzag@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Message-ID-Hash: GF756KC5FK7VVEOEJJH7RZWWRAHMFFO5
X-Message-ID-Hash: GF756KC5FK7VVEOEJJH7RZWWRAHMFFO5
X-MailFrom: hch@lst.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Jim Paris <jim@jtan.com>, Geoff Levand <geoff@infradead.org>, Joshua Morris <josh.h.morris@us.ibm.com>, Philip Kelleher <pjk1939@linux.ibm.com>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-m68k@lists.linux-m68k.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-xtensa@linux-xtensa.org, drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-bcache@vger.kernel.org, linux-raid <linux-raid@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GF756KC5FK7VVEOEJJH7RZWWRAHMFFO5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, May 09, 2020 at 08:07:14AM -0700, Dan Williams wrote:
> > which are all used in the I/O submission path (generic_make_request /
> > generic_make_request_checks).  This is mostly a prep cleanup patch to
> > also remove the pointless queue argument from ->make_request - then
> > ->queue is an extra dereference and extra churn.
> 
> Ah ok. If the changelogs had been filled in with something like "In
> preparation for removing @q from make_request_fn, stop using
> ->queuedata", I probably wouldn't have looked twice.
> 
> For the nvdimm/ driver updates you can add:
> 
>     Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 
> ...or just let me know if you want me to pick those up through the nvdimm tree.

I'd love you to pick them up through the nvdimm tree.  Do you want
to fix up the commit message yourself?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

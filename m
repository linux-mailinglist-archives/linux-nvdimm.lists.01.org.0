Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF801CBEEC
	for <lists+linux-nvdimm@lfdr.de>; Sat,  9 May 2020 10:24:36 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C8B27118A0EFF;
	Sat,  9 May 2020 01:22:25 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=<UNKNOWN> 
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0F96E1162EB2B
	for <linux-nvdimm@lists.01.org>; Sat,  9 May 2020 01:22:24 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8260E68CEC; Sat,  9 May 2020 10:24:31 +0200 (CEST)
Date: Sat, 9 May 2020 10:24:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Subject: Re: remove a few uses of ->queuedata
Message-ID: <20200509082431.GC21834@lst.de>
References: <20200508161517.252308-1-hch@lst.de> <20200508221321.GD1389136@T590>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200508221321.GD1389136@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Message-ID-Hash: IRPMDJRTQLFI3SFF2QZYFOYLVWOANTJM
X-Message-ID-Hash: IRPMDJRTQLFI3SFF2QZYFOYLVWOANTJM
X-MailFrom: hch@lst.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Jim Paris <jim@jtan.com>, Geoff Levand <geoff@infradead.org>, Joshua Morris <josh.h.morris@us.ibm.com>, Philip Kelleher <pjk1939@linux.ibm.com>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org, drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <>
List-Archive: <>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, May 09, 2020 at 06:13:21AM +0800, Ming Lei wrote:
> On Fri, May 08, 2020 at 06:15:02PM +0200, Christoph Hellwig wrote:
> > Hi all,
> > 
> > various bio based drivers use queue->queuedata despite already having
> > set up disk->private_data, which can be used just as easily.  This
> > series cleans them up to only use a single private data pointer.
> > 
> > blk-mq based drivers that have code pathes that can't easily get at
> > the gendisk are unaffected by this series.
> 
> Yeah, before adding disk, there still may be requests queued to LLD
> for blk-mq based drivers.
> 
> So are there this similar situation for these bio based drivers?

bio submittsion is based on the gendisk, so we can't submit before
it is added.  The passthrough request based path obviously doesn't apply
here.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

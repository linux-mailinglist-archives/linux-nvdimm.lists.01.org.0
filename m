Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7611CBA7C
	for <lists+linux-nvdimm@lfdr.de>; Sat,  9 May 2020 00:13:52 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8CBCB119003A8;
	Fri,  8 May 2020 15:11:44 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=ming.lei@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CAB0C118B18D4
	for <linux-nvdimm@lists.01.org>; Fri,  8 May 2020 15:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1588976027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7XTZwXR9Z9h3mhkEx2o1bmyDVneFoc2pkGAjVYehhi0=;
	b=DYNToviyiMl7w9UQ7gUvhh4rfgDyGWwcDsjwd27ECg2H3FwzzSssQXrTZcpq+3N7UBFMm1
	Vu0a1br9K1I1rIwmOj6Qx1d0WI/+76mtYQ3/Vm8jkJxxDipFgxnawZQYtdT21dapbfb3HL
	lnYUcnow49Lv4KkpYGMEYM4Cnrgdi2s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-d2xIQt37O8yux2pmv4ZgAg-1; Fri, 08 May 2020 18:13:42 -0400
X-MC-Unique: d2xIQt37O8yux2pmv4ZgAg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 828A51005510;
	Fri,  8 May 2020 22:13:39 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 74FBC1001B07;
	Fri,  8 May 2020 22:13:27 +0000 (UTC)
Date: Sat, 9 May 2020 06:13:21 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: remove a few uses of ->queuedata
Message-ID: <20200508221321.GD1389136@T590>
References: <20200508161517.252308-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200508161517.252308-1-hch@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Message-ID-Hash: KZB2QDE7IWSE6UD6XOPCAUKTSVORGD5R
X-Message-ID-Hash: KZB2QDE7IWSE6UD6XOPCAUKTSVORGD5R
X-MailFrom: ming.lei@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jens Axboe <axboe@kernel.dk>, Jim Paris <jim@jtan.com>, Geoff Levand <geoff@infradead.org>, Joshua Morris <josh.h.morris@us.ibm.com>, Philip Kelleher <pjk1939@linux.ibm.com>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org, drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KZB2QDE7IWSE6UD6XOPCAUKTSVORGD5R/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, May 08, 2020 at 06:15:02PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> various bio based drivers use queue->queuedata despite already having
> set up disk->private_data, which can be used just as easily.  This
> series cleans them up to only use a single private data pointer.
> 
> blk-mq based drivers that have code pathes that can't easily get at
> the gendisk are unaffected by this series.

Yeah, before adding disk, there still may be requests queued to LLD
for blk-mq based drivers.

So are there this similar situation for these bio based drivers?


Thanks,
Ming
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

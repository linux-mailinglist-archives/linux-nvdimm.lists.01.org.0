Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9124621473D
	for <lists+linux-nvdimm@lfdr.de>; Sat,  4 Jul 2020 18:08:19 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2DB41111AFBB8;
	Sat,  4 Jul 2020 09:08:17 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=jic23@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D89231118BAEB
	for <linux-nvdimm@lists.01.org>; Sat,  4 Jul 2020 09:08:12 -0700 (PDT)
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id EE73520739;
	Sat,  4 Jul 2020 16:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593878892;
	bh=1BpfsvpmseYY6Czd4aQrB5WsjTyV3T6hjuFnvWaFxYk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l5+F5/ytTi7u4OFepYp/cyoSTMCyGXSJo0lhT6S9CBsCxhL19+xmKTfgSTcvWh4KH
	 bFN3f+bYvtnJNrdrnt0YqD9n94fo5RXRHJ6w3byFwfT+jsusMAk5NsjiJYU2EwrTMQ
	 BI7iVw6BHNgJrKRAU3Hh+9xUm0dkCc2iKNJdzwqg=
Date: Sat, 4 Jul 2020 17:08:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH 06/17] Documentation/driver-api: generic-counter: drop
 doubled word
Message-ID: <20200704170805.18b07f1a@archlinux>
In-Reply-To: <20200704123041.GA5194@shinobu>
References: <20200704034502.17199-1-rdunlap@infradead.org>
	<20200704034502.17199-7-rdunlap@infradead.org>
	<20200704123041.GA5194@shinobu>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Message-ID-Hash: KKZHLEBKAEUANI7SDUKQUEK4Y26H3UA2
X-Message-ID-Hash: KKZHLEBKAEUANI7SDUKQUEK4Y26H3UA2
X-MailFrom: jic23@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-nvdimm@lists.01.org, linux-usb@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KKZHLEBKAEUANI7SDUKQUEK4Y26H3UA2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, 4 Jul 2020 08:30:41 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Fri, Jul 03, 2020 at 08:44:51PM -0700, Randy Dunlap wrote:
> > Drop the doubled word "the".
> > 
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: linux-doc@vger.kernel.org
> > Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
> > Cc: linux-iio@vger.kernel.org
> > ---
> >  Documentation/driver-api/generic-counter.rst |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- linux-next-20200701.orig/Documentation/driver-api/generic-counter.rst
> > +++ linux-next-20200701/Documentation/driver-api/generic-counter.rst
> > @@ -262,7 +262,7 @@ the system.
> >  Counter Counts may be allocated via counter_count structures, and
> >  respective Counter Signal associations (Synapses) made via
> >  counter_synapse structures. Associated counter_synapse structures are
> > -stored as an array and set to the the synapses array member of the
> > +stored as an array and set to the synapses array member of the
> >  respective counter_count structure. These counter_count structures are
> >  set to the counts array member of an allocated counter_device structure
> >  before the Counter is registered to the system.  
> 
> Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Applied to the togreg branch of iio.git

Thanks,

Jonathan
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

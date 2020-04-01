Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C9319AF80
	for <lists+linux-nvdimm@lfdr.de>; Wed,  1 Apr 2020 18:14:31 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C1F2F10FC3764;
	Wed,  1 Apr 2020 09:15:19 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-delivery-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 28AA210FC363D
	for <linux-nvdimm@lists.01.org>; Wed,  1 Apr 2020 09:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1585757667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BwLjwW0ZN4RV6KPYUWCSZF/c2rPm1lXXgz0HJ8FZAPg=;
	b=RD/aCu6neMpZtcQUXW1Qh5RYZ43gD8istHRRHz5uMfLID8hjlD/gxBRKcRBpNd5j+JeM+K
	yOCiEmVAA8qLsTPA7YT/KZ3mtHz3x3yMZDXS5eImH9hCj4KhtaqK1Tu0RCo43a/XiqMU7O
	nYPhVSBU97aK3xyuKBzRsH9p9Kbm+sY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-sfcpXAfHOpSdjLB9aQjdBg-1; Wed, 01 Apr 2020 12:14:21 -0400
X-MC-Unique: sfcpXAfHOpSdjLB9aQjdBg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5328B1902EA1;
	Wed,  1 Apr 2020 16:14:20 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-83.rdu2.redhat.com [10.10.115.83])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3B84419C70;
	Wed,  1 Apr 2020 16:14:17 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 9613D220005; Wed,  1 Apr 2020 12:14:16 -0400 (EDT)
Date: Wed, 1 Apr 2020 12:14:16 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 4/8] dax, pmem: Add a dax operation zero_page_range
Message-ID: <20200401161416.GC9398@redhat.com>
References: <20200218214841.10076-1-vgoyal@redhat.com>
 <20200218214841.10076-5-vgoyal@redhat.com>
 <CAPcyv4jKHxy5c8BZodePeCu5+Z=cwhtEfw3RnOD1ZDNob382bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4jKHxy5c8BZodePeCu5+Z=cwhtEfw3RnOD1ZDNob382bQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Message-ID-Hash: UFHPITYREUMTBANDTMPGPK6XJJWESG4A
X-Message-ID-Hash: UFHPITYREUMTBANDTMPGPK6XJJWESG4A
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Christoph Hellwig <hch@infradead.org>, device-mapper development <dm-devel@redhat.com>, Christoph Hellwig <hch@lst.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UFHPITYREUMTBANDTMPGPK6XJJWESG4A/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Mar 31, 2020 at 12:38:16PM -0700, Dan Williams wrote:
> On Tue, Feb 18, 2020 at 1:49 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > Add a dax operation zero_page_range, to zero a range of memory. This will
> > also clear any poison in the range being zeroed.
> >
> > As of now, zeroing of up to one page is allowed in a single call. There
> > are no callers which are trying to zero more than a page in a single call.
> > Once we grow the callers which zero more than a page in single call, we
> > can add that support. Primary reason for not doing that yet is that this
> > will add little complexity in dm implementation where a range might be
> > spanning multiple underlying targets and one will have to split the range
> > into multiple sub ranges and call zero_page_range() on individual targets.
> >
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  drivers/dax/super.c   | 19 +++++++++++++++++++
> >  drivers/nvdimm/pmem.c | 10 ++++++++++
> >  include/linux/dax.h   |  3 +++
> >  3 files changed, 32 insertions(+)
> >
> > diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> > index 0aa4b6bc5101..c912808bc886 100644
> > --- a/drivers/dax/super.c
> > +++ b/drivers/dax/super.c
> > @@ -344,6 +344,25 @@ size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
> >  }
> >  EXPORT_SYMBOL_GPL(dax_copy_to_iter);
> >
> > +int dax_zero_page_range(struct dax_device *dax_dev, u64 offset, size_t len)
> > +{
> > +       if (!dax_alive(dax_dev))
> > +               return -ENXIO;
> > +
> > +       if (!dax_dev->ops->zero_page_range)
> > +               return -EOPNOTSUPP;
> 
> This seems too late to be doing the validation. It would be odd for
> random filesystem operations to see this error. I would move the check
> to alloc_dax() and fail that if the caller fails to implement the
> operation.
> 
> An incremental patch on top to fix this up would be ok. Something like
> "Now that all dax_operations providers implement zero_page_range()
> mandate it at alloc_dax time".

Hi Dan,

Posted an extra patch in same patch series for this.

https://lore.kernel.org/linux-fsdevel/20200228163456.1587-1-vgoyal@redhat.com/T/#m624680cbb5e714266d4b34ade2d6c390dae69598

Vivek
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

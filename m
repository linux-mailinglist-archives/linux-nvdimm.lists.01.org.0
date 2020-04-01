Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FA519AC78
	for <lists+linux-nvdimm@lfdr.de>; Wed,  1 Apr 2020 15:15:25 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8B55310FC3BA0;
	Wed,  1 Apr 2020 06:16:13 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A201D10FC3774
	for <linux-nvdimm@lists.01.org>; Wed,  1 Apr 2020 06:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1585746918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uDWi3WDn1B2QwOc9496H7TM03TtVTOftspl14cHOSNA=;
	b=S2WikJ6MAlmp+kUP/r2tLY+LkGHrSxDaUqhWa+wcEeoGIKa5BfXH8umrVwhkI8iudlNLnC
	Ex04roE75Sj7OhQ2UggiqDbMAf9dgC29Jv7zRVyEIhOYNXUhF5SzecJM71PsI8sg7aIWXd
	Mt02WMt5dVth4ih7VvuzcyjVZE5RIxo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-C-GpJADTMS21MbxEZWGp5g-1; Wed, 01 Apr 2020 09:15:13 -0400
X-MC-Unique: C-GpJADTMS21MbxEZWGp5g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8799D100DFC1;
	Wed,  1 Apr 2020 13:15:11 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-83.rdu2.redhat.com [10.10.115.83])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AF9985C1D5;
	Wed,  1 Apr 2020 13:15:08 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 269EF220005; Wed,  1 Apr 2020 09:15:08 -0400 (EDT)
Date: Wed, 1 Apr 2020 09:15:08 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 4/8] dax, pmem: Add a dax operation zero_page_range
Message-ID: <20200401131508.GA3434@redhat.com>
References: <20200218214841.10076-1-vgoyal@redhat.com>
 <20200218214841.10076-5-vgoyal@redhat.com>
 <CAPcyv4jKHxy5c8BZodePeCu5+Z=cwhtEfw3RnOD1ZDNob382bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4jKHxy5c8BZodePeCu5+Z=cwhtEfw3RnOD1ZDNob382bQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Message-ID-Hash: QY7LCJITFUPNGTKRBTWCVMUIUUOR3VH7
X-Message-ID-Hash: QY7LCJITFUPNGTKRBTWCVMUIUUOR3VH7
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Christoph Hellwig <hch@infradead.org>, device-mapper development <dm-devel@redhat.com>, Christoph Hellwig <hch@lst.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QY7LCJITFUPNGTKRBTWCVMUIUUOR3VH7/>
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

Ok, I will send an incremental patch for this.

BTW, I have posted V6 of this patch series and you might want to look
at that instead of V5.

https://lore.kernel.org/linux-fsdevel/20200228163456.1587-1-vgoyal@redhat.com/

Vivek
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6C2159298
	for <lists+linux-nvdimm@lfdr.de>; Tue, 11 Feb 2020 16:11:35 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EC0401007A82E;
	Tue, 11 Feb 2020 07:14:50 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.120; helo=us-smtp-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [205.139.110.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 611DA1007B1C2
	for <linux-nvdimm@lists.01.org>; Tue, 11 Feb 2020 07:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1581433889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xWrVwmVPWaQjEiPR8xrbcdO9jipuXVef6xbTXqC/E5c=;
	b=TYHbyn27Y9xOA0ItZjopCSWRr6zIyE9EI470NwnqAHcdkI5pGEZXtd/DYj8eP/H8eQLZHS
	FqS915vBrc6Fy9HlI8rIngS4TA2nmOtrPGqtmCwM2VRsmC2ajrCSgdOgauzYh9kpylp5Vz
	tHJLFNHnN4L/v6Wjc+3cS4wCJiCm8jk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-JdHOYAdvPNyeRD3JB0pOGA-1; Tue, 11 Feb 2020 10:11:22 -0500
X-MC-Unique: JdHOYAdvPNyeRD3JB0pOGA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80F7A1005514;
	Tue, 11 Feb 2020 15:11:20 +0000 (UTC)
Received: from horse.redhat.com (ovpn-123-66.rdu2.redhat.com [10.10.123.66])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 97B6C26FDB;
	Tue, 11 Feb 2020 15:11:14 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 48F50220A24; Tue, 11 Feb 2020 10:11:14 -0500 (EST)
Date: Tue, 11 Feb 2020 10:11:14 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH v3 4/7] s390,dcssblk,dax: Add dax zero_page_range
 operation to dcssblk driver
Message-ID: <20200211151114.GA8590@redhat.com>
References: <20200207202652.1439-1-vgoyal@redhat.com>
 <20200207202652.1439-5-vgoyal@redhat.com>
 <20200210215315.27b7e310@thinkpad>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200210215315.27b7e310@thinkpad>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Message-ID-Hash: RZ2WMBZS6SYDT3G6NIKLKDDXTVNPAXEJ
X-Message-ID-Hash: RZ2WMBZS6SYDT3G6NIKLKDDXTVNPAXEJ
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, hch@infradead.org, dm-devel@redhat.com, linux-s390@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RZ2WMBZS6SYDT3G6NIKLKDDXTVNPAXEJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 10, 2020 at 09:53:15PM +0100, Gerald Schaefer wrote:
> On Fri,  7 Feb 2020 15:26:49 -0500
> Vivek Goyal <vgoyal@redhat.com> wrote:
> 
> > Add dax operation zero_page_range for dcssblk driver.
> > 
> > CC: linux-s390@vger.kernel.org
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  drivers/s390/block/dcssblk.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
> > index 63502ca537eb..331abab5d066 100644
> > --- a/drivers/s390/block/dcssblk.c
> > +++ b/drivers/s390/block/dcssblk.c
> > @@ -57,11 +57,28 @@ static size_t dcssblk_dax_copy_to_iter(struct dax_device *dax_dev,
> >  	return copy_to_iter(addr, bytes, i);
> >  }
> >  
> > +static int dcssblk_dax_zero_page_range(struct dax_device *dax_dev, u64 offset,
> > +				       size_t len)
> > +{
> > +	long rc;
> > +	void *kaddr;
> > +	pgoff_t pgoff = offset >> PAGE_SHIFT;
> > +	unsigned page_offset = offset_in_page(offset);
> > +
> > +	rc = dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
> 
> Why do you pass only 1 page as nr_pages argument for dax_direct_access()?
> In some other patch in this series there is a comment that this will
> currently only be used for one page, but support for more pages might be
> added later. Wouldn't it make sense to rather use something like
> PAGE_ALIGN(page_offset + len) >> PAGE_SHIFT instead of 1 here, so that
> this won't have to be changed when callers will be ready to use it
> with more than one page?
> 
> Of course, I guess then we'd also need some check on the return value
> from dax_direct_access(), i.e. if the returned available range is
> large enough for the requested range.

I left it at 1 page because that's the current limitation of this
interface and there are no callers which are zeroing across page
boundaries.

I prefer to keep it this way and modify it when we are extending this
interface to allow zeroing across page boundaries. Because even if I add
that logic, I can't test it.

But if you still prefer to change it, I am open to make that change.

Thanks
Vivek
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

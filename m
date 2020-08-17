Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE040246E18
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Aug 2020 19:22:37 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 01E24132E5400;
	Mon, 17 Aug 2020 10:22:36 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.120; helo=us-smtp-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [205.139.110.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D37A3132E53FF
	for <linux-nvdimm@lists.01.org>; Mon, 17 Aug 2020 10:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1597684951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WKN0994t/hbdJ7u3ukIhrtrsKOYgx7+SHughQ7Y0XYU=;
	b=PAuuu7K1RTA0FTCSR75M/DFKeS0svunXZYJTHwc9V/PwYhNpor1rRZaQuFLbSS1HypjKL7
	A+2x4c4ccF0vxp4lt58DC7jT81uckkvBRurMWtVTSJqAUPm84HoTpWVYSAza8lk1wc3hD0
	crQ2bQKdHyxS17DSCGcXzuvjEf52jJM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-97ei8BkgNj6e3vRfERYvKg-1; Mon, 17 Aug 2020 13:22:28 -0400
X-MC-Unique: 97ei8BkgNj6e3vRfERYvKg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D1A5801AAF;
	Mon, 17 Aug 2020 17:22:27 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-81.rdu2.redhat.com [10.10.115.81])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 35478756AA;
	Mon, 17 Aug 2020 17:22:21 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 9FA4A222E58; Mon, 17 Aug 2020 13:22:20 -0400 (EDT)
Date: Mon, 17 Aug 2020 13:22:20 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 02/20] dax: Create a range version of
 dax_layout_busy_page()
Message-ID: <20200817172220.GB630630@redhat.com>
References: <20200807195526.426056-1-vgoyal@redhat.com>
 <20200807195526.426056-3-vgoyal@redhat.com>
 <20200817165339.GA22500@quack2.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200817165339.GA22500@quack2.suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Message-ID-Hash: 3GVGBM65XIIT3OOC3YGFMPCBHHLGMPWB
X-Message-ID-Hash: 3GVGBM65XIIT3OOC3YGFMPCBHHLGMPWB
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, virtio-fs@redhat.com, miklos@szeredi.hu, stefanha@redhat.com, dgilbert@redhat.com, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3GVGBM65XIIT3OOC3YGFMPCBHHLGMPWB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Aug 17, 2020 at 06:53:39PM +0200, Jan Kara wrote:
> On Fri 07-08-20 15:55:08, Vivek Goyal wrote:
> > virtiofs device has a range of memory which is mapped into file inodes
> > using dax. This memory is mapped in qemu on host and maps different
> > sections of real file on host. Size of this memory is limited
> > (determined by administrator) and depending on filesystem size, we will
> > soon reach a situation where all the memory is in use and we need to
> > reclaim some.
> > 
> > As part of reclaim process, we will need to make sure that there are
> > no active references to pages (taken by get_user_pages()) on the memory
> > range we are trying to reclaim. I am planning to use
> > dax_layout_busy_page() for this. But in current form this is per inode
> > and scans through all the pages of the inode.
> > 
> > We want to reclaim only a portion of memory (say 2MB page). So we want
> > to make sure that only that 2MB range of pages do not have any
> > references  (and don't want to unmap all the pages of inode).
> > 
> > Hence, create a range version of this function named
> > dax_layout_busy_page_range() which can be used to pass a range which
> > needs to be unmapped.
> > 
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: linux-nvdimm@lists.01.org
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> 
> The API looks OK. Some comments WRT the implementation below.
> 
> > diff --git a/fs/dax.c b/fs/dax.c
> > index 11b16729b86f..0d51b0fbb489 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -558,27 +558,20 @@ static void *grab_mapping_entry(struct xa_state *xas,
> >  	return xa_mk_internal(VM_FAULT_FALLBACK);
> >  }
> >  
> > -/**
> > - * dax_layout_busy_page - find first pinned page in @mapping
> > - * @mapping: address space to scan for a page with ref count > 1
> > - *
> > - * DAX requires ZONE_DEVICE mapped pages. These pages are never
> > - * 'onlined' to the page allocator so they are considered idle when
> > - * page->count == 1. A filesystem uses this interface to determine if
> > - * any page in the mapping is busy, i.e. for DMA, or other
> > - * get_user_pages() usages.
> > - *
> > - * It is expected that the filesystem is holding locks to block the
> > - * establishment of new mappings in this address_space. I.e. it expects
> > - * to be able to run unmap_mapping_range() and subsequently not race
> > - * mapping_mapped() becoming true.
> > +/*
> > + * Partial pages are included. If end is LLONG_MAX, pages in the range from
> > + * start to end of the file are inluded.
> >   */
> 
> I think the big kerneldoc comment should stay with
> dax_layout_busy_page_range() since dax_layout_busy_page() will be just a
> trivial wrapper around it..

Hi Jan,

Thanks for the review.

Will move kerneldoc comment.


> 
> > -struct page *dax_layout_busy_page(struct address_space *mapping)
> > +struct page *dax_layout_busy_page_range(struct address_space *mapping,
> > +					loff_t start, loff_t end)
> >  {
> > -	XA_STATE(xas, &mapping->i_pages, 0);
> >  	void *entry;
> >  	unsigned int scanned = 0;
> >  	struct page *page = NULL;
> > +	pgoff_t start_idx = start >> PAGE_SHIFT;
> > +	pgoff_t end_idx = end >> PAGE_SHIFT;
> > +	XA_STATE(xas, &mapping->i_pages, start_idx);
> > +	loff_t len, lstart = round_down(start, PAGE_SIZE);
> >  
> >  	/*
> >  	 * In the 'limited' case get_user_pages() for dax is disabled.
> > @@ -589,6 +582,22 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
> >  	if (!dax_mapping(mapping) || !mapping_mapped(mapping))
> >  		return NULL;
> >  
> > +	/* If end == LLONG_MAX, all pages from start to till end of file */
> > +	if (end == LLONG_MAX) {
> > +		end_idx = ULONG_MAX;
> > +		len = 0;
> > +	} else {
> > +		/* length is being calculated from lstart and not start.
> > +		 * This is due to behavior of unmap_mapping_range(). If
> > +		 * start is say 4094 and end is on 4096 then we want to
> > +		 * unamp two pages, idx 0 and 1. But unmap_mapping_range()
> > +		 * will unmap only page at idx 0. If we calculate len
> > +		 * from the rounded down start, this problem should not
> > +		 * happen.
> > +		 */
> > +		len = end - lstart + 1;
> > +	}
> 
> Maybe it would be more understandable to use
> 	unmap_mapping_pages(mapping, start_idx, end_idx - start_idx + 1);
> below and avoid all this rounding and special-casing.

Will do.

> 
> > +
> >  	/*
> >  	 * If we race get_user_pages_fast() here either we'll see the
> >  	 * elevated page count in the iteration and wait, or
> > @@ -601,10 +610,10 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
> >  	 * guaranteed to either see new references or prevent new
> >  	 * references from being established.
> >  	 */
> > -	unmap_mapping_range(mapping, 0, 0, 0);
> > +	unmap_mapping_range(mapping, start, len, 0);
> >  
> >  	xas_lock_irq(&xas);
> > -	xas_for_each(&xas, entry, ULONG_MAX) {
> > +	xas_for_each(&xas, entry, end_idx) {
> >  		if (WARN_ON_ONCE(!xa_is_value(entry)))
> >  			continue;
> >  		if (unlikely(dax_is_locked(entry)))
> > @@ -625,6 +634,27 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
> >  	xas_unlock_irq(&xas);
> >  	return page;
> >  }
> > +EXPORT_SYMBOL_GPL(dax_layout_busy_page_range);
> > +
> > +/**
> > + * dax_layout_busy_page - find first pinned page in @mapping
> > + * @mapping: address space to scan for a page with ref count > 1
> > + *
> > + * DAX requires ZONE_DEVICE mapped pages. These pages are never
> > + * 'onlined' to the page allocator so they are considered idle when
> > + * page->count == 1. A filesystem uses this interface to determine if
> > + * any page in the mapping is busy, i.e. for DMA, or other
> > + * get_user_pages() usages.
> > + *
> > + * It is expected that the filesystem is holding locks to block the
> > + * establishment of new mappings in this address_space. I.e. it expects
> > + * to be able to run unmap_mapping_range() and subsequently not race
> > + * mapping_mapped() becoming true.
> > + */
> > +struct page *dax_layout_busy_page(struct address_space *mapping)
> > +{
> > +	return dax_layout_busy_page_range(mapping, 0, 0);
> 
> Should the 'end' rather be LLONG_MAX?

My bad. I forgot to change this. Previous version of patches had the
semantic that 'end == 0' signifies till the end of file. Yes, 'end'
should be LLONG_MAX now. Will fix it.

Thanks
Vivek

> 
> Otherwise the patch looks good to me.
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

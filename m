Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE88A36717E
	for <lists+linux-nvdimm@lfdr.de>; Wed, 21 Apr 2021 19:39:56 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2EAAB100EAB61;
	Wed, 21 Apr 2021 10:39:55 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2839C100EAB60
	for <linux-nvdimm@lists.01.org>; Wed, 21 Apr 2021 10:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619026790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NozKqtAQsLfIuTJYfL4jEF5T8uHtk7yVgiyg7jRNbZo=;
	b=bQUnKTyfhm9VaeDMKQYSZ+PTqHRIi0Qjfd9oCzk6oe1GzP8SvADgnARwIGcAeGcvOJx36O
	Wwul+raFs7oxCiR5lgj17bZNN7X8rcMhMJkSRWT+L2pZSGnQIiY8jPfhJulxfVoUKRcWFS
	ZGLONLx857YhTryTfsRPvohL+LpfmmY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-R1oJopAjPNS_ZDvua3z3Zg-1; Wed, 21 Apr 2021 13:39:36 -0400
X-MC-Unique: R1oJopAjPNS_ZDvua3z3Zg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EAE28030C9;
	Wed, 21 Apr 2021 17:39:35 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-206.rdu2.redhat.com [10.10.114.206])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 26E885D769;
	Wed, 21 Apr 2021 17:39:32 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id B4E70220BCF; Wed, 21 Apr 2021 13:39:31 -0400 (EDT)
Date: Wed, 21 Apr 2021 13:39:31 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [Virtio-fs] [PATCH v3 2/3] dax: Add a wakeup mode parameter to
 put_unlocked_entry()
Message-ID: <20210421173931.GF1579961@redhat.com>
References: <20210419213636.1514816-1-vgoyal@redhat.com>
 <20210419213636.1514816-3-vgoyal@redhat.com>
 <20210420093420.2eed3939@bahia.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210420093420.2eed3939@bahia.lan>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Message-ID-Hash: KA74JVOM7ONVQKQDFROP4FS32K65QQFG
X-Message-ID-Hash: KA74JVOM7ONVQKQDFROP4FS32K65QQFG
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, jack@suse.cz, willy@infradead.org, linux-nvdimm@lists.01.org, miklos@szeredi.hu, linux-kernel@vger.kernel.org, virtio-fs@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KA74JVOM7ONVQKQDFROP4FS32K65QQFG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Apr 20, 2021 at 09:34:20AM +0200, Greg Kurz wrote:
> On Mon, 19 Apr 2021 17:36:35 -0400
> Vivek Goyal <vgoyal@redhat.com> wrote:
> 
> > As of now put_unlocked_entry() always wakes up next waiter. In next
> > patches we want to wake up all waiters at one callsite. Hence, add a
> > parameter to the function.
> > 
> > This patch does not introduce any change of behavior.
> > 
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  fs/dax.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/dax.c b/fs/dax.c
> > index 00978d0838b1..f19d76a6a493 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -275,11 +275,12 @@ static void wait_entry_unlocked(struct xa_state *xas, void *entry)
> >  	finish_wait(wq, &ewait.wait);
> >  }
> >  
> > -static void put_unlocked_entry(struct xa_state *xas, void *entry)
> > +static void put_unlocked_entry(struct xa_state *xas, void *entry,
> > +			       enum dax_entry_wake_mode mode)
> >  {
> >  	/* If we were the only waiter woken, wake the next one */
> 
> With this change, the comment is no longer accurate since the
> function can now wake all waiters if passed mode == WAKE_ALL.
> Also, it paraphrases the code which is simple enough, so I'd
> simply drop it.

Ok, I will get rid of this comment. Agreed that code is simple
enough. And frankly speaking I don't even understand "If we were the
only waiter woken" part. How do we know that only this caller
was woken.

Vivek

> 
> This is minor though and it shouldn't prevent this fix to go
> forward.
> 
> Reviewed-by: Greg Kurz <groug@kaod.org>
> 
> >  	if (entry && !dax_is_conflict(entry))
> > -		dax_wake_entry(xas, entry, WAKE_NEXT);
> > +		dax_wake_entry(xas, entry, mode);
> >  }
> >  
> >  /*
> > @@ -633,7 +634,7 @@ struct page *dax_layout_busy_page_range(struct address_space *mapping,
> >  			entry = get_unlocked_entry(&xas, 0);
> >  		if (entry)
> >  			page = dax_busy_page(entry);
> > -		put_unlocked_entry(&xas, entry);
> > +		put_unlocked_entry(&xas, entry, WAKE_NEXT);
> >  		if (page)
> >  			break;
> >  		if (++scanned % XA_CHECK_SCHED)
> > @@ -675,7 +676,7 @@ static int __dax_invalidate_entry(struct address_space *mapping,
> >  	mapping->nrexceptional--;
> >  	ret = 1;
> >  out:
> > -	put_unlocked_entry(&xas, entry);
> > +	put_unlocked_entry(&xas, entry, WAKE_NEXT);
> >  	xas_unlock_irq(&xas);
> >  	return ret;
> >  }
> > @@ -954,7 +955,7 @@ static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
> >  	return ret;
> >  
> >   put_unlocked:
> > -	put_unlocked_entry(xas, entry);
> > +	put_unlocked_entry(xas, entry, WAKE_NEXT);
> >  	return ret;
> >  }
> >  
> > @@ -1695,7 +1696,7 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
> >  	/* Did we race with someone splitting entry or so? */
> >  	if (!entry || dax_is_conflict(entry) ||
> >  	    (order == 0 && !dax_is_pte_entry(entry))) {
> > -		put_unlocked_entry(&xas, entry);
> > +		put_unlocked_entry(&xas, entry, WAKE_NEXT);
> >  		xas_unlock_irq(&xas);
> >  		trace_dax_insert_pfn_mkwrite_no_entry(mapping->host, vmf,
> >  						      VM_FAULT_NOPAGE);
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

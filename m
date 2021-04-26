Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0782A36B85C
	for <lists+linux-nvdimm@lfdr.de>; Mon, 26 Apr 2021 19:52:37 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5A5DA100EBBA2;
	Mon, 26 Apr 2021 10:52:34 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 99139100EF276
	for <linux-nvdimm@lists.01.org>; Mon, 26 Apr 2021 10:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619459548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vWzRnpXVlW5LRY1iXXQRwUChafBizRadg9HN9FqtYdM=;
	b=SCFhA+uoCb0E4zQoeATV2aNiV+atxRueRVliGseUOxwBy1jcrrDvWKQhgCl+hUvX3nc2XA
	bP0iKgf993L0/+/13hnj0BCAciNyC4qH8nd+cPORhvPc2gkJhTJAEHeJfyZvXL8BTREbr6
	l25anFCTPtyCn8Uo/tpFFdo6lpyKcZE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-xCDh-EyJNauYWT0Sm-_tng-1; Mon, 26 Apr 2021 13:52:26 -0400
X-MC-Unique: xCDh-EyJNauYWT0Sm-_tng-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EB1C87A83E;
	Mon, 26 Apr 2021 17:52:25 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-66.rdu2.redhat.com [10.10.114.66])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2695C5D6A1;
	Mon, 26 Apr 2021 17:52:18 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 9EF97220BCF; Mon, 26 Apr 2021 13:52:17 -0400 (EDT)
Date: Mon, 26 Apr 2021 13:52:17 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 1/3] dax: Add an enum for specifying dax wakup mode
Message-ID: <20210426175217.GD1741690@redhat.com>
References: <20210423130723.1673919-1-vgoyal@redhat.com>
 <20210423130723.1673919-2-vgoyal@redhat.com>
 <20210426134632.GM235567@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210426134632.GM235567@casper.infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Message-ID-Hash: KG42F25AGNZEFYQN6Z5E2O2IWPAUGQK4
X-Message-ID-Hash: KG42F25AGNZEFYQN6Z5E2O2IWPAUGQK4
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, virtio-fs@redhat.com, miklos@szeredi.hu, jack@suse.cz, slp@redhat.com, groug@kaod.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KG42F25AGNZEFYQN6Z5E2O2IWPAUGQK4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Apr 26, 2021 at 02:46:32PM +0100, Matthew Wilcox wrote:
> On Fri, Apr 23, 2021 at 09:07:21AM -0400, Vivek Goyal wrote:
> > +enum dax_wake_mode {
> > +	WAKE_NEXT,
> > +	WAKE_ALL,
> > +};
> 
> Why define them in this order when ...
> 
> > @@ -196,7 +207,7 @@ static void dax_wake_entry(struct xa_state *xas, void *entry, bool wake_all)
> >  	 * must be in the waitqueue and the following check will see them.
> >  	 */
> >  	if (waitqueue_active(wq))
> > -		__wake_up(wq, TASK_NORMAL, wake_all ? 0 : 1, &key);
> > +		__wake_up(wq, TASK_NORMAL, mode == WAKE_ALL ? 0 : 1, &key);
> 
> ... they're used like this?  This is almost as bad as
> 
> enum bool {
> 	true,
> 	false,
> };

Hi Matthew,

So you prefer that I should switch order of WAKE_NEXT and WAKE_ALL? 

enum dax_wake_mode {
	WAKE_ALL,
	WAKE_NEXT,
};


And then do following to wake task.

if (waitqueue_active(wq))
	__wake_up(wq, TASK_NORMAL, mode, &key);

I am fine with this if you like this better.

Or you are suggesting that don't introduce "enum dax_wake_mode" to
begin with.

Vivek
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEF036B8AF
	for <lists+linux-nvdimm@lfdr.de>; Mon, 26 Apr 2021 20:08:35 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F267F100EBB6F;
	Mon, 26 Apr 2021 11:08:33 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2B958100EBBA2
	for <linux-nvdimm@lists.01.org>; Mon, 26 Apr 2021 11:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619460508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A1r1y2XmXpPoWoQQIZR44ApqAwQCbrMIhs03n4zkI9M=;
	b=HTB8z9V11sG2XDkhqMRdaPkBqbAd7o8vbDmi+wWkSD47nkqeP3GrrjhKNhqibEjVjklSc5
	2K/JDYVsZFamvz7brMRfHRoBydFqEctAE7ezzUUYrpmeiyFsFHvoe+fnG00YNBc+NzWgKr
	Fzc/7odIxHhpncmAoztC9NoFw7DbgxQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-s-SJ1R8rOjSd00roqxDARw-1; Mon, 26 Apr 2021 14:08:26 -0400
X-MC-Unique: s-SJ1R8rOjSd00roqxDARw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 593816D4FA;
	Mon, 26 Apr 2021 18:08:24 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-66.rdu2.redhat.com [10.10.114.66])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9642F19C78;
	Mon, 26 Apr 2021 18:08:17 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 251CE220BCF; Mon, 26 Apr 2021 14:08:17 -0400 (EDT)
Date: Mon, 26 Apr 2021 14:08:17 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 1/3] dax: Add an enum for specifying dax wakup mode
Message-ID: <20210426180817.GF1741690@redhat.com>
References: <20210423130723.1673919-1-vgoyal@redhat.com>
 <20210423130723.1673919-2-vgoyal@redhat.com>
 <20210426134632.GM235567@casper.infradead.org>
 <20210426175217.GD1741690@redhat.com>
 <20210426180211.GP235567@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210426180211.GP235567@casper.infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Message-ID-Hash: GGMRMXTRKWPMGBKX45CUJ2FQEBCGT4CC
X-Message-ID-Hash: GGMRMXTRKWPMGBKX45CUJ2FQEBCGT4CC
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, virtio-fs@redhat.com, miklos@szeredi.hu, jack@suse.cz, slp@redhat.com, groug@kaod.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GGMRMXTRKWPMGBKX45CUJ2FQEBCGT4CC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Apr 26, 2021 at 07:02:11PM +0100, Matthew Wilcox wrote:
> On Mon, Apr 26, 2021 at 01:52:17PM -0400, Vivek Goyal wrote:
> > On Mon, Apr 26, 2021 at 02:46:32PM +0100, Matthew Wilcox wrote:
> > > On Fri, Apr 23, 2021 at 09:07:21AM -0400, Vivek Goyal wrote:
> > > > +enum dax_wake_mode {
> > > > +	WAKE_NEXT,
> > > > +	WAKE_ALL,
> > > > +};
> > > 
> > > Why define them in this order when ...
> > > 
> > > > @@ -196,7 +207,7 @@ static void dax_wake_entry(struct xa_state *xas, void *entry, bool wake_all)
> > > >  	 * must be in the waitqueue and the following check will see them.
> > > >  	 */
> > > >  	if (waitqueue_active(wq))
> > > > -		__wake_up(wq, TASK_NORMAL, wake_all ? 0 : 1, &key);
> > > > +		__wake_up(wq, TASK_NORMAL, mode == WAKE_ALL ? 0 : 1, &key);
> > > 
> > > ... they're used like this?  This is almost as bad as
> > > 
> > > enum bool {
> > > 	true,
> > > 	false,
> > > };
> > 
> > Hi Matthew,
> > 
> > So you prefer that I should switch order of WAKE_NEXT and WAKE_ALL? 
> > 
> > enum dax_wake_mode {
> > 	WAKE_ALL,
> > 	WAKE_NEXT,
> > };
> 
> That, yes.
> 
> > And then do following to wake task.
> > 
> > if (waitqueue_active(wq))
> > 	__wake_up(wq, TASK_NORMAL, mode, &key);
> 
> No, the third argument to __wake_up() is a count, not an enum.  It just so
> happens that '0' means 'all' and we only ever wake up 1 and not, say, 5.
> So the logical way to define the enum is ALL, NEXT which _just happens
> to match_ the usage of __wake_up().

Ok, In that case, I will retain existing code.

__wake_up(wq, TASK_NORMAL, mode == WAKE_ALL ? 0 : 1, &key);

Vivek
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 864DA36713E
	for <lists+linux-nvdimm@lfdr.de>; Wed, 21 Apr 2021 19:21:50 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B4322100EAB4D;
	Wed, 21 Apr 2021 10:21:48 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B0D2F100EAB4C
	for <linux-nvdimm@lists.01.org>; Wed, 21 Apr 2021 10:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619025703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6JUDsCX1FVLABG3f9acRCoDqQKripe/7UMrZ2uGWSs8=;
	b=Hi8rKQXr4ts6/Q15ars3r68NufLB/eHSMauqQ5d8NfVJyxYu9/Sd3X8Wy8xsLA2hphpqA3
	3Z8A8UxLYPf/2oD2CpemW1C1XQJz+wKNp50befqsnhe+Yy6oYDwbWamkm3f3pNqXkPLOaG
	WBTnsZUreH0sEwxbeS8AYTHmvy3OIMU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-601-faPE_qS1MgukzwLIDB8nzA-1; Wed, 21 Apr 2021 13:21:39 -0400
X-MC-Unique: faPE_qS1MgukzwLIDB8nzA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D630E107ACC7;
	Wed, 21 Apr 2021 17:21:37 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-206.rdu2.redhat.com [10.10.114.206])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F165519D80;
	Wed, 21 Apr 2021 17:21:30 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 6EB69220BCF; Wed, 21 Apr 2021 13:21:30 -0400 (EDT)
Date: Wed, 21 Apr 2021 13:21:30 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 1/3] dax: Add an enum for specifying dax wakup mode
Message-ID: <20210421172130.GE1579961@redhat.com>
References: <20210419213636.1514816-1-vgoyal@redhat.com>
 <20210419213636.1514816-2-vgoyal@redhat.com>
 <20210421092440.GM8706@quack2.suse.cz>
 <20210421155631.GC1579961@redhat.com>
 <20210421161624.GJ3596236@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210421161624.GJ3596236@casper.infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Message-ID-Hash: 5TNNLWRWNFWV3OYOCAMT6XJBOM7DQCY7
X-Message-ID-Hash: 5TNNLWRWNFWV3OYOCAMT6XJBOM7DQCY7
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com, slp@redhat.com, miklos@szeredi.hu, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5TNNLWRWNFWV3OYOCAMT6XJBOM7DQCY7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Apr 21, 2021 at 05:16:24PM +0100, Matthew Wilcox wrote:
> On Wed, Apr 21, 2021 at 11:56:31AM -0400, Vivek Goyal wrote:
> > +/**
> > + * enum dax_entry_wake_mode: waitqueue wakeup toggle
> 
> s/toggle/behaviour/ ?

Will do.

> 
> > + * @WAKE_NEXT: wake only the first waiter in the waitqueue
> > + * @WAKE_ALL: wake all waiters in the waitqueue
> > + */
> > +enum dax_entry_wake_mode {
> > +	WAKE_NEXT,
> > +	WAKE_ALL,
> > +};
> > +
> >  static wait_queue_head_t *dax_entry_waitqueue(struct xa_state *xas,
> >  		void *entry, struct exceptional_entry_key *key)
> >  {
> > @@ -182,7 +192,8 @@ static int wake_exceptional_entry_func(w
> >   * The important information it's conveying is whether the entry at
> >   * this index used to be a PMD entry.
> >   */
> > -static void dax_wake_entry(struct xa_state *xas, void *entry, bool wake_all)
> > +static void dax_wake_entry(struct xa_state *xas, void *entry,
> > +			   enum dax_entry_wake_mode mode)
> 
> It's an awfully verbose name.  'dax_wake_mode'?

Sure. Will change.

Vivek
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

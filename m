Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A67636B87F
	for <lists+linux-nvdimm@lfdr.de>; Mon, 26 Apr 2021 20:02:35 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 62727100EBBA2;
	Mon, 26 Apr 2021 11:02:33 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BC312100ED497
	for <linux-nvdimm@lists.01.org>; Mon, 26 Apr 2021 11:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PWkah+fwPe33ZZcVqLDlcUWqo58D207f7qzlEj7nZwY=; b=GCyXjZT/CpYO/4ULivAxhOfL2e
	t0+fXiuhp77Toc2bpsmMyGA5pKlvXqdOCQ6BY6f9QcP7f02vrnAGfLg/qTL3PqwbxefsOH5XwkviN
	NGsMJi1ldPNllb+6J6c3TQhT0VsyOM8pqoJ6n4WgGNpxLiF05zsb2N7BNR5LSpzTiwLzL4L+2XP8j
	szX8OM40R/GksXzf/AZUIdGzO6iVgiyvWY+IEYZpWbUVY8OmfA+xG7HSQof2Yn3OokpD+UCJpUbei
	eOAVq+Twf6Xf8U2cVBFX3h4rvP1hzJixGETipmVcMHFX16aMbfe3yMQgr5SHicD71ImR99HvawHwx
	2YsP+Oag==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
	id 1lb5Yh-005wFT-Uj; Mon, 26 Apr 2021 18:02:15 +0000
Date: Mon, 26 Apr 2021 19:02:11 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v4 1/3] dax: Add an enum for specifying dax wakup mode
Message-ID: <20210426180211.GP235567@casper.infradead.org>
References: <20210423130723.1673919-1-vgoyal@redhat.com>
 <20210423130723.1673919-2-vgoyal@redhat.com>
 <20210426134632.GM235567@casper.infradead.org>
 <20210426175217.GD1741690@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210426175217.GD1741690@redhat.com>
Message-ID-Hash: J3JBGVY3TJM6WVMETE6KNL2USC7RVDGC
X-Message-ID-Hash: J3JBGVY3TJM6WVMETE6KNL2USC7RVDGC
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, virtio-fs@redhat.com, miklos@szeredi.hu, jack@suse.cz, slp@redhat.com, groug@kaod.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/J3JBGVY3TJM6WVMETE6KNL2USC7RVDGC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Apr 26, 2021 at 01:52:17PM -0400, Vivek Goyal wrote:
> On Mon, Apr 26, 2021 at 02:46:32PM +0100, Matthew Wilcox wrote:
> > On Fri, Apr 23, 2021 at 09:07:21AM -0400, Vivek Goyal wrote:
> > > +enum dax_wake_mode {
> > > +	WAKE_NEXT,
> > > +	WAKE_ALL,
> > > +};
> > 
> > Why define them in this order when ...
> > 
> > > @@ -196,7 +207,7 @@ static void dax_wake_entry(struct xa_state *xas, void *entry, bool wake_all)
> > >  	 * must be in the waitqueue and the following check will see them.
> > >  	 */
> > >  	if (waitqueue_active(wq))
> > > -		__wake_up(wq, TASK_NORMAL, wake_all ? 0 : 1, &key);
> > > +		__wake_up(wq, TASK_NORMAL, mode == WAKE_ALL ? 0 : 1, &key);
> > 
> > ... they're used like this?  This is almost as bad as
> > 
> > enum bool {
> > 	true,
> > 	false,
> > };
> 
> Hi Matthew,
> 
> So you prefer that I should switch order of WAKE_NEXT and WAKE_ALL? 
> 
> enum dax_wake_mode {
> 	WAKE_ALL,
> 	WAKE_NEXT,
> };

That, yes.

> And then do following to wake task.
> 
> if (waitqueue_active(wq))
> 	__wake_up(wq, TASK_NORMAL, mode, &key);

No, the third argument to __wake_up() is a count, not an enum.  It just so
happens that '0' means 'all' and we only ever wake up 1 and not, say, 5.
So the logical way to define the enum is ALL, NEXT which _just happens
to match_ the usage of __wake_up().
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

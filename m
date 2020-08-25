Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEB72518B8
	for <lists+linux-nvdimm@lfdr.de>; Tue, 25 Aug 2020 14:40:37 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 94D23124DA735;
	Tue, 25 Aug 2020 05:40:35 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1AEA2124DA70B
	for <linux-nvdimm@lists.01.org>; Tue, 25 Aug 2020 05:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tw5dcUYU1cuOf4FiFUQPG5KaP/PO9JilKtZRxZg/G8g=; b=ojprYWBY613BEb+StdJ0sxAyYt
	xMBg5qD1i74X/rjfNcU3gB4uY9pUinU2iATgkX0wej7DwChopPzimexI44FgtHomC+/S2vxY5Sep8
	T7rDlQiBkUFG9SX5ljMSX0SpUSTlLEBqhL3QIxD5RlFAvxm8bQWfYs7rXEjhBcKobos3I50NoqAYZ
	/hDcxtVuham4kEwH1msCu8TAeXpk2xEEiIW/LsnJa3WUcQsN1LCiVfCM+UAw8iHdMp0DV++omjnsU
	hnS4vi39EcNhowoNyU1vySJ2NofttZbo8aNEma3HQlamiZN6quSfpYv+kZjnoYeP27AKSMYQFyODi
	adgr5+fw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kAYFU-0004As-Sf; Tue, 25 Aug 2020 12:40:24 +0000
Date: Tue, 25 Aug 2020 13:40:24 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 9/9] iomap: Change calling convention for zeroing
Message-ID: <20200825124024.GN17456@casper.infradead.org>
References: <20200824145511.10500-1-willy@infradead.org>
 <20200824145511.10500-10-willy@infradead.org>
 <20200825002735.GI12131@dread.disaster.area>
 <20200825032603.GL17456@casper.infradead.org>
 <E47B2C68-43F2-496F-AA91-A83EB3D91F28@dilger.ca>
 <20200825042711.GL12131@dread.disaster.area>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200825042711.GL12131@dread.disaster.area>
Message-ID-Hash: JUCOH4KOJKG4PLQSLIF7H754LNNJ4IYM
X-Message-ID-Hash: JUCOH4KOJKG4PLQSLIF7H754LNNJ4IYM
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andreas Dilger <adilger@dilger.ca>, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <darrick.wong@oracle.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JUCOH4KOJKG4PLQSLIF7H754LNNJ4IYM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Aug 25, 2020 at 02:27:11PM +1000, Dave Chinner wrote:
> On Mon, Aug 24, 2020 at 09:35:59PM -0600, Andreas Dilger wrote:
> > On Aug 24, 2020, at 9:26 PM, Matthew Wilcox <willy@infradead.org> wrote:
> > > 
> > > On Tue, Aug 25, 2020 at 10:27:35AM +1000, Dave Chinner wrote:
> > >>> 	do {
> > >>> -		unsigned offset, bytes;
> > >>> -
> > >>> -		offset = offset_in_page(pos);
> > >>> -		bytes = min_t(loff_t, PAGE_SIZE - offset, count);
> > >>> +		loff_t bytes;
> > >>> 
> > >>> 		if (IS_DAX(inode))
> > >>> -			status = dax_iomap_zero(pos, offset, bytes, iomap);
> > >>> +			bytes = dax_iomap_zero(pos, length, iomap);
> > >> 
> > >> Hmmm. everything is loff_t here, but the callers are defining length
> > >> as u64, not loff_t. Is there a potential sign conversion problem
> > >> here? (sure 64 bit is way beyond anything we'll pass here, but...)
> > > 
> > > I've gone back and forth on the correct type for 'length' a few times.
> > > size_t is too small (not for zeroing, but for seek()).  An unsigned type
> > > seems right -- a length can't be negative, and we don't want to give
> > > the impression that it can.  But the return value from these functions
> > > definitely needs to be signed so we can represent an error.  So a u64
> > > length with an loff_t return type feels like the best solution.  And
> > > the upper layers have to promise not to pass in a length that's more
> > > than 2^63-1.
> > 
> > The problem with allowing a u64 as the length is that it leads to the
> > possibility of an argument value that cannot be returned.  Checking
> > length < 0 is not worse than checking length > 0x7ffffffffffffff,
> > and has the benefit of consistency with the other argument types and
> > signs...

The callee should just trust that the caller isn't going to do that.
File sizes can't be more than 2^63-1 bytes, so an extent of a file also
can't be more than 2^63-1 bytes.

> I think the problem here is that we have no guaranteed 64 bit size
> type. when that was the case with off_t, we created loff_t to always
> represent a 64 bit offset value. However, we never created one for
> the count/size that is passed alongside loff_t in many places - it
> was said that "syscalls are limited to 32 bit sizes" and
> "size_t is 64 bit on 64 bit platforms" and so on and so we still
> don't have a clean way to pass 64 bit sizes through the IO path.
> 
> We've been living with this shitty situation for a long time now, so
> perhaps it's time for us to define lsize_t for 64 bit lengths and
> start using that everywhere that needs a 64 bit clean path
> through the code, regardless of whether the arch is 32 or 64 bit...
> 
> Thoughts?

I don't think the THP patches should be blocked on this expedition.

We have a guaranteed 64 bit type -- it's u64.  I don't think defining
lsize_t is going to fix anything.  The next big problem to fix will be
supporting storage >16EiB, but I think that's a project that can start
in ten years and still be here before anyone but the TLAs have that much
storage in a single device.

Any objection to leaving this patch as-is with a u64 length?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

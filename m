Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B233250E4C
	for <lists+linux-nvdimm@lfdr.de>; Tue, 25 Aug 2020 03:36:56 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A779F135A9B0F;
	Mon, 24 Aug 2020 18:36:51 -0700 (PDT)
Received-SPF: Pass (helo) identity=helo; client-ip=211.29.132.42; helo=mail106.syd.optusnet.com.au; envelope-from=david@fromorbit.com; receiver=<UNKNOWN> 
Received: from mail106.syd.optusnet.com.au (mail106.syd.optusnet.com.au [211.29.132.42])
	by ml01.01.org (Postfix) with ESMTP id C753C1307C9E0
	for <linux-nvdimm@lists.01.org>; Mon, 24 Aug 2020 18:33:55 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-146-199.pa.nsw.optusnet.com.au [49.181.146.199])
	by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id D5B366AD1D6;
	Tue, 25 Aug 2020 11:33:52 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
	(envelope-from <david@fromorbit.com>)
	id 1kANqR-0005wh-1B; Tue, 25 Aug 2020 11:33:51 +1000
Date: Tue, 25 Aug 2020 11:33:51 +1000
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 8/9] iomap: Convert iomap_write_end types
Message-ID: <20200825013351.GK12131@dread.disaster.area>
References: <20200824145511.10500-1-willy@infradead.org>
 <20200824145511.10500-9-willy@infradead.org>
 <20200825001223.GH12131@dread.disaster.area>
 <20200825010605.GJ17456@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200825010605.GJ17456@casper.infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LPwYv6e9 c=1 sm=1 tr=0 cx=a_idp_d
	a=GorAHYkI+xOargNMzM6qxQ==:117 a=GorAHYkI+xOargNMzM6qxQ==:17
	a=kj9zAlcOel0A:10 a=y4yBn9ojGxQA:10 a=7-415B0cAAAA:8
	a=lR8mz5mIW4tkD5AzabkA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Message-ID-Hash: 2RPGKXCWYLN742S45LZGOG5S733KM6GO
X-Message-ID-Hash: 2RPGKXCWYLN742S45LZGOG5S733KM6GO
X-MailFrom: david@fromorbit.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <darrick.wong@oracle.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2RPGKXCWYLN742S45LZGOG5S733KM6GO/>
List-Archive: <>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Aug 25, 2020 at 02:06:05AM +0100, Matthew Wilcox wrote:
> On Tue, Aug 25, 2020 at 10:12:23AM +1000, Dave Chinner wrote:
> > > -static int
> > > -__iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
> > > -		unsigned copied, struct page *page)
> > > +static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
> > > +		size_t copied, struct page *page)
> > >  {
> > 
> > Please leave the function declarations formatted the same way as
> > they currently are. They are done that way intentionally so it is
> > easy to grep for function definitions. Not to mention is't much
> > easier to read than when the function name is commingled into the
> > multiline paramener list like...
> 
> I understand that's true for XFS, but it's not true throughout the
> rest of the kernel. 

What other code does is irrelevant. I'm trying to maintain and
improve the consistency of the format used for the fs/iomap code.

> This file isn't even consistent:
> 
> buffered-io.c:static inline struct iomap_page *to_iomap_page(struct page *page)
> buffered-io.c:static inline bool iomap_block_needs_zeroing(struct inode
> buffered-io.c:static int iomap_zero(struct inode *inode, loff_t pos, unsigned offset,
> buffered-io.c:static void iomap_writepage_end_bio(struct bio *bio)
> buffered-io.c:static int __init iomap_init(void)
> 
> (i just grepped for ^static so there're other functions not covered by this)

5 functions that have that format, compared to 45 that do have the
formatting I asked you to retain. It think it's pretty clear which
way consistency lies here...

> The other fs/iomap/ files are equally inconsistent.

Inconsistency always occurs when multiple people modify the same
code. Often that's simply because reviewers haven't noticed the
inconsistency - it's certainly not intentional.

Saying "No, I'm going to make the code less consistent because it's
already slightly inconsistent" is, IMO, not a valid response to a
review request to conform to the existing code layout in that file,
especially if it improves the consistency of the code being
modified. That's really not negotiable....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

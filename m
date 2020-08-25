Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDADB250E11
	for <lists+linux-nvdimm@lfdr.de>; Tue, 25 Aug 2020 03:06:29 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CD0AF136F07B6;
	Mon, 24 Aug 2020 18:06:28 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6D312136F07B4
	for <linux-nvdimm@lists.01.org>; Mon, 24 Aug 2020 18:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xzdunZmDdu/tuWxDqIrXIq5mvQShEvSrh2WBDyB9JHs=; b=Gw+T08pM8yf5l2lRbR+PV/GPw3
	a6J9xQN1X7CiVASDZBWQD8ZppaZXqkQmDbsY581gBBycjBYuteqT7aX3oPt0ssNMy+zftlITNbp+P
	ITlxwxxr9UGu+F9v2lAfvo5b2ObAkB3iIZ22h+r8F0dwJMaHQWi6kxy9YTjhtbUxsaLVjVgklnglb
	NELmocqxLdHU+OcFcUVu4XvPPRjS0TB3CcOWM0qqvDwxP4nQ5RsHj5EQAxVxyD+Ows1Y9RwbcphjD
	ZijhXNt5TQr9INGaJI6KBsKOO5ZSsAzSWygUjx7nkf06fpYBpEAViN0kTIPfg3jlRVePv7iGpfItQ
	31Y9Ay2Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kANPZ-00088W-KT; Tue, 25 Aug 2020 01:06:05 +0000
Date: Tue, 25 Aug 2020 02:06:05 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 8/9] iomap: Convert iomap_write_end types
Message-ID: <20200825010605.GJ17456@casper.infradead.org>
References: <20200824145511.10500-1-willy@infradead.org>
 <20200824145511.10500-9-willy@infradead.org>
 <20200825001223.GH12131@dread.disaster.area>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200825001223.GH12131@dread.disaster.area>
Message-ID-Hash: PLFYE5OIWUWPNCEFHWYUQHVGUCPB35Y3
X-Message-ID-Hash: PLFYE5OIWUWPNCEFHWYUQHVGUCPB35Y3
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <darrick.wong@oracle.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PLFYE5OIWUWPNCEFHWYUQHVGUCPB35Y3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Aug 25, 2020 at 10:12:23AM +1000, Dave Chinner wrote:
> > -static int
> > -__iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
> > -		unsigned copied, struct page *page)
> > +static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
> > +		size_t copied, struct page *page)
> >  {
> 
> Please leave the function declarations formatted the same way as
> they currently are. They are done that way intentionally so it is
> easy to grep for function definitions. Not to mention is't much
> easier to read than when the function name is commingled into the
> multiline paramener list like...

I understand that's true for XFS, but it's not true throughout the
rest of the kernel.  This file isn't even consistent:

buffered-io.c:static inline struct iomap_page *to_iomap_page(struct page *page)
buffered-io.c:static inline bool iomap_block_needs_zeroing(struct inode
buffered-io.c:static int iomap_zero(struct inode *inode, loff_t pos, unsigned offset,
buffered-io.c:static void iomap_writepage_end_bio(struct bio *bio)
buffered-io.c:static int __init iomap_init(void)

(i just grepped for ^static so there're other functions not covered by this)

The other fs/iomap/ files are equally inconsistent.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

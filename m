Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDEC250CC9
	for <lists+linux-nvdimm@lfdr.de>; Tue, 25 Aug 2020 02:12:31 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A10941307C9E0;
	Mon, 24 Aug 2020 17:12:30 -0700 (PDT)
Received-SPF: Pass (helo) identity=helo; client-ip=211.29.132.97; helo=mail110.syd.optusnet.com.au; envelope-from=david@fromorbit.com; receiver=<UNKNOWN> 
Received: from mail110.syd.optusnet.com.au (mail110.syd.optusnet.com.au [211.29.132.97])
	by ml01.01.org (Postfix) with ESMTP id C7E681307C9E0
	for <linux-nvdimm@lists.01.org>; Mon, 24 Aug 2020 17:12:27 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-146-199.pa.nsw.optusnet.com.au [49.181.146.199])
	by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id 9335D1091CA;
	Tue, 25 Aug 2020 10:12:23 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
	(envelope-from <david@fromorbit.com>)
	id 1kAMZb-0005kb-4O; Tue, 25 Aug 2020 10:12:23 +1000
Date: Tue, 25 Aug 2020 10:12:23 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH 8/9] iomap: Convert iomap_write_end types
Message-ID: <20200825001223.GH12131@dread.disaster.area>
References: <20200824145511.10500-1-willy@infradead.org>
 <20200824145511.10500-9-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200824145511.10500-9-willy@infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LPwYv6e9 c=1 sm=1 tr=0 cx=a_idp_d
	a=GorAHYkI+xOargNMzM6qxQ==:117 a=GorAHYkI+xOargNMzM6qxQ==:17
	a=kj9zAlcOel0A:10 a=y4yBn9ojGxQA:10 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8
	a=Jc2B04GcgJ8hC2UcC2sA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
	a=biEYGPWJfzWAr4FL6Ov7:22
Message-ID-Hash: 6GR2NXM7IUEYPNSU5FZZLSJ33D2RI7W7
X-Message-ID-Hash: 6GR2NXM7IUEYPNSU5FZZLSJ33D2RI7W7
X-MailFrom: david@fromorbit.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <darrick.wong@oracle.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6GR2NXM7IUEYPNSU5FZZLSJ33D2RI7W7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Aug 24, 2020 at 03:55:09PM +0100, Matthew Wilcox (Oracle) wrote:
> iomap_write_end cannot return an error, so switch it to return
> size_t instead of int and remove the error checking from the callers.
> Also convert the arguments to size_t from unsigned int, in case anyone
> ever wants to support a page size larger than 2GB.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/iomap/buffered-io.c | 31 ++++++++++++-------------------
>  1 file changed, 12 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 8c6187a6f34e..7f618ab4b11e 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -666,9 +666,8 @@ iomap_set_page_dirty(struct page *page)
>  }
>  EXPORT_SYMBOL_GPL(iomap_set_page_dirty);
>  
> -static int
> -__iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
> -		unsigned copied, struct page *page)
> +static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
> +		size_t copied, struct page *page)
>  {

Please leave the function declarations formatted the same way as
they currently are. They are done that way intentionally so it is
easy to grep for function definitions. Not to mention is't much
easier to read than when the function name is commingled into the
multiline paramener list like...

> -static int
> -iomap_write_end(struct inode *inode, loff_t pos, unsigned len, unsigned copied,
> -		struct page *page, struct iomap *iomap, struct iomap *srcmap)
> +/* Returns the number of bytes copied.  May be 0.  Cannot be an errno. */
> +static size_t iomap_write_end(struct inode *inode, loff_t pos, size_t len,
> +		size_t copied, struct page *page, struct iomap *iomap,
> +		struct iomap *srcmap)

... this.

Otherwise the code looks fine.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

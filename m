Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F01250CF2
	for <lists+linux-nvdimm@lfdr.de>; Tue, 25 Aug 2020 02:27:44 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DB47C136F07B5;
	Mon, 24 Aug 2020 17:27:42 -0700 (PDT)
Received-SPF: Pass (helo) identity=helo; client-ip=211.29.132.97; helo=mail110.syd.optusnet.com.au; envelope-from=david@fromorbit.com; receiver=<UNKNOWN> 
Received: from mail110.syd.optusnet.com.au (mail110.syd.optusnet.com.au [211.29.132.97])
	by ml01.01.org (Postfix) with ESMTP id CC3EF136F07B5
	for <linux-nvdimm@lists.01.org>; Mon, 24 Aug 2020 17:27:38 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-146-199.pa.nsw.optusnet.com.au [49.181.146.199])
	by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id A92681092F9;
	Tue, 25 Aug 2020 10:27:37 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
	(envelope-from <david@fromorbit.com>)
	id 1kAMoJ-0005mv-WC; Tue, 25 Aug 2020 10:27:36 +1000
Date: Tue, 25 Aug 2020 10:27:35 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH 9/9] iomap: Change calling convention for zeroing
Message-ID: <20200825002735.GI12131@dread.disaster.area>
References: <20200824145511.10500-1-willy@infradead.org>
 <20200824145511.10500-10-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200824145511.10500-10-willy@infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QIgWuTDL c=1 sm=1 tr=0 cx=a_idp_d
	a=GorAHYkI+xOargNMzM6qxQ==:117 a=GorAHYkI+xOargNMzM6qxQ==:17
	a=kj9zAlcOel0A:10 a=y4yBn9ojGxQA:10 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8
	a=Yagp9b6qcfzQHBwh10oA:9 a=afcYxvJ0ROV6oatP:21 a=wHxIqCD_xUrfLMnn:21
	a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=biEYGPWJfzWAr4FL6Ov7:22
Message-ID-Hash: ATYTOIATEBLJJGDL7PLEMGP7QLQ6NOGP
X-Message-ID-Hash: ATYTOIATEBLJJGDL7PLEMGP7QLQ6NOGP
X-MailFrom: david@fromorbit.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <darrick.wong@oracle.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ATYTOIATEBLJJGDL7PLEMGP7QLQ6NOGP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Aug 24, 2020 at 03:55:10PM +0100, Matthew Wilcox (Oracle) wrote:
> Pass the full length to iomap_zero() and dax_iomap_zero(), and have
> them return how many bytes they actually handled.  This is preparatory
> work for handling THP, although it looks like DAX could actually take
> advantage of it if there's a larger contiguous area.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/dax.c               | 13 ++++++-------
>  fs/iomap/buffered-io.c | 33 +++++++++++++++------------------
>  include/linux/dax.h    |  3 +--
>  3 files changed, 22 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 95341af1a966..f2b912cb034e 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1037,18 +1037,18 @@ static vm_fault_t dax_load_hole(struct xa_state *xas,
>  	return ret;
>  }
>  
> -int dax_iomap_zero(loff_t pos, unsigned offset, unsigned size,
> -		   struct iomap *iomap)
> +loff_t dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
>  {
>  	sector_t sector = iomap_sector(iomap, pos & PAGE_MASK);
>  	pgoff_t pgoff;
>  	long rc, id;
>  	void *kaddr;
>  	bool page_aligned = false;
> -
> +	unsigned offset = offset_in_page(pos);
> +	unsigned size = min_t(u64, PAGE_SIZE - offset, length);
>  
>  	if (IS_ALIGNED(sector << SECTOR_SHIFT, PAGE_SIZE) &&
> -	    IS_ALIGNED(size, PAGE_SIZE))
> +	    (size == PAGE_SIZE))
>  		page_aligned = true;
>  
>  	rc = bdev_dax_pgoff(iomap->bdev, sector, PAGE_SIZE, &pgoff);
> @@ -1058,8 +1058,7 @@ int dax_iomap_zero(loff_t pos, unsigned offset, unsigned size,
>  	id = dax_read_lock();
>  
>  	if (page_aligned)
> -		rc = dax_zero_page_range(iomap->dax_dev, pgoff,
> -					 size >> PAGE_SHIFT);
> +		rc = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
>  	else
>  		rc = dax_direct_access(iomap->dax_dev, pgoff, 1, &kaddr, NULL);
>  	if (rc < 0) {
> @@ -1072,7 +1071,7 @@ int dax_iomap_zero(loff_t pos, unsigned offset, unsigned size,
>  		dax_flush(iomap->dax_dev, kaddr + offset, size);
>  	}
>  	dax_read_unlock(id);
> -	return 0;
> +	return size;
>  }
>  
>  static loff_t
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 7f618ab4b11e..2dba054095e8 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -901,11 +901,13 @@ iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
>  }
>  EXPORT_SYMBOL_GPL(iomap_file_unshare);
>  
> -static int iomap_zero(struct inode *inode, loff_t pos, unsigned offset,
> -		unsigned bytes, struct iomap *iomap, struct iomap *srcmap)
> +static loff_t iomap_zero(struct inode *inode, loff_t pos, u64 length,
> +		struct iomap *iomap, struct iomap *srcmap)

While you are touching this, please convert it back to:

static loff_t
iomap_zero(struct inode *inode, loff_t pos, u64 length,
		struct iomap *iomap, struct iomap *srcmap)


>  {
>  	struct page *page;
>  	int status;
> +	unsigned offset = offset_in_page(pos);
> +	unsigned bytes = min_t(u64, PAGE_SIZE - offset, length);
>  
>  	status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap, srcmap);
>  	if (status)
> @@ -917,38 +919,33 @@ static int iomap_zero(struct inode *inode, loff_t pos, unsigned offset,
>  	return iomap_write_end(inode, pos, bytes, bytes, page, iomap, srcmap);
>  }
>  
> -static loff_t
> -iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
> -		void *data, struct iomap *iomap, struct iomap *srcmap)
> +static loff_t iomap_zero_range_actor(struct inode *inode, loff_t pos,
> +		loff_t length, void *data, struct iomap *iomap,
> +		struct iomap *srcmap)

And leave this as it was formatted.

/me missed this when iomap_readahead() was introduced, too.


>  {
>  	bool *did_zero = data;
>  	loff_t written = 0;
> -	int status;
>  
>  	/* already zeroed?  we're done. */
>  	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
> -		return count;
> +		return length;
>  
>  	do {
> -		unsigned offset, bytes;
> -
> -		offset = offset_in_page(pos);
> -		bytes = min_t(loff_t, PAGE_SIZE - offset, count);
> +		loff_t bytes;
>  
>  		if (IS_DAX(inode))
> -			status = dax_iomap_zero(pos, offset, bytes, iomap);
> +			bytes = dax_iomap_zero(pos, length, iomap);

Hmmm. everything is loff_t here, but the callers are defining length
as u64, not loff_t. Is there a potential sign conversion problem
here? (sure 64 bit is way beyond anything we'll pass here, but...)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

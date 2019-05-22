Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB618270A9
	for <lists+linux-nvdimm@lfdr.de>; Wed, 22 May 2019 22:14:55 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B453621260A63;
	Wed, 22 May 2019 13:14:53 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=rgoldwyn@suse.de;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 2551821255833
 for <linux-nvdimm@lists.01.org>; Wed, 22 May 2019 13:14:50 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 570F7AECB;
 Wed, 22 May 2019 20:14:49 +0000 (UTC)
Date: Wed, 22 May 2019 15:14:47 -0500
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH 04/18] dax: Introduce IOMAP_DAX_COW to CoW edges during
 writes
Message-ID: <20190522201446.tc4zbxdevjm5dofe@fiona>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
 <20190429172649.8288-5-rgoldwyn@suse.de>
 <20190521165158.GB5125@magnolia>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190521165158.GB5125@magnolia>
User-Agent: NeoMutt/20180716
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: kilobyte@angband.pl, jack@suse.cz, linux-nvdimm@lists.01.org,
 nborisov@suse.com, david@fromorbit.com, dsterba@suse.cz, willy@infradead.org,
 linux-fsdevel@vger.kernel.org, hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On  9:51 21/05, Darrick J. Wong wrote:
> On Mon, Apr 29, 2019 at 12:26:35PM -0500, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > The IOMAP_DAX_COW is a iomap type which performs copy of
> > edges of data while performing a write if start/end are
> > not page aligned. The source address is expected in
> > iomap->inline_data.
> > 
> > dax_copy_edges() is a helper functions performs a copy from
> > one part of the device to another for data not page aligned.
> > If iomap->inline_data is NULL, it memset's the area to zero.
> > 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > ---
> >  fs/dax.c              | 46 +++++++++++++++++++++++++++++++++++++++++++++-
> >  include/linux/iomap.h |  1 +
> >  2 files changed, 46 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/dax.c b/fs/dax.c
> > index e5e54da1715f..610bfa861a28 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -1084,6 +1084,42 @@ int __dax_zero_page_range(struct block_device *bdev,
> >  }
> >  EXPORT_SYMBOL_GPL(__dax_zero_page_range);
> >  
> > +/*
> > + * dax_copy_edges - Copies the part of the pages not included in
> > + * 		    the write, but required for CoW because
> > + * 		    offset/offset+length are not page aligned.
> > + */
> > +static int dax_copy_edges(struct inode *inode, loff_t pos, loff_t length,
> > +			   struct iomap *iomap, void *daddr)
> > +{
> > +	unsigned offset = pos & (PAGE_SIZE - 1);
> > +	loff_t end = pos + length;
> > +	loff_t pg_end = round_up(end, PAGE_SIZE);
> > +	void *saddr = iomap->inline_data;
> > +	int ret = 0;
> > +	/*
> > +	 * Copy the first part of the page
> > +	 * Note: we pass offset as length
> > +	 */
> > +	if (offset) {
> > +		if (saddr)
> > +			ret = memcpy_mcsafe(daddr, saddr, offset);
> > +		else
> > +			memset(daddr, 0, offset);
> > +	}
> > +
> > +	/* Copy the last part of the range */
> > +	if (end < pg_end) {
> > +		if (saddr)
> > +			ret = memcpy_mcsafe(daddr + offset + length,
> > +			       saddr + offset + length,	pg_end - end);
> > +		else
> > +			memset(daddr + offset + length, 0,
> > +					pg_end - end);
> > +	}
> > +	return ret;
> > +}
> > +
> >  static loff_t
> >  dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> >  		struct iomap *iomap)
> > @@ -1105,9 +1141,11 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> >  			return iov_iter_zero(min(length, end - pos), iter);
> >  	}
> >  
> > -	if (WARN_ON_ONCE(iomap->type != IOMAP_MAPPED))
> > +	if (WARN_ON_ONCE(iomap->type != IOMAP_MAPPED
> > +			 && iomap->type != IOMAP_DAX_COW))
> 
> I reiterate (from V3) that the && goes on the previous line...
> 
> 	if (WARN_ON_ONCE(iomap->type != IOMAP_MAPPED &&
> 			 iomap->type != IOMAP_DAX_COW))
> 
> >  		return -EIO;
> >  
> > +
> >  	/*
> >  	 * Write can allocate block for an area which has a hole page mapped
> >  	 * into page tables. We have to tear down these mappings so that data
> > @@ -1144,6 +1182,12 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> >  			break;
> >  		}
> >  
> > +		if (iomap->type == IOMAP_DAX_COW) {
> > +			ret = dax_copy_edges(inode, pos, length, iomap, kaddr);
> > +			if (ret)
> > +				break;
> > +		}
> > +
> >  		map_len = PFN_PHYS(map_len);
> >  		kaddr += offset;
> >  		map_len -= offset;
> > diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> > index 0fefb5455bda..6e885c5a38a3 100644
> > --- a/include/linux/iomap.h
> > +++ b/include/linux/iomap.h
> > @@ -25,6 +25,7 @@ struct vm_fault;
> >  #define IOMAP_MAPPED	0x03	/* blocks allocated at @addr */
> >  #define IOMAP_UNWRITTEN	0x04	/* blocks allocated at @addr in unwritten state */
> >  #define IOMAP_INLINE	0x05	/* data inline in the inode */
> 
> > +#define IOMAP_DAX_COW	0x06
> 
> DAX isn't going to be the only scenario where we need a way to
> communicate to iomap actors the need to implement copy on write.
> 
> XFS also uses struct iomap to hand out file leases to clients.  The
> lease code /currently/ doesn't support files with shared blocks (because
> the only user is pNFS) but one could easily imagine a future where some
> client wants to lease a file with shared blocks, in which case XFS will
> want to convey the COW details to the lessee.
> 
> > +/* Copy data pointed by inline_data before write*/
> 
> A month ago during the V3 patchset review, I wrote (possibly in an other
> thread, sorry) about something that I'm putting my foot down about now
> for the V4 patchset, which is the {re,ab}use of @inline_data for the
> data source address.

Looks like I missed this.
> 
> We cannot use @inline_data to convey the source address.  @inline_data
> (so far) is used to point to the in-memory representation of the storage
> described by @addr.  For data writes, @addr is the location of the write
> on disk and @inline_data is the location of the write in memory.
> 
> Reusing @inline_data here to point to the location of the source data in
> memory is a totally different thing and will likely result in confusion.
> On a practical level, this also means that we cannot support the case of
> COW && INLINE because the type codes collide and so would the users of
> @inline_data.  This isn't required *right now*, but if you had a pmem
> filesystem that stages inode updates in memory and flips a pointer to
> commit changes then the ->iomap_begin function will need to convey two
> pointers at once.
> 
> So this brings us back to Dave's suggestion during the V1 patchset
> review that instead of adding more iomap flags/types and overloading
> fields, we simply pass two struct iomaps into ->iomap_begin:

Actually, Dave is the one who suggested to perform it this way.
https://patchwork.kernel.org/comment/22562195/

> 
>  - Change iomap_apply() to "struct iomap iomap[2] = 0;" and pass
>    &iomap[0] into the ->iomap_begin and ->iomap_end functions.  The
>    first iomap will be filled in with the destination for the write (as
>    all implementations do now), and the second iomap can be filled in
>    with the source information for a COW operation.
> 
>  - If the ->iomap_begin implementation decides that COW is necessary for
>    the requested operation, then it should fill out that second iomap
>    with information about the extent that the actor must copied before
>    returning.  The second iomap's offset and length must match the
>    first.  If COW isn't necessary, the ->iomap_begin implementation
>    ignores it, and the second iomap retains type == 0 (i.e. invalid
>    mapping).
> 
> Proceeding along these lines will (AFAICT) still allow you to enable all
> the btrfs functionality in the rest of this patchset while making the
> task of wiring up XFS fairly simple.  No overloaded fields and no new
> flags.
> 
> This is how I'd like to see this patchset should proceed to V5.  Does
> that make sense?


Yes, I think this would be a more flexible design as well if we ever
decide to extend it beyond dax.
We would still need a IOMAP_COW type set in iomap[0].

-- 
Goldwyn
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

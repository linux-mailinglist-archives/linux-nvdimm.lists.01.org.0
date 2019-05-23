Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7139127C76
	for <lists+linux-nvdimm@lfdr.de>; Thu, 23 May 2019 14:10:13 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6FD4C2127677B;
	Thu, 23 May 2019 05:10:11 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=jack@suse.cz;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6585021276775
 for <linux-nvdimm@lists.01.org>; Thu, 23 May 2019 05:10:10 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id C9B79AF3E;
 Thu, 23 May 2019 12:10:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
 id 62FA31E3C4B; Thu, 23 May 2019 14:10:08 +0200 (CEST)
Date: Thu, 23 May 2019 14:10:08 +0200
From: Jan Kara <jack@suse.cz>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH 08/18] dax: memcpy page in case of IOMAP_DAX_COW for mmap
 faults
Message-ID: <20190523121008.GA2949@quack2.suse.cz>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
 <20190429172649.8288-9-rgoldwyn@suse.de>
 <20190521174625.GF5125@magnolia>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190521174625.GF5125@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
 nborisov@suse.com, Goldwyn Rodrigues <rgoldwyn@suse.de>, david@fromorbit.com,
 dsterba@suse.cz, willy@infradead.org, Goldwyn Rodrigues <rgoldwyn@suse.com>,
 linux-fsdevel@vger.kernel.org, hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue 21-05-19 10:46:25, Darrick J. Wong wrote:
> On Mon, Apr 29, 2019 at 12:26:39PM -0500, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > Change dax_iomap_pfn to return the address as well in order to
> > use it for performing a memcpy in case the type is IOMAP_DAX_COW.
> > We don't handle PMD because btrfs does not support hugepages.
> > 
> > Question:
> > The sequence of bdev_dax_pgoff() and dax_direct_access() is
> > used multiple times to calculate address and pfn's. Would it make
> > sense to call it while calculating address as well to reduce code?
> > 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > ---
> >  fs/dax.c | 19 +++++++++++++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/dax.c b/fs/dax.c
> > index 610bfa861a28..718b1632a39d 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -984,7 +984,7 @@ static sector_t dax_iomap_sector(struct iomap *iomap, loff_t pos)
> >  }
> >  
> >  static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
> > -			 pfn_t *pfnp)
> > +			 pfn_t *pfnp, void **addr)
> >  {
> >  	const sector_t sector = dax_iomap_sector(iomap, pos);
> >  	pgoff_t pgoff;
> > @@ -996,7 +996,7 @@ static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
> >  		return rc;
> >  	id = dax_read_lock();
> >  	length = dax_direct_access(iomap->dax_dev, pgoff, PHYS_PFN(size),
> > -				   NULL, pfnp);
> > +				   addr, pfnp);
> >  	if (length < 0) {
> >  		rc = length;
> >  		goto out;
> > @@ -1286,6 +1286,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
> >  	XA_STATE(xas, &mapping->i_pages, vmf->pgoff);
> >  	struct inode *inode = mapping->host;
> >  	unsigned long vaddr = vmf->address;
> > +	void *addr;
> >  	loff_t pos = (loff_t)vmf->pgoff << PAGE_SHIFT;
> >  	struct iomap iomap = { 0 };
> 
> Ugh, I had forgotten that fs/dax.c open-codes iomap_apply, probably
> because the actor returns vm_fault_t, not bytes copied.  I guess that
> makes it a tiny bit more complicated to pass in two (struct iomap *) to
> the iomap_begin function...

Hum, right. We could actually reimplement dax_iomap_{pte|pmd}_fault() using
iomap_apply(). We would just need to propagate error code out of our
'actor' inside the structure pointed to by 'data'. But that's doable.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

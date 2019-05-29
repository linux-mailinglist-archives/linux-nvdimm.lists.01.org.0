Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E6F2D3F9
	for <lists+linux-nvdimm@lfdr.de>; Wed, 29 May 2019 04:48:02 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B88812128DD32;
	Tue, 28 May 2019 19:48:00 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=211.29.132.249;
 helo=mail105.syd.optusnet.com.au; envelope-from=david@fromorbit.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au
 [211.29.132.249])
 by ml01.01.org (Postfix) with ESMTP id F311E2128D88C
 for <linux-nvdimm@lists.01.org>; Tue, 28 May 2019 19:47:56 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-144-61.pa.nsw.optusnet.com.au
 [49.180.144.61])
 by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id BC575D1A1;
 Wed, 29 May 2019 12:47:51 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
 (envelope-from <david@fromorbit.com>)
 id 1hVod3-0000Tb-MZ; Wed, 29 May 2019 12:47:49 +1000
Date: Wed, 29 May 2019 12:47:49 +1000
From: Dave Chinner <david@fromorbit.com>
To: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Subject: Re: [PATCH 04/18] dax: Introduce IOMAP_DAX_COW to CoW edges during
 writes
Message-ID: <20190529024749.GC16786@dread.disaster.area>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
 <20190429172649.8288-5-rgoldwyn@suse.de>
 <20190521165158.GB5125@magnolia>
 <1e9951c1-d320-e480-3130-dc1f4b81ef2c@cn.fujitsu.com>
 <20190523115109.2o4txdjq2ft7fzzc@fiona>
 <1620c513-4ce2-84b0-33dc-2675246183ea@cn.fujitsu.com>
 <20190528091729.GD9607@quack2.suse.cz>
 <a3a919e6-ecad-bdf6-423c-fc01f9cfa661@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a3a919e6-ecad-bdf6-423c-fc01f9cfa661@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0 cx=a_idp_d
 a=8RU0RCro9O0HS2ezTvitPg==:117 a=8RU0RCro9O0HS2ezTvitPg==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=E5NmQfObTbMA:10
 a=7-415B0cAAAA:8 a=XyvwrCn6JVpaNVbEGqAA:9 a=vEUpTPDqILtuVklf:21
 a=ZaHK-JVdKnvBLsfL:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
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
Cc: kilobyte@angband.pl, Jan Kara <jack@suse.cz>,
 "Darrick J. Wong" <darrick.wong@oracle.com>, nborisov@suse.com,
 Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-nvdimm@lists.01.org,
 dsterba@suse.cz, willy@infradead.org, linux-fsdevel@vger.kernel.org,
 hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, May 29, 2019 at 10:01:58AM +0800, Shiyang Ruan wrote:
> 
> On 5/28/19 5:17 PM, Jan Kara wrote:
> > On Mon 27-05-19 16:25:41, Shiyang Ruan wrote:
> > > On 5/23/19 7:51 PM, Goldwyn Rodrigues wrote:
> > > > > 
> > > > > Hi,
> > > > > 
> > > > > I'm working on reflink & dax in XFS, here are some thoughts on this:
> > > > > 
> > > > > As mentioned above: the second iomap's offset and length must match the
> > > > > first.  I thought so at the beginning, but later found that the only
> > > > > difference between these two iomaps is @addr.  So, what about adding a
> > > > > @saddr, which means the source address of COW extent, into the struct iomap.
> > > > > The ->iomap_begin() fills @saddr if the extent is COW, and 0 if not.  Then
> > > > > handle this @saddr in each ->actor().  No more modifications in other
> > > > > functions.
> > > > 
> > > > Yes, I started of with the exact idea before being recommended this by Dave.
> > > > I used two fields instead of one namely cow_pos and cow_addr which defined
> > > > the source details. I had put it as a iomap flag as opposed to a type
> > > > which of course did not appeal well.
> > > > 
> > > > We may want to use iomaps for cases where two inodes are involved.
> > > > An example of the other scenario where offset may be different is file
> > > > comparison for dedup: vfs_dedup_file_range_compare(). However, it would
> > > > need two inodes in iomap as well.
> > > > 
> > > Yes, it is reasonable.  Thanks for your explanation.
> > > 
> > > One more thing RFC:
> > > I'd like to add an end-io callback argument in ->dax_iomap_actor() to update
> > > the metadata after one whole COW operation is completed.  The end-io can
> > > also be called in ->iomap_end().  But one COW operation may call
> > > ->iomap_apply() many times, and so does the end-io.  Thus, I think it would
> > > be nice to move it to the bottom of ->dax_iomap_actor(), called just once in
> > > each COW operation.
> > 
> > I'm sorry but I don't follow what you suggest. One COW operation is a call
> > to dax_iomap_rw(), isn't it? That may call iomap_apply() several times,
> > each invocation calls ->iomap_begin(), ->actor() (dax_iomap_actor()),
> > ->iomap_end() once. So I don't see a difference between doing something in
> > ->actor() and ->iomap_end() (besides the passed arguments but that does not
> > seem to be your concern). So what do you exactly want to do?
> 
> Hi Jan,
> 
> Thanks for pointing out, and I'm sorry for my mistake.  It's
> ->dax_iomap_rw(), not ->dax_iomap_actor().
> 
> I want to call the callback function at the end of ->dax_iomap_rw().
> 
> Like this:
> dax_iomap_rw(..., callback) {
> 
>     ...
>     while (...) {
>         iomap_apply(...);
>     }
> 
>     if (callback != null) {
>         callback();
>     }
>     return ...;
> }

Why does this need to be in dax_iomap_rw()?

We already do post-dax_iomap_rw() "io-end callbacks" directly in
xfs_file_dax_write() to update the file size....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

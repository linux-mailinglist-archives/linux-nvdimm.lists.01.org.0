Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EA427447
	for <lists+linux-nvdimm@lfdr.de>; Thu, 23 May 2019 04:10:30 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CEB442126D83F;
	Wed, 22 May 2019 19:10:27 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=211.29.132.249;
 helo=mail105.syd.optusnet.com.au; envelope-from=david@fromorbit.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au
 [211.29.132.249])
 by ml01.01.org (Postfix) with ESMTP id 5B35B2120ADD6
 for <linux-nvdimm@lists.01.org>; Wed, 22 May 2019 19:10:25 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-144-61.pa.nsw.optusnet.com.au
 [49.180.144.61])
 by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 94661105FF11;
 Thu, 23 May 2019 12:10:18 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
 (envelope-from <david@fromorbit.com>)
 id 1hTdBR-0005cL-FL; Thu, 23 May 2019 12:10:17 +1000
Date: Thu, 23 May 2019 12:10:17 +1000
From: Dave Chinner <david@fromorbit.com>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Subject: Re: [PATCH 04/18] dax: Introduce IOMAP_DAX_COW to CoW edges during
 writes
Message-ID: <20190523021017.GA16786@dread.disaster.area>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
 <20190429172649.8288-5-rgoldwyn@suse.de>
 <20190521165158.GB5125@magnolia>
 <20190522201446.tc4zbxdevjm5dofe@fiona>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190522201446.tc4zbxdevjm5dofe@fiona>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0 cx=a_idp_d
 a=8RU0RCro9O0HS2ezTvitPg==:117 a=8RU0RCro9O0HS2ezTvitPg==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=E5NmQfObTbMA:10
 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8 a=PiLuJtFBGQ_lXzUGpukA:9
 a=CjuIK1q_8ugA:10 a=igBNqPyMv6gA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=biEYGPWJfzWAr4FL6Ov7:22
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
Cc: kilobyte@angband.pl, jack@suse.cz,
 "Darrick J. Wong" <darrick.wong@oracle.com>, nborisov@suse.com,
 linux-nvdimm@lists.01.org, dsterba@suse.cz, willy@infradead.org,
 linux-fsdevel@vger.kernel.org, hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, May 22, 2019 at 03:14:47PM -0500, Goldwyn Rodrigues wrote:
> On  9:51 21/05, Darrick J. Wong wrote:
> > On Mon, Apr 29, 2019 at 12:26:35PM -0500, Goldwyn Rodrigues wrote:
> > We cannot use @inline_data to convey the source address.  @inline_data
> > (so far) is used to point to the in-memory representation of the storage
> > described by @addr.  For data writes, @addr is the location of the write
> > on disk and @inline_data is the location of the write in memory.
> > 
> > Reusing @inline_data here to point to the location of the source data in
> > memory is a totally different thing and will likely result in confusion.
> > On a practical level, this also means that we cannot support the case of
> > COW && INLINE because the type codes collide and so would the users of
> > @inline_data.  This isn't required *right now*, but if you had a pmem
> > filesystem that stages inode updates in memory and flips a pointer to
> > commit changes then the ->iomap_begin function will need to convey two
> > pointers at once.
> > 
> > So this brings us back to Dave's suggestion during the V1 patchset
> > review that instead of adding more iomap flags/types and overloading
> > fields, we simply pass two struct iomaps into ->iomap_begin:
> 
> Actually, Dave is the one who suggested to perform it this way.
> https://patchwork.kernel.org/comment/22562195/

My first suggestion was to use two iomaps. This suggestion came
later, as a way of demonstrating that a different type could be used
to redefine what ->inline_data was used for, if people considered
that an acceptible solution.

What was apparent from other discussions in the thread you quote was
that using two iomaps looked to be the better, more general approach
to solving the iomap read-modify-write issue at hand.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

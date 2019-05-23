Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F3E28123
	for <lists+linux-nvdimm@lfdr.de>; Thu, 23 May 2019 17:27:31 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 38F5221276772;
	Thu, 23 May 2019 08:27:29 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=rgoldwyn@suse.de;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 38E882126579B
 for <linux-nvdimm@lists.01.org>; Thu, 23 May 2019 08:27:27 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 69AD7ADEA;
 Thu, 23 May 2019 15:27:25 +0000 (UTC)
Date: Thu, 23 May 2019 10:27:22 -0500
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 16/18] btrfs: Writeprotect mmap pages on snapshot
Message-ID: <20190523152722.ybo5xuhej3yonvgt@fiona>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
 <20190429172649.8288-17-rgoldwyn@suse.de>
 <20190523140445.GD2949@quack2.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190523140445.GD2949@quack2.suse.cz>
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
Cc: kilobyte@angband.pl, darrick.wong@oracle.com, nborisov@suse.com,
 linux-nvdimm@lists.01.org, david@fromorbit.com, dsterba@suse.cz,
 willy@infradead.org, linux-fsdevel@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 16:04 23/05, Jan Kara wrote:
> On Mon 29-04-19 12:26:47, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > Inorder to make sure mmap'd files don't change after snapshot,
> > writeprotect the mmap pages on snapshot. This is done by performing
> > a data writeback on the pages (which simply mark the pages are
> > wrprotected). This way if the user process tries to access the memory
> > we will get another fault and we can perform a CoW.
> > 
> > In order to accomplish this, we tag all CoW pages as
> > PAGECACHE_TAG_TOWRITE, and add the mmapd inode in delalloc_inodes.
> > During snapshot, it starts writeback of all delalloc'd inodes and
> > here we perform a data writeback. We don't want to keep the inodes
> > in delalloc_inodes until it umount (WARN_ON), so we remove it
> > during inode evictions.
> > 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> OK, so here you use PAGECACHE_TAG_TOWRITE. But why is not
> PAGECACHE_TAG_DIRTY enough for you? Also why isn't the same needed also for
> normal non-DAX inodes? There you also need to trigger CoW on mmap write so
> I just don't see the difference...

Because dax_writeback_mapping_range() writebacks pages marked 
PAGECACHE_TAG_TOWRITE and not PAGECACHE_TAG_DIRTY. Should it
writeback pages marked as PAGECACHE_TAG_DIRTY as well?


-- 
Goldwyn
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

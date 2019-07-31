Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC2E7CEA8
	for <lists+linux-nvdimm@lfdr.de>; Wed, 31 Jul 2019 22:33:32 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 581C7212FD3FE;
	Wed, 31 Jul 2019 13:36:01 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=rgoldwyn@suse.de;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 61CBE212FD3E9
 for <linux-nvdimm@lists.01.org>; Wed, 31 Jul 2019 13:35:58 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id B764AAF84;
 Wed, 31 Jul 2019 20:33:26 +0000 (UTC)
Date: Wed, 31 Jul 2019 15:33:24 -0500
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Subject: Re: [RFC PATCH 0/7] xfs: add reflink & dedupe support for fsdax.
Message-ID: <20190731203324.7vjwlejmwpghpvqi@fiona>
References: <20190731114935.11030-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190731114935.11030-1-ruansy.fnst@cn.fujitsu.com>
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
Cc: qi.fuli@fujitsu.com, gujx@cn.fujitsu.com, darrick.wong@oracle.com,
 linux-nvdimm@lists.01.org, david@fromorbit.com, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 19:49 31/07, Shiyang Ruan wrote:
> This patchset aims to take care of this issue to make reflink and dedupe
> work correctly in XFS.
> 
> It is based on Goldwyn's patchsets: "v4 Btrfs dax support" and "Btrfs
> iomap".  I picked up some patches related and made a few fix to make it
> basically works fine.
> 
> For dax framework: 
>   1. adapt to the latest change in iomap.
> 
> For XFS:
>   1. report the source address and set IOMAP_COW type for those write
>      operations that need COW.
>   2. update extent list at the end.
>   3. add file contents comparison function based on dax framework.
>   4. use xfs_break_layouts() to support dax.

Shiyang,

I think you used the older patches which does not contain the iomap changes
which would call iomap_begin() with two iomaps. I have it in the btrfs-iomap
branch and plan to update it today. It is built on v5.3-rcX, so it should
contain the changes which moves the iomap code to the different directory.
I will build the dax patches on top of that.
However, we are making a big dependency chain here :(

-- 
Goldwyn

> 
> 
> Goldwyn Rodrigues (3):
>   dax: replace mmap entry in case of CoW
>   fs: dedup file range to use a compare function
>   dax: memcpy before zeroing range
> 
> Shiyang Ruan (4):
>   dax: Introduce dax_copy_edges() for COW.
>   dax: copy data before write.
>   xfs: Add COW handle for fsdax.
>   xfs: Add dedupe support for fsdax.
> 
>  fs/btrfs/ioctl.c      |  11 ++-
>  fs/dax.c              | 203 ++++++++++++++++++++++++++++++++++++++----
>  fs/iomap.c            |   9 +-
>  fs/ocfs2/file.c       |   2 +-
>  fs/read_write.c       |  11 +--
>  fs/xfs/xfs_iomap.c    |  42 +++++----
>  fs/xfs/xfs_reflink.c  |  84 +++++++++--------
>  include/linux/dax.h   |  15 ++--
>  include/linux/fs.h    |   8 +-
>  include/linux/iomap.h |   6 ++
>  10 files changed, 294 insertions(+), 97 deletions(-)
> 
> -- 
> 2.17.0
> 
> 
> 

-- 
Goldwyn
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

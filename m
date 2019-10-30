Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4B5E9B16
	for <lists+linux-nvdimm@lfdr.de>; Wed, 30 Oct 2019 12:48:28 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8C79F100EA53E;
	Wed, 30 Oct 2019 04:49:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=rgoldwyn@suse.de; receiver=<UNKNOWN> 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DB5E8100EA53D
	for <linux-nvdimm@lists.01.org>; Wed, 30 Oct 2019 04:48:59 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id 7A09FB147;
	Wed, 30 Oct 2019 11:48:21 +0000 (UTC)
Date: Wed, 30 Oct 2019 06:48:18 -0500
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Subject: Re: [RFC PATCH v2 0/7] xfs: reflink & dedupe for fsdax (read/write
 path).
Message-ID: <20191030114818.emvmgfgqadiqintw@fiona>
References: <20191030041358.14450-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191030041358.14450-1-ruansy.fnst@cn.fujitsu.com>
User-Agent: NeoMutt/20180716
Message-ID-Hash: G2LJ66MLNLK62GOOS2ENAVTZWCNJD7AL
X-Message-ID-Hash: G2LJ66MLNLK62GOOS2ENAVTZWCNJD7AL
X-MailFrom: rgoldwyn@suse.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, darrick.wong@oracle.com, hch@infradead.org, david@fromorbit.com, linux-kernel@vger.kernel.org, gujx@cn.fujitsu.com, qi.fuli@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/G2LJ66MLNLK62GOOS2ENAVTZWCNJD7AL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12:13 30/10, Shiyang Ruan wrote:
> This patchset aims to take care of this issue to make reflink and dedupe
> work correctly (actually in read/write path, there still has some problems,
> such as the page->mapping and page->index issue, in mmap path) in XFS under
> fsdax mode.

Have you managed to solve the problem of multi-mapped pages? I don't
think we can include this until we solve that problem. This is the
problem I faced when I was doing the btrfs dax support.

Suppose there is an extent shared with multiple files. You map data for
both files. Which inode should page->mapping->host (precisely
page->mapping) point to? As Dave pointed out, this needs to be fixed at
the mm level, and will not only benefit dax with CoW but other
areas such as overlayfs and possibly containers.

-- 
Goldwyn


> 
> It is based on Goldwyn's patchsets: "v4 Btrfs dax support" and the latest
> iomap.  I borrowed some patches related and made a few fix to make it
> basically works fine.
> 
> For dax framework: 
>   1. adapt to the latest change in iomap (two iomaps).
> 
> For XFS:
>   1. distinguish dax write/zero from normal write/zero.
>   2. remap extents after COW.
>   3. add file contents comparison function based on dax framework.
>   4. use xfs_break_layouts() instead of break_layout to support dax.
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
>   xfs: handle copy-on-write in fsdax write() path.
>   xfs: support dedupe for fsdax.
> 
>  fs/btrfs/ioctl.c       |   3 +-
>  fs/dax.c               | 211 +++++++++++++++++++++++++++++++++++++----
>  fs/iomap/buffered-io.c |   8 +-
>  fs/ocfs2/file.c        |   2 +-
>  fs/read_write.c        |  11 ++-
>  fs/xfs/xfs_bmap_util.c |   6 +-
>  fs/xfs/xfs_file.c      |  10 +-
>  fs/xfs/xfs_iomap.c     |   3 +-
>  fs/xfs/xfs_iops.c      |  11 ++-
>  fs/xfs/xfs_reflink.c   |  79 ++++++++-------
>  include/linux/dax.h    |  16 ++--
>  include/linux/fs.h     |   9 +-
>  12 files changed, 291 insertions(+), 78 deletions(-)
> 
> -- 
> 2.23.0
> 
> 
> 

-- 
Goldwyn
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2E7271EF
	for <lists+linux-nvdimm@lfdr.de>; Wed, 22 May 2019 23:50:39 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B418C2126578B;
	Wed, 22 May 2019 14:50:37 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=rgoldwyn@suse.de;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 02B3621243BDA
 for <linux-nvdimm@lists.01.org>; Wed, 22 May 2019 14:50:35 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 62DD4AB91;
 Wed, 22 May 2019 21:50:34 +0000 (UTC)
Date: Wed, 22 May 2019 16:50:31 -0500
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH 03/18] btrfs: basic dax read
Message-ID: <20190522215031.p2zmos3usl2pigwj@fiona>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
 <20190429172649.8288-4-rgoldwyn@suse.de>
 <20190521151445.GA5125@magnolia>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190521151445.GA5125@magnolia>
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

On  8:14 21/05, Darrick J. Wong wrote:
> On Mon, Apr 29, 2019 at 12:26:34PM -0500, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > Perform a basic read using iomap support. The btrfs_iomap_begin()
> > finds the extent at the position and fills the iomap data
> > structure with the values.
> > 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > ---
> >  fs/btrfs/Makefile |  1 +
> >  fs/btrfs/ctree.h  |  5 +++++
> >  fs/btrfs/dax.c    | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  fs/btrfs/file.c   | 11 ++++++++++-
> >  4 files changed, 65 insertions(+), 1 deletion(-)
> >  create mode 100644 fs/btrfs/dax.c
> > 
> > diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
> > index ca693dd554e9..1fa77b875ae9 100644
> > --- a/fs/btrfs/Makefile
> > +++ b/fs/btrfs/Makefile
> > @@ -12,6 +12,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
> >  	   reada.o backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
> >  	   uuid-tree.o props.o free-space-tree.o tree-checker.o
> >  
> > +btrfs-$(CONFIG_FS_DAX) += dax.o
> >  btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
> >  btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
> >  btrfs-$(CONFIG_BTRFS_FS_REF_VERIFY) += ref-verify.o
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index 9512f49262dd..b7bbe5130a3b 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -3795,6 +3795,11 @@ int btrfs_reada_wait(void *handle);
> >  void btrfs_reada_detach(void *handle);
> >  int btree_readahead_hook(struct extent_buffer *eb, int err);
> >  
> > +#ifdef CONFIG_FS_DAX
> > +/* dax.c */
> > +ssize_t btrfs_file_dax_read(struct kiocb *iocb, struct iov_iter *to);
> > +#endif /* CONFIG_FS_DAX */
> > +
> >  static inline int is_fstree(u64 rootid)
> >  {
> >  	if (rootid == BTRFS_FS_TREE_OBJECTID ||
> > diff --git a/fs/btrfs/dax.c b/fs/btrfs/dax.c
> > new file mode 100644
> > index 000000000000..bf3d46b0acb6
> > --- /dev/null
> > +++ b/fs/btrfs/dax.c
> > @@ -0,0 +1,49 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * DAX support for BTRFS
> > + *
> > + * Copyright (c) 2019  SUSE Linux
> > + * Author: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > + */
> > +
> > +#ifdef CONFIG_FS_DAX
> > +#include <linux/dax.h>
> > +#include <linux/iomap.h>
> > +#include "ctree.h"
> > +#include "btrfs_inode.h"
> > +
> > +static int btrfs_iomap_begin(struct inode *inode, loff_t pos,
> > +		loff_t length, unsigned flags, struct iomap *iomap)
> > +{
> > +	struct extent_map *em;
> > +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> > +	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, pos, length, 0);
> > +	if (em->block_start == EXTENT_MAP_HOLE) {
> > +		iomap->type = IOMAP_HOLE;
> > +		return 0;
> 
> I'm not doing a rigorous review of the btrfs-specific pieces, but you're
> required to fill out the other iomap fields for a read hole.

I fixed this in the patch adding write support. However, this
looks wrong as a patch. I will fix this.

-- 
Goldwyn
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

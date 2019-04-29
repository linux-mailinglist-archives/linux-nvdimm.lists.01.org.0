Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5F7E8C8
	for <lists+linux-nvdimm@lfdr.de>; Mon, 29 Apr 2019 19:27:16 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AA3BC2121AA00;
	Mon, 29 Apr 2019 10:27:12 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=rgoldwyn@suse.de;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id CDD36211F9D4A
 for <linux-nvdimm@lists.01.org>; Mon, 29 Apr 2019 10:27:10 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 7DA90AD0A;
 Mon, 29 Apr 2019 17:27:08 +0000 (UTC)
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v4 00/18] btrfs dax support
Date: Mon, 29 Apr 2019 12:26:31 -0500
Message-Id: <20190429172649.8288-1-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
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
Cc: kilobyte@angband.pl, jack@suse.cz, darrick.wong@oracle.com,
 nborisov@suse.com, linux-nvdimm@lists.01.org, david@fromorbit.com,
 dsterba@suse.cz, willy@infradead.org, linux-fsdevel@vger.kernel.org,
 hch@lst.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

This patch set adds support for dax on the BTRFS filesystem.
In order to support for CoW for btrfs, there were changes which had to be
made to the dax handling. The important one is copying blocks into the
same dax device before using them which is performed by iomap
type IOMAP_DAX_COW.

Snapshotting and CoW features are supported (including mmap preservation
across snapshots).

Git: https://github.com/goldwynr/linux/tree/btrfs-dax

Changes since v3:
 - Fixed memcpy bug
 - used flags for dax_insert_entry instead of bools for dax_insert_entry()

Changes since v2:
 - Created a new type IOMAP_DAX_COW as opposed to flag IOMAP_F_COW
 - CoW source address is presented in iomap.inline_data
 - Split the patches to more elaborate dax/iomap patches

Changes since v1:
 - use iomap instead of redoing everything in btrfs
 - support for mmap writeprotecting on snapshotting

 fs/btrfs/Makefile            |    1 
 fs/btrfs/ctree.h             |   38 +++++
 fs/btrfs/dax.c               |  289 +++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/disk-io.c           |    4 
 fs/btrfs/file.c              |   37 ++++-
 fs/btrfs/inode.c             |  114 ++++++++++++----
 fs/btrfs/ioctl.c             |   29 +++-
 fs/btrfs/send.c              |    4 
 fs/btrfs/super.c             |   30 ++++
 fs/dax.c                     |  183 ++++++++++++++++++++++++---
 fs/iomap.c                   |    9 -
 fs/ocfs2/file.c              |    2 
 fs/read_write.c              |   11 -
 fs/xfs/xfs_reflink.c         |    2 
 include/linux/dax.h          |   15 +-
 include/linux/fs.h           |    8 +
 include/linux/iomap.h        |    7 +
 include/trace/events/btrfs.h |   56 ++++++++
 18 files changed, 752 insertions(+), 87 deletions(-)


_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

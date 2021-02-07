Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A94831262F
	for <lists+linux-nvdimm@lfdr.de>; Sun,  7 Feb 2021 18:09:42 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E7BF8100EBB8F;
	Sun,  7 Feb 2021 09:09:38 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 098E5100EBB71
	for <linux-nvdimm@lists.01.org>; Sun,  7 Feb 2021 09:09:35 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.81,160,1610380800";
   d="scan'208";a="104299367"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 08 Feb 2021 01:09:32 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
	by cn.fujitsu.com (Postfix) with ESMTP id DEF7F4CE6F6E;
	Mon,  8 Feb 2021 01:09:27 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 8 Feb 2021 01:09:30 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Mon, 8 Feb 2021 01:09:29 +0800
From: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<linux-nvdimm@lists.01.org>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH 0/7] fsdax,xfs: Add reflink&dedupe support for fsdax
Date: Mon, 8 Feb 2021 01:09:17 +0800
Message-ID: <20210207170924.2933035-1-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
X-yoursite-MailScanner-ID: DEF7F4CE6F6E.A03B3
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: DPEUSARPI56IM6IV2R5YWOS3O2YAXZFK
X-Message-ID-Hash: DPEUSARPI56IM6IV2R5YWOS3O2YAXZFK
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DPEUSARPI56IM6IV2R5YWOS3O2YAXZFK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patchset is attempt to add CoW support for fsdax, and take XFS,
which has both reflink and fsdax feature, as an example.

One of the key mechanism need to be implemented in fsdax is CoW.  Copy
the data from srcmap before we actually write data to the destance
iomap.  And we just copy range in which data won't be changed.

Another mechanism is range comparison .  In page cache case, readpage()
is used to load data on disk to page cache in order to be able to
compare data.  In fsdax case, readpage() does not work.  So, we need
another compare data with direct access support.

With the two mechanism implemented in fsdax, we are able to make reflink
and fsdax work together in XFS.


Some of the patches are picked up from Goldwyn's patchset.  I made some
changes to adapt to this patchset.

(Rebased on v5.10)
==

Shiyang Ruan (7):
  fsdax: Output address in dax_iomap_pfn() and rename it
  fsdax: Introduce dax_copy_edges() for CoW
  fsdax: Copy data before write
  fsdax: Replace mmap entry in case of CoW
  fsdax: Dedup file range to use a compare function
  fs/xfs: Handle CoW for fsdax write() path
  fs/xfs: Add dedupe support for fsdax

 fs/btrfs/reflink.c     |   3 +-
 fs/dax.c               | 188 ++++++++++++++++++++++++++++++++++++++---
 fs/ocfs2/file.c        |   2 +-
 fs/remap_range.c       |  14 +--
 fs/xfs/xfs_bmap_util.c |   6 +-
 fs/xfs/xfs_file.c      |  30 ++++++-
 fs/xfs/xfs_inode.c     |   8 +-
 fs/xfs/xfs_inode.h     |   1 +
 fs/xfs/xfs_iomap.c     |   3 +-
 fs/xfs/xfs_iops.c      |  11 ++-
 fs/xfs/xfs_reflink.c   |  23 ++++-
 include/linux/dax.h    |   5 ++
 include/linux/fs.h     |   9 +-
 13 files changed, 270 insertions(+), 33 deletions(-)

-- 
2.30.0


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

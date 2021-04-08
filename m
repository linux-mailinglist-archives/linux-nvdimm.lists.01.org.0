Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A953582B6
	for <lists+linux-nvdimm@lfdr.de>; Thu,  8 Apr 2021 14:04:47 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F1CF6100EAB44;
	Thu,  8 Apr 2021 05:04:45 -0700 (PDT)
Received-SPF: Neutral (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 5FE54100EB333
	for <linux-nvdimm@lists.01.org>; Thu,  8 Apr 2021 05:04:42 -0700 (PDT)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A4NSyVKlPuH4vkzq6pEU2/XbVTQ3pDfLM3DAb?=
 =?us-ascii?q?vn1ZSRFFG/GwvcaogfgdyFvImC8cMUtQ/eyoFYuhZTfn9ZBz6ZQMJrvKZmTbkU?=
 =?us-ascii?q?ahMY0K1+Xf6hLtFyD0/uRekYdMGpIVNPTeFl5/5Pya3CCdM/INhOaK67qpg+C2?=
 =?us-ascii?q?9QYJcShPZ7t75wl0Tia3e3cGJzVuPpYyGJqC6scvnVPJFkg/VNixBXUOQoH41r?=
 =?us-ascii?q?/2va/hCCRnOzcXrCGKjR6NrIXxCgWk2H4lOA9n8PMP9nfknmXCipmejw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.82,206,1613404800";
   d="scan'208";a="106797245"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 08 Apr 2021 20:04:39 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
	by cn.fujitsu.com (Postfix) with ESMTP id BF9744CEA876;
	Thu,  8 Apr 2021 20:04:35 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 8 Apr 2021 20:04:36 +0800
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 8 Apr 2021 20:04:35 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Thu, 8 Apr 2021 20:04:34 +0800
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<linux-nvdimm@lists.01.org>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v4 0/7] fsdax,xfs: Add reflink&dedupe support for fsdax
Date: Thu, 8 Apr 2021 20:04:25 +0800
Message-ID: <20210408120432.1063608-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
X-yoursite-MailScanner-ID: BF9744CEA876.A4371
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Message-ID-Hash: YBJUSBJMPPSAXKASB6REFNGECOR7HD24
X-Message-ID-Hash: YBJUSBJMPPSAXKASB6REFNGECOR7HD24
X-MailFrom: ruansy.fnst@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YBJUSBJMPPSAXKASB6REFNGECOR7HD24/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patchset is attempt to add CoW support for fsdax, and take XFS,
which has both reflink and fsdax feature, as an example.

Changes from V3:
 - Take out the first 3 patches as a cleanup patchset[1], which has been
    sent yesterday.
 - Fix usage of code in dax_iomap_cow_copy()
 - Add comments for macro definitions
 - Fix other code style problems and mistakes

Changes from V2:
 - Fix the mistake in iomap_apply2() and dax_dedupe_file_range_compare()
 - Add CoW judgement in dax_iomap_zero()
 - Fix other code style problems and mistakes

Changes from V1:
 - Factor some helper functions to simplify dax fault code
 - Introduce iomap_apply2() for dax_dedupe_file_range_compare()
 - Fix mistakes and other problems
 - Rebased on v5.11

One of the key mechanism need to be implemented in fsdax is CoW.  Copy
the data from srcmap before we actually write data to the destance
iomap.  And we just copy range in which data won't be changed.

Another mechanism is range comparison.  In page cache case, readpage()
is used to load data on disk to page cache in order to be able to
compare data.  In fsdax case, readpage() does not work.  So, we need
another compare data with direct access support.

With the two mechanism implemented in fsdax, we are able to make reflink
and fsdax work together in XFS.

Some of the patches are picked up from Goldwyn's patchset.  I made some
changes to adapt to this patchset.


(Rebased on v5.12-rc5 and patchset[1])

[1]: https://lore.kernel.org/linux-xfs/20210407133823.828176-1-ruansy.fnst@fujitsu.com/
==

Shiyang Ruan (7):
  fsdax: Introduce dax_iomap_cow_copy()
  fsdax: Replace mmap entry in case of CoW
  fsdax: Add dax_iomap_cow_copy() for dax_iomap_zero
  iomap: Introduce iomap_apply2() for operations on two files
  fsdax: Dedup file range to use a compare function
  fs/xfs: Handle CoW for fsdax write() path
  fs/xfs: Add dedupe support for fsdax

 fs/dax.c               | 202 +++++++++++++++++++++++++++++++++++------
 fs/iomap/apply.c       |  52 +++++++++++
 fs/iomap/buffered-io.c |   2 +-
 fs/remap_range.c       |  45 +++++++--
 fs/xfs/xfs_bmap_util.c |   3 +-
 fs/xfs/xfs_file.c      |  29 ++++--
 fs/xfs/xfs_inode.c     |   8 +-
 fs/xfs/xfs_inode.h     |   1 +
 fs/xfs/xfs_iomap.c     |  58 +++++++++++-
 fs/xfs/xfs_iomap.h     |   4 +
 fs/xfs/xfs_iops.c      |   7 +-
 fs/xfs/xfs_reflink.c   |  17 ++--
 include/linux/dax.h    |   7 +-
 include/linux/fs.h     |  12 ++-
 include/linux/iomap.h  |   7 +-
 15 files changed, 393 insertions(+), 61 deletions(-)

-- 
2.31.0


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

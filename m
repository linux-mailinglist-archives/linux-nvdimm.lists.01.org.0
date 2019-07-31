Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEA67C05E
	for <lists+linux-nvdimm@lfdr.de>; Wed, 31 Jul 2019 13:49:50 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D2727212E844C;
	Wed, 31 Jul 2019 04:52:19 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=183.91.158.132;
 helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
 by ml01.01.org (Postfix) with ESMTP id D4685212E8447
 for <linux-nvdimm@lists.01.org>; Wed, 31 Jul 2019 04:52:18 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.64,330,1559491200"; d="scan'208";a="72591477"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
 by heian.cn.fujitsu.com with ESMTP; 31 Jul 2019 19:49:45 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
 by cn.fujitsu.com (Postfix) with ESMTP id B85DD4B4041E;
 Wed, 31 Jul 2019 19:49:42 +0800 (CST)
Received: from iridescent.g08.fujitsu.local (10.167.225.140) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 31 Jul 2019 19:49:49 +0800
From: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To: <linux-xfs@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
 <darrick.wong@oracle.com>
Subject: [RFC PATCH 0/7] xfs: add reflink & dedupe support for fsdax.
Date: Wed, 31 Jul 2019 19:49:28 +0800
Message-ID: <20190731114935.11030-1-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
X-Originating-IP: [10.167.225.140]
X-yoursite-MailScanner-ID: B85DD4B4041E.A6D27
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
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
Cc: qi.fuli@fujitsu.com, gujx@cn.fujitsu.com, rgoldwyn@suse.de,
 david@fromorbit.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

This patchset aims to take care of this issue to make reflink and dedupe
work correctly in XFS.

It is based on Goldwyn's patchsets: "v4 Btrfs dax support" and "Btrfs
iomap".  I picked up some patches related and made a few fix to make it
basically works fine.

For dax framework: 
  1. adapt to the latest change in iomap.

For XFS:
  1. report the source address and set IOMAP_COW type for those write
     operations that need COW.
  2. update extent list at the end.
  3. add file contents comparison function based on dax framework.
  4. use xfs_break_layouts() to support dax.


Goldwyn Rodrigues (3):
  dax: replace mmap entry in case of CoW
  fs: dedup file range to use a compare function
  dax: memcpy before zeroing range

Shiyang Ruan (4):
  dax: Introduce dax_copy_edges() for COW.
  dax: copy data before write.
  xfs: Add COW handle for fsdax.
  xfs: Add dedupe support for fsdax.

 fs/btrfs/ioctl.c      |  11 ++-
 fs/dax.c              | 203 ++++++++++++++++++++++++++++++++++++++----
 fs/iomap.c            |   9 +-
 fs/ocfs2/file.c       |   2 +-
 fs/read_write.c       |  11 +--
 fs/xfs/xfs_iomap.c    |  42 +++++----
 fs/xfs/xfs_reflink.c  |  84 +++++++++--------
 include/linux/dax.h   |  15 ++--
 include/linux/fs.h    |   8 +-
 include/linux/iomap.h |   6 ++
 10 files changed, 294 insertions(+), 97 deletions(-)

-- 
2.17.0



_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

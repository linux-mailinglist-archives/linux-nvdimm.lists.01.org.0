Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BAD2BFD9D
	for <lists+linux-nvdimm@lfdr.de>; Mon, 23 Nov 2020 01:41:33 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 926A4100EF26A;
	Sun, 22 Nov 2020 16:41:30 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id B399D100EF245
	for <linux-nvdimm@lists.01.org>; Sun, 22 Nov 2020 16:41:27 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.78,361,1599494400";
   d="scan'208";a="101635228"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 Nov 2020 08:41:23 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
	by cn.fujitsu.com (Postfix) with ESMTP id 03B5C48990F9;
	Mon, 23 Nov 2020 08:41:18 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 23 Nov 2020 08:41:16 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Mon, 23 Nov 2020 08:41:18 +0800
From: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>
Subject: [RFC PATCH v2 0/6] fsdax: introduce fs query to support reflink
Date: Mon, 23 Nov 2020 08:41:10 +0800
Message-ID: <20201123004116.2453-1-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-yoursite-MailScanner-ID: 03B5C48990F9.AE527
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: YOYVHDVZBUSF6AP5MUXJTPEU55IVGSYN
X-Message-ID-Hash: YOYVHDVZBUSF6AP5MUXJTPEU55IVGSYN
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org, darrick.wong@oracle.com, david@fromorbit.com, hch@lst.de, song@kernel.org, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YOYVHDVZBUSF6AP5MUXJTPEU55IVGSYN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patchset is a try to resolve the problem of tracking shared page
for fsdax.

Change from v1:
  - Intorduce ->block_lost() for block device
  - Support mapped device
  - Add 'not available' warning for realtime device in XFS
  - Rebased to v5.10-rc1

This patchset moves owner tracking from dax_assocaite_entry() to pmem
device, by introducing an interface ->memory_failure() of struct
pagemap.  The interface is called by memory_failure() in mm, and
implemented by pmem device.  Then pmem device calls its ->block_lost()
to find the filesystem which the damaged page located in, and call
->storage_lost() to track files or metadata assocaited with this page.
Finally we are able to try to fix the damaged data in filesystem and do
other necessary processing, such as killing processes who are using the
files affected.

The call trace is like this:
 memory_failure()
   pgmap->ops->memory_failure()   => pmem_pgmap_memory_failure()
    gendisk->fops->block_lost()   => pmem_block_lost() or
                                         md_blk_block_lost()
     sb->s_ops->storage_lost()    => xfs_fs_storage_lost()
      xfs_rmap_query_range()
       xfs_storage_lost_helper()
        mf_recover_controller->recover_fn => \ 
                            memory_failure_dev_pagemap_kill_procs()

The collect_procs() and kill_procs() are moved into a callback which
is passed from memory_failure() to xfs_storage_lost_helper().  So we
can call it when a file assocaited is found, instead of creating a
file list and iterate it.

The fsdax & reflink support for XFS is not contained in this patchset.

(Rebased on v5.10-rc1)

Shiyang Ruan (6):
  fs: introduce ->storage_lost() for memory-failure
  blk: introduce ->block_lost() to handle memory-failure
  md: implement ->block_lost() for memory-failure
  pagemap: introduce ->memory_failure()
  mm, fsdax: refactor dax handler in memory-failure
  fsdax: remove useless (dis)associate functions

 block/genhd.c                 |  12 ++++
 drivers/md/dm-linear.c        |   8 +++
 drivers/md/dm.c               |  64 +++++++++++++++++
 drivers/nvdimm/pmem.c         |  50 +++++++++++++
 fs/block_dev.c                |  23 ++++++
 fs/dax.c                      |  64 ++---------------
 fs/xfs/xfs_super.c            |  87 +++++++++++++++++++++++
 include/linux/blkdev.h        |   2 +
 include/linux/dax.h           |   5 +-
 include/linux/device-mapper.h |   2 +
 include/linux/fs.h            |   2 +
 include/linux/genhd.h         |   9 +++
 include/linux/memremap.h      |   3 +
 include/linux/mm.h            |  14 ++++
 mm/memory-failure.c           | 127 +++++++++++++++++++++-------------
 15 files changed, 362 insertions(+), 110 deletions(-)

-- 
2.29.2


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

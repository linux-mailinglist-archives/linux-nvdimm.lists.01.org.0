Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 253522E7B36
	for <lists+linux-nvdimm@lfdr.de>; Wed, 30 Dec 2020 17:58:48 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9903B100EC1DD;
	Wed, 30 Dec 2020 08:58:46 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 530B8100EC1D6
	for <linux-nvdimm@lists.01.org>; Wed, 30 Dec 2020 08:58:43 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.78,461,1599494400";
   d="scan'208";a="103085830"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 31 Dec 2020 00:58:39 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
	by cn.fujitsu.com (Postfix) with ESMTP id CCD554CE6018;
	Thu, 31 Dec 2020 00:58:32 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 31 Dec 2020 00:58:32 +0800
Received: from irides.mr (10.167.225.141) by G08CNEXCHPEKD04.g08.fujitsu.local
 (10.167.33.209) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 31 Dec 2020 00:58:32 +0800
From: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>
Subject: [PATCH 00/10] fsdax: introduce fs query to support reflink
Date: Thu, 31 Dec 2020 00:55:51 +0800
Message-ID: <20201230165601.845024-1-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-yoursite-MailScanner-ID: CCD554CE6018.ACD3C
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: X2QZ5BYWDOXHYARTHCDNF273GDIX6CUA
X-Message-ID-Hash: X2QZ5BYWDOXHYARTHCDNF273GDIX6CUA
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org, darrick.wong@oracle.com, david@fromorbit.com, hch@lst.de, song@kernel.org, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/X2QZ5BYWDOXHYARTHCDNF273GDIX6CUA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patchset is aimed to support shared pages tracking for fsdax.

Change from RFC v3:
  - Do not lock dax entry in memory failure handler
  - Add a helper function for corrupted_range
  - Add restrictions in xfs code
  - Fix code style
  - remove the useless association and lock in fsdax

Change from RFC v2:
  - Adjust the order of patches
  - Divide the infrastructure and the drivers that use it
  - Rebased to v5.10

Change from RFC v1:
  - Introduce ->block_lost() for block device
  - Support mapped device
  - Add 'not available' warning for realtime device in XFS
  - Rebased to v5.10-rc1

This patchset moves owner tracking from dax_assocaite_entry() to pmem
device driver, by introducing an interface ->memory_failure() of struct
pagemap.  This interface is called by memory_failure() in mm, and
implemented by pmem device.  Then pmem device calls its ->corrupted_range()
to find the filesystem which the corrupted data located in, and call
filesystem handler to track files or metadata assocaited with this page.
Finally we are able to try to fix the corrupted data in filesystem and do
other necessary processing, such as killing processes who are using the
files affected.

The call trace is like this:
memory_failure()
 pgmap->ops->memory_failure()      => pmem_pgmap_memory_failure()
  gendisk->fops->corrupted_range() => - pmem_corrupted_range()
                                      - md_blk_corrupted_range()
   sb->s_ops->currupted_range()    => xfs_fs_corrupted_range()
    xfs_rmap_query_range()
     xfs_currupt_helper()
      * corrupted on metadata
          try to recover data, call xfs_force_shutdown()
      * corrupted on file data 
          try to recover data, call mf_dax_mapping_kill_procs()

The fsdax & reflink support for XFS is not contained in this patchset.

(Rebased on v5.10)
--

Shiyang Ruan (10):
  pagemap: Introduce ->memory_failure()
  blk: Introduce ->corrupted_range() for block device
  fs: Introduce ->corrupted_range() for superblock
  mm, fsdax: Refactor memory-failure handler for dax mapping
  mm, pmem: Implement ->memory_failure() in pmem driver
  pmem: Implement ->corrupted_range() for pmem driver
  dm: Introduce ->rmap() to find bdev offset
  md: Implement ->corrupted_range()
  xfs: Implement ->corrupted_range() for XFS
  fs/dax: remove useless functions

 block/genhd.c                 |  12 ++++
 drivers/md/dm-linear.c        |   8 +++
 drivers/md/dm.c               |  54 ++++++++++++++
 drivers/nvdimm/pmem.c         |  43 +++++++++++
 fs/block_dev.c                |  37 ++++++++++
 fs/dax.c                      | 115 ++++-------------------------
 fs/xfs/xfs_fsops.c            |   5 ++
 fs/xfs/xfs_mount.h            |   1 +
 fs/xfs/xfs_super.c            | 107 +++++++++++++++++++++++++++
 include/linux/blkdev.h        |   2 +
 include/linux/dax.h           |   3 +-
 include/linux/device-mapper.h |   2 +
 include/linux/fs.h            |   2 +
 include/linux/genhd.h         |   3 +
 include/linux/memremap.h      |   8 +++
 include/linux/mm.h            |   9 +++
 mm/memory-failure.c           | 131 ++++++++++++++++++----------------
 17 files changed, 375 insertions(+), 167 deletions(-)

-- 
2.29.2


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

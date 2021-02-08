Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE8E312FC4
	for <lists+linux-nvdimm@lfdr.de>; Mon,  8 Feb 2021 11:55:40 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C2D96100EB85D;
	Mon,  8 Feb 2021 02:55:38 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 0CBB2100EB856
	for <linux-nvdimm@lists.01.org>; Mon,  8 Feb 2021 02:55:35 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.81,161,1610380800";
   d="scan'208";a="104328056"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 08 Feb 2021 18:55:34 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
	by cn.fujitsu.com (Postfix) with ESMTP id 869654CE6F7F;
	Mon,  8 Feb 2021 18:55:32 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 8 Feb 2021 18:55:33 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Mon, 8 Feb 2021 18:55:34 +0800
From: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, <dm-devel@redhat.com>
Subject: [PATCH v3 00/11] fsdax: introduce fs query to support reflink
Date: Mon, 8 Feb 2021 18:55:19 +0800
Message-ID: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
X-yoursite-MailScanner-ID: 869654CE6F7F.ACD1D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: YJ62S3DCR3ITTEXXJ5Q6VC3SF4SMLJZZ
X-Message-ID-Hash: YJ62S3DCR3ITTEXXJ5Q6VC3SF4SMLJZZ
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: darrick.wong@oracle.com, david@fromorbit.com, hch@lst.de, agk@redhat.com, snitzer@redhat.com, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YJ62S3DCR3ITTEXXJ5Q6VC3SF4SMLJZZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patchset is aimed to support shared pages tracking for fsdax.

Change from V2:
  - Split 8th patch into other related to make it easy to review
  - Other small fixes

Change from V1:
  - Add the old memory-failure handler back for rolling back
  - Add callback in MD's ->rmap() to support multiple mapping of dm device
  - Add judgement for CONFIG_SYSFS
  - Add pfn_valid() judgement in hwpoison_filter()
  - Rebased to v5.11-rc5

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

(Rebased on v5.11-rc5)
==

Shiyang Ruan (11):
  pagemap: Introduce ->memory_failure()
  blk: Introduce ->corrupted_range() for block device
  fs: Introduce ->corrupted_range() for superblock
  block_dev: Introduce bd_corrupted_range()
  mm, fsdax: Refactor memory-failure handler for dax mapping
  mm, pmem: Implement ->memory_failure() in pmem driver
  pmem: Implement ->corrupted_range() for pmem driver
  dm: Introduce ->rmap() to find bdev offset
  md: Implement ->corrupted_range()
  xfs: Implement ->corrupted_range() for XFS
  fs/dax: Remove useless functions

 block/genhd.c                 |   6 ++
 drivers/md/dm-linear.c        |  20 ++++
 drivers/md/dm.c               |  61 +++++++++++
 drivers/nvdimm/pmem.c         |  45 ++++++++
 fs/block_dev.c                |  47 ++++++++-
 fs/dax.c                      |  63 ++++-------
 fs/xfs/xfs_fsops.c            |   5 +
 fs/xfs/xfs_mount.h            |   1 +
 fs/xfs/xfs_super.c            | 112 ++++++++++++++++++++
 include/linux/blkdev.h        |   2 +
 include/linux/dax.h           |   1 +
 include/linux/device-mapper.h |   5 +
 include/linux/fs.h            |   2 +
 include/linux/genhd.h         |   3 +
 include/linux/memremap.h      |   8 ++
 include/linux/mm.h            |   9 ++
 mm/memory-failure.c           | 190 +++++++++++++++++++++++-----------
 17 files changed, 475 insertions(+), 105 deletions(-)

-- 
2.30.0


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

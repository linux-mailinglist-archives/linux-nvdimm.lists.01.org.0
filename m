Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 591BB379D66
	for <lists+linux-nvdimm@lfdr.de>; Tue, 11 May 2021 05:09:49 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E2DB8100EB82F;
	Mon, 10 May 2021 20:09:46 -0700 (PDT)
Received-SPF: Neutral (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 9C4AA100EB82C
	for <linux-nvdimm@lists.01.org>; Mon, 10 May 2021 20:09:42 -0700 (PDT)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AqeOPpaHk4VAK9c6upLqEAMeALOsnbusQ8zAX?=
 =?us-ascii?q?P0AYc3Jom6uj5qSTdZUgpHjJYVkqOE3I9ertBEDiewK4yXcW2/hzAV7KZmCP0w?=
 =?us-ascii?q?HEEGgI1+rfKlPbdBEWjtQtt5uIbZIOc+HYPBxri9rg+gmkH5IFyNmDyqqhguDT?=
 =?us-ascii?q?1B5WPHhXQpAl/wFkERyaD0EzYAFHAKAyHJ2a6tECiCGnfR0sH7yGL0hAT+7evM?=
 =?us-ascii?q?fKiZ6jRRYHAiQs4A6IgSjtyJOSKWn/4isj?=
X-IronPort-AV: E=Sophos;i="5.82,290,1613404800";
   d="scan'208";a="108110504"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 May 2021 11:09:40 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
	by cn.fujitsu.com (Postfix) with ESMTP id 7E1904D0BA79;
	Tue, 11 May 2021 11:09:36 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 11 May 2021 11:09:35 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Tue, 11 May 2021 11:09:35 +0800
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<linux-nvdimm@lists.01.org>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v5 0/7] fsdax,xfs: Add reflink&dedupe support for fsdax
Date: Tue, 11 May 2021 11:09:26 +0800
Message-ID: <20210511030933.3080921-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-yoursite-MailScanner-ID: 7E1904D0BA79.A04B1
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Message-ID-Hash: HWMOX5YFXJGUWMVZ4GTV3WUV57DAXDXQ
X-Message-ID-Hash: HWMOX5YFXJGUWMVZ4GTV3WUV57DAXDXQ
X-MailFrom: ruansy.fnst@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: darrick.wong@oracle.com, willy@infradead.org, viro@zeniv.linux.org.uk, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HWMOX5YFXJGUWMVZ4GTV3WUV57DAXDXQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patchset is attempt to add CoW support for fsdax, and take XFS,
which has both reflink and fsdax feature, as an example.

Changes from V4:
 - Fix the mistake of breaking dax layout for two inodes
 - Add CONFIG_FS_DAX judgement for fsdax code in remap_range.c
 - Fix other small problems and mistakes

Changes from V3:
 - Take out the first 3 patches as a cleanup patchset[1], which has been
    sent yesterday.
 - Fix usage of code in dax_iomap_cow_copy()
 - Add comments for macro definitions
 - Fix other code style problems and mistakes

One of the key mechanism need to be implemented in fsdax is CoW.  Copy
the data from srcmap before we actually write data to the destance
iomap.  And we just copy range in which data won't be changed.

Another mechanism is range comparison.  In page cache case, readpage()
is used to load data on disk to page cache in order to be able to
compare data.  In fsdax case, readpage() does not work.  So, we need
another compare data with direct access support.

With the two mechanisms implemented in fsdax, we are able to make reflink
and fsdax work together in XFS.

Some of the patches are picked up from Goldwyn's patchset.  I made some
changes to adapt to this patchset.


(Rebased on v5.13-rc1 and patchset[1])
[1]: https://lkml.org/lkml/2021/4/22/575

Shiyang Ruan (7):
  fsdax: Introduce dax_iomap_cow_copy()
  fsdax: Replace mmap entry in case of CoW
  fsdax: Add dax_iomap_cow_copy() for dax_iomap_zero
  iomap: Introduce iomap_apply2() for operations on two files
  fsdax: Dedup file range to use a compare function
  fs/xfs: Handle CoW for fsdax write() path
  fs/xfs: Add dax dedupe support

 fs/dax.c               | 206 +++++++++++++++++++++++++++++++++++------
 fs/iomap/apply.c       |  52 +++++++++++
 fs/iomap/buffered-io.c |   2 +-
 fs/remap_range.c       |  57 ++++++++++--
 fs/xfs/xfs_bmap_util.c |   3 +-
 fs/xfs/xfs_file.c      |  11 +--
 fs/xfs/xfs_inode.c     |  66 ++++++++++++-
 fs/xfs/xfs_inode.h     |   1 +
 fs/xfs/xfs_iomap.c     |  61 +++++++++++-
 fs/xfs/xfs_iomap.h     |   4 +
 fs/xfs/xfs_iops.c      |   7 +-
 fs/xfs/xfs_reflink.c   |  15 +--
 include/linux/dax.h    |   7 +-
 include/linux/fs.h     |  12 ++-
 include/linux/iomap.h  |   7 +-
 15 files changed, 449 insertions(+), 62 deletions(-)

-- 
2.31.1


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

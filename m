Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69503341253
	for <lists+linux-nvdimm@lfdr.de>; Fri, 19 Mar 2021 02:53:01 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 649D2100EB352;
	Thu, 18 Mar 2021 18:52:54 -0700 (PDT)
Received-SPF: Neutral (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 36721100EB349
	for <linux-nvdimm@lists.01.org>; Thu, 18 Mar 2021 18:52:49 -0700 (PDT)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AARB8MK8Ih9lumEGjpUVuk+A4I+orLtY04lQ7?=
 =?us-ascii?q?vn1ZYxpTb8CeioSSjO0WvCWE7Ao5dVMBvZS7OKeGSW7B7pId2+QsFJqrQQWOgg?=
 =?us-ascii?q?WVBa5v4YboyzfjXw3Sn9Q26Y5OaK57YeeQMXFfreLXpDa1CMwhxt7vytHMuc77?=
 =?us-ascii?q?w212RQ9nL4FMhj0JaTqzKUF9SAlYCZdRLvP1ifZvnSaqengcc62Adxs4dtXEzu?=
 =?us-ascii?q?eqqLvWJTYCBzMCrDKFlC6U7tfBeCSw71MzVCxuzN4ZnVT4rw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.81,259,1610380800";
   d="scan'208";a="105876646"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 19 Mar 2021 09:52:46 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
	by cn.fujitsu.com (Postfix) with ESMTP id 122074CEB2A3;
	Fri, 19 Mar 2021 09:52:46 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 19 Mar 2021 09:52:46 +0800
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 19 Mar 2021 09:52:42 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Fri, 19 Mar 2021 09:52:41 +0800
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<linux-nvdimm@lists.01.org>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v3 00/10] fsdax,xfs: Add reflink&dedupe support for fsdax
Date: Fri, 19 Mar 2021 09:52:27 +0800
Message-ID: <20210319015237.993880-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
X-yoursite-MailScanner-ID: 122074CEB2A3.A4D15
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Message-ID-Hash: GCEZG4QCHWK7YBOKWMUUKKPUQCIWSFRL
X-Message-ID-Hash: GCEZG4QCHWK7YBOKWMUUKKPUQCIWSFRL
X-MailFrom: ruansy.fnst@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GCEZG4QCHWK7YBOKWMUUKKPUQCIWSFRL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>

This patchset is attempt to add CoW support for fsdax, and take XFS,
which has both reflink and fsdax feature, as an example.

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

(Rebased on v5.11)
==

Shiyang Ruan (10):
  fsdax: Factor helpers to simplify dax fault code
  fsdax: Factor helper: dax_fault_actor()
  fsdax: Output address in dax_iomap_pfn() and rename it
  fsdax: Introduce dax_iomap_cow_copy()
  fsdax: Replace mmap entry in case of CoW
  fsdax: Add dax_iomap_cow_copy() for dax_iomap_zero
  iomap: Introduce iomap_apply2() for operations on two files
  fsdax: Dedup file range to use a compare function
  fs/xfs: Handle CoW for fsdax write() path
  fs/xfs: Add dedupe support for fsdax

 fs/dax.c               | 596 ++++++++++++++++++++++++++---------------
 fs/iomap/apply.c       |  56 ++++
 fs/iomap/buffered-io.c |   2 +-
 fs/remap_range.c       |  45 +++-
 fs/xfs/xfs_bmap_util.c |   3 +-
 fs/xfs/xfs_file.c      |  29 +-
 fs/xfs/xfs_inode.c     |   8 +-
 fs/xfs/xfs_inode.h     |   1 +
 fs/xfs/xfs_iomap.c     |  58 +++-
 fs/xfs/xfs_iomap.h     |   4 +
 fs/xfs/xfs_iops.c      |   7 +-
 fs/xfs/xfs_reflink.c   |  17 +-
 include/linux/dax.h    |   7 +-
 include/linux/fs.h     |  15 +-
 include/linux/iomap.h  |   7 +-
 15 files changed, 602 insertions(+), 253 deletions(-)

--
2.30.1


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

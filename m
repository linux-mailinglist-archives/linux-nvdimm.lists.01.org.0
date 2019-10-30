Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5109CE959A
	for <lists+linux-nvdimm@lfdr.de>; Wed, 30 Oct 2019 05:14:23 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A2C1D100EA53F;
	Tue, 29 Oct 2019 21:14:59 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 97B74100EA53D
	for <linux-nvdimm@lists.01.org>; Tue, 29 Oct 2019 21:14:56 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.68,245,1569254400";
   d="scan'208";a="77665111"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Oct 2019 12:14:14 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
	by cn.fujitsu.com (Postfix) with ESMTP id 3C6C34B6AE15;
	Wed, 30 Oct 2019 12:06:16 +0800 (CST)
Received: from localhost.localdomain (10.167.225.140) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 30 Oct 2019 12:14:24 +0800
From: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To: <linux-xfs@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
	<darrick.wong@oracle.com>, <rgoldwyn@suse.de>, <hch@infradead.org>,
	<david@fromorbit.com>
Subject: [RFC PATCH v2 0/7] xfs: reflink & dedupe for fsdax (read/write path).
Date: Wed, 30 Oct 2019 12:13:51 +0800
Message-ID: <20191030041358.14450-1-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
X-Originating-IP: [10.167.225.140]
X-yoursite-MailScanner-ID: 3C6C34B6AE15.A4452
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: U5PUXWU5BMJDYJ72HFZUW2SE532SZRWD
X-Message-ID-Hash: U5PUXWU5BMJDYJ72HFZUW2SE532SZRWD
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org, gujx@cn.fujitsu.com, qi.fuli@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/U5PUXWU5BMJDYJ72HFZUW2SE532SZRWD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patchset aims to take care of this issue to make reflink and dedupe
work correctly (actually in read/write path, there still has some problems,
such as the page->mapping and page->index issue, in mmap path) in XFS under
fsdax mode.

It is based on Goldwyn's patchsets: "v4 Btrfs dax support" and the latest
iomap.  I borrowed some patches related and made a few fix to make it
basically works fine.

For dax framework: 
  1. adapt to the latest change in iomap (two iomaps).

For XFS:
  1. distinguish dax write/zero from normal write/zero.
  2. remap extents after COW.
  3. add file contents comparison function based on dax framework.
  4. use xfs_break_layouts() instead of break_layout to support dax.


Goldwyn Rodrigues (3):
  dax: replace mmap entry in case of CoW
  fs: dedup file range to use a compare function
  dax: memcpy before zeroing range

Shiyang Ruan (4):
  dax: Introduce dax_copy_edges() for COW.
  dax: copy data before write.
  xfs: handle copy-on-write in fsdax write() path.
  xfs: support dedupe for fsdax.

 fs/btrfs/ioctl.c       |   3 +-
 fs/dax.c               | 211 +++++++++++++++++++++++++++++++++++++----
 fs/iomap/buffered-io.c |   8 +-
 fs/ocfs2/file.c        |   2 +-
 fs/read_write.c        |  11 ++-
 fs/xfs/xfs_bmap_util.c |   6 +-
 fs/xfs/xfs_file.c      |  10 +-
 fs/xfs/xfs_iomap.c     |   3 +-
 fs/xfs/xfs_iops.c      |  11 ++-
 fs/xfs/xfs_reflink.c   |  79 ++++++++-------
 include/linux/dax.h    |  16 ++--
 include/linux/fs.h     |   9 +-
 12 files changed, 291 insertions(+), 78 deletions(-)

-- 
2.23.0


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

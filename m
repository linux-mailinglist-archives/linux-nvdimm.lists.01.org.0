Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF13E1B9AA4
	for <lists+linux-nvdimm@lfdr.de>; Mon, 27 Apr 2020 10:48:38 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9D5B110FF7B7F;
	Mon, 27 Apr 2020 01:47:47 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id BCCDA1009F03D
	for <linux-nvdimm@lists.01.org>; Mon, 27 Apr 2020 01:47:44 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.73,323,1583164800";
   d="scan'208";a="90547651"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 27 Apr 2020 16:48:31 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
	by cn.fujitsu.com (Postfix) with ESMTP id B686750A9991;
	Mon, 27 Apr 2020 16:37:48 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 27 Apr 2020 16:48:31 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Mon, 27 Apr 2020 16:48:30 +0800
From: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<linux-nvdimm@lists.01.org>
Subject: [RFC PATCH 0/8] dax: Add a dax-rmap tree to support reflink
Date: Mon, 27 Apr 2020 16:47:42 +0800
Message-ID: <20200427084750.136031-1-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-yoursite-MailScanner-ID: B686750A9991.AE152
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: W57IF4VGKUCAPDXDICWZC3R5C7EDGMT2
X-Message-ID-Hash: W57IF4VGKUCAPDXDICWZC3R5C7EDGMT2
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/W57IF4VGKUCAPDXDICWZC3R5C7EDGMT2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patchset is a try to resolve the shared 'page cache' problem for
fsdax.

In order to track multiple mappings and indexes on one page, I
introduced a dax-rmap rb-tree to manage the relationship.  A dax entry
will be associated more than once if is shared.  At the second time we
associate this entry, we create this rb-tree and store its root in
page->private(not used in fsdax).  Insert (->mapping, ->index) when
dax_associate_entry() and delete it when dax_disassociate_entry().

We can iterate the dax-rmap rb-tree before any other operations on
mappings of files.  Such as memory-failure and rmap.

Same as before, I borrowed and made some changes on Goldwyn's patchsets.
These patches makes up for the lack of CoW mechanism in fsdax.

The rests are dax & reflink support for xfs.

(Rebased to 5.7-rc2)


Shiyang Ruan (8):
  fs/dax: Introduce dax-rmap btree for reflink
  mm: add dax-rmap for memory-failure and rmap
  fs/dax: Introduce dax_copy_edges() for COW
  fs/dax: copy data before write
  fs/dax: replace mmap entry in case of CoW
  fs/dax: dedup file range to use a compare function
  fs/xfs: handle CoW for fsdax write() path
  fs/xfs: support dedupe for fsdax

 fs/dax.c               | 343 +++++++++++++++++++++++++++++++++++++----
 fs/ocfs2/file.c        |   2 +-
 fs/read_write.c        |  11 +-
 fs/xfs/xfs_bmap_util.c |   6 +-
 fs/xfs/xfs_file.c      |  10 +-
 fs/xfs/xfs_iomap.c     |   3 +-
 fs/xfs/xfs_iops.c      |  11 +-
 fs/xfs/xfs_reflink.c   |  79 ++++++----
 include/linux/dax.h    |  11 ++
 include/linux/fs.h     |   9 +-
 mm/memory-failure.c    |  63 ++++++--
 mm/rmap.c              |  54 +++++--
 12 files changed, 498 insertions(+), 104 deletions(-)

-- 
2.26.2


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

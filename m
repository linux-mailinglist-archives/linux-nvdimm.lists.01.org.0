Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A30A22655A8
	for <lists+linux-nvdimm@lfdr.de>; Fri, 11 Sep 2020 01:47:32 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A929B13DCF675;
	Thu, 10 Sep 2020 16:47:24 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C49A013DCF66E
	for <linux-nvdimm@lists.01.org>; Thu, 10 Sep 2020 16:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=gATiEIJ5yym8gDZW7pIpWvARxJPI7Am+GdMp2jh+5MM=; b=NU+A3j4UiyhwWUqTbemQKJ7NoT
	bJbdq0iulAfED6zqYzsugnRZeP4UFzoCZXBTUxe3UU0nxN1pxpDgbXamafmx7vgty1r6sztkFceoc
	uhCtLXWHHlRk8UEarcpLejYVsKtGgEDyGzsi1+3zAjHhmygjlNrGDioIz9zRv1FhKFM6KhSKpk31W
	9giPinWY+QjDf/q+iQqddSd89v8Xi9iu/rSoc6Qc49vUBRfO7hQxKyAA3RwyRbQ3MzGLfQgWh0J7X
	BFCVnyNyY/g0MCXWFxTQJUOtq/pm5rcIOT9stXwsB8VLtzKhCFJprAB/2wZXJI9/bYGDR9edkQMRp
	lHM6Bawg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGWHU-0001RW-R5; Thu, 10 Sep 2020 23:47:08 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/9] THP iomap patches for 5.10
Date: Fri, 11 Sep 2020 00:46:58 +0100
Message-Id: <20200910234707.5504-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Message-ID-Hash: BSDFQ3I2G7GEF4W54TAI3UI52I3UJILP
X-Message-ID-Hash: BSDFQ3I2G7GEF4W54TAI3UI52I3UJILP
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, "Darrick J . Wong" <darrick.wong@oracle.com>, Christoph Hellwig <hch@infradead.org>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BSDFQ3I2G7GEF4W54TAI3UI52I3UJILP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

These patches are carefully plucked from the THP series.  I would like
them to hit 5.10 to make the THP patchset merge easier.  Some of these
are just generic improvements that make sense on their own terms, but
the overall intent is to support THPs in iomap.

v2:
 - Move the call to flush_dcache_page (Christoph)
 - Clarify comments (Darrick)
 - Rename read_count to read_bytes_pending (Christoph)
 - Rename write_count to write_bytes_pending (Christoph)
 - Restructure iomap_readpage_actor() (Christoph)
 - Change return type of the zeroing functions from loff_t to s64

Matthew Wilcox (Oracle) (9):
  iomap: Fix misplaced page flushing
  fs: Introduce i_blocks_per_page
  iomap: Use kzalloc to allocate iomap_page
  iomap: Use bitmap ops to set uptodate bits
  iomap: Support arbitrarily many blocks per page
  iomap: Convert read_count to read_bytes_pending
  iomap: Convert write_count to write_bytes_pending
  iomap: Convert iomap_write_end types
  iomap: Change calling convention for zeroing

 fs/dax.c                |  13 ++-
 fs/iomap/buffered-io.c  | 173 +++++++++++++++++-----------------------
 fs/jfs/jfs_metapage.c   |   2 +-
 fs/xfs/xfs_aops.c       |   2 +-
 include/linux/dax.h     |   3 +-
 include/linux/pagemap.h |  16 ++++
 6 files changed, 96 insertions(+), 113 deletions(-)

-- 
2.28.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E7F25003B
	for <lists+linux-nvdimm@lfdr.de>; Mon, 24 Aug 2020 16:55:56 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 955A41359E210;
	Mon, 24 Aug 2020 07:55:27 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=90.155.50.34; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1AFB213596B72
	for <linux-nvdimm@lists.01.org>; Mon, 24 Aug 2020 07:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=rtPWePEP2e2MrA1B6+d56D/W6SCtPdzXjGVhB68Hm9E=; b=mYU+Wo1zHLWgAf8PtstxsMTzeM
	l89zOmYzJ4RAebFtunciW1qLOccTUYbRyCdTC0HFhRUaFysVsGgifHdVuV+nAICugexygDYupVHqV
	Pgx88p5wQgJt3gvzhQmSRhuRsWVxpyeb3EOAahpwBmkUxMJssYiXiFutGNnBlHme91mw0lrufX/dt
	bx5Jm4KquFZu8cyiMXr7xv+0CHqsS7c/CnzDPyx3OGlyMbSVg+plp6m2GJXAthNPGuz3oVbU9HsFS
	C9b1dq1AShibohWaSk/lWESu2oP6BM+zNJFGDBsrG1QOBj4Tc/Kwcp9qKnijfzIHWXVdM+9wKdOXa
	ZIB2/1BA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kADsO-0002lr-Li; Mon, 24 Aug 2020 14:55:12 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/9] THP iomap patches for 5.10
Date: Mon, 24 Aug 2020 15:55:01 +0100
Message-Id: <20200824145511.10500-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Message-ID-Hash: YCBG3SR5N43GVVM3NTP2OCRZXOO6CZNE
X-Message-ID-Hash: YCBG3SR5N43GVVM3NTP2OCRZXOO6CZNE
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, "Darrick J . Wong" <darrick.wong@oracle.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YCBG3SR5N43GVVM3NTP2OCRZXOO6CZNE/>
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

I'll send another patch series later today which are the changes to
iomap which don't pay their own way until we actually have THPs in the
page cache.  I would like those to be reviewed with an eye to merging
them into 5.11.

Matthew Wilcox (Oracle) (9):
  iomap: Fix misplaced page flushing
  fs: Introduce i_blocks_per_page
  iomap: Use kzalloc to allocate iomap_page
  iomap: Use bitmap ops to set uptodate bits
  iomap: Support arbitrarily many blocks per page
  iomap: Convert read_count to byte count
  iomap: Convert write_count to byte count
  iomap: Convert iomap_write_end types
  iomap: Change calling convention for zeroing

 fs/dax.c                |  13 ++--
 fs/iomap/buffered-io.c  | 145 ++++++++++++++++------------------------
 fs/jfs/jfs_metapage.c   |   2 +-
 fs/xfs/xfs_aops.c       |   2 +-
 include/linux/dax.h     |   3 +-
 include/linux/pagemap.h |  16 +++++
 6 files changed, 83 insertions(+), 98 deletions(-)

-- 
2.28.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

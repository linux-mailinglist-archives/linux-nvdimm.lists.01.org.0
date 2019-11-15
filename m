Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0876FD1DB
	for <lists+linux-nvdimm@lfdr.de>; Fri, 15 Nov 2019 01:11:41 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DF03E100EEBB6;
	Thu, 14 Nov 2019 16:13:05 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.228.121.65; helo=hqemgate16.nvidia.com; envelope-from=jhubbard@nvidia.com; receiver=<UNKNOWN> 
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com [216.228.121.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A05F8100EEBB6
	for <linux-nvdimm@lists.01.org>; Thu, 14 Nov 2019 16:13:03 -0800 (PST)
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
	id <B5dcded000003>; Thu, 14 Nov 2019 16:10:40 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 14 Nov 2019 16:11:36 -0800
X-PGP-Universal: processed;
	by hqpgpgate102.nvidia.com on Thu, 14 Nov 2019 16:11:36 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 15 Nov
 2019 00:11:35 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 15 Nov
 2019 00:11:35 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 15 Nov 2019 00:11:36 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
	id <B5dcded370000>; Thu, 14 Nov 2019 16:11:35 -0800
From: John Hubbard <jhubbard@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/2] mm: devmap: page-freeing related cleanups
Date: Thu, 14 Nov 2019 16:11:32 -0800
Message-ID: <20191115001134.2489505-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
	t=1573776640; bh=Mrh+2x3rLyg/1Ohx9ZbAHZm/a7AggeIHJioHTmLGuI0=;
	h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-NVConfidentiality:Content-Type:
	 Content-Transfer-Encoding;
	b=DZcZ0SoDzKuC008CDMbWmWtK8o3RU+gyRqoH79kkT0C1ay6qRmo2hejSoX2HpGy/B
	 +5FabwWpsUQUGv8HHmkIYTnL1y/2+GbIHQOf+mFA6oxSXk1bk7grxs6uzcJca/E1Xm
	 8esnQQdLhoMkpKRgjCX2BSCBt9xhr2xYmv9nMeg5OCxdVG2RRQbp1v01apcLfL/nM+
	 luqycv7RgfjPWuNN9EFxR38gL8JzhKV5dkzHP42ybDarrmwsm+ioY9m1fJDa4Hb+h1
	 L5/C7iLg1GLeumAXkNYMa/UajJH9HNrt+MaBA2vR328TSNs2V0wznLS3wVBllnpxX1
	 kU7XWzoQehkGw==
Message-ID-Hash: LU6IAQKEMTOIHRO2WVNBXWA3AMKBMOJY
X-Message-ID-Hash: LU6IAQKEMTOIHRO2WVNBXWA3AMKBMOJY
X-MailFrom: jhubbard@nvidia.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>, =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, linux-nvdimm@lists.01.org, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, John Hubbard <jhubbard@nvidia.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LU6IAQKEMTOIHRO2WVNBXWA3AMKBMOJY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

Here are the small devmap page-freeing cleanups as requested, so that
they can be reviewed separately from the larger "track dma-pinned pages
series" [1] that they were originally part of.

I did not add Jan Kara's and Jerome Glisse's reviewed-by tags, because those
were for patch 2 but as part of [1], which is different enough from this
series that I couldn't treat it as "close enough".

Testing: Dan notes that his patch (1) has passed nvdimm unit tests. However,
I have not yet done much testing of the two patches together. What
I've done so far is to boot up a system that has CONFIG_DEV_PAGEMAP_OPS=y
and run LTP tests on it, but none of those tests are exercising
free_devmap_managed_page().

Dan, if you could run this combined set through your unit tests, I'd feel
a lot better about it. I'll also work on getting my HMM test setup revived.


[1] https://lore.kernel.org/r/20191113042710.3997854-1-jhubbard@nvidia.com

Dan Williams (1):
  mm: Cleanup __put_devmap_managed_page() vs ->page_free()

John Hubbard (1):
  mm: devmap: refactor 1-based refcounting for ZONE_DEVICE pages

 drivers/nvdimm/pmem.c |  6 ----
 include/linux/mm.h    | 27 +++++++++++++--
 mm/memremap.c         | 76 ++++++++++++++++++++-----------------------
 3 files changed, 60 insertions(+), 49 deletions(-)

-- 
2.24.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

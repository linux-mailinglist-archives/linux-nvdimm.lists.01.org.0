Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F135B499
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Jul 2019 08:20:34 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 60CB2212A36ED;
	Sun, 30 Jun 2019 23:20:33 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=batv+bb02ddf78a79a38d855c+5790+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 9A8F22129641A
 for <linux-nvdimm@lists.01.org>; Sun, 30 Jun 2019 23:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UlLC8XGw3CfveOE+CE9qUf9ABEe6OmzNIUUnRKazXzE=; b=mMtjeXqRDcDlmyLmrlKFtZtdRU
 1ZECHbYWTfCpkYG1u7NxycM68aGZsaYVHMGnG4IQzU0TAgr9BXvJmFLjN1uPnSkkanle0EQD+/cUS
 ysH15a0tARem1UDKd65mwKxipLWalrdQsGtNrZr4Ay04rG8pu2TsMymVBvSIJ23mdukOSrcE5tXS+
 BWHN4YZYUOMExmZHWnv83906SilXzAL2f2pgaif+KbkA2D1AQX1pNsvBi8cwWmL7Fz0f8pQe7JPnj
 XXI8WLRTzHBt3FMBIQfyW16QH39tSa/OW8ex+6Eu1UTsQsmyJMJobkLg5Jcwv6wJjHpb7mHbkiY/n
 MjKn053w==;
Received: from [46.140.178.35] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hhpfs-0002sg-H6; Mon, 01 Jul 2019 06:20:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 01/22] mm/hmm.c: suppress compilation warnings when
 CONFIG_HUGETLB_PAGE is not set
Date: Mon,  1 Jul 2019 08:19:59 +0200
Message-Id: <20190701062020.19239-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701062020.19239-1-hch@lst.de>
References: <20190701062020.19239-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, nouveau@lists.freedesktop.org,
 Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

From: Jason Gunthorpe <jgg@mellanox.com>

gcc reports that several variables are defined but not used.

For the first hunk CONFIG_HUGETLB_PAGE the entire if block is already
protected by pud_huge() which is forced to 0.  None of the stuff under the
ifdef causes compilation problems as it is already stubbed out in the
header files.

For the second hunk the dummy huge_page_shift macro doesn't touch the
argument, so just inline the argument.

Link: http://lkml.kernel.org/r/20190522195151.GA23955@ziepe.ca
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/hmm.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index c5d840e34b28..c62ae414a3a2 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -788,7 +788,6 @@ static int hmm_vma_walk_pud(pud_t *pudp,
 			return hmm_vma_walk_hole_(addr, end, fault,
 						write_fault, walk);
 
-#ifdef CONFIG_HUGETLB_PAGE
 		pfn = pud_pfn(pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
 		for (i = 0; i < npages; ++i, ++pfn) {
 			hmm_vma_walk->pgmap = get_dev_pagemap(pfn,
@@ -804,9 +803,6 @@ static int hmm_vma_walk_pud(pud_t *pudp,
 		}
 		hmm_vma_walk->last = end;
 		return 0;
-#else
-		return -EINVAL;
-#endif
 	}
 
 	split_huge_pud(walk->vma, pudp, addr);
@@ -1015,9 +1011,8 @@ long hmm_range_snapshot(struct hmm_range *range)
 			return -EFAULT;
 
 		if (is_vm_hugetlb_page(vma)) {
-			struct hstate *h = hstate_vma(vma);
-
-			if (huge_page_shift(h) != range->page_shift &&
+			if (huge_page_shift(hstate_vma(vma)) !=
+				    range->page_shift &&
 			    range->page_shift != PAGE_SHIFT)
 				return -EINVAL;
 		} else {
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

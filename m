Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A27989087
	for <lists+linux-nvdimm@lfdr.de>; Sun, 11 Aug 2019 10:13:05 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8436821959CB2;
	Sun, 11 Aug 2019 01:15:34 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=batv+ae155d32c5e98ef18dee+5831+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4A32D212E8426
 for <linux-nvdimm@lists.01.org>; Sun, 11 Aug 2019 01:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y01FamiaByfIvO4XPWaRUQIkSGmHIczQrp+AHvWAufA=; b=RipnxiPt/PMVgl31RtWtQJu3OX
 VrtuUEa9DBkTysRlMPDs1dgFUPp6qSJxDMt8qbJIFjXY/4T/9DAI7jJLR/l2QUJ1Wr9wEEXr5LAFk
 Fc8vtOysZAZCOegxYg4kgsM9/0zvRpon6JcD/C5G8Op2oi4kUx8EBWDh5SfZhCgKFDpQF/2Vxy87W
 JebOmEQSEZX2iS4UyphPWLOkEXGYARp8ynsC9ruErseHKFgsWmV9WDZU0NnMtbKg2xMhYlZQVqBUV
 Dkkj6+wq8Q0is5FJ/jAexn89X7iyHKgpKE9rC9YP5uR6T7HX7Ir9Wrurtsb57fn8FnyfLdogrv0Cf
 +fokE9LQ==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hwiyI-0005DL-9r; Sun, 11 Aug 2019 08:12:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 3/5] memremap: remove the dev field in struct dev_pagemap
Date: Sun, 11 Aug 2019 10:12:45 +0200
Message-Id: <20190811081247.22111-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190811081247.22111-1-hch@lst.de>
References: <20190811081247.22111-1-hch@lst.de>
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
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
 Bharata B Rao <bharata@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

The dev field in struct dev_pagemap is only used to print dev_name in
two places, which are at best nice to have.  Just remove the field
and thus the name in those two messages.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/memremap.h | 1 -
 mm/memremap.c            | 6 +-----
 mm/page_alloc.c          | 2 +-
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index f8a5b2a19945..8f0013e18e14 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -109,7 +109,6 @@ struct dev_pagemap {
 	struct percpu_ref *ref;
 	struct percpu_ref internal_ref;
 	struct completion done;
-	struct device *dev;
 	enum memory_type type;
 	unsigned int flags;
 	u64 pci_p2pdma_bus_offset;
diff --git a/mm/memremap.c b/mm/memremap.c
index 6ee03a816d67..600a14cbe663 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -96,7 +96,6 @@ static void dev_pagemap_cleanup(struct dev_pagemap *pgmap)
 static void devm_memremap_pages_release(void *data)
 {
 	struct dev_pagemap *pgmap = data;
-	struct device *dev = pgmap->dev;
 	struct resource *res = &pgmap->res;
 	unsigned long pfn;
 	int nid;
@@ -123,8 +122,7 @@ static void devm_memremap_pages_release(void *data)
 
 	untrack_pfn(NULL, PHYS_PFN(res->start), resource_size(res));
 	pgmap_array_delete(res);
-	dev_WARN_ONCE(dev, pgmap->altmap.alloc,
-		      "%s: failed to free all reserved pages\n", __func__);
+	WARN_ONCE(pgmap->altmap.alloc, "failed to free all reserved pages\n");
 }
 
 static void dev_pagemap_percpu_release(struct percpu_ref *ref)
@@ -245,8 +243,6 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 		goto err_array;
 	}
 
-	pgmap->dev = dev;
-
 	error = xa_err(xa_store_range(&pgmap_array, PHYS_PFN(res->start),
 				PHYS_PFN(res->end), pgmap, GFP_KERNEL));
 	if (error)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 272c6de1bf4e..b39baa2b1faf 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5982,7 +5982,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 		}
 	}
 
-	pr_info("%s initialised, %lu pages in %ums\n", dev_name(pgmap->dev),
+	pr_info("%s initialised %lu pages in %ums\n", __func__,
 		size, jiffies_to_msecs(jiffies - start));
 }
 
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

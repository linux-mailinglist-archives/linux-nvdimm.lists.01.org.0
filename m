Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFF3434C6
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Jun 2019 11:43:45 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AAA66212963F5;
	Thu, 13 Jun 2019 02:43:42 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=batv+aff2f865c54b6c032bcd+5772+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id CDD98212963E0
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 02:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xP52k8PSxiWJA231A7iOWwtNJf1wPwc/yjXMJD2RBtk=; b=YfEdLD5CH3U9ysOCwdL2FYmTCm
 7+M9qmqGSvaM914U2KnoFaX+n4shPpJhrUd/PvcrkZkqrHimpFDBxMasr7oVEDrDKecmBuTaLZCGM
 iT/KWUgZgRrB5zdJ/8S6pGh3KqkYgPjzhaOvvfgtZVAUrvCGJ6viIrfd+IFAUOmCbaSXdn3Xqi6dP
 IyH7Omvq4XCgzsLItQEh8dQn6hfmBqy4TB1udG/rSepK2+eOtVvT3UK4eCYBuVf36OinvPDjaWT7K
 MXnnYC67WwxGCvY3QR0pM8YGYOMCMRIMWbIz573pF9NwIAyI8Sbpnmm+OJEQEqq7JYkUxrcjdGlkh
 kmjcQnIg==;
Received: from mpp-cp1-natpool-1-198.ethz.ch ([82.130.71.198] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hbMGf-0001kQ-VY; Thu, 13 Jun 2019 09:43:38 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 03/22] mm: remove hmm_devmem_add_resource
Date: Thu, 13 Jun 2019 11:43:06 +0200
Message-Id: <20190613094326.24093-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613094326.24093-1-hch@lst.de>
References: <20190613094326.24093-1-hch@lst.de>
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
 linux-mm@kvack.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

This function has never been used since it was first added to the kernel
more than a year and a half ago, and if we ever grow a consumer of the
MEMORY_DEVICE_PUBLIC infrastructure it can easily use devm_memremap_pages
directly now that we've simplified the API for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/hmm.h |  3 ---
 mm/hmm.c            | 54 ---------------------------------------------
 2 files changed, 57 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 4867b9da1b6c..5761a39221a6 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -688,9 +688,6 @@ struct hmm_devmem {
 struct hmm_devmem *hmm_devmem_add(const struct hmm_devmem_ops *ops,
 				  struct device *device,
 				  unsigned long size);
-struct hmm_devmem *hmm_devmem_add_resource(const struct hmm_devmem_ops *ops,
-					   struct device *device,
-					   struct resource *res);
 
 /*
  * hmm_devmem_page_set_drvdata - set per-page driver data field
diff --git a/mm/hmm.c b/mm/hmm.c
index ff2598eb7377..0c62426d1257 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -1445,58 +1445,4 @@ struct hmm_devmem *hmm_devmem_add(const struct hmm_devmem_ops *ops,
 	return devmem;
 }
 EXPORT_SYMBOL_GPL(hmm_devmem_add);
-
-struct hmm_devmem *hmm_devmem_add_resource(const struct hmm_devmem_ops *ops,
-					   struct device *device,
-					   struct resource *res)
-{
-	struct hmm_devmem *devmem;
-	void *result;
-	int ret;
-
-	if (res->desc != IORES_DESC_DEVICE_PUBLIC_MEMORY)
-		return ERR_PTR(-EINVAL);
-
-	dev_pagemap_get_ops();
-
-	devmem = devm_kzalloc(device, sizeof(*devmem), GFP_KERNEL);
-	if (!devmem)
-		return ERR_PTR(-ENOMEM);
-
-	init_completion(&devmem->completion);
-	devmem->pfn_first = -1UL;
-	devmem->pfn_last = -1UL;
-	devmem->resource = res;
-	devmem->device = device;
-	devmem->ops = ops;
-
-	ret = percpu_ref_init(&devmem->ref, &hmm_devmem_ref_release,
-			      0, GFP_KERNEL);
-	if (ret)
-		return ERR_PTR(ret);
-
-	ret = devm_add_action_or_reset(device, hmm_devmem_ref_exit,
-			&devmem->ref);
-	if (ret)
-		return ERR_PTR(ret);
-
-	devmem->pfn_first = devmem->resource->start >> PAGE_SHIFT;
-	devmem->pfn_last = devmem->pfn_first +
-			   (resource_size(devmem->resource) >> PAGE_SHIFT);
-	devmem->page_fault = hmm_devmem_fault;
-
-	devmem->pagemap.type = MEMORY_DEVICE_PUBLIC;
-	devmem->pagemap.res = *devmem->resource;
-	devmem->pagemap.page_free = hmm_devmem_free;
-	devmem->pagemap.altmap_valid = false;
-	devmem->pagemap.ref = &devmem->ref;
-	devmem->pagemap.data = devmem;
-	devmem->pagemap.kill = hmm_devmem_ref_kill;
-
-	result = devm_memremap_pages(devmem->device, &devmem->pagemap);
-	if (IS_ERR(result))
-		return result;
-	return devmem;
-}
-EXPORT_SYMBOL_GPL(hmm_devmem_add_resource);
 #endif /* CONFIG_DEVICE_PRIVATE || CONFIG_DEVICE_PUBLIC */
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

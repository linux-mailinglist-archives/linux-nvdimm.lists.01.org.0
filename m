Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 282E74822E
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Jun 2019 14:28:28 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0B0992129EB94;
	Mon, 17 Jun 2019 05:28:27 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=batv+a9ecd0bfb5b639be820a+5776+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 3D2012129DBAA
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 05:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rfiOsXsxRAZCFDVo21abTS19/9zGASI6nRdrjMvZ5Iw=; b=oLig9/TEaZEXPR+t7+dEa5tPGZ
 RpcPa/hgJAoKo4WO6XIcMV1sCs82yI/lf9OjzRWEj+XFibg0CgidALCirzn9I/Ux8nEqBtGYl0Qhp
 UjkLcxgYpbFIOCt2hu8a+nzyW05x/LYTS/62NJNSg1oHibCDD2QPN0COJRNN2zrq9SkAjfzaA6Lr+
 zYAG9oM+7PFTegy2bOQY0pdWVMTOTKk33rjMgeztaj1iyS1JvSCd/oKCL5f0rojkYJR/4cRDYuLKc
 J4VWWF9tGqI6teBCMBGayYjyd6VOGU6+ryOE8y398cTseQsF6pbV13QaK/gGJKuNaKx6HgHODXtXL
 AcMMPXXQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hcqkF-0000KX-9f; Mon, 17 Jun 2019 12:28:19 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 19/25] mm: remove hmm_vma_alloc_locked_page
Date: Mon, 17 Jun 2019 14:27:27 +0200
Message-Id: <20190617122733.22432-20-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617122733.22432-1-hch@lst.de>
References: <20190617122733.22432-1-hch@lst.de>
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

The only user of it has just been removed, and there wasn't really any need
to wrap a basic memory allocator to start with.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/hmm.h |  3 ---
 mm/hmm.c            | 14 --------------
 2 files changed, 17 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index e64824334b85..89571e8d9c63 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -589,9 +589,6 @@ static inline void hmm_mm_init(struct mm_struct *mm) {}
 #if IS_ENABLED(CONFIG_DEVICE_PRIVATE) ||  IS_ENABLED(CONFIG_DEVICE_PUBLIC)
 struct hmm_devmem;
 
-struct page *hmm_vma_alloc_locked_page(struct vm_area_struct *vma,
-				       unsigned long addr);
-
 /*
  * struct hmm_devmem_ops - callback for ZONE_DEVICE memory events
  *
diff --git a/mm/hmm.c b/mm/hmm.c
index 307c12d7531c..0ef1a1921afb 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -1327,20 +1327,6 @@ EXPORT_SYMBOL(hmm_range_dma_unmap);
 
 
 #if IS_ENABLED(CONFIG_DEVICE_PRIVATE) ||  IS_ENABLED(CONFIG_DEVICE_PUBLIC)
-struct page *hmm_vma_alloc_locked_page(struct vm_area_struct *vma,
-				       unsigned long addr)
-{
-	struct page *page;
-
-	page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
-	if (!page)
-		return NULL;
-	lock_page(page);
-	return page;
-}
-EXPORT_SYMBOL(hmm_vma_alloc_locked_page);
-
-
 static void hmm_devmem_ref_release(struct percpu_ref *ref)
 {
 	struct hmm_devmem *devmem;
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

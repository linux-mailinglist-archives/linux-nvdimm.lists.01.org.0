Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F165B4CD
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Jul 2019 08:21:09 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 182E3212ABA53;
	Sun, 30 Jun 2019 23:21:08 -0700 (PDT)
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
 by ml01.01.org (Postfix) with ESMTPS id 68AFE212A36E9
 for <linux-nvdimm@lists.01.org>; Sun, 30 Jun 2019 23:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NOvUE3MK4PBUVZYjodBNHK+lKTK0X5FfG0LU1tN7KYg=; b=HxhHD1pjEjG0nbECxGzrXlhFSd
 pYZ6FWrI65g6HDmRODhykjBJp0i+FO3Uewll57/9um1FFD20gH4ojUuQNOIz01ZkUrcxNvZkRgUQN
 d4BYKfrRc9cM6YWvqKXEPU/9hSQZ8afF1Nc8uwN+hYuTZ6mIozhJx0vvBN4rmktvAuaDt+9DRD7YH
 Yt7ORdztBsdCgvFNEe2JgqOp59ScdlPwB/6u5xSmz78zlZR86fRRWnEUBJQYKEd5eEJyrKgYxL8Vc
 B6Ul4VaxPsIcxuFe3qolUUFbeMuW1AiRr8uD2U7S106Nnsa8IJBj/Ut4/rYC3XSWoJDmQO9jELO9k
 1eio7AzQ==;
Received: from [46.140.178.35] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hhpgV-0003Cs-5p; Mon, 01 Jul 2019 06:21:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 18/22] mm: return valid info from hmm_range_unregister
Date: Mon,  1 Jul 2019 08:20:16 +0200
Message-Id: <20190701062020.19239-19-hch@lst.de>
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
 linux-mm@kvack.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Checking range->valid is trivial and has no meaningful cost, but
nicely simplifies the fastpath in typical callers.  Also remove the
hmm_vma_range_done function, which now is a trivial wrapper around
hmm_range_unregister.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c |  2 +-
 include/linux/hmm.h                   | 11 +----------
 mm/hmm.c                              |  6 +++++-
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index 8c92374afcf2..9d40114d7949 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -652,7 +652,7 @@ nouveau_svm_fault(struct nvif_notify *notify)
 		ret = hmm_vma_fault(&svmm->mirror, &range, true);
 		if (ret == 0) {
 			mutex_lock(&svmm->mutex);
-			if (!hmm_vma_range_done(&range)) {
+			if (!hmm_range_unregister(&range)) {
 				mutex_unlock(&svmm->mutex);
 				goto again;
 			}
diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 0fa8ea34ccef..4b185d286c3b 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -465,7 +465,7 @@ int hmm_range_register(struct hmm_range *range,
 		       unsigned long start,
 		       unsigned long end,
 		       unsigned page_shift);
-void hmm_range_unregister(struct hmm_range *range);
+bool hmm_range_unregister(struct hmm_range *range);
 long hmm_range_snapshot(struct hmm_range *range);
 long hmm_range_fault(struct hmm_range *range, bool block);
 long hmm_range_dma_map(struct hmm_range *range,
@@ -487,15 +487,6 @@ long hmm_range_dma_unmap(struct hmm_range *range,
  */
 #define HMM_RANGE_DEFAULT_TIMEOUT 1000
 
-/* This is a temporary helper to avoid merge conflict between trees. */
-static inline bool hmm_vma_range_done(struct hmm_range *range)
-{
-	bool ret = hmm_range_valid(range);
-
-	hmm_range_unregister(range);
-	return ret;
-}
-
 /* This is a temporary helper to avoid merge conflict between trees. */
 static inline int hmm_vma_fault(struct hmm_mirror *mirror,
 				struct hmm_range *range, bool block)
diff --git a/mm/hmm.c b/mm/hmm.c
index de35289df20d..c85ed7d4e2ce 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -920,11 +920,14 @@ EXPORT_SYMBOL(hmm_range_register);
  *
  * Range struct is used to track updates to the CPU page table after a call to
  * hmm_range_register(). See include/linux/hmm.h for how to use it.
+ *
+ * Returns if the range was still valid at the time of unregistering.
  */
-void hmm_range_unregister(struct hmm_range *range)
+bool hmm_range_unregister(struct hmm_range *range)
 {
 	struct hmm *hmm = range->hmm;
 	unsigned long flags;
+	bool ret = range->valid;
 
 	spin_lock_irqsave(&hmm->ranges_lock, flags);
 	list_del_init(&range->list);
@@ -941,6 +944,7 @@ void hmm_range_unregister(struct hmm_range *range)
 	 */
 	range->valid = false;
 	memset(&range->hmm, POISON_INUSE, sizeof(range->hmm));
+	return ret;
 }
 EXPORT_SYMBOL(hmm_range_unregister);
 
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

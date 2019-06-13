Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35878434DB
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Jun 2019 11:44:15 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 11B0421296404;
	Thu, 13 Jun 2019 02:44:14 -0700 (PDT)
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
 by ml01.01.org (Postfix) with ESMTPS id EF7D7212963FE
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 02:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=j5NF6MNZYGnulaE88E08I95IgTMRhrbK2u/HLXeuvXI=; b=Ac6u1kwcs5Qa+uMIZP26VzBqh1
 oBc3B77m8cKbTSEIFPsUyGP6G3FUk3c8E+xk2HZWozHXtClsdTiu2RALXiDqDY43JEV1DWM9l1/Du
 GMJh/5UGQizxUaLO1dcsKhrvI14c20vJPjJ7jreMh9910F1WY99XI00fTC0entGgeaSQZLCs86xfW
 52vn6lM51A13Btvh++2O9/BZ39MqDd/CCOhxXr/jPAHEUNdYFrNi3zls/lufPVZvRZbXCwxBGi+w3
 avf91FXeX0uy9xYlvIoYY88p2jQx1BQy8vySwJ/yFSSrfYf9r3j/UGnyKprb+nbDw7XgChANaBwwz
 q7RSMx1Q==;
Received: from mpp-cp1-natpool-1-198.ethz.ch ([82.130.71.198] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hbMHB-0001sa-6c; Thu, 13 Jun 2019 09:44:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 14/22] nouveau: use alloc_page_vma directly
Date: Thu, 13 Jun 2019 11:43:17 +0200
Message-Id: <20190613094326.24093-15-hch@lst.de>
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

hmm_vma_alloc_locked_page is scheduled to go away, use the proper
mm function directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index 40c47d6a7d78..a50f6fd2fe24 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -148,11 +148,12 @@ nouveau_dmem_fault_alloc_and_copy(struct vm_area_struct *vma,
 		if (!spage || !(src_pfns[i] & MIGRATE_PFN_MIGRATE))
 			continue;
 
-		dpage = hmm_vma_alloc_locked_page(vma, addr);
+		dpage = alloc_page_vma(GFP_HIGHUSER, vma, addr);
 		if (!dpage) {
 			dst_pfns[i] = MIGRATE_PFN_ERROR;
 			continue;
 		}
+		lock_page(dpage);
 
 		dst_pfns[i] = migrate_pfn(page_to_pfn(dpage)) |
 			      MIGRATE_PFN_LOCKED;
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

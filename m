Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D50434EC
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Jun 2019 11:44:39 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 04CDA21296418;
	Thu, 13 Jun 2019 02:44:38 -0700 (PDT)
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
 by ml01.01.org (Postfix) with ESMTPS id 8D3B921296070
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 02:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0sAfzDlcAsndHKBt75dqqx/GnOCOQqtRdathOjahJzQ=; b=trz7K9USBFzK+xAnepin47AmRr
 Ru/Ufe0ArOAav00lGoPPzRUVxrswp05DRpD2d5fXaeZItnlHIGrtF1O1z/B5eK/v1ypkuEUV33AoE
 O6sWXD/9uMVmrJLXNRSSRwxNiWV3okj38PS6HOorCIE1095zMfIxNPliWKgHj+KFNGQYjRJfvAAE9
 OZPPi7DMhfjs+Ay9FbxkmMkIi0kMa6qSNkzN8TL3yorsUR6y30VoiV0rQhnhlXUczuR6wnoc3Tr3D
 5CrUdFq3rR6UxwQZviB1fSzfyE69t0fvrojVXmSEKwbbynKreccgHDzaxSTGmzkzt23o/mQnE0h+e
 YEeclslA==;
Received: from mpp-cp1-natpool-1-198.ethz.ch ([82.130.71.198] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hbMHY-0001yQ-Rm; Thu, 13 Jun 2019 09:44:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 22/22] mm: don't select MIGRATE_VMA_HELPER from HMM_MIRROR
Date: Thu, 13 Jun 2019 11:43:25 +0200
Message-Id: <20190613094326.24093-23-hch@lst.de>
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

The migrate_vma helper is only used by noveau to migrate device private
pages around.  Other HMM_MIRROR users like amdgpu or infiniband don't
need it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/nouveau/Kconfig | 1 +
 mm/Kconfig                      | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
index 66c839d8e9d1..96b9814e6d06 100644
--- a/drivers/gpu/drm/nouveau/Kconfig
+++ b/drivers/gpu/drm/nouveau/Kconfig
@@ -88,6 +88,7 @@ config DRM_NOUVEAU_SVM
 	depends on DRM_NOUVEAU
 	depends on HMM_MIRROR
 	depends on STAGING
+	select MIGRATE_VMA_HELPER
 	default n
 	help
 	  Say Y here if you want to enable experimental support for
diff --git a/mm/Kconfig b/mm/Kconfig
index 73676cb4693f..eca88679b624 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -679,7 +679,6 @@ config HMM_MIRROR
 	bool "HMM mirror CPU page table into a device page table"
 	depends on MMU
 	select MMU_NOTIFIER
-	select MIGRATE_VMA_HELPER
 	help
 	  Select HMM_MIRROR if you want to mirror range of the CPU page table of a
 	  process into a device page table. Here, mirror means "keep synchronized".
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

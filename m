Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FC189085
	for <lists+linux-nvdimm@lfdr.de>; Sun, 11 Aug 2019 10:13:02 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6E86A212E844F;
	Sun, 11 Aug 2019 01:15:29 -0700 (PDT)
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
 by ml01.01.org (Postfix) with ESMTPS id B657E2194EB78
 for <linux-nvdimm@lists.01.org>; Sun, 11 Aug 2019 01:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MRcXDHnvegEnPa14nfQi3BqEN+g8pBHoWHKAcBcbf9E=; b=bhgtFlj77SWSlCwSjYILq91ceo
 78PkXlraHml2oYRTR5Aj0jTSFviOVyqPHDDUnkcmKulGthcCrePG5BcGiGmgD/LDTEFbLvyt/4rMx
 F9i1oqG6lWV8fjRskKRWX8E8Az+mbfrzAuX+sPxz3sffgBLwEZab/+CfuUHtZfxgh1MxIdIyqqsqX
 IDgtMnbPis2tx5d2oflU1k3GlUhBYF2HmdBl18+u1jcwetya75loik3xMKD2nrkC+5BwuhWMM4DBH
 NrztwG5lvsVuKAtIQBHkFCgrusv8on3mHMP4SVFrhXvL1jJs1azM0fbcipVQUSUH5efpD3zTzGkiS
 vK/3xEtQ==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hwiyF-0005Co-Hc; Sun, 11 Aug 2019 08:12:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 2/5] resource: add a not device managed
 request_free_mem_region variant
Date: Sun, 11 Aug 2019 10:12:44 +0200
Message-Id: <20190811081247.22111-3-hch@lst.de>
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

Just add a simple macro that passes a NULL dev argument to
dev_request_free_mem_region, and call request_mem_region in the
function for that particular case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/ioport.h | 2 ++
 kernel/resource.c      | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 0dcc48cafa80..528ae6cbb1b4 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -297,6 +297,8 @@ static inline bool resource_overlaps(struct resource *r1, struct resource *r2)
 
 struct resource *devm_request_free_mem_region(struct device *dev,
 		struct resource *base, unsigned long size, const char *name);
+#define request_free_mem_region(base, size, name) \
+	devm_request_free_mem_region(NULL, base, size, name)
 
 #endif /* __ASSEMBLY__ */
 #endif	/* _LINUX_IOPORT_H */
diff --git a/kernel/resource.c b/kernel/resource.c
index 0ddc558586a7..3a826b3cc883 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1671,7 +1671,10 @@ struct resource *devm_request_free_mem_region(struct device *dev,
 				REGION_DISJOINT)
 			continue;
 
-		res = devm_request_mem_region(dev, addr, size, name);
+		if (dev)
+			res = devm_request_mem_region(dev, addr, size, name);
+		else
+			res = request_mem_region(addr, size, name);
 		if (!res)
 			return ERR_PTR(-ENOMEM);
 		res->desc = IORES_DESC_DEVICE_PRIVATE_MEMORY;
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

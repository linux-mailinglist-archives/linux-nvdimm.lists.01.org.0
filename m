Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB0C48203
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Jun 2019 14:27:48 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D726E21296B30;
	Mon, 17 Jun 2019 05:27:46 -0700 (PDT)
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
 by ml01.01.org (Postfix) with ESMTPS id DFEDD2128A65C
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 05:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PvDb2Ox1k4dZazYGdHDZANbuB1HI2/N93WOg6eXhjAQ=; b=sb1bPHYSDLwe702WgBPwsLs+J0
 vhPm0vc39IREraw5fNiKWwVi9b2XYJL8w6l2OeJY6AgdG8fPQh63r1aibZKvGoX4P777qmADQIXze
 OYKNAjycAzImv4MUUNJ1Sv6fOnX95UP0Tu509ppILxE5n4d614sDWPMcRXsHXnhq1gEXEUCA1AvUq
 OqgqDRRmXt/AFAdHkWOVd0/MMaDaR60es8wSgvkI32aP283KFFhUOZkJ79kLqoS/P/7e6eF2EVA7o
 0cDAzMOCQw8d61JCfYZgkqA5mYDhyXUXH6xL/G5qSJueB/oc/v0KwCGT+woKWUhfY5a9eI/qAtVq6
 jjs4LpNQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hcqjb-0008KG-Cp; Mon, 17 Jun 2019 12:27:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 01/25] mm: remove the unused ARCH_HAS_HMM_DEVICE Kconfig option
Date: Mon, 17 Jun 2019 14:27:09 +0200
Message-Id: <20190617122733.22432-2-hch@lst.de>
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
---
 mm/Kconfig | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index f0c76ba47695..0d2ba7e1f43e 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -675,16 +675,6 @@ config ARCH_HAS_HMM_MIRROR
 	depends on (X86_64 || PPC64)
 	depends on MMU && 64BIT
 
-config ARCH_HAS_HMM_DEVICE
-	bool
-	default y
-	depends on (X86_64 || PPC64)
-	depends on MEMORY_HOTPLUG
-	depends on MEMORY_HOTREMOVE
-	depends on SPARSEMEM_VMEMMAP
-	depends on ARCH_HAS_ZONE_DEVICE
-	select XARRAY_MULTI
-
 config ARCH_HAS_HMM
 	bool
 	default y
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6232A6FC62
	for <lists+linux-nvdimm@lfdr.de>; Mon, 22 Jul 2019 11:41:52 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4C62E212BC470;
	Mon, 22 Jul 2019 02:44:17 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=batv+8b691fc55bcfc6b3008b+5811+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E8E5C212B6D70
 for <linux-nvdimm@lists.01.org>; Mon, 22 Jul 2019 02:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uuCke/m1jxxr5tTC/Z7FAkFIKWk99JBUnhxnHFx1S5k=; b=WXncvnAfRIhXiNhfTvFgzTSrF
 ZeDnrZaWqROY3q3TyF6+hGQSvWWIqJD7MeOQoMk2WZfLDNomf3R8pV6dpv5+mvmHXTpeI0UX4RNUb
 hkDTyr1coiXAyEeAdPb4CXbPQALKGS57XYw9PzDyGdU9Z+CS1erUFKlVunUphg5QtGfA11SuI7rsd
 ChVghFzuHlEUhYWDLVjXggS1uDOscMM3UYgK2ZtbOaIG4ZTTXfRKdD6YE+r6yOBrLNmlIcVbvsbhg
 1PjGys38TyqD6c6dJsU1JVr/v3+VJT097jYWFnAFx4U9ZFuPcYA01JJmQi4DL3qInrz7U/mzTF/F+
 z7WiJCYBg==;
Received: from 089144207240.atnat0016.highway.bob.at ([89.144.207.240]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hpUpF-0001Az-4X; Mon, 22 Jul 2019 09:41:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: dan.j.williams@intel.com,
	akpm@linux-foundation.org
Subject: [PATCH] memremap: move from kernel/ to mm/
Date: Mon, 22 Jul 2019 11:41:43 +0200
Message-Id: <20190722094143.18387-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
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
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

memremap.c implements MM functionality for ZONE_DEVICE, so it really
should be in the mm/ directory, not the kernel/ one.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Sending for applying just after -rc1 preferably to avoid conflicts
later in the merge window

 kernel/Makefile           | 1 -
 mm/Makefile               | 1 +
 {kernel => mm}/memremap.c | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename {kernel => mm}/memremap.c (100%)

diff --git a/kernel/Makefile b/kernel/Makefile
index a8d923b5481b..ef0d95a190b4 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -111,7 +111,6 @@ obj-$(CONFIG_CONTEXT_TRACKING) += context_tracking.o
 obj-$(CONFIG_TORTURE_TEST) += torture.o
 
 obj-$(CONFIG_HAS_IOMEM) += iomem.o
-obj-$(CONFIG_ZONE_DEVICE) += memremap.o
 obj-$(CONFIG_RSEQ) += rseq.o
 
 obj-$(CONFIG_GCC_PLUGIN_STACKLEAK) += stackleak.o
diff --git a/mm/Makefile b/mm/Makefile
index 338e528ad436..d0b295c3b764 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -102,5 +102,6 @@ obj-$(CONFIG_FRAME_VECTOR) += frame_vector.o
 obj-$(CONFIG_DEBUG_PAGE_REF) += debug_page_ref.o
 obj-$(CONFIG_HARDENED_USERCOPY) += usercopy.o
 obj-$(CONFIG_PERCPU_STATS) += percpu-stats.o
+obj-$(CONFIG_ZONE_DEVICE) += memremap.o
 obj-$(CONFIG_HMM_MIRROR) += hmm.o
 obj-$(CONFIG_MEMFD_CREATE) += memfd.o
diff --git a/kernel/memremap.c b/mm/memremap.c
similarity index 100%
rename from kernel/memremap.c
rename to mm/memremap.c
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38577332F6A
	for <lists+linux-nvdimm@lfdr.de>; Tue,  9 Mar 2021 20:58:36 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6F652100EB847;
	Tue,  9 Mar 2021 11:58:34 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7C3BA100EB844
	for <linux-nvdimm@lists.01.org>; Tue,  9 Mar 2021 11:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=RGjaGTfkSxj6Autv9FlufontkwdJU9wp0hD2xAby0Vk=; b=HniCgkZiRZw/fimxF5B4BgBAnw
	daSqwlIyut8hHJqoP5oXZFUQ0MF/Mpy9+mFq0EuPBIR+of1znBQDFc1pQ9X5qyOONnyvOAOMKUMfh
	ADMLHqb5hK/03a4N8OVc9fzdooAaoBFcz+Dd/97IpzSblliTwSK8s7ZgcjIqvSUtp/n33rFfhRGMU
	rIWDE+uNIaOW8EWrjZNcwWCeHTFQ4lnIlhFdIwnAiVKq8IAUQHB3ZtKFXMJHpKqzQOQ1pMXcUlMcM
	CS4wbc2Wy6ddHkpRGka+4ECJxtj8WBGGM+YggeIEtpv9EiFp+t3p0iFK0xOqsT8IjnFwvrXordar/
	b0YGk1NQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
	id 1lJiUG-001Bq5-D4; Tue, 09 Mar 2021 19:57:53 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Subject: [PATCH v2] include: Remove pagemap.h from blkdev.h
Date: Tue,  9 Mar 2021 19:57:47 +0000
Message-Id: <20210309195747.283796-1-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Message-ID-Hash: QCQCI4SPUR5E5C4D7DDHDTM45GDPREXD
X-Message-ID-Hash: QCQCI4SPUR5E5C4D7DDHDTM45GDPREXD
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org, linux-nvdimm@lists.01.org, linux-scsi@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QCQCI4SPUR5E5C4D7DDHDTM45GDPREXD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

My UEK-derived config has 1030 files depending on pagemap.h before
this change.  Afterwards, just 326 files need to be rebuilt when I
touch pagemap.h.  I think blkdev.h is probably included too widely,
but untangling that dependency is harder and this solves my problem.
x86 allmodconfig builds, but there may be implicit include problems
on other architectures.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
v2: Fix CONFIG_SWAP=n implicit use of pagemap.h by swap.h.  Increases
    the number of files from 240, but that's still a big win -- 68%
    reduction instead of 77%.

 block/blk-settings.c      | 1 +
 drivers/block/brd.c       | 1 +
 drivers/block/loop.c      | 1 +
 drivers/md/bcache/super.c | 1 +
 drivers/nvdimm/btt.c      | 1 +
 drivers/nvdimm/pmem.c     | 1 +
 drivers/scsi/scsicam.c    | 1 +
 include/linux/blkdev.h    | 1 -
 include/linux/swap.h      | 1 +
 9 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index b4aa2f37fab6..976085a44fb8 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -7,6 +7,7 @@
 #include <linux/init.h>
 #include <linux/bio.h>
 #include <linux/blkdev.h>
+#include <linux/pagemap.h>
 #include <linux/memblock.h>	/* for max_pfn/max_low_pfn */
 #include <linux/gcd.h>
 #include <linux/lcm.h>
diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 18bf99906662..2a5a1933826b 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -18,6 +18,7 @@
 #include <linux/bio.h>
 #include <linux/highmem.h>
 #include <linux/mutex.h>
+#include <linux/pagemap.h>
 #include <linux/radix-tree.h>
 #include <linux/fs.h>
 #include <linux/slab.h>
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index a370cde3ddd4..d58d68f3c7cd 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -53,6 +53,7 @@
 #include <linux/moduleparam.h>
 #include <linux/sched.h>
 #include <linux/fs.h>
+#include <linux/pagemap.h>
 #include <linux/file.h>
 #include <linux/stat.h>
 #include <linux/errno.h>
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 71691f32959b..f154c89d1326 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -16,6 +16,7 @@
 #include "features.h"
 
 #include <linux/blkdev.h>
+#include <linux/pagemap.h>
 #include <linux/debugfs.h>
 #include <linux/genhd.h>
 #include <linux/idr.h>
diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 41aa1f01fc07..18a267d5073f 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -6,6 +6,7 @@
 #include <linux/highmem.h>
 #include <linux/debugfs.h>
 #include <linux/blkdev.h>
+#include <linux/pagemap.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/mutex.h>
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index b8a85bfb2e95..16760b237229 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/blkdev.h>
+#include <linux/pagemap.h>
 #include <linux/hdreg.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/drivers/scsi/scsicam.c b/drivers/scsi/scsicam.c
index f1553a453616..0ffdb8f2995f 100644
--- a/drivers/scsi/scsicam.c
+++ b/drivers/scsi/scsicam.c
@@ -17,6 +17,7 @@
 #include <linux/genhd.h>
 #include <linux/kernel.h>
 #include <linux/blkdev.h>
+#include <linux/pagemap.h>
 #include <linux/msdos_partition.h>
 #include <asm/unaligned.h>
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c032cfe133c7..1e2a95599390 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -11,7 +11,6 @@
 #include <linux/minmax.h>
 #include <linux/timer.h>
 #include <linux/workqueue.h>
-#include <linux/pagemap.h>
 #include <linux/backing-dev-defs.h>
 #include <linux/wait.h>
 #include <linux/mempool.h>
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 4cc6ec3bf0ab..ae194bb7ddb4 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -10,6 +10,7 @@
 #include <linux/sched.h>
 #include <linux/node.h>
 #include <linux/fs.h>
+#include <linux/pagemap.h>
 #include <linux/atomic.h>
 #include <linux/page-flags.h>
 #include <asm/page.h>
-- 
2.30.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

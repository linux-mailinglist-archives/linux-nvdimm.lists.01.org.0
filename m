Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 350E435A3E6
	for <lists+linux-nvdimm@lfdr.de>; Fri,  9 Apr 2021 18:45:55 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CD742100EA902;
	Fri,  9 Apr 2021 09:45:53 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=colyli@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5D621100EAB1F
	for <linux-nvdimm@lists.01.org>; Fri,  9 Apr 2021 09:45:51 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id E91D4B120;
	Fri,  9 Apr 2021 16:45:49 +0000 (UTC)
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Subject: [PATCH v7 16/16] bcache: more fix for compiling error when BCACHE_NVM_PAGES disabled
Date: Sat, 10 Apr 2021 00:43:43 +0800
Message-Id: <20210409164343.56828-17-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210409164343.56828-1-colyli@suse.de>
References: <20210409164343.56828-1-colyli@suse.de>
MIME-Version: 1.0
Message-ID-Hash: NNQGJUVCISBNWUM2BOSH6X3HSNKO5ZWU
X-Message-ID-Hash: NNQGJUVCISBNWUM2BOSH6X3HSNKO5ZWU
X-MailFrom: colyli@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-block@vger.kernel.org, linux-nvdimm@lists.01.org, axboe@kernel.dk, jianpeng.ma@intel.com, qiaowei.ren@intel.com, hare@suse.com, jack@suse.cz, Coly Li <colyli@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NNQGJUVCISBNWUM2BOSH6X3HSNKO5ZWU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch fixes the compiling error when BCACHE_NVM_PAGES is disabled.
The change could be added into previous nvm-pages patches, so that this
patch can be dropped in next nvm-pages series.

Signed-off-by: Coly Li <colyli@suse.de>
Cc: Jianpeng Ma <jianpeng.ma@intel.com>
Cc: Qiaowei Ren <qiaowei.ren@intel.com>
---
 drivers/md/bcache/nvm-pages.c | 4 ++--
 drivers/md/bcache/nvm-pages.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/nvm-pages.c b/drivers/md/bcache/nvm-pages.c
index 19597ae7ef3e..b32f162bf728 100644
--- a/drivers/md/bcache/nvm-pages.c
+++ b/drivers/md/bcache/nvm-pages.c
@@ -7,6 +7,8 @@
  * Copyright (c) 2021, Jianpeng Ma <jianpeng.ma@intel.com>.
  */
 
+#ifdef CONFIG_BCACHE_NVM_PAGES
+
 #include "bcache.h"
 #include "nvm-pages.h"
 
@@ -23,8 +25,6 @@
 #include <linux/blkdev.h>
 #include <linux/bcache-nvm.h>
 
-#ifdef CONFIG_BCACHE_NVM_PAGES
-
 struct bch_nvm_set *only_set;
 
 static void release_nvm_namespaces(struct bch_nvm_set *nvm_set)
diff --git a/drivers/md/bcache/nvm-pages.h b/drivers/md/bcache/nvm-pages.h
index 1c4cbad0209f..f9e0cd7ca3dd 100644
--- a/drivers/md/bcache/nvm-pages.h
+++ b/drivers/md/bcache/nvm-pages.h
@@ -3,8 +3,10 @@
 #ifndef _BCACHE_NVM_PAGES_H
 #define _BCACHE_NVM_PAGES_H
 
+#ifdef CONFIG_BCACHE_NVM_PAGES
 #include <linux/bcache-nvm.h>
 #include <linux/libnvdimm.h>
+#endif /* CONFIG_BCACHE_NVM_PAGES */
 
 /*
  * Bcache NVDIMM in memory data structures
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A46E335A3E2
	for <lists+linux-nvdimm@lfdr.de>; Fri,  9 Apr 2021 18:45:52 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AC72E100EAB1C;
	Fri,  9 Apr 2021 09:45:49 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=colyli@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 16980100EAB11
	for <linux-nvdimm@lists.01.org>; Fri,  9 Apr 2021 09:45:46 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id A24B1B0B8;
	Fri,  9 Apr 2021 16:45:44 +0000 (UTC)
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Subject: [PATCH v7 15/16] bcache: fix BCACHE_NVM_PAGES' dependences in Kconfig
Date: Sat, 10 Apr 2021 00:43:42 +0800
Message-Id: <20210409164343.56828-16-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210409164343.56828-1-colyli@suse.de>
References: <20210409164343.56828-1-colyli@suse.de>
MIME-Version: 1.0
Message-ID-Hash: LBFWIGMULGRMB7M42AYFPWTGEWSB3W4W
X-Message-ID-Hash: LBFWIGMULGRMB7M42AYFPWTGEWSB3W4W
X-MailFrom: colyli@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-block@vger.kernel.org, linux-nvdimm@lists.01.org, axboe@kernel.dk, jianpeng.ma@intel.com, qiaowei.ren@intel.com, hare@suse.com, jack@suse.cz, Coly Li <colyli@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LBFWIGMULGRMB7M42AYFPWTGEWSB3W4W/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch fix the following dependences for BCACHE_NVM_PAGES in
Kconfig,
- Add "depends on PHYS_ADDR_T_64BIT" which is mandatory for libnvdimm
- Add "select LIBNVDIMM" and "select DAX" because nvm-pages code needs
  libnvdimm and dax driver.

This patch can be merged into previous nvm-pages patches, and dropped
in next version series.

Signed-off-by: Coly Li <colyli@suse.de>
Cc: Jianpeng Ma <jianpeng.ma@intel.com>
Cc: Qiaowei Ren <qiaowei.ren@intel.com>
---
 drivers/md/bcache/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/md/bcache/Kconfig b/drivers/md/bcache/Kconfig
index fdec9905ef40..0996e366ad0b 100644
--- a/drivers/md/bcache/Kconfig
+++ b/drivers/md/bcache/Kconfig
@@ -39,5 +39,8 @@ config BCACHE_ASYNC_REGISTRATION
 config BCACHE_NVM_PAGES
 	bool "NVDIMM support for bcache (EXPERIMENTAL)"
 	depends on BCACHE
+	depends on PHYS_ADDR_T_64BIT
+	select LIBNVDIMM
+	select DAX
 	help
 	nvm pages allocator for bcache.
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

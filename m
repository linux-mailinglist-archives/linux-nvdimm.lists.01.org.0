Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 923522E6CD7
	for <lists+linux-nvdimm@lfdr.de>; Tue, 29 Dec 2020 01:44:35 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7E358100EF252;
	Mon, 28 Dec 2020 16:44:33 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=jianpeng.ma@intel.com; receiver=<UNKNOWN> 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 594FA100EF250
	for <linux-nvdimm@lists.01.org>; Mon, 28 Dec 2020 16:44:31 -0800 (PST)
IronPort-SDR: Uc3MsL4qGMo6TQa1z+WbJP2pXLMsL/lmO4agjW9dqpalLhW0kzbGlwVZY9M0NgfLQZW00250sh
 OpsxJBjOA9YA==
X-IronPort-AV: E=McAfee;i="6000,8403,9848"; a="164151888"
X-IronPort-AV: E=Sophos;i="5.78,456,1599548400";
   d="scan'208";a="164151888"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 16:44:30 -0800
IronPort-SDR: Y6yLUi706MAF2msENF9sQgCEKH9JaRJfBnoX9wsZA9VYxZY7NTILdLv9DBrbr4TTIvb2XpYswa
 qImRgNkViFKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,456,1599548400";
   d="scan'208";a="395234889"
Received: from sceph7.sh.intel.com ([10.239.241.90])
  by fmsmga002.fm.intel.com with ESMTP; 28 Dec 2020 16:44:29 -0800
From: Jianpeng Ma <jianpeng.ma@intel.com>
To: dan.j.williams@intel.com
Subject: [PATCH v2] libnvdimm/pmem: remove unused header.
Date: Tue, 29 Dec 2020 08:26:35 +0800
Message-Id: <20201229002635.42555-1-jianpeng.ma@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Message-ID-Hash: UJCIAY5DDSMWTTGMUX6IK5FWCYTCEPD4
X-Message-ID-Hash: UJCIAY5DDSMWTTGMUX6IK5FWCYTCEPD4
X-MailFrom: jianpeng.ma@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, hch@lst.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UJCIAY5DDSMWTTGMUX6IK5FWCYTCEPD4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

'commit a8b456d01cd6 ("bdi: remove BDI_CAP_SYNCHRONOUS_IO")' forgot
remove the related header file.

Fixes: a8b456d01cd6 ("bdi: remove BDI_CAP_SYNCHRONOUS_IO")
Signed-off-by: Jianpeng Ma <jianpeng.ma@intel.com>
---
 drivers/nvdimm/pmem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 875076b0ea6c..f33bdae626ba 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -23,7 +23,6 @@
 #include <linux/uio.h>
 #include <linux/dax.h>
 #include <linux/nd.h>
-#include <linux/backing-dev.h>
 #include <linux/mm.h>
 #include <asm/cacheflush.h>
 #include "pmem.h"
-- 
2.29.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

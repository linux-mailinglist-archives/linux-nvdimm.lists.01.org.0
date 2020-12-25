Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0360C2E2976
	for <lists+linux-nvdimm@lfdr.de>; Fri, 25 Dec 2020 02:53:19 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 369F0100EBBB3;
	Thu, 24 Dec 2020 17:53:17 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=jianpeng.ma@intel.com; receiver=<UNKNOWN> 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2B323100EBBA2
	for <linux-nvdimm@lists.01.org>; Thu, 24 Dec 2020 17:53:14 -0800 (PST)
IronPort-SDR: cakd+VTK5ZBYY189j5rrE60x3W7/zn50/2duqk6GkKUyTBzp2rFRySWatSbAE2HvbRYzZPckGq
 ynOw2a5la3cQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9845"; a="172678238"
X-IronPort-AV: E=Sophos;i="5.78,446,1599548400";
   d="scan'208";a="172678238"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2020 17:53:13 -0800
IronPort-SDR: il6Z7wQIrmDiwVpksLn/0g+0qO4siSR9CzcNCIGEUU/DxssLZvCC0zAgNSRMhNgvV0yFTWnhbn
 tCe5XOSgTECQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,446,1599548400";
   d="scan'208";a="345818547"
Received: from sceph7.sh.intel.com ([10.239.241.90])
  by fmsmga008.fm.intel.com with ESMTP; 24 Dec 2020 17:53:12 -0800
From: Jianpeng Ma <jianpeng.ma@intel.com>
To: dan.j.williams@intel.com
Subject: [PATCH] libnvdimm/pmem: remove unused header.
Date: Fri, 25 Dec 2020 09:35:46 +0800
Message-Id: <20201225013546.300116-1-jianpeng.ma@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Message-ID-Hash: Q4X6YCUPIEGMFEZBIXP4RHX6L6BTRGNJ
X-Message-ID-Hash: Q4X6YCUPIEGMFEZBIXP4RHX6L6BTRGNJ
X-MailFrom: jianpeng.ma@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, hch@lst.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Q4X6YCUPIEGMFEZBIXP4RHX6L6BTRGNJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

'commit a8b456d01cd6 ("bdi: remove BDI_CAP_SYNCHRONOUS_IO")' forgot
remove the related header file.

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

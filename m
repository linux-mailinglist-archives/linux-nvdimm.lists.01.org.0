Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B79A6EBB76
	for <lists+linux-nvdimm@lfdr.de>; Fri,  1 Nov 2019 01:45:55 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 96329100DC40D;
	Thu, 31 Oct 2019 17:46:17 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 88C53100DC40B
	for <linux-nvdimm@lists.01.org>; Thu, 31 Oct 2019 17:46:16 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2019 17:45:47 -0700
X-IronPort-AV: E=Sophos;i="5.68,253,1569308400";
   d="scan'208";a="204369011"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2019 17:45:47 -0700
Subject: [PATCH] libnvdimm/pmem: Delete include of nd-core.h
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Thu, 31 Oct 2019 17:31:30 -0700
Message-ID: <157256829077.1212326.8726596129631121970.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Message-ID-Hash: RBKFI6BMHJJEQR5QOTF5EHOFLZYVX3NA
X-Message-ID-Hash: RBKFI6BMHJJEQR5QOTF5EHOFLZYVX3NA
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RBKFI6BMHJJEQR5QOTF5EHOFLZYVX3NA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The entire point of nd-core.h is to hide functionality that no leaf
driver should touch. In fact, the commit that added it had no need to
include it.

Fixes: 06e8ccdab15f ("acpi: nfit: Add support for detect platform...")
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/pmem.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 7a6f4501dcda..ad8e4df1282b 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -28,7 +28,6 @@
 #include "pmem.h"
 #include "pfn.h"
 #include "nd.h"
-#include "nd-core.h"
 
 static struct device *to_dev(struct pmem_device *pmem)
 {
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

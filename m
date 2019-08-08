Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA92786CCE
	for <lists+linux-nvdimm@lfdr.de>; Thu,  8 Aug 2019 23:58:15 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1CAB42131D566;
	Thu,  8 Aug 2019 15:00:44 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.88; helo=mga01.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 45A5B212FE8B4
 for <linux-nvdimm@lists.01.org>; Thu,  8 Aug 2019 15:00:37 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Aug 2019 14:58:06 -0700
X-IronPort-AV: E=Sophos;i="5.64,363,1559545200"; d="scan'208";a="169126521"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Aug 2019 14:58:06 -0700
Subject: [PATCH] mm/memremap: Fix reuse of pgmap instances with internal
 references
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Thu, 08 Aug 2019 14:43:49 -0700
Message-ID: <156530042781.2068700.8733813683117819799.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
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
Cc: linux-mm@kvack.org, Jason Gunthorpe <jgg@mellanox.com>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Currently, attempts to shutdown and re-enable a device-dax instance
trigger:

    Missing reference count teardown definition
    WARNING: CPU: 37 PID: 1608 at mm/memremap.c:211 devm_memremap_pages+0x234/0x850
    [..]
    RIP: 0010:devm_memremap_pages+0x234/0x850
    [..]
    Call Trace:
     dev_dax_probe+0x66/0x190 [device_dax]
     really_probe+0xef/0x390
     driver_probe_device+0xb4/0x100
     device_driver_attach+0x4f/0x60

Given that the setup path initializes pgmap->ref, arrange for it to be
also torn down so devm_memremap_pages() is ready to be called again and
not be mistaken for the 3rd-party per-cpu-ref case.

Fixes: 24917f6b1041 ("memremap: provide an optional internal refcount in struct dev_pagemap")
Reported-by: Fan Du <fan.du@intel.com>
Tested-by: Vishal Verma <vishal.l.verma@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

Andrew, I have another dax fix pending, so I'm ok to take this through
the nvdimm tree, holler if you want it in -mm.

 mm/memremap.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/memremap.c b/mm/memremap.c
index 6ee03a816d67..86432650f829 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -91,6 +91,12 @@ static void dev_pagemap_cleanup(struct dev_pagemap *pgmap)
 		wait_for_completion(&pgmap->done);
 		percpu_ref_exit(pgmap->ref);
 	}
+	/*
+	 * Undo the pgmap ref assignment for the internal case as the
+	 * caller may re-enable the same pgmap.
+	 */
+	if (pgmap->ref == &pgmap->internal_ref)
+		pgmap->ref = NULL;
 }
 
 static void devm_memremap_pages_release(void *data)

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

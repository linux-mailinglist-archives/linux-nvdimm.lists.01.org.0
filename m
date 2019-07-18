Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E706C41D
	for <lists+linux-nvdimm@lfdr.de>; Thu, 18 Jul 2019 03:22:24 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DEBF1212C01DD;
	Wed, 17 Jul 2019 18:24:51 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.24; helo=mga09.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 2C7C4212C01CC
 for <linux-nvdimm@lists.01.org>; Wed, 17 Jul 2019 18:24:50 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Jul 2019 18:22:21 -0700
X-IronPort-AV: E=Sophos;i="5.64,276,1559545200"; d="scan'208";a="168124002"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Jul 2019 18:22:21 -0700
Subject: [PATCH v2 3/7] libnvdimm/region: Register badblocks before namespaces
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Wed, 17 Jul 2019 18:08:03 -0700
Message-ID: <156341208365.292348.1547528796026249120.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156341206785.292348.1660822720191643298.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156341206785.292348.1660822720191643298.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Namespace activation expects to be able to reference region badblocks.
The following warning sometimes triggers when asynchronous namespace
activation races in front of the completion of namespace probing. Move
all possible namespace probing after region badblocks initialization.

Otherwise, lockdep sometimes catches the uninitialized state of the
badblocks seqlock with stack trace signatures like:

    INFO: trying to register non-static key.
    pmem2: detected capacity change from 0 to 136365211648
    the code is fine but needs lockdep annotation.
    turning off the locking correctness validator.
    CPU: 9 PID: 358 Comm: kworker/u80:5 Tainted: G           OE     5.2.0-rc4+ #3382
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
    Workqueue: events_unbound async_run_entry_fn
    Call Trace:
     dump_stack+0x85/0xc0
    pmem1.12: detected capacity change from 0 to 8589934592
     register_lock_class+0x56a/0x570
     ? check_object+0x140/0x270
     __lock_acquire+0x80/0x1710
     ? __mutex_lock+0x39d/0x910
     lock_acquire+0x9e/0x180
     ? nd_pfn_validate+0x28f/0x440 [libnvdimm]
     badblocks_check+0x93/0x1f0
     ? nd_pfn_validate+0x28f/0x440 [libnvdimm]
     nd_pfn_validate+0x28f/0x440 [libnvdimm]
     ? lockdep_hardirqs_on+0xf0/0x180
     nd_dax_probe+0x9a/0x120 [libnvdimm]
     nd_pmem_probe+0x6d/0x180 [nd_pmem]
     nvdimm_bus_probe+0x90/0x2c0 [libnvdimm]

Fixes: 48af2f7e52f4 ("libnvdimm, pfn: during init, clear errors...")
Cc: <stable@vger.kernel.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/region.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/nvdimm/region.c b/drivers/nvdimm/region.c
index ef46cc3a71ae..488c47ac4c4a 100644
--- a/drivers/nvdimm/region.c
+++ b/drivers/nvdimm/region.c
@@ -34,17 +34,6 @@ static int nd_region_probe(struct device *dev)
 	if (rc)
 		return rc;
 
-	rc = nd_region_register_namespaces(nd_region, &err);
-	if (rc < 0)
-		return rc;
-
-	ndrd = dev_get_drvdata(dev);
-	ndrd->ns_active = rc;
-	ndrd->ns_count = rc + err;
-
-	if (rc && err && rc == err)
-		return -ENODEV;
-
 	if (is_nd_pmem(&nd_region->dev)) {
 		struct resource ndr_res;
 
@@ -60,6 +49,17 @@ static int nd_region_probe(struct device *dev)
 		nvdimm_badblocks_populate(nd_region, &nd_region->bb, &ndr_res);
 	}
 
+	rc = nd_region_register_namespaces(nd_region, &err);
+	if (rc < 0)
+		return rc;
+
+	ndrd = dev_get_drvdata(dev);
+	ndrd->ns_active = rc;
+	ndrd->ns_count = rc + err;
+
+	if (rc && err && rc == err)
+		return -ENODEV;
+
 	nd_region->btt_seed = nd_btt_create(nd_region);
 	nd_region->pfn_seed = nd_pfn_create(nd_region);
 	nd_region->dax_seed = nd_dax_create(nd_region);

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B71C728BDB7
	for <lists+linux-nvdimm@lfdr.de>; Mon, 12 Oct 2020 18:28:44 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9C9A215B7DEB9;
	Mon, 12 Oct 2020 09:28:24 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.244.80; helo=nam12-mw2-obe.outbound.protection.outlook.com; envelope-from=nmeeramohide@micron.com; receiver=<UNKNOWN> 
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4C9E315B7DE82
	for <linux-nvdimm@lists.01.org>; Mon, 12 Oct 2020 09:28:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYVP6r4aTnfhNrdQRrKHzutBc52lMR7XCx9ETXqAUhGQasBWJKtZiD1FolNuT/lEK+SZylGTHh97JeMa+vCe9NTqx9xK2o22HeNflhtMYRcgnLzg4bLmCHGFz2I64IIG1k2L/wXZ2YAj8M0OqT1NfLFUQavPCq9OtAlH1peQ85qHVw1VbrAprehWpLpgJxUBqZpT+LoaXo9fILy6/4MiBL3b87euObgNQH3trfOGJ+dYMU/qq1XsVQGVYTpHQQ1uVSGV1RnSk19IIaxU08XZlol9cjWrXTX6MBzIRztvWPwFk4emxXQEedZEIx2mWjWnKHr4KNErxuhvUZbOGCTGAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKDNuYWPvqW17HEfn2YlDnJSz6UClueobWWQ1euI3Io=;
 b=T7ZvO/tOsojUyWvIcxhWGrYKf/eRmIlmiEghfMa4lgtdW+kWXaX5Jp4CwI0v7PCFB+2DHKIHvMTg/+pncgoIi6VdkD/1+7yYHrN9KAufDdXq9RniM3pzS5KVWHY+mxCE++Y5jWiRiVupb6DbaUipPlqpmQHH42wLh/NRBksGZ94QXb8s6FU+W38aevhjY9qfFp8u1OFQYTBBbUMlvkTN0QMHb3YgY96DBOPcqaVyUbf0xe+yShEUa8gYeyJS0Xz0Ktgcd5OMrpWMsRp44WnsJIM5qlVcWM5yuGxbc3VV1sbuwIxwAu08ihrjRtw6v0GGVU9CTMxX1C6jbhr+8KjWeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=kvack.org smtp.mailfrom=micron.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKDNuYWPvqW17HEfn2YlDnJSz6UClueobWWQ1euI3Io=;
 b=caIHBZ994oA/1R9um+PUqctQpfaRzIT/OuFhsD3Jk/mxmuClkUnYP5156WyBifPhJ7VhaLQo8mNlIxpzEWev6fd3hddVidxVaa+4E5644UxqXYyEyDOydQbRupEcKEO9rCstigu2v9ldUmv1gjiNiZ05h3lXM5+dcg57gN6rnSI=
Received: from SN4PR0201CA0056.namprd02.prod.outlook.com
 (2603:10b6:803:20::18) by MWHPR08MB2478.namprd08.prod.outlook.com
 (2603:10b6:300:d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Mon, 12 Oct
 2020 16:28:14 +0000
Received: from SN1NAM01FT015.eop-nam01.prod.protection.outlook.com
 (2603:10b6:803:20:cafe::5a) by SN4PR0201CA0056.outlook.office365.com
 (2603:10b6:803:20::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22 via Frontend
 Transport; Mon, 12 Oct 2020 16:28:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com;
Received: from mail.micron.com (137.201.242.130) by
 SN1NAM01FT015.mail.protection.outlook.com (10.152.65.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3455.23 via Frontend Transport; Mon, 12 Oct 2020 16:28:14 +0000
Received: from micron.com (10.114.5.55) by bowex17c.micron.com
 (137.201.21.211) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Oct
 2020 10:28:11 -0600
From: Nabeel M Mohamed <nmeeramohide@micron.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-nvdimm@lists.01.org>
Subject: [PATCH v2 19/22] mpool: add support to mmap arbitrary collection of mblocks
Date: Mon, 12 Oct 2020 11:27:33 -0500
Message-ID: <20201012162736.65241-20-nmeeramohide@micron.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20201012162736.65241-1-nmeeramohide@micron.com>
References: <20201012162736.65241-1-nmeeramohide@micron.com>
MIME-Version: 1.0
X-ClientProxiedBy: bowex17a.micron.com (137.201.21.209) To bowex17c.micron.com
 (137.201.21.211)
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24646.005
X-TM-AS-Result: No--20.037900-0.000000-31
X-TM-AS-MatchedID: 154075-701478-705247-702754-847298-700958-704718-703812-7
	00400-704960-701162-702876-105040-704418-705041-704397-701724-704637-702877
	-704318-703878-701270-703027-702914-705161-700328-186035-701342-704500-7049
	26-703532-861243-702619-701592-780052-701590-703357-703956-704728-701480-70
	1809-701280-703017-702395-188019-702299-704477-300015-703140-703213-121336-
	701105-704673-703967-700698-703953-700076-701932-703173-700286-703958-70308
	0-703624-700181-705220-121367-139504-703279-700351-704053-105630-703904-703
	865-702298-704934-705279-702837-106420-703325-700069-703766-137717-702617-7
	04001-702975-704338-701847-701750-705022-704264-148004-148036-42000-42003
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 514fe41f-f74d-4277-37c2-08d86ecbd166
X-MS-TrafficTypeDiagnostic: MWHPR08MB2478:
X-Microsoft-Antispam-PRVS: 
 <MWHPR08MB2478F97AD41A83C4E91D69F7B3070@MWHPR08MB2478.namprd08.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+URp68n8QDRg2M29SGVQbrWj6m7dQOkJ0pWm6CC9PYJF7/Upt6UI2TIEIXB1A33Tp7n9Jrl80n7K1FLJ2gCkEYyJuTCF7iyaShJs7vEKRCUBcglC1io6lK0eMIkzfVZP0lDOGobqfkPxmPwUoMuBY/DyzIfbZN7nh9bl21pJ8blgEhK9MuN1SkFY3XPJArF8WblREJwfRNzLyvQMPWq5P1nUVQ7epO+IBwlvQnHhzVEA85Da6Pk1NWgf0rdyMXXRgxwM4J/JKKSscgLIJAAYighuoNy3a82HKhGEJY/pLCW85yuhStgmCF1uC1cRxX1e2olW3jJAeRYfvlkqGvHVFm3twZT0xaOwqHjt2DZ0QGRYXGdA5s1JpVbXMz6fQ16qaxYuXP2ZN0nBxwxuLwijyLyoBrDxS4b4MPU9HazFqm50AkAQC2U05pDoqCodI7hlBA5qMlKMGOoXy8aND1I2jg==
X-Forefront-Antispam-Report: 
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(46966005)(107886003)(47076004)(8936002)(8676002)(86362001)(1076003)(83380400001)(6286002)(33310700002)(4326008)(6666004)(478600001)(356005)(7636003)(36756003)(55016002)(110136005)(26005)(5660300002)(70206006)(70586007)(186003)(7696005)(82310400003)(336012)(82740400003)(426003)(316002)(2906002)(54906003)(2616005)(30864003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 16:28:14.1839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 514fe41f-f74d-4277-37c2-08d86ecbd166
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM01FT015.eop-nam01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR08MB2478
Message-ID-Hash: VWYKLEKFR7JJ2W53RQND4BHPMU4DHS7H
X-Message-ID-Hash: VWYKLEKFR7JJ2W53RQND4BHPMU4DHS7H
X-MailFrom: nmeeramohide@micron.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: smoyer@micron.com, gbecker@micron.com, plabat@micron.com, jgroves@micron.com, Nabeel M Mohamed <nmeeramohide@micron.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VWYKLEKFR7JJ2W53RQND4BHPMU4DHS7H/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This implements the mmap file operation for the mpool driver.

Mblock and mlog writes avoid the Linux page cache. Mblocks are
written, committed, and made immutable before they can be read
either directly (avoiding the page cache) or memory-mapped.
Mlogs are always read and updated directly and cannot be
memory-mapped.

Mblocks are memory-mapped by creating an mcache map.
The mcache map APIs allow an arbitrary collection of mblocks
(specified as a vector of mblock OIDs) to be mapped linearly
into the virtual address space of an mpool client.

An extended VMA instance (mpc_xvm) is created for each
mcache map. The xvm takes a ref on all the mblocks it maps.
The size of an xvm region is 1G by default and can be tuned
using the module parameter 'xvm_size_max'. When an mcache
map is created, its xvm instance is assigned with the next
available device offset range. The device offset -> xvm
mapping is inserted into a region map stored in the mpool's
unit object.

The mmap driver entry point uses the vma page offset to deduce
the device offset of the corresponding mcache map. The xvm
instance is looked up from the region map using device offset
as the key. A reference to this xvm instance is stored in the
vma private data, which enables the page fault handler to find
the xvm for the faulting range in constant time. The offset into
the mcache map can then be used to determine the mblock id and
offset to be read for filling the page.

Readahead is enabled for the mpool device by providing the
fadvise file op and by initializing file_ra_state.ra_pages.
Readahead requests are dispatched to one of the four
readahead workqueues and served by the workqueue threads.

Co-developed-by: Greg Becker <gbecker@micron.com>
Signed-off-by: Greg Becker <gbecker@micron.com>
Co-developed-by: Pierre Labat <plabat@micron.com>
Signed-off-by: Pierre Labat <plabat@micron.com>
Co-developed-by: John Groves <jgroves@micron.com>
Signed-off-by: John Groves <jgroves@micron.com>
Signed-off-by: Nabeel M Mohamed <nmeeramohide@micron.com>
---
 drivers/mpool/init.c   |   16 +
 drivers/mpool/init.h   |    2 +
 drivers/mpool/mcache.c | 1029 ++++++++++++++++++++++++++++++++++++++++
 drivers/mpool/mcache.h |   96 ++++
 drivers/mpool/mpctl.c  |   45 +-
 drivers/mpool/mpctl.h  |    3 +
 6 files changed, 1190 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mpool/mcache.c
 create mode 100644 drivers/mpool/mcache.h

diff --git a/drivers/mpool/init.c b/drivers/mpool/init.c
index 126c6c7142b5..b1fe3286773a 100644
--- a/drivers/mpool/init.c
+++ b/drivers/mpool/init.c
@@ -12,11 +12,20 @@
 #include "smap.h"
 #include "pmd_obj.h"
 #include "sb.h"
+#include "mcache.h"
 #include "mpctl.h"
 
 /*
  * Module params...
  */
+unsigned int xvm_max __read_mostly = 1048576 * 128;
+module_param(xvm_max, uint, 0444);
+MODULE_PARM_DESC(xvm_max, " max extended VMA regions");
+
+unsigned int xvm_size_max __read_mostly = 30;
+module_param(xvm_size_max, uint, 0444);
+MODULE_PARM_DESC(xvm_size_max, " max extended VMA size log2");
+
 unsigned int maxunits __read_mostly = 1024;
 module_param(maxunits, uint, 0444);
 MODULE_PARM_DESC(maxunits, " max mpools");
@@ -40,6 +49,7 @@ MODULE_PARM_DESC(chunk_size_kb, "Chunk size (in KiB) for device I/O");
 static void mpool_exit_impl(void)
 {
 	mpctl_exit();
+	mcache_exit();
 	pmd_exit();
 	smap_exit();
 	sb_exit();
@@ -82,6 +92,12 @@ static __init int mpool_init(void)
 		goto errout;
 	}
 
+	rc = mcache_init();
+	if (rc) {
+		errmsg = "mcache init failed";
+		goto errout;
+	}
+
 	rc = mpctl_init();
 	if (rc) {
 		errmsg = "mpctl init failed";
diff --git a/drivers/mpool/init.h b/drivers/mpool/init.h
index 3d8f809a5e45..507d43a55c01 100644
--- a/drivers/mpool/init.h
+++ b/drivers/mpool/init.h
@@ -6,6 +6,8 @@
 #ifndef MPOOL_INIT_H
 #define MPOOL_INIT_H
 
+extern unsigned int xvm_max;
+extern unsigned int xvm_size_max;
 extern unsigned int maxunits;
 extern unsigned int rwsz_max_mb;
 extern unsigned int rwconc_max;
diff --git a/drivers/mpool/mcache.c b/drivers/mpool/mcache.c
new file mode 100644
index 000000000000..07c79615ecf1
--- /dev/null
+++ b/drivers/mpool/mcache.c
@@ -0,0 +1,1029 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+
+#include <linux/module.h>
+#include <linux/memcontrol.h>
+#include <linux/kref.h>
+#include <linux/migrate.h>
+#include <linux/delay.h>
+#include <linux/uio.h>
+#include <linux/fadvise.h>
+#include <linux/prefetch.h>
+
+#include "mpool_ioctl.h"
+
+#include "mp.h"
+#include "mpool_printk.h"
+#include "assert.h"
+
+#include "mpctl.h"
+
+#ifndef lru_to_page
+#define lru_to_page(_head)  (list_entry((_head)->prev, struct page, lru))
+#endif
+
+/*
+ * MPC_RA_IOV_MAX - Max pages per call to mblock read by a readahead
+ * request.  Be careful about increasing this as it directly adds
+ * (n * 24) bytes to the stack frame of mpc_readpages_cb().
+ */
+#define MPC_RA_IOV_MAX      (8)
+
+#define NODEV               MKDEV(0, 0)    /* Non-existent device */
+
+/*
+ * Arguments required to initiate an asynchronous call to mblock_read()
+ * and which must also be preserved across that call.
+ *
+ * Note: We could make things more efficient by changing a_pagev[]
+ * to a struct kvec if mblock_read() would guarantee that it will
+ * not alter the given iovec.
+ */
+struct readpage_args {
+	void                       *a_xvm;
+	struct mblock_descriptor   *a_mbdesc;
+	u64                         a_mboffset;
+	int                         a_pagec;
+	struct page                *a_pagev[];
+};
+
+struct readpage_work {
+	struct work_struct      w_work;
+	struct readpage_args    w_args;
+};
+
+static void mpc_xvm_put(struct mpc_xvm *xvm);
+
+static int mpc_readpage_impl(struct page *page, struct mpc_xvm *map);
+
+/* The following structures are initialized at the end of this file. */
+static const struct vm_operations_struct mpc_vops_default;
+const struct address_space_operations mpc_aops_default;
+
+static struct workqueue_struct *mpc_wq_trunc __read_mostly;
+static struct workqueue_struct *mpc_wq_rav[4] __read_mostly;
+
+static size_t mpc_xvm_cachesz[2] __read_mostly;
+static struct kmem_cache *mpc_xvm_cache[2] __read_mostly;
+
+static struct workqueue_struct *mpc_rgn2wq(uint rgn)
+{
+	return mpc_wq_rav[rgn % ARRAY_SIZE(mpc_wq_rav)];
+}
+
+static int mpc_rgnmap_isorphan(int rgn, void *item, void *data)
+{
+	struct mpc_xvm *xvm = item;
+	void **headp = data;
+
+	if (xvm && kref_read(&xvm->xvm_ref) == 1 && !atomic_read(&xvm->xvm_opened)) {
+		idr_replace(&xvm->xvm_rgnmap->rm_root, NULL, rgn);
+		xvm->xvm_next = *headp;
+		*headp = xvm;
+	}
+
+	return ITERCB_NEXT;
+}
+
+void mpc_rgnmap_flush(struct mpc_rgnmap *rm)
+{
+	struct mpc_xvm *head = NULL, *xvm;
+
+	if (!rm)
+		return;
+
+	/* Wait for all mpc_xvm_free_cb() callbacks to complete... */
+	flush_workqueue(mpc_wq_trunc);
+
+	/*
+	 * Build a list of all orphaned XVMs and release their birth
+	 * references (i.e., XVMs that were created but never mmapped).
+	 */
+	mutex_lock(&rm->rm_lock);
+	idr_for_each(&rm->rm_root, mpc_rgnmap_isorphan, &head);
+	mutex_unlock(&rm->rm_lock);
+
+	while ((xvm = head)) {
+		head = xvm->xvm_next;
+		mpc_xvm_put(xvm);
+	}
+}
+
+static struct mpc_xvm *mpc_xvm_lookup(struct mpc_rgnmap *rm, uint key)
+{
+	struct mpc_xvm *xvm;
+
+	mutex_lock(&rm->rm_lock);
+	xvm = idr_find(&rm->rm_root, key);
+	if (xvm && !kref_get_unless_zero(&xvm->xvm_ref))
+		xvm = NULL;
+	mutex_unlock(&rm->rm_lock);
+
+	return xvm;
+}
+
+void mpc_xvm_free(struct mpc_xvm *xvm)
+{
+	struct mpc_rgnmap *rm;
+
+	ASSERT((u32)(uintptr_t)xvm == xvm->xvm_magic);
+
+	rm = xvm->xvm_rgnmap;
+
+	mutex_lock(&rm->rm_lock);
+	idr_remove(&rm->rm_root, xvm->xvm_rgn);
+	mutex_unlock(&rm->rm_lock);
+
+	xvm->xvm_magic = 0xbadcafe;
+	xvm->xvm_rgn = -1;
+
+	kmem_cache_free(xvm->xvm_cache, xvm);
+
+	atomic_dec(&rm->rm_rgncnt);
+}
+
+static void mpc_xvm_free_cb(struct work_struct *work)
+{
+	struct mpc_xvm *xvm = container_of(work, typeof(*xvm), xvm_work);
+
+	mpc_xvm_free(xvm);
+}
+
+static void mpc_xvm_get(struct mpc_xvm *xvm)
+{
+	kref_get(&xvm->xvm_ref);
+}
+
+static void mpc_xvm_release(struct kref *kref)
+{
+	struct mpc_xvm *xvm = container_of(kref, struct mpc_xvm, xvm_ref);
+	struct mpc_rgnmap *rm = xvm->xvm_rgnmap;
+	int i;
+
+	ASSERT((u32)(uintptr_t)xvm == xvm->xvm_magic);
+
+	mutex_lock(&rm->rm_lock);
+	ASSERT(kref_read(kref) == 0);
+	idr_replace(&rm->rm_root, NULL, xvm->xvm_rgn);
+	mutex_unlock(&rm->rm_lock);
+
+	/*
+	 * Wait for all in-progress readaheads to complete
+	 * before we drop our mblock references.
+	 */
+	if (atomic_add_return(WQ_MAX_ACTIVE, &xvm->xvm_rabusy) > WQ_MAX_ACTIVE)
+		flush_workqueue(mpc_rgn2wq(xvm->xvm_rgn));
+
+	for (i = 0; i < xvm->xvm_mbinfoc; ++i)
+		mblock_put(xvm->xvm_mbinfov[i].mbdesc);
+
+	INIT_WORK(&xvm->xvm_work, mpc_xvm_free_cb);
+	queue_work(mpc_wq_trunc, &xvm->xvm_work);
+}
+
+static void mpc_xvm_put(struct mpc_xvm *xvm)
+{
+	kref_put(&xvm->xvm_ref, mpc_xvm_release);
+}
+
+/*
+ * VM operations
+ */
+
+static void mpc_vm_open(struct vm_area_struct *vma)
+{
+	mpc_xvm_get(vma->vm_private_data);
+}
+
+static void mpc_vm_close(struct vm_area_struct *vma)
+{
+	mpc_xvm_put(vma->vm_private_data);
+}
+
+static int mpc_alloc_and_readpage(struct vm_area_struct *vma, pgoff_t offset, gfp_t gfp)
+{
+	struct address_space *mapping;
+	struct file *file;
+	struct page *page;
+	int rc;
+
+	page = __page_cache_alloc(gfp | __GFP_NOWARN);
+	if (!page)
+		return -ENOMEM;
+
+	file    = vma->vm_file;
+	mapping = file->f_mapping;
+
+	rc = add_to_page_cache_lru(page, mapping, offset, gfp & GFP_KERNEL);
+	if (rc == 0)
+		rc = mpc_readpage_impl(page, vma->vm_private_data);
+	else if (rc == -EEXIST)
+		rc = 0;
+
+	put_page(page);
+
+	return rc;
+}
+
+static bool mpc_lock_page_or_retry(struct page *page, struct mm_struct *mm, uint flags)
+{
+	might_sleep();
+
+	if (trylock_page(page))
+		return true;
+
+	if (flags & FAULT_FLAG_ALLOW_RETRY) {
+		if (flags & FAULT_FLAG_RETRY_NOWAIT)
+			return false;
+
+		mmap_read_unlock(mm);
+		/* _killable version is not exported by the kernel. */
+		wait_on_page_locked(page);
+		return false;
+	}
+
+	if (flags & FAULT_FLAG_KILLABLE) {
+		int rc;
+
+		rc = lock_page_killable(page);
+		if (rc) {
+			mmap_read_unlock(mm);
+			return false;
+		}
+	} else {
+		lock_page(page);
+	}
+
+	return true;
+}
+
+static int mpc_handle_page_error(struct page *page, struct vm_area_struct *vma)
+{
+	int rc;
+
+	ClearPageError(page);
+
+	rc = mpc_readpage_impl(page, vma->vm_private_data);
+	if (rc == 0) {
+		wait_on_page_locked(page);
+		if (!PageUptodate(page))
+			rc = -EIO;
+	}
+
+	put_page(page);
+
+	return rc;
+}
+
+static vm_fault_t mpc_vm_fault_impl(struct vm_area_struct *vma, struct vm_fault *vmf)
+{
+	struct address_space *mapping;
+	struct inode *inode;
+	struct page *page;
+	vm_fault_t vmfrc;
+	pgoff_t offset;
+	loff_t size;
+
+	mapping = vma->vm_file->f_mapping;
+	inode   = mapping->host;
+	offset  = vmf->pgoff;
+	vmfrc   = 0;
+
+	size = round_up(i_size_read(inode), PAGE_SIZE);
+	if (offset >= (size >> PAGE_SHIFT))
+		return VM_FAULT_SIGBUS;
+
+retry_find:
+	page = find_get_page(mapping, offset);
+	if (!page) {
+		int rc = mpc_alloc_and_readpage(vma, offset, mapping_gfp_mask(mapping));
+
+		if (rc < 0)
+			return (rc == -ENOMEM) ? VM_FAULT_OOM : VM_FAULT_SIGBUS;
+
+		vmfrc = VM_FAULT_MAJOR;
+		goto retry_find;
+	}
+
+	/* At this point, page is not locked but has a ref. */
+	if (vmfrc == VM_FAULT_MAJOR)
+		count_vm_event(PGMAJFAULT);
+
+	if (!mpc_lock_page_or_retry(page, vma->vm_mm, vmf->flags)) {
+		put_page(page);
+		return vmfrc | VM_FAULT_RETRY;
+	}
+
+	/* At this point, page is locked with a ref. */
+	if (unlikely(page->mapping != mapping)) {
+		unlock_page(page);
+		put_page(page);
+		goto retry_find;
+	}
+
+	VM_BUG_ON_PAGE(page->index != offset, page);
+
+	if (unlikely(!PageUptodate(page))) {
+		int rc = mpc_handle_page_error(page, vma);
+
+		/* At this point, page is not locked and has no ref. */
+		if (rc)
+			return VM_FAULT_SIGBUS;
+		goto retry_find;
+	}
+
+	/* Page is locked with a ref. */
+	vmf->page = page;
+
+	return vmfrc | VM_FAULT_LOCKED;
+}
+
+static vm_fault_t mpc_vm_fault(struct vm_fault *vmf)
+{
+	return mpc_vm_fault_impl(vmf->vma, vmf);
+}
+
+/*
+ * MPCTL address-space operations.
+ */
+
+static int mpc_readpage_impl(struct page *page, struct mpc_xvm *xvm)
+{
+	struct mpc_mbinfo *mbinfo;
+	struct kvec iov[1];
+	off_t offset;
+	uint mbnum;
+	int rc;
+
+	offset  = page->index << PAGE_SHIFT;
+	offset %= (1ul << xvm_size_max);
+
+	mbnum = offset / xvm->xvm_bktsz;
+	if (mbnum >= xvm->xvm_mbinfoc) {
+		unlock_page(page);
+		return -EINVAL;
+	}
+
+	mbinfo = xvm->xvm_mbinfov + mbnum;
+	offset %= xvm->xvm_bktsz;
+
+	if (offset >= mbinfo->mblen) {
+		unlock_page(page);
+		return -EINVAL;
+	}
+
+	iov[0].iov_base = page_address(page);
+	iov[0].iov_len = PAGE_SIZE;
+
+	rc = mblock_read(xvm->xvm_mpdesc, mbinfo->mbdesc, iov, 1, offset, PAGE_SIZE);
+	if (rc) {
+		unlock_page(page);
+		return rc;
+	}
+
+	if (xvm->xvm_hcpagesp)
+		atomic64_inc(xvm->xvm_hcpagesp);
+	atomic64_inc(&xvm->xvm_nrpages);
+
+	SetPagePrivate(page);
+	set_page_private(page, (ulong)xvm);
+	SetPageUptodate(page);
+	unlock_page(page);
+
+	return 0;
+}
+
+#define MPC_RPARGSBUFSZ \
+	(sizeof(struct readpage_args) + MPC_RA_IOV_MAX * sizeof(void *))
+
+/**
+ * mpc_readpages_cb() - mpc_readpages() callback
+ * @work:   w_work.work from struct readpage_work
+ *
+ * The incoming arguments are in the first page (a_pagev[0]) which
+ * we are about to overwrite, so we copy them to the stack.
+ */
+static void mpc_readpages_cb(struct work_struct *work)
+{
+	struct kvec iovbuf[MPC_RA_IOV_MAX];
+	char argsbuf[MPC_RPARGSBUFSZ];
+	struct readpage_args *args = (void *)argsbuf;
+	struct readpage_work *w;
+	struct mpc_xvm *xvm;
+	struct kvec *iov = iovbuf;
+	size_t argssz;
+	int pagec, rc, i;
+
+	w = container_of(work, struct readpage_work, w_work);
+
+	pagec = w->w_args.a_pagec;
+	argssz = sizeof(*args) + sizeof(args->a_pagev[0]) * pagec;
+
+	ASSERT(pagec <= ARRAY_SIZE(iovbuf));
+	ASSERT(argssz <= sizeof(argsbuf));
+
+	memcpy(args, &w->w_args, argssz);
+	w = NULL; /* Do not touch! */
+
+	xvm = args->a_xvm;
+
+	/*
+	 * Synchronize with mpc_xvm_put() to prevent dropping our
+	 * mblock references while there are reads in progress.
+	 */
+	if (atomic_inc_return(&xvm->xvm_rabusy) > WQ_MAX_ACTIVE) {
+		rc = -ENXIO;
+		goto errout;
+	}
+
+	for (i = 0; i < pagec; ++i) {
+		iov[i].iov_base = page_address(args->a_pagev[i]);
+		iov[i].iov_len = PAGE_SIZE;
+	}
+
+	rc = mblock_read(xvm->xvm_mpdesc, args->a_mbdesc, iov,
+			 pagec, args->a_mboffset, pagec << PAGE_SHIFT);
+	if (rc)
+		goto errout;
+
+	if (xvm->xvm_hcpagesp)
+		atomic64_add(pagec, xvm->xvm_hcpagesp);
+	atomic64_add(pagec, &xvm->xvm_nrpages);
+	atomic_dec(&xvm->xvm_rabusy);
+
+	for (i = 0; i < pagec; ++i) {
+		struct page *page = args->a_pagev[i];
+
+		SetPagePrivate(page);
+		set_page_private(page, (ulong)xvm);
+		SetPageUptodate(page);
+
+		unlock_page(page);
+		put_page(page);
+	}
+
+	return;
+
+errout:
+	atomic_dec(&xvm->xvm_rabusy);
+
+	for (i = 0; i < pagec; ++i) {
+		unlock_page(args->a_pagev[i]);
+		put_page(args->a_pagev[i]);
+	}
+}
+
+static int mpc_readpages(struct file *file, struct address_space *mapping,
+			 struct list_head *pages, uint nr_pages)
+{
+	struct workqueue_struct *wq;
+	struct readpage_work *w;
+	struct work_struct *work;
+	struct mpc_mbinfo *mbinfo;
+	struct mpc_unit *unit;
+	struct mpc_xvm *xvm;
+	struct page *page;
+	off_t offset, mbend;
+	uint mbnum, iovmax, i;
+	uint ra_pages_max;
+	ulong index;
+	gfp_t gfp;
+	u32 key;
+	int rc;
+
+	unit = file->private_data;
+
+	ra_pages_max = unit->un_ra_pages_max;
+	if (ra_pages_max < 1)
+		return 0;
+
+	page   = lru_to_page(pages);
+	offset = page->index << PAGE_SHIFT;
+	index  = page->index;
+	work   = NULL;
+	w      = NULL;
+
+	key = offset >> xvm_size_max;
+
+	/*
+	 * The idr value here (xvm) is pinned for the lifetime of the address map.
+	 * Therefore, we can exit the rcu read-side critsec without worry that xvm will be
+	 * destroyed before put_page() has been called on each and every page in the given
+	 * list of pages.
+	 */
+	rcu_read_lock();
+	xvm = idr_find(&unit->un_rgnmap.rm_root, key);
+	rcu_read_unlock();
+
+	if (!xvm)
+		return 0;
+
+	offset %= (1ul << xvm_size_max);
+
+	mbnum = offset / xvm->xvm_bktsz;
+	if (mbnum >= xvm->xvm_mbinfoc)
+		return 0;
+
+	mbinfo = xvm->xvm_mbinfov + mbnum;
+
+	mbend = mbnum * xvm->xvm_bktsz + mbinfo->mblen;
+	iovmax = MPC_RA_IOV_MAX;
+
+	gfp = mapping_gfp_mask(mapping) & GFP_KERNEL;
+	wq = mpc_rgn2wq(xvm->xvm_rgn);
+
+	nr_pages = min_t(uint, nr_pages, ra_pages_max);
+
+	for (i = 0; i < nr_pages; ++i) {
+		page    = lru_to_page(pages);
+		offset  = page->index << PAGE_SHIFT;
+		offset %= (1ul << xvm_size_max);
+
+		/* Don't read past the end of the mblock. */
+		if (offset >= mbend)
+			break;
+
+		/* mblock reads must be logically contiguous. */
+		if (page->index != index && work) {
+			queue_work(wq, work);
+			work = NULL;
+		}
+
+		index = page->index + 1; /* next expected page index */
+
+		prefetchw(&page->flags);
+		list_del(&page->lru);
+
+		rc = add_to_page_cache_lru(page, mapping, page->index, gfp);
+		if (rc) {
+			if (work) {
+				queue_work(wq, work);
+				work = NULL;
+			}
+			put_page(page);
+			continue;
+		}
+
+		if (!work) {
+			w = page_address(page);
+			INIT_WORK(&w->w_work, mpc_readpages_cb);
+			w->w_args.a_xvm = xvm;
+			w->w_args.a_mbdesc = mbinfo->mbdesc;
+			w->w_args.a_mboffset = offset % xvm->xvm_bktsz;
+			w->w_args.a_pagec = 0;
+			work = &w->w_work;
+
+			iovmax = MPC_RA_IOV_MAX;
+			iovmax -= page->index % MPC_RA_IOV_MAX;
+		}
+
+		w->w_args.a_pagev[w->w_args.a_pagec++] = page;
+
+		/*
+		 * Restrict batch size to the number of struct kvecs
+		 * that will fit into a page (minus our header).
+		 */
+		if (w->w_args.a_pagec >= iovmax) {
+			queue_work(wq, work);
+			work = NULL;
+		}
+	}
+
+	if (work)
+		queue_work(wq, work);
+
+	return 0;
+}
+
+/**
+ * mpc_releasepage() - Linux VM calls the release page when pages are released.
+ * @page:
+ * @gfp:
+ *
+ * The function is added as part of tracking incoming and outgoing pages.
+ */
+static int mpc_releasepage(struct page *page, gfp_t gfp)
+{
+	struct mpc_xvm *xvm;
+
+	if (!PagePrivate(page))
+		return 0;
+
+	xvm = (void *)page_private(page);
+	if (!xvm)
+		return 0;
+
+	ClearPagePrivate(page);
+	set_page_private(page, 0);
+
+	ASSERT((u32)(uintptr_t)xvm == xvm->xvm_magic);
+
+	if (xvm->xvm_hcpagesp)
+		atomic64_dec(xvm->xvm_hcpagesp);
+	atomic64_dec(&xvm->xvm_nrpages);
+
+	return 1;
+}
+
+static void mpc_invalidatepage(struct page *page, uint offset, uint length)
+{
+	mpc_releasepage(page, 0);
+}
+
+/**
+ * mpc_migratepage() -  Callback for handling page migration.
+ * @mapping:
+ * @newpage:
+ * @page:
+ * @mode:
+ *
+ * The drivers having private pages are supplying this callback.
+ * Not sure the page migration releases or invalidates the page being migrated,
+ * or else the tracking of incoming and outgoing pages will be in trouble. The
+ * callback is added to deal with uncertainties around migration. The migration
+ * will be declined so long as the page is private and it belongs to mpctl.
+ */
+static int mpc_migratepage(struct address_space *mapping, struct page *newpage,
+			   struct page *page, enum migrate_mode mode)
+{
+	if (page_has_private(page) &&
+	    !try_to_release_page(page, GFP_KERNEL))
+		return -EAGAIN;
+
+	ASSERT(PageLocked(page));
+
+	return migrate_page(mapping, newpage, page, mode);
+}
+
+int mpc_mmap(struct file *fp, struct vm_area_struct *vma)
+{
+	struct mpc_unit *unit = fp->private_data;
+	struct mpc_xvm *xvm;
+	off_t off;
+	ulong len;
+	u32 key;
+
+	off = vma->vm_pgoff << PAGE_SHIFT;
+	len = vma->vm_end - vma->vm_start - 1;
+
+	/* Verify that the request does not cross an xvm region boundary. */
+	if ((off >> xvm_size_max) != ((off + len) >> xvm_size_max))
+		return -EINVAL;
+
+	/* Acquire a reference on the region map for this region. */
+	key = off >> xvm_size_max;
+
+	xvm = mpc_xvm_lookup(&unit->un_rgnmap, key);
+	if (!xvm)
+		return -EINVAL;
+
+	/*
+	 * Drop the birth ref on first open so that the final call
+	 * to mpc_vm_close() will cause the vma to be destroyed.
+	 */
+	if (atomic_inc_return(&xvm->xvm_opened) == 1)
+		mpc_xvm_put(xvm);
+
+	vma->vm_ops = &mpc_vops_default;
+
+	vma->vm_flags &= ~(VM_RAND_READ | VM_SEQ_READ);
+	vma->vm_flags &= ~(VM_MAYWRITE | VM_MAYEXEC);
+
+	vma->vm_flags = (VM_DONTEXPAND | VM_DONTDUMP | VM_NORESERVE);
+	vma->vm_flags |= VM_MAYREAD | VM_READ | VM_RAND_READ;
+
+	vma->vm_private_data = xvm;
+
+	fp->f_ra.ra_pages = unit->un_ra_pages_max;
+	fp->f_mode |= FMODE_RANDOM;
+
+	return 0;
+}
+
+/**
+ * mpc_fadvise() -
+ *
+ * mpc_fadvise() currently handles only POSIX_FADV_WILLNEED.
+ *
+ * The code path that leads here is: madvise_willneed() -> vfs_fadvise() -> mpc_fadvise()
+ */
+int mpc_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
+{
+	pgoff_t start, end;
+
+	if (!file)
+		return -EINVAL;
+
+	if (advice != POSIX_FADV_WILLNEED)
+		return -EOPNOTSUPP;
+
+	start = offset >> PAGE_SHIFT;
+	end = (offset + len - 1) >> PAGE_SHIFT;
+
+	if (end < start)
+		return -EINVAL;
+
+	/* To force page cache readahead */
+	spin_lock(&file->f_lock);
+	file->f_mode |= FMODE_RANDOM;
+	spin_unlock(&file->f_lock);
+
+	page_cache_sync_readahead(file->f_mapping, &file->f_ra, file, start, end - start + 1);
+
+	return 0;
+}
+
+/**
+ * mpioc_xvm_create() - create an extended VMA map (AKA mcache map)
+ * @unit:
+ * @arg:
+ */
+int mpioc_xvm_create(struct mpc_unit *unit, struct mpool_descriptor *mp, struct mpioc_vma *ioc)
+{
+	struct mpc_mbinfo *mbinfov;
+	struct kmem_cache *cache;
+	struct mpc_rgnmap *rm;
+	struct mpc_xvm *xvm;
+	size_t largest, sz;
+	uint mbidc, mult;
+	u64 *mbidv;
+	int rc, i;
+
+	if (!unit || !unit->un_mapping || !ioc)
+		return -EINVAL;
+
+	if (ioc->im_mbidc < 1)
+		return -EINVAL;
+
+	if (ioc->im_advice > MPC_VMA_PINNED)
+		return -EINVAL;
+
+	mult = 1;
+	if (ioc->im_advice == MPC_VMA_WARM)
+		mult = 10;
+	else if (ioc->im_advice == MPC_VMA_HOT)
+		mult = 100;
+
+	mbidc = ioc->im_mbidc;
+
+	sz = sizeof(*xvm) + sizeof(*mbinfov) * mbidc;
+	if (sz > mpc_xvm_cachesz[1])
+		return -EINVAL;
+	else if (sz > mpc_xvm_cachesz[0])
+		cache = mpc_xvm_cache[1];
+	else
+		cache = mpc_xvm_cache[0];
+
+	sz = mbidc * sizeof(mbidv[0]);
+
+	mbidv = kmalloc(sz, GFP_KERNEL);
+	if (!mbidv)
+		return -ENOMEM;
+
+	rc = copy_from_user(mbidv, ioc->im_mbidv, sz);
+	if (rc) {
+		kfree(mbidv);
+		return -EFAULT;
+	}
+
+	xvm = kmem_cache_zalloc(cache, GFP_KERNEL);
+	if (!xvm) {
+		kfree(mbidv);
+		return -ENOMEM;
+	}
+
+	xvm->xvm_magic = (u32)(uintptr_t)xvm;
+	xvm->xvm_mbinfoc = mbidc;
+	xvm->xvm_mpdesc = mp;
+
+	xvm->xvm_mapping = unit->un_mapping;
+	xvm->xvm_rgnmap = &unit->un_rgnmap;
+	xvm->xvm_advice = ioc->im_advice;
+	kref_init(&xvm->xvm_ref);
+	xvm->xvm_cache = cache;
+	atomic_set(&xvm->xvm_opened, 0);
+
+	atomic64_set(&xvm->xvm_nrpages, 0);
+	atomic_set(&xvm->xvm_rabusy, 0);
+
+	largest = 0;
+
+	mbinfov = xvm->xvm_mbinfov;
+
+	for (i = 0; i < mbidc; ++i) {
+		struct mpc_mbinfo *mbinfo = mbinfov + i;
+		struct mblock_props props;
+
+		rc = mblock_find_get(mp, mbidv[i], 1, &props, &mbinfo->mbdesc);
+		if (rc) {
+			mbidc = i;
+			goto errout;
+		}
+
+		mbinfo->mblen = ALIGN(props.mpr_write_len, PAGE_SIZE);
+		mbinfo->mbmult = mult;
+		atomic64_set(&mbinfo->mbatime, 0);
+
+		largest = max_t(size_t, largest, mbinfo->mblen);
+	}
+
+	xvm->xvm_bktsz = roundup_pow_of_two(largest);
+
+	if (xvm->xvm_bktsz * mbidc > (1ul << xvm_size_max)) {
+		rc = -E2BIG;
+		goto errout;
+	}
+
+	rm = &unit->un_rgnmap;
+
+	mutex_lock(&rm->rm_lock);
+	xvm->xvm_rgn = idr_alloc(&rm->rm_root, NULL, 1, -1, GFP_KERNEL);
+	if (xvm->xvm_rgn < 1) {
+		mutex_unlock(&rm->rm_lock);
+
+		rc = xvm->xvm_rgn ?: -EINVAL;
+		goto errout;
+	}
+
+	ioc->im_offset = (ulong)xvm->xvm_rgn << xvm_size_max;
+	ioc->im_bktsz = xvm->xvm_bktsz;
+	ioc->im_len = xvm->xvm_bktsz * mbidc;
+	ioc->im_len = ALIGN(ioc->im_len, (1ul << xvm_size_max));
+
+	atomic_inc(&rm->rm_rgncnt);
+
+	idr_replace(&rm->rm_root, xvm, xvm->xvm_rgn);
+	mutex_unlock(&rm->rm_lock);
+
+errout:
+	if (rc) {
+		for (i = 0; i < mbidc; ++i)
+			mblock_put(mbinfov[i].mbdesc);
+		kmem_cache_free(cache, xvm);
+	}
+
+	kfree(mbidv);
+
+	return rc;
+}
+
+/**
+ * mpioc_xvm_destroy() - destroy an extended VMA
+ * @unit:
+ * @arg:
+ */
+int mpioc_xvm_destroy(struct mpc_unit *unit, struct mpioc_vma *ioc)
+{
+	struct mpc_rgnmap *rm;
+	struct mpc_xvm *xvm;
+	u64 rgn;
+
+	if (!unit || !ioc)
+		return -EINVAL;
+
+	rgn = ioc->im_offset >> xvm_size_max;
+	rm = &unit->un_rgnmap;
+
+	mutex_lock(&rm->rm_lock);
+	xvm = idr_find(&rm->rm_root, rgn);
+	if (xvm && kref_read(&xvm->xvm_ref) == 1 && !atomic_read(&xvm->xvm_opened))
+		idr_remove(&rm->rm_root, rgn);
+	else
+		xvm = NULL;
+	mutex_unlock(&rm->rm_lock);
+
+	if (xvm)
+		mpc_xvm_put(xvm);
+
+	return 0;
+}
+
+int mpioc_xvm_purge(struct mpc_unit *unit, struct mpioc_vma *ioc)
+{
+	struct mpc_xvm *xvm;
+	u64 rgn;
+
+	if (!unit || !ioc)
+		return -EINVAL;
+
+	rgn = ioc->im_offset >> xvm_size_max;
+
+	xvm = mpc_xvm_lookup(&unit->un_rgnmap, rgn);
+	if (!xvm)
+		return -ENOENT;
+
+	mpc_xvm_put(xvm);
+
+	return 0;
+}
+
+int mpioc_xvm_vrss(struct mpc_unit *unit, struct mpioc_vma *ioc)
+{
+	struct mpc_xvm *xvm;
+	u64 rgn;
+
+	if (!unit || !ioc)
+		return -EINVAL;
+
+	rgn = ioc->im_offset >> xvm_size_max;
+
+	xvm = mpc_xvm_lookup(&unit->un_rgnmap, rgn);
+	if (!xvm)
+		return -ENOENT;
+
+	ioc->im_vssp = mpc_xvm_pglen(xvm);
+	ioc->im_rssp = atomic64_read(&xvm->xvm_nrpages);
+
+	mpc_xvm_put(xvm);
+
+	return 0;
+}
+
+int mcache_init(void)
+{
+	size_t sz;
+	int rc, i;
+
+	xvm_max = clamp_t(uint, xvm_max, 1024, 1u << 30);
+	xvm_size_max = clamp_t(ulong, xvm_size_max, 27, 32);
+
+	sz = sizeof(struct mpc_mbinfo) * 8;
+	mpc_xvm_cachesz[0] = sizeof(struct mpc_xvm) + sz;
+
+	mpc_xvm_cache[0] = kmem_cache_create("mpool_xvm_0", mpc_xvm_cachesz[0], 0,
+					     SLAB_HWCACHE_ALIGN | SLAB_POISON, NULL);
+	if (!mpc_xvm_cache[0]) {
+		rc = -ENOMEM;
+		mp_pr_err("mpc xvm cache 0 create failed", rc);
+		return rc;
+	}
+
+	sz = sizeof(struct mpc_mbinfo) * 32;
+	mpc_xvm_cachesz[1] = sizeof(struct mpc_xvm) + sz;
+
+	mpc_xvm_cache[1] = kmem_cache_create("mpool_xvm_1", mpc_xvm_cachesz[1], 0,
+					     SLAB_HWCACHE_ALIGN | SLAB_POISON, NULL);
+	if (!mpc_xvm_cache[1]) {
+		rc = -ENOMEM;
+		mp_pr_err("mpc xvm cache 1 create failed", rc);
+		goto errout;
+	}
+
+	mpc_wq_trunc = alloc_workqueue("mpc_wq_trunc", WQ_UNBOUND, 16);
+	if (!mpc_wq_trunc) {
+		rc = -ENOMEM;
+		mp_pr_err("trunc workqueue alloc failed", rc);
+		goto errout;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(mpc_wq_rav); ++i) {
+		int     maxactive = 16;
+		char    name[16];
+
+		snprintf(name, sizeof(name), "mpc_wq_ra%d", i);
+
+		mpc_wq_rav[i] = alloc_workqueue(name, 0, maxactive);
+		if (!mpc_wq_rav[i]) {
+			rc = -ENOMEM;
+			mp_pr_err("mpctl ra workqueue alloc failed", rc);
+			goto errout;
+		}
+	}
+
+	return 0;
+
+errout:
+	mcache_exit();
+	return rc;
+}
+
+void mcache_exit(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mpc_wq_rav); ++i) {
+		if (mpc_wq_rav[i])
+			destroy_workqueue(mpc_wq_rav[i]);
+		mpc_wq_rav[i] = NULL;
+	}
+
+	if (mpc_wq_trunc)
+		destroy_workqueue(mpc_wq_trunc);
+	kmem_cache_destroy(mpc_xvm_cache[1]);
+	kmem_cache_destroy(mpc_xvm_cache[0]);
+}
+
+static const struct vm_operations_struct mpc_vops_default = {
+	.open           = mpc_vm_open,
+	.close          = mpc_vm_close,
+	.fault          = mpc_vm_fault,
+};
+
+const struct address_space_operations mpc_aops_default = {
+	.readpages      = mpc_readpages,
+	.releasepage    = mpc_releasepage,
+	.invalidatepage = mpc_invalidatepage,
+	.migratepage    = mpc_migratepage,
+};
diff --git a/drivers/mpool/mcache.h b/drivers/mpool/mcache.h
new file mode 100644
index 000000000000..fe6f45a05494
--- /dev/null
+++ b/drivers/mpool/mcache.h
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+
+#ifndef MPOOL_MCACHE_H
+#define MPOOL_MCACHE_H
+
+#include <linux/kref.h>
+
+#include "init.h"
+#include "mblock.h"
+
+struct mpc_unit;
+
+/**
+ * struct mpc_rgnmap - extended vma (xvm) region management
+ * @rm_lock:    protects rm_root
+ * @rm_root:    root of the region map
+ * @rm_rgncnt;  number of active regions
+ *
+ * Note that this is not a ref-counted object, its lifetime
+ * is tied to struct mpc_unit.
+ */
+struct mpc_rgnmap {
+	struct mutex    rm_lock;
+	struct idr      rm_root;
+	atomic_t        rm_rgncnt;
+} ____cacheline_aligned;
+
+
+struct mpc_mbinfo {
+	struct mblock_descriptor   *mbdesc;
+	u32                         mblen;
+	u32                         mbmult;
+	atomic64_t                  mbatime;
+} __aligned(32);
+
+struct mpc_xvm {
+	size_t                      xvm_bktsz;
+	uint                        xvm_mbinfoc;
+	uint                        xvm_rgn;
+	struct kref                 xvm_ref;
+	u32                         xvm_magic;
+	struct mpool_descriptor    *xvm_mpdesc;
+
+	atomic64_t                 *xvm_hcpagesp;
+	struct address_space       *xvm_mapping;
+	struct mpc_rgnmap          *xvm_rgnmap;
+
+	enum mpc_vma_advice         xvm_advice;
+	atomic_t                    xvm_opened;
+	struct kmem_cache          *xvm_cache;
+	struct mpc_xvm             *xvm_next;
+
+	____cacheline_aligned
+	atomic64_t                  xvm_nrpages;
+	atomic_t                    xvm_rabusy;
+	struct work_struct          xvm_work;
+
+	____cacheline_aligned
+	struct mpc_mbinfo           xvm_mbinfov[];
+};
+
+extern const struct address_space_operations mpc_aops_default;
+
+void mpc_rgnmap_flush(struct mpc_rgnmap *rm);
+
+int mpc_mmap(struct file *fp, struct vm_area_struct *vma);
+
+int mpc_fadvise(struct file *file, loff_t offset, loff_t len, int advice);
+
+int mpioc_xvm_create(struct mpc_unit *unit, struct mpool_descriptor *mp, struct mpioc_vma *ioc);
+
+int mpioc_xvm_destroy(struct mpc_unit *unit, struct mpioc_vma *ioc);
+
+int mpioc_xvm_purge(struct mpc_unit *unit, struct mpioc_vma *ioc);
+
+int mpioc_xvm_vrss(struct mpc_unit *unit, struct mpioc_vma *ioc);
+
+void mpc_xvm_free(struct mpc_xvm *xvm);
+
+int mcache_init(void) __cold;
+void mcache_exit(void) __cold;
+
+static inline pgoff_t mpc_xvm_pgoff(struct mpc_xvm *xvm)
+{
+	return ((ulong)xvm->xvm_rgn << xvm_size_max) >> PAGE_SHIFT;
+}
+
+static inline size_t mpc_xvm_pglen(struct mpc_xvm *xvm)
+{
+	return (xvm->xvm_bktsz * xvm->xvm_mbinfoc) >> PAGE_SHIFT;
+}
+
+#endif /* MPOOL_MCACHE_H */
diff --git a/drivers/mpool/mpctl.c b/drivers/mpool/mpctl.c
index 3a231cf982b3..f11f522ec90c 100644
--- a/drivers/mpool/mpctl.c
+++ b/drivers/mpool/mpctl.c
@@ -142,6 +142,11 @@ static ssize_t mpc_label_show(struct device *dev, struct device_attribute *da, c
 	return scnprintf(buf, PAGE_SIZE, "%s\n", dev_to_unit(dev)->un_label);
 }
 
+static ssize_t mpc_vma_show(struct device *dev, struct device_attribute *da, char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "%u\n", xvm_size_max);
+}
+
 static ssize_t mpc_type_show(struct device *dev, struct device_attribute *da, char *buf)
 {
 	struct mpool_uuid  uuid;
@@ -160,6 +165,7 @@ static void mpc_mpool_params_add(struct device_attribute *dattr)
 	MPC_ATTR_RO(dattr++, mode);
 	MPC_ATTR_RO(dattr++, ra);
 	MPC_ATTR_RO(dattr++, label);
+	MPC_ATTR_RO(dattr++, vma);
 	MPC_ATTR_RO(dattr,   type);
 }
 
@@ -243,6 +249,8 @@ static void mpool_params_merge_defaults(struct mpool_params *params)
 	if (params->mp_mode != -1)
 		params->mp_mode &= 0777;
 
+	params->mp_vma_size_max = xvm_size_max;
+
 	params->mp_rsvd0 = 0;
 	params->mp_rsvd1 = 0;
 	params->mp_rsvd2 = 0;
@@ -382,6 +390,10 @@ static int mpc_unit_create(const char *name, struct mpc_mpool *mpool, struct mpc
 	kref_init(&unit->un_ref);
 	unit->un_mpool = mpool;
 
+	mutex_init(&unit->un_rgnmap.rm_lock);
+	idr_init(&unit->un_rgnmap.rm_root);
+	atomic_set(&unit->un_rgnmap.rm_rgncnt, 0);
+
 	mutex_lock(&ss->ss_lock);
 	minor = idr_alloc(&ss->ss_unitmap, NULL, 0, -1, GFP_KERNEL);
 	mutex_unlock(&ss->ss_lock);
@@ -421,6 +433,8 @@ static void mpc_unit_release(struct kref *refp)
 	if (unit->un_device)
 		device_destroy(ss->ss_class, unit->un_devno);
 
+	idr_destroy(&unit->un_rgnmap.rm_root);
+
 	kfree(unit);
 }
 
@@ -633,6 +647,7 @@ static int mpc_cf_journal(struct mpc_unit *unit)
 	cfg.mc_oid2 = unit->un_ds_oidv[1];
 	cfg.mc_captgt = unit->un_mdc_captgt;
 	cfg.mc_ra_pages_max = unit->un_ra_pages_max;
+	cfg.mc_vma_size_max = xvm_size_max;
 	memcpy(&cfg.mc_utype, &unit->un_utype, sizeof(cfg.mc_utype));
 	strlcpy(cfg.mc_label, unit->un_label, sizeof(cfg.mc_label));
 
@@ -742,6 +757,7 @@ static int mpioc_params_get(struct mpc_unit *unit, struct mpioc_params *get)
 	params->mp_oidv[0] = unit->un_ds_oidv[0];
 	params->mp_oidv[1] = unit->un_ds_oidv[1];
 	params->mp_ra_pages_max = unit->un_ra_pages_max;
+	params->mp_vma_size_max = xvm_size_max;
 	memcpy(&params->mp_utype, &unit->un_utype, sizeof(params->mp_utype));
 	strlcpy(params->mp_label, unit->un_label, sizeof(params->mp_label));
 	strlcpy(params->mp_name, unit->un_name, sizeof(params->mp_name));
@@ -785,6 +801,8 @@ static int mpioc_params_set(struct mpc_unit *unit, struct mpioc_params *set)
 
 	params = &set->mps_params;
 
+	params->mp_vma_size_max = xvm_size_max;
+
 	mutex_lock(&ss->ss_lock);
 	if (params->mp_uid != -1 || params->mp_gid != -1 || params->mp_mode != -1) {
 		err = mpc_mp_chown(unit, params);
@@ -919,6 +937,7 @@ static void mpioc_prop_get(struct mpc_unit *unit, struct mpioc_prop *kprop)
 	params->mp_oidv[0] = unit->un_ds_oidv[0];
 	params->mp_oidv[1] = unit->un_ds_oidv[1];
 	params->mp_ra_pages_max = unit->un_ra_pages_max;
+	params->mp_vma_size_max = xvm_size_max;
 	memcpy(&params->mp_utype, &unit->un_utype, sizeof(params->mp_utype));
 	strlcpy(params->mp_label, unit->un_label, sizeof(params->mp_label));
 	strlcpy(params->mp_name, unit->un_name, sizeof(params->mp_name));
@@ -1171,6 +1190,7 @@ static int mpioc_mp_create(struct mpc_unit *ctl, struct mpioc_mpool *mp,
 	cfg.mc_rsvd0 = mp->mp_params.mp_rsvd0;
 	cfg.mc_captgt = MPOOL_ROOT_LOG_CAP;
 	cfg.mc_ra_pages_max = mp->mp_params.mp_ra_pages_max;
+	cfg.mc_vma_size_max = mp->mp_params.mp_vma_size_max;
 	cfg.mc_rsvd1 = mp->mp_params.mp_rsvd1;
 	cfg.mc_rsvd2 = mp->mp_params.mp_rsvd2;
 	cfg.mc_rsvd3 = mp->mp_params.mp_rsvd3;
@@ -1300,6 +1320,7 @@ static int mpioc_mp_activate(struct mpc_unit *ctl, struct mpioc_mpool *mp,
 	mp->mp_params.mp_oidv[0] = cfg.mc_oid1;
 	mp->mp_params.mp_oidv[1] = cfg.mc_oid2;
 	mp->mp_params.mp_ra_pages_max = cfg.mc_ra_pages_max;
+	mp->mp_params.mp_vma_size_max = cfg.mc_vma_size_max;
 	memcpy(&mp->mp_params.mp_utype, &cfg.mc_utype, sizeof(mp->mp_params.mp_utype));
 	strlcpy(mp->mp_params.mp_label, cfg.mc_label, sizeof(mp->mp_params.mp_label));
 
@@ -2313,6 +2334,7 @@ static int mpc_open(struct inode *ip, struct file *fp)
 	}
 
 	fp->f_op = &mpc_fops_default;
+	fp->f_mapping->a_ops = &mpc_aops_default;
 
 	unit->un_mapping = fp->f_mapping;
 
@@ -2361,8 +2383,11 @@ static int mpc_release(struct inode *ip, struct file *fp)
 	if (!lastclose)
 		goto errout;
 
-	if (mpc_unit_ismpooldev(unit))
+	if (mpc_unit_ismpooldev(unit)) {
+		mpc_rgnmap_flush(&unit->un_rgnmap);
+
 		unit->un_mapping = NULL;
+	}
 
 	unit->un_open_excl = false;
 
@@ -2530,6 +2555,22 @@ static long mpc_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
 		rc = mpioc_mlog_erase(unit, argp);
 		break;
 
+	case MPIOC_VMA_CREATE:
+		rc = mpioc_xvm_create(unit, unit->un_mpool->mp_desc, argp);
+		break;
+
+	case MPIOC_VMA_DESTROY:
+		rc = mpioc_xvm_destroy(unit, argp);
+		break;
+
+	case MPIOC_VMA_PURGE:
+		rc = mpioc_xvm_purge(unit, argp);
+		break;
+
+	case MPIOC_VMA_VRSS:
+		rc = mpioc_xvm_vrss(unit, argp);
+		break;
+
 	default:
 		rc = -ENOTTY;
 		mp_pr_rl("invalid command %x: dir=%u type=%c nr=%u size=%u",
@@ -2553,6 +2594,8 @@ static const struct file_operations mpc_fops_default = {
 	.open		= mpc_open,
 	.release	= mpc_release,
 	.unlocked_ioctl	= mpc_ioctl,
+	.mmap           = mpc_mmap,
+	.fadvise        = mpc_fadvise,
 };
 
 static int mpc_exit_unit(int minor, void *item, void *arg)
diff --git a/drivers/mpool/mpctl.h b/drivers/mpool/mpctl.h
index 412a6a491c15..b93e44248f03 100644
--- a/drivers/mpool/mpctl.h
+++ b/drivers/mpool/mpctl.h
@@ -11,6 +11,8 @@
 #include <linux/device.h>
 #include <linux/semaphore.h>
 
+#include "mcache.h"
+
 #define ITERCB_NEXT     (0)
 #define ITERCB_DONE     (1)
 
@@ -23,6 +25,7 @@ struct mpc_unit {
 	uid_t                       un_uid;
 	gid_t                       un_gid;
 	mode_t                      un_mode;
+	struct mpc_rgnmap           un_rgnmap;
 	dev_t                       un_devno;
 	const struct mpc_uinfo     *un_uinfo;
 	struct mpc_mpool           *un_mpool;
-- 
2.17.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

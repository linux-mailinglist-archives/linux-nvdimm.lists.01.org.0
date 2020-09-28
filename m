Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA9327B257
	for <lists+linux-nvdimm@lfdr.de>; Mon, 28 Sep 2020 18:47:43 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8D948153A89FD;
	Mon, 28 Sep 2020 09:47:28 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.77.88; helo=nam02-sn1-obe.outbound.protection.outlook.com; envelope-from=nmeeramohide@micron.com; receiver=<UNKNOWN> 
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-eopbgr770088.outbound.protection.outlook.com [40.107.77.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CB35C152EDBCB
	for <linux-nvdimm@lists.01.org>; Mon, 28 Sep 2020 09:47:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDZ2N+SjNYXQZUG5k/0p567bYGQSY/03eIaiiSFcpiQBgQj869kP3oaZY2NFOwbgGvEBNZL3ROAtzc3VrmMhaakChwRJpcHLketx78Bwv4PifKIAtDQFGAOBPbtxA/nOC4gUfjpBc93iRhIo0iSgID2XwhcrH4bFOIWvPHcYSY6X6V/QVaTmmd2EIaocUhrS12hGngdLZme00fnVQsqSl3XzboR+F9FA+O8G1El53WySIndRB/Df6EW/s7jYJXLhraLUEKNUGxD3OjKRnZqiYN+RMrGuNcrunekJFtLtbhg8/dslAgI+OQa7bRHOl2AujotQuVfDsr/a2lOFmR9xmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3AHN/M7HgjTxtgdmSf1/n6pC28a1p0tV7pfc1+eKUo=;
 b=gWznpt+VlNYHbano/90x1BTCxCL3RjMnP82dGDwt0Xyv0CxtJ1DpVFPpsizqmL7IpAURnZppKmym8sgfC/hJW1s4Yfg+x5R8tEWcyrpQ3I7923TidiMJLSAb52RU4echbKNFb+Pf3C4Zmc30gQadnE03a1lCwF5fbk5Lgsy7No/yVxm3cHbqwHdei/MCTjFKgvy8Uh9pvc6vScEKElhZkxKYUjszAopAiecqbbZGLkUAgrfRAJDCKukqygyDYknKqMsoqY+vSyrNUXPuO0dT88GvIIOQLc+J84nJgPwV1XA6hGgxVQ8JpX9t1r0gXEBnQZYuNt5ZOSYAZE+VKaEeJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=kvack.org smtp.mailfrom=micron.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3AHN/M7HgjTxtgdmSf1/n6pC28a1p0tV7pfc1+eKUo=;
 b=Bx1Jp8ndl2MkZ6UJgO6EOIIkOaVZvOegqw1nF28VQHYj0uU1nAKSIgMVuKvJms38r5R6xQWtY8Jpmn5nn2CMTg1l2OyFB8dek2zKd+dyXy9u0f0QeAcSG4rqPvZZVHxTWa/ND2Jl0PF8kthZVZ+oIyjn7QTjjd4o8S6qG/UvHV4=
Received: from BN6PR13CA0036.namprd13.prod.outlook.com (2603:10b6:404:13e::22)
 by DM6PR08MB5723.namprd08.prod.outlook.com (2603:10b6:5:155::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.29; Mon, 28 Sep
 2020 16:47:21 +0000
Received: from BN3NAM01FT028.eop-nam01.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::4) by BN6PR13CA0036.outlook.office365.com
 (2603:10b6:404:13e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.17 via Frontend
 Transport; Mon, 28 Sep 2020 16:47:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com;
Received: from mail.micron.com (137.201.242.130) by
 BN3NAM01FT028.mail.protection.outlook.com (10.152.67.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3412.21 via Frontend Transport; Mon, 28 Sep 2020 16:47:21 +0000
Received: from micron.com (10.114.5.55) by bowex17c.micron.com
 (137.201.21.211) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 28 Sep
 2020 10:47:16 -0600
From: <nmeeramohide@micron.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-nvdimm@lists.01.org>
Subject: [PATCH 20/22] mpool: add support to proactively evict cached mblock data from the page-cache
Date: Mon, 28 Sep 2020 11:45:32 -0500
Message-ID: <20200928164534.48203-21-nmeeramohide@micron.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200928164534.48203-1-nmeeramohide@micron.com>
References: <20200928164534.48203-1-nmeeramohide@micron.com>
MIME-Version: 1.0
X-ClientProxiedBy: bowex17d.micron.com (137.201.21.212) To bowex17c.micron.com
 (137.201.21.211)
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24646.005
X-TM-AS-Result: No--7.484900-0.000000-31
X-TM-AS-MatchedID: 700076-702928-704804-702719-847298-703651-702083-703863-7
	03812-705223-704807-703357-704418-705140-105630-705161-704031-700010-702203
	-701757-705041-700335-700025-704960-704965-704278-704524-701480-701809-7030
	17-702395-188019-704397-703279-701270-704477-704318-700351-702619-702837-70
	4793-702898-702617-702914-701964-700071-704806-703330-703215-701274-704926-
	700069-703744-300015-703213-703880-702102-106470-705244-703904-700488-12136
	7-701342-702415-704127-702433-703140-121336-701105-704673-703967-703901-702
	665-702754-186102-704792-702259-705220-702887-701194-702171-139630-702177-1
	21270-702960-705173-186035-704264-703993-700535-148004-148036-42000-42003
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e731e6c-bafe-4a61-ccfe-08d863ce2b2d
X-MS-TrafficTypeDiagnostic: DM6PR08MB5723:
X-Microsoft-Antispam-PRVS: 
 <DM6PR08MB572339F46F6D10A69566E76BB3350@DM6PR08MB5723.namprd08.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	wRuvTOoEWKXliDKF6iRmV9jrjA/NTtQGBZnnnrnJy4GKnC0f8Y63ygevncgvNwNrrh+MTP5fq+E4wnaydu+oFUnoGxlt0koff8L6g3IV321tB2BfAcW7NUE3ynnablpQro0V802+URO9rcbCnqSU5qtqI3dhQxOLhA4l0fGpogu/p0AzUNBirAJgoKFl9gyTIz1LyyJRyux8bgLNUg1q+k63TlwpMbYyUc4jW8Lq4+uj51tQhs0itSq2Ck52KuuyTSmbIXbsEmIaBN5Rf14W50/RAaxBCUe1JDTU+TcLrEraMBENum58gSADmDLzw9AD4oFZrQ/9UGwH0RBZzgN4+n3z+SIvvMV38RcRsmMf12VTSOAJ0pfPHFhZXEy3xHH+zuxHvz2kize5W2YqDIEFIgkI8cCgF1CC8ne3iILzpSLXPfw+NnDJs37MRzO+pkcvZ2LdTmXTxARfbpsfaUtYViTi08gSilB/CwEyuyI2pHFDBMzE8qebfSj073Mvgj3WvCBqpB3VbHcClhdLC+1MeQ==
X-Forefront-Antispam-Report: 
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(46966005)(6666004)(82740400003)(7696005)(186003)(82310400003)(70206006)(33310700002)(356005)(83380400001)(336012)(478600001)(316002)(86362001)(54906003)(47076004)(36756003)(70586007)(110136005)(4326008)(26005)(55016002)(426003)(2906002)(2616005)(2876002)(1076003)(30864003)(7636003)(5660300002)(8936002)(107886003)(6286002)(8676002)(2101003)(305334003);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 16:47:21.0180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e731e6c-bafe-4a61-ccfe-08d863ce2b2d
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3NAM01FT028.eop-nam01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB5723
Message-ID-Hash: N76YIFRF566HFVH7RIFTXEL5WGHTUF2H
X-Message-ID-Hash: N76YIFRF566HFVH7RIFTXEL5WGHTUF2H
X-MailFrom: nmeeramohide@micron.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: smoyer@micron.com, gbecker@micron.com, plabat@micron.com, jgroves@micron.com, Nabeel M Mohamed <nmeeramohide@micron.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/N76YIFRF566HFVH7RIFTXEL5WGHTUF2H/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Nabeel M Mohamed <nmeeramohide@micron.com>

This adds a mechanism to track object-level usage metrics and use
that metrics to proactively evict mblock data from the page cache.

The proactive reaping is employed just before the onset of memory
pressure, which greatly improves throughput and reduces tail
latencies for read and memory intensive workloads.

The reaper component tracks residency of pages from specified xvms
and weighs the memory used against system free memory. The reaper
begins evicting pages from the specified xvm when the free memory
falls below a predetermined low watermark, stopping when the free
memory rises above a high watermark.

The reaper maintains several lists of xvms and cycles through them
in a round-robin fashion to select pages to evict. Each xvm is
comprised of one or more contiguous virtual subranges of pages,
where each subrange is delineated by an mblock. Each mblock has an
associated access time which is updated on each page fault to any
page in the mblock.  The reaper leverages the atime to decide
whether or not to evict all the pages in the subrange based upon
the current TTL, where the current TTL grows shorter as the urgency
to evict pages grows stronger.

Co-developed-by: Greg Becker <gbecker@micron.com>
Signed-off-by: Greg Becker <gbecker@micron.com>
Co-developed-by: Pierre Labat <plabat@micron.com>
Signed-off-by: Pierre Labat <plabat@micron.com>
Co-developed-by: John Groves <jgroves@micron.com>
Signed-off-by: John Groves <jgroves@micron.com>
Signed-off-by: Nabeel M Mohamed <nmeeramohide@micron.com>
---
 drivers/mpool/mcache.c |  43 +++
 drivers/mpool/mcache.h |   8 +
 drivers/mpool/mpctl.c  |  15 +
 drivers/mpool/mpctl.h  |   6 +
 drivers/mpool/reaper.c | 692 +++++++++++++++++++++++++++++++++++++++++
 drivers/mpool/reaper.h |  71 +++++
 6 files changed, 835 insertions(+)
 create mode 100644 drivers/mpool/reaper.c
 create mode 100644 drivers/mpool/reaper.h

diff --git a/drivers/mpool/mcache.c b/drivers/mpool/mcache.c
index b93ef85b300f..7201252292eb 100644
--- a/drivers/mpool/mcache.c
+++ b/drivers/mpool/mcache.c
@@ -17,6 +17,7 @@
 #include "assert.h"
 
 #include "mpctl.h"
+#include "reaper.h"
 
 #ifndef lru_to_page
 #define lru_to_page(_head)  (list_entry((_head)->prev, struct page, lru))
@@ -62,6 +63,7 @@ const struct address_space_operations mpc_aops_default;
 
 static struct workqueue_struct *mpc_wq_trunc __read_mostly;
 static struct workqueue_struct *mpc_wq_rav[4] __read_mostly;
+struct mpc_reap *mpc_reap __read_mostly;
 
 static size_t mpc_xvm_cachesz[2] __read_mostly;
 static struct kmem_cache *mpc_xvm_cache[2] __read_mostly;
@@ -107,6 +109,10 @@ void mpc_rgnmap_flush(struct mpc_rgnmap *rm)
 		head = xvm->xvm_next;
 		mpc_xvm_put(xvm);
 	}
+
+	/* Wait for reaper to prune its lists... */
+	while (atomic_read(&rm->rm_rgncnt) > 0)
+		usleep_range(100000, 150000);
 }
 
 static struct mpc_xvm *mpc_xvm_lookup(struct mpc_rgnmap *rm, uint key)
@@ -127,6 +133,22 @@ void mpc_xvm_free(struct mpc_xvm *xvm)
 	struct mpc_rgnmap *rm;
 
 	ASSERT((u32)(uintptr_t)xvm == xvm->xvm_magic);
+	ASSERT(atomic_read(&xvm->xvm_reapref) > 0);
+
+again:
+	mpc_reap_xvm_evict(xvm);
+
+	if (atomic_dec_return(&xvm->xvm_reapref) > 0) {
+		atomic_inc(xvm->xvm_freedp);
+		return;
+	}
+
+	if (atomic64_read(&xvm->xvm_nrpages) > 0) {
+		atomic_cmpxchg(&xvm->xvm_evicting, 1, 0);
+		atomic_inc(&xvm->xvm_reapref);
+		usleep_range(10000, 30000);
+		goto again;
+	}
 
 	rm = xvm->xvm_rgnmap;
 
@@ -335,6 +357,8 @@ static vm_fault_t mpc_vm_fault_impl(struct vm_area_struct *vma, struct vm_fault
 	/* Page is locked with a ref. */
 	vmf->page = page;
 
+	mpc_reap_xvm_touch(vma->vm_private_data, page->index);
+
 	return vmfrc | VM_FAULT_LOCKED;
 }
 
@@ -532,6 +556,9 @@ static int mpc_readpages(struct file *file, struct address_space *mapping,
 	gfp = mapping_gfp_mask(mapping) & GFP_KERNEL;
 	wq = mpc_rgn2wq(xvm->xvm_rgn);
 
+	if (mpc_reap_xvm_duress(xvm))
+		nr_pages = min_t(uint, nr_pages, 8);
+
 	nr_pages = min_t(uint, nr_pages, ra_pages_max);
 
 	for (i = 0; i < nr_pages; ++i) {
@@ -601,6 +628,8 @@ static int mpc_readpages(struct file *file, struct address_space *mapping,
  * @gfp:
  *
  * The function is added as part of tracking incoming and outgoing pages.
+ * When the number of pages owned exceeds the limit (if defined) reap function
+ * will get invoked to trim down the usage.
  */
 static int mpc_releasepage(struct page *page, gfp_t gfp)
 {
@@ -696,6 +725,8 @@ int mpc_mmap(struct file *fp, struct vm_area_struct *vma)
 
 	fp->f_ra.ra_pages = unit->un_ra_pages_max;
 
+	mpc_reap_xvm_add(unit->un_ds_reap, xvm);
+
 	return 0;
 }
 
@@ -769,6 +800,9 @@ int mpioc_xvm_create(struct mpc_unit *unit, struct mpool_descriptor *mp, struct
 	xvm->xvm_cache = cache;
 	atomic_set(&xvm->xvm_opened, 0);
 
+	INIT_LIST_HEAD(&xvm->xvm_list);
+	atomic_set(&xvm->xvm_evicting, 0);
+	atomic_set(&xvm->xvm_reapref, 1);
 	atomic64_set(&xvm->xvm_nrpages, 0);
 	atomic_set(&xvm->xvm_rabusy, 0);
 
@@ -878,6 +912,8 @@ int mpioc_xvm_purge(struct mpc_unit *unit, struct mpioc_vma *ioc)
 	if (!xvm)
 		return -ENOENT;
 
+	mpc_reap_xvm_evict(xvm);
+
 	mpc_xvm_put(xvm);
 
 	return 0;
@@ -942,6 +978,12 @@ int mcache_init(void)
 		goto errout;
 	}
 
+	rc = mpc_reap_create(&mpc_reap);
+	if (rc) {
+		mp_pr_err("reap create failed", rc);
+		goto errout;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(mpc_wq_rav); ++i) {
 		int     maxactive = 16;
 		char    name[16];
@@ -973,6 +1015,7 @@ void mcache_exit(void)
 		mpc_wq_rav[i] = NULL;
 	}
 
+	mpc_reap_destroy(mpc_reap);
 	if (mpc_wq_trunc)
 		destroy_workqueue(mpc_wq_trunc);
 	kmem_cache_destroy(mpc_xvm_cache[1]);
diff --git a/drivers/mpool/mcache.h b/drivers/mpool/mcache.h
index 46c11d0ce5c9..9197fde3d858 100644
--- a/drivers/mpool/mcache.h
+++ b/drivers/mpool/mcache.h
@@ -47,12 +47,19 @@ struct mpc_xvm {
 	atomic64_t                 *xvm_hcpagesp;
 	struct address_space       *xvm_mapping;
 	struct mpc_rgnmap          *xvm_rgnmap;
+	struct mpc_reap            *xvm_reap;
 
 	enum mpc_vma_advice         xvm_advice;
 	atomic_t                    xvm_opened;
 	struct kmem_cache          *xvm_cache;
 	struct mpc_xvm             *xvm_next;
 
+	____cacheline_aligned
+	struct list_head            xvm_list;
+	atomic_t                    xvm_evicting;
+	atomic_t                    xvm_reapref;
+	atomic_t                   *xvm_freedp;
+
 	____cacheline_aligned
 	atomic64_t                  xvm_nrpages;
 	atomic_t                    xvm_rabusy;
@@ -62,6 +69,7 @@ struct mpc_xvm {
 	struct mpc_mbinfo           xvm_mbinfov[];
 };
 
+extern struct mpc_reap *mpc_reap;
 extern const struct address_space_operations mpc_aops_default;
 
 void mpc_rgnmap_flush(struct mpc_rgnmap *rm);
diff --git a/drivers/mpool/mpctl.c b/drivers/mpool/mpctl.c
index 961078205c5e..5c1a71572c4c 100644
--- a/drivers/mpool/mpctl.c
+++ b/drivers/mpool/mpctl.c
@@ -39,6 +39,7 @@
 #include "mp.h"
 #include "mpctl.h"
 #include "sysfs.h"
+#include "reaper.h"
 #include "init.h"
 
 
@@ -188,6 +189,10 @@ static int mpc_params_register(struct mpc_unit *unit, int cnt)
 	if (mpc_unit_ismpooldev(unit))
 		mpc_mpool_params_add(dattr);
 
+	/* Common parameters */
+	if (mpc_unit_isctldev(unit))
+		mpc_reap_params_add(dattr);
+
 	rc = mpc_attr_group_create(attr);
 	if (rc) {
 		mpc_attr_destroy(attr);
@@ -2382,6 +2387,7 @@ static int mpc_open(struct inode *ip, struct file *fp)
 	mpc_bdi_save(unit, ip);
 
 	unit->un_mapping = fp->f_mapping;
+	unit->un_ds_reap = mpc_reap;
 
 	inode_lock(ip);
 	i_size_write(ip, 1ul << 63);
@@ -2431,6 +2437,7 @@ static int mpc_release(struct inode *ip, struct file *fp)
 	if (mpc_unit_ismpooldev(unit)) {
 		mpc_rgnmap_flush(&unit->un_rgnmap);
 
+		unit->un_ds_reap = NULL;
 		unit->un_mapping = NULL;
 
 		mpc_bdi_restore(unit, ip);
@@ -2768,6 +2775,14 @@ int mpctl_init(void)
 		goto errout;
 	}
 
+	/* The reaper component has already been initialized before mpctl. */
+	ctlunit->un_ds_reap = mpc_reap;
+	rc = mpc_params_register(ctlunit, MPC_REAP_PARAMS_CNT);
+	if (rc) {
+		errmsg = "cannot register common parameters";
+		goto errout;
+	}
+
 	mutex_lock(&ss->ss_lock);
 	idr_replace(&ss->ss_unitmap, ctlunit, MINOR(ctlunit->un_devno));
 	mutex_unlock(&ss->ss_lock);
diff --git a/drivers/mpool/mpctl.h b/drivers/mpool/mpctl.h
index 8c926eef837c..6b6f12d7787f 100644
--- a/drivers/mpool/mpctl.h
+++ b/drivers/mpool/mpctl.h
@@ -30,6 +30,7 @@ struct mpc_unit {
 	const struct mpc_uinfo     *un_uinfo;
 	struct mpc_mpool           *un_mpool;
 	struct address_space       *un_mapping;
+	struct mpc_reap            *un_ds_reap;
 	struct device              *un_device;
 	struct backing_dev_info    *un_saved_bdi;
 	struct mpc_attr            *un_attr;
@@ -47,6 +48,11 @@ static inline struct mpc_unit *dev_to_unit(struct device *dev)
 	return dev_get_drvdata(dev);
 }
 
+static inline struct mpc_reap *dev_to_reap(struct device *dev)
+{
+	return dev_to_unit(dev)->un_ds_reap;
+}
+
 int mpctl_init(void) __cold;
 void mpctl_exit(void) __cold;
 
diff --git a/drivers/mpool/reaper.c b/drivers/mpool/reaper.c
new file mode 100644
index 000000000000..2a1be946e874
--- /dev/null
+++ b/drivers/mpool/reaper.c
@@ -0,0 +1,692 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+/*
+ * The reaper subsystem tracks residency of pages from specified VMAs and
+ * weighs the memory used against system free memory.  Should the relative
+ * residency vs free memory fall below a predetermined low watermark the
+ * reaper begins evicting pages from the specified VMAs, stopping when free
+ * memory rises above a high watermark that is slightly higher than the low
+ * watermark.
+ *
+ * The reaper maintains several lists of VMAs and cycles through them in a
+ * round-robin fashion to select pages to evict.  Each VMA is comprised of
+ * one or more contiguous virtual subranges of pages, where each subrange
+ * is delineated by an mblock (typically no larger than 32M).  Each mblock
+ * has an associated access time which is updated on each page fault to any
+ * page in the mblock.  The reaper leverages the atime to decide whether or
+ * not to evict all the pages in the subrange based upon the current TTL,
+ * where the current TTL grows shorter as the urgency to evict pages grows
+ * stronger.
+ */
+
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/delay.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/sched/clock.h>
+
+#include "mpool_printk.h"
+#include "assert.h"
+
+#include "sysfs.h"
+#include "mpctl.h"
+#include "reaper.h"
+
+#define REAP_ELEM_MAX       3
+
+/**
+ * struct mpc_reap_elem -
+ * @reap_lock:      lock to protect reap_list
+ * @reap_list:      list of inodes
+ * @reap_active:    reaping in progress
+ * @reap_hpages:    total hot pages which are mapped
+ * @reap_cpages:    total coldpages which are mapped
+ */
+struct mpc_reap_elem {
+	struct mutex            reap_lock;
+	struct list_head        reap_list;
+
+	____cacheline_aligned
+	atomic_t                reap_running;
+	struct work_struct      reap_work;
+	struct mpc_reap        *reap_reap;
+
+	____cacheline_aligned
+	atomic64_t              reap_hpages;
+	atomic_t                reap_nfreed;
+
+	____cacheline_aligned
+	atomic64_t              reap_wpages;
+
+	____cacheline_aligned
+	atomic64_t              reap_cpages;
+};
+
+/**
+ * struct mpc_reap -
+ * @reap_lwm:     Low water mark
+ * @reap_ttl_cur: Current time-to-live
+ * @reap_wq:
+ *
+ * @reap_hdr:     sysctl table header
+ * @reap_tab:     sysctl table components
+ * @reap_mempct:
+ * @reap_ttl:
+ * @reap_debug:
+ *
+ * @reap_eidx:    Pruner element index
+ * @reap_emit:    Pruner debug message control
+ * @reap_dwork:
+ * @reap_elem:    Array of reaper lists (reaper pool)
+ */
+struct mpc_reap {
+	atomic_t                    reap_lwm;
+	atomic_t                    reap_ttl_cur;
+	struct workqueue_struct    *reap_wq;
+
+	____cacheline_aligned
+	unsigned int                reap_mempct;
+	unsigned int                reap_ttl;
+	unsigned int                reap_debug;
+
+	____cacheline_aligned
+	atomic_t                    reap_eidx;
+	atomic_t                    reap_emit;
+	struct delayed_work         reap_dwork;
+
+	struct mpc_reap_elem        reap_elem[REAP_ELEM_MAX];
+};
+
+/**
+ * mpc_reap_meminfo() - Get current system-wide memory usage
+ * @freep:    ptr to return bytes of free memory
+ * @availp:   ptr to return bytes of available memory
+ * @shift:    shift results by %shift bits
+ *
+ * %mpc_reap_meminfo() returns current free and available memory
+ * sizes obtained from /proc/meminfo in userland and si_meminfo()
+ * in the kernel.  The resulting sizes are in bytes, but the
+ * caller can supply a non-zero %shift argment to obtain results
+ * in different units (e.g., for MiB shift=20, for GiB shift=30).
+ *
+ * %freep and/or %availp may be NULL.
+ */
+static void mpc_reap_meminfo(ulong *freep, ulong *availp, uint shift)
+{
+	struct sysinfo si;
+
+	si_meminfo(&si);
+
+	if (freep)
+		*freep = (si.freeram * si.mem_unit) >> shift;
+
+	if (availp)
+		*availp = (si_mem_available() * si.mem_unit) >> shift;
+}
+
+static void mpc_reap_evict_vma(struct mpc_xvm *xvm)
+{
+	struct address_space *mapping = xvm->xvm_mapping;
+	struct mpc_reap *reap = xvm->xvm_reap;
+	pgoff_t off, bktsz, len;
+	u64 ttl, xtime, now;
+	int i;
+
+	bktsz = xvm->xvm_bktsz >> PAGE_SHIFT;
+	off = mpc_xvm_pgoff(xvm);
+
+	ttl = atomic_read(&reap->reap_ttl_cur) * 1000ul;
+	now = local_clock();
+
+	for (i = 0; i < xvm->xvm_mbinfoc; ++i, off += bktsz) {
+		struct mpc_mbinfo *mbinfo = xvm->xvm_mbinfov + i;
+
+		xtime = now - (ttl * mbinfo->mbmult);
+		len = mbinfo->mblen >> PAGE_SHIFT;
+
+		if (atomic64_read(&mbinfo->mbatime) > xtime)
+			continue;
+
+		atomic64_set(&mbinfo->mbatime, U64_MAX);
+
+		invalidate_inode_pages2_range(mapping, off, off + len);
+
+		if (atomic64_read(&xvm->xvm_nrpages) < 32)
+			break;
+
+		if (need_resched())
+			cond_resched();
+
+		ttl = atomic_read(&reap->reap_ttl_cur) * 1000ul;
+		now = local_clock();
+	}
+}
+
+/**
+ * mpc_reap_evict() - Evict "cold" pages from the given XVMs
+ * @process:    A list of one of more XVMs to be reaped
+ */
+static void mpc_reap_evict(struct list_head *process)
+{
+	struct mpc_xvm *xvm, *next;
+
+	list_for_each_entry_safe(xvm, next, process, xvm_list) {
+		if (atomic_read(&xvm->xvm_reap->reap_lwm))
+			mpc_reap_evict_vma(xvm);
+
+		atomic_cmpxchg(&xvm->xvm_evicting, 1, 0);
+	}
+}
+
+/**
+ * mpc_reap_scan() - Scan for pages to purge
+ * @elem:
+ * @idx:    reap list index
+ */
+static void mpc_reap_scan(struct mpc_reap_elem *elem)
+{
+	struct list_head *list, process;
+	struct mpc_xvm *xvm, *next;
+	u64 nrpages, n;
+
+	INIT_LIST_HEAD(&process);
+
+	mutex_lock(&elem->reap_lock);
+	list = &elem->reap_list;
+	n = 0;
+
+	list_for_each_entry_safe(xvm, next, list, xvm_list) {
+		nrpages = atomic64_read(&xvm->xvm_nrpages);
+
+		if (nrpages < 32)
+			continue;
+
+		if (atomic_read(&xvm->xvm_reapref) == 1)
+			continue;
+
+		if (atomic_cmpxchg(&xvm->xvm_evicting, 0, 1))
+			continue;
+
+		list_del(&xvm->xvm_list);
+		list_add(&xvm->xvm_list, &process);
+
+		if (++n > 4)
+			break;
+	}
+	mutex_unlock(&elem->reap_lock);
+
+	mpc_reap_evict(&process);
+
+	mutex_lock(&elem->reap_lock);
+	list_splice_tail(&process, list);
+	mutex_unlock(&elem->reap_lock);
+
+	usleep_range(300, 700);
+}
+
+static void mpc_reap_run(struct work_struct *work)
+{
+	struct mpc_reap_elem *elem;
+	struct mpc_reap *reap;
+
+	elem = container_of(work, struct mpc_reap_elem, reap_work);
+	reap = elem->reap_reap;
+
+	while (atomic_read(&reap->reap_lwm))
+		mpc_reap_scan(elem);
+
+	atomic_cmpxchg(&elem->reap_running, 1, 0);
+}
+
+/**
+ * mpc_reap_tune() - Dynamic tuning of reap knobs.
+ * @reap:
+ */
+static void mpc_reap_tune(struct mpc_reap *reap)
+{
+	ulong total_pages, hpages, wpages, cpages, mfree;
+	uint freepct, hwm, lwm, ttl, debug, i;
+
+	hpages = wpages = cpages = 0;
+
+	/*
+	 * Take a live snapshot of the current memory usage.  Disable
+	 * preemption so that the result is reasonably accurate.
+	 */
+	preempt_disable();
+	mpc_reap_meminfo(&mfree, NULL, PAGE_SHIFT);
+
+	for (i = 0; i < REAP_ELEM_MAX; ++i) {
+		struct mpc_reap_elem *elem = &reap->reap_elem[i];
+
+		hpages += atomic64_read(&elem->reap_hpages);
+		wpages += atomic64_read(&elem->reap_wpages);
+		cpages += atomic64_read(&elem->reap_cpages);
+	}
+	preempt_enable();
+
+	total_pages = mfree + hpages + wpages + cpages;
+
+	/*
+	 * Determine the current percentage of free memory relative to the
+	 * number of hot+warm+cold pages tracked by the reaper.  freepct,
+	 * lwm, and hwm are scaled to 10000 for finer resolution.
+	 */
+	freepct = ((hpages + wpages + cpages) * 10000) / total_pages;
+	freepct = 10000 - freepct;
+
+	lwm = (100 - reap->reap_mempct) * 100;
+	hwm = (lwm * 10300) / 10000;
+	hwm = min_t(u32, hwm, 9700);
+	ttl = reap->reap_ttl;
+
+	if (freepct >= hwm) {
+		if (atomic_read(&reap->reap_ttl_cur) != ttl)
+			atomic_set(&reap->reap_ttl_cur, ttl);
+		if (atomic_read(&reap->reap_lwm))
+			atomic_set(&reap->reap_lwm, 0);
+	} else if (freepct < lwm || atomic_read(&reap->reap_lwm) > 0) {
+		ulong x = 10000 - (freepct * 10000) / hwm;
+
+		if (atomic_read(&reap->reap_lwm) != x) {
+			atomic_set(&reap->reap_lwm, x);
+
+			x = (ttl * (500ul * 500)) / (x * x);
+			if (x > ttl)
+				x = ttl;
+
+			atomic_set(&reap->reap_ttl_cur, x);
+		}
+	}
+
+	debug = reap->reap_debug;
+	if (!debug || (debug == 1 && freepct > hwm))
+		return;
+
+	if (atomic_inc_return(&reap->reap_emit) % REAP_ELEM_MAX > 0)
+		return;
+
+	mp_pr_info(
+		"%lu %lu, hot %lu, warm %lu, cold %lu, freepct %u, lwm %u, hwm %u, %2u, ttl %u",
+		mfree >> (20 - PAGE_SHIFT), total_pages >> (20 - PAGE_SHIFT),
+		hpages >> (20 - PAGE_SHIFT), wpages >> (20 - PAGE_SHIFT),
+		cpages >> (20 - PAGE_SHIFT), freepct, lwm, hwm,
+		atomic_read(&reap->reap_lwm), atomic_read(&reap->reap_ttl_cur) / 1000);
+}
+
+static void mpc_reap_prune(struct work_struct *work)
+{
+	struct mpc_reap_elem *elem;
+	struct mpc_xvm *xvm, *next;
+	struct mpc_reap *reap;
+	struct list_head freeme;
+	uint nfreed, eidx;
+	ulong delay;
+
+	reap = container_of(work, struct mpc_reap, reap_dwork.work);
+
+	/*
+	 * First, assesss the current memory situation.  If free
+	 * memory is below the low watermark then try to start a
+	 * reaper to evict some pages.
+	 */
+	mpc_reap_tune(reap);
+
+	if (atomic_read(&reap->reap_lwm)) {
+		eidx = atomic_read(&reap->reap_eidx) % REAP_ELEM_MAX;
+		elem = reap->reap_elem + eidx;
+
+		if (!atomic_cmpxchg(&elem->reap_running, 0, 1))
+			queue_work(reap->reap_wq, &elem->reap_work);
+	}
+
+	/* Next, advance to the next elem and prune VMAs that have been freed. */
+	eidx = atomic_inc_return(&reap->reap_eidx) % REAP_ELEM_MAX;
+
+	elem = reap->reap_elem + eidx;
+	INIT_LIST_HEAD(&freeme);
+
+	nfreed = atomic_read(&elem->reap_nfreed);
+
+	if (nfreed && mutex_trylock(&elem->reap_lock)) {
+		struct list_head   *list = &elem->reap_list;
+		uint                npruned = 0;
+
+		list_for_each_entry_safe(xvm, next, list, xvm_list) {
+			if (atomic_read(&xvm->xvm_reapref) > 1)
+				continue;
+
+			list_del(&xvm->xvm_list);
+			list_add_tail(&xvm->xvm_list, &freeme);
+
+			if (++npruned >= nfreed)
+				break;
+		}
+		mutex_unlock(&elem->reap_lock);
+
+		list_for_each_entry_safe(xvm, next, &freeme, xvm_list)
+			mpc_xvm_free(xvm);
+
+		atomic_sub(npruned, &elem->reap_nfreed);
+	}
+
+	delay = reap->reap_mempct < 100 ? 1000 / REAP_ELEM_MAX : 1000;
+	delay = msecs_to_jiffies(delay);
+
+	queue_delayed_work(reap->reap_wq, &reap->reap_dwork, delay);
+}
+
+#define REAP_MEMPCT_MIN    5
+#define REAP_MEMPCT_MAX    100
+#define REAP_TTL_MIN       100
+#define REAP_DEBUG_MAX     3
+
+static ssize_t mpc_reap_mempct_show(struct device *dev, struct device_attribute *da, char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "%d\n", dev_to_reap(dev)->reap_mempct);
+}
+
+static ssize_t mpc_reap_mempct_store(struct device *dev, struct device_attribute *da,
+				     const char *buf, size_t count)
+{
+	struct mpc_reap *reap;
+	unsigned int val;
+	int rc;
+
+	rc = kstrtouint(buf, 10, &val);
+	if (rc || (val < REAP_MEMPCT_MIN || val > REAP_MEMPCT_MAX))
+		return -EINVAL;
+
+	reap = dev_to_reap(dev);
+	reap->reap_mempct = val;
+
+	return count;
+}
+
+static ssize_t mpc_reap_debug_show(struct device *dev, struct device_attribute *da, char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "%d\n", dev_to_reap(dev)->reap_debug);
+}
+
+static ssize_t mpc_reap_debug_store(struct device *dev, struct device_attribute *da,
+				    const char *buf, size_t count)
+{
+	struct mpc_reap *reap;
+	unsigned int val;
+	int rc;
+
+	rc = kstrtouint(buf, 10, &val);
+	if (rc || val > REAP_DEBUG_MAX)
+		return -EINVAL;
+
+	reap = dev_to_reap(dev);
+	reap->reap_debug = val;
+
+	return count;
+}
+
+static ssize_t mpc_reap_ttl_show(struct device *dev, struct device_attribute *da, char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "%d\n", dev_to_reap(dev)->reap_ttl);
+}
+
+static ssize_t mpc_reap_ttl_store(struct device *dev, struct device_attribute *da,
+				  const char *buf, size_t count)
+{
+	struct mpc_reap *reap;
+	unsigned int val;
+	int rc;
+
+	rc = kstrtouint(buf, 10, &val);
+	if (rc || val < REAP_TTL_MIN)
+		return -EINVAL;
+
+	reap = dev_to_reap(dev);
+	reap->reap_ttl = val;
+
+	return count;
+}
+
+void mpc_reap_params_add(struct device_attribute *dattr)
+{
+	MPC_ATTR_RW(dattr++, reap_mempct);
+	MPC_ATTR_RW(dattr++, reap_debug);
+	MPC_ATTR_RW(dattr, reap_ttl);
+}
+
+static void mpc_reap_mempct_init(struct mpc_reap *reap)
+{
+	ulong mavail;
+	uint pct = 60;
+
+	mpc_reap_meminfo(NULL, &mavail, 30);
+
+	if (mavail > 256)
+		pct = 10;
+	else if (mavail > 128)
+		pct = 13;
+	else if (mavail > 64)
+		pct = 25;
+	else if (mavail > 32)
+		pct = 40;
+
+	reap->reap_mempct = clamp_t(unsigned int, 100 - pct, 1, 100);
+}
+
+/**
+ * mpc_reap_create() - Allocate and initialize reap data strctures
+ * @reapout: Initialized reap structure.
+ *
+ * Returns -ENOMEM if the allocation fails.
+ */
+int mpc_reap_create(struct mpc_reap **reapp)
+{
+	struct mpc_reap_elem *elem;
+	struct mpc_reap *reap;
+	uint flags, i;
+
+	flags = WQ_UNBOUND | WQ_HIGHPRI | WQ_CPU_INTENSIVE;
+	*reapp = NULL;
+
+	reap = kzalloc(roundup_pow_of_two(sizeof(*reap)), GFP_KERNEL);
+	if (!reap)
+		return -ENOMEM;
+
+	reap->reap_wq = alloc_workqueue("mpc_reap", flags, REAP_ELEM_MAX + 1);
+	if (!reap->reap_wq) {
+		kfree(reap);
+		return -ENOMEM;
+	}
+
+	atomic_set(&reap->reap_lwm, 0);
+	atomic_set(&reap->reap_ttl_cur, 0);
+	atomic_set(&reap->reap_eidx, 0);
+	atomic_set(&reap->reap_emit, 0);
+
+	for (i = 0; i < REAP_ELEM_MAX; ++i) {
+		elem = &reap->reap_elem[i];
+
+		mutex_init(&elem->reap_lock);
+		INIT_LIST_HEAD(&elem->reap_list);
+
+		INIT_WORK(&elem->reap_work, mpc_reap_run);
+		atomic_set(&elem->reap_running, 0);
+		elem->reap_reap = reap;
+
+		atomic64_set(&elem->reap_hpages, 0);
+		atomic64_set(&elem->reap_wpages, 0);
+		atomic64_set(&elem->reap_cpages, 0);
+		atomic_set(&elem->reap_nfreed, 0);
+	}
+
+	reap->reap_ttl   = 10 * 1000 * 1000;
+	reap->reap_debug = 0;
+	mpc_reap_mempct_init(reap);
+
+	INIT_DELAYED_WORK(&reap->reap_dwork, mpc_reap_prune);
+	queue_delayed_work(reap->reap_wq, &reap->reap_dwork, 1);
+
+	*reapp = reap;
+
+	return 0;
+}
+
+void mpc_reap_destroy(struct mpc_reap *reap)
+{
+	struct mpc_reap_elem *elem;
+	int i;
+
+	if (!reap)
+		return;
+
+	cancel_delayed_work_sync(&reap->reap_dwork);
+
+	/*
+	 * There shouldn't be any reapers running at this point,
+	 * but perform a flush/wait for good measure...
+	 */
+	atomic_set(&reap->reap_lwm, 0);
+
+	if (reap->reap_wq)
+		flush_workqueue(reap->reap_wq);
+
+	for (i = 0; i < REAP_ELEM_MAX; ++i) {
+		elem = &reap->reap_elem[i];
+
+		ASSERT(atomic64_read(&elem->reap_hpages) == 0);
+		ASSERT(atomic64_read(&elem->reap_wpages) == 0);
+		ASSERT(atomic64_read(&elem->reap_cpages) == 0);
+		ASSERT(atomic_read(&elem->reap_nfreed) == 0);
+		ASSERT(list_empty(&elem->reap_list));
+
+		mutex_destroy(&elem->reap_lock);
+	}
+
+	if (reap->reap_wq)
+		destroy_workqueue(reap->reap_wq);
+	kfree(reap);
+}
+
+void mpc_reap_xvm_add(struct mpc_reap *reap, struct mpc_xvm *xvm)
+{
+	struct mpc_reap_elem *elem;
+	uint idx, mult;
+
+	if (!reap || !xvm)
+		return;
+
+	if (xvm->xvm_advice == MPC_VMA_PINNED)
+		return;
+
+	mult = 1;
+	if (xvm->xvm_advice == MPC_VMA_WARM)
+		mult = 10;
+	else if (xvm->xvm_advice == MPC_VMA_HOT)
+		mult = 30;
+
+	/* Acquire a reference on xvm for the reaper... */
+	atomic_inc(&xvm->xvm_reapref);
+	xvm->xvm_reap = reap;
+
+	idx = (get_cycles() >> 1) % REAP_ELEM_MAX;
+
+	elem = &reap->reap_elem[idx];
+
+	mutex_lock(&elem->reap_lock);
+	xvm->xvm_freedp = &elem->reap_nfreed;
+
+	if (xvm->xvm_advice == MPC_VMA_HOT)
+		xvm->xvm_hcpagesp = &elem->reap_hpages;
+	else if (xvm->xvm_advice == MPC_VMA_WARM)
+		xvm->xvm_hcpagesp = &elem->reap_wpages;
+	else
+		xvm->xvm_hcpagesp = &elem->reap_cpages;
+
+	list_add_tail(&xvm->xvm_list, &elem->reap_list);
+	mutex_unlock(&elem->reap_lock);
+}
+
+void mpc_reap_xvm_evict(struct mpc_xvm *xvm)
+{
+	pgoff_t start, end, bktsz;
+
+	if (atomic_cmpxchg(&xvm->xvm_evicting, 0, 1))
+		return;
+
+	start = mpc_xvm_pgoff(xvm);
+	end = mpc_xvm_pglen(xvm) + start;
+	bktsz = xvm->xvm_bktsz >> PAGE_SHIFT;
+
+	if (bktsz < 1024)
+		bktsz = end - start;
+
+	/* Evict in chunks to improve mmap_sem interleaving... */
+	for (; start < end; start += bktsz)
+		invalidate_inode_pages2_range(xvm->xvm_mapping, start, start + bktsz);
+
+	atomic_cmpxchg(&xvm->xvm_evicting, 1, 0);
+}
+
+void mpc_reap_xvm_touch(struct mpc_xvm *xvm, int index)
+{
+	struct mpc_reap *reap;
+	atomic64_t *atimep;
+	uint mbnum, lwm;
+	pgoff_t offset;
+	ulong delay;
+	u64 now;
+
+	reap = xvm->xvm_reap;
+	if (!reap)
+		return;
+
+	offset = (index << PAGE_SHIFT) % (1ul << xvm_size_max);
+	mbnum = offset / xvm->xvm_bktsz;
+
+	atimep = &xvm->xvm_mbinfov[mbnum].mbatime;
+	now = local_clock();
+
+	/*
+	 * Don't update atime too frequently.  If we set atime to
+	 * U64_MAX in mpc_reap_evict_vma() then the addition here
+	 * will roll over and atime will be updated.
+	 */
+	if (atomic64_read(atimep) + (10 * USEC_PER_SEC) < now)
+		atomic64_set(atimep, now);
+
+	/* Sleep a bit if the reaper is having trouble meeting the free memory target. */
+	lwm = atomic_read(&reap->reap_lwm);
+	if (lwm < 3333)
+		return;
+
+	delay = 500000 / (10001 - lwm) - (500000 / 10001);
+	delay = min_t(ulong, delay, 3000);
+
+	usleep_range(delay, delay * 2);
+}
+
+bool mpc_reap_xvm_duress(struct mpc_xvm *xvm)
+{
+	struct mpc_reap *reap;
+	uint lwm;
+
+	if (xvm->xvm_advice == MPC_VMA_HOT)
+		return false;
+
+	reap = xvm->xvm_reap;
+	if (!reap)
+		return false;
+
+	lwm = atomic_read(&reap->reap_lwm);
+	if (lwm < 1500)
+		return false;
+
+	if (lwm > 3000)
+		return true;
+
+	return (xvm->xvm_advice == MPC_VMA_COLD);
+}
diff --git a/drivers/mpool/reaper.h b/drivers/mpool/reaper.h
new file mode 100644
index 000000000000..d3af6aef918d
--- /dev/null
+++ b/drivers/mpool/reaper.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+
+#ifndef MPOOL_REAPER_H
+#define MPOOL_REAPER_H
+
+#define MPC_REAP_PARAMS_CNT    3
+
+struct mpc_reap;
+struct mpc_xvm;
+
+/**
+ * mpc_reap_create() - Allocate and initialize reap data strctures
+ * @reapp: Ptr to initialized reap structure.
+ *
+ * Return: -ENOMEM if the allocaiton fails.
+ */
+int mpc_reap_create(struct mpc_reap **reapp);
+
+/**
+ * mpc_reap_destroy() - Destroy the given reaper
+ * @reap:
+ */
+void mpc_reap_destroy(struct mpc_reap *reap);
+
+/**
+ * mpc_reap_xvm_add() - Add an extended VMA to the reap list
+ * @xvm: extended VMA
+ */
+void mpc_reap_xvm_add(struct mpc_reap *reap, struct mpc_xvm *xvm);
+
+/**
+ * mpc_reap_xvm_evict() - Evict all pages of given extended VMA
+ * @xvm: extended VMA
+ */
+void mpc_reap_xvm_evict(struct mpc_xvm *xvm);
+
+/**
+ * mpc_reap_xvm_touch() - Update extended VMA mblock atime
+ * @xvm:    extended VMA
+ * @index:  valid page index within the extended VMA
+ *
+ * Update the access time stamp of the mblock given by the valid
+ * page %index within the VMA.  Might sleep for some number of
+ * microseconds if the reaper is under duress (i.e., the more
+ * urgent the duress the longer the sleep).
+ *
+ * This function is called only by mpc_vm_fault_impl(), once
+ * for each successful page fault.
+ */
+void mpc_reap_xvm_touch(struct mpc_xvm *xvm, int index);
+
+/**
+ * mpc_reap_xvm_duress() - Check to see if reaper is under duress
+ * @xvm:   extended VMA
+ *
+ * Return: %false if the VMA is marked MPC_XVM_HOT.
+ * Return: %false if reaper is not enabled nor under duress.
+ * Return: %true depending upon the urgency of duress and the
+ * VMA advice (MPC_XVM_WARM or MPC_XVM_COLD).
+ *
+ * This function is called only by mpc_readpages() to decide whether
+ * or not to reduce the size of a speculative readahead request.
+ */
+bool mpc_reap_xvm_duress(struct mpc_xvm *xvm);
+
+void mpc_reap_params_add(struct device_attribute *dattr);
+
+#endif /* MPOOL_REAPER_H */
-- 
2.17.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

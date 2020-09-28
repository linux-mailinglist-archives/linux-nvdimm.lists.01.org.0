Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1734027B245
	for <lists+linux-nvdimm@lfdr.de>; Mon, 28 Sep 2020 18:47:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 132FF152EDBF3;
	Mon, 28 Sep 2020 09:47:18 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.93.82; helo=nam10-dm6-obe.outbound.protection.outlook.com; envelope-from=nmeeramohide@micron.com; receiver=<UNKNOWN> 
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2A7C9152EDBDD
	for <linux-nvdimm@lists.01.org>; Mon, 28 Sep 2020 09:47:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGqO1wZNTIb/KiUwZXhkyx7wcz2erio9gZ0B7e5H7avMgIKua/bZNgyLfZAy0Kw2KI2lLSL/vDQKmSRVyB227kobLAv//LNjSOw/4r04WaV6BXpxzZ0nDMMrnxXDQx/sPJ9vqiPVt7vCxRDVQXFuIKTHOww1Lr4BOfGZBH51Xd7gkRwK/1yB+8J0ISvT4H6f5s4iHLZnOCijb/prbgzLslq/F5YGP0NNW1rgRQdQYMh5HBUJwJzbJ8GQhannqs10TcnO9FBTGwaNFvzkl7EwyYV5DU3LRi8wpgsLfgQnxAtULerm1qlHuEb+8kbnX7eTpG4EWAULzpyNfa1nuLpW5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIlBAETom3bLDm0FkXsU59NJb1/nq6FazhMqqkvWe/k=;
 b=ehbzqd5De2z6jpCJCRbDoNVY6yYRzqxQzthZr3fCdGPhMSoVJt+brjmN4I+QEG3wR6sZxXErug0RciCxy+E50oJ2fB239k7QYJ4oYwATlWKnWg5+2NkG9SnOC649TNux0C3A+/R3B7UTV68w6MR7O9mTp17sM7mHiL/2jLl66hEojuwYa0u5AdanK2DbP7IltlsHou/91h0j+9lCGV3YGJzrJEnoGRXIeSALHWC0gVVAadeN42tkUuuwSnFuV5S/VABGqTjHuOb2ViQHu1+th9BYdePl36eSC0IXy51FCA42TXKOBlO053TPt3Wuuqn2EJYtTvZvrWZNmtpgI/SY6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=kvack.org smtp.mailfrom=micron.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIlBAETom3bLDm0FkXsU59NJb1/nq6FazhMqqkvWe/k=;
 b=gltQyKojFEmi+i9bPh12ZBFcREU6tT1PKajLromxk2LBMrAVdkJ0sYqXg5jQxpAdSm9wlnCyHGS4Cex8WJ105ZopfxdjEHVfDB6U8xdRtpXWkg/FeK2NlezeQjt1B2dbtQcWMadsltQXAVeng1Y8y0xhjkGTdvkNTcFhjt/fOg8=
Received: from BN6PR17CA0044.namprd17.prod.outlook.com (2603:10b6:405:75::33)
 by BYAPR08MB4245.namprd08.prod.outlook.com (2603:10b6:a03::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.29; Mon, 28 Sep 2020 16:47:11 +0000
Received: from BN3NAM01FT020.eop-nam01.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::3b) by BN6PR17CA0044.outlook.office365.com
 (2603:10b6:405:75::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Mon, 28 Sep 2020 16:47:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com;
Received: from mail.micron.com (137.201.242.130) by
 BN3NAM01FT020.mail.protection.outlook.com (10.152.67.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3412.21 via Frontend Transport; Mon, 28 Sep 2020 16:47:10 +0000
Received: from micron.com (10.114.5.55) by bowex17c.micron.com
 (137.201.21.211) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 28 Sep
 2020 10:47:06 -0600
From: <nmeeramohide@micron.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-nvdimm@lists.01.org>
Subject: [PATCH 09/22] mpool: add mblock lifecycle management and IO routines
Date: Mon, 28 Sep 2020 11:45:21 -0500
Message-ID: <20200928164534.48203-10-nmeeramohide@micron.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200928164534.48203-1-nmeeramohide@micron.com>
References: <20200928164534.48203-1-nmeeramohide@micron.com>
MIME-Version: 1.0
X-ClientProxiedBy: bowex17d.micron.com (137.201.21.212) To bowex17c.micron.com
 (137.201.21.211)
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24646.005
X-TM-AS-Result: No--14.586700-0.000000-31
X-TM-AS-MatchedID: 702732-703812-705244-701073-702751-703115-704949-704585-7
	01844-704318-701656-703966-704499-704397-700335-705161-113230-701480-701809
	-703017-703140-702395-188019-703213-121336-701105-704673-703967-703027-7024
	15-701275-703815-702754-704895-702688-701964-780039-701880-105250-705018-70
	1744-703534-704002-704477-703694-700714-851458-700958-704401-700717-702779-
	702960-702874-701919-704749-701847-847575-703080-703215-704714-700286-70281
	2-702719-703286-703953-701723-825159-703357-702914-703958-705247-121270-704
	264-703816-703954-700863-704418-701698-703904-704001-702525-700698-704718-7
	03117-702558-701032-701724-148004-148036-42000-42003
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 530afe5f-7fd9-4b46-230f-08d863ce2523
X-MS-TrafficTypeDiagnostic: BYAPR08MB4245:
X-Microsoft-Antispam-PRVS: 
 <BYAPR08MB42457F50959E6E53CB4BA223B3350@BYAPR08MB4245.namprd08.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Oob-TLC-OOBClassifiers: OLM:104;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lm7Rgw3g9SobWsydA3TOC5PsPqYMm3fnIVjHf1yW4c9blH6w406EX6eryNMyrCP9wRy7bBr3WZ/ZTLv6MUuYXpzOs23RVGeFGFh3GF/ieFczcUy6ndIMS4vIPXn/cVCTyb42KBCVI2iLyuXpbGl0XDYouL4UmTUcbbuCkL5xax9lNMYJ0z83Sb36F7N2PbmnDUolTVsy7qjjjvBNCQ2A3tU7Ua5MK0guW/2gLELD/cEBS0BO9jSGU9pNhCr/h5fnXZdL+plN4l9Iu+IfW3LZB0oXphK/OwuO3hmtvlQg5FnS2kj3iQipyd4b6s4oqXtfIt0V7xvJTxt1AADbUznfIpL05cizsXAwYbIIw+Nxxty9R4+0wBpLfS5Ex7HOxRiNERr28wEoG/VZredRxUbueZEFolkL4F8/p2Gx5YQ76gsa3Ce4alTpv8z57sav3tVLDBGHTl6ia1irMYZuX9VVTondzI3JgGoCSVS13Tvc3wWX0aEFvGPa/lukxp8TWAGY
X-Forefront-Antispam-Report: 
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(46966005)(2616005)(36756003)(7696005)(26005)(6666004)(186003)(8936002)(8676002)(316002)(110136005)(426003)(2906002)(54906003)(336012)(55016002)(2876002)(5660300002)(107886003)(82310400003)(86362001)(6286002)(70206006)(70586007)(1076003)(82740400003)(7636003)(478600001)(356005)(47076004)(83380400001)(4326008)(30864003)(33310700002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 16:47:10.8798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 530afe5f-7fd9-4b46-230f-08d863ce2523
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3NAM01FT020.eop-nam01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4245
Message-ID-Hash: E5YX4CIEFTIJENL4YRTGRKKGKP4DOGQ3
X-Message-ID-Hash: E5YX4CIEFTIJENL4YRTGRKKGKP4DOGQ3
X-MailFrom: nmeeramohide@micron.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: smoyer@micron.com, gbecker@micron.com, plabat@micron.com, jgroves@micron.com, Nabeel M Mohamed <nmeeramohide@micron.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/E5YX4CIEFTIJENL4YRTGRKKGKP4DOGQ3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Nabeel M Mohamed <nmeeramohide@micron.com>

Implements the mblock lifecycle management functions: allocate,
commit, abort, read, write, destroy etc.

Mblocks are containers comprising a linear sequence of bytes that
can be written exactly once, are immutable after writing, and can
be read in whole or in part as needed until deleted.

Mpool currently supports only fixed size mblocks whose size is the
same as the zone size and is established at mpool create.

Mblock API uses the metadata manager interface to reserve storage
space at allocation time, store metadata for the mblock in its
associated MDC-K when committing it, record end-of-life for the
mblock in its associated MDC-K when deleting it and read/write
mblock data.

Co-developed-by: Greg Becker <gbecker@micron.com>
Signed-off-by: Greg Becker <gbecker@micron.com>
Co-developed-by: Pierre Labat <plabat@micron.com>
Signed-off-by: Pierre Labat <plabat@micron.com>
Co-developed-by: John Groves <jgroves@micron.com>
Signed-off-by: John Groves <jgroves@micron.com>
Signed-off-by: Nabeel M Mohamed <nmeeramohide@micron.com>
---
 drivers/mpool/mblock.c | 432 +++++++++++++++++++++++++++++++++++++++++
 drivers/mpool/mblock.h | 161 +++++++++++++++
 2 files changed, 593 insertions(+)
 create mode 100644 drivers/mpool/mblock.c
 create mode 100644 drivers/mpool/mblock.h

diff --git a/drivers/mpool/mblock.c b/drivers/mpool/mblock.c
new file mode 100644
index 000000000000..10c47ec74ff6
--- /dev/null
+++ b/drivers/mpool/mblock.c
@@ -0,0 +1,432 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+
+/*
+ * DOC: Module info.
+ *
+ * Mblock module.
+ *
+ * Defines functions for writing, reading, and managing the lifecycle
+ * of mblocks.
+ *
+ */
+
+#include <linux/vmalloc.h>
+#include <linux/blk_types.h>
+#include <linux/mm.h>
+
+#include "mpool_printk.h"
+#include "assert.h"
+
+#include "pd.h"
+#include "pmd_obj.h"
+#include "mpcore.h"
+#include "mblock.h"
+
+/**
+ * mblock2layout() - convert opaque mblock handle to pmd_layout
+ *
+ * This function converts the opaque handle (mblock_descriptor) used by
+ * clients to the internal representation (pmd_layout).  The
+ * conversion is a simple cast, followed by a sanity check to verify the
+ * layout object is an mblock object.  If the validation fails, a NULL
+ * pointer is returned.
+ */
+static struct pmd_layout *mblock2layout(struct mblock_descriptor *mbh)
+{
+	struct pmd_layout *layout = (void *)mbh;
+
+	if (!layout)
+		return NULL;
+
+	ASSERT(layout->eld_objid > 0);
+	ASSERT(kref_read(&layout->eld_ref) >= 2);
+
+	return mblock_objid(layout->eld_objid) ? layout : NULL;
+}
+
+static u32 mblock_optimal_iosz_get(struct mpool_descriptor *mp, struct pmd_layout *layout)
+{
+	struct mpool_dev_info *pd = pmd_layout_pd_get(mp, layout);
+
+	return pd->pdi_optiosz;
+}
+
+/**
+ * layout2mblock() - convert pmd_layout to opaque mblock_descriptor
+ *
+ * This function converts the internally used pmd_layout to
+ * the externally used opaque mblock_descriptor.
+ */
+static struct mblock_descriptor *layout2mblock(struct pmd_layout *layout)
+{
+	return (struct mblock_descriptor *)layout;
+}
+
+static void mblock_getprops_cmn(struct mpool_descriptor *mp, struct pmd_layout *layout,
+				struct mblock_props *prop)
+{
+	struct mpool_dev_info *pd;
+
+	pd = pmd_layout_pd_get(mp, layout);
+
+	prop->mpr_objid = layout->eld_objid;
+	prop->mpr_alloc_cap = pmd_layout_cap_get(mp, layout);
+	prop->mpr_write_len = layout->eld_mblen;
+	prop->mpr_optimal_wrsz = mblock_optimal_iosz_get(mp, layout);
+	prop->mpr_mclassp = pd->pdi_mclass;
+	prop->mpr_iscommitted = layout->eld_state & PMD_LYT_COMMITTED;
+}
+
+static int mblock_alloc_cmn(struct mpool_descriptor *mp, u64 objid,
+			    enum mp_media_classp mclassp, bool spare,
+			    struct mblock_props *prop, struct mblock_descriptor **mbh)
+{
+	struct pmd_obj_capacity ocap = { .moc_spare = spare };
+	struct pmd_layout *layout = NULL;
+	int rc;
+
+	if (!mp)
+		return -EINVAL;
+
+	*mbh = NULL;
+
+	if (!objid) {
+		rc = pmd_obj_alloc(mp, OMF_OBJ_MBLOCK, &ocap, mclassp, &layout);
+		if (rc)
+			return rc;
+	} else {
+		rc = pmd_obj_realloc(mp, objid, &ocap, mclassp, &layout);
+		if (rc) {
+			if (rc != -ENOENT)
+				mp_pr_err("mpool %s, re-allocating mblock 0x%lx failed",
+					  rc, mp->pds_name, (ulong)objid);
+			return rc;
+		}
+	}
+
+	if (!layout)
+		return -ENOTRECOVERABLE;
+
+	if (prop) {
+		pmd_obj_rdlock(layout);
+		mblock_getprops_cmn(mp, layout, prop);
+		pmd_obj_rdunlock(layout);
+	}
+
+	*mbh = layout2mblock(layout);
+
+	return 0;
+}
+
+int mblock_alloc(struct mpool_descriptor *mp, enum mp_media_classp mclassp, bool spare,
+		 struct mblock_descriptor **mbh, struct mblock_props *prop)
+{
+	return mblock_alloc_cmn(mp, 0, mclassp, spare, prop, mbh);
+}
+
+int mblock_find_get(struct mpool_descriptor *mp, u64 objid, int which,
+		    struct mblock_props *prop, struct mblock_descriptor **mbh)
+{
+	struct pmd_layout *layout;
+
+	*mbh = NULL;
+
+	if (!mblock_objid(objid))
+		return -EINVAL;
+
+	layout = pmd_obj_find_get(mp, objid, which);
+	if (!layout)
+		return -ENOENT;
+
+	if (prop) {
+		pmd_obj_rdlock(layout);
+		mblock_getprops_cmn(mp, layout, prop);
+		pmd_obj_rdunlock(layout);
+	}
+
+	*mbh = layout2mblock(layout);
+
+	return 0;
+}
+
+void mblock_put(struct mblock_descriptor *mbh)
+{
+	struct pmd_layout *layout;
+
+	layout = mblock2layout(mbh);
+	if (layout)
+		pmd_obj_put(layout);
+}
+
+/*
+ * Helper function to log a message that many functions need to log:
+ */
+#define mp_pr_layout_not_found(_mp, _mbh)				\
+do {									\
+	static unsigned long state;					\
+	uint dly = msecs_to_jiffies(1000);				\
+									\
+	if (printk_timed_ratelimit(&state, dly)) {			\
+		mp_pr_warn("mpool %s, layout not found: mbh %p",	\
+			   (_mp)->pds_name, (_mbh));			\
+		dump_stack();						\
+	}								\
+} while (0)
+
+int mblock_commit(struct mpool_descriptor *mp, struct mblock_descriptor *mbh)
+{
+	struct mpool_dev_info *pd;
+	struct pmd_layout *layout;
+	int rc;
+
+	layout = mblock2layout(mbh);
+	if (!layout) {
+		mp_pr_layout_not_found(mp, mbh);
+		return -EINVAL;
+	}
+
+	pd = pmd_layout_pd_get(mp, layout);
+	if (!pd->pdi_fua) {
+		rc = pd_dev_flush(&pd->pdi_parm);
+		if (rc)
+			return rc;
+	}
+
+	/* Commit will fail with EBUSY if aborting flag set. */
+	rc = pmd_obj_commit(mp, layout);
+	if (rc) {
+		mp_pr_rl("mpool %s, committing mblock 0x%lx failed",
+			 rc, mp->pds_name, (ulong)layout->eld_objid);
+		return rc;
+	}
+
+	return 0;
+}
+
+int mblock_abort(struct mpool_descriptor *mp, struct mblock_descriptor *mbh)
+{
+	struct pmd_layout *layout;
+	int rc;
+
+	layout = mblock2layout(mbh);
+	if (!layout) {
+		mp_pr_layout_not_found(mp, mbh);
+		return -EINVAL;
+	}
+
+	rc = pmd_obj_abort(mp, layout);
+	if (rc) {
+		mp_pr_err("mpool %s, aborting mblock 0x%lx failed",
+			  rc, mp->pds_name, (ulong)layout->eld_objid);
+		return rc;
+	}
+
+	return 0;
+}
+
+int mblock_delete(struct mpool_descriptor *mp, struct mblock_descriptor *mbh)
+{
+	struct pmd_layout *layout;
+
+	layout = mblock2layout(mbh);
+	if (!layout) {
+		mp_pr_layout_not_found(mp, mbh);
+		return -EINVAL;
+	}
+
+	return pmd_obj_delete(mp, layout);
+}
+
+/**
+ * mblock_rw_argcheck() - Validate mblock_write() and mblock_read().
+ * @mp:      Mpool descriptor
+ * @layout:  Layout of the mblock
+ * @iov:     iovec array
+ * @iovcnt:  iovec count
+ * @boff:    Byte offset into the layout.  Must be equal to layout->eld_mblen for write
+ * @rw:      MPOOL_OP_READ or MPOOL_OP_WRITE
+ * @len:     number of bytes in iov list
+ *
+ * Returns: 0 if successful, -errno otherwise
+ *
+ * Note: be aware that there are checks in this function that prevent illegal
+ * arguments in lower level functions (lower level functions should assert the
+ * requirements but not otherwise check them)
+ */
+static int mblock_rw_argcheck(struct mpool_descriptor *mp, struct pmd_layout *layout,
+			      loff_t boff, int rw, size_t len)
+{
+	u64 opt_iosz;
+	u32 mblock_cap;
+	int rc;
+
+	mblock_cap = pmd_layout_cap_get(mp, layout);
+	opt_iosz = mblock_optimal_iosz_get(mp, layout);
+
+	if (rw == MPOOL_OP_READ) {
+		/* boff must be a multiple of the OS page size */
+		if (!PAGE_ALIGNED(boff)) {
+			rc = -EINVAL;
+			mp_pr_err("mpool %s, read offset 0x%lx is not multiple of OS page size",
+				  rc, mp->pds_name, (ulong) boff);
+			return rc;
+		}
+
+		/* Check that boff is not past end of mblock capacity. */
+		if (mblock_cap <= boff) {
+			rc = -EINVAL;
+			mp_pr_err("mpool %s, read offset 0x%lx >= mblock capacity 0x%x",
+				  rc, mp->pds_name, (ulong)boff, mblock_cap);
+			return rc;
+		}
+
+		/*
+		 * Check that the request does not extend past the data
+		 * written.  Don't record an error if this appears to
+		 * be an mcache readahead request.
+		 *
+		 * TODO: Use (len != MCACHE_RA_PAGES_MAX)
+		 */
+		if (boff + len > layout->eld_mblen)
+			return -EINVAL;
+	} else {
+		/* Write boff required to match eld_mblen */
+		if (boff != layout->eld_mblen) {
+			rc = -EINVAL;
+			mp_pr_err("mpool %s write boff (%ld) != eld_mblen (%d)",
+				  rc, mp->pds_name, (ulong)boff, layout->eld_mblen);
+			return rc;
+		}
+
+		/* Writes must be optimal iosz aligned */
+		if (boff % opt_iosz) {
+			rc = -EINVAL;
+			mp_pr_err("mpool %s, write not optimal iosz aligned, offset 0x%lx",
+				  rc, mp->pds_name, (ulong)boff);
+			return rc;
+		}
+
+		/* Check for write past end of allocated space (!) */
+		if ((len + boff) > mblock_cap) {
+			rc = -EINVAL;
+			mp_pr_err("(write): len %lu + boff %lu > mblock_cap %lu",
+				  rc, (ulong)len, (ulong)boff, (ulong)mblock_cap);
+			return rc;
+		}
+	}
+
+	return 0;
+}
+
+int mblock_write(struct mpool_descriptor *mp, struct mblock_descriptor *mbh,
+		 const struct kvec *iov, int iovcnt, size_t len)
+{
+	struct pmd_layout *layout;
+	loff_t boff;
+	u8 state;
+	int rc;
+
+	layout = mblock2layout(mbh);
+	if (!layout) {
+		mp_pr_layout_not_found(mp, mbh);
+		return -EINVAL;
+	}
+
+	rc = mblock_rw_argcheck(mp, layout, layout->eld_mblen, MPOOL_OP_WRITE, len);
+	if (rc) {
+		mp_pr_debug("mblock write argcheck failed ", rc);
+		return rc;
+	}
+
+	if (len == 0)
+		return 0;
+
+	boff = layout->eld_mblen;
+
+	ASSERT(PAGE_ALIGNED(len));
+	ASSERT(PAGE_ALIGNED(boff));
+	ASSERT(iovcnt == (len >> PAGE_SHIFT));
+
+	pmd_obj_wrlock(layout);
+	state = layout->eld_state;
+	if (!(state & PMD_LYT_COMMITTED)) {
+		struct mpool_dev_info *pd = pmd_layout_pd_get(mp, layout);
+		int flags = 0;
+
+		if (pd->pdi_fua)
+			flags = REQ_FUA;
+
+		rc = pmd_layout_rw(mp, layout, iov, iovcnt, boff, flags, MPOOL_OP_WRITE);
+		if (!rc)
+			layout->eld_mblen += len;
+	}
+	pmd_obj_wrunlock(layout);
+
+	return !(state & PMD_LYT_COMMITTED) ? rc : -EALREADY;
+}
+
+int mblock_read(struct mpool_descriptor *mp, struct mblock_descriptor *mbh,
+		const struct kvec *iov, int iovcnt, loff_t boff, size_t len)
+{
+	struct pmd_layout *layout;
+	u8 state;
+	int rc;
+
+	layout = mblock2layout(mbh);
+	if (!layout) {
+		mp_pr_layout_not_found(mp, mbh);
+		return -EINVAL;
+	}
+
+	rc = mblock_rw_argcheck(mp, layout, boff, MPOOL_OP_READ, len);
+	if (rc) {
+		mp_pr_debug("mblock read argcheck failed ", rc);
+		return rc;
+	}
+
+	if (len == 0)
+		return 0;
+
+	ASSERT(PAGE_ALIGNED(len));
+	ASSERT(PAGE_ALIGNED(boff));
+	ASSERT(iovcnt == (len >> PAGE_SHIFT));
+
+	/*
+	 * Read lock the mblock layout; mblock reads can proceed concurrently;
+	 * Mblock writes are serialized but concurrent with reads
+	 */
+	pmd_obj_rdlock(layout);
+	state = layout->eld_state;
+	if (state & PMD_LYT_COMMITTED)
+		rc = pmd_layout_rw(mp, layout, iov, iovcnt, boff, 0, MPOOL_OP_READ);
+	pmd_obj_rdunlock(layout);
+
+	return (state & PMD_LYT_COMMITTED) ? rc : -EAGAIN;
+}
+
+int mblock_get_props_ex(struct mpool_descriptor *mp, struct mblock_descriptor *mbh,
+			struct mblock_props_ex *prop)
+{
+	struct pmd_layout *layout;
+
+	layout = mblock2layout(mbh);
+	if (!layout) {
+		mp_pr_layout_not_found(mp, mbh);
+		return -EINVAL;
+	}
+
+	pmd_obj_rdlock(layout);
+	prop->mbx_zonecnt = layout->eld_ld.ol_zcnt;
+	mblock_getprops_cmn(mp, layout, &prop->mbx_props);
+	pmd_obj_rdunlock(layout);
+
+	return 0;
+}
+
+bool mblock_objid(u64 objid)
+{
+	return objid && (pmd_objid_type(objid) == OMF_OBJ_MBLOCK);
+}
diff --git a/drivers/mpool/mblock.h b/drivers/mpool/mblock.h
new file mode 100644
index 000000000000..2a5435875a92
--- /dev/null
+++ b/drivers/mpool/mblock.h
@@ -0,0 +1,161 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+
+/*
+ * DOC: Module info.
+ *
+ * Defines functions for writing, reading, and managing the lifecycle of mlogs.
+ *
+ */
+
+#ifndef MPOOL_MBLOCK_H
+#define MPOOL_MBLOCK_H
+
+#include <linux/uio.h>
+
+#include "mpool_ioctl.h"
+/*
+ * Opaque handles for clients
+ */
+struct mpool_descriptor;
+struct mblock_descriptor;
+struct mpool_obj_layout;
+
+/*
+ * mblock API functions
+ */
+
+/**
+ * mblock_alloc() - Allocate an mblock.
+ * @mp:         mpool descriptor
+ * @capreq:     mblock capacity requested
+ * @mclassp:    media class
+ * @mbh:        mblock handle returned
+ * @prop:       mblock properties returned
+ *
+ * Allocate mblock with erasure code and capacity params as specified in
+ * ecparm and capreq on drives in a media class mclassp;
+ * if successful mbh is a handle for the mblock and prop contains its
+ * properties.
+ * Note: mblock is not persistent until committed; allocation can be aborted.
+ *
+ * Return: %0 if successful, -errno otherwise...
+ */
+int mblock_alloc(struct mpool_descriptor *mp, enum mp_media_classp mclassp, bool spare,
+		 struct mblock_descriptor **mbh, struct mblock_props *prop);
+
+/**
+ * mblock_find_get() - Get handle and properties for existing mblock with specified objid.
+ * @mp:
+ * @objid:
+ * @which:
+ * @prop:
+ * @mbh:
+ *
+ * If successful, the caller holds a ref on the mblock (which must be put eventually).
+ *
+ * Return: %0 if successful, -errno otherwise...
+ */
+int mblock_find_get(struct mpool_descriptor *mp, u64 objid, int which,
+		    struct mblock_props *prop, struct mblock_descriptor **mbh);
+
+/**
+ * mblock_put() - Put (release) a ref on an mblock
+ * @mbh:
+ *
+ * Put a ref on a known mblock.
+ *
+ * Return: %0 if successful, -errno otherwise...
+ */
+void mblock_put(struct mblock_descriptor *mbh);
+
+/**
+ * mblock_commit() - Make allocated mblock persistent
+ * @mp:
+ * @mbh:
+ *
+ * if fails mblock still exists in an
+ * uncommitted state so can retry commit or abort except as noted.
+ *
+ * Return: %0 if successful, -errno otherwise...
+ * EBUSY if must abort
+ */
+int mblock_commit(struct mpool_descriptor *mp, struct mblock_descriptor *mbh);
+
+/**
+ * mblock_abort() - Discard uncommitted mblock
+ * @mp:
+ * @mbh:
+ *
+ * If successful mbh is invalid after call.
+ *
+ * Return: %0 if successful, -errno otherwise...
+ *
+ */
+int mblock_abort(struct mpool_descriptor *mp, struct mblock_descriptor *mbh);
+
+/**
+ * mblock_delete() - Delete committed mblock
+ * @mp:
+ * @mbh:
+ *
+ * If successful mbh is invalid after call.
+ *
+ * Return: %0 if successful, -errno otherwise...
+ */
+int mblock_delete(struct mpool_descriptor *mp, struct mblock_descriptor *mbh);
+
+/**
+ * mblock_write() - Write iov to mblock
+ * @mp:
+ * @mbh:
+ * @iov:
+ * @iovcnt:
+ * @len:
+ *
+ * Mblocks can be written until they are committed, or
+ * until they are full.  If a caller needs to issue more than one write call
+ * to the same mblock, all but the last write call must be optimal write size aligned.
+ * The mpr_optimal_wrsz field in struct mblock_props gives the optimal write size.
+ *
+ * Return: %0 if success, -errno otherwise...
+ */
+int mblock_write(struct mpool_descriptor *mp, struct mblock_descriptor *mbh,
+		 const struct kvec *iov, int iovcnt, size_t len);
+
+/**
+ * mblock_read() - Read data from mblock mbnum in committed mblock into iov
+ * @mp:
+ * @mbh:
+ * @iov:
+ * @iovcnt:
+ * @boff:
+ * @len:
+ *
+ * Read data from mblock mbnum in committed mblock into iov starting at
+ * byte offset boff; boff and iov buffers must be a multiple of OS page
+ * size for the mblock.
+ *
+ * If fails can call mblock_get_props() to confirm mblock was written.
+ *
+ * Return: 0 if successful, -errno otherwise...
+ */
+int mblock_read(struct mpool_descriptor *mp, struct mblock_descriptor *mbh,
+		const struct kvec *iov, int iovcnt, loff_t boff, size_t len);
+
+/**
+ * mblock_get_props_ex() - Return extended mblock properties in prop
+ * @mp:
+ * @mbh:
+ * @prop:
+ *
+ * Return: %0 if successful, -errno otherwise...
+ */
+int mblock_get_props_ex(struct mpool_descriptor *mp, struct mblock_descriptor *mbh,
+			struct mblock_props_ex *prop);
+
+bool mblock_objid(u64 objid);
+
+#endif /* MPOOL_MBLOCK_H */
-- 
2.17.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

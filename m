Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1454128BDA5
	for <lists+linux-nvdimm@lfdr.de>; Mon, 12 Oct 2020 18:28:28 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9F34115B7DE8E;
	Mon, 12 Oct 2020 09:28:18 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.244.87; helo=nam12-mw2-obe.outbound.protection.outlook.com; envelope-from=nmeeramohide@micron.com; receiver=<UNKNOWN> 
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8A7AB15B409E8
	for <linux-nvdimm@lists.01.org>; Mon, 12 Oct 2020 09:28:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pyz1iUG/BHUFQpcGDAZtq1ag006I5YrZjOxt1tLtDBFTsmtmqCYlAdpTyvIgzD8gtjXg03c1qaRaih71KGxQHuQg+IH2BRkbStNJwNYOa/yiSPZbg5O/wKrg82FBdXl2DMXlCsD1lMsse1Ly3Q3JRBO3j/RWTsn3qbTRQnFP5uceYjhuz1Mx1onLaGDZhMvBnGY96y75ZK8ThPI+nq1g9d7nR5nppxiEF7BIMGyDkEqtpfJu0aXLeSF3w4BenFe3a3fZxdPQeGsYLqXyFHGoTXWNReSuPQP0oeUNu9IKUvCsOYytlWxnrunKCCxly/rbrIwl2eyTo9U8EYL4AQY3/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiGyXLZKeQVbPPSZ3p/9RzptcSmdVSRHKOxhvqvTIcM=;
 b=kyQvxonvuKzM6FzttzpUmK//r+SIFDeqCCI9/7/gsMmW18IhHUDipf4z0V7QgwDf/GeWGixUxaeAW2nkv9O4UKXAGwesbPNAPxTcdWVo60Ab9BAlusNaeEigw/6qEK9y+17lN2/WR7YduUx3Gri51/lm0Tj+KLqNQ/Gf0wf+ZdIxdLlgq2AZxuXtc3/6XPmOCcOgjRIpGc9lsM7ge4Vbakm/dwienbi00ifdHNn2fVkYgfAoYN1Dpqv52G7N8IHlWWgS7fU6kUpqd1OwIcNI4vjECqJ3jRF2qXTXR2CEH6b0IOPsSSsytrV9aoMH/xiQMAD/bwqFAmvcMvOiN3EMfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=kvack.org smtp.mailfrom=micron.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiGyXLZKeQVbPPSZ3p/9RzptcSmdVSRHKOxhvqvTIcM=;
 b=Ey/Q2pYDF5kv5uUvzQlRjJnGRT3OI88ab6xjT5eAkFgFo0yplCIS5uQ1bbVOpFdgdddlSniMwn3cF5Tp0tvnHESqXgFQ9Fiy7vnB/XqEb7hI6sN72gt9ir9zMaV2cY7i0tTeVYQW0O+KSMNhoslfr3vrAgaBN0pH9pNRwaKttUs=
Received: from SN4PR0201CA0055.namprd02.prod.outlook.com
 (2603:10b6:803:20::17) by MN2PR08MB5840.namprd08.prod.outlook.com
 (2603:10b6:208:11e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Mon, 12 Oct
 2020 16:28:11 +0000
Received: from SN1NAM01FT015.eop-nam01.prod.protection.outlook.com
 (2603:10b6:803:20:cafe::51) by SN4PR0201CA0055.outlook.office365.com
 (2603:10b6:803:20::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22 via Frontend
 Transport; Mon, 12 Oct 2020 16:28:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com;
Received: from mail.micron.com (137.201.242.130) by
 SN1NAM01FT015.mail.protection.outlook.com (10.152.65.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3455.23 via Frontend Transport; Mon, 12 Oct 2020 16:28:10 +0000
Received: from micron.com (10.114.5.55) by bowex17c.micron.com
 (137.201.21.211) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Oct
 2020 10:28:04 -0600
From: Nabeel M Mohamed <nmeeramohide@micron.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-nvdimm@lists.01.org>
Subject: [PATCH v2 12/22] mpool: add metadata container or mlog-pair framework
Date: Mon, 12 Oct 2020 11:27:26 -0500
Message-ID: <20201012162736.65241-13-nmeeramohide@micron.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20201012162736.65241-1-nmeeramohide@micron.com>
References: <20201012162736.65241-1-nmeeramohide@micron.com>
MIME-Version: 1.0
X-ClientProxiedBy: bowex17a.micron.com (137.201.21.209) To bowex17c.micron.com
 (137.201.21.211)
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24646.005
X-TM-AS-Result: No--10.571200-0.000000-31
X-TM-AS-MatchedID: 701073-704502-702345-701246-703361-705153-700737-704959-7
	03851-704949-704381-701847-700010-703853-702889-701480-701809-703017-703140
	-702395-188019-703213-121336-701105-704673-703967-702754-704521-847575-7000
	50-703812-704477-702433-702837-704328-700053-703904-851458-704318-703694-70
	1586-701750-702617-703275-843010-703173-702779-105250-700069-700073-137717-
	121665-702914-704579-703215-703080-704002-705244-704606-702888-148004-14803
	6-42000-42003-190014
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b61e329e-bbbf-466c-ec8a-08d86ecbcf31
X-MS-TrafficTypeDiagnostic: MN2PR08MB5840:
X-Microsoft-Antispam-PRVS: 
 <MN2PR08MB5840B8CCBF1348829E46DBE5B3070@MN2PR08MB5840.namprd08.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Oob-TLC-OOBClassifiers: OLM:172;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Z6IIM/d02DwtYos3ITPyf+fVqzlvxx6t76DqgeeUj5D7yXaXcmotiD91fi5dcObmNBpxWvQKJUbPq8fetjxPdVaUHoBmbrQmplQEPRwtPumtImapb0OC2dv/uqGF17wkkhqveRaJsIii0yCpc4TvbpCcWVm1gvtCvWDMe3k3olEtUbQroILZ/aOEEjQ2Hhf9xYOzo5Ql9qwJBwKG1BxWIMSAuGez+l1ASCCxReC7iHHFXf9EWSEygybhfZ7gd0BXhXQ35Oz4IjRUWTi28JC5bowayqetJZRZ4HFFWXrssRfzKFjm436hCa9HZgtzcX9mz5pXgaXGqMMiiNWJQvc7+x2YguO7SMmOzZAyz+PWkqaVN+baKRhWBIYaFN6px5KmV1zic4niKFDPppy3XBCGkGyiibeffFbaeuCUWIsgQ8Rr1+tSzDc/UoLhOG5/eg7G
X-Forefront-Antispam-Report: 
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(46966005)(4326008)(7696005)(82310400003)(36756003)(33310700002)(70586007)(70206006)(356005)(186003)(8676002)(47076004)(107886003)(83380400001)(8936002)(6286002)(82740400003)(26005)(7636003)(1076003)(86362001)(426003)(110136005)(5660300002)(2616005)(6666004)(2906002)(55016002)(478600001)(30864003)(336012)(54906003)(316002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 16:28:10.4748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b61e329e-bbbf-466c-ec8a-08d86ecbcf31
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM01FT015.eop-nam01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB5840
Message-ID-Hash: BW2XB3HJBU642HHBWGFVACJ2PWDCER7P
X-Message-ID-Hash: BW2XB3HJBU642HHBWGFVACJ2PWDCER7P
X-MailFrom: nmeeramohide@micron.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: smoyer@micron.com, gbecker@micron.com, plabat@micron.com, jgroves@micron.com, Nabeel M Mohamed <nmeeramohide@micron.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BW2XB3HJBU642HHBWGFVACJ2PWDCER7P/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Metadata containers are used for storing and maintaining metadata.

MDC APIs are implemented as helper functions built on a pair of
mlogs per MDC. It embodies the concept of compaction to deal with
one of the mlog pairs filling, what it means to compact is
use-case dependent.

The MDC APIs make it easy for a client to:

- Append metadata update records to the active mlog of an MDC
  until it is full (or exceeds some client-specific threshold)
- Flag the start of a compaction which marks the other mlog of
  the MDC as active
- Re-serialize its metadata by appending it to the (newly)
  active mlog of the MDC
- Flag the end of the compaction
- Continue appending metadata update records to the MDC until
  the above process repeats

The MDC API functions handle all failures, including crash
recovery, by using special markers recognized by the mlog
implementation.

Co-developed-by: Greg Becker <gbecker@micron.com>
Signed-off-by: Greg Becker <gbecker@micron.com>
Co-developed-by: Pierre Labat <plabat@micron.com>
Signed-off-by: Pierre Labat <plabat@micron.com>
Co-developed-by: John Groves <jgroves@micron.com>
Signed-off-by: John Groves <jgroves@micron.com>
Signed-off-by: Nabeel M Mohamed <nmeeramohide@micron.com>
---
 drivers/mpool/mdc.c | 486 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/mpool/mdc.h | 106 ++++++++++
 2 files changed, 592 insertions(+)
 create mode 100644 drivers/mpool/mdc.c
 create mode 100644 drivers/mpool/mdc.h

diff --git a/drivers/mpool/mdc.c b/drivers/mpool/mdc.c
new file mode 100644
index 000000000000..288e6ee4670b
--- /dev/null
+++ b/drivers/mpool/mdc.c
@@ -0,0 +1,486 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "mpool_printk.h"
+#include "mpool_ioctl.h"
+#include "mpcore.h"
+#include "mp.h"
+#include "mlog.h"
+#include "mdc.h"
+
+#define mdc_logerr(_mpname, _msg, _mlh, _objid, _gen1, _gen2, _err)     \
+	mp_pr_err("mpool %s, mdc open, %s "			        \
+		  "mlog %p objid 0x%lx gen1 %lu gen2 %lu",		\
+		  (_err), (_mpname), (_msg),		                \
+		  (_mlh), (ulong)(_objid), (ulong)(_gen1),		\
+		  (ulong)(_gen2))					\
+
+#define OP_COMMIT      0
+#define OP_DELETE      1
+
+/**
+ * mdc_acquire() - Validate mdc handle and acquire mdc_lock
+ * @mlh: MDC handle
+ * @rw:  read/append?
+ */
+static inline int mdc_acquire(struct mp_mdc *mdc, bool rw)
+{
+	if (!mdc || mdc->mdc_magic != MPC_MDC_MAGIC || !mdc->mdc_valid)
+		return -EINVAL;
+
+	if (rw && (mdc->mdc_flags & MDC_OF_SKIP_SER))
+		return 0;
+
+	mutex_lock(&mdc->mdc_lock);
+
+	/* Validate again after acquiring lock */
+	if (!mdc->mdc_valid) {
+		mutex_unlock(&mdc->mdc_lock);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * mdc_release() - Release mdc_lock
+ * @mlh: MDC handle
+ * @rw:  read/append?
+ */
+static inline void mdc_release(struct mp_mdc *mdc, bool rw)
+{
+	if (rw && (mdc->mdc_flags & MDC_OF_SKIP_SER))
+		return;
+
+	mutex_unlock(&mdc->mdc_lock);
+}
+
+/**
+ * mdc_invalidate() - Invalidates MDC handle by resetting the magic
+ * @mdc: MDC handle
+ */
+static inline void mdc_invalidate(struct mp_mdc *mdc)
+{
+	mdc->mdc_magic = MPC_NO_MAGIC;
+}
+
+/**
+ * mdc_get_mpname() - Get mpool name from mpool descriptor
+ * @mp:     mpool descriptor
+ * @mpname: buffer to store the mpool name (output)
+ * @mplen:  buffer len
+ */
+static int mdc_get_mpname(struct mpool_descriptor *mp, char *mpname, size_t mplen)
+{
+	if (!mp || !mpname)
+		return -EINVAL;
+
+	return mpool_get_mpname(mp, mpname, mplen);
+}
+
+/**
+ * mdc_find_get() - Wrapper around get for mlog pair.
+ */
+static void mdc_find_get(struct mpool_descriptor *mp, u64 *logid, bool do_put,
+			 struct mlog_props *props, struct mlog_descriptor **mlh, int *ferr)
+{
+	int i;
+
+	for (i = 0; i < 2; ++i)
+		ferr[i] = mlog_find_get(mp, logid[i], 0, &props[i], &mlh[i]);
+
+	if (do_put && ((ferr[0] && !ferr[1]) || (ferr[1] && !ferr[0]))) {
+		if (ferr[0])
+			mlog_put(mlh[1]);
+		else
+			mlog_put(mlh[0]);
+	}
+}
+
+/**
+ * mdc_put() - Wrapper around put for mlog pair.
+ */
+static void mdc_put(struct mlog_descriptor *mlh1, struct mlog_descriptor *mlh2)
+{
+	mlog_put(mlh1);
+	mlog_put(mlh2);
+}
+
+int mp_mdc_open(struct mpool_descriptor *mp, u64 logid1, u64 logid2, u8 flags,
+		struct mp_mdc **mdc_out)
+{
+	struct mlog_descriptor *mlh[2];
+	struct mlog_props *props = NULL;
+	struct mp_mdc *mdc;
+
+	int     err = 0, err1 = 0, err2 = 0;
+	int     ferr[2] = {0};
+	u64     gen1 = 0, gen2 = 0;
+	bool    empty = false;
+	u8      mlflags = 0;
+	u64     id[2];
+	char   *mpname;
+
+	if (!mp || !mdc_out)
+		return -EINVAL;
+
+	mdc = kzalloc(sizeof(*mdc), GFP_KERNEL);
+	if (!mdc)
+		return -ENOMEM;
+
+	mdc->mdc_valid = 0;
+	mdc->mdc_mp    = mp;
+	mdc_get_mpname(mp, mdc->mdc_mpname, sizeof(mdc->mdc_mpname));
+
+	mpname = mdc->mdc_mpname;
+
+	if (logid1 == logid2) {
+		err = -EINVAL;
+		goto exit;
+	}
+
+	props = kcalloc(2, sizeof(*props), GFP_KERNEL);
+	if (!props) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	/*
+	 * This mdc_find_get can go away once mp_mdc_open is modified to
+	 * operate on handles.
+	 */
+	id[0] = logid1;
+	id[1] = logid2;
+	mdc_find_get(mp, id, true, props, mlh, ferr);
+	if (ferr[0] || ferr[1]) {
+		err = ferr[0] ? : ferr[1];
+		goto exit;
+	}
+	mdc->mdc_logh1 = mlh[0];
+	mdc->mdc_logh2 = mlh[1];
+
+	if (flags & MDC_OF_SKIP_SER)
+		mlflags |= MLOG_OF_SKIP_SER;
+
+	mlflags |= MLOG_OF_COMPACT_SEM;
+
+	err1 = mlog_open(mp, mdc->mdc_logh1, mlflags, &gen1);
+	err2 = mlog_open(mp, mdc->mdc_logh2, mlflags, &gen2);
+
+	if (err1 && err1 != -EMSGSIZE && err1 != -EBUSY) {
+		err = err1;
+	} else if (err2 && err2 != -EMSGSIZE && err2 != -EBUSY) {
+		err = err2;
+	} else if ((err1 && err2) || (!err1 && !err2 && gen1 && gen1 == gen2)) {
+
+		err = -EINVAL;
+
+		/* Bad pair; both have failed erases/compactions or equal non-0 gens. */
+		mp_pr_err("mpool %s, mdc open, bad mlog handle, mlog1 %p logid1 0x%lx errno %d gen1 %lu, mlog2 %p logid2 0x%lx errno %d gen2 %lu",
+			err, mpname, mdc->mdc_logh1, (ulong)logid1, err1, (ulong)gen1,
+			mdc->mdc_logh2, (ulong)logid2, err2, (ulong)gen2);
+	} else {
+		/* Active log is valid log with smallest gen */
+		if (err1 || (!err2 && gen2 < gen1)) {
+			mdc->mdc_alogh = mdc->mdc_logh2;
+			if (!err1) {
+				err = mlog_empty(mp, mdc->mdc_logh1, &empty);
+				if (err)
+					mdc_logerr(mpname, "mlog1 empty check failed",
+						   mdc->mdc_logh1, logid1, gen1, gen2, err);
+			}
+			if (!err && (err1 || !empty)) {
+				err = mlog_erase(mp, mdc->mdc_logh1, gen2 + 1);
+				if (!err) {
+					err = mlog_open(mp, mdc->mdc_logh1, mlflags, &gen1);
+					if (err)
+						mdc_logerr(mpname, "mlog1 open failed",
+							   mdc->mdc_logh1, logid1, gen1, gen2, err);
+				} else {
+					mdc_logerr(mpname, "mlog1 erase failed", mdc->mdc_logh1,
+						   logid1, gen1, gen2, err);
+				}
+			}
+		} else {
+			mdc->mdc_alogh = mdc->mdc_logh1;
+			if (!err2) {
+				err = mlog_empty(mp, mdc->mdc_logh2, &empty);
+				if (err)
+					mdc_logerr(mpname, "mlog2 empty check failed",
+						   mdc->mdc_logh2, logid2, gen1, gen2, err);
+			}
+			if (!err && (err2 || gen2 == gen1 || !empty)) {
+				err = mlog_erase(mp, mdc->mdc_logh2, gen1 + 1);
+				if (!err) {
+					err = mlog_open(mp, mdc->mdc_logh2, mlflags, &gen2);
+					if (err)
+						mdc_logerr(mpname, "mlog2 open failed",
+							   mdc->mdc_logh2, logid2, gen1, gen2, err);
+				} else {
+					mdc_logerr(mpname, "mlog2 erase failed", mdc->mdc_logh2,
+						   logid2, gen1, gen2, err);
+				}
+			}
+		}
+
+		if (!err) {
+			err = mlog_empty(mp, mdc->mdc_alogh, &empty);
+			if (!err && empty) {
+				/*
+				 * First use of log pair so need to add
+				 * cstart/cend recs; above handles case of
+				 * failure between adding cstart and cend
+				 */
+				err = mlog_append_cstart(mp, mdc->mdc_alogh);
+				if (!err) {
+					err = mlog_append_cend(mp, mdc->mdc_alogh);
+					if (err)
+						mdc_logerr(mpname,
+							   "adding cend to active mlog failed",
+							   mdc->mdc_alogh,
+							   mdc->mdc_alogh == mdc->mdc_logh1 ?
+							   logid1 : logid2, gen1, gen2, err);
+				} else {
+					mdc_logerr(mpname, "adding cstart to active mlog failed",
+						   mdc->mdc_alogh,
+						   mdc->mdc_alogh == mdc->mdc_logh1 ?
+						   logid1 : logid2, gen1, gen2, err);
+				}
+
+			} else if (err) {
+				mdc_logerr(mpname, "active mlog empty check failed",
+					   mdc->mdc_alogh, mdc->mdc_alogh == mdc->mdc_logh1 ?
+					   logid1 : logid2, gen1, gen2, err);
+			}
+		}
+	}
+
+	if (!err) {
+		/*
+		 * Inform pre-compaction of the size of the active
+		 * mlog and how much is used. This is applicable
+		 * only for mpool core's internal MDCs.
+		 */
+		mlog_precompact_alsz(mp, mdc->mdc_alogh);
+
+		mdc->mdc_valid = 1;
+		mdc->mdc_magic = MPC_MDC_MAGIC;
+		mdc->mdc_flags = flags;
+		mutex_init(&mdc->mdc_lock);
+
+		*mdc_out = mdc;
+	} else {
+		err1 = mlog_close(mp, mdc->mdc_logh1);
+		err2 = mlog_close(mp, mdc->mdc_logh2);
+
+		mdc_put(mdc->mdc_logh1, mdc->mdc_logh2);
+	}
+
+exit:
+	if (err)
+		kfree(mdc);
+
+	kfree(props);
+
+	return err;
+}
+
+int mp_mdc_cstart(struct mp_mdc *mdc)
+{
+	struct mlog_descriptor *tgth = NULL;
+	struct mpool_descriptor *mp;
+	bool rw = false;
+	int rc;
+
+	if (!mdc)
+		return -EINVAL;
+
+	rc = mdc_acquire(mdc, rw);
+	if (rc)
+		return rc;
+
+	mp = mdc->mdc_mp;
+
+	if (mdc->mdc_alogh == mdc->mdc_logh1)
+		tgth = mdc->mdc_logh2;
+	else
+		tgth = mdc->mdc_logh1;
+
+	rc = mlog_append_cstart(mp, tgth);
+	if (rc) {
+		mdc_release(mdc, rw);
+
+		mp_pr_err("mpool %s, mdc %p cstart failed, mlog %p",
+			  rc, mdc->mdc_mpname, mdc, tgth);
+
+		(void)mp_mdc_close(mdc);
+
+		return rc;
+	}
+
+	mdc->mdc_alogh = tgth;
+	mdc_release(mdc, rw);
+
+	return 0;
+}
+
+int mp_mdc_cend(struct mp_mdc *mdc)
+{
+	struct mlog_descriptor *srch = NULL;
+	struct mlog_descriptor *tgth = NULL;
+	struct mpool_descriptor *mp;
+	u64 gentgt = 0;
+	bool rw = false;
+	int rc;
+
+	if (!mdc)
+		return -EINVAL;
+
+	rc = mdc_acquire(mdc, rw);
+	if (rc)
+		return rc;
+
+	mp = mdc->mdc_mp;
+
+	if (mdc->mdc_alogh == mdc->mdc_logh1) {
+		tgth = mdc->mdc_logh1;
+		srch = mdc->mdc_logh2;
+	} else {
+		tgth = mdc->mdc_logh2;
+		srch = mdc->mdc_logh1;
+	}
+
+	rc = mlog_append_cend(mp, tgth);
+	if (!rc) {
+		rc = mlog_gen(tgth, &gentgt);
+		if (!rc)
+			rc = mlog_erase(mp, srch, gentgt + 1);
+	}
+
+	if (rc) {
+		mdc_release(mdc, rw);
+
+		mp_pr_err("mpool %s, mdc %p cend failed, mlog %p",
+			  rc, mdc->mdc_mpname, mdc, tgth);
+
+		mp_mdc_close(mdc);
+
+		return rc;
+	}
+
+	mdc_release(mdc, rw);
+
+	return rc;
+}
+
+int mp_mdc_close(struct mp_mdc *mdc)
+{
+	struct mpool_descriptor *mp;
+	int rval = 0, rc;
+	bool rw = false;
+
+	if (!mdc)
+		return -EINVAL;
+
+	rc = mdc_acquire(mdc, rw);
+	if (rc)
+		return rc;
+
+	mp = mdc->mdc_mp;
+
+	mdc->mdc_valid = 0;
+
+	rc = mlog_close(mp, mdc->mdc_logh1);
+	if (rc) {
+		mp_pr_err("mpool %s, mdc %p close failed, mlog1 %p",
+			  rc, mdc->mdc_mpname, mdc, mdc->mdc_logh1);
+		rval = rc;
+	}
+
+	rc = mlog_close(mp, mdc->mdc_logh2);
+	if (rc) {
+		mp_pr_err("mpool %s, mdc %p close failed, mlog2 %p",
+			  rc, mdc->mdc_mpname, mdc, mdc->mdc_logh2);
+		rval = rc;
+	}
+
+	mdc_put(mdc->mdc_logh1, mdc->mdc_logh2);
+
+	mdc_invalidate(mdc);
+	mdc_release(mdc, false);
+
+	kfree(mdc);
+
+	return rval;
+}
+
+int mp_mdc_rewind(struct mp_mdc *mdc)
+{
+	bool rw = false;
+	int rc;
+
+	if (!mdc)
+		return -EINVAL;
+
+	rc = mdc_acquire(mdc, rw);
+	if (rc)
+		return rc;
+
+	rc = mlog_read_data_init(mdc->mdc_alogh);
+	if (rc)
+		mp_pr_err("mpool %s, mdc %p rewind failed, mlog %p",
+			  rc, mdc->mdc_mpname, mdc, mdc->mdc_alogh);
+
+	mdc_release(mdc, rw);
+
+	return rc;
+}
+
+int mp_mdc_read(struct mp_mdc *mdc, void *data, size_t len, size_t *rdlen)
+{
+	bool rw = true;
+	int rc;
+
+	if (!mdc || !data)
+		return -EINVAL;
+
+	rc = mdc_acquire(mdc, rw);
+	if (rc)
+		return rc;
+
+	rc = mlog_read_data_next(mdc->mdc_mp, mdc->mdc_alogh, data, (u64)len, (u64 *)rdlen);
+	if (rc && rc != -EOVERFLOW)
+		mp_pr_err("mpool %s, mdc %p read failed, mlog %p len %lu",
+			  rc, mdc->mdc_mpname, mdc, mdc->mdc_alogh, (ulong)len);
+
+	mdc_release(mdc, rw);
+
+	return rc;
+}
+
+int mp_mdc_append(struct mp_mdc *mdc, void *data, ssize_t len, bool sync)
+{
+	bool rw = true;
+	int rc;
+
+	if (!mdc || !data)
+		return -EINVAL;
+
+	rc = mdc_acquire(mdc, rw);
+	if (rc)
+		return rc;
+
+	rc = mlog_append_data(mdc->mdc_mp, mdc->mdc_alogh, data, (u64)len, sync);
+	if (rc)
+		mp_pr_rl("mpool %s, mdc %p append failed, mlog %p, len %lu sync %d",
+			 rc, mdc->mdc_mpname, mdc, mdc->mdc_alogh, (ulong)len, sync);
+
+	mdc_release(mdc, rw);
+
+	return rc;
+}
diff --git a/drivers/mpool/mdc.h b/drivers/mpool/mdc.h
new file mode 100644
index 000000000000..7ab1de261eff
--- /dev/null
+++ b/drivers/mpool/mdc.h
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+
+#ifndef MPOOL_MDC_PRIV_H
+#define MPOOL_MDC_PRIV_H
+
+#include <linux/mutex.h>
+
+#define MPC_MDC_MAGIC           0xFEEDFEED
+#define MPC_NO_MAGIC            0xFADEFADE
+
+struct mpool_descriptor;
+struct mlog_descriptor;
+
+/**
+ * struct mp_mdc - MDC handle
+ * @mdc_mp:     mpool handle
+ * @mdc_logh1:  mlog 1 handle
+ * @mdc_logh2:  mlog 2 handle
+ * @mdc_alogh:  active mlog handle
+ * @mdc_lock:   mdc mutex
+ * @mdc_mpname: mpool name
+ * @mdc_valid:  is the handle valid?
+ * @mdc_magic:  MDC handle magic
+ * @mdc_flags:	MDC flags
+ */
+struct mp_mdc {
+	struct mpool_descriptor    *mdc_mp;
+	struct mlog_descriptor     *mdc_logh1;
+	struct mlog_descriptor     *mdc_logh2;
+	struct mlog_descriptor     *mdc_alogh;
+	struct mutex                mdc_lock;
+	char                        mdc_mpname[MPOOL_NAMESZ_MAX];
+	int                         mdc_valid;
+	int                         mdc_magic;
+	u8                          mdc_flags;
+};
+
+/* MDC (Metadata Container) APIs */
+
+/**
+ * mp_mdc_open() - Open MDC by OIDs
+ * @mp:       mpool handle
+ * @logid1:   Mlog ID 1
+ * @logid2:   Mlog ID 2
+ * @flags:    MDC Open flags (enum mdc_open_flags)
+ * @mdc_out:  MDC handle
+ */
+int
+mp_mdc_open(struct mpool_descriptor *mp, u64 logid1, u64 logid2, u8 flags, struct mp_mdc **mdc_out);
+
+/**
+ * mp_mdc_close() - Close MDC
+ * @mdc:      MDC handle
+ */
+int mp_mdc_close(struct mp_mdc *mdc);
+
+/**
+ * mp_mdc_rewind() - Rewind MDC to first record
+ * @mdc:      MDC handle
+ */
+int mp_mdc_rewind(struct mp_mdc *mdc);
+
+/**
+ * mp_mdc_read() - Read next record from MDC
+ * @mdc:      MDC handle
+ * @data:     buffer to receive data
+ * @len:      length of supplied buffer
+ * @rdlen:    number of bytes read
+ *
+ * Return:
+ *   If the return value is -EOVERFLOW, then the receive buffer "data"
+ *   is too small and must be resized according to the value returned
+ *   in "rdlen".
+ */
+int mp_mdc_read(struct mp_mdc *mdc, void *data, size_t len, size_t *rdlen);
+
+/**
+ * mp_mdc_append() - append record to MDC
+ * @mdc:      MDC handle
+ * @data:     data to write
+ * @len:      length of data
+ * @sync:     flag to defer return until IO is complete
+ */
+int mp_mdc_append(struct mp_mdc *mdc, void *data, ssize_t len, bool sync);
+
+/**
+ * mp_mdc_cstart() - Initiate MDC compaction
+ * @mdc:      MDC handle
+ *
+ * Swap active (ostensibly full) and inactive (empty) mlogs
+ * Append a compaction start marker to newly active mlog
+ */
+int mp_mdc_cstart(struct mp_mdc *mdc);
+
+/**
+ * mp_mdc_cend() - End MDC compactions
+ * @mdc:      MDC handle
+ *
+ * Append a compaction end marker to the active mlog
+ */
+int mp_mdc_cend(struct mp_mdc *mdc);
+
+#endif /* MPOOL_MDC_PRIV_H */
-- 
2.17.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

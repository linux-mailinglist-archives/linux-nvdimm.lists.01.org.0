Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB4B27B251
	for <lists+linux-nvdimm@lfdr.de>; Mon, 28 Sep 2020 18:47:35 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9D138153A89F0;
	Mon, 28 Sep 2020 09:47:25 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.93.84; helo=nam10-dm6-obe.outbound.protection.outlook.com; envelope-from=nmeeramohide@micron.com; receiver=<UNKNOWN> 
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 79DE2153A89E0
	for <linux-nvdimm@lists.01.org>; Mon, 28 Sep 2020 09:47:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtCC92ARPPfcpqR1dzlFGByVOWHkxuoNXnsnWIoeyNzM2znlf5NwOaW5sEMJMIpNxw3a8HrsodjdoBI0In+KnAf3fyiY6gYHW2RzpUShNvhFGd2bhs/JaHW61dolw5fLzYSNaXEhDgk2Gt2xU9QYaN16O0Lxw+elhhKy6RQkz/Urx6oKBCedmKhvVQ/9YlcBgdZz9qqUnuYrsDSWZbp8Aod8/Yk/5Jg/50D1UQl+NWNJ5FODKaEOPit8n8YBNPnriUC+P7sGo63oJM9nMI3qTcL+qS2C0+WEVXIAlMpYWeEFlnTByksykp2mfWGbSTHDiQCYifeAaAT3ZovknKYrfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAKKfvORnGotFJyve2DtMFNoiL/gMzGI2rxg0no78qA=;
 b=IdO6fjgZowQtsC4XvtO3G20pZTV33hkgE+DbOZFcJttWA6rzfarIirG/Bs+5lBMgvaTJkiqSlG0k7MpSXfHsuFMGzk+sWx4EjFdrrYkseBD92Ja7fwpQrxcYUqHRSpZs2xs6v1uY93vaofvp2ID7jjpuEjFCJaQX+Q3zFggl4kCoGwk0sjXfsyED0+nyySp1sEt+BJOsFHWJ1zGK1mdJOWVr4MUwQQu5qct14XUF9ITelhDM2rQ9et0SjShcu+mk/MnjrrHraKQy1UxxlmVHkiD67HPbp5u2931xm8VkdtG2yiaCg4TYoMAZsnyC5YdO/WBPuouIkaPDliAqX9P9+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=kvack.org smtp.mailfrom=micron.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAKKfvORnGotFJyve2DtMFNoiL/gMzGI2rxg0no78qA=;
 b=dLVvuACUraQ6N73CVZJgsg/SG6Tavt6LtuNXOtNPw5mon2Nomc27y9Yt1Q9UeIj2KJImYd9nN6QP2+Gtb8vl4p1w8xfKq7imvwLc+C60/CtehjVZDOTynBE19mKTBecWGFinVZMTW2XvqxS9TDI4aSbrIGWCWQdnriinGgpMDHA=
Received: from BN6PR17CA0049.namprd17.prod.outlook.com (2603:10b6:405:75::38)
 by BY5PR08MB6311.namprd08.prod.outlook.com (2603:10b6:a03:1e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Mon, 28 Sep
 2020 16:47:16 +0000
Received: from BN3NAM01FT020.eop-nam01.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::db) by BN6PR17CA0049.outlook.office365.com
 (2603:10b6:405:75::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21 via Frontend
 Transport; Mon, 28 Sep 2020 16:47:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com;
Received: from mail.micron.com (137.201.242.130) by
 BN3NAM01FT020.mail.protection.outlook.com (10.152.67.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3412.21 via Frontend Transport; Mon, 28 Sep 2020 16:47:16 +0000
Received: from micron.com (10.114.5.55) by bowex17c.micron.com
 (137.201.21.211) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 28 Sep
 2020 10:47:12 -0600
From: <nmeeramohide@micron.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-nvdimm@lists.01.org>
Subject: [PATCH 16/22] mpool: add mpool control plane utility routines
Date: Mon, 28 Sep 2020 11:45:28 -0500
Message-ID: <20200928164534.48203-17-nmeeramohide@micron.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200928164534.48203-1-nmeeramohide@micron.com>
References: <20200928164534.48203-1-nmeeramohide@micron.com>
MIME-Version: 1.0
X-ClientProxiedBy: bowex17d.micron.com (137.201.21.212) To bowex17c.micron.com
 (137.201.21.211)
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24646.005
X-TM-AS-Result: No--14.691100-0.000000-31
X-TM-AS-MatchedID: 700076-703504-702422-704714-704926-701342-701478-703215-7
	03967-704983-704929-701330-703027-701480-701809-703017-702395-188019-703812
	-702914-704318-121224-702299-704477-300015-703140-703213-121336-701105-7046
	73-702754-702617-702433-705022-703173-702298-105700-702876-703285-700863-12
	1367-139504-703279-701270-704978-703904-703534-701919-704949-703932-700064-
	702877-701510-703865-704239-117072-701750-700050-702853-106420-704960-70400
	2-701964-703405-703160-700716-700714-700512-703532-703080-704061-701628-701
	963-703357-702415-702490-704718-700069-703878-703347-701443-704397-704127-1
	88199-702102-148004-148036-42000-42003
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 506a84fc-6d57-4582-9d6e-08d863ce283b
X-MS-TrafficTypeDiagnostic: BY5PR08MB6311:
X-Microsoft-Antispam-PRVS: 
 <BY5PR08MB6311A752554229FD06F3F284B3350@BY5PR08MB6311.namprd08.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Oob-TLC-OOBClassifiers: OLM:348;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HrycJmhehAkd3nEUNdHXtAxAIXWTbND7G/hGAUYYFDcCbv3BaPCPDZyGxAYqTQgrUpV+JGhSWrF6IDTVovMF5hNHGn0rxAg3rQvW2G059NrPJFIziXOZ7uuGuKOp9pKPZOAvJWs+NDJws4Fv51tic1k9W1eE6eHh8V8Z8MG60M+pO2vg81dbCqvyA3y7wMP/cEu5E2hvpZFMVhRR51dlGMNrRJuwsOdUFSDnuibKyZpRtTXKQI2VIaJVNHkgGICnYyvfc2f1hLxlPmtROBINZHzDPuc2sUM9c9evKLjeexHbutyBCcGbF0ZTiLcJMjn0eP69MmMUjGgjxjeAzO+OB2wt3Fuecoay2YCHPNia7Rap0DOiaLhzOo74pLW6zvpzwZB6ixlAjyVkfHNhWaAi6a87XzV6yA0HZXcTnNeEYll5m9AmS4B1iCXEdo26GJ55h2JMSO72/TmJ52cqM6IYR8Ky3HAWO47yYH4/Us2QS61VIvODf2R5er7eHLltXgiF
X-Forefront-Antispam-Report: 
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(46966005)(8676002)(478600001)(1076003)(54906003)(316002)(110136005)(6286002)(83380400001)(86362001)(356005)(33310700002)(7636003)(70586007)(70206006)(82310400003)(82740400003)(7696005)(36756003)(2616005)(6666004)(2876002)(4326008)(5660300002)(8936002)(2906002)(426003)(107886003)(26005)(186003)(55016002)(30864003)(336012)(47076004)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 16:47:16.0644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 506a84fc-6d57-4582-9d6e-08d863ce283b
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3NAM01FT020.eop-nam01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR08MB6311
Message-ID-Hash: J6OYDOUNG6MDCTDTXFUW7WSKGZUVSR4P
X-Message-ID-Hash: J6OYDOUNG6MDCTDTXFUW7WSKGZUVSR4P
X-MailFrom: nmeeramohide@micron.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: smoyer@micron.com, gbecker@micron.com, plabat@micron.com, jgroves@micron.com, Nabeel M Mohamed <nmeeramohide@micron.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/J6OYDOUNG6MDCTDTXFUW7WSKGZUVSR4P/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Nabeel M Mohamed <nmeeramohide@micron.com>

This adds the mpool control plane infrastructure to manage
mpools.

There is a unit object instance for each device object
created by the mpool driver. A minor number is reserved
for each unit object.

The mpool control device (/dev/mpoolctl) gets a minor
number of 0. An mpool device (/dev/mpool/<mpool_name>)
gets a minor number > 0. Utility routines exist to lookup
an mpool unit given its minor number or name.

All units are born with a reference count of two -
one for the caller and a birth reference that can be released
only by either destroying the unit or unloading the module.

Co-developed-by: Greg Becker <gbecker@micron.com>
Signed-off-by: Greg Becker <gbecker@micron.com>
Co-developed-by: Pierre Labat <plabat@micron.com>
Signed-off-by: Pierre Labat <plabat@micron.com>
Co-developed-by: John Groves <jgroves@micron.com>
Signed-off-by: John Groves <jgroves@micron.com>
Signed-off-by: Nabeel M Mohamed <nmeeramohide@micron.com>
---
 drivers/mpool/init.c  |  20 ++
 drivers/mpool/init.h  |   3 +
 drivers/mpool/mpctl.c | 466 ++++++++++++++++++++++++++++++++++++++++++
 drivers/mpool/mpctl.h |  50 +++++
 drivers/mpool/sysfs.c |  48 +++++
 drivers/mpool/sysfs.h |  48 +++++
 6 files changed, 635 insertions(+)
 create mode 100644 drivers/mpool/mpctl.c
 create mode 100644 drivers/mpool/mpctl.h
 create mode 100644 drivers/mpool/sysfs.c
 create mode 100644 drivers/mpool/sysfs.h

diff --git a/drivers/mpool/init.c b/drivers/mpool/init.c
index eb1217f63746..126c6c7142b5 100644
--- a/drivers/mpool/init.c
+++ b/drivers/mpool/init.c
@@ -12,10 +12,23 @@
 #include "smap.h"
 #include "pmd_obj.h"
 #include "sb.h"
+#include "mpctl.h"
 
 /*
  * Module params...
  */
+unsigned int maxunits __read_mostly = 1024;
+module_param(maxunits, uint, 0444);
+MODULE_PARM_DESC(maxunits, " max mpools");
+
+unsigned int rwsz_max_mb __read_mostly = 32;
+module_param(rwsz_max_mb, uint, 0444);
+MODULE_PARM_DESC(rwsz_max_mb, " max mblock/mlog r/w size (mB)");
+
+unsigned int rwconc_max __read_mostly = 8;
+module_param(rwconc_max, uint, 0444);
+MODULE_PARM_DESC(rwconc_max, " max mblock/mlog large r/w concurrency");
+
 unsigned int rsvd_bios_max __read_mostly = 16;
 module_param(rsvd_bios_max, uint, 0444);
 MODULE_PARM_DESC(rsvd_bios_max, "max reserved bios in mpool bioset");
@@ -26,6 +39,7 @@ MODULE_PARM_DESC(chunk_size_kb, "Chunk size (in KiB) for device I/O");
 
 static void mpool_exit_impl(void)
 {
+	mpctl_exit();
 	pmd_exit();
 	smap_exit();
 	sb_exit();
@@ -68,6 +82,12 @@ static __init int mpool_init(void)
 		goto errout;
 	}
 
+	rc = mpctl_init();
+	if (rc) {
+		errmsg = "mpctl init failed";
+		goto errout;
+	}
+
 errout:
 	if (rc) {
 		mp_pr_err("%s", rc, errmsg);
diff --git a/drivers/mpool/init.h b/drivers/mpool/init.h
index e02a9672e727..3d8f809a5e45 100644
--- a/drivers/mpool/init.h
+++ b/drivers/mpool/init.h
@@ -6,6 +6,9 @@
 #ifndef MPOOL_INIT_H
 #define MPOOL_INIT_H
 
+extern unsigned int maxunits;
+extern unsigned int rwsz_max_mb;
+extern unsigned int rwconc_max;
 extern unsigned int rsvd_bios_max;
 extern int chunk_size_kb;
 
diff --git a/drivers/mpool/mpctl.c b/drivers/mpool/mpctl.c
new file mode 100644
index 000000000000..4f3600840ff0
--- /dev/null
+++ b/drivers/mpool/mpctl.c
@@ -0,0 +1,466 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/cdev.h>
+#include <linux/log2.h>
+#include <linux/idr.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/blkdev.h>
+#include <linux/vmalloc.h>
+#include <linux/memcontrol.h>
+#include <linux/pagemap.h>
+#include <linux/kobject.h>
+#include <linux/mm_inline.h>
+#include <linux/version.h>
+#include <linux/kref.h>
+
+#include <linux/backing-dev.h>
+#include <linux/spinlock.h>
+#include <linux/list.h>
+#include <linux/rbtree.h>
+#include <linux/migrate.h>
+#include <linux/delay.h>
+#include <linux/ctype.h>
+#include <linux/uio.h>
+#include <linux/prefetch.h>
+
+#include "mpool_printk.h"
+#include "assert.h"
+
+#include "mpool_ioctl.h"
+#include "mlog.h"
+#include "mp.h"
+#include "mpctl.h"
+#include "sysfs.h"
+#include "init.h"
+
+
+#define NODEV               MKDEV(0, 0)    /* Non-existent device */
+
+/* mpc pseudo-driver instance data (i.e., all globals live here). */
+struct mpc_softstate {
+	struct mutex        ss_lock;        /* Protects ss_unitmap */
+	struct idr          ss_unitmap;     /* minor-to-unit map */
+
+	____cacheline_aligned
+	struct semaphore    ss_op_sema;     /* Serialize mgmt. ops */
+	dev_t               ss_devno;       /* Control device devno */
+	struct cdev         ss_cdev;
+	struct class       *ss_class;
+	bool                ss_inited;
+};
+
+/* Unit-type specific information. */
+struct mpc_uinfo {
+	const char     *ui_typename;
+	const char     *ui_subdirfmt;
+};
+
+/* One mpc_mpool object per mpool. */
+struct mpc_mpool {
+	struct kref                 mp_ref;
+	struct rw_semaphore         mp_lock;
+	struct mpool_descriptor    *mp_desc;
+	struct mp_mdc              *mp_mdc;
+	uint                        mp_dpathc;
+	char                      **mp_dpathv;
+	char                        mp_name[];
+};
+
+/* The following structures are initialized at the end of this file. */
+static const struct file_operations mpc_fops_default;
+
+static struct mpc_softstate mpc_softstate;
+
+static unsigned int mpc_ctl_uid __read_mostly;
+static unsigned int mpc_ctl_gid __read_mostly = 6;
+static unsigned int mpc_ctl_mode __read_mostly = 0664;
+
+static const struct mpc_uinfo mpc_uinfo_ctl = {
+	.ui_typename = "mpoolctl",
+	.ui_subdirfmt = "%s",
+};
+
+static const struct mpc_uinfo mpc_uinfo_mpool = {
+	.ui_typename = "mpool",
+	.ui_subdirfmt = "mpool/%s",
+};
+
+static inline bool mpc_unit_isctldev(const struct mpc_unit *unit)
+{
+	return (unit->un_uinfo == &mpc_uinfo_ctl);
+}
+
+static inline bool mpc_unit_ismpooldev(const struct mpc_unit *unit)
+{
+	return (unit->un_uinfo == &mpc_uinfo_mpool);
+}
+
+static inline uid_t mpc_current_uid(void)
+{
+	return from_kuid(current_user_ns(), current_uid());
+}
+
+static inline gid_t mpc_current_gid(void)
+{
+	return from_kgid(current_user_ns(), current_gid());
+}
+
+/**
+ * mpc_mpool_release() - release kref handler for mpc_mpool object
+ * @refp:  kref pointer
+ */
+static void mpc_mpool_release(struct kref *refp)
+{
+	struct mpc_mpool *mpool = container_of(refp, struct mpc_mpool, mp_ref);
+	int rc;
+
+	if (mpool->mp_desc) {
+		rc = mpool_deactivate(mpool->mp_desc);
+		if (rc)
+			mp_pr_err("mpool %s deactivate failed", rc, mpool->mp_name);
+	}
+
+	kfree(mpool->mp_dpathv);
+	kfree(mpool);
+
+	module_put(THIS_MODULE);
+}
+
+static void mpc_mpool_put(struct mpc_mpool *mpool)
+{
+	kref_put(&mpool->mp_ref, mpc_mpool_release);
+}
+
+/**
+ * mpc_unit_create() - Create and install a unit object
+ * @path:         device path under "/dev/" to create
+ * @mpool:        mpool ptr
+ * @unitp:        unit ptr
+ *
+ * Create a unit object and install a NULL ptr for it in the units map,
+ * thereby reserving a minor number.  The unit cannot be found by any
+ * of the lookup routines until the NULL ptr is replaced by the actual
+ * ptr to the unit.
+ *
+ * A unit maps an mpool device (.e.g., /dev/mpool/foo)  to an mpool object
+ * created by mpool_create().
+ *
+ * All units are born with two references, one for the caller and one that
+ * can only be released by destroying the unit or unloading the module.
+ *
+ * Return:  Returns 0 if successful and sets *unitp.
+ *          Returns -errno on error.
+ */
+static int mpc_unit_create(const char *name, struct mpc_mpool *mpool, struct mpc_unit **unitp)
+{
+	struct mpc_softstate *ss = &mpc_softstate;
+	struct mpc_unit *unit;
+	size_t unitsz;
+	int minor;
+
+	if (!ss || !name || !unitp)
+		return -EINVAL;
+
+	unitsz = sizeof(*unit) + strlen(name) + 1;
+
+	unit = kzalloc(unitsz, GFP_KERNEL);
+	if (!unit)
+		return -ENOMEM;
+
+	strcpy(unit->un_name, name);
+
+	sema_init(&unit->un_open_lock, 1);
+	unit->un_open_excl = false;
+	unit->un_open_cnt = 0;
+	unit->un_devno = NODEV;
+	kref_init(&unit->un_ref);
+	unit->un_mpool = mpool;
+
+	mutex_lock(&ss->ss_lock);
+	minor = idr_alloc(&ss->ss_unitmap, NULL, 0, -1, GFP_KERNEL);
+	mutex_unlock(&ss->ss_lock);
+
+	if (minor < 0) {
+		kfree(unit);
+		return minor;
+	}
+
+	kref_get(&unit->un_ref); /* acquire additional ref for the caller */
+
+	unit->un_devno = MKDEV(MAJOR(ss->ss_cdev.dev), minor);
+	*unitp = unit;
+
+	return 0;
+}
+
+/**
+ * mpc_unit_release() - Destroy a unit object created by mpc_unit_create().
+ * @unit:
+ */
+static void mpc_unit_release(struct kref *refp)
+{
+	struct mpc_unit *unit = container_of(refp, struct mpc_unit, un_ref);
+	struct mpc_softstate *ss = &mpc_softstate;
+
+	mutex_lock(&ss->ss_lock);
+	idr_remove(&ss->ss_unitmap, MINOR(unit->un_devno));
+	mutex_unlock(&ss->ss_lock);
+
+	if (unit->un_mpool)
+		mpc_mpool_put(unit->un_mpool);
+
+	if (unit->un_device)
+		device_destroy(ss->ss_class, unit->un_devno);
+
+	kfree(unit);
+}
+
+static void mpc_unit_put(struct mpc_unit *unit)
+{
+	if (unit)
+		kref_put(&unit->un_ref, mpc_unit_release);
+}
+
+/**
+ * mpc_unit_setup() - Create a device unit object and special file
+ * @uinfo:
+ * @name:
+ * @cfg:
+ * @mpool:
+ * @unitp: unitp can be NULL. *unitp is updated only if unitp is not NULL
+ *	and no error is returned.
+ *
+ * If successful, this function adopts mpool.  On failure, mpool
+ * remains the responsibility of the caller.
+ *
+ * All units are born with two references, one for the caller and one
+ * that can only be released by destroying the unit or unloading the
+ * module. If the caller passes in nil for unitp then this function
+ * will drop the caller's "caller reference" on his behalf.
+ *
+ * Return:  Returns 0 on success, -errno otherwise...
+ */
+static int mpc_unit_setup(const struct mpc_uinfo *uinfo, const char *name,
+			  const struct mpool_config *cfg, struct mpc_mpool *mpool,
+			  struct mpc_unit **unitp)
+{
+	struct mpc_softstate *ss = &mpc_softstate;
+	struct mpc_unit *unit;
+	struct device *device;
+	int rc;
+
+	if (!ss || !uinfo || !name || !name[0] || !cfg || !unitp)
+		return -EINVAL;
+
+	if (cfg->mc_uid == -1 || cfg->mc_gid == -1 || cfg->mc_mode == -1)
+		return -EINVAL;
+
+	if (!capable(CAP_MKNOD))
+		return -EPERM;
+
+	if (cfg->mc_uid != mpc_current_uid() && !capable(CAP_CHOWN))
+		return -EPERM;
+
+	if (cfg->mc_gid != mpc_current_gid() && !capable(CAP_CHOWN))
+		return -EPERM;
+
+	if (mpool && strcmp(mpool->mp_name, name))
+		return -EINVAL;
+
+	*unitp = NULL;
+	unit = NULL;
+
+	/*
+	 * Try to create a new unit object.  If successful, then all error
+	 * handling beyond this point must route through the errout label
+	 * to ensure the unit is fully destroyed.
+	 */
+	rc = mpc_unit_create(name, mpool, &unit);
+	if (rc)
+		return rc;
+
+	unit->un_uid = cfg->mc_uid;
+	unit->un_gid = cfg->mc_gid;
+	unit->un_mode = cfg->mc_mode;
+
+	unit->un_mdc_captgt = cfg->mc_captgt;
+	memcpy(&unit->un_utype, &cfg->mc_utype, sizeof(unit->un_utype));
+	strlcpy(unit->un_label, cfg->mc_label, sizeof(unit->un_label));
+	unit->un_ds_oidv[0] = cfg->mc_oid1;
+	unit->un_ds_oidv[1] = cfg->mc_oid2;
+	unit->un_ra_pages_max = cfg->mc_ra_pages_max;
+
+	device = device_create(ss->ss_class, NULL, unit->un_devno, unit, uinfo->ui_subdirfmt, name);
+	if (IS_ERR(device)) {
+		rc = PTR_ERR(device);
+		mp_pr_err("device_create %s failed", rc, name);
+		goto errout;
+	}
+
+	unit->un_device = device;
+	unit->un_uinfo = uinfo;
+
+	dev_info(unit->un_device, "minor %u, uid %u, gid %u, mode 0%02o",
+		 MINOR(unit->un_devno), cfg->mc_uid, cfg->mc_gid, cfg->mc_mode);
+
+	*unitp = unit;
+
+errout:
+	if (rc) {
+		/*
+		 * Acquire an additional reference on mpool so that it is not
+		 * errantly destroyed along with the unit, then release both
+		 * the unit's birth and caller's references which should
+		 * destroy the unit.
+		 */
+		kref_get(&mpool->mp_ref);
+		mpc_unit_put(unit);
+		mpc_unit_put(unit);
+	}
+
+	return rc;
+}
+
+/**
+ * mpc_uevent() - Hook to intercept and modify uevents before they're posted to udev
+ * @dev:    mpc driver device
+ * @env:
+ *
+ * See man 7 udev for more info.
+ */
+static int mpc_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	struct mpc_unit *unit = dev_get_drvdata(dev);
+
+	if (unit) {
+		add_uevent_var(env, "DEVMODE=%#o", unit->un_mode);
+		add_uevent_var(env, "DEVUID=%u", unit->un_uid);
+		add_uevent_var(env, "DEVGID=%u", unit->un_gid);
+	}
+
+	return 0;
+}
+
+static int mpc_exit_unit(int minor, void *item, void *arg)
+{
+	mpc_unit_put(item);
+
+	return ITERCB_NEXT;
+}
+
+/**
+ * mpctl_exit() - Tear down and unload the mpool control module.
+ */
+void mpctl_exit(void)
+{
+	struct mpc_softstate *ss = &mpc_softstate;
+
+	if (ss->ss_inited) {
+		idr_for_each(&ss->ss_unitmap, mpc_exit_unit, NULL);
+		idr_destroy(&ss->ss_unitmap);
+
+		if (ss->ss_devno != NODEV) {
+			if (ss->ss_class) {
+				if (ss->ss_cdev.ops)
+					cdev_del(&ss->ss_cdev);
+				class_destroy(ss->ss_class);
+			}
+			unregister_chrdev_region(ss->ss_devno, maxunits);
+		}
+
+		ss->ss_inited = false;
+	}
+}
+
+/**
+ * mpctl_init() - Load and initialize the mpool control module.
+ */
+int mpctl_init(void)
+{
+	struct mpc_softstate *ss = &mpc_softstate;
+	struct mpool_config *cfg = NULL;
+	struct mpc_unit *ctlunit;
+	const char *errmsg = NULL;
+	int rc;
+
+	if (ss->ss_inited)
+		return -EBUSY;
+
+	ctlunit = NULL;
+
+	maxunits = clamp_t(uint, maxunits, 8, 8192);
+
+	cdev_init(&ss->ss_cdev, &mpc_fops_default);
+	ss->ss_cdev.owner = THIS_MODULE;
+
+	mutex_init(&ss->ss_lock);
+	idr_init(&ss->ss_unitmap);
+	ss->ss_class = NULL;
+	ss->ss_devno = NODEV;
+	sema_init(&ss->ss_op_sema, 1);
+	ss->ss_inited = true;
+
+	rc = alloc_chrdev_region(&ss->ss_devno, 0, maxunits, "mpool");
+	if (rc) {
+		errmsg = "cannot allocate control device major";
+		ss->ss_devno = NODEV;
+		goto errout;
+	}
+
+	ss->ss_class = class_create(THIS_MODULE, module_name(THIS_MODULE));
+	if (IS_ERR(ss->ss_class)) {
+		errmsg = "class_create() failed";
+		rc = PTR_ERR(ss->ss_class);
+		ss->ss_class = NULL;
+		goto errout;
+	}
+
+	ss->ss_class->dev_uevent = mpc_uevent;
+
+	rc = cdev_add(&ss->ss_cdev, ss->ss_devno, maxunits);
+	if (rc) {
+		errmsg = "cdev_add() failed";
+		ss->ss_cdev.ops = NULL;
+		goto errout;
+	}
+
+	cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
+	if (!cfg) {
+		errmsg = "cfg alloc failed";
+		rc = -ENOMEM;
+		goto errout;
+	}
+
+	cfg->mc_uid = mpc_ctl_uid;
+	cfg->mc_gid = mpc_ctl_gid;
+	cfg->mc_mode = mpc_ctl_mode;
+
+	rc = mpc_unit_setup(&mpc_uinfo_ctl, MPC_DEV_CTLNAME, cfg, NULL, &ctlunit);
+	if (rc) {
+		errmsg = "cannot create control device";
+		goto errout;
+	}
+
+	mutex_lock(&ss->ss_lock);
+	idr_replace(&ss->ss_unitmap, ctlunit, MINOR(ctlunit->un_devno));
+	mutex_unlock(&ss->ss_lock);
+
+	mpc_unit_put(ctlunit);
+
+errout:
+	if (rc) {
+		mp_pr_err("%s", rc, errmsg);
+		mpctl_exit();
+	}
+
+	kfree(cfg);
+
+	return rc;
+}
diff --git a/drivers/mpool/mpctl.h b/drivers/mpool/mpctl.h
new file mode 100644
index 000000000000..ff3ec9fc24a9
--- /dev/null
+++ b/drivers/mpool/mpctl.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+
+#ifndef MPOOL_MPCTL_H
+#define MPOOL_MPCTL_H
+
+#include <linux/rbtree.h>
+#include <linux/kref.h>
+#include <linux/device.h>
+#include <linux/semaphore.h>
+
+#define ITERCB_NEXT     (0)
+#define ITERCB_DONE     (1)
+
+/* There is one unit object for each device object created by the driver. */
+struct mpc_unit {
+	struct kref                 un_ref;
+	int                         un_open_cnt;    /* Unit open count */
+	struct semaphore            un_open_lock;   /* Protects un_open_* */
+	bool                        un_open_excl;   /* Unit exclusively open */
+	uid_t                       un_uid;
+	gid_t                       un_gid;
+	mode_t                      un_mode;
+	dev_t                       un_devno;
+	const struct mpc_uinfo     *un_uinfo;
+	struct mpc_mpool           *un_mpool;
+	struct address_space       *un_mapping;
+	struct device              *un_device;
+	struct backing_dev_info    *un_saved_bdi;
+	struct mpc_attr            *un_attr;
+	uint                        un_rawio;       /* log2(max_mblock_size) */
+	u64                         un_ds_oidv[2];
+	u32                         un_ra_pages_max;
+	u64                         un_mdc_captgt;
+	uuid_le                     un_utype;
+	u8                          un_label[MPOOL_LABELSZ_MAX];
+	char                        un_name[];
+};
+
+static inline struct mpc_unit *dev_to_unit(struct device *dev)
+{
+	return dev_get_drvdata(dev);
+}
+
+int mpctl_init(void) __cold;
+void mpctl_exit(void) __cold;
+
+#endif /* MPOOL_MPCTL_H */
diff --git a/drivers/mpool/sysfs.c b/drivers/mpool/sysfs.c
new file mode 100644
index 000000000000..638106a77669
--- /dev/null
+++ b/drivers/mpool/sysfs.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+
+#include <linux/slab.h>
+
+#include "sysfs.h"
+
+struct mpc_attr *mpc_attr_create(struct device *dev, const char *name, int acnt)
+{
+	struct mpc_attr *attr;
+	int i;
+
+	attr = kzalloc(sizeof(*attr) + acnt * sizeof(*attr->a_dattr) +
+		       (acnt + 1) * sizeof(*attr->a_attrs), GFP_KERNEL);
+	if (!attr)
+		return NULL;
+
+	attr->a_kobj = &dev->kobj;
+
+	attr->a_dattr = (void *)(attr + 1);
+
+	attr->a_attrs = (void *)(attr->a_dattr + acnt);
+	for (i = 0; i < acnt; i++)
+		attr->a_attrs[i] = &attr->a_dattr[i].attr;
+	attr->a_attrs[i] = NULL;
+
+	attr->a_group.attrs = attr->a_attrs;
+	attr->a_group.name = name;
+
+	return attr;
+}
+
+void mpc_attr_destroy(struct mpc_attr *attr)
+{
+	kfree(attr);
+}
+
+int mpc_attr_group_create(struct mpc_attr *attr)
+{
+	return sysfs_create_group(attr->a_kobj, &attr->a_group);
+}
+
+void mpc_attr_group_destroy(struct mpc_attr *attr)
+{
+	sysfs_remove_group(attr->a_kobj, &attr->a_group);
+}
diff --git a/drivers/mpool/sysfs.h b/drivers/mpool/sysfs.h
new file mode 100644
index 000000000000..b161eceec75f
--- /dev/null
+++ b/drivers/mpool/sysfs.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+
+#ifndef MPOOL_SYSFS_H
+#define MPOOL_SYSFS_H
+
+#include <linux/device.h>
+#include <linux/sysfs.h>
+
+
+#define MPC_ATTR(_da, _name, _mode)                \
+	(_da)->attr.name = __stringify(_name);     \
+	(_da)->attr.mode = (_mode);                \
+	(_da)->show      = mpc_##_name##_show      \
+
+#define MPC_ATTR_RO(_dattr, _name)                 \
+	do {                                       \
+		__typeof(_dattr) da = (_dattr);    \
+		MPC_ATTR(da, _name, 0444);         \
+		da->store = NULL;                  \
+	} while (0)
+
+#define MPC_ATTR_RW(_dattr, _name)                 \
+	do {                                       \
+		__typeof(_dattr) da = (_dattr);    \
+		MPC_ATTR(da, _name, 0644);         \
+		da->store = mpc_##_name##_store;   \
+	} while (0)
+
+
+struct mpc_attr {
+	struct attribute_group       a_group;
+	struct kobject              *a_kobj;
+	struct device_attribute     *a_dattr;
+	struct attribute           **a_attrs;
+};
+
+struct mpc_attr *mpc_attr_create(struct device *d, const char *name, int acnt);
+
+void mpc_attr_destroy(struct mpc_attr *attr);
+
+int mpc_attr_group_create(struct mpc_attr *attr);
+
+void mpc_attr_group_destroy(struct mpc_attr *attr);
+
+#endif /* MPOOL_SYSFS_H */
-- 
2.17.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

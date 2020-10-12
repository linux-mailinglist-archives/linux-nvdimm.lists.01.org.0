Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BBB28BD9C
	for <lists+linux-nvdimm@lfdr.de>; Mon, 12 Oct 2020 18:28:10 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ADE7615AE2A5B;
	Mon, 12 Oct 2020 09:28:08 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.92.88; helo=nam10-bn7-obe.outbound.protection.outlook.com; envelope-from=nmeeramohide@micron.com; receiver=<UNKNOWN> 
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DAA1215AE2A5B
	for <linux-nvdimm@lists.01.org>; Mon, 12 Oct 2020 09:28:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIKfrs6IjKLJv08iGflS0QdFbQiGU0d/xqe9rq+RvK81F+u5wnOefV2o++Ow/trN17w1SnoB+QL5fBB8wDC45LZBmqpmEaefXNQkLHqgTAGfna6mHJwN1+G4R0EyCVH37mITg+5e2ZBRR1bQhoMJvH5Nv3J4BgTaF44Tc/7Xk0fiB3nBk+AURqvD2t3m3pTfVZ2f6hhqdQy1V/w2W8RvTttYG5bAxFaDLb9UjcTt1uUNYf+PACoXDaEYrkommLDcT/N/A4OzjFpdOoaHrmAX/2p2tPdGCmG0uzDqUnUnN90gyqrwMgGJuZMFw2GcMbgkaVsAxsAw9li7IDuSH5+tQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ov7hkZOVjFQmRNfZZb3qG9PqakDfrQUN0Fp9oW558KU=;
 b=oeTquXnE5AmGALsQf3w/32l6uCdqiJYhP+oF92Z3XxvHhhT9L+30jQ96GucaJqa8W7n+26n7e1uGZRXz2hYubiLs1ERQT+ahHFVJLBjc4Li9yr3c4bl+ta5RWlOOa8zFfn9LODbTb73AYDAAOYajArypc9i7Qi10MiNCcMfU4S4JORcTyqL3PH6VIBkufiNLbL3AmcdlvQdPRb2HeHfEOq+YSFDyNXT1IEtC3a4o0pYd/g+2784B/2Ne5TKL4bMZ8sn9+/Geqz678cMXyy3FTZgw+SBtv8SNB99jTOilYLsCaXYaezuFxiq71g7b2uPxcov4jUoQ0mH8H1vpY4xQ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=kvack.org smtp.mailfrom=micron.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ov7hkZOVjFQmRNfZZb3qG9PqakDfrQUN0Fp9oW558KU=;
 b=WufzLEI+UxbskofZCAZIL2J9i48hazxiDkO1BRO1BDFaGdgemPqtfTh42A5/mnKa+No8wel2izzVRUXYuQPQ89eEGXloNECnqggEctvQo5X6wMITW2Ak30Mga+3S8gFS75d5frCnk6WJZ6qYY6xD+PB+kffx0wCVaA9Ktgz4RZo=
Received: from SN4PR0201CA0051.namprd02.prod.outlook.com
 (2603:10b6:803:20::13) by BYAPR08MB5189.namprd08.prod.outlook.com
 (2603:10b6:a03:62::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.25; Mon, 12 Oct
 2020 16:27:58 +0000
Received: from SN1NAM01FT015.eop-nam01.prod.protection.outlook.com
 (2603:10b6:803:20:cafe::26) by SN4PR0201CA0051.outlook.office365.com
 (2603:10b6:803:20::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend
 Transport; Mon, 12 Oct 2020 16:27:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com;
Received: from mail.micron.com (137.201.242.130) by
 SN1NAM01FT015.mail.protection.outlook.com (10.152.65.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3455.23 via Frontend Transport; Mon, 12 Oct 2020 16:27:57 +0000
Received: from micron.com (10.114.5.55) by bowex17c.micron.com
 (137.201.21.211) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Oct
 2020 10:27:54 -0600
From: Nabeel M Mohamed <nmeeramohide@micron.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-nvdimm@lists.01.org>
Subject: [PATCH v2 01/22] mpool: add utility routines and ioctl definitions
Date: Mon, 12 Oct 2020 11:27:15 -0500
Message-ID: <20201012162736.65241-2-nmeeramohide@micron.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20201012162736.65241-1-nmeeramohide@micron.com>
References: <20201012162736.65241-1-nmeeramohide@micron.com>
MIME-Version: 1.0
X-ClientProxiedBy: bowex17a.micron.com (137.201.21.209) To bowex17c.micron.com
 (137.201.21.211)
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24646.005
X-TM-AS-Result: No--10.996200-0.000000-31
X-TM-AS-MatchedID: 700076-704983-702783-700308-702559-701342-702731-700863-8
	47298-701480-701809-703017-703140-702395-188019-703213-121336-701105-704673
	-703967-702754-704477-702433-703027-300015-701317-704499-700379-704978-7004
	28-105700-702914-702525-701270-703357-704318-700717-704402-704053-702779-70
	0714-701893-702962-105040-705244-702673-705022-700524-703976-700864-702259-
	703638-700458-703215-701475-704792-186035-704401-105630-704418-704475-70287
	6-701274-701701-705161-704397-701343-701773-703694-701969-701724-701029-851
	458-700958-843010-704328-703816-113238-702837-702008-704184-702688-704183-7
	04264-705094-701007-704929-704521-703286-703766-148004-148036-42000-42003
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84f17742-f841-49b0-c2b5-08d86ecbc778
X-MS-TrafficTypeDiagnostic: BYAPR08MB5189:
X-Microsoft-Antispam-PRVS: 
 <BYAPR08MB5189C0E8AE377487EB24A7DAB3070@BYAPR08MB5189.namprd08.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	NF6HX/rKpYP5Ih2z9nr889sgZ5SMOEX/QLP4PJhihUK55W3ZnLhS5swjTLZWjGuKsQ+Ctlm7DIR1NCfCLWCIsAFaL9T5Extbu3Gh38J67rRTRXnBnPrs6EhCr/vWd/EP8tuRrX91XWlDpDYFMmm1cgA7y+d+IgL9/33KveWoR6QiftM0mwhyafpGRnCy3bDcACTS1LJzIn96LEhxuqnV0W2EbAG1uzbD2nswOQnkRbbdm4wa8W61i5vP1ETtvWeB+KI9AZJTXy09BkCvlTGRINPC0n1iuG2NtHvjpzjYZIsnqTxBlm1vShD70s5pRibek9RzMcxumTuEC2MoWUV0q2HsuTRJ+Sb8w2hnjMAxwY5mnd9SPsM9RdhMa75F/xMS0cyjSixmGlkh6sULiCjQtGy+74okAJu7+XIG18uJpC8s3vo3FeIgghSoNd5uT7oIc9gdA/a1LAlEQvT/kTbP/g==
X-Forefront-Antispam-Report: 
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(46966005)(110136005)(36756003)(5660300002)(2616005)(6666004)(54906003)(8936002)(336012)(7696005)(186003)(316002)(30864003)(55016002)(26005)(86362001)(4326008)(8676002)(47076004)(7636003)(33310700002)(6286002)(1076003)(356005)(70206006)(70586007)(82310400003)(107886003)(83380400001)(2906002)(478600001)(426003)(82740400003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 16:27:57.5202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f17742-f841-49b0-c2b5-08d86ecbc778
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM01FT015.eop-nam01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB5189
Message-ID-Hash: ZDTWZMDIWQLXDF7K5WLKINRD7SRNP7VD
X-Message-ID-Hash: ZDTWZMDIWQLXDF7K5WLKINRD7SRNP7VD
X-MailFrom: nmeeramohide@micron.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: smoyer@micron.com, gbecker@micron.com, plabat@micron.com, jgroves@micron.com, Nabeel M Mohamed <nmeeramohide@micron.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZDTWZMDIWQLXDF7K5WLKINRD7SRNP7VD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This adds structures used by mpool ioctls and utility routines
for logging, UUID management etc.

The mpool ioctls can be categorized as follows:

1. IOCTLs issued to the mpool control device (/dev/mpoolctl)
   - Mpool life cycle management (MPIOC_MP_*)

2. IOCTLs issued to the mpool device (/dev/mpool/<mpool-name>)
   - Mpool parameters (MPIOC_PARAMS_*)
   - Mpool properties (MPIOC_PROP_*)
   - Mpool media class management (MPIOC_MP_MCLASS_*)
   - Device management (MPIOC_DRV_*)
   - Mblock object life cycle management and IO (MPIOC_MB_*)
   - Mlog object life cycle management and IO (MPIOC_MLOG_*)
   - Mblock cache management (MPIOC_VMA_*)

Co-developed-by: Greg Becker <gbecker@micron.com>
Signed-off-by: Greg Becker <gbecker@micron.com>
Co-developed-by: Pierre Labat <plabat@micron.com>
Signed-off-by: Pierre Labat <plabat@micron.com>
Co-developed-by: John Groves <jgroves@micron.com>
Signed-off-by: John Groves <jgroves@micron.com>
Signed-off-by: Nabeel M Mohamed <nmeeramohide@micron.com>
---
 drivers/mpool/assert.h       |  25 ++
 drivers/mpool/init.c         |  22 ++
 drivers/mpool/mpool_ioctl.h  | 636 +++++++++++++++++++++++++++++++++++
 drivers/mpool/mpool_printk.h |  43 +++
 drivers/mpool/uuid.h         |  59 ++++
 5 files changed, 785 insertions(+)
 create mode 100644 drivers/mpool/assert.h
 create mode 100644 drivers/mpool/init.c
 create mode 100644 drivers/mpool/mpool_ioctl.h
 create mode 100644 drivers/mpool/mpool_printk.h
 create mode 100644 drivers/mpool/uuid.h

diff --git a/drivers/mpool/assert.h b/drivers/mpool/assert.h
new file mode 100644
index 000000000000..a2081e71ec93
--- /dev/null
+++ b/drivers/mpool/assert.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+
+#ifndef MPOOL_ASSERT_H
+#define MPOOL_ASSERT_H
+
+#include <linux/bug.h>
+
+#ifdef CONFIG_MPOOL_ASSERT
+__cold __noreturn
+static inline void assertfail(const char *expr, const char *file, int line)
+{
+	pr_err("mpool assertion failed: %s in %s:%d\n", expr, file, line);
+	BUG();
+}
+
+#define ASSERT(_expr)   (likely(_expr) ? (void)0 : assertfail(#_expr, __FILE__, __LINE__))
+
+#else
+#define ASSERT(_expr)   (void)(_expr)
+#endif
+
+#endif /* MPOOL_ASSERT_H */
diff --git a/drivers/mpool/init.c b/drivers/mpool/init.c
new file mode 100644
index 000000000000..0493fb5b1157
--- /dev/null
+++ b/drivers/mpool/init.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+
+#include <linux/module.h>
+
+static __init int mpool_init(void)
+{
+	return 0;
+}
+
+static __exit void mpool_exit(void)
+{
+}
+
+module_init(mpool_init);
+module_exit(mpool_exit);
+
+MODULE_DESCRIPTION("Object Storage Media Pool (mpool)");
+MODULE_AUTHOR("Micron Technology, Inc.");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/mpool/mpool_ioctl.h b/drivers/mpool/mpool_ioctl.h
new file mode 100644
index 000000000000..599da0618a09
--- /dev/null
+++ b/drivers/mpool/mpool_ioctl.h
@@ -0,0 +1,636 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+
+#ifndef MPOOL_IOCTL_H
+#define MPOOL_IOCTL_H
+
+#include <linux/uuid.h>
+#include <linux/uio.h>
+
+#ifndef __user
+#define __user
+#endif
+
+/*
+ * Maximum name lengths including NUL terminator.  Note that the maximum
+ * mpool name length is baked into libblkid and may not be changed here.
+ */
+#define MPOOL_NAMESZ_MAX            32
+#define MPOOL_LABELSZ_MAX           64
+#define PD_NAMESZ_MAX               32
+
+#define MPC_DEV_SUBDIR              "mpool"
+#define MPC_DEV_CTLNAME             MPC_DEV_SUBDIR "ctl"
+#define MPC_DEV_CTLPATH             "/dev/" MPC_DEV_CTLNAME
+
+#define MPOOL_LABEL_INVALID         ""
+#define MPOOL_LABEL_DEFAULT         "raw"
+
+#define MPOOL_RA_PAGES_INVALID      U32_MAX
+#define MPOOL_RA_PAGES_MAX          ((128 * 1024) / PAGE_SIZE)
+
+#define MPOOL_MCLASS_INVALID        MP_MED_INVALID
+#define MPOOL_MCLASS_DEFAULT        MP_MED_CAPACITY
+
+#define MPOOL_SPARES_INVALID        U8_MAX
+#define MPOOL_SPARES_DEFAULT        5
+
+#define MPOOL_ROOT_LOG_CAP          (8 * 1024 * 1024)
+
+#define MPOOL_MBSIZE_MB_DEFAULT     32
+
+#define MPOOL_MDCNUM_DEFAULT        16
+
+
+/**
+ * mp_mgmt_flags - Mpool Management Flags
+ * @MP_FLAGS_FORCE:
+ * @MP_PERMIT_META_CONV: permit mpool metadata conversion. That is, allow the
+ *	mpool activate to write back the mpool metadata to the latest version
+ *	used by the binary activating the mpool.
+ * @MP_FLAGS_RESIZE: Resize mpool
+ */
+enum mp_mgmt_flags {
+	MP_FLAGS_FORCE,
+	MP_FLAGS_PERMIT_META_CONV,
+	MP_FLAGS_RESIZE,
+};
+
+/**
+ * mp_media_classp = Media classes
+ *
+ * @MP_MED_STAGING:  Initial data ingest, hot data storage, or similar.
+ * @MP_MED_CAPACITY: Primary data storage, cold data, or similar.
+ */
+enum mp_media_classp {
+	MP_MED_STAGING   = 0,
+	MP_MED_CAPACITY  = 1,
+};
+
+#define MP_MED_BASE        MP_MED_STAGING
+#define MP_MED_NUMBER      (MP_MED_CAPACITY + 1)
+#define MP_MED_INVALID     U8_MAX
+
+/**
+ * struct mpool_devprops -
+ * @pdp_devid:   UUID for drive
+ * @pdp_mclassp: enum mp_media_classp
+ * @pdp_status:  enum pd_status
+ * @pdp_total:   raw capacity of drive
+ * @pdp_avail:   available capacity (total - bad zones) of drive
+ * @pdp_spare:   spare capacity of drive
+ * @pdp_fspare:  free spare capacity of drive
+ * @pdp_usable:  usable capacity of drive
+ * @pdp_fusable: free usable capacity of drive
+ * @pdp_used:    used capacity of drive:
+ */
+struct mpool_devprops {
+	uuid_le    pdp_devid;
+	uint8_t    pdp_mclassp;
+	uint8_t    pdp_status;
+	uint8_t    pdp_rsvd1[6];
+	uint64_t   pdp_total;
+	uint64_t   pdp_avail;
+	uint64_t   pdp_spare;
+	uint64_t   pdp_fspare;
+	uint64_t   pdp_usable;
+	uint64_t   pdp_fusable;
+	uint64_t   pdp_used;
+	uint64_t   pdp_rsvd2;
+};
+
+/**
+ * struct mpool_params -
+ * @mp_poolid:          UUID of mpool
+ * @mp_type:            user-specified identifier
+ * @mp_uid:
+ * @mp_gid:
+ * @mp_mode:
+ * @mp_stat:            overall mpool status (enum mpool_status)
+ * @mp_mdc_captgt:      user MDC capacity
+ * @mp_oidv:            user MDC OIDs
+ * @mp_ra_pages_max:    max VMA map readahead pages
+ * @mp_vma_size_max:    max VMA map size (log2)
+ * @mp_mblocksz:        mblock size by media class (MiB)
+ * @mp_utype:           user-defined type
+ * @mp_label:           user specified label
+ * @mp_name:            mpool name (2x for planned expansion)
+ */
+struct mpool_params {
+	uuid_le     mp_poolid;
+	uid_t       mp_uid;
+	gid_t       mp_gid;
+	mode_t      mp_mode;
+	uint8_t     mp_stat;
+	uint8_t     mp_spare_cap;
+	uint8_t     mp_spare_stg;
+	uint8_t     mp_rsvd0;
+	uint64_t    mp_mdc_captgt;
+	uint64_t    mp_oidv[2];
+	uint32_t    mp_ra_pages_max;
+	uint32_t    mp_vma_size_max;
+	uint32_t    mp_mblocksz[MP_MED_NUMBER];
+	uint16_t    mp_mdc0cap;
+	uint16_t    mp_mdcncap;
+	uint16_t    mp_mdcnum;
+	uint16_t    mp_rsvd1;
+	uint32_t    mp_rsvd2;
+	uint64_t    mp_rsvd3;
+	uint64_t    mp_rsvd4;
+	uuid_le     mp_utype;
+	char        mp_label[MPOOL_LABELSZ_MAX];
+	char        mp_name[MPOOL_NAMESZ_MAX * 2];
+};
+
+/**
+ * struct mpool_usage - in bytes
+ * @mpu_total:   raw capacity for all drives
+ * @mpu_usable:  usable capacity for all drives
+ * @mpu_fusable: free usable capacity for all drives
+ * @mpu_used:    used capacity for all drives; possible for
+ *               used > usable when fusable=0; see smap
+ *               module for details
+ * @mpu_spare:   total spare space
+ * @mpu_fspare:  free spare space
+ *
+ * @mpu_mblock_alen: mblock allocated length
+ * @mpu_mblock_wlen: mblock written length
+ * @mpu_mlog_alen:   mlog allocated length
+ * @mpu_mblock_cnt:  number of active mblocks
+ * @mpu_mlog_cnt:    number of active mlogs
+ */
+struct mpool_usage {
+	uint64_t   mpu_total;
+	uint64_t   mpu_usable;
+	uint64_t   mpu_fusable;
+	uint64_t   mpu_used;
+	uint64_t   mpu_spare;
+	uint64_t   mpu_fspare;
+
+	uint64_t   mpu_alen;
+	uint64_t   mpu_wlen;
+	uint64_t   mpu_mblock_alen;
+	uint64_t   mpu_mblock_wlen;
+	uint64_t   mpu_mlog_alen;
+	uint32_t   mpu_mblock_cnt;
+	uint32_t   mpu_mlog_cnt;
+};
+
+/**
+ * mpool_mclass_xprops -
+ * @mc_devtype: type of devices in the media class
+ *                  (enum pd_devtype)
+ * @mc_mclass: media class (enum mp_media_classp)
+ * @mc_sectorsz: media class (enum mp_media_classp)
+ * @mc_spare: percent spare zones for drives
+ * @mc_uacnt: UNAVAIL status drive count
+ * @mc_zonepg: pages per zone
+ * @mc_features: feature bitmask
+ * @mc_usage: feature bitmask
+ */
+struct mpool_mclass_xprops {
+	uint8_t                    mc_devtype;
+	uint8_t                    mc_mclass;
+	uint8_t                    mc_sectorsz;
+	uint8_t                    mc_rsvd1;
+	uint32_t                   mc_spare;
+	uint16_t                   mc_uacnt;
+	uint16_t                   mc_rsvd2;
+	uint32_t                   mc_zonepg;
+	uint64_t                   mc_features;
+	uint64_t                   mc_rsvd3;
+	struct mpool_usage         mc_usage;
+};
+
+/**
+ * mpool_mclass_props -
+ *
+ * @mc_mblocksz:   mblock size in MiB
+ * @mc_rsvd:       reserved struct field (for future use)
+ * @mc_total:      total space in the media class (mc_usable + mc_spare)
+ * @mc_usable:     usable space in bytes
+ * @mc_used:       bytes allocated from usable space
+ * @mc_spare:      spare space in bytes
+ * @mc_spare_used: bytes allocated from spare space
+ */
+struct mpool_mclass_props {
+	uint32_t   mc_mblocksz;
+	uint32_t   mc_rsvd;
+	uint64_t   mc_total;
+	uint64_t   mc_usable;
+	uint64_t   mc_used;
+	uint64_t   mc_spare;
+	uint64_t   mc_spare_used;
+};
+
+/**
+ * struct mpool_xprops - Extended mpool properties
+ * @ppx_params: mpool configuration parameters
+ * @ppx_drive_spares: percent spare zones for drives in each media class
+ * @ppx_uacnt:  UNAVAIL status drive count in each media class
+ */
+struct mpool_xprops {
+	struct mpool_params     ppx_params;
+	uint8_t                 ppx_rsvd[MP_MED_NUMBER];
+	uint8_t                 ppx_drive_spares[MP_MED_NUMBER];
+	uint16_t                ppx_uacnt[MP_MED_NUMBER];
+	uint32_t                ppx_pd_mclassv[MP_MED_NUMBER];
+	char                    ppx_pd_namev[MP_MED_NUMBER][PD_NAMESZ_MAX];
+};
+
+
+/*
+ * struct mblock_props -
+ *
+ * @mpr_objid:        mblock identifier
+ * @mpr_alloc_cap:    allocated capacity in bytes
+ * @mpr_write_len:    written user-data in bytes
+ * @mpr_optimal_wrsz: optimal write size(in bytes) for all but the last incremental mblock write
+ * @mpr_mclassp:      media class
+ * @mpr_iscommitted:  Is this mblock committed?
+ */
+struct mblock_props {
+	uint64_t                mpr_objid;
+	uint32_t                mpr_alloc_cap;
+	uint32_t                mpr_write_len;
+	uint32_t                mpr_optimal_wrsz;
+	uint32_t                mpr_mclassp; /* enum mp_media_classp */
+	uint8_t                 mpr_iscommitted;
+	uint8_t                 mpr_rsvd1[7];
+	uint64_t                mpr_rsvd2;
+};
+
+struct mblock_props_ex {
+	struct mblock_props     mbx_props;
+	uint8_t                 mbx_zonecnt;      /* zone count per strip */
+	uint8_t                 mbx_rsvd1[7];
+	uint64_t                mbx_rsvd2;
+};
+
+
+/*
+ * enum mlog_open_flags -
+ * @MLOG_OF_COMPACT_SEM: Enforce compaction semantics
+ * @MLOG_OF_SKIP_SER:    Appends and reads are guaranteed to be serialized
+ *                       outside of the mlog API
+ */
+enum mlog_open_flags {
+	MLOG_OF_COMPACT_SEM = 0x1,
+	MLOG_OF_SKIP_SER    = 0x2,
+};
+
+/*
+ * NOTE:
+ * + a value of 0 for targets (*tgt) means no specific target and the
+ *   allocator is free to choose based on media class configuration
+ */
+struct mlog_capacity {
+	uint64_t    lcp_captgt;       /* capacity target for mlog in bytes */
+	uint8_t     lcp_spare;        /* true if alloc mlog from spare space */
+	uint8_t     lcp_rsvd1[7];
+};
+
+/*
+ * struct mlog_props -
+ *
+ * @lpr_uuid:        UUID or mlog magic
+ * @lpr_objid:       mlog identifier
+ * @lpr_alloc_cap:   maximum capacity in bytes
+ * @lpr_gen:         generation no. (user mlogs)
+ * @lpr_mclassp:     media class
+ * @lpr_iscommitted: Is this mlog committed?
+ */
+struct mlog_props {
+	uuid_le     lpr_uuid;
+	uint64_t    lpr_objid;
+	uint64_t    lpr_alloc_cap;
+	uint64_t    lpr_gen;
+	uint8_t     lpr_mclassp;
+	uint8_t     lpr_iscommitted;
+	uint8_t     lpr_rsvd1[6];
+	uint64_t    lpr_rsvd2;
+};
+
+/*
+ * struct mlog_props_ex -
+ *
+ * @lpx_props:
+ * @lpx_totsec:   total number of sectors
+ * @lpx_zonecnt:   zone count per strip
+ * @lpx_state:    mlog layout state
+ * @lpx_secshift: sector shift
+ */
+struct mlog_props_ex {
+	struct mlog_props   lpx_props;
+	uint32_t            lpx_totsec;
+	uint32_t            lpx_zonecnt;
+	uint8_t             lpx_state;
+	uint8_t             lpx_secshift;
+	uint8_t             lpx_rsvd1[6];
+	uint64_t            lpx_rsvd2;
+};
+
+
+/**
+ * enum mdc_open_flags -
+ * @MDC_OF_SKIP_SER: appends and reads are guaranteed to be serialized
+ *                   outside of the MDC API
+ */
+enum mdc_open_flags {
+	MDC_OF_SKIP_SER  = 0x1,
+};
+
+/**
+ * struct mdc_capacity -
+ * @mdt_captgt: capacity target for mlog in bytes
+ * @mpt_spare:  true if alloc MDC from spare space
+ */
+struct mdc_capacity {
+	uint64_t   mdt_captgt;
+	bool       mdt_spare;
+};
+
+/**
+ * struct mdc_props -
+ * @mdc_objid1:
+ * @mdc_objid2:
+ * @mdc_alloc_cap:
+ * @mdc_mclassp:
+ */
+struct mdc_props {
+	uint64_t               mdc_objid1;
+	uint64_t               mdc_objid2;
+	uint64_t               mdc_alloc_cap;
+	enum mp_media_classp   mdc_mclassp;
+};
+
+
+/**
+ * enum mpc_vma_advice -
+ * @MPC_VMA_COLD:
+ * @MPC_VMA_WARM:
+ * @MPC_VMA_HOT:
+ * @MPC_VMA_PINNED:
+ */
+enum mpc_vma_advice {
+	MPC_VMA_COLD = 0,
+	MPC_VMA_WARM,
+	MPC_VMA_HOT,
+	MPC_VMA_PINNED
+};
+
+
+/**
+ * struct pd_znparam - zone parameter arg used in compute/set API functions
+ * @dvb_zonepg:     zone size in PAGE_SIZE units.
+ * @dvb_zonetot:    total number of zones
+ */
+struct pd_znparam {
+	uint32_t   dvb_zonepg;
+	uint32_t   dvb_zonetot;
+	uint64_t   dvb_rsvd1;
+};
+
+#define PD_DEV_ID_LEN              64
+
+/**
+ * struct pd_prop - PD properties
+ * @pdp_didstr:         drive id string (model)
+ * @pdp_devtype:	device type (enum pd_devtype)
+ * @pdp_phys_if:	physical interface of the drive
+ *			Determined by the device discovery.
+ *			(device_phys_if)
+ * @pdp_mclassp:        performance characteristic of the media class
+ *			Determined by the user, not by the device discovery.
+ *			(enum mp_media_classp)
+ * @pdp_cmdopt:         enum pd_cmd_opt. Features of the PD.
+ * @pdp_zparam:	zone parameters
+ * @pdp_discard_granularity: specified by
+ *	/sys/block/<disk>/queue/discard_granularity
+ * @pdp_sectorsz:	Sector size, exponent base 2
+ * @pdp_optiosz:        Optimal IO size
+ * @pdp_devsz:		device size in bytes
+ *
+ * Note: in order to avoid passing enums across user-kernel boundary
+ * declare the following as uint8_t
+ * pdp_devtype: enum pd_devtype
+ * pdp_devstate: enum pd_state
+ * pdp_phys_if: enum device_phys_if
+ * pdp_mclassp: enum mp_media_classp
+ */
+struct pd_prop {
+	char		        pdp_didstr[PD_DEV_ID_LEN];
+	uint8_t                 pdp_devtype;
+	uint8_t                 pdp_devstate;
+	uint8_t                 pdp_phys_if;
+	uint8_t                 pdp_mclassp;
+	bool                    pdp_fua;
+	uint64_t                pdp_cmdopt;
+
+	struct pd_znparam       pdp_zparam;
+	uint32_t                pdp_discard_granularity;
+	uint32_t                pdp_sectorsz;
+	uint32_t                pdp_optiosz;
+	uint32_t                pdp_rsvd2;
+	uint64_t	        pdp_devsz;
+	uint64_t	        pdp_rsvd3;
+};
+
+
+struct mpioc_mpool {
+	struct mpool_params     mp_params;
+	uint32_t                mp_flags;       /* mp_mgmt_flags */
+	uint32_t                mp_dpathc;      /* Count of device paths */
+	uint32_t                mp_dpathssz;    /* Length of mp_dpaths */
+	uint32_t                mp_rsvd1;
+	uint64_t                mp_rsvd2;
+	char __user            *mp_dpaths;      /* Newline separated paths */
+	struct pd_prop __user  *mp_pd_prop;     /* mp_dpathc elements */
+};
+
+/**
+ * struct mpioc_params -
+ * @mps_params;
+ */
+struct mpioc_params {
+	struct mpool_params     mps_params;
+};
+
+struct mpioc_mclass {
+	struct mpool_mclass_xprops __user  *mcl_xprops;
+	uint32_t                            mcl_cnt;
+	uint32_t                            mcl_rsvd1;
+};
+
+struct mpioc_drive {
+	uint32_t	        drv_flags;   /* mp_mgmt_flags */
+	uint32_t	        drv_rsvd1;
+	uint32_t                drv_dpathc;  /* Count of device paths */
+	uint32_t                drv_dpathssz;/* Length of mp_dpaths */
+	struct pd_prop __user  *drv_pd_prop; /* mp_dpathc elements */
+	char __user            *drv_dpaths;  /* Newline separated device paths*/
+};
+
+enum mpioc_list_cmd {
+	MPIOC_LIST_CMD_INVALID     = 0,
+	MPIOC_LIST_CMD_PROP_GET    = 1,       /* Used by mpool get command */
+	MPIOC_LIST_CMD_PROP_LIST   = 2,       /* Used by mpool list command */
+	MPIOC_LIST_CMD_LAST = MPIOC_LIST_CMD_PROP_LIST,
+};
+
+struct mpioc_list {
+	uint32_t        ls_cmd;     /* enum mpioc_list_cmd */
+	uint32_t        ls_listc;
+	void __user    *ls_listv;
+};
+
+struct mpioc_prop {
+	struct mpool_xprops         pr_xprops;
+	struct mpool_usage          pr_usage;
+	struct mpool_mclass_xprops  pr_mcxv[MP_MED_NUMBER];
+	uint32_t                    pr_mcxc;
+	uint32_t                    pr_rsvd1;
+	uint64_t                    pr_rsvd2;
+};
+
+struct mpioc_devprops {
+	char                    dpr_pdname[PD_NAMESZ_MAX];
+	struct mpool_devprops   dpr_devprops;
+};
+
+/**
+ * struct mpioc_mblock:
+ * @mb_objid:   mblock unique ID (permanent)
+ * @mb_offset:  mblock read offset (ephemeral)
+ * @mb_props:
+ * @mb_layout
+ * @mb_spare:
+ * @mb_mclassp: enum mp_media_classp, declared as uint8_t
+ */
+struct mpioc_mblock {
+	uint64_t                mb_objid;
+	int64_t                 mb_offset;
+	struct mblock_props_ex  mb_props;
+	uint8_t                 mb_spare;
+	uint8_t                 mb_mclassp;
+	uint16_t                mb_rsvd1;
+	uint32_t                mb_rsvd2;
+	uint64_t                mb_rsvd3;
+};
+
+struct mpioc_mblock_id {
+	uint64_t    mi_objid;
+};
+
+#define MPIOC_KIOV_MAX          (1024)
+
+struct mpioc_mblock_rw {
+	uint64_t                    mb_objid;
+	int64_t                     mb_offset;
+	uint32_t                    mb_rsvd2;
+	uint16_t                    mb_rsvd3;
+	uint16_t                    mb_iov_cnt;
+	const struct iovec __user  *mb_iov;
+};
+
+struct mpioc_mlog {
+	uint64_t                ml_objid;
+	uint64_t                ml_rsvd;
+	struct mlog_props_ex    ml_props;
+	struct mlog_capacity    ml_cap;
+	uint8_t                 ml_mclassp; /* enum mp_media_classp */
+	uint8_t                 ml_rsvd1[7];
+	uint64_t                ml_rsvd2;
+};
+
+struct mpioc_mlog_id {
+	uint64_t    mi_objid;
+	uint64_t    mi_gen;
+	uint8_t     mi_state;
+	uint8_t     mi_rsvd1[7];
+};
+
+struct mpioc_mlog_io {
+	uint64_t                mi_objid;
+	int64_t                 mi_off;
+	uint8_t                 mi_op;
+	uint8_t                 mi_rsvd1[5];
+	uint16_t                mi_iovc;
+	struct iovec __user    *mi_iov;
+	uint64_t                mi_rsvd2;
+};
+
+struct mpioc_vma {
+	uint32_t            im_advice;
+	uint32_t            im_mbidc;
+	uint64_t __user    *im_mbidv;
+	uint64_t            im_bktsz;
+	int64_t             im_offset;
+	uint64_t            im_len;
+	uint64_t            im_vssp;
+	uint64_t            im_rssp;
+	uint64_t            im_rsvd;
+};
+
+union mpioc_union {
+	struct mpioc_mpool      mpu_mpool;
+	struct mpioc_drive      mpu_drive;
+	struct mpioc_params     mpu_params;
+	struct mpioc_mclass     mpu_mclass;
+	struct mpioc_list       mpu_list;
+	struct mpioc_prop       mpu_prop;
+	struct mpioc_devprops   mpu_devprops;
+	struct mpioc_mlog       mpu_mlog;
+	struct mpioc_mlog_id    mpu_mlog_id;
+	struct mpioc_mlog_io    mpu_mlog_io;
+	struct mpioc_mblock     mpu_mblock;
+	struct mpioc_mblock_id  mpu_mblock_id;
+	struct mpioc_mblock_rw  mpu_mblock_rw;
+	struct mpioc_vma        mpu_vma;
+};
+
+#define MPIOC_MAGIC             ('2')
+
+#define MPIOC_MP_CREATE         _IOWR(MPIOC_MAGIC, 1, struct mpioc_mpool)
+#define MPIOC_MP_DESTROY        _IOW(MPIOC_MAGIC, 2, struct mpioc_mpool)
+#define MPIOC_MP_ACTIVATE       _IOWR(MPIOC_MAGIC, 5, struct mpioc_mpool)
+#define MPIOC_MP_DEACTIVATE     _IOW(MPIOC_MAGIC, 6, struct mpioc_mpool)
+#define MPIOC_MP_RENAME         _IOWR(MPIOC_MAGIC, 7, struct mpioc_mpool)
+
+#define MPIOC_PARAMS_GET        _IOWR(MPIOC_MAGIC, 10, struct mpioc_params)
+#define MPIOC_PARAMS_SET        _IOWR(MPIOC_MAGIC, 11, struct mpioc_params)
+#define MPIOC_MP_MCLASS_GET     _IOWR(MPIOC_MAGIC, 12, struct mpioc_mclass)
+
+#define MPIOC_DRV_ADD           _IOWR(MPIOC_MAGIC, 15, struct mpioc_drive)
+#define MPIOC_DRV_SPARES        _IOWR(MPIOC_MAGIC, 16, struct mpioc_drive)
+
+#define MPIOC_PROP_GET          _IOWR(MPIOC_MAGIC, 20, struct mpioc_list)
+#define MPIOC_PROP_SET          _IOWR(MPIOC_MAGIC, 21, struct mpioc_list)
+#define MPIOC_DEVPROPS_GET      _IOWR(MPIOC_MAGIC, 22, struct mpioc_devprops)
+
+#define MPIOC_MLOG_ALLOC        _IOWR(MPIOC_MAGIC, 30, struct mpioc_mlog)
+#define MPIOC_MLOG_COMMIT       _IOWR(MPIOC_MAGIC, 32, struct mpioc_mlog_id)
+#define MPIOC_MLOG_ABORT        _IOW(MPIOC_MAGIC, 33, struct mpioc_mlog_id)
+#define MPIOC_MLOG_DELETE       _IOW(MPIOC_MAGIC, 34, struct mpioc_mlog_id)
+#define MPIOC_MLOG_FIND         _IOWR(MPIOC_MAGIC, 37, struct mpioc_mlog)
+#define MPIOC_MLOG_READ         _IOW(MPIOC_MAGIC, 40, struct mpioc_mlog_io)
+#define MPIOC_MLOG_WRITE        _IOW(MPIOC_MAGIC, 41, struct mpioc_mlog_io)
+#define MPIOC_MLOG_PROPS        _IOWR(MPIOC_MAGIC, 42, struct mpioc_mlog)
+#define MPIOC_MLOG_ERASE        _IOWR(MPIOC_MAGIC, 43, struct mpioc_mlog_id)
+
+#define MPIOC_MB_ALLOC          _IOWR(MPIOC_MAGIC, 50, struct mpioc_mblock)
+#define MPIOC_MB_ABORT          _IOW(MPIOC_MAGIC, 52, struct mpioc_mblock_id)
+#define MPIOC_MB_COMMIT         _IOW(MPIOC_MAGIC, 53, struct mpioc_mblock_id)
+#define MPIOC_MB_DELETE         _IOW(MPIOC_MAGIC, 54, struct mpioc_mblock_id)
+#define MPIOC_MB_FIND           _IOWR(MPIOC_MAGIC, 56, struct mpioc_mblock)
+#define MPIOC_MB_READ           _IOW(MPIOC_MAGIC, 60, struct mpioc_mblock_rw)
+#define MPIOC_MB_WRITE          _IOW(MPIOC_MAGIC, 61, struct mpioc_mblock_rw)
+
+#define MPIOC_VMA_CREATE        _IOWR(MPIOC_MAGIC, 70, struct mpioc_vma)
+#define MPIOC_VMA_DESTROY       _IOW(MPIOC_MAGIC, 71, struct mpioc_vma)
+#define MPIOC_VMA_PURGE         _IOW(MPIOC_MAGIC, 72, struct mpioc_vma)
+#define MPIOC_VMA_VRSS          _IOWR(MPIOC_MAGIC, 73, struct mpioc_vma)
+
+#endif
diff --git a/drivers/mpool/mpool_printk.h b/drivers/mpool/mpool_printk.h
new file mode 100644
index 000000000000..280a8e064115
--- /dev/null
+++ b/drivers/mpool/mpool_printk.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+
+#ifndef MPOOL_PRINTK_H
+#define MPOOL_PRINTK_H
+
+#include <linux/printk.h>
+
+static unsigned long mp_pr_rl_state __maybe_unused;
+
+/* TODO: Use dev_crit(), dev_err(), ... */
+
+#define mp_pr_crit(_fmt, _err, ...)				\
+	pr_crit("%s: " _fmt ": errno %d", __func__, ## __VA_ARGS__, (_err))
+
+#define mp_pr_err(_fmt, _err, ...)				\
+	pr_err("%s: " _fmt ": errno %d", __func__, ## __VA_ARGS__, (_err))
+
+#define mp_pr_warn(_fmt, ...)					\
+	pr_warn("%s: " _fmt, __func__, ## __VA_ARGS__)
+
+#define mp_pr_notice(_fmt, ...)					\
+	pr_notice("%s: " _fmt, __func__, ## __VA_ARGS__)
+
+#define mp_pr_info(_fmt, ...)					\
+	pr_info("%s: " _fmt, __func__, ## __VA_ARGS__)
+
+#define mp_pr_debug(_fmt, _err, ...)				\
+	pr_debug("%s: " _fmt ": errno %d", __func__, ## __VA_ARGS__,  (_err))
+
+
+/* Rate limited version of mp_pr_err(). */
+#define mp_pr_rl(_fmt, _err, ...)				\
+do {								\
+	if (printk_timed_ratelimit(&mp_pr_rl_state, 333)) {	\
+		pr_err("%s: " _fmt ": errno %d",		\
+		       __func__, ## __VA_ARGS__, (_err));	\
+	}							\
+} while (0)
+
+#endif /* MPOOL_PRINTK_H */
diff --git a/drivers/mpool/uuid.h b/drivers/mpool/uuid.h
new file mode 100644
index 000000000000..28e53be68662
--- /dev/null
+++ b/drivers/mpool/uuid.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+
+#ifndef MPOOL_UUID_H
+#define MPOOL_UUID_H
+
+#define MPOOL_UUID_SIZE        16
+#define MPOOL_UUID_STRING_LEN  36
+
+#include <linux/kernel.h>
+#include <linux/uuid.h>
+
+struct mpool_uuid {
+	unsigned char uuid[MPOOL_UUID_SIZE];
+};
+
+/* mpool_uuid uses the LE version in the kernel */
+static inline void mpool_generate_uuid(struct mpool_uuid *uuid)
+{
+	generate_random_guid(uuid->uuid);
+}
+
+static inline void mpool_uuid_copy(struct mpool_uuid *u_dst, const struct mpool_uuid *u_src)
+{
+	memcpy(u_dst->uuid, u_src->uuid, MPOOL_UUID_SIZE);
+}
+
+static inline int mpool_uuid_compare(const struct mpool_uuid *uuid1, const struct mpool_uuid *uuid2)
+{
+	return memcmp(uuid1, uuid2, MPOOL_UUID_SIZE);
+}
+
+static inline void mpool_uuid_clear(struct mpool_uuid *uuid)
+{
+	memset(uuid->uuid, 0, MPOOL_UUID_SIZE);
+}
+
+static inline int mpool_uuid_is_null(const struct mpool_uuid *uuid)
+{
+	const struct mpool_uuid zero = { };
+
+	return !memcmp(&zero, uuid, sizeof(zero));
+}
+
+static inline void mpool_unparse_uuid(const struct mpool_uuid *uuid, char *dst)
+{
+	const unsigned char *u = uuid->uuid;
+
+	snprintf(dst, MPOOL_UUID_STRING_LEN + 1,
+		 "%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x",
+		 u[0], u[1], u[2], u[3],
+		 u[4], u[5], u[6], u[7],
+		 u[8], u[9], u[10], u[11],
+		 u[12], u[13], u[14], u[15]);
+}
+
+#endif /* MPOOL_UUID_H */
-- 
2.17.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

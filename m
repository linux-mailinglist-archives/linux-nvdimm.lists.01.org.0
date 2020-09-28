Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B82F927B258
	for <lists+linux-nvdimm@lfdr.de>; Mon, 28 Sep 2020 18:47:45 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A5FA2153A8A09;
	Mon, 28 Sep 2020 09:47:28 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.243.56; helo=nam12-dm6-obe.outbound.protection.outlook.com; envelope-from=nmeeramohide@micron.com; receiver=<UNKNOWN> 
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7448C152EDBCF
	for <linux-nvdimm@lists.01.org>; Mon, 28 Sep 2020 09:47:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZJewqQxQcwwwe1A7heElDxOyxKOt0cQJvdRb0HceJr4blxJH87onO74qiM8a/R2XyriO7s8IixmgfIu/tveec2PJOmv7OxjMFZQhvdM+yesv51+3OeAyROqF+5jT1WSQKrMJExtFUKLsG2FwQ221nTSEmcetjDgYYophLFKZxLwjeCePd2EEhTfus92S7BiYBDRN95bkX4GAc/2s0/7Sx6So3uvHcTs7XuVFIJbBUIES6sOtRL7RxFGcPKplwawSuWH1fDN9Al+5yuMftPIKdSerkKou9vYZon8GCBiQN+G1x108d/XNurM5BFqK1KwxhPbfcoy7UBOt+iFRPm+fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LLZlCiwYv42Sp3MVyUXSIPnkfi5MuTb/poHrT6pbdc=;
 b=T9/nqx9pB4dxVsYwYbTAJYZ12/nD0IneiKjihoGejSzBCRLVguIDm+2ssUrFFd/Xt6fK1YlKz8ZqBejr8LUZZ9V7bfriDlneWlvO/dYcBwwzY+LtkihdT4gsNk5SMVW5umZ6x1tIsL8+kXGMeC3zc+s56gO+JUrc/fW2kxCp2Urh/QGR1zKxjZ20N2hP76vVicBj44xeVCRMJvZp2OZOtVRdKFyQfVO9EOG92o55POHDs2XPyvcMw9ZGqzKFaiGVTJGpgGfbqjZ7HLxWED/iTh9Me4umRo4hvnHE9i9FrTHt9fQHHI33NWwr0yj5jEGCFx6JPr6etTCZVoRARaiVvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=kvack.org smtp.mailfrom=micron.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LLZlCiwYv42Sp3MVyUXSIPnkfi5MuTb/poHrT6pbdc=;
 b=t/LZn4innjWbWPkgbvSH1KarIUCsjf2TaoSlYzdAM5X/hRct5stZmP6Zw0apuI4w6r7GIBHS0X2n78cVdWwIxos3tb1eZY27aApx34SQeMwoREVAXfvvqDNjCzMTYN8rWVx/3X/0SO71V6L7q57RDBsljcUmNjauEOL20mq92YY=
Received: from BN6PR13CA0037.namprd13.prod.outlook.com (2603:10b6:404:13e::23)
 by CY4PR08MB2968.namprd08.prod.outlook.com (2603:10b6:903:146::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Mon, 28 Sep
 2020 16:47:22 +0000
Received: from BN3NAM01FT028.eop-nam01.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::30) by BN6PR13CA0037.outlook.office365.com
 (2603:10b6:404:13e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.13 via Frontend
 Transport; Mon, 28 Sep 2020 16:47:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com;
Received: from mail.micron.com (137.201.242.130) by
 BN3NAM01FT028.mail.protection.outlook.com (10.152.67.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3412.21 via Frontend Transport; Mon, 28 Sep 2020 16:47:22 +0000
Received: from micron.com (10.114.5.55) by bowex17c.micron.com
 (137.201.21.211) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 28 Sep
 2020 10:47:18 -0600
From: <nmeeramohide@micron.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-nvdimm@lists.01.org>
Subject: [PATCH 22/22] mpool: add Kconfig and Makefile
Date: Mon, 28 Sep 2020 11:45:34 -0500
Message-ID: <20200928164534.48203-23-nmeeramohide@micron.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200928164534.48203-1-nmeeramohide@micron.com>
References: <20200928164534.48203-1-nmeeramohide@micron.com>
MIME-Version: 1.0
X-ClientProxiedBy: bowex17d.micron.com (137.201.21.212) To bowex17c.micron.com
 (137.201.21.211)
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24646.005
X-TM-AS-Result: No--2.057200-0.000000-31
X-TM-AS-MatchedID: 700076-701480-701809-703017-702395-188019-704388-702493-7
	01128-703140-703213-121336-704499-701029-701270-703027-704783-701343-703713
	-702207-704623-700260-105700-701592-704079-700806-701590-704849-703993-1860
	27-704962-148004-148036-42000-42003
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 498ccff6-3a0c-45bc-4ba9-08d863ce2bd1
X-MS-TrafficTypeDiagnostic: CY4PR08MB2968:
X-Microsoft-Antispam-PRVS: 
 <CY4PR08MB29686D9948BC453CC9790D8CB3350@CY4PR08MB2968.namprd08.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qlTqLwQUa6FgoKcykeoK9xGkjlcp1D85rwCHjyBuXGjuqZmQ9jT3glB4kCLAOlHVh5Njw8qvkL1mPEX5b6p1Lrm0yTyMMWRvc3ZPv/HhNSGH3lY7eHZPCVoLIvSLtW7zhV4QmeTMm1PNdW4k3StZdkkNnYVMPUdPKhT6sBwoJmC5/8Mc0XXVSHt5L+m6zct5/RMgxbaoRYWwhmjvFH3Z9PKuANt6m9n/k7jYZwWmhFCYPBM4XjniuVeX7HWVAlJzM3wWimp/mDwRtKqNkpzzHc5VPB9ovaaAQ+J2F8BT9aFUXvK6N/9tBUOI4Kn4GpVQ87768q+pwBd/7GNjA2okiNuSdmFTPY96JmqhiusWHHkgTlDvt8TqHQ3aF6X0aC7U0hawUxq73DkbYObKDHTVmqv8IDb0TWava6sZ73L5qSNbkOqJw9vp41kl3H3y9ax8w0SUySVs2EVwo7qnhIoqs4z3yw5FRaYm3GRTqqLankI7dgYjqB4+GZscm7er3f+O
X-Forefront-Antispam-Report: 
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(46966005)(55016002)(186003)(26005)(336012)(426003)(70586007)(5660300002)(83380400001)(2876002)(2906002)(4326008)(316002)(2616005)(54906003)(110136005)(478600001)(7696005)(107886003)(6286002)(36756003)(1076003)(82310400003)(8676002)(6666004)(82740400003)(7636003)(47076004)(70206006)(356005)(33310700002)(8936002)(86362001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 16:47:22.0865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 498ccff6-3a0c-45bc-4ba9-08d863ce2bd1
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3NAM01FT028.eop-nam01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR08MB2968
Message-ID-Hash: LQ3I433M5MOOQ3CLRX6T4RB4BU6BC4FR
X-Message-ID-Hash: LQ3I433M5MOOQ3CLRX6T4RB4BU6BC4FR
X-MailFrom: nmeeramohide@micron.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: smoyer@micron.com, gbecker@micron.com, plabat@micron.com, jgroves@micron.com, Nabeel M Mohamed <nmeeramohide@micron.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LQ3I433M5MOOQ3CLRX6T4RB4BU6BC4FR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Nabeel M Mohamed <nmeeramohide@micron.com>

This adds the Kconfig and Makefile for mpool.

Co-developed-by: Greg Becker <gbecker@micron.com>
Signed-off-by: Greg Becker <gbecker@micron.com>
Co-developed-by: Pierre Labat <plabat@micron.com>
Signed-off-by: Pierre Labat <plabat@micron.com>
Co-developed-by: John Groves <jgroves@micron.com>
Signed-off-by: John Groves <jgroves@micron.com>
Signed-off-by: Nabeel M Mohamed <nmeeramohide@micron.com>
---
 drivers/Kconfig        |  2 ++
 drivers/Makefile       |  1 +
 drivers/mpool/Kconfig  | 28 ++++++++++++++++++++++++++++
 drivers/mpool/Makefile | 11 +++++++++++
 4 files changed, 42 insertions(+)
 create mode 100644 drivers/mpool/Kconfig
 create mode 100644 drivers/mpool/Makefile

diff --git a/drivers/Kconfig b/drivers/Kconfig
index dcecc9f6e33f..547ac47a10eb 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -235,4 +235,6 @@ source "drivers/interconnect/Kconfig"
 source "drivers/counter/Kconfig"
 
 source "drivers/most/Kconfig"
+
+source "drivers/mpool/Kconfig"
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index c0cd1b9075e3..e2477288e761 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -188,3 +188,4 @@ obj-$(CONFIG_GNSS)		+= gnss/
 obj-$(CONFIG_INTERCONNECT)	+= interconnect/
 obj-$(CONFIG_COUNTER)		+= counter/
 obj-$(CONFIG_MOST)		+= most/
+obj-$(CONFIG_MPOOL)		+= mpool/
diff --git a/drivers/mpool/Kconfig b/drivers/mpool/Kconfig
new file mode 100644
index 000000000000..33380f497473
--- /dev/null
+++ b/drivers/mpool/Kconfig
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Object Storage Media Pool (mpool) configuration
+#
+
+config MPOOL
+	tristate "Object Storage Media Pool"
+	depends on BLOCK
+	default n
+	help
+	  This module implements a simple transactional object store on top of
+	  block storage devices.
+
+	  Mpool provides a high-performance alternative to file systems or
+	  raw block devices for applications that can benefit from its simple
+	  object storage model and unique features.
+
+	  If you want to use mpool, choose M here: the module will be called mpool.
+
+config MPOOL_ASSERT
+	bool "Object Storage Media Pool assert support"
+	depends on MPOOL
+	default n
+	help
+	  Enables runtime assertion checking for mpool.
+
+	  This is a developer only config. If this config is enabled and any of the
+	  asserts trigger, it results in a panic.
diff --git a/drivers/mpool/Makefile b/drivers/mpool/Makefile
new file mode 100644
index 000000000000..374bbe5bcfa0
--- /dev/null
+++ b/drivers/mpool/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Makefile for Object Storage Media Pool (mpool)
+#
+
+obj-$(CONFIG_MPOOL) += mpool.o
+
+mpool-y             := init.o pd.o mclass.o smap.o omf.o \
+		       upgrade.o sb.o pmd_obj.o mblock.o  \
+		       mlog_utils.o mlog.o mdc.o mpcore.o pmd.o \
+		       mp.o mpctl.o sysfs.o mcache.o reaper.o
-- 
2.17.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

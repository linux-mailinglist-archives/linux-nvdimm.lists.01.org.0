Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8D928BDBB
	for <lists+linux-nvdimm@lfdr.de>; Mon, 12 Oct 2020 18:28:46 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BA6A415B7DE8D;
	Mon, 12 Oct 2020 09:28:25 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.220.72; helo=nam11-co1-obe.outbound.protection.outlook.com; envelope-from=nmeeramohide@micron.com; receiver=<UNKNOWN> 
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0AAF815B409E9
	for <linux-nvdimm@lists.01.org>; Mon, 12 Oct 2020 09:28:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9ApKnE5XO5uoGlSUs/+Z0SF/G83jcdrBynfkgKEwS3JdjlmrecFp88oSuUk+JV/MMeJBzU62fdMd4iVRRi3wl8pzWTMh7BLRUV4IiETDeGyepqTzsYwNyQ8GHYWBuKhbg7ns17A9YFA4RKPY0Xm8xQdX233ufcZGXzfHWRXLEMqPAvWLDi/mPI+jwc/4lgP6DjzwgQY45CD4lXcYQ7amymKVs/OtU1BXBKWsNyRed9XT0OHLZaidnwiyapytXeZQfgMe5umproNGgsVXHNLwOSxbnXTwo1kXJlBYjglo6FeHRuUJYr/5qGw6M/QUOxBMq6sWgexR5AYeFNo6ACJrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvJAvY/CvP/6s4kEJcHseX1otzR4gaJivsMwElMSbPk=;
 b=Yrt2sQKxFO/YBWfSRI/X4VMUQYa4FaMfDZplvXPdHGa++U6IRlk5NyYmiAt3XvsZ4e1qIJ+KN8eWEoGM0FtjsFV1UD4b8GLOr3+3NruHVrPy4rtnVGAoqH0+GymssuNhRTIaHnJz98KeYwP/7oVrakWSQFZNjf+60PXV1MoAulHwNPowIgp9z5N1uW6MHiGJDGUU5vBaAuvfGPGJSoHpl0hgRG1K+2MTEq4xboBCX9sYBKQ4sr+ocYe4fFX5sxAONRzgJGzh8bYKw9+SJuRpYXkKWKAJJnnbFSCsAA5V3iUqNzMZ9JxzaQHVk9S0DMSV7ZoQ023Q1b+jRgfWOve+Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=kvack.org smtp.mailfrom=micron.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvJAvY/CvP/6s4kEJcHseX1otzR4gaJivsMwElMSbPk=;
 b=YtLnocvl2soBpp6BEKDrLffIJ3Sgxk6iZNXbwQxqVvH8d09OJilaZWIoda1BpJ661tadYAQ4x91tNdwfdYgUM5zkY3AsaUcEQfm7zIDd8eoguxxf7AiMy+nsE9u9WS3nwsOQfxk1NMHLv2lksOfDVs0xBQEK1bwxdZVXK6Jwyb4=
Received: from SA9PR10CA0012.namprd10.prod.outlook.com (2603:10b6:806:a7::17)
 by BN8PR08MB5953.namprd08.prod.outlook.com (2603:10b6:408:ad::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Mon, 12 Oct
 2020 16:28:16 +0000
Received: from SN1NAM01FT051.eop-nam01.prod.protection.outlook.com
 (2603:10b6:806:a7:cafe::3c) by SA9PR10CA0012.outlook.office365.com
 (2603:10b6:806:a7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24 via Frontend
 Transport; Mon, 12 Oct 2020 16:28:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com;
Received: from mail.micron.com (137.201.242.130) by
 SN1NAM01FT051.mail.protection.outlook.com (10.152.64.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3455.23 via Frontend Transport; Mon, 12 Oct 2020 16:28:15 +0000
Received: from micron.com (10.114.5.55) by bowex17c.micron.com
 (137.201.21.211) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Oct
 2020 10:28:13 -0600
From: Nabeel M Mohamed <nmeeramohide@micron.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-nvdimm@lists.01.org>
Subject: [PATCH v2 22/22] mpool: add Kconfig and Makefile
Date: Mon, 12 Oct 2020 11:27:36 -0500
Message-ID: <20201012162736.65241-23-nmeeramohide@micron.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20201012162736.65241-1-nmeeramohide@micron.com>
References: <20201012162736.65241-1-nmeeramohide@micron.com>
MIME-Version: 1.0
X-ClientProxiedBy: bowex17a.micron.com (137.201.21.209) To bowex17c.micron.com
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
X-MS-Office365-Filtering-Correlation-Id: 4420ddc8-5662-4c1d-f949-08d86ecbd264
X-MS-TrafficTypeDiagnostic: BN8PR08MB5953:
X-Microsoft-Antispam-PRVS: 
 <BN8PR08MB5953A158B99419B292D99B6EB3070@BN8PR08MB5953.namprd08.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sAM56kahL4ArPNo048xnxLitNO+8T+cELWYrQaidGatd0SP9lkjbTOYFhFxcdpaiCl1BLAbQ8e8VB4gdWVUJUjyBgFDUqxZyNdELSH12EPX01ihBSdvc3UYliMMGvbXRIGhSqgQSjf+A+9cVmj66o1jZ3MU3g1+2or51E4aThguUPZWJ0PcratBe6INUNDJY37XjZNymbemuuu0cb324rg9omD2MFjAdg3HBetwwv2sc6LDyqZCizmf/nFsX2ExIPMWIkgo8OBeYnRW4EmFn65uTdzRUUWvhASWgCHJYWltRyuF0ybi0IMo+XNIvvn8v57SVx973Ta7B/Aehe+z7V8rPjejQYeJlXpTR92Ebku9fgpIsrGzoXy4eGnOiDlZXLEXrYP9RfQFGE3CDZ6LCyFhg16OrZPc5gsvCwWPT9eQypQG+cM7BuOXnwj/CbGurfppjid2DS6/XWU+vf0jQBQ==
X-Forefront-Antispam-Report: 
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(46966005)(6666004)(8936002)(82310400003)(26005)(5660300002)(186003)(356005)(8676002)(7696005)(1076003)(6286002)(478600001)(70206006)(33310700002)(110136005)(2906002)(86362001)(107886003)(47076004)(36756003)(426003)(4326008)(2616005)(7636003)(83380400001)(336012)(54906003)(82740400003)(55016002)(316002)(70586007)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 16:28:15.8405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4420ddc8-5662-4c1d-f949-08d86ecbd264
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM01FT051.eop-nam01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR08MB5953
Message-ID-Hash: 5NSSDYC73YYYSVDRQJ4DDMNKQL5C3R75
X-Message-ID-Hash: 5NSSDYC73YYYSVDRQJ4DDMNKQL5C3R75
X-MailFrom: nmeeramohide@micron.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: smoyer@micron.com, gbecker@micron.com, plabat@micron.com, jgroves@micron.com, Nabeel M Mohamed <nmeeramohide@micron.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5NSSDYC73YYYSVDRQJ4DDMNKQL5C3R75/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

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

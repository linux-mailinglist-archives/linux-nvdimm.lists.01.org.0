Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284D527B240
	for <lists+linux-nvdimm@lfdr.de>; Mon, 28 Sep 2020 18:47:18 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6B77B152EDBE4;
	Mon, 28 Sep 2020 09:47:15 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.100.72; helo=nam04-bn8-obe.outbound.protection.outlook.com; envelope-from=nmeeramohide@micron.com; receiver=<UNKNOWN> 
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2072.outbound.protection.outlook.com [40.107.100.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C4CCA152EDBD0
	for <linux-nvdimm@lists.01.org>; Mon, 28 Sep 2020 09:47:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lveFDhbgzacv2YuLhDqslxhfnrtngwsBNNJXTqnTdZye3i4TyZyt6TcSChX1PgfDv7xzU6BNm+Ft7sfKc/MIWWeWrdBd+mvSQLWehtEToQxHQ6Nk/1M9uOQxwbgTSRxDGu7bHMug3+QFJgZzqm3pD10IHOnqwvRX72RQOXyDS83fSm2Us7KY7h+VqoyNW8qoqDeTKUNQyuWNbYhhTdxKoSMZQv7EnCUk2t9Kxx4kDQALE2Wrl7twBB1x0W28gHLjICTSwI+Er98mh7NatHIYAY3WCo48lvR4nBSAOrcNY4Fgf/7fDbUjl32/Ig8iYhm2wkF5h4SXU8SE+n118Romqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqG6yQBqeR+/Qek+bGpg9KiL6/dI/z45ZbP9c8Ompnk=;
 b=QBKJ4BXLlRGnVCwF3tlPP5WRx8baPt61OWonwrIEIHeLxrFE94OIOv/HHwtltnztvwXTqKG2CP/SX+4NEZUFksTsjELpoEBuGzRA3OjwRn1OyxMY2BgnJKKoNIs6duGIyVSuqHw4ISMucSTnJfLanWSeytqctHXka/O9UA+I4RA50aTk57WQEDrG3mahuqJ4XgEt9RD0gCZdQgD3MIrE46j2n4dQMK6u2fSJONt57yU5AndO4Pcjcipeo95arDhxuBOu8v+9aTNmXQSsqcU1DhcEM578SYOR/EZJd+sQBjQUeOSKdSLilVLJolX6rjXhLjwS4VDBNSux8ih4iMoAJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=kvack.org smtp.mailfrom=micron.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqG6yQBqeR+/Qek+bGpg9KiL6/dI/z45ZbP9c8Ompnk=;
 b=xvHHGhl6/UjT4Ewzlu6faE+Yf4DI3yTYufIWvwu/KunLwqJa2mnev52/1EdXKv+1fCUaXmiw5F5joWkdedhSz1qzSA3uEwxk7MrSljF/kCokme/pIh1Pqxys3pfzpN/U2P+n4V3b1ypy2gOa0EEsbsn2eJsofz3krBPR/gt4cWY=
Received: from BN6PR17CA0028.namprd17.prod.outlook.com (2603:10b6:405:75::17)
 by BL0PR08MB4548.namprd08.prod.outlook.com (2603:10b6:208:5d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25; Mon, 28 Sep
 2020 16:47:09 +0000
Received: from BN3NAM01FT020.eop-nam01.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::72) by BN6PR17CA0028.outlook.office365.com
 (2603:10b6:405:75::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Mon, 28 Sep 2020 16:47:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com;
Received: from mail.micron.com (137.201.242.130) by
 BN3NAM01FT020.mail.protection.outlook.com (10.152.67.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3412.21 via Frontend Transport; Mon, 28 Sep 2020 16:47:09 +0000
Received: from micron.com (10.114.5.55) by bowex17c.micron.com
 (137.201.21.211) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 28 Sep
 2020 10:47:03 -0600
From: <nmeeramohide@micron.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-nvdimm@lists.01.org>
Subject: [PATCH 06/22] mpool: add on-media pack, unpack and upgrade routines
Date: Mon, 28 Sep 2020 11:45:18 -0500
Message-ID: <20200928164534.48203-7-nmeeramohide@micron.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200928164534.48203-1-nmeeramohide@micron.com>
References: <20200928164534.48203-1-nmeeramohide@micron.com>
MIME-Version: 1.0
X-ClientProxiedBy: bowex17d.micron.com (137.201.21.212) To bowex17c.micron.com
 (137.201.21.211)
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24646.005
X-TM-AS-Result: No--9.134500-0.000000-31
X-TM-AS-MatchedID: 155702-158256-700076-704982-701910-704500-703851-700786-7
	03140-704895-700071-701604-703610-303277-703145-703027-703816-705022-701480
	-704962-701809-703017-702395-188019-704318-701342-702299-704477-300015-7032
	13-121336-701105-704673-703967-701475-701275-701912-701073-704983-702754-13
	9549-702162-701918-702688-704804-702226-704401-105640-702224-702907-704959-
	700006-705161-703982-700069-703117-701194-702972-701919-701091-700700-70502
	3-105630-701104-702438-702798-702617-702962-702673-703215-851458-702914-705
	248-703294-702525-701590-188199-701007-700809-702177-702415-702837-705018-7
	04612-700737-701270-702853-703408-700863-703357-148004-148036-42000-42003
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 287cec45-bab3-434c-b84c-08d863ce242f
X-MS-TrafficTypeDiagnostic: BL0PR08MB4548:
X-Microsoft-Antispam-PRVS: 
 <BL0PR08MB4548CD01C2C21FCCEF6CF6A1B3350@BL0PR08MB4548.namprd08.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	68dZqsjkaBlhRXvVyzInHtSTJwboMBQOhflL95e9650uX0qr2hZ2CGQgvYt/T/adK3VDUNw0QgThrovvfUMYH+s91sKtnvLwmua3BkYeCMeAXikoqqmGOCHruA3MviDQvHg6H7zpfxf85tnHL0moVcpUyIv8EvJnHdPCjkV5D6oLHg5lwAu3sjrhdawzRS5IjMehg+CGrBjaGIu7eqsX22wRaypRxfs8N0cQqo5c9CjLc2YBBDyxYYkjhEvVxXm7Ja7gb53iU5rEMjU2ILnjQE72IsgIZH6yioAwdkfMUH0y1HR+pmwL7HpC19hhgFFJMbbec1bvhHh+Up5BdevqV6UUmhqhz952QtGJxKmGa/wgspRMFsJ8Yi2Ouh2GxvgSvW8z7mzcoRTALAF0PqdjqyIrBSwJsJ7fCutKNjlQfFpt0pu8J3Cx4YCjhZqOmJtcwKNL9F0i5TgmOLcEN3U7OnL8wO8+9AexJTC0lmzCV7mkU9nCcJZ5VQQ2b0N21jQ9ch12RB5vekz1NPyxir+F7g==
X-Forefront-Antispam-Report: 
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(46966005)(83380400001)(107886003)(7696005)(356005)(6286002)(8936002)(7636003)(36756003)(55016002)(2906002)(2876002)(70206006)(478600001)(70586007)(316002)(82310400003)(30864003)(5660300002)(47076004)(82740400003)(1076003)(110136005)(8676002)(6666004)(26005)(426003)(2616005)(33310700002)(86362001)(54906003)(186003)(4326008)(336012)(461764006)(2101003)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 16:47:09.2855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 287cec45-bab3-434c-b84c-08d863ce242f
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3NAM01FT020.eop-nam01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR08MB4548
Message-ID-Hash: K6KTPQKALQJ6YX6BXMEERZTRTWPIMTEZ
X-Message-ID-Hash: K6KTPQKALQJ6YX6BXMEERZTRTWPIMTEZ
X-MailFrom: nmeeramohide@micron.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: smoyer@micron.com, gbecker@micron.com, plabat@micron.com, jgroves@micron.com, Nabeel M Mohamed <nmeeramohide@micron.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/K6KTPQKALQJ6YX6BXMEERZTRTWPIMTEZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Nabeel M Mohamed <nmeeramohide@micron.com>

This adds utilities to translate structures to and from their
on-media format. All mpool metadata is stored on media in
little-endian format.

The metadata records are both versioned and contains a record
type. This allows the record format to change over time, new
record types to be added and old record types to be deprecated.

All structs, enums, constants etc., representing on-media format
ends with a postfix "_omf". The functions for serializing
in-memory structures to on-media format are named with prefix
"omf_" and with postfix "_pack_htole". The corresponding
deserializing functions are named with postfix "_unpack_letoh".

The mpool metadata records are upgraded at mpool activation time.
The newer module code reads the metadata records created by an
older mpool version, converts them into the current in-memory
format and then serializes the in-memory format to the current
on-media format.

Co-developed-by: Greg Becker <gbecker@micron.com>
Signed-off-by: Greg Becker <gbecker@micron.com>
Co-developed-by: Pierre Labat <plabat@micron.com>
Signed-off-by: Pierre Labat <plabat@micron.com>
Co-developed-by: John Groves <jgroves@micron.com>
Signed-off-by: John Groves <jgroves@micron.com>
Signed-off-by: Nabeel M Mohamed <nmeeramohide@micron.com>
---
 drivers/mpool/init.c    |    8 +
 drivers/mpool/omf.c     | 1322 +++++++++++++++++++++++++++++++++++++++
 drivers/mpool/upgrade.c |  138 ++++
 3 files changed, 1468 insertions(+)
 create mode 100644 drivers/mpool/omf.c
 create mode 100644 drivers/mpool/upgrade.c

diff --git a/drivers/mpool/init.c b/drivers/mpool/init.c
index 031408815b48..70f907ccc28a 100644
--- a/drivers/mpool/init.c
+++ b/drivers/mpool/init.c
@@ -7,6 +7,7 @@
 
 #include "mpool_printk.h"
 
+#include "omf_if.h"
 #include "pd.h"
 #include "smap.h"
 
@@ -24,6 +25,7 @@ MODULE_PARM_DESC(chunk_size_kb, "Chunk size (in KiB) for device I/O");
 static void mpool_exit_impl(void)
 {
 	smap_exit();
+	omf_exit();
 	pd_exit();
 }
 
@@ -38,6 +40,12 @@ static __init int mpool_init(void)
 		goto errout;
 	}
 
+	rc = omf_init();
+	if (rc) {
+		errmsg = "omf init failed";
+		goto errout;
+	}
+
 	rc = smap_init();
 	if (rc) {
 		errmsg = "smap init failed";
diff --git a/drivers/mpool/omf.c b/drivers/mpool/omf.c
new file mode 100644
index 000000000000..0bb6d239982b
--- /dev/null
+++ b/drivers/mpool/omf.c
@@ -0,0 +1,1322 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+/*
+ * Pool on-drive format (omf) module.
+ *
+ * Defines:
+ * + on-drive format for mpool superblocks
+ * + on-drive formats for mlogs, mblocks, and metadata containers (mdc)
+ * + utility functions for working with these on-drive formats
+ *
+ * All mpool metadata is versioned and stored on media in little-endian format.
+ */
+
+#include <linux/slab.h>
+#include <crypto/hash.h>
+
+#include "assert.h"
+#include "mpool_printk.h"
+
+#include "upgrade.h"
+#include "pmd_obj.h"
+#include "mpcore.h"
+
+#define _STR(x) #x
+#define STR(x)  _STR(x)
+static const char mpool_sbver[] = "MPOOL_SBVER_" STR(OMF_SB_DESC_VER_LAST);
+
+static struct crypto_shash *mpool_tfm;
+
+enum unpack_only {
+	UNPACKONLY    = 0,
+	UNPACKCONVERT = 1,
+};
+
+/*
+ * Forward declarations.
+ */
+static int omf_layout_unpack_letoh_v1(void *out, const char *inbuf);
+static int omf_dparm_unpack_letoh_v1(void *out, const char *inbuf);
+static int omf_mdcrec_mcspare_unpack_letoh_v1(void *out, const char *inbuf);
+static int omf_sb_unpack_letoh_v1(void *out, const char *inbuf);
+static int omf_pmd_layout_unpack_letoh_v1(void *out, const char *inbuf);
+
+/*
+ * layout_descriptor_table: track changes in OMF and in-memory layout descriptor
+ */
+static struct upgrade_history layout_descriptor_table[] = {
+	{
+		sizeof(struct omf_layout_descriptor),
+		omf_layout_unpack_letoh_v1,
+		NULL,
+		OMF_SB_DESC_V1,
+		{ {1, 0, 0, 0} }
+	},
+};
+
+/*
+ * devparm_descriptor_table: track changes in dev parm descriptor
+ */
+static struct upgrade_history devparm_descriptor_table[] = {
+	{
+		sizeof(struct omf_devparm_descriptor),
+		omf_dparm_unpack_letoh_v1,
+		NULL,
+		OMF_SB_DESC_V1,
+		{ {1, 0, 0, 0} }
+	},
+};
+
+/*
+ * mdcrec_data_mcspare_table: track changes in spare % record.
+ */
+static struct upgrade_history mdcrec_data_mcspare_table[]
+	= {
+	{
+		sizeof(struct omf_mdcrec_data),
+		omf_mdcrec_mcspare_unpack_letoh_v1,
+		NULL,
+		OMF_SB_DESC_UNDEF,
+		{ {1, 0, 0, 0} },
+	},
+};
+
+/*
+ * sb_descriptor_table: track changes in mpool superblock descriptor
+ */
+static struct upgrade_history sb_descriptor_table[] = {
+	{
+		sizeof(struct omf_sb_descriptor),
+		omf_sb_unpack_letoh_v1,
+		NULL,
+		OMF_SB_DESC_V1,
+		{ {1, 0, 0, 0} }
+	},
+};
+
+/*
+ * mdcrec_data_ocreate_table: track changes in OCREATE mdc record.
+ */
+static struct upgrade_history mdcrec_data_ocreate_table[]
+	= {
+	{
+		sizeof(struct omf_mdcrec_data),
+		omf_pmd_layout_unpack_letoh_v1,
+		NULL,
+		OMF_SB_DESC_UNDEF,
+		{ {1, 0, 0, 0} }
+	},
+};
+
+
+/*
+ * Generic routines
+ */
+
+/**
+ * omf_find_upgrade_hist() - Find the upgrade history entry for the given sb or mdc version
+ * @uhtab:
+ * @tabsz:   NELEM of upgrade_table
+ * @sbver:   superblock version
+ * @mdcver:  mdc version
+ *
+ * Given a superblock version or a mpool MDC content version, find the
+ * corresponding upgrade history entry which matches the given sb or mdc
+ * version.  That is the entry with the highest version such as
+ * entry version <= the version passed in.
+ *
+ * Note that caller of this routine can pass in either a valid superblock
+ * version or a valid mdc version. If a valid superblock version is passed in,
+ * mdcver need to be set to NULL. If a mdc version is passed in, sbver
+ * need to set to 0.
+ *
+ * For example,
+ * We update a structure "struct abc" three times, which is part of mpool
+ * superblock or MDC. when superblock version is  1, 3 and 5 respectively.
+ * Each time we add an entry in the upgrade table for this structure.
+ * The upgrade history table looks like:
+ *
+ * struct upgrade_history abc_hist[] =
+ * {{sizeof(struct abc_v1), abc_unpack_v1, NULL, OMF_SB_DESC_V1, NULL},
+ *  {sizeof(struct abc_v2), abc_unpack_v2, NULL, OMF_SB_DESC_V3, NULL},
+ *  {sizeof(struct abc_v3), abc_unpack_v3, NULL, OMF_SB_DESC_V5, NULL}}
+ *
+ * if caller needs to find the upgrade history entry matches
+ * sb version 3(OMF_SB_DESC_V3), this routine finds the exact match and
+ * returns &abc_hist[1].
+ *
+ * if caller needs to find the upgrade history entry which matches
+ * sb version 4 (OMF_SB_DESC_V4), since we don't update this structure
+ * in sb version 4, this routine finds the prior entry which matches
+ * the sb version 3, return &abc_hist[1]
+ *
+ */
+static struct upgrade_history *
+omf_find_upgrade_hist(struct upgrade_history *uhtab, size_t tabsz,
+		      enum sb_descriptor_ver_omf sbver, struct omf_mdcver *mdcver)
+{
+	struct upgrade_history *cur = NULL;
+	int beg = 0, end = tabsz, mid;
+
+	while (beg < end) {
+		mid = (beg + end) / 2;
+		cur = &uhtab[mid];
+		if (mdcver) {
+			ASSERT(sbver == 0);
+
+			if (omfu_mdcver_cmp(mdcver, "==", &cur->uh_mdcver))
+				return cur;
+			else if (omfu_mdcver_cmp(mdcver, ">", &cur->uh_mdcver))
+				beg = mid + 1;
+			else
+				end = mid;
+		} else {
+			ASSERT(sbver <= OMF_SB_DESC_VER_LAST);
+
+			if (sbver == cur->uh_sbver)
+				return cur;
+			else if (sbver > cur->uh_sbver)
+				beg = mid + 1;
+			else
+				end = mid;
+		}
+	}
+
+	if (end == 0)
+		return NULL; /* not found */
+
+	return &uhtab[end - 1];
+}
+
+/**
+ * omf_upgrade_convert_only() - Convert sb/mdc from v1 to v2 (v1 <= v2)
+ * @out:   v2 in-memory metadata structure
+ * @in:    v1 in-memory metadata structure
+ * @uhtab: upgrade history table for this structure
+ * @tabsz: NELEM(uhtab)
+ * @sbv1:  superblock version converting from
+ * @sbv2:  superblock version converting to
+ * @mdcv1: mdc version converting from
+ * @mdcv2: mdc version converting to
+ *
+ * Convert a nested metadata structure in mpool superblock or
+ * MDC from v1 to v2 (v1 <= v2)
+ *
+ * Note that callers can pass in either mdc beg/end ver (mdcv1/mdcv2),
+ * or superblock beg/end versions (sbv1/sbv2). Set both mdcv1 and
+ * mdcv2 to NULL, if caller wants to use superblock versions
+ */
+static __maybe_unused int
+omf_upgrade_convert_only(void *out, const void *in, struct upgrade_history *uhtab,
+			 size_t tabsz, enum sb_descriptor_ver_omf sbv1,
+			 enum sb_descriptor_ver_omf sbv2,
+			 struct omf_mdcver *mdcv1, struct omf_mdcver *mdcv2)
+{
+	struct upgrade_history *v1, *v2, *cur;
+	void *new, *old;
+	size_t newsz;
+
+	v1 = omf_find_upgrade_hist(uhtab, tabsz, sbv1, mdcv1);
+	ASSERT(v1);
+
+	v2 = omf_find_upgrade_hist(uhtab, tabsz, sbv2, mdcv2);
+	ASSERT(v2);
+	ASSERT(v1 <= v2);
+
+	if (v1 == v2)
+		/* No need to do conversion */
+		return 0;
+
+	if (v2 == v1 + 1) {
+		/*
+		 * Single step conversion, Don't need to allocate/free
+		 * buffers for intermediate conversion states
+		 */
+		if (v2->uh_conv != NULL)
+			v2->uh_conv(in, out);
+		return 0;
+	}
+
+	/*
+	 * Make a local copy of input buffer, we won't free it
+	 * in the for loop below
+	 */
+	old = kmalloc(v1->uh_size, GFP_KERNEL);
+	if (!old)
+		return -ENOMEM;
+	memcpy(old, in, v1->uh_size);
+
+	new = old;
+	newsz = v1->uh_size;
+
+	for (cur = v1 + 1; cur <= v2; cur++) {
+		if (!cur->uh_conv)
+			continue;
+		new = kzalloc(cur->uh_size, GFP_KERNEL);
+		if (!new) {
+			kfree(old);
+			return -ENOMEM;
+		}
+		newsz = cur->uh_size;
+		cur->uh_conv(old, new);
+		kfree(old);
+		old = new;
+	}
+
+	memcpy(out, new, newsz);
+	kfree(new);
+
+	return 0;
+}
+
+/**
+ * omf_upgrade_unpack_only() - unpack OMF meta data
+ * @out:     output buffer for in-memory structure
+ * @inbuf:   OMF structure
+ * @uhtab:   upgrade history table
+ * @tabsz:   NELEM of uhtab
+ * @sbver:   superblock version
+ * @mdcver: mpool MDC content version
+ */
+static int omf_upgrade_unpack_only(void *out, const char *inbuf, struct upgrade_history *uhtab,
+				   size_t tabsz, enum sb_descriptor_ver_omf sbver,
+				   struct omf_mdcver *mdcver)
+{
+	struct upgrade_history *res;
+
+	res = omf_find_upgrade_hist(uhtab, tabsz, sbver, mdcver);
+
+	return res->uh_unpack(out, inbuf);
+}
+
+/**
+ * omf_unpack_letoh_and_convert() - Unpack OMF meta data and convert it to the latest version.
+ * @out:    in-memory structure
+ * @outsz:  size of in-memory structure
+ * @inbuf:  OMF structure
+ * @uhtab:  upgrade history table
+ * @tabsz:  number of elements in uhtab
+ * @sbver:  superblock version
+ * @mdcver: mdc version. if set to NULL, use sbver to find the corresponding
+ *          nested structure upgrade table
+ */
+static int omf_unpack_letoh_and_convert(void *out, size_t outsz, const char *inbuf,
+					struct upgrade_history *uhtab,
+					size_t tabsz, enum sb_descriptor_ver_omf sbver,
+					struct omf_mdcver *mdcver)
+{
+	struct upgrade_history *cur, *omf;
+	void *old, *new;
+	size_t newsz;
+	int rc;
+
+	omf = omf_find_upgrade_hist(uhtab, tabsz, sbver, mdcver);
+	ASSERT(omf);
+
+	if (omf == &uhtab[tabsz - 1]) {
+		/*
+		 * Current version is the latest version.
+		 * Don't need to do any conversion
+		 */
+		return omf->uh_unpack(out, inbuf);
+	}
+
+	old = kzalloc(omf->uh_size, GFP_KERNEL);
+	if (!old)
+		return -ENOMEM;
+
+	rc = omf->uh_unpack(old, inbuf);
+	if (rc) {
+		kfree(old);
+		return rc;
+	}
+
+	new = old;
+	newsz = omf->uh_size;
+
+	for (cur = omf + 1; cur <= &uhtab[tabsz - 1]; cur++) {
+		if (!cur->uh_conv)
+			continue;
+		new = kzalloc(cur->uh_size, GFP_KERNEL);
+		if (!new) {
+			kfree(old);
+			return -ENOMEM;
+		}
+		newsz = cur->uh_size;
+		cur->uh_conv(old, new);
+		kfree(old);
+		old = new;
+	}
+
+	ASSERT(newsz == outsz);
+
+	memcpy(out, new, newsz);
+	kfree(new);
+
+	return 0;
+}
+
+_Static_assert(MPOOL_UUID_SIZE == OMF_UUID_PACKLEN, "mpool uuid sz != omf uuid packlen");
+_Static_assert(OMF_MPOOL_NAME_LEN == MPOOL_NAMESZ_MAX, "omf mpool name len != mpool namesz max");
+
+/*
+ * devparm_descriptor
+ */
+static void omf_dparm_pack_htole(struct omf_devparm_descriptor *dp, char *outbuf)
+{
+	struct devparm_descriptor_omf *dp_omf;
+
+	dp_omf = (struct devparm_descriptor_omf *)outbuf;
+	omf_set_podp_devid(dp_omf, dp->odp_devid.uuid, MPOOL_UUID_SIZE);
+	omf_set_podp_devsz(dp_omf, dp->odp_devsz);
+	omf_set_podp_zonetot(dp_omf, dp->odp_zonetot);
+	omf_set_podp_zonepg(dp_omf, dp->odp_zonepg);
+	omf_set_podp_mclassp(dp_omf, dp->odp_mclassp);
+	/* Translate pd_devtype into devtype_omf */
+	omf_set_podp_devtype(dp_omf, dp->odp_devtype);
+	omf_set_podp_sectorsz(dp_omf, dp->odp_sectorsz);
+	omf_set_podp_features(dp_omf, dp->odp_features);
+}
+
+/**
+ * omf_dparm_unpack_letoh()- unpack version 1 omf devparm descriptor into
+ *                            in-memory format
+ * @out: in-memory format
+ * @inbuf: omf format
+ */
+static int omf_dparm_unpack_letoh_v1(void *out, const char *inbuf)
+{
+	struct devparm_descriptor_omf *dp_omf;
+	struct omf_devparm_descriptor *dp;
+
+	dp_omf = (struct devparm_descriptor_omf *)inbuf;
+	dp = (struct omf_devparm_descriptor *)out;
+
+	omf_podp_devid(dp_omf, dp->odp_devid.uuid, MPOOL_UUID_SIZE);
+	dp->odp_devsz     = omf_podp_devsz(dp_omf);
+	dp->odp_zonetot    = omf_podp_zonetot(dp_omf);
+	dp->odp_zonepg = omf_podp_zonepg(dp_omf);
+	dp->odp_mclassp   = omf_podp_mclassp(dp_omf);
+	/* Translate devtype_omf into mp_devtype */
+	dp->odp_devtype	  = omf_podp_devtype(dp_omf);
+	dp->odp_sectorsz  = omf_podp_sectorsz(dp_omf);
+	dp->odp_features  = omf_podp_features(dp_omf);
+
+	return 0;
+}
+
+static int omf_dparm_unpack_letoh(struct omf_devparm_descriptor *dp, const char *inbuf,
+				  enum sb_descriptor_ver_omf sbver,
+				  struct omf_mdcver *mdcver,
+				  enum unpack_only unpackonly)
+{
+	const size_t sz = ARRAY_SIZE(layout_descriptor_table);
+	int rc;
+
+	if (unpackonly == UNPACKONLY)
+		rc = omf_upgrade_unpack_only(dp, inbuf, devparm_descriptor_table,
+					     sz, sbver, mdcver);
+	else
+		rc = omf_unpack_letoh_and_convert(dp, sizeof(*dp), inbuf, devparm_descriptor_table,
+						  sz, sbver, mdcver);
+
+	return rc;
+}
+
+
+/*
+ * layout_descriptor
+ */
+static void omf_layout_pack_htole(const struct omf_layout_descriptor *ld, char *outbuf)
+{
+	struct layout_descriptor_omf *ld_omf;
+
+	ld_omf = (struct layout_descriptor_omf *)outbuf;
+	omf_set_pol_zcnt(ld_omf, ld->ol_zcnt);
+	omf_set_pol_zaddr(ld_omf, ld->ol_zaddr);
+}
+
+/**
+ * omf_layout_unpack_letoh_v1() - unpack omf layout descriptor version 1
+ * @out: in-memory layout descriptor
+ * @in: on-media layout descriptor
+ */
+int omf_layout_unpack_letoh_v1(void *out, const char *inbuf)
+{
+	struct omf_layout_descriptor *ld;
+	struct layout_descriptor_omf *ld_omf;
+
+	ld = (struct omf_layout_descriptor *)out;
+	ld_omf = (struct layout_descriptor_omf *)inbuf;
+
+	ld->ol_zcnt = omf_pol_zcnt(ld_omf);
+	ld->ol_zaddr = omf_pol_zaddr(ld_omf);
+
+	return 0;
+}
+
+static int omf_layout_unpack_letoh(struct omf_layout_descriptor *ld, const char *inbuf,
+				   enum sb_descriptor_ver_omf sbver,
+				   struct omf_mdcver *mdcver,
+				   enum unpack_only unpackonly)
+{
+	const size_t sz = ARRAY_SIZE(layout_descriptor_table);
+	int rc;
+
+	if (unpackonly == UNPACKONLY)
+		rc = omf_upgrade_unpack_only(ld, inbuf, layout_descriptor_table,
+					     sz, sbver, mdcver);
+	else
+		rc = omf_unpack_letoh_and_convert(ld, sizeof(*ld), inbuf, layout_descriptor_table,
+						  sz, sbver, mdcver);
+
+	return rc;
+}
+
+/*
+ * pmd_layout
+ */
+static int omf_pmd_layout_pack_htole(const struct mpool_descriptor *mp, u8 rtype,
+				     struct pmd_layout *ecl, char *outbuf)
+{
+	struct mdcrec_data_ocreate_omf *ocre_omf;
+	int data_rec_sz;
+
+	if (rtype != OMF_MDR_OCREATE && rtype != OMF_MDR_OUPDATE) {
+		mp_pr_warn("mpool %s, wrong rec type %u packing layout", mp->pds_name, rtype);
+		return -EINVAL;
+	}
+
+	data_rec_sz = sizeof(*ocre_omf);
+
+	ocre_omf = (struct mdcrec_data_ocreate_omf *)outbuf;
+	omf_set_pdrc_rtype(ocre_omf, rtype);
+	omf_set_pdrc_mclass(ocre_omf, mp->pds_pdv[ecl->eld_ld.ol_pdh].pdi_mclass);
+	omf_set_pdrc_objid(ocre_omf, ecl->eld_objid);
+	omf_set_pdrc_gen(ocre_omf, ecl->eld_gen);
+	omf_set_pdrc_mblen(ocre_omf, ecl->eld_mblen);
+
+	if (objid_type(ecl->eld_objid) == OMF_OBJ_MLOG) {
+		memcpy(ocre_omf->pdrc_uuid, ecl->eld_uuid.uuid, OMF_UUID_PACKLEN);
+		data_rec_sz += OMF_UUID_PACKLEN;
+	}
+
+	omf_layout_pack_htole(&(ecl->eld_ld), (char *)&(ocre_omf->pdrc_ld));
+
+	return data_rec_sz;
+}
+
+/**
+ * omf_pmd_layout_unpack_letoh_v1() - Unpack little-endian mdc obj record and optional obj layout
+ * @out:
+ * @inbuf:
+ *
+ * For version 1 of OMF_MDR_OCREATE record (struct layout_descriptor_omf)
+ *
+ * Return:
+ *   0 if successful
+ *   -EINVAL if invalid record type or format
+ *   -ENOMEM if cannot alloc memory for metadata conversion
+ */
+static int omf_pmd_layout_unpack_letoh_v1(void *out, const char *inbuf)
+{
+	struct mdcrec_data_ocreate_omf *ocre_omf;
+	struct omf_mdcrec_data *cdr = out;
+	int rc;
+
+	ocre_omf = (struct mdcrec_data_ocreate_omf *)inbuf;
+
+	cdr->omd_rtype = omf_pdrc_rtype(ocre_omf);
+	if (cdr->omd_rtype != OMF_MDR_OCREATE && cdr->omd_rtype == OMF_MDR_OUPDATE) {
+		rc = -EINVAL;
+		mp_pr_err("Unpacking layout failed, wrong record type %d", rc, cdr->omd_rtype);
+		return rc;
+	}
+
+	cdr->u.obj.omd_mclass = omf_pdrc_mclass(ocre_omf);
+	cdr->u.obj.omd_objid = omf_pdrc_objid(ocre_omf);
+	cdr->u.obj.omd_gen   = omf_pdrc_gen(ocre_omf);
+	cdr->u.obj.omd_mblen = omf_pdrc_mblen(ocre_omf);
+
+	if (objid_type(cdr->u.obj.omd_objid) == OMF_OBJ_MLOG)
+		memcpy(cdr->u.obj.omd_uuid.uuid, ocre_omf->pdrc_uuid, OMF_UUID_PACKLEN);
+
+	rc = omf_layout_unpack_letoh(&cdr->u.obj.omd_old, (char *)&(ocre_omf->pdrc_ld),
+				     OMF_SB_DESC_V1, NULL, UNPACKONLY);
+
+	return rc;
+}
+
+
+/**
+ * omf_pmd_layout_unpack_letoh() - Unpack little-endian mdc obj record and optional obj layout
+ * @mp:
+ * @mdcver: version of the mpool MDC content being unpacked.
+ * @cdr: output
+ * @inbuf:
+ *
+ * Allocate object layout.
+ * For version 1 of OMF_MDR_OCREATE record (strut layout_descriptor_omf)
+ *
+ * Return:
+ *   0 if successful
+ *   -EINVAL if invalid record type or format
+ *   -ENOMEM if cannot alloc memory to return an object layout
+ *   -ENOENT if cannot convert a devid to a device handle (pdh)
+ */
+static int omf_pmd_layout_unpack_letoh(struct mpool_descriptor *mp, struct omf_mdcver *mdcver,
+				       struct omf_mdcrec_data *cdr, const char *inbuf)
+{
+	struct pmd_layout *ecl = NULL;
+	int rc, i;
+
+	rc = omf_unpack_letoh_and_convert(cdr, sizeof(*cdr), inbuf, mdcrec_data_ocreate_table,
+					  ARRAY_SIZE(mdcrec_data_ocreate_table),
+					  OMF_SB_DESC_UNDEF, mdcver);
+	if (rc) {
+		char buf[MAX_MDCVERSTR];
+
+		omfu_mdcver_to_str(mdcver, buf, sizeof(buf));
+		mp_pr_err("mpool %s, unpacking layout failed for mdc content version %s",
+			  rc, mp->pds_name, buf);
+		return rc;
+	}
+
+#ifdef COMP_PMD_ENABLED
+	ecl = pmd_layout_alloc(&cdr->u.obj.omd_uuid, cdr->u.obj.omd_objid, cdr->u.obj.omd_gen,
+			       cdr->u.obj.omd_mblen, cdr->u.obj.omd_old.ol_zcnt);
+#endif
+	if (!ecl) {
+		rc = -ENOMEM;
+		mp_pr_err("mpool %s, unpacking layout failed, could not allocate layout structure",
+			  rc, mp->pds_name);
+		return rc;
+	}
+
+	ecl->eld_ld.ol_zaddr = cdr->u.obj.omd_old.ol_zaddr;
+
+	for (i = 0; i < mp->pds_pdvcnt; i++) {
+		if (mp->pds_pdv[i].pdi_mclass == cdr->u.obj.omd_mclass) {
+			ecl->eld_ld.ol_pdh = i;
+			break;
+		}
+	}
+
+	if (i >= mp->pds_pdvcnt) {
+		pmd_obj_put(ecl);
+
+		rc = -ENOENT;
+		mp_pr_err("mpool %s, unpacking layout failed, mclass %u not in mpool",
+			  rc, mp->pds_name, cdr->u.obj.omd_mclass);
+		return rc;
+	}
+
+	cdr->u.obj.omd_layout = ecl;
+
+	return rc;
+}
+
+
+/*
+ * sb_descriptor
+ */
+
+/**
+ * omf_cksum_crc32c_le() - compute checksum
+ * @dbuf: data buf
+ * @dlen: data length
+ * @obuf: output buf
+ *
+ * Compute 4-byte checksum of type CRC32C for data buffer dbuf with length dlen
+ * and store in obuf little-endian; CRC32C is the only crypto algorithm we
+ * currently support.
+ *
+ * Return: 0 if successful, -EINVAL otherwise...
+ */
+static int omf_cksum_crc32c_le(const char *dbuf, u64 dlen, u8 *obuf)
+{
+	struct shash_desc *desc;
+	size_t descsz;
+	int rc;
+
+	memset(obuf, 0, 4);
+
+	descsz = sizeof(*desc) + crypto_shash_descsize(mpool_tfm);
+	desc = kzalloc(descsz, GFP_KERNEL);
+	if (!desc)
+		return -ENOMEM;
+	desc->tfm = mpool_tfm;
+
+	rc = crypto_shash_digest(desc, (u8 *)dbuf, dlen, obuf);
+
+	kfree(desc);
+
+	return rc;
+}
+
+struct omf_mdcver *omf_sbver_to_mdcver(enum sb_descriptor_ver_omf sbver)
+{
+	struct upgrade_history *uhtab;
+
+	uhtab = omf_find_upgrade_hist(sb_descriptor_table, ARRAY_SIZE(sb_descriptor_table),
+				      sbver, NULL);
+	if (uhtab) {
+		ASSERT(uhtab->uh_sbver == sbver);
+		return &uhtab->uh_mdcver;
+	}
+
+	return NULL;
+}
+
+int omf_sb_pack_htole(struct omf_sb_descriptor *sb, char *outbuf)
+{
+	struct sb_descriptor_omf *sb_omf;
+	u8 cksum[4];
+	int rc;
+
+	if (sb->osb_vers != OMF_SB_DESC_VER_LAST)
+		return -EINVAL; /* Not a valid header version */
+
+	sb_omf = (struct sb_descriptor_omf *)outbuf;
+
+	/* Pack drive-specific info */
+	omf_set_psb_magic(sb_omf, sb->osb_magic);
+	omf_set_psb_name(sb_omf, sb->osb_name, MPOOL_NAMESZ_MAX);
+	omf_set_psb_poolid(sb_omf, sb->osb_poolid.uuid, MPOOL_UUID_SIZE);
+	omf_set_psb_vers(sb_omf, sb->osb_vers);
+	omf_set_psb_gen(sb_omf, sb->osb_gen);
+
+	omf_dparm_pack_htole(&(sb->osb_parm), (char *)&(sb_omf->psb_parm));
+
+	omf_set_psb_mdc01gen(sb_omf, sb->osb_mdc01gen);
+	omf_set_psb_mdc01uuid(sb_omf, sb->osb_mdc01uuid.uuid, MPOOL_UUID_SIZE);
+	omf_layout_pack_htole(&(sb->osb_mdc01desc), (char *)&(sb_omf->psb_mdc01desc));
+	omf_set_psb_mdc01devid(sb_omf, sb->osb_mdc01devid.uuid, MPOOL_UUID_SIZE);
+
+	omf_set_psb_mdc02gen(sb_omf, sb->osb_mdc02gen);
+	omf_set_psb_mdc02uuid(sb_omf, sb->osb_mdc02uuid.uuid, MPOOL_UUID_SIZE);
+	omf_layout_pack_htole(&(sb->osb_mdc02desc), (char *)&(sb_omf->psb_mdc02desc));
+	omf_set_psb_mdc02devid(sb_omf, sb->osb_mdc02devid.uuid, MPOOL_UUID_SIZE);
+
+	outbuf = (char *)&sb_omf->psb_mdc0dev;
+	omf_dparm_pack_htole(&sb->osb_mdc0dev, outbuf);
+
+	/* Add CKSUM1 */
+	rc = omf_cksum_crc32c_le((char *)sb_omf, offsetof(struct sb_descriptor_omf, psb_cksum1),
+				 cksum);
+	if (rc)
+		return -EINVAL;
+
+	omf_set_psb_cksum1(sb_omf, cksum, 4);
+
+	/* Add CKSUM2 */
+	rc = omf_cksum_crc32c_le((char *)&sb_omf->psb_parm, sizeof(sb_omf->psb_parm), cksum);
+	if (rc)
+		return -EINVAL;
+
+	omf_set_psb_cksum2(sb_omf, cksum, 4);
+
+	return 0;
+}
+
+/**
+ * omf_sb_unpack_letoh_v1()- unpack version 1 omf sb descriptor into in-memory format
+ * @out: in-memory format
+ * @inbuf: omf format
+ */
+int omf_sb_unpack_letoh_v1(void *out, const char *inbuf)
+{
+	struct sb_descriptor_omf *sb_omf;
+	struct omf_sb_descriptor *sb;
+	u8 cksum[4], omf_cksum[4];
+	int rc;
+
+	sb_omf = (struct sb_descriptor_omf *)inbuf;
+	sb = (struct omf_sb_descriptor *)out;
+
+	/* Verify CKSUM2 */
+	rc = omf_cksum_crc32c_le((char *) &(sb_omf->psb_parm), sizeof(sb_omf->psb_parm), cksum);
+	omf_psb_cksum2(sb_omf, omf_cksum, 4);
+
+	if (rc || memcmp(cksum, omf_cksum, 4))
+		return -EINVAL;
+
+
+	sb->osb_magic = omf_psb_magic(sb_omf);
+
+	omf_psb_name(sb_omf, sb->osb_name, MPOOL_NAMESZ_MAX);
+
+	sb->osb_vers = omf_psb_vers(sb_omf);
+	ASSERT(sb->osb_vers == OMF_SB_DESC_V1);
+
+	omf_psb_poolid(sb_omf, sb->osb_poolid.uuid, MPOOL_UUID_SIZE);
+
+	sb->osb_gen = omf_psb_gen(sb_omf);
+	omf_dparm_unpack_letoh(&(sb->osb_parm), (char *)&(sb_omf->psb_parm),
+			       OMF_SB_DESC_V1, NULL, UNPACKONLY);
+
+	sb->osb_mdc01gen  = omf_psb_mdc01gen(sb_omf);
+	omf_psb_mdc01uuid(sb_omf, sb->osb_mdc01uuid.uuid, MPOOL_UUID_SIZE);
+	omf_layout_unpack_letoh(&(sb->osb_mdc01desc), (char *)&(sb_omf->psb_mdc01desc),
+				OMF_SB_DESC_V1, NULL, UNPACKONLY);
+	omf_psb_mdc01devid(sb_omf, sb->osb_mdc01devid.uuid, MPOOL_UUID_SIZE);
+
+	sb->osb_mdc02gen = omf_psb_mdc02gen(sb_omf);
+	omf_psb_mdc02uuid(sb_omf, sb->osb_mdc02uuid.uuid, MPOOL_UUID_SIZE);
+	omf_layout_unpack_letoh(&(sb->osb_mdc02desc), (char *)&(sb_omf->psb_mdc02desc),
+				OMF_SB_DESC_V1, NULL, UNPACKONLY);
+	omf_psb_mdc02devid(sb_omf, sb->osb_mdc02devid.uuid, MPOOL_UUID_SIZE);
+
+	inbuf = (char *)&sb_omf->psb_mdc0dev;
+	omf_dparm_unpack_letoh(&sb->osb_mdc0dev, inbuf, OMF_SB_DESC_V1, NULL, UNPACKONLY);
+
+	return 0;
+}
+
+int omf_sb_unpack_letoh(struct omf_sb_descriptor *sb, const char *inbuf, u16 *omf_ver)
+{
+	struct sb_descriptor_omf *sb_omf;
+	u8 cksum[4], omf_cksum[4];
+	u64 magic = 0;
+	int rc;
+
+	sb_omf = (struct sb_descriptor_omf *)inbuf;
+
+	magic = omf_psb_magic(sb_omf);
+
+	*omf_ver = OMF_SB_DESC_UNDEF;
+
+	if (magic != OMF_SB_MAGIC)
+		return -EBADF;
+
+	/* Verify CKSUM1 */
+	rc = omf_cksum_crc32c_le(inbuf, offsetof(struct sb_descriptor_omf, psb_cksum1), cksum);
+	omf_psb_cksum1(sb_omf, omf_cksum, 4);
+	if (rc || memcmp(cksum, omf_cksum, 4))
+		return -EINVAL;
+
+	*omf_ver = omf_psb_vers(sb_omf);
+
+	if (*omf_ver > OMF_SB_DESC_VER_LAST) {
+		rc = -EPROTONOSUPPORT;
+		mp_pr_err("Unsupported sb version %d", rc, *omf_ver);
+		return rc;
+	}
+
+	rc = omf_unpack_letoh_and_convert(sb, sizeof(*sb), inbuf, sb_descriptor_table,
+					  ARRAY_SIZE(sb_descriptor_table), *omf_ver, NULL);
+	if (rc)
+		mp_pr_err("Unpacking superblock failed for version %u", rc, *omf_ver);
+
+	return rc;
+}
+
+bool omf_sb_has_magic_le(const char *inbuf)
+{
+	struct sb_descriptor_omf *sb_omf;
+	u64 magic;
+
+	sb_omf = (struct sb_descriptor_omf *)inbuf;
+	magic  = omf_psb_magic(sb_omf);
+
+	return magic == OMF_SB_MAGIC;
+}
+
+
+/*
+ * mdcrec_objcmn
+ */
+
+/**
+ * omf_mdcrec_objcmn_pack_htole() - pack mdc obj record
+ * @mp:
+ * @cdr:
+ * @outbuf:
+ *
+ * Pack mdc obj record and optional obj layout into outbuf little-endian.
+ *
+ * Return: bytes packed if successful, -EINVAL otherwise
+ */
+static u64 omf_mdcrec_objcmn_pack_htole(struct mpool_descriptor *mp,
+					struct omf_mdcrec_data *cdr, char *outbuf)
+{
+	struct pmd_layout *layout = cdr->u.obj.omd_layout;
+	struct mdcrec_data_odelete_omf *odel_omf;
+	struct mdcrec_data_oerase_omf *oera_omf;
+	s64 bytes = 0;
+
+	switch (cdr->omd_rtype) {
+	case OMF_MDR_ODELETE:
+	case OMF_MDR_OIDCKPT:
+		odel_omf = (struct mdcrec_data_odelete_omf *)outbuf;
+		omf_set_pdro_rtype(odel_omf, cdr->omd_rtype);
+		omf_set_pdro_objid(odel_omf, cdr->u.obj.omd_objid);
+		return sizeof(*odel_omf);
+
+	case OMF_MDR_OERASE:
+		oera_omf = (struct mdcrec_data_oerase_omf *)outbuf;
+		omf_set_pdrt_rtype(oera_omf, cdr->omd_rtype);
+		omf_set_pdrt_objid(oera_omf, cdr->u.obj.omd_objid);
+		omf_set_pdrt_gen(oera_omf, cdr->u.obj.omd_gen);
+		return sizeof(*oera_omf);
+
+	default:
+		break;
+	}
+
+	if (cdr->omd_rtype != OMF_MDR_OCREATE && cdr->omd_rtype != OMF_MDR_OUPDATE) {
+		mp_pr_warn("mpool %s, packing object, unknown rec type %d",
+			   mp->pds_name, cdr->omd_rtype);
+		return -EINVAL;
+	}
+
+	/* OCREATE or OUPDATE: pack object in provided layout descriptor */
+	if (!layout) {
+		mp_pr_warn("mpool %s, invalid layout", mp->pds_name);
+		return -EINVAL;
+	}
+
+	bytes = omf_pmd_layout_pack_htole(mp, cdr->omd_rtype, layout, outbuf);
+	if (bytes < 0)
+		return -EINVAL;
+
+	return bytes;
+}
+
+/**
+ * omf_mdcrec_objcmn_unpack_letoh() - Unpack little-endian mdc record and optional obj layout
+ * @mp:
+ * @mdcver:
+ * @cdr:
+ * @inbuf:
+ *
+ * Return:
+ *   0 if successful
+ *   -EINVAL if invalid record type or format
+ *   -ENOMEM if cannot alloc memory to return an object layout
+ *   -ENOENT if cannot convert a devid to a device handle (pdh)
+ */
+static int omf_mdcrec_objcmn_unpack_letoh(struct mpool_descriptor *mp, struct omf_mdcver *mdcver,
+					  struct omf_mdcrec_data *cdr, const char *inbuf)
+{
+	struct mdcrec_data_odelete_omf *odel_omf;
+	struct mdcrec_data_oerase_omf *oera_omf;
+	enum mdcrec_type_omf rtype;
+	int rc = 0;
+
+	/*
+	 * The data record type is always the first field of all the
+	 * data records.
+	 */
+	rtype = omf_pdro_rtype((struct mdcrec_data_odelete_omf *)inbuf);
+
+	switch (rtype) {
+	case OMF_MDR_ODELETE:
+	case OMF_MDR_OIDCKPT:
+		odel_omf = (struct mdcrec_data_odelete_omf *)inbuf;
+		cdr->omd_rtype = omf_pdro_rtype(odel_omf);
+		cdr->u.obj.omd_objid = omf_pdro_objid(odel_omf);
+		break;
+
+	case OMF_MDR_OERASE:
+		oera_omf = (struct mdcrec_data_oerase_omf *)inbuf;
+		cdr->omd_rtype = omf_pdrt_rtype(oera_omf);
+		cdr->u.obj.omd_objid = omf_pdrt_objid(oera_omf);
+		cdr->u.obj.omd_gen = omf_pdrt_gen(oera_omf);
+		break;
+
+	case OMF_MDR_OCREATE:
+	case OMF_MDR_OUPDATE:
+		rc = omf_pmd_layout_unpack_letoh(mp, mdcver, cdr, inbuf);
+		break;
+
+	default:
+		mp_pr_warn("mpool %s, invalid rtype %d", mp->pds_name, rtype);
+		return -EINVAL;
+	}
+
+	return rc;
+}
+
+
+/*
+ * mdcrec_mcconfig
+ */
+
+/**
+ * omf_mdcrec_mcconfig_pack_htole() - Pack mdc mclass config record into outbuf little-endian.
+ * @cdr:
+ * @outbuf:
+ *
+ * Return: bytes packed.
+ */
+static u64 omf_mdcrec_mcconfig_pack_htole(struct omf_mdcrec_data *cdr, char *outbuf)
+{
+	struct mdcrec_data_mcconfig_omf *mc_omf;
+
+	mc_omf = (struct mdcrec_data_mcconfig_omf *)outbuf;
+	omf_set_pdrs_rtype(mc_omf, cdr->omd_rtype);
+	omf_dparm_pack_htole(&(cdr->u.dev.omd_parm), (char *)&(mc_omf->pdrs_parm));
+
+	return sizeof(*mc_omf);
+}
+
+/**
+ * omf_mdcrec_mcconfig_unpack_letoh() - Unpack little-endian mdc mcconfig record from inbuf.
+ * @cdr:
+ * @inbuf:
+ */
+static int omf_mdcrec_mcconfig_unpack_letoh(struct omf_mdcver *mdcver, struct omf_mdcrec_data *cdr,
+					    const char *inbuf)
+{
+	struct mdcrec_data_mcconfig_omf *mc_omf;
+
+	mc_omf = (struct mdcrec_data_mcconfig_omf *)inbuf;
+
+	cdr->omd_rtype = omf_pdrs_rtype(mc_omf);
+
+	return omf_dparm_unpack_letoh(&(cdr->u.dev.omd_parm), (char *)&(mc_omf->pdrs_parm),
+				      OMF_SB_DESC_UNDEF, mdcver, UNPACKCONVERT);
+}
+
+
+/*
+ * mdcrec_version
+ */
+
+/**
+ * omf_mdcver_pack_htole() - Pack mdc content version record into outbuf little-endian.
+ * @cdr:
+ * @outbuf:
+ *
+ * Return: bytes packed.
+ */
+static u64 omf_mdcver_pack_htole(struct omf_mdcrec_data *cdr, char *outbuf)
+{
+	struct mdcver_omf *pv_omf = (struct mdcver_omf *)outbuf;
+
+	omf_set_pv_rtype(pv_omf, cdr->omd_rtype);
+	omf_set_pv_mdcv_major(pv_omf, cdr->u.omd_version.mdcv_major);
+	omf_set_pv_mdcv_minor(pv_omf, cdr->u.omd_version.mdcv_minor);
+	omf_set_pv_mdcv_patch(pv_omf, cdr->u.omd_version.mdcv_patch);
+	omf_set_pv_mdcv_dev(pv_omf, cdr->u.omd_version.mdcv_dev);
+
+	return sizeof(*pv_omf);
+}
+
+void omf_mdcver_unpack_letoh(struct omf_mdcrec_data *cdr, const char *inbuf)
+{
+	struct mdcver_omf *pv_omf = (struct mdcver_omf *)inbuf;
+
+	cdr->omd_rtype = omf_pv_rtype(pv_omf);
+	cdr->u.omd_version.mdcv_major = omf_pv_mdcv_major(pv_omf);
+	cdr->u.omd_version.mdcv_minor = omf_pv_mdcv_minor(pv_omf);
+	cdr->u.omd_version.mdcv_patch = omf_pv_mdcv_patch(pv_omf);
+	cdr->u.omd_version.mdcv_dev   = omf_pv_mdcv_dev(pv_omf);
+}
+
+
+/*
+ * mdcrec_mcspare
+ */
+static u64 omf_mdcrec_mcspare_pack_htole(struct omf_mdcrec_data *cdr, char *outbuf)
+{
+	struct mdcrec_data_mcspare_omf *mcs_omf;
+
+	mcs_omf = (struct mdcrec_data_mcspare_omf *)outbuf;
+	omf_set_pdra_rtype(mcs_omf, cdr->omd_rtype);
+	omf_set_pdra_mclassp(mcs_omf, cdr->u.mcs.omd_mclassp);
+	omf_set_pdra_spzone(mcs_omf, cdr->u.mcs.omd_spzone);
+
+	return sizeof(*mcs_omf);
+}
+
+/**
+ * omf_mdcrec_mcspare_unpack_letoh_v1() - Unpack little-endian mdc media class spare record
+ * @cdr:
+ * @inbuf:
+ */
+static int omf_mdcrec_mcspare_unpack_letoh_v1(void *out, const char *inbuf)
+{
+	struct mdcrec_data_mcspare_omf *mcs_omf;
+	struct omf_mdcrec_data *cdr = out;
+
+	mcs_omf = (struct mdcrec_data_mcspare_omf *)inbuf;
+
+	cdr->omd_rtype = omf_pdra_rtype(mcs_omf);
+	cdr->u.mcs.omd_mclassp = omf_pdra_mclassp(mcs_omf);
+	cdr->u.mcs.omd_spzone = omf_pdra_spzone(mcs_omf);
+
+	return 0;
+}
+
+/**
+ * omf_mdcrec_mcspare_unpack_letoh() - Unpack little-endian mdc media class spare record
+ * @cdr:
+ * @inbuf:
+ */
+static int omf_mdcrec_mcspare_unpack_letoh(struct omf_mdcrec_data *cdr, const char *inbuf,
+					   enum sb_descriptor_ver_omf sbver,
+					   struct omf_mdcver *mdcver)
+{
+	return omf_unpack_letoh_and_convert(cdr, sizeof(*cdr), inbuf, mdcrec_data_mcspare_table,
+					    ARRAY_SIZE(mdcrec_data_mcspare_table), sbver, mdcver);
+}
+
+
+/*
+ * mdcrec_mpconfig
+ */
+
+/**
+ * omf_mdcrec_mpconfig_pack_htole() - Pack an mpool config record
+ * @cdr:
+ * @outbuf:
+ *
+ * Return: bytes packed.
+ */
+static u64 omf_mdcrec_mpconfig_pack_htole(struct omf_mdcrec_data *cdr, char *outbuf)
+{
+	struct mdcrec_data_mpconfig_omf *cfg_omf;
+	struct mpool_config *cfg;
+
+	cfg = &cdr->u.omd_cfg;
+
+	cfg_omf = (struct mdcrec_data_mpconfig_omf *)outbuf;
+	omf_set_pdmc_rtype(cfg_omf, cdr->omd_rtype);
+	omf_set_pdmc_oid1(cfg_omf, cfg->mc_oid1);
+	omf_set_pdmc_oid2(cfg_omf, cfg->mc_oid2);
+	omf_set_pdmc_uid(cfg_omf, cfg->mc_uid);
+	omf_set_pdmc_gid(cfg_omf, cfg->mc_gid);
+	omf_set_pdmc_mode(cfg_omf, cfg->mc_mode);
+	omf_set_pdmc_rsvd0(cfg_omf, cfg->mc_rsvd0);
+	omf_set_pdmc_captgt(cfg_omf, cfg->mc_captgt);
+	omf_set_pdmc_ra_pages_max(cfg_omf, cfg->mc_ra_pages_max);
+	omf_set_pdmc_vma_size_max(cfg_omf, cfg->mc_vma_size_max);
+	omf_set_pdmc_rsvd1(cfg_omf, cfg->mc_rsvd1);
+	omf_set_pdmc_rsvd2(cfg_omf, cfg->mc_rsvd2);
+	omf_set_pdmc_rsvd3(cfg_omf, cfg->mc_rsvd3);
+	omf_set_pdmc_rsvd4(cfg_omf, cfg->mc_rsvd4);
+	omf_set_pdmc_utype(cfg_omf, &cfg->mc_utype, sizeof(cfg->mc_utype));
+	omf_set_pdmc_label(cfg_omf, cfg->mc_label, sizeof(cfg->mc_label));
+
+	return sizeof(*cfg_omf);
+}
+
+/**
+ * omf_mdcrec_mpconfig_unpack_letoh() - Unpack an mpool config record
+ * @cdr:
+ * @inbuf:
+ *
+ * Return: bytes packed.
+ */
+static void omf_mdcrec_mpconfig_unpack_letoh(struct omf_mdcrec_data *cdr, const char *inbuf)
+{
+	struct mdcrec_data_mpconfig_omf *cfg_omf;
+	struct mpool_config *cfg;
+
+	cfg = &cdr->u.omd_cfg;
+
+	cfg_omf = (struct mdcrec_data_mpconfig_omf *)inbuf;
+	cdr->omd_rtype = omf_pdmc_rtype(cfg_omf);
+	cfg->mc_oid1 = omf_pdmc_oid1(cfg_omf);
+	cfg->mc_oid2 = omf_pdmc_oid2(cfg_omf);
+	cfg->mc_uid = omf_pdmc_uid(cfg_omf);
+	cfg->mc_gid = omf_pdmc_gid(cfg_omf);
+	cfg->mc_mode = omf_pdmc_mode(cfg_omf);
+	cfg->mc_rsvd0 = omf_pdmc_rsvd0(cfg_omf);
+	cfg->mc_captgt = omf_pdmc_captgt(cfg_omf);
+	cfg->mc_ra_pages_max = omf_pdmc_ra_pages_max(cfg_omf);
+	cfg->mc_vma_size_max = omf_pdmc_vma_size_max(cfg_omf);
+	cfg->mc_rsvd1 = omf_pdmc_rsvd1(cfg_omf);
+	cfg->mc_rsvd2 = omf_pdmc_rsvd2(cfg_omf);
+	cfg->mc_rsvd3 = omf_pdmc_rsvd3(cfg_omf);
+	cfg->mc_rsvd4 = omf_pdmc_rsvd4(cfg_omf);
+	omf_pdmc_utype(cfg_omf, &cfg->mc_utype, sizeof(cfg->mc_utype));
+	omf_pdmc_label(cfg_omf, cfg->mc_label, sizeof(cfg->mc_label));
+}
+
+/**
+ * mdcrec_type_objcmn() - Determine if the data record type corresponds to an object.
+ * @rtype: record type
+ *
+ * Return: true if the type is of an object data record.
+ */
+static bool mdcrec_type_objcmn(enum mdcrec_type_omf rtype)
+{
+	return (rtype == OMF_MDR_OCREATE || rtype == OMF_MDR_OUPDATE || rtype == OMF_MDR_ODELETE ||
+		rtype == OMF_MDR_OIDCKPT || rtype == OMF_MDR_OERASE);
+}
+
+int omf_mdcrec_isobj_le(const char *inbuf)
+{
+	const u8 rtype = inbuf[0]; /* rtype is byte so no endian conversion */
+
+	return mdcrec_type_objcmn(rtype);
+}
+
+
+/*
+ * mdcrec
+ */
+int omf_mdcrec_pack_htole(struct mpool_descriptor *mp, struct omf_mdcrec_data *cdr, char *outbuf)
+{
+	u8 rtype = (char)cdr->omd_rtype;
+
+	if (mdcrec_type_objcmn(rtype))
+		return omf_mdcrec_objcmn_pack_htole(mp, cdr, outbuf);
+	else if (rtype == OMF_MDR_VERSION)
+		return omf_mdcver_pack_htole(cdr, outbuf);
+	else if (rtype == OMF_MDR_MCCONFIG)
+		return omf_mdcrec_mcconfig_pack_htole(cdr, outbuf);
+	else if (rtype == OMF_MDR_MCSPARE)
+		return omf_mdcrec_mcspare_pack_htole(cdr, outbuf);
+	else if (rtype == OMF_MDR_MPCONFIG)
+		return omf_mdcrec_mpconfig_pack_htole(cdr, outbuf);
+
+	mp_pr_warn("mpool %s, invalid record type %u in mdc log", mp->pds_name, rtype);
+
+	return -EINVAL;
+}
+
+int omf_mdcrec_unpack_letoh(struct omf_mdcver *mdcver, struct mpool_descriptor *mp,
+			    struct omf_mdcrec_data *cdr, const char *inbuf)
+{
+	u8 rtype = (u8)*inbuf;
+
+	/* rtype is byte so no endian conversion */
+
+	if (mdcrec_type_objcmn(rtype))
+		return omf_mdcrec_objcmn_unpack_letoh(mp, mdcver, cdr, inbuf);
+	else if (rtype == OMF_MDR_VERSION)
+		omf_mdcver_unpack_letoh(cdr, inbuf);
+	else if (rtype == OMF_MDR_MCCONFIG)
+		omf_mdcrec_mcconfig_unpack_letoh(mdcver, cdr, inbuf);
+	else if (rtype == OMF_MDR_MCSPARE)
+		omf_mdcrec_mcspare_unpack_letoh(cdr, inbuf, OMF_SB_DESC_UNDEF, mdcver);
+	else if (rtype == OMF_MDR_MPCONFIG)
+		omf_mdcrec_mpconfig_unpack_letoh(cdr, inbuf);
+	else {
+		mp_pr_warn("mpool %s, unknown record type %u in mdc log", mp->pds_name, rtype);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+u8 omf_mdcrec_unpack_type_letoh(const char *inbuf)
+{
+	/* rtype is byte so no endian conversion */
+	return (u8)*inbuf;
+}
+
+
+/*
+ * logblock_header
+ */
+
+int omf_logblock_header_pack_htole(struct omf_logblock_header *lbh, char *outbuf)
+{
+	struct logblock_header_omf *lbh_omf;
+
+	lbh_omf = (struct logblock_header_omf *)outbuf;
+
+	if (lbh->olh_vers != OMF_LOGBLOCK_VERS)
+		return -EINVAL;
+
+	omf_set_polh_vers(lbh_omf, lbh->olh_vers);
+	omf_set_polh_magic(lbh_omf, lbh->olh_magic.uuid, MPOOL_UUID_SIZE);
+	omf_set_polh_gen(lbh_omf, lbh->olh_gen);
+	omf_set_polh_pfsetid(lbh_omf, lbh->olh_pfsetid);
+	omf_set_polh_cfsetid(lbh_omf, lbh->olh_cfsetid);
+
+	return 0;
+}
+
+int omf_logblock_header_unpack_letoh(struct omf_logblock_header *lbh, const char *inbuf)
+{
+	struct logblock_header_omf *lbh_omf;
+
+	lbh_omf = (struct logblock_header_omf *)inbuf;
+
+	lbh->olh_vers    = omf_polh_vers(lbh_omf);
+	omf_polh_magic(lbh_omf, lbh->olh_magic.uuid, MPOOL_UUID_SIZE);
+	lbh->olh_gen     = omf_polh_gen(lbh_omf);
+	lbh->olh_pfsetid = omf_polh_pfsetid(lbh_omf);
+	lbh->olh_cfsetid = omf_polh_cfsetid(lbh_omf);
+
+	return 0;
+}
+
+int omf_logblock_header_len_le(char *lbuf)
+{
+	struct logblock_header_omf *lbh_omf;
+
+	lbh_omf = (struct logblock_header_omf *)lbuf;
+
+	if (omf_polh_vers(lbh_omf) == OMF_LOGBLOCK_VERS)
+		return OMF_LOGBLOCK_HDR_PACKLEN;
+
+	return -EINVAL;
+}
+
+
+/*
+ * logrec_descriptor
+ */
+static bool logrec_type_valid(enum logrec_type_omf rtype)
+{
+	return rtype <= OMF_LOGREC_CEND;
+}
+
+bool logrec_type_datarec(enum logrec_type_omf rtype)
+{
+	return rtype && rtype <= OMF_LOGREC_DATALAST;
+}
+
+int omf_logrec_desc_pack_htole(struct omf_logrec_descriptor *lrd, char *outbuf)
+{
+	struct logrec_descriptor_omf *lrd_omf;
+
+	if (!logrec_type_valid(lrd->olr_rtype))
+		return -EINVAL;
+
+	lrd_omf = (struct logrec_descriptor_omf *)outbuf;
+	omf_set_polr_tlen(lrd_omf, lrd->olr_tlen);
+	omf_set_polr_rlen(lrd_omf, lrd->olr_rlen);
+	omf_set_polr_rtype(lrd_omf, lrd->olr_rtype);
+
+	return 0;
+}
+
+void omf_logrec_desc_unpack_letoh(struct omf_logrec_descriptor *lrd, const char *inbuf)
+{
+	struct logrec_descriptor_omf *lrd_omf;
+
+	lrd_omf = (struct logrec_descriptor_omf *)inbuf;
+	lrd->olr_tlen  = omf_polr_tlen(lrd_omf);
+	lrd->olr_rlen  = omf_polr_rlen(lrd_omf);
+	lrd->olr_rtype = omf_polr_rtype(lrd_omf);
+}
+
+int omf_init(void)
+{
+	const char *algo = "crc32c";
+	int rc = 0;
+
+	mpool_tfm = crypto_alloc_shash(algo, 0, 0);
+	if (!mpool_tfm) {
+		rc = -ENOMEM;
+		mp_pr_err("crypto_alloc_shash(%s) failed", rc, algo);
+	}
+
+	return rc;
+}
+
+void omf_exit(void)
+{
+	if (mpool_tfm)
+		crypto_free_shash(mpool_tfm);
+}
diff --git a/drivers/mpool/upgrade.c b/drivers/mpool/upgrade.c
new file mode 100644
index 000000000000..1b6b692e58f4
--- /dev/null
+++ b/drivers/mpool/upgrade.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+
+/*
+ * DOC: Module info.
+ *
+ * Pool metadata upgrade module.
+ *
+ * Defines functions used to upgrade the mpool metadata.
+ *
+ */
+
+#include "omf_if.h"
+#include "upgrade.h"
+
+/*
+ * Latest mpool MDC content version understood by this binary.
+ * Also version used to write MDC content by this binary.
+ */
+#define MDCVER_MAJOR       1
+#define MDCVER_MINOR       0
+#define MDCVER_PATCH       0
+#define MDCVER_DEV         0
+
+/**
+ * struct mdcver_info - mpool MDC content version and its information.
+ * @mi_mdcver:  version of a mpool MDC content. It is the version of the
+ *              first binary that introduced that content semantic/format.
+ * @mi_types:   types used by this release (when writing MDC0-N content)
+ * @mi_ntypes:  no. of types are used by this release.
+ * @mi_comment: comment about that version
+ *
+ * Such a structure instance is added each time the mpool MDCs content
+ * semantic/format changes (making it incompatible with earlier binary
+ * versions).
+ */
+struct mdcver_info {
+	struct omf_mdcver   mi_mdcver;
+	uint8_t            *mi_types;
+	uint8_t             mi_ntypes;
+	const char         *mi_comment;
+};
+
+/*
+ * mpool MDC types used when MDC content is written at version 1.0.0.0.
+ */
+static uint8_t mdcver_1_0_0_0_types[] = {
+	OMF_MDR_OCREATE, OMF_MDR_OUPDATE, OMF_MDR_ODELETE, OMF_MDR_OIDCKPT,
+	OMF_MDR_OERASE, OMF_MDR_MCCONFIG, OMF_MDR_MCSPARE, OMF_MDR_VERSION,
+	OMF_MDR_MPCONFIG};
+
+
+/*
+ * mdcver_info mdcvtab[] - table of versions of mpool MDCs content.
+ *
+ * Each time MDC content semantic/format changes (making it incompatible
+ * with earlier binary versions) an entry is added in this table.
+ * The entry at the end of the array (highest index) is the version placed
+ * in the mpool MDC version record written to media when this binary writes
+ * the mpool MDCs.
+ * This entry is also the last mpool MDC content format/semantic that this
+ * binary understands.
+ *
+ * Example:
+ * - Initial binary 1.0.0.0 generates first ever MDCs content.
+ *   There is one entry in the table with its mi_mdcver being 1.0.0.0.
+ * - binary 1.0.0.1 is released and changes mpool MDC content semantic (for
+ *   example chenge the meaning of media class enum). This release adds the
+ *   entry 1.0.0.1 in this table.
+ * - binary 1.0.1.0 is released and doesn't change MDCs content semantic/format,
+ *   MDCs content generated by 1.0.1.0 binary is still compatible with a
+ *   1.0.0.1 binary reading it.
+ *   No entry is added in the table.
+ * - binary 2.0.0.0 is released and it changes MDCs content semantic.
+ *   A third entry is added in the table with its mi_mdcver being 2.0.0.0.
+ */
+static struct mdcver_info mdcvtab[] = {
+	{{ {MDCVER_MAJOR, MDCVER_MINOR, MDCVER_PATCH, MDCVER_DEV} },
+	mdcver_1_0_0_0_types, sizeof(mdcver_1_0_0_0_types),
+	"Initial mpool MDCs content"},
+};
+
+struct omf_mdcver *omfu_mdcver_cur(void)
+{
+	return &mdcvtab[ARRAY_SIZE(mdcvtab) - 1].mi_mdcver;
+}
+
+const char *omfu_mdcver_comment(struct omf_mdcver *mdcver)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mdcvtab); i++)
+		if (omfu_mdcver_cmp(mdcver, "==", &mdcvtab[i].mi_mdcver))
+			return mdcvtab[i].mi_comment;
+
+	return NULL;
+}
+
+char *omfu_mdcver_to_str(struct omf_mdcver *mdcver, char *buf, size_t sz)
+{
+	snprintf(buf, sz, "%u.%u.%u.%u", mdcver->mdcv_major,
+		 mdcver->mdcv_minor, mdcver->mdcv_patch, mdcver->mdcv_dev);
+
+	return buf;
+}
+
+bool omfu_mdcver_cmp(struct omf_mdcver *a, char *op, struct omf_mdcver *b)
+{
+	size_t cnt = ARRAY_SIZE(a->mdcver);
+	int res = 0, i;
+
+	for (i = 0; i < cnt; i++) {
+		if (a->mdcver[i] != b->mdcver[i]) {
+			res = (a->mdcver[i] > b->mdcver[i]) ? 1 : -1;
+			break;
+		}
+	}
+
+	if (((op[1] == '=') && (res == 0)) || ((op[0] == '>') && (res > 0)) ||
+	    ((op[0] == '<') && (res < 0)))
+		return true;
+
+	return false;
+}
+
+bool omfu_mdcver_cmp2(struct omf_mdcver *a, char *op, u16 major, u16 minor, u16 patch, u16 dev)
+{
+	struct omf_mdcver b;
+
+	b.mdcv_major = major;
+	b.mdcv_minor = minor;
+	b.mdcv_patch = patch;
+	b.mdcv_dev   = dev;
+
+	return omfu_mdcver_cmp(a, op, &b);
+}
-- 
2.17.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

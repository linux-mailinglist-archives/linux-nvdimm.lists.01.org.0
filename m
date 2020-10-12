Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD56128BD9E
	for <lists+linux-nvdimm@lfdr.de>; Mon, 12 Oct 2020 18:28:15 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1E72B15B409EF;
	Mon, 12 Oct 2020 09:28:14 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.223.74; helo=nam11-dm6-obe.outbound.protection.outlook.com; envelope-from=nmeeramohide@micron.com; receiver=<UNKNOWN> 
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A104B14B2CCEC
	for <linux-nvdimm@lists.01.org>; Mon, 12 Oct 2020 09:28:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2YNj7RdLNWcqK5LSbAAv0RxCzNrczoEMiP6/9jBBmsnCiaBEBkYSm2RkCM9DXjQEXZZWi/gsW0EmhoRSpAu89MrBpFj7uHvJ2dPIF4a1xEWxeMY0TdZZ5SPsek2pj8U6HSuYB+dmyTerg3qMrMY0/V5G7jV6jZbxAqhPzXGg2EVSN0kEvKUFd5fdlr8K256BNGnISnkCzyrP6M6zRioQ2/WwTqf8wxBmoEeBW3fcD7xx2yK1Cg9rxW9rDQCdN5cf331Yt7QPSoYe7ElTdEIXSsSFizufkcw2Y3iMyHrfVdV66mRN6cOh9rpYoDkfxVEk/Ei8TTrkv8KvH79LOEO4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVzhXWEgyB/vdJqGkffReFcKclHByOIDbZRSBpUr32k=;
 b=HT32dfIgJSOjhhwByRghqMCYzVZBpCHMgfq0MowRyIE1bghNEQiTETzL6kNYcDueap0yGTPmVBjPFptJWeKEHzKvpbC3spT/YIe8VbQcMFOPu33ayQqEkMJ+FuI5FBAA6aFfN8c724tfoCosj4yzVuWwXxdlNZhm6nhkTm28zL9UixtbAqP6/cqqc2xWHS1nqygIjy8Dwo/4r1LOy2SQuTnKn9f75cmXBM843O3FsLT8wJBkY27P1kjZt8OX2bRQualXDgGvA0FYekRfelen6+g42WN7jdMSo+8PfmbLeJ9Eqk4GPAbgU6swJFpFIF8bhQacqxKVmdYmCkVegZ0y/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=kvack.org smtp.mailfrom=micron.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVzhXWEgyB/vdJqGkffReFcKclHByOIDbZRSBpUr32k=;
 b=aSdisXUL2W6CWdCGDF32JPaVh5BOKlMa2YGC8rhtvSKkxHNocnAMt2AryGL3gHdlTG6TyyPNFLbpGDJmsFW3aPy+Cl7s5KcJ7HyCGm29xMiHqOJGW8fO0mCEoCUUT4AZIddgo9BQl/kgP01wWf63sqhHg9nJKmF8W5lDlvMX1kg=
Received: from SN4PR0201CA0067.namprd02.prod.outlook.com
 (2603:10b6:803:20::29) by DM5PR08MB3337.namprd08.prod.outlook.com
 (2603:10b6:4:69::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.29; Mon, 12 Oct
 2020 16:28:03 +0000
Received: from SN1NAM01FT015.eop-nam01.prod.protection.outlook.com
 (2603:10b6:803:20:cafe::fb) by SN4PR0201CA0067.outlook.office365.com
 (2603:10b6:803:20::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend
 Transport; Mon, 12 Oct 2020 16:28:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com;
Received: from mail.micron.com (137.201.242.130) by
 SN1NAM01FT015.mail.protection.outlook.com (10.152.65.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3455.23 via Frontend Transport; Mon, 12 Oct 2020 16:28:02 +0000
Received: from micron.com (10.114.5.55) by bowex17c.micron.com
 (137.201.21.211) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Oct
 2020 10:27:55 -0600
From: Nabeel M Mohamed <nmeeramohide@micron.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-nvdimm@lists.01.org>
Subject: [PATCH v2 02/22] mpool: add in-memory struct definitions
Date: Mon, 12 Oct 2020 11:27:16 -0500
Message-ID: <20201012162736.65241-3-nmeeramohide@micron.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20201012162736.65241-1-nmeeramohide@micron.com>
References: <20201012162736.65241-1-nmeeramohide@micron.com>
MIME-Version: 1.0
X-ClientProxiedBy: bowex17a.micron.com (137.201.21.209) To bowex17c.micron.com
 (137.201.21.211)
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24646.005
X-TM-AS-Result: No--20.984400-0.000000-31
X-TM-AS-MatchedID: 700069-702178-700864-703226-701475-704397-702876-701480-7
	01809-703017-703140-702395-188019-703213-121336-701105-704673-703967-139504
	-700863-703707-704318-703215-703357-704183-701342-700535-704718-704401-7001
	63-703700-702438-105250-121367-704418-701432-704477-702433-701275-703815-70
	2732-702754-702688-703812-702779-702008-704792-703231-704184-704475-703864-
	700335-702914-700002-390336-704472-701813-702888-700912-702525-701919-70490
	1-705244-701104-704001-700717-703694-847575-700958-701075-701744-702889-137
	717-701586-121665-704002-113872-704895-704978-701274-700714-702933-701893-7
	01847-702874-703635-106420-703080-701628-704726-148004-148036-42000-42003-1
	90014
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c68b203-b114-4719-2d66-08d86ecbca95
X-MS-TrafficTypeDiagnostic: DM5PR08MB3337:
X-Microsoft-Antispam-PRVS: 
 <DM5PR08MB3337F2DE69148CEE6CF4879EB3070@DM5PR08MB3337.namprd08.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Oob-TLC-OOBClassifiers: OLM:185;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HW8pfCgBN0i7mTUQj1lM5t7qtneuszQAWCt7yDhjC+0dzPQxbQ9QLNIowVolsk5zDvoOed1sJ4M4Bm2LurA5j08w8JUQFttLEMOa/ifhK6kdQxvxMP6+ZGjBgYl8QOClvn7hfCRmcpghJ9tMdfNIkx7ahs4AQJv0pGS3OdZLfypsbk5UkxVpcZ1FaN68qgUYzz1GYkO0zNcWrDhkN7fcxUrfeu7zR2PWfYm1njo8HlB0LXByNeyvPKP5rJGgOw36wthaWh5XOK2RKn93zarYdDb1VQBnRYRwtrKpjGpzRXjv0rjMwdR5gZThJKfkBIS8KzlGZ/QhaeePJhveac/ZxEQsInvYTS0h1nP5qHl4jiqnh5fAtQmL4w7n4M32s6339HZipVnfFWDMiJ2MjXu6moLaAIWt/lKyqxUlPRugLS2qtvi3A94vtJ94zGReGWhoQHgh9sraZk+vtRrQqQ0OlobqptT0ajBhB2UuW41jBwI=
X-Forefront-Antispam-Report: 
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(46966005)(70206006)(70586007)(8676002)(2906002)(86362001)(110136005)(54906003)(316002)(26005)(55016002)(478600001)(8936002)(336012)(186003)(426003)(7696005)(6286002)(82310400003)(36756003)(4326008)(2616005)(6666004)(30864003)(1076003)(5660300002)(82740400003)(7636003)(47076004)(107886003)(356005)(33310700002)(83380400001)(461764006)(2101003)(579004)(559001);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 16:28:02.7536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c68b203-b114-4719-2d66-08d86ecbca95
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM01FT015.eop-nam01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR08MB3337
Message-ID-Hash: HN7QZMRXP7O6KNSWCM2TPYSCN5PUJBYN
X-Message-ID-Hash: HN7QZMRXP7O6KNSWCM2TPYSCN5PUJBYN
X-MailFrom: nmeeramohide@micron.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: smoyer@micron.com, gbecker@micron.com, plabat@micron.com, jgroves@micron.com, Nabeel M Mohamed <nmeeramohide@micron.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HN7QZMRXP7O6KNSWCM2TPYSCN5PUJBYN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add headers containing the basic in-memory structures used by mpool.

- mclass.h: media classes
- mlog.h: mlog objects
- mp.h, mpcore.h: mpool objects
- params.h: mpool parameters
- pd.h: pool drive interface
- pmd.h, pmd_obj.h: Metadata manager
- sb.h: superblock interface
- smap.h: space map interface

Co-developed-by: Greg Becker <gbecker@micron.com>
Signed-off-by: Greg Becker <gbecker@micron.com>
Co-developed-by: Pierre Labat <plabat@micron.com>
Signed-off-by: Pierre Labat <plabat@micron.com>
Co-developed-by: John Groves <jgroves@micron.com>
Signed-off-by: John Groves <jgroves@micron.com>
Signed-off-by: Nabeel M Mohamed <nmeeramohide@micron.com>
---
 drivers/mpool/mclass.h  | 137 +++++++++++
 drivers/mpool/mlog.h    | 212 +++++++++++++++++
 drivers/mpool/mp.h      | 231 +++++++++++++++++++
 drivers/mpool/mpcore.h  | 354 ++++++++++++++++++++++++++++
 drivers/mpool/params.h  | 116 ++++++++++
 drivers/mpool/pd.h      | 202 ++++++++++++++++
 drivers/mpool/pmd.h     | 379 ++++++++++++++++++++++++++++++
 drivers/mpool/pmd_obj.h | 499 ++++++++++++++++++++++++++++++++++++++++
 drivers/mpool/sb.h      | 162 +++++++++++++
 drivers/mpool/smap.h    | 334 +++++++++++++++++++++++++++
 10 files changed, 2626 insertions(+)
 create mode 100644 drivers/mpool/mclass.h
 create mode 100644 drivers/mpool/mlog.h
 create mode 100644 drivers/mpool/mp.h
 create mode 100644 drivers/mpool/mpcore.h
 create mode 100644 drivers/mpool/params.h
 create mode 100644 drivers/mpool/pd.h
 create mode 100644 drivers/mpool/pmd.h
 create mode 100644 drivers/mpool/pmd_obj.h
 create mode 100644 drivers/mpool/sb.h
 create mode 100644 drivers/mpool/smap.h

diff --git a/drivers/mpool/mclass.h b/drivers/mpool/mclass.h
new file mode 100644
index 000000000000..2ecdcd08de9f
--- /dev/null
+++ b/drivers/mpool/mclass.h
@@ -0,0 +1,137 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+
+#ifndef MPOOL_MCLASS_H
+#define MPOOL_MCLASS_H
+
+#include "mpool_ioctl.h"
+
+struct omf_devparm_descriptor;
+struct mpool_descriptor;
+struct mpcore_params;
+
+/*
+ * This file contains the media class structures definitions and prototypes
+ * private to mpool core.
+ */
+
+/**
+ * struct mc_parms - media class parameters
+ * @mcp_classp:    class performance characteristics, enum mp_media_classp
+ * @mcp_zonepg:    zone size in number of zone pages
+ * @mcp_sectorsz:  2^sectorsz is the logical sector size
+ * @mcp_devtype:   device type. Enum pd_devtype.
+ * @mcp_features:  ored bits from mp_mc_features
+ *
+ * Two PDs can't be placed in the same media class if they have different
+ * mc_parms.
+ */
+struct mc_parms {
+	u8  mcp_classp;
+	u32 mcp_zonepg;
+	u8  mcp_sectorsz;
+	u8  mcp_devtype;
+	u64 mcp_features;
+};
+
+/**
+ * struct mc_smap_parms - media class space map parameters
+ * @mcsp_spzone: percent spare zones for drives.
+ * @mcsp_rgnc: no. of space map zones for drives in each media class
+ * @mcsp_align: space map zone alignment for drives in each media class
+ */
+struct mc_smap_parms {
+	u8		mcsp_spzone;
+	u8		mcsp_rgnc;
+	u8		mcsp_align;
+};
+
+/**
+ * struct media_class - define a media class
+ * @mc_parms:  define a media class, content differ for each media class
+ * @mc_sparms: space map params for this media class
+ * @mc_pdmc:   active pdv entries grouped by media class array
+ * @mc_uacnt:  UNAVAIL status drive count in each media class
+ *
+ * Locking:
+ *    Protected by mp.pds_pdvlock.
+ */
+struct media_class {
+	struct mc_parms        mc_parms;
+	struct mc_smap_parms   mc_sparms;
+	s8                     mc_pdmc;
+	u8                     mc_uacnt;
+};
+
+/**
+ * mc_pd_prop2mc_parms() -  Convert PD properties into media class parameters.
+ * @pd_prop: input, pd properties.
+ * @mc_parms: output, media class parameters.
+ *
+ * Typically used before a lookup (mc_lookup_from_mc_parms()) to know in
+ * which media class a PD belongs to.
+ */
+void mc_pd_prop2mc_parms(struct pd_prop *pd_prop, struct mc_parms *mc_parms);
+
+/**
+ * mc_omf_devparm2mc_parms() - convert a omf_devparm_descriptor into an mc_parms.
+ * @omf_devparm: input
+ * @mc_parms: output
+ */
+void mc_omf_devparm2mc_parms(struct omf_devparm_descriptor *omf_devparm, struct mc_parms *mc_parms);
+
+/**
+ * mc_parms2omf_devparm() - convert a mc_parms in a omf_devparm_descriptor
+ * @mc_parms: input
+ * @omf_devparm: output
+ */
+void mc_parms2omf_devparm(struct mc_parms *mc_parms, struct omf_devparm_descriptor *omf_devparm);
+
+/**
+ * mc_cmp_omf_devparm() - check if two omf_devparm_descriptor corresponds
+ *	to the same media class.
+ * @omf_devparm1:
+ * @omf_devparm2:
+ *
+ * Returns 0 if in same media class.
+ */
+int mc_cmp_omf_devparm(struct omf_devparm_descriptor *omfd1, struct omf_devparm_descriptor *omfd2);
+
+/**
+ * mc_init_class() - initialize a media class
+ * @mc:
+ * @mc_parms: parameters of the media class
+ * @mcsp:     smap parameters for mc
+ */
+void mc_init_class(struct media_class *mc, struct mc_parms *mc_parms, struct mc_smap_parms *mcsp);
+
+/**
+ * mc_set_spzone() - set the percent spare on the media class mclass.
+ * @mc:
+ * @spzone:
+ *
+ * Return: 0, or -ENOENT if the specified mclass doesn't exist.
+ */
+int mc_set_spzone(struct media_class *mc, u8 spzone);
+
+/**
+ * mclass_isvalid() - Return true if the media class is valid.
+ * @mclass:
+ */
+static inline bool mclass_isvalid(enum mp_media_classp mclass)
+{
+	return (mclass >= 0 && mclass < MP_MED_NUMBER);
+}
+
+/**
+ * mc_smap_parms_get() - get space map params for the specified mclass.
+ * @mp:
+ * @mclass:
+ * @mcsp: (output)
+ */
+int mc_smap_parms_get(struct media_class *mc, struct mpcore_params *params,
+		      struct mc_smap_parms *mcsp);
+
+#endif /* MPOOL_MCLASS_H */
diff --git a/drivers/mpool/mlog.h b/drivers/mpool/mlog.h
new file mode 100644
index 000000000000..0de816335d55
--- /dev/null
+++ b/drivers/mpool/mlog.h
@@ -0,0 +1,212 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+/*
+ * Defines functions for writing, reading, and managing the lifecycle of mlogs.
+ */
+
+#ifndef MPOOL_MLOG_H
+#define MPOOL_MLOG_H
+
+#include <linux/uio.h>
+
+#include "mpool_ioctl.h"
+
+#define MB       (1024 * 1024)
+struct pmd_layout;
+struct mpool_descriptor;
+struct mlog_descriptor;
+
+
+/**
+ * struct mlog_read_iter -
+ * @lri_layout: Layout of log being read
+ * @lri_soff:   Sector offset of next log block to read from
+ * @lri_gen:    Log generation number at iterator initialization
+ * @lri_roff:   Next offset in log block soff to read from
+ * @lri_rbidx:  Read buffer page index currently reading from
+ * @lri_sidx:   Log block index in lri_rbidx
+ * @lri_valid:  1 if iterator is valid; 0 otherwise
+ */
+struct mlog_read_iter {
+	struct pmd_layout  *lri_layout;
+	off_t               lri_soff;
+	u64                 lri_gen;
+	u16                 lri_roff;
+	u16                 lri_rbidx;
+	u16                 lri_sidx;
+	u8                  lri_valid;
+};
+
+/**
+ * struct mlog_fsetparms -
+ *
+ * @mfp_totsec: Total number of log blocks in mlog
+ * @mfp_secpga: Is sector size page-aligned?
+ * @mfp_lpgsz:  Size of each page in read/append buffer
+ * @mfp_npgmb:  No. of pages in 1 MiB buffer
+ * @mfp_sectsz: Sector size obtained from PD prop
+ * @mfp_nsecmb: No. of sectors/log blocks in 1 MiB buffer
+ * @mfp_nsecpg: No. of sectors/log blocks per page
+ */
+struct mlog_fsetparms {
+	u32    mfp_totsec;
+	bool   mfp_secpga;
+	u32    mfp_lpgsz;
+	u16    mfp_nlpgmb;
+	u16    mfp_sectsz;
+	u16    mfp_nsecmb;
+	u16    mfp_nseclpg;
+};
+
+/**
+ * struct mlog_stat - mlog open status (referenced by associated struct pmd_layout)
+ * @lst_citr:    Current mlog read iterator
+ * @lst_mfp:     Mlog flush set parameters
+ * @lst_abuf:    Append buffer, max 1 MiB size
+ * @lst_rbuf:    Read buffer, max 1 MiB size - immutable
+ * @lst_rsoff:   LB offset of the 1st log block in lst_rbuf
+ * @lst_rseoff:  LB offset of the last log block in lst_rbuf
+ * @lst_asoff:   LB offset of the 1st log block in CFS
+ * @lst_wsoff:   Offset of the accumulating log block
+ * @lst_abdirty: true, if append buffer is dirty
+ * @lst_pfsetid: Prev. fSetID of the first log block in CFS
+ * @lst_cfsetid: Current fSetID of the CFS
+ * @lst_cfssoff: Offset within the 1st log block from where CFS starts
+ * @lst_aoff:    Next byte offset[0, sectsz) to fill in the current log block
+ * @lst_abidx:   Index of current filling page in lst_abuf
+ * @lst_csem:    enforce compaction semantics if true
+ * @lst_cstart:  valid compaction start marker in log?
+ * @lst_cend:    valid compaction end marker in log?
+ */
+struct mlog_stat {
+	struct mlog_read_iter  lst_citr;
+	struct mlog_fsetparms  lst_mfp;
+	char  **lst_abuf;
+	char  **lst_rbuf;
+	off_t   lst_rsoff;
+	off_t   lst_rseoff;
+	off_t   lst_asoff;
+	off_t   lst_wsoff;
+	bool    lst_abdirty;
+	u32     lst_pfsetid;
+	u32     lst_cfsetid;
+	u16     lst_cfssoff;
+	u16     lst_aoff;
+	u16     lst_abidx;
+	u8      lst_csem;
+	u8      lst_cstart;
+	u8      lst_cend;
+};
+
+#define MLOG_TOTSEC(lstat)  ((lstat)->lst_mfp.mfp_totsec)
+#define MLOG_LPGSZ(lstat)   ((lstat)->lst_mfp.mfp_lpgsz)
+#define MLOG_NLPGMB(lstat)  ((lstat)->lst_mfp.mfp_nlpgmb)
+#define MLOG_SECSZ(lstat)   ((lstat)->lst_mfp.mfp_sectsz)
+#define MLOG_NSECMB(lstat)  ((lstat)->lst_mfp.mfp_nsecmb)
+#define MLOG_NSECLPG(lstat) ((lstat)->lst_mfp.mfp_nseclpg)
+
+#define IS_SECPGA(lstat)    ((lstat)->lst_mfp.mfp_secpga)
+
+/*
+ * mlog API functions
+ */
+
+/*
+ * Error codes: all mlog fns can return one or more of:
+ * -EINVAL = invalid fn args
+ * -ENOENT = log not open or logid not found
+ * -EFBIG = log full
+ * -EMSGSIZE = cstart w/o cend indicating a crash during compaction
+ * -ENODATA = malformed or corrupted log
+ * -EIO = unable to read/write log on media
+ * -ENOMEM = insufficient room in copy-out buffer
+ * -EBUSY = log is in erasing state; wait or retry erase
+ */
+
+int mlog_alloc(struct mpool_descriptor *mp, struct mlog_capacity *capreq,
+	       enum mp_media_classp mclassp, struct mlog_props *prop,
+	       struct mlog_descriptor **mlh);
+
+int mlog_realloc(struct mpool_descriptor *mp, u64 objid, struct mlog_capacity *capreq,
+		 enum mp_media_classp mclassp, struct mlog_props *prop,
+		 struct mlog_descriptor **mlh);
+
+int mlog_find_get(struct mpool_descriptor *mp, u64 objid, int which,
+		  struct mlog_props *prop, struct mlog_descriptor **mlh);
+
+void mlog_put(struct mlog_descriptor *layout);
+
+void mlog_lookup_rootids(u64 *id1, u64 *id2);
+
+int mlog_commit(struct mpool_descriptor *mp, struct mlog_descriptor *mlh);
+
+int mlog_abort(struct mpool_descriptor *mp, struct mlog_descriptor *mlh);
+
+int mlog_delete(struct mpool_descriptor *mp, struct mlog_descriptor *mlh);
+
+/**
+ * mlog_open() - Open committed log, validate contents, and return its generation number
+ * @mp:
+ * @mlh:
+ * @flags:
+ * @gen: output
+ *
+ * If log is already open just returns gen; if csem is true enforces compaction
+ * semantics so that open fails if valid cstart/cend markers are not present.
+ *
+ * Returns: 0 if successful, -errno otherwise
+ */
+int mlog_open(struct mpool_descriptor *mp, struct mlog_descriptor *mlh, u8 flags, u64 *gen);
+
+int mlog_close(struct mpool_descriptor *mp, struct mlog_descriptor *mlh);
+
+int mlog_gen(struct mlog_descriptor *mlh, u64 *gen);
+
+int mlog_empty(struct mpool_descriptor *mp, struct mlog_descriptor *mlh, bool *empty);
+
+int mlog_erase(struct mpool_descriptor *mp, struct mlog_descriptor *mlh, u64 mingen);
+
+int mlog_append_cstart(struct mpool_descriptor *mp, struct mlog_descriptor *mlh);
+
+int mlog_append_cend(struct mpool_descriptor *mp, struct mlog_descriptor *mlh);
+
+int mlog_append_data(struct mpool_descriptor *mp, struct mlog_descriptor *mlh,
+		     char *buf, u64 buflen, int sync);
+
+int mlog_read_data_init(struct mlog_descriptor *mlh);
+
+/**
+ * mlog_read_data_next() -
+ * @mp:
+ * @mlh:
+ * @buf:
+ * @buflen:
+ * @rdlen:
+ *
+ * Returns:
+ *   If -EOVERFLOW is returned, then "buf" is too small to
+ *   hold the read data. Can be retried with a bigger receive buffer whose
+ *   size is returned in rdlen.
+ */
+int mlog_read_data_next(struct mpool_descriptor *mp, struct mlog_descriptor *mlh,
+			char *buf, u64 buflen, u64 *rdlen);
+
+int mlog_get_props_ex(struct mpool_descriptor *mp, struct mlog_descriptor *mlh,
+		      struct mlog_props_ex *prop);
+
+void mlog_precompact_alsz(struct mpool_descriptor *mp, struct mlog_descriptor *mlh);
+
+int mlog_rw_raw(struct mpool_descriptor *mp, struct mlog_descriptor *mlh,
+		const struct kvec *iov, int iovcnt, u64 boff, u8 rw);
+
+void mlogutil_closeall(struct mpool_descriptor *mp);
+
+bool mlog_objid(u64 objid);
+
+struct pmd_layout *mlog2layout(struct mlog_descriptor *mlh);
+
+struct mlog_descriptor *layout2mlog(struct pmd_layout *layout);
+
+#endif /* MPOOL_MLOG_H */
diff --git a/drivers/mpool/mp.h b/drivers/mpool/mp.h
new file mode 100644
index 000000000000..e1570f8c8d0c
--- /dev/null
+++ b/drivers/mpool/mp.h
@@ -0,0 +1,231 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+
+#ifndef MPOOL_MP_H
+#define MPOOL_MP_H
+
+#include "mpool_ioctl.h"
+#include "uuid.h"
+#include "params.h"
+
+struct mpool_descriptor;
+
+#define MPOOL_OP_READ  0
+#define MPOOL_OP_WRITE 1
+#define PD_DEV_ID_PDUNAVAILABLE "DID_PDUNAVAILABLE"
+
+#define MPOOL_DRIVES_MAX       MP_MED_NUMBER
+#define MP_MED_ALL             MP_MED_NUMBER
+
+/* Object types */
+enum mp_obj_type {
+	MP_OBJ_UNDEF  = 0,
+	MP_OBJ_MBLOCK = 1,
+	MP_OBJ_MLOG   = 2,
+};
+
+/**
+ * struct mpool_config -
+ * @mc_oid1:
+ * @mc_oid2:
+ * @mc_uid:
+ * @mc_gid:
+ * @mc_mode:
+ * @mc_mclassp:
+ * @mc_captgt:
+ * @mc_ra_pages_max:
+ * @mc_vma_sz_max:
+ * @mc_utype:           user-defined type
+ * @mc_label:           user-defined label
+
+ */
+struct mpool_config {
+	u64                     mc_oid1;
+	u64                     mc_oid2;
+	uid_t                   mc_uid;
+	gid_t                   mc_gid;
+	mode_t                  mc_mode;
+	u32                     mc_rsvd0;
+	u64                     mc_captgt;
+	u32                     mc_ra_pages_max;
+	u32                     mc_vma_size_max;
+	u32                     mc_rsvd1;
+	u32                     mc_rsvd2;
+	u64                     mc_rsvd3;
+	u64                     mc_rsvd4;
+	uuid_le                 mc_utype;
+	char                    mc_label[MPOOL_LABELSZ_MAX];
+};
+
+/*
+ * mpool API functions
+ */
+
+/**
+ * mpool_create() - Create an mpool
+ * @mpname:
+ * @flags: enum mp_mgmt_flags
+ * @dpaths:
+ * @pd_prop: PDs properties obtained by mpool_create() caller.
+ * @params:  mpcore parameters
+ * @mlog_cap:
+ *
+ * Create an mpool from dcnt drive paths dpaths; store mpool metadata as
+ * specified by mdparm;
+ *
+ * Return:
+ * %0 if successful, -errno otherwise..
+ * ENODEV if insufficient number of drives meeting mdparm,
+ */
+int mpool_create(const char *name, u32 flags, char **dpaths, struct pd_prop *pd_prop,
+		 struct mpcore_params *params, u64 mlog_cap);
+
+/**
+ * mpool_activate() - Activate an mpool
+ * @dcnt:
+ * @dpaths:
+ * @pd_prop: properties of the PDs. dcnt elements.
+ * @mlog_cap:
+ * @params:   mpcore parameters
+ * @flags:
+ * @mpp: *mpp is set to NULL if error
+ *
+ * Activate mpool on dcnt drive paths dpaths; if force flag is set tolerate
+ * unavailable drives up to redundancy limit; if successful *mpp is a handle
+ * for the mpool.
+ *
+ * Return:
+ * %0 if successful, -errno otherwise
+ * ENODEV if too many drives unavailable or failed,
+ * ENXIO if device previously removed from mpool and is no longer a member
+ */
+int mpool_activate(u64 dcnt, char **dpaths, struct pd_prop *pd_prop, u64 mlog_cap,
+		   struct mpcore_params *params, u32 flags, struct mpool_descriptor **mpp);
+
+
+/**
+ * mpool_deactivate() - Deactivate an mpool.
+ * @mp: mpool descriptor
+ *
+ * Deactivate mpool; caller must ensure no other thread can access mp; mp is
+ * invalid after call.
+ */
+int mpool_deactivate(struct mpool_descriptor *mp);
+
+/**
+ * mpool_destroy() - Destroy an mpool
+ * @dcnt:
+ * @dpaths:
+ * @pd_prop: PD properties.
+ * @flags:
+ *
+ * Destroy mpool on dcnt drive paths dpaths;
+ *
+ * Return:
+ * %0 if successful, -errno otherwise
+ */
+int mpool_destroy(u64 dcnt, char **dpaths, struct pd_prop *pd_prop, u32 flags);
+
+/**
+ * mpool_rename() - Rename mpool to mp_newname
+ * @dcnt:
+ * @dpaths:
+ * @pd_prop: PD properties.
+ * @flags:
+ * @mp_newname:
+ *
+ * Return:
+ * %0 if successful, -errno otherwise
+ */
+int mpool_rename(u64 dcnt, char **dpaths, struct pd_prop *pd_prop, u32 flags,
+		 const char *mp_newname);
+
+/**
+ * mpool_drive_add() - Add new drive dpath to mpool.
+ * @mp:
+ * @dpath:
+ * @pd_prop: PD properties.
+ *
+ * Return: %0 if successful; -enno otherwise...
+ */
+int mpool_drive_add(struct mpool_descriptor *mp, char *dpath, struct pd_prop *pd_prop);
+
+/**
+ * mpool_drive_spares() - Set percent spare zones to spzone for drives in media class mclassp.
+ * @mp:
+ * @mclassp:
+ * @spzone:
+ *
+ * Return: 0 if successful, -errno otherwise...
+ */
+int mpool_drive_spares(struct mpool_descriptor *mp, enum mp_media_classp mclassp, u8 spzone);
+
+/**
+ * mpool_mclass_get_cnt() - Get a count of media classes with drives in this mpool
+ * @mp:
+ * @info:
+ */
+void mpool_mclass_get_cnt(struct mpool_descriptor *mp, u32 *cnt);
+
+/**
+ * mpool_mclass_get() - Get a information on mcl_cnt media classes
+ * @mp:
+ * @mcic:
+ * @mciv:
+ *
+ * Return: 0 if successful, -errno otherwise...
+ */
+int mpool_mclass_get(struct mpool_descriptor *mp, u32 *mcxc, struct mpool_mclass_xprops *mcxv);
+
+/**
+ * mpool_get_xprops() - Retrieve extended mpool properties
+ * @mp:
+ * @prop:
+ */
+void mpool_get_xprops(struct mpool_descriptor *mp, struct mpool_xprops *xprops);
+
+/**
+ * mpool_get_devprops_by_name() - Fill in dprop for active drive with name pdname
+ * @mp:
+ * @pdname:
+ * @dprop:
+ *
+ * Return: %0 if success, -errno otherwise...
+ * -ENOENT if device with specified name cannot be found
+ */
+int mpool_get_devprops_by_name(struct mpool_descriptor *mp, char *pdname,
+			       struct mpool_devprops *dprop);
+
+/**
+ * mpool_get_usage() - Fill in stats with mpool space usage for the media class mclassp
+ * @mp:
+ * @mclassp:
+ * @usage:
+ *
+ * If mclassp is MCLASS_ALL, report on entire pool (all media classes).
+ *
+ * Return: %0 if successful; err_t otherwise...
+ */
+void
+mpool_get_usage(
+	struct mpool_descriptor    *mp,
+	enum mp_media_classp        mclassp,
+	struct mpool_usage         *usage);
+
+/**
+ * mpool_config_store() - store a config record in MDC0
+ * @mp:
+ * @cfg:
+ */
+int mpool_config_store(struct mpool_descriptor *mp, const struct mpool_config *cfg);
+
+/**
+ * mpool_config_fetch() - fetch the current mpool config
+ * @mp:
+ * @cfg:
+ */
+int mpool_config_fetch(struct mpool_descriptor *mp, struct mpool_config *cfg);
+
+#endif /* MPOOL_MP_H */
diff --git a/drivers/mpool/mpcore.h b/drivers/mpool/mpcore.h
new file mode 100644
index 000000000000..904763d49814
--- /dev/null
+++ b/drivers/mpool/mpcore.h
@@ -0,0 +1,354 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+
+#ifndef MPOOL_MPCORE_H
+#define MPOOL_MPCORE_H
+
+#include <linux/rbtree.h>
+#include <linux/workqueue.h>
+#include <linux/mutex.h>
+
+#include "uuid.h"
+
+#include "mp.h"
+#include "pd.h"
+#include "smap.h"
+#include "mclass.h"
+#include "pmd.h"
+#include "params.h"
+
+extern struct rb_root mpool_pools;
+
+struct pmd_layout;
+
+/**
+ * enum mpool_status -
+ * @MPOOL_STAT_UNDEF:
+ * @MPOOL_STAT_OPTIMAL:
+ * @MPOOL_STAT_FAULTED:
+ */
+enum mpool_status {
+	MPOOL_STAT_UNDEF    = 0,
+	MPOOL_STAT_OPTIMAL  = 1,
+	MPOOL_STAT_FAULTED  = 2,
+	MPOOL_STAT_LAST = MPOOL_STAT_FAULTED,
+};
+
+_Static_assert((MPOOL_STAT_LAST < 256), "enum mpool_status must fit in u8");
+
+/**
+ * struct mpool_dev_info - Pool drive state, status, and params
+ * @pdi_devid:    UUID for this drive
+ * @pdi_parm:     drive parms
+ * @pdi_status:   enum pd_status value: drive status
+ * @pdi_ds:       drive space allocation info
+ * @pdi_rmap:     per allocation zone space maps rbtree array, node:
+ *                struct u64_to_u64_rb
+ * @pdi_rmlock:   lock protects per zone space maps
+ * @pdi_name:     device name (only the last path name component)
+ *
+ * Pool drive state, status, and params
+ *
+ * LOCKING:
+ *    devid, mclass : constant; no locking required
+ *    parm: constant EXCEPT in rare change of status from UNAVAIL; see below
+ *    status: usage does not require locking, but MUST get/set via accessors
+ *    state: protected by pdvlock in enclosing mpool_descriptor
+ *    ds: protected by ds.dalock defined in smap module
+ *    zmap[x]: protected by zmlock[x]
+ *
+ * parm fields are constant except in a rare change of status from UNAVAIL,
+ * during which a subset of the fields are modified.  see the pd module for
+ * details on how this is handled w/o requiring locking.
+ */
+struct mpool_dev_info {
+	atomic_t                pdi_status; /* Barriers or acq/rel required */
+	struct pd_dev_parm      pdi_parm;
+	struct smap_dev_alloc   pdi_ds;
+	struct rmbkt           *pdi_rmbktv;
+	struct mpool_uuid       pdi_devid;
+};
+
+/* Shortcuts */
+#define pdi_didstr    pdi_parm.dpr_prop.pdp_didstr
+#define pdi_zonepg    pdi_parm.dpr_prop.pdp_zparam.dvb_zonepg
+#define pdi_zonetot   pdi_parm.dpr_prop.pdp_zparam.dvb_zonetot
+#define pdi_devtype   pdi_parm.dpr_prop.pdp_devtype
+#define pdi_cmdopt    pdi_parm.dpr_prop.pdp_cmdopt
+#define pdi_mclass    pdi_parm.dpr_prop.pdp_mclassp
+#define pdi_devsz     pdi_parm.dpr_prop.pdp_devsz
+#define pdi_sectorsz  pdi_parm.dpr_prop.pdp_sectorsz
+#define pdi_optiosz   pdi_parm.dpr_prop.pdp_optiosz
+#define pdi_fua       pdi_parm.dpr_prop.pdp_fua
+#define pdi_prop      pdi_parm.dpr_prop
+#define pdi_name      pdi_parm.dpr_name
+
+/**
+ * struct uuid_to_mpdesc_rb -
+ * @utm_node:
+ * @utm_uuid_le:
+ * @utm_md:
+ */
+struct uuid_to_mpdesc_rb {
+	struct rb_node              utm_node;
+	struct mpool_uuid           utm_uuid_le;
+	struct mpool_descriptor    *utm_md;
+};
+
+/**
+ * struct mpdesc_mdparm - parameters used for the MDCs of the mpool.
+ * @md_mclass:  media class used for the mpool metadata
+ */
+struct mpdesc_mdparm {
+	u8     md_mclass;
+};
+
+/**
+ * struct pre_compact_ctrl - used to start/stop/control precompaction
+ * @pco_dwork:
+ * @pco_mp:
+ * @pco_nmtoc: next MDC to compact
+
+ * Each time pmd_precompact_cb() runs it will consider the next MDC
+ * for compaction.
+ */
+struct pre_compact_ctrl {
+	struct delayed_work	 pco_dwork;
+	struct mpool_descriptor *pco_mp;
+	atomic_t		 pco_nmtoc;
+};
+
+/**
+ * struct mpool_descriptor - Media pool descriptor
+ * @pds_pdvlock:  drive membership/state lock
+ * @pds_pdv:      per drive info array
+ * @pds_omlock:   open mlog index lock
+ * @pds_oml:      rbtree of open mlog layouts. indexed by objid
+ *                node type: objid_to_layout_rb
+ * @pds_poolid:   UUID of pool
+ * @pds_mdparm:   mclass id of mclass used for mdc layouts
+ * @pds_cfg:      mpool config
+ * @pds_pdvcnt:   cnt of valid pdv entries
+ * @pds_mc        table of media classes
+ * @pds_uctxt     used by user-space mlogs to indicate the context
+ * @pds_node:     for linking this object into an rbtree
+ * @pds_params:   Per mpool parameters
+ * @pds_workq:    Workqueue per mpool.
+ * @pds_sbmdc0:   Used to store in RAM the MDC0 metadata. Loaded at activate
+ *                time, changed when MDC0 is compacted.
+ * @pds_mda:      metadata container array (this thing is huge!)
+ *
+ * LOCKING:
+ *    poolid, ospagesz, mdparm: constant; no locking required
+ *    mda: protected by internal locks as documented in pmd module
+ *    oml: protected by omlock
+ *    pdv: see note
+ *    pds_mc: protected by pds_pdvlock
+ *	Update of pds_mc[].mc_sparams.mc_spzone must also be enclosed
+ *	with mpool_s_lock to serialize the spzone updates, because they include
+ *	an append of an MDC0 record on top of updating mc_spzone.
+ *    all other fields: protected by pds_pdvlock (as is pds_pdv[x].state)
+ *    pds_sbmdc0: Used to store in RAM the MDC0 metadata. Loaded when mpool
+ *	activated, no lock needed at that time (single) threaded.
+ *	Then changed during MDC0 compaction. At that time it is protected by
+ *	MDC0 compact lock.
+ *
+ * NOTE:
+ *    pds_pdvcnt only ever increases so that pds_pdv[x], x < pdvcnt, can be
+ *    accessed without locking, other than as required by the struct
+ *    mpool_dev_info.
+ *    mc_spzone is written and read only by mpool functions that are serialized
+ *    via mpool_s_lock.
+ */
+struct mpool_descriptor {
+	struct rw_semaphore         pds_pdvlock;
+
+	____cacheline_aligned
+	struct mpool_dev_info       pds_pdv[MPOOL_DRIVES_MAX];
+
+	____cacheline_aligned
+	struct mutex                pds_oml_lock;
+	struct rb_root              pds_oml_root;
+
+	/* Read-mostly fields... */
+	____cacheline_aligned
+	u16                         pds_pdvcnt;
+	struct mpdesc_mdparm        pds_mdparm;
+	struct workqueue_struct    *pds_workq;
+	struct workqueue_struct    *pds_erase_wq;
+	struct workqueue_struct    *pds_precompact_wq;
+
+	struct media_class          pds_mc[MP_MED_NUMBER];
+	struct mpcore_params        pds_params;
+	struct omf_sb_descriptor    pds_sbmdc0;
+	struct pre_compact_ctrl     pds_pco;
+	struct smap_usage_work      pds_smap_usage_work;
+
+	/* Rarey used fields... */
+	struct mpool_config         pds_cfg;
+	struct rb_node              pds_node;
+	struct mpool_uuid           pds_poolid;
+	char                        pds_name[MPOOL_NAMESZ_MAX];
+
+	/* pds_mda is enormous (91K) */
+	struct pmd_mda_info         pds_mda;
+};
+
+/**
+ * mpool_desc_unavail_add() - Add unavailable drive to mpool descriptor.
+ * @mp:
+ * @omf_devparm:
+ *
+ * Add unavailable drive to mpool descriptor; caller must guarantee that
+ * devparm.devid is not already there.
+ * As part of adding the drive to the mpool descriptor, the drive is added
+ * in its media class.
+ *
+ * Return: 0 if successful, -errno (-EINVAL or -ENOMEM) otherwise
+ */
+int mpool_desc_unavail_add(struct mpool_descriptor *mp, struct omf_devparm_descriptor *devparm);
+
+/**
+ * mpool_desc_pdmc_add() - Add a device in its media class.
+ * @mp:
+ * @pdh:
+ * @omf_devparm:
+ * @check_only: if true, the call doesn't change any state, it only check
+ *	if the PD could be added in a media class.
+ *
+ * If the media class doesn't exist yet, it is created here.
+ *
+ * This function has two inputs related to the PD it is acting on:
+ *  "phd"
+ *  and "omf_devparm"
+ *
+ * If omf_devparm is NULL, it means that the media class in which the PD must
+ * be placed is derived from mp->pds_pdv[pdh].pdi_parm.dpr_prop
+ * In that case the PD properties (.dpr_prop) must be updated and
+ * correct when entering this function.
+ * devparm is NULL when the device is available, that means the discovery
+ * was able to update .dpr_prop.
+ *
+ * If omf_devparm is not NULL, it means that the media class in which the PD
+ * must be placed is derived from omf_devparm.
+ * This is used when unavailable PDs are placed in their media class. In this
+ * situation (because the PD is unavailable) the discovery couldn't discover
+ * the PD properties and mp->pds_pdv[pdh].pdi_parm.dpr_prop has not been
+ * updated because of that.
+ * So we can't use .dpr_prop to place the PD in its class, instead we use what
+ * is coming from the persitent metadata (PD state record in MDC0). Aka
+ * omf_devparm.
+ * mp->pds_pdv[pdh].pdi_parm.dpr_prop will be update if/when the PD is available
+ * again.
+ *
+ * Restrictions in placing PDs in media classes
+ * --------------------------------------------
+ * This function enforces these restrictions.
+ * These restrictions are:
+ * a) in a mpool, for a given mclassp (enum mp_media_classp), there is
+ *    at maximum one media class.
+ * b) All drives of a media class must checksummed or none, no mix allowed.
+ * c) The STAGING and CAPACITY classes must be both checksummed or both not
+ *    checksummed.
+ *
+ * Locking:
+ * -------
+ *	Should be called with mp.pds_pdvlock held in write.
+ *	Except if mpool is single threaded (during activate for example).
+ */
+int
+mpool_desc_pdmc_add(
+	struct mpool_descriptor		*mp,
+	u16				 pdh,
+	struct omf_devparm_descriptor	*omf_devparm,
+	bool				 check_only);
+
+int uuid_to_mpdesc_insert(struct rb_root *root, struct mpool_descriptor *data);
+
+int
+mpool_dev_sbwrite(
+	struct mpool_descriptor    *mp,
+	struct mpool_dev_info      *pd,
+	struct omf_sb_descriptor   *sbmdc0);
+
+int
+mpool_mdc0_sb2obj(
+	struct mpool_descriptor    *mp,
+	struct omf_sb_descriptor   *sb,
+	struct pmd_layout         **l1,
+	struct pmd_layout         **l2);
+
+int mpool_desc_init_newpool(struct mpool_descriptor *mp, u32 flags);
+
+int
+mpool_dev_init_all(
+	struct mpool_dev_info  *pdv,
+	u64                     dcnt,
+	char                  **dpaths,
+	struct pd_prop	       *pd_prop);
+
+void mpool_mdc_cap_init(struct mpool_descriptor *mp, struct mpool_dev_info *pd);
+
+int
+mpool_desc_init_sb(
+	struct mpool_descriptor    *mp,
+	struct omf_sb_descriptor   *sbmdc0,
+	u32                         flags,
+	bool                       *mc_resize);
+
+int mpool_dev_sbwrite_newpool(struct mpool_descriptor *mp, struct omf_sb_descriptor *sbmdc0);
+
+int check_for_dups(char **listv, int cnt, int *dup, int *offset);
+
+void fill_in_devprops(struct mpool_descriptor *mp, u64 pdh, struct mpool_devprops *dprop);
+
+int mpool_create_rmlogs(struct mpool_descriptor *mp, u64 mlog_cap);
+
+struct mpool_descriptor *mpool_desc_alloc(void);
+
+void mpool_desc_free(struct mpool_descriptor *mp);
+
+int mpool_dev_check_new(struct mpool_descriptor *mp, struct mpool_dev_info *pd);
+
+static inline enum pd_status mpool_pd_status_get(struct mpool_dev_info *pd)
+{
+	enum pd_status  val;
+
+	/* Acquire semantics used so that no reads will be re-ordered from
+	 * before to after this read.
+	 */
+	val = atomic_read_acquire(&pd->pdi_status);
+
+	return val;
+}
+
+static inline void mpool_pd_status_set(struct mpool_dev_info *pd, enum pd_status status)
+{
+	/* All prior writes must be visible prior to the status change */
+	smp_wmb();
+	atomic_set(&pd->pdi_status, status);
+}
+
+/**
+ * mpool_get_mpname() - Get the mpool name
+ * @mp:     mpool descriptor of the mpool
+ * @mpname: buffer to copy the mpool name into
+ * @mplen:  buffer length
+ *
+ * Return:
+ * %0 if successful, -EINVAL otherwise
+ */
+static inline int mpool_get_mpname(struct mpool_descriptor *mp, char *mpname, size_t mplen)
+{
+	if (!mp || !mpname)
+		return -EINVAL;
+
+	strlcpy(mpname, mp->pds_name, mplen);
+
+	return 0;
+}
+
+
+#endif /* MPOOL_MPCORE_H */
diff --git a/drivers/mpool/params.h b/drivers/mpool/params.h
new file mode 100644
index 000000000000..5d1f40857a2a
--- /dev/null
+++ b/drivers/mpool/params.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+
+#ifndef MPOOL_PARAMS_H
+#define MPOOL_PARAMS_H
+
+#define MPOOL_MDC_SET_SZ                16
+
+/* Mpool metadata container compaction retries; keep relatively small */
+#define MPOOL_MDC_COMPACT_RETRY_DEFAULT 5
+
+/*
+ * Space map allocation zones per drive; bounds number of concurrent obj
+ * allocs
+ */
+#define MPOOL_SMAP_RGNCNT_DEFAULT       4
+
+/*
+ * Space map alignment in number of zones.
+ */
+#define MPOOL_SMAP_ZONEALIGN_DEFAULT    1
+
+/*
+ * Number of concurent jobs for loading user MDC 1~N
+ */
+#define MPOOL_OBJ_LOAD_JOBS_DEFAULT     8
+
+/*
+ * Defaults for MDC1/255 pre-compaction.
+ */
+#define MPOOL_PCO_PCTFULL               70
+#define MPOOL_PCO_PCTGARBAGE            20
+#define MPOOL_PCO_NBNOALLOC              2
+#define MPOOL_PCO_PERIOD                 5
+#define MPOOL_PCO_FILLBIAS	      1000
+#define MPOOL_PD_USAGE_PERIOD        60000
+#define MPOOL_CREATE_MDC_PCTFULL  (MPOOL_PCO_PCTFULL - MPOOL_PCO_PCTGARBAGE)
+#define MPOOL_CREATE_MDC_PCTGRBG   MPOOL_PCO_PCTGARBAGE
+
+
+/**
+ * struct mpcore_params - mpool core parameters. Not exported to public API.
+ * @mp_mdc0cap: MDC0 capacity,  *ONLY* for testing purpose
+ * @mp_mdcncap: MDCN capacity,  *ONLY* for testing purpose
+ * @mp_mdcnnum: Number of MDCs, *ONLY* for testing purpose
+ * @mp_smaprgnc:
+ * @mp_smapalign:
+ * @mp_spare:
+ * @mp_objloadjobs: number of concurrent MDC loading jobs
+ *
+ * The below parameters starting with "pco" are used for the pre-compaction
+ * of MDC1/255
+ * @mp_pcopctfull:  % (0-100) of fill of MDCi active mlog that must be reached
+ *	before a pre-compaction is attempted.
+ * @mp_pcopctgarbage:  % (0-100) of garbage in MDCi active mlog that must be
+ *	reached	before a pre-compaction is attempted.
+ * @mp_pconbnoalloc: Number of MDCs from which no object is allocated from.
+ *	If 0, that disable the background pre compaction.
+ * @mp_pcoperiod: In seconds. Period at which a background thread check if
+ *	a MDC needs compaction.
+ * @mp_pcofillbias: If the next mpool MDC has less objects than
+ *	(current MDC objects - pcofillbias), then allocate an object
+ *	from the next MDC instead of from the current one.
+ *	This bias favors object allocation from less filled MDCs (in term
+ *	of number of committed objects).
+ *	The bigger the number, the less bias.
+ * @mp_crtmdcpctfull: percent full threshold across all MDCs in combination
+ *      with crtmdcpctgrbg percent is used as a trigger to create new MDCs
+ * @mp_crtmdcpctgrbg: percent garbage threshold in combination with
+ *      @crtmdcpctfull percent is used as a trigger to create new MDCs
+ * @mp_mpusageperiod: period at which a background thread check mpool space
+ * usage, in milliseconds
+ */
+struct mpcore_params {
+	u64    mp_mdcnum;
+	u64    mp_mdc0cap;
+	u64    mp_mdcncap;
+	u64    mp_smaprgnc;
+	u64    mp_smapalign;
+	u64    mp_spare;
+	u64    mp_objloadjobs;
+	u64    mp_pcopctfull;
+	u64    mp_pcopctgarbage;
+	u64    mp_pconbnoalloc;
+	u64    mp_pcoperiod;
+	u64    mp_pcofillbias;
+	u64    mp_crtmdcpctfull;
+	u64    mp_crtmdcpctgrbg;
+	u64    mp_mpusageperiod;
+};
+
+/**
+ * mpcore_params_defaults() -
+ */
+static inline void mpcore_params_defaults(struct mpcore_params *params)
+{
+	params->mp_mdcnum          = MPOOL_MDCNUM_DEFAULT;
+	params->mp_mdc0cap         = 0;
+	params->mp_mdcncap         = 0;
+	params->mp_smaprgnc        = MPOOL_SMAP_RGNCNT_DEFAULT;
+	params->mp_smapalign       = MPOOL_SMAP_ZONEALIGN_DEFAULT;
+	params->mp_spare           = MPOOL_SPARES_DEFAULT;
+	params->mp_pcopctfull	   = MPOOL_PCO_PCTFULL;
+	params->mp_pcopctgarbage   = MPOOL_PCO_PCTGARBAGE;
+	params->mp_pconbnoalloc    = MPOOL_PCO_NBNOALLOC;
+	params->mp_pcoperiod       = MPOOL_PCO_PERIOD;
+	params->mp_pcofillbias     = MPOOL_PCO_FILLBIAS;
+	params->mp_crtmdcpctfull   = MPOOL_CREATE_MDC_PCTFULL;
+	params->mp_crtmdcpctgrbg   = MPOOL_CREATE_MDC_PCTGRBG;
+	params->mp_mpusageperiod   = MPOOL_PD_USAGE_PERIOD;
+	params->mp_objloadjobs     = MPOOL_OBJ_LOAD_JOBS_DEFAULT;
+}
+
+#endif /* MPOOL_PARAMS_H */
diff --git a/drivers/mpool/pd.h b/drivers/mpool/pd.h
new file mode 100644
index 000000000000..c8faefc7cf11
--- /dev/null
+++ b/drivers/mpool/pd.h
@@ -0,0 +1,202 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+
+#ifndef MPOOL_PD_H
+#define MPOOL_PD_H
+
+#include <linux/uio.h>
+
+#include "uuid.h"
+#include "mpool_ioctl.h"
+
+/* Returns PD length in bytes. */
+#define PD_LEN(_pd_prop) ((_pd_prop)->pdp_devsz)
+
+/* Returns PD sector size (exponent, power of 2) */
+#define PD_SECTORSZ(_pd_prop) ((_pd_prop)->pdp_sectorsz)
+
+/* Return PD sector size mask */
+#define PD_SECTORMASK(_pd_prop) ((uint64_t)(1 << PD_SECTORSZ(_pd_prop)) - 1)
+
+struct omf_devparm_descriptor;
+
+/**
+ * struct pd_dev_parm -
+ * @dpr_prop:		drive properties including zone parameters
+ * @dpr_dev_private:    private info for implementation
+ * @dpr_name:           device name
+ */
+struct pd_dev_parm {
+	struct pd_prop	         dpr_prop;
+	void		        *dpr_dev_private;
+	char                     dpr_name[PD_NAMESZ_MAX];
+};
+
+/* Shortcuts */
+#define dpr_zonepg        dpr_prop.pdp_zparam.dvb_zonepg
+#define dpr_zonetot       dpr_prop.pdp_zparam.dvb_zonetot
+#define dpr_devsz         dpr_prop.pdp_devsz
+#define dpr_didstr        dpr_prop.pdp_didstr
+#define dpr_mediachar     dpr_prop.pdp_mediachar
+#define dpr_cmdopt        dpr_prop.pdp_cmdopt
+#define dpr_optiosz       dpr_prop.pdp_optiosz
+
+/**
+ * enum pd_status - Transient drive status.
+ * @PD_STAT_UNDEF:       undefined; should never occur
+ * @PD_STAT_ONLINE:      drive is responding to I/O requests
+ * @PD_STAT_SUSPECT:     drive is failing some I/O requests
+ * @PD_STAT_OFFLINE:     drive declared non-responsive to I/O requests
+ * @PD_STAT_UNAVAIL:     drive path not provided or open failed when mpool was opened
+ *
+ * Transient drive status, these are stored as atomic_t variable
+ * values
+ */
+enum pd_status {
+	PD_STAT_UNDEF      = 0,
+	PD_STAT_ONLINE     = 1,
+	PD_STAT_SUSPECT    = 2,
+	PD_STAT_OFFLINE    = 3,
+	PD_STAT_UNAVAIL    = 4
+};
+
+_Static_assert((PD_STAT_UNAVAIL < 256), "enum pd_status must fit in uint8_t");
+
+/**
+ * enum pd_cmd_opt - drive command options
+ * @PD_CMD_DISCARD:	     the device has TRIM/UNMAP command.
+ * @PD_CMD_SECTOR_UPDATABLE: the device can be read/written with sector granularity.
+ * @PD_CMD_DIF_ENABLED:      T10 DIF is used on this device.
+ * @PD_CMD_SED_ENABLED:      Self encrypting enabled
+ * @PD_CMD_DISCARD_ZERO:     the device supports discard_zero
+ * @PD_CMD_RDONLY:           activate mpool with PDs in RDONLY mode,
+ *                           write/discard commands are No-OPs.
+ * Defined as a bit vector so can combine.
+ * Fields holding such a vector should uint64_t.
+ *
+ * TODO: we need to find a way to detect if SED is enabled on a device
+ */
+enum pd_cmd_opt {
+	PD_CMD_NONE             = 0,
+	PD_CMD_DISCARD          = 0x1,
+	PD_CMD_SECTOR_UPDATABLE = 0x2,
+	PD_CMD_DIF_ENABLED      = 0x4,
+	PD_CMD_SED_ENABLED      = 0x8,
+	PD_CMD_DISCARD_ZERO     = 0x10,
+	PD_CMD_RDONLY           = 0x20,
+};
+
+/**
+ * enum pd_devtype - Device types
+ * @PD_DEV_TYPE_BLOCK_STREAM: Block device implementing streams.
+ * @PD_DEV_TYPE_BLOCK_STD:    Standard (non-streams) device (SSD, HDD).
+ * @PD_DEV_TYPE_FILE:	      File in user space for UT.
+ * @PD_DEV_TYPE_MEM:	      Memory semantic device, e.g. NVDIMM direct access (raw or dax mode)
+ * @PD_DEV_TYPE_ZONE:	      zone-like device, e.g., open channel SSD and SMR HDD (using ZBC/ZAC)
+ * @PD_DEV_TYPE_BLOCK_NVDIMM: Standard (non-streams) NVDIMM in sector mode.
+ */
+enum pd_devtype {
+	PD_DEV_TYPE_BLOCK_STREAM = 1,
+	PD_DEV_TYPE_BLOCK_STD,
+	PD_DEV_TYPE_FILE,
+	PD_DEV_TYPE_MEM,
+	PD_DEV_TYPE_ZONE,
+	PD_DEV_TYPE_BLOCK_NVDIMM,
+	PD_DEV_TYPE_LAST = PD_DEV_TYPE_BLOCK_NVDIMM,
+};
+
+_Static_assert((PD_DEV_TYPE_LAST < 256), "enum pd_devtype must fit in uint8_t");
+
+/**
+ * enum pd_state - Device states
+ * @PD_DEV_STATE_AVAIL:       Device is available
+ * @PD_DEV_STATE_UNAVAIL:     Device is unavailable
+ */
+enum pd_state {
+	PD_DEV_STATE_UNDEFINED = 0,
+	PD_DEV_STATE_AVAIL = 1,
+	PD_DEV_STATE_UNAVAIL = 2,
+	PD_DEV_STATE_LAST = PD_DEV_STATE_UNAVAIL,
+};
+
+_Static_assert((PD_DEV_STATE_LAST < 256), "enum pd_state must fit in uint8_t");
+
+/*
+ * pd API functions -- device-type independent dparm ops
+ */
+
+/*
+ * Error codes: All pd functions can return one or more of:
+ *
+ * -EINVAL    invalid fn args
+ * -EBADSLT   attempt to read or write a bad zone on a zone device
+ * -EIO       all other errors
+ */
+
+int pd_dev_open(const char *path, struct pd_dev_parm *dparm, struct pd_prop *pd_prop);
+int pd_dev_close(struct pd_dev_parm *dparm);
+int pd_dev_flush(struct pd_dev_parm *dparm);
+
+/**
+ * pd_bio_erase() -
+ * @pd:
+ * @zaddr:
+ * @zonecnt:
+ * @reads_erased: whether the data can be read post DISCARD
+ *
+ * Return:
+ */
+int pd_zone_erase(struct pd_dev_parm *dparm, u64 zaddr, u32 zonecnt, bool reads_erased);
+
+/*
+ * pd API functions - device dependent operations
+ */
+
+/**
+ * pd_zone_pwritev() -
+ * @pd:
+ * @iov:
+ * @iovcnt:
+ * @zaddr:
+ * @boff: offset in bytes from the start of "zaddr".
+ * @opflags:
+ *
+ * Return:
+ */
+int pd_zone_pwritev(struct pd_dev_parm *dparm, const struct kvec *iov,
+		    int iovcnt, u64 zaddr, loff_t boff, int opflags);
+
+/**
+ * pd_zone_pwritev_sync() -
+ * @pd:
+ * @iov:
+ * @iovcnt:
+ * @zaddr:
+ * @boff: Offset in bytes from the start of zaddr.
+ *
+ * Return:
+ */
+int pd_zone_pwritev_sync(struct pd_dev_parm *dparm, const struct kvec *iov,
+			 int iovcnt, u64 zaddr, loff_t boff);
+
+/**
+ * pd_zone_preadv() -
+ * @pd:
+ * @iov:
+ * @iovcnt:
+ * @zaddr: target zone for this I/O
+ * @boff:    byte offset into the target zone
+ *
+ * Return:
+ */
+int pd_zone_preadv(struct pd_dev_parm *dparm, const struct kvec *iov,
+		   int iovcnt, u64 zaddr, loff_t boff);
+
+void pd_dev_set_unavail(struct pd_dev_parm *dparm, struct omf_devparm_descriptor *omf_devparm);
+
+int pd_init(void) __cold;
+void pd_exit(void) __cold;
+
+#endif /* MPOOL_PD_H */
diff --git a/drivers/mpool/pmd.h b/drivers/mpool/pmd.h
new file mode 100644
index 000000000000..5fd6ca020fd1
--- /dev/null
+++ b/drivers/mpool/pmd.h
@@ -0,0 +1,379 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+
+#ifndef MPOOL_PMD_H
+#define MPOOL_PMD_H
+
+#include <linux/atomic.h>
+#include <linux/rbtree.h>
+#include <linux/mutex.h>
+#include <linux/workqueue.h>
+#include <linux/spinlock.h>
+
+#include "mpool_ioctl.h"
+#include "omf_if.h"
+#include "pmd_obj.h"
+
+/**
+ * DOC: Module info.
+ *
+ * Pool metadata (pmd) module.
+ *
+ * Implements functions for mpool metadata management.
+ *
+ */
+
+struct mpool_descriptor;
+struct mpool_dev_info;
+struct mp_mdc;
+struct pmd_layout;
+struct mpool_config;
+
+/**
+ * DOC: Object lifecycle
+ *
+ * +) all mblock/mlog objects are owned by mpool layer users, excepting
+ *     mdc mlogs
+ * +) users are responsible for object lifecycle mgmt and must not violate it;
+ *    e.g. by using an object handle (layout pointer) after deleting that
+ *    object
+ * +) the mpool layer never independently aborts or deletes user objects
+ */
+
+/**
+ * DOC: Object ids
+ * Object ids for mblocks and mlogs are a unit64 of the form:
+ * <uniquifier (52-bits), type (4-bits), slot # (8 bits)>
+ *
+ */
+
+/**
+ * DOC: NOTES
+ * + metadata for a given object is stored in the mdc specified by slot #
+ * + uniquifiers are only guaranteed unique for a given slot #
+ * + metadata for all mdc (except mdc 0) are stored in mdc 0
+ * + mdc 0 is a distinguished container whose metadata is stored in superblocks
+ * + mdc 0 only stores object metadata for mdc 1-255
+ * + mdc N is implemented via mlogs with objids (2N, MLOG, 0) & (2N+1, MLOG, 0)
+ * + mdc 0 mlog objids are (0, MLOG, 0) and (1, MLOG, 0) where a slot # of 0
+ *   indicates the mlog metadata is stored in mdc 0 whereas it is actually in
+ *   superblocks; see comments in pmd_mdc0_init() for how we exploit this.
+ */
+
+/**
+ * struct pre_compact_ctrs - objects records counters, used for pre compaction of MDC1/255.
+ * @pcc_cr:   count of object create records
+ * @pcc_up:   count of object update records
+ * @pcc_del:  count of object delete records. If the object is shceduled for
+ *	deletion in the background, the counter is incremented (while the
+ *	delete record has not been written yet).
+ * @pcc_er:   count of object erase records
+ * @pcc_cobj: count of committed objects (and not deleted).
+ * @pcc_cap: In bytes, size of each mlog of the MDC
+ * @pcc_len: In bytes, how much is filled the active mlog.
+ *
+ * One such structure per mpool MDC.
+ *
+ * Locking:
+ *	Updates are serialized by the MDC compact lock.
+ *	The reads by the pre-compaction thread are done without holding any
+ *	lock. This is why atomic variables are used.
+ *	However because the variables are integers, the atomic read translates
+ *	into a simple load and the set translate in a simple store.
+ *
+ * The counters pcc_up, pcc_del, pcc_er are cleared at each compaction.
+ *
+ * Relaxed access is appropriate for all of these atomics
+ */
+struct pre_compact_ctrs {
+	atomic_t   pcc_cr;
+	atomic_t   pcc_up;
+	atomic_t   pcc_del;
+	atomic_t   pcc_er;
+	atomic_t   pcc_cobj;
+	atomic64_t pcc_cap;
+	atomic64_t pcc_len;
+};
+
+/**
+ * struct credit_info - mdc selector info
+ * @ci_credit:      available credit
+ * @ci_free:        available free space
+ * @ci_slot:        MDC slot number
+ *
+ * Contains information about available credit and a balance. Available
+ * credit is based on an rate at which records can be written to
+ * mdc such that all MDC will fill at the same time.
+ */
+struct credit_info  {
+	u64                 ci_credit;
+	u64                 ci_free;
+	u8                  ci_slot;
+};
+
+/**
+ * struct pmd_mdc_stats - per MDC space usage stats
+ * @pms_mblock_alen: mblock alloc len
+ * @pms_mblock_wlen: mblock write len
+ * @pms_mlog_alen: mlog alloc len
+ * @pms_mblock_cnt: mblock count
+ * @pms_mlog_cnt: mlog count
+ */
+struct pmd_mdc_stats {
+	u64    pms_mblock_alen;
+	u64    pms_mblock_wlen;
+	u64    pms_mlog_alen;
+	u32    pms_mblock_cnt;
+	u32    pms_mlog_cnt;
+};
+
+/**
+ * struct pmd_mdc_info - Metadata container (mdc) info.
+ * @mmi_compactlock: compaction lock
+ * @mmi_uc_lock:     uncommitted objects tree lock
+ * @mmi_uc_root:     uncommitted objects tree root
+ * @mmi_co_lock:     committed objects tree lock
+ * @mmi_co_root:     committed objects tree root
+ * @mmi_uqlock:      uniquifier lock
+ * @mmi_luniq:       uniquifier of last object assigned to container
+ * @mmi_mdc:         MDC implementing container
+ * @mmi_recbuf:      buffer for (un)packing log records
+ * @mmi_lckpt:       last objid checkpointed
+ * @mmi_stats:       per-MDC usage stats
+ * @mmi_stats_lock:  lock for protecting mmi_stats
+ * @mmi_pco_cnt:     counters used by the pre compaction of MDC1/255.
+ * @mmi_mdcver:      version of the mdc content on media when the mpool was
+ *                   activated. That may not be the current version on media
+ *                   if a MDC metadata conversion took place during activate.
+ * @mmi_credit       MDC credit info
+ *
+ * LOCKING:
+ * + mmi_luniq: protected by uqlock
+ * + mmi_mdc, recbuf, lckpt: protected by compactlock
+ * + mmi_co_root: protected by co_lock
+ * + mmi_uc_root: protected by uc_lock
+ * + mmi_stats: protected by mmi_stats_lock
+ * + mmi_pco_counters: updates serialized by mmi_compactlock
+ *
+ * NOTE:
+ *  + for mdc0 mmi_luniq is the slot # of the last mdc created
+ *  + logging to a mdc cannot execute concurrent with compacting
+ *    that mdc;
+ *    mmi_compactlock is used to enforce this
+ *  + compacting a mdc requires freezing both the list of committed
+ *    objects in that mdc and the metadata for those objects;
+ *    compactlock facilitates this in a way that avoids locking each
+ *    object during compaction; as a result object metadata updates
+ *    are serialized, but even without mdc compaction this would be
+ *    the case because all such metadata updates must be logged to
+ *    the object's mdc and mdc logging is inherently serial
+ *  + see struct pmd_layout comments for specifics on how
+ *    compactlock is used to freeze metadata for committed objects
+ */
+struct pmd_mdc_info {
+	struct mutex            mmi_compactlock;
+	char                   *mmi_recbuf;
+	u64                     mmi_lckpt;
+	struct mp_mdc          *mmi_mdc;
+
+	____cacheline_aligned
+	struct mutex            mmi_uc_lock;
+	struct rb_root          mmi_uc_root;
+
+	____cacheline_aligned
+	struct rw_semaphore     mmi_co_lock;
+	struct rb_root          mmi_co_root;
+
+	____cacheline_aligned
+	struct mutex            mmi_uqlock;
+	u64                     mmi_luniq;
+
+	____cacheline_aligned
+	struct credit_info      mmi_credit;
+	struct omf_mdcver       mmi_mdcver;
+
+	____cacheline_aligned
+	struct mutex            mmi_stats_lock;
+	struct pmd_mdc_stats    mmi_stats;
+
+	struct pre_compact_ctrs mmi_pco_cnt;
+};
+
+/**
+ * struct pmd_mdc_selector - Object containing MDC slots for allocation
+ * @mds_tbl_idx:      idx of the MDC slot selector in the mds_tbl
+ * @mds_tbl:          slot table used for MDC selection
+ * @mds_mdc:          scratch pad for sorting mdc by free size
+ *
+ * LOCKING:
+ *  + mdi_slotvlock lock will be taken to protect this object.
+ *
+ */
+struct pmd_mdc_selector {
+	atomic_t    mds_tbl_idx;
+	u8          mds_tbl[MDC_TBL_SZ];
+	void       *mds_smdc[MDC_SLOTS];
+};
+
+/**
+ * struct pmd_mda_info - Metadata container array (mda).
+ * @mdi_slotvlock:   it is assumed that this spinlock is NOT taken from interrupt context
+ * @mdi_slotvcnt:    number of active slotv entries
+ * @mdi_slotv:       per mdc info
+ * @mdi_sel:         MDC allocation selector
+ *
+ * LOCKING:
+ *  + mdi_slotvcnt: protected by mdi_slotvlock
+ *
+ * NOTE:
+ *  + mdi_slotvcnt only ever increases so mdi_slotv[x], x < mdi_slotvcnt, is
+ *    always active
+ *  + all mdi_slotv[] entries are initialized whether or not active so they
+ *    can all be accessed w/o locking except as required by pmd_mdc_info struct
+ */
+struct pmd_mda_info {
+	spinlock_t              mdi_slotvlock;
+	u16                     mdi_slotvcnt;
+
+	struct pmd_mdc_info     mdi_slotv[MDC_SLOTS];
+	struct pmd_mdc_selector mdi_sel;
+};
+
+/**
+ * struct pmd_obj_load_work - work struct for loading MDC 1~N
+ * @olw_work:     work struct
+ * @olw_mp:
+ * @olw_progress: Progress index. It is an (atomic_t *) so that multiple
+ *                pmd_obj_load_work structs can point to a single atomic_t
+ *                for grabbing the next MDC number to be processed.
+ * @olw_err:
+ */
+struct pmd_obj_load_work {
+	struct work_struct          olw_work;
+	struct mpool_descriptor    *olw_mp;
+	atomic_t                   *olw_progress; /* relaxed is correct */
+	atomic_t                   *olw_err;
+};
+
+/**
+ * pmd_mpool_activate() - Load all metadata for mpool mp.
+ * @mp:
+ * @mdc01:
+ * @mdc02:
+ * @create:
+ *
+ * Load all metadata for mpool mp; create flag indicates if is a new pool;
+ * caller must ensure no other thread accesses mp until activation is complete.
+ * note: pmd module owns mdc01/2 memory mgmt whether succeeds or fails
+ *
+ * Return: %0 if successful, -errno otherwise
+ */
+int pmd_mpool_activate(struct mpool_descriptor *mp, struct pmd_layout *mdc01,
+		       struct pmd_layout *mdc02, int create);
+
+/**
+ * pmd_mpool_deactivate() - Deactivate mpool mp.
+ * @mp:
+ *
+ * Free all metadata for mpool mp excepting mp itself; caller must ensure
+ * no other thread can access mp during deactivation.
+ */
+void pmd_mpool_deactivate(struct mpool_descriptor *mp);
+
+/**
+ * pmd_mdc_alloc() - Add a metadata container to mpool.
+ * @mp:
+ * @mincap:
+ * @iter: the role of this parameter is to get the active mlogs of the mpool
+ *	MDCs uniformely spread on the mpool devices.
+ *	When pmd_mdc_alloc() is called in a loop to allocate several mpool MDCs,
+ *	iter should be incremented at each subsequent call.
+ *
+ * Add a metadata container (mdc) to mpool with a minimum capacity of mincap
+ * bytes.  Once added an mdc can never be deleted.
+ *
+ * Return: %0 if successful, -errno otherwise
+ */
+int pmd_mdc_alloc(struct mpool_descriptor *mp, u64 mincap, u32 iter);
+
+/**
+ * pmd_mdc_cap() - Get metadata container (mdc) capacity stats.
+ * @mp:
+ * @mdcmax:
+ * @mdccap:
+ * @mdc0cap:
+ *
+ * Get metadata container (mdc) stats: count, aggregate capacity ex-mdc0 and
+ * mdc0 cap
+ */
+void pmd_mdc_cap(struct mpool_descriptor *mp, u64 *mdcmax, u64 *mdccap, u64 *mdc0cap);
+
+/**
+ * pmd_prop_mcconfig() -
+ * @mp:
+ * @pd:
+ * @compacting: if true, called by a compaction.
+ *
+ * Persist state (new or update) for drive pd; caller must hold mp.pdvlock
+ * if pd is an in-use member of mp.pdv.
+ *
+ * Locking: caller must hold MDC0 compact lock.
+ *
+ * Return: %0 if successful, -errno otherwise
+ */
+int pmd_prop_mcconfig(struct mpool_descriptor *mp, struct mpool_dev_info *pd, bool compacting);
+
+/**
+ * pmd_prop_mcspare() -
+ * @mp:
+ * @mclassp:
+ * @spzone:
+ * @compacting: if true, called by a compaction.
+ *
+ * Persist spare zone info for drives in media class (new or update).
+ *
+ * Locking: caller must hold MDC0 compact lock.
+ *
+ * Return: %0 if successful, -errno otherwise
+ */
+int pmd_prop_mcspare(struct mpool_descriptor *mp, enum mp_media_classp mclassp,
+		     u8 spzone, bool compacting);
+
+int pmd_prop_mpconfig(struct mpool_descriptor *mp, const struct mpool_config *cfg, bool compacting);
+
+/**
+ * pmd_precompact_start() - start MDC1/255 precompaction
+ * @mp:
+ */
+void pmd_precompact_start(struct mpool_descriptor *mp);
+
+/**
+ * pmd_precompact_stop() - stop MDC1/255 precompaction
+ * @mp:
+ */
+void pmd_precompact_stop(struct mpool_descriptor *mp);
+
+/**
+ * pmd_mdc_addrec_version() -add a version record in a mpool MDC.
+ * @mp:
+ * @cslot:
+ */
+int pmd_mdc_addrec_version(struct mpool_descriptor *mp, u8 cslot);
+
+int pmd_log_delete(struct mpool_descriptor *mp, u64 objid);
+
+int pmd_log_create(struct mpool_descriptor *mp, struct pmd_layout *layout);
+
+int pmd_log_erase(struct mpool_descriptor *mp, u64 objid, u64 gen);
+
+int pmd_log_idckpt(struct mpool_descriptor *mp, u64 objid);
+
+#define PMD_MDC0_COMPACTLOCK(_mp) \
+	pmd_mdc_lock(&((_mp)->pds_mda.mdi_slotv[0].mmi_compactlock), 0)
+
+#define PMD_MDC0_COMPACTUNLOCK(_mp) \
+	pmd_mdc_unlock(&((_mp)->pds_mda.mdi_slotv[0].mmi_compactlock))
+
+#endif /* MPOOL_PMD_H */
diff --git a/drivers/mpool/pmd_obj.h b/drivers/mpool/pmd_obj.h
new file mode 100644
index 000000000000..7cf5dea80f9d
--- /dev/null
+++ b/drivers/mpool/pmd_obj.h
@@ -0,0 +1,499 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+
+#ifndef MPOOL_PMD_OBJ_H
+#define MPOOL_PMD_OBJ_H
+
+#include <linux/sort.h>
+#include <linux/rbtree.h>
+#include <linux/kref.h>
+#include <linux/rwsem.h>
+#include <linux/workqueue.h>
+
+#include "uuid.h"
+#include "mpool_ioctl.h"
+#include "omf_if.h"
+#include "mlog.h"
+
+struct mpool_descriptor;
+struct pmd_mdc_info;
+
+/*
+ * objid uniquifier checkpoint interval; used to avoid reissuing an outstanding
+ * objid after a crash; supports pmd_{mblock|mlog}_realloc()
+ */
+#define OBJID_UNIQ_POW2 8
+#define OBJID_UNIQ_DELTA (1 << OBJID_UNIQ_POW2)
+
+/* MDC_SLOTS is 256 [0,255] to fit in 8-bit slot field in objid.
+ */
+#define MDC_SLOTS           256
+#define MDC_TBL_SZ          (MDC_SLOTS * 4)
+
+#define UROOT_OBJID_LOG1 logid_make(0, 1)
+#define UROOT_OBJID_LOG2 logid_make(1, 1)
+#define UROOT_OBJID_MAX  1
+
+#define MDC0_OBJID_LOG1 logid_make(0, 0)
+#define MDC0_OBJID_LOG2 logid_make(1, 0)
+
+/**
+ * enum pmd_lock_class -
+ * @PMD_NONE:
+ * @PMD_OBJ_CLIENT:
+ *      For layout rwlock,
+ *              - Object id contains a non-zero slot number
+ * @PMD_MDC_NORMAL:
+ *      For layout rwlock,
+ *              - Object id contains a zero slot number AND
+ *              - Object id is neither of the well-known MDC-0 objids
+ *      For pmd_mdc_info.* locks,
+ *              - Array index of pmd_mda_info.slov[] is > 0.
+ * @PMD_MDC_ZERO:
+ *      For layout rwlock,
+ *              - Object id contains a zero slot number AND
+ *              - Object id is either of the well-known MDC-0 objids
+ *      For pmd_mdc_info.* locks,
+ *              - Array index of pmd_mda_info.slov[] is == 0.
+ *
+ * NOTE:
+ * - Object layout rw locks must be acquired before any MDC locks.
+ * - MDC-0 locks of a given class are below MDC-1/255 locks of those same
+ *   classes.
+ */
+enum pmd_lock_class {
+	PMD_NONE       = 0,
+	PMD_OBJ_CLIENT = 1,
+	PMD_MDC_NORMAL = 2,
+	PMD_MDC_ZERO   = 3,
+};
+
+/**
+ * enum pmd_obj_op -
+ * @PMD_OBJ_LOAD:
+ * @PMD_OBJ_ALLOC:
+ * @PMD_OBJ_COMMIT:
+ * @PMD_OBJ_ABORT:
+ * @PMD_OBJ_DELETE:
+ */
+enum pmd_obj_op {
+	PMD_OBJ_LOAD     = 1,
+	PMD_OBJ_ALLOC    = 2,
+	PMD_OBJ_COMMIT   = 3,
+	PMD_OBJ_ABORT    = 4,
+	PMD_OBJ_DELETE   = 5,
+};
+
+/**
+ * enum pmd_layout_state - object state flags
+ * @PMD_LYT_COMMITTED: object is committed to media
+ * @PMD_LYT_REMOVED:   object logically removed (aborted or deleted)
+ */
+enum pmd_layout_state {
+	PMD_LYT_COMMITTED  = 0x01,
+	PMD_LYT_REMOVED    = 0x02,
+};
+
+/**
+ * struct pmd_layout_mlpriv - mlog private data for pmd_layout
+ * @mlp_uuid:       unique ID per mlog
+ * @mlp_lstat:      mlog status
+ * @mlp_nodeoml:    "open mlog" rbtree linkage
+ */
+struct pmd_layout_mlpriv {
+	struct mpool_uuid   mlp_uuid;
+	struct rb_node      mlp_nodeoml;
+	struct mlog_stat    mlp_lstat;
+};
+
+/**
+ * union pmd_layout_priv - pmd_layout object type specific private data
+ * @mlpriv: mlog private data
+ */
+union pmd_layout_priv {
+	struct pmd_layout_mlpriv    mlpriv;
+};
+
+/**
+ * struct pmd_layout - object layout (in-memory version)
+ * @eld_nodemdc: rbtree node for uncommitted and committed objects
+ * @eld_objid:   object ID associated with layout
+ * @eld_mblen:   Amount of data written in the mblock in bytes (0 for mlogs)
+ * @eld_state:   enum pmd_layout_state
+ * @eld_flags:   enum mlog_open_flags for mlogs
+ * @eld_gen:     object generation
+ * @eld_ld:
+ * @eld_ref:     user ref count from alloc/get/put
+ * @eld_rwlock:  implements pmd_obj_*lock() for this layout
+ * @dle_mlpriv:  mlog private data
+ *
+ * LOCKING:
+ * + objid: constant; no locking required
+ * + lstat: lstat and *lstat are protected by pmd_obj_*lock()
+ * + all other fields: see notes
+ *
+ * NOTE:
+ * + committed object fields (other): to update hold pmd_obj_wrlock()
+ *   AND
+ *   compactlock for object's mdc; to read hold pmd_obj_*lock()
+ *   See the comments associated with struct pmd_mdc_info for
+ *   further details.
+ *
+ * eld_priv[] contains exactly one element if the object type
+ * is and mlog, otherwise it contains exactly zero element.
+ */
+struct pmd_layout {
+	struct rb_node                  eld_nodemdc;
+	u64                             eld_objid;
+	u32                             eld_mblen;
+	u8                              eld_state;
+	u8                              eld_flags;
+	u64                             eld_gen;
+	struct omf_layout_descriptor    eld_ld;
+
+	/* The above fields are read-mostly, while the
+	 * following two fields mutate frequently.
+	 */
+	struct kref                     eld_ref;
+	struct rw_semaphore             eld_rwlock;
+
+	union pmd_layout_priv           eld_priv[];
+};
+
+/* Shortcuts for mlog private data...
+ */
+#define eld_mlpriv      eld_priv->mlpriv
+#define eld_uuid        eld_mlpriv.mlp_uuid
+#define eld_lstat       eld_mlpriv.mlp_lstat
+#define eld_nodeoml     eld_mlpriv.mlp_nodeoml
+
+/**
+ * struct pmd_obj_capacity -
+ * @moc_captgt:  capacity target for object in bytes
+ * @moc_spare:   true, if alloc obj from spare space
+ */
+struct pmd_obj_capacity {
+	u64    moc_captgt;
+	bool   moc_spare;
+};
+
+/**
+ * struct pmd_obj_erase_work - workqueue job struct for object erase and free
+ * @oef_mp:             mpool
+ * @oef_layout:         object layout
+ * @oef_cache:          kmem cache to free work (or NULL)
+ * @oef_wqstruct:	workq struct
+ */
+struct pmd_obj_erase_work {
+	struct mpool_descriptor    *oef_mp;
+	struct pmd_layout          *oef_layout;
+	struct kmem_cache          *oef_cache;
+	struct work_struct          oef_wqstruct;
+};
+
+/**
+ * struct mdc_csm_info - mdc credit set member info
+ * @m_slot:      mdc slot number
+ * @ci_credit:   available credit
+ */
+struct mdc_csm_info {
+	u8   m_slot;
+	u16  m_credit;
+};
+
+/**
+ * struct mdc_credit_set - mdc credit set
+ * @cs_idx:      index of current credit set member
+ * @cs_num_csm:  number of credit set members in this credit set
+ * @cs_csm:      array of credit set members
+ */
+struct mdc_credit_set {
+	u8                    cs_idx;
+	u8                    cs_num_csm;
+	struct mdc_csm_info   csm[MPOOL_MDC_SET_SZ];
+};
+
+/**
+ * pmd_obj_alloc() - Allocate an object.
+ * @mp:
+ * @otype:
+ * @ocap:
+ * @mclassp: media class
+ * @layoutp:
+ *
+ * Allocate object of type otype with parameters and capacity as specified
+ * by ocap on drives in media class mclassp providing a minimum capacity of
+ * mincap bytes; if successful returns object layout.
+ *
+ * Note:
+ * Object is not persistent until committed; allocation can be aborted.
+ *
+ * Return: %0 if successful, -errno otherwise
+ */
+int pmd_obj_alloc(struct mpool_descriptor *mp, enum obj_type_omf otype,
+		  struct pmd_obj_capacity *ocap, enum mp_media_classp mclassp,
+		  struct pmd_layout **layoutp);
+
+
+/**
+ * pmd_obj_realloc() - Re-allocate an object.
+ * @mp:
+ * @objid:
+ * @ocap:
+ * @mclassp: media class
+ * @layoutp:
+ *
+ * Allocate object with specified objid to support crash recovery; otherwise
+ * is equivalent to pmd_obj_alloc(); if successful returns object layout.
+ *
+ * Note:
+ * Object is not persistent until committed; allocation can be aborted.
+ *
+ * Return: %0 if successful; -errno otherwise
+ */
+int pmd_obj_realloc(struct mpool_descriptor *mp, u64 objid, struct pmd_obj_capacity *ocap,
+		    enum mp_media_classp mclassp, struct pmd_layout **layoutp);
+
+
+/**
+ * pmd_obj_commit() - Commit an object.
+ * @mp:
+ * @layout:
+ *
+ * Make allocated object persistent; if fails object remains uncommitted so
+ * can retry commit or abort; object cannot be committed while in erasing or
+ * aborting state; caller MUST NOT hold pmd_obj_*lock() on layout.
+ *
+ * Return: %0 if successful, -errno otherwise
+ */
+int pmd_obj_commit(struct mpool_descriptor *mp, struct pmd_layout *layout);
+
+/**
+ * pmd_obj_abort() - Discard un-committed object.
+ * @mp:
+ * @layout:
+ *
+ * Discard uncommitted object; caller MUST NOT hold pmd_obj_*lock() on
+ * layout; if successful layout is invalid after call.
+ *
+ * Return: %0 if successful; -errno otherwise
+ */
+int pmd_obj_abort(struct mpool_descriptor *mp, struct pmd_layout *layout);
+
+/**
+ * pmd_obj_delete() - Delete committed object.
+ * @mp:
+ * @layout:
+ *
+ * Delete committed object; caller MUST NOT hold pmd_obj_*lock() on layout;
+ * if successful layout is invalid.
+ *
+ * Return: %0 if successful, -errno otherwise
+ */
+int pmd_obj_delete(struct mpool_descriptor *mp, struct pmd_layout *layout);
+
+/**
+ * pmd_obj_erase() - Log erase for object and set state flag and generation number
+ * @mp:
+ * @layout:
+ * @gen:
+ *
+ * Object must be in committed state; caller MUST hold pmd_obj_wrlock() on layout.
+ *
+ * Return: %0 if successful, -errno otherwise
+ */
+int pmd_obj_erase(struct mpool_descriptor *mp, struct pmd_layout *layout, u64 gen);
+
+/**
+ * pmd_obj_find_get() - Get a reference for a layout for objid.
+ * @mp:
+ * @objid:
+ * @which:
+ *
+ * Get layout for object with specified objid; return NULL either if not found
+ *
+ * Return: pointer to layout if successful, NULL otherwise
+ */
+struct pmd_layout *pmd_obj_find_get(struct mpool_descriptor *mp, u64 objid, int which);
+
+/**
+ * pmd_obj_rdlock() - Read-lock object layout with appropriate nesting level.
+ * @layout:
+ */
+void pmd_obj_rdlock(struct pmd_layout *layout);
+
+/**
+ * pmd_obj_rdunlock() - Release read lock on object layout.
+ * @layout:
+ */
+void pmd_obj_rdunlock(struct pmd_layout *layout);
+
+/**
+ * pmd_obj_wrlock() - Write-lock object layout with appropriate nesting level.
+ * @layout:
+ */
+void pmd_obj_wrlock(struct pmd_layout *layout);
+
+/**
+ * pmd_obj_wrunlock() - Release write lock on object layout.
+ * @layout:
+ */
+void pmd_obj_wrunlock(struct pmd_layout *layout);
+
+/**
+ * pmd_init_credit() - udpates available credit and setup mdc selector table
+ * @mp: mpool object
+ *
+ * Lock: No Lock required
+ *
+ * Used to initialize credit when new MDCs are added and add the mds to
+ * available
+ * credit list.
+ */
+void pmd_update_credit(struct mpool_descriptor *mp);
+
+/**
+ * pmd_mpool_usage() - calculate per-mpool space usage
+ * @mp:
+ * @usage:
+ */
+void pmd_mpool_usage(struct mpool_descriptor *mp, struct mpool_usage *usage);
+
+/**
+ * pmd_precompact_alsz() - Inform MDC1/255 pre-compacting about the active
+ *	mlog of an mpool MDCi 0<i<=255.
+ *	The size and how much is used are passed in.
+ *	"alsz" stands for active mlog size.
+ * @mp:
+ * @objid: objid of the active mlog of the mpool MDCi
+ * @len: In bytes, how much of the active mlog is used.
+ * @cap: In bytes, size of the active mlog.
+ */
+void pmd_precompact_alsz(struct mpool_descriptor *mp, u64 objid, u64 len, u64 cap);
+
+/**
+ * pmd_layout_alloc() - create and initialize an pmd_layout
+ * @objid:  mblock/mlog object ID
+ * @gen:    generation number
+ * @mblen:  mblock written length
+ * @zcnt:   number of zones in a strip
+ *
+ * Alloc and init object layout; non-arg fields and all strip descriptor
+ * fields are set to 0/UNDEF/NONE; no auxiliary object info is allocated.
+ *
+ * Return: NULL if allocation fails.
+ */
+struct pmd_layout *pmd_layout_alloc(struct mpool_uuid *uuid, u64 objid,
+				    u64 gen, u64 mblen, u32 zcnt);
+
+/**
+ * pmd_layout_release() - free pmd_layout and internal elements
+ * @layout:
+ *
+ * Deallocate all memory associated with object layout.
+ *
+ * Return: void
+ */
+void pmd_layout_release(struct kref *refp);
+
+int pmd_layout_rw(struct mpool_descriptor *mp, struct pmd_layout *layout,
+		  const struct kvec *iov, int iovcnt, u64 boff, int flags, u8 rw);
+
+struct mpool_dev_info *pmd_layout_pd_get(struct mpool_descriptor *mp, struct pmd_layout *layout);
+
+u64 pmd_layout_cap_get(struct mpool_descriptor *mp, struct pmd_layout *layout);
+
+int pmd_layout_erase(struct mpool_descriptor *mp, struct pmd_layout *layout);
+
+int pmd_obj_alloc_cmn(struct mpool_descriptor *mp, u64 objid, enum obj_type_omf otype,
+		      struct pmd_obj_capacity *ocap, enum mp_media_classp mclass,
+		      int realloc, bool needref, struct pmd_layout **layoutp);
+
+void pmd_update_obj_stats(struct mpool_descriptor *mp, struct pmd_layout *layout,
+			  struct pmd_mdc_info *cinfo, enum pmd_obj_op op);
+
+void pmd_obj_rdlock(struct pmd_layout *layout);
+void pmd_obj_rdunlock(struct pmd_layout *layout);
+
+void pmd_obj_wrlock(struct pmd_layout *layout);
+void pmd_obj_wrunlock(struct pmd_layout *layout);
+
+void pmd_co_rlock(struct pmd_mdc_info *cinfo, u8 slot);
+void pmd_co_runlock(struct pmd_mdc_info *cinfo);
+
+struct pmd_layout *pmd_co_find(struct pmd_mdc_info *cinfo, u64 objid);
+struct pmd_layout *pmd_co_insert(struct pmd_mdc_info *cinfo, struct pmd_layout *layout);
+struct pmd_layout *pmd_co_remove(struct pmd_mdc_info *cinfo, struct pmd_layout *layout);
+
+int pmd_smap_insert(struct mpool_descriptor *mp, struct pmd_layout *layout);
+
+int pmd_init(void) __cold;
+void pmd_exit(void) __cold;
+
+static inline bool objtype_user(enum obj_type_omf otype)
+{
+	return (otype == OMF_OBJ_MBLOCK || otype == OMF_OBJ_MLOG);
+}
+
+static inline u64 objid_make(u64 uniq, enum obj_type_omf otype, u8 cslot)
+{
+	return ((uniq << 12) | ((otype & 0xF) << 8) | (cslot & 0xFF));
+}
+
+static inline u64 objid_uniq(u64 objid)
+{
+	return (objid >> 12);
+}
+
+static inline u8 objid_slot(u64 objid)
+{
+	return (objid & 0xFF);
+}
+
+static inline bool objid_ckpt(u64 objid)
+{
+	return !(objid_uniq(objid) & (OBJID_UNIQ_DELTA - 1));
+}
+
+static inline u64 logid_make(u64 uniq, u8 cslot)
+{
+	return objid_make(uniq, OMF_OBJ_MLOG, cslot);
+}
+
+static inline bool objid_mdc0log(u64 objid)
+{
+	return ((objid == MDC0_OBJID_LOG1) || (objid == MDC0_OBJID_LOG2));
+}
+
+static inline enum obj_type_omf pmd_objid_type(u64 objid)
+{
+	enum obj_type_omf otype = objid_type(objid);
+
+	return objtype_valid(otype) ? otype : OMF_OBJ_UNDEF;
+}
+
+/* True if objid is an mpool user object (versus mpool metadata object). */
+static inline bool pmd_objid_isuser(u64 objid)
+{
+	return objtype_user(objid_type(objid)) && objid_slot(objid);
+}
+
+static inline void pmd_obj_put(struct pmd_layout *layout)
+{
+	kref_put(&layout->eld_ref, pmd_layout_release);
+}
+
+/* General mdc locking (has external callers...) */
+static inline void pmd_mdc_lock(struct mutex *lock, u8 slot)
+{
+	mutex_lock_nested(lock, slot > 0 ? PMD_MDC_NORMAL : PMD_MDC_ZERO);
+}
+
+static inline void pmd_mdc_unlock(struct mutex *lock)
+{
+	mutex_unlock(lock);
+}
+
+#endif /* MPOOL_PMD_OBJ_H */
diff --git a/drivers/mpool/sb.h b/drivers/mpool/sb.h
new file mode 100644
index 000000000000..673a5f742f7c
--- /dev/null
+++ b/drivers/mpool/sb.h
@@ -0,0 +1,162 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+
+#ifndef MPOOL_SB_PRIV_H
+#define MPOOL_SB_PRIV_H
+
+#include "mpool_ioctl.h"
+
+struct pd_dev_parm;
+struct omf_sb_descriptor;
+struct pd_prop;
+
+/*
+ * Drives have 2 superblocks.
+ * + sb0 at byte offset 0
+ * + sb1 at byte offset SB_AREA_SZ
+ *
+ * Read: sb0 is the authoritative copy, other copies are not used.
+ * Updates: sb0 is updated first; if successful sb1 is updated
+ */
+/* Number of superblock per Physical Device.  */
+#define SB_SB_COUNT        2
+
+/*
+ * Size in byte of the area occupied by a superblock. The superblock itself
+ * may be smaller, but always starts at the beginning of its area.
+ */
+#define SB_AREA_SZ        (4096ULL)
+
+/*
+ * Size in byte of an area located just after the superblock areas.
+ * Not used in 1.0. Later can be used for MDC0 metadata and/or voting sets.
+ */
+#define MDC0MD_AREA_SZ    (4096ULL)
+
+/*
+ * sb API functions
+ */
+
+/**
+ * sb_magic_check() - check for sb magic value
+ * @dparm: struct pd_dev_parm *
+ *
+ * Determine if the mpool magic value exists in at least one place where
+ * expected on drive pd.  Does NOT imply drive has a valid superblock.
+ *
+ * Note: only pd.status and pd.parm must be set; no other pd fields accessed.
+ *
+ * Return: 1 if found, 0 if not found, -(errno) if error reading
+ */
+int sb_magic_check(struct pd_dev_parm *dparm);
+
+/**
+ * sb_write_new() - write superblock to new drive
+ * @dparm: struct pd_dev_parm *
+ * @sb: struct omf_sb_descriptor *
+ *
+ * Write superblock sb to new (non-pool) drive
+ *
+ * Note: only pd.status and pd.parm must be set; no other pd fields accessed.
+ *
+ * Return: 0 if successful; -errno otherwise
+ */
+int sb_write_new(struct pd_dev_parm *dparm, struct omf_sb_descriptor *sb);
+
+/**
+ * sb_write_update() - update superblock
+ * @dparm: "dparm" info is not used to fill up the super block, only "sb" content is used.
+ * @sb: "sb" content is written in the super block.
+ *
+ * Update superblock on pool drive
+ *
+ * Note: only pd.status and pd.parm must be set; no other pd fields accessed.
+ *
+ * Return: 0 if successful; -errno otherwise
+ */
+int sb_write_update(struct pd_dev_parm *dparm, struct omf_sb_descriptor *sb);
+
+/**
+ * sb_erase() - erase superblock
+ * @dparm: struct pd_dev_parm *
+ *
+ * Erase superblock on drive pd.
+ *
+ * Note: only pd.status and pd.parm must be set; no other pd fields accessed.
+ *
+ * Return: 0 if successful; -errno otherwise
+ */
+int sb_erase(struct pd_dev_parm *dparm);
+
+/**
+ * sb_read() - read superblock
+ * @dparm: struct pd_dev_parm *
+ * @sb: struct omf_sb_descriptor *
+ * @omf_ver: omf sb version
+ * @force:
+ *
+ * Read superblock from drive pd; make repairs as necessary.
+ *
+ * Note: only pd.status and pd.parm must be set; no other pd fields accessed.
+ *
+ * Return: 0 if successful; -errno otherwise
+ */
+int sb_read(struct pd_dev_parm *dparm, struct omf_sb_descriptor *sb, u16 *omf_ver, bool force);
+
+/**
+ * sbutil_mdc0_clear() - clear mdc0 of superblock
+ * @sb: struct omf_sb_descriptor *)
+ *
+ * Clear (set to zeros) mdc0 portion of sb.
+ *
+ * Return: void
+ */
+void sbutil_mdc0_clear(struct omf_sb_descriptor *sb);
+
+/**
+ * sbutil_mdc0_isclear() - Test if mdc0 is clear
+ * @sb: struct omf_sb_descriptor *
+ *
+ * Return: 1 if mdc0 portion of sb is clear.
+ */
+int sbutil_mdc0_isclear(struct omf_sb_descriptor *sb);
+
+/**
+ * sbutil_mdc0_copy() - copy mdc0 from one superblock to another
+ * @tgtsb: struct omf_sb_descriptor *
+ * @srcsb: struct omf_sb_descriptor *
+ *
+ * Copy mdc0 portion of srcsb to tgtsb.
+ *
+ * Return void
+ */
+void sbutil_mdc0_copy(struct omf_sb_descriptor *tgtsb, struct omf_sb_descriptor *srcsb);
+
+/**
+ * sbutil_mdc0_isvalid() - validate mdc0 of a superblock
+ * @sb: struct omf_sb_descriptor *
+ *
+ * Validate mdc0 portion of sb and extract mdparm.
+ * Return: 1 if valid and mdparm set; 0 otherwise.
+ */
+int sbutil_mdc0_isvalid(struct omf_sb_descriptor *sb);
+
+/**
+ * sb_zones_for_sbs() - compute how many zones are needed to contain the superblocks.
+ * @pd_prop:
+ */
+static inline u32 sb_zones_for_sbs(struct pd_prop *pd_prop)
+{
+	u32 zonebyte;
+
+	zonebyte = pd_prop->pdp_zparam.dvb_zonepg << PAGE_SHIFT;
+
+	return (2 * (SB_AREA_SZ + MDC0MD_AREA_SZ) + (zonebyte - 1)) / zonebyte;
+}
+
+int sb_init(void) __cold;
+void sb_exit(void) __cold;
+
+#endif /* MPOOL_SB_PRIV_H */
diff --git a/drivers/mpool/smap.h b/drivers/mpool/smap.h
new file mode 100644
index 000000000000..b9b72d3182c6
--- /dev/null
+++ b/drivers/mpool/smap.h
@@ -0,0 +1,334 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+
+#ifndef MPOOL_SMAP_H
+#define MPOOL_SMAP_H
+
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+#include <linux/rbtree.h>
+#include <linux/workqueue.h>
+
+#include "mpool_ioctl.h"
+
+/* Forward Decls */
+struct mpool_usage;
+struct mpool_devprops;
+struct mc_smap_parms;
+struct mpool_descriptor;
+
+/*
+ * Common defs
+ */
+
+/**
+ * struct rmbkt - region map bucket
+ */
+struct rmbkt {
+	struct mutex    pdi_rmlock;
+	struct rb_root  pdi_rmroot;
+} ____cacheline_aligned;
+
+/**
+ * struct smap_zone -
+ * @smz_node:
+ * @smz_key:
+ * @smz_value:
+ */
+struct smap_zone {
+	struct rb_node  smz_node;
+	u64             smz_key;
+	u64             smz_value;
+};
+
+/**
+ * enum smap_space_type - space allocation policy flag
+ * @SMAP_SPC_UNDEF:
+ * @SMAP_SPC_USABLE_ONLY:    allocate from usable space only
+ * @SMAP_SPC_USABLE_2_SPARE: allocate from usable space first then spare
+ *                          if needed
+ * @SMAP_SPC_SPARE_ONLY:     allocate from spare space only
+ * @SMAP_SPC_SPARE_2_USABLE: allocate from spare space first then usable
+ *                          if needed
+ */
+enum smap_space_type {
+	SMAP_SPC_UNDEF           = 0,
+	SMAP_SPC_USABLE_ONLY     = 1,
+	SMAP_SPC_USABLE_2_SPARE  = 2,
+	SMAP_SPC_SPARE_ONLY      = 3,
+	SMAP_SPC_SPARE_2_USABLE  = 4
+};
+
+static inline int saptype_valid(enum smap_space_type saptype)
+{
+	return (saptype && saptype <= 4);
+}
+
+/*
+ * drive allocation info
+ *
+ * LOCKING:
+ * + rgnsz, rgnladdr: constants; no locking required
+ * + all other fields: protected by dalock
+ */
+
+/**
+ * struct smap_dev_alloc -
+ * @sda_dalock:
+ * @sda_rgnsz:    number of zones per rgn, excepting last
+ * @sda_rgnladdr: address of first zone in last rgn
+ * @sda_rgnalloc: rgn last alloced from
+ * @sda_zoneeff:    total zones (zonetot) minus bad zones
+ * @sda_utgt:      target max usable zones to allocate
+ * @sda_uact:      actual usable zones allocated
+ * @sda_stgt:      target max spare zones to allocate
+ * @sda_sact       actual spare zones allocated
+ *
+ * NOTE:
+ * + must maintain invariant that sact <= stgt
+ * + however it is possible for uact > utgt due to changing % spare
+ *   zones or zone failures.  this condition corrects when
+ *   sufficient space is freed or if % spare zones is changed
+ *   (again).
+ *
+ * Capacity pools and calcs:
+ * + total zones = zonetot
+ * + avail zones = zoneeff
+ * + usable zones = utgt which is (zoneeff * (1 - spzone/100))
+ * + free usable zones = max(0, utgt - uact); max handles uact > utgt
+ * + used zones = uact; possible for used > usable (uact > utgt)
+ * + spare zones = stgt which is (zoneeff - utgt)
+ * + free spare zones = (stgt - sact); guaranteed that sact <= stgt
+ */
+struct smap_dev_alloc {
+	spinlock_t sda_dalock;
+	u32        sda_rgnsz;
+	u32        sda_rgnladdr;
+	u32        sda_rgnalloc;
+	u32        sda_zoneeff;
+	u32        sda_utgt;
+	u32        sda_uact;
+	u32        sda_stgt;
+	u32        sda_sact;
+};
+
+struct smap_dev_znstats {
+	u64    sdv_total;
+	u64    sdv_avail;
+	u64    sdv_usable;
+	u64    sdv_fusable;
+	u64    sdv_spare;
+	u64    sdv_fspare;
+	u64    sdv_used;
+};
+
+/**
+ * smap_usage_work - delayed work struct for checking mpool free usable space usage
+ * @smapu_wstruct:
+ * @smapu_mp:
+ * @smapu_freepct: free space %
+ */
+struct smap_usage_work {
+	struct delayed_work             smapu_wstruct;
+	struct mpool_descriptor        *smapu_mp;
+	int                             smapu_freepct;
+};
+
+/*
+ * smap API functions
+ */
+
+/*
+ * Return: all smap fns can return -errno with the following errno values
+ * on failure:
+ * + -EINVAL = invalid fn args
+ * + -ENOSPC = unable to allocate requested space
+ * + -ENOMEM = insufficient memory to complete operation
+ */
+
+/*
+ * smap API usage notes:
+ * + During mpool activation call smap_insert() for all existing objects
+ *   before calling smap_alloc() or smap_free().
+ */
+
+/**
+ * smap_mpool_init() - initialize the smaps for an initialized mpool_descriptor
+ * @mp: struct mpool_descriptor *
+ *
+ * smap_mpool_init must be called once per mpool as it is being activated.
+ *
+ * Init space maps for all drives in mpool that are empty except for
+ * superblocks; caller must ensure no other thread can access mp.
+ *
+ * TODO: Traversing smap rbtrees may need fix, since there may be unsafe
+ * erases within loops.
+ *
+ * Return:
+ * 0 if successful, -errno with the following errno values on failure:
+ * -EINVAL if spare zone percentage is > 100%,
+ * -EINVAL if rgn count is 0, or
+ * -EINVAL if zonecnt on one of the drives is < rgn count
+ * -ENOMEM if there is no memory available
+ */
+int smap_mpool_init(struct mpool_descriptor *mp);
+
+/**
+ * smap_mpool_free() - free smap structures in a mpool_descriptor
+ * @mp: struct mpool_descriptor *
+ *
+ * Free space maps for all drives in mpool; caller must ensure no other
+ * thread can access mp.
+ *
+ * Return: void
+ */
+void smap_mpool_free(struct mpool_descriptor *mp);
+
+/**
+ * smap_mpool_usage() - present stats of smap usage
+ * @mp: struct mpool_descriptor *
+ * @mclass: media class or MP_MED_ALL for all classes
+ * @usage: struct mpool_usage *
+ *
+ * Fill in stats with space usage for media class; if MP_MED_ALL
+ * report on all media classes; caller must hold mp.pdvlock.
+ *
+ * Locking: the caller should hold the pds_pdvlock at least in read to
+ *	    be protected against media classes updates.
+ */
+void smap_mpool_usage(struct mpool_descriptor *mp, u8 mclass, struct mpool_usage *usage);
+
+/**
+ * smap_drive_spares() - Set percentage of zones to set aside as spares
+ * @mp: struct mpool_descriptor *
+ * @mclassp: media class
+ * @spzone: percentage of zones to use as spares
+ *
+ * Set percent spare zones to spzone for drives in media class mclass;
+ * caller must hold mp.pdvlock.
+ *
+ * Locking: the caller should hold the pds_pdvlock at least in read to
+ *	    be protected against media classes updates.
+ *
+ * Return: 0 if successful; -errno otherwise
+ */
+int smap_drive_spares(struct mpool_descriptor *mp, enum mp_media_classp mclassp, u8 spzone);
+
+/**
+ * smap_drive_usage() - Fill in a given drive's portion of dprop struct.
+ * @mp:    struct mpool_descriptor *
+ * @pdh:   drive number within the mpool_descriptor
+ * @dprop: struct mpool_devprops *, structure to fill in
+ *
+ * Fill in usage portion of dprop for drive pdh; caller must hold mp.pdvlock
+ *
+ * Return: 0 if successful, -errno otherwise
+ */
+int smap_drive_usage(struct mpool_descriptor *mp, u16 pdh, struct mpool_devprops *dprop);
+
+/**
+ * smap_drive_init() - Initialize a specific drive within a mpool_descriptor
+ * @mp:    struct mpool_descriptor *
+ * @mcsp:  smap parameters
+ * @pdh:   u16, drive number within the mpool_descriptor
+ *
+ * Init space map for pool drive pdh that is empty except for superblocks
+ * with a percent spare zones of spzone; caller must ensure pdh is not in use.
+ *
+ * Return: 0 if successful, -errno otherwise
+ */
+int smap_drive_init(struct mpool_descriptor *mp, struct mc_smap_parms *mcsp, u16 pdh);
+
+/**
+ * smap_drive_free() - Release resources for a specific drive
+ * @mp:  struct mpool_descriptor *
+ * @pdh: u16, drive number within the mpool_descriptor
+ *
+ * Free space map for pool drive pdh including partial (failed) inits;
+ * caller must ensure pdh is not in use.
+ *
+ * Return: void
+ */
+void smap_drive_free(struct mpool_descriptor *mp, u16 pdh);
+
+/**
+ * smap_insert() - Inject an entry to an smap for existing object
+ * @mp: struct mpool_descriptor *
+ * @pdh: drive number within the mpool_descriptor
+ * @zoneaddr: starting zone for entry
+ * @zonecnt: number of zones in entry
+ *
+ * Add entry to space map for an existing object with a strip on drive pdh
+ * starting at zoneaddr and continuing for zonecnt blocks.
+ *
+ * Used, in part for superblocks.
+ *
+ * Return: 0 if successful, -errno otherwise
+ */
+int smap_insert(struct mpool_descriptor *mp, u16 pdh, u64 zoneaddr, u32 zonecnt);
+
+/**
+ * smap_alloc() - Allocate a new contiguous zone range on a specific drive
+ * @mp: struct mpool_descriptor
+ * @pdh: u16, drive number within the mpool_descriptor
+ * @zonecnt: u64, the number of zones requested
+ * @sapolicy: enum smap_space_type, usable only, spare only, etc.
+ * @zoneaddr: u64 *, the starting zone for the allocated range
+ * @align: no. of zones (must be a power-of-2)
+ *
+ * Attempt to allocate zonecnt contiguous zones on drive pdh
+ * in accordance with space allocation policy sapolicy.
+ *
+ * Return: 0 if succcessful; -errno otherwise
+ */
+int smap_alloc(struct mpool_descriptor *mp, u16 pdh, u64 zonecnt,
+	       enum smap_space_type sapolicy, u64 *zoneaddr, u64 align);
+
+/**
+ * smap_free() - Free a previously allocated range of zones in the smap
+ * @mp: struct mpool_descriptor *
+ * @pdh: u16, number of the disk within the mpool_descriptor
+ * @zoneaddr: u64, starting zone for the range to free
+ * @zonecnt: u16, the number of zones in the range
+ *
+ * Free currently allocated space starting at zoneaddr
+ * and continuing for zonecnt blocks.
+ *
+ * Return: 0 if successful, -errno otherwise
+ */
+int smap_free(struct mpool_descriptor *mp, u16 pdh, u64 zoneaddr, u16 zonecnt);
+
+/*
+ * smap internal functions
+ */
+
+/**
+ * smap_mpool_usage() - Get the media class usage for a given mclass.
+ * @mp:
+ * @mclass: if MP_MED_ALL, return the sum of the stats for all media class,
+ *	else the stats only for one media class.
+ * @usage: output
+ *
+ * Locking: the caller should hold the pds_pdvlock at least in read to
+ *	    be protected against media classes updates.
+ */
+void smap_mclass_usage(struct mpool_descriptor *mp, u8 mclass, struct mpool_usage *usage);
+
+/**
+ * smap_log_mpool_usage() - check drive mpool free usable space %, and log a message if needed
+ * @ws:
+ */
+void smap_log_mpool_usage(struct work_struct *ws);
+
+/**
+ * smap_wait_usage_done() - wait for periodical job for logging pd free usable space % to complete
+ * @mp:
+ */
+void smap_wait_usage_done(struct mpool_descriptor *mp);
+
+int smap_init(void) __cold;
+void smap_exit(void) __cold;
+
+#endif /* MPOOL_SMAP_H */
-- 
2.17.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

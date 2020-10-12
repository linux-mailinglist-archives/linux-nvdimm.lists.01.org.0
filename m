Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D88928BD9F
	for <lists+linux-nvdimm@lfdr.de>; Mon, 12 Oct 2020 18:28:17 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4488A15B409F4;
	Mon, 12 Oct 2020 09:28:14 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.94.67; helo=nam10-mw2-obe.outbound.protection.outlook.com; envelope-from=nmeeramohide@micron.com; receiver=<UNKNOWN> 
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 67D5B14B2CCEC
	for <linux-nvdimm@lists.01.org>; Mon, 12 Oct 2020 09:28:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVTb1E1OaPdeYjG/N4cLKjW7g3XPNXHd9zJSQY0RAEhl/Crt9QTXVleLVrRr+3ZyZahr4/o/rJywNgSY4NFbn9FV7xOF8NzhdHuGizWzDU5JqsRUjDZ2cN5yF/572Q+va5RKdZGTMYR9RBh4nrS2SPNORX7TaiVx1GD1sQdhQTcrmoR38V2ftOuO+uh9RJeGOM42fe9uFxU6L//VLOMObbFTaa+kof3OjhoUF97V5MrJncbVdwiIN7jQ0Keu5T7ZIsJQRJohBvyMJXH0Fn+4hRLwFJ559O8HcuHdKc2LnDvQz/Hm5ha059BXDJSVJ4/iCHKgfTo+xtXaIprhtOZxxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gS913cTFno8j44TvajhZ5qcpn9B8dknbA0Mgf/29zs0=;
 b=ikgfNIOgENHOqSgUClkQs/5qPh70MvNc5BqDQalJaAZ0JipP/hVPpOqv944BHHgaIEkaI3urEt+Wg1CpCbLtrI81EZHsMshVHPIFNCQT1SNzMxLjzNk5SXfHr+hPP19E3v5E3BTnCLfm1C7yBe2axV9MTdURkPX/GqGuMLhmUURG58sinOFn6Aa56VfvtpkDfkjT+49TexSLi/PJsaCxmUzm9WEECC8Rke+8e+3soSBeC3yiMT7oDZoEO7DKUfeA5a60VJYPsQAHp6pLKx4hP/BB9xTJv4+Wu5aPMOg+jJCCmitS/iG1EaDFLpWxX1wAYjVoxU1eRm1MZb0EkKL2rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=kvack.org smtp.mailfrom=micron.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gS913cTFno8j44TvajhZ5qcpn9B8dknbA0Mgf/29zs0=;
 b=15K4sx81TptAXceYmoloP6R7S/wOugYHanKlKAxVkBaeQklG1L0GpfmxchTgP7NJ8kmusmOMPkLJZ3oHj5fYGnaljGuW7BxTdHQiiHMkQASwr8mz7/+wUv/lk9lzosiBW46XSrwksf/QEXvmOQxRwjklwfPj08waZ5spuaDCN1g=
Received: from SA9PR10CA0013.namprd10.prod.outlook.com (2603:10b6:806:a7::18)
 by BYAPR08MB5574.namprd08.prod.outlook.com (2603:10b6:a03:c8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Mon, 12 Oct
 2020 16:28:07 +0000
Received: from SN1NAM01FT051.eop-nam01.prod.protection.outlook.com
 (2603:10b6:806:a7:cafe::47) by SA9PR10CA0013.outlook.office365.com
 (2603:10b6:806:a7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24 via Frontend
 Transport; Mon, 12 Oct 2020 16:28:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com;
Received: from mail.micron.com (137.201.242.130) by
 SN1NAM01FT051.mail.protection.outlook.com (10.152.64.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3455.23 via Frontend Transport; Mon, 12 Oct 2020 16:28:06 +0000
Received: from micron.com (10.114.5.55) by bowex17c.micron.com
 (137.201.21.211) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Oct
 2020 10:27:58 -0600
From: Nabeel M Mohamed <nmeeramohide@micron.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-nvdimm@lists.01.org>
Subject: [PATCH v2 05/22] mpool: add space map component which manages free space on mpool devices
Date: Mon, 12 Oct 2020 11:27:19 -0500
Message-ID: <20201012162736.65241-6-nmeeramohide@micron.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20201012162736.65241-1-nmeeramohide@micron.com>
References: <20201012162736.65241-1-nmeeramohide@micron.com>
MIME-Version: 1.0
X-ClientProxiedBy: bowex17a.micron.com (137.201.21.209) To bowex17c.micron.com
 (137.201.21.211)
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24646.005
X-TM-AS-Result: No--16.293800-0.000000-31
X-TM-AS-MatchedID: 155760-702686-105630-704397-702876-700863-705063-702877-7
	05161-700060-703812-700095-703226-701342-703342-704806-702615-703956-701413
	-704714-704228-703878-703700-704318-702619-703215-704418-704792-704401-7045
	85-703542-780052-703953-701480-701809-701280-703017-702395-188019-703027-70
	2299-704477-300015-703213-703140-121336-701105-704673-703967-139504-702754-
	701772-704183-701590-700809-700163-847298-701475-704053-702700-702444-70356
	3-703385-701803-701750-700069-704841-700926-702415-188199-704402-702798-700
	864-702908-700077-700786-701007-700954-704264-704090-704612-700737-701270-7
	04959-700512-703532-704173-703434-702216-702298-148004-148036-29997-42000-4
	2003
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 717c543e-e40f-46fd-9fb3-08d86ecbccae
X-MS-TrafficTypeDiagnostic: BYAPR08MB5574:
X-Microsoft-Antispam-PRVS: 
 <BYAPR08MB557473BD758E472ADD72EB88B3070@BYAPR08MB5574.namprd08.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Be54rN2g3I4+KfN0igHESCOahw/uTNPRKyTzpndDdsVmScmGOfQLWuIo81nbDr/XpdWDkb/PycIZfTxnJC79FwIdylsh7V1Kh19kSeesnQPACD8b6qWAoGzR/bPcCrfSTLxcGztWm3z4VvAcuWBM96h01DDyK2WkyYwQ3pGT+NH/QTHsTxb4Bu5hgytuFvOYEg9p2SGS66MLlkc5o4bYSL6HKv+MRzE2upLNXo21Xu8glQUJn/pjy03W2hK6ENy9Bw8uS6mbBPdxVvQUozeiqiSwaj786EaRdDcvfQDO0WWzXWV66Ee8DOzrKwi5STTRbqqx+MkBkBPEDLfG85EQ7Vvh1YjlvtWsrHcwCUs1keqGVGnb8GkBCBmQpZrdWOLe2S3b7g8rVSO75dmLmLBjhB7f7xiLbOAkFSLfVb5/S/fSHsOY89ZIm1NL4dOXUNBH
X-Forefront-Antispam-Report: 
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(46966005)(426003)(47076004)(2616005)(107886003)(356005)(36756003)(2906002)(5660300002)(8936002)(6666004)(86362001)(33310700002)(30864003)(83380400001)(8676002)(336012)(55016002)(316002)(7696005)(4326008)(478600001)(7636003)(186003)(6286002)(54906003)(26005)(70586007)(70206006)(110136005)(82310400003)(82740400003)(1076003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 16:28:06.1958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 717c543e-e40f-46fd-9fb3-08d86ecbccae
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM01FT051.eop-nam01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB5574
Message-ID-Hash: FRLIUCUCM5C7ATCA33YLHJ3TAHIBQSML
X-Message-ID-Hash: FRLIUCUCM5C7ATCA33YLHJ3TAHIBQSML
X-MailFrom: nmeeramohide@micron.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: smoyer@micron.com, gbecker@micron.com, plabat@micron.com, jgroves@micron.com, Nabeel M Mohamed <nmeeramohide@micron.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FRLIUCUCM5C7ATCA33YLHJ3TAHIBQSML/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The smap layer implements a free space map for each media class
volume in an active mpool.

Free space maps are maintained in memory only. When an mpool is
activated, the free space map is reconstructed from the object
metadata read from media. This approach has the following
advantages:
- Objects can be allocated or freed without any space map device IO
- No overhead of tracking both the allocated and free space,
  and keeping them synchronized

The LBA space of a media class volume is subdivided into regions.
Allocation requests for a volume are distributed across these
regions. There's a separate space map per region which is
protected by a region mutex 'pdi_rmlock'.

Each region is further subdivided into zones. The zone size is
determined at mpool create time, and it defaults to 32MiB.
The free space in each region is represented by a rbtree,
where the key is a zone number and the value is the length of
the free space specified as a zone count.

A configurable percentage of the total zones on a given volume
are marked as spare zones, and the rest are marked as usable
zones. The smap supports different allocation policies which
determine which zone type is used to satisfy an allocation
request - usable or spare or usable then spare or
spare then usable.

Co-developed-by: Greg Becker <gbecker@micron.com>
Signed-off-by: Greg Becker <gbecker@micron.com>
Co-developed-by: Pierre Labat <plabat@micron.com>
Signed-off-by: Pierre Labat <plabat@micron.com>
Co-developed-by: John Groves <jgroves@micron.com>
Signed-off-by: John Groves <jgroves@micron.com>
Signed-off-by: Nabeel M Mohamed <nmeeramohide@micron.com>
---
 drivers/mpool/init.c   |   17 +-
 drivers/mpool/mclass.c |  103 ++++
 drivers/mpool/smap.c   | 1031 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1150 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mpool/mclass.c
 create mode 100644 drivers/mpool/smap.c

diff --git a/drivers/mpool/init.c b/drivers/mpool/init.c
index 294cf3cbbaa7..031408815b48 100644
--- a/drivers/mpool/init.c
+++ b/drivers/mpool/init.c
@@ -8,6 +8,7 @@
 #include "mpool_printk.h"
 
 #include "pd.h"
+#include "smap.h"
 
 /*
  * Module params...
@@ -22,16 +23,30 @@ MODULE_PARM_DESC(chunk_size_kb, "Chunk size (in KiB) for device I/O");
 
 static void mpool_exit_impl(void)
 {
+	smap_exit();
 	pd_exit();
 }
 
 static __init int mpool_init(void)
 {
+	const char *errmsg = NULL;
 	int rc;
 
 	rc = pd_init();
 	if (rc) {
-		mp_pr_err("pd init failed", rc);
+		errmsg = "pd init failed";
+		goto errout;
+	}
+
+	rc = smap_init();
+	if (rc) {
+		errmsg = "smap init failed";
+		goto errout;
+	}
+
+errout:
+	if (rc) {
+		mp_pr_err("%s", rc, errmsg);
 		mpool_exit_impl();
 	}
 
diff --git a/drivers/mpool/mclass.c b/drivers/mpool/mclass.c
new file mode 100644
index 000000000000..a81ee5ee9468
--- /dev/null
+++ b/drivers/mpool/mclass.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+
+/*
+ * This file contains the media class accessor functions.
+ */
+
+#include <linux/errno.h>
+
+#include "omf_if.h"
+#include "pd.h"
+#include "params.h"
+#include "mclass.h"
+
+void mc_init_class(struct media_class *mc, struct mc_parms *mc_parms, struct mc_smap_parms *mcsp)
+{
+	memcpy(&(mc->mc_parms), mc_parms, sizeof(*mc_parms));
+	mc->mc_uacnt = 0;
+	mc->mc_sparms = *mcsp;
+}
+
+void mc_omf_devparm2mc_parms(struct omf_devparm_descriptor *omf_devparm, struct mc_parms *mc_parms)
+{
+	/* Zeroes mc_ parms because memcmp() may be used on it later. */
+	memset(mc_parms, 0, sizeof(*mc_parms));
+	mc_parms->mcp_classp   = omf_devparm->odp_mclassp;
+	mc_parms->mcp_zonepg   = omf_devparm->odp_zonepg;
+	mc_parms->mcp_sectorsz = omf_devparm->odp_sectorsz;
+	mc_parms->mcp_devtype  = omf_devparm->odp_devtype;
+	mc_parms->mcp_features = omf_devparm->odp_features;
+}
+
+void mc_parms2omf_devparm(struct mc_parms *mc_parms, struct omf_devparm_descriptor *omf_devparm)
+{
+	omf_devparm->odp_mclassp  = mc_parms->mcp_classp;
+	omf_devparm->odp_zonepg   = mc_parms->mcp_zonepg;
+	omf_devparm->odp_sectorsz = mc_parms->mcp_sectorsz;
+	omf_devparm->odp_devtype  = mc_parms->mcp_devtype;
+	omf_devparm->odp_features = mc_parms->mcp_features;
+}
+
+int mc_cmp_omf_devparm(struct omf_devparm_descriptor *omfd1, struct omf_devparm_descriptor *omfd2)
+{
+	struct mc_parms mc_parms1;
+	struct mc_parms mc_parms2;
+
+	mc_omf_devparm2mc_parms(omfd1, &mc_parms1);
+	mc_omf_devparm2mc_parms(omfd2, &mc_parms2);
+
+	return memcmp(&mc_parms1, &mc_parms2, sizeof(mc_parms1));
+}
+
+void mc_pd_prop2mc_parms(struct pd_prop *pd_prop, struct mc_parms *mc_parms)
+{
+	/* Zeroes mc_ parms because memcmp() may be used on it later. */
+	memset(mc_parms, 0, sizeof(*mc_parms));
+	mc_parms->mcp_classp	= pd_prop->pdp_mclassp;
+	mc_parms->mcp_zonepg	= pd_prop->pdp_zparam.dvb_zonepg;
+	mc_parms->mcp_sectorsz	= PD_SECTORSZ(pd_prop);
+	mc_parms->mcp_devtype	= pd_prop->pdp_devtype;
+	mc_parms->mcp_features	= OMF_MC_FEAT_MBLOCK_TGT;
+
+	if (pd_prop->pdp_cmdopt & PD_CMD_SECTOR_UPDATABLE)
+		mc_parms->mcp_features |= OMF_MC_FEAT_MLOG_TGT;
+	if (pd_prop->pdp_cmdopt & PD_CMD_DIF_ENABLED)
+		mc_parms->mcp_features |= OMF_MC_FEAT_CHECKSUM;
+}
+
+int mc_set_spzone(struct media_class *mc, u8 spzone)
+{
+	if (!mc)
+		return -EINVAL;
+
+	if (mc->mc_pdmc < 0)
+		return -ENOENT;
+
+	mc->mc_sparms.mcsp_spzone = spzone;
+
+	return 0;
+}
+
+static void mc_smap_parms_get_internal(struct mpcore_params *params, struct mc_smap_parms *mcsp)
+{
+	mcsp->mcsp_spzone = params->mp_spare;
+	mcsp->mcsp_rgnc = params->mp_smaprgnc;
+	mcsp->mcsp_align = params->mp_smapalign;
+}
+
+int mc_smap_parms_get(struct media_class *mc, struct mpcore_params *params,
+		      struct mc_smap_parms *mcsp)
+{
+	if (!mc || !mcsp)
+		return -EINVAL;
+
+	if (mc->mc_pdmc >= 0)
+		*mcsp = mc->mc_sparms;
+	else
+		mc_smap_parms_get_internal(params, mcsp);
+
+	return 0;
+}
diff --git a/drivers/mpool/smap.c b/drivers/mpool/smap.c
new file mode 100644
index 000000000000..a62aaa2f0113
--- /dev/null
+++ b/drivers/mpool/smap.c
@@ -0,0 +1,1031 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+/*
+ * Space map module.
+ *
+ * Implements space maps for managing free space on drives.
+ */
+
+#include <linux/log2.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+
+#include "assert.h"
+#include "mpool_printk.h"
+
+#include "pd.h"
+#include "sb.h"
+#include "mclass.h"
+#include "smap.h"
+#include "mpcore.h"
+
+static struct kmem_cache  *smap_zone_cache __read_mostly;
+
+static int smap_drive_alloc(struct mpool_descriptor *mp, struct mc_smap_parms *mcsp, u16 pdh);
+static int smap_drive_sballoc(struct mpool_descriptor *mp, u16 pdh);
+
+/*
+ * smap API functions
+ */
+
+static struct smap_zone *smap_zone_find(struct rb_root *root, u64 key)
+{
+	struct rb_node *node = root->rb_node;
+	struct smap_zone *elem;
+
+	while (node) {
+		elem = rb_entry(node, typeof(*elem), smz_node);
+
+		if (key < elem->smz_key)
+			node = node->rb_left;
+		else if (key > elem->smz_key)
+			node = node->rb_right;
+		else
+			return elem;
+	}
+
+	return NULL;
+}
+
+static int smap_zone_insert(struct rb_root *root, struct smap_zone *item)
+{
+	struct rb_node **pos = &root->rb_node, *parent = NULL;
+	struct smap_zone *this;
+
+	/* Figure out where to put new node */
+	while (*pos) {
+		this = rb_entry(*pos, typeof(*this), smz_node);
+		parent = *pos;
+
+		if (item->smz_key < this->smz_key)
+			pos = &(*pos)->rb_left;
+		else if (item->smz_key > this->smz_key)
+			pos = &(*pos)->rb_right;
+		else
+			return false;
+	}
+
+	/* Add new node and rebalance tree. */
+	rb_link_node(&item->smz_node, parent, pos);
+	rb_insert_color(&item->smz_node, root);
+
+	return true;
+}
+
+int smap_mpool_init(struct mpool_descriptor *mp)
+{
+	struct mpool_dev_info *pd = NULL;
+	struct media_class *mc;
+	u64 pdh = 0;
+	int rc = 0;
+
+	for (pdh = 0; pdh < mp->pds_pdvcnt; pdh++) {
+		struct mc_smap_parms   mcsp;
+
+		pd = &mp->pds_pdv[pdh];
+		mc = &mp->pds_mc[pd->pdi_mclass];
+		rc = mc_smap_parms_get(&mp->pds_mc[mc->mc_parms.mcp_classp],
+				       &mp->pds_params, &mcsp);
+		if (rc)
+			break;
+
+		rc = smap_drive_init(mp, &mcsp, pdh);
+		if (rc) {
+			mp_pr_err("smap(%s, %s): drive init failed",
+				  rc, mp->pds_name, pd->pdi_name);
+			break;
+		}
+	}
+
+	if (rc)
+		smap_mpool_free(mp);
+
+	return rc;
+}
+
+void smap_mpool_free(struct mpool_descriptor *mp)
+{
+	u64 pdh = 0;
+
+	for (pdh = 0; pdh < mp->pds_pdvcnt; pdh++)
+		smap_drive_free(mp, pdh);
+}
+
+void smap_mpool_usage(struct mpool_descriptor *mp, u8 mclass, struct mpool_usage *usage)
+{
+	if (mclass == MP_MED_ALL) {
+		u32 i;
+
+		for (i = 0; i < MP_MED_NUMBER; i++)
+			smap_mclass_usage(mp, i, usage);
+	} else {
+		smap_mclass_usage(mp, mclass, usage);
+	}
+}
+
+int smap_drive_spares(struct mpool_descriptor *mp, enum mp_media_classp mclassp, u8 spzone)
+{
+	struct mpool_dev_info *pd = NULL;
+	struct media_class *mc;
+	int rc;
+	u8 i;
+
+	if (!mclass_isvalid(mclassp) || spzone > 100) {
+		rc = -EINVAL;
+		mp_pr_err("smap mpool %s: smap drive spares failed mclassp %d spzone %u",
+			  rc, mp->pds_name, mclassp, spzone);
+		return rc;
+	}
+
+	/* Loop on all classes matching mclassp. */
+	for (i = 0; i < MP_MED_NUMBER; i++) {
+		mc = &mp->pds_mc[i];
+		if (mc->mc_parms.mcp_classp != mclassp || mc->mc_pdmc < 0)
+			continue;
+
+		pd = &mp->pds_pdv[mc->mc_pdmc];
+
+		spin_lock(&pd->pdi_ds.sda_dalock);
+		/* Adjust utgt but not uact; possible for uact > utgt due to spzone change. */
+		pd->pdi_ds.sda_utgt = (pd->pdi_ds.sda_zoneeff * (100 - spzone)) / 100;
+		/* Adjust stgt and sact maintaining invariant that sact <= stgt */
+		pd->pdi_ds.sda_stgt = pd->pdi_ds.sda_zoneeff - pd->pdi_ds.sda_utgt;
+		if (pd->pdi_ds.sda_sact > pd->pdi_ds.sda_stgt) {
+			pd->pdi_ds.sda_uact += (pd->pdi_ds.sda_sact - pd->pdi_ds.sda_stgt);
+			pd->pdi_ds.sda_sact = pd->pdi_ds.sda_stgt;
+		}
+		spin_unlock(&pd->pdi_ds.sda_dalock);
+
+	}
+	return 0;
+}
+
+/*
+ * Compute zone stats for drive pd per comments in smap_dev_alloc.
+ */
+static void smap_calc_znstats(struct mpool_dev_info *pd, struct smap_dev_znstats *zones)
+{
+	zones->sdv_total = pd->pdi_parm.dpr_zonetot;
+	zones->sdv_avail = pd->pdi_ds.sda_zoneeff;
+	zones->sdv_usable = pd->pdi_ds.sda_utgt;
+
+	if (pd->pdi_ds.sda_utgt > pd->pdi_ds.sda_uact)
+		zones->sdv_fusable = pd->pdi_ds.sda_utgt - pd->pdi_ds.sda_uact;
+	else
+		zones->sdv_fusable = 0;
+
+	zones->sdv_spare = pd->pdi_ds.sda_stgt;
+	zones->sdv_fspare = pd->pdi_ds.sda_stgt - pd->pdi_ds.sda_sact;
+	zones->sdv_used = pd->pdi_ds.sda_uact;
+}
+
+int smap_drive_usage(struct mpool_descriptor *mp, u16 pdh, struct mpool_devprops *dprop)
+{
+	struct mpool_dev_info *pd = &mp->pds_pdv[pdh];
+	struct smap_dev_znstats zones;
+	u32 zonepg = 0;
+
+	zonepg = pd->pdi_parm.dpr_zonepg;
+
+	spin_lock(&pd->pdi_ds.sda_dalock);
+	smap_calc_znstats(pd, &zones);
+	spin_unlock(&pd->pdi_ds.sda_dalock);
+
+	dprop->pdp_total = (zones.sdv_total * zonepg) << PAGE_SHIFT;
+	dprop->pdp_avail = (zones.sdv_avail * zonepg) << PAGE_SHIFT;
+	dprop->pdp_spare = (zones.sdv_spare * zonepg) << PAGE_SHIFT;
+	dprop->pdp_fspare = (zones.sdv_fspare * zonepg) << PAGE_SHIFT;
+	dprop->pdp_usable = (zones.sdv_usable * zonepg) << PAGE_SHIFT;
+	dprop->pdp_fusable = (zones.sdv_fusable * zonepg) << PAGE_SHIFT;
+	dprop->pdp_used = (zones.sdv_used * zonepg) << PAGE_SHIFT;
+
+	return 0;
+}
+
+int smap_drive_init(struct mpool_descriptor *mp, struct mc_smap_parms *mcsp, u16 pdh)
+{
+	struct mpool_dev_info *pd __maybe_unused;
+	int rc;
+
+	pd = &mp->pds_pdv[pdh];
+
+	if ((mcsp->mcsp_spzone > 100) || !(mcsp->mcsp_rgnc > 0)) {
+		rc = -EINVAL;
+		mp_pr_err("smap(%s, %s): drive init failed, spzone %u rcnt %lu", rc, mp->pds_name,
+			  pd->pdi_name, mcsp->mcsp_spzone, (ulong)mcsp->mcsp_rgnc);
+		return rc;
+	}
+
+	rc = smap_drive_alloc(mp, mcsp, pdh);
+	if (!rc) {
+		rc = smap_drive_sballoc(mp, pdh);
+		if (rc)
+			mp_pr_err("smap(%s, %s): sb alloc failed", rc, mp->pds_name, pd->pdi_name);
+	} else {
+		mp_pr_err("smap(%s, %s): drive alloc failed", rc, mp->pds_name, pd->pdi_name);
+	}
+
+	if (rc)
+		smap_drive_free(mp, pdh);
+
+	return rc;
+}
+
+void smap_drive_free(struct mpool_descriptor *mp, u16 pdh)
+{
+	struct mpool_dev_info *pd = &mp->pds_pdv[pdh];
+	u8 rgn = 0;
+
+	if (pd->pdi_rmbktv) {
+		struct media_class     *mc;
+		struct mc_smap_parms    mcsp;
+
+		mc = &mp->pds_mc[pd->pdi_mclass];
+		(void)mc_smap_parms_get(&mp->pds_mc[mc->mc_parms.mcp_classp],
+					&mp->pds_params, &mcsp);
+
+		for (rgn = 0; rgn < mcsp.mcsp_rgnc; rgn++) {
+			struct smap_zone   *zone, *tmp;
+			struct rb_root     *root;
+
+			root = &pd->pdi_rmbktv[rgn].pdi_rmroot;
+
+			rbtree_postorder_for_each_entry_safe(zone, tmp, root, smz_node) {
+				kmem_cache_free(smap_zone_cache, zone);
+			}
+		}
+
+		kfree(pd->pdi_rmbktv);
+		pd->pdi_rmbktv = NULL;
+	}
+
+	pd->pdi_ds.sda_rgnsz = 0;
+	pd->pdi_ds.sda_rgnladdr = 0;
+	pd->pdi_ds.sda_rgnalloc = 0;
+	pd->pdi_ds.sda_zoneeff = 0;
+	pd->pdi_ds.sda_utgt = 0;
+	pd->pdi_ds.sda_uact = 0;
+}
+
+static bool smap_alloccheck(struct mpool_dev_info *pd, u64 zonecnt, enum smap_space_type sapolicy)
+{
+	struct smap_dev_alloc *ds;
+	bool alloced = false;
+	u64 zoneextra;
+
+	ds = &pd->pdi_ds;
+
+	spin_lock(&ds->sda_dalock);
+
+	switch (sapolicy) {
+
+	case SMAP_SPC_USABLE_ONLY:
+		if ((ds->sda_uact + zonecnt) > ds->sda_utgt)
+			break;
+
+		ds->sda_uact = ds->sda_uact + zonecnt;
+		alloced = true;
+		break;
+
+	case SMAP_SPC_SPARE_ONLY:
+		if ((ds->sda_sact + zonecnt) > ds->sda_stgt)
+			break;
+
+		ds->sda_sact = ds->sda_sact + zonecnt;
+		alloced = true;
+		break;
+
+	case SMAP_SPC_USABLE_2_SPARE:
+		if ((ds->sda_uact + ds->sda_sact + zonecnt) > ds->sda_zoneeff)
+			break;
+
+		if ((ds->sda_uact + zonecnt) <= ds->sda_utgt) {
+			ds->sda_uact = ds->sda_uact + zonecnt;
+		} else {
+			zoneextra = (ds->sda_uact + zonecnt) - ds->sda_utgt;
+			ds->sda_uact = ds->sda_utgt;
+			ds->sda_sact = ds->sda_sact + zoneextra;
+		}
+		alloced = true;
+		break;
+
+	case SMAP_SPC_SPARE_2_USABLE:
+		if ((ds->sda_sact + ds->sda_uact + zonecnt) > ds->sda_zoneeff)
+			break;
+
+		if ((ds->sda_sact + zonecnt) <= ds->sda_stgt) {
+			ds->sda_sact = ds->sda_sact + zonecnt;
+		} else {
+			zoneextra = (ds->sda_sact + zonecnt) - ds->sda_stgt;
+			ds->sda_sact = ds->sda_stgt;
+			ds->sda_uact = ds->sda_uact + zoneextra;
+		}
+		alloced = true;
+		break;
+
+	default:
+		break;
+	}
+
+	spin_unlock(&ds->sda_dalock);
+
+	return alloced;
+}
+
+int smap_alloc(struct mpool_descriptor *mp, u16 pdh, u64 zonecnt,
+	       enum smap_space_type sapolicy, u64 *zoneaddr, u64 align)
+{
+	struct mc_smap_parms mcsp;
+	struct mpool_dev_info *pd;
+	struct smap_dev_alloc *ds;
+	struct smap_zone *elem = NULL;
+	struct rb_root *rmap = NULL;
+	struct mutex *rmlock = NULL;
+	struct media_class *mc;
+	u64 fsoff = 0, fslen = 0, ualen = 0;
+	u8 rgn = 0, rgnc;
+	s8 rgnleft;
+	bool res;
+	int rc;
+
+	*zoneaddr = 0;
+	pd = &mp->pds_pdv[pdh];
+
+	if (!zonecnt || !saptype_valid(sapolicy))
+		return -EINVAL;
+
+	ASSERT(is_power_of_2(align));
+
+	ds = &pd->pdi_ds;
+	mc = &mp->pds_mc[pd->pdi_mclass];
+	rc = mc_smap_parms_get(&mp->pds_mc[mc->mc_parms.mcp_classp], &mp->pds_params, &mcsp);
+	if (rc)
+		return rc;
+
+	rgnc = mcsp.mcsp_rgnc;
+
+	/*
+	 * We do not update the last rgn alloced beyond this point as it
+	 * would incur search penalty if all the regions except one are highly
+	 * fragmented, i.e., the last alloc rgn would never change in this case.
+	 */
+	spin_lock(&ds->sda_dalock);
+	ds->sda_rgnalloc = (ds->sda_rgnalloc + 1) % rgnc;
+	rgn = ds->sda_rgnalloc;
+	spin_unlock(&ds->sda_dalock);
+
+	rgnleft = rgnc;
+
+	/* Search per-rgn space maps for contiguous region. */
+	while (rgnleft--) {
+		struct rb_node *node;
+
+		rmlock = &pd->pdi_rmbktv[rgn].pdi_rmlock;
+		rmap = &pd->pdi_rmbktv[rgn].pdi_rmroot;
+
+		mutex_lock(rmlock);
+
+		for (node = rb_first(rmap); node; node = rb_next(node)) {
+			elem  = rb_entry(node, struct smap_zone, smz_node);
+			fsoff = elem->smz_key;
+			fslen = elem->smz_value;
+
+			if (zonecnt > fslen)
+				continue;
+
+			if (IS_ALIGNED(fsoff, align)) {
+				ualen = 0;
+				break;
+			}
+
+			ualen = ALIGN(fsoff, align) - fsoff;
+			if (ualen + zonecnt > fslen)
+				continue;
+
+			break;
+		}
+
+		if (node)
+			break;
+
+		mutex_unlock(rmlock);
+
+		rgn = (rgn + 1) % rgnc;
+	}
+
+	if (rgnleft < 0)
+		return -ENOSPC;
+
+	/* Alloc from this free space if permitted. First fit. */
+	res = smap_alloccheck(pd, zonecnt, sapolicy);
+	if (!res) {
+		mutex_unlock(rmlock);
+		return -ENOSPC;
+	}
+
+	fsoff = fsoff + ualen;
+	fslen = fslen - ualen;
+
+	*zoneaddr = fsoff;
+	rb_erase(&elem->smz_node, rmap);
+
+	if (zonecnt < fslen) {
+		/* Re-use elem */
+		elem->smz_key   = fsoff + zonecnt;
+		elem->smz_value = fslen - zonecnt;
+		smap_zone_insert(rmap, elem);
+		elem = NULL;
+	}
+
+	if (ualen) {
+		if (!elem) {
+			elem = kmem_cache_alloc(smap_zone_cache, GFP_ATOMIC);
+			if (!elem) {
+				mutex_unlock(rmlock);
+				return -ENOMEM;
+			}
+		}
+
+		elem->smz_key   = fsoff - ualen;
+		elem->smz_value = ualen;
+		smap_zone_insert(rmap, elem);
+		elem = NULL;
+	}
+
+	mutex_unlock(rmlock);
+
+	if (elem)
+		kmem_cache_free(smap_zone_cache, elem);
+
+	return 0;
+}
+
+/*
+ * smap internal functions
+ */
+
+/*
+ * Init empty space map for drive pdh with a % spare zones of spzone.
+ * Returns: 0 if successful, -errno otherwise...
+ */
+static int smap_drive_alloc(struct mpool_descriptor *mp, struct mc_smap_parms *mcsp, u16 pdh)
+{
+	struct mpool_dev_info *pd = &mp->pds_pdv[pdh];
+	struct smap_zone *urb_elem = NULL;
+	struct smap_zone *found_ue = NULL;
+	u32 rgnsz = 0;
+	u8 rgn = 0;
+	u8 rgn2 = 0;
+	u8 rgnc;
+	int rc;
+
+	rgnc  = mcsp->mcsp_rgnc;
+	rgnsz = pd->pdi_parm.dpr_zonetot / rgnc;
+	if (!rgnsz) {
+		rc = -EINVAL;
+		mp_pr_err("smap(%s, %s): drive alloc failed, invalid rgn size",
+			  rc, mp->pds_name, pd->pdi_name);
+		return rc;
+	}
+
+	/* Allocate and init per channel space maps and associated locks */
+	pd->pdi_rmbktv = kcalloc(rgnc, sizeof(*pd->pdi_rmbktv), GFP_KERNEL);
+	if (!pd->pdi_rmbktv) {
+		rc = -ENOMEM;
+		mp_pr_err("smap(%s, %s): rmbktv alloc failed", rc, mp->pds_name, pd->pdi_name);
+		return rc;
+	}
+
+	/* Define all space on all channels as being free (drive empty) */
+	for (rgn = 0; rgn < rgnc; rgn++) {
+		mutex_init(&pd->pdi_rmbktv[rgn].pdi_rmlock);
+
+		urb_elem = kmem_cache_alloc(smap_zone_cache, GFP_KERNEL);
+		if (!urb_elem) {
+			struct rb_root *rmroot;
+
+			for (rgn2 = 0; rgn2 < rgn; rgn2++) {
+				rmroot = &pd->pdi_rmbktv[rgn2].pdi_rmroot;
+
+				found_ue = smap_zone_find(rmroot, 0);
+				if (found_ue) {
+					rb_erase(&found_ue->smz_node, rmroot);
+					kmem_cache_free(smap_zone_cache, found_ue);
+				}
+			}
+
+			kfree(pd->pdi_rmbktv);
+			pd->pdi_rmbktv = NULL;
+
+			rc = -ENOMEM;
+			mp_pr_err("smap(%s, %s): rb node alloc failed, rgn %u",
+				  rc, mp->pds_name, pd->pdi_name, rgn);
+			return rc;
+		}
+
+		urb_elem->smz_key = rgn * rgnsz;
+		if (rgn < rgnc - 1)
+			urb_elem->smz_value = rgnsz;
+		else
+			urb_elem->smz_value = pd->pdi_parm.dpr_zonetot - (rgn * rgnsz);
+		smap_zone_insert(&pd->pdi_rmbktv[rgn].pdi_rmroot, urb_elem);
+	}
+
+	spin_lock_init(&pd->pdi_ds.sda_dalock);
+	pd->pdi_ds.sda_rgnalloc = 0;
+	pd->pdi_ds.sda_rgnsz = rgnsz;
+	pd->pdi_ds.sda_rgnladdr = (rgnc - 1) * rgnsz;
+	pd->pdi_ds.sda_zoneeff = pd->pdi_parm.dpr_zonetot;
+	pd->pdi_ds.sda_utgt = (pd->pdi_ds.sda_zoneeff * (100 - mcsp->mcsp_spzone)) / 100;
+	pd->pdi_ds.sda_uact = 0;
+	pd->pdi_ds.sda_stgt = pd->pdi_ds.sda_zoneeff - pd->pdi_ds.sda_utgt;
+	pd->pdi_ds.sda_sact = 0;
+
+	return 0;
+}
+
+/*
+ * Add entry to space map covering superblocks on drive pdh.
+ * Returns: 0 if successful, -errno otherwise...
+ */
+static int smap_drive_sballoc(struct mpool_descriptor *mp, u16 pdh)
+{
+	struct mpool_dev_info *pd = &mp->pds_pdv[pdh];
+	int rc;
+	u32 cnt;
+
+	cnt = sb_zones_for_sbs(&(pd->pdi_prop));
+	if (cnt < 1) {
+		rc = -ESPIPE;
+		mp_pr_err("smap(%s, %s): identifying sb failed", rc, mp->pds_name, pd->pdi_name);
+		return rc;
+	}
+
+	rc = smap_insert(mp, pdh, 0, cnt);
+	if (rc)
+		mp_pr_err("smap(%s, %s): insert failed, cnt %u",
+			  rc, mp->pds_name, pd->pdi_name, cnt);
+
+	return rc;
+}
+
+void smap_mclass_usage(struct mpool_descriptor *mp, u8 mclass, struct mpool_usage *usage)
+{
+	struct smap_dev_znstats zones;
+	struct mpool_dev_info *pd;
+	struct media_class *mc;
+	u32 zonepg = 0;
+
+	mc = &mp->pds_mc[mclass];
+	if (mc->mc_pdmc < 0)
+		return;
+
+	pd = &mp->pds_pdv[mc->mc_pdmc];
+	zonepg = pd->pdi_zonepg;
+
+	spin_lock(&pd->pdi_ds.sda_dalock);
+	smap_calc_znstats(pd, &zones);
+	spin_unlock(&pd->pdi_ds.sda_dalock);
+
+	usage->mpu_total  += ((zones.sdv_total * zonepg) << PAGE_SHIFT);
+	usage->mpu_usable += ((zones.sdv_usable * zonepg) << PAGE_SHIFT);
+	usage->mpu_used   += ((zones.sdv_used * zonepg) << PAGE_SHIFT);
+	usage->mpu_spare  += ((zones.sdv_spare * zonepg) << PAGE_SHIFT);
+	usage->mpu_fspare += ((zones.sdv_fspare * zonepg) << PAGE_SHIFT);
+	usage->mpu_fusable += ((zones.sdv_fusable * zonepg) << PAGE_SHIFT);
+}
+
+static u32 smap_addr2rgn(struct mpool_descriptor *mp, struct mpool_dev_info *pd, u64 zoneaddr)
+{
+	struct mc_smap_parms   mcsp;
+
+	mc_smap_parms_get(&mp->pds_mc[pd->pdi_mclass], &mp->pds_params, &mcsp);
+
+	if (zoneaddr >= pd->pdi_ds.sda_rgnladdr)
+		return mcsp.mcsp_rgnc - 1;
+
+	return zoneaddr / pd->pdi_ds.sda_rgnsz;
+}
+
+/*
+ * Add entry to space map in rgn starting at zoneaddr
+ * and continuing for zonecnt blocks.
+ *
+ *   Returns: 0 if successful, -errno otherwise...
+ */
+static int smap_insert_byrgn(struct mpool_dev_info *pd, u32 rgn, u64 zoneaddr, u16 zonecnt)
+{
+	const char *msg __maybe_unused;
+	struct smap_zone *elem = NULL;
+	struct rb_root *rmap;
+	struct rb_node *node;
+	u64 fsoff, fslen;
+	int rc;
+
+	fsoff = fslen = 0;
+	rc = 0;
+	msg = NULL;
+
+	mutex_lock(&pd->pdi_rmbktv[rgn].pdi_rmlock);
+	rmap = &pd->pdi_rmbktv[rgn].pdi_rmroot;
+
+	node = rmap->rb_node;
+	if (!node) {
+		msg = "invalid rgn map";
+		rc = -EINVAL;
+		goto errout;
+	}
+
+	/* Use binary search to find the insertion point in the tree.
+	 */
+	while (node) {
+		elem = rb_entry(node, struct smap_zone, smz_node);
+
+		if (zoneaddr < elem->smz_key)
+			node = node->rb_left;
+		else if (zoneaddr > elem->smz_key + elem->smz_value)
+			node = node->rb_right;
+		else
+			break;
+	}
+
+	fsoff = elem->smz_key;
+	fslen = elem->smz_value;
+
+	/* Bail out if we're past zoneaddr in space map w/o finding the required chunk. */
+	if (zoneaddr < fsoff) {
+		elem = NULL;
+		msg = "requested range not free";
+		rc = -EINVAL;
+		goto errout;
+	}
+
+	/* The allocation must fit entirely within this chunk or it fails. */
+	if (zoneaddr + zonecnt > fsoff + fslen) {
+		elem = NULL;
+		msg = "requested range does not fit";
+		rc = -EINVAL;
+		goto errout;
+	}
+
+	rb_erase(&elem->smz_node, rmap);
+
+	if (zoneaddr > fsoff) {
+		elem->smz_key = fsoff;
+		elem->smz_value = zoneaddr - fsoff;
+		smap_zone_insert(rmap, elem);
+		elem = NULL;
+	}
+	if (zoneaddr + zonecnt < fsoff + fslen) {
+		if (!elem)
+			elem = kmem_cache_alloc(smap_zone_cache, GFP_KERNEL);
+		if (!elem) {
+			msg = "chunk alloc failed";
+			rc = -ENOMEM;
+			goto errout;
+		}
+
+		elem->smz_key = zoneaddr + zonecnt;
+		elem->smz_value = (fsoff + fslen) - (zoneaddr + zonecnt);
+		smap_zone_insert(rmap, elem);
+		elem = NULL;
+	}
+
+	/* Insert consumes usable only; possible for uact > utgt.*/
+	spin_lock(&pd->pdi_ds.sda_dalock);
+	pd->pdi_ds.sda_uact = pd->pdi_ds.sda_uact + zonecnt;
+	spin_unlock(&pd->pdi_ds.sda_dalock);
+
+errout:
+	mutex_unlock(&pd->pdi_rmbktv[rgn].pdi_rmlock);
+
+	if (elem != NULL) {
+		/* Was an exact match */
+		ASSERT((zoneaddr == fsoff) && (zonecnt == fslen));
+		kmem_cache_free(smap_zone_cache, elem);
+	}
+
+	if (rc)
+		mp_pr_err("smap pd %s: %s, zoneaddr %lu zonecnt %u fsoff %lu fslen %lu",
+			  rc, pd->pdi_name, msg ? msg : "(no detail)",
+			  (ulong)zoneaddr, zonecnt, (ulong)fsoff, (ulong)fslen);
+
+	return rc;
+}
+
+int smap_insert(struct mpool_descriptor *mp, u16 pdh, u64 zoneaddr, u32 zonecnt)
+{
+	struct mpool_dev_info *pd = &mp->pds_pdv[pdh];
+	u32 rstart = 0, rend = 0;
+	u64 raddr = 0, rcnt = 0;
+	u64 zoneadded = 0;
+	int rgn = 0;
+	int rc = 0;
+
+	if (zoneaddr >= pd->pdi_parm.dpr_zonetot ||
+	    (zoneaddr + zonecnt) > pd->pdi_parm.dpr_zonetot) {
+		rc = -EINVAL;
+		mp_pr_err("smap(%s, %s): insert failed, zoneaddr %lu zonecnt %u zonetot %u",
+			  rc, mp->pds_name, pd->pdi_name, (ulong)zoneaddr,
+			  zonecnt, pd->pdi_parm.dpr_zonetot);
+		return rc;
+	}
+
+	/*
+	 * smap_alloc() never crosses regions. however a previous instantiation
+	 * of this mpool might have used a different value of rgn count
+	 * so must handle inserts that cross regions.
+	 */
+	rstart = smap_addr2rgn(mp, pd, zoneaddr);
+	rend = smap_addr2rgn(mp, pd, zoneaddr + zonecnt - 1);
+	zoneadded = 0;
+
+	for (rgn = rstart; rgn < rend + 1; rgn++) {
+		/* Compute zone address and count for this rgn */
+		if (rgn == rstart)
+			raddr = zoneaddr;
+		else
+			raddr = (u64)rgn * pd->pdi_ds.sda_rgnsz;
+
+		if (rgn < rend)
+			rcnt = ((rgn + 1) * pd->pdi_ds.sda_rgnsz) - raddr;
+		else
+			rcnt = zonecnt - zoneadded;
+
+		rc = smap_insert_byrgn(pd, rgn, raddr, rcnt);
+		if (rc) {
+			mp_pr_err("smap(%s, %s): insert byrgn failed, rgn %d raddr %lu rcnt %lu",
+				  rc, mp->pds_name, pd->pdi_name, rgn, (ulong)raddr, (ulong)rcnt);
+			break;
+		}
+		zoneadded = zoneadded + rcnt;
+	}
+
+	return rc;
+}
+
+/**
+ * smap_free_byrgn() - free the specified range of zones
+ * @pd:         physical device object
+ * @rgn:       allocation rgn specifier
+ * @zoneaddr:    offset into the space map
+ * @zonecnt:     length of range to be freed
+ *
+ * Free the given range of zone (i.e., [%zoneaddr, %zoneaddr + %zonecnt])
+ * back to the indicated space map.  Always coalesces ranges in the space
+ * map that abut the range to be freed so as to minimize fragmentation.
+ *
+ * Return: 0 if successful, -errno otherwise...
+ */
+static int smap_free_byrgn(struct mpool_dev_info *pd, u32 rgn, u64 zoneaddr, u32 zonecnt)
+{
+	const char *msg __maybe_unused;
+	struct smap_zone *left, *right;
+	struct smap_zone *new, *old;
+	struct rb_root *rmap;
+	struct rb_node *node;
+	u32 orig_zonecnt = zonecnt;
+	int rc = 0;
+
+	new = old = left = right = NULL;
+	msg = NULL;
+
+	mutex_lock(&pd->pdi_rmbktv[rgn].pdi_rmlock);
+	rmap = &pd->pdi_rmbktv[rgn].pdi_rmroot;
+
+	node = rmap->rb_node;
+
+	/* Use binary search to find chunks to the left and/or right of the range being freed. */
+	while (node) {
+		struct smap_zone *this;
+
+		this = rb_entry(node, struct smap_zone, smz_node);
+
+		if (zoneaddr + zonecnt <= this->smz_key) {
+			right = this;
+			node = node->rb_left;
+		} else if (zoneaddr >= this->smz_key + this->smz_value) {
+			left = this;
+			node = node->rb_right;
+		} else {
+			msg = "chunk overlapping";
+			rc = -EINVAL;
+			goto unlock;
+		}
+	}
+
+	/* If the request abuts the chunk to the right then coalesce them. */
+	if (right) {
+		if (zoneaddr + zonecnt == right->smz_key) {
+			zonecnt += right->smz_value;
+			rb_erase(&right->smz_node, rmap);
+
+			new = right;  /* re-use right node */
+		}
+	}
+
+	/* If the request abuts the chunk to the left then coalesce them. */
+	if (left) {
+		if (left->smz_key + left->smz_value == zoneaddr) {
+			zoneaddr = left->smz_key;
+			zonecnt += left->smz_value;
+			rb_erase(&left->smz_node, rmap);
+
+			old = new;  /* free new/left outside the critsec */
+			new = left; /* re-use left node */
+		}
+	}
+
+	/*
+	 * If the request did not abut either the current or the previous
+	 * chunk (i.e., new == NULL) then we must create a new chunk node
+	 * and insert it into the smap.  Otherwise, we'll re-use one of
+	 * the abutting chunk nodes (i.e., left or right).
+	 *
+	 * Note: If we have to call kmalloc and it fails (unlikely) then
+	 * this chunk will be lost only for the current session.  It will
+	 * be recovered once the mpool is closed and re-opened.
+	 */
+	if (!new) {
+		new = kmem_cache_alloc(smap_zone_cache, GFP_ATOMIC);
+		if (!new) {
+			msg = "chunk alloc failed";
+			rc = -ENOMEM;
+			goto unlock;
+		}
+	}
+
+	new->smz_key = zoneaddr;
+	new->smz_value = zonecnt;
+
+	if (!smap_zone_insert(rmap, new)) {
+		kmem_cache_free(smap_zone_cache, new);
+		msg = "chunk insert failed";
+		rc = -ENOTRECOVERABLE;
+		goto unlock;
+	}
+
+	/* Freed space goes to spare first then usable. */
+	zonecnt = orig_zonecnt;
+
+	spin_lock(&pd->pdi_ds.sda_dalock);
+	if (pd->pdi_ds.sda_sact > 0) {
+		if (pd->pdi_ds.sda_sact > zonecnt) {
+			pd->pdi_ds.sda_sact -= zonecnt;
+			zonecnt = 0;
+		} else {
+			zonecnt -= pd->pdi_ds.sda_sact;
+			pd->pdi_ds.sda_sact = 0;
+		}
+	}
+
+	pd->pdi_ds.sda_uact -= zonecnt;
+	spin_unlock(&pd->pdi_ds.sda_dalock);
+
+unlock:
+	mutex_unlock(&pd->pdi_rmbktv[rgn].pdi_rmlock);
+
+	if (old)
+		kmem_cache_free(smap_zone_cache, old);
+
+	if (rc)
+		mp_pr_err("smap pd %s: %s, free byrgn failed, rgn %u zoneaddr %lu zonecnt %u",
+			  rc, pd->pdi_name, msg ? msg : "(no detail)",
+			  rgn, (ulong)zoneaddr, zonecnt);
+
+	return rc;
+}
+
+int smap_free(struct mpool_descriptor *mp, u16 pdh, u64 zoneaddr, u16 zonecnt)
+{
+	struct mpool_dev_info *pd = NULL;
+	u32 rstart = 0, rend = 0;
+	u32 raddr = 0, rcnt = 0;
+	u64 zonefreed = 0;
+	u32 rgn = 0;
+	int rc = 0;
+
+	pd = &mp->pds_pdv[pdh];
+
+	if (zoneaddr >= pd->pdi_parm.dpr_zonetot || zoneaddr + zonecnt > pd->pdi_parm.dpr_zonetot) {
+		rc = -EINVAL;
+		mp_pr_err("smap(%s, %s): free failed, zoneaddr %lu zonecnt %u zonetot: %u",
+			  rc, mp->pds_name, pd->pdi_name, (ulong)zoneaddr,
+			  zonecnt, pd->pdi_parm.dpr_zonetot);
+		return rc;
+	}
+
+	if (!zonecnt)
+		return 0; /* Nothing to be returned */
+
+	/*
+	 * smap_alloc() never crosses regions. however a previous instantiation
+	 * of this mpool might have used a different value of rgn count
+	 * so must handle frees that cross regions.
+	 */
+
+	rstart = smap_addr2rgn(mp, pd, zoneaddr);
+	rend = smap_addr2rgn(mp, pd, zoneaddr + zonecnt - 1);
+
+	for (rgn = rstart; rgn < rend + 1; rgn++) {
+		/* Compute zone address and count for this rgn */
+		if (rgn == rstart)
+			raddr = zoneaddr;
+		else
+			raddr = rgn * pd->pdi_ds.sda_rgnsz;
+
+		if (rgn < rend)
+			rcnt = ((u64)(rgn + 1) * pd->pdi_ds.sda_rgnsz) - raddr;
+		else
+			rcnt = zonecnt - zonefreed;
+
+		rc = smap_free_byrgn(pd, rgn, raddr, rcnt);
+		if (rc) {
+			mp_pr_err("smap(%s, %s): free byrgn failed, rgn %d raddr %lu, rcnt %lu",
+				  rc, mp->pds_name, pd->pdi_name, rgn, (ulong)raddr, (ulong)rcnt);
+			break;
+		}
+		zonefreed = zonefreed + rcnt;
+	}
+
+	return rc;
+}
+
+void smap_wait_usage_done(struct mpool_descriptor *mp)
+{
+	struct smap_usage_work *usagew = &mp->pds_smap_usage_work;
+
+	cancel_delayed_work_sync(&usagew->smapu_wstruct);
+}
+
+#define SMAP_FREEPCT_DELTA 5
+#define SMAP_FREEPCT_LOG_THLD   50
+
+void smap_log_mpool_usage(struct work_struct *ws)
+{
+	struct smap_usage_work *smapu;
+	struct mpool_descriptor *mp;
+	struct mpool_usage usage;
+	int last, cur, delta;
+
+	smapu = container_of(ws, struct smap_usage_work, smapu_wstruct.work);
+	mp = smapu->smapu_mp;
+
+	/* Get the current mpool space usage stats */
+	smap_mpool_usage(mp, MP_MED_ALL, &usage);
+
+	if (usage.mpu_usable == 0) {
+		mp_pr_err("smap mpool %s: zero usable space", -EINVAL, mp->pds_name);
+		return;
+	}
+	/*
+	 * Calculate the delta of free usable space/total usable space,
+	 * since last time a message was logged
+	 */
+	last = smapu->smapu_freepct;
+	cur = usage.mpu_fusable * 100 / usage.mpu_usable;
+	delta = cur - last;
+
+	/*
+	 * Log a message if delta >= 5% && free usable space % < 50%
+	 */
+	if ((abs(delta) >= SMAP_FREEPCT_DELTA) && (cur < SMAP_FREEPCT_LOG_THLD)) {
+
+		smapu->smapu_freepct = cur;
+		if (last == 0)
+			mp_pr_info("smap mpool %s, free space %d%%",
+				   mp->pds_name, smapu->smapu_freepct);
+
+		else
+			mp_pr_info("smap mpool %s, free space %s from %d%% to %d%%",
+				   mp->pds_name, (delta > 0) ? "increases" : "decreases",
+				   last, smapu->smapu_freepct);
+	}
+
+	/* Schedule the next run of smap_log_mpool_usage() */
+	queue_delayed_work(mp->pds_workq, &smapu->smapu_wstruct,
+			   msecs_to_jiffies(mp->pds_params.mp_mpusageperiod));
+}
+
+int smap_init(void)
+{
+	int rc = 0;
+
+	smap_zone_cache = kmem_cache_create("mpool_smap_zone", sizeof(struct smap_zone),
+					    0, SLAB_HWCACHE_ALIGN | SLAB_POISON, NULL);
+	if (!smap_zone_cache) {
+		rc = -ENOMEM;
+		mp_pr_err("kmem_cache_create(smap_zone, %zu) failed",
+			  rc, sizeof(struct smap_zone));
+	}
+
+	return rc;
+}
+
+void smap_exit(void)
+{
+	kmem_cache_destroy(smap_zone_cache);
+	smap_zone_cache = NULL;
+}
-- 
2.17.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

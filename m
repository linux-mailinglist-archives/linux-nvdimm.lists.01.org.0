Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 408B428BDA0
	for <lists+linux-nvdimm@lfdr.de>; Mon, 12 Oct 2020 18:28:19 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8AAA315B409F8;
	Mon, 12 Oct 2020 09:28:15 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.220.88; helo=nam11-co1-obe.outbound.protection.outlook.com; envelope-from=nmeeramohide@micron.com; receiver=<UNKNOWN> 
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0C94614B2CCEC
	for <linux-nvdimm@lists.01.org>; Mon, 12 Oct 2020 09:28:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJPdMZ1rjFTDomMjxLff7Omt6XHQPJc1g+p6rpMcx2mBixfL+VuFTrROJVqyOdHH4WpUoQLeR28owZXlD/eiLb1HYES5rEqkGdwIcBOrfnANwJU2Fdm4/qYV+6t7wevzpk2fBWF2FFE9r+RKQN9O4Kgpu2T5OEoXlYT5f3MYfpQfjBxH0CnQpQNRNDygpDZ13SLF3qSTnuXMthD42Leq3+1S29IxMbFzePv3peBkGjG7e65Ui5h4WCW/2drdfkwmWN7iuebr/HPtx7m552nJJAfHcmasYbg/O7dOnbCMU7Q1nMnt41VIN6htlc4mmuZGWADa0FseTCikWzUZuCjdtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efRadhT/BouYWnAOqZQzKWC6yxeagGIjwbecZBAlvPw=;
 b=l9lEsGgk6l3t2JbiNkzZ4I32NK6UhIjotyAAaUmEX7KWNJgTerKEiAqcS7numjSL7HuwUC6N6CkL+v4u3ubYASBVDD0lEiK9t1dON5+KcxQ9Qqv/tQAEzjkseK20wDk4+QIPSqdRoFhQ0sYOwmNBodvO6B3vvrpQyagyvOkpQuPqtQWaQnAGB4Tf8TPefx45BVluvop47acLjt6sZOGQGgqK6kO8BMPVld6AKbCyNlXa5arYyHRkQT+ZC1ZU4SwGvK1hIQU5SM6r1gwI96HHDH+/mufcxApUcsWeaXi/ONA12xJxKEgQZDaOwiGJd4OD8krjXXwAuRUfCi8rKvj0cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=kvack.org smtp.mailfrom=micron.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efRadhT/BouYWnAOqZQzKWC6yxeagGIjwbecZBAlvPw=;
 b=nAqpqP/X9u/gtNfPZeA7htjDq0xRuSs4ws44hDcX2O9JFUNEiOt6eh/XFfVq0BM++85zU+Xa7QF9mcKIV+pksGiwRIOt5zzBTUSU39JGAFsVg4eP8eibKCma9UPrDfop6a7rKPF5wkuU8CXRNV0mM17pI3JPhiLUEpCE+hN6/Z0=
Received: from SA9PR10CA0013.namprd10.prod.outlook.com (2603:10b6:806:a7::18)
 by CY1PR0801MB2138.namprd08.prod.outlook.com (2a01:111:e400:c616::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Mon, 12 Oct
 2020 16:28:08 +0000
Received: from SN1NAM01FT051.eop-nam01.prod.protection.outlook.com
 (2603:10b6:806:a7:cafe::67) by SA9PR10CA0013.outlook.office365.com
 (2603:10b6:806:a7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24 via Frontend
 Transport; Mon, 12 Oct 2020 16:28:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com;
Received: from mail.micron.com (137.201.242.130) by
 SN1NAM01FT051.mail.protection.outlook.com (10.152.64.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3455.23 via Frontend Transport; Mon, 12 Oct 2020 16:28:07 +0000
Received: from micron.com (10.114.5.55) by bowex17c.micron.com
 (137.201.21.211) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Oct
 2020 10:28:00 -0600
From: Nabeel M Mohamed <nmeeramohide@micron.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-nvdimm@lists.01.org>
Subject: [PATCH v2 07/22] mpool: add superblock management routines
Date: Mon, 12 Oct 2020 11:27:21 -0500
Message-ID: <20201012162736.65241-8-nmeeramohide@micron.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20201012162736.65241-1-nmeeramohide@micron.com>
References: <20201012162736.65241-1-nmeeramohide@micron.com>
MIME-Version: 1.0
X-ClientProxiedBy: bowex17a.micron.com (137.201.21.209) To bowex17c.micron.com
 (137.201.21.211)
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24646.005
X-TM-AS-Result: No--19.925700-0.000000-31
X-TM-AS-MatchedID: 703713-704982-121367-703812-704959-700863-705063-701104-7
	03853-701667-703958-705022-700809-701342-700717-700028-701969-703408-701480
	-701809-703017-702395-188019-703027-704318-702299-704477-300015-703140-7032
	13-121336-701105-704673-703967-701275-701475-702754-704961-704960-703115-70
	5161-700488-704718-703231-701750-704481-851458-136523-701964-700950-700010-
	704714-703117-702699-702935-701172-705244-703215-121665-702837-701703-70308
	0-700026-701919-703815-105250-702525-702617-188199-703173-703192-704558-701
	893-704183-703935-702852-700877-703561-704574-704381-704962-705279-701698-7
	02398-701032-702415-703348-148004-148036-29997-42000-42003
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fe8c0ba-66af-424e-e1eb-08d86ecbcd6d
X-MS-TrafficTypeDiagnostic: CY1PR0801MB2138:
X-Microsoft-Antispam-PRVS: 
 <CY1PR0801MB21380B41BB51268DB5F90663B3070@CY1PR0801MB2138.namprd08.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	E8gYIldCu6rA3vQox3VrbrSy0bKBX+FuupDGC7FtDY4HsZj+dqMW7+dtPCJ95h3D/ocpLDhu5rAkcT+Gc5HJd+vMU6jSSg0Ef9rFW3CkZWmWBtqVWkVxQejTI7ecDov2dc5mIUKkJu89VFUyg+0Mbz4liQKCrgYuhDb+X/pdmVQLx43E684Lbtcy5uFK2gV1vwDjdPQ+9/KsQF3CFfOvjKzFYumP7Zwpi69kkLkheIk+k5nYY/+ly8FCSxAcA+GTr+/31X1rD57L8jSnMUaPNUp+TGrXjaXkLuwMDI5CH60i1m7RB9TJkajpLH7W5a+TP4zVBgVu/5P1pADNMdVobt//p1NlitN6etOj65gsIbXuK+5K2wAFjqF7MXjN4nex8u+fH69UE5/jP3LHyfrpk8Sl7W6gpqWMe35q3ddP/krShGp5SX2uwFZi+Kl7fY8bWUo/EyRSYlXw39MV8A89kg==
X-Forefront-Antispam-Report: 
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(46966005)(8936002)(83380400001)(70206006)(6666004)(2616005)(86362001)(5660300002)(82310400003)(7696005)(4326008)(70586007)(478600001)(1076003)(7636003)(316002)(107886003)(55016002)(82740400003)(336012)(26005)(186003)(30864003)(36756003)(110136005)(356005)(6286002)(47076004)(54906003)(426003)(33310700002)(2906002)(8676002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 16:28:07.5242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe8c0ba-66af-424e-e1eb-08d86ecbcd6d
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM01FT051.eop-nam01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0801MB2138
Message-ID-Hash: 3KJCNSOKYGGHOKXRFEY6OTGMA3P4F7DE
X-Message-ID-Hash: 3KJCNSOKYGGHOKXRFEY6OTGMA3P4F7DE
X-MailFrom: nmeeramohide@micron.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: smoyer@micron.com, gbecker@micron.com, plabat@micron.com, jgroves@micron.com, Nabeel M Mohamed <nmeeramohide@micron.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3KJCNSOKYGGHOKXRFEY6OTGMA3P4F7DE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Provides utilities to initialize, read, update, and erase mpool
superblocks.

Mpool stores two copies of superblocks, one at offset 0 and the
other at offset 8K in zone 0 of each media class volume. SB0 is
the authoritative copy and SB1 is used for recovery in the event
of corruption.

The superblock comprises the metadata required to uniquely identify
a media class volume, the name and UUID of the mpool to which this
volume belongs to, the superblock version, checksum and device
properties. The superblock on the capacity media class volume also
includes metadata for accessing the metadata container 0 (MDC-0).
MDC-0 is introduced in a future patch.

Co-developed-by: Greg Becker <gbecker@micron.com>
Signed-off-by: Greg Becker <gbecker@micron.com>
Co-developed-by: Pierre Labat <plabat@micron.com>
Signed-off-by: Pierre Labat <plabat@micron.com>
Co-developed-by: John Groves <jgroves@micron.com>
Signed-off-by: John Groves <jgroves@micron.com>
Signed-off-by: Nabeel M Mohamed <nmeeramohide@micron.com>
---
 drivers/mpool/init.c |   8 +
 drivers/mpool/sb.c   | 625 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 633 insertions(+)
 create mode 100644 drivers/mpool/sb.c

diff --git a/drivers/mpool/init.c b/drivers/mpool/init.c
index 70f907ccc28a..261ce67e94dd 100644
--- a/drivers/mpool/init.c
+++ b/drivers/mpool/init.c
@@ -10,6 +10,7 @@
 #include "omf_if.h"
 #include "pd.h"
 #include "smap.h"
+#include "sb.h"
 
 /*
  * Module params...
@@ -25,6 +26,7 @@ MODULE_PARM_DESC(chunk_size_kb, "Chunk size (in KiB) for device I/O");
 static void mpool_exit_impl(void)
 {
 	smap_exit();
+	sb_exit();
 	omf_exit();
 	pd_exit();
 }
@@ -46,6 +48,12 @@ static __init int mpool_init(void)
 		goto errout;
 	}
 
+	rc = sb_init();
+	if (rc) {
+		errmsg = "sb init failed";
+		goto errout;
+	}
+
 	rc = smap_init();
 	if (rc) {
 		errmsg = "smap init failed";
diff --git a/drivers/mpool/sb.c b/drivers/mpool/sb.c
new file mode 100644
index 000000000000..c161eff2bc0d
--- /dev/null
+++ b/drivers/mpool/sb.c
@@ -0,0 +1,625 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+/*
+ * Superblock module.
+ *
+ * Defines functions for managing per drive superblocks.
+ *
+ */
+
+#include <linux/slab.h>
+#include <linux/uio.h>
+
+#include "mpool_printk.h"
+#include "assert.h"
+
+#include "mpool_ioctl.h"
+#include "pd.h"
+#include "omf_if.h"
+#include "sb.h"
+#include "mclass.h"
+
+/* Cleared out sb */
+static struct omf_sb_descriptor SBCLEAR;
+
+/*
+ * Drives have 2 superblocks.
+ * + sb0 at byte offset 0
+ * + sb1 at byte offset SB_AREA_SZ + MDC0MD_AREA_SZ
+ *
+ * Read: sb0 is the authoritative copy, other copies are not used.
+ * Updates: sb0 is updated first; if successful sb1 is updated
+ */
+
+/*
+ * sb internal functions
+ */
+
+/**
+ * sb_prop_valid() - Validate the PD properties needed to read the erase superblocks.
+ *
+ * When the superblocks are read, the zone parameters may not been known
+ * yet. They may be obtained from the superblocks.
+ *
+ * Returns: true if we have enough to read the superblocks.
+ */
+static bool sb_prop_valid(struct pd_dev_parm *dparm)
+{
+	struct pd_prop *pd_prop = &dparm->dpr_prop;
+
+	if (SB_AREA_SZ < OMF_SB_DESC_PACKLEN) {
+
+		/* Guarantee that the SB area is large enough to hold an SB */
+		mp_pr_err("sb(%s): structure too big %lu %lu",
+			  -EINVAL, dparm->dpr_name, (ulong)SB_AREA_SZ, OMF_SB_DESC_PACKLEN);
+		return false;
+	}
+
+	if ((pd_prop->pdp_devtype != PD_DEV_TYPE_BLOCK_STD) &&
+	    (pd_prop->pdp_devtype != PD_DEV_TYPE_BLOCK_NVDIMM) &&
+	    (pd_prop->pdp_devtype != PD_DEV_TYPE_FILE)) {
+		mp_pr_err("sb(%s): unknown device type %d",
+			  -EINVAL, dparm->dpr_name, pd_prop->pdp_devtype);
+		return false;
+	}
+
+	if (PD_LEN(pd_prop) == 0) {
+		mp_pr_err("sb(%s): unknown device size", -EINVAL, dparm->dpr_name);
+		return false;
+	}
+
+	return true;
+};
+
+static u64 sb_idx2woff(u32 idx)
+{
+	return (u64)idx * (SB_AREA_SZ + MDC0MD_AREA_SZ);
+}
+
+/**
+ * sb_parm_valid() - Validate parameters passed to an SB API function
+ * @dparm: struct pd_dev_parm
+ *
+ * When this function is called it is assumed that the zone parameters of the
+ * PD are already known.
+ *
+ * Part of the validation is enforcing the rule from the comment above that
+ * there needs to be at least one more zone than those consumed by the
+ * (SB_SB_COUNT) superblocks.
+ *
+ * Returns: true if drive pd meets criteria for sb, false otherwise.
+ */
+static bool sb_parm_valid(struct pd_dev_parm *dparm)
+{
+	struct pd_prop *pd_prop = &dparm->dpr_prop;
+	u32 cnt;
+
+	if (SB_AREA_SZ < OMF_SB_DESC_PACKLEN) {
+		/* Guarantee that the SB area is large enough to hold an SB */
+		return false;
+	}
+
+	if (pd_prop->pdp_zparam.dvb_zonepg == 0) {
+		/* Zone size can't be 0. */
+		return false;
+	}
+
+	cnt = sb_zones_for_sbs(pd_prop);
+	if (cnt < 1) {
+		/* At least one zone is needed to hold SB0 and SB1. */
+		return false;
+	}
+
+	if (dparm->dpr_zonetot < (cnt + 1)) {
+		/* Guarantee that there is at least one zone not consumed by SBs. */
+		return false;
+	}
+
+	return true;
+};
+
+/*
+ * Write packed superblock in outbuf to sb copy number idx on drive pd.
+ * Returns: 0 if successful; -errno otherwise...
+ */
+static int sb_write_sbx(struct pd_dev_parm *dparm, char *outbuf, u32 idx)
+{
+	const struct kvec iov = { outbuf, SB_AREA_SZ };
+	u64 woff;
+	int rc;
+
+	woff = sb_idx2woff(idx);
+
+	rc = pd_zone_pwritev_sync(dparm, &iov, 1, 0, woff);
+	if (rc) {
+		mp_pr_err("sb(%s, %d): write failed, woff %lu",
+			  rc, dparm->dpr_name, idx, (ulong)woff);
+		return rc;
+	}
+
+	return 0;
+}
+
+/*
+ * Read packed superblock into inbuf from sb copy number idx.
+ * Returns: 0 if successful; -errno otherwise...
+ *
+ */
+static int sb_read_sbx(struct pd_dev_parm *dparm, char *inbuf, u32 idx)
+{
+	const struct kvec  iov = { inbuf, SB_AREA_SZ };
+	u64 woff;
+	int rc;
+
+	woff = sb_idx2woff(idx);
+
+	rc = pd_zone_preadv(dparm, &iov, 1, 0, woff);
+	if (rc) {
+		mp_pr_err("sb(%s, %d): read failed, woff %lu",
+			  rc, dparm->dpr_name, idx, (ulong)woff);
+		return rc;
+	}
+
+	return 0;
+}
+
+/*
+ * sb API functions
+ */
+
+_Static_assert(SB_AREA_SZ >= OMF_SB_DESC_PACKLEN, "sb_area_sz < omf_sb_desc_packlen");
+
+/*
+ * Determine if the mpool magic value exists in at least one place where
+ * expected on drive pd.  Does NOT imply drive has a valid superblock.
+ *
+ * Note: only pd.status and pd.parm must be set; no other pd fields accessed.
+ *
+ * Returns: 1 if found, 0 if not found, -(errno) if error reading
+ *
+ */
+int sb_magic_check(struct pd_dev_parm *dparm)
+{
+	int rval = 0, i;
+	char *inbuf;
+	int rc;
+
+	if (!sb_prop_valid(dparm)) {
+		rc = -EINVAL;
+		mp_pr_err("sb(%s): invalid param, zonepg %u zonetot %u",
+			  rc, dparm->dpr_name, dparm->dpr_zonepg, dparm->dpr_zonetot);
+		return rc;
+	}
+
+	inbuf = kmalloc_large(SB_AREA_SZ + 1, GFP_KERNEL);
+	if (!inbuf) {
+		rc = -ENOMEM;
+		mp_pr_err("sb(%s) magic check: buffer alloc failed", rc, dparm->dpr_name);
+		return rc;
+	}
+
+	for (i = 0; i < SB_SB_COUNT; i++) {
+		const struct kvec iov = { inbuf, SB_AREA_SZ };
+		u64 woff = sb_idx2woff(i);
+
+		memset(inbuf, 0, SB_AREA_SZ);
+
+		rc = pd_zone_preadv(dparm, &iov, 1, 0, woff);
+		if (rc) {
+			rval = rc;
+			mp_pr_err("sb(%s, %d) magic: read failed, woff %lu",
+				  rc, dparm->dpr_name, i, (ulong)woff);
+		} else if (omf_sb_has_magic_le(inbuf)) {
+			kfree(inbuf);
+			return 1;
+		}
+	}
+
+	kfree(inbuf);
+	return rval;
+}
+
+/*
+ * Write superblock sb to new (non-pool) drive
+ *
+ * Note: only pd.status and pd.parm must be set; no other pd fields accessed.
+ *
+ * Returns: 0 if successful; -errno otherwise...
+ *
+ */
+int sb_write_new(struct pd_dev_parm *dparm, struct omf_sb_descriptor *sb)
+{
+	char *outbuf;
+	int rc, i;
+
+	if (!sb_parm_valid(dparm)) {
+		rc = -EINVAL;
+		mp_pr_err("sb(%s) invalid param, zonepg %u zonetot %u",
+			  rc, dparm->dpr_name, dparm->dpr_zonepg, dparm->dpr_zonetot);
+		return rc;
+	}
+
+	outbuf = kmalloc_large(SB_AREA_SZ + 1, GFP_KERNEL);
+	if (!outbuf)
+		return -ENOMEM;
+
+	memset(outbuf, 0, SB_AREA_SZ);
+
+	rc = omf_sb_pack_htole(sb, outbuf);
+	if (rc) {
+		mp_pr_err("sb(%s) packing failed", rc, dparm->dpr_name);
+		kfree(outbuf);
+		return rc;
+	}
+
+	/*
+	 * since pd is not yet a pool member only succeed if write all sb
+	 * copies.
+	 */
+	for (i = 0; i < SB_SB_COUNT; i++) {
+		rc = sb_write_sbx(dparm, outbuf, i);
+		if (rc) {
+			mp_pr_err("sb(%s, %d): write sbx failed", rc, dparm->dpr_name, i);
+			break;
+		}
+	}
+
+	kfree(outbuf);
+	return rc;
+}
+
+/*
+ * Update superblock on pool drive
+ *
+ * Note: only pd.status and pd.parm must be set; no other pd fields accessed.
+ *
+ * Returns: 0 if successful; -errno otherwise..
+ *
+ */
+int sb_write_update(struct pd_dev_parm *dparm, struct omf_sb_descriptor *sb)
+{
+	char *outbuf;
+	int rc, i;
+
+	if (!sb_parm_valid(dparm)) {
+		rc = -EINVAL;
+		mp_pr_err("sb(%s) invalid param, zonepg %u zonetot %u partlen %lu",
+			  rc, dparm->dpr_name, dparm->dpr_zonepg, dparm->dpr_zonetot,
+			  (ulong)PD_LEN(&dparm->dpr_prop));
+		return rc;
+	}
+
+	outbuf = kmalloc_large(SB_AREA_SZ + 1, GFP_KERNEL);
+	if (!outbuf)
+		return -ENOMEM;
+
+	memset(outbuf, 0, SB_AREA_SZ);
+
+	rc = omf_sb_pack_htole(sb, outbuf);
+	if (rc) {
+		mp_pr_err("sb(%s) packing failed", rc, dparm->dpr_name);
+		kfree(outbuf);
+		return rc;
+	}
+
+	/* Update sb0 first and then sb1 if that is successful */
+	for (i = 0; i < SB_SB_COUNT; i++) {
+		rc = sb_write_sbx(dparm, outbuf, i);
+		if (rc) {
+			mp_pr_err("sb(%s, %d) sbx write failed", rc, dparm->dpr_name, i);
+			if (i == 0)
+				break;
+			rc = 0;
+		}
+	}
+
+	kfree(outbuf);
+
+	return rc;
+}
+
+/*
+ * Erase superblock on drive pd.
+ *
+ * Note: only pd properties must be set.
+ *
+ * Returns: 0 if successful; -errno otherwise...
+ *
+ */
+int sb_erase(struct pd_dev_parm *dparm)
+{
+	int rc = 0, i;
+	char *buf;
+
+	if (!sb_prop_valid(dparm)) {
+		rc = -EINVAL;
+		mp_pr_err("sb(%s) invalid param, zonepg %u zonetot %u", rc, dparm->dpr_name,
+			  dparm->dpr_zonepg, dparm->dpr_zonetot);
+		return rc;
+	}
+
+	buf = kmalloc_large(SB_AREA_SZ + 1, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	memset(buf, 0, SB_AREA_SZ);
+
+	for (i = 0; i < SB_SB_COUNT; i++) {
+		const struct kvec iov = { buf, SB_AREA_SZ };
+		u64 woff = sb_idx2woff(i);
+
+		rc = pd_zone_pwritev_sync(dparm, &iov, 1, 0, woff);
+		if (rc)
+			mp_pr_err("sb(%s, %d): erase failed", rc, dparm->dpr_name, i);
+	}
+
+	kfree(buf);
+
+	return rc;
+}
+
+static int sb_reconcile(struct omf_sb_descriptor *sb, struct pd_dev_parm *dparm, bool force)
+{
+	struct omf_devparm_descriptor *sb_parm = &sb->osb_parm;
+	struct pd_prop *pd_prop = &dparm->dpr_prop;
+	struct mc_parms mc_parms;
+	int rc;
+
+	pd_prop->pdp_mclassp = sb_parm->odp_mclassp;
+	pd_prop->pdp_zparam.dvb_zonepg = sb_parm->odp_zonepg;
+	pd_prop->pdp_zparam.dvb_zonetot = sb_parm->odp_zonetot;
+
+	if (force)
+		return 0;
+
+	if (pd_prop->pdp_devsz < sb_parm->odp_devsz) {
+		rc = -EINVAL;
+
+		mp_pr_err("sb(%s): devsz(%lu) > discovered (%lu)",
+			  rc, dparm->dpr_name, (ulong)sb_parm->odp_devsz,
+			  (ulong)pd_prop->pdp_devsz);
+		return rc;
+	}
+
+	if (PD_SECTORSZ(pd_prop) != sb_parm->odp_sectorsz) {
+		rc = -EINVAL;
+
+		mp_pr_err("sb(%s) sector size(%u) mismatches discovered(%u)",
+			  rc, dparm->dpr_name, sb_parm->odp_sectorsz, PD_SECTORSZ(pd_prop));
+		return rc;
+	}
+
+	if (pd_prop->pdp_devtype != sb_parm->odp_devtype) {
+		rc = -EINVAL;
+
+		mp_pr_err("sb(%s), pd type(%u) mismatches discovered(%u)",
+			  rc, dparm->dpr_name, sb_parm->odp_devtype, pd_prop->pdp_devtype);
+		return rc;
+	}
+
+	mc_pd_prop2mc_parms(pd_prop, &mc_parms);
+	if (mc_parms.mcp_features != sb_parm->odp_features) {
+		rc = -EINVAL;
+
+		mp_pr_err("sb(%s), pd features(%lu) mismatches discovered(%lu)",
+			  rc, dparm->dpr_name, (ulong)sb_parm->odp_features,
+			  (ulong)mc_parms.mcp_features);
+		return rc;
+	}
+
+	return 0;
+}
+
+/*
+ * Read superblock from drive pd.
+ *
+ * Note: only pd.status and pd.parm must be set; no other pd fields accessed.
+ *
+ * Returns: 0 if successful; -errno otherwise...
+ *
+ */
+int sb_read(struct pd_dev_parm *dparm, struct omf_sb_descriptor *sb, u16 *omf_ver, bool force)
+{
+	struct omf_sb_descriptor *sbtmp;
+	int rc = 0, i;
+	char *buf;
+
+	if (!sb_prop_valid(dparm)) {
+		rc = -EINVAL;
+		mp_pr_err("sb(%s) invalid parameter, zonepg %u zonetot %u",
+			  rc, dparm->dpr_name, dparm->dpr_zonepg, dparm->dpr_zonetot);
+		return rc;
+	}
+
+	sbtmp = kzalloc(sizeof(*sbtmp), GFP_KERNEL);
+	if (!sbtmp)
+		return -ENOMEM;
+
+	buf = kmalloc_large(SB_AREA_SZ + 1, GFP_KERNEL);
+	if (!buf) {
+		kfree(sbtmp);
+		return -ENOMEM;
+	}
+
+	/*
+	 * In 1.0, voting + SB gen numbers across the drive SBs is not used.
+	 * There is one authoritave replica that is SB0.
+	 * SB1 only used for debugging.
+	 */
+	for (i = 0; i < SB_SB_COUNT; i++) {
+		memset(buf, 0, SB_AREA_SZ);
+
+		rc = sb_read_sbx(dparm, buf, i);
+		if (rc)
+			mp_pr_err("sb(%s, %d) read sbx failed", rc, dparm->dpr_name, i);
+		else {
+			rc = omf_sb_unpack_letoh(sbtmp, buf, omf_ver);
+			if (rc)
+				mp_pr_err("sb(%s, %d) bad magic/version/cksum",
+					  rc, dparm->dpr_name, i);
+			else if (i == 0)
+				/* Deep copy to main struct  */
+				*sb = *sbtmp;
+		}
+		if (rc && (i == 0)) {
+			/*
+			 * SB0 has the authoritative replica of
+			 * MDC0 metadata. We need it.
+			 */
+			goto exit;
+		}
+	}
+
+	/*
+	 * Check that superblock SB0 is consistent and
+	 * update the PD properties from it.
+	 */
+	rc = sb_reconcile(sb, dparm, force);
+
+exit:
+	kfree(sbtmp);
+	kfree(buf);
+	return rc;
+}
+
+/*
+ * Clear (set to zeros) mdc0 portion of sb.
+ */
+void sbutil_mdc0_clear(struct omf_sb_descriptor *sb)
+{
+	sb->osb_mdc01gen = 0;
+	sb->osb_mdc01desc.ol_zcnt = 0;
+	mpool_uuid_clear(&sb->osb_mdc01uuid);
+
+	mpool_uuid_clear(&sb->osb_mdc01devid);
+	sb->osb_mdc01desc.ol_zaddr = 0;
+
+	sb->osb_mdc02gen = 0;
+	sb->osb_mdc02desc.ol_zcnt = 0;
+	mpool_uuid_clear(&sb->osb_mdc02uuid);
+
+	mpool_uuid_clear(&sb->osb_mdc02devid);
+	sb->osb_mdc02desc.ol_zaddr = 0;
+
+	mpool_uuid_clear(&sb->osb_mdc0dev.odp_devid);
+	sb->osb_mdc0dev.odp_zonetot = 0;
+	sb->osb_mdc0dev.odp_zonepg = 0;
+	sb->osb_mdc0dev.odp_mclassp = 0;
+	sb->osb_mdc0dev.odp_devtype = 0;
+	sb->osb_mdc0dev.odp_sectorsz = 0;
+	sb->osb_mdc0dev.odp_features = 0;
+}
+
+/*
+ * Copy mdc0 portion of srcsb to tgtsb.
+ */
+void sbutil_mdc0_copy(struct omf_sb_descriptor *tgtsb, struct omf_sb_descriptor *srcsb)
+{
+	tgtsb->osb_mdc01gen = srcsb->osb_mdc01gen;
+	mpool_uuid_copy(&tgtsb->osb_mdc01uuid, &srcsb->osb_mdc01uuid);
+	mpool_uuid_copy(&tgtsb->osb_mdc01devid, &srcsb->osb_mdc01devid);
+	tgtsb->osb_mdc01desc.ol_zcnt = srcsb->osb_mdc01desc.ol_zcnt;
+	tgtsb->osb_mdc01desc.ol_zaddr = srcsb->osb_mdc01desc.ol_zaddr;
+
+	tgtsb->osb_mdc02gen = srcsb->osb_mdc02gen;
+	mpool_uuid_copy(&tgtsb->osb_mdc02uuid, &srcsb->osb_mdc02uuid);
+	mpool_uuid_copy(&tgtsb->osb_mdc02devid, &srcsb->osb_mdc02devid);
+	tgtsb->osb_mdc02desc.ol_zcnt = srcsb->osb_mdc02desc.ol_zcnt;
+	tgtsb->osb_mdc02desc.ol_zaddr = srcsb->osb_mdc02desc.ol_zaddr;
+
+	mpool_uuid_copy(&tgtsb->osb_mdc0dev.odp_devid, &srcsb->osb_mdc0dev.odp_devid);
+	tgtsb->osb_mdc0dev.odp_devsz    = srcsb->osb_mdc0dev.odp_devsz;
+	tgtsb->osb_mdc0dev.odp_zonetot  = srcsb->osb_mdc0dev.odp_zonetot;
+	tgtsb->osb_mdc0dev.odp_zonepg   = srcsb->osb_mdc0dev.odp_zonepg;
+	tgtsb->osb_mdc0dev.odp_mclassp  = srcsb->osb_mdc0dev.odp_mclassp;
+	tgtsb->osb_mdc0dev.odp_devtype  = srcsb->osb_mdc0dev.odp_devtype;
+	tgtsb->osb_mdc0dev.odp_sectorsz = srcsb->osb_mdc0dev.odp_sectorsz;
+	tgtsb->osb_mdc0dev.odp_features = srcsb->osb_mdc0dev.odp_features;
+}
+
+/*
+ * Compare mdc0 portions of sb1 and sb2.
+ */
+static int sbutil_mdc0_eq(struct omf_sb_descriptor *sb1, struct omf_sb_descriptor *sb2)
+{
+	if (sb1->osb_mdc01gen != sb2->osb_mdc01gen ||
+	    sb1->osb_mdc01desc.ol_zcnt != sb2->osb_mdc01desc.ol_zcnt)
+		return 0;
+
+	if (mpool_uuid_compare(&sb1->osb_mdc01devid, &sb2->osb_mdc01devid) ||
+	    sb1->osb_mdc01desc.ol_zaddr != sb2->osb_mdc01desc.ol_zaddr)
+		return 0;
+
+	if (sb1->osb_mdc02gen != sb2->osb_mdc02gen ||
+	    sb1->osb_mdc02desc.ol_zcnt != sb2->osb_mdc02desc.ol_zcnt)
+		return 0;
+
+	if (mpool_uuid_compare(&sb1->osb_mdc02devid, &sb2->osb_mdc02devid) ||
+	    sb1->osb_mdc02desc.ol_zaddr != sb2->osb_mdc02desc.ol_zaddr)
+		return 0;
+
+	if (mpool_uuid_compare(&sb1->osb_mdc0dev.odp_devid, &sb2->osb_mdc0dev.odp_devid) ||
+	    sb1->osb_mdc0dev.odp_zonetot != sb2->osb_mdc0dev.odp_zonetot ||
+	    mc_cmp_omf_devparm(&sb1->osb_mdc0dev, &sb2->osb_mdc0dev))
+		return 0;
+
+	return 1;
+}
+
+/**
+ * sbutil_mdc0_isclear() - returns 1 if there is no MDC0 metadata in the
+ *	                   mdc0 portion of the super block.
+ * @sb:
+ *
+ * Some fields in the MDC0 portion of "sb" may not be 0 even if there is no
+ * MDC0 metadata present. It is due to metadata upgrade.
+ * Metadata upgrade may have to place a specific (non zero) value in a field
+ * that was not existing in a previous metadata version to indicate that
+ * the value is invalid.
+ */
+int sbutil_mdc0_isclear(struct omf_sb_descriptor *sb)
+{
+	return sbutil_mdc0_eq(&SBCLEAR, sb);
+}
+
+/*
+ * Validate mdc0 portion of sb
+ * Returns: 1 if valid; 0 otherwise.
+ */
+int sbutil_mdc0_isvalid(struct omf_sb_descriptor *sb)
+{
+	/* Basic consistency validation; can make more extensive as needed */
+
+	if (mpool_uuid_compare(&sb->osb_mdc01devid, &sb->osb_mdc02devid) ||
+	    mpool_uuid_compare(&sb->osb_mdc01devid, &sb->osb_mdc0dev.odp_devid))
+		return 0;
+
+	if (mpool_uuid_is_null(&sb->osb_mdc01devid))
+		return 0;
+
+	if (mpool_uuid_is_null(&sb->osb_parm.odp_devid))
+		return 0;
+
+	/* Confirm this drive is supposed to contain this mdc0 info */
+	if (mpool_uuid_compare(&sb->osb_mdc01devid, &sb->osb_parm.odp_devid))
+		return 0;
+
+	/* Found this drive in mdc0 strip list; confirm param and ownership */
+	if (mc_cmp_omf_devparm(&sb->osb_parm, &sb->osb_mdc0dev))
+		return 0;
+
+	return (sb->osb_mdc01desc.ol_zcnt == sb->osb_mdc02desc.ol_zcnt);
+}
+
+int sb_init(void)
+{
+	sbutil_mdc0_clear(&SBCLEAR);
+
+	return 0;
+}
+
+void sb_exit(void)
+{
+}
-- 
2.17.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

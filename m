Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6B828BD9D
	for <lists+linux-nvdimm@lfdr.de>; Mon, 12 Oct 2020 18:28:14 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E9C1F15B409EB;
	Mon, 12 Oct 2020 09:28:12 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.243.83; helo=nam12-dm6-obe.outbound.protection.outlook.com; envelope-from=nmeeramohide@micron.com; receiver=<UNKNOWN> 
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9760015AE2A5B
	for <linux-nvdimm@lists.01.org>; Mon, 12 Oct 2020 09:28:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiddeJpjNqhtH3adefsjWpdZ9wlDsb7zI6t1ba2MudJKb6+o3WvQNosRRqAyGc4nMyytrKBSaRa573JoqVA91q3hyP7N6so66t7KsXdH4kSPTUJh68N1AnUsSGuJqMTaqDk800A8ahoXevOW0cBrgoQVZqmPxXtlv/EdRis02uqXcCYL7LyxqofbKAr74TZuW5GYAyowJ4jV3CSRlEO1nTDgnmj/IbvcwJmdBPS85HC7ZIzxSGbs3ntgWcJoQ/LCTL017AEkaksamJWzjjpITdZV4rPr1sAty6w2SMtYtlxaVCqTrhCOv8r4MKrtecQzaBfdaQT6wNa2pVg4V1LqJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeqO1XOCAbA4eD3X+aSNpGKjC2bXt2pdV5gICxWVT80=;
 b=I+qKR61hKtE/KODKkK/K3nwfkediO6NnlIeTPvUBFIpQ+4Z/yQElwZQe1jSHnG5tO5OgH+6wh1s06yz6McKZMziTiziU4lgx8ScMUL1EVXurmZU2VbQF928akBe8MYCqzNbuTUrZ2vVB6X7DGI6cBoOtrdPPAamjGY2G+9Ro+T/47RBD3NjteAY3jPf8VKtlpz2maV4ZYlo0+YBzaD09eQ0H1qdUWm9xV4aRgER+ekCtWpBN+KYfDjfvGAi3mUJHWQ8aC17W4iNyTCqGPAdhjaFlvtg11h9Gye5jwA71UVf0Amaznxjj8u1YWT5j5X3xOJZbLUqJTnH5fA33C/sAJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=kvack.org smtp.mailfrom=micron.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeqO1XOCAbA4eD3X+aSNpGKjC2bXt2pdV5gICxWVT80=;
 b=pRiSpgI1Al9/fsuZC9OcIGkw5tM1aPmffA0PJPJlWl6aEI1wxldty4TvxlHnF1Pb+eqKoIWlP5iQuTivO/c+FiHEU25ufsBehd8y5+7xkMoVsw9xOT9GqK16hHx4mZxOsWFRpLBqgnbQBOoy0SCJfJy8O3ls7qm29J0tE7y+RGg=
Received: from SN4PR0201CA0064.namprd02.prod.outlook.com
 (2603:10b6:803:20::26) by BN8PR08MB5729.namprd08.prod.outlook.com
 (2603:10b6:408:b6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Mon, 12 Oct
 2020 16:28:05 +0000
Received: from SN1NAM01FT015.eop-nam01.prod.protection.outlook.com
 (2603:10b6:803:20:cafe::ac) by SN4PR0201CA0064.outlook.office365.com
 (2603:10b6:803:20::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend
 Transport; Mon, 12 Oct 2020 16:28:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com;
Received: from mail.micron.com (137.201.242.130) by
 SN1NAM01FT015.mail.protection.outlook.com (10.152.65.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3455.23 via Frontend Transport; Mon, 12 Oct 2020 16:28:04 +0000
Received: from micron.com (10.114.5.55) by bowex17c.micron.com
 (137.201.21.211) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Oct
 2020 10:27:57 -0600
From: Nabeel M Mohamed <nmeeramohide@micron.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-nvdimm@lists.01.org>
Subject: [PATCH v2 04/22] mpool: add pool drive component which handles mpool IO using the block layer API
Date: Mon, 12 Oct 2020 11:27:18 -0500
Message-ID: <20201012162736.65241-5-nmeeramohide@micron.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20201012162736.65241-1-nmeeramohide@micron.com>
References: <20201012162736.65241-1-nmeeramohide@micron.com>
MIME-Version: 1.0
X-ClientProxiedBy: bowex17a.micron.com (137.201.21.209) To bowex17c.micron.com
 (137.201.21.211)
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24646.005
X-TM-AS-Result: No--16.147700-0.000000-31
X-TM-AS-MatchedID: 701475-702501-702686-703812-705244-703226-701342-704949-7
	04318-860560-703027-703953-702559-701480-701809-701280-703017-702395-188019
	-702754-121224-702914-703967-702299-704477-300015-703140-703213-121336-7011
	05-704673-701343-701275-703815-701443-704388-704895-704183-704264-117072-70
	2230-704481-137717-121665-703881-702558-700946-703878-851458-701847-703816-
	705161-704193-701590-703357-704542-701705-700458-704184-113872-702898-86459
	6-702700-188199-700069-702617-704978-704397-701813-704239-702613-703285-186
	035-148004-148036-42000-42003-190014
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d85fde22-5ac5-4e34-5996-08d86ecbcbd8
X-MS-TrafficTypeDiagnostic: BN8PR08MB5729:
X-Microsoft-Antispam-PRVS: 
 <BN8PR08MB5729E98C1A157B0C7990F2F8B3070@BN8PR08MB5729.namprd08.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	anEl4Lyw+tXeTkE7XWB1CsMqa+AL29uS9WkfCAoYe/wgIcn4XWvDkb4DUnGf6WFZW1KQY8K3UKNnGTVsaqNkMDr9DqDJWosGBybLit+9rhiTY+1aYTjKrmws7PcJ5DhdKjfj0QzUv8WOHcUKQuO7ZGwS6Mq5vIzLHyJO4z/rCAhP8yHTbz83BPL1DrWvxtp9mavkmbcN+c5zjvuHuy71vY9rGcCoQb4mHAHi3rFQQtXugbqunxmWoEMUWEHXUCri1C1egfkNCYRhlqCIFjj35zim7yN0dFYI78o7ezPU9cj3sUoeUp/oIXz5ZZHin0Etfp3aO7yfRl+pmiaAE8pA7U7AGEz9pam9E9vdkYOcOZ0NNtXoRusm3iDv/aDokc5Th+2e+2TAOe9VingUz67KTsDQGXqig+1DjcVL/CFNKuRmr/mKBIBkJDmKD02h6BYmbY51S5CuWSNo9if8cN4G/A==
X-Forefront-Antispam-Report: 
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(46966005)(8936002)(7696005)(6666004)(54906003)(8676002)(107886003)(2906002)(1076003)(55016002)(316002)(186003)(26005)(70206006)(6286002)(110136005)(30864003)(86362001)(70586007)(5660300002)(33310700002)(478600001)(356005)(7636003)(4326008)(47076004)(83380400001)(82740400003)(426003)(336012)(82310400003)(2616005)(36756003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 16:28:04.8546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d85fde22-5ac5-4e34-5996-08d86ecbcbd8
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM01FT015.eop-nam01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR08MB5729
Message-ID-Hash: URW35OFHON3A34J5SXYUWLBIZRGWNUAU
X-Message-ID-Hash: URW35OFHON3A34J5SXYUWLBIZRGWNUAU
X-MailFrom: nmeeramohide@micron.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: smoyer@micron.com, gbecker@micron.com, plabat@micron.com, jgroves@micron.com, Nabeel M Mohamed <nmeeramohide@micron.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/URW35OFHON3A34J5SXYUWLBIZRGWNUAU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The pool drive (pd) component interfaces with the block layer to
read, write, flush, and discard mpool objects.

The underlying block device(s) are opened during mpool activation
and remains open until deactivated.

Read/write IO to an mpool device is chunked by the PD layer.
Chunking interleaves IO from different streams providing better
QoS.  The size of each chunk (or BIO size) is determined by the
module parameter 'chunk_size_kb'.  All the chunks from a single
r/w request is issued asynchronously to the block layer using
BIO chaining.

Co-developed-by: Greg Becker <gbecker@micron.com>
Signed-off-by: Greg Becker <gbecker@micron.com>
Co-developed-by: Pierre Labat <plabat@micron.com>
Signed-off-by: Pierre Labat <plabat@micron.com>
Co-developed-by: John Groves <jgroves@micron.com>
Signed-off-by: John Groves <jgroves@micron.com>
Signed-off-by: Nabeel M Mohamed <nmeeramohide@micron.com>
---
 drivers/mpool/init.c |  31 +++-
 drivers/mpool/init.h |  12 ++
 drivers/mpool/pd.c   | 424 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 466 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mpool/init.h
 create mode 100644 drivers/mpool/pd.c

diff --git a/drivers/mpool/init.c b/drivers/mpool/init.c
index 0493fb5b1157..294cf3cbbaa7 100644
--- a/drivers/mpool/init.c
+++ b/drivers/mpool/init.c
@@ -5,13 +5,42 @@
 
 #include <linux/module.h>
 
+#include "mpool_printk.h"
+
+#include "pd.h"
+
+/*
+ * Module params...
+ */
+unsigned int rsvd_bios_max __read_mostly = 16;
+module_param(rsvd_bios_max, uint, 0444);
+MODULE_PARM_DESC(rsvd_bios_max, "max reserved bios in mpool bioset");
+
+int chunk_size_kb __read_mostly = 128;
+module_param(chunk_size_kb, uint, 0644);
+MODULE_PARM_DESC(chunk_size_kb, "Chunk size (in KiB) for device I/O");
+
+static void mpool_exit_impl(void)
+{
+	pd_exit();
+}
+
 static __init int mpool_init(void)
 {
-	return 0;
+	int rc;
+
+	rc = pd_init();
+	if (rc) {
+		mp_pr_err("pd init failed", rc);
+		mpool_exit_impl();
+	}
+
+	return rc;
 }
 
 static __exit void mpool_exit(void)
 {
+	mpool_exit_impl();
 }
 
 module_init(mpool_init);
diff --git a/drivers/mpool/init.h b/drivers/mpool/init.h
new file mode 100644
index 000000000000..e02a9672e727
--- /dev/null
+++ b/drivers/mpool/init.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+
+#ifndef MPOOL_INIT_H
+#define MPOOL_INIT_H
+
+extern unsigned int rsvd_bios_max;
+extern int chunk_size_kb;
+
+#endif /* MPOOL_INIT_H */
diff --git a/drivers/mpool/pd.c b/drivers/mpool/pd.c
new file mode 100644
index 000000000000..f13c7704efad
--- /dev/null
+++ b/drivers/mpool/pd.c
@@ -0,0 +1,424 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+/*
+ * Pool drive module with backing block devices.
+ *
+ * Defines functions for probing, reading, and writing drives in an mpool.
+ * IO is done using kerel BIO facilities.
+ */
+
+#define _LARGEFILE64_SOURCE
+
+#include <linux/fs.h>
+#include <linux/blkdev.h>
+#include <linux/blk_types.h>
+
+#include "mpool_printk.h"
+#include "assert.h"
+
+#include "init.h"
+#include "omf_if.h"
+#include "pd.h"
+
+#ifndef SECTOR_SHIFT
+#define SECTOR_SHIFT   9
+#endif
+
+static struct bio_set mpool_bioset;
+
+static const fmode_t    pd_bio_fmode = FMODE_READ | FMODE_WRITE | FMODE_EXCL;
+static char            *pd_bio_holder = "mpool";
+
+int pd_dev_open(const char *path, struct pd_dev_parm *dparm, struct pd_prop *pd_prop)
+{
+	struct block_device *bdev;
+
+	bdev = blkdev_get_by_path(path, pd_bio_fmode, pd_bio_holder);
+	if (IS_ERR(bdev))
+		return PTR_ERR(bdev);
+
+	dparm->dpr_dev_private = bdev;
+	dparm->dpr_prop = *pd_prop;
+
+	if ((pd_prop->pdp_devtype != PD_DEV_TYPE_BLOCK_STD) &&
+	    (pd_prop->pdp_devtype != PD_DEV_TYPE_BLOCK_NVDIMM)) {
+		int rc = -EINVAL;
+
+		mp_pr_err("unsupported PD type %d", rc, pd_prop->pdp_devtype);
+		return rc;
+	}
+
+	return 0;
+}
+
+int pd_dev_close(struct pd_dev_parm *dparm)
+{
+	struct block_device *bdev = dparm->dpr_dev_private;
+
+	if (bdev) {
+		dparm->dpr_dev_private = NULL;
+		sync_blockdev(bdev);
+		invalidate_bdev(bdev);
+		blkdev_put(bdev, pd_bio_fmode);
+	}
+
+	return bdev ? 0 : -EINVAL;
+}
+
+int pd_dev_flush(struct pd_dev_parm *dparm)
+{
+	struct block_device *bdev;
+	int rc;
+
+	bdev = dparm->dpr_dev_private;
+	if (!bdev) {
+		rc = -EINVAL;
+		mp_pr_err("bdev %s not registered", rc, dparm->dpr_name);
+		return rc;
+	}
+
+	rc = blkdev_issue_flush(bdev, GFP_NOIO);
+	if (rc)
+		mp_pr_err("bdev %s, flush failed", rc, dparm->dpr_name);
+
+	return rc;
+}
+
+/**
+ * pd_bio_discard() - issue discard command to erase a byte-aligned region
+ * @dparm:
+ * @off:
+ * @len:
+ */
+static int pd_bio_discard(struct pd_dev_parm *dparm, loff_t off, size_t len)
+{
+	struct block_device *bdev;
+	int rc;
+
+	bdev = dparm->dpr_dev_private;
+	if (!bdev) {
+		rc = -EINVAL;
+		mp_pr_err("bdev %s not registered", rc, dparm->dpr_name);
+		return rc;
+	}
+
+	/* Validate I/O offset is sector-aligned */
+	if (off & PD_SECTORMASK(&dparm->dpr_prop)) {
+		rc = -EINVAL;
+		mp_pr_err("bdev %s, offset 0x%lx not multiple of sec size %u",
+			  rc, dparm->dpr_name, (ulong)off, (1 << PD_SECTORSZ(&dparm->dpr_prop)));
+		return rc;
+	}
+
+	if (off > PD_LEN(&dparm->dpr_prop)) {
+		rc = -EINVAL;
+		mp_pr_err("bdev %s, offset 0x%lx past end 0x%lx",
+			  rc, dparm->dpr_name, (ulong)off, (ulong)PD_LEN(&dparm->dpr_prop));
+		return rc;
+	}
+
+	rc = blkdev_issue_discard(bdev, off >> SECTOR_SHIFT, len >> SECTOR_SHIFT, GFP_NOIO, 0);
+	if (rc)
+		mp_pr_err("bdev %s, offset 0x%lx len 0x%lx, discard faiure",
+			  rc, dparm->dpr_name, (ulong)off, (ulong)len);
+
+	return rc;
+}
+
+/**
+ * pd_zone_erase() - issue write-zeros or discard commands to erase PD
+ * @dparm:
+ * @zaddr:
+ * @zonecnt:
+ * @flag:
+ * @afp:
+ */
+int pd_zone_erase(struct pd_dev_parm *dparm, u64 zaddr, u32 zonecnt, bool reads_erased)
+{
+	int rc = 0;
+	u64 cmdopt;
+
+	/* Validate args against zone param */
+	if (zaddr >= dparm->dpr_zonetot)
+		return -EINVAL;
+
+	if (zonecnt == 0)
+		zonecnt = dparm->dpr_zonetot - zaddr;
+
+	if (zonecnt > (dparm->dpr_zonetot - zaddr))
+		return -EINVAL;
+
+	if (zonecnt == 0)
+		return 0;
+
+	/*
+	 * When both DIF and SED are enabled, read from a discared block
+	 * would fail, so we can't discard blocks if both DIF and SED are
+	 * enabled AND we need to read blocks after erase.
+	 */
+	cmdopt = dparm->dpr_cmdopt;
+	if ((cmdopt & PD_CMD_DISCARD) &&
+	    !(reads_erased && (cmdopt & PD_CMD_DIF_ENABLED) && (cmdopt & PD_CMD_SED_ENABLED))) {
+		size_t zlen;
+
+		zlen = dparm->dpr_zonepg << PAGE_SHIFT;
+		rc = pd_bio_discard(dparm, zaddr * zlen, zonecnt * zlen);
+	}
+
+	return rc;
+}
+
+static void pd_bio_init(struct bio *bio, struct block_device *bdev, int rw, loff_t off, int flags)
+{
+	bio_set_op_attrs(bio, rw, flags);
+	bio->bi_iter.bi_sector = off >> SECTOR_SHIFT;
+	bio_set_dev(bio, bdev);
+}
+
+static struct bio *pd_bio_chain(struct bio *target, unsigned int nr_pages, gfp_t gfp)
+{
+	struct bio *new;
+
+	new = bio_alloc_bioset(gfp, nr_pages, &mpool_bioset);
+
+	if (!target)
+		return new;
+
+	if (new) {
+		bio_chain(target, new);
+		submit_bio(target);
+	} else {
+		submit_bio_wait(target);
+		bio_put(target);
+	}
+
+	return new;
+}
+
+/**
+ * pd_bio_rw() -
+ * @dparm:
+ * @iov:
+ * @iovcnt:
+ * @off: offset in bytes on disk
+ * @rw:
+ * @opflags:
+ *
+ * pd_bio_rw() expects a list of kvecs wherein each base ptr is sector
+ * aligned and each length is multiple of sectors.
+ *
+ * If the IO is bigger than 1MiB (BIO_MAX_PAGES pages) or chunk_size_kb,
+ * it is split in several IOs.
+ */
+static int pd_bio_rw(struct pd_dev_parm *dparm, const struct kvec *iov,
+		     int iovcnt, loff_t off, int rw, int opflags)
+{
+	struct block_device *bdev;
+	struct page *page;
+	struct bio *bio;
+	uintptr_t iov_base;
+	u64 sector_mask;
+	u32 tot_pages, tot_len, len, iov_len, left, iolimit;
+	int i, cc, rc = 0;
+
+	if (iovcnt < 1)
+		return 0;
+
+	bdev = dparm->dpr_dev_private;
+	if (!bdev) {
+		rc = -EINVAL;
+		mp_pr_err("bdev %s not registered", rc, dparm->dpr_name);
+		return rc;
+	}
+
+	sector_mask = PD_SECTORMASK(&dparm->dpr_prop);
+	if (off & sector_mask) {
+		rc = -EINVAL;
+		mp_pr_err("bdev %s, %s offset 0x%lx not multiple of sector size %u",
+			  rc, dparm->dpr_name, (rw == REQ_OP_READ) ? "read" : "write",
+			  (ulong)off, (1 << PD_SECTORSZ(&dparm->dpr_prop)));
+		return rc;
+	}
+
+	if (off > PD_LEN(&dparm->dpr_prop)) {
+		rc = -EINVAL;
+		mp_pr_err("bdev %s, %s offset 0x%lx past device end 0x%lx",
+			  rc, dparm->dpr_name, (rw == REQ_OP_READ) ? "read" : "write",
+			  (ulong)off, (ulong)PD_LEN(&dparm->dpr_prop));
+		return rc;
+	}
+
+	tot_pages = 0;
+	tot_len = 0;
+	for (i = 0; i < iovcnt; i++) {
+		if (!PAGE_ALIGNED((uintptr_t)iov[i].iov_base) || (iov[i].iov_len & sector_mask)) {
+			rc = -EINVAL;
+			mp_pr_err("bdev %s, %s off 0x%lx, misaligned kvec, base 0x%lx, len 0x%lx",
+				  rc, dparm->dpr_name, (rw == REQ_OP_READ) ? "read" : "write",
+				  (ulong)off, (ulong)iov[i].iov_base, (ulong)iov[i].iov_len);
+			return rc;
+		}
+
+		iov_len = iov[i].iov_len;
+		tot_len += iov_len;
+		while (iov_len > 0) {
+			len = min_t(size_t, PAGE_SIZE, iov_len);
+			iov_len -= len;
+			tot_pages++;
+		}
+	}
+
+	if (off + tot_len > PD_LEN(&dparm->dpr_prop)) {
+		rc = -EINVAL;
+		mp_pr_err("bdev %s, %s I/O end past device end 0x%lx, 0x%lx:0x%x",
+			  rc, dparm->dpr_name, (rw == REQ_OP_READ) ? "read" : "write",
+			  (ulong)PD_LEN(&dparm->dpr_prop), (ulong)off, tot_len);
+		return rc;
+	}
+
+	if (tot_len == 0)
+		return 0;
+
+	/* IO size for each bio is determined by the chunk size. */
+	iolimit = chunk_size_kb >> (PAGE_SHIFT - 10);
+	iolimit = clamp_t(u32, iolimit, 32, BIO_MAX_PAGES);
+
+	left = 0;
+	bio = NULL;
+
+	for (i = 0; i < iovcnt; i++) {
+		iov_base = (uintptr_t)iov[i].iov_base;
+		iov_len = iov[i].iov_len;
+
+		while (iov_len > 0) {
+			if (left == 0) {
+				left = min_t(size_t, tot_pages, iolimit);
+
+				bio = pd_bio_chain(bio, left, GFP_NOIO);
+				if (!bio)
+					return -ENOMEM;
+
+				pd_bio_init(bio, bdev, rw, off, opflags);
+			}
+
+			len = min_t(size_t, PAGE_SIZE, iov_len);
+			page = virt_to_page(iov_base);
+			cc = -1;
+
+			if (page)
+				cc = bio_add_page(bio, page, len, 0);
+
+			if (cc != len) {
+				if (cc == 0 && bio->bi_vcnt > 0) {
+					left = 0;
+					continue;
+				}
+
+				bio_io_error(bio);
+				bio_put(bio);
+				return -ENOTRECOVERABLE;
+			}
+
+			iov_len -= len;
+			iov_base += len;
+			off += len;
+			left--;
+			tot_pages--;
+		}
+	}
+
+	ASSERT(bio);
+	ASSERT(tot_pages == 0);
+
+	rc = submit_bio_wait(bio);
+	bio_put(bio);
+
+	return rc;
+}
+
+int pd_zone_pwritev(struct pd_dev_parm *dparm, const struct kvec *iov,
+		    int iovcnt, u64 zaddr, loff_t boff, int opflags)
+{
+	loff_t woff;
+
+	woff = ((u64)dparm->dpr_zonepg << PAGE_SHIFT) * zaddr + boff;
+
+	return pd_bio_rw(dparm, iov, iovcnt, woff, REQ_OP_WRITE, opflags);
+}
+
+int pd_zone_pwritev_sync(struct pd_dev_parm *dparm, const struct kvec *iov,
+			 int iovcnt, u64 zaddr, loff_t boff)
+{
+	struct block_device *bdev;
+	int rc;
+
+	rc = pd_zone_pwritev(dparm, iov, iovcnt, zaddr, boff, REQ_FUA);
+	if (rc)
+		return rc;
+
+	/*
+	 * This sync & invalidate bdev ensures that the data written from the
+	 * kernel is immediately visible to the user-space.
+	 */
+	bdev = dparm->dpr_dev_private;
+	if (bdev) {
+		sync_blockdev(bdev);
+		invalidate_bdev(bdev);
+	}
+
+	return 0;
+}
+
+int pd_zone_preadv(struct pd_dev_parm *dparm, const struct kvec *iov,
+		   int iovcnt, u64 zaddr, loff_t boff)
+{
+	loff_t roff;
+
+	roff = ((u64)dparm->dpr_zonepg << PAGE_SHIFT) * zaddr + boff;
+
+	return pd_bio_rw(dparm, iov, iovcnt, roff, REQ_OP_READ, 0);
+}
+
+void pd_dev_set_unavail(struct pd_dev_parm *dparm, struct omf_devparm_descriptor *omf_devparm)
+{
+	struct pd_prop *pd_prop = &(dparm->dpr_prop);
+
+	/*
+	 * Fill in dparm for unavailable drive; sets zone parm and other
+	 * PD properties we keep in metadata; no ops vector because we need
+	 * the device to be available to know it (the discovery gets it).
+	 */
+	strncpy(dparm->dpr_prop.pdp_didstr, PD_DEV_ID_PDUNAVAILABLE, PD_DEV_ID_LEN);
+	pd_prop->pdp_devstate = PD_DEV_STATE_UNAVAIL;
+	pd_prop->pdp_cmdopt = PD_CMD_NONE;
+
+	pd_prop->pdp_zparam.dvb_zonepg  = omf_devparm->odp_zonepg;
+	pd_prop->pdp_zparam.dvb_zonetot = omf_devparm->odp_zonetot;
+	pd_prop->pdp_mclassp  = omf_devparm->odp_mclassp;
+	pd_prop->pdp_phys_if  = 0;
+	pd_prop->pdp_sectorsz = omf_devparm->odp_sectorsz;
+	pd_prop->pdp_devsz    = omf_devparm->odp_devsz;
+}
+
+
+int pd_init(void)
+{
+	int rc;
+
+	chunk_size_kb = clamp_t(uint, chunk_size_kb, 128, 1024);
+
+	rsvd_bios_max = clamp_t(uint, rsvd_bios_max, 1, 1024);
+
+	rc = bioset_init(&mpool_bioset, rsvd_bios_max, 0, BIOSET_NEED_BVECS);
+	if (rc)
+		mp_pr_err("mpool bioset init failed", rc);
+
+	return rc;
+}
+
+void pd_exit(void)
+{
+	bioset_exit(&mpool_bioset);
+}
-- 
2.17.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

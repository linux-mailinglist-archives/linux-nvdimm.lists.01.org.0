Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAA028BDAD
	for <lists+linux-nvdimm@lfdr.de>; Mon, 12 Oct 2020 18:28:41 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2D30C15B7DEA8;
	Mon, 12 Oct 2020 09:28:23 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.220.87; helo=nam11-co1-obe.outbound.protection.outlook.com; envelope-from=nmeeramohide@micron.com; receiver=<UNKNOWN> 
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7302215B409E9
	for <linux-nvdimm@lists.01.org>; Mon, 12 Oct 2020 09:28:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fv7LKqArXtGq9WfuG54l0ZsxFeouktiG49qZMskuFWMRADcZtoUHxM730sGOmDgfsrfgN1xr8oyL4GdiA3g+l0kyCb3LBX2m5vl3SX64x6ENC7KFqPJEvMaeK9ebzalGKYQIyOl5i9gg7Pg5fPloW5ckEEV4+RHgxDyC5/Q3ZTOsFR29qC1kpOwWw88EIeWptPEe5kDApYNTB81POQirBUZu5vr5Kx11tjrZ+0xYydlZiOTc0mb9bMWN43j4Amu/U+ypz3cuiqhEQ96LsB1ThDAW3vQG/1OHYePkk48C9FqbzesBelMPOVunsoeB7QIortI4T3i8ptgnChXImNB0EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkVoFiUi2Iz/F6Em5YnRLCM8GAu1BaSixEQ4mQn5KvQ=;
 b=c1lGbPRA70S6wWZwUZWyLF0cDhhvuBKoKlT4GBGxXpSJ91eYgEA21mqyK8847kZl44g1M9PfcHJJEUgvWCRU8OBp34kCw+aQxLCz5BEkB9Fqn8xL8eIQdMbdtNAn96Tnfa5/IwWa/UrOLPHgAveYlKILntXIdfDRFcDGvdsFCurjzcYqce7lJRUL5GByLGTqysqNiolhYqiraPGAdO57ukeoQgvj0VSIR7Fwdb3rf1weRz4eW7Fw5RApJmb5uEnLRJhwodXA1G7rLzvOkKvx7OouRvfxPZ9ZWDwg+0dSLTxnvZTc4jnZ2U4+kRFIRm17MC6tMkal7l6BpXLRKB2xyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=kvack.org smtp.mailfrom=micron.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkVoFiUi2Iz/F6Em5YnRLCM8GAu1BaSixEQ4mQn5KvQ=;
 b=R8IHQXUzZL8og9qQx/TrQQh0nqW7Um3l+9NDHRnKyprzh73gVBx2ar8BHPhhX9+3ILhW/Eut+CPAtjjqgff4RBq6BWic2zOYXLa3dufBLDfHWxUSj956ZtIqPCyMFOg4Ci9ag3NIQkvo+DHmzwTGi3q8+6m2ovYuU171I3duAkM=
Received: from SA9PR10CA0018.namprd10.prod.outlook.com (2603:10b6:806:a7::23)
 by MN2PR08MB5758.namprd08.prod.outlook.com (2603:10b6:208:115::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Mon, 12 Oct
 2020 16:28:14 +0000
Received: from SN1NAM01FT051.eop-nam01.prod.protection.outlook.com
 (2603:10b6:806:a7:cafe::cb) by SA9PR10CA0018.outlook.office365.com
 (2603:10b6:806:a7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.26 via Frontend
 Transport; Mon, 12 Oct 2020 16:28:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com;
Received: from mail.micron.com (137.201.242.130) by
 SN1NAM01FT051.mail.protection.outlook.com (10.152.64.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3455.23 via Frontend Transport; Mon, 12 Oct 2020 16:28:13 +0000
Received: from micron.com (10.114.5.55) by bowex17c.micron.com
 (137.201.21.211) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Oct
 2020 10:28:10 -0600
From: Nabeel M Mohamed <nmeeramohide@micron.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-nvdimm@lists.01.org>
Subject: [PATCH v2 18/22] mpool: add object lifecycle management ioctls
Date: Mon, 12 Oct 2020 11:27:32 -0500
Message-ID: <20201012162736.65241-19-nmeeramohide@micron.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20201012162736.65241-1-nmeeramohide@micron.com>
References: <20201012162736.65241-1-nmeeramohide@micron.com>
MIME-Version: 1.0
X-ClientProxiedBy: bowex17a.micron.com (137.201.21.209) To bowex17c.micron.com
 (137.201.21.211)
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24646.005
X-TM-AS-Result: No--13.608500-0.000000-31
X-TM-AS-MatchedID: 700076-703812-705244-701791-702732-701515-703408-704985-8
	47298-703226-701579-703956-701480-702395-188019-704477-704926-703357-702914
	-704318-700069-701475-703213-105630-105640-701342-704978-704397-703815-7019
	64-702876-703953-702617-700025-705279-701104-704200-703215-139704-780058-70
	3129-114012-700458-703958-700337-701343-700224-700002-703325-701893-851458-
	704612-700737-704264-701270-703694-704401-847575-704418-300015-701750-70449
	9-703080-700714-703347-703027-704060-702525-700946-148004-148036-20020-4200
	0-42003
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6c48898-c47c-4bd5-54e9-08d86ecbd10f
X-MS-TrafficTypeDiagnostic: MN2PR08MB5758:
X-Microsoft-Antispam-PRVS: 
 <MN2PR08MB5758EB00A9FF06DA101EA392B3070@MN2PR08MB5758.namprd08.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Oob-TLC-OOBClassifiers: OLM:108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CqtV/udELRQI4Zpu/mAAQwqbrYRaa6snufNogc7UFtHx4mxTLmQNAl2+LFR3IPyW5+m22UaAikrlOUTyufXpUD1Na5WXwH2XVKwzUw+hQ7lkEVZiva8Y4j+XmRRFSG1kgUmbBraiXufCzGTC9wmPYPhCmvhpSLCK2+rLCa3JV+zwv+39Eo0ZmFTv6ggBuwTU82KP9mpU0cpjxFhW0zhWDgtSxYdstywhNF6FlI19MhANlq+gcGyHAW403jOmzrCgISoCyx6GwFRtrkTK/VRndv6O5RZTEl53/Cc2xLU06AW2dXizzz2gGTJrynX1O0uEdxZnKt6XStfvCu5enq5WzeV23L0o0G6uZo0oybcKLN912Ud+1CLaPb9KH3nM1srvTB3snuHy8iVtiukGYQ6hM71bds0ov/8f7uyboyDrLQpt1ioUmvDpVWR9T+4KXG2ApSQlihG1cOavlR8NOULRQjr3M6Y248bx1vgrO71hQaQ3WasFBbOosOL6Tqrw5vn+VK1vsZvqOxgL+aVgzcAfdiUd1jj8fa13uwJzRBkmagM=
X-Forefront-Antispam-Report: 
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(46966005)(4326008)(83380400001)(1076003)(7636003)(8936002)(36756003)(70206006)(966005)(70586007)(426003)(6666004)(82740400003)(336012)(186003)(6286002)(2906002)(55016002)(86362001)(33310700002)(316002)(110136005)(47076004)(5660300002)(54906003)(8676002)(7696005)(26005)(30864003)(2616005)(478600001)(107886003)(82310400003)(356005)(71600200004)(2101003)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 16:28:13.6005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c48898-c47c-4bd5-54e9-08d86ecbd10f
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM01FT051.eop-nam01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB5758
Message-ID-Hash: 7CUZJF7DXRYR6EWN5INBDUTIYQC5KUHJ
X-Message-ID-Hash: 7CUZJF7DXRYR6EWN5INBDUTIYQC5KUHJ
X-MailFrom: nmeeramohide@micron.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: smoyer@micron.com, gbecker@micron.com, plabat@micron.com, jgroves@micron.com, Nabeel M Mohamed <nmeeramohide@micron.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7CUZJF7DXRYR6EWN5INBDUTIYQC5KUHJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This adds the mblock and mlog management ioctls: alloc, commit,
abort, destroy, read, write, fetch properties etc.

The mblock and mlog management ioctl handlers are thin wrappers
around the core mblock/mlog lifecycle management and IO routines
introduced in an earlier patch.

The object read/write ioctl handlers utilizes vcache, which is a
small cache of iovec objects and page pointers. This cache is
used for large mblock/mlog IO. It acts as an emergency memory
pool for handling IO requests under memory pressure thereby
reducing tail latencies.

Co-developed-by: Greg Becker <gbecker@micron.com>
Signed-off-by: Greg Becker <gbecker@micron.com>
Co-developed-by: Pierre Labat <plabat@micron.com>
Signed-off-by: Pierre Labat <plabat@micron.com>
Co-developed-by: John Groves <jgroves@micron.com>
Signed-off-by: John Groves <jgroves@micron.com>
Signed-off-by: Nabeel M Mohamed <nmeeramohide@micron.com>
---
 drivers/mpool/mpctl.c | 670 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 667 insertions(+), 3 deletions(-)

diff --git a/drivers/mpool/mpctl.c b/drivers/mpool/mpctl.c
index de62f9a5524d..3a231cf982b3 100644
--- a/drivers/mpool/mpctl.c
+++ b/drivers/mpool/mpctl.c
@@ -33,6 +33,7 @@
 #include "assert.h"
 
 #include "mpool_ioctl.h"
+#include "mblock.h"
 #include "mlog.h"
 #include "mp.h"
 #include "mpctl.h"
@@ -1299,7 +1300,6 @@ static int mpioc_mp_activate(struct mpc_unit *ctl, struct mpioc_mpool *mp,
 	mp->mp_params.mp_oidv[0] = cfg.mc_oid1;
 	mp->mp_params.mp_oidv[1] = cfg.mc_oid2;
 	mp->mp_params.mp_ra_pages_max = cfg.mc_ra_pages_max;
-	mp->mp_params.mp_vma_size_max = cfg.mc_vma_size_max;
 	memcpy(&mp->mp_params.mp_utype, &cfg.mc_utype, sizeof(mp->mp_params.mp_utype));
 	strlcpy(mp->mp_params.mp_label, cfg.mc_label, sizeof(mp->mp_params.mp_label));
 
@@ -1656,6 +1656,596 @@ static int mpioc_mp_add(struct mpc_unit *unit, struct mpioc_drive *drv)
 	return rc;
 }
 
+
+/**
+ * struct vcache -  very-large-buffer cache...
+ */
+struct vcache {
+	spinlock_t  vc_lock;
+	void       *vc_head;
+	size_t      vc_size;
+} ____cacheline_aligned;
+
+static struct vcache mpc_physio_vcache;
+
+static void *mpc_vcache_alloc(struct vcache *vc, size_t sz)
+{
+	void *p;
+
+	if (!vc || sz > vc->vc_size)
+		return NULL;
+
+	spin_lock(&vc->vc_lock);
+	p = vc->vc_head;
+	if (p)
+		vc->vc_head = *(void **)p;
+	spin_unlock(&vc->vc_lock);
+
+	return p;
+}
+
+static void mpc_vcache_free(struct vcache *vc, void *p)
+{
+	if (!vc || !p)
+		return;
+
+	spin_lock(&vc->vc_lock);
+	*(void **)p = vc->vc_head;
+	vc->vc_head = p;
+	spin_unlock(&vc->vc_lock);
+}
+
+static int mpc_vcache_init(struct vcache *vc, size_t sz, size_t n)
+{
+	if (!vc || sz < PAGE_SIZE || n < 1)
+		return -EINVAL;
+
+	spin_lock_init(&vc->vc_lock);
+	vc->vc_head = NULL;
+	vc->vc_size = sz;
+
+	while (n-- > 0)
+		mpc_vcache_free(vc, vmalloc(sz));
+
+	return vc->vc_head ? 0 : -ENOMEM;
+}
+
+static void mpc_vcache_fini(struct vcache *vc)
+{
+	void *p;
+
+	while ((p = mpc_vcache_alloc(vc, PAGE_SIZE)))
+		vfree(p);
+}
+
+/**
+ * mpc_physio() - Generic raw device mblock read/write routine.
+ * @mpd:      mpool descriptor
+ * @desc:     mblock or mlog descriptor
+ * @uiov:     vector of iovecs that describe user-space segments
+ * @uioc:     count of elements in uiov[]
+ * @offset:   offset into the mblock at which to start reading
+ * @objtype:  mblock or mlog
+ * @rw:       READ or WRITE in regards to the media.
+ * @stkbuf:   caller provided scratch space
+ * @stkbufsz: size of stkbuf
+ *
+ * This function creates an array of iovec objects each of which
+ * map a portion of the user request into kernel space so that
+ * mpool can directly access the user data.  Note that this is
+ * a zero-copy operation.
+ *
+ * Requires that each user-space segment be page aligned and of an
+ * integral number of pages.
+ *
+ * See http://www.makelinux.net/ldd3/chp-15-sect-3 for more detail.
+ */
+static int mpc_physio(struct mpool_descriptor *mpd, void *desc, struct iovec *uiov,
+		      int uioc, off_t offset, enum mp_obj_type objtype, int rw,
+		      void *stkbuf, size_t stkbufsz)
+{
+	struct kvec *iov_base, *iov;
+	struct iov_iter iter;
+	struct page **pagesv;
+	size_t pagesvsz, pgbase, length;
+	int pagesc, niov, rc, i;
+	ssize_t cc;
+
+	iov = NULL;
+	niov = 0;
+	rc = 0;
+
+	length = iov_length(uiov, uioc);
+
+	if (length < PAGE_SIZE || !IS_ALIGNED(length, PAGE_SIZE))
+		return -EINVAL;
+
+	if (length > (rwsz_max_mb << 20))
+		return -EINVAL;
+
+	/*
+	 * Allocate an array of page pointers for iov_iter_get_pages()
+	 * and an array of iovecs for mblock_read() and mblock_write().
+	 *
+	 * Note: the only way we can calculate the number of required
+	 * iovecs in advance is to assume that we need one per page.
+	 */
+	pagesc = length / PAGE_SIZE;
+	pagesvsz = (sizeof(*pagesv) + sizeof(*iov)) * pagesc;
+
+	/*
+	 * pagesvsz may be big, and it will not be used as the iovec_list
+	 * for the block stack - pd will chunk it up to the underlying
+	 * devices (with another iovec list per pd).
+	 */
+	if (pagesvsz > stkbufsz) {
+		pagesv = NULL;
+
+		if (pagesvsz <= PAGE_SIZE * 2)
+			pagesv = kmalloc(pagesvsz, GFP_NOIO);
+
+		while (!pagesv) {
+			pagesv = mpc_vcache_alloc(&mpc_physio_vcache, pagesvsz);
+			if (!pagesv)
+				usleep_range(750, 1250);
+		}
+	} else {
+		pagesv = stkbuf;
+	}
+
+	if (!pagesv)
+		return -ENOMEM;
+
+	iov_base = (struct kvec *)((char *)pagesv + (sizeof(*pagesv) * pagesc));
+
+	iov_iter_init(&iter, rw, uiov, uioc, length);
+
+	for (i = 0, cc = 0; i < pagesc; i += (cc / PAGE_SIZE)) {
+
+		/* Get struct page vector for the user buffers. */
+		cc = iov_iter_get_pages(&iter, &pagesv[i], length - (i * PAGE_SIZE),
+					pagesc - i, &pgbase);
+		if (cc < 0) {
+			rc = cc;
+			pagesc = i;
+			goto errout;
+		}
+
+		/*
+		 * pgbase is the offset into the 1st iovec - our alignment
+		 * requirements force it to be 0
+		 */
+		if (cc < PAGE_SIZE || pgbase != 0) {
+			rc = -EINVAL;
+			pagesc = i + 1;
+			goto errout;
+		}
+
+		iov_iter_advance(&iter, cc);
+	}
+
+	/* Build an array of iovecs for mpool so that it can directly access the user data. */
+	for (i = 0, iov = iov_base; i < pagesc; ++i, ++iov, ++niov) {
+		iov->iov_len = PAGE_SIZE;
+		iov->iov_base = kmap(pagesv[i]);
+
+		if (!iov->iov_base) {
+			rc = -EINVAL;
+			pagesc = i + 1;
+			goto errout;
+		}
+	}
+
+	switch (objtype) {
+	case MP_OBJ_MBLOCK:
+		if (rw == WRITE)
+			rc = mblock_write(mpd, desc, iov_base, niov, pagesc << PAGE_SHIFT);
+		else
+			rc = mblock_read(mpd, desc, iov_base, niov, offset, pagesc << PAGE_SHIFT);
+		break;
+
+	case MP_OBJ_MLOG:
+		rc = mlog_rw_raw(mpd, desc, iov_base, niov, offset, rw);
+		break;
+
+	default:
+		rc = -EINVAL;
+		goto errout;
+	}
+
+errout:
+	for (i = 0, iov = iov_base; i < pagesc; ++i, ++iov) {
+		if (i < niov)
+			kunmap(pagesv[i]);
+		put_page(pagesv[i]);
+	}
+
+	if (pagesvsz > stkbufsz) {
+		if (pagesvsz > PAGE_SIZE * 2)
+			mpc_vcache_free(&mpc_physio_vcache, pagesv);
+		else
+			kfree(pagesv);
+	}
+
+	return rc;
+}
+
+/**
+ * mpioc_mb_alloc() - Allocate an mblock object.
+ * @unit:   mpool unit ptr
+ * @mb:     mblock parameter block
+ *
+ * MPIOC_MB_ALLOC ioctl handler to allocate a single mblock.
+ *
+ * Return:  Returns 0 if successful, -errno otherwise...
+ */
+static int mpioc_mb_alloc(struct mpc_unit *unit, struct mpioc_mblock *mb)
+{
+	struct mblock_descriptor *mblock;
+	struct mpool_descriptor *mpool;
+	struct mblock_props props;
+	int rc;
+
+	if (!unit || !mb || !unit->un_mpool)
+		return -EINVAL;
+
+	mpool = unit->un_mpool->mp_desc;
+
+	rc = mblock_alloc(mpool, mb->mb_mclassp, mb->mb_spare, &mblock, &props);
+	if (rc)
+		return rc;
+
+	mblock_get_props_ex(mpool, mblock, &mb->mb_props);
+	mblock_put(mblock);
+
+	mb->mb_objid  = props.mpr_objid;
+	mb->mb_offset = -1;
+
+	return 0;
+}
+
+/**
+ * mpioc_mb_find() - Find an mblock object by its objid
+ * @unit:   mpool unit ptr
+ * @mb:     mblock parameter block
+ *
+ * Return:  Returns 0 if successful, -errno otherwise...
+ */
+static int mpioc_mb_find(struct mpc_unit *unit, struct mpioc_mblock *mb)
+{
+	struct mblock_descriptor *mblock;
+	struct mpool_descriptor *mpool;
+	int rc;
+
+	if (!unit || !mb || !unit->un_mpool)
+		return -EINVAL;
+
+	if (!mblock_objid(mb->mb_objid))
+		return -EINVAL;
+
+	mpool = unit->un_mpool->mp_desc;
+
+	rc = mblock_find_get(mpool, mb->mb_objid, 0, NULL, &mblock);
+	if (rc)
+		return rc;
+
+	(void)mblock_get_props_ex(mpool, mblock, &mb->mb_props);
+
+	mblock_put(mblock);
+
+	mb->mb_offset = -1;
+
+	return 0;
+}
+
+/**
+ * mpioc_mb_abcomdel() - Abort, commit, or delete an mblock.
+ * @unit:   mpool unit ptr
+ * @cmd     MPIOC_MB_ABORT, MPIOC_MB_COMMIT, or MPIOC_MB_DELETE
+ * @mi:     mblock parameter block
+ *
+ * MPIOC_MB_ACD ioctl handler to either abort, commit, or delete
+ * the specified mblock.
+ *
+ * Return:  Returns 0 if successful, -errno otherwise...
+ */
+static int mpioc_mb_abcomdel(struct mpc_unit *unit, uint cmd, struct mpioc_mblock_id *mi)
+{
+	struct mblock_descriptor *mblock;
+	struct mpool_descriptor *mpool;
+	int which, rc;
+	bool drop;
+
+	if (!unit || !mi || !unit->un_mpool)
+		return -EINVAL;
+
+	if (!mblock_objid(mi->mi_objid))
+		return -EINVAL;
+
+	which = (cmd == MPIOC_MB_DELETE) ? 1 : -1;
+	mpool = unit->un_mpool->mp_desc;
+	drop = true;
+
+	rc = mblock_find_get(mpool, mi->mi_objid, which, NULL, &mblock);
+	if (rc)
+		return rc;
+
+	switch (cmd) {
+	case MPIOC_MB_COMMIT:
+		rc = mblock_commit(mpool, mblock);
+		break;
+
+	case MPIOC_MB_ABORT:
+		rc = mblock_abort(mpool, mblock);
+		drop = !!rc;
+		break;
+
+	case MPIOC_MB_DELETE:
+		rc = mblock_delete(mpool, mblock);
+		drop = !!rc;
+		break;
+
+	default:
+		rc = -ENOTTY;
+		break;
+	}
+
+	if (drop)
+		mblock_put(mblock);
+
+	return rc;
+}
+
+/**
+ * mpioc_mb_rw() - read/write mblock ioctl handler
+ * @unit:   mpool unit ptr
+ * @cmd:    MPIOC_MB_READ or MPIOC_MB_WRITE
+ * @mbiov:  mblock parameter block
+ */
+static int mpioc_mb_rw(struct mpc_unit *unit, uint cmd, struct mpioc_mblock_rw *mbrw,
+		       void *stkbuf, size_t stkbufsz)
+{
+	struct mblock_descriptor *mblock;
+	struct mpool_descriptor *mpool;
+	struct iovec *kiov;
+	bool xfree = false;
+	int which, rc;
+	size_t kiovsz;
+
+	if (!unit || !mbrw || !unit->un_mpool)
+		return -EINVAL;
+
+	if (!mblock_objid(mbrw->mb_objid))
+		return -EINVAL;
+
+	/*
+	 * For small iovec counts we simply copyin the array of iovecs
+	 * to local storage (stkbuf).  Otherwise, we must kmalloc a
+	 * buffer into which to perform the copyin.
+	 */
+	if (mbrw->mb_iov_cnt > MPIOC_KIOV_MAX)
+		return -EINVAL;
+
+	kiovsz = mbrw->mb_iov_cnt * sizeof(*kiov);
+
+	if (kiovsz > stkbufsz) {
+		kiov = kmalloc(kiovsz, GFP_KERNEL);
+		if (!kiov)
+			return -ENOMEM;
+
+		xfree = true;
+	} else {
+		kiov = stkbuf;
+		stkbuf += kiovsz;
+		stkbufsz -= kiovsz;
+	}
+
+	which = (cmd == MPIOC_MB_READ) ? 1 : -1;
+	mpool = unit->un_mpool->mp_desc;
+
+	rc = mblock_find_get(mpool, mbrw->mb_objid, which, NULL, &mblock);
+	if (rc)
+		goto errout;
+
+	if (copy_from_user(kiov, mbrw->mb_iov, kiovsz)) {
+		rc = -EFAULT;
+	} else {
+		rc = mpc_physio(mpool, mblock, kiov, mbrw->mb_iov_cnt, mbrw->mb_offset,
+				MP_OBJ_MBLOCK, (cmd == MPIOC_MB_READ) ? READ : WRITE,
+				stkbuf, stkbufsz);
+	}
+
+	mblock_put(mblock);
+
+errout:
+	if (xfree)
+		kfree(kiov);
+
+	return rc;
+}
+
+/*
+ * Mpctl mlog ioctl handlers
+ */
+static int mpioc_mlog_alloc(struct mpc_unit *unit, struct mpioc_mlog *ml)
+{
+	struct mpool_descriptor *mpool;
+	struct mlog_descriptor *mlog;
+	struct mlog_props props;
+	int rc;
+
+	if (!unit || !unit->un_mpool || !ml)
+		return -EINVAL;
+
+	mpool = unit->un_mpool->mp_desc;
+
+	rc = mlog_alloc(mpool, &ml->ml_cap, ml->ml_mclassp, &props, &mlog);
+	if (rc)
+		return rc;
+
+	mlog_get_props_ex(mpool, mlog, &ml->ml_props);
+	mlog_put(mlog);
+
+	ml->ml_objid = props.lpr_objid;
+
+	return 0;
+}
+
+static int mpioc_mlog_find(struct mpc_unit *unit, struct mpioc_mlog *ml)
+{
+	struct mpool_descriptor    *mpool;
+	struct mlog_descriptor     *mlog;
+	int rc;
+
+	if (!unit || !unit->un_mpool || !ml || !mlog_objid(ml->ml_objid))
+		return -EINVAL;
+
+	mpool = unit->un_mpool->mp_desc;
+
+	rc = mlog_find_get(mpool, ml->ml_objid, 0, NULL, &mlog);
+	if (!rc) {
+		rc = mlog_get_props_ex(mpool, mlog, &ml->ml_props);
+		mlog_put(mlog);
+	}
+
+	return rc;
+}
+
+static int mpioc_mlog_abcomdel(struct mpc_unit *unit, uint cmd, struct mpioc_mlog_id *mi)
+{
+	struct mpool_descriptor *mpool;
+	struct mlog_descriptor *mlog;
+	struct mlog_props_ex props;
+	int which, rc;
+	bool drop;
+
+	if (!unit || !unit->un_mpool || !mi || !mlog_objid(mi->mi_objid))
+		return -EINVAL;
+
+	which = (cmd == MPIOC_MLOG_DELETE) ? 1 : -1;
+	mpool = unit->un_mpool->mp_desc;
+	drop = true;
+
+	rc = mlog_find_get(mpool, mi->mi_objid, which, NULL, &mlog);
+	if (rc)
+		return rc;
+
+	switch (cmd) {
+	case MPIOC_MLOG_COMMIT:
+		rc = mlog_commit(mpool, mlog);
+		if (!rc) {
+			mlog_get_props_ex(mpool, mlog, &props);
+			mi->mi_gen   = props.lpx_props.lpr_gen;
+			mi->mi_state = props.lpx_state;
+		}
+		break;
+
+	case MPIOC_MLOG_ABORT:
+		rc = mlog_abort(mpool, mlog);
+		drop = !!rc;
+		break;
+
+	case MPIOC_MLOG_DELETE:
+		rc = mlog_delete(mpool, mlog);
+		drop = !!rc;
+		break;
+
+	default:
+		rc = -ENOTTY;
+		break;
+	}
+
+	if (drop)
+		mlog_put(mlog);
+
+	return rc;
+}
+
+static int mpioc_mlog_rw(struct mpc_unit *unit, struct mpioc_mlog_io *mi,
+			 void *stkbuf, size_t stkbufsz)
+{
+	struct mpool_descriptor *mpool;
+	struct mlog_descriptor *mlog;
+	struct iovec *kiov;
+	bool xfree = false;
+	size_t kiovsz;
+	int rc;
+
+	if (!unit || !unit->un_mpool || !mi || !mlog_objid(mi->mi_objid))
+		return -EINVAL;
+
+	/*
+	 * For small iovec counts we simply copyin the array of iovecs
+	 * to the stack (kiov_buf). Otherwise, we must kmalloc a
+	 * buffer into which to perform the copyin.
+	 */
+	if (mi->mi_iovc > MPIOC_KIOV_MAX)
+		return -EINVAL;
+
+	kiovsz = mi->mi_iovc * sizeof(*kiov);
+
+	if (kiovsz > stkbufsz) {
+		kiov = kmalloc(kiovsz, GFP_KERNEL);
+		if (!kiov)
+			return -ENOMEM;
+
+		xfree = true;
+	} else {
+		kiov = stkbuf;
+		stkbuf += kiovsz;
+		stkbufsz -= kiovsz;
+	}
+
+	mpool = unit->un_mpool->mp_desc;
+
+	rc = mlog_find_get(mpool, mi->mi_objid, 1, NULL, &mlog);
+	if (rc)
+		goto errout;
+
+	if (copy_from_user(kiov, mi->mi_iov, kiovsz)) {
+		rc = -EFAULT;
+	} else {
+		rc = mpc_physio(mpool, mlog, kiov, mi->mi_iovc, mi->mi_off, MP_OBJ_MLOG,
+				(mi->mi_op == MPOOL_OP_READ) ? READ : WRITE, stkbuf, stkbufsz);
+	}
+
+	mlog_put(mlog);
+
+errout:
+	if (xfree)
+		kfree(kiov);
+
+	return rc;
+}
+
+static int mpioc_mlog_erase(struct mpc_unit *unit, struct mpioc_mlog_id *mi)
+{
+	struct mpool_descriptor *mpool;
+	struct mlog_descriptor *mlog;
+	struct mlog_props_ex props;
+	int rc;
+
+	if (!unit || !unit->un_mpool || !mi || !mlog_objid(mi->mi_objid))
+		return -EINVAL;
+
+	mpool = unit->un_mpool->mp_desc;
+
+	rc = mlog_find_get(mpool, mi->mi_objid, 0, NULL, &mlog);
+	if (rc)
+		return rc;
+
+	rc = mlog_erase(mpool, mlog, mi->mi_gen);
+	if (!rc) {
+		mlog_get_props_ex(mpool, mlog, &props);
+		mi->mi_gen   = props.lpx_props.lpr_gen;
+		mi->mi_state = props.lpx_state;
+	}
+
+	mlog_put(mlog);
+
+	return rc;
+}
+
 static struct mpc_softstate *mpc_cdev2ss(struct cdev *cdev)
 {
 	if (!cdev || cdev->owner != THIS_MODULE) {
@@ -1798,8 +2388,8 @@ static long mpc_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
 {
 	char argbuf[256] __aligned(16);
 	struct mpc_unit *unit;
-	size_t argbufsz;
-	void *argp;
+	size_t argbufsz, stkbufsz;
+	void *argp, *stkbuf;
 	ulong iosz;
 	int rc;
 
@@ -1810,7 +2400,12 @@ static long mpc_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
 		switch (cmd) {
 		case MPIOC_PROP_GET:
 		case MPIOC_DEVPROPS_GET:
+		case MPIOC_MB_FIND:
+		case MPIOC_MB_READ:
 		case MPIOC_MP_MCLASS_GET:
+		case MPIOC_MLOG_FIND:
+		case MPIOC_MLOG_READ:
+		case MPIOC_MLOG_PROPS:
 			break;
 
 		default:
@@ -1882,6 +2477,59 @@ static long mpc_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
 		rc = mpioc_devprops_get(unit, argp);
 		break;
 
+	case MPIOC_MB_ALLOC:
+		rc = mpioc_mb_alloc(unit, argp);
+		break;
+
+	case MPIOC_MB_FIND:
+		rc = mpioc_mb_find(unit, argp);
+		break;
+
+	case MPIOC_MB_COMMIT:
+	case MPIOC_MB_DELETE:
+	case MPIOC_MB_ABORT:
+		rc = mpioc_mb_abcomdel(unit, cmd, argp);
+		break;
+
+	case MPIOC_MB_READ:
+	case MPIOC_MB_WRITE:
+		ASSERT(roundup(iosz, 16) < argbufsz);
+
+		stkbufsz = argbufsz - roundup(iosz, 16);
+		stkbuf = argbuf + roundup(iosz, 16);
+
+		rc = mpioc_mb_rw(unit, cmd, argp, stkbuf, stkbufsz);
+		break;
+
+	case MPIOC_MLOG_ALLOC:
+		rc = mpioc_mlog_alloc(unit, argp);
+		break;
+
+	case MPIOC_MLOG_FIND:
+	case MPIOC_MLOG_PROPS:
+		rc = mpioc_mlog_find(unit, argp);
+		break;
+
+	case MPIOC_MLOG_ABORT:
+	case MPIOC_MLOG_COMMIT:
+	case MPIOC_MLOG_DELETE:
+		rc = mpioc_mlog_abcomdel(unit, cmd, argp);
+		break;
+
+	case MPIOC_MLOG_READ:
+	case MPIOC_MLOG_WRITE:
+		ASSERT(roundup(iosz, 16) < argbufsz);
+
+		stkbufsz = argbufsz - roundup(iosz, 16);
+		stkbuf = argbuf + roundup(iosz, 16);
+
+		rc = mpioc_mlog_rw(unit, argp, stkbuf, stkbufsz);
+		break;
+
+	case MPIOC_MLOG_ERASE:
+		rc = mpioc_mlog_erase(unit, argp);
+		break;
+
 	default:
 		rc = -ENOTTY;
 		mp_pr_rl("invalid command %x: dir=%u type=%c nr=%u size=%u",
@@ -1936,6 +2584,8 @@ void mpctl_exit(void)
 
 		ss->ss_inited = false;
 	}
+
+	mpc_vcache_fini(&mpc_physio_vcache);
 }
 
 /**
@@ -1947,6 +2597,7 @@ int mpctl_init(void)
 	struct mpool_config *cfg = NULL;
 	struct mpc_unit *ctlunit;
 	const char *errmsg = NULL;
+	size_t sz;
 	int rc;
 
 	if (ss->ss_inited)
@@ -1956,6 +2607,19 @@ int mpctl_init(void)
 
 	maxunits = clamp_t(uint, maxunits, 8, 8192);
 
+	rwsz_max_mb = clamp_t(ulong, rwsz_max_mb, 1, 128);
+	rwconc_max = clamp_t(ulong, rwconc_max, 1, 32);
+
+	/* Must be same as mpc_physio() pagesvsz calculation. */
+	sz = (rwsz_max_mb << 20) / PAGE_SIZE;
+	sz *= (sizeof(void *) + sizeof(struct iovec));
+
+	rc = mpc_vcache_init(&mpc_physio_vcache, sz, rwconc_max);
+	if (rc) {
+		errmsg = "vcache init failed";
+		goto errout;
+	}
+
 	cdev_init(&ss->ss_cdev, &mpc_fops_default);
 	ss->ss_cdev.owner = THIS_MODULE;
 
-- 
2.17.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

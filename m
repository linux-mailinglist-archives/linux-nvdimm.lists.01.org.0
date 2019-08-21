Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5CB981F5
	for <lists+linux-nvdimm@lfdr.de>; Wed, 21 Aug 2019 19:58:02 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0C3812194D3B8;
	Wed, 21 Aug 2019 10:58:54 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=vgoyal@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id AA81320212CA7
 for <linux-nvdimm@lists.01.org>; Wed, 21 Aug 2019 10:58:52 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B723F1105201;
 Wed, 21 Aug 2019 17:57:42 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.158])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F167C60127;
 Wed, 21 Aug 2019 17:57:32 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 7C3D6223CFD; Wed, 21 Aug 2019 13:57:32 -0400 (EDT)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvdimm@lists.01.org
Subject: [PATCH 01/19] dax: remove block device dependencies
Date: Wed, 21 Aug 2019 13:57:02 -0400
Message-Id: <20190821175720.25901-2-vgoyal@redhat.com>
In-Reply-To: <20190821175720.25901-1-vgoyal@redhat.com>
References: <20190821175720.25901-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Wed, 21 Aug 2019 17:57:42 +0000 (UTC)
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: miklos@szeredi.hu, dgilbert@redhat.com, virtio-fs@redhat.com,
 stefanha@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Although struct dax_device itself is not tied to a block device, some
DAX code assumes there is a block device.  Make block devices optional
by allowing bdev to be NULL in commonly used DAX APIs.

When there is no block device:
 * Skip the partition offset calculation in bdev_dax_pgoff()
 * Skip the blkdev_issue_zeroout() optimization

Note that more block device assumptions remain but I haven't reach those
code paths yet.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 drivers/dax/super.c | 3 ++-
 fs/dax.c            | 7 ++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 26a654dbc69a..3cbc97f3e653 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -46,7 +46,8 @@ EXPORT_SYMBOL_GPL(dax_read_unlock);
 int bdev_dax_pgoff(struct block_device *bdev, sector_t sector, size_t size,
 		pgoff_t *pgoff)
 {
-	phys_addr_t phys_off = (get_start_sect(bdev) + sector) * 512;
+	sector_t start_sect = bdev ? get_start_sect(bdev) : 0;
+	phys_addr_t phys_off = (start_sect + sector) * 512;
 
 	if (pgoff)
 		*pgoff = PHYS_PFN(phys_off);
diff --git a/fs/dax.c b/fs/dax.c
index 6bf81f931de3..a11147bbaf9e 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1046,7 +1046,12 @@ static vm_fault_t dax_load_hole(struct xa_state *xas,
 static bool dax_range_is_aligned(struct block_device *bdev,
 				 unsigned int offset, unsigned int length)
 {
-	unsigned short sector_size = bdev_logical_block_size(bdev);
+	unsigned short sector_size;
+
+	if (!bdev)
+		return false;
+
+	sector_size = bdev_logical_block_size(bdev);
 
 	if (!IS_ALIGNED(offset, sector_size))
 		return false;
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

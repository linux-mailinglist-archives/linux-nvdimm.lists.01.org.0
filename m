Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EE4356D7C
	for <lists+linux-nvdimm@lfdr.de>; Wed,  7 Apr 2021 15:38:59 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 99618100F2253;
	Wed,  7 Apr 2021 06:38:54 -0700 (PDT)
Received-SPF: Neutral (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 92775100F224E
	for <linux-nvdimm@lists.01.org>; Wed,  7 Apr 2021 06:38:51 -0700 (PDT)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AlI4bwazfs6gfkON58gYmKrPwzL1zdoIgy1kn?=
 =?us-ascii?q?xilNYDZSddGVkN3roeQD2XbP+VIscVwDufTFAqmPRnvA6YV4iLN9AZ6OVBTr0V?=
 =?us-ascii?q?HHEKhM4YfuyDXrGWnf24dmv5tIXLN5DLTLbGRSqebfzE2GH807wN+BmZrY4Nv2?=
 =?us-ascii?q?63t2VwllZ+VBwm5Ce2WmO3Z7TgVHGpY1faD0jqV6jgC9cncaZNnTPAhmY8H/ob?=
 =?us-ascii?q?Tw9K7OUFovAh4LzE20hyq01biSKXOl9yZbfzRR4bpKywT4rzA=3D?=
X-IronPort-AV: E=Sophos;i="5.82,203,1613404800";
   d="scan'208";a="106746651"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 07 Apr 2021 21:38:49 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
	by cn.fujitsu.com (Postfix) with ESMTP id 8FCE44D0B8A3;
	Wed,  7 Apr 2021 21:38:47 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 7 Apr 2021 21:38:41 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Wed, 7 Apr 2021 21:38:41 +0800
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<linux-nvdimm@lists.01.org>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v2 3/3] fsdax: Output address in dax_iomap_pfn() and rename it
Date: Wed, 7 Apr 2021 21:38:23 +0800
Message-ID: <20210407133823.828176-4-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210407133823.828176-1-ruansy.fnst@fujitsu.com>
References: <20210407133823.828176-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
X-yoursite-MailScanner-ID: 8FCE44D0B8A3.A396E
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Message-ID-Hash: RGDK6WVXFNHRWGM4E7WPVEUI6IWBQG5T
X-Message-ID-Hash: RGDK6WVXFNHRWGM4E7WPVEUI6IWBQG5T
X-MailFrom: ruansy.fnst@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RGDK6WVXFNHRWGM4E7WPVEUI6IWBQG5T/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add address output in dax_iomap_pfn() in order to perform a memcpy() in
CoW case.  Since this function both output address and pfn, rename it to
dax_iomap_direct_access().

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/dax.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 6dea1fc11b46..8d7e4e2cc0fb 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -998,8 +998,8 @@ static sector_t dax_iomap_sector(struct iomap *iomap, loff_t pos)
 	return (iomap->addr + (pos & PAGE_MASK) - iomap->offset) >> 9;
 }
 
-static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
-			 pfn_t *pfnp)
+static int dax_iomap_direct_access(struct iomap *iomap, loff_t pos, size_t size,
+		void **kaddr, pfn_t *pfnp)
 {
 	const sector_t sector = dax_iomap_sector(iomap, pos);
 	pgoff_t pgoff;
@@ -1011,11 +1011,13 @@ static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
 		return rc;
 	id = dax_read_lock();
 	length = dax_direct_access(iomap->dax_dev, pgoff, PHYS_PFN(size),
-				   NULL, pfnp);
+				   kaddr, pfnp);
 	if (length < 0) {
 		rc = length;
 		goto out;
 	}
+	if (!pfnp)
+		goto out_check_addr;
 	rc = -EINVAL;
 	if (PFN_PHYS(length) < size)
 		goto out;
@@ -1025,6 +1027,12 @@ static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
 	if (length > 1 && !pfn_t_devmap(*pfnp))
 		goto out;
 	rc = 0;
+
+out_check_addr:
+	if (!kaddr)
+		goto out;
+	if (!*kaddr)
+		rc = -EFAULT;
 out:
 	dax_read_unlock(id);
 	return rc;
@@ -1389,7 +1397,7 @@ static vm_fault_t dax_fault_actor(struct vm_fault *vmf, pfn_t *pfnp,
 		return pmd ? VM_FAULT_FALLBACK : VM_FAULT_SIGBUS;
 	}
 
-	err = dax_iomap_pfn(iomap, pos, size, &pfn);
+	err = dax_iomap_direct_access(iomap, pos, size, NULL, &pfn);
 	if (err)
 		return pmd ? VM_FAULT_FALLBACK : dax_fault_return(err);
 
-- 
2.31.0


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

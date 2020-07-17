Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C044223565
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 Jul 2020 09:21:20 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B63FB11571BF6;
	Fri, 17 Jul 2020 00:21:13 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4252C11E9F62D
	for <linux-nvdimm@lists.01.org>; Fri, 17 Jul 2020 00:21:07 -0700 (PDT)
IronPort-SDR: Czks2kYUej3w6+8Y8cvVnnjln20w0zi7nlKa1Z8/g7CWBFN4y+vHb1qb1AKSl7fZ7wY1GdCpXn
 CL+TuWbVGArQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="137010664"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800";
   d="scan'208";a="137010664"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:21:06 -0700
IronPort-SDR: UzMMytv3b1Qxm4D4n9gaTEFqECDrP0ucHi6x9ptuP9XRozCIl0BMdyTn15dPEcX9F+OQRLFbiS
 15stgd4RI0rA==
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800";
   d="scan'208";a="430760950"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:21:06 -0700
From: ira.weiny@intel.com
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH RFC V2 10/17] fs/dax: Remove unused size parameter
Date: Fri, 17 Jul 2020 00:20:49 -0700
Message-Id: <20200717072056.73134-11-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20200717072056.73134-1-ira.weiny@intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
MIME-Version: 1.0
Message-ID-Hash: QNNGFQ3YIALDEKQF2IXQOAGGZKVB4K6G
X-Message-ID-Hash: QNNGFQ3YIALDEKQF2IXQOAGGZKVB4K6G
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Ben Widawsky <ben.widawsky@intel.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QNNGFQ3YIALDEKQF2IXQOAGGZKVB4K6G/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Ira Weiny <ira.weiny@intel.com>

Passing size to copy_user_dax implies it can copy variable sizes of data
when in fact it calls copy_user_page() which is exactly a page.

We are safe because the only caller uses PAGE_SIZE anyway so just remove
the variable for clarity.

While we are at it change copy_user_dax() to copy_cow_page_dax() to make
it clear it is a singleton helper for this one case not implementing
what dax_iomap_actor() does.

Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/dax.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 11b16729b86f..3e0babeb0365 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -680,21 +680,20 @@ int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 	return __dax_invalidate_entry(mapping, index, false);
 }
 
-static int copy_user_dax(struct block_device *bdev, struct dax_device *dax_dev,
-		sector_t sector, size_t size, struct page *to,
-		unsigned long vaddr)
+static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_dev,
+			     sector_t sector, struct page *to, unsigned long vaddr)
 {
 	void *vto, *kaddr;
 	pgoff_t pgoff;
 	long rc;
 	int id;
 
-	rc = bdev_dax_pgoff(bdev, sector, size, &pgoff);
+	rc = bdev_dax_pgoff(bdev, sector, PAGE_SIZE, &pgoff);
 	if (rc)
 		return rc;
 
 	id = dax_read_lock();
-	rc = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size), &kaddr, NULL);
+	rc = dax_direct_access(dax_dev, pgoff, PHYS_PFN(PAGE_SIZE), &kaddr, NULL);
 	if (rc < 0) {
 		dax_read_unlock(id);
 		return rc;
@@ -1305,8 +1304,8 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 			clear_user_highpage(vmf->cow_page, vaddr);
 			break;
 		case IOMAP_MAPPED:
-			error = copy_user_dax(iomap.bdev, iomap.dax_dev,
-					sector, PAGE_SIZE, vmf->cow_page, vaddr);
+			error = copy_cow_page_dax(iomap.bdev, iomap.dax_dev,
+						  sector, vmf->cow_page, vaddr);
 			break;
 		default:
 			WARN_ON_ONCE(1);
-- 
2.28.0.rc0.12.gb6a658bd00c9
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

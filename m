Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6951795D9
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Mar 2020 17:59:19 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 423FF10FC36D1;
	Wed,  4 Mar 2020 09:00:09 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0327E10FC36CE
	for <linux-nvdimm@lists.01.org>; Wed,  4 Mar 2020 09:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1583341154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c6J5XCx0kMPd1dVsDnBHHYs7u5PYfcv7KGfFAmsKVQE=;
	b=T5Wz4jgfA+OA+NuhHEDdtBzVGRQqr0r/xDdsP9pIAZzajmg12slfSeQRJ3+1VTDN5r4oZj
	/4weajiEBx8PFXaZYlRxp/4j9x8smCZJLET8u+jajsSovgH9QyLJKR8Onq157SmepmnJow
	cf1IWnEtbPaxwxhS1qQx3hhMIZn5flc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-1ZgCRd3bPSKznatq-Wu17g-1; Wed, 04 Mar 2020 11:59:12 -0500
X-MC-Unique: 1ZgCRd3bPSKznatq-Wu17g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73B5C8017CC;
	Wed,  4 Mar 2020 16:59:11 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 99AE960C84;
	Wed,  4 Mar 2020 16:59:03 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 3C45D2257D4; Wed,  4 Mar 2020 11:59:03 -0500 (EST)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	virtio-fs@redhat.com,
	miklos@szeredi.hu
Subject: [PATCH 02/20] dax: Create a range version of dax_layout_busy_page()
Date: Wed,  4 Mar 2020 11:58:27 -0500
Message-Id: <20200304165845.3081-3-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-1-vgoyal@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Message-ID-Hash: JWCUL6KD6QDAJO2W4MC3QPGOE46WKOZ5
X-Message-ID-Hash: JWCUL6KD6QDAJO2W4MC3QPGOE46WKOZ5
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: stefanha@redhat.com, dgilbert@redhat.com, mst@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JWCUL6KD6QDAJO2W4MC3QPGOE46WKOZ5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

virtiofs device has a range of memory which is mapped into file inodes
using dax. This memory is mapped in qemu on host and maps different
sections of real file on host. Size of this memory is limited
(determined by administrator) and depending on filesystem size, we will
soon reach a situation where all the memory is in use and we need to
reclaim some.

As part of reclaim process, we will need to make sure that there are
no active references to pages (taken by get_user_pages()) on the memory
range we are trying to reclaim. I am planning to use
dax_layout_busy_page() for this. But in current form this is per inode
and scans through all the pages of the inode.

We want to reclaim only a portion of memory (say 2MB page). So we want
to make sure that only that 2MB range of pages do not have any
references  (and don't want to unmap all the pages of inode).

Hence, create a range version of this function named
dax_layout_busy_page_range() which can be used to pass a range which
needs to be unmapped.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/dax.c            | 66 ++++++++++++++++++++++++++++++++-------------
 include/linux/dax.h |  6 +++++
 2 files changed, 54 insertions(+), 18 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 35da144375a0..fde92bb5da69 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -558,27 +558,20 @@ static void *grab_mapping_entry(struct xa_state *xas,
 	return xa_mk_internal(VM_FAULT_FALLBACK);
 }
 
-/**
- * dax_layout_busy_page - find first pinned page in @mapping
- * @mapping: address space to scan for a page with ref count > 1
- *
- * DAX requires ZONE_DEVICE mapped pages. These pages are never
- * 'onlined' to the page allocator so they are considered idle when
- * page->count == 1. A filesystem uses this interface to determine if
- * any page in the mapping is busy, i.e. for DMA, or other
- * get_user_pages() usages.
- *
- * It is expected that the filesystem is holding locks to block the
- * establishment of new mappings in this address_space. I.e. it expects
- * to be able to run unmap_mapping_range() and subsequently not race
- * mapping_mapped() becoming true.
+/*
+ * Partial pages are included. If end is 0, pages in the range from start
+ * to end of the file are inluded.
  */
-struct page *dax_layout_busy_page(struct address_space *mapping)
+struct page *dax_layout_busy_page_range(struct address_space *mapping,
+					loff_t start, loff_t end)
 {
-	XA_STATE(xas, &mapping->i_pages, 0);
 	void *entry;
 	unsigned int scanned = 0;
 	struct page *page = NULL;
+	pgoff_t start_idx = start >> PAGE_SHIFT;
+	pgoff_t end_idx = end >> PAGE_SHIFT;
+	XA_STATE(xas, &mapping->i_pages, start_idx);
+	loff_t len, lstart = round_down(start, PAGE_SIZE);
 
 	/*
 	 * In the 'limited' case get_user_pages() for dax is disabled.
@@ -589,6 +582,22 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
 	if (!dax_mapping(mapping) || !mapping_mapped(mapping))
 		return NULL;
 
+	/* If end == 0, all pages from start to till end of file */
+	if (!end) {
+		end_idx = ULONG_MAX;
+		len = 0;
+	} else {
+		/* length is being calculated from lstart and not start.
+		 * This is due to behavior of unmap_mapping_range(). If
+		 * start is say 4094 and end is on 4096 then we want to
+		 * unamp two pages, idx 0 and 1. But unmap_mapping_range()
+		 * will unmap only page at idx 0. If we calculate len
+		 * from the rounded down start, this problem should not
+		 * happen.
+		 */
+		len = end - lstart + 1;
+	}
+
 	/*
 	 * If we race get_user_pages_fast() here either we'll see the
 	 * elevated page count in the iteration and wait, or
@@ -601,10 +610,10 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
 	 * guaranteed to either see new references or prevent new
 	 * references from being established.
 	 */
-	unmap_mapping_range(mapping, 0, 0, 0);
+	unmap_mapping_range(mapping, start, len, 0);
 
 	xas_lock_irq(&xas);
-	xas_for_each(&xas, entry, ULONG_MAX) {
+	xas_for_each(&xas, entry, end_idx) {
 		if (WARN_ON_ONCE(!xa_is_value(entry)))
 			continue;
 		if (unlikely(dax_is_locked(entry)))
@@ -625,6 +634,27 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
 	xas_unlock_irq(&xas);
 	return page;
 }
+EXPORT_SYMBOL_GPL(dax_layout_busy_page_range);
+
+/**
+ * dax_layout_busy_page - find first pinned page in @mapping
+ * @mapping: address space to scan for a page with ref count > 1
+ *
+ * DAX requires ZONE_DEVICE mapped pages. These pages are never
+ * 'onlined' to the page allocator so they are considered idle when
+ * page->count == 1. A filesystem uses this interface to determine if
+ * any page in the mapping is busy, i.e. for DMA, or other
+ * get_user_pages() usages.
+ *
+ * It is expected that the filesystem is holding locks to block the
+ * establishment of new mappings in this address_space. I.e. it expects
+ * to be able to run unmap_mapping_range() and subsequently not race
+ * mapping_mapped() becoming true.
+ */
+struct page *dax_layout_busy_page(struct address_space *mapping)
+{
+	return dax_layout_busy_page_range(mapping, 0, 0);
+}
 EXPORT_SYMBOL_GPL(dax_layout_busy_page);
 
 static int __dax_invalidate_entry(struct address_space *mapping,
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 328c2dbb4409..4fd4f866a4d3 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -139,6 +139,7 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 		struct dax_device *dax_dev, struct writeback_control *wbc);
 
 struct page *dax_layout_busy_page(struct address_space *mapping);
+struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
 dax_entry_t dax_lock_page(struct page *page);
 void dax_unlock_page(struct page *page, dax_entry_t cookie);
 #else
@@ -169,6 +170,11 @@ static inline struct page *dax_layout_busy_page(struct address_space *mapping)
 	return NULL;
 }
 
+static inline struct page *dax_layout_busy_page_range(struct address_space *mapping, pgoff_t start, pgoff_t nr_pages)
+{
+	return NULL;
+}
+
 static inline int dax_writeback_mapping_range(struct address_space *mapping,
 		struct dax_device *dax_dev, struct writeback_control *wbc)
 {
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

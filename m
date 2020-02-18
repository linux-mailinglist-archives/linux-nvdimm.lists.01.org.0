Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C53163569
	for <lists+linux-nvdimm@lfdr.de>; Tue, 18 Feb 2020 22:49:20 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CF6D510FC358F;
	Tue, 18 Feb 2020 13:49:55 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BB0DB10FC33F2
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 13:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1582062540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPuW8FJYXb4EyYv2Zcbckz83nVUeVWfBw8sxF/N5fjs=;
	b=UF0+2FgblivKYIXxXMGw/QFgAqnySdhKDxd61Rc4zR4w6STslQKSjlPHbCHMWTETUbIleE
	GEbG8HosTrReeqEe3CaPV2972fzgZioHJGC8p8WL+QcS7qyzabUrJHE2No77ftAa1sJsb8
	uf4UkA5lez5AsYVRMrNvQekPX92gq6o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-t2mG82F3PxyQsJxHcH8wnQ-1; Tue, 18 Feb 2020 16:48:57 -0500
X-MC-Unique: t2mG82F3PxyQsJxHcH8wnQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF155802567;
	Tue, 18 Feb 2020 21:48:55 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 10EBE5C1B0;
	Tue, 18 Feb 2020 21:48:53 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 8E9362257D3; Tue, 18 Feb 2020 16:48:52 -0500 (EST)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	hch@infradead.org,
	dan.j.williams@intel.com
Subject: [PATCH v5 1/8] pmem: Add functions for reading/writing page to/from pmem
Date: Tue, 18 Feb 2020 16:48:34 -0500
Message-Id: <20200218214841.10076-2-vgoyal@redhat.com>
In-Reply-To: <20200218214841.10076-1-vgoyal@redhat.com>
References: <20200218214841.10076-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Message-ID-Hash: MAE6LDRYRYRPSLPWZNS6ZEML4LHAYBBX
X-Message-ID-Hash: MAE6LDRYRYRPSLPWZNS6ZEML4LHAYBBX
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: dm-devel@redhat.com, Christoph Hellwig <hch@lst.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MAE6LDRYRYRPSLPWZNS6ZEML4LHAYBBX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This splits pmem_do_bvec() into pmem_do_read() and pmem_do_write().
pmem_do_write() will be used by pmem zero_page_range() as well. Hence
sharing the same code.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 drivers/nvdimm/pmem.c | 86 +++++++++++++++++++++++++------------------
 1 file changed, 50 insertions(+), 36 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 4eae441f86c9..075b11682192 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -136,9 +136,25 @@ static blk_status_t read_pmem(struct page *page, unsigned int off,
 	return BLK_STS_OK;
 }
 
-static blk_status_t pmem_do_bvec(struct pmem_device *pmem, struct page *page,
-			unsigned int len, unsigned int off, unsigned int op,
-			sector_t sector)
+static blk_status_t pmem_do_read(struct pmem_device *pmem,
+			struct page *page, unsigned int page_off,
+			sector_t sector, unsigned int len)
+{
+	blk_status_t rc;
+	phys_addr_t pmem_off = sector * 512 + pmem->data_offset;
+	void *pmem_addr = pmem->virt_addr + pmem_off;
+
+	if (unlikely(is_bad_pmem(&pmem->bb, sector, len)))
+		return BLK_STS_IOERR;
+
+	rc = read_pmem(page, page_off, pmem_addr, len);
+	flush_dcache_page(page);
+	return rc;
+}
+
+static blk_status_t pmem_do_write(struct pmem_device *pmem,
+			struct page *page, unsigned int page_off,
+			sector_t sector, unsigned int len)
 {
 	blk_status_t rc = BLK_STS_OK;
 	bool bad_pmem = false;
@@ -148,34 +164,25 @@ static blk_status_t pmem_do_bvec(struct pmem_device *pmem, struct page *page,
 	if (unlikely(is_bad_pmem(&pmem->bb, sector, len)))
 		bad_pmem = true;
 
-	if (!op_is_write(op)) {
-		if (unlikely(bad_pmem))
-			rc = BLK_STS_IOERR;
-		else {
-			rc = read_pmem(page, off, pmem_addr, len);
-			flush_dcache_page(page);
-		}
-	} else {
-		/*
-		 * Note that we write the data both before and after
-		 * clearing poison.  The write before clear poison
-		 * handles situations where the latest written data is
-		 * preserved and the clear poison operation simply marks
-		 * the address range as valid without changing the data.
-		 * In this case application software can assume that an
-		 * interrupted write will either return the new good
-		 * data or an error.
-		 *
-		 * However, if pmem_clear_poison() leaves the data in an
-		 * indeterminate state we need to perform the write
-		 * after clear poison.
-		 */
-		flush_dcache_page(page);
-		write_pmem(pmem_addr, page, off, len);
-		if (unlikely(bad_pmem)) {
-			rc = pmem_clear_poison(pmem, pmem_off, len);
-			write_pmem(pmem_addr, page, off, len);
-		}
+	/*
+	 * Note that we write the data both before and after
+	 * clearing poison.  The write before clear poison
+	 * handles situations where the latest written data is
+	 * preserved and the clear poison operation simply marks
+	 * the address range as valid without changing the data.
+	 * In this case application software can assume that an
+	 * interrupted write will either return the new good
+	 * data or an error.
+	 *
+	 * However, if pmem_clear_poison() leaves the data in an
+	 * indeterminate state we need to perform the write
+	 * after clear poison.
+	 */
+	flush_dcache_page(page);
+	write_pmem(pmem_addr, page, page_off, len);
+	if (unlikely(bad_pmem)) {
+		rc = pmem_clear_poison(pmem, pmem_off, len);
+		write_pmem(pmem_addr, page, page_off, len);
 	}
 
 	return rc;
@@ -197,8 +204,12 @@ static blk_qc_t pmem_make_request(struct request_queue *q, struct bio *bio)
 
 	do_acct = nd_iostat_start(bio, &start);
 	bio_for_each_segment(bvec, bio, iter) {
-		rc = pmem_do_bvec(pmem, bvec.bv_page, bvec.bv_len,
-				bvec.bv_offset, bio_op(bio), iter.bi_sector);
+		if (op_is_write(bio_op(bio)))
+			rc = pmem_do_write(pmem, bvec.bv_page, bvec.bv_offset,
+				iter.bi_sector, bvec.bv_len);
+		else
+			rc = pmem_do_read(pmem, bvec.bv_page, bvec.bv_offset,
+				iter.bi_sector, bvec.bv_len);
 		if (rc) {
 			bio->bi_status = rc;
 			break;
@@ -223,9 +234,12 @@ static int pmem_rw_page(struct block_device *bdev, sector_t sector,
 	struct pmem_device *pmem = bdev->bd_queue->queuedata;
 	blk_status_t rc;
 
-	rc = pmem_do_bvec(pmem, page, hpage_nr_pages(page) * PAGE_SIZE,
-			  0, op, sector);
-
+	if (op_is_write(op))
+		rc = pmem_do_write(pmem, page, 0, sector,
+				   hpage_nr_pages(page) * PAGE_SIZE);
+	else
+		rc = pmem_do_read(pmem, page, 0, sector,
+				   hpage_nr_pages(page) * PAGE_SIZE);
 	/*
 	 * The ->rw_page interface is subtle and tricky.  The core
 	 * retries on any error, so we can only invoke page_endio() in
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

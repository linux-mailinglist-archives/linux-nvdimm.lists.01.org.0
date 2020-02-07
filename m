Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE6C155F8D
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 Feb 2020 21:27:15 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 93D2C10FC3594;
	Fri,  7 Feb 2020 12:30:30 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.120; helo=us-smtp-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [205.139.110.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D7C5A10FC3592
	for <linux-nvdimm@lists.01.org>; Fri,  7 Feb 2020 12:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1581107229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BaMoU3pUt65BkfrWudQyORZLvQWCs8nEN8buujVWjC0=;
	b=K078tx3IH1tx5ufyCFsi3s64DsCy4oan8kBfs/5dTjRCKfNw8FbF5fFjjd8LXqdVohW7Gr
	d4Eg5KOiq6IjbvqpEcV5jHwTEt0npxL4f8lg+xc9GfWG7VX6oR+59/5PEL7xd3Eve/ohkL
	aOFxvn/9lbY6xcy3FaMW//+hqIWrpUU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-yOy0T3A6ODmJ02SyZCEOyA-1; Fri, 07 Feb 2020 15:27:07 -0500
X-MC-Unique: yOy0T3A6ODmJ02SyZCEOyA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E031F10054E3;
	Fri,  7 Feb 2020 20:27:05 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 097AD19C6A;
	Fri,  7 Feb 2020 20:27:03 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 9162C2257D4; Fri,  7 Feb 2020 15:27:02 -0500 (EST)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	hch@infradead.org,
	dan.j.williams@intel.com
Subject: [PATCH v3 2/7] pmem: Enable pmem_do_write() to deal with arbitrary ranges
Date: Fri,  7 Feb 2020 15:26:47 -0500
Message-Id: <20200207202652.1439-3-vgoyal@redhat.com>
In-Reply-To: <20200207202652.1439-1-vgoyal@redhat.com>
References: <20200207202652.1439-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Message-ID-Hash: GKKJYKGD5Q25CTXGFTWW5JYQY6YH6NZG
X-Message-ID-Hash: GKKJYKGD5Q25CTXGFTWW5JYQY6YH6NZG
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: dm-devel@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GKKJYKGD5Q25CTXGFTWW5JYQY6YH6NZG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Currently pmem_do_write() is written with assumption that all I/O is
sector aligned. Soon I want to use this function in zero_page_range()
where range passed in does not have to be sector aligned.

Modify this function to be able to deal with an arbitrary range. Which
is specified by pmem_off and len.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 drivers/nvdimm/pmem.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 9ad07cb8c9fc..281fe04d25fd 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -154,15 +154,23 @@ static blk_status_t pmem_do_read(struct pmem_device *pmem,
 
 static blk_status_t pmem_do_write(struct pmem_device *pmem,
 			struct page *page, unsigned int page_off,
-			sector_t sector, unsigned int len)
+			u64 pmem_off, unsigned int len)
 {
 	blk_status_t rc = BLK_STS_OK;
 	bool bad_pmem = false;
-	phys_addr_t pmem_off = sector * 512 + pmem->data_offset;
-	void *pmem_addr = pmem->virt_addr + pmem_off;
-
-	if (unlikely(is_bad_pmem(&pmem->bb, sector, len)))
-		bad_pmem = true;
+	phys_addr_t pmem_real_off = pmem_off + pmem->data_offset;
+	void *pmem_addr = pmem->virt_addr + pmem_real_off;
+	sector_t sector_start, sector_end;
+	unsigned nr_sectors;
+
+	sector_start = DIV_ROUND_UP(pmem_off, SECTOR_SIZE);
+	sector_end = (pmem_off + len) >> SECTOR_SHIFT;
+	if (sector_end > sector_start) {
+		nr_sectors = sector_end - sector_start;
+		if (unlikely(is_bad_pmem(&pmem->bb, sector_start,
+					 nr_sectors << SECTOR_SHIFT)))
+			bad_pmem = true;
+	}
 
 	/*
 	 * Note that we write the data both before and after
@@ -181,7 +189,13 @@ static blk_status_t pmem_do_write(struct pmem_device *pmem,
 	flush_dcache_page(page);
 	write_pmem(pmem_addr, page, page_off, len);
 	if (unlikely(bad_pmem)) {
-		rc = pmem_clear_poison(pmem, pmem_off, len);
+		/*
+		 * Pass sector aligned offset and length. That seems
+		 * to work as of now. Other finer grained alignment
+		 * cases can be addressed later if need be.
+		 */
+		rc = pmem_clear_poison(pmem, ALIGN(pmem_real_off, SECTOR_SIZE),
+				       nr_sectors << SECTOR_SHIFT);
 		write_pmem(pmem_addr, page, page_off, len);
 	}
 
@@ -195,7 +209,7 @@ static blk_status_t pmem_do_bvec(struct pmem_device *pmem, struct page *page,
 	if (!op_is_write(op))
 		return pmem_do_read(pmem, page, off, sector, len);
 
-	return pmem_do_write(pmem, page, off, sector, len);
+	return pmem_do_write(pmem, page, off, sector << SECTOR_SHIFT, len);
 }
 
 static blk_qc_t pmem_make_request(struct request_queue *q, struct bio *bio)
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

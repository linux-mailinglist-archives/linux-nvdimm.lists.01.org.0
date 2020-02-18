Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4194B163565
	for <lists+linux-nvdimm@lfdr.de>; Tue, 18 Feb 2020 22:49:17 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AE08810FC3581;
	Tue, 18 Feb 2020 13:49:55 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-delivery-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C0FFA10FC33F2
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 13:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1582062539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dWuQevadGbeWpwHhQNwK1IjmkMEDQ0KYV5P1Kw6/vBY=;
	b=Cs/TkbH+TCLFbRuU+u5wFkJqftUwZim9L/BTX/o7RzCVfXG4mLK1vxZkJSreQ2YojPwER2
	fROmIS+LYj/B6fnjzNrsJ13Lw+2fd9ODebJn7BheWUdUKEqu6JeHlTJ47AzeLx0dRgfgQg
	nGKjEG+QxL7ei5cJdkDWn1p0Ih6ic3Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-pkhcM5VjO76REe6mdKaKbg-1; Tue, 18 Feb 2020 16:48:57 -0500
X-MC-Unique: pkhcM5VjO76REe6mdKaKbg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBA6710CE783;
	Tue, 18 Feb 2020 21:48:55 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2846460BE1;
	Tue, 18 Feb 2020 21:48:53 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id A7FE52257D6; Tue, 18 Feb 2020 16:48:52 -0500 (EST)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	hch@infradead.org,
	dan.j.williams@intel.com
Subject: [PATCH v5 4/8] dax, pmem: Add a dax operation zero_page_range
Date: Tue, 18 Feb 2020 16:48:37 -0500
Message-Id: <20200218214841.10076-5-vgoyal@redhat.com>
In-Reply-To: <20200218214841.10076-1-vgoyal@redhat.com>
References: <20200218214841.10076-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Message-ID-Hash: 6ERZJZOD4YJYN2TNKNOQNE6ZOXJETEKG
X-Message-ID-Hash: 6ERZJZOD4YJYN2TNKNOQNE6ZOXJETEKG
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: dm-devel@redhat.com, Christoph Hellwig <hch@lst.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6ERZJZOD4YJYN2TNKNOQNE6ZOXJETEKG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a dax operation zero_page_range, to zero a range of memory. This will
also clear any poison in the range being zeroed.

As of now, zeroing of up to one page is allowed in a single call. There
are no callers which are trying to zero more than a page in a single call.
Once we grow the callers which zero more than a page in single call, we
can add that support. Primary reason for not doing that yet is that this
will add little complexity in dm implementation where a range might be
spanning multiple underlying targets and one will have to split the range
into multiple sub ranges and call zero_page_range() on individual targets.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 drivers/dax/super.c   | 19 +++++++++++++++++++
 drivers/nvdimm/pmem.c | 10 ++++++++++
 include/linux/dax.h   |  3 +++
 3 files changed, 32 insertions(+)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 0aa4b6bc5101..c912808bc886 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -344,6 +344,25 @@ size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
 }
 EXPORT_SYMBOL_GPL(dax_copy_to_iter);
 
+int dax_zero_page_range(struct dax_device *dax_dev, u64 offset, size_t len)
+{
+	if (!dax_alive(dax_dev))
+		return -ENXIO;
+
+	if (!dax_dev->ops->zero_page_range)
+		return -EOPNOTSUPP;
+	/*
+	 * There are no callers that want to zero across a page boundary as of
+	 * now. Once users are there, this check can be removed after the
+	 * device mapper code has been updated to split ranges across targets.
+	 */
+	if (offset_in_page(offset) + len > PAGE_SIZE)
+		return -EIO;
+
+	return dax_dev->ops->zero_page_range(dax_dev, offset, len);
+}
+EXPORT_SYMBOL_GPL(dax_zero_page_range);
+
 #ifdef CONFIG_ARCH_HAS_PMEM_API
 void arch_wb_cache_pmem(void *addr, size_t size);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size)
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 3c46e9e6d04c..e17f9f56d6fe 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -304,6 +304,15 @@ static const struct block_device_operations pmem_fops = {
 	.revalidate_disk =	nvdimm_revalidate_disk,
 };
 
+static int pmem_dax_zero_page_range(struct dax_device *dax_dev, u64 offset,
+				    size_t len)
+{
+	struct pmem_device *pmem = dax_get_private(dax_dev);
+
+	return blk_status_to_errno(pmem_do_write(pmem, ZERO_PAGE(0), 0, offset,
+				   len));
+}
+
 static long pmem_dax_direct_access(struct dax_device *dax_dev,
 		pgoff_t pgoff, long nr_pages, void **kaddr, pfn_t *pfn)
 {
@@ -335,6 +344,7 @@ static const struct dax_operations pmem_dax_ops = {
 	.dax_supported = generic_fsdax_supported,
 	.copy_from_iter = pmem_copy_from_iter,
 	.copy_to_iter = pmem_copy_to_iter,
+	.zero_page_range = pmem_dax_zero_page_range,
 };
 
 static const struct attribute_group *pmem_attribute_groups[] = {
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 328c2dbb4409..93a663c26d6a 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -34,6 +34,8 @@ struct dax_operations {
 	/* copy_to_iter: required operation for fs-dax direct-i/o */
 	size_t (*copy_to_iter)(struct dax_device *, pgoff_t, void *, size_t,
 			struct iov_iter *);
+	/* zero_page_range: required operation. Zero range with-in a page  */
+	int (*zero_page_range)(struct dax_device *, u64, size_t);
 };
 
 extern struct attribute_group dax_attribute_group;
@@ -199,6 +201,7 @@ size_t dax_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
 		size_t bytes, struct iov_iter *i);
 size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
 		size_t bytes, struct iov_iter *i);
+int dax_zero_page_range(struct dax_device *dax_dev, u64 offset, size_t len);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size);
 
 ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

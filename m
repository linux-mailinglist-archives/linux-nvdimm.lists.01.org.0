Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D81A163563
	for <lists+linux-nvdimm@lfdr.de>; Tue, 18 Feb 2020 22:49:12 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7753E10FC340B;
	Tue, 18 Feb 2020 13:49:54 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-delivery-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4800410FC33F2
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 13:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1582062539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tyVUZZb1YzuBSN0HxippMw48mL8qf75NwDgXuTB/Cgc=;
	b=BoMX2887LUcxREyoT7N86JT23RzidZoGhwieSgxmEtjSA5xpdWRmu90qHBg3nseKA+jaD7
	G+wTKKy6nTuGXlsEZE4gwTFeiEEyOOSjDfNg0zeQm0D2EoR4NcpzTI4VWHYk/5rxUg6EBN
	BfZLOQxQefC9mB99/0n7jM/T8Fhv66A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-y2FBWsfmMyi3cnQC9K4Img-1; Tue, 18 Feb 2020 16:48:57 -0500
X-MC-Unique: y2FBWsfmMyi3cnQC9K4Img-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7CD9802566;
	Tue, 18 Feb 2020 21:48:55 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 007E75D9E5;
	Tue, 18 Feb 2020 21:48:52 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 9429C2257D4; Tue, 18 Feb 2020 16:48:52 -0500 (EST)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	hch@infradead.org,
	dan.j.williams@intel.com
Subject: [PATCH v5 2/8] drivers/pmem: Allow pmem_clear_poison() to accept arbitrary offset and len
Date: Tue, 18 Feb 2020 16:48:35 -0500
Message-Id: <20200218214841.10076-3-vgoyal@redhat.com>
In-Reply-To: <20200218214841.10076-1-vgoyal@redhat.com>
References: <20200218214841.10076-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Message-ID-Hash: W5AJTT7K3W2BCFS5KVJ4TPBOWGFDG4SC
X-Message-ID-Hash: W5AJTT7K3W2BCFS5KVJ4TPBOWGFDG4SC
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: dm-devel@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/W5AJTT7K3W2BCFS5KVJ4TPBOWGFDG4SC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Currently pmem_clear_poison() expects offset and len to be sector aligned.
Atleast that seems to be the assumption with which code has been written.
It is called only from pmem_do_bvec() which is called only from pmem_rw_page()
and pmem_make_request() which will only passe sector aligned offset and len.

Soon we want use this function from dax_zero_page_range() code path which
can try to zero arbitrary range of memory with-in a page. So update this
function to assume that offset and length can be arbitrary and do the
necessary alignments as needed.

nvdimm_clear_poison() seems to assume offset and len to be aligned to
clear_err_unit boundary. But this is currently internal detail and is
not exported for others to use. So for now, continue to align offset and
length to SECTOR_SIZE boundary. Improving it further and to align it
to clear_err_unit boundary is a TODO item for future.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 drivers/nvdimm/pmem.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 075b11682192..e72959203253 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -74,14 +74,28 @@ static blk_status_t pmem_clear_poison(struct pmem_device *pmem,
 	sector_t sector;
 	long cleared;
 	blk_status_t rc = BLK_STS_OK;
+	phys_addr_t start_aligned, end_aligned;
+	unsigned int len_aligned;
 
-	sector = (offset - pmem->data_offset) / 512;
+	/*
+	 * Callers can pass arbitrary offset and len. But nvdimm_clear_poison()
+	 * expects memory offset and length to meet certain alignment
+	 * restrction (clear_err_unit). Currently nvdimm does not export
+	 * required alignment. So align offset and length to sector boundary
+	 * before passing it to nvdimm_clear_poison().
+	 */
+	start_aligned = ALIGN(offset, SECTOR_SIZE);
+	end_aligned = ALIGN_DOWN((offset + len), SECTOR_SIZE) - 1;
+	len_aligned = end_aligned - start_aligned + 1;
+
+	sector = (start_aligned - pmem->data_offset) / 512;
 
-	cleared = nvdimm_clear_poison(dev, pmem->phys_addr + offset, len);
-	if (cleared < len)
+	cleared = nvdimm_clear_poison(dev, pmem->phys_addr + start_aligned,
+				      len_aligned);
+	if (cleared < len_aligned)
 		rc = BLK_STS_IOERR;
 	if (cleared > 0 && cleared / 512) {
-		hwpoison_clear(pmem, pmem->phys_addr + offset, cleared);
+		hwpoison_clear(pmem, pmem->phys_addr + start_aligned, cleared);
 		cleared /= 512;
 		dev_dbg(dev, "%#llx clear %ld sector%s\n",
 				(unsigned long long) sector, cleared,
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

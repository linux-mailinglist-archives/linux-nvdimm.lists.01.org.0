Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0447F155F92
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 Feb 2020 21:27:18 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BD07910FC359C;
	Fri,  7 Feb 2020 12:30:30 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2C9E110FC3594
	for <linux-nvdimm@lists.01.org>; Fri,  7 Feb 2020 12:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1581107229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+PIs0aogCK20rQ10EgLXcJqcuxsHbzkpWoBj+waYkxo=;
	b=YGS4+pmeeO5i8dl4DI8nA5wRC3VuCit74gjdbulY/b61uhux7vXsZhCYcGm59G2O87hFNW
	h17ZpdgiDzReEzL7P7VlPL111lxrn6Sh1+X1LlaVYWyoOoSkSubd474ihWpOSCz8VG38AW
	SwqCaMoYy6N89We4H6KLxSrnhHgPRHc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-G1LW6OLLO12cioVzd5mrEQ-1; Fri, 07 Feb 2020 15:27:07 -0500
X-MC-Unique: G1LW6OLLO12cioVzd5mrEQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C14B2800E21;
	Fri,  7 Feb 2020 20:27:05 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 14E2C1BC6D;
	Fri,  7 Feb 2020 20:27:03 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 9B0742257D6; Fri,  7 Feb 2020 15:27:02 -0500 (EST)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	hch@infradead.org,
	dan.j.williams@intel.com
Subject: [PATCH v3 4/7] s390,dcssblk,dax: Add dax zero_page_range operation to dcssblk driver
Date: Fri,  7 Feb 2020 15:26:49 -0500
Message-Id: <20200207202652.1439-5-vgoyal@redhat.com>
In-Reply-To: <20200207202652.1439-1-vgoyal@redhat.com>
References: <20200207202652.1439-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Message-ID-Hash: NBVDRECPYLKHGDOWJFTW5VZQHZX5DJ47
X-Message-ID-Hash: NBVDRECPYLKHGDOWJFTW5VZQHZX5DJ47
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: dm-devel@redhat.com, linux-s390@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NBVDRECPYLKHGDOWJFTW5VZQHZX5DJ47/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add dax operation zero_page_range for dcssblk driver.

CC: linux-s390@vger.kernel.org
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 drivers/s390/block/dcssblk.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 63502ca537eb..331abab5d066 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -57,11 +57,28 @@ static size_t dcssblk_dax_copy_to_iter(struct dax_device *dax_dev,
 	return copy_to_iter(addr, bytes, i);
 }
 
+static int dcssblk_dax_zero_page_range(struct dax_device *dax_dev, u64 offset,
+				       size_t len)
+{
+	long rc;
+	void *kaddr;
+	pgoff_t pgoff = offset >> PAGE_SHIFT;
+	unsigned page_offset = offset_in_page(offset);
+
+	rc = dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
+	if (rc < 0)
+		return rc;
+	memset(kaddr + page_offset, 0, len);
+	dax_flush(dax_dev, kaddr + page_offset, len);
+	return 0;
+}
+
 static const struct dax_operations dcssblk_dax_ops = {
 	.direct_access = dcssblk_dax_direct_access,
 	.dax_supported = generic_fsdax_supported,
 	.copy_from_iter = dcssblk_dax_copy_from_iter,
 	.copy_to_iter = dcssblk_dax_copy_to_iter,
+	.zero_page_range = dcssblk_dax_zero_page_range,
 };
 
 struct dcssblk_dev_info {
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6005B1510AC
	for <lists+linux-nvdimm@lfdr.de>; Mon,  3 Feb 2020 21:01:20 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9880710FC337E;
	Mon,  3 Feb 2020 12:04:15 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.120; helo=us-smtp-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [205.139.110.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3C3A310FC3375
	for <linux-nvdimm@lists.01.org>; Mon,  3 Feb 2020 12:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1580760054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=shhBFCMAdHyZPSUtZvbDnSl6Hh6MWwOI5m8jhLLofFE=;
	b=ga89WBB5lunq63ZiAP591mvF32fCH/VSn5ooq0MNJgzdlbDIPqd51P2mv+1S6LlWhyD1WS
	2H+6vMDr6tl1g0Nh322tntov+rpcAGrvCWDPAHE+mQx248O3JOoqVy7iuP0Xu6H6+y7NDm
	s2QO3mqBM6SkEi6LJepMiNj2M4nuUFg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-F8QWiDr3OLqkSVisg9cvPg-1; Mon, 03 Feb 2020 15:00:50 -0500
X-MC-Unique: F8QWiDr3OLqkSVisg9cvPg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03C65107ACC4;
	Mon,  3 Feb 2020 20:00:49 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 777C48CCC2;
	Mon,  3 Feb 2020 20:00:46 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 0DB832246B1; Mon,  3 Feb 2020 15:00:46 -0500 (EST)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	dan.j.williams@intel.com,
	hch@infradead.org
Subject: [PATCH 2/5] s390,dax: Add dax zero_page_range operation to dcssblk driver
Date: Mon,  3 Feb 2020 15:00:26 -0500
Message-Id: <20200203200029.4592-3-vgoyal@redhat.com>
In-Reply-To: <20200203200029.4592-1-vgoyal@redhat.com>
References: <20200203200029.4592-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Message-ID-Hash: J4FTARKCSS6APVUUCILLPMY42GEVYKU3
X-Message-ID-Hash: J4FTARKCSS6APVUUCILLPMY42GEVYKU3
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: dm-devel@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/J4FTARKCSS6APVUUCILLPMY42GEVYKU3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add dax operation zero_page_range. This just calls generic helper
generic_dax_zero_page_range().

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 drivers/s390/block/dcssblk.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 63502ca537eb..f6709200bcd0 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -62,6 +62,7 @@ static const struct dax_operations dcssblk_dax_ops = {
 	.dax_supported = generic_fsdax_supported,
 	.copy_from_iter = dcssblk_dax_copy_from_iter,
 	.copy_to_iter = dcssblk_dax_copy_to_iter,
+	.zero_page_range = dcssblk_dax_zero_page_range,
 };
 
 struct dcssblk_dev_info {
@@ -941,6 +942,12 @@ dcssblk_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 	return __dcssblk_direct_access(dev_info, pgoff, nr_pages, kaddr, pfn);
 }
 
+static int dcssblk_dax_zero_page_range(struct dax_device *dax_dev,pgoff_t pgoff,
+				       unsigned offset, size_t len)
+{
+	return generic_dax_zero_page_range(dax_dev, pgoff, offset, len);
+}
+
 static void
 dcssblk_check_params(void)
 {
-- 
2.18.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

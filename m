Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE4315AE19
	for <lists+linux-nvdimm@lfdr.de>; Wed, 12 Feb 2020 18:08:03 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 03EA810FC337D;
	Wed, 12 Feb 2020 09:11:16 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-delivery-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0219B10FC317F
	for <linux-nvdimm@lists.01.org>; Wed, 12 Feb 2020 09:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1581527275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Kx97YjoepQpQ0kz210ikU62VnqPVqaOjhm9SlazRBo=;
	b=gNcbxa1isplaIvP9rBjxqY2ejICIZ/qnU8BEf+6rbzT1vqz273d3oXqK5vyv5SZo7Ejh74
	4fxcjGLwl/mXcQgtpT/ZjK+LSzXnQG2imJYukUvz6oayGDHzYO7oQjiyLsuREvTZtgVSw9
	/OQFYYMhcpUJR8Fa19OrWJtwCHybt0k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-e1m5cTtcPZ-n_WXIgSZPsQ-1; Wed, 12 Feb 2020 12:07:51 -0500
X-MC-Unique: e1m5cTtcPZ-n_WXIgSZPsQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 432DF800D41;
	Wed, 12 Feb 2020 17:07:50 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 21BC25C1B2;
	Wed, 12 Feb 2020 17:07:50 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id C052D2257D7; Wed, 12 Feb 2020 12:07:46 -0500 (EST)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	dan.j.williams@intel.com,
	hch@infradead.org
Subject: [PATCH 5/6] drivers/dax: Use dax_pgoff() instead of bdev_dax_pgoff()
Date: Wed, 12 Feb 2020 12:07:32 -0500
Message-Id: <20200212170733.8092-6-vgoyal@redhat.com>
In-Reply-To: <20200212170733.8092-1-vgoyal@redhat.com>
References: <20200212170733.8092-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Message-ID-Hash: 6RZCOTNZ56ZFENU7CCHNP74RQJCTPERW
X-Message-ID-Hash: 6RZCOTNZ56ZFENU7CCHNP74RQJCTPERW
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: dm-devel@redhat.com, jack@suse.cz
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6RZCOTNZ56ZFENU7CCHNP74RQJCTPERW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Start using dax_pgoff() instead of bdev_dax_pgoff().

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 drivers/dax/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index e9daa30e4250..ee35ecc61545 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -97,7 +97,7 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
 		return false;
 	}
 
-	err = bdev_dax_pgoff(bdev, start, PAGE_SIZE, &pgoff);
+	err = dax_pgoff(get_start_sect(bdev), start, PAGE_SIZE, &pgoff);
 	if (err) {
 		pr_debug("%s: error: unaligned partition for dax\n",
 				bdevname(bdev, buf));
@@ -105,7 +105,7 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
 	}
 
 	last_page = PFN_DOWN((start + sectors - 1) * 512) * PAGE_SIZE / 512;
-	err = bdev_dax_pgoff(bdev, last_page, PAGE_SIZE, &pgoff_end);
+	err = dax_pgoff(get_start_sect(bdev), last_page, PAGE_SIZE, &pgoff_end);
 	if (err) {
 		pr_debug("%s: error: unaligned partition for dax\n",
 				bdevname(bdev, buf));
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

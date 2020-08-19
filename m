Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B32D724A90C
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Aug 2020 00:21:14 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4C312134BE058;
	Wed, 19 Aug 2020 15:21:10 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-delivery-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9D39B134BE049
	for <linux-nvdimm@lists.01.org>; Wed, 19 Aug 2020 15:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1597875665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+4JPYlZ9QDYDC/mD0F6lPDwdYttMSKvhVad1UZeeChA=;
	b=Rqb/KziIqR3qhjwB6PANiyrYvd8qf0MWVqHtXJ/PCk07bOIsrOIWvx7yrTYcNv89DBIaFV
	JQmWbTglu+6L6qPTCHYfnigxEoVtjohORqeCN+rqC8ZuVjEnI7hx0FXX7ZuyBuiakZM9G4
	AbERB0/C1bzY2CYyivqH4bramMjf5kk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-mzDGoN68MzeM2JWyxMOSZw-1; Wed, 19 Aug 2020 18:21:02 -0400
X-MC-Unique: mzDGoN68MzeM2JWyxMOSZw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E05028030A1;
	Wed, 19 Aug 2020 22:21:00 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-197.rdu2.redhat.com [10.10.115.197])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3B0A35C88D;
	Wed, 19 Aug 2020 22:20:54 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id C68142254FA; Wed, 19 Aug 2020 18:20:53 -0400 (EDT)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	virtio-fs@redhat.com
Subject: [PATCH v3 01/18] dax: Modify bdev_dax_pgoff() to handle NULL bdev
Date: Wed, 19 Aug 2020 18:19:39 -0400
Message-Id: <20200819221956.845195-2-vgoyal@redhat.com>
In-Reply-To: <20200819221956.845195-1-vgoyal@redhat.com>
References: <20200819221956.845195-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Message-ID-Hash: AAYUEMC5M2FUYKO7GXKSF35XE53A6QN7
X-Message-ID-Hash: AAYUEMC5M2FUYKO7GXKSF35XE53A6QN7
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: miklos@szeredi.hu, stefanha@redhat.com, dgilbert@redhat.com, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AAYUEMC5M2FUYKO7GXKSF35XE53A6QN7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

virtiofs does not have a block device but it has dax device.
Modify bdev_dax_pgoff() to be able to handle that.

If there is no bdev, that means dax offset is 0. (It can't be a partition
block device starting at an offset in dax device).

This is little hackish. There have been discussions about getting rid
of dax not supporting partitions.

https://lore.kernel.org/linux-fsdevel/20200107125159.GA15745@infradead.org/

IMHO, this path can easily break exisitng users. For example
ioctl(BLKPG_ADD_PARTITION) will start breaking on block devices
supporting DAX. Also, I personally find it very useful to be able to
partition dax devices and still be able to use DAX.

Alternatively, I tried to store offset into dax device information in iomap
interface, but that got NACKed.

https://lore.kernel.org/linux-fsdevel/20200217133117.GB20444@infradead.org/

I can't think of a good path to solve this issue properly. So to make
progress, it seems this patch is least bad option for now and I hope
we can take it.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Vishal L Verma <vishal.l.verma@intel.com>
Cc: "Weiny, Ira" <ira.weiny@intel.com>
Cc: linux-nvdimm@lists.01.org
---
 drivers/dax/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index c82cbcb64202..505165752d8f 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -46,7 +46,8 @@ EXPORT_SYMBOL_GPL(dax_read_unlock);
 int bdev_dax_pgoff(struct block_device *bdev, sector_t sector, size_t size,
 		pgoff_t *pgoff)
 {
-	phys_addr_t phys_off = (get_start_sect(bdev) + sector) * 512;
+	sector_t start_sect = bdev ? get_start_sect(bdev) : 0;
+	phys_addr_t phys_off = (start_sect + sector) * 512;
 
 	if (pgoff)
 		*pgoff = PHYS_PFN(phys_off);
-- 
2.25.4
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

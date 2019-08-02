Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BE6800F4
	for <lists+linux-nvdimm@lfdr.de>; Fri,  2 Aug 2019 21:30:03 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0155B2130C4A4;
	Fri,  2 Aug 2019 12:32:32 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=vgoyal@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D0539213030AE
 for <linux-nvdimm@lists.01.org>; Fri,  2 Aug 2019 12:32:30 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 089EF3CA12;
 Fri,  2 Aug 2019 19:29:59 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.158])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A4D4F19C68;
 Fri,  2 Aug 2019 19:29:56 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 2C27C22377E; Fri,  2 Aug 2019 15:29:56 -0400 (EDT)
Date: Fri, 2 Aug 2019 15:29:56 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: dan.j.williams@intel.com, linux-nvdimm@lists.01.org
Subject: [PATCH] dax: dax_layout_busy_page() should not unmap cow pages
Message-ID: <20190802192956.GA3032@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 02 Aug 2019 19:29:59 +0000 (UTC)
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

As of now dax_layout_busy_page() calls unmap_mapping_range() with last
argument as 1, which says even unmap cow pages. I am wondering who needs
to get rid of cow pages as well.

I noticed one interesting side affect of this. I mount xfs with -o dax and
mmaped a file with MAP_PRIVATE and wrote some data to a page which created
cow page. Then I called fallocate() on that file to zero a page of file.
fallocate() called dax_layout_busy_page() which unmapped cow pages as well
and then I tried to read back the data I wrote and what I get is old
data from persistent memory. I lost the data I had written. This
read basically resulted in new fault and read back the data from
persistent memory.

This sounds wrong. Are there any users which need to unmap cow pages
as well? If not, I am proposing changing it to not unmap cow pages.

I noticed this while while writing virtio_fs code where when I tried
to reclaim a memory range and that corrupted the executable and I
was running from virtio-fs and program got segment violation.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/dax.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: rhvgoyal-linux/fs/dax.c
===================================================================
--- rhvgoyal-linux.orig/fs/dax.c	2019-08-01 17:03:10.574675652 -0400
+++ rhvgoyal-linux/fs/dax.c	2019-08-02 14:32:28.809639116 -0400
@@ -600,7 +600,7 @@ struct page *dax_layout_busy_page(struct
 	 * guaranteed to either see new references or prevent new
 	 * references from being established.
 	 */
-	unmap_mapping_range(mapping, 0, 0, 1);
+	unmap_mapping_range(mapping, 0, 0, 0);
 
 	xas_lock_irq(&xas);
 	xas_for_each(&xas, entry, ULONG_MAX) {
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

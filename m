Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 067EB2990E0
	for <lists+linux-nvdimm@lfdr.de>; Mon, 26 Oct 2020 16:19:06 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E39DC161A7F39;
	Mon, 26 Oct 2020 08:19:02 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 21125161A7F35
	for <linux-nvdimm@lists.01.org>; Mon, 26 Oct 2020 08:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=u2Fe6BQ/u/f2UXO9kqkzvT+VV4hRg/ENhBrvFiLbe5s=; b=dKfgeZnLltsNCRY492u0UBMfel
	qg1TKqVaKjRSiA5LR5yaiie/d407qBVpsV/DMwBnPi87sFCUef+TqazMuJleIECxD61YLex96ipOa
	QTTbRCQtS4NuyhobrZ/ObBrWRP1Nee5CdhDaxbBu+XRCKbRW8GSswQ98veAxERha0vYWm8hMYngp+
	akFQvO9VITfMKwWo3f/rl5F85fMSViaSj7l47Of6t65SMs/DdZRvRIgTqtdi5mGKcLqWOmeltGajp
	HUTYVEVo1g6RPdHuJaF17nqGpIk7+aOrGmlac/6JoAGGwd7WddEbmymrBwXMoLm2dkwogJWehs28Y
	bs7IGdLg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kX4Gp-0006Jw-DX; Mon, 26 Oct 2020 15:18:51 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org
Subject: [PATCH v2 1/4] mm: Introduce and use mapping_empty
Date: Mon, 26 Oct 2020 15:18:46 +0000
Message-Id: <20201026151849.24232-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201026151849.24232-1-willy@infradead.org>
References: <20201026151849.24232-1-willy@infradead.org>
MIME-Version: 1.0
Message-ID-Hash: IHAAIFCO6HG3UZCMA2XL7UGKSJ3UUUX6
X-Message-ID-Hash: IHAAIFCO6HG3UZCMA2XL7UGKSJ3UUUX6
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IHAAIFCO6HG3UZCMA2XL7UGKSJ3UUUX6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Instead of checking the two counters (nrpages and nrexceptional), we
can just check whether i_pages is empty.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Tested-by: Vishal Verma <vishal.l.verma@intel.com>
---
 fs/block_dev.c          |  2 +-
 fs/dax.c                |  2 +-
 fs/gfs2/glock.c         |  3 +--
 include/linux/pagemap.h |  5 +++++
 mm/truncate.c           | 18 +++---------------
 5 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9e84b1928b94..34105f66e12f 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -79,7 +79,7 @@ static void kill_bdev(struct block_device *bdev)
 {
 	struct address_space *mapping = bdev->bd_inode->i_mapping;
 
-	if (mapping->nrpages == 0 && mapping->nrexceptional == 0)
+	if (mapping_empty(mapping))
 		return;
 
 	invalidate_bh_lrus();
diff --git a/fs/dax.c b/fs/dax.c
index 5b47834f2e1b..53ed0ab8c958 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -965,7 +965,7 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 	if (WARN_ON_ONCE(inode->i_blkbits != PAGE_SHIFT))
 		return -EIO;
 
-	if (!mapping->nrexceptional || wbc->sync_mode != WB_SYNC_ALL)
+	if (mapping_empty(mapping) || wbc->sync_mode != WB_SYNC_ALL)
 		return 0;
 
 	trace_dax_writeback_range(inode, xas.xa_index, end_index);
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 5441c17562c5..bfad01ce096d 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -273,8 +273,7 @@ static void __gfs2_glock_put(struct gfs2_glock *gl)
 	if (mapping) {
 		truncate_inode_pages_final(mapping);
 		if (!gfs2_withdrawn(sdp))
-			GLOCK_BUG_ON(gl, mapping->nrpages ||
-				     mapping->nrexceptional);
+			GLOCK_BUG_ON(gl, !mapping_empty(mapping));
 	}
 	trace_gfs2_glock_put(gl);
 	sdp->sd_lockstruct.ls_ops->lm_put_lock(gl);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index dc3390e6ee3e..86143d36d028 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -18,6 +18,11 @@
 
 struct pagevec;
 
+static inline bool mapping_empty(struct address_space *mapping)
+{
+	return xa_empty(&mapping->i_pages);
+}
+
 /*
  * Bits in mapping->flags.
  */
diff --git a/mm/truncate.c b/mm/truncate.c
index 11ef90d7e3af..58524aaf67e2 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -342,7 +342,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	struct page *	page;
 	bool partial_end;
 
-	if (mapping->nrpages == 0 && mapping->nrexceptional == 0)
+	if (mapping_empty(mapping))
 		goto out;
 
 	/*
@@ -470,9 +470,6 @@ EXPORT_SYMBOL(truncate_inode_pages);
  */
 void truncate_inode_pages_final(struct address_space *mapping)
 {
-	unsigned long nrexceptional;
-	unsigned long nrpages;
-
 	/*
 	 * Page reclaim can not participate in regular inode lifetime
 	 * management (can't call iput()) and thus can race with the
@@ -482,16 +479,7 @@ void truncate_inode_pages_final(struct address_space *mapping)
 	 */
 	mapping_set_exiting(mapping);
 
-	/*
-	 * When reclaim installs eviction entries, it increases
-	 * nrexceptional first, then decreases nrpages.  Make sure we see
-	 * this in the right order or we might miss an entry.
-	 */
-	nrpages = mapping->nrpages;
-	smp_rmb();
-	nrexceptional = mapping->nrexceptional;
-
-	if (nrpages || nrexceptional) {
+	if (!mapping_empty(mapping)) {
 		/*
 		 * As truncation uses a lockless tree lookup, cycle
 		 * the tree lock to make sure any ongoing tree
@@ -657,7 +645,7 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 	int ret2 = 0;
 	int did_range_unmap = 0;
 
-	if (mapping->nrpages == 0 && mapping->nrexceptional == 0)
+	if (mapping_empty(mapping))
 		goto out;
 
 	pagevec_init(&pvec);
-- 
2.28.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

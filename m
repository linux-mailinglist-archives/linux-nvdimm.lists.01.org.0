Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 782C52990DD
	for <lists+linux-nvdimm@lfdr.de>; Mon, 26 Oct 2020 16:19:02 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 941601607FD38;
	Mon, 26 Oct 2020 08:19:00 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7CDF71606A31D
	for <linux-nvdimm@lists.01.org>; Mon, 26 Oct 2020 08:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=n6jFmTk/80oHxPEc+nlR48Wkyjmo4dNW4K8OCdeXgjc=; b=cqyQyYbVduDoU3LlPdawStRBcd
	k9JKZ+usT65v41U/kLQGzsIoTLB8YIR/y+XXv6cMlG5/JFW2duXDhmP0Gu0+9qRCCapfrrYocaatu
	ySYb84BhcAy7X0lhT64cHWlFJ2aXsIYWqrEOan6cj2T3jCiprarTM/mAwWcoyYXu9uxFwq6ppC9wq
	j4bIcU8LTet1YgryCUth5WgKFxg9qI1g79p3q5TzRjtdBD8V4bdU+yo0UifODu2CZ8zVoPYDgLhdF
	+ieu3P/fTScHyp6aP82usGr+N2NvhokP4nmIES+BPRPcduCTR2fwPHw4JZibcqQFulcI6BtnYIpQJ
	CBt1EKcA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kX4Gp-0006K8-U9; Mon, 26 Oct 2020 15:18:51 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org
Subject: [PATCH v2 4/4] mm: Remove nrexceptional from inode
Date: Mon, 26 Oct 2020 15:18:49 +0000
Message-Id: <20201026151849.24232-5-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201026151849.24232-1-willy@infradead.org>
References: <20201026151849.24232-1-willy@infradead.org>
MIME-Version: 1.0
Message-ID-Hash: P4YKSSI5KARF4L3W5NLMLKZ37YBEKEKX
X-Message-ID-Hash: P4YKSSI5KARF4L3W5NLMLKZ37YBEKEKX
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/P4YKSSI5KARF4L3W5NLMLKZ37YBEKEKX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

We no longer track anything in nrexceptional, so remove it, saving 8
bytes per inode.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Tested-by: Vishal Verma <vishal.l.verma@intel.com>
---
 fs/inode.c         | 2 +-
 include/linux/fs.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 9d78c37b00b8..4531358ae97b 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -530,7 +530,7 @@ void clear_inode(struct inode *inode)
 	 */
 	xa_lock_irq(&inode->i_data.i_pages);
 	BUG_ON(inode->i_data.nrpages);
-	BUG_ON(inode->i_data.nrexceptional);
+	BUG_ON(!mapping_empty(&inode->i_data));
 	xa_unlock_irq(&inode->i_data.i_pages);
 	BUG_ON(!list_empty(&inode->i_data.private_list));
 	BUG_ON(!(inode->i_state & I_FREEING));
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0bd126418bb6..a5d801430040 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -439,7 +439,6 @@ int pagecache_write_end(struct file *, struct address_space *mapping,
  * @i_mmap: Tree of private and shared mappings.
  * @i_mmap_rwsem: Protects @i_mmap and @i_mmap_writable.
  * @nrpages: Number of page entries, protected by the i_pages lock.
- * @nrexceptional: Shadow or DAX entries, protected by the i_pages lock.
  * @writeback_index: Writeback starts here.
  * @a_ops: Methods.
  * @flags: Error bits and flags (AS_*).
@@ -460,7 +459,6 @@ struct address_space {
 	struct rb_root_cached	i_mmap;
 	struct rw_semaphore	i_mmap_rwsem;
 	unsigned long		nrpages;
-	unsigned long		nrexceptional;
 	pgoff_t			writeback_index;
 	const struct address_space_operations *a_ops;
 	unsigned long		flags;
-- 
2.28.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

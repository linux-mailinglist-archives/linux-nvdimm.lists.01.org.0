Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6E62990DF
	for <lists+linux-nvdimm@lfdr.de>; Mon, 26 Oct 2020 16:19:03 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AB24115FD55F3;
	Mon, 26 Oct 2020 08:19:01 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7DBA01607FD38
	for <linux-nvdimm@lists.01.org>; Mon, 26 Oct 2020 08:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=YBpgmOJoJ1jlUGhshMwr4ZbPT8T4YP/gLs08vxJuO+w=; b=ZdHfDjJVPbTjQFu9WaucKuuGhl
	PDbKN10iDop7d07eWwksVUgPyvIwSx9sp3yBR/Eil8wEW6X3IO2UD7jWN4IQweA7NkBtXAHfKc8Y0
	DDF8Kh8SVSALt3kcrLQ1H7AFLczfn/bOEapc8ALyIfO5Cm4lcOJjqi/EWHDefnEJOsZLmCCUHm8nx
	KH3KWwMDO4Qt1OwGelnq2B17/jLZSQu+5rgmOATRyx0wazdoGnX3Mw8D9XRpujPV+gqDyFgOSMm1T
	4IRwuyYobSyITyvJOQfiLmCFLeAHvuTcqrH8mQ+jzJsyNCLyG8P6/zlvZpNPoSbUHQ0kpH+gv/XhW
	gKW97k6g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kX4Gp-0006K0-Ja; Mon, 26 Oct 2020 15:18:51 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org
Subject: [PATCH v2 2/4] mm: Stop accounting shadow entries
Date: Mon, 26 Oct 2020 15:18:47 +0000
Message-Id: <20201026151849.24232-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201026151849.24232-1-willy@infradead.org>
References: <20201026151849.24232-1-willy@infradead.org>
MIME-Version: 1.0
Message-ID-Hash: FIQTZPUURIMGPD7CXT7JVCJWLYQMTJUN
X-Message-ID-Hash: FIQTZPUURIMGPD7CXT7JVCJWLYQMTJUN
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FIQTZPUURIMGPD7CXT7JVCJWLYQMTJUN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

We no longer need to keep track of how many shadow entries are
present in a mapping.  This saves a few writes to the inode and
memory barriers.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Tested-by: Vishal Verma <vishal.l.verma@intel.com>
---
 mm/filemap.c    | 13 -------------
 mm/swap_state.c |  4 ----
 mm/truncate.c   |  1 -
 mm/workingset.c |  1 -
 4 files changed, 19 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index bd116f63263e..2e68116be4b0 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -140,17 +140,6 @@ static void page_cache_delete(struct address_space *mapping,
 
 	page->mapping = NULL;
 	/* Leave page->index set: truncation lookup relies upon it */
-
-	if (shadow) {
-		mapping->nrexceptional += nr;
-		/*
-		 * Make sure the nrexceptional update is committed before
-		 * the nrpages update so that final truncate racing
-		 * with reclaim does not see both counters 0 at the
-		 * same time and miss a shadow entry.
-		 */
-		smp_wmb();
-	}
 	mapping->nrpages -= nr;
 }
 
@@ -883,8 +872,6 @@ noinline int __add_to_page_cache_locked(struct page *page,
 		if (xas_error(&xas))
 			goto unlock;
 
-		if (old)
-			mapping->nrexceptional--;
 		mapping->nrpages++;
 
 		/* hugetlb pages do not participate in page cache accounting */
diff --git a/mm/swap_state.c b/mm/swap_state.c
index ee465827420e..85aca8d63aeb 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -160,7 +160,6 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry,
 			xas_store(&xas, page);
 			xas_next(&xas);
 		}
-		address_space->nrexceptional -= nr_shadows;
 		address_space->nrpages += nr;
 		__mod_node_page_state(page_pgdat(page), NR_FILE_PAGES, nr);
 		ADD_CACHE_INFO(add_total, nr);
@@ -199,8 +198,6 @@ void __delete_from_swap_cache(struct page *page,
 		xas_next(&xas);
 	}
 	ClearPageSwapCache(page);
-	if (shadow)
-		address_space->nrexceptional += nr;
 	address_space->nrpages -= nr;
 	__mod_node_page_state(page_pgdat(page), NR_FILE_PAGES, -nr);
 	ADD_CACHE_INFO(del_total, nr);
@@ -301,7 +298,6 @@ void clear_shadow_from_swap_cache(int type, unsigned long begin,
 			xas_store(&xas, NULL);
 			nr_shadows++;
 		}
-		address_space->nrexceptional -= nr_shadows;
 		xa_unlock_irq(&address_space->i_pages);
 
 		/* search the next swapcache until we meet end */
diff --git a/mm/truncate.c b/mm/truncate.c
index 58524aaf67e2..27cf411ae51f 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -40,7 +40,6 @@ static inline void __clear_shadow_entry(struct address_space *mapping,
 	if (xas_load(&xas) != entry)
 		return;
 	xas_store(&xas, NULL);
-	mapping->nrexceptional--;
 }
 
 static void clear_shadow_entry(struct address_space *mapping, pgoff_t index,
diff --git a/mm/workingset.c b/mm/workingset.c
index 975a4d2dd02e..74d5f460e446 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -557,7 +557,6 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
 		goto out_invalid;
 	if (WARN_ON_ONCE(node->count != node->nr_values))
 		goto out_invalid;
-	mapping->nrexceptional -= node->nr_values;
 	xa_delete_node(node, workingset_update_node);
 	__inc_lruvec_slab_state(node, WORKINGSET_NODERECLAIM);
 
-- 
2.28.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

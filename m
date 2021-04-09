Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1BC35A3D3
	for <lists+linux-nvdimm@lfdr.de>; Fri,  9 Apr 2021 18:45:11 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 223A8100EAB0B;
	Fri,  9 Apr 2021 09:45:09 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=colyli@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2B978100EAB0B
	for <linux-nvdimm@lists.01.org>; Fri,  9 Apr 2021 09:45:04 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id B7414B0B8;
	Fri,  9 Apr 2021 16:45:02 +0000 (UTC)
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Subject: [PATCH v7 11/16] bcache: support storing bcache journal into NVDIMM meta device
Date: Sat, 10 Apr 2021 00:43:38 +0800
Message-Id: <20210409164343.56828-12-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210409164343.56828-1-colyli@suse.de>
References: <20210409164343.56828-1-colyli@suse.de>
MIME-Version: 1.0
Message-ID-Hash: 3NENLJZSEKQ5BXJTBOW5TFED34SBOC6P
X-Message-ID-Hash: 3NENLJZSEKQ5BXJTBOW5TFED34SBOC6P
X-MailFrom: colyli@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-block@vger.kernel.org, linux-nvdimm@lists.01.org, axboe@kernel.dk, jianpeng.ma@intel.com, qiaowei.ren@intel.com, hare@suse.com, jack@suse.cz, Coly Li <colyli@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3NENLJZSEKQ5BXJTBOW5TFED34SBOC6P/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch implements two methods to store bcache journal to,
1) __journal_write_unlocked() for block interface device
   The latency method to compose bio and issue the jset bio to cache
   device (e.g. SSD). c->journal.key.ptr[0] indicates the LBA on cache
   device to store the journal jset.
2) __journal_nvdimm_write_unlocked() for memory interface NVDIMM
   Use memory interface to access NVDIMM pages and store the jset by
   memcpy_flushcache(). c->journal.key.ptr[0] indicates the linear
   address from the NVDIMM pages to store the journal jset.

For lagency configuration without NVDIMM meta device, journal I/O is
handled by __journal_write_unlocked() with existing code logic. If the
NVDIMM meta device is used (by bcache-tools), the journal I/O will
be handled by __journal_nvdimm_write_unlocked() and go into the NVDIMM
pages.

And when NVDIMM meta device is used, sb.d[] stores the linear addresses
from NVDIMM pages (no more bucket index), in journal_reclaim() the
journaling location in c->journal.key.ptr[0] should also be updated by
linear address from NVDIMM pages (no more LBA combined by sectors offset
and bucket index).

Signed-off-by: Coly Li <colyli@suse.de>
Cc: Jianpeng Ma <jianpeng.ma@intel.com>
Cc: Qiaowei Ren <qiaowei.ren@intel.com>
---
 drivers/md/bcache/journal.c   | 119 ++++++++++++++++++++++++----------
 drivers/md/bcache/nvm-pages.h |   1 +
 drivers/md/bcache/super.c     |  25 ++++++-
 3 files changed, 107 insertions(+), 38 deletions(-)

diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index acbfd4ec88af..9a542e6c2152 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -596,6 +596,8 @@ static void do_journal_discard(struct cache *ca)
 		return;
 	}
 
+	BUG_ON(bch_has_feature_nvdimm_meta(&ca->sb));
+
 	switch (atomic_read(&ja->discard_in_flight)) {
 	case DISCARD_IN_FLIGHT:
 		return;
@@ -661,9 +663,13 @@ static void journal_reclaim(struct cache_set *c)
 		goto out;
 
 	ja->cur_idx = next;
-	k->ptr[0] = MAKE_PTR(0,
-			     bucket_to_sector(c, ca->sb.d[ja->cur_idx]),
-			     ca->sb.nr_this_dev);
+	if (!bch_has_feature_nvdimm_meta(&ca->sb))
+		k->ptr[0] = MAKE_PTR(0,
+			bucket_to_sector(c, ca->sb.d[ja->cur_idx]),
+			ca->sb.nr_this_dev);
+	else
+		k->ptr[0] = ca->sb.d[ja->cur_idx];
+
 	atomic_long_inc(&c->reclaimed_journal_buckets);
 
 	bkey_init(k);
@@ -729,46 +735,21 @@ static void journal_write_unlock(struct closure *cl)
 	spin_unlock(&c->journal.lock);
 }
 
-static void journal_write_unlocked(struct closure *cl)
+
+static void __journal_write_unlocked(struct cache_set *c)
 	__releases(c->journal.lock)
 {
-	struct cache_set *c = container_of(cl, struct cache_set, journal.io);
-	struct cache *ca = c->cache;
-	struct journal_write *w = c->journal.cur;
 	struct bkey *k = &c->journal.key;
-	unsigned int i, sectors = set_blocks(w->data, block_bytes(ca)) *
-		ca->sb.block_size;
-
+	struct journal_write *w = c->journal.cur;
+	struct closure *cl = &c->journal.io;
+	struct cache *ca = c->cache;
 	struct bio *bio;
 	struct bio_list list;
+	unsigned int i, sectors = set_blocks(w->data, block_bytes(ca)) *
+		ca->sb.block_size;
 
 	bio_list_init(&list);
 
-	if (!w->need_write) {
-		closure_return_with_destructor(cl, journal_write_unlock);
-		return;
-	} else if (journal_full(&c->journal)) {
-		journal_reclaim(c);
-		spin_unlock(&c->journal.lock);
-
-		btree_flush_write(c);
-		continue_at(cl, journal_write, bch_journal_wq);
-		return;
-	}
-
-	c->journal.blocks_free -= set_blocks(w->data, block_bytes(ca));
-
-	w->data->btree_level = c->root->level;
-
-	bkey_copy(&w->data->btree_root, &c->root->key);
-	bkey_copy(&w->data->uuid_bucket, &c->uuid_bucket);
-
-	w->data->prio_bucket[ca->sb.nr_this_dev] = ca->prio_buckets[0];
-	w->data->magic		= jset_magic(&ca->sb);
-	w->data->version	= BCACHE_JSET_VERSION;
-	w->data->last_seq	= last_seq(&c->journal);
-	w->data->csum		= csum_set(w->data);
-
 	for (i = 0; i < KEY_PTRS(k); i++) {
 		ca = PTR_CACHE(c, k, i);
 		bio = &ca->journal.bio;
@@ -793,7 +774,6 @@ static void journal_write_unlocked(struct closure *cl)
 
 		ca->journal.seq[ca->journal.cur_idx] = w->data->seq;
 	}
-
 	/* If KEY_PTRS(k) == 0, this jset gets lost in air */
 	BUG_ON(i == 0);
 
@@ -805,6 +785,73 @@ static void journal_write_unlocked(struct closure *cl)
 
 	while ((bio = bio_list_pop(&list)))
 		closure_bio_submit(c, bio, cl);
+}
+
+#ifdef CONFIG_BCACHE_NVM_PAGES
+
+static void __journal_nvdimm_write_unlocked(struct cache_set *c)
+	__releases(c->journal.lock)
+{
+	struct journal_write *w = c->journal.cur;
+	struct cache *ca = c->cache;
+	unsigned int sectors;
+
+	sectors = set_blocks(w->data, block_bytes(ca)) * ca->sb.block_size;
+	atomic_long_add(sectors, &ca->meta_sectors_written);
+
+	memcpy_flushcache((void *)c->journal.key.ptr[0], w->data, sectors << 9);
+
+	c->journal.key.ptr[0] += sectors << 9;
+	ca->journal.seq[ca->journal.cur_idx] = w->data->seq;
+
+	atomic_dec_bug(&fifo_back(&c->journal.pin));
+	bch_journal_next(&c->journal);
+	journal_reclaim(c);
+
+	spin_unlock(&c->journal.lock);
+}
+
+#else /* CONFIG_BCACHE_NVM_PAGES */
+
+static void __journal_nvdimm_write_unlocked(struct cache_set *c) { }
+
+#endif /* CONFIG_BCACHE_NVM_PAGES */
+
+static void journal_write_unlocked(struct closure *cl)
+{
+	struct cache_set *c = container_of(cl, struct cache_set, journal.io);
+	struct cache *ca = c->cache;
+	struct journal_write *w = c->journal.cur;
+
+	if (!w->need_write) {
+		closure_return_with_destructor(cl, journal_write_unlock);
+		return;
+	} else if (journal_full(&c->journal)) {
+		journal_reclaim(c);
+		spin_unlock(&c->journal.lock);
+
+		btree_flush_write(c);
+		continue_at(cl, journal_write, bch_journal_wq);
+		return;
+	}
+
+	c->journal.blocks_free -= set_blocks(w->data, block_bytes(ca));
+
+	w->data->btree_level = c->root->level;
+
+	bkey_copy(&w->data->btree_root, &c->root->key);
+	bkey_copy(&w->data->uuid_bucket, &c->uuid_bucket);
+
+	w->data->prio_bucket[ca->sb.nr_this_dev] = ca->prio_buckets[0];
+	w->data->magic		= jset_magic(&ca->sb);
+	w->data->version	= BCACHE_JSET_VERSION;
+	w->data->last_seq	= last_seq(&c->journal);
+	w->data->csum		= csum_set(w->data);
+
+	if (!bch_has_feature_nvdimm_meta(&ca->sb))
+		__journal_write_unlocked(c);
+	else
+		__journal_nvdimm_write_unlocked(c);
 
 	continue_at(cl, journal_write_done, NULL);
 }
diff --git a/drivers/md/bcache/nvm-pages.h b/drivers/md/bcache/nvm-pages.h
index b8a5cd0890d3..1c4cbad0209f 100644
--- a/drivers/md/bcache/nvm-pages.h
+++ b/drivers/md/bcache/nvm-pages.h
@@ -4,6 +4,7 @@
 #define _BCACHE_NVM_PAGES_H
 
 #include <linux/bcache-nvm.h>
+#include <linux/libnvdimm.h>
 
 /*
  * Bcache NVDIMM in memory data structures
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 144e7d0cc9a6..9640bfb85571 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1686,7 +1686,29 @@ void bch_cache_set_release(struct kobject *kobj)
 static void cache_set_free(struct closure *cl)
 {
 	struct cache_set *c = container_of(cl, struct cache_set, cl);
-	struct cache *ca;
+	struct cache *ca = c->cache;
+
+#ifdef CONFIG_BCACHE_NVM_PAGES
+	/* Flush cache if journal stored in NVDIMM */
+	if (ca && bch_has_feature_nvdimm_meta(&ca->sb)) {
+		unsigned long bucket_size = ca->sb.bucket_size;
+		int i;
+
+		for (i = 0; i < ca->sb.keys; i++) {
+			unsigned long offset = 0;
+			unsigned int len = round_down(UINT_MAX, 2);
+
+			while (bucket_size > 0) {
+				if (len > bucket_size)
+					len = bucket_size;
+				arch_invalidate_pmem(
+					(void *)(ca->sb.d[i] + offset), len);
+				offset += len;
+				bucket_size -= len;
+			}
+		}
+	}
+#endif /* CONFIG_BCACHE_NVM_PAGES */
 
 	debugfs_remove(c->debug);
 
@@ -1698,7 +1720,6 @@ static void cache_set_free(struct closure *cl)
 	bch_bset_sort_state_free(&c->sort);
 	free_pages((unsigned long) c->uuids, ilog2(meta_bucket_pages(&c->cache->sb)));
 
-	ca = c->cache;
 	if (ca) {
 		ca->set = NULL;
 		c->cache = NULL;
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

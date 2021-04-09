Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 926AE35A3D2
	for <lists+linux-nvdimm@lfdr.de>; Fri,  9 Apr 2021 18:45:08 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 08D6C100EAB11;
	Fri,  9 Apr 2021 09:45:01 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=colyli@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C665B100EAB0B
	for <linux-nvdimm@lists.01.org>; Fri,  9 Apr 2021 09:44:58 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 5EADEB2B9;
	Fri,  9 Apr 2021 16:44:57 +0000 (UTC)
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Subject: [PATCH v7 10/16] bcache: initialize bcache journal for NVDIMM meta device
Date: Sat, 10 Apr 2021 00:43:37 +0800
Message-Id: <20210409164343.56828-11-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210409164343.56828-1-colyli@suse.de>
References: <20210409164343.56828-1-colyli@suse.de>
MIME-Version: 1.0
Message-ID-Hash: NFS4MW4X2BROKAY65LFJXMXTKC34EJEP
X-Message-ID-Hash: NFS4MW4X2BROKAY65LFJXMXTKC34EJEP
X-MailFrom: colyli@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-block@vger.kernel.org, linux-nvdimm@lists.01.org, axboe@kernel.dk, jianpeng.ma@intel.com, qiaowei.ren@intel.com, hare@suse.com, jack@suse.cz, Coly Li <colyli@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NFS4MW4X2BROKAY65LFJXMXTKC34EJEP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The nvm-pages allocator may store and index the NVDIMM pages allocated
for bcache journal. This patch adds the initialization to store bcache
journal space on NVDIMM pages if BCH_FEATURE_INCOMPAT_NVDIMM_META bit is
set by bcache-tools.

If BCH_FEATURE_INCOMPAT_NVDIMM_META is set, get_nvdimm_journal_space()
will return the linear address of NVDIMM pages for bcache journal,
- If there is previously allocated space, find it from nvm-pages owner
  list and return to bch_journal_init().
- If there is no previously allocated space, require a new NVDIMM range
  from the nvm-pages allocator, and return it to bch_journal_init().

And in bch_journal_init(), keys in sb.d[] store the corresponding linear
address from NVDIMM into sb.d[i].ptr[0] where 'i' is the bucket index to
iterate all journal buckets.

Later when bcache journaling code stores the journaling jset, the target
NVDIMM linear address stored (and updated) in sb.d[i].ptr[0] can be used
directly in memory copy from DRAM pages into NVDIMM pages.

Signed-off-by: Coly Li <colyli@suse.de>
Cc: Jianpeng Ma <jianpeng.ma@intel.com>
Cc: Qiaowei Ren <qiaowei.ren@intel.com>
---
 drivers/md/bcache/journal.c | 105 ++++++++++++++++++++++++++++++++++++
 drivers/md/bcache/journal.h |   2 +-
 drivers/md/bcache/super.c   |  16 +++---
 3 files changed, 115 insertions(+), 8 deletions(-)

diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index c6613e817333..acbfd4ec88af 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -9,6 +9,8 @@
 #include "btree.h"
 #include "debug.h"
 #include "extents.h"
+#include "nvm-pages.h"
+#include "features.h"
 
 #include <trace/events/bcache.h>
 
@@ -982,3 +984,106 @@ int bch_journal_alloc(struct cache_set *c)
 
 	return 0;
 }
+
+#ifdef CONFIG_BCACHE_NVM_PAGES
+
+static void *find_journal_nvm_base(struct bch_nvm_pages_owner_head *owner_list,
+				   struct cache *ca)
+{
+	unsigned long addr = 0;
+	struct bch_nvm_pgalloc_recs *recs_list = owner_list->recs[0];
+
+	while (recs_list) {
+		struct bch_pgalloc_rec *rec;
+		unsigned long jnl_pgoff;
+		int i;
+
+		jnl_pgoff = ((unsigned long)ca->sb.d[0]) >> PAGE_SHIFT;
+		rec = recs_list->recs;
+		for (i = 0; i < recs_list->used; i++) {
+			if (rec->pgoff == jnl_pgoff)
+				break;
+			rec++;
+		}
+		if (i < recs_list->used) {
+			addr = rec->pgoff << PAGE_SHIFT;
+			break;
+		}
+		recs_list = recs_list->next;
+	}
+	return (void *)addr;
+}
+
+static void *get_nvdimm_journal_space(struct cache *ca)
+{
+	struct bch_nvm_pages_owner_head *owner_list = NULL;
+	void *ret = NULL;
+	int order;
+
+	owner_list = bch_get_allocated_pages(ca->sb.set_uuid);
+	if (owner_list) {
+		ret = find_journal_nvm_base(owner_list, ca);
+		if (ret)
+			goto found;
+	}
+
+	order = ilog2(ca->sb.bucket_size *
+		      ca->sb.njournal_buckets / PAGE_SECTORS);
+	ret = bch_nvm_alloc_pages(order, ca->sb.set_uuid);
+	if (ret)
+		memset(ret, 0, (1 << order) * PAGE_SIZE);
+
+found:
+	return ret;
+}
+
+static int __bch_journal_nvdimm_init(struct cache *ca)
+{
+	int i, ret = 0;
+	void *journal_nvm_base = NULL;
+
+	journal_nvm_base = get_nvdimm_journal_space(ca);
+	if (!journal_nvm_base) {
+		pr_err("Failed to get journal space from nvdimm\n");
+		ret = -1;
+		goto out;
+	}
+
+	/* Iniialized and reloaded from on-disk super block already */
+	if (ca->sb.d[0] != 0)
+		goto out;
+
+	for (i = 0; i < ca->sb.keys; i++)
+		ca->sb.d[i] =
+			(u64)(journal_nvm_base + (ca->sb.bucket_size * i));
+
+out:
+	return ret;
+}
+
+#else /* CONFIG_BCACHE_NVM_PAGES */
+
+static int __bch_journal_nvdimm_init(struct cache *ca)
+{
+	return -1;
+}
+
+#endif /* CONFIG_BCACHE_NVM_PAGES */
+
+int bch_journal_init(struct cache_set *c)
+{
+	int i, ret = 0;
+	struct cache *ca = c->cache;
+
+	ca->sb.keys = clamp_t(int, ca->sb.nbuckets >> 7,
+				2, SB_JOURNAL_BUCKETS);
+
+	if (!bch_has_feature_nvdimm_meta(&ca->sb)) {
+		for (i = 0; i < ca->sb.keys; i++)
+			ca->sb.d[i] = ca->sb.first_bucket + i;
+	} else {
+		ret = __bch_journal_nvdimm_init(ca);
+	}
+
+	return ret;
+}
diff --git a/drivers/md/bcache/journal.h b/drivers/md/bcache/journal.h
index f2ea34d5f431..e3a7fa5a8fda 100644
--- a/drivers/md/bcache/journal.h
+++ b/drivers/md/bcache/journal.h
@@ -179,7 +179,7 @@ void bch_journal_mark(struct cache_set *c, struct list_head *list);
 void bch_journal_meta(struct cache_set *c, struct closure *cl);
 int bch_journal_read(struct cache_set *c, struct list_head *list);
 int bch_journal_replay(struct cache_set *c, struct list_head *list);
-
+int bch_journal_init(struct cache_set *c);
 void bch_journal_free(struct cache_set *c);
 int bch_journal_alloc(struct cache_set *c);
 
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 0674a76d9454..144e7d0cc9a6 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -146,10 +146,15 @@ static const char *read_super_common(struct cache_sb *sb,  struct block_device *
 		goto err;
 
 	err = "Journal buckets not sequential";
+#ifdef CONFIG_BCACHE_NVM_PAGES
+	if (!bch_has_feature_nvdimm_meta(sb)) {
+#endif
 	for (i = 0; i < sb->keys; i++)
 		if (sb->d[i] != sb->first_bucket + i)
 			goto err;
-
+#ifdef CONFIG_BCACHE_NVM_PAGES
+	} /* bch_has_feature_nvdimm_meta */
+#endif
 	err = "Too many journal buckets";
 	if (sb->first_bucket + sb->keys > sb->nbuckets)
 		goto err;
@@ -2072,14 +2077,11 @@ static int run_cache_set(struct cache_set *c)
 		if (bch_journal_replay(c, &journal))
 			goto err;
 	} else {
-		unsigned int j;
-
 		pr_notice("invalidating existing data\n");
-		ca->sb.keys = clamp_t(int, ca->sb.nbuckets >> 7,
-					2, SB_JOURNAL_BUCKETS);
 
-		for (j = 0; j < ca->sb.keys; j++)
-			ca->sb.d[j] = ca->sb.first_bucket + j;
+		err = "error initializing journal";
+		if (bch_journal_init(c))
+			goto err;
 
 		bch_initial_gc_finish(c);
 
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

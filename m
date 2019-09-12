Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5B5B06E6
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Sep 2019 04:55:01 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 90C2121962301;
	Wed, 11 Sep 2019 19:55:05 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=216.40.44.95;
 helo=smtprelay.hostedemail.com; envelope-from=joe@perches.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from smtprelay.hostedemail.com (smtprelay0095.hostedemail.com
 [216.40.44.95])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 608EE20215F74
 for <linux-nvdimm@lists.01.org>; Wed, 11 Sep 2019 19:55:04 -0700 (PDT)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay02.hostedemail.com (Postfix) with ESMTP id 714E01E06E;
 Thu, 12 Sep 2019 02:54:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2, 0, 0, , d41d8cd98f00b204, joe@perches.com, :::::::::::::::::,
 RULES_HIT:69:355:371:372:379:541:960:966:968:973:982:988:989:1260:1345:1359:1431:1437:1461:1605:1730:1747:1777:1792:1801:1963:2194:2196:2198:2199:2200:2201:2393:2559:2562:2689:2693:2894:2895:2898:2899:2904:2924:2925:2926:3138:3139:3140:3141:3142:3865:3866:3867:3868:3870:3871:3874:4250:4321:4385:4605:5007:6261:7558:7875:7903:7904:7974:8568:8603:8660:9010:9036:9108:9163:9897:10004:10848:11026:11232:11233:11914:12043:12048:12291:12296:12297:12438:12555:12683:12895:12986:13138:13148:13230:13231:13972:14096:14394:14877:21080:21324:21325:21433:21450:21451:21611:21622:21740:21789:21795:21796:21810:21966:30003:30025:30029:30034:30036:30045:30051:30054:30056:30069:30070:30075:30079:30080:30090,
 0,
 RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,
 CacheIP:none, Bayesian:0.5, 0.5, 0.5, Netcheck:none, DomainCache:0,
 MSF:not bulk, SPF:fn, MSBL:0, DNSBL:none, Custom_rules:0:0:0, LFtime:3,
 LUA_SUMMARY:none
X-HE-Tag: pail74_820939831c537
X-Filterd-Recvd-Size: 183493
Received: from joe-laptop.perches.com (unknown [47.151.152.152])
 (Authenticated sender: joe@perches.com)
 by omf16.hostedemail.com (Postfix) with ESMTPA;
 Thu, 12 Sep 2019 02:54:53 +0000 (UTC)
From: Joe Perches <joe@perches.com>
To: Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Keith Busch <keith.busch@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 "Oliver O'Halloran" <oohall@gmail.com>
Subject: [PATCH 01/13] nvdimm: Use more typical whitespace
Date: Wed, 11 Sep 2019 19:54:31 -0700
Message-Id: <7a5598bda6a3d18d75c3e76ab89d9d95e8952500.1568256705.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1568256705.git.joe@perches.com>
References: <cover.1568256705.git.joe@perches.com>
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
Cc: linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
 linux-nvdimm@lists.01.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Convert the file to a more common kernel whitespace style to make
this more like other kernel files

git diff -w shows no difference.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/nvdimm/badrange.c       |  18 +--
 drivers/nvdimm/blk.c            |  26 ++--
 drivers/nvdimm/btt.c            | 192 +++++++++++++--------------
 drivers/nvdimm/btt.h            |   2 +-
 drivers/nvdimm/btt_devs.c       |  42 +++---
 drivers/nvdimm/bus.c            | 100 +++++++-------
 drivers/nvdimm/claim.c          |  36 +++---
 drivers/nvdimm/core.c           |  36 +++---
 drivers/nvdimm/dimm.c           |   2 +-
 drivers/nvdimm/dimm_devs.c      |  68 +++++-----
 drivers/nvdimm/e820.c           |   2 +-
 drivers/nvdimm/label.c          | 146 ++++++++++-----------
 drivers/nvdimm/label.h          |   4 +-
 drivers/nvdimm/namespace_devs.c | 280 ++++++++++++++++++++--------------------
 drivers/nvdimm/nd-core.h        |  26 ++--
 drivers/nvdimm/nd.h             |  66 +++++-----
 drivers/nvdimm/nd_virtio.c      |  18 +--
 drivers/nvdimm/of_pmem.c        |   6 +-
 drivers/nvdimm/pfn_devs.c       |  86 ++++++------
 drivers/nvdimm/pmem.c           |  44 +++----
 drivers/nvdimm/pmem.h           |   2 +-
 drivers/nvdimm/region.c         |  16 +--
 drivers/nvdimm/region_devs.c    | 122 ++++++++---------
 drivers/nvdimm/security.c       |  84 ++++++------
 drivers/nvdimm/virtio_pmem.c    |   8 +-
 25 files changed, 716 insertions(+), 716 deletions(-)

diff --git a/drivers/nvdimm/badrange.c b/drivers/nvdimm/badrange.c
index b9eeefa27e3a..b997c2007b83 100644
--- a/drivers/nvdimm/badrange.c
+++ b/drivers/nvdimm/badrange.c
@@ -24,7 +24,7 @@ void badrange_init(struct badrange *badrange)
 EXPORT_SYMBOL_GPL(badrange_init);
 
 static void append_badrange_entry(struct badrange *badrange,
-		struct badrange_entry *bre, u64 addr, u64 length)
+				  struct badrange_entry *bre, u64 addr, u64 length)
 {
 	lockdep_assert_held(&badrange->lock);
 	bre->start = addr;
@@ -33,7 +33,7 @@ static void append_badrange_entry(struct badrange *badrange,
 }
 
 static int alloc_and_append_badrange_entry(struct badrange *badrange,
-		u64 addr, u64 length, gfp_t flags)
+					   u64 addr, u64 length, gfp_t flags)
 {
 	struct badrange_entry *bre;
 
@@ -99,7 +99,7 @@ int badrange_add(struct badrange *badrange, u64 addr, u64 length)
 EXPORT_SYMBOL_GPL(badrange_add);
 
 void badrange_forget(struct badrange *badrange, phys_addr_t start,
-		unsigned int len)
+		     unsigned int len)
 {
 	struct list_head *badrange_list = &badrange->list;
 	u64 clr_end = start + len - 1;
@@ -152,7 +152,7 @@ void badrange_forget(struct badrange *badrange, phys_addr_t start,
 
 			/* Add new entry covering the right half */
 			alloc_and_append_badrange_entry(badrange, new_start,
-					new_len, GFP_NOWAIT);
+							new_len, GFP_NOWAIT);
 			/* Adjust this entry to cover the left half */
 			bre->length = start - bre->start;
 			continue;
@@ -165,11 +165,11 @@ EXPORT_SYMBOL_GPL(badrange_forget);
 static void set_badblock(struct badblocks *bb, sector_t s, int num)
 {
 	dev_dbg(bb->dev, "Found a bad range (0x%llx, 0x%llx)\n",
-			(u64) s * 512, (u64) num * 512);
+		(u64) s * 512, (u64) num * 512);
 	/* this isn't an error as the hardware will still throw an exception */
 	if (badblocks_set(bb, s, num, 1))
 		dev_info_once(bb->dev, "%s: failed for sector %llx\n",
-				__func__, (u64) s);
+			      __func__, (u64) s);
 }
 
 /**
@@ -211,7 +211,7 @@ static void __add_badblock_range(struct badblocks *bb, u64 ns_offset, u64 len)
 }
 
 static void badblocks_populate(struct badrange *badrange,
-		struct badblocks *bb, const struct resource *res)
+			       struct badblocks *bb, const struct resource *res)
 {
 	struct badrange_entry *bre;
 
@@ -267,13 +267,13 @@ static void badblocks_populate(struct badrange *badrange,
  * and add badblocks entries for all matching sub-ranges
  */
 void nvdimm_badblocks_populate(struct nd_region *nd_region,
-		struct badblocks *bb, const struct resource *res)
+			       struct badblocks *bb, const struct resource *res)
 {
 	struct nvdimm_bus *nvdimm_bus;
 
 	if (!is_memory(&nd_region->dev)) {
 		dev_WARN_ONCE(&nd_region->dev, 1,
-				"%s only valid for pmem regions\n", __func__);
+			      "%s only valid for pmem regions\n", __func__);
 		return;
 	}
 	nvdimm_bus = walk_to_nvdimm_bus(&nd_region->dev);
diff --git a/drivers/nvdimm/blk.c b/drivers/nvdimm/blk.c
index 677d6f45b5c4..edd3e1664edc 100644
--- a/drivers/nvdimm/blk.c
+++ b/drivers/nvdimm/blk.c
@@ -29,7 +29,7 @@ static u32 nsblk_sector_size(struct nd_namespace_blk *nsblk)
 }
 
 static resource_size_t to_dev_offset(struct nd_namespace_blk *nsblk,
-				resource_size_t ns_offset, unsigned int len)
+				     resource_size_t ns_offset, unsigned int len)
 {
 	int i;
 
@@ -37,7 +37,7 @@ static resource_size_t to_dev_offset(struct nd_namespace_blk *nsblk,
 		if (ns_offset < resource_size(nsblk->res[i])) {
 			if (ns_offset + len > resource_size(nsblk->res[i])) {
 				dev_WARN_ONCE(&nsblk->common.dev, 1,
-					"illegal request\n");
+					      "illegal request\n");
 				return SIZE_MAX;
 			}
 			return nsblk->res[i]->start + ns_offset;
@@ -61,7 +61,7 @@ static struct nd_blk_region *to_ndbr(struct nd_namespace_blk *nsblk)
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 static int nd_blk_rw_integrity(struct nd_namespace_blk *nsblk,
-		struct bio_integrity_payload *bip, u64 lba, int rw)
+			       struct bio_integrity_payload *bip, u64 lba, int rw)
 {
 	struct nd_blk_region *ndbr = to_ndbr(nsblk);
 	unsigned int len = nsblk_meta_size(nsblk);
@@ -91,7 +91,7 @@ static int nd_blk_rw_integrity(struct nd_namespace_blk *nsblk,
 		cur_len = min(len, bv.bv_len);
 		iobuf = kmap_atomic(bv.bv_page);
 		err = ndbr->do_io(ndbr, dev_offset, iobuf + bv.bv_offset,
-				cur_len, rw);
+				  cur_len, rw);
 		kunmap_atomic(iobuf);
 		if (err)
 			return err;
@@ -107,15 +107,15 @@ static int nd_blk_rw_integrity(struct nd_namespace_blk *nsblk,
 
 #else /* CONFIG_BLK_DEV_INTEGRITY */
 static int nd_blk_rw_integrity(struct nd_namespace_blk *nsblk,
-		struct bio_integrity_payload *bip, u64 lba, int rw)
+			       struct bio_integrity_payload *bip, u64 lba, int rw)
 {
 	return 0;
 }
 #endif
 
 static int nsblk_do_bvec(struct nd_namespace_blk *nsblk,
-		struct bio_integrity_payload *bip, struct page *page,
-		unsigned int len, unsigned int off, int rw, sector_t sector)
+			 struct bio_integrity_payload *bip, struct page *page,
+			 unsigned int len, unsigned int off, int rw, sector_t sector)
 {
 	struct nd_blk_region *ndbr = to_ndbr(nsblk);
 	resource_size_t	dev_offset, ns_offset;
@@ -184,12 +184,12 @@ static blk_qc_t nd_blk_make_request(struct request_queue *q, struct bio *bio)
 
 		BUG_ON(len > PAGE_SIZE);
 		err = nsblk_do_bvec(nsblk, bip, bvec.bv_page, len,
-				bvec.bv_offset, rw, iter.bi_sector);
+				    bvec.bv_offset, rw, iter.bi_sector);
 		if (err) {
 			dev_dbg(&nsblk->common.dev,
-					"io error in %s sector %lld, len %d,\n",
-					(rw == READ) ? "READ" : "WRITE",
-					(unsigned long long) iter.bi_sector, len);
+				"io error in %s sector %lld, len %d,\n",
+				(rw == READ) ? "READ" : "WRITE",
+				(unsigned long long) iter.bi_sector, len);
 			bio->bi_status = errno_to_blk_status(err);
 			break;
 		}
@@ -202,8 +202,8 @@ static blk_qc_t nd_blk_make_request(struct request_queue *q, struct bio *bio)
 }
 
 static int nsblk_rw_bytes(struct nd_namespace_common *ndns,
-		resource_size_t offset, void *iobuf, size_t n, int rw,
-		unsigned long flags)
+			  resource_size_t offset, void *iobuf, size_t n, int rw,
+			  unsigned long flags)
 {
 	struct nd_namespace_blk *nsblk = to_nd_namespace_blk(&ndns->dev);
 	struct nd_blk_region *ndbr = to_ndbr(nsblk);
diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index a8d56887ec88..d3e187ac43eb 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -35,7 +35,7 @@ static u64 adjust_initial_offset(struct nd_btt *nd_btt, u64 offset)
 }
 
 static int arena_read_bytes(struct arena_info *arena, resource_size_t offset,
-		void *buf, size_t n, unsigned long flags)
+			    void *buf, size_t n, unsigned long flags)
 {
 	struct nd_btt *nd_btt = arena->nd_btt;
 	struct nd_namespace_common *ndns = nd_btt->ndns;
@@ -46,7 +46,7 @@ static int arena_read_bytes(struct arena_info *arena, resource_size_t offset,
 }
 
 static int arena_write_bytes(struct arena_info *arena, resource_size_t offset,
-		void *buf, size_t n, unsigned long flags)
+			     void *buf, size_t n, unsigned long flags)
 {
 	struct nd_btt *nd_btt = arena->nd_btt;
 	struct nd_namespace_common *ndns = nd_btt->ndns;
@@ -66,23 +66,23 @@ static int btt_info_write(struct arena_info *arena, struct btt_sb *super)
 	 * correctly, so make sure that is the case.
 	 */
 	dev_WARN_ONCE(to_dev(arena), !IS_ALIGNED(arena->infooff, 512),
-		"arena->infooff: %#llx is unaligned\n", arena->infooff);
+		      "arena->infooff: %#llx is unaligned\n", arena->infooff);
 	dev_WARN_ONCE(to_dev(arena), !IS_ALIGNED(arena->info2off, 512),
-		"arena->info2off: %#llx is unaligned\n", arena->info2off);
+		      "arena->info2off: %#llx is unaligned\n", arena->info2off);
 
 	ret = arena_write_bytes(arena, arena->info2off, super,
-			sizeof(struct btt_sb), 0);
+				sizeof(struct btt_sb), 0);
 	if (ret)
 		return ret;
 
 	return arena_write_bytes(arena, arena->infooff, super,
-			sizeof(struct btt_sb), 0);
+				 sizeof(struct btt_sb), 0);
 }
 
 static int btt_info_read(struct arena_info *arena, struct btt_sb *super)
 {
 	return arena_read_bytes(arena, arena->infooff, super,
-			sizeof(struct btt_sb), 0);
+				sizeof(struct btt_sb), 0);
 }
 
 /*
@@ -92,19 +92,19 @@ static int btt_info_read(struct arena_info *arena, struct btt_sb *super)
  *   mapping contains 'E' and 'Z' flags as desired
  */
 static int __btt_map_write(struct arena_info *arena, u32 lba, __le32 mapping,
-		unsigned long flags)
+			   unsigned long flags)
 {
 	u64 ns_off = arena->mapoff + (lba * MAP_ENT_SIZE);
 
 	if (unlikely(lba >= arena->external_nlba))
 		dev_err_ratelimited(to_dev(arena),
-			"%s: lba %#x out of range (max: %#x)\n",
-			__func__, lba, arena->external_nlba);
+				    "%s: lba %#x out of range (max: %#x)\n",
+				    __func__, lba, arena->external_nlba);
 	return arena_write_bytes(arena, ns_off, &mapping, MAP_ENT_SIZE, flags);
 }
 
 static int btt_map_write(struct arena_info *arena, u32 lba, u32 mapping,
-			u32 z_flag, u32 e_flag, unsigned long rwb_flags)
+			 u32 z_flag, u32 e_flag, unsigned long rwb_flags)
 {
 	u32 ze;
 	__le32 mapping_le;
@@ -139,7 +139,7 @@ static int btt_map_write(struct arena_info *arena, u32 lba, u32 mapping,
 		 * to avoid confusion
 		 */
 		dev_err_ratelimited(to_dev(arena),
-			"Invalid use of Z and E flags\n");
+				    "Invalid use of Z and E flags\n");
 		return -EIO;
 	}
 
@@ -157,8 +157,8 @@ static int btt_map_read(struct arena_info *arena, u32 lba, u32 *mapping,
 
 	if (unlikely(lba >= arena->external_nlba))
 		dev_err_ratelimited(to_dev(arena),
-			"%s: lba %#x out of range (max: %#x)\n",
-			__func__, lba, arena->external_nlba);
+				    "%s: lba %#x out of range (max: %#x)\n",
+				    __func__, lba, arena->external_nlba);
 
 	ret = arena_read_bytes(arena, ns_off, &in, MAP_ENT_SIZE, rwb_flags);
 	if (ret)
@@ -204,17 +204,17 @@ static int btt_map_read(struct arena_info *arena, u32 lba, u32 *mapping,
 }
 
 static int btt_log_group_read(struct arena_info *arena, u32 lane,
-			struct log_group *log)
+			      struct log_group *log)
 {
 	return arena_read_bytes(arena,
-			arena->logoff + (lane * LOG_GRP_SIZE), log,
-			LOG_GRP_SIZE, 0);
+				arena->logoff + (lane * LOG_GRP_SIZE), log,
+				LOG_GRP_SIZE, 0);
 }
 
 static struct dentry *debugfs_root;
 
 static void arena_debugfs_init(struct arena_info *a, struct dentry *parent,
-				int idx)
+			       int idx)
 {
 	char dirname[32];
 	struct dentry *d;
@@ -231,13 +231,13 @@ static void arena_debugfs_init(struct arena_info *a, struct dentry *parent,
 
 	debugfs_create_x64("size", S_IRUGO, d, &a->size);
 	debugfs_create_x64("external_lba_start", S_IRUGO, d,
-				&a->external_lba_start);
+			   &a->external_lba_start);
 	debugfs_create_x32("internal_nlba", S_IRUGO, d, &a->internal_nlba);
 	debugfs_create_u32("internal_lbasize", S_IRUGO, d,
-				&a->internal_lbasize);
+			   &a->internal_lbasize);
 	debugfs_create_x32("external_nlba", S_IRUGO, d, &a->external_nlba);
 	debugfs_create_u32("external_lbasize", S_IRUGO, d,
-				&a->external_lbasize);
+			   &a->external_lbasize);
 	debugfs_create_u32("nfree", S_IRUGO, d, &a->nfree);
 	debugfs_create_u16("version_major", S_IRUGO, d, &a->version_major);
 	debugfs_create_u16("version_minor", S_IRUGO, d, &a->version_minor);
@@ -258,7 +258,7 @@ static void btt_debugfs_init(struct btt *btt)
 	struct arena_info *arena;
 
 	btt->debugfs_dir = debugfs_create_dir(dev_name(&btt->nd_btt->dev),
-						debugfs_root);
+					      debugfs_root);
 	if (IS_ERR_OR_NULL(btt->debugfs_dir))
 		return;
 
@@ -338,9 +338,9 @@ static int btt_log_read(struct arena_info *arena, u32 lane,
 	old_ent = btt_log_get_old(arena, &log);
 	if (old_ent < 0 || old_ent > 1) {
 		dev_err(to_dev(arena),
-				"log corruption (%d): lane %d seq [%d, %d]\n",
-				old_ent, lane, log.ent[arena->log_index[0]].seq,
-				log.ent[arena->log_index[1]].seq);
+			"log corruption (%d): lane %d seq [%d, %d]\n",
+			old_ent, lane, log.ent[arena->log_index[0]].seq,
+			log.ent[arena->log_index[1]].seq);
 		/* TODO set error state? */
 		return -EIO;
 	}
@@ -359,7 +359,7 @@ static int btt_log_read(struct arena_info *arena, u32 lane,
  * btt_flog_write is the wrapper for updating the freelist elements
  */
 static int __btt_log_write(struct arena_info *arena, u32 lane,
-			u32 sub, struct log_entry *ent, unsigned long flags)
+			   u32 sub, struct log_entry *ent, unsigned long flags)
 {
 	int ret;
 	u32 group_slot = arena->log_index[sub];
@@ -380,7 +380,7 @@ static int __btt_log_write(struct arena_info *arena, u32 lane,
 }
 
 static int btt_flog_write(struct arena_info *arena, u32 lane, u32 sub,
-			struct log_entry *ent)
+			  struct log_entry *ent)
 {
 	int ret;
 
@@ -421,15 +421,15 @@ static int btt_map_init(struct arena_info *arena)
 	 * is the case.
 	 */
 	dev_WARN_ONCE(to_dev(arena), !IS_ALIGNED(arena->mapoff, 512),
-		"arena->mapoff: %#llx is unaligned\n", arena->mapoff);
+		      "arena->mapoff: %#llx is unaligned\n", arena->mapoff);
 
 	while (mapsize) {
 		size_t size = min(mapsize, chunk_size);
 
 		dev_WARN_ONCE(to_dev(arena), size < 512,
-			"chunk size: %#zx is unaligned\n", size);
+			      "chunk size: %#zx is unaligned\n", size);
 		ret = arena_write_bytes(arena, arena->mapoff + offset, zerobuf,
-				size, 0);
+					size, 0);
 		if (ret)
 			goto free;
 
@@ -438,7 +438,7 @@ static int btt_map_init(struct arena_info *arena)
 		cond_resched();
 	}
 
- free:
+free:
 	kfree(zerobuf);
 	return ret;
 }
@@ -465,15 +465,15 @@ static int btt_log_init(struct arena_info *arena)
 	 * is the case.
 	 */
 	dev_WARN_ONCE(to_dev(arena), !IS_ALIGNED(arena->logoff, 512),
-		"arena->logoff: %#llx is unaligned\n", arena->logoff);
+		      "arena->logoff: %#llx is unaligned\n", arena->logoff);
 
 	while (logsize) {
 		size_t size = min(logsize, chunk_size);
 
 		dev_WARN_ONCE(to_dev(arena), size < 512,
-			"chunk size: %#zx is unaligned\n", size);
+			      "chunk size: %#zx is unaligned\n", size);
 		ret = arena_write_bytes(arena, arena->logoff + offset, zerobuf,
-				size, 0);
+					size, 0);
 		if (ret)
 			goto free;
 
@@ -492,7 +492,7 @@ static int btt_log_init(struct arena_info *arena)
 			goto free;
 	}
 
- free:
+free:
 	kfree(zerobuf);
 	return ret;
 }
@@ -518,7 +518,7 @@ static int arena_clear_freelist_error(struct arena_info *arena, u32 lane)
 			unsigned long chunk = min(len, PAGE_SIZE);
 
 			ret = arena_write_bytes(arena, nsoff, zero_page,
-				chunk, 0);
+						chunk, 0);
 			if (ret)
 				break;
 			len -= chunk;
@@ -538,7 +538,7 @@ static int btt_freelist_init(struct arena_info *arena)
 	u32 i, map_entry, log_oldmap, log_newmap;
 
 	arena->freelist = kcalloc(arena->nfree, sizeof(struct free_entry),
-					GFP_KERNEL);
+				  GFP_KERNEL);
 	if (!arena->freelist)
 		return -ENOMEM;
 
@@ -561,12 +561,12 @@ static int btt_freelist_init(struct arena_info *arena)
 		 * the BTT read-only
 		 */
 		if (ent_e_flag(log_new.old_map) &&
-				!ent_normal(log_new.old_map)) {
+		    !ent_normal(log_new.old_map)) {
 			arena->freelist[i].has_err = 1;
 			ret = arena_clear_freelist_error(arena, i);
 			if (ret)
 				dev_err_ratelimited(to_dev(arena),
-					"Unable to clear known errors\n");
+						    "Unable to clear known errors\n");
 		}
 
 		/* This implies a newly created or untouched flog entry */
@@ -575,7 +575,7 @@ static int btt_freelist_init(struct arena_info *arena)
 
 		/* Check if map recovery is needed */
 		ret = btt_map_read(arena, le32_to_cpu(log_new.lba), &map_entry,
-				NULL, NULL, 0);
+				   NULL, NULL, 0);
 		if (ret)
 			return ret;
 
@@ -592,7 +592,7 @@ static int btt_freelist_init(struct arena_info *arena)
 			 * to complete the map write. So fix up the map.
 			 */
 			ret = btt_map_write(arena, le32_to_cpu(log_new.lba),
-					le32_to_cpu(log_new.new_map), 0, 0, 0);
+					    le32_to_cpu(log_new.new_map), 0, 0, 0);
 			if (ret)
 				return ret;
 		}
@@ -641,7 +641,7 @@ static int log_set_indices(struct arena_info *arena)
 				} else {
 					/* Skip if index has been recorded */
 					if ((next_idx == 1) &&
-						(j == log_index[0]))
+					    (j == log_index[0]))
 						continue;
 					/* valid entry, record index */
 					log_index[next_idx] = j;
@@ -732,7 +732,7 @@ static int btt_maplocks_init(struct arena_info *arena)
 	u32 i;
 
 	arena->map_locks = kcalloc(arena->nfree, sizeof(struct aligned_lock),
-				GFP_KERNEL);
+				   GFP_KERNEL);
 	if (!arena->map_locks)
 		return -ENOMEM;
 
@@ -743,7 +743,7 @@ static int btt_maplocks_init(struct arena_info *arena)
 }
 
 static struct arena_info *alloc_arena(struct btt *btt, size_t size,
-				size_t start, size_t arena_off)
+				      size_t start, size_t arena_off)
 {
 	struct arena_info *arena;
 	u64 logsize, mapsize, datasize;
@@ -763,7 +763,7 @@ static struct arena_info *alloc_arena(struct btt *btt, size_t size,
 	arena->external_lba_start = start;
 	arena->external_lbasize = btt->lbasize;
 	arena->internal_lbasize = roundup(arena->external_lbasize,
-					INT_LBASIZE_ALIGNMENT);
+					  INT_LBASIZE_ALIGNMENT);
 	arena->nfree = BTT_DEFAULT_NFREE;
 	arena->version_major = btt->nd_btt->version_major;
 	arena->version_minor = btt->nd_btt->version_minor;
@@ -780,7 +780,7 @@ static struct arena_info *alloc_arena(struct btt *btt, size_t size,
 
 	/* Calculate optimal split between map and data area */
 	arena->internal_nlba = div_u64(available - BTT_PG_SIZE,
-			arena->internal_lbasize + MAP_ENT_SIZE);
+				       arena->internal_lbasize + MAP_ENT_SIZE);
 	arena->external_nlba = arena->internal_nlba - arena->nfree;
 
 	mapsize = roundup((arena->external_nlba * MAP_ENT_SIZE), BTT_PG_SIZE);
@@ -818,7 +818,7 @@ static void free_arenas(struct btt *btt)
  * populates the corresponding arena_info struct
  */
 static void parse_arena_meta(struct arena_info *arena, struct btt_sb *super,
-				u64 arena_off)
+			     u64 arena_off)
 {
 	arena->internal_nlba = le32_to_cpu(super->internal_nlba);
 	arena->internal_lbasize = le32_to_cpu(super->internal_lbasize);
@@ -829,7 +829,7 @@ static void parse_arena_meta(struct arena_info *arena, struct btt_sb *super,
 	arena->version_minor = le16_to_cpu(super->version_minor);
 
 	arena->nextoff = (super->nextoff == 0) ? 0 : (arena_off +
-			le64_to_cpu(super->nextoff));
+						      le64_to_cpu(super->nextoff));
 	arena->infooff = arena_off;
 	arena->dataoff = arena_off + le64_to_cpu(super->dataoff);
 	arena->mapoff = arena_off + le64_to_cpu(super->mapoff);
@@ -877,7 +877,7 @@ static int discover_arenas(struct btt *btt)
 				goto out;
 			} else {
 				dev_err(to_dev(arena),
-						"Found corrupted metadata!\n");
+					"Found corrupted metadata!\n");
 				ret = -ENODEV;
 				goto out;
 			}
@@ -922,10 +922,10 @@ static int discover_arenas(struct btt *btt)
 	kfree(super);
 	return ret;
 
- out:
+out:
 	kfree(arena);
 	free_arenas(btt);
- out_super:
+out_super:
 	kfree(super);
 	return ret;
 }
@@ -1048,7 +1048,7 @@ static int btt_meta_init(struct btt *btt)
 
 	btt->init_state = INIT_READY;
 
- unlock:
+unlock:
 	mutex_unlock(&btt->init_lock);
 	return ret;
 }
@@ -1066,7 +1066,7 @@ static u32 btt_meta_size(struct btt *btt)
  * so that this range search becomes faster.
  */
 static int lba_to_arena(struct btt *btt, sector_t sector, __u32 *premap,
-				struct arena_info **arena)
+			struct arena_info **arena)
 {
 	struct arena_info *arena_list;
 	__u64 lba = div_u64(sector << SECTOR_SHIFT, btt->sector_size);
@@ -1088,7 +1088,7 @@ static int lba_to_arena(struct btt *btt, sector_t sector, __u32 *premap,
  * readability, since they index into an array of locks
  */
 static void lock_map(struct arena_info *arena, u32 premap)
-		__acquires(&arena->map_locks[idx].lock)
+	__acquires(&arena->map_locks[idx].lock)
 {
 	u32 idx = (premap * MAP_ENT_SIZE / L1_CACHE_BYTES) % arena->nfree;
 
@@ -1096,7 +1096,7 @@ static void lock_map(struct arena_info *arena, u32 premap)
 }
 
 static void unlock_map(struct arena_info *arena, u32 premap)
-		__releases(&arena->map_locks[idx].lock)
+	__releases(&arena->map_locks[idx].lock)
 {
 	u32 idx = (premap * MAP_ENT_SIZE / L1_CACHE_BYTES) % arena->nfree;
 
@@ -1104,7 +1104,7 @@ static void unlock_map(struct arena_info *arena, u32 premap)
 }
 
 static int btt_data_read(struct arena_info *arena, struct page *page,
-			unsigned int off, u32 lba, u32 len)
+			 unsigned int off, u32 lba, u32 len)
 {
 	int ret;
 	u64 nsoff = to_namespace_offset(arena, lba);
@@ -1117,7 +1117,7 @@ static int btt_data_read(struct arena_info *arena, struct page *page,
 }
 
 static int btt_data_write(struct arena_info *arena, u32 lba,
-			struct page *page, unsigned int off, u32 len)
+			  struct page *page, unsigned int off, u32 len)
 {
 	int ret;
 	u64 nsoff = to_namespace_offset(arena, lba);
@@ -1139,7 +1139,7 @@ static void zero_fill_data(struct page *page, unsigned int off, u32 len)
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 static int btt_rw_integrity(struct btt *btt, struct bio_integrity_payload *bip,
-			struct arena_info *arena, u32 postmap, int rw)
+			    struct arena_info *arena, u32 postmap, int rw)
 {
 	unsigned int len = btt_meta_size(btt);
 	u64 meta_nsoff;
@@ -1166,12 +1166,12 @@ static int btt_rw_integrity(struct btt *btt, struct bio_integrity_payload *bip,
 		mem = kmap_atomic(bv.bv_page);
 		if (rw)
 			ret = arena_write_bytes(arena, meta_nsoff,
-					mem + bv.bv_offset, cur_len,
-					NVDIMM_IO_ATOMIC);
+						mem + bv.bv_offset, cur_len,
+						NVDIMM_IO_ATOMIC);
 		else
 			ret = arena_read_bytes(arena, meta_nsoff,
-					mem + bv.bv_offset, cur_len,
-					NVDIMM_IO_ATOMIC);
+					       mem + bv.bv_offset, cur_len,
+					       NVDIMM_IO_ATOMIC);
 
 		kunmap_atomic(mem);
 		if (ret)
@@ -1188,15 +1188,15 @@ static int btt_rw_integrity(struct btt *btt, struct bio_integrity_payload *bip,
 
 #else /* CONFIG_BLK_DEV_INTEGRITY */
 static int btt_rw_integrity(struct btt *btt, struct bio_integrity_payload *bip,
-			struct arena_info *arena, u32 postmap, int rw)
+			    struct arena_info *arena, u32 postmap, int rw)
 {
 	return 0;
 }
 #endif
 
 static int btt_read_pg(struct btt *btt, struct bio_integrity_payload *bip,
-			struct page *page, unsigned int off, sector_t sector,
-			unsigned int len)
+		       struct page *page, unsigned int off, sector_t sector,
+		       unsigned int len)
 {
 	int ret = 0;
 	int t_flag, e_flag;
@@ -1215,7 +1215,7 @@ static int btt_read_pg(struct btt *btt, struct bio_integrity_payload *bip,
 		cur_len = min(btt->sector_size, len);
 
 		ret = btt_map_read(arena, premap, &postmap, &t_flag, &e_flag,
-				NVDIMM_IO_ATOMIC);
+				   NVDIMM_IO_ATOMIC);
 		if (ret)
 			goto out_lane;
 
@@ -1246,12 +1246,12 @@ static int btt_read_pg(struct btt *btt, struct bio_integrity_payload *bip,
 			barrier();
 
 			ret = btt_map_read(arena, premap, &new_map, &new_t,
-						&new_e, NVDIMM_IO_ATOMIC);
+					   &new_e, NVDIMM_IO_ATOMIC);
 			if (ret)
 				goto out_rtt;
 
 			if ((postmap == new_map) && (t_flag == new_t) &&
-					(e_flag == new_e))
+			    (e_flag == new_e))
 				break;
 
 			postmap = new_map;
@@ -1265,7 +1265,7 @@ static int btt_read_pg(struct btt *btt, struct bio_integrity_payload *bip,
 
 			/* Media error - set the e_flag */
 			rc = btt_map_write(arena, premap, postmap, 0, 1,
-				NVDIMM_IO_ATOMIC);
+					   NVDIMM_IO_ATOMIC);
 			goto out_rtt;
 		}
 
@@ -1285,9 +1285,9 @@ static int btt_read_pg(struct btt *btt, struct bio_integrity_payload *bip,
 
 	return 0;
 
- out_rtt:
+out_rtt:
 	arena->rtt[lane] = RTT_INVALID;
- out_lane:
+out_lane:
 	nd_region_release_lane(btt->nd_region, lane);
 	return ret;
 }
@@ -1298,10 +1298,10 @@ static int btt_read_pg(struct btt *btt, struct bio_integrity_payload *bip,
  * we need the final, raw namespace offset here
  */
 static bool btt_is_badblock(struct btt *btt, struct arena_info *arena,
-		u32 postmap)
+			    u32 postmap)
 {
 	u64 nsoff = adjust_initial_offset(arena->nd_btt,
-			to_namespace_offset(arena, postmap));
+					  to_namespace_offset(arena, postmap));
 	sector_t phys_sector = nsoff >> 9;
 
 	return is_bad_pmem(btt->phys_bb, phys_sector, arena->internal_lbasize);
@@ -1321,7 +1321,7 @@ static int btt_write_pg(struct btt *btt, struct bio_integrity_payload *bip,
 		u32 cur_len;
 		int e_flag;
 
- retry:
+	retry:
 		lane = nd_region_acquire_lane(btt->nd_region);
 
 		ret = lba_to_arena(btt, sector, &premap, &arena);
@@ -1338,7 +1338,7 @@ static int btt_write_pg(struct btt *btt, struct bio_integrity_payload *bip,
 			arena->freelist[lane].has_err = 1;
 
 		if (mutex_is_locked(&arena->err_lock)
-				|| arena->freelist[lane].has_err) {
+		    || arena->freelist[lane].has_err) {
 			nd_region_release_lane(btt->nd_region, lane);
 
 			ret = arena_clear_freelist_error(arena, lane);
@@ -1368,14 +1368,14 @@ static int btt_write_pg(struct btt *btt, struct bio_integrity_payload *bip,
 
 		if (bip) {
 			ret = btt_rw_integrity(btt, bip, arena, new_postmap,
-						WRITE);
+					       WRITE);
 			if (ret)
 				goto out_lane;
 		}
 
 		lock_map(arena, premap);
 		ret = btt_map_read(arena, premap, &old_postmap, NULL, &e_flag,
-				NVDIMM_IO_ATOMIC);
+				   NVDIMM_IO_ATOMIC);
 		if (ret)
 			goto out_map;
 		if (old_postmap >= arena->internal_nlba) {
@@ -1395,7 +1395,7 @@ static int btt_write_pg(struct btt *btt, struct bio_integrity_payload *bip,
 			goto out_map;
 
 		ret = btt_map_write(arena, premap, new_postmap, 0, 0,
-			NVDIMM_IO_ATOMIC);
+				    NVDIMM_IO_ATOMIC);
 		if (ret)
 			goto out_map;
 
@@ -1415,16 +1415,16 @@ static int btt_write_pg(struct btt *btt, struct bio_integrity_payload *bip,
 
 	return 0;
 
- out_map:
+out_map:
 	unlock_map(arena, premap);
- out_lane:
+out_lane:
 	nd_region_release_lane(btt->nd_region, lane);
 	return ret;
 }
 
 static int btt_do_bvec(struct btt *btt, struct bio_integrity_payload *bip,
-			struct page *page, unsigned int len, unsigned int off,
-			unsigned int op, sector_t sector)
+		       struct page *page, unsigned int len, unsigned int off,
+		       unsigned int op, sector_t sector)
 {
 	int ret;
 
@@ -1457,9 +1457,9 @@ static blk_qc_t btt_make_request(struct request_queue *q, struct bio *bio)
 		unsigned int len = bvec.bv_len;
 
 		if (len > PAGE_SIZE || len < btt->sector_size ||
-				len % btt->sector_size) {
+		    len % btt->sector_size) {
 			dev_err_ratelimited(&btt->nd_btt->dev,
-				"unaligned bio segment (len: %d)\n", len);
+					    "unaligned bio segment (len: %d)\n", len);
 			bio->bi_status = BLK_STS_IOERR;
 			break;
 		}
@@ -1468,10 +1468,10 @@ static blk_qc_t btt_make_request(struct request_queue *q, struct bio *bio)
 				  bio_op(bio), iter.bi_sector);
 		if (err) {
 			dev_err(&btt->nd_btt->dev,
-					"io error in %s sector %lld, len %d,\n",
-					(op_is_write(bio_op(bio))) ? "WRITE" :
-					"READ",
-					(unsigned long long) iter.bi_sector, len);
+				"io error in %s sector %lld, len %d,\n",
+				(op_is_write(bio_op(bio))) ? "WRITE" :
+				"READ",
+				(unsigned long long) iter.bi_sector, len);
 			bio->bi_status = errno_to_blk_status(err);
 			break;
 		}
@@ -1484,7 +1484,7 @@ static blk_qc_t btt_make_request(struct request_queue *q, struct bio *bio)
 }
 
 static int btt_rw_page(struct block_device *bdev, sector_t sector,
-		struct page *page, unsigned int op)
+		       struct page *page, unsigned int op)
 {
 	struct btt *btt = bdev->bd_disk->private_data;
 	int rc;
@@ -1538,7 +1538,7 @@ static int btt_blk_init(struct btt *btt)
 	btt->btt_disk->queue = btt->btt_queue;
 	btt->btt_disk->flags = GENHD_FL_EXT_DEVT;
 	btt->btt_disk->queue->backing_dev_info->capabilities |=
-			BDI_CAP_SYNCHRONOUS_IO;
+		BDI_CAP_SYNCHRONOUS_IO;
 
 	blk_queue_make_request(btt->btt_queue, btt_make_request);
 	blk_queue_logical_block_size(btt->btt_queue, btt->sector_size);
@@ -1589,7 +1589,7 @@ static void btt_blk_cleanup(struct btt *btt)
  * Pointer to a new struct btt on success, NULL on failure.
  */
 static struct btt *btt_init(struct nd_btt *nd_btt, unsigned long long rawsize,
-		u32 lbasize, u8 *uuid, struct nd_region *nd_region)
+			    u32 lbasize, u8 *uuid, struct nd_region *nd_region)
 {
 	int ret;
 	struct btt *btt;
@@ -1618,13 +1618,13 @@ static struct btt *btt_init(struct nd_btt *nd_btt, unsigned long long rawsize,
 
 	if (btt->init_state != INIT_READY && nd_region->ro) {
 		dev_warn(dev, "%s is read-only, unable to init btt metadata\n",
-				dev_name(&nd_region->dev));
+			 dev_name(&nd_region->dev));
 		return NULL;
 	} else if (btt->init_state != INIT_READY) {
 		btt->num_arenas = (rawsize / ARENA_MAX_SIZE) +
 			((rawsize % ARENA_MAX_SIZE) ? 1 : 0);
 		dev_dbg(dev, "init: %d arenas for %llu rawsize\n",
-				btt->num_arenas, rawsize);
+			btt->num_arenas, rawsize);
 
 		ret = create_arenas(btt);
 		if (ret) {
@@ -1696,13 +1696,13 @@ int nvdimm_namespace_attach_btt(struct nd_namespace_common *ndns)
 	rawsize = nvdimm_namespace_capacity(ndns) - nd_btt->initial_offset;
 	if (rawsize < ARENA_MIN_SIZE) {
 		dev_dbg(&nd_btt->dev, "%s must be at least %ld bytes\n",
-				dev_name(&ndns->dev),
-				ARENA_MIN_SIZE + nd_btt->initial_offset);
+			dev_name(&ndns->dev),
+			ARENA_MIN_SIZE + nd_btt->initial_offset);
 		return -ENXIO;
 	}
 	nd_region = to_nd_region(nd_btt->dev.parent);
 	btt = btt_init(nd_btt, rawsize, nd_btt->lbasize, nd_btt->uuid,
-			nd_region);
+		       nd_region);
 	if (!btt)
 		return -ENOMEM;
 	nd_btt->btt = btt;
diff --git a/drivers/nvdimm/btt.h b/drivers/nvdimm/btt.h
index 2e258bee7db2..1da76da3e159 100644
--- a/drivers/nvdimm/btt.h
+++ b/drivers/nvdimm/btt.h
@@ -235,6 +235,6 @@ struct btt {
 
 bool nd_btt_arena_is_valid(struct nd_btt *nd_btt, struct btt_sb *super);
 int nd_btt_version(struct nd_btt *nd_btt, struct nd_namespace_common *ndns,
-		struct btt_sb *btt_sb);
+		   struct btt_sb *btt_sb);
 
 #endif
diff --git a/drivers/nvdimm/btt_devs.c b/drivers/nvdimm/btt_devs.c
index 3508a79110c7..9c4cbda834be 100644
--- a/drivers/nvdimm/btt_devs.c
+++ b/drivers/nvdimm/btt_devs.c
@@ -46,10 +46,10 @@ struct nd_btt *to_nd_btt(struct device *dev)
 EXPORT_SYMBOL(to_nd_btt);
 
 static const unsigned long btt_lbasize_supported[] = { 512, 520, 528,
-	4096, 4104, 4160, 4224, 0 };
+						       4096, 4104, 4160, 4224, 0 };
 
 static ssize_t sector_size_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+				struct device_attribute *attr, char *buf)
 {
 	struct nd_btt *nd_btt = to_nd_btt(dev);
 
@@ -57,7 +57,7 @@ static ssize_t sector_size_show(struct device *dev,
 }
 
 static ssize_t sector_size_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
+				 struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct nd_btt *nd_btt = to_nd_btt(dev);
 	ssize_t rc;
@@ -65,9 +65,9 @@ static ssize_t sector_size_store(struct device *dev,
 	nd_device_lock(dev);
 	nvdimm_bus_lock(dev);
 	rc = nd_size_select_store(dev, buf, &nd_btt->lbasize,
-			btt_lbasize_supported);
+				  btt_lbasize_supported);
 	dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
-			buf[len - 1] == '\n' ? "" : "\n");
+		buf[len - 1] == '\n' ? "" : "\n");
 	nvdimm_bus_unlock(dev);
 	nd_device_unlock(dev);
 
@@ -76,7 +76,7 @@ static ssize_t sector_size_store(struct device *dev,
 static DEVICE_ATTR_RW(sector_size);
 
 static ssize_t uuid_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			 struct device_attribute *attr, char *buf)
 {
 	struct nd_btt *nd_btt = to_nd_btt(dev);
 
@@ -86,7 +86,7 @@ static ssize_t uuid_show(struct device *dev,
 }
 
 static ssize_t uuid_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
+			  struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct nd_btt *nd_btt = to_nd_btt(dev);
 	ssize_t rc;
@@ -94,7 +94,7 @@ static ssize_t uuid_store(struct device *dev,
 	nd_device_lock(dev);
 	rc = nd_uuid_store(dev, &nd_btt->uuid, buf, len);
 	dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
-			buf[len - 1] == '\n' ? "" : "\n");
+		buf[len - 1] == '\n' ? "" : "\n");
 	nd_device_unlock(dev);
 
 	return rc ? rc : len;
@@ -102,20 +102,20 @@ static ssize_t uuid_store(struct device *dev,
 static DEVICE_ATTR_RW(uuid);
 
 static ssize_t namespace_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			      struct device_attribute *attr, char *buf)
 {
 	struct nd_btt *nd_btt = to_nd_btt(dev);
 	ssize_t rc;
 
 	nvdimm_bus_lock(dev);
 	rc = sprintf(buf, "%s\n", nd_btt->ndns
-			? dev_name(&nd_btt->ndns->dev) : "");
+		     ? dev_name(&nd_btt->ndns->dev) : "");
 	nvdimm_bus_unlock(dev);
 	return rc;
 }
 
 static ssize_t namespace_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
+			       struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct nd_btt *nd_btt = to_nd_btt(dev);
 	ssize_t rc;
@@ -124,7 +124,7 @@ static ssize_t namespace_store(struct device *dev,
 	nvdimm_bus_lock(dev);
 	rc = nd_namespace_store(dev, &nd_btt->ndns, buf, len);
 	dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
-			buf[len - 1] == '\n' ? "" : "\n");
+		buf[len - 1] == '\n' ? "" : "\n");
 	nvdimm_bus_unlock(dev);
 	nd_device_unlock(dev);
 
@@ -133,7 +133,7 @@ static ssize_t namespace_store(struct device *dev,
 static DEVICE_ATTR_RW(namespace);
 
 static ssize_t size_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			 struct device_attribute *attr, char *buf)
 {
 	struct nd_btt *nd_btt = to_nd_btt(dev);
 	ssize_t rc;
@@ -152,7 +152,7 @@ static ssize_t size_show(struct device *dev,
 static DEVICE_ATTR_RO(size);
 
 static ssize_t log_zero_flags_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+				   struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "Y\n");
 }
@@ -179,8 +179,8 @@ static const struct attribute_group *nd_btt_attribute_groups[] = {
 };
 
 static struct device *__nd_btt_create(struct nd_region *nd_region,
-		unsigned long lbasize, u8 *uuid,
-		struct nd_namespace_common *ndns)
+				      unsigned long lbasize, u8 *uuid,
+				      struct nd_namespace_common *ndns)
 {
 	struct nd_btt *nd_btt;
 	struct device *dev;
@@ -208,7 +208,7 @@ static struct device *__nd_btt_create(struct nd_region *nd_region,
 	device_initialize(&nd_btt->dev);
 	if (ndns && !__nd_attach_ndns(&nd_btt->dev, ndns, &nd_btt->ndns)) {
 		dev_dbg(&ndns->dev, "failed, already claimed by %s\n",
-				dev_name(ndns->claim));
+			dev_name(ndns->claim));
 		put_device(dev);
 		return NULL;
 	}
@@ -269,7 +269,7 @@ bool nd_btt_arena_is_valid(struct nd_btt *nd_btt, struct btt_sb *super)
 EXPORT_SYMBOL(nd_btt_arena_is_valid);
 
 int nd_btt_version(struct nd_btt *nd_btt, struct nd_namespace_common *ndns,
-		struct btt_sb *btt_sb)
+		   struct btt_sb *btt_sb)
 {
 	if (ndns->claim_class == NVDIMM_CCLASS_BTT2) {
 		/* Probe/setup for BTT v2.0 */
@@ -281,7 +281,7 @@ int nd_btt_version(struct nd_btt *nd_btt, struct nd_namespace_common *ndns,
 		if (!nd_btt_arena_is_valid(nd_btt, btt_sb))
 			return -ENODEV;
 		if ((le16_to_cpu(btt_sb->version_major) != 2) ||
-				(le16_to_cpu(btt_sb->version_minor) != 0))
+		    (le16_to_cpu(btt_sb->version_minor) != 0))
 			return -ENODEV;
 	} else {
 		/*
@@ -296,7 +296,7 @@ int nd_btt_version(struct nd_btt *nd_btt, struct nd_namespace_common *ndns,
 		if (!nd_btt_arena_is_valid(nd_btt, btt_sb))
 			return -ENODEV;
 		if ((le16_to_cpu(btt_sb->version_major) != 1) ||
-				(le16_to_cpu(btt_sb->version_minor) != 1))
+		    (le16_to_cpu(btt_sb->version_minor) != 1))
 			return -ENODEV;
 	}
 	return 0;
@@ -304,7 +304,7 @@ int nd_btt_version(struct nd_btt *nd_btt, struct nd_namespace_common *ndns,
 EXPORT_SYMBOL(nd_btt_version);
 
 static int __nd_btt_probe(struct nd_btt *nd_btt,
-		struct nd_namespace_common *ndns, struct btt_sb *btt_sb)
+			  struct nd_namespace_common *ndns, struct btt_sb *btt_sb)
 {
 	int rc;
 
diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 29479d3b01b0..83b6fcbb252d 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -48,7 +48,7 @@ static int to_nd_device_type(struct device *dev)
 static int nvdimm_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	return add_uevent_var(env, "MODALIAS=" ND_DEVICE_MODALIAS_FMT,
-			to_nd_device_type(dev));
+			      to_nd_device_type(dev));
 }
 
 static struct module *to_bus_provider(struct device *dev)
@@ -88,7 +88,7 @@ static int nvdimm_bus_probe(struct device *dev)
 		return -ENXIO;
 
 	dev_dbg(&nvdimm_bus->dev, "START: %s.probe(%s)\n",
-			dev->driver->name, dev_name(dev));
+		dev->driver->name, dev_name(dev));
 
 	nvdimm_bus_probe_start(nvdimm_bus);
 	debug_nvdimm_lock(dev);
@@ -102,7 +102,7 @@ static int nvdimm_bus_probe(struct device *dev)
 	nvdimm_bus_probe_end(nvdimm_bus);
 
 	dev_dbg(&nvdimm_bus->dev, "END: %s.probe(%s) = %d\n", dev->driver->name,
-			dev_name(dev), rc);
+		dev_name(dev), rc);
 
 	if (rc != 0)
 		module_put(provider);
@@ -124,7 +124,7 @@ static int nvdimm_bus_remove(struct device *dev)
 	nd_region_disable(nvdimm_bus, dev);
 
 	dev_dbg(&nvdimm_bus->dev, "%s.remove(%s) = %d\n", dev->driver->name,
-			dev_name(dev), rc);
+		dev_name(dev), rc);
 	module_put(provider);
 	return rc;
 }
@@ -140,7 +140,7 @@ static void nvdimm_bus_shutdown(struct device *dev)
 	if (nd_drv && nd_drv->shutdown) {
 		nd_drv->shutdown(dev);
 		dev_dbg(&nvdimm_bus->dev, "%s.shutdown(%s)\n",
-				dev->driver->name, dev_name(dev));
+			dev->driver->name, dev_name(dev));
 	}
 }
 
@@ -190,7 +190,7 @@ static int nvdimm_clear_badblocks_region(struct device *dev, void *data)
 
 	/* make sure we are in the region */
 	if (ctx->phys < nd_region->ndr_start
-			|| (ctx->phys + ctx->cleared) > ndr_end)
+	    || (ctx->phys + ctx->cleared) > ndr_end)
 		return 0;
 
 	sector = (ctx->phys - nd_region->ndr_start) / 512;
@@ -203,7 +203,7 @@ static int nvdimm_clear_badblocks_region(struct device *dev, void *data)
 }
 
 static void nvdimm_clear_badblocks_regions(struct nvdimm_bus *nvdimm_bus,
-		phys_addr_t phys, u64 cleared)
+					   phys_addr_t phys, u64 cleared)
 {
 	struct clear_badblocks_context ctx = {
 		.phys = phys,
@@ -211,11 +211,11 @@ static void nvdimm_clear_badblocks_regions(struct nvdimm_bus *nvdimm_bus,
 	};
 
 	device_for_each_child(&nvdimm_bus->dev, &ctx,
-			nvdimm_clear_badblocks_region);
+			      nvdimm_clear_badblocks_region);
 }
 
 static void nvdimm_account_cleared_poison(struct nvdimm_bus *nvdimm_bus,
-		phys_addr_t phys, u64 cleared)
+					  phys_addr_t phys, u64 cleared)
 {
 	if (cleared > 0)
 		badrange_forget(&nvdimm_bus->badrange, phys, cleared);
@@ -225,7 +225,7 @@ static void nvdimm_account_cleared_poison(struct nvdimm_bus *nvdimm_bus,
 }
 
 long nvdimm_clear_poison(struct device *dev, phys_addr_t phys,
-		unsigned int len)
+			 unsigned int len)
 {
 	struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(dev);
 	struct nvdimm_bus_descriptor *nd_desc;
@@ -251,7 +251,7 @@ long nvdimm_clear_poison(struct device *dev, phys_addr_t phys,
 	ars_cap.length = len;
 	noio_flag = memalloc_noio_save();
 	rc = nd_desc->ndctl(nd_desc, NULL, ND_CMD_ARS_CAP, &ars_cap,
-			sizeof(ars_cap), &cmd_rc);
+			    sizeof(ars_cap), &cmd_rc);
 	memalloc_noio_restore(noio_flag);
 	if (rc < 0)
 		return rc;
@@ -269,7 +269,7 @@ long nvdimm_clear_poison(struct device *dev, phys_addr_t phys,
 	clear_err.length = len;
 	noio_flag = memalloc_noio_save();
 	rc = nd_desc->ndctl(nd_desc, NULL, ND_CMD_CLEAR_ERROR, &clear_err,
-			sizeof(clear_err), &cmd_rc);
+			    sizeof(clear_err), &cmd_rc);
 	memalloc_noio_restore(noio_flag);
 	if (rc < 0)
 		return rc;
@@ -337,7 +337,7 @@ struct nvdimm_bus *nvdimm_to_bus(struct nvdimm *nvdimm)
 EXPORT_SYMBOL_GPL(nvdimm_to_bus);
 
 struct nvdimm_bus *nvdimm_bus_register(struct device *parent,
-		struct nvdimm_bus_descriptor *nd_desc)
+				       struct nvdimm_bus_descriptor *nd_desc)
 {
 	struct nvdimm_bus *nvdimm_bus;
 	int rc;
@@ -369,7 +369,7 @@ struct nvdimm_bus *nvdimm_bus_register(struct device *parent,
 	}
 
 	return nvdimm_bus;
- err:
+err:
 	put_device(&nvdimm_bus->dev);
 	return NULL;
 }
@@ -433,7 +433,7 @@ static int nd_bus_remove(struct device *dev)
 	mutex_unlock(&nvdimm_bus_list_mutex);
 
 	wait_event(nvdimm_bus->wait,
-			atomic_read(&nvdimm_bus->ioctl_active) == 0);
+		   atomic_read(&nvdimm_bus->ioctl_active) == 0);
 
 	nd_synchronize();
 	device_for_each_child(&nvdimm_bus->dev, NULL, child_unregister);
@@ -571,7 +571,7 @@ void nd_device_unregister(struct device *dev, enum nd_async_mode mode)
 
 		get_device(dev);
 		async_schedule_domain(nd_async_device_unregister, dev,
-				&nd_async_domain);
+				      &nd_async_domain);
 		break;
 	case ND_SYNC:
 		/*
@@ -602,13 +602,13 @@ EXPORT_SYMBOL(nd_device_unregister);
  * @mod_name: automatically set by nd_driver_register() macro
  */
 int __nd_driver_register(struct nd_device_driver *nd_drv, struct module *owner,
-		const char *mod_name)
+			 const char *mod_name)
 {
 	struct device_driver *drv = &nd_drv->drv;
 
 	if (!nd_drv->type) {
 		pr_debug("driver type bitmask not set (%ps)\n",
-				__builtin_return_address(0));
+			 __builtin_return_address(0));
 		return -EINVAL;
 	}
 
@@ -639,7 +639,7 @@ int nvdimm_revalidate_disk(struct gendisk *disk)
 		return 0;
 
 	dev_info(dev, "%s read-only, marking %s read-only\n",
-			dev_name(&nd_region->dev), disk->disk_name);
+		 dev_name(&nd_region->dev), disk->disk_name);
 	set_disk_ro(disk, 1);
 
 	return 0;
@@ -648,15 +648,15 @@ int nvdimm_revalidate_disk(struct gendisk *disk)
 EXPORT_SYMBOL(nvdimm_revalidate_disk);
 
 static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
-		char *buf)
+			     char *buf)
 {
 	return sprintf(buf, ND_DEVICE_MODALIAS_FMT "\n",
-			to_nd_device_type(dev));
+		       to_nd_device_type(dev));
 }
 static DEVICE_ATTR_RO(modalias);
 
 static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
-		char *buf)
+			    char *buf)
 {
 	return sprintf(buf, "%s\n", dev->type->name);
 }
@@ -677,7 +677,7 @@ struct attribute_group nd_device_attribute_group = {
 EXPORT_SYMBOL_GPL(nd_device_attribute_group);
 
 static ssize_t numa_node_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			      struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%d\n", dev_to_node(dev));
 }
@@ -689,7 +689,7 @@ static struct attribute *nd_numa_attributes[] = {
 };
 
 static umode_t nd_numa_attr_visible(struct kobject *kobj, struct attribute *a,
-		int n)
+				    int n)
 {
 	if (!IS_ENABLED(CONFIG_NUMA))
 		return 0;
@@ -712,11 +712,11 @@ int nvdimm_bus_create_ndctl(struct nvdimm_bus *nvdimm_bus)
 	struct device *dev;
 
 	dev = device_create(nd_class, &nvdimm_bus->dev, devt, nvdimm_bus,
-			"ndctl%d", nvdimm_bus->id);
+			    "ndctl%d", nvdimm_bus->id);
 
 	if (IS_ERR(dev))
 		dev_dbg(&nvdimm_bus->dev, "failed to register ndctl%d: %ld\n",
-				nvdimm_bus->id, PTR_ERR(dev));
+			nvdimm_bus->id, PTR_ERR(dev));
 	return PTR_ERR_OR_ZERO(dev);
 }
 
@@ -818,7 +818,7 @@ const struct nd_cmd_desc *nd_cmd_bus_desc(int cmd)
 EXPORT_SYMBOL_GPL(nd_cmd_bus_desc);
 
 u32 nd_cmd_in_size(struct nvdimm *nvdimm, int cmd,
-		const struct nd_cmd_desc *desc, int idx, void *buf)
+		   const struct nd_cmd_desc *desc, int idx, void *buf)
 {
 	if (idx >= desc->in_num)
 		return UINT_MAX;
@@ -845,8 +845,8 @@ u32 nd_cmd_in_size(struct nvdimm *nvdimm, int cmd,
 EXPORT_SYMBOL_GPL(nd_cmd_in_size);
 
 u32 nd_cmd_out_size(struct nvdimm *nvdimm, int cmd,
-		const struct nd_cmd_desc *desc, int idx, const u32 *in_field,
-		const u32 *out_field, unsigned long remainder)
+		    const struct nd_cmd_desc *desc, int idx, const u32 *in_field,
+		    const u32 *out_field, unsigned long remainder)
 {
 	if (idx >= desc->out_num)
 		return UINT_MAX;
@@ -896,7 +896,7 @@ void wait_nvdimm_bus_probe_idle(struct device *dev)
 		nvdimm_bus_unlock(dev);
 		nd_device_unlock(dev);
 		wait_event(nvdimm_bus->wait,
-				nvdimm_bus->probe_active == 0);
+			   nvdimm_bus->probe_active == 0);
 		nd_device_lock(dev);
 		nvdimm_bus_lock(dev);
 	} while (true);
@@ -950,7 +950,7 @@ static int nd_ns_forget_poison_check(struct device *dev, void *data)
 
 /* set_config requires an idle interleave set */
 static int nd_cmd_clear_to_send(struct nvdimm_bus *nvdimm_bus,
-		struct nvdimm *nvdimm, unsigned int cmd, void *data)
+				struct nvdimm *nvdimm, unsigned int cmd, void *data)
 {
 	struct nvdimm_bus_descriptor *nd_desc = nvdimm_bus->nd_desc;
 
@@ -965,7 +965,7 @@ static int nd_cmd_clear_to_send(struct nvdimm_bus *nvdimm_bus,
 	/* require clear error to go through the pmem driver */
 	if (!nvdimm && cmd == ND_CMD_CLEAR_ERROR)
 		return device_for_each_child(&nvdimm_bus->dev, data,
-				nd_ns_forget_poison_check);
+					     nd_ns_forget_poison_check);
 
 	if (!nvdimm || cmd != ND_CMD_SET_CONFIG_DATA)
 		return 0;
@@ -978,7 +978,7 @@ static int nd_cmd_clear_to_send(struct nvdimm_bus *nvdimm_bus,
 }
 
 static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
-		int read_only, unsigned int ioctl_cmd, unsigned long arg)
+		      int read_only, unsigned int ioctl_cmd, unsigned long arg)
 {
 	struct nvdimm_bus_descriptor *nd_desc = nvdimm_bus->nd_desc;
 	const struct nd_cmd_desc *desc = NULL;
@@ -1013,7 +1013,7 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
 	}
 
 	if (!desc || (desc->out_num + desc->in_num == 0) ||
-			!test_bit(cmd, &cmd_mask))
+	    !test_bit(cmd, &cmd_mask))
 		return -ENOTTY;
 
 	/* fail write commands (when read-only) */
@@ -1025,8 +1025,8 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
 		case ND_CMD_CLEAR_ERROR:
 		case ND_CMD_CALL:
 			dev_dbg(dev, "'%s' command while read-only.\n",
-					nvdimm ? nvdimm_cmd_name(cmd)
-					: nvdimm_bus_cmd_name(cmd));
+				nvdimm ? nvdimm_cmd_name(cmd)
+				: nvdimm_bus_cmd_name(cmd));
 			return -EPERM;
 		default:
 			break;
@@ -1042,7 +1042,7 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
 		in_size = nd_cmd_in_size(nvdimm, cmd, desc, i, in_env);
 		if (in_size == UINT_MAX) {
 			dev_err(dev, "%s:%s unknown input size cmd: %s field: %d\n",
-					__func__, dimm_name, cmd_name, i);
+				__func__, dimm_name, cmd_name, i);
 			rc = -ENXIO;
 			goto out;
 		}
@@ -1060,8 +1060,8 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
 	if (cmd == ND_CMD_CALL) {
 		func = pkg.nd_command;
 		dev_dbg(dev, "%s, idx: %llu, in: %u, out: %u, len %llu\n",
-				dimm_name, pkg.nd_command,
-				in_len, out_len, buf_len);
+			dimm_name, pkg.nd_command,
+			in_len, out_len, buf_len);
 	}
 
 	/* process an output envelope */
@@ -1073,12 +1073,12 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
 
 	for (i = 0; i < desc->out_num; i++) {
 		u32 out_size = nd_cmd_out_size(nvdimm, cmd, desc, i,
-				(u32 *) in_env, (u32 *) out_env, 0);
+					       (u32 *) in_env, (u32 *) out_env, 0);
 		u32 copy;
 
 		if (out_size == UINT_MAX) {
 			dev_dbg(dev, "%s unknown output size cmd: %s field: %d\n",
-					dimm_name, cmd_name, i);
+				dimm_name, cmd_name, i);
 			rc = -EFAULT;
 			goto out;
 		}
@@ -1087,7 +1087,7 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
 		else
 			copy = 0;
 		if (copy && copy_from_user(&out_env[out_len],
-					p + in_len + out_len, copy)) {
+					   p + in_len + out_len, copy)) {
 			rc = -EFAULT;
 			goto out;
 		}
@@ -1097,7 +1097,7 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
 	buf_len = (u64) out_len + (u64) in_len;
 	if (buf_len > ND_IOCTL_MAX_BUFLEN) {
 		dev_dbg(dev, "%s cmd: %s buf_len: %llu > %d\n", dimm_name,
-				cmd_name, buf_len, ND_IOCTL_MAX_BUFLEN);
+			cmd_name, buf_len, ND_IOCTL_MAX_BUFLEN);
 		rc = -EINVAL;
 		goto out;
 	}
@@ -1127,7 +1127,7 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
 		struct nd_cmd_clear_error *clear_err = buf;
 
 		nvdimm_account_cleared_poison(nvdimm_bus, clear_err->address,
-				clear_err->cleared);
+					      clear_err->cleared);
 	}
 
 	if (copy_to_user(p, buf, buf_len))
@@ -1162,7 +1162,7 @@ static int match_dimm(struct device *dev, void *data)
 }
 
 static long nd_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
-		enum nd_ioctl_mode mode)
+		     enum nd_ioctl_mode mode)
 
 {
 	struct nvdimm_bus *nvdimm_bus, *found = NULL;
@@ -1177,7 +1177,7 @@ static long nd_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
 			struct device *dev;
 
 			dev = device_find_child(&nvdimm_bus->dev,
-					file->private_data, match_dimm);
+						file->private_data, match_dimm);
 			if (!dev)
 				continue;
 			nvdimm = to_nvdimm(dev);
@@ -1271,13 +1271,13 @@ int __init nvdimm_bus_init(void)
 
 	return 0;
 
- err_nd_bus:
+err_nd_bus:
 	class_destroy(nd_class);
- err_class:
+err_class:
 	unregister_chrdev(nvdimm_major, "dimmctl");
- err_dimm_chrdev:
+err_dimm_chrdev:
 	unregister_chrdev(nvdimm_bus_major, "ndctl");
- err_bus_chrdev:
+err_bus_chrdev:
 	bus_unregister(&nvdimm_bus_type);
 
 	return rc;
diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
index 2985ca949912..62f3afaa7d27 100644
--- a/drivers/nvdimm/claim.c
+++ b/drivers/nvdimm/claim.c
@@ -27,7 +27,7 @@ void __nd_detach_ndns(struct device *dev, struct nd_namespace_common **_ndns)
 }
 
 void nd_detach_ndns(struct device *dev,
-		struct nd_namespace_common **_ndns)
+		    struct nd_namespace_common **_ndns)
 {
 	struct nd_namespace_common *ndns = *_ndns;
 
@@ -41,7 +41,7 @@ void nd_detach_ndns(struct device *dev,
 }
 
 bool __nd_attach_ndns(struct device *dev, struct nd_namespace_common *attach,
-		struct nd_namespace_common **_ndns)
+		      struct nd_namespace_common **_ndns)
 {
 	struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(&attach->dev);
 
@@ -56,7 +56,7 @@ bool __nd_attach_ndns(struct device *dev, struct nd_namespace_common *attach,
 }
 
 bool nd_attach_ndns(struct device *dev, struct nd_namespace_common *attach,
-		struct nd_namespace_common **_ndns)
+		    struct nd_namespace_common **_ndns)
 {
 	bool claimed;
 
@@ -110,7 +110,7 @@ struct nd_pfn *to_nd_pfn_safe(struct device *dev)
 }
 
 static void nd_detach_and_reset(struct device *dev,
-		struct nd_namespace_common **_ndns)
+				struct nd_namespace_common **_ndns)
 {
 	/* detach the namespace and destroy / reset the device */
 	__nd_detach_ndns(dev, _ndns);
@@ -132,8 +132,8 @@ static void nd_detach_and_reset(struct device *dev,
 }
 
 ssize_t nd_namespace_store(struct device *dev,
-		struct nd_namespace_common **_ndns, const char *buf,
-		size_t len)
+			   struct nd_namespace_common **_ndns, const char *buf,
+			   size_t len)
 {
 	struct nd_namespace_common *ndns;
 	struct device *found;
@@ -162,7 +162,7 @@ ssize_t nd_namespace_store(struct device *dev,
 		goto out;
 	} else if (ndns) {
 		dev_dbg(dev, "namespace already set to: %s\n",
-				dev_name(&ndns->dev));
+			dev_name(&ndns->dev));
 		len = -EBUSY;
 		goto out;
 	}
@@ -170,7 +170,7 @@ ssize_t nd_namespace_store(struct device *dev,
 	found = device_find_child(dev->parent, name, namespace_match);
 	if (!found) {
 		dev_dbg(dev, "'%s' not found under %s\n", name,
-				dev_name(dev->parent));
+			dev_name(dev->parent));
 		len = -ENODEV;
 		goto out;
 	}
@@ -214,13 +214,13 @@ ssize_t nd_namespace_store(struct device *dev,
 	WARN_ON_ONCE(!is_nvdimm_bus_locked(dev));
 	if (!__nd_attach_ndns(dev, ndns, _ndns)) {
 		dev_dbg(dev, "%s already claimed\n",
-				dev_name(&ndns->dev));
+			dev_name(&ndns->dev));
 		len = -EBUSY;
 	}
 
- out_attach:
+out_attach:
 	put_device(&ndns->dev); /* from device_find_child */
- out:
+out:
 	kfree(name);
 	return len;
 }
@@ -249,8 +249,8 @@ u64 nd_sb_checksum(struct nd_gen_sb *nd_gen_sb)
 EXPORT_SYMBOL(nd_sb_checksum);
 
 static int nsio_rw_bytes(struct nd_namespace_common *ndns,
-		resource_size_t offset, void *buf, size_t size, int rw,
-		unsigned long flags)
+			 resource_size_t offset, void *buf, size_t size, int rw,
+			 unsigned long flags)
 {
 	struct nd_namespace_io *nsio = to_nd_namespace_io(&ndns->dev);
 	unsigned int sz_align = ALIGN(size + (offset & (512 - 1)), 512);
@@ -275,12 +275,12 @@ static int nsio_rw_bytes(struct nd_namespace_common *ndns,
 
 	if (unlikely(is_bad_pmem(&nsio->bb, sector, sz_align))) {
 		if (IS_ALIGNED(offset, 512) && IS_ALIGNED(size, 512)
-				&& !(flags & NVDIMM_IO_ATOMIC)) {
+		    && !(flags & NVDIMM_IO_ATOMIC)) {
 			long cleared;
 
 			might_sleep();
 			cleared = nvdimm_clear_poison(&ndns->dev,
-					nsio->res.start + offset, size);
+						      nsio->res.start + offset, size);
 			if (cleared < size)
 				rc = -EIO;
 			if (cleared > 0 && cleared / 512) {
@@ -307,7 +307,7 @@ int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio)
 
 	nsio->size = resource_size(res);
 	if (!devm_request_mem_region(dev, res->start, resource_size(res),
-				dev_name(&ndns->dev))) {
+				     dev_name(&ndns->dev))) {
 		dev_warn(dev, "could not reserve region %pR\n", res);
 		return -EBUSY;
 	}
@@ -316,10 +316,10 @@ int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio)
 	if (devm_init_badblocks(dev, &nsio->bb))
 		return -ENOMEM;
 	nvdimm_badblocks_populate(to_nd_region(ndns->dev.parent), &nsio->bb,
-			&nsio->res);
+				  &nsio->res);
 
 	nsio->addr = devm_memremap(dev, res->start, resource_size(res),
-			ARCH_MEMREMAP_PMEM);
+				   ARCH_MEMREMAP_PMEM);
 
 	return PTR_ERR_OR_ZERO(nsio->addr);
 }
diff --git a/drivers/nvdimm/core.c b/drivers/nvdimm/core.c
index 9204f1e9fd14..b3ff3e62d847 100644
--- a/drivers/nvdimm/core.c
+++ b/drivers/nvdimm/core.c
@@ -63,7 +63,7 @@ struct nvdimm_map {
 };
 
 static struct nvdimm_map *find_nvdimm_map(struct device *dev,
-		resource_size_t offset)
+					  resource_size_t offset)
 {
 	struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(dev);
 	struct nvdimm_map *nvdimm_map;
@@ -75,7 +75,7 @@ static struct nvdimm_map *find_nvdimm_map(struct device *dev,
 }
 
 static struct nvdimm_map *alloc_nvdimm_map(struct device *dev,
-		resource_size_t offset, size_t size, unsigned long flags)
+					   resource_size_t offset, size_t size, unsigned long flags)
 {
 	struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(dev);
 	struct nvdimm_map *nvdimm_map;
@@ -93,7 +93,7 @@ static struct nvdimm_map *alloc_nvdimm_map(struct device *dev,
 
 	if (!request_mem_region(offset, size, dev_name(&nvdimm_bus->dev))) {
 		dev_err(&nvdimm_bus->dev, "failed to request %pa + %zd for %s\n",
-				&offset, size, dev_name(dev));
+			&offset, size, dev_name(dev));
 		goto err_request_region;
 	}
 
@@ -106,14 +106,14 @@ static struct nvdimm_map *alloc_nvdimm_map(struct device *dev,
 		goto err_map;
 
 	dev_WARN_ONCE(dev, !is_nvdimm_bus_locked(dev), "%s: bus unlocked!",
-			__func__);
+		      __func__);
 	list_add(&nvdimm_map->list, &nvdimm_bus->mapping_list);
 
 	return nvdimm_map;
 
- err_map:
+err_map:
 	release_mem_region(offset, size);
- err_request_region:
+err_request_region:
 	kfree(nvdimm_map);
 	return NULL;
 }
@@ -154,7 +154,7 @@ static void nvdimm_map_put(void *data)
  * @flags: memremap flags, or, if zero, perform an ioremap instead
  */
 void *devm_nvdimm_memremap(struct device *dev, resource_size_t offset,
-		size_t size, unsigned long flags)
+			   size_t size, unsigned long flags)
 {
 	struct nvdimm_map *nvdimm_map;
 
@@ -214,7 +214,7 @@ static bool is_uuid_sep(char sep)
 }
 
 static int nd_uuid_parse(struct device *dev, u8 *uuid_out, const char *buf,
-		size_t len)
+			 size_t len)
 {
 	const char *str = buf;
 	u8 uuid[16];
@@ -223,8 +223,8 @@ static int nd_uuid_parse(struct device *dev, u8 *uuid_out, const char *buf,
 	for (i = 0; i < 16; i++) {
 		if (!isxdigit(str[0]) || !isxdigit(str[1])) {
 			dev_dbg(dev, "pos: %d buf[%zd]: %c buf[%zd]: %c\n",
-					i, str - buf, str[0],
-					str + 1 - buf, str[1]);
+				i, str - buf, str[0],
+				str + 1 - buf, str[1]);
 			return -EINVAL;
 		}
 
@@ -249,7 +249,7 @@ static int nd_uuid_parse(struct device *dev, u8 *uuid_out, const char *buf,
  * LOCKING: expects nd_device_lock() is held on entry
  */
 int nd_uuid_store(struct device *dev, u8 **uuid_out, const char *buf,
-		size_t len)
+		  size_t len)
 {
 	u8 uuid[16];
 	int rc;
@@ -270,7 +270,7 @@ int nd_uuid_store(struct device *dev, u8 **uuid_out, const char *buf,
 }
 
 ssize_t nd_size_select_show(unsigned long current_size,
-		const unsigned long *supported, char *buf)
+			    const unsigned long *supported, char *buf)
 {
 	ssize_t len = 0;
 	int i;
@@ -285,7 +285,7 @@ ssize_t nd_size_select_show(unsigned long current_size,
 }
 
 ssize_t nd_size_select_store(struct device *dev, const char *buf,
-		unsigned long *current_size, const unsigned long *supported)
+			     unsigned long *current_size, const unsigned long *supported)
 {
 	unsigned long lbasize;
 	int rc, i;
@@ -310,7 +310,7 @@ ssize_t nd_size_select_store(struct device *dev, const char *buf,
 }
 
 static ssize_t commands_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			     struct device_attribute *attr, char *buf)
 {
 	int cmd, len = 0;
 	struct nvdimm_bus *nvdimm_bus = to_nvdimm_bus(dev);
@@ -337,7 +337,7 @@ static const char *nvdimm_bus_provider(struct nvdimm_bus *nvdimm_bus)
 }
 
 static ssize_t provider_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			     struct device_attribute *attr, char *buf)
 {
 	struct nvdimm_bus *nvdimm_bus = to_nvdimm_bus(dev);
 
@@ -361,7 +361,7 @@ static int flush_regions_dimms(struct device *dev, void *data)
 }
 
 static ssize_t wait_probe_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			       struct device_attribute *attr, char *buf)
 {
 	struct nvdimm_bus *nvdimm_bus = to_nvdimm_bus(dev);
 	struct nvdimm_bus_descriptor *nd_desc = nvdimm_bus->nd_desc;
@@ -442,9 +442,9 @@ static __init int libnvdimm_init(void)
 	nd_label_init();
 
 	return 0;
- err_region:
+err_region:
 	nvdimm_exit();
- err_dimm:
+err_dimm:
 	nvdimm_bus_exit();
 	return rc;
 }
diff --git a/drivers/nvdimm/dimm.c b/drivers/nvdimm/dimm.c
index 64776ed15bb3..916710ae647f 100644
--- a/drivers/nvdimm/dimm.c
+++ b/drivers/nvdimm/dimm.c
@@ -108,7 +108,7 @@ static int nvdimm_probe(struct device *dev)
 
 	return 0;
 
- err:
+err:
 	put_ndd(ndd);
 	return rc;
 }
diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index 196aa44c4936..52b00078939b 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -51,7 +51,7 @@ static int validate_dimm(struct nvdimm_drvdata *ndd)
 	rc = nvdimm_check_config_data(ndd->dev);
 	if (rc)
 		dev_dbg(ndd->dev, "%ps: %s error: %d\n",
-				__builtin_return_address(0), __func__, rc);
+			__builtin_return_address(0), __func__, rc);
 	return rc;
 }
 
@@ -76,7 +76,7 @@ int nvdimm_init_nsarea(struct nvdimm_drvdata *ndd)
 	memset(cmd, 0, sizeof(*cmd));
 	nd_desc = nvdimm_bus->nd_desc;
 	rc = nd_desc->ndctl(nd_desc, to_nvdimm(ndd->dev),
-			ND_CMD_GET_CONFIG_SIZE, cmd, sizeof(*cmd), &cmd_rc);
+			    ND_CMD_GET_CONFIG_SIZE, cmd, sizeof(*cmd), &cmd_rc);
 	if (rc < 0)
 		return rc;
 	return cmd_rc;
@@ -112,7 +112,7 @@ int nvdimm_get_config_data(struct nvdimm_drvdata *ndd, void *buf,
 		cmd_size = sizeof(*cmd) + cmd->in_length;
 
 		rc = nd_desc->ndctl(nd_desc, to_nvdimm(ndd->dev),
-				ND_CMD_GET_CONFIG_DATA, cmd, cmd_size, &cmd_rc);
+				    ND_CMD_GET_CONFIG_DATA, cmd, cmd_size, &cmd_rc);
 		if (rc < 0)
 			break;
 		if (cmd_rc < 0) {
@@ -129,7 +129,7 @@ int nvdimm_get_config_data(struct nvdimm_drvdata *ndd, void *buf,
 }
 
 int nvdimm_set_config_data(struct nvdimm_drvdata *ndd, size_t offset,
-		void *buf, size_t len)
+			   void *buf, size_t len)
 {
 	size_t max_cmd_size, buf_offset;
 	struct nd_cmd_set_config_hdr *cmd;
@@ -149,7 +149,7 @@ int nvdimm_set_config_data(struct nvdimm_drvdata *ndd, size_t offset,
 		return -ENOMEM;
 
 	for (buf_offset = 0; len; len -= cmd->in_length,
-			buf_offset += cmd->in_length) {
+		     buf_offset += cmd->in_length) {
 		size_t cmd_size;
 
 		cmd->in_offset = offset + buf_offset;
@@ -160,7 +160,7 @@ int nvdimm_set_config_data(struct nvdimm_drvdata *ndd, size_t offset,
 		cmd_size = sizeof(*cmd) + cmd->in_length + sizeof(u32);
 
 		rc = nd_desc->ndctl(nd_desc, to_nvdimm(ndd->dev),
-				ND_CMD_SET_CONFIG_DATA, cmd, cmd_size, &cmd_rc);
+				    ND_CMD_SET_CONFIG_DATA, cmd, cmd_size, &cmd_rc);
 		if (rc < 0)
 			break;
 		if (cmd_rc < 0) {
@@ -302,7 +302,7 @@ void *nvdimm_provider_data(struct nvdimm *nvdimm)
 EXPORT_SYMBOL_GPL(nvdimm_provider_data);
 
 static ssize_t commands_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			     struct device_attribute *attr, char *buf)
 {
 	struct nvdimm *nvdimm = to_nvdimm(dev);
 	int cmd, len = 0;
@@ -318,18 +318,18 @@ static ssize_t commands_show(struct device *dev,
 static DEVICE_ATTR_RO(commands);
 
 static ssize_t flags_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			  struct device_attribute *attr, char *buf)
 {
 	struct nvdimm *nvdimm = to_nvdimm(dev);
 
 	return sprintf(buf, "%s%s\n",
-			test_bit(NDD_ALIASING, &nvdimm->flags) ? "alias " : "",
-			test_bit(NDD_LOCKED, &nvdimm->flags) ? "lock " : "");
+		       test_bit(NDD_ALIASING, &nvdimm->flags) ? "alias " : "",
+		       test_bit(NDD_LOCKED, &nvdimm->flags) ? "lock " : "");
 }
 static DEVICE_ATTR_RO(flags);
 
 static ssize_t state_show(struct device *dev, struct device_attribute *attr,
-		char *buf)
+			  char *buf)
 {
 	struct nvdimm *nvdimm = to_nvdimm(dev);
 
@@ -340,12 +340,12 @@ static ssize_t state_show(struct device *dev, struct device_attribute *attr,
 	nvdimm_bus_lock(dev);
 	nvdimm_bus_unlock(dev);
 	return sprintf(buf, "%s\n", atomic_read(&nvdimm->busy)
-			? "active" : "idle");
+		       ? "active" : "idle");
 }
 static DEVICE_ATTR_RO(state);
 
 static ssize_t available_slots_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+				    struct device_attribute *attr, char *buf)
 {
 	struct nvdimm_drvdata *ndd = dev_get_drvdata(dev);
 	ssize_t rc;
@@ -368,7 +368,7 @@ static ssize_t available_slots_show(struct device *dev,
 static DEVICE_ATTR_RO(available_slots);
 
 __weak ssize_t security_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			     struct device_attribute *attr, char *buf)
 {
 	struct nvdimm *nvdimm = to_nvdimm(dev);
 
@@ -384,17 +384,17 @@ __weak ssize_t security_show(struct device *dev,
 }
 
 static ssize_t frozen_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			   struct device_attribute *attr, char *buf)
 {
 	struct nvdimm *nvdimm = to_nvdimm(dev);
 
 	return sprintf(buf, "%d\n", test_bit(NVDIMM_SECURITY_FROZEN,
-				&nvdimm->sec.flags));
+					     &nvdimm->sec.flags));
 }
 static DEVICE_ATTR_RO(frozen);
 
 static ssize_t security_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
+			      struct device_attribute *attr, const char *buf, size_t len)
 
 {
 	ssize_t rc;
@@ -438,9 +438,9 @@ static umode_t nvdimm_visible(struct kobject *kobj, struct attribute *a, int n)
 	if (a == &dev_attr_security.attr) {
 		/* Are there any state mutation ops (make writable)? */
 		if (nvdimm->sec.ops->freeze || nvdimm->sec.ops->disable
-				|| nvdimm->sec.ops->change_key
-				|| nvdimm->sec.ops->erase
-				|| nvdimm->sec.ops->overwrite)
+		    || nvdimm->sec.ops->change_key
+		    || nvdimm->sec.ops->erase
+		    || nvdimm->sec.ops->overwrite)
 			return a->mode;
 		return 0444;
 	}
@@ -457,10 +457,10 @@ struct attribute_group nvdimm_attribute_group = {
 EXPORT_SYMBOL_GPL(nvdimm_attribute_group);
 
 struct nvdimm *__nvdimm_create(struct nvdimm_bus *nvdimm_bus,
-		void *provider_data, const struct attribute_group **groups,
-		unsigned long flags, unsigned long cmd_mask, int num_flush,
-		struct resource *flush_wpq, const char *dimm_id,
-		const struct nvdimm_security_ops *sec_ops)
+			       void *provider_data, const struct attribute_group **groups,
+			       unsigned long flags, unsigned long cmd_mask, int num_flush,
+			       struct resource *flush_wpq, const char *dimm_id,
+			       const struct nvdimm_security_ops *sec_ops)
 {
 	struct nvdimm *nvdimm = kzalloc(sizeof(*nvdimm), GFP_KERNEL);
 	struct device *dev;
@@ -517,7 +517,7 @@ int nvdimm_security_setup_events(struct device *dev)
 	struct nvdimm *nvdimm = to_nvdimm(dev);
 
 	if (!nvdimm->sec.flags || !nvdimm->sec.ops
-			|| !nvdimm->sec.ops->overwrite)
+	    || !nvdimm->sec.ops->overwrite)
 		return 0;
 	nvdimm->sec.overwrite_state = sysfs_get_dirent(dev->kobj.sd, "security");
 	if (!nvdimm->sec.overwrite_state)
@@ -590,13 +590,13 @@ int alias_dpa_busy(struct device *dev, void *data)
 	 */
 	if (info->res) {
 		if (info->res->start >= nd_mapping->start
-				&& info->res->start < map_end)
+		    && info->res->start < map_end)
 			/* pass */;
 		else
 			return 0;
 	}
 
- retry:
+retry:
 	/*
 	 * Find the free dpa from the end of the last pmem allocation to
 	 * the end of the interleave-set mapping.
@@ -605,8 +605,8 @@ int alias_dpa_busy(struct device *dev, void *data)
 		if (strncmp(res->name, "pmem", 4) != 0)
 			continue;
 		if ((res->start >= blk_start && res->start < map_end)
-				|| (res->end >= blk_start
-					&& res->end <= map_end)) {
+		    || (res->end >= blk_start
+			&& res->end <= map_end)) {
 			new = max(blk_start, min(map_end + 1, res->end + 1));
 			if (new != blk_start) {
 				blk_start = new;
@@ -710,7 +710,7 @@ resource_size_t nd_pmem_max_contiguous_dpa(struct nd_region *nd_region,
  * the set can be established.
  */
 resource_size_t nd_pmem_available_dpa(struct nd_region *nd_region,
-		struct nd_mapping *nd_mapping, resource_size_t *overlap)
+				      struct nd_mapping *nd_mapping, resource_size_t *overlap)
 {
 	resource_size_t map_start, map_end, busy = 0, available, blk_start;
 	struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
@@ -756,7 +756,7 @@ resource_size_t nd_pmem_available_dpa(struct nd_region *nd_region,
 		return available - busy;
 	return 0;
 
- err:
+err:
 	nd_dbg_dpa(nd_region, ndd, res, "%s\n", reason);
 	return 0;
 }
@@ -769,8 +769,8 @@ void nvdimm_free_dpa(struct nvdimm_drvdata *ndd, struct resource *res)
 }
 
 struct resource *nvdimm_allocate_dpa(struct nvdimm_drvdata *ndd,
-		struct nd_label_id *label_id, resource_size_t start,
-		resource_size_t n)
+				     struct nd_label_id *label_id, resource_size_t start,
+				     resource_size_t n)
 {
 	char *name = kmemdup(label_id, sizeof(*label_id), GFP_KERNEL);
 	struct resource *res;
@@ -791,7 +791,7 @@ struct resource *nvdimm_allocate_dpa(struct nvdimm_drvdata *ndd,
  * @label_id: dpa resource name of the form {pmem|blk}-<human readable uuid>
  */
 resource_size_t nvdimm_allocated_dpa(struct nvdimm_drvdata *ndd,
-		struct nd_label_id *label_id)
+				     struct nd_label_id *label_id)
 {
 	resource_size_t allocated = 0;
 	struct resource *res;
diff --git a/drivers/nvdimm/e820.c b/drivers/nvdimm/e820.c
index 87f72f725e4f..adfeaf5c3c23 100644
--- a/drivers/nvdimm/e820.c
+++ b/drivers/nvdimm/e820.c
@@ -71,7 +71,7 @@ static int e820_pmem_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, nvdimm_bus);
 
 	rc = walk_iomem_res_desc(IORES_DESC_PERSISTENT_MEMORY_LEGACY,
-			IORESOURCE_MEM, 0, -1, nvdimm_bus, e820_register_one);
+				 IORESOURCE_MEM, 0, -1, nvdimm_bus, e820_register_one);
 	if (rc)
 		goto err;
 	return 0;
diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
index 73e197babc2f..ebfad5183b23 100644
--- a/drivers/nvdimm/label.c
+++ b/drivers/nvdimm/label.c
@@ -42,14 +42,14 @@ unsigned sizeof_namespace_label(struct nvdimm_drvdata *ndd)
 static size_t __sizeof_namespace_index(u32 nslot)
 {
 	return ALIGN(sizeof(struct nd_namespace_index) + DIV_ROUND_UP(nslot, 8),
-			NSINDEX_ALIGN);
+		     NSINDEX_ALIGN);
 }
 
 static int __nvdimm_num_label_slots(struct nvdimm_drvdata *ndd,
-		size_t index_size)
+				    size_t index_size)
 {
 	return (ndd->nsarea.config_size - index_size * 2) /
-			sizeof_namespace_label(ndd);
+		sizeof_namespace_label(ndd);
 }
 
 int nvdimm_num_label_slots(struct nvdimm_drvdata *ndd)
@@ -79,7 +79,7 @@ size_t sizeof_namespace_index(struct nvdimm_drvdata *ndd)
 		return size / 2;
 
 	dev_err(ndd->dev, "label area (%d) too small to host (%d byte) labels\n",
-			ndd->nsarea.config_size, sizeof_namespace_label(ndd));
+		ndd->nsarea.config_size, sizeof_namespace_label(ndd));
 	return 0;
 }
 
@@ -144,7 +144,7 @@ static int __nd_label_validate(struct nvdimm_drvdata *ndd)
 
 		if (labelsize != sizeof_namespace_label(ndd)) {
 			dev_dbg(dev, "nsindex%d labelsize %d invalid\n",
-					i, nsindex[i]->labelsize);
+				i, nsindex[i]->labelsize);
 			continue;
 		}
 
@@ -165,40 +165,40 @@ static int __nd_label_validate(struct nvdimm_drvdata *ndd)
 
 		/* sanity check the index against expected values */
 		if (__le64_to_cpu(nsindex[i]->myoff)
-				!= i * sizeof_namespace_index(ndd)) {
+		    != i * sizeof_namespace_index(ndd)) {
 			dev_dbg(dev, "nsindex%d myoff: %#llx invalid\n",
-					i, (unsigned long long)
-					__le64_to_cpu(nsindex[i]->myoff));
+				i, (unsigned long long)
+				__le64_to_cpu(nsindex[i]->myoff));
 			continue;
 		}
 		if (__le64_to_cpu(nsindex[i]->otheroff)
-				!= (!i) * sizeof_namespace_index(ndd)) {
+		    != (!i) * sizeof_namespace_index(ndd)) {
 			dev_dbg(dev, "nsindex%d otheroff: %#llx invalid\n",
-					i, (unsigned long long)
-					__le64_to_cpu(nsindex[i]->otheroff));
+				i, (unsigned long long)
+				__le64_to_cpu(nsindex[i]->otheroff));
 			continue;
 		}
 		if (__le64_to_cpu(nsindex[i]->labeloff)
-				!= 2 * sizeof_namespace_index(ndd)) {
+		    != 2 * sizeof_namespace_index(ndd)) {
 			dev_dbg(dev, "nsindex%d labeloff: %#llx invalid\n",
-					i, (unsigned long long)
-					__le64_to_cpu(nsindex[i]->labeloff));
+				i, (unsigned long long)
+				__le64_to_cpu(nsindex[i]->labeloff));
 			continue;
 		}
 
 		size = __le64_to_cpu(nsindex[i]->mysize);
 		if (size > sizeof_namespace_index(ndd)
-				|| size < sizeof(struct nd_namespace_index)) {
+		    || size < sizeof(struct nd_namespace_index)) {
 			dev_dbg(dev, "nsindex%d mysize: %#llx invalid\n", i, size);
 			continue;
 		}
 
 		nslot = __le32_to_cpu(nsindex[i]->nslot);
 		if (nslot * sizeof_namespace_label(ndd)
-				+ 2 * sizeof_namespace_index(ndd)
-				> ndd->nsarea.config_size) {
+		    + 2 * sizeof_namespace_index(ndd)
+		    > ndd->nsarea.config_size) {
 			dev_dbg(dev, "nsindex%d nslot: %u invalid, config_size: %#x\n",
-					i, nslot, ndd->nsarea.config_size);
+				i, nslot, ndd->nsarea.config_size);
 			continue;
 		}
 		valid[i] = true;
@@ -218,7 +218,7 @@ static int __nd_label_validate(struct nvdimm_drvdata *ndd)
 	default:
 		/* pick the best index... */
 		seq = best_seq(__le32_to_cpu(nsindex[0]->seq),
-				__le32_to_cpu(nsindex[1]->seq));
+			       __le32_to_cpu(nsindex[1]->seq));
 		if (seq == (__le32_to_cpu(nsindex[1]->seq) & NSINDEX_SEQ_MASK))
 			return 1;
 		else
@@ -271,7 +271,7 @@ static struct nd_namespace_label *nd_label_base(struct nvdimm_drvdata *ndd)
 }
 
 static int to_slot(struct nvdimm_drvdata *ndd,
-		struct nd_namespace_label *nd_label)
+		   struct nd_namespace_label *nd_label)
 {
 	unsigned long label, base;
 
@@ -291,9 +291,9 @@ static struct nd_namespace_label *to_label(struct nvdimm_drvdata *ndd, int slot)
 	return (struct nd_namespace_label *) label;
 }
 
-#define for_each_clear_bit_le(bit, addr, size) \
-	for ((bit) = find_next_zero_bit_le((addr), (size), 0);  \
-	     (bit) < (size);                                    \
+#define for_each_clear_bit_le(bit, addr, size)				\
+	for ((bit) = find_next_zero_bit_le((addr), (size), 0);		\
+	     (bit) < (size);						\
 	     (bit) = find_next_zero_bit_le((addr), (size), (bit) + 1))
 
 /**
@@ -305,8 +305,8 @@ static struct nd_namespace_label *to_label(struct nvdimm_drvdata *ndd, int slot)
  * @nslot: on return set to the number of slots in the label space
  */
 static bool preamble_index(struct nvdimm_drvdata *ndd, int idx,
-		struct nd_namespace_index **nsindex_out,
-		unsigned long **free, u32 *nslot)
+			   struct nd_namespace_index **nsindex_out,
+			   unsigned long **free, u32 *nslot)
 {
 	struct nd_namespace_index *nsindex;
 
@@ -326,28 +326,28 @@ char *nd_label_gen_id(struct nd_label_id *label_id, u8 *uuid, u32 flags)
 	if (!label_id || !uuid)
 		return NULL;
 	snprintf(label_id->id, ND_LABEL_ID_SIZE, "%s-%pUb",
-			flags & NSLABEL_FLAG_LOCAL ? "blk" : "pmem", uuid);
+		 flags & NSLABEL_FLAG_LOCAL ? "blk" : "pmem", uuid);
 	return label_id->id;
 }
 
 static bool preamble_current(struct nvdimm_drvdata *ndd,
-		struct nd_namespace_index **nsindex,
-		unsigned long **free, u32 *nslot)
+			     struct nd_namespace_index **nsindex,
+			     unsigned long **free, u32 *nslot)
 {
 	return preamble_index(ndd, ndd->ns_current, nsindex,
-			free, nslot);
+			      free, nslot);
 }
 
 static bool preamble_next(struct nvdimm_drvdata *ndd,
-		struct nd_namespace_index **nsindex,
-		unsigned long **free, u32 *nslot)
+			  struct nd_namespace_index **nsindex,
+			  unsigned long **free, u32 *nslot)
 {
 	return preamble_index(ndd, ndd->ns_next, nsindex,
-			free, nslot);
+			      free, nslot);
 }
 
 static bool slot_valid(struct nvdimm_drvdata *ndd,
-		struct nd_namespace_label *nd_label, u32 slot)
+		       struct nd_namespace_label *nd_label, u32 slot)
 {
 	/* check that we are written where we expect to be written */
 	if (slot != __le32_to_cpu(nd_label->slot))
@@ -355,7 +355,7 @@ static bool slot_valid(struct nvdimm_drvdata *ndd,
 
 	/* check that DPA allocations are page aligned */
 	if ((__le64_to_cpu(nd_label->dpa)
-				| __le64_to_cpu(nd_label->rawsize)) % SZ_4K)
+	     | __le64_to_cpu(nd_label->rawsize)) % SZ_4K)
 		return false;
 
 	/* check checksum */
@@ -405,8 +405,8 @@ int nd_label_reserve_dpa(struct nvdimm_drvdata *ndd)
 			flags &= ~NSLABEL_FLAG_LOCAL;
 		nd_label_gen_id(&label_id, label_uuid, flags);
 		res = nvdimm_allocate_dpa(ndd, &label_id,
-				__le64_to_cpu(nd_label->dpa),
-				__le64_to_cpu(nd_label->rawsize));
+					  __le64_to_cpu(nd_label->dpa),
+					  __le64_to_cpu(nd_label->rawsize));
 		nd_dbg_dpa(nd_region, ndd, res, "reserve\n");
 		if (!res)
 			return -EBUSY;
@@ -464,7 +464,7 @@ int nd_label_data_init(struct nvdimm_drvdata *ndd)
 	if (read_size < max_xfer) {
 		/* trim waste */
 		max_xfer -= ((max_xfer - 1) - (config_size - 1) % max_xfer) /
-			    DIV_ROUND_UP(config_size, max_xfer);
+			DIV_ROUND_UP(config_size, max_xfer);
 		/* make certain we read indexes in exactly 1 read */
 		if (max_xfer < read_size)
 			max_xfer = read_size;
@@ -516,7 +516,7 @@ int nd_label_data_init(struct nvdimm_drvdata *ndd)
 		/* determine how much more will be read after this next call. */
 		label_read_size = offset + ndd->nslabel_size - read_size;
 		label_read_size = DIV_ROUND_UP(label_read_size, max_xfer) *
-				  max_xfer;
+			max_xfer;
 
 		/* truncate last read if needed */
 		if (read_size + label_read_size > config_size)
@@ -559,7 +559,7 @@ int nd_label_active_count(struct nvdimm_drvdata *ndd)
 
 			dev_dbg(ndd->dev,
 				"slot%d invalid slot: %d dpa: %llx size: %llx\n",
-					slot, label_slot, dpa, size);
+				slot, label_slot, dpa, size);
 			continue;
 		}
 		count++;
@@ -641,7 +641,7 @@ u32 nd_label_nfree(struct nvdimm_drvdata *ndd)
 }
 
 static int nd_label_write_index(struct nvdimm_drvdata *ndd, int index, u32 seq,
-		unsigned long flags)
+				unsigned long flags)
 {
 	struct nd_namespace_index *nsindex;
 	unsigned long offset;
@@ -664,7 +664,7 @@ static int nd_label_write_index(struct nvdimm_drvdata *ndd, int index, u32 seq,
 	nsindex->myoff = __cpu_to_le64(offset);
 	nsindex->mysize = __cpu_to_le64(sizeof_namespace_index(ndd));
 	offset = (unsigned long) to_namespace_index(ndd,
-			nd_label_next_nsindex(index))
+						    nd_label_next_nsindex(index))
 		- (unsigned long) to_namespace_index(ndd, 0);
 	nsindex->otheroff = __cpu_to_le64(offset);
 	offset = (unsigned long) nd_label_base(ndd)
@@ -689,7 +689,7 @@ static int nd_label_write_index(struct nvdimm_drvdata *ndd, int index, u32 seq,
 	checksum = nd_fletcher64(nsindex, sizeof_namespace_index(ndd), 1);
 	nsindex->checksum = __cpu_to_le64(checksum);
 	rc = nvdimm_set_config_data(ndd, __le64_to_cpu(nsindex->myoff),
-			nsindex, sizeof_namespace_index(ndd));
+				    nsindex, sizeof_namespace_index(ndd));
 	if (rc < 0)
 		return rc;
 
@@ -707,7 +707,7 @@ static int nd_label_write_index(struct nvdimm_drvdata *ndd, int index, u32 seq,
 }
 
 static unsigned long nd_label_offset(struct nvdimm_drvdata *ndd,
-		struct nd_namespace_label *nd_label)
+				     struct nd_namespace_label *nd_label)
 {
 	return (unsigned long) nd_label
 		- (unsigned long) to_namespace_index(ndd, 0);
@@ -730,7 +730,7 @@ enum nvdimm_claim_class to_nvdimm_cclass(guid_t *guid)
 }
 
 static const guid_t *to_abstraction_guid(enum nvdimm_claim_class claim_class,
-	guid_t *target)
+					 guid_t *target)
 {
 	if (claim_class == NVDIMM_CCLASS_BTT)
 		return &nvdimm_btt_guid;
@@ -751,7 +751,7 @@ static const guid_t *to_abstraction_guid(enum nvdimm_claim_class claim_class,
 }
 
 static void reap_victim(struct nd_mapping *nd_mapping,
-		struct nd_label_ent *victim)
+			struct nd_label_ent *victim)
 {
 	struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
 	u32 slot = to_slot(ndd, victim->label);
@@ -762,8 +762,8 @@ static void reap_victim(struct nd_mapping *nd_mapping,
 }
 
 static int __pmem_label_update(struct nd_region *nd_region,
-		struct nd_mapping *nd_mapping, struct nd_namespace_pmem *nspm,
-		int pos, unsigned long flags)
+			       struct nd_mapping *nd_mapping, struct nd_namespace_pmem *nspm,
+			       int pos, unsigned long flags)
 {
 	struct nd_namespace_common *ndns = &nspm->nsio.common;
 	struct nd_interleave_set *nd_set = nd_region->nd_set;
@@ -816,8 +816,8 @@ static int __pmem_label_update(struct nd_region *nd_region,
 		guid_copy(&nd_label->type_guid, &nd_set->type_guid);
 	if (namespace_label_has(ndd, abstraction_guid))
 		guid_copy(&nd_label->abstraction_guid,
-				to_abstraction_guid(ndns->claim_class,
-					&nd_label->abstraction_guid));
+			  to_abstraction_guid(ndns->claim_class,
+					      &nd_label->abstraction_guid));
 	if (namespace_label_has(ndd, checksum)) {
 		u64 sum;
 
@@ -830,7 +830,7 @@ static int __pmem_label_update(struct nd_region *nd_region,
 	/* update label */
 	offset = nd_label_offset(ndd, nd_label);
 	rc = nvdimm_set_config_data(ndd, offset, nd_label,
-			sizeof_namespace_label(ndd));
+				    sizeof_namespace_label(ndd));
 	if (rc < 0)
 		return rc;
 
@@ -840,14 +840,14 @@ static int __pmem_label_update(struct nd_region *nd_region,
 		if (!label_ent->label)
 			continue;
 		if (test_and_clear_bit(ND_LABEL_REAP, &label_ent->flags)
-				|| memcmp(nspm->uuid, label_ent->label->uuid,
-					NSLABEL_UUID_LEN) == 0)
+		    || memcmp(nspm->uuid, label_ent->label->uuid,
+			      NSLABEL_UUID_LEN) == 0)
 			reap_victim(nd_mapping, label_ent);
 	}
 
 	/* update index */
 	rc = nd_label_write_index(ndd, ndd->ns_next,
-			nd_inc_seq(__le32_to_cpu(nsindex->seq)), 0);
+				  nd_inc_seq(__le32_to_cpu(nsindex->seq)), 0);
 	if (rc == 0) {
 		list_for_each_entry(label_ent, &nd_mapping->labels, list)
 			if (!label_ent->label) {
@@ -856,8 +856,8 @@ static int __pmem_label_update(struct nd_region *nd_region,
 				break;
 			}
 		dev_WARN_ONCE(&nspm->nsio.common.dev, nd_label,
-				"failed to track label: %d\n",
-				to_slot(ndd, nd_label));
+			      "failed to track label: %d\n",
+			      to_slot(ndd, nd_label));
 		if (nd_label)
 			rc = -ENXIO;
 	}
@@ -879,7 +879,7 @@ static bool is_old_resource(struct resource *res, struct resource **list, int n)
 }
 
 static struct resource *to_resource(struct nvdimm_drvdata *ndd,
-		struct nd_namespace_label *nd_label)
+				    struct nd_namespace_label *nd_label)
 {
 	struct resource *res;
 
@@ -900,8 +900,8 @@ static struct resource *to_resource(struct nvdimm_drvdata *ndd,
  * 3/ Record the resources in the namespace device
  */
 static int __blk_label_update(struct nd_region *nd_region,
-		struct nd_mapping *nd_mapping, struct nd_namespace_blk *nsblk,
-		int num_labels)
+			      struct nd_mapping *nd_mapping, struct nd_namespace_blk *nsblk,
+			      int num_labels)
 {
 	int i, alloc, victims, nfree, old_num_resources, nlabel, rc = -ENXIO;
 	struct nd_interleave_set *nd_set = nd_region->nd_set;
@@ -956,7 +956,7 @@ static int __blk_label_update(struct nd_region *nd_region,
 				continue;
 			res = to_resource(ndd, nd_label);
 			if (res && is_old_resource(res, old_res_list,
-						old_num_resources))
+						   old_num_resources))
 				continue;
 			slot = to_slot(ndd, nd_label);
 			set_bit(slot, victim_map);
@@ -1013,7 +1013,7 @@ static int __blk_label_update(struct nd_region *nd_region,
 		memcpy(nd_label->uuid, nsblk->uuid, NSLABEL_UUID_LEN);
 		if (nsblk->alt_name)
 			memcpy(nd_label->name, nsblk->alt_name,
-					NSLABEL_NAME_LEN);
+			       NSLABEL_NAME_LEN);
 		nd_label->flags = __cpu_to_le32(NSLABEL_FLAG_LOCAL);
 
 		/*
@@ -1044,22 +1044,22 @@ static int __blk_label_update(struct nd_region *nd_region,
 			guid_copy(&nd_label->type_guid, &nd_set->type_guid);
 		if (namespace_label_has(ndd, abstraction_guid))
 			guid_copy(&nd_label->abstraction_guid,
-					to_abstraction_guid(ndns->claim_class,
-						&nd_label->abstraction_guid));
+				  to_abstraction_guid(ndns->claim_class,
+						      &nd_label->abstraction_guid));
 
 		if (namespace_label_has(ndd, checksum)) {
 			u64 sum;
 
 			nd_label->checksum = __cpu_to_le64(0);
 			sum = nd_fletcher64(nd_label,
-					sizeof_namespace_label(ndd), 1);
+					    sizeof_namespace_label(ndd), 1);
 			nd_label->checksum = __cpu_to_le64(sum);
 		}
 
 		/* update label */
 		offset = nd_label_offset(ndd, nd_label);
 		rc = nvdimm_set_config_data(ndd, offset, nd_label,
-				sizeof_namespace_label(ndd));
+					    sizeof_namespace_label(ndd));
 		if (rc < 0)
 			goto abort;
 	}
@@ -1072,7 +1072,7 @@ static int __blk_label_update(struct nd_region *nd_region,
 
 	/* update index */
 	rc = nd_label_write_index(ndd, ndd->ns_next,
-			nd_inc_seq(__le32_to_cpu(nsindex->seq)), 0);
+				  nd_inc_seq(__le32_to_cpu(nsindex->seq)), 0);
 	if (rc)
 		goto abort;
 
@@ -1109,7 +1109,7 @@ static int __blk_label_update(struct nd_region *nd_region,
 
 	mutex_lock(&nd_mapping->lock);
 	label_ent = list_first_entry_or_null(&nd_mapping->labels,
-			typeof(*label_ent), list);
+					     typeof(*label_ent), list);
 	if (!label_ent) {
 		WARN_ON(1);
 		mutex_unlock(&nd_mapping->lock);
@@ -1133,16 +1133,16 @@ static int __blk_label_update(struct nd_region *nd_region,
 		}
 		if (nd_label)
 			dev_WARN(&nsblk->common.dev,
-					"failed to track label slot%d\n", slot);
+				 "failed to track label slot%d\n", slot);
 	}
 	mutex_unlock(&nd_mapping->lock);
 
- out:
+out:
 	kfree(old_res_list);
 	bitmap_free(victim_map);
 	return rc;
 
- abort:
+abort:
 	/*
 	 * 1/ repair the allocated label bitmap in the index
 	 * 2/ restore the resource list
@@ -1243,11 +1243,11 @@ static int del_labels(struct nd_mapping *nd_mapping, u8 *uuid)
 	mutex_unlock(&nd_mapping->lock);
 
 	return nd_label_write_index(ndd, ndd->ns_next,
-			nd_inc_seq(__le32_to_cpu(nsindex->seq)), 0);
+				    nd_inc_seq(__le32_to_cpu(nsindex->seq)), 0);
 }
 
 int nd_pmem_namespace_label_update(struct nd_region *nd_region,
-		struct nd_namespace_pmem *nspm, resource_size_t size)
+				   struct nd_namespace_pmem *nspm, resource_size_t size)
 {
 	int i, rc;
 
@@ -1274,7 +1274,7 @@ int nd_pmem_namespace_label_update(struct nd_region *nd_region,
 			return rc;
 
 		rc = __pmem_label_update(nd_region, nd_mapping, nspm, i,
-				NSLABEL_FLAG_UPDATING);
+					 NSLABEL_FLAG_UPDATING);
 		if (rc)
 			return rc;
 	}
@@ -1295,7 +1295,7 @@ int nd_pmem_namespace_label_update(struct nd_region *nd_region,
 }
 
 int nd_blk_namespace_label_update(struct nd_region *nd_region,
-		struct nd_namespace_blk *nsblk, resource_size_t size)
+				  struct nd_namespace_blk *nsblk, resource_size_t size)
 {
 	struct nd_mapping *nd_mapping = &nd_region->mapping[0];
 	struct resource *res;
diff --git a/drivers/nvdimm/label.h b/drivers/nvdimm/label.h
index 4c7b775c2811..aff33d09fec3 100644
--- a/drivers/nvdimm/label.h
+++ b/drivers/nvdimm/label.h
@@ -140,7 +140,7 @@ struct nd_region;
 struct nd_namespace_pmem;
 struct nd_namespace_blk;
 int nd_pmem_namespace_label_update(struct nd_region *nd_region,
-		struct nd_namespace_pmem *nspm, resource_size_t size);
+				   struct nd_namespace_pmem *nspm, resource_size_t size);
 int nd_blk_namespace_label_update(struct nd_region *nd_region,
-		struct nd_namespace_blk *nsblk, resource_size_t size);
+				  struct nd_namespace_blk *nsblk, resource_size_t size);
 #endif /* __LABEL_H__ */
diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index a16e52251a30..5ffa137dc963 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -122,7 +122,7 @@ bool nd_is_uuid_unique(struct device *dev, u8 *uuid)
 		return false;
 	WARN_ON_ONCE(!is_nvdimm_bus_locked(&nvdimm_bus->dev));
 	if (device_for_each_child(&nvdimm_bus->dev, uuid,
-				is_namespace_uuid_busy) != 0)
+				  is_namespace_uuid_busy) != 0)
 		return false;
 	return true;
 }
@@ -147,8 +147,8 @@ bool pmem_should_map_pages(struct device *dev)
 
 	nsio = to_nd_namespace_io(dev);
 	if (region_intersects(nsio->res.start, resource_size(&nsio->res),
-				IORESOURCE_SYSTEM_RAM,
-				IORES_DESC_NONE) == REGION_MIXED)
+			      IORESOURCE_SYSTEM_RAM,
+			      IORES_DESC_NONE) == REGION_MIXED)
 		return false;
 
 	return ARCH_MEMREMAP_PMEM == MEMREMAP_WB;
@@ -167,7 +167,7 @@ unsigned int pmem_sector_size(struct nd_namespace_common *ndns)
 			return 4096;
 		else
 			dev_WARN(&ndns->dev, "unsupported sector size: %ld\n",
-					nspm->lbasize);
+				 nspm->lbasize);
 	}
 
 	/*
@@ -179,7 +179,7 @@ unsigned int pmem_sector_size(struct nd_namespace_common *ndns)
 EXPORT_SYMBOL(pmem_sector_size);
 
 const char *nvdimm_namespace_disk_name(struct nd_namespace_common *ndns,
-		char *name)
+				       char *name)
 {
 	struct nd_region *nd_region = to_nd_region(ndns->dev.parent);
 	const char *suffix = NULL;
@@ -199,16 +199,16 @@ const char *nvdimm_namespace_disk_name(struct nd_namespace_common *ndns,
 
 		if (nsidx)
 			sprintf(name, "pmem%d.%d%s", nd_region->id, nsidx,
-					suffix ? suffix : "");
+				suffix ? suffix : "");
 		else
 			sprintf(name, "pmem%d%s", nd_region->id,
-					suffix ? suffix : "");
+				suffix ? suffix : "");
 	} else if (is_namespace_blk(&ndns->dev)) {
 		struct nd_namespace_blk *nsblk;
 
 		nsblk = to_nd_namespace_blk(&ndns->dev);
 		sprintf(name, "ndblk%d.%d%s", nd_region->id, nsblk->id,
-				suffix ? suffix : "");
+			suffix ? suffix : "");
 	} else {
 		return NULL;
 	}
@@ -238,7 +238,7 @@ const u8 *nd_dev_to_uuid(struct device *dev)
 EXPORT_SYMBOL(nd_dev_to_uuid);
 
 static ssize_t nstype_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			   struct device_attribute *attr, char *buf)
 {
 	struct nd_region *nd_region = to_nd_region(dev->parent);
 
@@ -247,7 +247,7 @@ static ssize_t nstype_show(struct device *dev,
 static DEVICE_ATTR_RO(nstype);
 
 static ssize_t __alt_name_store(struct device *dev, const char *buf,
-		const size_t len)
+				const size_t len)
 {
 	char *input, *pos, *alt_name, **ns_altname;
 	ssize_t rc;
@@ -369,10 +369,10 @@ EXPORT_SYMBOL(nd_namespace_blk_validate);
 
 
 static int nd_namespace_label_update(struct nd_region *nd_region,
-		struct device *dev)
+				     struct device *dev)
 {
 	dev_WARN_ONCE(dev, dev->driver || to_ndns(dev)->claim,
-			"namespace must be idle during label update\n");
+		      "namespace must be idle during label update\n");
 	if (dev->driver || to_ndns(dev)->claim)
 		return 0;
 
@@ -405,7 +405,7 @@ static int nd_namespace_label_update(struct nd_region *nd_region,
 }
 
 static ssize_t alt_name_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
+			      struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct nd_region *nd_region = to_nd_region(dev->parent);
 	ssize_t rc;
@@ -424,7 +424,7 @@ static ssize_t alt_name_store(struct device *dev,
 }
 
 static ssize_t alt_name_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			     struct device_attribute *attr, char *buf)
 {
 	char *ns_altname;
 
@@ -444,8 +444,8 @@ static ssize_t alt_name_show(struct device *dev,
 static DEVICE_ATTR_RW(alt_name);
 
 static int scan_free(struct nd_region *nd_region,
-		struct nd_mapping *nd_mapping, struct nd_label_id *label_id,
-		resource_size_t n)
+		     struct nd_mapping *nd_mapping, struct nd_label_id *label_id,
+		     resource_size_t n)
 {
 	bool is_blk = strncmp(label_id->id, "blk", 3) == 0;
 	struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
@@ -502,7 +502,7 @@ static int scan_free(struct nd_region *nd_region,
  * set.
  */
 static int shrink_dpa_allocation(struct nd_region *nd_region,
-		struct nd_label_id *label_id, resource_size_t n)
+				 struct nd_label_id *label_id, resource_size_t n)
 {
 	int i;
 
@@ -519,8 +519,8 @@ static int shrink_dpa_allocation(struct nd_region *nd_region,
 }
 
 static resource_size_t init_dpa_allocation(struct nd_label_id *label_id,
-		struct nd_region *nd_region, struct nd_mapping *nd_mapping,
-		resource_size_t n)
+					   struct nd_region *nd_region, struct nd_mapping *nd_mapping,
+					   resource_size_t n)
 {
 	bool is_blk = strncmp(label_id->id, "blk", 3) == 0;
 	struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
@@ -561,9 +561,9 @@ static resource_size_t init_dpa_allocation(struct nd_label_id *label_id,
  * exists).  If reserving PMEM any space is valid.
  */
 static void space_valid(struct nd_region *nd_region, struct nvdimm_drvdata *ndd,
-		struct nd_label_id *label_id, struct resource *prev,
-		struct resource *next, struct resource *exist,
-		resource_size_t n, struct resource *valid)
+			struct nd_label_id *label_id, struct resource *prev,
+			struct resource *next, struct resource *exist,
+			resource_size_t n, struct resource *valid)
 {
 	bool is_reserve = strcmp(label_id->id, "pmem-reserve") == 0;
 	bool is_pmem = strncmp(label_id->id, "pmem", 4) == 0;
@@ -599,10 +599,10 @@ static void space_valid(struct nd_region *nd_region, struct nvdimm_drvdata *ndd,
 
 	/* allocation needs to be contiguous with the existing namespace */
 	if (valid->start == exist->end + 1
-			|| valid->end == exist->start - 1)
+	    || valid->end == exist->start - 1)
 		return;
 
- invalid:
+invalid:
 	/* truncate @valid size to 0 */
 	valid->end = valid->start - 1;
 }
@@ -612,8 +612,8 @@ enum alloc_loc {
 };
 
 static resource_size_t scan_allocate(struct nd_region *nd_region,
-		struct nd_mapping *nd_mapping, struct nd_label_id *label_id,
-		resource_size_t n)
+				     struct nd_mapping *nd_mapping, struct nd_label_id *label_id,
+				     resource_size_t n)
 {
 	resource_size_t mapping_end = nd_mapping->start + nd_mapping->size - 1;
 	bool is_pmem = strncmp(label_id->id, "pmem", 4) == 0;
@@ -629,7 +629,7 @@ static resource_size_t scan_allocate(struct nd_region *nd_region,
 	valid.start = nd_mapping->start;
 	valid.end = mapping_end;
 	valid.name = "free space";
- retry:
+retry:
 	first = 0;
 	for_each_dpa_resource(ndd, res) {
 		struct resource *next = res->sibling, *new_res = NULL;
@@ -649,7 +649,7 @@ static resource_size_t scan_allocate(struct nd_region *nd_region,
 			valid.start = nd_mapping->start;
 			valid.end = res->start - 1;
 			space_valid(nd_region, ndd, label_id, NULL, next, exist,
-					to_allocate, &valid);
+				    to_allocate, &valid);
 			available = resource_size(&valid);
 			if (available)
 				loc = ALLOC_BEFORE;
@@ -660,7 +660,7 @@ static resource_size_t scan_allocate(struct nd_region *nd_region,
 			valid.start = res->start + resource_size(res);
 			valid.end = min(mapping_end, next->start - 1);
 			space_valid(nd_region, ndd, label_id, res, next, exist,
-					to_allocate, &valid);
+				    to_allocate, &valid);
 			available = resource_size(&valid);
 			if (available)
 				loc = ALLOC_MID;
@@ -671,7 +671,7 @@ static resource_size_t scan_allocate(struct nd_region *nd_region,
 			valid.start = res->start + resource_size(res);
 			valid.end = mapping_end;
 			space_valid(nd_region, ndd, label_id, res, next, exist,
-					to_allocate, &valid);
+				    to_allocate, &valid);
 			available = resource_size(&valid);
 			if (available)
 				loc = ALLOC_AFTER;
@@ -685,7 +685,7 @@ static resource_size_t scan_allocate(struct nd_region *nd_region,
 			if (strcmp(res->name, label_id->id) == 0) {
 				/* adjust current resource up */
 				rc = adjust_resource(res, res->start - allocate,
-						resource_size(res) + allocate);
+						     resource_size(res) + allocate);
 				action = "cur grow up";
 			} else
 				action = "allocate";
@@ -694,8 +694,8 @@ static resource_size_t scan_allocate(struct nd_region *nd_region,
 			if (strcmp(next->name, label_id->id) == 0) {
 				/* adjust next resource up */
 				rc = adjust_resource(next, next->start
-						- allocate, resource_size(next)
-						+ allocate);
+						     - allocate, resource_size(next)
+						     + allocate);
 				new_res = next;
 				action = "next grow up";
 			} else if (strcmp(res->name, label_id->id) == 0) {
@@ -719,13 +719,13 @@ static resource_size_t scan_allocate(struct nd_region *nd_region,
 				valid.start += available - allocate;
 
 			new_res = nvdimm_allocate_dpa(ndd, label_id,
-					valid.start, allocate);
+						      valid.start, allocate);
 			if (!new_res)
 				rc = -EBUSY;
 		} else if (strcmp(action, "grow down") == 0) {
 			/* adjust current resource down */
 			rc = adjust_resource(res, res->start, resource_size(res)
-					+ allocate);
+					     + allocate);
 			if (rc == 0)
 				res->flags |= DPA_RESOURCE_ADJUSTED;
 		}
@@ -734,7 +734,7 @@ static resource_size_t scan_allocate(struct nd_region *nd_region,
 			new_res = res;
 
 		nd_dbg_dpa(nd_region, ndd, new_res, "%s(%d) %d\n",
-				action, loc, rc);
+			   action, loc, rc);
 
 		if (rc)
 			return n;
@@ -764,22 +764,22 @@ static resource_size_t scan_allocate(struct nd_region *nd_region,
 }
 
 static int merge_dpa(struct nd_region *nd_region,
-		struct nd_mapping *nd_mapping, struct nd_label_id *label_id)
+		     struct nd_mapping *nd_mapping, struct nd_label_id *label_id)
 {
 	struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
 	struct resource *res;
 
 	if (strncmp("pmem", label_id->id, 4) == 0)
 		return 0;
- retry:
+retry:
 	for_each_dpa_resource(ndd, res) {
 		int rc;
 		struct resource *next = res->sibling;
 		resource_size_t end = res->start + resource_size(res);
 
 		if (!next || strcmp(res->name, label_id->id) != 0
-				|| strcmp(next->name, label_id->id) != 0
-				|| end != next->start)
+		    || strcmp(next->name, label_id->id) != 0
+		    || end != next->start)
 			continue;
 		end += resource_size(next);
 		nvdimm_free_dpa(ndd, next);
@@ -822,9 +822,9 @@ int __reserve_free_pmem(struct device *dev, void *data)
 			return 0;
 		rem = scan_allocate(nd_region, nd_mapping, &label_id, n);
 		dev_WARN_ONCE(&nd_region->dev, rem,
-				"pmem reserve underrun: %#llx of %#llx bytes\n",
-				(unsigned long long) n - rem,
-				(unsigned long long) n);
+			      "pmem reserve underrun: %#llx of %#llx bytes\n",
+			      (unsigned long long) n - rem,
+			      (unsigned long long) n);
 		return rem ? -ENXIO : 0;
 	}
 
@@ -832,7 +832,7 @@ int __reserve_free_pmem(struct device *dev, void *data)
 }
 
 void release_free_pmem(struct nvdimm_bus *nvdimm_bus,
-		struct nd_mapping *nd_mapping)
+		       struct nd_mapping *nd_mapping)
 {
 	struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
 	struct resource *res, *_res;
@@ -843,13 +843,13 @@ void release_free_pmem(struct nvdimm_bus *nvdimm_bus,
 }
 
 static int reserve_free_pmem(struct nvdimm_bus *nvdimm_bus,
-		struct nd_mapping *nd_mapping)
+			     struct nd_mapping *nd_mapping)
 {
 	struct nvdimm *nvdimm = nd_mapping->nvdimm;
 	int rc;
 
 	rc = device_for_each_child(&nvdimm_bus->dev, nvdimm,
-			__reserve_free_pmem);
+				   __reserve_free_pmem);
 	if (rc)
 		release_free_pmem(nvdimm_bus, nd_mapping);
 	return rc;
@@ -869,7 +869,7 @@ static int reserve_free_pmem(struct nvdimm_bus *nvdimm_bus,
  * first.
  */
 static int grow_dpa_allocation(struct nd_region *nd_region,
-		struct nd_label_id *label_id, resource_size_t n)
+			       struct nd_label_id *label_id, resource_size_t n)
 {
 	struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(&nd_region->dev);
 	bool is_pmem = strncmp(label_id->id, "pmem", 4) == 0;
@@ -893,7 +893,7 @@ static int grow_dpa_allocation(struct nd_region *nd_region,
 					return rc;
 			}
 			rem = scan_allocate(nd_region, nd_mapping,
-					label_id, rem);
+					    label_id, rem);
 			if (blk_only)
 				release_free_pmem(nvdimm_bus, nd_mapping);
 
@@ -903,9 +903,9 @@ static int grow_dpa_allocation(struct nd_region *nd_region,
 		}
 
 		dev_WARN_ONCE(&nd_region->dev, rem,
-				"allocation underrun: %#llx of %#llx bytes\n",
-				(unsigned long long) n - rem,
-				(unsigned long long) n);
+			      "allocation underrun: %#llx of %#llx bytes\n",
+			      (unsigned long long) n - rem,
+			      (unsigned long long) n);
 		if (rem)
 			return -ENXIO;
 
@@ -918,7 +918,7 @@ static int grow_dpa_allocation(struct nd_region *nd_region,
 }
 
 static void nd_namespace_pmem_set_resource(struct nd_region *nd_region,
-		struct nd_namespace_pmem *nspm, resource_size_t size)
+					   struct nd_namespace_pmem *nspm, resource_size_t size)
 {
 	struct resource *res = &nspm->nsio.res;
 	resource_size_t offset = 0;
@@ -953,7 +953,7 @@ static void nd_namespace_pmem_set_resource(struct nd_region *nd_region,
 		size = 0;
 	}
 
- out:
+out:
 	res->start = nd_region->ndr_start + offset;
 	res->end = res->start + size - 1;
 }
@@ -1009,7 +1009,7 @@ static ssize_t __size_store(struct device *dev, unsigned long long val)
 	div_u64_rem(val, SZ_4K * nd_region->ndr_mappings, &remainder);
 	if (remainder) {
 		dev_dbg(dev, "%llu is not %dK aligned\n", val,
-				(SZ_4K * nd_region->ndr_mappings) / SZ_1K);
+			(SZ_4K * nd_region->ndr_mappings) / SZ_1K);
 		return -EINVAL;
 	}
 
@@ -1039,7 +1039,7 @@ static ssize_t __size_store(struct device *dev, unsigned long long val)
 	allocated = div_u64(allocated, nd_region->ndr_mappings);
 	if (val < allocated)
 		rc = shrink_dpa_allocation(nd_region, &label_id,
-				allocated - val);
+					   allocated - val);
 	else
 		rc = grow_dpa_allocation(nd_region, &label_id, val - allocated);
 
@@ -1050,7 +1050,7 @@ static ssize_t __size_store(struct device *dev, unsigned long long val)
 		struct nd_namespace_pmem *nspm = to_nd_namespace_pmem(dev);
 
 		nd_namespace_pmem_set_resource(nd_region, nspm,
-				val * nd_region->ndr_mappings);
+					       val * nd_region->ndr_mappings);
 	}
 
 	/*
@@ -1066,7 +1066,7 @@ static ssize_t __size_store(struct device *dev, unsigned long long val)
 }
 
 static ssize_t size_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
+			  struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct nd_region *nd_region = to_nd_region(dev->parent);
 	unsigned long long val;
@@ -1160,10 +1160,10 @@ bool nvdimm_namespace_locked(struct nd_namespace_common *ndns)
 EXPORT_SYMBOL(nvdimm_namespace_locked);
 
 static ssize_t size_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			 struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%llu\n", (unsigned long long)
-			nvdimm_namespace_capacity(to_ndns(dev)));
+		       nvdimm_namespace_capacity(to_ndns(dev)));
 }
 static DEVICE_ATTR(size, 0444, size_show, size_store);
 
@@ -1182,7 +1182,7 @@ static u8 *namespace_to_uuid(struct device *dev)
 }
 
 static ssize_t uuid_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			 struct device_attribute *attr, char *buf)
 {
 	u8 *uuid = namespace_to_uuid(dev);
 
@@ -1201,7 +1201,7 @@ static ssize_t uuid_show(struct device *dev,
  * @old_uuid: reference to the uuid storage location in the namespace object
  */
 static int namespace_update_uuid(struct nd_region *nd_region,
-		struct device *dev, u8 *new_uuid, u8 **old_uuid)
+				 struct device *dev, u8 *new_uuid, u8 **old_uuid)
 {
 	u32 flags = is_namespace_blk(dev) ? NSLABEL_FLAG_LOCAL : 0;
 	struct nd_label_id old_label_id;
@@ -1245,7 +1245,7 @@ static int namespace_update_uuid(struct nd_region *nd_region,
 		for_each_dpa_resource(ndd, res)
 			if (strcmp(res->name, old_label_id.id) == 0)
 				sprintf((void *) res->name, "%s",
-						new_label_id.id);
+					new_label_id.id);
 
 		mutex_lock(&nd_mapping->lock);
 		list_for_each_entry(label_ent, &nd_mapping->labels, list) {
@@ -1262,13 +1262,13 @@ static int namespace_update_uuid(struct nd_region *nd_region,
 		mutex_unlock(&nd_mapping->lock);
 	}
 	kfree(*old_uuid);
- out:
+out:
 	*old_uuid = new_uuid;
 	return 0;
 }
 
 static ssize_t uuid_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
+			  struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct nd_region *nd_region = to_nd_region(dev->parent);
 	u8 *uuid = NULL;
@@ -1300,7 +1300,7 @@ static ssize_t uuid_store(struct device *dev,
 	else
 		kfree(uuid);
 	dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
-			buf[len - 1] == '\n' ? "" : "\n");
+		buf[len - 1] == '\n' ? "" : "\n");
 	nvdimm_bus_unlock(dev);
 	nd_device_unlock(dev);
 
@@ -1309,7 +1309,7 @@ static ssize_t uuid_store(struct device *dev,
 static DEVICE_ATTR_RW(uuid);
 
 static ssize_t resource_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			     struct device_attribute *attr, char *buf)
 {
 	struct resource *res;
 
@@ -1332,31 +1332,31 @@ static ssize_t resource_show(struct device *dev,
 static DEVICE_ATTR_RO(resource);
 
 static const unsigned long blk_lbasize_supported[] = { 512, 520, 528,
-	4096, 4104, 4160, 4224, 0 };
+						       4096, 4104, 4160, 4224, 0 };
 
 static const unsigned long pmem_lbasize_supported[] = { 512, 4096, 0 };
 
 static ssize_t sector_size_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+				struct device_attribute *attr, char *buf)
 {
 	if (is_namespace_blk(dev)) {
 		struct nd_namespace_blk *nsblk = to_nd_namespace_blk(dev);
 
 		return nd_size_select_show(nsblk->lbasize,
-				blk_lbasize_supported, buf);
+					   blk_lbasize_supported, buf);
 	}
 
 	if (is_namespace_pmem(dev)) {
 		struct nd_namespace_pmem *nspm = to_nd_namespace_pmem(dev);
 
 		return nd_size_select_show(nspm->lbasize,
-				pmem_lbasize_supported, buf);
+					   pmem_lbasize_supported, buf);
 	}
 	return -ENXIO;
 }
 
 static ssize_t sector_size_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
+				 struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct nd_region *nd_region = to_nd_region(dev->parent);
 	const unsigned long *supported;
@@ -1385,7 +1385,7 @@ static ssize_t sector_size_store(struct device *dev,
 	if (rc >= 0)
 		rc = nd_namespace_label_update(nd_region, dev);
 	dev_dbg(dev, "result: %zd %s: %s%s", rc, rc < 0 ? "tried" : "wrote",
-			buf, buf[len - 1] == '\n' ? "" : "\n");
+		buf, buf[len - 1] == '\n' ? "" : "\n");
 	nvdimm_bus_unlock(dev);
 	nd_device_unlock(dev);
 
@@ -1394,7 +1394,7 @@ static ssize_t sector_size_store(struct device *dev,
 static DEVICE_ATTR_RW(sector_size);
 
 static ssize_t dpa_extents_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+				struct device_attribute *attr, char *buf)
 {
 	struct nd_region *nd_region = to_nd_region(dev->parent);
 	struct nd_label_id label_id;
@@ -1428,7 +1428,7 @@ static ssize_t dpa_extents_show(struct device *dev,
 			if (strcmp(res->name, label_id.id) == 0)
 				count++;
 	}
- out:
+out:
 	nvdimm_bus_unlock(dev);
 
 	return sprintf(buf, "%d\n", count);
@@ -1460,7 +1460,7 @@ static int btt_claim_class(struct device *dev)
 		else {
 			/* check whether existing labels are v1.1 or v1.2 */
 			if (__le16_to_cpu(nsindex->major) == 1
-					&& __le16_to_cpu(nsindex->minor) == 1)
+			    && __le16_to_cpu(nsindex->minor) == 1)
 				loop_bitmask |= 2;
 			else
 				loop_bitmask |= 4;
@@ -1497,7 +1497,7 @@ static int btt_claim_class(struct device *dev)
 }
 
 static ssize_t holder_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			   struct device_attribute *attr, char *buf)
 {
 	struct nd_namespace_common *ndns = to_ndns(dev);
 	ssize_t rc;
@@ -1536,7 +1536,7 @@ static ssize_t __holder_class_store(struct device *dev, const char *buf)
 }
 
 static ssize_t holder_class_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
+				  struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct nd_region *nd_region = to_nd_region(dev->parent);
 	ssize_t rc;
@@ -1555,7 +1555,7 @@ static ssize_t holder_class_store(struct device *dev,
 }
 
 static ssize_t holder_class_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+				 struct device_attribute *attr, char *buf)
 {
 	struct nd_namespace_common *ndns = to_ndns(dev);
 	ssize_t rc;
@@ -1564,7 +1564,7 @@ static ssize_t holder_class_show(struct device *dev,
 	if (ndns->claim_class == NVDIMM_CCLASS_NONE)
 		rc = sprintf(buf, "\n");
 	else if ((ndns->claim_class == NVDIMM_CCLASS_BTT) ||
-			(ndns->claim_class == NVDIMM_CCLASS_BTT2))
+		 (ndns->claim_class == NVDIMM_CCLASS_BTT2))
 		rc = sprintf(buf, "btt\n");
 	else if (ndns->claim_class == NVDIMM_CCLASS_PFN)
 		rc = sprintf(buf, "pfn\n");
@@ -1579,7 +1579,7 @@ static ssize_t holder_class_show(struct device *dev,
 static DEVICE_ATTR_RW(holder_class);
 
 static ssize_t mode_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			 struct device_attribute *attr, char *buf)
 {
 	struct nd_namespace_common *ndns = to_ndns(dev);
 	struct device *claim;
@@ -1606,7 +1606,7 @@ static ssize_t mode_show(struct device *dev,
 static DEVICE_ATTR_RO(mode);
 
 static ssize_t force_raw_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
+			       struct device_attribute *attr, const char *buf, size_t len)
 {
 	bool force_raw;
 	int rc = strtobool(buf, &force_raw);
@@ -1619,7 +1619,7 @@ static ssize_t force_raw_store(struct device *dev,
 }
 
 static ssize_t force_raw_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			      struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%d\n", to_ndns(dev)->force_raw);
 }
@@ -1641,7 +1641,7 @@ static struct attribute *nd_namespace_attributes[] = {
 };
 
 static umode_t namespace_visible(struct kobject *kobj,
-		struct attribute *a, int n)
+				 struct attribute *a, int n)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
 
@@ -1659,10 +1659,10 @@ static umode_t namespace_visible(struct kobject *kobj,
 	}
 
 	if (a == &dev_attr_nstype.attr || a == &dev_attr_size.attr
-			|| a == &dev_attr_holder.attr
-			|| a == &dev_attr_holder_class.attr
-			|| a == &dev_attr_force_raw.attr
-			|| a == &dev_attr_mode.attr)
+	    || a == &dev_attr_holder.attr
+	    || a == &dev_attr_holder_class.attr
+	    || a == &dev_attr_force_raw.attr
+	    || a == &dev_attr_mode.attr)
 		return a->mode;
 
 	return 0;
@@ -1707,13 +1707,13 @@ struct nd_namespace_common *nvdimm_namespace_common_probe(struct device *dev)
 		nd_device_unlock(&ndns->dev);
 		if (ndns->dev.driver) {
 			dev_dbg(&ndns->dev, "is active, can't bind %s\n",
-					dev_name(dev));
+				dev_name(dev));
 			return ERR_PTR(-EBUSY);
 		}
 		if (dev_WARN_ONCE(&ndns->dev, ndns->claim != dev,
-					"host (%s) vs claim (%s) mismatch\n",
-					dev_name(dev),
-					dev_name(ndns->claim)))
+				  "host (%s) vs claim (%s) mismatch\n",
+				  dev_name(dev),
+				  dev_name(ndns->claim)))
 			return ERR_PTR(-ENXIO);
 	} else {
 		ndns = to_ndns(dev);
@@ -1731,7 +1731,7 @@ struct nd_namespace_common *nvdimm_namespace_common_probe(struct device *dev)
 	size = nvdimm_namespace_capacity(ndns);
 	if (size < ND_MIN_NAMESPACE_SIZE) {
 		dev_dbg(&ndns->dev, "%pa, too small must be at least %#x\n",
-				&size, ND_MIN_NAMESPACE_SIZE);
+			&size, ND_MIN_NAMESPACE_SIZE);
 		return ERR_PTR(-ENODEV);
 	}
 
@@ -1789,7 +1789,7 @@ static struct device **create_namespace_io(struct nd_region *nd_region)
 }
 
 static bool has_uuid_at_pos(struct nd_region *nd_region, u8 *uuid,
-		u64 cookie, u16 pos)
+			    u64 cookie, u16 pos)
 {
 	struct nd_namespace_label *found = NULL;
 	int i;
@@ -1819,11 +1819,11 @@ static bool has_uuid_at_pos(struct nd_region *nd_region, u8 *uuid,
 				continue;
 
 			if (namespace_label_has(ndd, type_guid)
-					&& !guid_equal(&nd_set->type_guid,
-						&nd_label->type_guid)) {
+			    && !guid_equal(&nd_set->type_guid,
+					   &nd_label->type_guid)) {
 				dev_dbg(ndd->dev, "expect type_guid %pUb got %pUb\n",
-						&nd_set->type_guid,
-						&nd_label->type_guid);
+					&nd_set->type_guid,
+					&nd_label->type_guid);
 				continue;
 			}
 
@@ -1883,11 +1883,11 @@ static int select_pmem_id(struct nd_region *nd_region, u8 *pmem_id)
 		pmem_start = __le64_to_cpu(nd_label->dpa);
 		pmem_end = pmem_start + __le64_to_cpu(nd_label->rawsize);
 		if (pmem_start >= hw_start && pmem_start < hw_end
-				&& pmem_end <= hw_end && pmem_end > hw_start)
+		    && pmem_end <= hw_end && pmem_end > hw_start)
 			/* pass */;
 		else {
 			dev_dbg(&nd_region->dev, "%s invalid label for %pUb\n",
-					dev_name(ndd->dev), nd_label->uuid);
+				dev_name(ndd->dev), nd_label->uuid);
 			return -EINVAL;
 		}
 
@@ -1904,8 +1904,8 @@ static int select_pmem_id(struct nd_region *nd_region, u8 *pmem_id)
  * @nd_label: target pmem namespace label to evaluate
  */
 static struct device *create_namespace_pmem(struct nd_region *nd_region,
-		struct nd_namespace_index *nsindex,
-		struct nd_namespace_label *nd_label)
+					    struct nd_namespace_index *nsindex,
+					    struct nd_namespace_label *nd_label)
 {
 	u64 cookie = nd_region_interleave_set_cookie(nd_region, nsindex);
 	u64 altcookie = nd_region_interleave_set_altcookie(nd_region);
@@ -1925,12 +1925,12 @@ static struct device *create_namespace_pmem(struct nd_region *nd_region,
 
 	if (__le64_to_cpu(nd_label->isetcookie) != cookie) {
 		dev_dbg(&nd_region->dev, "invalid cookie in label: %pUb\n",
-				nd_label->uuid);
+			nd_label->uuid);
 		if (__le64_to_cpu(nd_label->isetcookie) != altcookie)
 			return ERR_PTR(-EAGAIN);
 
 		dev_dbg(&nd_region->dev, "valid altcookie in label: %pUb\n",
-				nd_label->uuid);
+			nd_label->uuid);
 	}
 
 	nspm = kzalloc(sizeof(*nspm), GFP_KERNEL);
@@ -1962,7 +1962,7 @@ static struct device *create_namespace_pmem(struct nd_region *nd_region,
 		 * find a dimm with two instances of the same uuid.
 		 */
 		dev_err(&nd_region->dev, "%s missing label for %pUb\n",
-				nvdimm_name(nvdimm), nd_label->uuid);
+			nvdimm_name(nvdimm), nd_label->uuid);
 		rc = -EINVAL;
 		goto err;
 	}
@@ -1986,7 +1986,7 @@ static struct device *create_namespace_pmem(struct nd_region *nd_region,
 
 		nd_mapping = &nd_region->mapping[i];
 		label_ent = list_first_entry_or_null(&nd_mapping->labels,
-				typeof(*label_ent), list);
+						     typeof(*label_ent), list);
 		label0 = label_ent ? label_ent->label : 0;
 
 		if (!label0) {
@@ -1999,9 +1999,9 @@ static struct device *create_namespace_pmem(struct nd_region *nd_region,
 			continue;
 		WARN_ON(nspm->alt_name || nspm->uuid);
 		nspm->alt_name = kmemdup((void __force *) label0->name,
-				NSLABEL_NAME_LEN, GFP_KERNEL);
+					 NSLABEL_NAME_LEN, GFP_KERNEL);
 		nspm->uuid = kmemdup((void __force *) label0->uuid,
-				NSLABEL_UUID_LEN, GFP_KERNEL);
+				     NSLABEL_UUID_LEN, GFP_KERNEL);
 		nspm->lbasize = __le64_to_cpu(label0->lbasize);
 		ndd = to_ndd(nd_mapping);
 		if (namespace_label_has(ndd, abstraction_guid))
@@ -2018,7 +2018,7 @@ static struct device *create_namespace_pmem(struct nd_region *nd_region,
 	nd_namespace_pmem_set_resource(nd_region, nspm, size);
 
 	return dev;
- err:
+err:
 	namespace_pmem_release(dev);
 	switch (rc) {
 	case -EINVAL:
@@ -2035,22 +2035,22 @@ static struct device *create_namespace_pmem(struct nd_region *nd_region,
 }
 
 struct resource *nsblk_add_resource(struct nd_region *nd_region,
-		struct nvdimm_drvdata *ndd, struct nd_namespace_blk *nsblk,
-		resource_size_t start)
+				    struct nvdimm_drvdata *ndd, struct nd_namespace_blk *nsblk,
+				    resource_size_t start)
 {
 	struct nd_label_id label_id;
 	struct resource *res;
 
 	nd_label_gen_id(&label_id, nsblk->uuid, NSLABEL_FLAG_LOCAL);
 	res = krealloc(nsblk->res,
-			sizeof(void *) * (nsblk->num_resources + 1),
-			GFP_KERNEL);
+		       sizeof(void *) * (nsblk->num_resources + 1),
+		       GFP_KERNEL);
 	if (!res)
 		return NULL;
 	nsblk->res = (struct resource **) res;
 	for_each_dpa_resource(ndd, res)
 		if (strcmp(res->name, label_id.id) == 0
-				&& res->start == start) {
+		    && res->start == start) {
 			nsblk->res[nsblk->num_resources++] = res;
 			return res;
 		}
@@ -2133,7 +2133,7 @@ void nd_region_create_ns_seed(struct nd_region *nd_region)
 	 */
 	if (!nd_region->ns_seed)
 		dev_err(&nd_region->dev, "failed to create %s namespace\n",
-				is_nd_blk(&nd_region->dev) ? "blk" : "pmem");
+			is_nd_blk(&nd_region->dev) ? "blk" : "pmem");
 	else
 		nd_device_register(nd_region->ns_seed);
 }
@@ -2175,8 +2175,8 @@ void nd_region_create_btt_seed(struct nd_region *nd_region)
 }
 
 static int add_namespace_resource(struct nd_region *nd_region,
-		struct nd_namespace_label *nd_label, struct device **devs,
-		int count)
+				  struct nd_namespace_label *nd_label, struct device **devs,
+				  int count)
 {
 	struct nd_mapping *nd_mapping = &nd_region->mapping[0];
 	struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
@@ -2195,15 +2195,15 @@ static int add_namespace_resource(struct nd_region *nd_region,
 			continue;
 		if (is_namespace_blk(devs[i])) {
 			res = nsblk_add_resource(nd_region, ndd,
-					to_nd_namespace_blk(devs[i]),
-					__le64_to_cpu(nd_label->dpa));
+						 to_nd_namespace_blk(devs[i]),
+						 __le64_to_cpu(nd_label->dpa));
 			if (!res)
 				return -ENXIO;
 			nd_dbg_dpa(nd_region, ndd, res, "%d assign\n", count);
 		} else {
 			dev_err(&nd_region->dev,
-					"error: conflicting extents for uuid: %pUb\n",
-					nd_label->uuid);
+				"error: conflicting extents for uuid: %pUb\n",
+				nd_label->uuid);
 			return -ENXIO;
 		}
 		break;
@@ -2213,7 +2213,7 @@ static int add_namespace_resource(struct nd_region *nd_region,
 }
 
 static struct device *create_namespace_blk(struct nd_region *nd_region,
-		struct nd_namespace_label *nd_label, int count)
+					   struct nd_namespace_label *nd_label, int count)
 {
 
 	struct nd_mapping *nd_mapping = &nd_region->mapping[0];
@@ -2227,15 +2227,15 @@ static struct device *create_namespace_blk(struct nd_region *nd_region,
 	if (namespace_label_has(ndd, type_guid)) {
 		if (!guid_equal(&nd_set->type_guid, &nd_label->type_guid)) {
 			dev_dbg(ndd->dev, "expect type_guid %pUb got %pUb\n",
-					&nd_set->type_guid,
-					&nd_label->type_guid);
+				&nd_set->type_guid,
+				&nd_label->type_guid);
 			return ERR_PTR(-EAGAIN);
 		}
 
 		if (nd_label->isetcookie != __cpu_to_le64(nd_set->cookie2)) {
 			dev_dbg(ndd->dev, "expect cookie %#llx got %#llx\n",
-					nd_set->cookie2,
-					__le64_to_cpu(nd_label->isetcookie));
+				nd_set->cookie2,
+				__le64_to_cpu(nd_label->isetcookie));
 			return ERR_PTR(-EAGAIN);
 		}
 	}
@@ -2249,7 +2249,7 @@ static struct device *create_namespace_blk(struct nd_region *nd_region,
 	nsblk->id = -1;
 	nsblk->lbasize = __le64_to_cpu(nd_label->lbasize);
 	nsblk->uuid = kmemdup(nd_label->uuid, NSLABEL_UUID_LEN,
-			GFP_KERNEL);
+			      GFP_KERNEL);
 	if (namespace_label_has(ndd, abstraction_guid))
 		nsblk->common.claim_class
 			= to_nvdimm_cclass(&nd_label->abstraction_guid);
@@ -2258,17 +2258,17 @@ static struct device *create_namespace_blk(struct nd_region *nd_region,
 	memcpy(name, nd_label->name, NSLABEL_NAME_LEN);
 	if (name[0]) {
 		nsblk->alt_name = kmemdup(name, NSLABEL_NAME_LEN,
-				GFP_KERNEL);
+					  GFP_KERNEL);
 		if (!nsblk->alt_name)
 			goto blk_err;
 	}
 	res = nsblk_add_resource(nd_region, ndd, nsblk,
-			__le64_to_cpu(nd_label->dpa));
+				 __le64_to_cpu(nd_label->dpa));
 	if (!res)
 		goto blk_err;
 	nd_dbg_dpa(nd_region, ndd, res, "%d: assign\n", count);
 	return dev;
- blk_err:
+blk_err:
 	namespace_blk_release(dev);
 	return ERR_PTR(-ENXIO);
 }
@@ -2288,14 +2288,14 @@ static int cmp_dpa(const void *a, const void *b)
 		nsblk_b = to_nd_namespace_blk(dev_b);
 
 		return memcmp(&nsblk_a->res[0]->start, &nsblk_b->res[0]->start,
-				sizeof(resource_size_t));
+			      sizeof(resource_size_t));
 	}
 
 	nspm_a = to_nd_namespace_pmem(dev_a);
 	nspm_b = to_nd_namespace_pmem(dev_b);
 
 	return memcmp(&nspm_a->nsio.res.start, &nspm_b->nsio.res.start,
-			sizeof(resource_size_t));
+		      sizeof(resource_size_t));
 }
 
 static struct device **scan_labels(struct nd_region *nd_region)
@@ -2316,7 +2316,7 @@ static struct device **scan_labels(struct nd_region *nd_region)
 			continue;
 		flags = __le32_to_cpu(nd_label->flags);
 		if (is_nd_blk(&nd_region->dev)
-				== !!(flags & NSLABEL_FLAG_LOCAL))
+		    == !!(flags & NSLABEL_FLAG_LOCAL))
 			/* pass, region matches label type */;
 		else
 			continue;
@@ -2364,8 +2364,8 @@ static struct device **scan_labels(struct nd_region *nd_region)
 	}
 
 	dev_dbg(&nd_region->dev, "discovered %d %s namespace%s\n",
-			count, is_nd_blk(&nd_region->dev)
-			? "blk" : "pmem", count == 1 ? "" : "s");
+		count, is_nd_blk(&nd_region->dev)
+		? "blk" : "pmem", count == 1 ? "" : "s");
 
 	if (count == 0) {
 		/* Publish a zero-sized namespace for userspace to configure. */
@@ -2423,7 +2423,7 @@ static struct device **scan_labels(struct nd_region *nd_region)
 
 	return devs;
 
- err:
+err:
 	if (devs) {
 		for (i = 0; devs[i]; i++)
 			if (is_nd_blk(&nd_region->dev))
@@ -2486,9 +2486,9 @@ static int init_active_labels(struct nd_region *nd_region)
 				return 0;
 
 			dev_err(&nd_region->dev, "%s: is %s, failing probe\n",
-					dev_name(&nd_mapping->nvdimm->dev),
-					test_bit(NDD_LOCKED, &nvdimm->flags)
-					? "locked" : "disabled");
+				dev_name(&nd_mapping->nvdimm->dev),
+				test_bit(NDD_LOCKED, &nvdimm->flags)
+				? "locked" : "disabled");
 			return -ENXIO;
 		}
 		nd_mapping->ndd = ndd;
@@ -2570,14 +2570,14 @@ int nd_region_register_namespaces(struct nd_region *nd_region, int *err)
 
 			nsblk = to_nd_namespace_blk(dev);
 			id = ida_simple_get(&nd_region->ns_ida, 0, 0,
-					GFP_KERNEL);
+					    GFP_KERNEL);
 			nsblk->id = id;
 		} else if (type == ND_DEVICE_NAMESPACE_PMEM) {
 			struct nd_namespace_pmem *nspm;
 
 			nspm = to_nd_namespace_pmem(dev);
 			id = ida_simple_get(&nd_region->ns_ida, 0, 0,
-					GFP_KERNEL);
+					    GFP_KERNEL);
 			nspm->id = id;
 		} else
 			id = i;
diff --git a/drivers/nvdimm/nd-core.h b/drivers/nvdimm/nd-core.h
index 454454ba1738..60525ff1f19f 100644
--- a/drivers/nvdimm/nd-core.h
+++ b/drivers/nvdimm/nd-core.h
@@ -48,7 +48,7 @@ struct nvdimm {
 };
 
 static inline unsigned long nvdimm_security_flags(
-		struct nvdimm *nvdimm, enum nvdimm_passphrase_type ptype)
+	struct nvdimm *nvdimm, enum nvdimm_passphrase_type ptype)
 {
 	u64 flags;
 	const u64 state_flags = 1UL << NVDIMM_SECURITY_DISABLED
@@ -62,8 +62,8 @@ static inline unsigned long nvdimm_security_flags(
 	flags = nvdimm->sec.ops->get_flags(nvdimm, ptype);
 	/* disabled, locked, unlocked, and overwrite are mutually exclusive */
 	dev_WARN_ONCE(&nvdimm->dev, hweight64(flags & state_flags) > 1,
-			"reported invalid security state: %#llx\n",
-			(unsigned long long) flags);
+		      "reported invalid security state: %#llx\n",
+		      (unsigned long long) flags);
 	return flags;
 }
 int nvdimm_security_freeze(struct nvdimm *nvdimm);
@@ -72,7 +72,7 @@ ssize_t nvdimm_security_store(struct device *dev, const char *buf, size_t len);
 void nvdimm_security_overwrite_query(struct work_struct *work);
 #else
 static inline ssize_t nvdimm_security_store(struct device *dev,
-		const char *buf, size_t len)
+					    const char *buf, size_t len)
 {
 	return -EOPNOTSUPP;
 }
@@ -146,29 +146,29 @@ resource_size_t nd_pmem_max_contiguous_dpa(struct nd_region *nd_region,
 					   struct nd_mapping *nd_mapping);
 resource_size_t nd_region_allocatable_dpa(struct nd_region *nd_region);
 resource_size_t nd_pmem_available_dpa(struct nd_region *nd_region,
-		struct nd_mapping *nd_mapping, resource_size_t *overlap);
+				      struct nd_mapping *nd_mapping, resource_size_t *overlap);
 resource_size_t nd_blk_available_dpa(struct nd_region *nd_region);
 resource_size_t nd_region_available_dpa(struct nd_region *nd_region);
 int nd_region_conflict(struct nd_region *nd_region, resource_size_t start,
-		resource_size_t size);
+		       resource_size_t size);
 resource_size_t nvdimm_allocated_dpa(struct nvdimm_drvdata *ndd,
-		struct nd_label_id *label_id);
+				     struct nd_label_id *label_id);
 int alias_dpa_busy(struct device *dev, void *data);
 struct resource *nsblk_add_resource(struct nd_region *nd_region,
-		struct nvdimm_drvdata *ndd, struct nd_namespace_blk *nsblk,
-		resource_size_t start);
+				    struct nvdimm_drvdata *ndd, struct nd_namespace_blk *nsblk,
+				    resource_size_t start);
 int nvdimm_num_label_slots(struct nvdimm_drvdata *ndd);
 void get_ndd(struct nvdimm_drvdata *ndd);
 resource_size_t __nvdimm_namespace_capacity(struct nd_namespace_common *ndns);
 void nd_detach_ndns(struct device *dev, struct nd_namespace_common **_ndns);
 void __nd_detach_ndns(struct device *dev, struct nd_namespace_common **_ndns);
 bool nd_attach_ndns(struct device *dev, struct nd_namespace_common *attach,
-		struct nd_namespace_common **_ndns);
+		    struct nd_namespace_common **_ndns);
 bool __nd_attach_ndns(struct device *dev, struct nd_namespace_common *attach,
-		struct nd_namespace_common **_ndns);
+		      struct nd_namespace_common **_ndns);
 ssize_t nd_namespace_store(struct device *dev,
-		struct nd_namespace_common **_ndns, const char *buf,
-		size_t len);
+			   struct nd_namespace_common **_ndns, const char *buf,
+			   size_t len);
 struct nd_pfn *to_nd_pfn_safe(struct device *dev);
 bool is_nvdimm_bus(struct device *dev);
 
diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index 1b9955651379..56ffd998d642 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -43,7 +43,7 @@ struct nd_region_data {
 };
 
 static inline void __iomem *ndrd_get_flush_wpq(struct nd_region_data *ndrd,
-		int dimm, int hint)
+					       int dimm, int hint)
 {
 	unsigned int num = 1 << ndrd->hints_shift;
 	unsigned int mask = num - 1;
@@ -52,7 +52,7 @@ static inline void __iomem *ndrd_get_flush_wpq(struct nd_region_data *ndrd,
 }
 
 static inline void ndrd_set_flush_wpq(struct nd_region_data *ndrd, int dimm,
-		int hint, void __iomem *flush)
+				      int hint, void __iomem *flush)
 {
 	unsigned int num = 1 << ndrd->hints_shift;
 	unsigned int mask = num - 1;
@@ -61,7 +61,7 @@ static inline void ndrd_set_flush_wpq(struct nd_region_data *ndrd, int dimm,
 }
 
 static inline struct nd_namespace_index *to_namespace_index(
-		struct nvdimm_drvdata *ndd, int i)
+	struct nvdimm_drvdata *ndd, int i)
 {
 	if (i < 0)
 		return NULL;
@@ -70,35 +70,35 @@ static inline struct nd_namespace_index *to_namespace_index(
 }
 
 static inline struct nd_namespace_index *to_current_namespace_index(
-		struct nvdimm_drvdata *ndd)
+	struct nvdimm_drvdata *ndd)
 {
 	return to_namespace_index(ndd, ndd->ns_current);
 }
 
 static inline struct nd_namespace_index *to_next_namespace_index(
-		struct nvdimm_drvdata *ndd)
+	struct nvdimm_drvdata *ndd)
 {
 	return to_namespace_index(ndd, ndd->ns_next);
 }
 
 unsigned sizeof_namespace_label(struct nvdimm_drvdata *ndd);
 
-#define namespace_label_has(ndd, field) \
-	(offsetof(struct nd_namespace_label, field) \
-		< sizeof_namespace_label(ndd))
+#define namespace_label_has(ndd, field)			\
+	(offsetof(struct nd_namespace_label, field)	\
+	 < sizeof_namespace_label(ndd))
 
-#define nd_dbg_dpa(r, d, res, fmt, arg...) \
+#define nd_dbg_dpa(r, d, res, fmt, arg...)				\
 	dev_dbg((r) ? &(r)->dev : (d)->dev, "%s: %.13s: %#llx @ %#llx " fmt, \
 		(r) ? dev_name((d)->dev) : "", res ? res->name : "null", \
-		(unsigned long long) (res ? resource_size(res) : 0), \
+		(unsigned long long) (res ? resource_size(res) : 0),	\
 		(unsigned long long) (res ? res->start : 0), ##arg)
 
-#define for_each_dpa_resource(ndd, res) \
+#define for_each_dpa_resource(ndd, res)				\
 	for (res = (ndd)->dpa.child; res; res = res->sibling)
 
-#define for_each_dpa_resource_safe(ndd, res, next) \
-	for (res = (ndd)->dpa.child, next = res ? res->sibling : NULL; \
-			res; res = next, next = next ? next->sibling : NULL)
+#define for_each_dpa_resource_safe(ndd, res, next)			\
+	for (res = (ndd)->dpa.child, next = res ? res->sibling : NULL;	\
+	     res; res = next, next = next ? next->sibling : NULL)
 
 struct nd_percpu_lane {
 	int count;
@@ -162,7 +162,7 @@ struct nd_region {
 struct nd_blk_region {
 	int (*enable)(struct nvdimm_bus *nvdimm_bus, struct device *dev);
 	int (*do_io)(struct nd_blk_region *ndbr, resource_size_t dpa,
-			void *iobuf, u64 len, int rw);
+		     void *iobuf, u64 len, int rw);
 	void *blk_provider_data;
 	struct nd_region nd_region;
 };
@@ -223,11 +223,11 @@ void nd_device_register(struct device *dev);
 void nd_device_unregister(struct device *dev, enum nd_async_mode mode);
 void nd_device_notify(struct device *dev, enum nvdimm_event event);
 int nd_uuid_store(struct device *dev, u8 **uuid_out, const char *buf,
-		size_t len);
+		  size_t len);
 ssize_t nd_size_select_show(unsigned long current_size,
-		const unsigned long *supported, char *buf);
+			    const unsigned long *supported, char *buf);
 ssize_t nd_size_select_store(struct device *dev, const char *buf,
-		unsigned long *current_size, const unsigned long *supported);
+			     unsigned long *current_size, const unsigned long *supported);
 int __init nvdimm_init(void);
 int __init nd_region_init(void);
 int __init nd_label_init(void);
@@ -241,9 +241,9 @@ int nvdimm_init_config_data(struct nvdimm_drvdata *ndd);
 int nvdimm_get_config_data(struct nvdimm_drvdata *ndd, void *buf,
 			   size_t offset, size_t len);
 int nvdimm_set_config_data(struct nvdimm_drvdata *ndd, size_t offset,
-		void *buf, size_t len);
+			   void *buf, size_t len);
 long nvdimm_clear_poison(struct device *dev, phys_addr_t phys,
-		unsigned int len);
+			 unsigned int len);
 void nvdimm_set_aliasing(struct device *dev);
 void nvdimm_set_locked(struct device *dev);
 void nvdimm_clear_locked(struct device *dev);
@@ -270,7 +270,7 @@ bool is_nd_btt(struct device *dev);
 struct device *nd_btt_create(struct nd_region *nd_region);
 #else
 static inline int nd_btt_probe(struct device *dev,
-		struct nd_namespace_common *ndns)
+			       struct nd_namespace_common *ndns)
 {
 	return -ENODEV;
 }
@@ -299,12 +299,12 @@ int nd_pfn_probe(struct device *dev, struct nd_namespace_common *ndns);
 bool is_nd_pfn(struct device *dev);
 struct device *nd_pfn_create(struct nd_region *nd_region);
 struct device *nd_pfn_devinit(struct nd_pfn *nd_pfn,
-		struct nd_namespace_common *ndns);
+			      struct nd_namespace_common *ndns);
 int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig);
 extern struct attribute_group nd_pfn_attribute_group;
 #else
 static inline int nd_pfn_probe(struct device *dev,
-		struct nd_namespace_common *ndns)
+			       struct nd_namespace_common *ndns)
 {
 	return -ENODEV;
 }
@@ -332,7 +332,7 @@ bool is_nd_dax(struct device *dev);
 struct device *nd_dax_create(struct nd_region *nd_region);
 #else
 static inline int nd_dax_probe(struct device *dev,
-		struct nd_namespace_common *ndns)
+			       struct nd_namespace_common *ndns)
 {
 	return -ENODEV;
 }
@@ -351,7 +351,7 @@ static inline struct device *nd_dax_create(struct nd_region *nd_region)
 int nd_region_to_nstype(struct nd_region *nd_region);
 int nd_region_register_namespaces(struct nd_region *nd_region, int *err);
 u64 nd_region_interleave_set_cookie(struct nd_region *nd_region,
-		struct nd_namespace_index *nsindex);
+				    struct nd_namespace_index *nsindex);
 u64 nd_region_interleave_set_altcookie(struct nd_region *nd_region);
 void nvdimm_bus_lock(struct device *dev);
 void nvdimm_bus_unlock(struct device *dev);
@@ -362,18 +362,18 @@ void put_ndd(struct nvdimm_drvdata *ndd);
 int nd_label_reserve_dpa(struct nvdimm_drvdata *ndd);
 void nvdimm_free_dpa(struct nvdimm_drvdata *ndd, struct resource *res);
 struct resource *nvdimm_allocate_dpa(struct nvdimm_drvdata *ndd,
-		struct nd_label_id *label_id, resource_size_t start,
-		resource_size_t n);
+				     struct nd_label_id *label_id, resource_size_t start,
+				     resource_size_t n);
 resource_size_t nvdimm_namespace_capacity(struct nd_namespace_common *ndns);
 bool nvdimm_namespace_locked(struct nd_namespace_common *ndns);
 struct nd_namespace_common *nvdimm_namespace_common_probe(struct device *dev);
 int nvdimm_namespace_attach_btt(struct nd_namespace_common *ndns);
 int nvdimm_namespace_detach_btt(struct nd_btt *nd_btt);
 const char *nvdimm_namespace_disk_name(struct nd_namespace_common *ndns,
-		char *name);
+				       char *name);
 unsigned int pmem_sector_size(struct nd_namespace_common *ndns);
 void nvdimm_badblocks_populate(struct nd_region *nd_region,
-		struct badblocks *bb, const struct resource *res);
+			       struct badblocks *bb, const struct resource *res);
 #if IS_ENABLED(CONFIG_ND_CLAIM)
 int nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap);
 int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio);
@@ -385,12 +385,12 @@ static inline int nvdimm_setup_pfn(struct nd_pfn *nd_pfn,
 	return -ENXIO;
 }
 static inline int devm_nsio_enable(struct device *dev,
-		struct nd_namespace_io *nsio)
+				   struct nd_namespace_io *nsio)
 {
 	return -ENXIO;
 }
 static inline void devm_nsio_disable(struct device *dev,
-		struct nd_namespace_io *nsio)
+				     struct nd_namespace_io *nsio)
 {
 }
 #endif
@@ -416,14 +416,14 @@ static inline void nd_iostat_end(struct bio *bio, unsigned long start)
 	generic_end_io_acct(disk->queue, bio_op(bio), &disk->part0, start);
 }
 static inline bool is_bad_pmem(struct badblocks *bb, sector_t sector,
-		unsigned int len)
+			       unsigned int len)
 {
 	if (bb->count) {
 		sector_t first_bad;
 		int num_bad;
 
 		return !!badblocks_check(bb, sector, len / 512, &first_bad,
-				&num_bad);
+					 &num_bad);
 	}
 
 	return false;
diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index 10351d5b49fa..e4f553633759 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -9,7 +9,7 @@
 #include "virtio_pmem.h"
 #include "nd.h"
 
- /* The interrupt handler */
+/* The interrupt handler */
 void virtio_pmem_host_ack(struct virtqueue *vq)
 {
 	struct virtio_pmem *vpmem = vq->vdev->priv;
@@ -24,7 +24,7 @@ void virtio_pmem_host_ack(struct virtqueue *vq)
 
 		if (!list_empty(&vpmem->req_list)) {
 			req_buf = list_first_entry(&vpmem->req_list,
-					struct virtio_pmem_request, list);
+						   struct virtio_pmem_request, list);
 			req_buf->wq_buf_avail = true;
 			wake_up(&req_buf->wq_buf);
 			list_del(&req_buf->list);
@@ -34,7 +34,7 @@ void virtio_pmem_host_ack(struct virtqueue *vq)
 }
 EXPORT_SYMBOL_GPL(virtio_pmem_host_ack);
 
- /* The request submission function */
+/* The request submission function */
 static int virtio_pmem_flush(struct nd_region *nd_region)
 {
 	struct virtio_device *vdev = nd_region->provider_data;
@@ -60,12 +60,12 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
 	sgs[1] = &ret;
 
 	spin_lock_irqsave(&vpmem->pmem_lock, flags);
-	 /*
-	  * If virtqueue_add_sgs returns -ENOSPC then req_vq virtual
-	  * queue does not have free descriptor. We add the request
-	  * to req_list and wait for host_ack to wake us up when free
-	  * slots are available.
-	  */
+	/*
+	 * If virtqueue_add_sgs returns -ENOSPC then req_vq virtual
+	 * queue does not have free descriptor. We add the request
+	 * to req_list and wait for host_ack to wake us up when free
+	 * slots are available.
+	 */
 	while ((err = virtqueue_add_sgs(vpmem->req_vq, sgs, 1, 1, req_data,
 					GFP_ATOMIC)) == -ENOSPC) {
 
diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
index 97187d6c0bdb..03ffcbf601d4 100644
--- a/drivers/nvdimm/of_pmem.c
+++ b/drivers/nvdimm/of_pmem.c
@@ -55,7 +55,7 @@ static int of_pmem_region_probe(struct platform_device *pdev)
 
 	is_volatile = !!of_find_property(np, "volatile", NULL);
 	dev_dbg(&pdev->dev, "Registering %s regions from %pOF\n",
-			is_volatile ? "volatile" : "non-volatile",  np);
+		is_volatile ? "volatile" : "non-volatile",  np);
 
 	for (i = 0; i < pdev->num_resources; i++) {
 		struct nd_region_desc ndr_desc;
@@ -80,10 +80,10 @@ static int of_pmem_region_probe(struct platform_device *pdev)
 
 		if (!region)
 			dev_warn(&pdev->dev, "Unable to register region %pR from %pOF\n",
-					ndr_desc.res, np);
+				 ndr_desc.res, np);
 		else
 			dev_dbg(&pdev->dev, "Registered region %pR from %pOF\n",
-					ndr_desc.res, np);
+				ndr_desc.res, np);
 	}
 
 	return 0;
diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index cb98b8fe786e..354ec83f0081 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -47,7 +47,7 @@ struct nd_pfn *to_nd_pfn(struct device *dev)
 EXPORT_SYMBOL(to_nd_pfn);
 
 static ssize_t mode_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			 struct device_attribute *attr, char *buf)
 {
 	struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
 
@@ -62,7 +62,7 @@ static ssize_t mode_show(struct device *dev,
 }
 
 static ssize_t mode_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
+			  struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
 	ssize_t rc = 0;
@@ -75,19 +75,19 @@ static ssize_t mode_store(struct device *dev,
 		size_t n = len - 1;
 
 		if (strncmp(buf, "pmem\n", n) == 0
-				|| strncmp(buf, "pmem", n) == 0) {
+		    || strncmp(buf, "pmem", n) == 0) {
 			nd_pfn->mode = PFN_MODE_PMEM;
 		} else if (strncmp(buf, "ram\n", n) == 0
-				|| strncmp(buf, "ram", n) == 0)
+			   || strncmp(buf, "ram", n) == 0)
 			nd_pfn->mode = PFN_MODE_RAM;
 		else if (strncmp(buf, "none\n", n) == 0
-				|| strncmp(buf, "none", n) == 0)
+			 || strncmp(buf, "none", n) == 0)
 			nd_pfn->mode = PFN_MODE_NONE;
 		else
 			rc = -EINVAL;
 	}
 	dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
-			buf[len - 1] == '\n' ? "" : "\n");
+		buf[len - 1] == '\n' ? "" : "\n");
 	nvdimm_bus_unlock(dev);
 	nd_device_unlock(dev);
 
@@ -96,7 +96,7 @@ static ssize_t mode_store(struct device *dev,
 static DEVICE_ATTR_RW(mode);
 
 static ssize_t align_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			  struct device_attribute *attr, char *buf)
 {
 	struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
 
@@ -127,7 +127,7 @@ static const unsigned long *nd_pfn_supported_alignments(void)
 }
 
 static ssize_t align_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
+			   struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
 	ssize_t rc;
@@ -135,9 +135,9 @@ static ssize_t align_store(struct device *dev,
 	nd_device_lock(dev);
 	nvdimm_bus_lock(dev);
 	rc = nd_size_select_store(dev, buf, &nd_pfn->align,
-			nd_pfn_supported_alignments());
+				  nd_pfn_supported_alignments());
 	dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
-			buf[len - 1] == '\n' ? "" : "\n");
+		buf[len - 1] == '\n' ? "" : "\n");
 	nvdimm_bus_unlock(dev);
 	nd_device_unlock(dev);
 
@@ -146,7 +146,7 @@ static ssize_t align_store(struct device *dev,
 static DEVICE_ATTR_RW(align);
 
 static ssize_t uuid_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			 struct device_attribute *attr, char *buf)
 {
 	struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
 
@@ -156,7 +156,7 @@ static ssize_t uuid_show(struct device *dev,
 }
 
 static ssize_t uuid_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
+			  struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
 	ssize_t rc;
@@ -164,7 +164,7 @@ static ssize_t uuid_store(struct device *dev,
 	nd_device_lock(dev);
 	rc = nd_uuid_store(dev, &nd_pfn->uuid, buf, len);
 	dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
-			buf[len - 1] == '\n' ? "" : "\n");
+		buf[len - 1] == '\n' ? "" : "\n");
 	nd_device_unlock(dev);
 
 	return rc ? rc : len;
@@ -172,20 +172,20 @@ static ssize_t uuid_store(struct device *dev,
 static DEVICE_ATTR_RW(uuid);
 
 static ssize_t namespace_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			      struct device_attribute *attr, char *buf)
 {
 	struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
 	ssize_t rc;
 
 	nvdimm_bus_lock(dev);
 	rc = sprintf(buf, "%s\n", nd_pfn->ndns
-			? dev_name(&nd_pfn->ndns->dev) : "");
+		     ? dev_name(&nd_pfn->ndns->dev) : "");
 	nvdimm_bus_unlock(dev);
 	return rc;
 }
 
 static ssize_t namespace_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
+			       struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
 	ssize_t rc;
@@ -194,7 +194,7 @@ static ssize_t namespace_store(struct device *dev,
 	nvdimm_bus_lock(dev);
 	rc = nd_namespace_store(dev, &nd_pfn->ndns, buf, len);
 	dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
-			buf[len - 1] == '\n' ? "" : "\n");
+		buf[len - 1] == '\n' ? "" : "\n");
 	nvdimm_bus_unlock(dev);
 	nd_device_unlock(dev);
 
@@ -203,7 +203,7 @@ static ssize_t namespace_store(struct device *dev,
 static DEVICE_ATTR_RW(namespace);
 
 static ssize_t resource_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			     struct device_attribute *attr, char *buf)
 {
 	struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
 	ssize_t rc;
@@ -217,7 +217,7 @@ static ssize_t resource_show(struct device *dev,
 		struct nd_namespace_io *nsio = to_nd_namespace_io(&ndns->dev);
 
 		rc = sprintf(buf, "%#llx\n", (unsigned long long) nsio->res.start
-				+ start_pad + offset);
+			     + start_pad + offset);
 	} else {
 		/* no address to convey if the pfn instance is disabled */
 		rc = -ENXIO;
@@ -229,7 +229,7 @@ static ssize_t resource_show(struct device *dev,
 static DEVICE_ATTR_RO(resource);
 
 static ssize_t size_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			 struct device_attribute *attr, char *buf)
 {
 	struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
 	ssize_t rc;
@@ -244,8 +244,8 @@ static ssize_t size_show(struct device *dev,
 		struct nd_namespace_io *nsio = to_nd_namespace_io(&ndns->dev);
 
 		rc = sprintf(buf, "%llu\n", (unsigned long long)
-				resource_size(&nsio->res) - start_pad
-				- end_trunc - offset);
+			     resource_size(&nsio->res) - start_pad
+			     - end_trunc - offset);
 	} else {
 		/* no size to convey if the pfn instance is disabled */
 		rc = -ENXIO;
@@ -257,7 +257,7 @@ static ssize_t size_show(struct device *dev,
 static DEVICE_ATTR_RO(size);
 
 static ssize_t supported_alignments_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+					 struct device_attribute *attr, char *buf)
 {
 	return nd_size_select_show(0, nd_pfn_supported_alignments(), buf);
 }
@@ -294,7 +294,7 @@ static const struct attribute_group *nd_pfn_attribute_groups[] = {
 };
 
 struct device *nd_pfn_devinit(struct nd_pfn *nd_pfn,
-		struct nd_namespace_common *ndns)
+			      struct nd_namespace_common *ndns)
 {
 	struct device *dev;
 
@@ -307,7 +307,7 @@ struct device *nd_pfn_devinit(struct nd_pfn *nd_pfn,
 	device_initialize(&nd_pfn->dev);
 	if (ndns && !__nd_attach_ndns(&nd_pfn->dev, ndns, &nd_pfn->ndns)) {
 		dev_dbg(&ndns->dev, "failed, already claimed by %s\n",
-				dev_name(ndns->claim));
+			dev_name(ndns->claim));
 		put_device(dev);
 		return NULL;
 	}
@@ -381,13 +381,13 @@ static int nd_pfn_clear_memmap_errors(struct nd_pfn *nd_pfn)
 		u64 nsoff;
 
 		bb_present = badblocks_check(&nd_region->bb, meta_start,
-				meta_num, &first_bad, &num_bad);
+					     meta_num, &first_bad, &num_bad);
 		if (bb_present) {
 			dev_dbg(&nd_pfn->dev, "meta: %x badblocks at %llx\n",
-					num_bad, first_bad);
+				num_bad, first_bad);
 			nsoff = ALIGN_DOWN((nd_region->ndr_start
-					+ (first_bad << 9)) - nsio->res.start,
-					PAGE_SIZE);
+					    + (first_bad << 9)) - nsio->res.start,
+					   PAGE_SIZE);
 			zero_len = ALIGN(num_bad << 9, PAGE_SIZE);
 			while (zero_len) {
 				unsigned long chunk = min(zero_len, PAGE_SIZE);
@@ -502,17 +502,17 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
 		 */
 		if (nd_pfn->align != align || nd_pfn->mode != mode) {
 			dev_err(&nd_pfn->dev,
-					"init failed, settings mismatch\n");
+				"init failed, settings mismatch\n");
 			dev_dbg(&nd_pfn->dev, "align: %lx:%lx mode: %d:%d\n",
-					nd_pfn->align, align, nd_pfn->mode,
-					mode);
+				nd_pfn->align, align, nd_pfn->mode,
+				mode);
 			return -EINVAL;
 		}
 	}
 
 	if (align > nvdimm_namespace_capacity(ndns)) {
 		dev_err(&nd_pfn->dev, "alignment: %lx exceeds capacity %llx\n",
-				align, nvdimm_namespace_capacity(ndns));
+			align, nvdimm_namespace_capacity(ndns));
 		return -EINVAL;
 	}
 
@@ -525,15 +525,15 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
 	nsio = to_nd_namespace_io(&ndns->dev);
 	if (offset >= resource_size(&nsio->res)) {
 		dev_err(&nd_pfn->dev, "pfn array size exceeds capacity of %s\n",
-				dev_name(&ndns->dev));
+			dev_name(&ndns->dev));
 		return -EBUSY;
 	}
 
 	if ((align && !IS_ALIGNED(nsio->res.start + offset + start_pad, align))
-			|| !IS_ALIGNED(offset, PAGE_SIZE)) {
+	    || !IS_ALIGNED(offset, PAGE_SIZE)) {
 		dev_err(&nd_pfn->dev,
-				"bad offset: %#llx dax disabled align: %#lx\n",
-				offset, align);
+			"bad offset: %#llx dax disabled align: %#lx\n",
+			offset, align);
 		return -ENXIO;
 	}
 
@@ -635,9 +635,9 @@ static int __nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap)
 		nd_pfn->npfns = PHYS_PFN((resource_size(res) - offset));
 		if (le64_to_cpu(nd_pfn->pfn_sb->npfns) > nd_pfn->npfns)
 			dev_info(&nd_pfn->dev,
-					"number of pfns truncated from %lld to %ld\n",
-					le64_to_cpu(nd_pfn->pfn_sb->npfns),
-					nd_pfn->npfns);
+				 "number of pfns truncated from %lld to %ld\n",
+				 le64_to_cpu(nd_pfn->pfn_sb->npfns),
+				 nd_pfn->npfns);
 		memcpy(altmap, &__altmap, sizeof(*altmap));
 		altmap->free = PHYS_PFN(offset - reserve);
 		altmap->alloc = 0;
@@ -682,8 +682,8 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
 	nd_region = to_nd_region(nd_pfn->dev.parent);
 	if (nd_region->ro) {
 		dev_info(&nd_pfn->dev,
-				"%s is read-only, unable to init metadata\n",
-				dev_name(&nd_region->dev));
+			 "%s is read-only, unable to init metadata\n",
+			 dev_name(&nd_region->dev));
 		return -ENXIO;
 	}
 
@@ -712,7 +712,7 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
 
 	if (offset >= size) {
 		dev_err(&nd_pfn->dev, "%s unable to satisfy requested alignment\n",
-				dev_name(&ndns->dev));
+			dev_name(&ndns->dev));
 		return -ENXIO;
 	}
 
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 4c121dd03dd9..29f19db46845 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -45,7 +45,7 @@ static struct nd_region *to_region(struct pmem_device *pmem)
 }
 
 static void hwpoison_clear(struct pmem_device *pmem,
-		phys_addr_t phys, unsigned int len)
+			   phys_addr_t phys, unsigned int len)
 {
 	unsigned long pfn_start, pfn_end, pfn;
 
@@ -69,7 +69,7 @@ static void hwpoison_clear(struct pmem_device *pmem,
 }
 
 static blk_status_t pmem_clear_poison(struct pmem_device *pmem,
-		phys_addr_t offset, unsigned int len)
+				      phys_addr_t offset, unsigned int len)
 {
 	struct device *dev = to_dev(pmem);
 	sector_t sector;
@@ -85,8 +85,8 @@ static blk_status_t pmem_clear_poison(struct pmem_device *pmem,
 		hwpoison_clear(pmem, pmem->phys_addr + offset, cleared);
 		cleared /= 512;
 		dev_dbg(dev, "%#llx clear %ld sector%s\n",
-				(unsigned long long) sector, cleared,
-				cleared > 1 ? "s" : "");
+			(unsigned long long) sector, cleared,
+			cleared > 1 ? "s" : "");
 		badblocks_clear(&pmem->bb, sector, cleared);
 		if (pmem->bb_state)
 			sysfs_notify_dirent(pmem->bb_state);
@@ -98,7 +98,7 @@ static blk_status_t pmem_clear_poison(struct pmem_device *pmem,
 }
 
 static void write_pmem(void *pmem_addr, struct page *page,
-		unsigned int off, unsigned int len)
+		       unsigned int off, unsigned int len)
 {
 	unsigned int chunk;
 	void *mem;
@@ -116,7 +116,7 @@ static void write_pmem(void *pmem_addr, struct page *page,
 }
 
 static blk_status_t read_pmem(struct page *page, unsigned int off,
-		void *pmem_addr, unsigned int len)
+			      void *pmem_addr, unsigned int len)
 {
 	unsigned int chunk;
 	unsigned long rem;
@@ -138,8 +138,8 @@ static blk_status_t read_pmem(struct page *page, unsigned int off,
 }
 
 static blk_status_t pmem_do_bvec(struct pmem_device *pmem, struct page *page,
-			unsigned int len, unsigned int off, unsigned int op,
-			sector_t sector)
+				 unsigned int len, unsigned int off, unsigned int op,
+				 sector_t sector)
 {
 	blk_status_t rc = BLK_STS_OK;
 	bool bad_pmem = false;
@@ -199,7 +199,7 @@ static blk_qc_t pmem_make_request(struct request_queue *q, struct bio *bio)
 	do_acct = nd_iostat_start(bio, &start);
 	bio_for_each_segment(bvec, bio, iter) {
 		rc = pmem_do_bvec(pmem, bvec.bv_page, bvec.bv_len,
-				bvec.bv_offset, bio_op(bio), iter.bi_sector);
+				  bvec.bv_offset, bio_op(bio), iter.bi_sector);
 		if (rc) {
 			bio->bi_status = rc;
 			break;
@@ -219,7 +219,7 @@ static blk_qc_t pmem_make_request(struct request_queue *q, struct bio *bio)
 }
 
 static int pmem_rw_page(struct block_device *bdev, sector_t sector,
-		       struct page *page, unsigned int op)
+			struct page *page, unsigned int op)
 {
 	struct pmem_device *pmem = bdev->bd_queue->queuedata;
 	blk_status_t rc;
@@ -241,12 +241,12 @@ static int pmem_rw_page(struct block_device *bdev, sector_t sector,
 
 /* see "strong" declaration in tools/testing/nvdimm/pmem-dax.c */
 __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn)
+				 long nr_pages, void **kaddr, pfn_t *pfn)
 {
 	resource_size_t offset = PFN_PHYS(pgoff) + pmem->data_offset;
 
 	if (unlikely(is_bad_pmem(&pmem->bb, PFN_PHYS(pgoff) / 512,
-					PFN_PHYS(nr_pages))))
+				 PFN_PHYS(nr_pages))))
 		return -EIO;
 
 	if (kaddr)
@@ -270,7 +270,7 @@ static const struct block_device_operations pmem_fops = {
 };
 
 static long pmem_dax_direct_access(struct dax_device *dax_dev,
-		pgoff_t pgoff, long nr_pages, void **kaddr, pfn_t *pfn)
+				   pgoff_t pgoff, long nr_pages, void **kaddr, pfn_t *pfn)
 {
 	struct pmem_device *pmem = dax_get_private(dax_dev);
 
@@ -284,13 +284,13 @@ static long pmem_dax_direct_access(struct dax_device *dax_dev,
  * dax_iomap_actor()
  */
 static size_t pmem_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff,
-		void *addr, size_t bytes, struct iov_iter *i)
+				  void *addr, size_t bytes, struct iov_iter *i)
 {
 	return _copy_from_iter_flushcache(addr, bytes, i);
 }
 
 static size_t pmem_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff,
-		void *addr, size_t bytes, struct iov_iter *i)
+				void *addr, size_t bytes, struct iov_iter *i)
 {
 	return _copy_to_iter_mcsafe(addr, bytes, i);
 }
@@ -350,7 +350,7 @@ static const struct dev_pagemap_ops fsdax_pagemap_ops = {
 };
 
 static int pmem_attach_disk(struct device *dev,
-		struct nd_namespace_common *ndns)
+			    struct nd_namespace_common *ndns)
 {
 	struct nd_namespace_io *nsio = to_nd_namespace_io(&ndns->dev);
 	struct nd_region *nd_region = to_nd_region(dev->parent);
@@ -393,7 +393,7 @@ static int pmem_attach_disk(struct device *dev,
 	}
 
 	if (!devm_request_mem_region(dev, res->start, resource_size(res),
-				dev_name(&ndns->dev))) {
+				     dev_name(&ndns->dev))) {
 		dev_warn(dev, "could not reserve region %pR\n", res);
 		return -EBUSY;
 	}
@@ -424,10 +424,10 @@ static int pmem_attach_disk(struct device *dev,
 		memcpy(&bb_res, &pmem->pgmap.res, sizeof(bb_res));
 	} else {
 		if (devm_add_action_or_reset(dev, pmem_release_queue,
-					&pmem->pgmap))
+					     &pmem->pgmap))
 			return -ENOMEM;
 		addr = devm_memremap(dev, pmem->phys_addr,
-				pmem->size, ARCH_MEMREMAP_PMEM);
+				     pmem->size, ARCH_MEMREMAP_PMEM);
 		memcpy(&bb_res, &nsio->res, sizeof(bb_res));
 	}
 
@@ -456,7 +456,7 @@ static int pmem_attach_disk(struct device *dev,
 	disk->queue->backing_dev_info->capabilities |= BDI_CAP_SYNCHRONOUS_IO;
 	nvdimm_namespace_disk_name(ndns, disk->disk_name);
 	set_capacity(disk, (pmem->size - pmem->pfn_pad - pmem->data_offset)
-			/ 512);
+		     / 512);
 	if (devm_init_badblocks(dev, &pmem->bb))
 		return -ENOMEM;
 	nvdimm_badblocks_populate(nd_region, &pmem->bb, &bb_res);
@@ -507,7 +507,7 @@ static int nd_pmem_probe(struct device *dev)
 
 	/* if we find a valid info-block we'll come back as that personality */
 	if (nd_btt_probe(dev, ndns) == 0 || nd_pfn_probe(dev, ndns) == 0
-			|| nd_dax_probe(dev, ndns) == 0)
+	    || nd_dax_probe(dev, ndns) == 0)
 		return -ENXIO;
 
 	/* ...otherwise we're just a raw pmem device */
@@ -572,7 +572,7 @@ static void nd_pmem_notify(struct device *dev, enum nvdimm_event event)
 
 			ndns = nd_pfn->ndns;
 			offset = pmem->data_offset +
-					__le32_to_cpu(pfn_sb->start_pad);
+				__le32_to_cpu(pfn_sb->start_pad);
 			end_trunc = __le32_to_cpu(pfn_sb->end_trunc);
 		} else {
 			ndns = to_ndns(dev);
diff --git a/drivers/nvdimm/pmem.h b/drivers/nvdimm/pmem.h
index 59cfe13ea8a8..f5ba2a9a68ed 100644
--- a/drivers/nvdimm/pmem.h
+++ b/drivers/nvdimm/pmem.h
@@ -27,7 +27,7 @@ struct pmem_device {
 };
 
 long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn);
+			  long nr_pages, void **kaddr, pfn_t *pfn);
 
 #ifdef CONFIG_MEMORY_FAILURE
 static inline bool test_and_clear_pmem_poison(struct page *page)
diff --git a/drivers/nvdimm/region.c b/drivers/nvdimm/region.c
index 37bf8719a2a4..8b7dbac27aea 100644
--- a/drivers/nvdimm/region.c
+++ b/drivers/nvdimm/region.c
@@ -17,13 +17,13 @@ static int nd_region_probe(struct device *dev)
 	struct nd_region *nd_region = to_nd_region(dev);
 
 	if (nd_region->num_lanes > num_online_cpus()
-			&& nd_region->num_lanes < num_possible_cpus()
-			&& !test_and_set_bit(0, &once)) {
+	    && nd_region->num_lanes < num_possible_cpus()
+	    && !test_and_set_bit(0, &once)) {
 		dev_dbg(dev, "online cpus (%d) < concurrent i/o lanes (%d) < possible cpus (%d)\n",
-				num_online_cpus(), nd_region->num_lanes,
-				num_possible_cpus());
+			num_online_cpus(), nd_region->num_lanes,
+			num_possible_cpus());
 		dev_dbg(dev, "setting nr_cpus=%d may yield better libnvdimm device performance\n",
-				nd_region->num_lanes);
+			nd_region->num_lanes);
 	}
 
 	rc = nd_region_activate(nd_region);
@@ -43,7 +43,7 @@ static int nd_region_probe(struct device *dev)
 						       "badblocks");
 		if (!nd_region->bb_state)
 			dev_warn(&nd_region->dev,
-					"'badblocks' notification disabled\n");
+				 "'badblocks' notification disabled\n");
 		ndr_res.start = nd_region->ndr_start;
 		ndr_res.end = nd_region->ndr_start + nd_region->ndr_size - 1;
 		nvdimm_badblocks_populate(nd_region, &nd_region->bb, &ndr_res);
@@ -76,7 +76,7 @@ static int nd_region_probe(struct device *dev)
 	 * "<async-registered>/<total>" namespace count.
 	 */
 	dev_err(dev, "failed to register %d namespace%s, continuing...\n",
-			err, err == 1 ? "" : "s");
+		err, err == 1 ? "" : "s");
 	return 0;
 }
 
@@ -128,7 +128,7 @@ static void nd_region_notify(struct device *dev, enum nvdimm_event event)
 			res.end = nd_region->ndr_start +
 				nd_region->ndr_size - 1;
 			nvdimm_badblocks_populate(nd_region,
-					&nd_region->bb, &res);
+						  &nd_region->bb, &res);
 			if (nd_region->bb_state)
 				sysfs_notify_dirent(nd_region->bb_state);
 		}
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index b477a8dc0020..025cd996ea58 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -23,12 +23,12 @@ static DEFINE_IDA(region_ida);
 static DEFINE_PER_CPU(int, flush_idx);
 
 static int nvdimm_map_flush(struct device *dev, struct nvdimm *nvdimm, int dimm,
-		struct nd_region_data *ndrd)
+			    struct nd_region_data *ndrd)
 {
 	int i, j;
 
 	dev_dbg(dev, "%s: map %d flush address%s\n", nvdimm_name(nvdimm),
-			nvdimm->num_flush, nvdimm->num_flush == 1 ? "" : "es");
+		nvdimm->num_flush, nvdimm->num_flush == 1 ? "" : "es");
 	for (i = 0; i < (1 << ndrd->hints_shift); i++) {
 		struct resource *res = &nvdimm->flush_wpq[i];
 		unsigned long pfn = PHYS_PFN(res->start);
@@ -45,15 +45,15 @@ static int nvdimm_map_flush(struct device *dev, struct nvdimm *nvdimm, int dimm,
 
 		if (j < i)
 			flush_page = (void __iomem *) ((unsigned long)
-					ndrd_get_flush_wpq(ndrd, dimm, j)
-					& PAGE_MASK);
+						       ndrd_get_flush_wpq(ndrd, dimm, j)
+						       & PAGE_MASK);
 		else
 			flush_page = devm_nvdimm_ioremap(dev,
-					PFN_PHYS(pfn), PAGE_SIZE);
+							 PFN_PHYS(pfn), PAGE_SIZE);
 		if (!flush_page)
 			return -ENXIO;
 		ndrd_set_flush_wpq(ndrd, dimm, i, flush_page
-				+ (res->start & ~PAGE_MASK));
+				   + (res->start & ~PAGE_MASK));
 	}
 
 	return 0;
@@ -247,7 +247,7 @@ int nd_region_to_nstype(struct nd_region *nd_region)
 EXPORT_SYMBOL(nd_region_to_nstype);
 
 static ssize_t size_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			 struct device_attribute *attr, char *buf)
 {
 	struct nd_region *nd_region = to_nd_region(dev);
 	unsigned long long size = 0;
@@ -265,7 +265,7 @@ static ssize_t size_show(struct device *dev,
 static DEVICE_ATTR_RO(size);
 
 static ssize_t deep_flush_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			       struct device_attribute *attr, char *buf)
 {
 	struct nd_region *nd_region = to_nd_region(dev);
 
@@ -277,7 +277,7 @@ static ssize_t deep_flush_show(struct device *dev,
 }
 
 static ssize_t deep_flush_store(struct device *dev, struct device_attribute *attr,
-		const char *buf, size_t len)
+				const char *buf, size_t len)
 {
 	bool flush;
 	int rc = strtobool(buf, &flush);
@@ -296,7 +296,7 @@ static ssize_t deep_flush_store(struct device *dev, struct device_attribute *att
 static DEVICE_ATTR_RW(deep_flush);
 
 static ssize_t mappings_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			     struct device_attribute *attr, char *buf)
 {
 	struct nd_region *nd_region = to_nd_region(dev);
 
@@ -305,7 +305,7 @@ static ssize_t mappings_show(struct device *dev,
 static DEVICE_ATTR_RO(mappings);
 
 static ssize_t nstype_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			   struct device_attribute *attr, char *buf)
 {
 	struct nd_region *nd_region = to_nd_region(dev);
 
@@ -314,7 +314,7 @@ static ssize_t nstype_show(struct device *dev,
 static DEVICE_ATTR_RO(nstype);
 
 static ssize_t set_cookie_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			       struct device_attribute *attr, char *buf)
 {
 	struct nd_region *nd_region = to_nd_region(dev);
 	struct nd_interleave_set *nd_set = nd_region->nd_set;
@@ -343,8 +343,8 @@ static ssize_t set_cookie_show(struct device *dev,
 
 			nsindex = to_namespace_index(ndd, ndd->ns_current);
 			rc = sprintf(buf, "%#llx\n",
-					nd_region_interleave_set_cookie(nd_region,
-						nsindex));
+				     nd_region_interleave_set_cookie(nd_region,
+								     nsindex));
 		}
 	}
 	nvdimm_bus_unlock(dev);
@@ -363,7 +363,7 @@ resource_size_t nd_region_available_dpa(struct nd_region *nd_region)
 
 	WARN_ON(!is_nvdimm_bus_locked(&nd_region->dev));
 
- retry:
+retry:
 	available = 0;
 	overlap = blk_max_overlap;
 	for (i = 0; i < nd_region->ndr_mappings; i++) {
@@ -376,7 +376,7 @@ resource_size_t nd_region_available_dpa(struct nd_region *nd_region)
 
 		if (is_memory(&nd_region->dev)) {
 			available += nd_pmem_available_dpa(nd_region,
-					nd_mapping, &overlap);
+							   nd_mapping, &overlap);
 			if (overlap > blk_max_overlap) {
 				blk_max_overlap = overlap;
 				goto retry;
@@ -413,7 +413,7 @@ resource_size_t nd_region_allocatable_dpa(struct nd_region *nd_region)
 }
 
 static ssize_t available_size_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+				   struct device_attribute *attr, char *buf)
 {
 	struct nd_region *nd_region = to_nd_region(dev);
 	unsigned long long available = 0;
@@ -436,7 +436,7 @@ static ssize_t available_size_show(struct device *dev,
 static DEVICE_ATTR_RO(available_size);
 
 static ssize_t max_available_extent_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+					 struct device_attribute *attr, char *buf)
 {
 	struct nd_region *nd_region = to_nd_region(dev);
 	unsigned long long available = 0;
@@ -453,7 +453,7 @@ static ssize_t max_available_extent_show(struct device *dev,
 static DEVICE_ATTR_RO(max_available_extent);
 
 static ssize_t init_namespaces_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+				    struct device_attribute *attr, char *buf)
 {
 	struct nd_region_data *ndrd = dev_get_drvdata(dev);
 	ssize_t rc;
@@ -470,7 +470,7 @@ static ssize_t init_namespaces_show(struct device *dev,
 static DEVICE_ATTR_RO(init_namespaces);
 
 static ssize_t namespace_seed_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+				   struct device_attribute *attr, char *buf)
 {
 	struct nd_region *nd_region = to_nd_region(dev);
 	ssize_t rc;
@@ -486,7 +486,7 @@ static ssize_t namespace_seed_show(struct device *dev,
 static DEVICE_ATTR_RO(namespace_seed);
 
 static ssize_t btt_seed_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			     struct device_attribute *attr, char *buf)
 {
 	struct nd_region *nd_region = to_nd_region(dev);
 	ssize_t rc;
@@ -503,7 +503,7 @@ static ssize_t btt_seed_show(struct device *dev,
 static DEVICE_ATTR_RO(btt_seed);
 
 static ssize_t pfn_seed_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			     struct device_attribute *attr, char *buf)
 {
 	struct nd_region *nd_region = to_nd_region(dev);
 	ssize_t rc;
@@ -520,7 +520,7 @@ static ssize_t pfn_seed_show(struct device *dev,
 static DEVICE_ATTR_RO(pfn_seed);
 
 static ssize_t dax_seed_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			     struct device_attribute *attr, char *buf)
 {
 	struct nd_region *nd_region = to_nd_region(dev);
 	ssize_t rc;
@@ -537,7 +537,7 @@ static ssize_t dax_seed_show(struct device *dev,
 static DEVICE_ATTR_RO(dax_seed);
 
 static ssize_t read_only_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			      struct device_attribute *attr, char *buf)
 {
 	struct nd_region *nd_region = to_nd_region(dev);
 
@@ -545,7 +545,7 @@ static ssize_t read_only_show(struct device *dev,
 }
 
 static ssize_t read_only_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
+			       struct device_attribute *attr, const char *buf, size_t len)
 {
 	bool ro;
 	int rc = strtobool(buf, &ro);
@@ -560,7 +560,7 @@ static ssize_t read_only_store(struct device *dev,
 static DEVICE_ATTR_RW(read_only);
 
 static ssize_t region_badblocks_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+				     struct device_attribute *attr, char *buf)
 {
 	struct nd_region *nd_region = to_nd_region(dev);
 	ssize_t rc;
@@ -577,7 +577,7 @@ static ssize_t region_badblocks_show(struct device *dev,
 static DEVICE_ATTR(badblocks, 0444, region_badblocks_show, NULL);
 
 static ssize_t resource_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+			     struct device_attribute *attr, char *buf)
 {
 	struct nd_region *nd_region = to_nd_region(dev);
 
@@ -586,7 +586,7 @@ static ssize_t resource_show(struct device *dev,
 static DEVICE_ATTR_RO(resource);
 
 static ssize_t persistence_domain_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+				       struct device_attribute *attr, char *buf)
 {
 	struct nd_region *nd_region = to_nd_region(dev);
 
@@ -655,18 +655,18 @@ static umode_t region_visible(struct kobject *kobj, struct attribute *a, int n)
 
 	if (a == &dev_attr_persistence_domain.attr) {
 		if ((nd_region->flags & (BIT(ND_REGION_PERSIST_CACHE)
-					| BIT(ND_REGION_PERSIST_MEMCTRL))) == 0)
+					 | BIT(ND_REGION_PERSIST_MEMCTRL))) == 0)
 			return 0;
 		return a->mode;
 	}
 
 	if (a != &dev_attr_set_cookie.attr
-			&& a != &dev_attr_available_size.attr)
+	    && a != &dev_attr_available_size.attr)
 		return a->mode;
 
 	if ((type == ND_DEVICE_NAMESPACE_PMEM
-				|| type == ND_DEVICE_NAMESPACE_BLK)
-			&& a == &dev_attr_available_size.attr)
+	     || type == ND_DEVICE_NAMESPACE_BLK)
+	    && a == &dev_attr_available_size.attr)
 		return a->mode;
 	else if (is_memory(dev) && nd_set)
 		return a->mode;
@@ -681,7 +681,7 @@ struct attribute_group nd_region_attribute_group = {
 EXPORT_SYMBOL_GPL(nd_region_attribute_group);
 
 u64 nd_region_interleave_set_cookie(struct nd_region *nd_region,
-		struct nd_namespace_index *nsindex)
+				    struct nd_namespace_index *nsindex)
 {
 	struct nd_interleave_set *nd_set = nd_region->nd_set;
 
@@ -689,7 +689,7 @@ u64 nd_region_interleave_set_cookie(struct nd_region *nd_region,
 		return 0;
 
 	if (nsindex && __le16_to_cpu(nsindex->major) == 1
-			&& __le16_to_cpu(nsindex->minor) == 1)
+	    && __le16_to_cpu(nsindex->minor) == 1)
 		return nd_set->cookie1;
 	return nd_set->cookie2;
 }
@@ -721,7 +721,7 @@ void nd_mapping_free_labels(struct nd_mapping *nd_mapping)
  * disable the region.
  */
 static void nd_region_notify_driver_action(struct nvdimm_bus *nvdimm_bus,
-		struct device *dev, bool probe)
+					   struct device *dev, bool probe)
 {
 	struct nd_region *nd_region;
 
@@ -808,17 +808,17 @@ static ssize_t mappingN(struct device *dev, char *buf, int n)
 	nvdimm = nd_mapping->nvdimm;
 
 	return sprintf(buf, "%s,%llu,%llu,%d\n", dev_name(&nvdimm->dev),
-			nd_mapping->start, nd_mapping->size,
-			nd_mapping->position);
+		       nd_mapping->start, nd_mapping->size,
+		       nd_mapping->position);
 }
 
-#define REGION_MAPPING(idx) \
-static ssize_t mapping##idx##_show(struct device *dev,		\
-		struct device_attribute *attr, char *buf)	\
-{								\
-	return mappingN(dev, buf, idx);				\
-}								\
-static DEVICE_ATTR_RO(mapping##idx)
+#define REGION_MAPPING(idx)						\
+	static ssize_t mapping##idx##_show(struct device *dev,		\
+					   struct device_attribute *attr, char *buf) \
+	{								\
+		return mappingN(dev, buf, idx);				\
+	}								\
+	static DEVICE_ATTR_RO(mapping##idx)
 
 /*
  * 32 should be enough for a while, even in the presence of socket
@@ -979,8 +979,8 @@ void nd_region_release_lane(struct nd_region *nd_region, unsigned int lane)
 EXPORT_SYMBOL(nd_region_release_lane);
 
 static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
-		struct nd_region_desc *ndr_desc, struct device_type *dev_type,
-		const char *caller)
+					  struct nd_region_desc *ndr_desc, struct device_type *dev_type,
+					  const char *caller)
 {
 	struct nd_region *nd_region;
 	struct device *dev;
@@ -994,7 +994,7 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 
 		if ((mapping->start | mapping->size) % SZ_4K) {
 			dev_err(&nvdimm_bus->dev, "%s: %s mapping%d is not 4K aligned\n",
-					caller, dev_name(&nvdimm->dev), i);
+				caller, dev_name(&nvdimm->dev), i);
 
 			return NULL;
 		}
@@ -1003,9 +1003,9 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 			ro = 1;
 
 		if (test_bit(NDD_NOBLK, &nvdimm->flags)
-				&& dev_type == &nd_blk_device_type) {
+		    && dev_type == &nd_blk_device_type) {
 			dev_err(&nvdimm_bus->dev, "%s: %s mapping%d is not BLK capable\n",
-					caller, dev_name(&nvdimm->dev), i);
+				caller, dev_name(&nvdimm->dev), i);
 			return NULL;
 		}
 	}
@@ -1016,8 +1016,8 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 
 		ndbr_desc = to_blk_region_desc(ndr_desc);
 		ndbr = kzalloc(sizeof(*ndbr) + sizeof(struct nd_mapping)
-				* ndr_desc->num_mappings,
-				GFP_KERNEL);
+			       * ndr_desc->num_mappings,
+			       GFP_KERNEL);
 		if (ndbr) {
 			nd_region = &ndbr->nd_region;
 			ndbr->enable = ndbr_desc->enable;
@@ -1091,39 +1091,39 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 
 	return nd_region;
 
- err_percpu:
+err_percpu:
 	ida_simple_remove(&region_ida, nd_region->id);
- err_id:
+err_id:
 	kfree(region_buf);
 	return NULL;
 }
 
 struct nd_region *nvdimm_pmem_region_create(struct nvdimm_bus *nvdimm_bus,
-		struct nd_region_desc *ndr_desc)
+					    struct nd_region_desc *ndr_desc)
 {
 	ndr_desc->num_lanes = ND_MAX_LANES;
 	return nd_region_create(nvdimm_bus, ndr_desc, &nd_pmem_device_type,
-			__func__);
+				__func__);
 }
 EXPORT_SYMBOL_GPL(nvdimm_pmem_region_create);
 
 struct nd_region *nvdimm_blk_region_create(struct nvdimm_bus *nvdimm_bus,
-		struct nd_region_desc *ndr_desc)
+					   struct nd_region_desc *ndr_desc)
 {
 	if (ndr_desc->num_mappings > 1)
 		return NULL;
 	ndr_desc->num_lanes = min(ndr_desc->num_lanes, ND_MAX_LANES);
 	return nd_region_create(nvdimm_bus, ndr_desc, &nd_blk_device_type,
-			__func__);
+				__func__);
 }
 EXPORT_SYMBOL_GPL(nvdimm_blk_region_create);
 
 struct nd_region *nvdimm_volatile_region_create(struct nvdimm_bus *nvdimm_bus,
-		struct nd_region_desc *ndr_desc)
+						struct nd_region_desc *ndr_desc)
 {
 	ndr_desc->num_lanes = ND_MAX_LANES;
 	return nd_region_create(nvdimm_bus, ndr_desc, &nd_volatile_device_type,
-			__func__);
+				__func__);
 }
 EXPORT_SYMBOL_GPL(nvdimm_volatile_region_create);
 
@@ -1187,7 +1187,7 @@ int nvdimm_has_flush(struct nd_region *nd_region)
 
 	/* no nvdimm or pmem api == flushing capability unknown */
 	if (nd_region->ndr_mappings == 0
-			|| !IS_ENABLED(CONFIG_ARCH_HAS_PMEM_API))
+	    || !IS_ENABLED(CONFIG_ARCH_HAS_PMEM_API))
 		return -ENXIO;
 
 	for (i = 0; i < nd_region->ndr_mappings; i++) {
@@ -1250,7 +1250,7 @@ static int region_conflict(struct device *dev, void *data)
 }
 
 int nd_region_conflict(struct nd_region *nd_region, resource_size_t start,
-		resource_size_t size)
+		       resource_size_t size)
 {
 	struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(&nd_region->dev);
 	struct conflict_context ctx = {
diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
index e32e43965e8d..be89ad78a368 100644
--- a/drivers/nvdimm/security.c
+++ b/drivers/nvdimm/security.c
@@ -78,7 +78,7 @@ static struct key *nvdimm_request_key(struct nvdimm *nvdimm)
 }
 
 static const void *nvdimm_get_key_payload(struct nvdimm *nvdimm,
-		struct key **key)
+					  struct key **key)
 {
 	*key = nvdimm_request_key(nvdimm);
 	if (!*key)
@@ -88,7 +88,7 @@ static const void *nvdimm_get_key_payload(struct nvdimm *nvdimm,
 }
 
 static struct key *nvdimm_lookup_user_key(struct nvdimm *nvdimm,
-		key_serial_t id, int subclass)
+					  key_serial_t id, int subclass)
 {
 	key_ref_t keyref;
 	struct key *key;
@@ -118,7 +118,7 @@ static struct key *nvdimm_lookup_user_key(struct nvdimm *nvdimm,
 }
 
 static const void *nvdimm_get_user_key_payload(struct nvdimm *nvdimm,
-		key_serial_t id, int subclass, struct key **key)
+					       key_serial_t id, int subclass, struct key **key)
 {
 	*key = NULL;
 	if (id == 0) {
@@ -174,7 +174,7 @@ static int __nvdimm_security_unlock(struct nvdimm *nvdimm)
 	lockdep_assert_held(&nvdimm_bus->reconfig_mutex);
 
 	if (!nvdimm->sec.ops || !nvdimm->sec.ops->unlock
-			|| !nvdimm->sec.flags)
+	    || !nvdimm->sec.flags)
 		return -EIO;
 
 	if (test_bit(NDD_SECURITY_OVERWRITE, &nvdimm->flags)) {
@@ -199,7 +199,7 @@ static int __nvdimm_security_unlock(struct nvdimm *nvdimm)
 
 	rc = nvdimm->sec.ops->unlock(nvdimm, data);
 	dev_dbg(dev, "key: %d unlock: %s\n", key_serial(key),
-			rc == 0 ? "success" : "fail");
+		rc == 0 ? "success" : "fail");
 
 	nvdimm_put_key(key);
 	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
@@ -223,7 +223,7 @@ static int check_security_state(struct nvdimm *nvdimm)
 
 	if (test_bit(NVDIMM_SECURITY_FROZEN, &nvdimm->sec.flags)) {
 		dev_dbg(dev, "Incorrect security state: %#lx\n",
-				nvdimm->sec.flags);
+			nvdimm->sec.flags);
 		return -EIO;
 	}
 
@@ -247,7 +247,7 @@ static int security_disable(struct nvdimm *nvdimm, unsigned int keyid)
 	lockdep_assert_held(&nvdimm_bus->reconfig_mutex);
 
 	if (!nvdimm->sec.ops || !nvdimm->sec.ops->disable
-			|| !nvdimm->sec.flags)
+	    || !nvdimm->sec.flags)
 		return -EOPNOTSUPP;
 
 	rc = check_security_state(nvdimm);
@@ -255,13 +255,13 @@ static int security_disable(struct nvdimm *nvdimm, unsigned int keyid)
 		return rc;
 
 	data = nvdimm_get_user_key_payload(nvdimm, keyid,
-			NVDIMM_BASE_KEY, &key);
+					   NVDIMM_BASE_KEY, &key);
 	if (!data)
 		return -ENOKEY;
 
 	rc = nvdimm->sec.ops->disable(nvdimm, data);
 	dev_dbg(dev, "key: %d disable: %s\n", key_serial(key),
-			rc == 0 ? "success" : "fail");
+		rc == 0 ? "success" : "fail");
 
 	nvdimm_put_key(key);
 	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
@@ -269,8 +269,8 @@ static int security_disable(struct nvdimm *nvdimm, unsigned int keyid)
 }
 
 static int security_update(struct nvdimm *nvdimm, unsigned int keyid,
-		unsigned int new_keyid,
-		enum nvdimm_passphrase_type pass_type)
+			   unsigned int new_keyid,
+			   enum nvdimm_passphrase_type pass_type)
 {
 	struct device *dev = &nvdimm->dev;
 	struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(dev);
@@ -282,7 +282,7 @@ static int security_update(struct nvdimm *nvdimm, unsigned int keyid,
 	lockdep_assert_held(&nvdimm_bus->reconfig_mutex);
 
 	if (!nvdimm->sec.ops || !nvdimm->sec.ops->change_key
-			|| !nvdimm->sec.flags)
+	    || !nvdimm->sec.flags)
 		return -EOPNOTSUPP;
 
 	rc = check_security_state(nvdimm);
@@ -290,12 +290,12 @@ static int security_update(struct nvdimm *nvdimm, unsigned int keyid,
 		return rc;
 
 	data = nvdimm_get_user_key_payload(nvdimm, keyid,
-			NVDIMM_BASE_KEY, &key);
+					   NVDIMM_BASE_KEY, &key);
 	if (!data)
 		return -ENOKEY;
 
 	newdata = nvdimm_get_user_key_payload(nvdimm, new_keyid,
-			NVDIMM_NEW_KEY, &newkey);
+					      NVDIMM_NEW_KEY, &newkey);
 	if (!newdata) {
 		nvdimm_put_key(key);
 		return -ENOKEY;
@@ -303,23 +303,23 @@ static int security_update(struct nvdimm *nvdimm, unsigned int keyid,
 
 	rc = nvdimm->sec.ops->change_key(nvdimm, data, newdata, pass_type);
 	dev_dbg(dev, "key: %d %d update%s: %s\n",
-			key_serial(key), key_serial(newkey),
-			pass_type == NVDIMM_MASTER ? "(master)" : "(user)",
-			rc == 0 ? "success" : "fail");
+		key_serial(key), key_serial(newkey),
+		pass_type == NVDIMM_MASTER ? "(master)" : "(user)",
+		rc == 0 ? "success" : "fail");
 
 	nvdimm_put_key(newkey);
 	nvdimm_put_key(key);
 	if (pass_type == NVDIMM_MASTER)
 		nvdimm->sec.ext_flags = nvdimm_security_flags(nvdimm,
-				NVDIMM_MASTER);
+							      NVDIMM_MASTER);
 	else
 		nvdimm->sec.flags = nvdimm_security_flags(nvdimm,
-				NVDIMM_USER);
+							  NVDIMM_USER);
 	return rc;
 }
 
 static int security_erase(struct nvdimm *nvdimm, unsigned int keyid,
-		enum nvdimm_passphrase_type pass_type)
+			  enum nvdimm_passphrase_type pass_type)
 {
 	struct device *dev = &nvdimm->dev;
 	struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(dev);
@@ -331,7 +331,7 @@ static int security_erase(struct nvdimm *nvdimm, unsigned int keyid,
 	lockdep_assert_held(&nvdimm_bus->reconfig_mutex);
 
 	if (!nvdimm->sec.ops || !nvdimm->sec.ops->erase
-			|| !nvdimm->sec.flags)
+	    || !nvdimm->sec.flags)
 		return -EOPNOTSUPP;
 
 	rc = check_security_state(nvdimm);
@@ -339,21 +339,21 @@ static int security_erase(struct nvdimm *nvdimm, unsigned int keyid,
 		return rc;
 
 	if (!test_bit(NVDIMM_SECURITY_UNLOCKED, &nvdimm->sec.ext_flags)
-			&& pass_type == NVDIMM_MASTER) {
+	    && pass_type == NVDIMM_MASTER) {
 		dev_dbg(dev,
 			"Attempt to secure erase in wrong master state.\n");
 		return -EOPNOTSUPP;
 	}
 
 	data = nvdimm_get_user_key_payload(nvdimm, keyid,
-			NVDIMM_BASE_KEY, &key);
+					   NVDIMM_BASE_KEY, &key);
 	if (!data)
 		return -ENOKEY;
 
 	rc = nvdimm->sec.ops->erase(nvdimm, data, pass_type);
 	dev_dbg(dev, "key: %d erase%s: %s\n", key_serial(key),
-			pass_type == NVDIMM_MASTER ? "(master)" : "(user)",
-			rc == 0 ? "success" : "fail");
+		pass_type == NVDIMM_MASTER ? "(master)" : "(user)",
+		rc == 0 ? "success" : "fail");
 
 	nvdimm_put_key(key);
 	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
@@ -372,7 +372,7 @@ static int security_overwrite(struct nvdimm *nvdimm, unsigned int keyid)
 	lockdep_assert_held(&nvdimm_bus->reconfig_mutex);
 
 	if (!nvdimm->sec.ops || !nvdimm->sec.ops->overwrite
-			|| !nvdimm->sec.flags)
+	    || !nvdimm->sec.flags)
 		return -EOPNOTSUPP;
 
 	if (dev->driver == NULL) {
@@ -385,13 +385,13 @@ static int security_overwrite(struct nvdimm *nvdimm, unsigned int keyid)
 		return rc;
 
 	data = nvdimm_get_user_key_payload(nvdimm, keyid,
-			NVDIMM_BASE_KEY, &key);
+					   NVDIMM_BASE_KEY, &key);
 	if (!data)
 		return -ENOKEY;
 
 	rc = nvdimm->sec.ops->overwrite(nvdimm, data);
 	dev_dbg(dev, "key: %d overwrite submission: %s\n", key_serial(key),
-			rc == 0 ? "success" : "fail");
+		rc == 0 ? "success" : "fail");
 
 	nvdimm_put_key(key);
 	if (rc == 0) {
@@ -428,7 +428,7 @@ void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
 	tmo = nvdimm->sec.overwrite_tmo;
 
 	if (!nvdimm->sec.ops || !nvdimm->sec.ops->query_overwrite
-			|| !nvdimm->sec.flags)
+	    || !nvdimm->sec.flags)
 		return;
 
 	rc = nvdimm->sec.ops->query_overwrite(nvdimm);
@@ -466,14 +466,14 @@ void nvdimm_security_overwrite_query(struct work_struct *work)
 	nvdimm_bus_unlock(&nvdimm->dev);
 }
 
-#define OPS							\
-	C( OP_FREEZE,		"freeze",		1),	\
-	C( OP_DISABLE,		"disable",		2),	\
-	C( OP_UPDATE,		"update",		3),	\
-	C( OP_ERASE,		"erase",		2),	\
-	C( OP_OVERWRITE,	"overwrite",		2),	\
-	C( OP_MASTER_UPDATE,	"master_update",	3),	\
-	C( OP_MASTER_ERASE,	"master_erase",		2)
+#define OPS								\
+	C( OP_FREEZE,		"freeze",		1),		\
+		C( OP_DISABLE,		"disable",		2),	\
+		C( OP_UPDATE,		"update",		3),	\
+		C( OP_ERASE,		"erase",		2),	\
+		C( OP_OVERWRITE,	"overwrite",		2),	\
+		C( OP_MASTER_UPDATE,	"master_update",	3),	\
+		C( OP_MASTER_ERASE,	"master_erase",		2)
 #undef C
 #define C(a, b, c) a
 enum nvdimmsec_op_ids { OPS };
@@ -498,9 +498,9 @@ ssize_t nvdimm_security_store(struct device *dev, const char *buf, size_t len)
 	int i;
 
 	rc = sscanf(buf, "%"__stringify(SEC_CMD_SIZE)"s"
-			" %"__stringify(KEY_ID_SIZE)"s"
-			" %"__stringify(KEY_ID_SIZE)"s",
-			cmd, keystr, nkeystr);
+		    " %"__stringify(KEY_ID_SIZE)"s"
+		    " %"__stringify(KEY_ID_SIZE)"s",
+		    cmd, keystr, nkeystr);
 	if (rc < 1)
 		return -EINVAL;
 	for (i = 0; i < ARRAY_SIZE(ops); i++)
@@ -524,7 +524,7 @@ ssize_t nvdimm_security_store(struct device *dev, const char *buf, size_t len)
 	} else if (i == OP_UPDATE || i == OP_MASTER_UPDATE) {
 		dev_dbg(dev, "%s %u %u\n", ops[i].name, key, newkey);
 		rc = security_update(nvdimm, key, newkey, i == OP_UPDATE
-				? NVDIMM_USER : NVDIMM_MASTER);
+				     ? NVDIMM_USER : NVDIMM_MASTER);
 	} else if (i == OP_ERASE || i == OP_MASTER_ERASE) {
 		dev_dbg(dev, "%s %u\n", ops[i].name, key);
 		if (atomic_read(&nvdimm->busy)) {
@@ -532,7 +532,7 @@ ssize_t nvdimm_security_store(struct device *dev, const char *buf, size_t len)
 			return -EBUSY;
 		}
 		rc = security_erase(nvdimm, key, i == OP_ERASE
-				? NVDIMM_USER : NVDIMM_MASTER);
+				    ? NVDIMM_USER : NVDIMM_MASTER);
 	} else if (i == OP_OVERWRITE) {
 		dev_dbg(dev, "overwrite %u\n", key);
 		if (atomic_read(&nvdimm->busy)) {
diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
index 5e3d07b47e0c..ce2181e06756 100644
--- a/drivers/nvdimm/virtio_pmem.c
+++ b/drivers/nvdimm/virtio_pmem.c
@@ -14,12 +14,12 @@ static struct virtio_device_id id_table[] = {
 	{ 0 },
 };
 
- /* Initialize virt queue */
+/* Initialize virt queue */
 static int init_vq(struct virtio_pmem *vpmem)
 {
 	/* single vq */
 	vpmem->req_vq = virtio_find_single_vq(vpmem->vdev,
-					virtio_pmem_host_ack, "flush_queue");
+					      virtio_pmem_host_ack, "flush_queue");
 	if (IS_ERR(vpmem->req_vq))
 		return PTR_ERR(vpmem->req_vq);
 
@@ -59,9 +59,9 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
 	}
 
 	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
-			start, &vpmem->start);
+		     start, &vpmem->start);
 	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
-			size, &vpmem->size);
+		     size, &vpmem->size);
 
 	res.start = vpmem->start;
 	res.end   = vpmem->start + vpmem->size - 1;
-- 
2.15.0

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

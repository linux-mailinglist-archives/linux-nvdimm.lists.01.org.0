Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF89B0D76
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Sep 2019 13:02:23 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B03ED21962301;
	Thu, 12 Sep 2019 04:02:24 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=216.40.44.173;
 helo=smtprelay.hostedemail.com; envelope-from=joe@perches.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from smtprelay.hostedemail.com (smtprelay0173.hostedemail.com
 [216.40.44.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A81D4202E2916
 for <linux-nvdimm@lists.01.org>; Thu, 12 Sep 2019 04:02:21 -0700 (PDT)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay04.hostedemail.com (Postfix) with ESMTP id B0263180A68A3;
 Thu, 12 Sep 2019 11:02:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2, 0, 0, , d41d8cd98f00b204, joe@perches.com, :::::::::::,
 RULES_HIT:69:355:371:372:379:599:960:966:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1461:1515:1516:1518:1593:1594:1605:1730:1747:1777:1792:1801:2194:2196:2198:2199:2200:2201:2393:2538:2539:2559:2562:2689:2691:2693:2736:2828:2890:2894:2895:2898:2924:2926:3138:3139:3140:3141:3142:3865:3866:3867:3868:3870:3871:3872:3874:4042:4250:4321:4384:4385:4395:4605:5007:6630:6691:7558:7875:7903:7904:8568:8603:8660:8957:9010:9036:9149:9592:10562:10848:11026:11232:11233:11914:12043:12050:12294:12296:12297:12438:12555:12679:12683:12740:12760:12895:12986:13138:13148:13160:13229:13230:13231:13255:13439:13972:14096:14097:14659:14877:21080:21324:21433:21450:21451:21611:21627:21740:21789:21795:21796:21810:21939:21966:30001:30003:30006:30025:30029:30034:30036:30045:30051:30054:30055:30056:30060:30064:30067:30069:30070:30075:30079:30080:30083:30090:30091,
 0, RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 
X-HE-Tag: drug90_13a2a988b1112
X-Filterd-Recvd-Size: 164896
Received: from XPS-9350.home (unknown [47.151.152.152])
 (Authenticated sender: joe@perches.com)
 by omf04.hostedemail.com (Postfix) with ESMTPA;
 Thu, 12 Sep 2019 11:02:14 +0000 (UTC)
Message-ID: <5eebafcb85a23a59f01681e73c83b387c59f4a4b.camel@perches.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm, MAINTAINERS:
 Maintainer Entry Profile
From: Joe Perches <joe@perches.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Dan Williams
 <dan.j.williams@intel.com>
Date: Thu, 12 Sep 2019 04:02:13 -0700
In-Reply-To: <e9cb9bc8bd7fe38a5bb6ff7b7222b512acc7b018.camel@perches.com>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190911184332.GL20699@kadam>
 <9132e214-9b57-07dc-7ee2-f6bc52e960c5@kernel.dk>
 <CAPcyv4ij3s+9uO0f9aLHGj3=ACG7hAjZ0Rf=tyFmpt3+uQyymw@mail.gmail.com>
 <CANiq72k2so3ZcqA3iRziGY=Shd_B1=qGoXXROeAF7Y3+pDmqyA@mail.gmail.com>
 <e9cb9bc8bd7fe38a5bb6ff7b7222b512acc7b018.camel@perches.com>
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

(cut down the cc-list)

On Thu, 2019-09-12 at 03:18 -0700, Joe Perches wrote:
> On Thu, 2019-09-12 at 10:24 +0200, Miguel Ojeda wrote:
> > On Thu, Sep 12, 2019 at 9:43 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > > Now I come to find that CodingStyle has settled on clang-format (in
> > > the last 15 months) as the new standard which is a much better answer
> > > to me than a manually specified style open to interpretation. I'll
> > > take a look at getting libnvdimm converted over.
> > 
> > Note that clang-format cannot do everything as we want within the
> > kernel just yet, but it is a close enough approximation -- it is near
> > the point where we could simply agree to use it and stop worrying
> > about styling issues. However, that would mean everyone needs to have
> > a recent clang-format available, which I think is the biggest obstacle
> > at the moment.
> 
> I don't think that's close to true yet for clang-format.
> 
> For instance: clang-format does not do anything with
> missing braces, or coalescing multi-part strings,
> or any number of other nominal coding style defects
> like all the for_each macros, aligning or not aligning
> columnar contents appropriately, etc...
> 
> clang-format as yet has no taste.
> 
> I believe it'll take a lot of work to improve it to a point
> where its formatting is acceptable and appropriate.
.

Just fyi:

Here's the difference that clang-format produces from the current
nvdimm sources to the patch series I posted.

clang-format does some OK, some not OK, some really bad.
(e.g.: __stringify)

My git branch for my patches is 20190911_nvdimm, and
using Stephen Rothwell's git tree for -next:

$ git checkout next-20190904
$ clang-format -i drivers/nvdimm/*.[ch]
$ git diff --stat -p 20190911_nvdimm -- drivers/nvdimm/ > nvdimm.clang-diff
---
 drivers/nvdimm/badrange.c       |  37 ++--
 drivers/nvdimm/blk.c            |  39 ++--
 drivers/nvdimm/btt.c            | 144 +++++++-------
 drivers/nvdimm/btt.h            |  62 +++----
 drivers/nvdimm/btt_devs.c       |  42 ++---
 drivers/nvdimm/bus.c            |  68 ++++---
 drivers/nvdimm/claim.c          |  26 ++-
 drivers/nvdimm/core.c           |  32 ++--
 drivers/nvdimm/dax_devs.c       |   3 +-
 drivers/nvdimm/dimm_devs.c      | 111 ++++++-----
 drivers/nvdimm/e820.c           |   3 +-
 drivers/nvdimm/label.c          | 205 ++++++++++----------
 drivers/nvdimm/label.h          |  35 ++--
 drivers/nvdimm/namespace_devs.c | 403 +++++++++++++++++++---------------------
 drivers/nvdimm/nd-core.h        |  40 ++--
 drivers/nvdimm/nd.h             |  72 ++++---
 drivers/nvdimm/nd_virtio.c      |  19 +-
 drivers/nvdimm/of_pmem.c        |   7 +-
 drivers/nvdimm/pfn_devs.c       | 101 +++++-----
 drivers/nvdimm/pmem.c           |  65 ++++---
 drivers/nvdimm/pmem.h           |  22 +--
 drivers/nvdimm/region.c         |  22 ++-
 drivers/nvdimm/region_devs.c    | 113 +++++------
 drivers/nvdimm/security.c       | 130 +++++++------
 drivers/nvdimm/virtio_pmem.c    |  30 ++-
 25 files changed, 895 insertions(+), 936 deletions(-)

diff --git a/drivers/nvdimm/badrange.c b/drivers/nvdimm/badrange.c
index 4d231643c095..fdd0f5cb873b 100644
--- a/drivers/nvdimm/badrange.c
+++ b/drivers/nvdimm/badrange.c
@@ -24,8 +24,8 @@ void badrange_init(struct badrange *badrange)
 EXPORT_SYMBOL_GPL(badrange_init);
 
 static void append_badrange_entry(struct badrange *badrange,
-				  struct badrange_entry *bre,
-				  u64 addr, u64 length)
+				  struct badrange_entry *bre, u64 addr,
+				  u64 length)
 {
 	lockdep_assert_held(&badrange->lock);
 	bre->start = addr;
@@ -33,8 +33,8 @@ static void append_badrange_entry(struct badrange *badrange,
 	list_add_tail(&bre->list, &badrange->list);
 }
 
-static int alloc_and_append_badrange_entry(struct badrange *badrange,
-					   u64 addr, u64 length, gfp_t flags)
+static int alloc_and_append_badrange_entry(struct badrange *badrange, u64 addr,
+					   u64 length, gfp_t flags)
 {
 	struct badrange_entry *bre;
 
@@ -66,7 +66,7 @@ static int add_badrange(struct badrange *badrange, u64 addr, u64 length)
 	 * This will be the common case as ARS_STATUS returns all known
 	 * errors in the SPA space, and we can't query it per region
 	 */
-	list_for_each_entry(bre, &badrange->list, list)
+	list_for_each_entry (bre, &badrange->list, list)
 		if (bre->start == addr) {
 			/* If length has changed, update this list entry */
 			if (bre->length != length)
@@ -116,13 +116,13 @@ void badrange_forget(struct badrange *badrange, phys_addr_t start,
 	 * split into two based on the overlap characteristics
 	 */
 
-	list_for_each_entry_safe(bre, next, badrange_list, list) {
+	list_for_each_entry_safe (bre, next, badrange_list, list) {
 		u64 bre_end = bre->start + bre->length - 1;
 
 		/* Skip intervals with no intersection */
 		if (bre_end < start)
 			continue;
-		if (bre->start >  clr_end)
+		if (bre->start > clr_end)
 			continue;
 		/* Delete completely overlapped badrange entries */
 		if ((bre->start >= start) && (bre_end <= clr_end)) {
@@ -165,12 +165,12 @@ EXPORT_SYMBOL_GPL(badrange_forget);
 
 static void set_badblock(struct badblocks *bb, sector_t s, int num)
 {
-	dev_dbg(bb->dev, "Found a bad range (0x%llx, 0x%llx)\n",
-		(u64)s * 512, (u64)num * 512);
+	dev_dbg(bb->dev, "Found a bad range (0x%llx, 0x%llx)\n", (u64)s * 512,
+		(u64)num * 512);
 	/* this isn't an error as the hardware will still throw an exception */
 	if (badblocks_set(bb, s, num, 1))
-		dev_info_once(bb->dev, "%s: failed for sector %llx\n",
-			      __func__, (u64)s);
+		dev_info_once(bb->dev, "%s: failed for sector %llx\n", __func__,
+			      (u64)s);
 }
 
 /**
@@ -207,26 +207,25 @@ static void __add_badblock_range(struct badblocks *bb, u64 ns_offset, u64 len)
 			remaining -= done;
 			s += done;
 		}
-	} else {
+	} else
 		set_badblock(bb, start_sector, num_sectors);
-	}
 }
 
-static void badblocks_populate(struct badrange *badrange,
-			       struct badblocks *bb, const struct resource *res)
+static void badblocks_populate(struct badrange *badrange, struct badblocks *bb,
+			       const struct resource *res)
 {
 	struct badrange_entry *bre;
 
 	if (list_empty(&badrange->list))
 		return;
 
-	list_for_each_entry(bre, &badrange->list, list) {
+	list_for_each_entry (bre, &badrange->list, list) {
 		u64 bre_end = bre->start + bre->length - 1;
 
 		/* Discard intervals with no intersection */
 		if (bre_end < res->start)
 			continue;
-		if (bre->start >  res->end)
+		if (bre->start > res->end)
 			continue;
 		/* Deal with any overlap after start of the namespace */
 		if (bre->start >= res->start) {
@@ -236,8 +235,8 @@ static void badblocks_populate(struct badrange *badrange,
 			if (bre_end <= res->end)
 				len = bre->length;
 			else
-				len = res->start + resource_size(res)
-					- bre->start;
+				len = res->start + resource_size(res) -
+				      bre->start;
 			__add_badblock_range(bb, start - res->start, len);
 			continue;
 		}
diff --git a/drivers/nvdimm/blk.c b/drivers/nvdimm/blk.c
index fc15aa9220c8..95281ba56691 100644
--- a/drivers/nvdimm/blk.c
+++ b/drivers/nvdimm/blk.c
@@ -62,12 +62,12 @@ static struct nd_blk_region *to_ndbr(struct nd_namespace_blk *nsblk)
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 static int nd_blk_rw_integrity(struct nd_namespace_blk *nsblk,
-			       struct bio_integrity_payload *bip,
-			       u64 lba, int rw)
+			       struct bio_integrity_payload *bip, u64 lba,
+			       int rw)
 {
 	struct nd_blk_region *ndbr = to_ndbr(nsblk);
 	unsigned int len = nsblk_meta_size(nsblk);
-	resource_size_t	dev_offset, ns_offset;
+	resource_size_t dev_offset, ns_offset;
 	u32 internal_lbasize, sector_size;
 	int err = 0;
 
@@ -109,8 +109,8 @@ static int nd_blk_rw_integrity(struct nd_namespace_blk *nsblk,
 
 #else /* CONFIG_BLK_DEV_INTEGRITY */
 static int nd_blk_rw_integrity(struct nd_namespace_blk *nsblk,
-			       struct bio_integrity_payload *bip,
-			       u64 lba, int rw)
+			       struct bio_integrity_payload *bip, u64 lba,
+			       int rw)
 {
 	return 0;
 }
@@ -122,7 +122,7 @@ static int nsblk_do_bvec(struct nd_namespace_blk *nsblk,
 			 sector_t sector)
 {
 	struct nd_blk_region *ndbr = to_ndbr(nsblk);
-	resource_size_t	dev_offset, ns_offset;
+	resource_size_t dev_offset, ns_offset;
 	u32 internal_lbasize, sector_size;
 	int err = 0;
 	void *iobuf;
@@ -183,7 +183,7 @@ static blk_qc_t nd_blk_make_request(struct request_queue *q, struct bio *bio)
 	nsblk = q->queuedata;
 	rw = bio_data_dir(bio);
 	do_acct = nd_iostat_start(bio, &start);
-	bio_for_each_segment(bvec, bio, iter) {
+	bio_for_each_segment (bvec, bio, iter) {
 		unsigned int len = bvec.bv_len;
 
 		BUG_ON(len > PAGE_SIZE);
@@ -191,9 +191,9 @@ static blk_qc_t nd_blk_make_request(struct request_queue *q, struct bio *bio)
 				    bvec.bv_offset, rw, iter.bi_sector);
 		if (err) {
 			dev_dbg(&nsblk->common.dev,
-				"io error in %s sector %lld, len %d\n",
-				rw == READ ? "READ" : "WRITE",
-				(u64)iter.bi_sector, len);
+				"io error in %s sector %lld, len %d,\n",
+				(rw == READ) ? "READ" : "WRITE",
+				(unsigned long long)iter.bi_sector, len);
 			bio->bi_status = errno_to_blk_status(err);
 			break;
 		}
@@ -211,7 +211,7 @@ static int nsblk_rw_bytes(struct nd_namespace_common *ndns,
 {
 	struct nd_namespace_blk *nsblk = to_nd_namespace_blk(&ndns->dev);
 	struct nd_blk_region *ndbr = to_ndbr(nsblk);
-	resource_size_t	dev_offset;
+	resource_size_t dev_offset;
 
 	dev_offset = to_dev_offset(nsblk, offset, n);
 
@@ -269,10 +269,10 @@ static int nsblk_attach_disk(struct nd_namespace_blk *nsblk)
 	if (!disk)
 		return -ENOMEM;
 
-	disk->first_minor	= 0;
-	disk->fops		= &nd_blk_fops;
-	disk->queue		= q;
-	disk->flags		= GENHD_FL_EXT_DEVT;
+	disk->first_minor = 0;
+	disk->fops = &nd_blk_fops;
+	disk->queue = q;
+	disk->flags = GENHD_FL_EXT_DEVT;
 	nvdimm_namespace_disk_name(&nsblk->common, disk->disk_name);
 
 	if (devm_add_action_or_reset(dev, nd_blk_release_disk, disk))
@@ -305,16 +305,13 @@ static int nd_blk_probe(struct device *dev)
 	dev_set_drvdata(dev, nsblk);
 
 	ndns->rw_bytes = nsblk_rw_bytes;
-
 	if (is_nd_btt(dev))
 		return nvdimm_namespace_attach_btt(ndns);
-
-	if (nd_btt_probe(dev, ndns) == 0) {
+	else if (nd_btt_probe(dev, ndns) == 0) {
 		/* we'll come back as btt-blk */
 		return -ENXIO;
-	}
-
-	return nsblk_attach_disk(nsblk);
+	} else
+		return nsblk_attach_disk(nsblk);
 }
 
 static int nd_blk_remove(struct device *dev)
diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 6c18d7bba6af..b4281d91d70b 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -19,10 +19,7 @@
 #include "btt.h"
 #include "nd.h"
 
-enum log_ent_request {
-	LOG_NEW_ENT = 0,
-	LOG_OLD_ENT
-};
+enum log_ent_request { LOG_NEW_ENT = 0, LOG_OLD_ENT };
 
 static struct device *to_dev(struct arena_info *arena)
 {
@@ -206,9 +203,8 @@ static int btt_map_read(struct arena_info *arena, u32 lba, u32 *mapping,
 static int btt_log_group_read(struct arena_info *arena, u32 lane,
 			      struct log_group *log)
 {
-	return arena_read_bytes(arena,
-				arena->logoff + (lane * LOG_GRP_SIZE), log,
-				LOG_GRP_SIZE, 0);
+	return arena_read_bytes(arena, arena->logoff + (lane * LOG_GRP_SIZE),
+				log, LOG_GRP_SIZE, 0);
 }
 
 static struct dentry *debugfs_root;
@@ -229,24 +225,27 @@ static void arena_debugfs_init(struct arena_info *a, struct dentry *parent,
 		return;
 	a->debugfs_dir = d;
 
-	debugfs_create_x64("size", 0444, d, &a->size);
-	debugfs_create_x64("external_lba_start", 0444, d, &a->external_lba_start);
-	debugfs_create_x32("internal_nlba", 0444, d, &a->internal_nlba);
-	debugfs_create_u32("internal_lbasize", 0444, d, &a->internal_lbasize);
-	debugfs_create_x32("external_nlba", 0444, d, &a->external_nlba);
-	debugfs_create_u32("external_lbasize", 0444, d, &a->external_lbasize);
-	debugfs_create_u32("nfree", 0444, d, &a->nfree);
-	debugfs_create_u16("version_major", 0444, d, &a->version_major);
-	debugfs_create_u16("version_minor", 0444, d, &a->version_minor);
-	debugfs_create_x64("nextoff", 0444, d, &a->nextoff);
-	debugfs_create_x64("infooff", 0444, d, &a->infooff);
-	debugfs_create_x64("dataoff", 0444, d, &a->dataoff);
-	debugfs_create_x64("mapoff", 0444, d, &a->mapoff);
-	debugfs_create_x64("logoff", 0444, d, &a->logoff);
-	debugfs_create_x64("info2off", 0444, d, &a->info2off);
-	debugfs_create_x32("flags", 0444, d, &a->flags);
-	debugfs_create_u32("log_index_0", 0444, d, &a->log_index[0]);
-	debugfs_create_u32("log_index_1", 0444, d, &a->log_index[1]);
+	debugfs_create_x64("size", S_IRUGO, d, &a->size);
+	debugfs_create_x64("external_lba_start", S_IRUGO, d,
+			   &a->external_lba_start);
+	debugfs_create_x32("internal_nlba", S_IRUGO, d, &a->internal_nlba);
+	debugfs_create_u32("internal_lbasize", S_IRUGO, d,
+			   &a->internal_lbasize);
+	debugfs_create_x32("external_nlba", S_IRUGO, d, &a->external_nlba);
+	debugfs_create_u32("external_lbasize", S_IRUGO, d,
+			   &a->external_lbasize);
+	debugfs_create_u32("nfree", S_IRUGO, d, &a->nfree);
+	debugfs_create_u16("version_major", S_IRUGO, d, &a->version_major);
+	debugfs_create_u16("version_minor", S_IRUGO, d, &a->version_minor);
+	debugfs_create_x64("nextoff", S_IRUGO, d, &a->nextoff);
+	debugfs_create_x64("infooff", S_IRUGO, d, &a->infooff);
+	debugfs_create_x64("dataoff", S_IRUGO, d, &a->dataoff);
+	debugfs_create_x64("mapoff", S_IRUGO, d, &a->mapoff);
+	debugfs_create_x64("logoff", S_IRUGO, d, &a->logoff);
+	debugfs_create_x64("info2off", S_IRUGO, d, &a->info2off);
+	debugfs_create_x32("flags", S_IRUGO, d, &a->flags);
+	debugfs_create_u32("log_index_0", S_IRUGO, d, &a->log_index[0]);
+	debugfs_create_u32("log_index_1", S_IRUGO, d, &a->log_index[1]);
 }
 
 static void btt_debugfs_init(struct btt *btt)
@@ -254,12 +253,12 @@ static void btt_debugfs_init(struct btt *btt)
 	int i = 0;
 	struct arena_info *arena;
 
-	btt->debugfs_dir = debugfs_create_dir(dev_name(&btt->nd_btt->dev),
-					      debugfs_root);
+	btt->debugfs_dir =
+		debugfs_create_dir(dev_name(&btt->nd_btt->dev), debugfs_root);
 	if (IS_ERR_OR_NULL(btt->debugfs_dir))
 		return;
 
-	list_for_each_entry(arena, &btt->arena_list, list) {
+	list_for_each_entry (arena, &btt->arena_list, list) {
 		arena_debugfs_init(arena, btt->debugfs_dir, i);
 		i++;
 	}
@@ -335,8 +334,8 @@ static int btt_log_read(struct arena_info *arena, u32 lane,
 	old_ent = btt_log_get_old(arena, &log);
 	if (old_ent < 0 || old_ent > 1) {
 		dev_err(to_dev(arena),
-			"log corruption (%d): lane %d seq [%d, %d]\n",
-			old_ent, lane, log.ent[arena->log_index[0]].seq,
+			"log corruption (%d): lane %d seq [%d, %d]\n", old_ent,
+			lane, log.ent[arena->log_index[0]].seq,
 			log.ent[arena->log_index[1]].seq);
 		/* TODO set error state? */
 		return -EIO;
@@ -355,8 +354,8 @@ static int btt_log_read(struct arena_info *arena, u32 lane,
  * It does _not_ prepare the freelist entry for the next write
  * btt_flog_write is the wrapper for updating the freelist elements
  */
-static int __btt_log_write(struct arena_info *arena, u32 lane,
-			   u32 sub, struct log_entry *ent, unsigned long flags)
+static int __btt_log_write(struct arena_info *arena, u32 lane, u32 sub,
+			   struct log_entry *ent, unsigned long flags)
 {
 	int ret;
 	u32 group_slot = arena->log_index[sub];
@@ -365,7 +364,7 @@ static int __btt_log_write(struct arena_info *arena, u32 lane,
 	u64 ns_off;
 
 	ns_off = arena->logoff + (lane * LOG_GRP_SIZE) +
-		(group_slot * LOG_ENT_SIZE);
+		 (group_slot * LOG_ENT_SIZE);
 	/* split the 16B write into atomic, durable halves */
 	ret = arena_write_bytes(arena, ns_off, src, log_half, flags);
 	if (ret)
@@ -514,8 +513,8 @@ static int arena_clear_freelist_error(struct arena_info *arena, u32 lane)
 		while (len) {
 			unsigned long chunk = min(len, PAGE_SIZE);
 
-			ret = arena_write_bytes(arena, nsoff, zero_page,
-						chunk, 0);
+			ret = arena_write_bytes(arena, nsoff, zero_page, chunk,
+						0);
 			if (ret)
 				break;
 			len -= chunk;
@@ -534,8 +533,8 @@ static int btt_freelist_init(struct arena_info *arena)
 	struct log_entry log_new;
 	u32 i, map_entry, log_oldmap, log_newmap;
 
-	arena->freelist = kcalloc(arena->nfree, sizeof(struct free_entry),
-				  GFP_KERNEL);
+	arena->freelist =
+		kcalloc(arena->nfree, sizeof(struct free_entry), GFP_KERNEL);
 	if (!arena->freelist)
 		return -ENOMEM;
 
@@ -562,8 +561,9 @@ static int btt_freelist_init(struct arena_info *arena)
 			arena->freelist[i].has_err = 1;
 			ret = arena_clear_freelist_error(arena, i);
 			if (ret)
-				dev_err_ratelimited(to_dev(arena),
-						    "Unable to clear known errors\n");
+				dev_err_ratelimited(
+					to_dev(arena),
+					"Unable to clear known errors\n");
 		}
 
 		/* This implies a newly created or untouched flog entry */
@@ -589,8 +589,8 @@ static int btt_freelist_init(struct arena_info *arena)
 			 * to complete the map write. So fix up the map.
 			 */
 			ret = btt_map_write(arena, le32_to_cpu(log_new.lba),
-					    le32_to_cpu(log_new.new_map),
-					    0, 0, 0);
+					    le32_to_cpu(log_new.new_map), 0, 0,
+					    0);
 			if (ret)
 				return ret;
 		}
@@ -601,9 +601,8 @@ static int btt_freelist_init(struct arena_info *arena)
 
 static bool ent_is_padding(struct log_entry *ent)
 {
-	return (ent->lba == 0) &&
-		(ent->old_map == 0) && (ent->new_map == 0) &&
-		(ent->seq == 0);
+	return (ent->lba == 0) && (ent->old_map == 0) && (ent->new_map == 0) &&
+	       (ent->seq == 0);
 }
 
 /*
@@ -622,7 +621,7 @@ static bool ent_is_padding(struct log_entry *ent)
 static int log_set_indices(struct arena_info *arena)
 {
 	bool idx_set = false, initial_state = true;
-	int ret, log_index[2] = {-1, -1};
+	int ret, log_index[2] = { -1, -1 };
 	u32 i, j, next_idx = 0;
 	struct log_group log;
 	u32 pad_count = 0;
@@ -703,10 +702,9 @@ static int log_set_indices(struct arena_info *arena)
 	 * Only allow the known permutations of log/padding indices,
 	 * i.e. (0, 1), and (0, 2)
 	 */
-	if ((log_index[0] == 0) &&
-	    ((log_index[1] == 1) || (log_index[1] == 2))) {
+	if ((log_index[0] == 0) && ((log_index[1] == 1) || (log_index[1] == 2)))
 		; /* known index possibilities */
-	} else {
+	else {
 		dev_err(to_dev(arena), "Found an unknown padding scheme\n");
 		return -ENXIO;
 	}
@@ -731,8 +729,8 @@ static int btt_maplocks_init(struct arena_info *arena)
 {
 	u32 i;
 
-	arena->map_locks = kcalloc(arena->nfree, sizeof(struct aligned_lock),
-				   GFP_KERNEL);
+	arena->map_locks =
+		kcalloc(arena->nfree, sizeof(struct aligned_lock), GFP_KERNEL);
 	if (!arena->map_locks)
 		return -ENOMEM;
 
@@ -762,8 +760,8 @@ static struct arena_info *alloc_arena(struct btt *btt, size_t size,
 	arena->size = size;
 	arena->external_lba_start = start;
 	arena->external_lbasize = btt->lbasize;
-	arena->internal_lbasize = roundup(arena->external_lbasize,
-					  INT_LBASIZE_ALIGNMENT);
+	arena->internal_lbasize =
+		roundup(arena->external_lbasize, INT_LBASIZE_ALIGNMENT);
 	arena->nfree = BTT_DEFAULT_NFREE;
 	arena->version_major = btt->nd_btt->version_major;
 	arena->version_minor = btt->nd_btt->version_minor;
@@ -803,7 +801,7 @@ static void free_arenas(struct btt *btt)
 {
 	struct arena_info *arena, *next;
 
-	list_for_each_entry_safe(arena, next, &btt->arena_list, list) {
+	list_for_each_entry_safe (arena, next, &btt->arena_list, list) {
 		list_del(&arena->list);
 		kfree(arena->rtt);
 		kfree(arena->map_locks);
@@ -828,18 +826,18 @@ static void parse_arena_meta(struct arena_info *arena, struct btt_sb *super,
 	arena->version_major = le16_to_cpu(super->version_major);
 	arena->version_minor = le16_to_cpu(super->version_minor);
 
-	arena->nextoff = (super->nextoff == 0)
-		? 0
-		: arena_off + le64_to_cpu(super->nextoff);
+	arena->nextoff = (super->nextoff == 0) ?
+				 0 :
+				 (arena_off + le64_to_cpu(super->nextoff));
 	arena->infooff = arena_off;
 	arena->dataoff = arena_off + le64_to_cpu(super->dataoff);
 	arena->mapoff = arena_off + le64_to_cpu(super->mapoff);
 	arena->logoff = arena_off + le64_to_cpu(super->logoff);
 	arena->info2off = arena_off + le64_to_cpu(super->info2off);
 
-	arena->size = (le64_to_cpu(super->nextoff) > 0)
-		? le64_to_cpu(super->nextoff)
-		: arena->info2off - arena->infooff + BTT_PG_SIZE;
+	arena->size = (le64_to_cpu(super->nextoff) > 0) ?
+			      (le64_to_cpu(super->nextoff)) :
+			      (arena->info2off - arena->infooff + BTT_PG_SIZE);
 
 	arena->flags = le32_to_cpu(super->flags);
 }
@@ -1029,7 +1027,7 @@ static int btt_meta_init(struct btt *btt)
 	struct arena_info *arena;
 
 	mutex_lock(&btt->init_lock);
-	list_for_each_entry(arena, &btt->arena_list, list) {
+	list_for_each_entry (arena, &btt->arena_list, list) {
 		ret = btt_arena_write_layout(arena);
 		if (ret)
 			goto unlock;
@@ -1072,7 +1070,7 @@ static int lba_to_arena(struct btt *btt, sector_t sector, __u32 *premap,
 	struct arena_info *arena_list;
 	__u64 lba = div_u64(sector << SECTOR_SHIFT, btt->sector_size);
 
-	list_for_each_entry(arena_list, &btt->arena_list, list) {
+	list_for_each_entry (arena_list, &btt->arena_list, list) {
 		if (lba < arena_list->external_nlba) {
 			*arena = arena_list;
 			*premap = lba;
@@ -1117,8 +1115,8 @@ static int btt_data_read(struct arena_info *arena, struct page *page,
 	return ret;
 }
 
-static int btt_data_write(struct arena_info *arena, u32 lba,
-			  struct page *page, unsigned int off, u32 len)
+static int btt_data_write(struct arena_info *arena, u32 lba, struct page *page,
+			  unsigned int off, u32 len)
 {
 	int ret;
 	u64 nsoff = to_namespace_offset(arena, lba);
@@ -1322,7 +1320,7 @@ static int btt_write_pg(struct btt *btt, struct bio_integrity_payload *bip,
 		u32 cur_len;
 		int e_flag;
 
-retry:
+	retry:
 		lane = nd_region_acquire_lane(btt->nd_region);
 
 		ret = lba_to_arena(btt, sector, &premap, &arena);
@@ -1453,7 +1451,7 @@ static blk_qc_t btt_make_request(struct request_queue *q, struct bio *bio)
 		return BLK_QC_T_NONE;
 
 	do_acct = nd_iostat_start(bio, &start);
-	bio_for_each_segment(bvec, bio, iter) {
+	bio_for_each_segment (bvec, bio, iter) {
 		unsigned int len = bvec.bv_len;
 
 		if (len > PAGE_SIZE || len < btt->sector_size ||
@@ -1469,9 +1467,9 @@ static blk_qc_t btt_make_request(struct request_queue *q, struct bio *bio)
 				  bio_op(bio), iter.bi_sector);
 		if (err) {
 			dev_err(&btt->nd_btt->dev,
-				"io error in %s sector %lld, len %d\n",
-				op_is_write(bio_op(bio)) ? "WRITE" : "READ",
-				(u64)iter.bi_sector, len);
+				"io error in %s sector %lld, len %d,\n",
+				(op_is_write(bio_op(bio))) ? "WRITE" : "READ",
+				(unsigned long long)iter.bi_sector, len);
 			bio->bi_status = errno_to_blk_status(err);
 			break;
 		}
@@ -1508,10 +1506,10 @@ static int btt_getgeo(struct block_device *bd, struct hd_geometry *geo)
 }
 
 static const struct block_device_operations btt_fops = {
-	.owner =		THIS_MODULE,
-	.rw_page =		btt_rw_page,
-	.getgeo =		btt_getgeo,
-	.revalidate_disk =	nvdimm_revalidate_disk,
+	.owner = THIS_MODULE,
+	.rw_page = btt_rw_page,
+	.getgeo = btt_getgeo,
+	.revalidate_disk = nvdimm_revalidate_disk,
 };
 
 static int btt_blk_init(struct btt *btt)
@@ -1621,7 +1619,7 @@ static struct btt *btt_init(struct nd_btt *nd_btt, unsigned long long rawsize,
 		return NULL;
 	} else if (btt->init_state != INIT_READY) {
 		btt->num_arenas = (rawsize / ARENA_MAX_SIZE) +
-			((rawsize % ARENA_MAX_SIZE) ? 1 : 0);
+				  ((rawsize % ARENA_MAX_SIZE) ? 1 : 0);
 		dev_dbg(dev, "init: %d arenas for %llu rawsize\n",
 			btt->num_arenas, rawsize);
 
diff --git a/drivers/nvdimm/btt.h b/drivers/nvdimm/btt.h
index fb0f4546153f..e514a1380157 100644
--- a/drivers/nvdimm/btt.h
+++ b/drivers/nvdimm/btt.h
@@ -10,40 +10,36 @@
 #include <linux/badblocks.h>
 #include <linux/types.h>
 
-#define BTT_SIG_LEN		16
-#define BTT_SIG			"BTT_ARENA_INFO\0"
-#define MAP_ENT_SIZE		4
-#define MAP_TRIM_SHIFT		31
-#define MAP_TRIM_MASK		BIT(MAP_TRIM_SHIFT)
-#define MAP_ERR_SHIFT		30
-#define MAP_ERR_MASK		BIT(MAP_ERR_SHIFT)
-#define MAP_LBA_MASK		(~(MAP_TRIM_MASK | MAP_ERR_MASK))
-#define MAP_ENT_NORMAL		0xC0000000
-#define LOG_GRP_SIZE		sizeof(struct log_group)
-#define LOG_ENT_SIZE		sizeof(struct log_entry)
-#define ARENA_MIN_SIZE		BIT(24)		/* 16 MB */
-#define ARENA_MAX_SIZE		BIT_ULL(39)	/* 512 GB */
-#define RTT_VALID		BIT(31)
-#define RTT_INVALID		0
-#define BTT_PG_SIZE		4096
-#define BTT_DEFAULT_NFREE	ND_MAX_LANES
-#define LOG_SEQ_INIT		1
-
-#define IB_FLAG_ERROR		0x00000001
-#define IB_FLAG_ERROR_MASK	0x00000001
-
-#define ent_lba(ent)		((ent) & MAP_LBA_MASK)
-#define ent_e_flag(ent)		(!!((ent) & MAP_ERR_MASK))
-#define ent_z_flag(ent)		(!!((ent) & MAP_TRIM_MASK))
-#define set_e_flag(ent)		((ent) |= MAP_ERR_MASK)
+#define BTT_SIG_LEN 16
+#define BTT_SIG "BTT_ARENA_INFO\0"
+#define MAP_ENT_SIZE 4
+#define MAP_TRIM_SHIFT 31
+#define MAP_TRIM_MASK (1 << MAP_TRIM_SHIFT)
+#define MAP_ERR_SHIFT 30
+#define MAP_ERR_MASK (1 << MAP_ERR_SHIFT)
+#define MAP_LBA_MASK (~((1 << MAP_TRIM_SHIFT) | (1 << MAP_ERR_SHIFT)))
+#define MAP_ENT_NORMAL 0xC0000000
+#define LOG_GRP_SIZE sizeof(struct log_group)
+#define LOG_ENT_SIZE sizeof(struct log_entry)
+#define ARENA_MIN_SIZE (1UL << 24) /* 16 MB */
+#define ARENA_MAX_SIZE (1ULL << 39) /* 512 GB */
+#define RTT_VALID (1UL << 31)
+#define RTT_INVALID 0
+#define BTT_PG_SIZE 4096
+#define BTT_DEFAULT_NFREE ND_MAX_LANES
+#define LOG_SEQ_INIT 1
+
+#define IB_FLAG_ERROR 0x00000001
+#define IB_FLAG_ERROR_MASK 0x00000001
+
+#define ent_lba(ent) (ent & MAP_LBA_MASK)
+#define ent_e_flag(ent) (!!(ent & MAP_ERR_MASK))
+#define ent_z_flag(ent) (!!(ent & MAP_TRIM_MASK))
+#define set_e_flag(ent) (ent |= MAP_ERR_MASK)
 /* 'normal' is both e and z flags set */
-#define ent_normal(ent)		(ent_e_flag(ent) && ent_z_flag(ent))
+#define ent_normal(ent) (ent_e_flag(ent) && ent_z_flag(ent))
 
-enum btt_init_state {
-	INIT_UNCHECKED = 0,
-	INIT_NOTFOUND,
-	INIT_READY
-};
+enum btt_init_state { INIT_UNCHECKED = 0, INIT_NOTFOUND, INIT_READY };
 
 /*
  * A log group represents one log 'lane', and consists of four log entries.
@@ -167,7 +163,7 @@ struct aligned_lock {
  * IO, this struct is passed around for the duration of the IO.
  */
 struct arena_info {
-	u64 size;			/* Total bytes for this arena */
+	u64 size; /* Total bytes for this arena */
 	u64 external_lba_start;
 	u32 internal_nlba;
 	u32 internal_lbasize;
diff --git a/drivers/nvdimm/btt_devs.c b/drivers/nvdimm/btt_devs.c
index b27993ade004..2d24d3408152 100644
--- a/drivers/nvdimm/btt_devs.c
+++ b/drivers/nvdimm/btt_devs.c
@@ -45,9 +45,8 @@ struct nd_btt *to_nd_btt(struct device *dev)
 }
 EXPORT_SYMBOL(to_nd_btt);
 
-static const unsigned long btt_lbasize_supported[] = {
-	512, 520, 528, 4096, 4104, 4160, 4224, 0
-};
+static const unsigned long btt_lbasize_supported[] = { 512,  520,  528,	 4096,
+						       4104, 4160, 4224, 0 };
 
 static ssize_t sector_size_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -58,8 +57,8 @@ static ssize_t sector_size_show(struct device *dev,
 }
 
 static ssize_t sector_size_store(struct device *dev,
-				 struct device_attribute *attr,
-				 const char *buf, size_t len)
+				 struct device_attribute *attr, const char *buf,
+				 size_t len)
 {
 	struct nd_btt *nd_btt = to_nd_btt(dev);
 	ssize_t rc;
@@ -68,8 +67,8 @@ static ssize_t sector_size_store(struct device *dev,
 	nvdimm_bus_lock(dev);
 	rc = nd_size_select_store(dev, buf, &nd_btt->lbasize,
 				  btt_lbasize_supported);
-	dev_dbg(dev, "result: %zd wrote: %s%s",
-		rc, buf, buf[len - 1] == '\n' ? "" : "\n");
+	dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
+		buf[len - 1] == '\n' ? "" : "\n");
 	nvdimm_bus_unlock(dev);
 	nd_device_unlock(dev);
 
@@ -77,8 +76,8 @@ static ssize_t sector_size_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(sector_size);
 
-static ssize_t uuid_show(struct device *dev,
-			 struct device_attribute *attr, char *buf)
+static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
 {
 	struct nd_btt *nd_btt = to_nd_btt(dev);
 
@@ -95,8 +94,8 @@ static ssize_t uuid_store(struct device *dev, struct device_attribute *attr,
 
 	nd_device_lock(dev);
 	rc = nd_uuid_store(dev, &nd_btt->uuid, buf, len);
-	dev_dbg(dev, "result: %zd wrote: %s%s",
-		rc, buf, buf[len - 1] == '\n' ? "" : "\n");
+	dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
+		buf[len - 1] == '\n' ? "" : "\n");
 	nd_device_unlock(dev);
 
 	return rc ? rc : len;
@@ -117,8 +116,8 @@ static ssize_t namespace_show(struct device *dev, struct device_attribute *attr,
 }
 
 static ssize_t namespace_store(struct device *dev,
-			       struct device_attribute *attr,
-			       const char *buf, size_t len)
+			       struct device_attribute *attr, const char *buf,
+			       size_t len)
 {
 	struct nd_btt *nd_btt = to_nd_btt(dev);
 	ssize_t rc;
@@ -126,8 +125,8 @@ static ssize_t namespace_store(struct device *dev,
 	nd_device_lock(dev);
 	nvdimm_bus_lock(dev);
 	rc = nd_namespace_store(dev, &nd_btt->ndns, buf, len);
-	dev_dbg(dev, "result: %zd wrote: %s%s",
-		rc, buf, buf[len - 1] == '\n' ? "" : "\n");
+	dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
+		buf[len - 1] == '\n' ? "" : "\n");
 	nvdimm_bus_unlock(dev);
 	nd_device_unlock(dev);
 
@@ -142,9 +141,9 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
 	ssize_t rc;
 
 	nd_device_lock(dev);
-	if (dev->driver) {
+	if (dev->driver)
 		rc = sprintf(buf, "%llu\n", nd_btt->size);
-	} else {
+	else {
 		/* no size to convey if the btt instance is disabled */
 		rc = -ENXIO;
 	}
@@ -162,12 +161,9 @@ static ssize_t log_zero_flags_show(struct device *dev,
 static DEVICE_ATTR_RO(log_zero_flags);
 
 static struct attribute *nd_btt_attributes[] = {
-	&dev_attr_sector_size.attr,
-	&dev_attr_namespace.attr,
-	&dev_attr_uuid.attr,
-	&dev_attr_size.attr,
-	&dev_attr_log_zero_flags.attr,
-	NULL,
+	&dev_attr_sector_size.attr,    &dev_attr_namespace.attr,
+	&dev_attr_uuid.attr,	       &dev_attr_size.attr,
+	&dev_attr_log_zero_flags.attr, NULL,
 };
 
 static struct attribute_group nd_btt_attribute_group = {
diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 733b2a2117c0..b159138d5490 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -2,9 +2,7 @@
 /*
  * Copyright(c) 2013-2015 Intel Corporation. All rights reserved.
  */
-
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/libnvdimm.h>
 #include <linux/sched/mm.h>
 #include <linux/vmalloc.h>
@@ -89,8 +87,8 @@ static int nvdimm_bus_probe(struct device *dev)
 	if (!try_module_get(provider))
 		return -ENXIO;
 
-	dev_dbg(&nvdimm_bus->dev, "START: %s.probe(%s)\n",
-		dev->driver->name, dev_name(dev));
+	dev_dbg(&nvdimm_bus->dev, "START: %s.probe(%s)\n", dev->driver->name,
+		dev_name(dev));
 
 	nvdimm_bus_probe_start(nvdimm_bus);
 	debug_nvdimm_lock(dev);
@@ -103,8 +101,8 @@ static int nvdimm_bus_probe(struct device *dev)
 		nd_region_disable(nvdimm_bus, dev);
 	nvdimm_bus_probe_end(nvdimm_bus);
 
-	dev_dbg(&nvdimm_bus->dev, "END: %s.probe(%s) = %d\n",
-		dev->driver->name, dev_name(dev), rc);
+	dev_dbg(&nvdimm_bus->dev, "END: %s.probe(%s) = %d\n", dev->driver->name,
+		dev_name(dev), rc);
 
 	if (rc != 0)
 		module_put(provider);
@@ -125,8 +123,8 @@ static int nvdimm_bus_remove(struct device *dev)
 	}
 	nd_region_disable(nvdimm_bus, dev);
 
-	dev_dbg(&nvdimm_bus->dev, "%s.remove(%s) = %d\n",
-		dev->driver->name, dev_name(dev), rc);
+	dev_dbg(&nvdimm_bus->dev, "%s.remove(%s) = %d\n", dev->driver->name,
+		dev_name(dev), rc);
 	module_put(provider);
 	return rc;
 }
@@ -226,8 +224,7 @@ static void nvdimm_account_cleared_poison(struct nvdimm_bus *nvdimm_bus,
 		nvdimm_clear_badblocks_regions(nvdimm_bus, phys, cleared);
 }
 
-long nvdimm_clear_poison(struct device *dev, phys_addr_t phys,
-			 unsigned int len)
+long nvdimm_clear_poison(struct device *dev, phys_addr_t phys, unsigned int len)
 {
 	struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(dev);
 	struct nvdimm_bus_descriptor *nd_desc;
@@ -419,7 +416,7 @@ static void free_badrange_list(struct list_head *badrange_list)
 {
 	struct badrange_entry *bre, *next;
 
-	list_for_each_entry_safe(bre, next, badrange_list, list) {
+	list_for_each_entry_safe (bre, next, badrange_list, list) {
 		list_del(&bre->list);
 		kfree(bre);
 	}
@@ -677,8 +674,8 @@ struct attribute_group nd_device_attribute_group = {
 };
 EXPORT_SYMBOL_GPL(nd_device_attribute_group);
 
-static ssize_t numa_node_show(struct device *dev,
-			      struct device_attribute *attr, char *buf)
+static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
 {
 	return sprintf(buf, "%d\n", dev_to_node(dev));
 }
@@ -858,9 +855,9 @@ u32 nd_cmd_out_size(struct nvdimm *nvdimm, int cmd,
 
 	if (nvdimm && cmd == ND_CMD_GET_CONFIG_DATA && idx == 1)
 		return in_field[1];
-	if (nvdimm && cmd == ND_CMD_VENDOR && idx == 2)
+	else if (nvdimm && cmd == ND_CMD_VENDOR && idx == 2)
 		return out_field[1];
-	if (!nvdimm && cmd == ND_CMD_ARS_STATUS && idx == 2) {
+	else if (!nvdimm && cmd == ND_CMD_ARS_STATUS && idx == 2) {
 		/*
 		 * Per table 9-276 ARS Data in ACPI 6.1, out_field[1] is
 		 * "Size of Output Buffer in bytes, including this
@@ -877,8 +874,7 @@ u32 nd_cmd_out_size(struct nvdimm *nvdimm, int cmd,
 		if (out_field[1] - 4 == remainder)
 			return remainder;
 		return out_field[1] - 8;
-	}
-	if (cmd == ND_CMD_CALL) {
+	} else if (cmd == ND_CMD_CALL) {
 		struct nd_cmd_pkg *pkg = (struct nd_cmd_pkg *)in_field;
 
 		return pkg->nd_size_out;
@@ -897,8 +893,7 @@ void wait_nvdimm_bus_probe_idle(struct device *dev)
 			break;
 		nvdimm_bus_unlock(dev);
 		nd_device_unlock(dev);
-		wait_event(nvdimm_bus->wait,
-			   nvdimm_bus->probe_active == 0);
+		wait_event(nvdimm_bus->wait, nvdimm_bus->probe_active == 0);
 		nd_device_lock(dev);
 		nvdimm_bus_lock(dev);
 	} while (true);
@@ -931,9 +926,8 @@ static int nd_pmem_forget_poison_check(struct device *dev, void *data)
 
 		if (!ndns)
 			return 0;
-	} else {
+	} else
 		ndns = to_ndns(dev);
-	}
 
 	nsio = to_nd_namespace_io(&ndns->dev);
 	pstart = nsio->res.start + offset;
@@ -952,8 +946,8 @@ static int nd_ns_forget_poison_check(struct device *dev, void *data)
 
 /* set_config requires an idle interleave set */
 static int nd_cmd_clear_to_send(struct nvdimm_bus *nvdimm_bus,
-				struct nvdimm *nvdimm,
-				unsigned int cmd, void *data)
+				struct nvdimm *nvdimm, unsigned int cmd,
+				void *data)
 {
 	struct nvdimm_bus_descriptor *nd_desc = nvdimm_bus->nd_desc;
 
@@ -1027,9 +1021,9 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
 		case ND_CMD_ARS_START:
 		case ND_CMD_CLEAR_ERROR:
 		case ND_CMD_CALL:
-			dev_dbg(dev, "'%s' command while read-only\n",
-				nvdimm ? nvdimm_cmd_name(cmd)
-				: nvdimm_bus_cmd_name(cmd));
+			dev_dbg(dev, "'%s' command while read-only.\n",
+				nvdimm ? nvdimm_cmd_name(cmd) :
+					 nvdimm_bus_cmd_name(cmd));
 			return -EPERM;
 		default:
 			break;
@@ -1044,13 +1038,15 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
 
 		in_size = nd_cmd_in_size(nvdimm, cmd, desc, i, in_env);
 		if (in_size == UINT_MAX) {
-			dev_err(dev, "%s:%s unknown input size cmd: %s field: %d\n",
+			dev_err(dev,
+				"%s:%s unknown input size cmd: %s field: %d\n",
 				__func__, dimm_name, cmd_name, i);
 			rc = -ENXIO;
 			goto out;
 		}
 		if (in_len < ND_CMD_MAX_ENVELOPE)
-			copy = min_t(u32, ND_CMD_MAX_ENVELOPE - in_len, in_size);
+			copy = min_t(u32, ND_CMD_MAX_ENVELOPE - in_len,
+				     in_size);
 		else
 			copy = 0;
 		if (copy && copy_from_user(&in_env[in_len], p + in_len, copy)) {
@@ -1074,18 +1070,20 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
 	}
 
 	for (i = 0; i < desc->out_num; i++) {
-		u32 out_size = nd_cmd_out_size(nvdimm, cmd, desc, i,
-					       (u32 *)in_env, (u32 *)out_env, 0);
+		u32 out_size = nd_cmd_out_size(
+			nvdimm, cmd, desc, i, (u32 *)in_env, (u32 *)out_env, 0);
 		u32 copy;
 
 		if (out_size == UINT_MAX) {
-			dev_dbg(dev, "%s unknown output size cmd: %s field: %d\n",
+			dev_dbg(dev,
+				"%s unknown output size cmd: %s field: %d\n",
 				dimm_name, cmd_name, i);
 			rc = -EFAULT;
 			goto out;
 		}
 		if (out_len < ND_CMD_MAX_ENVELOPE)
-			copy = min_t(u32, ND_CMD_MAX_ENVELOPE - out_len, out_size);
+			copy = min_t(u32, ND_CMD_MAX_ENVELOPE - out_len,
+				     out_size);
 		else
 			copy = 0;
 		if (copy && copy_from_user(&out_env[out_len],
@@ -1098,8 +1096,8 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
 
 	buf_len = (u64)out_len + (u64)in_len;
 	if (buf_len > ND_IOCTL_MAX_BUFLEN) {
-		dev_dbg(dev, "%s cmd: %s buf_len: %llu > %d\n",
-			dimm_name, cmd_name, buf_len, ND_IOCTL_MAX_BUFLEN);
+		dev_dbg(dev, "%s cmd: %s buf_len: %llu > %d\n", dimm_name,
+			cmd_name, buf_len, ND_IOCTL_MAX_BUFLEN);
 		rc = -EINVAL;
 		goto out;
 	}
@@ -1174,7 +1172,7 @@ static long nd_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
 
 	ro = ((file->f_flags & O_ACCMODE) == O_RDONLY);
 	mutex_lock(&nvdimm_bus_list_mutex);
-	list_for_each_entry(nvdimm_bus, &nvdimm_bus_list, list) {
+	list_for_each_entry (nvdimm_bus, &nvdimm_bus_list, list) {
 		if (mode == DIMM_IOCTL) {
 			struct device *dev;
 
diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
index 953029c240e5..b96a3f9226cc 100644
--- a/drivers/nvdimm/claim.c
+++ b/drivers/nvdimm/claim.c
@@ -26,8 +26,7 @@ void __nd_detach_ndns(struct device *dev, struct nd_namespace_common **_ndns)
 	put_device(&ndns->dev);
 }
 
-void nd_detach_ndns(struct device *dev,
-		    struct nd_namespace_common **_ndns)
+void nd_detach_ndns(struct device *dev, struct nd_namespace_common **_ndns)
 {
 	struct nd_namespace_common *ndns = *_ndns;
 
@@ -132,8 +131,8 @@ static void nd_detach_and_reset(struct device *dev,
 }
 
 ssize_t nd_namespace_store(struct device *dev,
-			   struct nd_namespace_common **_ndns,
-			   const char *buf, size_t len)
+			   struct nd_namespace_common **_ndns, const char *buf,
+			   size_t len)
 {
 	struct nd_namespace_common *ndns;
 	struct device *found;
@@ -149,7 +148,9 @@ ssize_t nd_namespace_store(struct device *dev,
 		return -ENOMEM;
 	strim(name);
 
-	if (!(strncmp(name, "namespace", 9) == 0 || strcmp(name, "") == 0)) {
+	if (strncmp(name, "namespace", 9) == 0 || strcmp(name, "") == 0)
+		/* pass */;
+	else {
 		len = -EINVAL;
 		goto out;
 	}
@@ -158,8 +159,7 @@ ssize_t nd_namespace_store(struct device *dev,
 	if (strcmp(name, "") == 0) {
 		nd_detach_and_reset(dev, _ndns);
 		goto out;
-	}
-	if (ndns) {
+	} else if (ndns) {
 		dev_dbg(dev, "namespace already set to: %s\n",
 			dev_name(&ndns->dev));
 		len = -EBUSY;
@@ -201,6 +201,7 @@ ssize_t nd_namespace_store(struct device *dev,
 	default:
 		len = -EBUSY;
 		goto out_attach;
+		break;
 	}
 
 	if (__nvdimm_namespace_capacity(ndns) < SZ_16M) {
@@ -211,8 +212,7 @@ ssize_t nd_namespace_store(struct device *dev,
 
 	WARN_ON_ONCE(!is_nvdimm_bus_locked(dev));
 	if (!__nd_attach_ndns(dev, ndns, _ndns)) {
-		dev_dbg(dev, "%s already claimed\n",
-			dev_name(&ndns->dev));
+		dev_dbg(dev, "%s already claimed\n", dev_name(&ndns->dev));
 		len = -EBUSY;
 	}
 
@@ -277,9 +277,8 @@ static int nsio_rw_bytes(struct nd_namespace_common *ndns,
 			long cleared;
 
 			might_sleep();
-			cleared = nvdimm_clear_poison(&ndns->dev,
-						      nsio->res.start + offset,
-						      size);
+			cleared = nvdimm_clear_poison(
+				&ndns->dev, nsio->res.start + offset, size);
 			if (cleared < size)
 				rc = -EIO;
 			if (cleared > 0 && cleared / 512) {
@@ -287,9 +286,8 @@ static int nsio_rw_bytes(struct nd_namespace_common *ndns,
 				badblocks_clear(&nsio->bb, sector, cleared);
 			}
 			arch_invalidate_pmem(nsio->addr + offset, size);
-		} else {
+		} else
 			rc = -EIO;
-		}
 	}
 
 	memcpy_flushcache(nsio->addr + offset, buf, size);
diff --git a/drivers/nvdimm/core.c b/drivers/nvdimm/core.c
index deb92c806abf..1ba19bef3334 100644
--- a/drivers/nvdimm/core.c
+++ b/drivers/nvdimm/core.c
@@ -68,14 +68,15 @@ static struct nvdimm_map *find_nvdimm_map(struct device *dev,
 	struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(dev);
 	struct nvdimm_map *nvdimm_map;
 
-	list_for_each_entry(nvdimm_map, &nvdimm_bus->mapping_list, list)
+	list_for_each_entry (nvdimm_map, &nvdimm_bus->mapping_list, list)
 		if (nvdimm_map->offset == offset)
 			return nvdimm_map;
 	return NULL;
 }
 
 static struct nvdimm_map *alloc_nvdimm_map(struct device *dev,
-					   resource_size_t offset, size_t size, unsigned long flags)
+					   resource_size_t offset, size_t size,
+					   unsigned long flags)
 {
 	struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(dev);
 	struct nvdimm_map *nvdimm_map;
@@ -92,8 +93,9 @@ static struct nvdimm_map *alloc_nvdimm_map(struct device *dev,
 	kref_init(&nvdimm_map->kref);
 
 	if (!request_mem_region(offset, size, dev_name(&nvdimm_bus->dev))) {
-		dev_err(&nvdimm_bus->dev, "failed to request %pa + %zd for %s\n",
-			&offset, size, dev_name(dev));
+		dev_err(&nvdimm_bus->dev,
+			"failed to request %pa + %zd for %s\n", &offset, size,
+			dev_name(dev));
 		goto err_request_region;
 	}
 
@@ -208,7 +210,9 @@ EXPORT_SYMBOL_GPL(to_nvdimm_bus_dev);
 
 static bool is_uuid_sep(char sep)
 {
-	return sep == '\n' || sep == '-' || sep == ':' || sep == '\0';
+	if (sep == '\n' || sep == '-' || sep == ':' || sep == '\0')
+		return true;
+	return false;
 }
 
 static int nd_uuid_parse(struct device *dev, u8 *uuid_out, const char *buf,
@@ -220,9 +224,8 @@ static int nd_uuid_parse(struct device *dev, u8 *uuid_out, const char *buf,
 
 	for (i = 0; i < 16; i++) {
 		if (!isxdigit(str[0]) || !isxdigit(str[1])) {
-			dev_dbg(dev, "pos: %d buf[%zd]: %c buf[%zd]: %c\n",
-				i, str - buf, str[0],
-				str + 1 - buf, str[1]);
+			dev_dbg(dev, "pos: %d buf[%zd]: %c buf[%zd]: %c\n", i,
+				str - buf, str[0], str + 1 - buf, str[1]);
 			return -EINVAL;
 		}
 
@@ -283,7 +286,8 @@ ssize_t nd_size_select_show(unsigned long current_size,
 }
 
 ssize_t nd_size_select_store(struct device *dev, const char *buf,
-			     unsigned long *current_size, const unsigned long *supported)
+			     unsigned long *current_size,
+			     const unsigned long *supported)
 {
 	unsigned long lbasize;
 	int rc, i;
@@ -307,14 +311,14 @@ ssize_t nd_size_select_store(struct device *dev, const char *buf,
 	}
 }
 
-static ssize_t commands_show(struct device *dev,
-			     struct device_attribute *attr, char *buf)
+static ssize_t commands_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
 {
 	int cmd, len = 0;
 	struct nvdimm_bus *nvdimm_bus = to_nvdimm_bus(dev);
 	struct nvdimm_bus_descriptor *nd_desc = nvdimm_bus->nd_desc;
 
-	for_each_set_bit(cmd, &nd_desc->cmd_mask, BITS_PER_LONG)
+	for_each_set_bit (cmd, &nd_desc->cmd_mask, BITS_PER_LONG)
 		len += sprintf(buf + len, "%s ", nvdimm_bus_cmd_name(cmd));
 	len += sprintf(buf + len, "\n");
 	return len;
@@ -334,8 +338,8 @@ static const char *nvdimm_bus_provider(struct nvdimm_bus *nvdimm_bus)
 		return "unknown";
 }
 
-static ssize_t provider_show(struct device *dev,
-			     struct device_attribute *attr, char *buf)
+static ssize_t provider_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
 {
 	struct nvdimm_bus *nvdimm_bus = to_nvdimm_bus(dev);
 
diff --git a/drivers/nvdimm/dax_devs.c b/drivers/nvdimm/dax_devs.c
index 46230eb35b90..6d22b0f83b3b 100644
--- a/drivers/nvdimm/dax_devs.c
+++ b/drivers/nvdimm/dax_devs.c
@@ -125,9 +125,8 @@ int nd_dax_probe(struct device *dev, struct nd_namespace_common *ndns)
 	if (rc < 0) {
 		nd_detach_ndns(dax_dev, &nd_pfn->ndns);
 		put_device(dax_dev);
-	} else {
+	} else
 		__nd_device_register(dax_dev);
-	}
 
 	return rc;
 }
diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index 35a6c20d30fd..415b03ca458a 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -2,9 +2,7 @@
 /*
  * Copyright(c) 2013-2015 Intel Corporation. All rights reserved.
  */
-
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/moduleparam.h>
 #include <linux/vmalloc.h>
 #include <linux/device.h>
@@ -84,8 +82,8 @@ int nvdimm_init_nsarea(struct nvdimm_drvdata *ndd)
 	return cmd_rc;
 }
 
-int nvdimm_get_config_data(struct nvdimm_drvdata *ndd, void *buf,
-			   size_t offset, size_t len)
+int nvdimm_get_config_data(struct nvdimm_drvdata *ndd, void *buf, size_t offset,
+			   size_t len)
 {
 	struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(ndd->dev);
 	struct nvdimm_bus_descriptor *nd_desc = nvdimm_bus->nd_desc;
@@ -131,8 +129,8 @@ int nvdimm_get_config_data(struct nvdimm_drvdata *ndd, void *buf,
 	return rc;
 }
 
-int nvdimm_set_config_data(struct nvdimm_drvdata *ndd, size_t offset,
-			   void *buf, size_t len)
+int nvdimm_set_config_data(struct nvdimm_drvdata *ndd, size_t offset, void *buf,
+			   size_t len)
 {
 	size_t max_cmd_size, buf_offset;
 	struct nd_cmd_set_config_hdr *cmd;
@@ -151,8 +149,8 @@ int nvdimm_set_config_data(struct nvdimm_drvdata *ndd, size_t offset,
 	if (!cmd)
 		return -ENOMEM;
 
-	for (buf_offset = 0; len; len -= cmd->in_length,
-		     buf_offset += cmd->in_length) {
+	for (buf_offset = 0; len;
+	     len -= cmd->in_length, buf_offset += cmd->in_length) {
 		size_t cmd_size;
 
 		cmd->in_offset = offset + buf_offset;
@@ -259,8 +257,7 @@ void nvdimm_drvdata_release(struct kref *kref)
 
 	dev_dbg(dev, "trace\n");
 	nvdimm_bus_lock(dev);
-	for_each_dpa_resource_safe(ndd, res, _r)
-		nvdimm_free_dpa(ndd, res);
+	for_each_dpa_resource_safe(ndd, res, _r) nvdimm_free_dpa(ndd, res);
 	nvdimm_bus_unlock(dev);
 
 	kvfree(ndd->data);
@@ -305,8 +302,8 @@ void *nvdimm_provider_data(struct nvdimm *nvdimm)
 }
 EXPORT_SYMBOL_GPL(nvdimm_provider_data);
 
-static ssize_t commands_show(struct device *dev,
-			     struct device_attribute *attr, char *buf)
+static ssize_t commands_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
 {
 	struct nvdimm *nvdimm = to_nvdimm(dev);
 	int cmd, len = 0;
@@ -314,15 +311,15 @@ static ssize_t commands_show(struct device *dev,
 	if (!nvdimm->cmd_mask)
 		return sprintf(buf, "\n");
 
-	for_each_set_bit(cmd, &nvdimm->cmd_mask, BITS_PER_LONG)
+	for_each_set_bit (cmd, &nvdimm->cmd_mask, BITS_PER_LONG)
 		len += sprintf(buf + len, "%s ", nvdimm_cmd_name(cmd));
 	len += sprintf(buf + len, "\n");
 	return len;
 }
 static DEVICE_ATTR_RO(commands);
 
-static ssize_t flags_show(struct device *dev,
-			  struct device_attribute *attr, char *buf)
+static ssize_t flags_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
 {
 	struct nvdimm *nvdimm = to_nvdimm(dev);
 
@@ -363,17 +360,16 @@ static ssize_t available_slots_show(struct device *dev,
 	if (nfree - 1 > nfree) {
 		dev_WARN_ONCE(dev, 1, "we ate our last label?\n");
 		nfree = 0;
-	} else {
+	} else
 		nfree--;
-	}
 	rc = sprintf(buf, "%d\n", nfree);
 	nvdimm_bus_unlock(dev);
 	return rc;
 }
 static DEVICE_ATTR_RO(available_slots);
 
-__weak ssize_t security_show(struct device *dev,
-			     struct device_attribute *attr, char *buf)
+__weak ssize_t security_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
 {
 	struct nvdimm *nvdimm = to_nvdimm(dev);
 
@@ -388,18 +384,17 @@ __weak ssize_t security_show(struct device *dev,
 	return -ENOTTY;
 }
 
-static ssize_t frozen_show(struct device *dev,
-			   struct device_attribute *attr, char *buf)
+static ssize_t frozen_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
 {
 	struct nvdimm *nvdimm = to_nvdimm(dev);
 
-	return sprintf(buf, "%d\n", test_bit(NVDIMM_SECURITY_FROZEN,
-					     &nvdimm->sec.flags));
+	return sprintf(buf, "%d\n",
+		       test_bit(NVDIMM_SECURITY_FROZEN, &nvdimm->sec.flags));
 }
 static DEVICE_ATTR_RO(frozen);
 
-static ssize_t security_store(struct device *dev,
-			      struct device_attribute *attr,
+static ssize_t security_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t len)
 
 {
@@ -443,10 +438,8 @@ static umode_t nvdimm_visible(struct kobject *kobj, struct attribute *a, int n)
 
 	if (a == &dev_attr_security.attr) {
 		/* Are there any state mutation ops (make writable)? */
-		if (nvdimm->sec.ops->freeze ||
-		    nvdimm->sec.ops->disable ||
-		    nvdimm->sec.ops->change_key ||
-		    nvdimm->sec.ops->erase ||
+		if (nvdimm->sec.ops->freeze || nvdimm->sec.ops->disable ||
+		    nvdimm->sec.ops->change_key || nvdimm->sec.ops->erase ||
 		    nvdimm->sec.ops->overwrite)
 			return a->mode;
 		return 0444;
@@ -464,9 +457,11 @@ struct attribute_group nvdimm_attribute_group = {
 EXPORT_SYMBOL_GPL(nvdimm_attribute_group);
 
 struct nvdimm *__nvdimm_create(struct nvdimm_bus *nvdimm_bus,
-			       void *provider_data, const struct attribute_group **groups,
-			       unsigned long flags, unsigned long cmd_mask, int num_flush,
-			       struct resource *flush_wpq, const char *dimm_id,
+			       void *provider_data,
+			       const struct attribute_group **groups,
+			       unsigned long flags, unsigned long cmd_mask,
+			       int num_flush, struct resource *flush_wpq,
+			       const char *dimm_id,
 			       const struct nvdimm_security_ops *sec_ops)
 {
 	struct nvdimm *nvdimm = kzalloc(sizeof(*nvdimm), GFP_KERNEL);
@@ -523,11 +518,11 @@ int nvdimm_security_setup_events(struct device *dev)
 {
 	struct nvdimm *nvdimm = to_nvdimm(dev);
 
-	if (!nvdimm->sec.flags ||
-	    !nvdimm->sec.ops ||
+	if (!nvdimm->sec.flags || !nvdimm->sec.ops ||
 	    !nvdimm->sec.ops->overwrite)
 		return 0;
-	nvdimm->sec.overwrite_state = sysfs_get_dirent(dev->kobj.sd, "security");
+	nvdimm->sec.overwrite_state =
+		sysfs_get_dirent(dev->kobj.sd, "security");
 	if (!nvdimm->sec.overwrite_state)
 		return -ENOMEM;
 
@@ -554,7 +549,7 @@ int nvdimm_security_freeze(struct nvdimm *nvdimm)
 		return -EIO;
 
 	if (test_bit(NDD_SECURITY_OVERWRITE, &nvdimm->flags)) {
-		dev_warn(&nvdimm->dev, "Overwrite operation in progress\n");
+		dev_warn(&nvdimm->dev, "Overwrite operation in progress.\n");
 		return -EBUSY;
 	}
 
@@ -579,7 +574,7 @@ int alias_dpa_busy(struct device *dev, void *data)
 
 	nd_region = to_nd_region(dev);
 	for (i = 0; i < nd_region->ndr_mappings; i++) {
-		nd_mapping  = &nd_region->mapping[i];
+		nd_mapping = &nd_region->mapping[i];
 		if (nd_mapping->nvdimm == info->nd_mapping->nvdimm)
 			break;
 	}
@@ -596,17 +591,21 @@ int alias_dpa_busy(struct device *dev, void *data)
 	 * looking to validate against PMEM aliasing collision rules
 	 * (i.e. BLK is allocated after all aliased PMEM).
 	 */
-	if (info->res &&
-	    (info->res->start < nd_mapping->start ||
-	     info->res->start >= map_end))
-		return 0;
+	if (info->res) {
+		if (info->res->start >= nd_mapping->start &&
+		    info->res->start < map_end)
+			/* pass */;
+		else
+			return 0;
+	}
 
 retry:
 	/*
 	 * Find the free dpa from the end of the last pmem allocation to
 	 * the end of the interleave-set mapping.
 	 */
-	for_each_dpa_resource(ndd, res) {
+	for_each_dpa_resource(ndd, res)
+	{
 		if (strncmp(res->name, "pmem", 4) != 0)
 			continue;
 		if ((res->start >= blk_start && res->start < map_end) ||
@@ -658,7 +657,8 @@ resource_size_t nd_blk_available_dpa(struct nd_region *nd_region)
 	device_for_each_child(&nvdimm_bus->dev, &info, alias_dpa_busy);
 
 	/* now account for busy blk allocations in unaliased dpa */
-	for_each_dpa_resource(ndd, res) {
+	for_each_dpa_resource(ndd, res)
+	{
 		if (strncmp(res->name, "blk", 3) != 0)
 			continue;
 		info.available -= resource_size(res);
@@ -688,7 +688,8 @@ resource_size_t nd_pmem_max_contiguous_dpa(struct nd_region *nd_region,
 	nvdimm_bus = walk_to_nvdimm_bus(ndd->dev);
 	if (__reserve_free_pmem(&nd_region->dev, nd_mapping->nvdimm))
 		return 0;
-	for_each_dpa_resource(ndd, res) {
+	for_each_dpa_resource(ndd, res)
+	{
 		if (strcmp(res->name, "pmem-reserve") != 0)
 			continue;
 		if (resource_size(res) > max)
@@ -728,17 +729,17 @@ resource_size_t nd_pmem_available_dpa(struct nd_region *nd_region,
 	map_start = nd_mapping->start;
 	map_end = map_start + nd_mapping->size - 1;
 	blk_start = max(map_start, map_end + 1 - *overlap);
-	for_each_dpa_resource(ndd, res) {
+	for_each_dpa_resource(ndd, res)
+	{
 		if (res->start >= map_start && res->start < map_end) {
-			if (strncmp(res->name, "blk", 3) == 0) {
+			if (strncmp(res->name, "blk", 3) == 0)
 				blk_start = min(blk_start,
 						max(map_start, res->start));
-			} else if (res->end > map_end) {
+			else if (res->end > map_end) {
 				reason = "misaligned to iset";
 				goto err;
-			} else {
+			} else
 				busy += resource_size(res);
-			}
 		} else if (res->end >= map_start && res->end <= map_end) {
 			if (strncmp(res->name, "blk", 3) == 0) {
 				/*
@@ -747,9 +748,8 @@ resource_size_t nd_pmem_available_dpa(struct nd_region *nd_region,
 				 * be used for BLK.
 				 */
 				blk_start = map_start;
-			} else {
+			} else
 				busy += resource_size(res);
-			}
 		} else if (map_start > res->start && map_start < res->end) {
 			/* total eclipse of the mapping */
 			busy += nd_mapping->size;
@@ -776,8 +776,8 @@ void nvdimm_free_dpa(struct nvdimm_drvdata *ndd, struct resource *res)
 }
 
 struct resource *nvdimm_allocate_dpa(struct nvdimm_drvdata *ndd,
-				     struct nd_label_id *label_id, resource_size_t start,
-				     resource_size_t n)
+				     struct nd_label_id *label_id,
+				     resource_size_t start, resource_size_t n)
 {
 	char *name = kmemdup(label_id, sizeof(*label_id), GFP_KERNEL);
 	struct resource *res;
@@ -803,9 +803,8 @@ resource_size_t nvdimm_allocated_dpa(struct nvdimm_drvdata *ndd,
 	resource_size_t allocated = 0;
 	struct resource *res;
 
-	for_each_dpa_resource(ndd, res)
-		if (strcmp(res->name, label_id->id) == 0)
-			allocated += resource_size(res);
+	for_each_dpa_resource(ndd, res) if (strcmp(res->name, label_id->id) ==
+					    0) allocated += resource_size(res);
 
 	return allocated;
 }
diff --git a/drivers/nvdimm/e820.c b/drivers/nvdimm/e820.c
index adfeaf5c3c23..697df0a9baa4 100644
--- a/drivers/nvdimm/e820.c
+++ b/drivers/nvdimm/e820.c
@@ -71,7 +71,8 @@ static int e820_pmem_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, nvdimm_bus);
 
 	rc = walk_iomem_res_desc(IORES_DESC_PERSISTENT_MEMORY_LEGACY,
-				 IORESOURCE_MEM, 0, -1, nvdimm_bus, e820_register_one);
+				 IORESOURCE_MEM, 0, -1, nvdimm_bus,
+				 e820_register_one);
 	if (rc)
 		goto err;
 	return 0;
diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
index 9bf75dad8e93..3ecb05c2cd4e 100644
--- a/drivers/nvdimm/label.c
+++ b/drivers/nvdimm/label.c
@@ -34,7 +34,7 @@ static u32 best_seq(u32 a, u32 b)
 		return a;
 }
 
-unsigned int sizeof_namespace_label(struct nvdimm_drvdata *ndd)
+unsigned sizeof_namespace_label(struct nvdimm_drvdata *ndd)
 {
 	return ndd->nslabel_size;
 }
@@ -49,7 +49,7 @@ static int __nvdimm_num_label_slots(struct nvdimm_drvdata *ndd,
 				    size_t index_size)
 {
 	return (ndd->nsarea.config_size - index_size * 2) /
-		sizeof_namespace_label(ndd);
+	       sizeof_namespace_label(ndd);
 }
 
 int nvdimm_num_label_slots(struct nvdimm_drvdata *ndd)
@@ -78,7 +78,8 @@ size_t sizeof_namespace_index(struct nvdimm_drvdata *ndd)
 	if (size <= space && nslot >= 2)
 		return size / 2;
 
-	dev_err(ndd->dev, "label area (%d) too small to host (%d byte) labels\n",
+	dev_err(ndd->dev,
+		"label area (%d) too small to host (%d byte) labels\n",
 		ndd->nsarea.config_size, sizeof_namespace_label(ndd));
 	return 0;
 }
@@ -135,16 +136,16 @@ static int __nd_label_validate(struct nvdimm_drvdata *ndd)
 		}
 
 		/* label sizes larger than 128 arrived with v1.2 */
-		version = __le16_to_cpu(nsindex[i]->major) * 100
-			+ __le16_to_cpu(nsindex[i]->minor);
+		version = __le16_to_cpu(nsindex[i]->major) * 100 +
+			  __le16_to_cpu(nsindex[i]->minor);
 		if (version >= 102)
 			labelsize = 1 << (7 + nsindex[i]->labelsize);
 		else
 			labelsize = 128;
 
 		if (labelsize != sizeof_namespace_label(ndd)) {
-			dev_dbg(dev, "nsindex%d labelsize %d invalid\n",
-				i, nsindex[i]->labelsize);
+			dev_dbg(dev, "nsindex%d labelsize %d invalid\n", i,
+				nsindex[i]->labelsize);
 			continue;
 		}
 
@@ -159,44 +160,48 @@ static int __nd_label_validate(struct nvdimm_drvdata *ndd)
 
 		seq = __le32_to_cpu(nsindex[i]->seq);
 		if ((seq & NSINDEX_SEQ_MASK) == 0) {
-			dev_dbg(dev, "nsindex%d sequence: %#x invalid\n",
-				i, seq);
+			dev_dbg(dev, "nsindex%d sequence: %#x invalid\n", i,
+				seq);
 			continue;
 		}
 
 		/* sanity check the index against expected values */
-		if (__le64_to_cpu(nsindex[i]->myoff)
-		    != i * sizeof_namespace_index(ndd)) {
-			dev_dbg(dev, "nsindex%d myoff: %#llx invalid\n",
-				i, (u64)__le64_to_cpu(nsindex[i]->myoff));
+		if (__le64_to_cpu(nsindex[i]->myoff) !=
+		    i * sizeof_namespace_index(ndd)) {
+			dev_dbg(dev, "nsindex%d myoff: %#llx invalid\n", i,
+				(unsigned long long)__le64_to_cpu(
+					nsindex[i]->myoff));
 			continue;
 		}
-		if (__le64_to_cpu(nsindex[i]->otheroff)
-		    != (!i) * sizeof_namespace_index(ndd)) {
-			dev_dbg(dev, "nsindex%d otheroff: %#llx invalid\n",
-				i, (u64)__le64_to_cpu(nsindex[i]->otheroff));
+		if (__le64_to_cpu(nsindex[i]->otheroff) !=
+		    (!i) * sizeof_namespace_index(ndd)) {
+			dev_dbg(dev, "nsindex%d otheroff: %#llx invalid\n", i,
+				(unsigned long long)__le64_to_cpu(
+					nsindex[i]->otheroff));
 			continue;
 		}
-		if (__le64_to_cpu(nsindex[i]->labeloff)
-		    != 2 * sizeof_namespace_index(ndd)) {
-			dev_dbg(dev, "nsindex%d labeloff: %#llx invalid\n",
-				i, (u64)__le64_to_cpu(nsindex[i]->labeloff));
+		if (__le64_to_cpu(nsindex[i]->labeloff) !=
+		    2 * sizeof_namespace_index(ndd)) {
+			dev_dbg(dev, "nsindex%d labeloff: %#llx invalid\n", i,
+				(unsigned long long)__le64_to_cpu(
+					nsindex[i]->labeloff));
 			continue;
 		}
 
 		size = __le64_to_cpu(nsindex[i]->mysize);
 		if (size > sizeof_namespace_index(ndd) ||
 		    size < sizeof(struct nd_namespace_index)) {
-			dev_dbg(dev, "nsindex%d mysize: %#llx invalid\n",
-				i, size);
+			dev_dbg(dev, "nsindex%d mysize: %#llx invalid\n", i,
+				size);
 			continue;
 		}
 
 		nslot = __le32_to_cpu(nsindex[i]->nslot);
-		if (nslot * sizeof_namespace_label(ndd)
-		    + 2 * sizeof_namespace_index(ndd)
-		    > ndd->nsarea.config_size) {
-			dev_dbg(dev, "nsindex%d nslot: %u invalid, config_size: %#x\n",
+		if (nslot * sizeof_namespace_label(ndd) +
+			    2 * sizeof_namespace_index(ndd) >
+		    ndd->nsarea.config_size) {
+			dev_dbg(dev,
+				"nsindex%d nslot: %u invalid, config_size: %#x\n",
 				i, nslot, ndd->nsarea.config_size);
 			continue;
 		}
@@ -290,9 +295,8 @@ static struct nd_namespace_label *to_label(struct nvdimm_drvdata *ndd, int slot)
 	return (struct nd_namespace_label *)label;
 }
 
-#define for_each_clear_bit_le(bit, addr, size)				\
-	for ((bit) = find_next_zero_bit_le((addr), (size), 0);		\
-	     (bit) < (size);						\
+#define for_each_clear_bit_le(bit, addr, size)                                 \
+	for ((bit) = find_next_zero_bit_le((addr), (size), 0); (bit) < (size); \
 	     (bit) = find_next_zero_bit_le((addr), (size), (bit) + 1))
 
 /**
@@ -333,16 +337,14 @@ static bool preamble_current(struct nvdimm_drvdata *ndd,
 			     struct nd_namespace_index **nsindex,
 			     unsigned long **free, u32 *nslot)
 {
-	return preamble_index(ndd, ndd->ns_current, nsindex,
-			      free, nslot);
+	return preamble_index(ndd, ndd->ns_current, nsindex, free, nslot);
 }
 
 static bool preamble_next(struct nvdimm_drvdata *ndd,
 			  struct nd_namespace_index **nsindex,
 			  unsigned long **free, u32 *nslot)
 {
-	return preamble_index(ndd, ndd->ns_next, nsindex,
-			      free, nslot);
+	return preamble_index(ndd, ndd->ns_next, nsindex, free, nslot);
 }
 
 static bool slot_valid(struct nvdimm_drvdata *ndd,
@@ -353,8 +355,8 @@ static bool slot_valid(struct nvdimm_drvdata *ndd,
 		return false;
 
 	/* check that DPA allocations are page aligned */
-	if ((__le64_to_cpu(nd_label->dpa)
-	     | __le64_to_cpu(nd_label->rawsize)) % SZ_4K)
+	if ((__le64_to_cpu(nd_label->dpa) | __le64_to_cpu(nd_label->rawsize)) %
+	    SZ_4K)
 		return false;
 
 	/* check checksum */
@@ -366,8 +368,9 @@ static bool slot_valid(struct nvdimm_drvdata *ndd,
 		sum = nd_fletcher64(nd_label, sizeof_namespace_label(ndd), 1);
 		nd_label->checksum = __cpu_to_le64(sum_save);
 		if (sum != sum_save) {
-			dev_dbg(ndd->dev, "fail checksum. slot: %d expect: %#llx\n",
-				slot, sum);
+			dev_dbg(ndd->dev,
+				"fail checksum. slot: %d expect: %#llx\n", slot,
+				sum);
 			return false;
 		}
 	}
@@ -384,7 +387,8 @@ int nd_label_reserve_dpa(struct nvdimm_drvdata *ndd)
 	if (!preamble_current(ndd, &nsindex, &free, &nslot))
 		return 0; /* no label, nothing to reserve */
 
-	for_each_clear_bit_le(slot, free, nslot) {
+	for_each_clear_bit_le(slot, free, nslot)
+	{
 		struct nvdimm *nvdimm = to_nvdimm(ndd->dev);
 		struct nd_namespace_label *nd_label;
 		struct nd_region *nd_region = NULL;
@@ -463,15 +467,15 @@ int nd_label_data_init(struct nvdimm_drvdata *ndd)
 	if (read_size < max_xfer) {
 		/* trim waste */
 		max_xfer -= ((max_xfer - 1) - (config_size - 1) % max_xfer) /
-			DIV_ROUND_UP(config_size, max_xfer);
+			    DIV_ROUND_UP(config_size, max_xfer);
 		/* make certain we read indexes in exactly 1 read */
 		if (max_xfer < read_size)
 			max_xfer = read_size;
 	}
 
 	/* Make our initial read size a multiple of max_xfer size */
-	read_size = min(DIV_ROUND_UP(read_size, max_xfer) * max_xfer,
-			config_size);
+	read_size =
+		min(DIV_ROUND_UP(read_size, max_xfer) * max_xfer, config_size);
 
 	/* Read the index data */
 	rc = nvdimm_get_config_data(ndd, ndd->data, 0, read_size);
@@ -514,8 +518,8 @@ int nd_label_data_init(struct nvdimm_drvdata *ndd)
 
 		/* determine how much more will be read after this next call. */
 		label_read_size = offset + ndd->nslabel_size - read_size;
-		label_read_size = DIV_ROUND_UP(label_read_size, max_xfer) *
-			max_xfer;
+		label_read_size =
+			DIV_ROUND_UP(label_read_size, max_xfer) * max_xfer;
 
 		/* truncate last read if needed */
 		if (read_size + label_read_size > config_size)
@@ -546,7 +550,8 @@ int nd_label_active_count(struct nvdimm_drvdata *ndd)
 	if (!preamble_current(ndd, &nsindex, &free, &nslot))
 		return 0;
 
-	for_each_clear_bit_le(slot, free, nslot) {
+	for_each_clear_bit_le(slot, free, nslot)
+	{
 		struct nd_namespace_label *nd_label;
 
 		nd_label = to_label(ndd, slot);
@@ -575,7 +580,8 @@ struct nd_namespace_label *nd_label_active(struct nvdimm_drvdata *ndd, int n)
 	if (!preamble_current(ndd, &nsindex, &free, &nslot))
 		return NULL;
 
-	for_each_clear_bit_le(slot, free, nslot) {
+	for_each_clear_bit_le(slot, free, nslot)
+	{
 		struct nd_namespace_label *nd_label;
 
 		nd_label = to_label(ndd, slot);
@@ -658,16 +664,16 @@ static int nd_label_write_index(struct nvdimm_drvdata *ndd, int index, u32 seq,
 	memset(&nsindex->flags, 0, 3);
 	nsindex->labelsize = sizeof_namespace_label(ndd) >> 8;
 	nsindex->seq = __cpu_to_le32(seq);
-	offset = (unsigned long)nsindex
-		- (unsigned long)to_namespace_index(ndd, 0);
+	offset = (unsigned long)nsindex -
+		 (unsigned long)to_namespace_index(ndd, 0);
 	nsindex->myoff = __cpu_to_le64(offset);
 	nsindex->mysize = __cpu_to_le64(sizeof_namespace_index(ndd));
-	offset = (unsigned long)to_namespace_index(ndd,
-						    nd_label_next_nsindex(index))
-		- (unsigned long)to_namespace_index(ndd, 0);
+	offset = (unsigned long)to_namespace_index(
+			 ndd, nd_label_next_nsindex(index)) -
+		 (unsigned long)to_namespace_index(ndd, 0);
 	nsindex->otheroff = __cpu_to_le64(offset);
-	offset = (unsigned long)nd_label_base(ndd)
-		- (unsigned long)to_namespace_index(ndd, 0);
+	offset = (unsigned long)nd_label_base(ndd) -
+		 (unsigned long)to_namespace_index(ndd, 0);
 	nsindex->labeloff = __cpu_to_le64(offset);
 	nsindex->nslot = __cpu_to_le32(nslot);
 	nsindex->major = __cpu_to_le16(1);
@@ -687,8 +693,8 @@ static int nd_label_write_index(struct nvdimm_drvdata *ndd, int index, u32 seq,
 	}
 	checksum = nd_fletcher64(nsindex, sizeof_namespace_index(ndd), 1);
 	nsindex->checksum = __cpu_to_le64(checksum);
-	rc = nvdimm_set_config_data(ndd, __le64_to_cpu(nsindex->myoff),
-				    nsindex, sizeof_namespace_index(ndd));
+	rc = nvdimm_set_config_data(ndd, __le64_to_cpu(nsindex->myoff), nsindex,
+				    sizeof_namespace_index(ndd));
 	if (rc < 0)
 		return rc;
 
@@ -708,21 +714,21 @@ static int nd_label_write_index(struct nvdimm_drvdata *ndd, int index, u32 seq,
 static unsigned long nd_label_offset(struct nvdimm_drvdata *ndd,
 				     struct nd_namespace_label *nd_label)
 {
-	return (unsigned long)nd_label
-		- (unsigned long)to_namespace_index(ndd, 0);
+	return (unsigned long)nd_label -
+	       (unsigned long)to_namespace_index(ndd, 0);
 }
 
 enum nvdimm_claim_class to_nvdimm_cclass(guid_t *guid)
 {
 	if (guid_equal(guid, &nvdimm_btt_guid))
 		return NVDIMM_CCLASS_BTT;
-	if (guid_equal(guid, &nvdimm_btt2_guid))
+	else if (guid_equal(guid, &nvdimm_btt2_guid))
 		return NVDIMM_CCLASS_BTT2;
-	if (guid_equal(guid, &nvdimm_pfn_guid))
+	else if (guid_equal(guid, &nvdimm_pfn_guid))
 		return NVDIMM_CCLASS_PFN;
-	if (guid_equal(guid, &nvdimm_dax_guid))
+	else if (guid_equal(guid, &nvdimm_dax_guid))
 		return NVDIMM_CCLASS_DAX;
-	if (guid_equal(guid, &guid_null))
+	else if (guid_equal(guid, &guid_null))
 		return NVDIMM_CCLASS_NONE;
 
 	return NVDIMM_CCLASS_UNKNOWN;
@@ -733,21 +739,20 @@ static const guid_t *to_abstraction_guid(enum nvdimm_claim_class claim_class,
 {
 	if (claim_class == NVDIMM_CCLASS_BTT)
 		return &nvdimm_btt_guid;
-	if (claim_class == NVDIMM_CCLASS_BTT2)
+	else if (claim_class == NVDIMM_CCLASS_BTT2)
 		return &nvdimm_btt2_guid;
-	if (claim_class == NVDIMM_CCLASS_PFN)
+	else if (claim_class == NVDIMM_CCLASS_PFN)
 		return &nvdimm_pfn_guid;
-	if (claim_class == NVDIMM_CCLASS_DAX)
+	else if (claim_class == NVDIMM_CCLASS_DAX)
 		return &nvdimm_dax_guid;
-	if (claim_class == NVDIMM_CCLASS_UNKNOWN) {
+	else if (claim_class == NVDIMM_CCLASS_UNKNOWN) {
 		/*
 		 * If we're modifying a namespace for which we don't
 		 * know the claim_class, don't touch the existing guid.
 		 */
 		return target;
-	}
-
-	return &guid_null;
+	} else
+		return &guid_null;
 }
 
 static void reap_victim(struct nd_mapping *nd_mapping,
@@ -763,8 +768,8 @@ static void reap_victim(struct nd_mapping *nd_mapping,
 
 static int __pmem_label_update(struct nd_region *nd_region,
 			       struct nd_mapping *nd_mapping,
-			       struct nd_namespace_pmem *nspm,
-			       int pos, unsigned long flags)
+			       struct nd_namespace_pmem *nspm, int pos,
+			       unsigned long flags)
 {
 	struct nd_namespace_common *ndns = &nspm->nsio.common;
 	struct nd_interleave_set *nd_set = nd_region->nd_set;
@@ -785,9 +790,8 @@ static int __pmem_label_update(struct nd_region *nd_region,
 
 	cookie = nd_region_interleave_set_cookie(nd_region, nsindex);
 	nd_label_gen_id(&label_id, nspm->uuid, 0);
-	for_each_dpa_resource(ndd, res)
-		if (strcmp(res->name, label_id.id) == 0)
-			break;
+	for_each_dpa_resource(ndd, res) if (strcmp(res->name, label_id.id) ==
+					    0) break;
 
 	if (!res) {
 		WARN_ON_ONCE(1);
@@ -837,12 +841,12 @@ static int __pmem_label_update(struct nd_region *nd_region,
 
 	/* Garbage collect the previous label */
 	mutex_lock(&nd_mapping->lock);
-	list_for_each_entry(label_ent, &nd_mapping->labels, list) {
+	list_for_each_entry (label_ent, &nd_mapping->labels, list) {
 		if (!label_ent->label)
 			continue;
 		if (test_and_clear_bit(ND_LABEL_REAP, &label_ent->flags) ||
 		    memcmp(nspm->uuid, label_ent->label->uuid,
-			      NSLABEL_UUID_LEN) == 0)
+			   NSLABEL_UUID_LEN) == 0)
 			reap_victim(nd_mapping, label_ent);
 	}
 
@@ -850,7 +854,7 @@ static int __pmem_label_update(struct nd_region *nd_region,
 	rc = nd_label_write_index(ndd, ndd->ns_next,
 				  nd_inc_seq(__le32_to_cpu(nsindex->seq)), 0);
 	if (rc == 0) {
-		list_for_each_entry(label_ent, &nd_mapping->labels, list)
+		list_for_each_entry (label_ent, &nd_mapping->labels, list)
 			if (!label_ent->label) {
 				label_ent->label = nd_label;
 				nd_label = NULL;
@@ -884,7 +888,8 @@ static struct resource *to_resource(struct nvdimm_drvdata *ndd,
 {
 	struct resource *res;
 
-	for_each_dpa_resource(ndd, res) {
+	for_each_dpa_resource(ndd, res)
+	{
 		if (res->start != __le64_to_cpu(nd_label->dpa))
 			continue;
 		if (resource_size(res) != __le64_to_cpu(nd_label->rawsize))
@@ -902,8 +907,7 @@ static struct resource *to_resource(struct nvdimm_drvdata *ndd,
  */
 static int __blk_label_update(struct nd_region *nd_region,
 			      struct nd_mapping *nd_mapping,
-			      struct nd_namespace_blk *nsblk,
-			      int num_labels)
+			      struct nd_namespace_blk *nsblk, int num_labels)
 {
 	int i, alloc, victims, nfree, old_num_resources, nlabel, rc = -ENXIO;
 	struct nd_interleave_set *nd_set = nd_region->nd_set;
@@ -936,7 +940,8 @@ static int __blk_label_update(struct nd_region *nd_region,
 	 * disable and re-enable the parent region.
 	 */
 	alloc = 0;
-	for_each_dpa_resource(ndd, res) {
+	for_each_dpa_resource(ndd, res)
+	{
 		if (strcmp(res->name, label_id.id) != 0)
 			continue;
 		if (!is_old_resource(res, old_res_list, old_num_resources))
@@ -951,7 +956,8 @@ static int __blk_label_update(struct nd_region *nd_region,
 			return -ENOMEM;
 
 		/* mark unused labels for garbage collection */
-		for_each_clear_bit_le(slot, free, nslot) {
+		for_each_clear_bit_le(slot, free, nslot)
+		{
 			nd_label = to_label(ndd, slot);
 			memcpy(uuid, nd_label->uuid, NSLABEL_UUID_LEN);
 			if (memcmp(uuid, nsblk->uuid, NSLABEL_UUID_LEN) != 0)
@@ -977,7 +983,8 @@ static int __blk_label_update(struct nd_region *nd_region,
 	/* assign all resources to the namespace before writing the labels */
 	nsblk->res = NULL;
 	nsblk->num_resources = 0;
-	for_each_dpa_resource(ndd, res) {
+	for_each_dpa_resource(ndd, res)
+	{
 		if (strcmp(res->name, label_id.id) != 0)
 			continue;
 		if (!nsblk_add_resource(nd_region, ndd, nsblk, res->start)) {
@@ -1024,7 +1031,8 @@ static int __blk_label_update(struct nd_region *nd_region,
 		 */
 		if (namespace_label_has(ndd, type_guid)) {
 			if (i == min_dpa_idx) {
-				nd_label->nlabel = __cpu_to_le16(nsblk->num_resources);
+				nd_label->nlabel =
+					__cpu_to_le16(nsblk->num_resources);
 				nd_label->position = __cpu_to_le16(0);
 			} else {
 				nd_label->nlabel = __cpu_to_le16(0xffff);
@@ -1045,8 +1053,9 @@ static int __blk_label_update(struct nd_region *nd_region,
 			guid_copy(&nd_label->type_guid, &nd_set->type_guid);
 		if (namespace_label_has(ndd, abstraction_guid))
 			guid_copy(&nd_label->abstraction_guid,
-				  to_abstraction_guid(ndns->claim_class,
-						      &nd_label->abstraction_guid));
+				  to_abstraction_guid(
+					  ndns->claim_class,
+					  &nd_label->abstraction_guid));
 
 		if (namespace_label_has(ndd, checksum)) {
 			u64 sum;
@@ -1066,7 +1075,7 @@ static int __blk_label_update(struct nd_region *nd_region,
 	}
 
 	/* free up now unused slots in the new index */
-	for_each_set_bit(slot, victim_map, victim_map ? nslot : 0) {
+	for_each_set_bit (slot, victim_map, victim_map ? nslot : 0) {
 		dev_dbg(ndd->dev, "free: %d\n", slot);
 		nd_label_free_slot(ndd, slot);
 	}
@@ -1083,7 +1092,7 @@ static int __blk_label_update(struct nd_region *nd_region,
 	 */
 	nlabel = 0;
 	mutex_lock(&nd_mapping->lock);
-	list_for_each_entry_safe(label_ent, e, &nd_mapping->labels, list) {
+	list_for_each_entry_safe (label_ent, e, &nd_mapping->labels, list) {
 		nd_label = label_ent->label;
 		if (!nd_label)
 			continue;
@@ -1117,7 +1126,8 @@ static int __blk_label_update(struct nd_region *nd_region,
 		rc = -ENXIO;
 		goto out;
 	}
-	for_each_clear_bit_le(slot, free, nslot) {
+	for_each_clear_bit_le(slot, free, nslot)
+	{
 		nd_label = to_label(ndd, slot);
 		memcpy(uuid, nd_label->uuid, NSLABEL_UUID_LEN);
 		if (memcmp(uuid, nsblk->uuid, NSLABEL_UUID_LEN) != 0)
@@ -1125,7 +1135,8 @@ static int __blk_label_update(struct nd_region *nd_region,
 		res = to_resource(ndd, nd_label);
 		res->flags &= ~DPA_RESOURCE_ADJUSTED;
 		dev_vdbg(&nsblk->common.dev, "assign label slot: %d\n", slot);
-		list_for_each_entry_from(label_ent, &nd_mapping->labels, list) {
+		list_for_each_entry_from (label_ent, &nd_mapping->labels,
+					  list) {
 			if (label_ent->label)
 				continue;
 			label_ent->label = nd_label;
@@ -1164,7 +1175,7 @@ static int init_labels(struct nd_mapping *nd_mapping, int num_labels)
 	struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
 
 	mutex_lock(&nd_mapping->lock);
-	list_for_each_entry(label_ent, &nd_mapping->labels, list)
+	list_for_each_entry (label_ent, &nd_mapping->labels, list)
 		old_num_labels++;
 	mutex_unlock(&nd_mapping->lock);
 
@@ -1181,7 +1192,9 @@ static int init_labels(struct nd_mapping *nd_mapping, int num_labels)
 		mutex_unlock(&nd_mapping->lock);
 	}
 
-	if (ndd->ns_current != -1 && ndd->ns_next != -1)
+	if (ndd->ns_current == -1 || ndd->ns_next == -1)
+		/* pass */;
+	else
 		return max(num_labels, old_num_labels);
 
 	nsindex = to_namespace_index(ndd, 0);
@@ -1217,7 +1230,7 @@ static int del_labels(struct nd_mapping *nd_mapping, u8 *uuid)
 		return 0;
 
 	mutex_lock(&nd_mapping->lock);
-	list_for_each_entry_safe(label_ent, e, &nd_mapping->labels, list) {
+	list_for_each_entry_safe (label_ent, e, &nd_mapping->labels, list) {
 		struct nd_namespace_label *nd_label = label_ent->label;
 
 		if (!nd_label)
@@ -1264,9 +1277,8 @@ int nd_pmem_namespace_label_update(struct nd_region *nd_region,
 			continue;
 		}
 
-		for_each_dpa_resource(ndd, res)
-			if (strncmp(res->name, "pmem", 4) == 0)
-				count++;
+		for_each_dpa_resource(ndd, res) if (strncmp(res->name, "pmem",
+							    4) == 0) count++;
 		WARN_ON_ONCE(!count);
 
 		rc = init_labels(nd_mapping, count);
@@ -1305,8 +1317,7 @@ int nd_blk_namespace_label_update(struct nd_region *nd_region,
 	if (size == 0)
 		return del_labels(nd_mapping, nsblk->uuid);
 
-	for_each_dpa_resource(to_ndd(nd_mapping), res)
-		count++;
+	for_each_dpa_resource(to_ndd(nd_mapping), res) count++;
 
 	count = init_labels(nd_mapping, count);
 	if (count < 0)
diff --git a/drivers/nvdimm/label.h b/drivers/nvdimm/label.h
index a008ec92f78c..b67eb02811cf 100644
--- a/drivers/nvdimm/label.h
+++ b/drivers/nvdimm/label.h
@@ -10,24 +10,23 @@
 #include <linux/uuid.h>
 #include <linux/io.h>
 
-enum {
-	NSINDEX_SIG_LEN = 16,
-	NSINDEX_ALIGN = 256,
-	NSINDEX_SEQ_MASK = 0x3,
-	NSLABEL_UUID_LEN = 16,
-	NSLABEL_NAME_LEN = 64,
-	NSLABEL_FLAG_ROLABEL = 0x1,  /* read-only label */
-	NSLABEL_FLAG_LOCAL = 0x2,    /* DIMM-local namespace */
-	NSLABEL_FLAG_BTT = 0x4,      /* namespace contains a BTT */
-	NSLABEL_FLAG_UPDATING = 0x8, /* label being updated */
-	BTT_ALIGN = 4096,            /* all btt structures */
-	BTTINFO_SIG_LEN = 16,
-	BTTINFO_UUID_LEN = 16,
-	BTTINFO_FLAG_ERROR = 0x1,    /* error state (read-only) */
-	BTTINFO_MAJOR_VERSION = 1,
-	ND_LABEL_MIN_SIZE = 256 * 4, /* see sizeof_namespace_index() */
-	ND_LABEL_ID_SIZE = 50,
-	ND_NSINDEX_INIT = 0x1,
+enum { NSINDEX_SIG_LEN = 16,
+       NSINDEX_ALIGN = 256,
+       NSINDEX_SEQ_MASK = 0x3,
+       NSLABEL_UUID_LEN = 16,
+       NSLABEL_NAME_LEN = 64,
+       NSLABEL_FLAG_ROLABEL = 0x1, /* read-only label */
+       NSLABEL_FLAG_LOCAL = 0x2, /* DIMM-local namespace */
+       NSLABEL_FLAG_BTT = 0x4, /* namespace contains a BTT */
+       NSLABEL_FLAG_UPDATING = 0x8, /* label being updated */
+       BTT_ALIGN = 4096, /* all btt structures */
+       BTTINFO_SIG_LEN = 16,
+       BTTINFO_UUID_LEN = 16,
+       BTTINFO_FLAG_ERROR = 0x1, /* error state (read-only) */
+       BTTINFO_MAJOR_VERSION = 1,
+       ND_LABEL_MIN_SIZE = 256 * 4, /* see sizeof_namespace_index() */
+       ND_LABEL_ID_SIZE = 50,
+       ND_NSINDEX_INIT = 0x1,
 };
 
 /**
diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index d53efe06d312..e08e05bb5f97 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -162,7 +162,7 @@ unsigned int pmem_sector_size(struct nd_namespace_common *ndns)
 
 		nspm = to_nd_namespace_pmem(&ndns->dev);
 		if (nspm->lbasize == 0 || nspm->lbasize == 512)
-			;	/* default */
+			/* default */;
 		else if (nspm->lbasize == 4096)
 			return 4096;
 		else
@@ -198,17 +198,17 @@ const char *nvdimm_namespace_disk_name(struct nd_namespace_common *ndns,
 		}
 
 		if (nsidx)
-			sprintf(name, "pmem%d.%d%s",
-				nd_region->id, nsidx, suffix ? suffix : "");
+			sprintf(name, "pmem%d.%d%s", nd_region->id, nsidx,
+				suffix ? suffix : "");
 		else
-			sprintf(name, "pmem%d%s",
-				nd_region->id, suffix ? suffix : "");
+			sprintf(name, "pmem%d%s", nd_region->id,
+				suffix ? suffix : "");
 	} else if (is_namespace_blk(&ndns->dev)) {
 		struct nd_namespace_blk *nsblk;
 
 		nsblk = to_nd_namespace_blk(&ndns->dev);
-		sprintf(name, "ndblk%d.%d%s",
-			nd_region->id, nsblk->id, suffix ? suffix : "");
+		sprintf(name, "ndblk%d.%d%s", nd_region->id, nsblk->id,
+			suffix ? suffix : "");
 	} else {
 		return NULL;
 	}
@@ -228,19 +228,17 @@ const u8 *nd_dev_to_uuid(struct device *dev)
 		struct nd_namespace_pmem *nspm = to_nd_namespace_pmem(dev);
 
 		return nspm->uuid;
-	}
-	if (is_namespace_blk(dev)) {
+	} else if (is_namespace_blk(dev)) {
 		struct nd_namespace_blk *nsblk = to_nd_namespace_blk(dev);
 
 		return nsblk->uuid;
-	}
-
-	return null_uuid;
+	} else
+		return null_uuid;
 }
 EXPORT_SYMBOL(nd_dev_to_uuid);
 
-static ssize_t nstype_show(struct device *dev,
-			   struct device_attribute *attr, char *buf)
+static ssize_t nstype_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
 {
 	struct nd_region *nd_region = to_nd_region(dev->parent);
 
@@ -262,9 +260,8 @@ static ssize_t __alt_name_store(struct device *dev, const char *buf,
 		struct nd_namespace_blk *nsblk = to_nd_namespace_blk(dev);
 
 		ns_altname = &nsblk->alt_name;
-	} else {
+	} else
 		return -ENXIO;
-	}
 
 	if (dev->driver || to_ndns(dev)->claim)
 		return -EBUSY;
@@ -306,9 +303,8 @@ static resource_size_t nd_namespace_blk_size(struct nd_namespace_blk *nsblk)
 	if (!nsblk->uuid)
 		return 0;
 	nd_label_gen_id(&label_id, nsblk->uuid, NSLABEL_FLAG_LOCAL);
-	for_each_dpa_resource(ndd, res)
-		if (strcmp(res->name, label_id.id) == 0)
-			size += resource_size(res);
+	for_each_dpa_resource(ndd, res) if (strcmp(res->name, label_id.id) == 0)
+		size += resource_size(res);
 	return size;
 }
 
@@ -326,7 +322,8 @@ static bool __nd_namespace_blk_validate(struct nd_namespace_blk *nsblk)
 
 	count = 0;
 	nd_label_gen_id(&label_id, nsblk->uuid, NSLABEL_FLAG_LOCAL);
-	for_each_dpa_resource(ndd, res) {
+	for_each_dpa_resource(ndd, res)
+	{
 		if (strcmp(res->name, label_id.id) != 0)
 			continue;
 		/*
@@ -345,11 +342,11 @@ static bool __nd_namespace_blk_validate(struct nd_namespace_blk *nsblk)
 	for (i = 0; i < nsblk->num_resources; i++) {
 		struct resource *found = NULL;
 
-		for_each_dpa_resource(ndd, res)
-			if (res == nsblk->res[i]) {
-				found = res;
-				break;
-			}
+		for_each_dpa_resource(ndd, res) if (res == nsblk->res[i])
+		{
+			found = res;
+			break;
+		}
 		/* stale resource */
 		if (!found)
 			return false;
@@ -387,25 +384,23 @@ static int nd_namespace_label_update(struct nd_region *nd_region,
 		resource_size_t size = resource_size(&nspm->nsio.res);
 
 		if (size == 0 && nspm->uuid)
-			;	/* delete allocation */
+			/* delete allocation */;
 		else if (!nspm->uuid)
 			return 0;
 
 		return nd_pmem_namespace_label_update(nd_region, nspm, size);
-	}
-	if (is_namespace_blk(dev)) {
+	} else if (is_namespace_blk(dev)) {
 		struct nd_namespace_blk *nsblk = to_nd_namespace_blk(dev);
 		resource_size_t size = nd_namespace_blk_size(nsblk);
 
 		if (size == 0 && nsblk->uuid)
-			;	/* delete allocation */
+			/* delete allocation */;
 		else if (!nsblk->uuid || !nsblk->lbasize)
 			return 0;
 
 		return nd_blk_namespace_label_update(nd_region, nsblk, size);
-	}
-
-	return -ENXIO;
+	} else
+		return -ENXIO;
 }
 
 static ssize_t alt_name_store(struct device *dev, struct device_attribute *attr,
@@ -427,8 +422,8 @@ static ssize_t alt_name_store(struct device *dev, struct device_attribute *attr,
 	return rc < 0 ? rc : len;
 }
 
-static ssize_t alt_name_show(struct device *dev,
-			     struct device_attribute *attr, char *buf)
+static ssize_t alt_name_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
 {
 	char *ns_altname;
 
@@ -440,9 +435,8 @@ static ssize_t alt_name_show(struct device *dev,
 		struct nd_namespace_blk *nsblk = to_nd_namespace_blk(dev);
 
 		ns_altname = nsblk->alt_name;
-	} else {
+	} else
 		return -ENXIO;
-	}
 
 	return sprintf(buf, "%s\n", ns_altname ? ns_altname : "");
 }
@@ -460,9 +454,9 @@ static int scan_free(struct nd_region *nd_region, struct nd_mapping *nd_mapping,
 		resource_size_t new_start;
 
 		last = NULL;
-		for_each_dpa_resource(ndd, res)
-			if (strcmp(res->name, label_id->id) == 0)
-				last = res;
+		for_each_dpa_resource(ndd, res) if (strcmp(res->name,
+							   label_id->id) == 0)
+			last = res;
 		res = last;
 		if (!res)
 			return 0;
@@ -603,8 +597,7 @@ static void space_valid(struct nd_region *nd_region, struct nvdimm_drvdata *ndd,
 		return;
 
 	/* allocation needs to be contiguous with the existing namespace */
-	if (valid->start == exist->end + 1 ||
-	    valid->end == exist->start - 1)
+	if (valid->start == exist->end + 1 || valid->end == exist->start - 1)
 		return;
 
 invalid:
@@ -613,7 +606,10 @@ static void space_valid(struct nd_region *nd_region, struct nvdimm_drvdata *ndd,
 }
 
 enum alloc_loc {
-	ALLOC_ERR = 0, ALLOC_BEFORE, ALLOC_MID, ALLOC_AFTER,
+	ALLOC_ERR = 0,
+	ALLOC_BEFORE,
+	ALLOC_MID,
+	ALLOC_AFTER,
 };
 
 static resource_size_t scan_allocate(struct nd_region *nd_region,
@@ -628,17 +624,16 @@ static resource_size_t scan_allocate(struct nd_region *nd_region,
 	const resource_size_t to_allocate = n;
 	int first;
 
-	for_each_dpa_resource(ndd, res) {
-		if (strcmp(label_id->id, res->name) == 0)
-			exist = res;
-	}
+	for_each_dpa_resource(ndd, res) if (strcmp(label_id->id, res->name) ==
+					    0) exist = res;
 
 	valid.start = nd_mapping->start;
 	valid.end = mapping_end;
 	valid.name = "free space";
 retry:
 	first = 0;
-	for_each_dpa_resource(ndd, res) {
+	for_each_dpa_resource(ndd, res)
+	{
 		struct resource *next = res->sibling, *new_res = NULL;
 		resource_size_t allocate, available = 0;
 		enum alloc_loc loc = ALLOC_ERR;
@@ -692,26 +687,24 @@ static resource_size_t scan_allocate(struct nd_region *nd_region,
 			if (strcmp(res->name, label_id->id) == 0) {
 				/* adjust current resource up */
 				rc = adjust_resource(res, res->start - allocate,
-						     resource_size(res) + allocate);
+						     resource_size(res) +
+							     allocate);
 				action = "cur grow up";
-			} else {
+			} else
 				action = "allocate";
-			}
 			break;
 		case ALLOC_MID:
 			if (strcmp(next->name, label_id->id) == 0) {
 				/* adjust next resource up */
-				rc = adjust_resource(next,
-						     next->start - allocate,
-						     resource_size(next)
-						     + allocate);
+				rc = adjust_resource(
+					next, next->start - allocate,
+					resource_size(next) + allocate);
 				new_res = next;
 				action = "next grow up";
 			} else if (strcmp(res->name, label_id->id) == 0) {
 				action = "grow down";
-			} else {
+			} else
 				action = "allocate";
-			}
 			break;
 		case ALLOC_AFTER:
 			if (strcmp(res->name, label_id->id) == 0)
@@ -743,8 +736,8 @@ static resource_size_t scan_allocate(struct nd_region *nd_region,
 		if (!new_res)
 			new_res = res;
 
-		nd_dbg_dpa(nd_region, ndd, new_res, "%s(%d) %d\n",
-			   action, loc, rc);
+		nd_dbg_dpa(nd_region, ndd, new_res, "%s(%d) %d\n", action, loc,
+			   rc);
 
 		if (rc)
 			return n;
@@ -759,9 +752,8 @@ static resource_size_t scan_allocate(struct nd_region *nd_region,
 			 * need to check this same resource again
 			 */
 			goto retry;
-		} else {
+		} else
 			return 0;
-		}
 	}
 
 	/*
@@ -774,8 +766,7 @@ static resource_size_t scan_allocate(struct nd_region *nd_region,
 	return n;
 }
 
-static int merge_dpa(struct nd_region *nd_region,
-		     struct nd_mapping *nd_mapping,
+static int merge_dpa(struct nd_region *nd_region, struct nd_mapping *nd_mapping,
 		     struct nd_label_id *label_id)
 {
 	struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
@@ -784,15 +775,14 @@ static int merge_dpa(struct nd_region *nd_region,
 	if (strncmp("pmem", label_id->id, 4) == 0)
 		return 0;
 retry:
-	for_each_dpa_resource(ndd, res) {
+	for_each_dpa_resource(ndd, res)
+	{
 		int rc;
 		struct resource *next = res->sibling;
 		resource_size_t end = res->start + resource_size(res);
 
-		if (!next ||
-		    strcmp(res->name, label_id->id) != 0 ||
-		    strcmp(next->name, label_id->id) != 0 ||
-		    end != next->start)
+		if (!next || strcmp(res->name, label_id->id) != 0 ||
+		    strcmp(next->name, label_id->id) != 0 || end != next->start)
 			continue;
 		end += resource_size(next);
 		nvdimm_free_dpa(ndd, next);
@@ -836,7 +826,8 @@ int __reserve_free_pmem(struct device *dev, void *data)
 		rem = scan_allocate(nd_region, nd_mapping, &label_id, n);
 		dev_WARN_ONCE(&nd_region->dev, rem,
 			      "pmem reserve underrun: %#llx of %#llx bytes\n",
-			      (u64)n - rem, (u64)n);
+			      (unsigned long long)n - rem,
+			      (unsigned long long)n);
 		return rem ? -ENXIO : 0;
 	}
 
@@ -849,9 +840,9 @@ void release_free_pmem(struct nvdimm_bus *nvdimm_bus,
 	struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
 	struct resource *res, *_res;
 
-	for_each_dpa_resource_safe(ndd, res, _res)
-		if (strcmp(res->name, "pmem-reserve") == 0)
-			nvdimm_free_dpa(ndd, res);
+	for_each_dpa_resource_safe(
+		ndd, res, _res) if (strcmp(res->name, "pmem-reserve") == 0)
+		nvdimm_free_dpa(ndd, res);
 }
 
 static int reserve_free_pmem(struct nvdimm_bus *nvdimm_bus,
@@ -904,8 +895,8 @@ static int grow_dpa_allocation(struct nd_region *nd_region,
 				if (rc)
 					return rc;
 			}
-			rem = scan_allocate(nd_region, nd_mapping,
-					    label_id, rem);
+			rem = scan_allocate(nd_region, nd_mapping, label_id,
+					    rem);
 			if (blk_only)
 				release_free_pmem(nvdimm_bus, nd_mapping);
 
@@ -916,7 +907,8 @@ static int grow_dpa_allocation(struct nd_region *nd_region,
 
 		dev_WARN_ONCE(&nd_region->dev, rem,
 			      "allocation underrun: %#llx of %#llx bytes\n",
-			      (u64)n - rem, (u64)n);
+			      (unsigned long long)n - rem,
+			      (unsigned long long)n);
 		if (rem)
 			return -ENXIO;
 
@@ -954,12 +946,13 @@ static void nd_namespace_pmem_set_resource(struct nd_region *nd_region,
 		nd_label_gen_id(&label_id, nspm->uuid, 0);
 
 		/* calculate a spa offset from the dpa allocation offset */
-		for_each_dpa_resource(ndd, res)
-			if (strcmp(res->name, label_id.id) == 0) {
-				offset = (res->start - nd_mapping->start)
-					* nd_region->ndr_mappings;
-				goto out;
-			}
+		for_each_dpa_resource(ndd, res) if (strcmp(res->name,
+							   label_id.id) == 0)
+		{
+			offset = (res->start - nd_mapping->start) *
+				 nd_region->ndr_mappings;
+			goto out;
+		}
 
 		WARN_ON_ONCE(1);
 		size = 0;
@@ -1128,18 +1121,14 @@ resource_size_t __nvdimm_namespace_capacity(struct nd_namespace_common *ndns)
 		struct nd_namespace_pmem *nspm = to_nd_namespace_pmem(dev);
 
 		return resource_size(&nspm->nsio.res);
-	}
-
-	if (is_namespace_blk(dev))
+	} else if (is_namespace_blk(dev)) {
 		return nd_namespace_blk_size(to_nd_namespace_blk(dev));
-
-	if (is_namespace_io(dev)) {
+	} else if (is_namespace_io(dev)) {
 		struct nd_namespace_io *nsio = to_nd_namespace_io(dev);
 
 		return resource_size(&nsio->res);
-	}
-
-	WARN_ONCE(1, "unknown namespace type\n");
+	} else
+		WARN_ONCE(1, "unknown namespace type\n");
 	return 0;
 }
 
@@ -1175,11 +1164,12 @@ bool nvdimm_namespace_locked(struct nd_namespace_common *ndns)
 }
 EXPORT_SYMBOL(nvdimm_namespace_locked);
 
-static ssize_t size_show(struct device *dev,
-			 struct device_attribute *attr, char *buf)
+static ssize_t size_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
 {
-	return sprintf(buf, "%llu\n",
-		       (u64)nvdimm_namespace_capacity(to_ndns(dev)));
+	return sprintf(
+		buf, "%llu\n",
+		(unsigned long long)nvdimm_namespace_capacity(to_ndns(dev)));
 }
 static DEVICE_ATTR(size, 0444, size_show, size_store);
 
@@ -1189,18 +1179,16 @@ static u8 *namespace_to_uuid(struct device *dev)
 		struct nd_namespace_pmem *nspm = to_nd_namespace_pmem(dev);
 
 		return nspm->uuid;
-	}
-	if (is_namespace_blk(dev)) {
+	} else if (is_namespace_blk(dev)) {
 		struct nd_namespace_blk *nsblk = to_nd_namespace_blk(dev);
 
 		return nsblk->uuid;
-	}
-
-	return ERR_PTR(-ENXIO);
+	} else
+		return ERR_PTR(-ENXIO);
 }
 
-static ssize_t uuid_show(struct device *dev,
-			 struct device_attribute *attr, char *buf)
+static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
 {
 	u8 *uuid = namespace_to_uuid(dev);
 
@@ -1219,8 +1207,8 @@ static ssize_t uuid_show(struct device *dev,
  * @old_uuid: reference to the uuid storage location in the namespace object
  */
 static int namespace_update_uuid(struct nd_region *nd_region,
-				 struct device *dev,
-				 u8 *new_uuid, u8 **old_uuid)
+				 struct device *dev, u8 *new_uuid,
+				 u8 **old_uuid)
 {
 	u32 flags = is_namespace_blk(dev) ? NSLABEL_FLAG_LOCAL : 0;
 	struct nd_label_id old_label_id;
@@ -1261,13 +1249,12 @@ static int namespace_update_uuid(struct nd_region *nd_region,
 		struct nd_label_ent *label_ent;
 		struct resource *res;
 
-		for_each_dpa_resource(ndd, res)
-			if (strcmp(res->name, old_label_id.id) == 0)
-				sprintf((void *)res->name, "%s",
-					new_label_id.id);
+		for_each_dpa_resource(
+			ndd, res) if (strcmp(res->name, old_label_id.id) == 0)
+			sprintf((void *)res->name, "%s", new_label_id.id);
 
 		mutex_lock(&nd_mapping->lock);
-		list_for_each_entry(label_ent, &nd_mapping->labels, list) {
+		list_for_each_entry (label_ent, &nd_mapping->labels, list) {
 			struct nd_namespace_label *nd_label = label_ent->label;
 			struct nd_label_id label_id;
 
@@ -1302,9 +1289,8 @@ static ssize_t uuid_store(struct device *dev, struct device_attribute *attr,
 		struct nd_namespace_blk *nsblk = to_nd_namespace_blk(dev);
 
 		ns_uuid = &nsblk->uuid;
-	} else {
+	} else
 		return -ENXIO;
-	}
 
 	nd_device_lock(dev);
 	nvdimm_bus_lock(dev);
@@ -1319,8 +1305,8 @@ static ssize_t uuid_store(struct device *dev, struct device_attribute *attr,
 		rc = nd_namespace_label_update(nd_region, dev);
 	else
 		kfree(uuid);
-	dev_dbg(dev, "result: %zd wrote: %s%s",
-		rc, buf, buf[len - 1] == '\n' ? "" : "\n");
+	dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
+		buf[len - 1] == '\n' ? "" : "\n");
 	nvdimm_bus_unlock(dev);
 	nd_device_unlock(dev);
 
@@ -1328,8 +1314,8 @@ static ssize_t uuid_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(uuid);
 
-static ssize_t resource_show(struct device *dev,
-			     struct device_attribute *attr, char *buf)
+static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
 {
 	struct resource *res;
 
@@ -1341,24 +1327,20 @@ static ssize_t resource_show(struct device *dev,
 		struct nd_namespace_io *nsio = to_nd_namespace_io(dev);
 
 		res = &nsio->res;
-	} else {
+	} else
 		return -ENXIO;
-	}
 
 	/* no address to convey if the namespace has no allocation */
 	if (resource_size(res) == 0)
 		return -ENXIO;
-	return sprintf(buf, "%#llx\n", (u64)res->start);
+	return sprintf(buf, "%#llx\n", (unsigned long long)res->start);
 }
 static DEVICE_ATTR_RO(resource);
 
-static const unsigned long blk_lbasize_supported[] = {
-	512, 520, 528, 4096, 4104, 4160, 4224, 0
-};
+static const unsigned long blk_lbasize_supported[] = { 512,  520,  528,	 4096,
+						       4104, 4160, 4224, 0 };
 
-static const unsigned long pmem_lbasize_supported[] = {
-	512, 4096, 0
-};
+static const unsigned long pmem_lbasize_supported[] = { 512, 4096, 0 };
 
 static ssize_t sector_size_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -1380,8 +1362,8 @@ static ssize_t sector_size_show(struct device *dev,
 }
 
 static ssize_t sector_size_store(struct device *dev,
-				 struct device_attribute *attr,
-				 const char *buf, size_t len)
+				 struct device_attribute *attr, const char *buf,
+				 size_t len)
 {
 	struct nd_region *nd_region = to_nd_region(dev->parent);
 	const unsigned long *supported;
@@ -1398,9 +1380,8 @@ static ssize_t sector_size_store(struct device *dev,
 
 		lbasize = &nspm->lbasize;
 		supported = pmem_lbasize_supported;
-	} else {
+	} else
 		return -ENXIO;
-	}
 
 	nd_device_lock(dev);
 	nvdimm_bus_lock(dev);
@@ -1410,8 +1391,7 @@ static ssize_t sector_size_store(struct device *dev,
 		rc = nd_size_select_store(dev, buf, lbasize, supported);
 	if (rc >= 0)
 		rc = nd_namespace_label_update(nd_region, dev);
-	dev_dbg(dev, "result: %zd %s: %s%s",
-		rc, rc < 0 ? "tried" : "wrote",
+	dev_dbg(dev, "result: %zd %s: %s%s", rc, rc < 0 ? "tried" : "wrote",
 		buf, buf[len - 1] == '\n' ? "" : "\n");
 	nvdimm_bus_unlock(dev);
 	nd_device_unlock(dev);
@@ -1451,9 +1431,9 @@ static ssize_t dpa_extents_show(struct device *dev,
 		struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
 		struct resource *res;
 
-		for_each_dpa_resource(ndd, res)
-			if (strcmp(res->name, label_id.id) == 0)
-				count++;
+		for_each_dpa_resource(ndd, res) if (strcmp(res->name,
+							   label_id.id) == 0)
+			count++;
 	}
 out:
 	nvdimm_bus_unlock(dev);
@@ -1482,9 +1462,9 @@ static int btt_claim_class(struct device *dev)
 		}
 
 		nsindex = to_namespace_index(ndd, ndd->ns_current);
-		if (nsindex == NULL) {
+		if (nsindex == NULL)
 			loop_bitmask |= 1;
-		} else {
+		else {
 			/* check whether existing labels are v1.1 or v1.2 */
 			if (__le16_to_cpu(nsindex->major) == 1 &&
 			    __le16_to_cpu(nsindex->minor) == 1)
@@ -1523,8 +1503,8 @@ static int btt_claim_class(struct device *dev)
 	}
 }
 
-static ssize_t holder_show(struct device *dev,
-			   struct device_attribute *attr, char *buf)
+static ssize_t holder_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
 {
 	struct nd_namespace_common *ndns = to_ndns(dev);
 	ssize_t rc;
@@ -1606,8 +1586,8 @@ static ssize_t holder_class_show(struct device *dev,
 }
 static DEVICE_ATTR_RW(holder_class);
 
-static ssize_t mode_show(struct device *dev,
-			 struct device_attribute *attr, char *buf)
+static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
 {
 	struct nd_namespace_common *ndns = to_ndns(dev);
 	struct device *claim;
@@ -1634,8 +1614,8 @@ static ssize_t mode_show(struct device *dev,
 static DEVICE_ATTR_RO(mode);
 
 static ssize_t force_raw_store(struct device *dev,
-			       struct device_attribute *attr,
-			       const char *buf, size_t len)
+			       struct device_attribute *attr, const char *buf,
+			       size_t len)
 {
 	bool force_raw;
 	int rc = strtobool(buf, &force_raw);
@@ -1647,30 +1627,24 @@ static ssize_t force_raw_store(struct device *dev,
 	return len;
 }
 
-static ssize_t force_raw_show(struct device *dev,
-			      struct device_attribute *attr, char *buf)
+static ssize_t force_raw_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
 {
 	return sprintf(buf, "%d\n", to_ndns(dev)->force_raw);
 }
 static DEVICE_ATTR_RW(force_raw);
 
 static struct attribute *nd_namespace_attributes[] = {
-	&dev_attr_nstype.attr,
-	&dev_attr_size.attr,
-	&dev_attr_mode.attr,
-	&dev_attr_uuid.attr,
-	&dev_attr_holder.attr,
-	&dev_attr_resource.attr,
-	&dev_attr_alt_name.attr,
-	&dev_attr_force_raw.attr,
-	&dev_attr_sector_size.attr,
-	&dev_attr_dpa_extents.attr,
-	&dev_attr_holder_class.attr,
-	NULL,
+	&dev_attr_nstype.attr,	     &dev_attr_size.attr,
+	&dev_attr_mode.attr,	     &dev_attr_uuid.attr,
+	&dev_attr_holder.attr,	     &dev_attr_resource.attr,
+	&dev_attr_alt_name.attr,     &dev_attr_force_raw.attr,
+	&dev_attr_sector_size.attr,  &dev_attr_dpa_extents.attr,
+	&dev_attr_holder_class.attr, NULL,
 };
 
-static umode_t namespace_visible(struct kobject *kobj,
-				 struct attribute *a, int n)
+static umode_t namespace_visible(struct kobject *kobj, struct attribute *a,
+				 int n)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
 
@@ -1687,12 +1661,9 @@ static umode_t namespace_visible(struct kobject *kobj,
 		return a->mode;
 	}
 
-	if (a == &dev_attr_nstype.attr ||
-	    a == &dev_attr_size.attr ||
-	    a == &dev_attr_holder.attr ||
-	    a == &dev_attr_holder_class.attr ||
-	    a == &dev_attr_force_raw.attr ||
-	    a == &dev_attr_mode.attr)
+	if (a == &dev_attr_nstype.attr || a == &dev_attr_size.attr ||
+	    a == &dev_attr_holder.attr || a == &dev_attr_holder_class.attr ||
+	    a == &dev_attr_force_raw.attr || a == &dev_attr_mode.attr)
 		return a->mode;
 
 	return 0;
@@ -1730,7 +1701,7 @@ struct nd_namespace_common *nvdimm_namespace_common_probe(struct device *dev)
 			return ERR_PTR(-ENODEV);
 
 		/*
-		 * Flush any in-progress probes / removals in the driver
+		 * Flush any in-progess probes / removals in the driver
 		 * for the raw personality of this namespace.
 		 */
 		nd_device_lock(&ndns->dev);
@@ -1742,8 +1713,7 @@ struct nd_namespace_common *nvdimm_namespace_common_probe(struct device *dev)
 		}
 		if (dev_WARN_ONCE(&ndns->dev, ndns->claim != dev,
 				  "host (%s) vs claim (%s) mismatch\n",
-				  dev_name(dev),
-				  dev_name(ndns->claim)))
+				  dev_name(dev), dev_name(ndns->claim)))
 			return ERR_PTR(-ENXIO);
 	} else {
 		ndns = to_ndns(dev);
@@ -1818,8 +1788,8 @@ static struct device **create_namespace_io(struct nd_region *nd_region)
 	return devs;
 }
 
-static bool has_uuid_at_pos(struct nd_region *nd_region, u8 *uuid,
-			    u64 cookie, u16 pos)
+static bool has_uuid_at_pos(struct nd_region *nd_region, u8 *uuid, u64 cookie,
+			    u16 pos)
 {
 	struct nd_namespace_label *found = NULL;
 	int i;
@@ -1831,7 +1801,7 @@ static bool has_uuid_at_pos(struct nd_region *nd_region, u8 *uuid,
 		struct nd_label_ent *label_ent;
 		bool found_uuid = false;
 
-		list_for_each_entry(label_ent, &nd_mapping->labels, list) {
+		list_for_each_entry (label_ent, &nd_mapping->labels, list) {
 			struct nd_namespace_label *nd_label = label_ent->label;
 			u16 position, nlabel;
 			u64 isetcookie;
@@ -1851,7 +1821,8 @@ static bool has_uuid_at_pos(struct nd_region *nd_region, u8 *uuid,
 			if (namespace_label_has(ndd, type_guid) &&
 			    !guid_equal(&nd_set->type_guid,
 					&nd_label->type_guid)) {
-				dev_dbg(ndd->dev, "expect type_guid %pUb got %pUb\n",
+				dev_dbg(ndd->dev,
+					"expect type_guid %pUb got %pUb\n",
 					&nd_set->type_guid,
 					&nd_label->type_guid);
 				continue;
@@ -1890,11 +1861,12 @@ static int select_pmem_id(struct nd_region *nd_region, u8 *pmem_id)
 		struct nd_label_ent *label_ent;
 
 		lockdep_assert_held(&nd_mapping->lock);
-		list_for_each_entry(label_ent, &nd_mapping->labels, list) {
+		list_for_each_entry (label_ent, &nd_mapping->labels, list) {
 			nd_label = label_ent->label;
 			if (!nd_label)
 				continue;
-			if (memcmp(nd_label->uuid, pmem_id, NSLABEL_UUID_LEN) == 0)
+			if (memcmp(nd_label->uuid, pmem_id, NSLABEL_UUID_LEN) ==
+			    0)
 				break;
 			nd_label = NULL;
 		}
@@ -1912,8 +1884,10 @@ static int select_pmem_id(struct nd_region *nd_region, u8 *pmem_id)
 		hw_end = hw_start + nd_mapping->size;
 		pmem_start = __le64_to_cpu(nd_label->dpa);
 		pmem_end = pmem_start + __le64_to_cpu(nd_label->rawsize);
-		if (!(pmem_start >= hw_start && pmem_start < hw_end &&
-		      pmem_end <= hw_end && pmem_end > hw_start)) {
+		if (pmem_start >= hw_start && pmem_start < hw_end &&
+		    pmem_end <= hw_end && pmem_end > hw_start)
+			/* pass */;
+		else {
 			dev_dbg(&nd_region->dev, "%s invalid label for %pUb\n",
 				dev_name(ndd->dev), nd_label->uuid);
 			return -EINVAL;
@@ -2062,25 +2036,26 @@ static struct device *create_namespace_pmem(struct nd_region *nd_region,
 }
 
 struct resource *nsblk_add_resource(struct nd_region *nd_region,
-				    struct nvdimm_drvdata *ndd, struct nd_namespace_blk *nsblk,
+				    struct nvdimm_drvdata *ndd,
+				    struct nd_namespace_blk *nsblk,
 				    resource_size_t start)
 {
 	struct nd_label_id label_id;
 	struct resource *res;
 
 	nd_label_gen_id(&label_id, nsblk->uuid, NSLABEL_FLAG_LOCAL);
-	res = krealloc(nsblk->res,
-		       sizeof(void *) * (nsblk->num_resources + 1),
+	res = krealloc(nsblk->res, sizeof(void *) * (nsblk->num_resources + 1),
 		       GFP_KERNEL);
 	if (!res)
 		return NULL;
 	nsblk->res = (struct resource **)res;
-	for_each_dpa_resource(ndd, res)
-		if (strcmp(res->name, label_id.id) == 0 &&
-		    res->start == start) {
-			nsblk->res[nsblk->num_resources++] = res;
-			return res;
-		}
+	for_each_dpa_resource(ndd,
+			      res) if (strcmp(res->name, label_id.id) == 0 &&
+				       res->start == start)
+	{
+		nsblk->res[nsblk->num_resources++] = res;
+		return res;
+	}
 	return NULL;
 }
 
@@ -2254,8 +2229,7 @@ static struct device *create_namespace_blk(struct nd_region *nd_region,
 	if (namespace_label_has(ndd, type_guid)) {
 		if (!guid_equal(&nd_set->type_guid, &nd_label->type_guid)) {
 			dev_dbg(ndd->dev, "expect type_guid %pUb got %pUb\n",
-				&nd_set->type_guid,
-				&nd_label->type_guid);
+				&nd_set->type_guid, &nd_label->type_guid);
 			return ERR_PTR(-EAGAIN);
 		}
 
@@ -2275,8 +2249,7 @@ static struct device *create_namespace_blk(struct nd_region *nd_region,
 	dev->parent = &nd_region->dev;
 	nsblk->id = -1;
 	nsblk->lbasize = __le64_to_cpu(nd_label->lbasize);
-	nsblk->uuid = kmemdup(nd_label->uuid, NSLABEL_UUID_LEN,
-			      GFP_KERNEL);
+	nsblk->uuid = kmemdup(nd_label->uuid, NSLABEL_UUID_LEN, GFP_KERNEL);
 	if (namespace_label_has(ndd, abstraction_guid))
 		nsblk->common.claim_class =
 			to_nvdimm_cclass(&nd_label->abstraction_guid);
@@ -2284,8 +2257,7 @@ static struct device *create_namespace_blk(struct nd_region *nd_region,
 		goto blk_err;
 	memcpy(name, nd_label->name, NSLABEL_NAME_LEN);
 	if (name[0]) {
-		nsblk->alt_name = kmemdup(name, NSLABEL_NAME_LEN,
-					  GFP_KERNEL);
+		nsblk->alt_name = kmemdup(name, NSLABEL_NAME_LEN, GFP_KERNEL);
 		if (!nsblk->alt_name)
 			goto blk_err;
 	}
@@ -2334,15 +2306,18 @@ static struct device **scan_labels(struct nd_region *nd_region)
 	resource_size_t map_end = nd_mapping->start + nd_mapping->size - 1;
 
 	/* "safe" because create_namespace_pmem() might list_move() label_ent */
-	list_for_each_entry_safe(label_ent, e, &nd_mapping->labels, list) {
+	list_for_each_entry_safe (label_ent, e, &nd_mapping->labels, list) {
 		struct nd_namespace_label *nd_label = label_ent->label;
 		struct device **__devs;
-		bool localflag;
+		u32 flags;
 
 		if (!nd_label)
 			continue;
-		localflag = __le32_to_cpu(nd_label->flags) & NSLABEL_FLAG_LOCAL;
-		if (is_nd_blk(&nd_region->dev) != localflag)
+		flags = __le32_to_cpu(nd_label->flags);
+		if (is_nd_blk(&nd_region->dev) ==
+		    !!(flags & NSLABEL_FLAG_LOCAL))
+			/* pass, region matches label type */;
+		else
 			continue;
 
 		/* skip labels that describe extents outside of the region */
@@ -2362,14 +2337,15 @@ static struct device **scan_labels(struct nd_region *nd_region)
 		kfree(devs);
 		devs = __devs;
 
-		if (is_nd_blk(&nd_region->dev)) {
+		if (is_nd_blk(&nd_region->dev))
 			dev = create_namespace_blk(nd_region, nd_label, count);
-		} else {
+		else {
 			struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
 			struct nd_namespace_index *nsindex;
 
 			nsindex = to_namespace_index(ndd, ndd->ns_current);
-			dev = create_namespace_pmem(nd_region, nsindex, nd_label);
+			dev = create_namespace_pmem(nd_region, nsindex,
+						    nd_label);
 		}
 
 		if (IS_ERR(dev)) {
@@ -2383,14 +2359,13 @@ static struct device **scan_labels(struct nd_region *nd_region)
 			default:
 				goto err;
 			}
-		} else {
+		} else
 			devs[count++] = dev;
-		}
 	}
 
-	dev_dbg(&nd_region->dev, "discovered %d %s namespace%s\n",
-		count, is_nd_blk(&nd_region->dev)
-		? "blk" : "pmem", count == 1 ? "" : "s");
+	dev_dbg(&nd_region->dev, "discovered %d %s namespace%s\n", count,
+		is_nd_blk(&nd_region->dev) ? "blk" : "pmem",
+		count == 1 ? "" : "s");
 
 	if (count == 0) {
 		/* Publish a zero-sized namespace for userspace to configure. */
@@ -2433,7 +2408,7 @@ static struct device **scan_labels(struct nd_region *nd_region)
 			}
 
 			j = count;
-			list_for_each_safe(l, e, &nd_mapping->labels) {
+			list_for_each_safe (l, e, &nd_mapping->labels) {
 				if (!j--)
 					break;
 				list_move_tail(l, &list);
@@ -2503,21 +2478,20 @@ static int init_active_labels(struct nd_region *nd_region)
 		 * the region from being activated.
 		 */
 		if (!ndd) {
-			if (test_bit(NDD_LOCKED, &nvdimm->flags) ||
-					/* label data may be unreadable */
-			    test_bit(NDD_ALIASING, &nvdimm->flags)) {
-					/* labels needed to disambiguate dpa */
-
-				dev_err(&nd_region->dev,
-					"%s: is %s, failing probe\n",
-					dev_name(&nd_mapping->nvdimm->dev),
-					test_bit(NDD_LOCKED, &nvdimm->flags)
-					? "locked" : "disabled");
-				return -ENXIO;
-			}
-			return 0;
-		}
+			if (test_bit(NDD_LOCKED, &nvdimm->flags))
+				/* fail, label data may be unreadable */;
+			else if (test_bit(NDD_ALIASING, &nvdimm->flags))
+				/* fail, labels needed to disambiguate dpa */;
+			else
+				return 0;
 
+			dev_err(&nd_region->dev, "%s: is %s, failing probe\n",
+				dev_name(&nd_mapping->nvdimm->dev),
+				test_bit(NDD_LOCKED, &nvdimm->flags) ?
+					"locked" :
+					"disabled");
+			return -ENXIO;
+		}
 		nd_mapping->ndd = ndd;
 		atomic_inc(&nvdimm->busy);
 		get_ndd(ndd);
@@ -2606,9 +2580,8 @@ int nd_region_register_namespaces(struct nd_region *nd_region, int *err)
 			id = ida_simple_get(&nd_region->ns_ida, 0, 0,
 					    GFP_KERNEL);
 			nspm->id = id;
-		} else {
+		} else
 			id = i;
-		}
 
 		if (id < 0)
 			break;
diff --git a/drivers/nvdimm/nd-core.h b/drivers/nvdimm/nd-core.h
index 15bbdf6bea24..0c0b84e2b98e 100644
--- a/drivers/nvdimm/nd-core.h
+++ b/drivers/nvdimm/nd-core.h
@@ -47,14 +47,14 @@ struct nvdimm {
 	struct delayed_work dwork;
 };
 
-static inline unsigned long nvdimm_security_flags(
-	struct nvdimm *nvdimm, enum nvdimm_passphrase_type ptype)
+static inline unsigned long
+nvdimm_security_flags(struct nvdimm *nvdimm, enum nvdimm_passphrase_type ptype)
 {
 	u64 flags;
-	const u64 state_flags = 1UL << NVDIMM_SECURITY_DISABLED
-		| 1UL << NVDIMM_SECURITY_LOCKED
-		| 1UL << NVDIMM_SECURITY_UNLOCKED
-		| 1UL << NVDIMM_SECURITY_OVERWRITE;
+	const u64 state_flags = 1UL << NVDIMM_SECURITY_DISABLED |
+				1UL << NVDIMM_SECURITY_LOCKED |
+				1UL << NVDIMM_SECURITY_UNLOCKED |
+				1UL << NVDIMM_SECURITY_OVERWRITE;
 
 	if (!nvdimm->sec.ops)
 		return 0;
@@ -62,21 +62,20 @@ static inline unsigned long nvdimm_security_flags(
 	flags = nvdimm->sec.ops->get_flags(nvdimm, ptype);
 	/* disabled, locked, unlocked, and overwrite are mutually exclusive */
 	dev_WARN_ONCE(&nvdimm->dev, hweight64(flags & state_flags) > 1,
-		      "reported invalid security state: %#llx\n", (u64)flags);
+		      "reported invalid security state: %#llx\n",
+		      (unsigned long long)flags);
 	return flags;
 }
-
 int nvdimm_security_freeze(struct nvdimm *nvdimm);
 #if IS_ENABLED(CONFIG_NVDIMM_KEYS)
 ssize_t nvdimm_security_store(struct device *dev, const char *buf, size_t len);
 void nvdimm_security_overwrite_query(struct work_struct *work);
 #else
-static inline ssize_t nvdimm_security_store(struct device *dev,
-					    const char *buf, size_t len)
+static inline ssize_t nvdimm_security_store(struct device *dev, const char *buf,
+					    size_t len)
 {
 	return -EOPNOTSUPP;
 }
-
 static inline void nvdimm_security_overwrite_query(struct work_struct *work)
 {
 }
@@ -107,12 +106,10 @@ static inline bool is_nd_region(struct device *dev)
 {
 	return is_nd_pmem(dev) || is_nd_blk(dev) || is_nd_volatile(dev);
 }
-
 static inline bool is_memory(struct device *dev)
 {
 	return is_nd_pmem(dev) || is_nd_volatile(dev);
 }
-
 struct nvdimm_bus *walk_to_nvdimm_bus(struct device *nd_dev);
 int __init nvdimm_bus_init(void);
 void nvdimm_bus_exit(void);
@@ -172,21 +169,20 @@ bool nd_attach_ndns(struct device *dev, struct nd_namespace_common *attach,
 bool __nd_attach_ndns(struct device *dev, struct nd_namespace_common *attach,
 		      struct nd_namespace_common **_ndns);
 ssize_t nd_namespace_store(struct device *dev,
-			   struct nd_namespace_common **_ndns,
-			   const char *buf, size_t len);
+			   struct nd_namespace_common **_ndns, const char *buf,
+			   size_t len);
 struct nd_pfn *to_nd_pfn_safe(struct device *dev);
 bool is_nvdimm_bus(struct device *dev);
 
 #ifdef CONFIG_PROVE_LOCKING
 extern struct class *nd_class;
 
-enum {
-	LOCK_BUS,
-	LOCK_NDCTL,
-	LOCK_REGION,
-	LOCK_DIMM = LOCK_REGION,
-	LOCK_NAMESPACE,
-	LOCK_CLAIM,
+enum { LOCK_BUS,
+       LOCK_NDCTL,
+       LOCK_REGION,
+       LOCK_DIMM = LOCK_REGION,
+       LOCK_NAMESPACE,
+       LOCK_CLAIM,
 };
 
 static inline void debug_nvdimm_lock(struct device *dev)
diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index 852ce9591109..c64e4223711b 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -60,8 +60,8 @@ static inline void ndrd_set_flush_wpq(struct nd_region_data *ndrd, int dimm,
 	ndrd->flush_wpq[dimm * num + (hint & mask)] = flush;
 }
 
-static inline struct nd_namespace_index *to_namespace_index(
-	struct nvdimm_drvdata *ndd, int i)
+static inline struct nd_namespace_index *
+to_namespace_index(struct nvdimm_drvdata *ndd, int i)
 {
 	if (i < 0)
 		return NULL;
@@ -69,36 +69,36 @@ static inline struct nd_namespace_index *to_namespace_index(
 	return ndd->data + sizeof_namespace_index(ndd) * i;
 }
 
-static inline struct nd_namespace_index *to_current_namespace_index(
-	struct nvdimm_drvdata *ndd)
+static inline struct nd_namespace_index *
+to_current_namespace_index(struct nvdimm_drvdata *ndd)
 {
 	return to_namespace_index(ndd, ndd->ns_current);
 }
 
-static inline struct nd_namespace_index *to_next_namespace_index(
-	struct nvdimm_drvdata *ndd)
+static inline struct nd_namespace_index *
+to_next_namespace_index(struct nvdimm_drvdata *ndd)
 {
 	return to_namespace_index(ndd, ndd->ns_next);
 }
 
-unsigned int sizeof_namespace_label(struct nvdimm_drvdata *ndd);
+unsigned sizeof_namespace_label(struct nvdimm_drvdata *ndd);
 
-#define namespace_label_has(ndd, field)			\
-	(offsetof(struct nd_namespace_label, field)	\
-	 < sizeof_namespace_label(ndd))
+#define namespace_label_has(ndd, field)                                        \
+	(offsetof(struct nd_namespace_label, field) <                          \
+	 sizeof_namespace_label(ndd))
 
-#define nd_dbg_dpa(r, d, res, fmt, arg...)				\
-	dev_dbg((r) ? &(r)->dev : (d)->dev, "%s: %.13s: %#llx @ %#llx " fmt, \
-		(r) ? dev_name((d)->dev) : "", res ? res->name : "null", \
-		(u64)(res ? resource_size(res) : 0),	\
-		(u64)(res ? res->start : 0), ##arg)
+#define nd_dbg_dpa(r, d, res, fmt, arg...)                                     \
+	dev_dbg((r) ? &(r)->dev : (d)->dev, "%s: %.13s: %#llx @ %#llx " fmt,   \
+		(r) ? dev_name((d)->dev) : "", res ? res->name : "null",       \
+		(unsigned long long)(res ? resource_size(res) : 0),            \
+		(unsigned long long)(res ? res->start : 0), ##arg)
 
-#define for_each_dpa_resource(ndd, res)				\
+#define for_each_dpa_resource(ndd, res)                                        \
 	for (res = (ndd)->dpa.child; res; res = res->sibling)
 
-#define for_each_dpa_resource_safe(ndd, res, next)			\
-	for (res = (ndd)->dpa.child, next = res ? res->sibling : NULL;	\
-	     res; res = next, next = next ? next->sibling : NULL)
+#define for_each_dpa_resource_safe(ndd, res, next)                             \
+	for (res = (ndd)->dpa.child, next = res ? res->sibling : NULL; res;    \
+	     res = next, next = next ? next->sibling : NULL)
 
 struct nd_percpu_lane {
 	int count;
@@ -108,7 +108,6 @@ struct nd_percpu_lane {
 enum nd_label_flags {
 	ND_LABEL_REAP,
 };
-
 struct nd_label_ent {
 	struct list_head list;
 	unsigned long flags;
@@ -171,9 +170,9 @@ struct nd_blk_region {
 /*
  * Lookup next in the repeating sequence of 01, 10, and 11.
  */
-static inline unsigned int nd_inc_seq(unsigned int seq)
+static inline unsigned nd_inc_seq(unsigned seq)
 {
-	static const unsigned int next[] = { 0, 2, 3, 1 };
+	static const unsigned next[] = { 0, 2, 3, 1 };
 
 	return next[seq & 3];
 }
@@ -240,10 +239,10 @@ struct nvdimm_drvdata *to_ndd(struct nd_mapping *nd_mapping);
 int nvdimm_check_config_data(struct device *dev);
 int nvdimm_init_nsarea(struct nvdimm_drvdata *ndd);
 int nvdimm_init_config_data(struct nvdimm_drvdata *ndd);
-int nvdimm_get_config_data(struct nvdimm_drvdata *ndd, void *buf,
-			   size_t offset, size_t len);
-int nvdimm_set_config_data(struct nvdimm_drvdata *ndd, size_t offset,
-			   void *buf, size_t len);
+int nvdimm_get_config_data(struct nvdimm_drvdata *ndd, void *buf, size_t offset,
+			   size_t len);
+int nvdimm_set_config_data(struct nvdimm_drvdata *ndd, size_t offset, void *buf,
+			   size_t len);
 long nvdimm_clear_poison(struct device *dev, phys_addr_t phys,
 			 unsigned int len);
 void nvdimm_set_aliasing(struct device *dev);
@@ -365,8 +364,7 @@ int nd_label_reserve_dpa(struct nvdimm_drvdata *ndd);
 void nvdimm_free_dpa(struct nvdimm_drvdata *ndd, struct resource *res);
 struct resource *nvdimm_allocate_dpa(struct nvdimm_drvdata *ndd,
 				     struct nd_label_id *label_id,
-				     resource_size_t start,
-				     resource_size_t n);
+				     resource_size_t start, resource_size_t n);
 resource_size_t nvdimm_namespace_capacity(struct nd_namespace_common *ndns);
 bool nvdimm_namespace_locked(struct nd_namespace_common *ndns);
 struct nd_namespace_common *nvdimm_namespace_common_probe(struct device *dev);
@@ -388,13 +386,11 @@ static inline int nvdimm_setup_pfn(struct nd_pfn *nd_pfn,
 {
 	return -ENXIO;
 }
-
 static inline int devm_nsio_enable(struct device *dev,
 				   struct nd_namespace_io *nsio)
 {
 	return -ENXIO;
 }
-
 static inline void devm_nsio_disable(struct device *dev,
 				     struct nd_namespace_io *nsio)
 {
@@ -415,27 +411,25 @@ static inline bool nd_iostat_start(struct bio *bio, unsigned long *start)
 			      &disk->part0);
 	return true;
 }
-
 static inline void nd_iostat_end(struct bio *bio, unsigned long start)
 {
 	struct gendisk *disk = bio->bi_disk;
 
 	generic_end_io_acct(disk->queue, bio_op(bio), &disk->part0, start);
 }
-
 static inline bool is_bad_pmem(struct badblocks *bb, sector_t sector,
 			       unsigned int len)
 {
-	sector_t first_bad;
-	int num_bad;
-
-	if (!bb->count)
-		return false;
+	if (bb->count) {
+		sector_t first_bad;
+		int num_bad;
 
+		return !!badblocks_check(bb, sector, len / 512, &first_bad,
+					 &num_bad);
+	}
 
-	return badblocks_check(bb, sector, len / 512, &first_bad, &num_bad);
+	return false;
 }
-
 resource_size_t nd_namespace_blk_validate(struct nd_namespace_blk *nsblk);
 const u8 *nd_dev_to_uuid(struct device *dev);
 bool pmem_should_map_pages(struct device *dev);
diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index 1a792fee8cfd..478194e86345 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -39,7 +39,7 @@ EXPORT_SYMBOL_GPL(virtio_pmem_host_ack);
 static int virtio_pmem_flush(struct nd_region *nd_region)
 {
 	struct virtio_device *vdev = nd_region->provider_data;
-	struct virtio_pmem *vpmem  = vdev->priv;
+	struct virtio_pmem *vpmem = vdev->priv;
 	struct virtio_pmem_request *req_data;
 	struct scatterlist *sgs[2], sg, ret;
 	unsigned long flags;
@@ -62,14 +62,16 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
 
 	spin_lock_irqsave(&vpmem->pmem_lock, flags);
 	/*
-	 * If virtqueue_add_sgs returns -ENOSPC then req_vq virtual
-	 * queue does not have free descriptor. We add the request
-	 * to req_list and wait for host_ack to wake us up when free
-	 * slots are available.
-	 */
+	  * If virtqueue_add_sgs returns -ENOSPC then req_vq virtual
+	  * queue does not have free descriptor. We add the request
+	  * to req_list and wait for host_ack to wake us up when free
+	  * slots are available.
+	  */
 	while ((err = virtqueue_add_sgs(vpmem->req_vq, sgs, 1, 1, req_data,
 					GFP_ATOMIC)) == -ENOSPC) {
-		dev_info(&vdev->dev, "failed to send command to virtio pmem device, no free slots in the virtqueue\n");
+		dev_info(
+			&vdev->dev,
+			"failed to send command to virtio pmem device, no free slots in the virtqueue\n");
 		req_data->wq_buf_avail = false;
 		list_add_tail(&req_data->list, &vpmem->req_list);
 		spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
@@ -85,7 +87,8 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
 	 * do anything about that.
 	 */
 	if (err || !err1) {
-		dev_info(&vdev->dev, "failed to send command to virtio pmem device\n");
+		dev_info(&vdev->dev,
+			 "failed to send command to virtio pmem device\n");
 		err = -EIO;
 	} else {
 		/* A host repsonse results in "host_ack" getting called */
diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
index 03ffcbf601d4..95f72164ea85 100644
--- a/drivers/nvdimm/of_pmem.c
+++ b/drivers/nvdimm/of_pmem.c
@@ -55,7 +55,7 @@ static int of_pmem_region_probe(struct platform_device *pdev)
 
 	is_volatile = !!of_find_property(np, "volatile", NULL);
 	dev_dbg(&pdev->dev, "Registering %s regions from %pOF\n",
-		is_volatile ? "volatile" : "non-volatile",  np);
+		is_volatile ? "volatile" : "non-volatile", np);
 
 	for (i = 0; i < pdev->num_resources; i++) {
 		struct nd_region_desc ndr_desc;
@@ -79,7 +79,8 @@ static int of_pmem_region_probe(struct platform_device *pdev)
 			region = nvdimm_pmem_region_create(bus, &ndr_desc);
 
 		if (!region)
-			dev_warn(&pdev->dev, "Unable to register region %pR from %pOF\n",
+			dev_warn(&pdev->dev,
+				 "Unable to register region %pR from %pOF\n",
 				 ndr_desc.res, np);
 		else
 			dev_dbg(&pdev->dev, "Registered region %pR from %pOF\n",
@@ -101,7 +102,7 @@ static int of_pmem_region_remove(struct platform_device *pdev)
 
 static const struct of_device_id of_pmem_region_match[] = {
 	{ .compatible = "pmem-region" },
-	{ },
+	{},
 };
 
 static struct platform_driver of_pmem_region_driver = {
diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index 6ab72f8f4a66..47b578dd1a4c 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -46,8 +46,8 @@ struct nd_pfn *to_nd_pfn(struct device *dev)
 }
 EXPORT_SYMBOL(to_nd_pfn);
 
-static ssize_t mode_show(struct device *dev,
-			 struct device_attribute *attr, char *buf)
+static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
 {
 	struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
 
@@ -69,26 +69,25 @@ static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
 
 	nd_device_lock(dev);
 	nvdimm_bus_lock(dev);
-	if (dev->driver) {
+	if (dev->driver)
 		rc = -EBUSY;
-	} else {
+	else {
 		size_t n = len - 1;
 
 		if (strncmp(buf, "pmem\n", n) == 0 ||
 		    strncmp(buf, "pmem", n) == 0) {
 			nd_pfn->mode = PFN_MODE_PMEM;
 		} else if (strncmp(buf, "ram\n", n) == 0 ||
-			   strncmp(buf, "ram", n) == 0) {
+			   strncmp(buf, "ram", n) == 0)
 			nd_pfn->mode = PFN_MODE_RAM;
-		} else if (strncmp(buf, "none\n", n) == 0 ||
-			   strncmp(buf, "none", n) == 0) {
+		else if (strncmp(buf, "none\n", n) == 0 ||
+			 strncmp(buf, "none", n) == 0)
 			nd_pfn->mode = PFN_MODE_NONE;
-		} else {
+		else
 			rc = -EINVAL;
-		}
 	}
-	dev_dbg(dev, "result: %zd wrote: %s%s",
-		rc, buf, buf[len - 1] == '\n' ? "" : "\n");
+	dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
+		buf[len - 1] == '\n' ? "" : "\n");
 	nvdimm_bus_unlock(dev);
 	nd_device_unlock(dev);
 
@@ -96,8 +95,8 @@ static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(mode);
 
-static ssize_t align_show(struct device *dev,
-			  struct device_attribute *attr, char *buf)
+static ssize_t align_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
 {
 	struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
 
@@ -127,8 +126,8 @@ static const unsigned long *nd_pfn_supported_alignments(void)
 	return data;
 }
 
-static ssize_t align_store(struct device *dev,
-			   struct device_attribute *attr, const char *buf, size_t len)
+static ssize_t align_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t len)
 {
 	struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
 	ssize_t rc;
@@ -137,8 +136,8 @@ static ssize_t align_store(struct device *dev,
 	nvdimm_bus_lock(dev);
 	rc = nd_size_select_store(dev, buf, &nd_pfn->align,
 				  nd_pfn_supported_alignments());
-	dev_dbg(dev, "result: %zd wrote: %s%s",
-		rc, buf, buf[len - 1] == '\n' ? "" : "\n");
+	dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
+		buf[len - 1] == '\n' ? "" : "\n");
 	nvdimm_bus_unlock(dev);
 	nd_device_unlock(dev);
 
@@ -146,8 +145,8 @@ static ssize_t align_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(align);
 
-static ssize_t uuid_show(struct device *dev,
-			 struct device_attribute *attr, char *buf)
+static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
 {
 	struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
 
@@ -156,24 +155,24 @@ static ssize_t uuid_show(struct device *dev,
 	return sprintf(buf, "\n");
 }
 
-static ssize_t uuid_store(struct device *dev,
-			  struct device_attribute *attr, const char *buf, size_t len)
+static ssize_t uuid_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t len)
 {
 	struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
 	ssize_t rc;
 
 	nd_device_lock(dev);
 	rc = nd_uuid_store(dev, &nd_pfn->uuid, buf, len);
-	dev_dbg(dev, "result: %zd wrote: %s%s",
-		rc, buf, buf[len - 1] == '\n' ? "" : "\n");
+	dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
+		buf[len - 1] == '\n' ? "" : "\n");
 	nd_device_unlock(dev);
 
 	return rc ? rc : len;
 }
 static DEVICE_ATTR_RW(uuid);
 
-static ssize_t namespace_show(struct device *dev,
-			      struct device_attribute *attr, char *buf)
+static ssize_t namespace_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
 {
 	struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
 	ssize_t rc;
@@ -186,8 +185,8 @@ static ssize_t namespace_show(struct device *dev,
 }
 
 static ssize_t namespace_store(struct device *dev,
-			       struct device_attribute *attr,
-			       const char *buf, size_t len)
+			       struct device_attribute *attr, const char *buf,
+			       size_t len)
 {
 	struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
 	ssize_t rc;
@@ -195,8 +194,8 @@ static ssize_t namespace_store(struct device *dev,
 	nd_device_lock(dev);
 	nvdimm_bus_lock(dev);
 	rc = nd_namespace_store(dev, &nd_pfn->ndns, buf, len);
-	dev_dbg(dev, "result: %zd wrote: %s%s",
-		rc, buf, buf[len - 1] == '\n' ? "" : "\n");
+	dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
+		buf[len - 1] == '\n' ? "" : "\n");
 	nvdimm_bus_unlock(dev);
 	nd_device_unlock(dev);
 
@@ -204,8 +203,8 @@ static ssize_t namespace_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(namespace);
 
-static ssize_t resource_show(struct device *dev,
-			     struct device_attribute *attr, char *buf)
+static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
 {
 	struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
 	ssize_t rc;
@@ -219,7 +218,8 @@ static ssize_t resource_show(struct device *dev,
 		struct nd_namespace_io *nsio = to_nd_namespace_io(&ndns->dev);
 
 		rc = sprintf(buf, "%#llx\n",
-			     (u64)nsio->res.start + start_pad + offset);
+			     (unsigned long long)nsio->res.start + start_pad +
+				     offset);
 	} else {
 		/* no address to convey if the pfn instance is disabled */
 		rc = -ENXIO;
@@ -230,8 +230,8 @@ static ssize_t resource_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(resource);
 
-static ssize_t size_show(struct device *dev,
-			 struct device_attribute *attr, char *buf)
+static ssize_t size_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
 {
 	struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
 	ssize_t rc;
@@ -246,8 +246,8 @@ static ssize_t size_show(struct device *dev,
 		struct nd_namespace_io *nsio = to_nd_namespace_io(&ndns->dev);
 
 		rc = sprintf(buf, "%llu\n",
-			     (u64)resource_size(&nsio->res)
-			     - start_pad - end_trunc - offset);
+			     (unsigned long long)resource_size(&nsio->res) -
+				     start_pad - end_trunc - offset);
 	} else {
 		/* no size to convey if the pfn instance is disabled */
 		rc = -ENXIO;
@@ -388,10 +388,10 @@ static int nd_pfn_clear_memmap_errors(struct nd_pfn *nd_pfn)
 		if (bb_present) {
 			dev_dbg(&nd_pfn->dev, "meta: %x badblocks at %llx\n",
 				num_bad, first_bad);
-			nsoff = ALIGN_DOWN((nd_region->ndr_start
-					    + (first_bad << 9))
-					   - nsio->res.start,
-					   PAGE_SIZE);
+			nsoff = ALIGN_DOWN(
+				(nd_region->ndr_start + (first_bad << 9)) -
+					nsio->res.start,
+				PAGE_SIZE);
 			zero_len = ALIGN(num_bad << 9, PAGE_SIZE);
 			while (zero_len) {
 				unsigned long chunk = min(zero_len, PAGE_SIZE);
@@ -508,8 +508,7 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
 			dev_err(&nd_pfn->dev,
 				"init failed, settings mismatch\n");
 			dev_dbg(&nd_pfn->dev, "align: %lx:%lx mode: %d:%d\n",
-				nd_pfn->align, align, nd_pfn->mode,
-				mode);
+				nd_pfn->align, align, nd_pfn->mode, mode);
 			return -EINVAL;
 		}
 	}
@@ -537,8 +536,8 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
 	     !IS_ALIGNED(nsio->res.start + offset + start_pad, align)) ||
 	    !IS_ALIGNED(offset, PAGE_SIZE)) {
 		dev_err(&nd_pfn->dev,
-			"bad offset: %#llx dax disabled align: %#lx\n",
-			offset, align);
+			"bad offset: %#llx dax disabled align: %#lx\n", offset,
+			align);
 		return -ENXIO;
 	}
 
@@ -579,9 +578,8 @@ int nd_pfn_probe(struct device *dev, struct nd_namespace_common *ndns)
 	if (rc < 0) {
 		nd_detach_ndns(pfn_dev, &nd_pfn->ndns);
 		put_device(pfn_dev);
-	} else {
+	} else
 		__nd_device_register(pfn_dev);
-	}
 
 	return rc;
 }
@@ -648,9 +646,8 @@ static int __nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap)
 		altmap->free = PHYS_PFN(offset - reserve);
 		altmap->alloc = 0;
 		pgmap->flags |= PGMAP_ALTMAP_VALID;
-	} else {
+	} else
 		return -ENXIO;
-	}
 
 	return 0;
 }
@@ -712,14 +709,14 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
 		 * PMD_SIZE for most architectures.
 		 */
 		offset = ALIGN(start + SZ_8K + 64 * npfns, align) - start;
-	} else if (nd_pfn->mode == PFN_MODE_RAM) {
+	} else if (nd_pfn->mode == PFN_MODE_RAM)
 		offset = ALIGN(start + SZ_8K, align) - start;
-	} else {
+	else
 		return -ENXIO;
-	}
 
 	if (offset >= size) {
-		dev_err(&nd_pfn->dev, "%s unable to satisfy requested alignment\n",
+		dev_err(&nd_pfn->dev,
+			"%s unable to satisfy requested alignment\n",
 			dev_name(&ndns->dev));
 		return -ENXIO;
 	}
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 3f1add94144a..b764fffba49c 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -44,8 +44,8 @@ static struct nd_region *to_region(struct pmem_device *pmem)
 	return to_nd_region(to_dev(pmem)->parent);
 }
 
-static void hwpoison_clear(struct pmem_device *pmem,
-			   phys_addr_t phys, unsigned int len)
+static void hwpoison_clear(struct pmem_device *pmem, phys_addr_t phys,
+			   unsigned int len)
 {
 	unsigned long pfn_start, pfn_end, pfn;
 
@@ -85,7 +85,8 @@ static blk_status_t pmem_clear_poison(struct pmem_device *pmem,
 		hwpoison_clear(pmem, pmem->phys_addr + offset, cleared);
 		cleared /= 512;
 		dev_dbg(dev, "%#llx clear %ld sector%s\n",
-			(u64)sector, cleared, cleared > 1 ? "s" : "");
+			(unsigned long long)sector, cleared,
+			cleared > 1 ? "s" : "");
 		badblocks_clear(&pmem->bb, sector, cleared);
 		if (pmem->bb_state)
 			sysfs_notify_dirent(pmem->bb_state);
@@ -96,8 +97,8 @@ static blk_status_t pmem_clear_poison(struct pmem_device *pmem,
 	return rc;
 }
 
-static void write_pmem(void *pmem_addr, struct page *page,
-		       unsigned int off, unsigned int len)
+static void write_pmem(void *pmem_addr, struct page *page, unsigned int off,
+		       unsigned int len)
 {
 	unsigned int chunk;
 	void *mem;
@@ -149,9 +150,9 @@ static blk_status_t pmem_do_bvec(struct pmem_device *pmem, struct page *page,
 		bad_pmem = true;
 
 	if (!op_is_write(op)) {
-		if (unlikely(bad_pmem)) {
+		if (unlikely(bad_pmem))
 			rc = BLK_STS_IOERR;
-		} else {
+		else {
 			rc = read_pmem(page, off, pmem_addr, len);
 			flush_dcache_page(page);
 		}
@@ -196,7 +197,7 @@ static blk_qc_t pmem_make_request(struct request_queue *q, struct bio *bio)
 		ret = nvdimm_flush(nd_region, bio);
 
 	do_acct = nd_iostat_start(bio, &start);
-	bio_for_each_segment(bvec, bio, iter) {
+	bio_for_each_segment (bvec, bio, iter) {
 		rc = pmem_do_bvec(pmem, bvec.bv_page, bvec.bv_len,
 				  bvec.bv_offset, bio_op(bio), iter.bi_sector);
 		if (rc) {
@@ -223,8 +224,8 @@ static int pmem_rw_page(struct block_device *bdev, sector_t sector,
 	struct pmem_device *pmem = bdev->bd_queue->queuedata;
 	blk_status_t rc;
 
-	rc = pmem_do_bvec(pmem, page, hpage_nr_pages(page) * PAGE_SIZE,
-			  0, op, sector);
+	rc = pmem_do_bvec(pmem, page, hpage_nr_pages(page) * PAGE_SIZE, 0, op,
+			  sector);
 
 	/*
 	 * The ->rw_page interface is subtle and tricky.  The core
@@ -263,14 +264,13 @@ __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 }
 
 static const struct block_device_operations pmem_fops = {
-	.owner =		THIS_MODULE,
-	.rw_page =		pmem_rw_page,
-	.revalidate_disk =	nvdimm_revalidate_disk,
+	.owner = THIS_MODULE,
+	.rw_page = pmem_rw_page,
+	.revalidate_disk = nvdimm_revalidate_disk,
 };
 
-static long pmem_dax_direct_access(struct dax_device *dax_dev,
-				   pgoff_t pgoff, long nr_pages,
-				   void **kaddr, pfn_t *pfn)
+static long pmem_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
+				   long nr_pages, void **kaddr, pfn_t *pfn)
 {
 	struct pmem_device *pmem = dax_get_private(dax_dev);
 
@@ -344,9 +344,9 @@ static void pmem_pagemap_page_free(struct page *page)
 }
 
 static const struct dev_pagemap_ops fsdax_pagemap_ops = {
-	.page_free		= pmem_pagemap_page_free,
-	.kill			= pmem_pagemap_kill,
-	.cleanup		= pmem_pagemap_cleanup,
+	.page_free = pmem_pagemap_page_free,
+	.kill = pmem_pagemap_kill,
+	.cleanup = pmem_pagemap_cleanup,
 };
 
 static int pmem_attach_disk(struct device *dev,
@@ -410,8 +410,8 @@ static int pmem_attach_disk(struct device *dev,
 		addr = devm_memremap_pages(dev, &pmem->pgmap);
 		pfn_sb = nd_pfn->pfn_sb;
 		pmem->data_offset = le64_to_cpu(pfn_sb->dataoff);
-		pmem->pfn_pad = resource_size(res) -
-			resource_size(&pmem->pgmap.res);
+		pmem->pfn_pad =
+			resource_size(res) - resource_size(&pmem->pgmap.res);
 		pmem->pfn_flags |= PFN_MAP;
 		memcpy(&bb_res, &pmem->pgmap.res, sizeof(bb_res));
 		bb_res.start += pmem->data_offset;
@@ -426,8 +426,8 @@ static int pmem_attach_disk(struct device *dev,
 		if (devm_add_action_or_reset(dev, pmem_release_queue,
 					     &pmem->pgmap))
 			return -ENOMEM;
-		addr = devm_memremap(dev, pmem->phys_addr,
-				     pmem->size, ARCH_MEMREMAP_PMEM);
+		addr = devm_memremap(dev, pmem->phys_addr, pmem->size,
+				     ARCH_MEMREMAP_PMEM);
 		memcpy(&bb_res, &nsio->res, sizeof(bb_res));
 	}
 
@@ -450,9 +450,9 @@ static int pmem_attach_disk(struct device *dev,
 		return -ENOMEM;
 	pmem->disk = disk;
 
-	disk->fops		= &pmem_fops;
-	disk->queue		= q;
-	disk->flags		= GENHD_FL_EXT_DEVT;
+	disk->fops = &pmem_fops;
+	disk->queue = q;
+	disk->flags = GENHD_FL_EXT_DEVT;
 	disk->queue->backing_dev_info->capabilities |= BDI_CAP_SYNCHRONOUS_IO;
 	nvdimm_namespace_disk_name(ndns, disk->disk_name);
 	set_capacity(disk,
@@ -480,8 +480,8 @@ static int pmem_attach_disk(struct device *dev,
 
 	revalidate_disk(disk);
 
-	pmem->bb_state = sysfs_get_dirent(disk_to_dev(disk)->kobj.sd,
-					  "badblocks");
+	pmem->bb_state =
+		sysfs_get_dirent(disk_to_dev(disk)->kobj.sd, "badblocks");
 	if (!pmem->bb_state)
 		dev_warn(dev, "'badblocks' notification disabled\n");
 
@@ -506,8 +506,7 @@ static int nd_pmem_probe(struct device *dev)
 		return pmem_attach_disk(dev, ndns);
 
 	/* if we find a valid info-block we'll come back as that personality */
-	if (nd_btt_probe(dev, ndns) == 0 ||
-	    nd_pfn_probe(dev, ndns) == 0 ||
+	if (nd_btt_probe(dev, ndns) == 0 || nd_pfn_probe(dev, ndns) == 0 ||
 	    nd_dax_probe(dev, ndns) == 0)
 		return -ENXIO;
 
@@ -519,9 +518,9 @@ static int nd_pmem_remove(struct device *dev)
 {
 	struct pmem_device *pmem = dev_get_drvdata(dev);
 
-	if (is_nd_btt(dev)) {
+	if (is_nd_btt(dev))
 		nvdimm_namespace_detach_btt(to_nd_btt(dev));
-	} else {
+	else {
 		/*
 		 * Note, this assumes nd_device_lock() context to not
 		 * race nd_pmem_notify()
@@ -573,7 +572,7 @@ static void nd_pmem_notify(struct device *dev, enum nvdimm_event event)
 
 			ndns = nd_pfn->ndns;
 			offset = pmem->data_offset +
-				__le32_to_cpu(pfn_sb->start_pad);
+				 __le32_to_cpu(pfn_sb->start_pad);
 			end_trunc = __le32_to_cpu(pfn_sb->end_trunc);
 		} else {
 			ndns = to_ndns(dev);
diff --git a/drivers/nvdimm/pmem.h b/drivers/nvdimm/pmem.h
index f5ba2a9a68ed..ebece9dc1baf 100644
--- a/drivers/nvdimm/pmem.h
+++ b/drivers/nvdimm/pmem.h
@@ -10,20 +10,20 @@
 /* this definition is in it's own header for tools/testing/nvdimm to consume */
 struct pmem_device {
 	/* One contiguous memory region per device */
-	phys_addr_t		phys_addr;
+	phys_addr_t phys_addr;
 	/* when non-zero this device is hosting a 'pfn' instance */
-	phys_addr_t		data_offset;
-	u64			pfn_flags;
-	void			*virt_addr;
+	phys_addr_t data_offset;
+	u64 pfn_flags;
+	void *virt_addr;
 	/* immutable base size of the namespace */
-	size_t			size;
+	size_t size;
 	/* trim size when namespace capacity has been section aligned */
-	u32			pfn_pad;
-	struct kernfs_node	*bb_state;
-	struct badblocks	bb;
-	struct dax_device	*dax_dev;
-	struct gendisk		*disk;
-	struct dev_pagemap	pgmap;
+	u32 pfn_pad;
+	struct kernfs_node *bb_state;
+	struct badblocks bb;
+	struct dax_device *dax_dev;
+	struct gendisk *disk;
+	struct dev_pagemap pgmap;
 };
 
 long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
diff --git a/drivers/nvdimm/region.c b/drivers/nvdimm/region.c
index fdd67ff499c9..fc6d11c3ea2f 100644
--- a/drivers/nvdimm/region.c
+++ b/drivers/nvdimm/region.c
@@ -19,10 +19,12 @@ static int nd_region_probe(struct device *dev)
 	if (nd_region->num_lanes > num_online_cpus() &&
 	    nd_region->num_lanes < num_possible_cpus() &&
 	    !test_and_set_bit(0, &once)) {
-		dev_dbg(dev, "online cpus (%d) < concurrent i/o lanes (%d) < possible cpus (%d)\n",
+		dev_dbg(dev,
+			"online cpus (%d) < concurrent i/o lanes (%d) < possible cpus (%d)\n",
 			num_online_cpus(), nd_region->num_lanes,
 			num_possible_cpus());
-		dev_dbg(dev, "setting nr_cpus=%d may yield better libnvdimm device performance\n",
+		dev_dbg(dev,
+			"setting nr_cpus=%d may yield better libnvdimm device performance\n",
 			nd_region->num_lanes);
 	}
 
@@ -39,8 +41,8 @@ static int nd_region_probe(struct device *dev)
 
 		if (devm_init_badblocks(dev, &nd_region->bb))
 			return -ENODEV;
-		nd_region->bb_state = sysfs_get_dirent(nd_region->dev.kobj.sd,
-						       "badblocks");
+		nd_region->bb_state =
+			sysfs_get_dirent(nd_region->dev.kobj.sd, "badblocks");
 		if (!nd_region->bb_state)
 			dev_warn(&nd_region->dev,
 				 "'badblocks' notification disabled\n");
@@ -75,8 +77,8 @@ static int nd_region_probe(struct device *dev)
 	 * <regionX>/namespaces returns the current
 	 * "<async-registered>/<total>" namespace count.
 	 */
-	dev_err(dev, "failed to register %d namespace%s, continuing...\n",
-		err, err == 1 ? "" : "s");
+	dev_err(dev, "failed to register %d namespace%s, continuing...\n", err,
+		err == 1 ? "" : "s");
 	return 0;
 }
 
@@ -125,10 +127,10 @@ static void nd_region_notify(struct device *dev, enum nvdimm_event event)
 
 		if (is_nd_pmem(&nd_region->dev)) {
 			res.start = nd_region->ndr_start;
-			res.end = nd_region->ndr_start +
-				nd_region->ndr_size - 1;
-			nvdimm_badblocks_populate(nd_region,
-						  &nd_region->bb, &res);
+			res.end =
+				nd_region->ndr_start + nd_region->ndr_size - 1;
+			nvdimm_badblocks_populate(nd_region, &nd_region->bb,
+						  &res);
 			if (nd_region->bb_state)
 				sysfs_notify_dirent(nd_region->bb_state);
 		}
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 6ed918e30cf9..0fb913c7a2c3 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -2,7 +2,6 @@
 /*
  * Copyright(c) 2013-2015 Intel Corporation. All rights reserved.
  */
-
 #include <linux/scatterlist.h>
 #include <linux/highmem.h>
 #include <linux/sched.h>
@@ -45,8 +44,12 @@ static int nvdimm_map_flush(struct device *dev, struct nvdimm *nvdimm, int dimm,
 		}
 
 		if (j < i)
-			flush_page = (void __iomem *)
-				((unsigned long)ndrd_get_flush_wpq(ndrd, dimm, j) & PAGE_MASK);
+			flush_page =
+				(void __iomem *)((unsigned long)
+							 ndrd_get_flush_wpq(
+								 ndrd, dimm,
+								 j) &
+						 PAGE_MASK);
 		else
 			flush_page = devm_nvdimm_ioremap(dev, PFN_PHYS(pfn),
 							 PAGE_SIZE);
@@ -246,8 +249,8 @@ int nd_region_to_nstype(struct nd_region *nd_region)
 }
 EXPORT_SYMBOL(nd_region_to_nstype);
 
-static ssize_t size_show(struct device *dev,
-			 struct device_attribute *attr, char *buf)
+static ssize_t size_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
 {
 	struct nd_region *nd_region = to_nd_region(dev);
 	unsigned long long size = 0;
@@ -277,8 +280,8 @@ static ssize_t deep_flush_show(struct device *dev,
 }
 
 static ssize_t deep_flush_store(struct device *dev,
-				struct device_attribute *attr,
-				const char *buf, size_t len)
+				struct device_attribute *attr, const char *buf,
+				size_t len)
 {
 	bool flush;
 	int rc = strtobool(buf, &flush);
@@ -296,8 +299,8 @@ static ssize_t deep_flush_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(deep_flush);
 
-static ssize_t mappings_show(struct device *dev,
-			     struct device_attribute *attr, char *buf)
+static ssize_t mappings_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
 {
 	struct nd_region *nd_region = to_nd_region(dev);
 
@@ -305,8 +308,8 @@ static ssize_t mappings_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(mappings);
 
-static ssize_t nstype_show(struct device *dev,
-			   struct device_attribute *attr, char *buf)
+static ssize_t nstype_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
 {
 	struct nd_region *nd_region = to_nd_region(dev);
 
@@ -321,7 +324,9 @@ static ssize_t set_cookie_show(struct device *dev,
 	struct nd_interleave_set *nd_set = nd_region->nd_set;
 	ssize_t rc = 0;
 
-	if (!(is_memory(dev) && nd_set))
+	if (is_memory(dev) && nd_set)
+		/* pass, should be precluded by region_visible */;
+	else
 		return -ENXIO;
 
 	/*
@@ -374,15 +379,14 @@ resource_size_t nd_region_available_dpa(struct nd_region *nd_region)
 			return 0;
 
 		if (is_memory(&nd_region->dev)) {
-			available += nd_pmem_available_dpa(nd_region,
-							   nd_mapping, &overlap);
+			available += nd_pmem_available_dpa(
+				nd_region, nd_mapping, &overlap);
 			if (overlap > blk_max_overlap) {
 				blk_max_overlap = overlap;
 				goto retry;
 			}
-		} else if (is_nd_blk(&nd_region->dev)) {
+		} else if (is_nd_blk(&nd_region->dev))
 			available += nd_blk_available_dpa(nd_region);
-		}
 	}
 
 	return available;
@@ -486,8 +490,8 @@ static ssize_t namespace_seed_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(namespace_seed);
 
-static ssize_t btt_seed_show(struct device *dev,
-			     struct device_attribute *attr, char *buf)
+static ssize_t btt_seed_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
 {
 	struct nd_region *nd_region = to_nd_region(dev);
 	ssize_t rc;
@@ -503,8 +507,8 @@ static ssize_t btt_seed_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(btt_seed);
 
-static ssize_t pfn_seed_show(struct device *dev,
-			     struct device_attribute *attr, char *buf)
+static ssize_t pfn_seed_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
 {
 	struct nd_region *nd_region = to_nd_region(dev);
 	ssize_t rc;
@@ -520,8 +524,8 @@ static ssize_t pfn_seed_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(pfn_seed);
 
-static ssize_t dax_seed_show(struct device *dev,
-			     struct device_attribute *attr, char *buf)
+static ssize_t dax_seed_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
 {
 	struct nd_region *nd_region = to_nd_region(dev);
 	ssize_t rc;
@@ -537,8 +541,8 @@ static ssize_t dax_seed_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(dax_seed);
 
-static ssize_t read_only_show(struct device *dev,
-			      struct device_attribute *attr, char *buf)
+static ssize_t read_only_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
 {
 	struct nd_region *nd_region = to_nd_region(dev);
 
@@ -546,8 +550,8 @@ static ssize_t read_only_show(struct device *dev,
 }
 
 static ssize_t read_only_store(struct device *dev,
-			       struct device_attribute *attr,
-			       const char *buf, size_t len)
+			       struct device_attribute *attr, const char *buf,
+			       size_t len)
 {
 	bool ro;
 	int rc = strtobool(buf, &ro);
@@ -578,8 +582,8 @@ static ssize_t region_badblocks_show(struct device *dev,
 }
 static DEVICE_ATTR(badblocks, 0444, region_badblocks_show, NULL);
 
-static ssize_t resource_show(struct device *dev,
-			     struct device_attribute *attr, char *buf)
+static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
 {
 	struct nd_region *nd_region = to_nd_region(dev);
 
@@ -656,8 +660,8 @@ static umode_t region_visible(struct kobject *kobj, struct attribute *a, int n)
 	}
 
 	if (a == &dev_attr_persistence_domain.attr) {
-		if ((nd_region->flags & (BIT(ND_REGION_PERSIST_CACHE)
-					 | BIT(ND_REGION_PERSIST_MEMCTRL))) == 0)
+		if ((nd_region->flags & (BIT(ND_REGION_PERSIST_CACHE) |
+					 BIT(ND_REGION_PERSIST_MEMCTRL))) == 0)
 			return 0;
 		return a->mode;
 	}
@@ -690,8 +694,7 @@ u64 nd_region_interleave_set_cookie(struct nd_region *nd_region,
 	if (!nd_set)
 		return 0;
 
-	if (nsindex &&
-	    __le16_to_cpu(nsindex->major) == 1 &&
+	if (nsindex && __le16_to_cpu(nsindex->major) == 1 &&
 	    __le16_to_cpu(nsindex->minor) == 1)
 		return nd_set->cookie1;
 	return nd_set->cookie2;
@@ -711,7 +714,7 @@ void nd_mapping_free_labels(struct nd_mapping *nd_mapping)
 	struct nd_label_ent *label_ent, *e;
 
 	lockdep_assert_held(&nd_mapping->lock);
-	list_for_each_entry_safe(label_ent, e, &nd_mapping->labels, list) {
+	list_for_each_entry_safe (label_ent, e, &nd_mapping->labels, list) {
 		list_del(&label_ent->list);
 		kfree(label_ent);
 	}
@@ -815,14 +818,13 @@ static ssize_t mappingN(struct device *dev, char *buf, int n)
 		       nd_mapping->position);
 }
 
-#define REGION_MAPPING(idx)						\
-static ssize_t mapping##idx##_show(struct device *dev,			\
-				   struct device_attribute *attr,	\
-				   char *buf)				\
-{									\
-	return mappingN(dev, buf, idx);					\
-}									\
-static DEVICE_ATTR_RO(mapping##idx)
+#define REGION_MAPPING(idx)                                                    \
+	static ssize_t mapping##idx##_show(                                    \
+		struct device *dev, struct device_attribute *attr, char *buf)  \
+	{                                                                      \
+		return mappingN(dev, buf, idx);                                \
+	}                                                                      \
+	static DEVICE_ATTR_RO(mapping##idx)
 
 /*
  * 32 should be enough for a while, even in the presence of socket
@@ -959,9 +961,8 @@ unsigned int nd_region_acquire_lane(struct nd_region *nd_region)
 		ndl_lock = per_cpu_ptr(nd_region->lane, lane);
 		if (ndl_count->count++ == 0)
 			spin_lock(&ndl_lock->lock);
-	} else {
+	} else
 		lane = cpu;
-	}
 
 	return lane;
 }
@@ -984,7 +985,8 @@ void nd_region_release_lane(struct nd_region *nd_region, unsigned int lane)
 EXPORT_SYMBOL(nd_region_release_lane);
 
 static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
-					  struct nd_region_desc *ndr_desc, struct device_type *dev_type,
+					  struct nd_region_desc *ndr_desc,
+					  struct device_type *dev_type,
 					  const char *caller)
 {
 	struct nd_region *nd_region;
@@ -998,8 +1000,9 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 		struct nvdimm *nvdimm = mapping->nvdimm;
 
 		if ((mapping->start | mapping->size) % SZ_4K) {
-			dev_err(&nvdimm_bus->dev, "%s: %s mapping%d is not 4K aligned\n",
-				caller, dev_name(&nvdimm->dev), i);
+			dev_err(&nvdimm_bus->dev,
+				"%s: %s mapping%d is not 4K aligned\n", caller,
+				dev_name(&nvdimm->dev), i);
 
 			return NULL;
 		}
@@ -1009,8 +1012,9 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 
 		if (test_bit(NDD_NOBLK, &nvdimm->flags) &&
 		    dev_type == &nd_blk_device_type) {
-			dev_err(&nvdimm_bus->dev, "%s: %s mapping%d is not BLK capable\n",
-				caller, dev_name(&nvdimm->dev), i);
+			dev_err(&nvdimm_bus->dev,
+				"%s: %s mapping%d is not BLK capable\n", caller,
+				dev_name(&nvdimm->dev), i);
 			return NULL;
 		}
 	}
@@ -1020,8 +1024,8 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 		struct nd_blk_region *ndbr;
 
 		ndbr_desc = to_blk_region_desc(ndr_desc);
-		ndbr = kzalloc(sizeof(*ndbr) + sizeof(struct nd_mapping)
-			       * ndr_desc->num_mappings,
+		ndbr = kzalloc(sizeof(*ndbr) + sizeof(struct nd_mapping) *
+						       ndr_desc->num_mappings,
 			       GFP_KERNEL);
 		if (ndbr) {
 			nd_region = &ndbr->nd_region;
@@ -1136,16 +1140,15 @@ int nvdimm_flush(struct nd_region *nd_region, struct bio *bio)
 {
 	int rc = 0;
 
-	if (!nd_region->flush) {
+	if (!nd_region->flush)
 		rc = generic_nvdimm_flush(nd_region);
-	} else {
+	else {
 		if (nd_region->flush(nd_region, bio))
 			rc = -EIO;
 	}
 
 	return rc;
 }
-
 /**
  * nvdimm_flush - flush any posted write queues between the cpu and pmem media
  * @nd_region: blk or interleaved pmem region
@@ -1216,14 +1219,14 @@ EXPORT_SYMBOL_GPL(nvdimm_has_flush);
 int nvdimm_has_cache(struct nd_region *nd_region)
 {
 	return is_nd_pmem(&nd_region->dev) &&
-		!test_bit(ND_REGION_PERSIST_CACHE, &nd_region->flags);
+	       !test_bit(ND_REGION_PERSIST_CACHE, &nd_region->flags);
 }
 EXPORT_SYMBOL_GPL(nvdimm_has_cache);
 
 bool is_nvdimm_sync(struct nd_region *nd_region)
 {
 	return is_nd_pmem(&nd_region->dev) &&
-		!test_bit(ND_REGION_ASYNC, &nd_region->flags);
+	       !test_bit(ND_REGION_ASYNC, &nd_region->flags);
 }
 EXPORT_SYMBOL_GPL(is_nvdimm_sync);
 
diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
index cb14c05f127e..4e600b190272 100644
--- a/drivers/nvdimm/security.c
+++ b/drivers/nvdimm/security.c
@@ -15,8 +15,8 @@
 #include "nd-core.h"
 #include "nd.h"
 
-#define NVDIMM_BASE_KEY		0
-#define NVDIMM_NEW_KEY		1
+#define NVDIMM_BASE_KEY 0
+#define NVDIMM_NEW_KEY 1
 
 static bool key_revalidate = true;
 module_param(key_revalidate, bool, 0444);
@@ -173,9 +173,7 @@ static int __nvdimm_security_unlock(struct nvdimm *nvdimm)
 	/* The bus lock should be held at the top level of the call stack */
 	lockdep_assert_held(&nvdimm_bus->reconfig_mutex);
 
-	if (!nvdimm->sec.ops ||
-	    !nvdimm->sec.ops->unlock ||
-	    !nvdimm->sec.flags)
+	if (!nvdimm->sec.ops || !nvdimm->sec.ops->unlock || !nvdimm->sec.flags)
 		return -EIO;
 
 	if (test_bit(NDD_SECURITY_OVERWRITE, &nvdimm->flags)) {
@@ -195,9 +193,8 @@ static int __nvdimm_security_unlock(struct nvdimm *nvdimm)
 			return 0;
 
 		return nvdimm_key_revalidate(nvdimm);
-	}
-
-	data = nvdimm_get_key_payload(nvdimm, &key);
+	} else
+		data = nvdimm_get_key_payload(nvdimm, &key);
 
 	rc = nvdimm->sec.ops->unlock(nvdimm, data);
 	dev_dbg(dev, "key: %d unlock: %s\n", key_serial(key),
@@ -230,7 +227,7 @@ static int check_security_state(struct nvdimm *nvdimm)
 	}
 
 	if (test_bit(NDD_SECURITY_OVERWRITE, &nvdimm->flags)) {
-		dev_dbg(dev, "Security operation in progress\n");
+		dev_dbg(dev, "Security operation in progress.\n");
 		return -EBUSY;
 	}
 
@@ -248,23 +245,21 @@ static int security_disable(struct nvdimm *nvdimm, unsigned int keyid)
 	/* The bus lock should be held at the top level of the call stack */
 	lockdep_assert_held(&nvdimm_bus->reconfig_mutex);
 
-	if (!nvdimm->sec.ops ||
-	    !nvdimm->sec.ops->disable ||
-	    !nvdimm->sec.flags)
+	if (!nvdimm->sec.ops || !nvdimm->sec.ops->disable || !nvdimm->sec.flags)
 		return -EOPNOTSUPP;
 
 	rc = check_security_state(nvdimm);
 	if (rc)
 		return rc;
 
-	data = nvdimm_get_user_key_payload(nvdimm, keyid,
-					   NVDIMM_BASE_KEY, &key);
+	data = nvdimm_get_user_key_payload(nvdimm, keyid, NVDIMM_BASE_KEY,
+					   &key);
 	if (!data)
 		return -ENOKEY;
 
 	rc = nvdimm->sec.ops->disable(nvdimm, data);
-	dev_dbg(dev, "key: %d disable: %s\n",
-		key_serial(key), rc == 0 ? "success" : "fail");
+	dev_dbg(dev, "key: %d disable: %s\n", key_serial(key),
+		rc == 0 ? "success" : "fail");
 
 	nvdimm_put_key(key);
 	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
@@ -284,8 +279,7 @@ static int security_update(struct nvdimm *nvdimm, unsigned int keyid,
 	/* The bus lock should be held at the top level of the call stack */
 	lockdep_assert_held(&nvdimm_bus->reconfig_mutex);
 
-	if (!nvdimm->sec.ops ||
-	    !nvdimm->sec.ops->change_key ||
+	if (!nvdimm->sec.ops || !nvdimm->sec.ops->change_key ||
 	    !nvdimm->sec.flags)
 		return -EOPNOTSUPP;
 
@@ -293,29 +287,29 @@ static int security_update(struct nvdimm *nvdimm, unsigned int keyid,
 	if (rc)
 		return rc;
 
-	data = nvdimm_get_user_key_payload(nvdimm, keyid,
-					   NVDIMM_BASE_KEY, &key);
+	data = nvdimm_get_user_key_payload(nvdimm, keyid, NVDIMM_BASE_KEY,
+					   &key);
 	if (!data)
 		return -ENOKEY;
 
-	newdata = nvdimm_get_user_key_payload(nvdimm, new_keyid,
-					      NVDIMM_NEW_KEY, &newkey);
+	newdata = nvdimm_get_user_key_payload(nvdimm, new_keyid, NVDIMM_NEW_KEY,
+					      &newkey);
 	if (!newdata) {
 		nvdimm_put_key(key);
 		return -ENOKEY;
 	}
 
 	rc = nvdimm->sec.ops->change_key(nvdimm, data, newdata, pass_type);
-	dev_dbg(dev, "key: %d %d update%s: %s\n",
-		key_serial(key), key_serial(newkey),
+	dev_dbg(dev, "key: %d %d update%s: %s\n", key_serial(key),
+		key_serial(newkey),
 		pass_type == NVDIMM_MASTER ? "(master)" : "(user)",
 		rc == 0 ? "success" : "fail");
 
 	nvdimm_put_key(newkey);
 	nvdimm_put_key(key);
 	if (pass_type == NVDIMM_MASTER)
-		nvdimm->sec.ext_flags = nvdimm_security_flags(nvdimm,
-							      NVDIMM_MASTER);
+		nvdimm->sec.ext_flags =
+			nvdimm_security_flags(nvdimm, NVDIMM_MASTER);
 	else
 		nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
 	return rc;
@@ -333,9 +327,7 @@ static int security_erase(struct nvdimm *nvdimm, unsigned int keyid,
 	/* The bus lock should be held at the top level of the call stack */
 	lockdep_assert_held(&nvdimm_bus->reconfig_mutex);
 
-	if (!nvdimm->sec.ops ||
-	    !nvdimm->sec.ops->erase ||
-	    !nvdimm->sec.flags)
+	if (!nvdimm->sec.ops || !nvdimm->sec.ops->erase || !nvdimm->sec.flags)
 		return -EOPNOTSUPP;
 
 	rc = check_security_state(nvdimm);
@@ -344,18 +336,18 @@ static int security_erase(struct nvdimm *nvdimm, unsigned int keyid,
 
 	if (!test_bit(NVDIMM_SECURITY_UNLOCKED, &nvdimm->sec.ext_flags) &&
 	    pass_type == NVDIMM_MASTER) {
-		dev_dbg(dev, "Attempt to secure erase in wrong master state\n");
+		dev_dbg(dev,
+			"Attempt to secure erase in wrong master state.\n");
 		return -EOPNOTSUPP;
 	}
 
-	data = nvdimm_get_user_key_payload(nvdimm, keyid,
-					   NVDIMM_BASE_KEY, &key);
+	data = nvdimm_get_user_key_payload(nvdimm, keyid, NVDIMM_BASE_KEY,
+					   &key);
 	if (!data)
 		return -ENOKEY;
 
 	rc = nvdimm->sec.ops->erase(nvdimm, data, pass_type);
-	dev_dbg(dev, "key: %d erase%s: %s\n",
-		key_serial(key),
+	dev_dbg(dev, "key: %d erase%s: %s\n", key_serial(key),
 		pass_type == NVDIMM_MASTER ? "(master)" : "(user)",
 		rc == 0 ? "success" : "fail");
 
@@ -375,13 +367,12 @@ static int security_overwrite(struct nvdimm *nvdimm, unsigned int keyid)
 	/* The bus lock should be held at the top level of the call stack */
 	lockdep_assert_held(&nvdimm_bus->reconfig_mutex);
 
-	if (!nvdimm->sec.ops ||
-	    !nvdimm->sec.ops->overwrite ||
+	if (!nvdimm->sec.ops || !nvdimm->sec.ops->overwrite ||
 	    !nvdimm->sec.flags)
 		return -EOPNOTSUPP;
 
 	if (dev->driver == NULL) {
-		dev_dbg(dev, "Unable to overwrite while DIMM active\n");
+		dev_dbg(dev, "Unable to overwrite while DIMM active.\n");
 		return -EINVAL;
 	}
 
@@ -389,14 +380,14 @@ static int security_overwrite(struct nvdimm *nvdimm, unsigned int keyid)
 	if (rc)
 		return rc;
 
-	data = nvdimm_get_user_key_payload(nvdimm, keyid,
-					   NVDIMM_BASE_KEY, &key);
+	data = nvdimm_get_user_key_payload(nvdimm, keyid, NVDIMM_BASE_KEY,
+					   &key);
 	if (!data)
 		return -ENOKEY;
 
 	rc = nvdimm->sec.ops->overwrite(nvdimm, data);
-	dev_dbg(dev, "key: %d overwrite submission: %s\n",
-		key_serial(key), rc == 0 ? "success" : "fail");
+	dev_dbg(dev, "key: %d overwrite submission: %s\n", key_serial(key),
+		rc == 0 ? "success" : "fail");
 
 	nvdimm_put_key(key);
 	if (rc == 0) {
@@ -432,8 +423,7 @@ void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
 
 	tmo = nvdimm->sec.overwrite_tmo;
 
-	if (!nvdimm->sec.ops ||
-	    !nvdimm->sec.ops->query_overwrite ||
+	if (!nvdimm->sec.ops || !nvdimm->sec.ops->query_overwrite ||
 	    !nvdimm->sec.flags)
 		return;
 
@@ -463,27 +453,27 @@ void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
 
 void nvdimm_security_overwrite_query(struct work_struct *work)
 {
-	struct nvdimm *nvdimm =
-		container_of(work, typeof(*nvdimm), dwork.work);
+	struct nvdimm *nvdimm = container_of(work, typeof(*nvdimm), dwork.work);
 
 	nvdimm_bus_lock(&nvdimm->dev);
 	__nvdimm_security_overwrite_query(nvdimm);
 	nvdimm_bus_unlock(&nvdimm->dev);
 }
 
-#define OPS								\
-	C(OP_FREEZE,		"freeze",		1),		\
-	C(OP_DISABLE,		"disable",		2),		\
-	C(OP_UPDATE,		"update",		3),		\
-	C(OP_ERASE,		"erase",		2),		\
-	C(OP_OVERWRITE,		"overwrite",		2),		\
-	C(OP_MASTER_UPDATE,	"master_update",	3),		\
-	C(OP_MASTER_ERASE,	"master_erase",		2)
+#define OPS                                                                    \
+	C(OP_FREEZE, "freeze", 1), C(OP_DISABLE, "disable", 2),                \
+		C(OP_UPDATE, "update", 3), C(OP_ERASE, "erase", 2),            \
+		C(OP_OVERWRITE, "overwrite", 2),                               \
+		C(OP_MASTER_UPDATE, "master_update", 3),                       \
+		C(OP_MASTER_ERASE, "master_erase", 2)
 #undef C
 #define C(a, b, c) a
 enum nvdimmsec_op_ids { OPS };
 #undef C
-#define C(a, b, c) { b, c }
+#define C(a, b, c)                                                             \
+	{                                                                      \
+		b, c                                                           \
+	}
 static struct {
 	const char *name;
 	int args;
@@ -502,10 +492,15 @@ ssize_t nvdimm_security_store(struct device *dev, const char *buf, size_t len)
 	unsigned int key, newkey;
 	int i;
 
-	rc = sscanf(buf, "%"__stringify(SEC_CMD_SIZE)"s"
-		    " %"__stringify(KEY_ID_SIZE)"s"
-		    " %"__stringify(KEY_ID_SIZE)"s",
-		    cmd, keystr, nkeystr);
+	rc = sscanf(
+		buf,
+		"%" __stringify(
+			SEC_CMD_SIZE) "s"
+				      " %" __stringify(
+					      KEY_ID_SIZE) "s"
+							   " %" __stringify(
+								   KEY_ID_SIZE) "s",
+		cmd, keystr, nkeystr);
 	if (rc < 1)
 		return -EINVAL;
 	for (i = 0; i < ARRAY_SIZE(ops); i++)
@@ -528,26 +523,29 @@ ssize_t nvdimm_security_store(struct device *dev, const char *buf, size_t len)
 		rc = security_disable(nvdimm, key);
 	} else if (i == OP_UPDATE || i == OP_MASTER_UPDATE) {
 		dev_dbg(dev, "%s %u %u\n", ops[i].name, key, newkey);
-		rc = security_update(nvdimm, key, newkey, i == OP_UPDATE
-				     ? NVDIMM_USER : NVDIMM_MASTER);
+		rc = security_update(nvdimm, key, newkey,
+				     i == OP_UPDATE ? NVDIMM_USER :
+						      NVDIMM_MASTER);
 	} else if (i == OP_ERASE || i == OP_MASTER_ERASE) {
 		dev_dbg(dev, "%s %u\n", ops[i].name, key);
 		if (atomic_read(&nvdimm->busy)) {
-			dev_dbg(dev, "Unable to secure erase while DIMM active\n");
+			dev_dbg(dev,
+				"Unable to secure erase while DIMM active.\n");
 			return -EBUSY;
 		}
-		rc = security_erase(nvdimm, key, i == OP_ERASE
-				    ? NVDIMM_USER : NVDIMM_MASTER);
+		rc = security_erase(nvdimm, key,
+				    i == OP_ERASE ? NVDIMM_USER :
+						    NVDIMM_MASTER);
 	} else if (i == OP_OVERWRITE) {
 		dev_dbg(dev, "overwrite %u\n", key);
 		if (atomic_read(&nvdimm->busy)) {
-			dev_dbg(dev, "Unable to overwrite while DIMM active\n");
+			dev_dbg(dev,
+				"Unable to overwrite while DIMM active.\n");
 			return -EBUSY;
 		}
 		rc = security_overwrite(nvdimm, key);
-	} else {
+	} else
 		return -EINVAL;
-	}
 
 	if (rc == 0)
 		rc = len;
diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
index 087753ac81a0..3d0443d24eee 100644
--- a/drivers/nvdimm/virtio_pmem.c
+++ b/drivers/nvdimm/virtio_pmem.c
@@ -18,8 +18,7 @@ static struct virtio_device_id id_table[] = {
 static int init_vq(struct virtio_pmem *vpmem)
 {
 	/* single vq */
-	vpmem->req_vq = virtio_find_single_vq(vpmem->vdev,
-					      virtio_pmem_host_ack,
+	vpmem->req_vq = virtio_find_single_vq(vpmem->vdev, virtio_pmem_host_ack,
 					      "flush_queue");
 	if (IS_ERR(vpmem->req_vq))
 		return PTR_ERR(vpmem->req_vq);
@@ -59,20 +58,20 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
 		goto out_err;
 	}
 
-	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
-		     start, &vpmem->start);
-	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
-		     size, &vpmem->size);
+	virtio_cread(vpmem->vdev, struct virtio_pmem_config, start,
+		     &vpmem->start);
+	virtio_cread(vpmem->vdev, struct virtio_pmem_config, size,
+		     &vpmem->size);
 
 	res.start = vpmem->start;
-	res.end   = vpmem->start + vpmem->size - 1;
+	res.end = vpmem->start + vpmem->size - 1;
 	vpmem->nd_desc.provider_name = "virtio-pmem";
 	vpmem->nd_desc.module = THIS_MODULE;
 
-	vpmem->nvdimm_bus = nvdimm_bus_register(&vdev->dev,
-						&vpmem->nd_desc);
+	vpmem->nvdimm_bus = nvdimm_bus_register(&vdev->dev, &vpmem->nd_desc);
 	if (!vpmem->nvdimm_bus) {
-		dev_err(&vdev->dev, "failed to register device with nvdimm_bus\n");
+		dev_err(&vdev->dev,
+			"failed to register device with nvdimm_bus\n");
 		err = -ENXIO;
 		goto out_vq;
 	}
@@ -92,7 +91,6 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
 	}
 	nd_region->provider_data = dev_to_virtio(nd_region->dev.parent->parent);
 	return 0;
-
 out_nd:
 	nvdimm_bus_unregister(vpmem->nvdimm_bus);
 out_vq:
@@ -111,11 +109,11 @@ static void virtio_pmem_remove(struct virtio_device *vdev)
 }
 
 static struct virtio_driver virtio_pmem_driver = {
-	.driver.name		= KBUILD_MODNAME,
-	.driver.owner		= THIS_MODULE,
-	.id_table		= id_table,
-	.probe			= virtio_pmem_probe,
-	.remove			= virtio_pmem_remove,
+	.driver.name = KBUILD_MODNAME,
+	.driver.owner = THIS_MODULE,
+	.id_table = id_table,
+	.probe = virtio_pmem_probe,
+	.remove = virtio_pmem_remove,
 };
 
 module_virtio_driver(virtio_pmem_driver);

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

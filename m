Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A9BB06F9
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Sep 2019 04:55:37 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BC46B202C80BF;
	Wed, 11 Sep 2019 19:55:41 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=216.40.44.40;
 helo=smtprelay.hostedemail.com; envelope-from=joe@perches.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from smtprelay.hostedemail.com (smtprelay0040.hostedemail.com
 [216.40.44.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4CEE3202C80B8
 for <linux-nvdimm@lists.01.org>; Wed, 11 Sep 2019 19:55:40 -0700 (PDT)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay08.hostedemail.com (Postfix) with ESMTP id 964BF182CED2A;
 Thu, 12 Sep 2019 02:55:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2, 0, 0, , d41d8cd98f00b204, joe@perches.com, :::::::::::::::,
 RULES_HIT:69:355:371:372:379:541:960:966:968:973:982:988:989:1260:1345:1359:1437:1461:1605:1730:1747:1777:1792:2194:2196:2198:2199:2200:2201:2393:2538:2539:2559:2562:2894:2898:3138:3139:3140:3141:3142:3865:3866:3867:3868:3870:3871:3874:4250:4321:4385:4605:5007:6261:7875:7903:8568:8603:9010:10004:10848:11026:11233:11914:12043:12048:12291:12296:12297:12438:12555:12683:12895:12986:13972:14096:14394:14877:21080:21451:21611:21627:21789:21795:21810:21966:30003:30012:30025:30029:30045:30051:30054:30055:30067:30070:30080:30090,
 0,
 RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,
 CacheIP:none, Bayesian:0.5, 0.5, 0.5, Netcheck:none, DomainCache:0,
 MSF:not bulk, SPF:fn, MSBL:0, DNSBL:neutral, Custom_rules:0:0:0, LFtime:27,
 LUA_SUMMARY:none
X-HE-Tag: pie27_878cb6c6f5912
X-Filterd-Recvd-Size: 55058
Received: from joe-laptop.perches.com (unknown [47.151.152.152])
 (Authenticated sender: joe@perches.com)
 by omf16.hostedemail.com (Postfix) with ESMTPA;
 Thu, 12 Sep 2019 02:55:31 +0000 (UTC)
From: Joe Perches <joe@perches.com>
To: Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Keith Busch <keith.busch@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 13/13] nvdimm: Miscellaneous neatening
Date: Wed, 11 Sep 2019 19:54:43 -0700
Message-Id: <251c25a6d6333ebd2e00caef4b15df895717ba9c.1568256708.git.joe@perches.com>
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

Random neatening, mostly trivially wrapping to 80 columns, to make the
code a bit more kernel style compatible.

Use casts to (u64) and not (unsigned long long)

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/nvdimm/badrange.c       |   3 +-
 drivers/nvdimm/blk.c            |  18 ++++---
 drivers/nvdimm/btt.c            |  22 ++++----
 drivers/nvdimm/btt_devs.c       |  42 +++++++++-------
 drivers/nvdimm/bus.c            |  25 ++++-----
 drivers/nvdimm/claim.c          |  11 ++--
 drivers/nvdimm/core.c           |   4 +-
 drivers/nvdimm/dimm_devs.c      |  18 ++++---
 drivers/nvdimm/label.c          |  35 +++++++------
 drivers/nvdimm/label.h          |   6 ++-
 drivers/nvdimm/namespace_devs.c | 109 +++++++++++++++++++++++-----------------
 drivers/nvdimm/nd-core.h        |  13 ++---
 drivers/nvdimm/nd.h             |  26 +++++-----
 drivers/nvdimm/nd_virtio.c      |   3 +-
 drivers/nvdimm/pfn_devs.c       |  43 ++++++++--------
 drivers/nvdimm/pmem.c           |  14 +++---
 drivers/nvdimm/region_devs.c    |  36 +++++++------
 drivers/nvdimm/security.c       |  28 +++++------
 drivers/nvdimm/virtio_pmem.c    |   4 +-
 19 files changed, 254 insertions(+), 206 deletions(-)

diff --git a/drivers/nvdimm/badrange.c b/drivers/nvdimm/badrange.c
index 681d99c59f52..4d231643c095 100644
--- a/drivers/nvdimm/badrange.c
+++ b/drivers/nvdimm/badrange.c
@@ -24,7 +24,8 @@ void badrange_init(struct badrange *badrange)
 EXPORT_SYMBOL_GPL(badrange_init);
 
 static void append_badrange_entry(struct badrange *badrange,
-				  struct badrange_entry *bre, u64 addr, u64 length)
+				  struct badrange_entry *bre,
+				  u64 addr, u64 length)
 {
 	lockdep_assert_held(&badrange->lock);
 	bre->start = addr;
diff --git a/drivers/nvdimm/blk.c b/drivers/nvdimm/blk.c
index db3973c7f506..fc15aa9220c8 100644
--- a/drivers/nvdimm/blk.c
+++ b/drivers/nvdimm/blk.c
@@ -29,7 +29,8 @@ static u32 nsblk_sector_size(struct nd_namespace_blk *nsblk)
 }
 
 static resource_size_t to_dev_offset(struct nd_namespace_blk *nsblk,
-				     resource_size_t ns_offset, unsigned int len)
+				     resource_size_t ns_offset,
+				     unsigned int len)
 {
 	int i;
 
@@ -61,7 +62,8 @@ static struct nd_blk_region *to_ndbr(struct nd_namespace_blk *nsblk)
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 static int nd_blk_rw_integrity(struct nd_namespace_blk *nsblk,
-			       struct bio_integrity_payload *bip, u64 lba, int rw)
+			       struct bio_integrity_payload *bip,
+			       u64 lba, int rw)
 {
 	struct nd_blk_region *ndbr = to_ndbr(nsblk);
 	unsigned int len = nsblk_meta_size(nsblk);
@@ -107,7 +109,8 @@ static int nd_blk_rw_integrity(struct nd_namespace_blk *nsblk,
 
 #else /* CONFIG_BLK_DEV_INTEGRITY */
 static int nd_blk_rw_integrity(struct nd_namespace_blk *nsblk,
-			       struct bio_integrity_payload *bip, u64 lba, int rw)
+			       struct bio_integrity_payload *bip,
+			       u64 lba, int rw)
 {
 	return 0;
 }
@@ -115,7 +118,8 @@ static int nd_blk_rw_integrity(struct nd_namespace_blk *nsblk,
 
 static int nsblk_do_bvec(struct nd_namespace_blk *nsblk,
 			 struct bio_integrity_payload *bip, struct page *page,
-			 unsigned int len, unsigned int off, int rw, sector_t sector)
+			 unsigned int len, unsigned int off, int rw,
+			 sector_t sector)
 {
 	struct nd_blk_region *ndbr = to_ndbr(nsblk);
 	resource_size_t	dev_offset, ns_offset;
@@ -187,9 +191,9 @@ static blk_qc_t nd_blk_make_request(struct request_queue *q, struct bio *bio)
 				    bvec.bv_offset, rw, iter.bi_sector);
 		if (err) {
 			dev_dbg(&nsblk->common.dev,
-				"io error in %s sector %lld, len %d,\n",
-				(rw == READ) ? "READ" : "WRITE",
-				(unsigned long long)iter.bi_sector, len);
+				"io error in %s sector %lld, len %d\n",
+				rw == READ ? "READ" : "WRITE",
+				(u64)iter.bi_sector, len);
 			bio->bi_status = errno_to_blk_status(err);
 			break;
 		}
diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 0df4461fe607..6c18d7bba6af 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -589,7 +589,8 @@ static int btt_freelist_init(struct arena_info *arena)
 			 * to complete the map write. So fix up the map.
 			 */
 			ret = btt_map_write(arena, le32_to_cpu(log_new.lba),
-					    le32_to_cpu(log_new.new_map), 0, 0, 0);
+					    le32_to_cpu(log_new.new_map),
+					    0, 0, 0);
 			if (ret)
 				return ret;
 		}
@@ -827,8 +828,9 @@ static void parse_arena_meta(struct arena_info *arena, struct btt_sb *super,
 	arena->version_major = le16_to_cpu(super->version_major);
 	arena->version_minor = le16_to_cpu(super->version_minor);
 
-	arena->nextoff = (super->nextoff == 0) ? 0 : (arena_off +
-						      le64_to_cpu(super->nextoff));
+	arena->nextoff = (super->nextoff == 0)
+		? 0
+		: arena_off + le64_to_cpu(super->nextoff);
 	arena->infooff = arena_off;
 	arena->dataoff = arena_off + le64_to_cpu(super->dataoff);
 	arena->mapoff = arena_off + le64_to_cpu(super->mapoff);
@@ -836,8 +838,8 @@ static void parse_arena_meta(struct arena_info *arena, struct btt_sb *super,
 	arena->info2off = arena_off + le64_to_cpu(super->info2off);
 
 	arena->size = (le64_to_cpu(super->nextoff) > 0)
-		? (le64_to_cpu(super->nextoff))
-		: (arena->info2off - arena->infooff + BTT_PG_SIZE);
+		? le64_to_cpu(super->nextoff)
+		: arena->info2off - arena->infooff + BTT_PG_SIZE;
 
 	arena->flags = le32_to_cpu(super->flags);
 }
@@ -1457,7 +1459,8 @@ static blk_qc_t btt_make_request(struct request_queue *q, struct bio *bio)
 		if (len > PAGE_SIZE || len < btt->sector_size ||
 		    len % btt->sector_size) {
 			dev_err_ratelimited(&btt->nd_btt->dev,
-					    "unaligned bio segment (len: %d)\n", len);
+					    "unaligned bio segment (len: %d)\n",
+					    len);
 			bio->bi_status = BLK_STS_IOERR;
 			break;
 		}
@@ -1466,10 +1469,9 @@ static blk_qc_t btt_make_request(struct request_queue *q, struct bio *bio)
 				  bio_op(bio), iter.bi_sector);
 		if (err) {
 			dev_err(&btt->nd_btt->dev,
-				"io error in %s sector %lld, len %d,\n",
-				(op_is_write(bio_op(bio))) ? "WRITE" :
-				"READ",
-				(unsigned long long)iter.bi_sector, len);
+				"io error in %s sector %lld, len %d\n",
+				op_is_write(bio_op(bio)) ? "WRITE" : "READ",
+				(u64)iter.bi_sector, len);
 			bio->bi_status = errno_to_blk_status(err);
 			break;
 		}
diff --git a/drivers/nvdimm/btt_devs.c b/drivers/nvdimm/btt_devs.c
index 9e0f17045e69..b27993ade004 100644
--- a/drivers/nvdimm/btt_devs.c
+++ b/drivers/nvdimm/btt_devs.c
@@ -45,8 +45,9 @@ struct nd_btt *to_nd_btt(struct device *dev)
 }
 EXPORT_SYMBOL(to_nd_btt);
 
-static const unsigned long btt_lbasize_supported[] = { 512, 520, 528,
-						       4096, 4104, 4160, 4224, 0 };
+static const unsigned long btt_lbasize_supported[] = {
+	512, 520, 528, 4096, 4104, 4160, 4224, 0
+};
 
 static ssize_t sector_size_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -57,7 +58,8 @@ static ssize_t sector_size_show(struct device *dev,
 }
 
 static ssize_t sector_size_store(struct device *dev,
-				 struct device_attribute *attr, const char *buf, size_t len)
+				 struct device_attribute *attr,
+				 const char *buf, size_t len)
 {
 	struct nd_btt *nd_btt = to_nd_btt(dev);
 	ssize_t rc;
@@ -66,8 +68,8 @@ static ssize_t sector_size_store(struct device *dev,
 	nvdimm_bus_lock(dev);
 	rc = nd_size_select_store(dev, buf, &nd_btt->lbasize,
 				  btt_lbasize_supported);
-	dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
-		buf[len - 1] == '\n' ? "" : "\n");
+	dev_dbg(dev, "result: %zd wrote: %s%s",
+		rc, buf, buf[len - 1] == '\n' ? "" : "\n");
 	nvdimm_bus_unlock(dev);
 	nd_device_unlock(dev);
 
@@ -85,37 +87,38 @@ static ssize_t uuid_show(struct device *dev,
 	return sprintf(buf, "\n");
 }
 
-static ssize_t uuid_store(struct device *dev,
-			  struct device_attribute *attr, const char *buf, size_t len)
+static ssize_t uuid_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t len)
 {
 	struct nd_btt *nd_btt = to_nd_btt(dev);
 	ssize_t rc;
 
 	nd_device_lock(dev);
 	rc = nd_uuid_store(dev, &nd_btt->uuid, buf, len);
-	dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
-		buf[len - 1] == '\n' ? "" : "\n");
+	dev_dbg(dev, "result: %zd wrote: %s%s",
+		rc, buf, buf[len - 1] == '\n' ? "" : "\n");
 	nd_device_unlock(dev);
 
 	return rc ? rc : len;
 }
 static DEVICE_ATTR_RW(uuid);
 
-static ssize_t namespace_show(struct device *dev,
-			      struct device_attribute *attr, char *buf)
+static ssize_t namespace_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
 {
 	struct nd_btt *nd_btt = to_nd_btt(dev);
 	ssize_t rc;
 
 	nvdimm_bus_lock(dev);
-	rc = sprintf(buf, "%s\n", nd_btt->ndns
-		     ? dev_name(&nd_btt->ndns->dev) : "");
+	rc = sprintf(buf, "%s\n",
+		     nd_btt->ndns ? dev_name(&nd_btt->ndns->dev) : "");
 	nvdimm_bus_unlock(dev);
 	return rc;
 }
 
 static ssize_t namespace_store(struct device *dev,
-			       struct device_attribute *attr, const char *buf, size_t len)
+			       struct device_attribute *attr,
+			       const char *buf, size_t len)
 {
 	struct nd_btt *nd_btt = to_nd_btt(dev);
 	ssize_t rc;
@@ -123,8 +126,8 @@ static ssize_t namespace_store(struct device *dev,
 	nd_device_lock(dev);
 	nvdimm_bus_lock(dev);
 	rc = nd_namespace_store(dev, &nd_btt->ndns, buf, len);
-	dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
-		buf[len - 1] == '\n' ? "" : "\n");
+	dev_dbg(dev, "result: %zd wrote: %s%s",
+		rc, buf, buf[len - 1] == '\n' ? "" : "\n");
 	nvdimm_bus_unlock(dev);
 	nd_device_unlock(dev);
 
@@ -132,8 +135,8 @@ static ssize_t namespace_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(namespace);
 
-static ssize_t size_show(struct device *dev,
-			 struct device_attribute *attr, char *buf)
+static ssize_t size_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
 {
 	struct nd_btt *nd_btt = to_nd_btt(dev);
 	ssize_t rc;
@@ -304,7 +307,8 @@ int nd_btt_version(struct nd_btt *nd_btt, struct nd_namespace_common *ndns,
 EXPORT_SYMBOL(nd_btt_version);
 
 static int __nd_btt_probe(struct nd_btt *nd_btt,
-			  struct nd_namespace_common *ndns, struct btt_sb *btt_sb)
+			  struct nd_namespace_common *ndns,
+			  struct btt_sb *btt_sb)
 {
 	int rc;
 
diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 620f07ac306c..733b2a2117c0 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -103,8 +103,8 @@ static int nvdimm_bus_probe(struct device *dev)
 		nd_region_disable(nvdimm_bus, dev);
 	nvdimm_bus_probe_end(nvdimm_bus);
 
-	dev_dbg(&nvdimm_bus->dev, "END: %s.probe(%s) = %d\n", dev->driver->name,
-		dev_name(dev), rc);
+	dev_dbg(&nvdimm_bus->dev, "END: %s.probe(%s) = %d\n",
+		dev->driver->name, dev_name(dev), rc);
 
 	if (rc != 0)
 		module_put(provider);
@@ -125,8 +125,8 @@ static int nvdimm_bus_remove(struct device *dev)
 	}
 	nd_region_disable(nvdimm_bus, dev);
 
-	dev_dbg(&nvdimm_bus->dev, "%s.remove(%s) = %d\n", dev->driver->name,
-		dev_name(dev), rc);
+	dev_dbg(&nvdimm_bus->dev, "%s.remove(%s) = %d\n",
+		dev->driver->name, dev_name(dev), rc);
 	module_put(provider);
 	return rc;
 }
@@ -846,8 +846,9 @@ u32 nd_cmd_in_size(struct nvdimm *nvdimm, int cmd,
 EXPORT_SYMBOL_GPL(nd_cmd_in_size);
 
 u32 nd_cmd_out_size(struct nvdimm *nvdimm, int cmd,
-		    const struct nd_cmd_desc *desc, int idx, const u32 *in_field,
-		    const u32 *out_field, unsigned long remainder)
+		    const struct nd_cmd_desc *desc, int idx,
+		    const u32 *in_field, const u32 *out_field,
+		    unsigned long remainder)
 {
 	if (idx >= desc->out_num)
 		return UINT_MAX;
@@ -951,7 +952,8 @@ static int nd_ns_forget_poison_check(struct device *dev, void *data)
 
 /* set_config requires an idle interleave set */
 static int nd_cmd_clear_to_send(struct nvdimm_bus *nvdimm_bus,
-				struct nvdimm *nvdimm, unsigned int cmd, void *data)
+				struct nvdimm *nvdimm,
+				unsigned int cmd, void *data)
 {
 	struct nvdimm_bus_descriptor *nd_desc = nvdimm_bus->nd_desc;
 
@@ -1025,7 +1027,7 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
 		case ND_CMD_ARS_START:
 		case ND_CMD_CLEAR_ERROR:
 		case ND_CMD_CALL:
-			dev_dbg(dev, "'%s' command while read-only.\n",
+			dev_dbg(dev, "'%s' command while read-only\n",
 				nvdimm ? nvdimm_cmd_name(cmd)
 				: nvdimm_bus_cmd_name(cmd));
 			return -EPERM;
@@ -1061,8 +1063,7 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
 	if (cmd == ND_CMD_CALL) {
 		func = pkg.nd_command;
 		dev_dbg(dev, "%s, idx: %llu, in: %u, out: %u, len %llu\n",
-			dimm_name, pkg.nd_command,
-			in_len, out_len, buf_len);
+			dimm_name, pkg.nd_command, in_len, out_len, buf_len);
 	}
 
 	/* process an output envelope */
@@ -1097,8 +1098,8 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
 
 	buf_len = (u64)out_len + (u64)in_len;
 	if (buf_len > ND_IOCTL_MAX_BUFLEN) {
-		dev_dbg(dev, "%s cmd: %s buf_len: %llu > %d\n", dimm_name,
-			cmd_name, buf_len, ND_IOCTL_MAX_BUFLEN);
+		dev_dbg(dev, "%s cmd: %s buf_len: %llu > %d\n",
+			dimm_name, cmd_name, buf_len, ND_IOCTL_MAX_BUFLEN);
 		rc = -EINVAL;
 		goto out;
 	}
diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
index 244631f5308c..953029c240e5 100644
--- a/drivers/nvdimm/claim.c
+++ b/drivers/nvdimm/claim.c
@@ -132,8 +132,8 @@ static void nd_detach_and_reset(struct device *dev,
 }
 
 ssize_t nd_namespace_store(struct device *dev,
-			   struct nd_namespace_common **_ndns, const char *buf,
-			   size_t len)
+			   struct nd_namespace_common **_ndns,
+			   const char *buf, size_t len)
 {
 	struct nd_namespace_common *ndns;
 	struct device *found;
@@ -158,7 +158,8 @@ ssize_t nd_namespace_store(struct device *dev,
 	if (strcmp(name, "") == 0) {
 		nd_detach_and_reset(dev, _ndns);
 		goto out;
-	} else if (ndns) {
+	}
+	if (ndns) {
 		dev_dbg(dev, "namespace already set to: %s\n",
 			dev_name(&ndns->dev));
 		len = -EBUSY;
@@ -200,7 +201,6 @@ ssize_t nd_namespace_store(struct device *dev,
 	default:
 		len = -EBUSY;
 		goto out_attach;
-		break;
 	}
 
 	if (__nvdimm_namespace_capacity(ndns) < SZ_16M) {
@@ -278,7 +278,8 @@ static int nsio_rw_bytes(struct nd_namespace_common *ndns,
 
 			might_sleep();
 			cleared = nvdimm_clear_poison(&ndns->dev,
-						      nsio->res.start + offset, size);
+						      nsio->res.start + offset,
+						      size);
 			if (cleared < size)
 				rc = -EIO;
 			if (cleared > 0 && cleared / 512) {
diff --git a/drivers/nvdimm/core.c b/drivers/nvdimm/core.c
index e30b39f49c46..deb92c806abf 100644
--- a/drivers/nvdimm/core.c
+++ b/drivers/nvdimm/core.c
@@ -208,9 +208,7 @@ EXPORT_SYMBOL_GPL(to_nvdimm_bus_dev);
 
 static bool is_uuid_sep(char sep)
 {
-	if (sep == '\n' || sep == '-' || sep == ':' || sep == '\0')
-		return true;
-	return false;
+	return sep == '\n' || sep == '-' || sep == ':' || sep == '\0';
 }
 
 static int nd_uuid_parse(struct device *dev, u8 *uuid_out, const char *buf,
diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index cac62bb726bb..35a6c20d30fd 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -114,7 +114,8 @@ int nvdimm_get_config_data(struct nvdimm_drvdata *ndd, void *buf,
 		cmd_size = sizeof(*cmd) + cmd->in_length;
 
 		rc = nd_desc->ndctl(nd_desc, to_nvdimm(ndd->dev),
-				    ND_CMD_GET_CONFIG_DATA, cmd, cmd_size, &cmd_rc);
+				    ND_CMD_GET_CONFIG_DATA, cmd, cmd_size,
+				    &cmd_rc);
 		if (rc < 0)
 			break;
 		if (cmd_rc < 0) {
@@ -162,7 +163,8 @@ int nvdimm_set_config_data(struct nvdimm_drvdata *ndd, size_t offset,
 		cmd_size = sizeof(*cmd) + cmd->in_length + sizeof(u32);
 
 		rc = nd_desc->ndctl(nd_desc, to_nvdimm(ndd->dev),
-				    ND_CMD_SET_CONFIG_DATA, cmd, cmd_size, &cmd_rc);
+				    ND_CMD_SET_CONFIG_DATA, cmd, cmd_size,
+				    &cmd_rc);
 		if (rc < 0)
 			break;
 		if (cmd_rc < 0) {
@@ -341,8 +343,8 @@ static ssize_t state_show(struct device *dev, struct device_attribute *attr,
 	 */
 	nvdimm_bus_lock(dev);
 	nvdimm_bus_unlock(dev);
-	return sprintf(buf, "%s\n", atomic_read(&nvdimm->busy)
-		       ? "active" : "idle");
+	return sprintf(buf, "%s\n",
+		       atomic_read(&nvdimm->busy) ? "active" : "idle");
 }
 static DEVICE_ATTR_RO(state);
 
@@ -397,7 +399,8 @@ static ssize_t frozen_show(struct device *dev,
 static DEVICE_ATTR_RO(frozen);
 
 static ssize_t security_store(struct device *dev,
-			      struct device_attribute *attr, const char *buf, size_t len)
+			      struct device_attribute *attr,
+			      const char *buf, size_t len)
 
 {
 	ssize_t rc;
@@ -551,7 +554,7 @@ int nvdimm_security_freeze(struct nvdimm *nvdimm)
 		return -EIO;
 
 	if (test_bit(NDD_SECURITY_OVERWRITE, &nvdimm->flags)) {
-		dev_warn(&nvdimm->dev, "Overwrite operation in progress.\n");
+		dev_warn(&nvdimm->dev, "Overwrite operation in progress\n");
 		return -EBUSY;
 	}
 
@@ -711,7 +714,8 @@ resource_size_t nd_pmem_max_contiguous_dpa(struct nd_region *nd_region,
  * the set can be established.
  */
 resource_size_t nd_pmem_available_dpa(struct nd_region *nd_region,
-				      struct nd_mapping *nd_mapping, resource_size_t *overlap)
+				      struct nd_mapping *nd_mapping,
+				      resource_size_t *overlap)
 {
 	resource_size_t map_start, map_end, busy = 0, available, blk_start;
 	struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
index ae466c6faa90..9bf75dad8e93 100644
--- a/drivers/nvdimm/label.c
+++ b/drivers/nvdimm/label.c
@@ -159,7 +159,8 @@ static int __nd_label_validate(struct nvdimm_drvdata *ndd)
 
 		seq = __le32_to_cpu(nsindex[i]->seq);
 		if ((seq & NSINDEX_SEQ_MASK) == 0) {
-			dev_dbg(dev, "nsindex%d sequence: %#x invalid\n", i, seq);
+			dev_dbg(dev, "nsindex%d sequence: %#x invalid\n",
+				i, seq);
 			continue;
 		}
 
@@ -167,29 +168,27 @@ static int __nd_label_validate(struct nvdimm_drvdata *ndd)
 		if (__le64_to_cpu(nsindex[i]->myoff)
 		    != i * sizeof_namespace_index(ndd)) {
 			dev_dbg(dev, "nsindex%d myoff: %#llx invalid\n",
-				i, (unsigned long long)
-				__le64_to_cpu(nsindex[i]->myoff));
+				i, (u64)__le64_to_cpu(nsindex[i]->myoff));
 			continue;
 		}
 		if (__le64_to_cpu(nsindex[i]->otheroff)
 		    != (!i) * sizeof_namespace_index(ndd)) {
 			dev_dbg(dev, "nsindex%d otheroff: %#llx invalid\n",
-				i, (unsigned long long)
-				__le64_to_cpu(nsindex[i]->otheroff));
+				i, (u64)__le64_to_cpu(nsindex[i]->otheroff));
 			continue;
 		}
 		if (__le64_to_cpu(nsindex[i]->labeloff)
 		    != 2 * sizeof_namespace_index(ndd)) {
 			dev_dbg(dev, "nsindex%d labeloff: %#llx invalid\n",
-				i, (unsigned long long)
-				__le64_to_cpu(nsindex[i]->labeloff));
+				i, (u64)__le64_to_cpu(nsindex[i]->labeloff));
 			continue;
 		}
 
 		size = __le64_to_cpu(nsindex[i]->mysize);
 		if (size > sizeof_namespace_index(ndd) ||
 		    size < sizeof(struct nd_namespace_index)) {
-			dev_dbg(dev, "nsindex%d mysize: %#llx invalid\n", i, size);
+			dev_dbg(dev, "nsindex%d mysize: %#llx invalid\n",
+				i, size);
 			continue;
 		}
 
@@ -717,13 +716,13 @@ enum nvdimm_claim_class to_nvdimm_cclass(guid_t *guid)
 {
 	if (guid_equal(guid, &nvdimm_btt_guid))
 		return NVDIMM_CCLASS_BTT;
-	else if (guid_equal(guid, &nvdimm_btt2_guid))
+	if (guid_equal(guid, &nvdimm_btt2_guid))
 		return NVDIMM_CCLASS_BTT2;
-	else if (guid_equal(guid, &nvdimm_pfn_guid))
+	if (guid_equal(guid, &nvdimm_pfn_guid))
 		return NVDIMM_CCLASS_PFN;
-	else if (guid_equal(guid, &nvdimm_dax_guid))
+	if (guid_equal(guid, &nvdimm_dax_guid))
 		return NVDIMM_CCLASS_DAX;
-	else if (guid_equal(guid, &guid_null))
+	if (guid_equal(guid, &guid_null))
 		return NVDIMM_CCLASS_NONE;
 
 	return NVDIMM_CCLASS_UNKNOWN;
@@ -763,7 +762,8 @@ static void reap_victim(struct nd_mapping *nd_mapping,
 }
 
 static int __pmem_label_update(struct nd_region *nd_region,
-			       struct nd_mapping *nd_mapping, struct nd_namespace_pmem *nspm,
+			       struct nd_mapping *nd_mapping,
+			       struct nd_namespace_pmem *nspm,
 			       int pos, unsigned long flags)
 {
 	struct nd_namespace_common *ndns = &nspm->nsio.common;
@@ -901,7 +901,8 @@ static struct resource *to_resource(struct nvdimm_drvdata *ndd,
  * 3/ Record the resources in the namespace device
  */
 static int __blk_label_update(struct nd_region *nd_region,
-			      struct nd_mapping *nd_mapping, struct nd_namespace_blk *nsblk,
+			      struct nd_mapping *nd_mapping,
+			      struct nd_namespace_blk *nsblk,
 			      int num_labels)
 {
 	int i, alloc, victims, nfree, old_num_resources, nlabel, rc = -ENXIO;
@@ -1245,7 +1246,8 @@ static int del_labels(struct nd_mapping *nd_mapping, u8 *uuid)
 }
 
 int nd_pmem_namespace_label_update(struct nd_region *nd_region,
-				   struct nd_namespace_pmem *nspm, resource_size_t size)
+				   struct nd_namespace_pmem *nspm,
+				   resource_size_t size)
 {
 	int i, rc;
 
@@ -1293,7 +1295,8 @@ int nd_pmem_namespace_label_update(struct nd_region *nd_region,
 }
 
 int nd_blk_namespace_label_update(struct nd_region *nd_region,
-				  struct nd_namespace_blk *nsblk, resource_size_t size)
+				  struct nd_namespace_blk *nsblk,
+				  resource_size_t size)
 {
 	struct nd_mapping *nd_mapping = &nd_region->mapping[0];
 	struct resource *res;
diff --git a/drivers/nvdimm/label.h b/drivers/nvdimm/label.h
index aff33d09fec3..a008ec92f78c 100644
--- a/drivers/nvdimm/label.h
+++ b/drivers/nvdimm/label.h
@@ -140,7 +140,9 @@ struct nd_region;
 struct nd_namespace_pmem;
 struct nd_namespace_blk;
 int nd_pmem_namespace_label_update(struct nd_region *nd_region,
-				   struct nd_namespace_pmem *nspm, resource_size_t size);
+				   struct nd_namespace_pmem *nspm,
+				   resource_size_t size);
 int nd_blk_namespace_label_update(struct nd_region *nd_region,
-				  struct nd_namespace_blk *nsblk, resource_size_t size);
+				  struct nd_namespace_blk *nsblk,
+				  resource_size_t size);
 #endif /* __LABEL_H__ */
diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 253f07d97b73..d53efe06d312 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -198,17 +198,17 @@ const char *nvdimm_namespace_disk_name(struct nd_namespace_common *ndns,
 		}
 
 		if (nsidx)
-			sprintf(name, "pmem%d.%d%s", nd_region->id, nsidx,
-				suffix ? suffix : "");
+			sprintf(name, "pmem%d.%d%s",
+				nd_region->id, nsidx, suffix ? suffix : "");
 		else
-			sprintf(name, "pmem%d%s", nd_region->id,
-				suffix ? suffix : "");
+			sprintf(name, "pmem%d%s",
+				nd_region->id, suffix ? suffix : "");
 	} else if (is_namespace_blk(&ndns->dev)) {
 		struct nd_namespace_blk *nsblk;
 
 		nsblk = to_nd_namespace_blk(&ndns->dev);
-		sprintf(name, "ndblk%d.%d%s", nd_region->id, nsblk->id,
-			suffix ? suffix : "");
+		sprintf(name, "ndblk%d.%d%s",
+			nd_region->id, nsblk->id, suffix ? suffix : "");
 	} else {
 		return NULL;
 	}
@@ -408,8 +408,8 @@ static int nd_namespace_label_update(struct nd_region *nd_region,
 	return -ENXIO;
 }
 
-static ssize_t alt_name_store(struct device *dev,
-			      struct device_attribute *attr, const char *buf, size_t len)
+static ssize_t alt_name_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t len)
 {
 	struct nd_region *nd_region = to_nd_region(dev->parent);
 	ssize_t rc;
@@ -448,9 +448,8 @@ static ssize_t alt_name_show(struct device *dev,
 }
 static DEVICE_ATTR_RW(alt_name);
 
-static int scan_free(struct nd_region *nd_region,
-		     struct nd_mapping *nd_mapping, struct nd_label_id *label_id,
-		     resource_size_t n)
+static int scan_free(struct nd_region *nd_region, struct nd_mapping *nd_mapping,
+		     struct nd_label_id *label_id, resource_size_t n)
 {
 	bool is_blk = strncmp(label_id->id, "blk", 3) == 0;
 	struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
@@ -507,7 +506,8 @@ static int scan_free(struct nd_region *nd_region,
  * set.
  */
 static int shrink_dpa_allocation(struct nd_region *nd_region,
-				 struct nd_label_id *label_id, resource_size_t n)
+				 struct nd_label_id *label_id,
+				 resource_size_t n)
 {
 	int i;
 
@@ -524,7 +524,8 @@ static int shrink_dpa_allocation(struct nd_region *nd_region,
 }
 
 static resource_size_t init_dpa_allocation(struct nd_label_id *label_id,
-					   struct nd_region *nd_region, struct nd_mapping *nd_mapping,
+					   struct nd_region *nd_region,
+					   struct nd_mapping *nd_mapping,
 					   resource_size_t n)
 {
 	bool is_blk = strncmp(label_id->id, "blk", 3) == 0;
@@ -616,7 +617,8 @@ enum alloc_loc {
 };
 
 static resource_size_t scan_allocate(struct nd_region *nd_region,
-				     struct nd_mapping *nd_mapping, struct nd_label_id *label_id,
+				     struct nd_mapping *nd_mapping,
+				     struct nd_label_id *label_id,
 				     resource_size_t n)
 {
 	resource_size_t mapping_end = nd_mapping->start + nd_mapping->size - 1;
@@ -626,9 +628,10 @@ static resource_size_t scan_allocate(struct nd_region *nd_region,
 	const resource_size_t to_allocate = n;
 	int first;
 
-	for_each_dpa_resource(ndd, res)
+	for_each_dpa_resource(ndd, res) {
 		if (strcmp(label_id->id, res->name) == 0)
 			exist = res;
+	}
 
 	valid.start = nd_mapping->start;
 	valid.end = mapping_end;
@@ -698,8 +701,9 @@ static resource_size_t scan_allocate(struct nd_region *nd_region,
 		case ALLOC_MID:
 			if (strcmp(next->name, label_id->id) == 0) {
 				/* adjust next resource up */
-				rc = adjust_resource(next, next->start
-						     - allocate, resource_size(next)
+				rc = adjust_resource(next,
+						     next->start - allocate,
+						     resource_size(next)
 						     + allocate);
 				new_res = next;
 				action = "next grow up";
@@ -730,8 +734,8 @@ static resource_size_t scan_allocate(struct nd_region *nd_region,
 				rc = -EBUSY;
 		} else if (strcmp(action, "grow down") == 0) {
 			/* adjust current resource down */
-			rc = adjust_resource(res, res->start, resource_size(res)
-					     + allocate);
+			rc = adjust_resource(res, res->start,
+					     resource_size(res) + allocate);
 			if (rc == 0)
 				res->flags |= DPA_RESOURCE_ADJUSTED;
 		}
@@ -771,7 +775,8 @@ static resource_size_t scan_allocate(struct nd_region *nd_region,
 }
 
 static int merge_dpa(struct nd_region *nd_region,
-		     struct nd_mapping *nd_mapping, struct nd_label_id *label_id)
+		     struct nd_mapping *nd_mapping,
+		     struct nd_label_id *label_id)
 {
 	struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
 	struct resource *res;
@@ -831,8 +836,7 @@ int __reserve_free_pmem(struct device *dev, void *data)
 		rem = scan_allocate(nd_region, nd_mapping, &label_id, n);
 		dev_WARN_ONCE(&nd_region->dev, rem,
 			      "pmem reserve underrun: %#llx of %#llx bytes\n",
-			      (unsigned long long)n - rem,
-			      (unsigned long long)n);
+			      (u64)n - rem, (u64)n);
 		return rem ? -ENXIO : 0;
 	}
 
@@ -912,8 +916,7 @@ static int grow_dpa_allocation(struct nd_region *nd_region,
 
 		dev_WARN_ONCE(&nd_region->dev, rem,
 			      "allocation underrun: %#llx of %#llx bytes\n",
-			      (unsigned long long)n - rem,
-			      (unsigned long long)n);
+			      (u64)n - rem, (u64)n);
 		if (rem)
 			return -ENXIO;
 
@@ -926,7 +929,8 @@ static int grow_dpa_allocation(struct nd_region *nd_region,
 }
 
 static void nd_namespace_pmem_set_resource(struct nd_region *nd_region,
-					   struct nd_namespace_pmem *nspm, resource_size_t size)
+					   struct nd_namespace_pmem *nspm,
+					   resource_size_t size)
 {
 	struct resource *res = &nspm->nsio.res;
 	resource_size_t offset = 0;
@@ -1073,8 +1077,8 @@ static ssize_t __size_store(struct device *dev, unsigned long long val)
 	return rc;
 }
 
-static ssize_t size_store(struct device *dev,
-			  struct device_attribute *attr, const char *buf, size_t len)
+static ssize_t size_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t len)
 {
 	struct nd_region *nd_region = to_nd_region(dev->parent);
 	unsigned long long val;
@@ -1174,8 +1178,8 @@ EXPORT_SYMBOL(nvdimm_namespace_locked);
 static ssize_t size_show(struct device *dev,
 			 struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%llu\n", (unsigned long long)
-		       nvdimm_namespace_capacity(to_ndns(dev)));
+	return sprintf(buf, "%llu\n",
+		       (u64)nvdimm_namespace_capacity(to_ndns(dev)));
 }
 static DEVICE_ATTR(size, 0444, size_show, size_store);
 
@@ -1215,7 +1219,8 @@ static ssize_t uuid_show(struct device *dev,
  * @old_uuid: reference to the uuid storage location in the namespace object
  */
 static int namespace_update_uuid(struct nd_region *nd_region,
-				 struct device *dev, u8 *new_uuid, u8 **old_uuid)
+				 struct device *dev,
+				 u8 *new_uuid, u8 **old_uuid)
 {
 	u32 flags = is_namespace_blk(dev) ? NSLABEL_FLAG_LOCAL : 0;
 	struct nd_label_id old_label_id;
@@ -1281,8 +1286,8 @@ static int namespace_update_uuid(struct nd_region *nd_region,
 	return 0;
 }
 
-static ssize_t uuid_store(struct device *dev,
-			  struct device_attribute *attr, const char *buf, size_t len)
+static ssize_t uuid_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t len)
 {
 	struct nd_region *nd_region = to_nd_region(dev->parent);
 	u8 *uuid = NULL;
@@ -1314,8 +1319,8 @@ static ssize_t uuid_store(struct device *dev,
 		rc = nd_namespace_label_update(nd_region, dev);
 	else
 		kfree(uuid);
-	dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
-		buf[len - 1] == '\n' ? "" : "\n");
+	dev_dbg(dev, "result: %zd wrote: %s%s",
+		rc, buf, buf[len - 1] == '\n' ? "" : "\n");
 	nvdimm_bus_unlock(dev);
 	nd_device_unlock(dev);
 
@@ -1343,14 +1348,17 @@ static ssize_t resource_show(struct device *dev,
 	/* no address to convey if the namespace has no allocation */
 	if (resource_size(res) == 0)
 		return -ENXIO;
-	return sprintf(buf, "%#llx\n", (unsigned long long)res->start);
+	return sprintf(buf, "%#llx\n", (u64)res->start);
 }
 static DEVICE_ATTR_RO(resource);
 
-static const unsigned long blk_lbasize_supported[] = { 512, 520, 528,
-						       4096, 4104, 4160, 4224, 0 };
+static const unsigned long blk_lbasize_supported[] = {
+	512, 520, 528, 4096, 4104, 4160, 4224, 0
+};
 
-static const unsigned long pmem_lbasize_supported[] = { 512, 4096, 0 };
+static const unsigned long pmem_lbasize_supported[] = {
+	512, 4096, 0
+};
 
 static ssize_t sector_size_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -1372,7 +1380,8 @@ static ssize_t sector_size_show(struct device *dev,
 }
 
 static ssize_t sector_size_store(struct device *dev,
-				 struct device_attribute *attr, const char *buf, size_t len)
+				 struct device_attribute *attr,
+				 const char *buf, size_t len)
 {
 	struct nd_region *nd_region = to_nd_region(dev->parent);
 	const unsigned long *supported;
@@ -1401,7 +1410,8 @@ static ssize_t sector_size_store(struct device *dev,
 		rc = nd_size_select_store(dev, buf, lbasize, supported);
 	if (rc >= 0)
 		rc = nd_namespace_label_update(nd_region, dev);
-	dev_dbg(dev, "result: %zd %s: %s%s", rc, rc < 0 ? "tried" : "wrote",
+	dev_dbg(dev, "result: %zd %s: %s%s",
+		rc, rc < 0 ? "tried" : "wrote",
 		buf, buf[len - 1] == '\n' ? "" : "\n");
 	nvdimm_bus_unlock(dev);
 	nd_device_unlock(dev);
@@ -1553,7 +1563,8 @@ static ssize_t __holder_class_store(struct device *dev, const char *buf)
 }
 
 static ssize_t holder_class_store(struct device *dev,
-				  struct device_attribute *attr, const char *buf, size_t len)
+				  struct device_attribute *attr,
+				  const char *buf, size_t len)
 {
 	struct nd_region *nd_region = to_nd_region(dev->parent);
 	ssize_t rc;
@@ -1623,7 +1634,8 @@ static ssize_t mode_show(struct device *dev,
 static DEVICE_ATTR_RO(mode);
 
 static ssize_t force_raw_store(struct device *dev,
-			       struct device_attribute *attr, const char *buf, size_t len)
+			       struct device_attribute *attr,
+			       const char *buf, size_t len)
 {
 	bool force_raw;
 	int rc = strtobool(buf, &force_raw);
@@ -2190,8 +2202,8 @@ void nd_region_create_btt_seed(struct nd_region *nd_region)
 }
 
 static int add_namespace_resource(struct nd_region *nd_region,
-				  struct nd_namespace_label *nd_label, struct device **devs,
-				  int count)
+				  struct nd_namespace_label *nd_label,
+				  struct device **devs, int count)
 {
 	struct nd_mapping *nd_mapping = &nd_region->mapping[0];
 	struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
@@ -2228,7 +2240,8 @@ static int add_namespace_resource(struct nd_region *nd_region,
 }
 
 static struct device *create_namespace_blk(struct nd_region *nd_region,
-					   struct nd_namespace_label *nd_label, int count)
+					   struct nd_namespace_label *nd_label,
+					   int count)
 {
 	struct nd_mapping *nd_mapping = &nd_region->mapping[0];
 	struct nd_interleave_set *nd_set = nd_region->nd_set;
@@ -2333,7 +2346,8 @@ static struct device **scan_labels(struct nd_region *nd_region)
 			continue;
 
 		/* skip labels that describe extents outside of the region */
-		if (nd_label->dpa < nd_mapping->start || nd_label->dpa > map_end)
+		if (nd_label->dpa < nd_mapping->start ||
+		    nd_label->dpa > map_end)
 			continue;
 
 		i = add_namespace_resource(nd_region, nd_label, devs, count);
@@ -2494,7 +2508,8 @@ static int init_active_labels(struct nd_region *nd_region)
 			    test_bit(NDD_ALIASING, &nvdimm->flags)) {
 					/* labels needed to disambiguate dpa */
 
-				dev_err(&nd_region->dev, "%s: is %s, failing probe\n",
+				dev_err(&nd_region->dev,
+					"%s: is %s, failing probe\n",
 					dev_name(&nd_mapping->nvdimm->dev),
 					test_bit(NDD_LOCKED, &nvdimm->flags)
 					? "locked" : "disabled");
diff --git a/drivers/nvdimm/nd-core.h b/drivers/nvdimm/nd-core.h
index 3b48fba4629b..15bbdf6bea24 100644
--- a/drivers/nvdimm/nd-core.h
+++ b/drivers/nvdimm/nd-core.h
@@ -62,8 +62,7 @@ static inline unsigned long nvdimm_security_flags(
 	flags = nvdimm->sec.ops->get_flags(nvdimm, ptype);
 	/* disabled, locked, unlocked, and overwrite are mutually exclusive */
 	dev_WARN_ONCE(&nvdimm->dev, hweight64(flags & state_flags) > 1,
-		      "reported invalid security state: %#llx\n",
-		      (unsigned long long)flags);
+		      "reported invalid security state: %#llx\n", (u64)flags);
 	return flags;
 }
 
@@ -150,7 +149,8 @@ resource_size_t nd_pmem_max_contiguous_dpa(struct nd_region *nd_region,
 					   struct nd_mapping *nd_mapping);
 resource_size_t nd_region_allocatable_dpa(struct nd_region *nd_region);
 resource_size_t nd_pmem_available_dpa(struct nd_region *nd_region,
-				      struct nd_mapping *nd_mapping, resource_size_t *overlap);
+				      struct nd_mapping *nd_mapping,
+				      resource_size_t *overlap);
 resource_size_t nd_blk_available_dpa(struct nd_region *nd_region);
 resource_size_t nd_region_available_dpa(struct nd_region *nd_region);
 int nd_region_conflict(struct nd_region *nd_region, resource_size_t start,
@@ -159,7 +159,8 @@ resource_size_t nvdimm_allocated_dpa(struct nvdimm_drvdata *ndd,
 				     struct nd_label_id *label_id);
 int alias_dpa_busy(struct device *dev, void *data);
 struct resource *nsblk_add_resource(struct nd_region *nd_region,
-				    struct nvdimm_drvdata *ndd, struct nd_namespace_blk *nsblk,
+				    struct nvdimm_drvdata *ndd,
+				    struct nd_namespace_blk *nsblk,
 				    resource_size_t start);
 int nvdimm_num_label_slots(struct nvdimm_drvdata *ndd);
 void get_ndd(struct nvdimm_drvdata *ndd);
@@ -171,8 +172,8 @@ bool nd_attach_ndns(struct device *dev, struct nd_namespace_common *attach,
 bool __nd_attach_ndns(struct device *dev, struct nd_namespace_common *attach,
 		      struct nd_namespace_common **_ndns);
 ssize_t nd_namespace_store(struct device *dev,
-			   struct nd_namespace_common **_ndns, const char *buf,
-			   size_t len);
+			   struct nd_namespace_common **_ndns,
+			   const char *buf, size_t len);
 struct nd_pfn *to_nd_pfn_safe(struct device *dev);
 bool is_nvdimm_bus(struct device *dev);
 
diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index d434041ca2e5..852ce9591109 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -90,8 +90,8 @@ unsigned int sizeof_namespace_label(struct nvdimm_drvdata *ndd);
 #define nd_dbg_dpa(r, d, res, fmt, arg...)				\
 	dev_dbg((r) ? &(r)->dev : (d)->dev, "%s: %.13s: %#llx @ %#llx " fmt, \
 		(r) ? dev_name((d)->dev) : "", res ? res->name : "null", \
-		(unsigned long long)(res ? resource_size(res) : 0),	\
-		(unsigned long long)(res ? res->start : 0), ##arg)
+		(u64)(res ? resource_size(res) : 0),	\
+		(u64)(res ? res->start : 0), ##arg)
 
 #define for_each_dpa_resource(ndd, res)				\
 	for (res = (ndd)->dpa.child; res; res = res->sibling)
@@ -228,7 +228,8 @@ int nd_uuid_store(struct device *dev, u8 **uuid_out, const char *buf,
 ssize_t nd_size_select_show(unsigned long current_size,
 			    const unsigned long *supported, char *buf);
 ssize_t nd_size_select_store(struct device *dev, const char *buf,
-			     unsigned long *current_size, const unsigned long *supported);
+			     unsigned long *current_size,
+			     const unsigned long *supported);
 int __init nvdimm_init(void);
 int __init nd_region_init(void);
 int __init nd_label_init(void);
@@ -363,7 +364,8 @@ void put_ndd(struct nvdimm_drvdata *ndd);
 int nd_label_reserve_dpa(struct nvdimm_drvdata *ndd);
 void nvdimm_free_dpa(struct nvdimm_drvdata *ndd, struct resource *res);
 struct resource *nvdimm_allocate_dpa(struct nvdimm_drvdata *ndd,
-				     struct nd_label_id *label_id, resource_size_t start,
+				     struct nd_label_id *label_id,
+				     resource_size_t start,
 				     resource_size_t n);
 resource_size_t nvdimm_namespace_capacity(struct nd_namespace_common *ndns);
 bool nvdimm_namespace_locked(struct nd_namespace_common *ndns);
@@ -374,7 +376,8 @@ const char *nvdimm_namespace_disk_name(struct nd_namespace_common *ndns,
 				       char *name);
 unsigned int pmem_sector_size(struct nd_namespace_common *ndns);
 void nvdimm_badblocks_populate(struct nd_region *nd_region,
-			       struct badblocks *bb, const struct resource *res);
+			       struct badblocks *bb,
+			       const struct resource *res);
 #if IS_ENABLED(CONFIG_ND_CLAIM)
 int nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap);
 int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio);
@@ -423,15 +426,14 @@ static inline void nd_iostat_end(struct bio *bio, unsigned long start)
 static inline bool is_bad_pmem(struct badblocks *bb, sector_t sector,
 			       unsigned int len)
 {
-	if (bb->count) {
-		sector_t first_bad;
-		int num_bad;
+	sector_t first_bad;
+	int num_bad;
 
-		return !!badblocks_check(bb, sector, len / 512, &first_bad,
-					 &num_bad);
-	}
+	if (!bb->count)
+		return false;
 
-	return false;
+
+	return badblocks_check(bb, sector, len / 512, &first_bad, &num_bad);
 }
 
 resource_size_t nd_namespace_blk_validate(struct nd_namespace_blk *nsblk);
diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index f09541bf3d5d..1a792fee8cfd 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -24,7 +24,8 @@ void virtio_pmem_host_ack(struct virtqueue *vq)
 
 		if (!list_empty(&vpmem->req_list)) {
 			req_buf = list_first_entry(&vpmem->req_list,
-						   struct virtio_pmem_request, list);
+						   struct virtio_pmem_request,
+						   list);
 			req_buf->wq_buf_avail = true;
 			wake_up(&req_buf->wq_buf);
 			list_del(&req_buf->list);
diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index 7226d6d95899..6ab72f8f4a66 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -61,8 +61,8 @@ static ssize_t mode_show(struct device *dev,
 	}
 }
 
-static ssize_t mode_store(struct device *dev,
-			  struct device_attribute *attr, const char *buf, size_t len)
+static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t len)
 {
 	struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
 	ssize_t rc = 0;
@@ -87,8 +87,8 @@ static ssize_t mode_store(struct device *dev,
 			rc = -EINVAL;
 		}
 	}
-	dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
-		buf[len - 1] == '\n' ? "" : "\n");
+	dev_dbg(dev, "result: %zd wrote: %s%s",
+		rc, buf, buf[len - 1] == '\n' ? "" : "\n");
 	nvdimm_bus_unlock(dev);
 	nd_device_unlock(dev);
 
@@ -137,8 +137,8 @@ static ssize_t align_store(struct device *dev,
 	nvdimm_bus_lock(dev);
 	rc = nd_size_select_store(dev, buf, &nd_pfn->align,
 				  nd_pfn_supported_alignments());
-	dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
-		buf[len - 1] == '\n' ? "" : "\n");
+	dev_dbg(dev, "result: %zd wrote: %s%s",
+		rc, buf, buf[len - 1] == '\n' ? "" : "\n");
 	nvdimm_bus_unlock(dev);
 	nd_device_unlock(dev);
 
@@ -164,8 +164,8 @@ static ssize_t uuid_store(struct device *dev,
 
 	nd_device_lock(dev);
 	rc = nd_uuid_store(dev, &nd_pfn->uuid, buf, len);
-	dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
-		buf[len - 1] == '\n' ? "" : "\n");
+	dev_dbg(dev, "result: %zd wrote: %s%s",
+		rc, buf, buf[len - 1] == '\n' ? "" : "\n");
 	nd_device_unlock(dev);
 
 	return rc ? rc : len;
@@ -179,14 +179,15 @@ static ssize_t namespace_show(struct device *dev,
 	ssize_t rc;
 
 	nvdimm_bus_lock(dev);
-	rc = sprintf(buf, "%s\n", nd_pfn->ndns
-		     ? dev_name(&nd_pfn->ndns->dev) : "");
+	rc = sprintf(buf, "%s\n",
+		     nd_pfn->ndns ? dev_name(&nd_pfn->ndns->dev) : "");
 	nvdimm_bus_unlock(dev);
 	return rc;
 }
 
 static ssize_t namespace_store(struct device *dev,
-			       struct device_attribute *attr, const char *buf, size_t len)
+			       struct device_attribute *attr,
+			       const char *buf, size_t len)
 {
 	struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
 	ssize_t rc;
@@ -194,8 +195,8 @@ static ssize_t namespace_store(struct device *dev,
 	nd_device_lock(dev);
 	nvdimm_bus_lock(dev);
 	rc = nd_namespace_store(dev, &nd_pfn->ndns, buf, len);
-	dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
-		buf[len - 1] == '\n' ? "" : "\n");
+	dev_dbg(dev, "result: %zd wrote: %s%s",
+		rc, buf, buf[len - 1] == '\n' ? "" : "\n");
 	nvdimm_bus_unlock(dev);
 	nd_device_unlock(dev);
 
@@ -217,8 +218,8 @@ static ssize_t resource_show(struct device *dev,
 		u32 start_pad = __le32_to_cpu(pfn_sb->start_pad);
 		struct nd_namespace_io *nsio = to_nd_namespace_io(&ndns->dev);
 
-		rc = sprintf(buf, "%#llx\n", (unsigned long long)nsio->res.start
-			     + start_pad + offset);
+		rc = sprintf(buf, "%#llx\n",
+			     (u64)nsio->res.start + start_pad + offset);
 	} else {
 		/* no address to convey if the pfn instance is disabled */
 		rc = -ENXIO;
@@ -244,9 +245,9 @@ static ssize_t size_show(struct device *dev,
 		u32 end_trunc = __le32_to_cpu(pfn_sb->end_trunc);
 		struct nd_namespace_io *nsio = to_nd_namespace_io(&ndns->dev);
 
-		rc = sprintf(buf, "%llu\n", (unsigned long long)
-			     resource_size(&nsio->res) - start_pad
-			     - end_trunc - offset);
+		rc = sprintf(buf, "%llu\n",
+			     (u64)resource_size(&nsio->res)
+			     - start_pad - end_trunc - offset);
 	} else {
 		/* no size to convey if the pfn instance is disabled */
 		rc = -ENXIO;
@@ -258,7 +259,8 @@ static ssize_t size_show(struct device *dev,
 static DEVICE_ATTR_RO(size);
 
 static ssize_t supported_alignments_show(struct device *dev,
-					 struct device_attribute *attr, char *buf)
+					 struct device_attribute *attr,
+					 char *buf)
 {
 	return nd_size_select_show(0, nd_pfn_supported_alignments(), buf);
 }
@@ -387,7 +389,8 @@ static int nd_pfn_clear_memmap_errors(struct nd_pfn *nd_pfn)
 			dev_dbg(&nd_pfn->dev, "meta: %x badblocks at %llx\n",
 				num_bad, first_bad);
 			nsoff = ALIGN_DOWN((nd_region->ndr_start
-					    + (first_bad << 9)) - nsio->res.start,
+					    + (first_bad << 9))
+					   - nsio->res.start,
 					   PAGE_SIZE);
 			zero_len = ALIGN(num_bad << 9, PAGE_SIZE);
 			while (zero_len) {
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 64e7429edcc2..3f1add94144a 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -85,8 +85,7 @@ static blk_status_t pmem_clear_poison(struct pmem_device *pmem,
 		hwpoison_clear(pmem, pmem->phys_addr + offset, cleared);
 		cleared /= 512;
 		dev_dbg(dev, "%#llx clear %ld sector%s\n",
-			(unsigned long long)sector, cleared,
-			cleared > 1 ? "s" : "");
+			(u64)sector, cleared, cleared > 1 ? "s" : "");
 		badblocks_clear(&pmem->bb, sector, cleared);
 		if (pmem->bb_state)
 			sysfs_notify_dirent(pmem->bb_state);
@@ -138,8 +137,8 @@ static blk_status_t read_pmem(struct page *page, unsigned int off,
 }
 
 static blk_status_t pmem_do_bvec(struct pmem_device *pmem, struct page *page,
-				 unsigned int len, unsigned int off, unsigned int op,
-				 sector_t sector)
+				 unsigned int len, unsigned int off,
+				 unsigned int op, sector_t sector)
 {
 	blk_status_t rc = BLK_STS_OK;
 	bool bad_pmem = false;
@@ -270,7 +269,8 @@ static const struct block_device_operations pmem_fops = {
 };
 
 static long pmem_dax_direct_access(struct dax_device *dax_dev,
-				   pgoff_t pgoff, long nr_pages, void **kaddr, pfn_t *pfn)
+				   pgoff_t pgoff, long nr_pages,
+				   void **kaddr, pfn_t *pfn)
 {
 	struct pmem_device *pmem = dax_get_private(dax_dev);
 
@@ -455,8 +455,8 @@ static int pmem_attach_disk(struct device *dev,
 	disk->flags		= GENHD_FL_EXT_DEVT;
 	disk->queue->backing_dev_info->capabilities |= BDI_CAP_SYNCHRONOUS_IO;
 	nvdimm_namespace_disk_name(ndns, disk->disk_name);
-	set_capacity(disk, (pmem->size - pmem->pfn_pad - pmem->data_offset)
-		     / 512);
+	set_capacity(disk,
+		     (pmem->size - pmem->pfn_pad - pmem->data_offset) / 512);
 	if (devm_init_badblocks(dev, &pmem->bb))
 		return -ENOMEM;
 	nvdimm_badblocks_populate(nd_region, &pmem->bb, &bb_res);
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 6861e0997d21..6ed918e30cf9 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -2,6 +2,7 @@
 /*
  * Copyright(c) 2013-2015 Intel Corporation. All rights reserved.
  */
+
 #include <linux/scatterlist.h>
 #include <linux/highmem.h>
 #include <linux/sched.h>
@@ -44,16 +45,15 @@ static int nvdimm_map_flush(struct device *dev, struct nvdimm *nvdimm, int dimm,
 		}
 
 		if (j < i)
-			flush_page = (void __iomem *)((unsigned long)
-						       ndrd_get_flush_wpq(ndrd, dimm, j)
-						       & PAGE_MASK);
+			flush_page = (void __iomem *)
+				((unsigned long)ndrd_get_flush_wpq(ndrd, dimm, j) & PAGE_MASK);
 		else
-			flush_page = devm_nvdimm_ioremap(dev,
-							 PFN_PHYS(pfn), PAGE_SIZE);
+			flush_page = devm_nvdimm_ioremap(dev, PFN_PHYS(pfn),
+							 PAGE_SIZE);
 		if (!flush_page)
 			return -ENXIO;
-		ndrd_set_flush_wpq(ndrd, dimm, i, flush_page
-				   + (res->start & ~PAGE_MASK));
+		ndrd_set_flush_wpq(ndrd, dimm, i,
+				   flush_page + (res->start & ~PAGE_MASK));
 	}
 
 	return 0;
@@ -276,7 +276,8 @@ static ssize_t deep_flush_show(struct device *dev,
 	return sprintf(buf, "%d\n", nvdimm_has_flush(nd_region));
 }
 
-static ssize_t deep_flush_store(struct device *dev, struct device_attribute *attr,
+static ssize_t deep_flush_store(struct device *dev,
+				struct device_attribute *attr,
 				const char *buf, size_t len)
 {
 	bool flush;
@@ -435,7 +436,8 @@ static ssize_t available_size_show(struct device *dev,
 static DEVICE_ATTR_RO(available_size);
 
 static ssize_t max_available_extent_show(struct device *dev,
-					 struct device_attribute *attr, char *buf)
+					 struct device_attribute *attr,
+					 char *buf)
 {
 	struct nd_region *nd_region = to_nd_region(dev);
 	unsigned long long available = 0;
@@ -544,7 +546,8 @@ static ssize_t read_only_show(struct device *dev,
 }
 
 static ssize_t read_only_store(struct device *dev,
-			       struct device_attribute *attr, const char *buf, size_t len)
+			       struct device_attribute *attr,
+			       const char *buf, size_t len)
 {
 	bool ro;
 	int rc = strtobool(buf, &ro);
@@ -813,12 +816,13 @@ static ssize_t mappingN(struct device *dev, char *buf, int n)
 }
 
 #define REGION_MAPPING(idx)						\
-	static ssize_t mapping##idx##_show(struct device *dev,		\
-					   struct device_attribute *attr, char *buf) \
-	{								\
-		return mappingN(dev, buf, idx);				\
-	}								\
-	static DEVICE_ATTR_RO(mapping##idx)
+static ssize_t mapping##idx##_show(struct device *dev,			\
+				   struct device_attribute *attr,	\
+				   char *buf)				\
+{									\
+	return mappingN(dev, buf, idx);					\
+}									\
+static DEVICE_ATTR_RO(mapping##idx)
 
 /*
  * 32 should be enough for a while, even in the presence of socket
diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
index 693416001d17..cb14c05f127e 100644
--- a/drivers/nvdimm/security.c
+++ b/drivers/nvdimm/security.c
@@ -118,7 +118,8 @@ static struct key *nvdimm_lookup_user_key(struct nvdimm *nvdimm,
 }
 
 static const void *nvdimm_get_user_key_payload(struct nvdimm *nvdimm,
-					       key_serial_t id, int subclass, struct key **key)
+					       key_serial_t id, int subclass,
+					       struct key **key)
 {
 	*key = NULL;
 	if (id == 0) {
@@ -229,7 +230,7 @@ static int check_security_state(struct nvdimm *nvdimm)
 	}
 
 	if (test_bit(NDD_SECURITY_OVERWRITE, &nvdimm->flags)) {
-		dev_dbg(dev, "Security operation in progress.\n");
+		dev_dbg(dev, "Security operation in progress\n");
 		return -EBUSY;
 	}
 
@@ -262,8 +263,8 @@ static int security_disable(struct nvdimm *nvdimm, unsigned int keyid)
 		return -ENOKEY;
 
 	rc = nvdimm->sec.ops->disable(nvdimm, data);
-	dev_dbg(dev, "key: %d disable: %s\n", key_serial(key),
-		rc == 0 ? "success" : "fail");
+	dev_dbg(dev, "key: %d disable: %s\n",
+		key_serial(key), rc == 0 ? "success" : "fail");
 
 	nvdimm_put_key(key);
 	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
@@ -316,8 +317,7 @@ static int security_update(struct nvdimm *nvdimm, unsigned int keyid,
 		nvdimm->sec.ext_flags = nvdimm_security_flags(nvdimm,
 							      NVDIMM_MASTER);
 	else
-		nvdimm->sec.flags = nvdimm_security_flags(nvdimm,
-							  NVDIMM_USER);
+		nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
 	return rc;
 }
 
@@ -344,8 +344,7 @@ static int security_erase(struct nvdimm *nvdimm, unsigned int keyid,
 
 	if (!test_bit(NVDIMM_SECURITY_UNLOCKED, &nvdimm->sec.ext_flags) &&
 	    pass_type == NVDIMM_MASTER) {
-		dev_dbg(dev,
-			"Attempt to secure erase in wrong master state.\n");
+		dev_dbg(dev, "Attempt to secure erase in wrong master state\n");
 		return -EOPNOTSUPP;
 	}
 
@@ -355,7 +354,8 @@ static int security_erase(struct nvdimm *nvdimm, unsigned int keyid,
 		return -ENOKEY;
 
 	rc = nvdimm->sec.ops->erase(nvdimm, data, pass_type);
-	dev_dbg(dev, "key: %d erase%s: %s\n", key_serial(key),
+	dev_dbg(dev, "key: %d erase%s: %s\n",
+		key_serial(key),
 		pass_type == NVDIMM_MASTER ? "(master)" : "(user)",
 		rc == 0 ? "success" : "fail");
 
@@ -381,7 +381,7 @@ static int security_overwrite(struct nvdimm *nvdimm, unsigned int keyid)
 		return -EOPNOTSUPP;
 
 	if (dev->driver == NULL) {
-		dev_dbg(dev, "Unable to overwrite while DIMM active.\n");
+		dev_dbg(dev, "Unable to overwrite while DIMM active\n");
 		return -EINVAL;
 	}
 
@@ -395,8 +395,8 @@ static int security_overwrite(struct nvdimm *nvdimm, unsigned int keyid)
 		return -ENOKEY;
 
 	rc = nvdimm->sec.ops->overwrite(nvdimm, data);
-	dev_dbg(dev, "key: %d overwrite submission: %s\n", key_serial(key),
-		rc == 0 ? "success" : "fail");
+	dev_dbg(dev, "key: %d overwrite submission: %s\n",
+		key_serial(key), rc == 0 ? "success" : "fail");
 
 	nvdimm_put_key(key);
 	if (rc == 0) {
@@ -533,7 +533,7 @@ ssize_t nvdimm_security_store(struct device *dev, const char *buf, size_t len)
 	} else if (i == OP_ERASE || i == OP_MASTER_ERASE) {
 		dev_dbg(dev, "%s %u\n", ops[i].name, key);
 		if (atomic_read(&nvdimm->busy)) {
-			dev_dbg(dev, "Unable to secure erase while DIMM active.\n");
+			dev_dbg(dev, "Unable to secure erase while DIMM active\n");
 			return -EBUSY;
 		}
 		rc = security_erase(nvdimm, key, i == OP_ERASE
@@ -541,7 +541,7 @@ ssize_t nvdimm_security_store(struct device *dev, const char *buf, size_t len)
 	} else if (i == OP_OVERWRITE) {
 		dev_dbg(dev, "overwrite %u\n", key);
 		if (atomic_read(&nvdimm->busy)) {
-			dev_dbg(dev, "Unable to overwrite while DIMM active.\n");
+			dev_dbg(dev, "Unable to overwrite while DIMM active\n");
 			return -EBUSY;
 		}
 		rc = security_overwrite(nvdimm, key);
diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
index ce2181e06756..087753ac81a0 100644
--- a/drivers/nvdimm/virtio_pmem.c
+++ b/drivers/nvdimm/virtio_pmem.c
@@ -19,7 +19,8 @@ static int init_vq(struct virtio_pmem *vpmem)
 {
 	/* single vq */
 	vpmem->req_vq = virtio_find_single_vq(vpmem->vdev,
-					      virtio_pmem_host_ack, "flush_queue");
+					      virtio_pmem_host_ack,
+					      "flush_queue");
 	if (IS_ERR(vpmem->req_vq))
 		return PTR_ERR(vpmem->req_vq);
 
@@ -91,6 +92,7 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
 	}
 	nd_region->provider_data = dev_to_virtio(nd_region->dev.parent->parent);
 	return 0;
+
 out_nd:
 	nvdimm_bus_unregister(vpmem->nvdimm_bus);
 out_vq:
-- 
2.15.0

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

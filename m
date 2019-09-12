Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82776B06EA
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Sep 2019 04:55:13 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E7B9E202C80A0;
	Wed, 11 Sep 2019 19:55:17 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=216.40.44.156;
 helo=smtprelay.hostedemail.com; envelope-from=joe@perches.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from smtprelay.hostedemail.com (smtprelay0156.hostedemail.com
 [216.40.44.156])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id EB555202C808E
 for <linux-nvdimm@lists.01.org>; Wed, 11 Sep 2019 19:55:16 -0700 (PDT)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay02.hostedemail.com (Postfix) with ESMTP id B5B9B1B664;
 Thu, 12 Sep 2019 02:55:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2, 0, 0, , d41d8cd98f00b204, joe@perches.com, :::::::::::::::,
 RULES_HIT:4:41:69:355:371:372:379:541:800:960:966:968:973:988:989:1260:1345:1359:1437:1605:1730:1747:1777:1792:2196:2198:2199:2200:2393:2559:2562:2693:2894:2895:2898:3138:3139:3140:3141:3142:3865:3866:3867:3868:3870:3871:4321:4385:4605:5007:6119:6261:7875:7903:7904:8603:9036:10004:10848:10954:11026:11232:11233:11473:11658:11914:12043:12048:12296:12297:12438:12555:12895:12986:14394:21080:21451:21627:21740:21810:21966:30003:30029:30045:30051:30054:30070:30079:30080,
 0,
 RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,
 CacheIP:none, Bayesian:0.5, 0.5, 0.5, Netcheck:none, DomainCache:0,
 MSF:not bulk, SPF:fn, MSBL:0, DNSBL:none, Custom_rules:0:0:0, LFtime:26,
 LUA_SUMMARY:none
X-HE-Tag: bomb51_8426c5b84e44c
X-Filterd-Recvd-Size: 19011
Received: from joe-laptop.perches.com (unknown [47.151.152.152])
 (Authenticated sender: joe@perches.com)
 by omf16.hostedemail.com (Postfix) with ESMTPA;
 Thu, 12 Sep 2019 02:55:08 +0000 (UTC)
From: Joe Perches <joe@perches.com>
To: Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Keith Busch <keith.busch@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 04/13] nvdimm: Use a more common kernel spacing style
Date: Wed, 11 Sep 2019 19:54:34 -0700
Message-Id: <f8f45c508b75ecaed4c670fc72cc4936526c0876.1568256706.git.joe@perches.com>
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

Use the more common kernel spacing styles per line.

git diff -w shows no difference.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/nvdimm/badrange.c       |  4 ++--
 drivers/nvdimm/blk.c            |  2 +-
 drivers/nvdimm/btt.c            |  4 ++--
 drivers/nvdimm/btt_devs.c       |  2 +-
 drivers/nvdimm/bus.c            | 14 +++++++-------
 drivers/nvdimm/core.c           |  2 +-
 drivers/nvdimm/label.c          | 28 ++++++++++++++--------------
 drivers/nvdimm/namespace_devs.c | 22 +++++++++++-----------
 drivers/nvdimm/nd-core.h        |  2 +-
 drivers/nvdimm/nd.h             |  4 ++--
 drivers/nvdimm/pfn_devs.c       |  6 +++---
 drivers/nvdimm/pmem.c           |  2 +-
 drivers/nvdimm/region.c         |  2 +-
 drivers/nvdimm/region_devs.c    |  2 +-
 drivers/nvdimm/security.c       | 18 +++++++++---------
 15 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/drivers/nvdimm/badrange.c b/drivers/nvdimm/badrange.c
index b997c2007b83..f2a742c6258a 100644
--- a/drivers/nvdimm/badrange.c
+++ b/drivers/nvdimm/badrange.c
@@ -165,11 +165,11 @@ EXPORT_SYMBOL_GPL(badrange_forget);
 static void set_badblock(struct badblocks *bb, sector_t s, int num)
 {
 	dev_dbg(bb->dev, "Found a bad range (0x%llx, 0x%llx)\n",
-		(u64) s * 512, (u64) num * 512);
+		(u64)s * 512, (u64)num * 512);
 	/* this isn't an error as the hardware will still throw an exception */
 	if (badblocks_set(bb, s, num, 1))
 		dev_info_once(bb->dev, "%s: failed for sector %llx\n",
-			      __func__, (u64) s);
+			      __func__, (u64)s);
 }
 
 /**
diff --git a/drivers/nvdimm/blk.c b/drivers/nvdimm/blk.c
index edd3e1664edc..95acb48bfaed 100644
--- a/drivers/nvdimm/blk.c
+++ b/drivers/nvdimm/blk.c
@@ -189,7 +189,7 @@ static blk_qc_t nd_blk_make_request(struct request_queue *q, struct bio *bio)
 			dev_dbg(&nsblk->common.dev,
 				"io error in %s sector %lld, len %d,\n",
 				(rw == READ) ? "READ" : "WRITE",
-				(unsigned long long) iter.bi_sector, len);
+				(unsigned long long)iter.bi_sector, len);
 			bio->bi_status = errno_to_blk_status(err);
 			break;
 		}
diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 9cad4dca6eac..28b65413abd8 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1007,7 +1007,7 @@ static int btt_arena_write_layout(struct arena_info *arena)
 	super->info2off = cpu_to_le64(arena->info2off - arena->infooff);
 
 	super->flags = 0;
-	sum = nd_sb_checksum((struct nd_gen_sb *) super);
+	sum = nd_sb_checksum((struct nd_gen_sb *)super);
 	super->checksum = cpu_to_le64(sum);
 
 	ret = btt_info_write(arena, super);
@@ -1469,7 +1469,7 @@ static blk_qc_t btt_make_request(struct request_queue *q, struct bio *bio)
 				"io error in %s sector %lld, len %d,\n",
 				(op_is_write(bio_op(bio))) ? "WRITE" :
 				"READ",
-				(unsigned long long) iter.bi_sector, len);
+				(unsigned long long)iter.bi_sector, len);
 			bio->bi_status = errno_to_blk_status(err);
 			break;
 		}
diff --git a/drivers/nvdimm/btt_devs.c b/drivers/nvdimm/btt_devs.c
index 9c4cbda834be..f6429842f1b6 100644
--- a/drivers/nvdimm/btt_devs.c
+++ b/drivers/nvdimm/btt_devs.c
@@ -256,7 +256,7 @@ bool nd_btt_arena_is_valid(struct nd_btt *nd_btt, struct btt_sb *super)
 
 	checksum = le64_to_cpu(super->checksum);
 	super->checksum = 0;
-	if (checksum != nd_sb_checksum((struct nd_gen_sb *) super))
+	if (checksum != nd_sb_checksum((struct nd_gen_sb *)super))
 		return false;
 	super->checksum = cpu_to_le64(checksum);
 
diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 6d4d4c72ac92..35591f492d27 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -876,7 +876,7 @@ u32 nd_cmd_out_size(struct nvdimm *nvdimm, int cmd,
 			return remainder;
 		return out_field[1] - 8;
 	} else if (cmd == ND_CMD_CALL) {
-		struct nd_cmd_pkg *pkg = (struct nd_cmd_pkg *) in_field;
+		struct nd_cmd_pkg *pkg = (struct nd_cmd_pkg *)in_field;
 
 		return pkg->nd_size_out;
 	}
@@ -984,7 +984,7 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
 	const struct nd_cmd_desc *desc = NULL;
 	unsigned int cmd = _IOC_NR(ioctl_cmd);
 	struct device *dev = &nvdimm_bus->dev;
-	void __user *p = (void __user *) arg;
+	void __user *p = (void __user *)arg;
 	char *out_env = NULL, *in_env = NULL;
 	const char *cmd_name, *dimm_name;
 	u32 in_len = 0, out_len = 0;
@@ -1073,7 +1073,7 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
 
 	for (i = 0; i < desc->out_num; i++) {
 		u32 out_size = nd_cmd_out_size(nvdimm, cmd, desc, i,
-					       (u32 *) in_env, (u32 *) out_env, 0);
+					       (u32 *)in_env, (u32 *)out_env, 0);
 		u32 copy;
 
 		if (out_size == UINT_MAX) {
@@ -1094,7 +1094,7 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
 		out_len += out_size;
 	}
 
-	buf_len = (u64) out_len + (u64) in_len;
+	buf_len = (u64)out_len + (u64)in_len;
 	if (buf_len > ND_IOCTL_MAX_BUFLEN) {
 		dev_dbg(dev, "%s cmd: %s buf_len: %llu > %d\n", dimm_name,
 			cmd_name, buf_len, ND_IOCTL_MAX_BUFLEN);
@@ -1150,7 +1150,7 @@ enum nd_ioctl_mode {
 
 static int match_dimm(struct device *dev, void *data)
 {
-	long id = (long) data;
+	long id = (long)data;
 
 	if (is_nvdimm(dev)) {
 		struct nvdimm *nvdimm = to_nvdimm(dev);
@@ -1166,7 +1166,7 @@ static long nd_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
 
 {
 	struct nvdimm_bus *nvdimm_bus, *found = NULL;
-	long id = (long) file->private_data;
+	long id = (long)file->private_data;
 	struct nvdimm *nvdimm = NULL;
 	int rc, ro;
 
@@ -1221,7 +1221,7 @@ static int nd_open(struct inode *inode, struct file *file)
 {
 	long minor = iminor(inode);
 
-	file->private_data = (void *) minor;
+	file->private_data = (void *)minor;
 	return 0;
 }
 
diff --git a/drivers/nvdimm/core.c b/drivers/nvdimm/core.c
index b3ff3e62d847..e30b39f49c46 100644
--- a/drivers/nvdimm/core.c
+++ b/drivers/nvdimm/core.c
@@ -184,7 +184,7 @@ u64 nd_fletcher64(void *addr, size_t len, bool le)
 	int i;
 
 	for (i = 0; i < len / sizeof(u32); i++) {
-		lo32 += le ? le32_to_cpu((__le32) buf[i]) : buf[i];
+		lo32 += le ? le32_to_cpu((__le32)buf[i]) : buf[i];
 		hi32 += lo32;
 	}
 
diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
index 37ea4fd89d3f..2c780c5352dc 100644
--- a/drivers/nvdimm/label.c
+++ b/drivers/nvdimm/label.c
@@ -275,8 +275,8 @@ static int to_slot(struct nvdimm_drvdata *ndd,
 {
 	unsigned long label, base;
 
-	label = (unsigned long) nd_label;
-	base = (unsigned long) nd_label_base(ndd);
+	label = (unsigned long)nd_label;
+	base = (unsigned long)nd_label_base(ndd);
 
 	return (label - base) / sizeof_namespace_label(ndd);
 }
@@ -285,10 +285,10 @@ static struct nd_namespace_label *to_label(struct nvdimm_drvdata *ndd, int slot)
 {
 	unsigned long label, base;
 
-	base = (unsigned long) nd_label_base(ndd);
+	base = (unsigned long)nd_label_base(ndd);
 	label = base + sizeof_namespace_label(ndd) * slot;
 
-	return (struct nd_namespace_label *) label;
+	return (struct nd_namespace_label *)label;
 }
 
 #define for_each_clear_bit_le(bit, addr, size)				\
@@ -314,7 +314,7 @@ static bool preamble_index(struct nvdimm_drvdata *ndd, int idx,
 	if (nsindex == NULL)
 		return false;
 
-	*free = (unsigned long *) nsindex->free;
+	*free = (unsigned long *)nsindex->free;
 	*nslot = __le32_to_cpu(nsindex->nslot);
 	*nsindex_out = nsindex;
 
@@ -659,16 +659,16 @@ static int nd_label_write_index(struct nvdimm_drvdata *ndd, int index, u32 seq,
 	memset(&nsindex->flags, 0, 3);
 	nsindex->labelsize = sizeof_namespace_label(ndd) >> 8;
 	nsindex->seq = __cpu_to_le32(seq);
-	offset = (unsigned long) nsindex
-		- (unsigned long) to_namespace_index(ndd, 0);
+	offset = (unsigned long)nsindex
+		- (unsigned long)to_namespace_index(ndd, 0);
 	nsindex->myoff = __cpu_to_le64(offset);
 	nsindex->mysize = __cpu_to_le64(sizeof_namespace_index(ndd));
-	offset = (unsigned long) to_namespace_index(ndd,
+	offset = (unsigned long)to_namespace_index(ndd,
 						    nd_label_next_nsindex(index))
-		- (unsigned long) to_namespace_index(ndd, 0);
+		- (unsigned long)to_namespace_index(ndd, 0);
 	nsindex->otheroff = __cpu_to_le64(offset);
-	offset = (unsigned long) nd_label_base(ndd)
-		- (unsigned long) to_namespace_index(ndd, 0);
+	offset = (unsigned long)nd_label_base(ndd)
+		- (unsigned long)to_namespace_index(ndd, 0);
 	nsindex->labeloff = __cpu_to_le64(offset);
 	nsindex->nslot = __cpu_to_le32(nslot);
 	nsindex->major = __cpu_to_le16(1);
@@ -678,7 +678,7 @@ static int nd_label_write_index(struct nvdimm_drvdata *ndd, int index, u32 seq,
 		nsindex->minor = __cpu_to_le16(2);
 	nsindex->checksum = __cpu_to_le64(0);
 	if (flags & ND_NSINDEX_INIT) {
-		unsigned long *free = (unsigned long *) nsindex->free;
+		unsigned long *free = (unsigned long *)nsindex->free;
 		u32 nfree = ALIGN(nslot, BITS_PER_LONG);
 		int last_bits, i;
 
@@ -709,8 +709,8 @@ static int nd_label_write_index(struct nvdimm_drvdata *ndd, int index, u32 seq,
 static unsigned long nd_label_offset(struct nvdimm_drvdata *ndd,
 				     struct nd_namespace_label *nd_label)
 {
-	return (unsigned long) nd_label
-		- (unsigned long) to_namespace_index(ndd, 0);
+	return (unsigned long)nd_label
+		- (unsigned long)to_namespace_index(ndd, 0);
 }
 
 enum nvdimm_claim_class to_nvdimm_cclass(guid_t *guid)
diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index df2a82179622..2bf4b6344926 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -824,8 +824,8 @@ int __reserve_free_pmem(struct device *dev, void *data)
 		rem = scan_allocate(nd_region, nd_mapping, &label_id, n);
 		dev_WARN_ONCE(&nd_region->dev, rem,
 			      "pmem reserve underrun: %#llx of %#llx bytes\n",
-			      (unsigned long long) n - rem,
-			      (unsigned long long) n);
+			      (unsigned long long)n - rem,
+			      (unsigned long long)n);
 		return rem ? -ENXIO : 0;
 	}
 
@@ -905,8 +905,8 @@ static int grow_dpa_allocation(struct nd_region *nd_region,
 
 		dev_WARN_ONCE(&nd_region->dev, rem,
 			      "allocation underrun: %#llx of %#llx bytes\n",
-			      (unsigned long long) n - rem,
-			      (unsigned long long) n);
+			      (unsigned long long)n - rem,
+			      (unsigned long long)n);
 		if (rem)
 			return -ENXIO;
 
@@ -1245,7 +1245,7 @@ static int namespace_update_uuid(struct nd_region *nd_region,
 
 		for_each_dpa_resource(ndd, res)
 			if (strcmp(res->name, old_label_id.id) == 0)
-				sprintf((void *) res->name, "%s",
+				sprintf((void *)res->name, "%s",
 					new_label_id.id);
 
 		mutex_lock(&nd_mapping->lock);
@@ -1328,7 +1328,7 @@ static ssize_t resource_show(struct device *dev,
 	/* no address to convey if the namespace has no allocation */
 	if (resource_size(res) == 0)
 		return -ENXIO;
-	return sprintf(buf, "%#llx\n", (unsigned long long) res->start);
+	return sprintf(buf, "%#llx\n", (unsigned long long)res->start);
 }
 static DEVICE_ATTR_RO(resource);
 
@@ -2000,9 +2000,9 @@ static struct device *create_namespace_pmem(struct nd_region *nd_region,
 		if (__le16_to_cpu(label0->position) != 0)
 			continue;
 		WARN_ON(nspm->alt_name || nspm->uuid);
-		nspm->alt_name = kmemdup((void __force *) label0->name,
+		nspm->alt_name = kmemdup((void __force *)label0->name,
 					 NSLABEL_NAME_LEN, GFP_KERNEL);
-		nspm->uuid = kmemdup((void __force *) label0->uuid,
+		nspm->uuid = kmemdup((void __force *)label0->uuid,
 				     NSLABEL_UUID_LEN, GFP_KERNEL);
 		nspm->lbasize = __le64_to_cpu(label0->lbasize);
 		ndd = to_ndd(nd_mapping);
@@ -2049,7 +2049,7 @@ struct resource *nsblk_add_resource(struct nd_region *nd_region,
 		       GFP_KERNEL);
 	if (!res)
 		return NULL;
-	nsblk->res = (struct resource **) res;
+	nsblk->res = (struct resource **)res;
 	for_each_dpa_resource(ndd, res)
 		if (strcmp(res->name, label_id.id) == 0 &&
 		    res->start == start) {
@@ -2277,8 +2277,8 @@ static struct device *create_namespace_blk(struct nd_region *nd_region,
 
 static int cmp_dpa(const void *a, const void *b)
 {
-	const struct device *dev_a = *(const struct device **) a;
-	const struct device *dev_b = *(const struct device **) b;
+	const struct device *dev_a = *(const struct device **)a;
+	const struct device *dev_b = *(const struct device **)b;
 	struct nd_namespace_blk *nsblk_a, *nsblk_b;
 	struct nd_namespace_pmem *nspm_a, *nspm_b;
 
diff --git a/drivers/nvdimm/nd-core.h b/drivers/nvdimm/nd-core.h
index 60525ff1f19f..b9163fff27b0 100644
--- a/drivers/nvdimm/nd-core.h
+++ b/drivers/nvdimm/nd-core.h
@@ -63,7 +63,7 @@ static inline unsigned long nvdimm_security_flags(
 	/* disabled, locked, unlocked, and overwrite are mutually exclusive */
 	dev_WARN_ONCE(&nvdimm->dev, hweight64(flags & state_flags) > 1,
 		      "reported invalid security state: %#llx\n",
-		      (unsigned long long) flags);
+		      (unsigned long long)flags);
 	return flags;
 }
 int nvdimm_security_freeze(struct nvdimm *nvdimm);
diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index 56ffd998d642..c10a4b94d44a 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -90,8 +90,8 @@ unsigned sizeof_namespace_label(struct nvdimm_drvdata *ndd);
 #define nd_dbg_dpa(r, d, res, fmt, arg...)				\
 	dev_dbg((r) ? &(r)->dev : (d)->dev, "%s: %.13s: %#llx @ %#llx " fmt, \
 		(r) ? dev_name((d)->dev) : "", res ? res->name : "null", \
-		(unsigned long long) (res ? resource_size(res) : 0),	\
-		(unsigned long long) (res ? res->start : 0), ##arg)
+		(unsigned long long)(res ? resource_size(res) : 0),	\
+		(unsigned long long)(res ? res->start : 0), ##arg)
 
 #define for_each_dpa_resource(ndd, res)				\
 	for (res = (ndd)->dpa.child; res; res = res->sibling)
diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index 5382b4f2f5ef..20a0cce9ee93 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -216,7 +216,7 @@ static ssize_t resource_show(struct device *dev,
 		u32 start_pad = __le32_to_cpu(pfn_sb->start_pad);
 		struct nd_namespace_io *nsio = to_nd_namespace_io(&ndns->dev);
 
-		rc = sprintf(buf, "%#llx\n", (unsigned long long) nsio->res.start
+		rc = sprintf(buf, "%#llx\n", (unsigned long long)nsio->res.start
 			     + start_pad + offset);
 	} else {
 		/* no address to convey if the pfn instance is disabled */
@@ -445,7 +445,7 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
 
 	checksum = le64_to_cpu(pfn_sb->checksum);
 	pfn_sb->checksum = 0;
-	if (checksum != nd_sb_checksum((struct nd_gen_sb *) pfn_sb))
+	if (checksum != nd_sb_checksum((struct nd_gen_sb *)pfn_sb))
 		return -ENODEV;
 	pfn_sb->checksum = cpu_to_le64(checksum);
 
@@ -728,7 +728,7 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
 	pfn_sb->version_minor = cpu_to_le16(3);
 	pfn_sb->end_trunc = cpu_to_le32(end_trunc);
 	pfn_sb->align = cpu_to_le32(nd_pfn->align);
-	checksum = nd_sb_checksum((struct nd_gen_sb *) pfn_sb);
+	checksum = nd_sb_checksum((struct nd_gen_sb *)pfn_sb);
 	pfn_sb->checksum = cpu_to_le64(checksum);
 
 	return nvdimm_write_bytes(ndns, SZ_4K, pfn_sb, sizeof(*pfn_sb), 0);
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index fa4500b4f2eb..dfe38d6b6607 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -85,7 +85,7 @@ static blk_status_t pmem_clear_poison(struct pmem_device *pmem,
 		hwpoison_clear(pmem, pmem->phys_addr + offset, cleared);
 		cleared /= 512;
 		dev_dbg(dev, "%#llx clear %ld sector%s\n",
-			(unsigned long long) sector, cleared,
+			(unsigned long long)sector, cleared,
 			cleared > 1 ? "s" : "");
 		badblocks_clear(&pmem->bb, sector, cleared);
 		if (pmem->bb_state)
diff --git a/drivers/nvdimm/region.c b/drivers/nvdimm/region.c
index 8486b6c26367..fdd67ff499c9 100644
--- a/drivers/nvdimm/region.c
+++ b/drivers/nvdimm/region.c
@@ -113,7 +113,7 @@ static int nd_region_remove(struct device *dev)
 
 static int child_notify(struct device *dev, void *data)
 {
-	nd_device_notify(dev, *(enum nvdimm_event *) data);
+	nd_device_notify(dev, *(enum nvdimm_event *)data);
 	return 0;
 }
 
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 0cff51370d3c..9265a2b0018c 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -44,7 +44,7 @@ static int nvdimm_map_flush(struct device *dev, struct nvdimm *nvdimm, int dimm,
 		}
 
 		if (j < i)
-			flush_page = (void __iomem *) ((unsigned long)
+			flush_page = (void __iomem *)((unsigned long)
 						       ndrd_get_flush_wpq(ndrd, dimm, j)
 						       & PAGE_MASK);
 		else
diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
index 8f1766c00c5f..ac23cd4480bd 100644
--- a/drivers/nvdimm/security.c
+++ b/drivers/nvdimm/security.c
@@ -473,13 +473,13 @@ void nvdimm_security_overwrite_query(struct work_struct *work)
 }
 
 #define OPS								\
-	C( OP_FREEZE,		"freeze",		1),		\
-		C( OP_DISABLE,		"disable",		2),	\
-		C( OP_UPDATE,		"update",		3),	\
-		C( OP_ERASE,		"erase",		2),	\
-		C( OP_OVERWRITE,	"overwrite",		2),	\
-		C( OP_MASTER_UPDATE,	"master_update",	3),	\
-		C( OP_MASTER_ERASE,	"master_erase",		2)
+	C(OP_FREEZE,		"freeze",		1),		\
+	C(OP_DISABLE,		"disable",		2),		\
+	C(OP_UPDATE,		"update",		3),		\
+	C(OP_ERASE,		"erase",		2),		\
+	C(OP_OVERWRITE,		"overwrite",		2),		\
+	C(OP_MASTER_UPDATE,	"master_update",	3),		\
+	C(OP_MASTER_ERASE,	"master_erase",		2)
 #undef C
 #define C(a, b, c) a
 enum nvdimmsec_op_ids { OPS };
@@ -498,8 +498,8 @@ ssize_t nvdimm_security_store(struct device *dev, const char *buf, size_t len)
 {
 	struct nvdimm *nvdimm = to_nvdimm(dev);
 	ssize_t rc;
-	char cmd[SEC_CMD_SIZE+1], keystr[KEY_ID_SIZE+1],
-		nkeystr[KEY_ID_SIZE+1];
+	char cmd[SEC_CMD_SIZE + 1], keystr[KEY_ID_SIZE + 1],
+		nkeystr[KEY_ID_SIZE + 1];
 	unsigned int key, newkey;
 	int i;
 
-- 
2.15.0

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

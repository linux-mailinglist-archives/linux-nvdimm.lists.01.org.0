Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA96B06F3
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Sep 2019 04:55:22 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 39928202C80AE;
	Wed, 11 Sep 2019 19:55:27 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=216.40.44.148;
 helo=smtprelay.hostedemail.com; envelope-from=joe@perches.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from smtprelay.hostedemail.com (smtprelay0148.hostedemail.com
 [216.40.44.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id DE128202C8099
 for <linux-nvdimm@lists.01.org>; Wed, 11 Sep 2019 19:55:25 -0700 (PDT)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay05.hostedemail.com (Postfix) with ESMTP id 206191802DF92;
 Thu, 12 Sep 2019 02:55:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2, 0, 0, , d41d8cd98f00b204, joe@perches.com, :::::::::::::::,
 RULES_HIT:41:69:327:355:371:372:379:541:800:960:966:968:973:988:989:1260:1345:1359:1437:1605:1730:1747:1777:1792:2194:2196:2198:2199:2200:2201:2393:2559:2562:2894:3138:3139:3140:3141:3142:3865:3866:3867:3868:3870:3871:4321:4385:4419:4605:5007:6117:6119:6261:7875:7903:7904:8603:10004:10848:10954:11026:11232:11473:11658:11914:12043:12048:12291:12296:12297:12438:12555:12683:12895:12986:13972:14394:21080:21433:21611:21627:21789:21796:21966:30003:30012:30029:30036:30054:30070:30080,
 0,
 RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,
 CacheIP:none, Bayesian:0.5, 0.5, 0.5, Netcheck:none, DomainCache:0,
 MSF:not bulk, SPF:fn, MSBL:0, DNSBL:neutral, Custom_rules:0:0:0, LFtime:24,
 LUA_SUMMARY:none
X-HE-Tag: watch80_858742d9e3f5a
X-Filterd-Recvd-Size: 20684
Received: from joe-laptop.perches.com (unknown [47.151.152.152])
 (Authenticated sender: joe@perches.com)
 by omf16.hostedemail.com (Postfix) with ESMTPA;
 Thu, 12 Sep 2019 02:55:17 +0000 (UTC)
From: Joe Perches <joe@perches.com>
To: Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Keith Busch <keith.busch@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 07/13] nvdimm: Use typical kernel brace styles
Date: Wed, 11 Sep 2019 19:54:37 -0700
Message-Id: <bb99cfbf8eadbc6316c0422128a0004997de7a11.1568256707.git.joe@perches.com>
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

Make the nvdimm code more like the rest of the kernel code to
improve readability.

Add balanced braces to multiple test blocks.
Remove else statements from blocks where the block above uses return.

e.g.:
	if (foo) {
		[code...];
		return FOO;
	} else if (bar) {
		[code...];
		return BAR;
	} else
		return BAZ;

becomes
	if (foo) {
		[code...];
		return FOO;
	}
	if (bar) {
		[code...];
		return BAR;
	}
	return BAZ;

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/nvdimm/badrange.c       |  3 +-
 drivers/nvdimm/blk.c            |  9 +++--
 drivers/nvdimm/btt.c            |  5 +--
 drivers/nvdimm/btt_devs.c       |  4 +--
 drivers/nvdimm/bus.c            | 10 +++---
 drivers/nvdimm/claim.c          |  7 ++--
 drivers/nvdimm/dax_devs.c       |  3 +-
 drivers/nvdimm/dimm_devs.c      | 13 ++++---
 drivers/nvdimm/label.c          | 13 +++----
 drivers/nvdimm/namespace_devs.c | 78 ++++++++++++++++++++++++++---------------
 drivers/nvdimm/pfn_devs.c       | 24 +++++++------
 drivers/nvdimm/pmem.c           |  8 ++---
 drivers/nvdimm/region_devs.c    | 10 +++---
 drivers/nvdimm/security.c       |  8 +++--
 14 files changed, 118 insertions(+), 77 deletions(-)

diff --git a/drivers/nvdimm/badrange.c b/drivers/nvdimm/badrange.c
index f2a742c6258a..681d99c59f52 100644
--- a/drivers/nvdimm/badrange.c
+++ b/drivers/nvdimm/badrange.c
@@ -206,8 +206,9 @@ static void __add_badblock_range(struct badblocks *bb, u64 ns_offset, u64 len)
 			remaining -= done;
 			s += done;
 		}
-	} else
+	} else {
 		set_badblock(bb, start_sector, num_sectors);
+	}
 }
 
 static void badblocks_populate(struct badrange *badrange,
diff --git a/drivers/nvdimm/blk.c b/drivers/nvdimm/blk.c
index 95acb48bfaed..db3973c7f506 100644
--- a/drivers/nvdimm/blk.c
+++ b/drivers/nvdimm/blk.c
@@ -301,13 +301,16 @@ static int nd_blk_probe(struct device *dev)
 	dev_set_drvdata(dev, nsblk);
 
 	ndns->rw_bytes = nsblk_rw_bytes;
+
 	if (is_nd_btt(dev))
 		return nvdimm_namespace_attach_btt(ndns);
-	else if (nd_btt_probe(dev, ndns) == 0) {
+
+	if (nd_btt_probe(dev, ndns) == 0) {
 		/* we'll come back as btt-blk */
 		return -ENXIO;
-	} else
-		return nsblk_attach_disk(nsblk);
+	}
+
+	return nsblk_attach_disk(nsblk);
 }
 
 static int nd_blk_remove(struct device *dev)
diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 0927cbdc5cc6..39851edc2cc5 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -702,9 +702,10 @@ static int log_set_indices(struct arena_info *arena)
 	 * Only allow the known permutations of log/padding indices,
 	 * i.e. (0, 1), and (0, 2)
 	 */
-	if ((log_index[0] == 0) && ((log_index[1] == 1) || (log_index[1] == 2)))
+	if ((log_index[0] == 0) &&
+	    ((log_index[1] == 1) || (log_index[1] == 2))) {
 		; /* known index possibilities */
-	else {
+	} else {
 		dev_err(to_dev(arena), "Found an unknown padding scheme\n");
 		return -ENXIO;
 	}
diff --git a/drivers/nvdimm/btt_devs.c b/drivers/nvdimm/btt_devs.c
index f6429842f1b6..9e0f17045e69 100644
--- a/drivers/nvdimm/btt_devs.c
+++ b/drivers/nvdimm/btt_devs.c
@@ -139,9 +139,9 @@ static ssize_t size_show(struct device *dev,
 	ssize_t rc;
 
 	nd_device_lock(dev);
-	if (dev->driver)
+	if (dev->driver) {
 		rc = sprintf(buf, "%llu\n", nd_btt->size);
-	else {
+	} else {
 		/* no size to convey if the btt instance is disabled */
 		rc = -ENXIO;
 	}
diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 5ffd61c9c4b7..620f07ac306c 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -857,9 +857,9 @@ u32 nd_cmd_out_size(struct nvdimm *nvdimm, int cmd,
 
 	if (nvdimm && cmd == ND_CMD_GET_CONFIG_DATA && idx == 1)
 		return in_field[1];
-	else if (nvdimm && cmd == ND_CMD_VENDOR && idx == 2)
+	if (nvdimm && cmd == ND_CMD_VENDOR && idx == 2)
 		return out_field[1];
-	else if (!nvdimm && cmd == ND_CMD_ARS_STATUS && idx == 2) {
+	if (!nvdimm && cmd == ND_CMD_ARS_STATUS && idx == 2) {
 		/*
 		 * Per table 9-276 ARS Data in ACPI 6.1, out_field[1] is
 		 * "Size of Output Buffer in bytes, including this
@@ -876,7 +876,8 @@ u32 nd_cmd_out_size(struct nvdimm *nvdimm, int cmd,
 		if (out_field[1] - 4 == remainder)
 			return remainder;
 		return out_field[1] - 8;
-	} else if (cmd == ND_CMD_CALL) {
+	}
+	if (cmd == ND_CMD_CALL) {
 		struct nd_cmd_pkg *pkg = (struct nd_cmd_pkg *)in_field;
 
 		return pkg->nd_size_out;
@@ -929,8 +930,9 @@ static int nd_pmem_forget_poison_check(struct device *dev, void *data)
 
 		if (!ndns)
 			return 0;
-	} else
+	} else {
 		ndns = to_ndns(dev);
+	}
 
 	nsio = to_nd_namespace_io(&ndns->dev);
 	pstart = nsio->res.start + offset;
diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
index ff66a3cc349c..3732925aadb8 100644
--- a/drivers/nvdimm/claim.c
+++ b/drivers/nvdimm/claim.c
@@ -149,9 +149,9 @@ ssize_t nd_namespace_store(struct device *dev,
 		return -ENOMEM;
 	strim(name);
 
-	if (strncmp(name, "namespace", 9) == 0 || strcmp(name, "") == 0)
+	if (strncmp(name, "namespace", 9) == 0 || strcmp(name, "") == 0) {
 		/* pass */;
-	else {
+	} else {
 		len = -EINVAL;
 		goto out;
 	}
@@ -288,8 +288,9 @@ static int nsio_rw_bytes(struct nd_namespace_common *ndns,
 				badblocks_clear(&nsio->bb, sector, cleared);
 			}
 			arch_invalidate_pmem(nsio->addr + offset, size);
-		} else
+		} else {
 			rc = -EIO;
+		}
 	}
 
 	memcpy_flushcache(nsio->addr + offset, buf, size);
diff --git a/drivers/nvdimm/dax_devs.c b/drivers/nvdimm/dax_devs.c
index 6d22b0f83b3b..46230eb35b90 100644
--- a/drivers/nvdimm/dax_devs.c
+++ b/drivers/nvdimm/dax_devs.c
@@ -125,8 +125,9 @@ int nd_dax_probe(struct device *dev, struct nd_namespace_common *ndns)
 	if (rc < 0) {
 		nd_detach_ndns(dax_dev, &nd_pfn->ndns);
 		put_device(dax_dev);
-	} else
+	} else {
 		__nd_device_register(dax_dev);
+	}
 
 	return rc;
 }
diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index 873df96795b0..4df85dd72682 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -361,8 +361,9 @@ static ssize_t available_slots_show(struct device *dev,
 	if (nfree - 1 > nfree) {
 		dev_WARN_ONCE(dev, 1, "we ate our last label?\n");
 		nfree = 0;
-	} else
+	} else {
 		nfree--;
+	}
 	rc = sprintf(buf, "%d\n", nfree);
 	nvdimm_bus_unlock(dev);
 	return rc;
@@ -728,14 +729,15 @@ resource_size_t nd_pmem_available_dpa(struct nd_region *nd_region,
 	blk_start = max(map_start, map_end + 1 - *overlap);
 	for_each_dpa_resource(ndd, res) {
 		if (res->start >= map_start && res->start < map_end) {
-			if (strncmp(res->name, "blk", 3) == 0)
+			if (strncmp(res->name, "blk", 3) == 0) {
 				blk_start = min(blk_start,
 						max(map_start, res->start));
-			else if (res->end > map_end) {
+			} else if (res->end > map_end) {
 				reason = "misaligned to iset";
 				goto err;
-			} else
+			} else {
 				busy += resource_size(res);
+			}
 		} else if (res->end >= map_start && res->end <= map_end) {
 			if (strncmp(res->name, "blk", 3) == 0) {
 				/*
@@ -744,8 +746,9 @@ resource_size_t nd_pmem_available_dpa(struct nd_region *nd_region,
 				 * be used for BLK.
 				 */
 				blk_start = map_start;
-			} else
+			} else {
 				busy += resource_size(res);
+			}
 		} else if (map_start > res->start && map_start < res->end) {
 			/* total eclipse of the mapping */
 			busy += nd_mapping->size;
diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
index bf58357927c4..e4632dbebead 100644
--- a/drivers/nvdimm/label.c
+++ b/drivers/nvdimm/label.c
@@ -734,20 +734,21 @@ static const guid_t *to_abstraction_guid(enum nvdimm_claim_class claim_class,
 {
 	if (claim_class == NVDIMM_CCLASS_BTT)
 		return &nvdimm_btt_guid;
-	else if (claim_class == NVDIMM_CCLASS_BTT2)
+	if (claim_class == NVDIMM_CCLASS_BTT2)
 		return &nvdimm_btt2_guid;
-	else if (claim_class == NVDIMM_CCLASS_PFN)
+	if (claim_class == NVDIMM_CCLASS_PFN)
 		return &nvdimm_pfn_guid;
-	else if (claim_class == NVDIMM_CCLASS_DAX)
+	if (claim_class == NVDIMM_CCLASS_DAX)
 		return &nvdimm_dax_guid;
-	else if (claim_class == NVDIMM_CCLASS_UNKNOWN) {
+	if (claim_class == NVDIMM_CCLASS_UNKNOWN) {
 		/*
 		 * If we're modifying a namespace for which we don't
 		 * know the claim_class, don't touch the existing guid.
 		 */
 		return target;
-	} else
-		return &guid_null;
+	}
+
+	return &guid_null;
 }
 
 static void reap_victim(struct nd_mapping *nd_mapping,
diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 600df84b4d2d..70e1d752c12c 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -228,12 +228,14 @@ const u8 *nd_dev_to_uuid(struct device *dev)
 		struct nd_namespace_pmem *nspm = to_nd_namespace_pmem(dev);
 
 		return nspm->uuid;
-	} else if (is_namespace_blk(dev)) {
+	}
+	if (is_namespace_blk(dev)) {
 		struct nd_namespace_blk *nsblk = to_nd_namespace_blk(dev);
 
 		return nsblk->uuid;
-	} else
-		return null_uuid;
+	}
+
+	return null_uuid;
 }
 EXPORT_SYMBOL(nd_dev_to_uuid);
 
@@ -260,8 +262,9 @@ static ssize_t __alt_name_store(struct device *dev, const char *buf,
 		struct nd_namespace_blk *nsblk = to_nd_namespace_blk(dev);
 
 		ns_altname = &nsblk->alt_name;
-	} else
+	} else {
 		return -ENXIO;
+	}
 
 	if (dev->driver || to_ndns(dev)->claim)
 		return -EBUSY;
@@ -389,7 +392,8 @@ static int nd_namespace_label_update(struct nd_region *nd_region,
 			return 0;
 
 		return nd_pmem_namespace_label_update(nd_region, nspm, size);
-	} else if (is_namespace_blk(dev)) {
+	}
+	if (is_namespace_blk(dev)) {
 		struct nd_namespace_blk *nsblk = to_nd_namespace_blk(dev);
 		resource_size_t size = nd_namespace_blk_size(nsblk);
 
@@ -399,8 +403,9 @@ static int nd_namespace_label_update(struct nd_region *nd_region,
 			return 0;
 
 		return nd_blk_namespace_label_update(nd_region, nsblk, size);
-	} else
-		return -ENXIO;
+	}
+
+	return -ENXIO;
 }
 
 static ssize_t alt_name_store(struct device *dev,
@@ -435,8 +440,9 @@ static ssize_t alt_name_show(struct device *dev,
 		struct nd_namespace_blk *nsblk = to_nd_namespace_blk(dev);
 
 		ns_altname = nsblk->alt_name;
-	} else
+	} else {
 		return -ENXIO;
+	}
 
 	return sprintf(buf, "%s\n", ns_altname ? ns_altname : "");
 }
@@ -685,8 +691,9 @@ static resource_size_t scan_allocate(struct nd_region *nd_region,
 				rc = adjust_resource(res, res->start - allocate,
 						     resource_size(res) + allocate);
 				action = "cur grow up";
-			} else
+			} else {
 				action = "allocate";
+			}
 			break;
 		case ALLOC_MID:
 			if (strcmp(next->name, label_id->id) == 0) {
@@ -698,8 +705,9 @@ static resource_size_t scan_allocate(struct nd_region *nd_region,
 				action = "next grow up";
 			} else if (strcmp(res->name, label_id->id) == 0) {
 				action = "grow down";
-			} else
+			} else {
 				action = "allocate";
+			}
 			break;
 		case ALLOC_AFTER:
 			if (strcmp(res->name, label_id->id) == 0)
@@ -747,8 +755,9 @@ static resource_size_t scan_allocate(struct nd_region *nd_region,
 			 * need to check this same resource again
 			 */
 			goto retry;
-		} else
+		} else {
 			return 0;
+		}
 	}
 
 	/*
@@ -1115,14 +1124,18 @@ resource_size_t __nvdimm_namespace_capacity(struct nd_namespace_common *ndns)
 		struct nd_namespace_pmem *nspm = to_nd_namespace_pmem(dev);
 
 		return resource_size(&nspm->nsio.res);
-	} else if (is_namespace_blk(dev)) {
+	}
+
+	if (is_namespace_blk(dev))
 		return nd_namespace_blk_size(to_nd_namespace_blk(dev));
-	} else if (is_namespace_io(dev)) {
+
+	if (is_namespace_io(dev)) {
 		struct nd_namespace_io *nsio = to_nd_namespace_io(dev);
 
 		return resource_size(&nsio->res);
-	} else
-		WARN_ONCE(1, "unknown namespace type\n");
+	}
+
+	WARN_ONCE(1, "unknown namespace type\n");
 	return 0;
 }
 
@@ -1172,12 +1185,14 @@ static u8 *namespace_to_uuid(struct device *dev)
 		struct nd_namespace_pmem *nspm = to_nd_namespace_pmem(dev);
 
 		return nspm->uuid;
-	} else if (is_namespace_blk(dev)) {
+	}
+	if (is_namespace_blk(dev)) {
 		struct nd_namespace_blk *nsblk = to_nd_namespace_blk(dev);
 
 		return nsblk->uuid;
-	} else
-		return ERR_PTR(-ENXIO);
+	}
+
+	return ERR_PTR(-ENXIO);
 }
 
 static ssize_t uuid_show(struct device *dev,
@@ -1282,8 +1297,9 @@ static ssize_t uuid_store(struct device *dev,
 		struct nd_namespace_blk *nsblk = to_nd_namespace_blk(dev);
 
 		ns_uuid = &nsblk->uuid;
-	} else
+	} else {
 		return -ENXIO;
+	}
 
 	nd_device_lock(dev);
 	nvdimm_bus_lock(dev);
@@ -1320,8 +1336,9 @@ static ssize_t resource_show(struct device *dev,
 		struct nd_namespace_io *nsio = to_nd_namespace_io(dev);
 
 		res = &nsio->res;
-	} else
+	} else {
 		return -ENXIO;
+	}
 
 	/* no address to convey if the namespace has no allocation */
 	if (resource_size(res) == 0)
@@ -1372,8 +1389,9 @@ static ssize_t sector_size_store(struct device *dev,
 
 		lbasize = &nspm->lbasize;
 		supported = pmem_lbasize_supported;
-	} else
+	} else {
 		return -ENXIO;
+	}
 
 	nd_device_lock(dev);
 	nvdimm_bus_lock(dev);
@@ -1454,9 +1472,9 @@ static int btt_claim_class(struct device *dev)
 		}
 
 		nsindex = to_namespace_index(ndd, ndd->ns_current);
-		if (nsindex == NULL)
+		if (nsindex == NULL) {
 			loop_bitmask |= 1;
-		else {
+		} else {
 			/* check whether existing labels are v1.1 or v1.2 */
 			if (__le16_to_cpu(nsindex->major) == 1 &&
 			    __le16_to_cpu(nsindex->minor) == 1)
@@ -1883,9 +1901,9 @@ static int select_pmem_id(struct nd_region *nd_region, u8 *pmem_id)
 		pmem_start = __le64_to_cpu(nd_label->dpa);
 		pmem_end = pmem_start + __le64_to_cpu(nd_label->rawsize);
 		if (pmem_start >= hw_start && pmem_start < hw_end &&
-		    pmem_end <= hw_end && pmem_end > hw_start)
+		    pmem_end <= hw_end && pmem_end > hw_start) {
 			/* pass */;
-		else {
+		} else {
 			dev_dbg(&nd_region->dev, "%s invalid label for %pUb\n",
 				dev_name(ndd->dev), nd_label->uuid);
 			return -EINVAL;
@@ -2335,9 +2353,9 @@ static struct device **scan_labels(struct nd_region *nd_region)
 		kfree(devs);
 		devs = __devs;
 
-		if (is_nd_blk(&nd_region->dev))
+		if (is_nd_blk(&nd_region->dev)) {
 			dev = create_namespace_blk(nd_region, nd_label, count);
-		else {
+		} else {
 			struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
 			struct nd_namespace_index *nsindex;
 
@@ -2356,8 +2374,9 @@ static struct device **scan_labels(struct nd_region *nd_region)
 			default:
 				goto err;
 			}
-		} else
+		} else {
 			devs[count++] = dev;
+		}
 	}
 
 	dev_dbg(&nd_region->dev, "discovered %d %s namespace%s\n",
@@ -2576,8 +2595,9 @@ int nd_region_register_namespaces(struct nd_region *nd_region, int *err)
 			id = ida_simple_get(&nd_region->ns_ida, 0, 0,
 					    GFP_KERNEL);
 			nspm->id = id;
-		} else
+		} else {
 			id = i;
+		}
 
 		if (id < 0)
 			break;
diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index 20a0cce9ee93..7226d6d95899 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -69,22 +69,23 @@ static ssize_t mode_store(struct device *dev,
 
 	nd_device_lock(dev);
 	nvdimm_bus_lock(dev);
-	if (dev->driver)
+	if (dev->driver) {
 		rc = -EBUSY;
-	else {
+	} else {
 		size_t n = len - 1;
 
 		if (strncmp(buf, "pmem\n", n) == 0 ||
 		    strncmp(buf, "pmem", n) == 0) {
 			nd_pfn->mode = PFN_MODE_PMEM;
 		} else if (strncmp(buf, "ram\n", n) == 0 ||
-			   strncmp(buf, "ram", n) == 0)
+			   strncmp(buf, "ram", n) == 0) {
 			nd_pfn->mode = PFN_MODE_RAM;
-		else if (strncmp(buf, "none\n", n) == 0 ||
-			 strncmp(buf, "none", n) == 0)
+		} else if (strncmp(buf, "none\n", n) == 0 ||
+			   strncmp(buf, "none", n) == 0) {
 			nd_pfn->mode = PFN_MODE_NONE;
-		else
+		} else {
 			rc = -EINVAL;
+		}
 	}
 	dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
 		buf[len - 1] == '\n' ? "" : "\n");
@@ -575,8 +576,9 @@ int nd_pfn_probe(struct device *dev, struct nd_namespace_common *ndns)
 	if (rc < 0) {
 		nd_detach_ndns(pfn_dev, &nd_pfn->ndns);
 		put_device(pfn_dev);
-	} else
+	} else {
 		__nd_device_register(pfn_dev);
+	}
 
 	return rc;
 }
@@ -643,8 +645,9 @@ static int __nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap)
 		altmap->free = PHYS_PFN(offset - reserve);
 		altmap->alloc = 0;
 		pgmap->flags |= PGMAP_ALTMAP_VALID;
-	} else
+	} else {
 		return -ENXIO;
+	}
 
 	return 0;
 }
@@ -706,10 +709,11 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
 		 * PMD_SIZE for most architectures.
 		 */
 		offset = ALIGN(start + SZ_8K + 64 * npfns, align) - start;
-	} else if (nd_pfn->mode == PFN_MODE_RAM)
+	} else if (nd_pfn->mode == PFN_MODE_RAM) {
 		offset = ALIGN(start + SZ_8K, align) - start;
-	else
+	} else {
 		return -ENXIO;
+	}
 
 	if (offset >= size) {
 		dev_err(&nd_pfn->dev, "%s unable to satisfy requested alignment\n",
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index dfe38d6b6607..64e7429edcc2 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -150,9 +150,9 @@ static blk_status_t pmem_do_bvec(struct pmem_device *pmem, struct page *page,
 		bad_pmem = true;
 
 	if (!op_is_write(op)) {
-		if (unlikely(bad_pmem))
+		if (unlikely(bad_pmem)) {
 			rc = BLK_STS_IOERR;
-		else {
+		} else {
 			rc = read_pmem(page, off, pmem_addr, len);
 			flush_dcache_page(page);
 		}
@@ -519,9 +519,9 @@ static int nd_pmem_remove(struct device *dev)
 {
 	struct pmem_device *pmem = dev_get_drvdata(dev);
 
-	if (is_nd_btt(dev))
+	if (is_nd_btt(dev)) {
 		nvdimm_namespace_detach_btt(to_nd_btt(dev));
-	else {
+	} else {
 		/*
 		 * Note, this assumes nd_device_lock() context to not
 		 * race nd_pmem_notify()
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 76b08b64b0b1..16dfdbdbf1c8 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -381,8 +381,9 @@ resource_size_t nd_region_available_dpa(struct nd_region *nd_region)
 				blk_max_overlap = overlap;
 				goto retry;
 			}
-		} else if (is_nd_blk(&nd_region->dev))
+		} else if (is_nd_blk(&nd_region->dev)) {
 			available += nd_blk_available_dpa(nd_region);
+		}
 	}
 
 	return available;
@@ -956,8 +957,9 @@ unsigned int nd_region_acquire_lane(struct nd_region *nd_region)
 		ndl_lock = per_cpu_ptr(nd_region->lane, lane);
 		if (ndl_count->count++ == 0)
 			spin_lock(&ndl_lock->lock);
-	} else
+	} else {
 		lane = cpu;
+	}
 
 	return lane;
 }
@@ -1132,9 +1134,9 @@ int nvdimm_flush(struct nd_region *nd_region, struct bio *bio)
 {
 	int rc = 0;
 
-	if (!nd_region->flush)
+	if (!nd_region->flush) {
 		rc = generic_nvdimm_flush(nd_region);
-	else {
+	} else {
 		if (nd_region->flush(nd_region, bio))
 			rc = -EIO;
 	}
diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
index 13bc5d54f0b6..693416001d17 100644
--- a/drivers/nvdimm/security.c
+++ b/drivers/nvdimm/security.c
@@ -194,8 +194,9 @@ static int __nvdimm_security_unlock(struct nvdimm *nvdimm)
 			return 0;
 
 		return nvdimm_key_revalidate(nvdimm);
-	} else
-		data = nvdimm_get_key_payload(nvdimm, &key);
+	}
+
+	data = nvdimm_get_key_payload(nvdimm, &key);
 
 	rc = nvdimm->sec.ops->unlock(nvdimm, data);
 	dev_dbg(dev, "key: %d unlock: %s\n", key_serial(key),
@@ -544,8 +545,9 @@ ssize_t nvdimm_security_store(struct device *dev, const char *buf, size_t len)
 			return -EBUSY;
 		}
 		rc = security_overwrite(nvdimm, key);
-	} else
+	} else {
 		return -EINVAL;
+	}
 
 	if (rc == 0)
 		rc = len;
-- 
2.15.0

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

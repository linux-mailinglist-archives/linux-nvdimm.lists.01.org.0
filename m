Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE3AB06E8
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Sep 2019 04:55:06 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BB84A202C809C;
	Wed, 11 Sep 2019 19:55:10 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=216.40.44.71;
 helo=smtprelay.hostedemail.com; envelope-from=joe@perches.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from smtprelay.hostedemail.com (smtprelay0071.hostedemail.com
 [216.40.44.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 80E5E202C808E
 for <linux-nvdimm@lists.01.org>; Wed, 11 Sep 2019 19:55:09 -0700 (PDT)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay06.hostedemail.com (Postfix) with ESMTP id AC23C18225DF8;
 Thu, 12 Sep 2019 02:55:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2, 0, 0, , d41d8cd98f00b204, joe@perches.com, :::::::::::::::,
 RULES_HIT:4:41:69:355:371:372:379:541:800:960:966:973:988:989:1260:1345:1359:1437:1461:1605:1730:1747:1777:1792:2194:2196:2199:2200:2393:2559:2562:2689:2741:2894:2898:3138:3139:3140:3141:3142:3865:3866:3867:3870:3871:3874:4250:4321:4385:4605:5007:6117:6119:6261:7903:7904:8568:8603:8660:9010:10004:10848:11026:11473:11658:11914:12043:12048:12291:12296:12297:12438:12555:12683:12895:12986:13148:13230:14096:14394:21080:21324:21611:21627:21789:21796:21966:30029:30036:30045:30054:30070:30075:30080,
 0,
 RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,
 CacheIP:none, Bayesian:0.5, 0.5, 0.5, Netcheck:none, DomainCache:0,
 MSF:not bulk, SPF:fn, MSBL:0, DNSBL:neutral, Custom_rules:0:0:0, LFtime:41,
 LUA_SUMMARY:none
X-HE-Tag: frame04_82d15126e1a3c
X-Filterd-Recvd-Size: 18662
Received: from joe-laptop.perches.com (unknown [47.151.152.152])
 (Authenticated sender: joe@perches.com)
 by omf16.hostedemail.com (Postfix) with ESMTPA;
 Thu, 12 Sep 2019 02:54:58 +0000 (UTC)
From: Joe Perches <joe@perches.com>
To: Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Keith Busch <keith.busch@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 02/13] nvdimm: Move logical continuations to previous line
Date: Wed, 11 Sep 2019 19:54:32 -0700
Message-Id: <d7bffd1c8fc3639880e25ede04a241a87cd036f9.1568256706.git.joe@perches.com>
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

Make the logical continuation style more like the rest of the kernel.

No change in object files.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/nvdimm/btt.c            |  9 +++++----
 drivers/nvdimm/bus.c            |  4 ++--
 drivers/nvdimm/claim.c          |  4 ++--
 drivers/nvdimm/dimm_devs.c      | 23 ++++++++++++-----------
 drivers/nvdimm/label.c          |  8 ++++----
 drivers/nvdimm/namespace_devs.c | 40 +++++++++++++++++++++-------------------
 drivers/nvdimm/pfn_devs.c       | 17 +++++++++--------
 drivers/nvdimm/pmem.c           |  5 +++--
 drivers/nvdimm/region.c         |  6 +++---
 drivers/nvdimm/region_devs.c    | 23 ++++++++++++-----------
 drivers/nvdimm/security.c       | 34 ++++++++++++++++++++--------------
 11 files changed, 93 insertions(+), 80 deletions(-)

diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index d3e187ac43eb..6362d96dfc16 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -603,8 +603,9 @@ static int btt_freelist_init(struct arena_info *arena)
 
 static bool ent_is_padding(struct log_entry *ent)
 {
-	return (ent->lba == 0) && (ent->old_map == 0) && (ent->new_map == 0)
-		&& (ent->seq == 0);
+	return (ent->lba == 0) &&
+		(ent->old_map == 0) && (ent->new_map == 0) &&
+		(ent->seq == 0);
 }
 
 /*
@@ -1337,8 +1338,8 @@ static int btt_write_pg(struct btt *btt, struct bio_integrity_payload *bip,
 		if (btt_is_badblock(btt, arena, arena->freelist[lane].block))
 			arena->freelist[lane].has_err = 1;
 
-		if (mutex_is_locked(&arena->err_lock)
-		    || arena->freelist[lane].has_err) {
+		if (mutex_is_locked(&arena->err_lock) ||
+		    arena->freelist[lane].has_err) {
 			nd_region_release_lane(btt->nd_region, lane);
 
 			ret = arena_clear_freelist_error(arena, lane);
diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 83b6fcbb252d..6d4d4c72ac92 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -189,8 +189,8 @@ static int nvdimm_clear_badblocks_region(struct device *dev, void *data)
 	ndr_end = nd_region->ndr_start + nd_region->ndr_size - 1;
 
 	/* make sure we are in the region */
-	if (ctx->phys < nd_region->ndr_start
-	    || (ctx->phys + ctx->cleared) > ndr_end)
+	if (ctx->phys < nd_region->ndr_start ||
+	    (ctx->phys + ctx->cleared) > ndr_end)
 		return 0;
 
 	sector = (ctx->phys - nd_region->ndr_start) / 512;
diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
index 62f3afaa7d27..ff66a3cc349c 100644
--- a/drivers/nvdimm/claim.c
+++ b/drivers/nvdimm/claim.c
@@ -274,8 +274,8 @@ static int nsio_rw_bytes(struct nd_namespace_common *ndns,
 	}
 
 	if (unlikely(is_bad_pmem(&nsio->bb, sector, sz_align))) {
-		if (IS_ALIGNED(offset, 512) && IS_ALIGNED(size, 512)
-		    && !(flags & NVDIMM_IO_ATOMIC)) {
+		if (IS_ALIGNED(offset, 512) && IS_ALIGNED(size, 512) &&
+		    !(flags & NVDIMM_IO_ATOMIC)) {
 			long cleared;
 
 			might_sleep();
diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index 52b00078939b..cb5598b3c389 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -437,10 +437,11 @@ static umode_t nvdimm_visible(struct kobject *kobj, struct attribute *a, int n)
 
 	if (a == &dev_attr_security.attr) {
 		/* Are there any state mutation ops (make writable)? */
-		if (nvdimm->sec.ops->freeze || nvdimm->sec.ops->disable
-		    || nvdimm->sec.ops->change_key
-		    || nvdimm->sec.ops->erase
-		    || nvdimm->sec.ops->overwrite)
+		if (nvdimm->sec.ops->freeze ||
+		    nvdimm->sec.ops->disable ||
+		    nvdimm->sec.ops->change_key ||
+		    nvdimm->sec.ops->erase ||
+		    nvdimm->sec.ops->overwrite)
 			return a->mode;
 		return 0444;
 	}
@@ -516,8 +517,9 @@ int nvdimm_security_setup_events(struct device *dev)
 {
 	struct nvdimm *nvdimm = to_nvdimm(dev);
 
-	if (!nvdimm->sec.flags || !nvdimm->sec.ops
-	    || !nvdimm->sec.ops->overwrite)
+	if (!nvdimm->sec.flags ||
+	    !nvdimm->sec.ops ||
+	    !nvdimm->sec.ops->overwrite)
 		return 0;
 	nvdimm->sec.overwrite_state = sysfs_get_dirent(dev->kobj.sd, "security");
 	if (!nvdimm->sec.overwrite_state)
@@ -589,8 +591,8 @@ int alias_dpa_busy(struct device *dev, void *data)
 	 * (i.e. BLK is allocated after all aliased PMEM).
 	 */
 	if (info->res) {
-		if (info->res->start >= nd_mapping->start
-		    && info->res->start < map_end)
+		if (info->res->start >= nd_mapping->start &&
+		    info->res->start < map_end)
 			/* pass */;
 		else
 			return 0;
@@ -604,9 +606,8 @@ int alias_dpa_busy(struct device *dev, void *data)
 	for_each_dpa_resource(ndd, res) {
 		if (strncmp(res->name, "pmem", 4) != 0)
 			continue;
-		if ((res->start >= blk_start && res->start < map_end)
-		    || (res->end >= blk_start
-			&& res->end <= map_end)) {
+		if ((res->start >= blk_start && res->start < map_end) ||
+		    (res->end >= blk_start && res->end <= map_end)) {
 			new = max(blk_start, min(map_end + 1, res->end + 1));
 			if (new != blk_start) {
 				blk_start = new;
diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
index ebfad5183b23..37ea4fd89d3f 100644
--- a/drivers/nvdimm/label.c
+++ b/drivers/nvdimm/label.c
@@ -187,8 +187,8 @@ static int __nd_label_validate(struct nvdimm_drvdata *ndd)
 		}
 
 		size = __le64_to_cpu(nsindex[i]->mysize);
-		if (size > sizeof_namespace_index(ndd)
-		    || size < sizeof(struct nd_namespace_index)) {
+		if (size > sizeof_namespace_index(ndd) ||
+		    size < sizeof(struct nd_namespace_index)) {
 			dev_dbg(dev, "nsindex%d mysize: %#llx invalid\n", i, size);
 			continue;
 		}
@@ -839,8 +839,8 @@ static int __pmem_label_update(struct nd_region *nd_region,
 	list_for_each_entry(label_ent, &nd_mapping->labels, list) {
 		if (!label_ent->label)
 			continue;
-		if (test_and_clear_bit(ND_LABEL_REAP, &label_ent->flags)
-		    || memcmp(nspm->uuid, label_ent->label->uuid,
+		if (test_and_clear_bit(ND_LABEL_REAP, &label_ent->flags) ||
+		    memcmp(nspm->uuid, label_ent->label->uuid,
 			      NSLABEL_UUID_LEN) == 0)
 			reap_victim(nd_mapping, label_ent);
 	}
diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 5ffa137dc963..df2a82179622 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -598,8 +598,8 @@ static void space_valid(struct nd_region *nd_region, struct nvdimm_drvdata *ndd,
 		return;
 
 	/* allocation needs to be contiguous with the existing namespace */
-	if (valid->start == exist->end + 1
-	    || valid->end == exist->start - 1)
+	if (valid->start == exist->end + 1 ||
+	    valid->end == exist->start - 1)
 		return;
 
 invalid:
@@ -777,9 +777,10 @@ static int merge_dpa(struct nd_region *nd_region,
 		struct resource *next = res->sibling;
 		resource_size_t end = res->start + resource_size(res);
 
-		if (!next || strcmp(res->name, label_id->id) != 0
-		    || strcmp(next->name, label_id->id) != 0
-		    || end != next->start)
+		if (!next ||
+		    strcmp(res->name, label_id->id) != 0 ||
+		    strcmp(next->name, label_id->id) != 0 ||
+		    end != next->start)
 			continue;
 		end += resource_size(next);
 		nvdimm_free_dpa(ndd, next);
@@ -1459,8 +1460,8 @@ static int btt_claim_class(struct device *dev)
 			loop_bitmask |= 1;
 		else {
 			/* check whether existing labels are v1.1 or v1.2 */
-			if (__le16_to_cpu(nsindex->major) == 1
-			    && __le16_to_cpu(nsindex->minor) == 1)
+			if (__le16_to_cpu(nsindex->major) == 1 &&
+			    __le16_to_cpu(nsindex->minor) == 1)
 				loop_bitmask |= 2;
 			else
 				loop_bitmask |= 4;
@@ -1658,11 +1659,12 @@ static umode_t namespace_visible(struct kobject *kobj,
 		return a->mode;
 	}
 
-	if (a == &dev_attr_nstype.attr || a == &dev_attr_size.attr
-	    || a == &dev_attr_holder.attr
-	    || a == &dev_attr_holder_class.attr
-	    || a == &dev_attr_force_raw.attr
-	    || a == &dev_attr_mode.attr)
+	if (a == &dev_attr_nstype.attr ||
+	    a == &dev_attr_size.attr ||
+	    a == &dev_attr_holder.attr ||
+	    a == &dev_attr_holder_class.attr ||
+	    a == &dev_attr_force_raw.attr ||
+	    a == &dev_attr_mode.attr)
 		return a->mode;
 
 	return 0;
@@ -1818,9 +1820,9 @@ static bool has_uuid_at_pos(struct nd_region *nd_region, u8 *uuid,
 			if (memcmp(nd_label->uuid, uuid, NSLABEL_UUID_LEN) != 0)
 				continue;
 
-			if (namespace_label_has(ndd, type_guid)
-			    && !guid_equal(&nd_set->type_guid,
-					   &nd_label->type_guid)) {
+			if (namespace_label_has(ndd, type_guid) &&
+			    !guid_equal(&nd_set->type_guid,
+					&nd_label->type_guid)) {
 				dev_dbg(ndd->dev, "expect type_guid %pUb got %pUb\n",
 					&nd_set->type_guid,
 					&nd_label->type_guid);
@@ -1882,8 +1884,8 @@ static int select_pmem_id(struct nd_region *nd_region, u8 *pmem_id)
 		hw_end = hw_start + nd_mapping->size;
 		pmem_start = __le64_to_cpu(nd_label->dpa);
 		pmem_end = pmem_start + __le64_to_cpu(nd_label->rawsize);
-		if (pmem_start >= hw_start && pmem_start < hw_end
-		    && pmem_end <= hw_end && pmem_end > hw_start)
+		if (pmem_start >= hw_start && pmem_start < hw_end &&
+		    pmem_end <= hw_end && pmem_end > hw_start)
 			/* pass */;
 		else {
 			dev_dbg(&nd_region->dev, "%s invalid label for %pUb\n",
@@ -2049,8 +2051,8 @@ struct resource *nsblk_add_resource(struct nd_region *nd_region,
 		return NULL;
 	nsblk->res = (struct resource **) res;
 	for_each_dpa_resource(ndd, res)
-		if (strcmp(res->name, label_id.id) == 0
-		    && res->start == start) {
+		if (strcmp(res->name, label_id.id) == 0 &&
+		    res->start == start) {
 			nsblk->res[nsblk->num_resources++] = res;
 			return res;
 		}
diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index 354ec83f0081..5382b4f2f5ef 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -74,14 +74,14 @@ static ssize_t mode_store(struct device *dev,
 	else {
 		size_t n = len - 1;
 
-		if (strncmp(buf, "pmem\n", n) == 0
-		    || strncmp(buf, "pmem", n) == 0) {
+		if (strncmp(buf, "pmem\n", n) == 0 ||
+		    strncmp(buf, "pmem", n) == 0) {
 			nd_pfn->mode = PFN_MODE_PMEM;
-		} else if (strncmp(buf, "ram\n", n) == 0
-			   || strncmp(buf, "ram", n) == 0)
+		} else if (strncmp(buf, "ram\n", n) == 0 ||
+			   strncmp(buf, "ram", n) == 0)
 			nd_pfn->mode = PFN_MODE_RAM;
-		else if (strncmp(buf, "none\n", n) == 0
-			 || strncmp(buf, "none", n) == 0)
+		else if (strncmp(buf, "none\n", n) == 0 ||
+			 strncmp(buf, "none", n) == 0)
 			nd_pfn->mode = PFN_MODE_NONE;
 		else
 			rc = -EINVAL;
@@ -529,8 +529,9 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
 		return -EBUSY;
 	}
 
-	if ((align && !IS_ALIGNED(nsio->res.start + offset + start_pad, align))
-	    || !IS_ALIGNED(offset, PAGE_SIZE)) {
+	if ((align &&
+	     !IS_ALIGNED(nsio->res.start + offset + start_pad, align)) ||
+	    !IS_ALIGNED(offset, PAGE_SIZE)) {
 		dev_err(&nd_pfn->dev,
 			"bad offset: %#llx dax disabled align: %#lx\n",
 			offset, align);
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 29f19db46845..fa4500b4f2eb 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -506,8 +506,9 @@ static int nd_pmem_probe(struct device *dev)
 		return pmem_attach_disk(dev, ndns);
 
 	/* if we find a valid info-block we'll come back as that personality */
-	if (nd_btt_probe(dev, ndns) == 0 || nd_pfn_probe(dev, ndns) == 0
-	    || nd_dax_probe(dev, ndns) == 0)
+	if (nd_btt_probe(dev, ndns) == 0 ||
+	    nd_pfn_probe(dev, ndns) == 0 ||
+	    nd_dax_probe(dev, ndns) == 0)
 		return -ENXIO;
 
 	/* ...otherwise we're just a raw pmem device */
diff --git a/drivers/nvdimm/region.c b/drivers/nvdimm/region.c
index 8b7dbac27aea..8486b6c26367 100644
--- a/drivers/nvdimm/region.c
+++ b/drivers/nvdimm/region.c
@@ -16,9 +16,9 @@ static int nd_region_probe(struct device *dev)
 	struct nd_region_data *ndrd;
 	struct nd_region *nd_region = to_nd_region(dev);
 
-	if (nd_region->num_lanes > num_online_cpus()
-	    && nd_region->num_lanes < num_possible_cpus()
-	    && !test_and_set_bit(0, &once)) {
+	if (nd_region->num_lanes > num_online_cpus() &&
+	    nd_region->num_lanes < num_possible_cpus() &&
+	    !test_and_set_bit(0, &once)) {
 		dev_dbg(dev, "online cpus (%d) < concurrent i/o lanes (%d) < possible cpus (%d)\n",
 			num_online_cpus(), nd_region->num_lanes,
 			num_possible_cpus());
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 025cd996ea58..0cff51370d3c 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -660,13 +660,13 @@ static umode_t region_visible(struct kobject *kobj, struct attribute *a, int n)
 		return a->mode;
 	}
 
-	if (a != &dev_attr_set_cookie.attr
-	    && a != &dev_attr_available_size.attr)
+	if (a != &dev_attr_set_cookie.attr &&
+	    a != &dev_attr_available_size.attr)
 		return a->mode;
 
-	if ((type == ND_DEVICE_NAMESPACE_PMEM
-	     || type == ND_DEVICE_NAMESPACE_BLK)
-	    && a == &dev_attr_available_size.attr)
+	if ((type == ND_DEVICE_NAMESPACE_PMEM ||
+	     type == ND_DEVICE_NAMESPACE_BLK) &&
+	    a == &dev_attr_available_size.attr)
 		return a->mode;
 	else if (is_memory(dev) && nd_set)
 		return a->mode;
@@ -688,8 +688,9 @@ u64 nd_region_interleave_set_cookie(struct nd_region *nd_region,
 	if (!nd_set)
 		return 0;
 
-	if (nsindex && __le16_to_cpu(nsindex->major) == 1
-	    && __le16_to_cpu(nsindex->minor) == 1)
+	if (nsindex &&
+	    __le16_to_cpu(nsindex->major) == 1 &&
+	    __le16_to_cpu(nsindex->minor) == 1)
 		return nd_set->cookie1;
 	return nd_set->cookie2;
 }
@@ -1002,8 +1003,8 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 		if (test_bit(NDD_UNARMED, &nvdimm->flags))
 			ro = 1;
 
-		if (test_bit(NDD_NOBLK, &nvdimm->flags)
-		    && dev_type == &nd_blk_device_type) {
+		if (test_bit(NDD_NOBLK, &nvdimm->flags) &&
+		    dev_type == &nd_blk_device_type) {
 			dev_err(&nvdimm_bus->dev, "%s: %s mapping%d is not BLK capable\n",
 				caller, dev_name(&nvdimm->dev), i);
 			return NULL;
@@ -1186,8 +1187,8 @@ int nvdimm_has_flush(struct nd_region *nd_region)
 	int i;
 
 	/* no nvdimm or pmem api == flushing capability unknown */
-	if (nd_region->ndr_mappings == 0
-	    || !IS_ENABLED(CONFIG_ARCH_HAS_PMEM_API))
+	if (nd_region->ndr_mappings == 0 ||
+	    !IS_ENABLED(CONFIG_ARCH_HAS_PMEM_API))
 		return -ENXIO;
 
 	for (i = 0; i < nd_region->ndr_mappings; i++) {
diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
index be89ad78a368..8f1766c00c5f 100644
--- a/drivers/nvdimm/security.c
+++ b/drivers/nvdimm/security.c
@@ -173,8 +173,9 @@ static int __nvdimm_security_unlock(struct nvdimm *nvdimm)
 	/* The bus lock should be held at the top level of the call stack */
 	lockdep_assert_held(&nvdimm_bus->reconfig_mutex);
 
-	if (!nvdimm->sec.ops || !nvdimm->sec.ops->unlock
-	    || !nvdimm->sec.flags)
+	if (!nvdimm->sec.ops ||
+	    !nvdimm->sec.ops->unlock ||
+	    !nvdimm->sec.flags)
 		return -EIO;
 
 	if (test_bit(NDD_SECURITY_OVERWRITE, &nvdimm->flags)) {
@@ -246,8 +247,9 @@ static int security_disable(struct nvdimm *nvdimm, unsigned int keyid)
 	/* The bus lock should be held at the top level of the call stack */
 	lockdep_assert_held(&nvdimm_bus->reconfig_mutex);
 
-	if (!nvdimm->sec.ops || !nvdimm->sec.ops->disable
-	    || !nvdimm->sec.flags)
+	if (!nvdimm->sec.ops ||
+	    !nvdimm->sec.ops->disable ||
+	    !nvdimm->sec.flags)
 		return -EOPNOTSUPP;
 
 	rc = check_security_state(nvdimm);
@@ -281,8 +283,9 @@ static int security_update(struct nvdimm *nvdimm, unsigned int keyid,
 	/* The bus lock should be held at the top level of the call stack */
 	lockdep_assert_held(&nvdimm_bus->reconfig_mutex);
 
-	if (!nvdimm->sec.ops || !nvdimm->sec.ops->change_key
-	    || !nvdimm->sec.flags)
+	if (!nvdimm->sec.ops ||
+	    !nvdimm->sec.ops->change_key ||
+	    !nvdimm->sec.flags)
 		return -EOPNOTSUPP;
 
 	rc = check_security_state(nvdimm);
@@ -330,16 +333,17 @@ static int security_erase(struct nvdimm *nvdimm, unsigned int keyid,
 	/* The bus lock should be held at the top level of the call stack */
 	lockdep_assert_held(&nvdimm_bus->reconfig_mutex);
 
-	if (!nvdimm->sec.ops || !nvdimm->sec.ops->erase
-	    || !nvdimm->sec.flags)
+	if (!nvdimm->sec.ops ||
+	    !nvdimm->sec.ops->erase ||
+	    !nvdimm->sec.flags)
 		return -EOPNOTSUPP;
 
 	rc = check_security_state(nvdimm);
 	if (rc)
 		return rc;
 
-	if (!test_bit(NVDIMM_SECURITY_UNLOCKED, &nvdimm->sec.ext_flags)
-	    && pass_type == NVDIMM_MASTER) {
+	if (!test_bit(NVDIMM_SECURITY_UNLOCKED, &nvdimm->sec.ext_flags) &&
+	    pass_type == NVDIMM_MASTER) {
 		dev_dbg(dev,
 			"Attempt to secure erase in wrong master state.\n");
 		return -EOPNOTSUPP;
@@ -371,8 +375,9 @@ static int security_overwrite(struct nvdimm *nvdimm, unsigned int keyid)
 	/* The bus lock should be held at the top level of the call stack */
 	lockdep_assert_held(&nvdimm_bus->reconfig_mutex);
 
-	if (!nvdimm->sec.ops || !nvdimm->sec.ops->overwrite
-	    || !nvdimm->sec.flags)
+	if (!nvdimm->sec.ops ||
+	    !nvdimm->sec.ops->overwrite ||
+	    !nvdimm->sec.flags)
 		return -EOPNOTSUPP;
 
 	if (dev->driver == NULL) {
@@ -427,8 +432,9 @@ void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
 
 	tmo = nvdimm->sec.overwrite_tmo;
 
-	if (!nvdimm->sec.ops || !nvdimm->sec.ops->query_overwrite
-	    || !nvdimm->sec.flags)
+	if (!nvdimm->sec.ops ||
+	    !nvdimm->sec.ops->query_overwrite ||
+	    !nvdimm->sec.flags)
 		return;
 
 	rc = nvdimm->sec.ops->query_overwrite(nvdimm);
-- 
2.15.0

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

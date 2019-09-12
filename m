Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E410EB06F7
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Sep 2019 04:55:30 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 908A3202C80B4;
	Wed, 11 Sep 2019 19:55:34 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=216.40.44.27;
 helo=smtprelay.hostedemail.com; envelope-from=joe@perches.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from smtprelay.hostedemail.com (smtprelay0027.hostedemail.com
 [216.40.44.27])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 151D3202C80A5
 for <linux-nvdimm@lists.01.org>; Wed, 11 Sep 2019 19:55:34 -0700 (PDT)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay04.hostedemail.com (Postfix) with ESMTP id 50123180A68D6;
 Thu, 12 Sep 2019 02:55:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2, 0, 0, , d41d8cd98f00b204, joe@perches.com, :::::::::::::::,
 RULES_HIT:2:41:69:355:379:541:800:960:973:988:989:1260:1345:1359:1437:1535:1605:1730:1747:1777:1792:2194:2199:2393:2553:2559:2562:2898:3138:3139:3140:3141:3142:3865:3866:3867:3871:3874:4049:4118:4250:4321:4605:5007:6117:6119:6261:7903:7974:8603:9010:9592:9707:10004:10848:11026:11473:11658:11914:12043:12048:12296:12297:12438:12555:12683:12895:12986:14096:14394:21080:21324:21451:21627:21796:21966:30012:30029:30036:30054:30056:30069:30070:30075:30090,
 0,
 RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,
 CacheIP:none, Bayesian:0.5, 0.5, 0.5, Netcheck:none, DomainCache:0,
 MSF:not bulk, SPF:fn, MSBL:0, DNSBL:neutral, Custom_rules:0:0:0, LFtime:59,
 LUA_SUMMARY:none
X-HE-Tag: farm24_86bb032e81406
X-Filterd-Recvd-Size: 7399
Received: from joe-laptop.perches.com (unknown [47.151.152.152])
 (Authenticated sender: joe@perches.com)
 by omf16.hostedemail.com (Postfix) with ESMTPA;
 Thu, 12 Sep 2019 02:55:25 +0000 (UTC)
From: Joe Perches <joe@perches.com>
To: Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Keith Busch <keith.busch@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 11/13] nvdimm: Use more common logic testing styles and bare ;
 positions
Date: Wed, 11 Sep 2019 19:54:41 -0700
Message-Id: <d6aa5b66936f2e0f132e893e10494aae6b74e886.1568256708.git.joe@perches.com>
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

Avoid using uncommon logic testing styles to make the code a
bit more like other kernel code.

e.g.:
	if (foo) {
		;
	} else {
		<code>
	}

is typically written

	if (!foo) {
		<code>
	}

Also put bare semicolons before the comment not after the comment

e.g.:

	if (foo) {
		/* comment */;
	} else if (bar) {
		<code>
	} else {
		baz;
	}

is typically written

	if (foo) {
		;	/* comment */
	} else if (bar) {
		<code>
	} else {
		baz;
	}

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/nvdimm/claim.c          |  4 +---
 drivers/nvdimm/dimm_devs.c      | 11 ++++------
 drivers/nvdimm/label.c          |  4 +---
 drivers/nvdimm/namespace_devs.c | 46 +++++++++++++++++++----------------------
 drivers/nvdimm/region_devs.c    |  4 +---
 5 files changed, 28 insertions(+), 41 deletions(-)

diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
index 3732925aadb8..244631f5308c 100644
--- a/drivers/nvdimm/claim.c
+++ b/drivers/nvdimm/claim.c
@@ -149,9 +149,7 @@ ssize_t nd_namespace_store(struct device *dev,
 		return -ENOMEM;
 	strim(name);
 
-	if (strncmp(name, "namespace", 9) == 0 || strcmp(name, "") == 0) {
-		/* pass */;
-	} else {
+	if (!(strncmp(name, "namespace", 9) == 0 || strcmp(name, "") == 0)) {
 		len = -EINVAL;
 		goto out;
 	}
diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index 4df85dd72682..cac62bb726bb 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -593,13 +593,10 @@ int alias_dpa_busy(struct device *dev, void *data)
 	 * looking to validate against PMEM aliasing collision rules
 	 * (i.e. BLK is allocated after all aliased PMEM).
 	 */
-	if (info->res) {
-		if (info->res->start >= nd_mapping->start &&
-		    info->res->start < map_end)
-			/* pass */;
-		else
-			return 0;
-	}
+	if (info->res &&
+	    (info->res->start < nd_mapping->start ||
+	     info->res->start >= map_end))
+		return 0;
 
 retry:
 	/*
diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
index e4632dbebead..ae466c6faa90 100644
--- a/drivers/nvdimm/label.c
+++ b/drivers/nvdimm/label.c
@@ -1180,9 +1180,7 @@ static int init_labels(struct nd_mapping *nd_mapping, int num_labels)
 		mutex_unlock(&nd_mapping->lock);
 	}
 
-	if (ndd->ns_current == -1 || ndd->ns_next == -1)
-		/* pass */;
-	else
+	if (ndd->ns_current != -1 && ndd->ns_next != -1)
 		return max(num_labels, old_num_labels);
 
 	nsindex = to_namespace_index(ndd, 0);
diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 8c75ef84bad7..7a16340f9853 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -162,7 +162,7 @@ unsigned int pmem_sector_size(struct nd_namespace_common *ndns)
 
 		nspm = to_nd_namespace_pmem(&ndns->dev);
 		if (nspm->lbasize == 0 || nspm->lbasize == 512)
-			/* default */;
+			;	/* default */
 		else if (nspm->lbasize == 4096)
 			return 4096;
 		else
@@ -387,7 +387,7 @@ static int nd_namespace_label_update(struct nd_region *nd_region,
 		resource_size_t size = resource_size(&nspm->nsio.res);
 
 		if (size == 0 && nspm->uuid)
-			/* delete allocation */;
+			;	/* delete allocation */
 		else if (!nspm->uuid)
 			return 0;
 
@@ -398,7 +398,7 @@ static int nd_namespace_label_update(struct nd_region *nd_region,
 		resource_size_t size = nd_namespace_blk_size(nsblk);
 
 		if (size == 0 && nsblk->uuid)
-			/* delete allocation */;
+			;	/* delete allocation */
 		else if (!nsblk->uuid || !nsblk->lbasize)
 			return 0;
 
@@ -1900,10 +1900,8 @@ static int select_pmem_id(struct nd_region *nd_region, u8 *pmem_id)
 		hw_end = hw_start + nd_mapping->size;
 		pmem_start = __le64_to_cpu(nd_label->dpa);
 		pmem_end = pmem_start + __le64_to_cpu(nd_label->rawsize);
-		if (pmem_start >= hw_start && pmem_start < hw_end &&
-		    pmem_end <= hw_end && pmem_end > hw_start) {
-			/* pass */;
-		} else {
+		if (!(pmem_start >= hw_start && pmem_start < hw_end &&
+		      pmem_end <= hw_end && pmem_end > hw_start)) {
 			dev_dbg(&nd_region->dev, "%s invalid label for %pUb\n",
 				dev_name(ndd->dev), nd_label->uuid);
 			return -EINVAL;
@@ -2326,15 +2324,12 @@ static struct device **scan_labels(struct nd_region *nd_region)
 	list_for_each_entry_safe(label_ent, e, &nd_mapping->labels, list) {
 		struct nd_namespace_label *nd_label = label_ent->label;
 		struct device **__devs;
-		u32 flags;
+		bool localflag;
 
 		if (!nd_label)
 			continue;
-		flags = __le32_to_cpu(nd_label->flags);
-		if (is_nd_blk(&nd_region->dev)
-		    == !!(flags & NSLABEL_FLAG_LOCAL))
-			/* pass, region matches label type */;
-		else
+		localflag = __le32_to_cpu(nd_label->flags) & NSLABEL_FLAG_LOCAL;
+		if (is_nd_blk(&nd_region->dev) != localflag)
 			continue;
 
 		/* skip labels that describe extents outside of the region */
@@ -2494,19 +2489,20 @@ static int init_active_labels(struct nd_region *nd_region)
 		 * the region from being activated.
 		 */
 		if (!ndd) {
-			if (test_bit(NDD_LOCKED, &nvdimm->flags))
-				/* fail, label data may be unreadable */;
-			else if (test_bit(NDD_ALIASING, &nvdimm->flags))
-				/* fail, labels needed to disambiguate dpa */;
-			else
-				return 0;
-
-			dev_err(&nd_region->dev, "%s: is %s, failing probe\n",
-				dev_name(&nd_mapping->nvdimm->dev),
-				test_bit(NDD_LOCKED, &nvdimm->flags)
-				? "locked" : "disabled");
-			return -ENXIO;
+			if (test_bit(NDD_LOCKED, &nvdimm->flags) ||
+					/* label data may be unreadable */
+			    test_bit(NDD_ALIASING, &nvdimm->flags)) {
+					/* labels needed to disambiguate dpa */
+
+				dev_err(&nd_region->dev, "%s: is %s, failing probe\n",
+					dev_name(&nd_mapping->nvdimm->dev),
+					test_bit(NDD_LOCKED, &nvdimm->flags)
+					? "locked" : "disabled");
+				return -ENXIO;
+			}
+			return 0;
 		}
+
 		nd_mapping->ndd = ndd;
 		atomic_inc(&nvdimm->busy);
 		get_ndd(ndd);
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 65df07481909..6861e0997d21 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -320,9 +320,7 @@ static ssize_t set_cookie_show(struct device *dev,
 	struct nd_interleave_set *nd_set = nd_region->nd_set;
 	ssize_t rc = 0;
 
-	if (is_memory(dev) && nd_set)
-		/* pass, should be precluded by region_visible */;
-	else
+	if (!(is_memory(dev) && nd_set))
 		return -ENXIO;
 
 	/*
-- 
2.15.0

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

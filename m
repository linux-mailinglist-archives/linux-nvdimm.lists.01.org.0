Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 789282FD9CE
	for <lists+linux-nvdimm@lfdr.de>; Wed, 20 Jan 2021 20:39:07 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2A7E5100EB32D;
	Wed, 20 Jan 2021 11:39:06 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4FF12100EB32D
	for <linux-nvdimm@lists.01.org>; Wed, 20 Jan 2021 11:39:04 -0800 (PST)
IronPort-SDR: KoW9/dqo2vHKFeQiAJSiiM9XEJwRNq59cuOT/Q1ysNAJetGZbTw67h+TPQozNMXNSpx1glsHK/
 hrdDW3XFqLCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="178386993"
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400";
   d="scan'208";a="178386993"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 11:39:03 -0800
IronPort-SDR: A3tq+YfoJkcUvYVuSJGsyf0zQsyBAJ86r71bERgJ64yfMKnnvdTRgckKg/hKXntycN1Q0RFCdW
 xZ5pUlI4l3vQ==
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400";
   d="scan'208";a="570375737"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 11:39:03 -0800
Subject: [PATCH 2/3] libnvdimm/ida: Switch to non-deprecated ida helpers
From: Dan Williams <dan.j.williams@intel.com>
To: gregkh@linuxfoundation.org
Date: Wed, 20 Jan 2021 11:39:03 -0800
Message-ID: <161117154337.2853729.4507006194649324399.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161117153248.2853729.2452425259045172318.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161117153248.2853729.2452425259045172318.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: LNAJCIUO7RWHSKQT5YLXZWBQ3LF6MDML
X-Message-ID-Hash: LNAJCIUO7RWHSKQT5YLXZWBQ3LF6MDML
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: logang@deltatee.com, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LNAJCIUO7RWHSKQT5YLXZWBQ3LF6MDML/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In preparation for a rework of character device initialization, take the
opportunity to cleanup ida usage.

Cc: Vishal Verma <vishal.l.verma@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/btt_devs.c       |    6 +++---
 drivers/nvdimm/bus.c            |    4 ++--
 drivers/nvdimm/dax_devs.c       |    4 ++--
 drivers/nvdimm/dimm_devs.c      |    4 ++--
 drivers/nvdimm/namespace_devs.c |   14 ++++++--------
 drivers/nvdimm/pfn_devs.c       |    4 ++--
 6 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/nvdimm/btt_devs.c b/drivers/nvdimm/btt_devs.c
index 05feb97e11ce..e148fd16a47e 100644
--- a/drivers/nvdimm/btt_devs.c
+++ b/drivers/nvdimm/btt_devs.c
@@ -20,7 +20,7 @@ static void nd_btt_release(struct device *dev)
 
 	dev_dbg(dev, "trace\n");
 	nd_detach_ndns(&nd_btt->dev, &nd_btt->ndns);
-	ida_simple_remove(&nd_region->btt_ida, nd_btt->id);
+	ida_free(&nd_region->btt_ida, nd_btt->id);
 	kfree(nd_btt->uuid);
 	kfree(nd_btt);
 }
@@ -190,7 +190,7 @@ static struct device *__nd_btt_create(struct nd_region *nd_region,
 	if (!nd_btt)
 		return NULL;
 
-	nd_btt->id = ida_simple_get(&nd_region->btt_ida, 0, 0, GFP_KERNEL);
+	nd_btt->id = ida_alloc(&nd_region->btt_ida, GFP_KERNEL);
 	if (nd_btt->id < 0)
 		goto out_nd_btt;
 
@@ -215,7 +215,7 @@ static struct device *__nd_btt_create(struct nd_region *nd_region,
 	return dev;
 
 out_put_id:
-	ida_simple_remove(&nd_region->btt_ida, nd_btt->id);
+	ida_free(&nd_region->btt_ida, nd_btt->id);
 
 out_nd_btt:
 	kfree(nd_btt);
diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 2304c6183822..0258ec90dce6 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -296,7 +296,7 @@ static void nvdimm_bus_release(struct device *dev)
 	struct nvdimm_bus *nvdimm_bus;
 
 	nvdimm_bus = container_of(dev, struct nvdimm_bus, dev);
-	ida_simple_remove(&nd_ida, nvdimm_bus->id);
+	ida_free(&nd_ida, nvdimm_bus->id);
 	kfree(nvdimm_bus);
 }
 
@@ -351,7 +351,7 @@ struct nvdimm_bus *nvdimm_bus_register(struct device *parent,
 	INIT_LIST_HEAD(&nvdimm_bus->list);
 	INIT_LIST_HEAD(&nvdimm_bus->mapping_list);
 	init_waitqueue_head(&nvdimm_bus->wait);
-	nvdimm_bus->id = ida_simple_get(&nd_ida, 0, 0, GFP_KERNEL);
+	nvdimm_bus->id = ida_alloc(&nd_ida, GFP_KERNEL);
 	if (nvdimm_bus->id < 0) {
 		kfree(nvdimm_bus);
 		return NULL;
diff --git a/drivers/nvdimm/dax_devs.c b/drivers/nvdimm/dax_devs.c
index 99965077bac4..374b195ba8d5 100644
--- a/drivers/nvdimm/dax_devs.c
+++ b/drivers/nvdimm/dax_devs.c
@@ -18,7 +18,7 @@ static void nd_dax_release(struct device *dev)
 
 	dev_dbg(dev, "trace\n");
 	nd_detach_ndns(dev, &nd_pfn->ndns);
-	ida_simple_remove(&nd_region->dax_ida, nd_pfn->id);
+	ida_free(&nd_region->dax_ida, nd_pfn->id);
 	kfree(nd_pfn->uuid);
 	kfree(nd_dax);
 }
@@ -55,7 +55,7 @@ static struct nd_dax *nd_dax_alloc(struct nd_region *nd_region)
 		return NULL;
 
 	nd_pfn = &nd_dax->nd_pfn;
-	nd_pfn->id = ida_simple_get(&nd_region->dax_ida, 0, 0, GFP_KERNEL);
+	nd_pfn->id = ida_alloc(&nd_region->dax_ida, GFP_KERNEL);
 	if (nd_pfn->id < 0) {
 		kfree(nd_dax);
 		return NULL;
diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index b59032e0859b..3dec809ef20a 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -198,7 +198,7 @@ static void nvdimm_release(struct device *dev)
 {
 	struct nvdimm *nvdimm = to_nvdimm(dev);
 
-	ida_simple_remove(&dimm_ida, nvdimm->id);
+	ida_free(&dimm_ida, nvdimm->id);
 	kfree(nvdimm);
 }
 
@@ -592,7 +592,7 @@ struct nvdimm *__nvdimm_create(struct nvdimm_bus *nvdimm_bus,
 	if (!nvdimm)
 		return NULL;
 
-	nvdimm->id = ida_simple_get(&dimm_ida, 0, 0, GFP_KERNEL);
+	nvdimm->id = ida_alloc(&dimm_ida, GFP_KERNEL);
 	if (nvdimm->id < 0) {
 		kfree(nvdimm);
 		return NULL;
diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 6da67f4d641a..c34880310c40 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -26,7 +26,7 @@ static void namespace_pmem_release(struct device *dev)
 	struct nd_region *nd_region = to_nd_region(dev->parent);
 
 	if (nspm->id >= 0)
-		ida_simple_remove(&nd_region->ns_ida, nspm->id);
+		ida_free(&nd_region->ns_ida, nspm->id);
 	kfree(nspm->alt_name);
 	kfree(nspm->uuid);
 	kfree(nspm);
@@ -38,7 +38,7 @@ static void namespace_blk_release(struct device *dev)
 	struct nd_region *nd_region = to_nd_region(dev->parent);
 
 	if (nsblk->id >= 0)
-		ida_simple_remove(&nd_region->ns_ida, nsblk->id);
+		ida_free(&nd_region->ns_ida, nsblk->id);
 	kfree(nsblk->alt_name);
 	kfree(nsblk->uuid);
 	kfree(nsblk->res);
@@ -2114,7 +2114,7 @@ static struct device *nd_namespace_blk_create(struct nd_region *nd_region)
 
 	dev = &nsblk->common.dev;
 	dev->type = &namespace_blk_device_type;
-	nsblk->id = ida_simple_get(&nd_region->ns_ida, 0, 0, GFP_KERNEL);
+	nsblk->id = ida_alloc(&nd_region->ns_ida, GFP_KERNEL);
 	if (nsblk->id < 0) {
 		kfree(nsblk);
 		return NULL;
@@ -2145,7 +2145,7 @@ static struct device *nd_namespace_pmem_create(struct nd_region *nd_region)
 	res->name = dev_name(&nd_region->dev);
 	res->flags = IORESOURCE_MEM;
 
-	nspm->id = ida_simple_get(&nd_region->ns_ida, 0, 0, GFP_KERNEL);
+	nspm->id = ida_alloc(&nd_region->ns_ida, GFP_KERNEL);
 	if (nspm->id < 0) {
 		kfree(nspm);
 		return NULL;
@@ -2633,15 +2633,13 @@ int nd_region_register_namespaces(struct nd_region *nd_region, int *err)
 			struct nd_namespace_blk *nsblk;
 
 			nsblk = to_nd_namespace_blk(dev);
-			id = ida_simple_get(&nd_region->ns_ida, 0, 0,
-					GFP_KERNEL);
+			id = ida_alloc(&nd_region->ns_ida, GFP_KERNEL);
 			nsblk->id = id;
 		} else if (type == ND_DEVICE_NAMESPACE_PMEM) {
 			struct nd_namespace_pmem *nspm;
 
 			nspm = to_nd_namespace_pmem(dev);
-			id = ida_simple_get(&nd_region->ns_ida, 0, 0,
-					GFP_KERNEL);
+			id = ida_alloc(&nd_region->ns_ida, GFP_KERNEL);
 			nspm->id = id;
 		} else
 			id = i;
diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index b499df630d4d..8edfe2d2c77c 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -21,7 +21,7 @@ static void nd_pfn_release(struct device *dev)
 
 	dev_dbg(dev, "trace\n");
 	nd_detach_ndns(&nd_pfn->dev, &nd_pfn->ndns);
-	ida_simple_remove(&nd_region->pfn_ida, nd_pfn->id);
+	ida_free(&nd_region->pfn_ida, nd_pfn->id);
 	kfree(nd_pfn->uuid);
 	kfree(nd_pfn);
 }
@@ -322,7 +322,7 @@ static struct nd_pfn *nd_pfn_alloc(struct nd_region *nd_region)
 	if (!nd_pfn)
 		return NULL;
 
-	nd_pfn->id = ida_simple_get(&nd_region->pfn_ida, 0, 0, GFP_KERNEL);
+	nd_pfn->id = ida_alloc(&nd_region->pfn_ida, GFP_KERNEL);
 	if (nd_pfn->id < 0) {
 		kfree(nd_pfn);
 		return NULL;
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

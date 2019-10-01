Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B85C3B51
	for <lists+linux-nvdimm@lfdr.de>; Tue,  1 Oct 2019 18:43:52 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C018710FC71FD;
	Tue,  1 Oct 2019 09:45:18 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=sashal@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3748E10FC71E3
	for <linux-nvdimm@lists.01.org>; Tue,  1 Oct 2019 09:45:16 -0700 (PDT)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id F286D2168B;
	Tue,  1 Oct 2019 16:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569948228;
	bh=LbY8e0Zc9YsjxIv7bUW/Y9HmfDl94YIC5UR7YxW2k2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O/f4SHDO9O3hgX56aH9ZxlEdqs8EjPGCtRp0Zji+Sgo4WYnEaAorsWjCdQBQgdDAq
	 Yf/JVESyriwpoAYSFPOYs/D4GMSw3NPkfqvcTk+c9pzg/XYEIEryOwdcDv9AtZ/IDF
	 ZHsLY83IKcdu2mD9Cc9ig5mvUvCk7c+DriuZUWSw=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 26/43] libnvdimm/region: Initialize bad block for volatile namespaces
Date: Tue,  1 Oct 2019 12:42:54 -0400
Message-Id: <20191001164311.15993-26-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001164311.15993-1-sashal@kernel.org>
References: <20191001164311.15993-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Message-ID-Hash: UGU6WSLO36QHW4LZGDGXUH7T7KVR3C2T
X-Message-ID-Hash: UGU6WSLO36QHW4LZGDGXUH7T7KVR3C2T
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Sasha Levin <sashal@kernel.org>, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <>
List-Archive: <>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>

[ Upstream commit c42adf87e4e7ed77f6ffe288dc90f980d07d68df ]

We do check for a bad block during namespace init and that use
region bad block list. We need to initialize the bad block
for volatile regions for this to work. We also observe a lockdep
warning as below because the lock is not initialized correctly
since we skip bad block init for volatile regions.

 INFO: trying to register non-static key.
 the code is fine but needs lockdep annotation.
 turning off the locking correctness validator.
 CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.3.0-rc1-15699-g3dee241c937e #149
 Call Trace:
 [c0000000f95cb250] [c00000000147dd84] dump_stack+0xe8/0x164 (unreliable)
 [c0000000f95cb2a0] [c00000000022ccd8] register_lock_class+0x308/0xa60
 [c0000000f95cb3a0] [c000000000229cc0] __lock_acquire+0x170/0x1ff0
 [c0000000f95cb4c0] [c00000000022c740] lock_acquire+0x220/0x270
 [c0000000f95cb580] [c000000000a93230] badblocks_check+0xc0/0x290
 [c0000000f95cb5f0] [c000000000d97540] nd_pfn_validate+0x5c0/0x7f0
 [c0000000f95cb6d0] [c000000000d98300] nd_dax_probe+0xd0/0x1f0
 [c0000000f95cb760] [c000000000d9b66c] nd_pmem_probe+0x10c/0x160
 [c0000000f95cb790] [c000000000d7f5ec] nvdimm_bus_probe+0x10c/0x240
 [c0000000f95cb820] [c000000000d0f844] really_probe+0x254/0x4e0
 [c0000000f95cb8b0] [c000000000d0fdfc] driver_probe_device+0x16c/0x1e0
 [c0000000f95cb930] [c000000000d10238] device_driver_attach+0x68/0xa0
 [c0000000f95cb970] [c000000000d1040c] __driver_attach+0x19c/0x1c0
 [c0000000f95cb9f0] [c000000000d0c4c4] bus_for_each_dev+0x94/0x130
 [c0000000f95cba50] [c000000000d0f014] driver_attach+0x34/0x50
 [c0000000f95cba70] [c000000000d0e208] bus_add_driver+0x178/0x2f0
 [c0000000f95cbb00] [c000000000d117c8] driver_register+0x108/0x170
 [c0000000f95cbb70] [c000000000d7edb0] __nd_driver_register+0xe0/0x100
 [c0000000f95cbbd0] [c000000001a6baa4] nd_pmem_driver_init+0x34/0x48
 [c0000000f95cbbf0] [c0000000000106f4] do_one_initcall+0x1d4/0x4b0
 [c0000000f95cbcd0] [c0000000019f499c] kernel_init_freeable+0x544/0x65c
 [c0000000f95cbdb0] [c000000000010d6c] kernel_init+0x2c/0x180
 [c0000000f95cbe20] [c00000000000b954] ret_from_kernel_thread+0x5c/0x68

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Link: https://lore.kernel.org/r/20190919083355.26340-1-aneesh.kumar@linux.ibm.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvdimm/bus.c         | 2 +-
 drivers/nvdimm/region.c      | 4 ++--
 drivers/nvdimm/region_devs.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 2ba22cd1331b0..54a633e8cb5d2 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -189,7 +189,7 @@ static int nvdimm_clear_badblocks_region(struct device *dev, void *data)
 	sector_t sector;
 
 	/* make sure device is a region */
-	if (!is_nd_pmem(dev))
+	if (!is_memory(dev))
 		return 0;
 
 	nd_region = to_nd_region(dev);
diff --git a/drivers/nvdimm/region.c b/drivers/nvdimm/region.c
index f9130cc157e83..22224b21c34df 100644
--- a/drivers/nvdimm/region.c
+++ b/drivers/nvdimm/region.c
@@ -42,7 +42,7 @@ static int nd_region_probe(struct device *dev)
 	if (rc)
 		return rc;
 
-	if (is_nd_pmem(&nd_region->dev)) {
+	if (is_memory(&nd_region->dev)) {
 		struct resource ndr_res;
 
 		if (devm_init_badblocks(dev, &nd_region->bb))
@@ -131,7 +131,7 @@ static void nd_region_notify(struct device *dev, enum nvdimm_event event)
 		struct nd_region *nd_region = to_nd_region(dev);
 		struct resource res;
 
-		if (is_nd_pmem(&nd_region->dev)) {
+		if (is_memory(&nd_region->dev)) {
 			res.start = nd_region->ndr_start;
 			res.end = nd_region->ndr_start +
 				nd_region->ndr_size - 1;
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 0303296e6d5b6..609fc450522a1 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -633,11 +633,11 @@ static umode_t region_visible(struct kobject *kobj, struct attribute *a, int n)
 	if (!is_memory(dev) && a == &dev_attr_dax_seed.attr)
 		return 0;
 
-	if (!is_nd_pmem(dev) && a == &dev_attr_badblocks.attr)
+	if (!is_memory(dev) && a == &dev_attr_badblocks.attr)
 		return 0;
 
 	if (a == &dev_attr_resource.attr) {
-		if (is_nd_pmem(dev))
+		if (is_memory(dev))
 			return 0400;
 		else
 			return 0;
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

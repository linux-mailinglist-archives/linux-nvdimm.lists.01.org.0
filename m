Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2F921FF1
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 May 2019 23:54:50 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6B4BE21276779;
	Fri, 17 May 2019 14:54:49 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::843; helo=mail-qt1-x843.google.com;
 envelope-from=pasha.tatashin@soleen.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 224F5212604F2
 for <linux-nvdimm@lists.01.org>; Fri, 17 May 2019 14:54:47 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id a17so9802560qth.3
 for <linux-nvdimm@lists.01.org>; Fri, 17 May 2019 14:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=8p3wsS4SMTLuQgzuXCRhTKHP61mCg8wFpFeHB9x4QIQ=;
 b=dxODNsdP4xdmGLZgD3wGpBVlOvBLAVbSmuov53M2mG0sFDyfGFIGchYc5sW1e4tdjh
 E4c/jto60Apec/FyJ74ps0C/lZTwCHSVCGEu/P9hjQyCnKCnrzUieZ4VeCLSkNoimqU6
 vTLoXPIvlC8WqNcEBLsvkQh9YYqP+L4H5r2GbwuKQ+kEujoYI57NpN8mOTCWgmfsr7Aw
 Spg565JQb5vi1JEv/tGDOgJGc//CmfQNLmu7NjApk78ZskurVXGDnNCuawRCwtqnE6X6
 JljgK2qNEAxVFEPGagOdIZlQ2j6+4SDQF/UVFwdv64lQUFlavVTkaDTXSW2ZYOAZXFsD
 rTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8p3wsS4SMTLuQgzuXCRhTKHP61mCg8wFpFeHB9x4QIQ=;
 b=CEeNxmIZbaR/wKWY252AN+hTzfOhpRXDlUBGQY9UgEk+fZSwWQ1ygqdemIkbJDKE8U
 2z1aOAMh1lFhFtbfoyAxgmN7pkprp053IJymjB4M7GSAKoqTISJ6bkwFuuY4fbiCEbEy
 M/R5WMnNf1efsBp86CScvWCVu/qXUaWBlUkgp9pfmLCGydzoGm2FAQe0CcgRn7PBS7mz
 ClWmAw/r9oU5rm0mf6aIRyGAN75zg1djkScrRYLng9KSfk+Qeo+iEosQApAuCZpFJItq
 AeKYnM8qJJSl8y3RThumE2Jp1L5sJnS7EmSDHIhk2g6BAs3MZrSy42R0Lvel8GrfJsVH
 lltw==
X-Gm-Message-State: APjAAAVOnj+YAZzHX7PwivtUOglSEeQdj43wtx6xm2kep51fmOpXanzW
 XLqofXGiyN8LR43n7UJFvyGwlg==
X-Google-Smtp-Source: APXvYqwFk9kJSaOoaMhXOv97FFwjvOjt9oKxB+WBIkvvLLcYVDlAeyLAX4m1Cd2gwueE6vntUoBbxw==
X-Received: by 2002:ac8:3696:: with SMTP id a22mr50806933qtc.296.1558130086264; 
 Fri, 17 May 2019 14:54:46 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net.
 [73.69.118.222])
 by smtp.gmail.com with ESMTPSA id n36sm6599813qtk.9.2019.05.17.14.54.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 17 May 2019 14:54:45 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-nvdimm@lists.01.org, akpm@linux-foundation.org, mhocko@suse.com,
 dave.hansen@linux.intel.com, dan.j.williams@intel.com,
 keith.busch@intel.com, vishal.l.verma@intel.com, dave.jiang@intel.com,
 zwisler@kernel.org, thomas.lendacky@amd.com, ying.huang@intel.com,
 fengguang.wu@intel.com, bp@suse.de, bhelgaas@google.com,
 baiyaowei@cmss.chinamobile.com, tiwai@suse.de, jglisse@redhat.com,
 david@redhat.com
Subject: [v6 3/3] device-dax: "Hotremove" persistent memory that is used like
 normal RAM
Date: Fri, 17 May 2019 17:54:38 -0400
Message-Id: <20190517215438.6487-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190517215438.6487-1-pasha.tatashin@soleen.com>
References: <20190517215438.6487-1-pasha.tatashin@soleen.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

It is now allowed to use persistent memory like a regular RAM, but
currently there is no way to remove this memory until machine is
rebooted.

This work expands the functionality to also allows hotremoving
previously hotplugged persistent memory, and recover the device for use
for other purposes.

To hotremove persistent memory, the management software must first
offline all memory blocks of dax region, and than unbind it from
device-dax/kmem driver. So, operations should look like this:

echo offline > /sys/devices/system/memory/memoryN/state
...
echo dax0.0 > /sys/bus/dax/drivers/kmem/unbind

Note: if unbind is done without offlining memory beforehand, it won't be
possible to do dax0.0 hotremove, and dax's memory is going to be part of
System RAM until reboot.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 drivers/dax/dax-private.h |  2 ++
 drivers/dax/kmem.c        | 41 +++++++++++++++++++++++++++++++++++----
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index a45612148ca0..999aaf3a29b3 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -53,6 +53,7 @@ struct dax_region {
  * @pgmap - pgmap for memmap setup / lifetime (driver owned)
  * @ref: pgmap reference count (driver owned)
  * @cmp: @ref final put completion (driver owned)
+ * @dax_mem_res: physical address range of hotadded DAX memory
  */
 struct dev_dax {
 	struct dax_region *region;
@@ -62,6 +63,7 @@ struct dev_dax {
 	struct dev_pagemap pgmap;
 	struct percpu_ref ref;
 	struct completion cmp;
+	struct resource *dax_kmem_res;
 };
 
 static inline struct dev_dax *to_dev_dax(struct device *dev)
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 4c0131857133..3d0a7e702c94 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -71,21 +71,54 @@ int dev_dax_kmem_probe(struct device *dev)
 		kfree(new_res);
 		return rc;
 	}
+	dev_dax->dax_kmem_res = new_res;
 
 	return 0;
 }
 
+#ifdef CONFIG_MEMORY_HOTREMOVE
+static int dev_dax_kmem_remove(struct device *dev)
+{
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+	struct resource *res = dev_dax->dax_kmem_res;
+	resource_size_t kmem_start = res->start;
+	resource_size_t kmem_size = resource_size(res);
+	int rc;
+
+	/*
+	 * We have one shot for removing memory, if some memory blocks were not
+	 * offline prior to calling this function remove_memory() will fail, and
+	 * there is no way to hotremove this memory until reboot because device
+	 * unbind will succeed even if we return failure.
+	 */
+	rc = remove_memory(dev_dax->target_node, kmem_start, kmem_size);
+	if (rc) {
+		dev_err(dev,
+			"DAX region %pR cannot be hotremoved until the next reboot\n",
+			res);
+		return rc;
+	}
+
+	/* Release and free dax resources */
+	release_resource(res);
+	kfree(res);
+	dev_dax->dax_kmem_res = NULL;
+
+	return 0;
+}
+#else
 static int dev_dax_kmem_remove(struct device *dev)
 {
 	/*
-	 * Purposely leak the request_mem_region() for the device-dax
-	 * range and return '0' to ->remove() attempts. The removal of
-	 * the device from the driver always succeeds, but the region
-	 * is permanently pinned as reserved by the unreleased
+	 * Without hotremove purposely leak the request_mem_region() for the
+	 * device-dax range and return '0' to ->remove() attempts. The removal
+	 * of the device from the driver always succeeds, but the region is
+	 * permanently pinned as reserved by the unreleased
 	 * request_mem_region().
 	 */
 	return 0;
 }
+#endif /* CONFIG_MEMORY_HOTREMOVE */
 
 static struct dax_device_driver device_dax_kmem_driver = {
 	.drv = {
-- 
2.21.0

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAFA1CA655
	for <lists+linux-nvdimm@lfdr.de>; Fri,  8 May 2020 10:42:49 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D8EFF11842517;
	Fri,  8 May 2020 01:40:44 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.61; helo=us-smtp-delivery-1.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com [205.139.110.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4146E11842510
	for <linux-nvdimm@lists.01.org>; Fri,  8 May 2020 01:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1588927365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f6TeMrGs7xjeCj9G607qVf2e66dWDywj8Qub6sAiaWA=;
	b=Ciwc1Gyc7rUGo4o2E31rMdT+x/1y6/5dcWUsjUIUWMd03kIui1OBxVkvXjIr9fHN2UZUP5
	i2GIA31KaoC7+hyI+hgLHfzmAsF5U9bGYNgNnKvYCWJyUP0v2JBBRevP6ZLI+/XY0Jk/AR
	9TbT+v0yycoLrxehyrBjdzoPS21B8Hs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-e2MKSisaOFSWnPAgNcUing-1; Fri, 08 May 2020 04:42:43 -0400
X-MC-Unique: e2MKSisaOFSWnPAgNcUing-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C966107ACCA;
	Fri,  8 May 2020 08:42:41 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-181.ams2.redhat.com [10.36.113.181])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 54D1C5C1C5;
	Fri,  8 May 2020 08:42:38 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] device-dax: Add memory via add_memory_driver_managed()
Date: Fri,  8 May 2020 10:42:17 +0200
Message-Id: <20200508084217.9160-5-david@redhat.com>
In-Reply-To: <20200508084217.9160-1-david@redhat.com>
References: <20200508084217.9160-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Message-ID-Hash: A4NSE3QNT7AQXHI7B2JAUHLPAQXPJS5M
X-Message-ID-Hash: A4NSE3QNT7AQXHI7B2JAUHLPAQXPJS5M
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-mm@kvack.org, linux-nvdimm@lists.01.org, kexec@lists.infradead.org, Pavel Tatashin <pasha.tatashin@soleen.com>, David Hildenbrand <david@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Wei Yang <richard.weiyang@gmail.com>, Baoquan He <bhe@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eric Biederman <ebiederm@xmission.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/A4NSE3QNT7AQXHI7B2JAUHLPAQXPJS5M/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Currently, when adding memory, we create entries in /sys/firmware/memmap/
as "System RAM". This will lead to kexec-tools to add that memory to the
fixed-up initial memmap for a kexec kernel (loaded via kexec_load()). The
memory will be considered initial System RAM by the kexec'd kernel and
can no longer be reconfigured. This is not what happens during a real
reboot.

Let's add our memory via add_memory_driver_managed() now, so we won't
create entries in /sys/firmware/memmap/ and indicate the memory as
"System RAM (kmem)" in /proc/iomem. This allows everybody (especially
kexec-tools) to identify that this memory is special and has to be treated
differently than ordinary (hotplugged) System RAM.

Before configuring the namespace:
	[root@localhost ~]# cat /proc/iomem
	...
	140000000-33fffffff : Persistent Memory
	  140000000-33fffffff : namespace0.0
	3280000000-32ffffffff : PCI Bus 0000:00

After configuring the namespace:
	[root@localhost ~]# cat /proc/iomem
	...
	140000000-33fffffff : Persistent Memory
	  140000000-1481fffff : namespace0.0
	  148200000-33fffffff : dax0.0
	3280000000-32ffffffff : PCI Bus 0000:00

After loading kmem before this change:
	[root@localhost ~]# cat /proc/iomem
	...
	140000000-33fffffff : Persistent Memory
	  140000000-1481fffff : namespace0.0
	  150000000-33fffffff : dax0.0
	    150000000-33fffffff : System RAM
	3280000000-32ffffffff : PCI Bus 0000:00

After loading kmem after this change:
	[root@localhost ~]# cat /proc/iomem
	...
	140000000-33fffffff : Persistent Memory
	  140000000-1481fffff : namespace0.0
	  150000000-33fffffff : dax0.0
	    150000000-33fffffff : System RAM (kmem)
	3280000000-32ffffffff : PCI Bus 0000:00

After a proper reboot:
	[root@localhost ~]# cat /proc/iomem
	...
	140000000-33fffffff : Persistent Memory
	  140000000-1481fffff : namespace0.0
	  148200000-33fffffff : dax0.0
	3280000000-32ffffffff : PCI Bus 0000:00

Within the kexec kernel before this change:
	[root@localhost ~]# cat /proc/iomem
	...
	140000000-33fffffff : Persistent Memory
	  140000000-1481fffff : namespace0.0
	  150000000-33fffffff : System RAM
	3280000000-32ffffffff : PCI Bus 0000:00

Within the kexec kernel after this change:
	[root@localhost ~]# cat /proc/iomem
	...
	140000000-33fffffff : Persistent Memory
	  140000000-1481fffff : namespace0.0
	  148200000-33fffffff : dax0.0
	3280000000-32ffffffff : PCI Bus 0000:00

/sys/firmware/memmap/ before this change:
	0000000000000000-000000000009fc00 (System RAM)
	000000000009fc00-00000000000a0000 (Reserved)
	00000000000f0000-0000000000100000 (Reserved)
	0000000000100000-00000000bffdf000 (System RAM)
	00000000bffdf000-00000000c0000000 (Reserved)
	00000000feffc000-00000000ff000000 (Reserved)
	00000000fffc0000-0000000100000000 (Reserved)
	0000000100000000-0000000140000000 (System RAM)
	0000000150000000-0000000340000000 (System RAM)

/sys/firmware/memmap/ after a proper reboot:
	0000000000000000-000000000009fc00 (System RAM)
	000000000009fc00-00000000000a0000 (Reserved)
	00000000000f0000-0000000000100000 (Reserved)
	0000000000100000-00000000bffdf000 (System RAM)
	00000000bffdf000-00000000c0000000 (Reserved)
	00000000feffc000-00000000ff000000 (Reserved)
	00000000fffc0000-0000000100000000 (Reserved)
	0000000100000000-0000000140000000 (System RAM)

/sys/firmware/memmap/ after this change:
	0000000000000000-000000000009fc00 (System RAM)
	000000000009fc00-00000000000a0000 (Reserved)
	00000000000f0000-0000000000100000 (Reserved)
	0000000000100000-00000000bffdf000 (System RAM)
	00000000bffdf000-00000000c0000000 (Reserved)
	00000000feffc000-00000000ff000000 (Reserved)
	00000000fffc0000-0000000100000000 (Reserved)
	0000000100000000-0000000140000000 (System RAM)

kexec-tools already seem to basically ignore any System RAM that's not
on top level when searching for areas to place kexec images - but also
for determining crash areas to dump via kdump. Changing the resource name
won't have an impact.

Handle unloading of the driver after memory hotremove failed properly, by
duplicating the string if necessary.

Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/dax/dax-private.h |  1 +
 drivers/dax/kmem.c        | 28 ++++++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 3107ce80e809..16850d5388ab 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -44,6 +44,7 @@ struct dax_region {
  * @dev - device core
  * @pgmap - pgmap for memmap setup / lifetime (driver owned)
  * @dax_mem_res: physical address range of hotadded DAX memory
+ * @dax_mem_name: name for hotadded DAX memory via add_memory_driver_managed()
  */
 struct dev_dax {
 	struct dax_region *region;
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 1e678bdf5aed..275aa5f87399 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -14,6 +14,11 @@
 #include "dax-private.h"
 #include "bus.h"
 
+/* Memory resource name used for add_memory_driver_managed(). */
+static const char *kmem_name;
+/* Set if any memory will remain added when the driver will be unloaded. */
+static bool any_hotremove_failed;
+
 int dev_dax_kmem_probe(struct device *dev)
 {
 	struct dev_dax *dev_dax = to_dev_dax(dev);
@@ -70,7 +75,12 @@ int dev_dax_kmem_probe(struct device *dev)
 	 */
 	new_res->flags = IORESOURCE_SYSTEM_RAM;
 
-	rc = add_memory(numa_node, new_res->start, resource_size(new_res));
+	/*
+	 * Ensure that future kexec'd kernels will not treat this as RAM
+	 * automatically.
+	 */
+	rc = add_memory_driver_managed(numa_node, new_res->start,
+				       resource_size(new_res), kmem_name);
 	if (rc) {
 		release_resource(new_res);
 		kfree(new_res);
@@ -100,6 +110,7 @@ static int dev_dax_kmem_remove(struct device *dev)
 	 */
 	rc = remove_memory(dev_dax->target_node, kmem_start, kmem_size);
 	if (rc) {
+		any_hotremove_failed = true;
 		dev_err(dev,
 			"DAX region %pR cannot be hotremoved until the next reboot\n",
 			res);
@@ -124,6 +135,7 @@ static int dev_dax_kmem_remove(struct device *dev)
 	 * permanently pinned as reserved by the unreleased
 	 * request_mem_region().
 	 */
+	any_hotremove_failed = true;
 	return 0;
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */
@@ -137,12 +149,24 @@ static struct dax_device_driver device_dax_kmem_driver = {
 
 static int __init dax_kmem_init(void)
 {
-	return dax_driver_register(&device_dax_kmem_driver);
+	int rc;
+
+	/* Resource name is permanently allocated if any hotremove fails. */
+	kmem_name = kstrdup_const("System RAM (kmem)", GFP_KERNEL);
+	if (!kmem_name)
+		return -ENOMEM;
+
+	rc = dax_driver_register(&device_dax_kmem_driver);
+	if (rc)
+		kfree_const(kmem_name);
+	return rc;
 }
 
 static void __exit dax_kmem_exit(void)
 {
 	dax_driver_unregister(&device_dax_kmem_driver);
+	if (!any_hotremove_failed)
+		kfree_const(kmem_name);
 }
 
 MODULE_AUTHOR("Intel Corporation");
-- 
2.25.4
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

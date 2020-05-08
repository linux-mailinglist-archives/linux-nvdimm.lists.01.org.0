Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E2C1CA653
	for <lists+linux-nvdimm@lfdr.de>; Fri,  8 May 2020 10:42:46 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AFDB011842512;
	Fri,  8 May 2020 01:40:42 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5BADB11842514
	for <linux-nvdimm@lists.01.org>; Fri,  8 May 2020 01:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1588927362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DkYu0M5ykfG2hTZIF69XpJ1yEj1G8Eb0aQWKG7Ql4Yo=;
	b=VrhKDVZxN7ipTh6PWd+Pf18Ig0A3tVlJ9I64lPIH71Omag9bIc7CrS8Na/NkH5pcBHgY5X
	ikYiklzLkfg+dGRZzg00tUOCsAjfwSaedebjycC1HzWU1f/fcma56eVKuNPvuqCUn86Ome
	mYkbdYgzkqzDyM15XrCWmIrv2gzfj/M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-tCJpy3lUPhm-3mSbdHEKkg-1; Fri, 08 May 2020 04:42:36 -0400
X-MC-Unique: tCJpy3lUPhm-3mSbdHEKkg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D50980058A;
	Fri,  8 May 2020 08:42:34 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-181.ams2.redhat.com [10.36.113.181])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 90F2A5C1B0;
	Fri,  8 May 2020 08:42:31 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] mm/memory_hotplug: Introduce add_memory_driver_managed()
Date: Fri,  8 May 2020 10:42:15 +0200
Message-Id: <20200508084217.9160-3-david@redhat.com>
In-Reply-To: <20200508084217.9160-1-david@redhat.com>
References: <20200508084217.9160-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Message-ID-Hash: AIPMQE6QRZBWPC6LFUH3JYAQHS5RLBJF
X-Message-ID-Hash: AIPMQE6QRZBWPC6LFUH3JYAQHS5RLBJF
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-mm@kvack.org, linux-nvdimm@lists.01.org, kexec@lists.infradead.org, Pavel Tatashin <pasha.tatashin@soleen.com>, David Hildenbrand <david@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Wei Yang <richard.weiyang@gmail.com>, Baoquan He <bhe@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eric Biederman <ebiederm@xmission.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AIPMQE6QRZBWPC6LFUH3JYAQHS5RLBJF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Some device drivers rely on memory they managed to not get added to the
initial (firmware) memmap as system RAM - so it's not used as initial
system RAM by the kernel and the driver is under control. While this is the
case during cold boot and after a reboot, kexec is not aware of that and
might add such memory to the initial (firmware) memmap of the kexec kernel.
We need ways to teach kernel and userspace that this system ram is
different.

For example, dax/kmem allows to decide at runtime if persistent memory is
to be used as system ram. Another future user is virtio-mem, which has to
coordinate with its hypervisor to deal with inaccessible parts within
memory resources.

We want to let users in the kernel (esp. kexec) but also user space
(esp. kexec-tools) know that this memory has different semantics and
needs to be handled differently:
1. Don't create entries in /sys/firmware/memmap/
2. Name the memory resource "System RAM ($DRIVER)" (exposed via
   /proc/iomem) ($DRIVER might be "kmem", "virtio_mem").
3. Flag the memory resource IORESOURCE_MEM_DRIVER_MANAGED

/sys/firmware/memmap/ [1] represents the "raw firmware-provided memory map"
because "on most architectures that firmware-provided memory map is
modified afterwards by the kernel itself". The primary user is kexec on
x86-64. Since commit d96ae5309165 ("memory-hotplug: create
/sys/firmware/memmap entry for new memory"), we add all hotplugged
memory to that firmware memmap - which makes perfect sense for traditional
memory hotplug on x86-64, where real HW will also add hotplugged DIMMs to
the firmware memmap. We replicate what the "raw firmware-provided memory
map" looks like after hot(un)plug.

To keep things simple, let the user provide the full resource name
instead of only the driver name - this way, we don't have to manually
allocate/craft strings for memory resources. Also use the resource
name to make decisions, to avoid passing additional flags. In case the
name isn't "System RAM", it's special.

We don't have to worry about firmware_map_remove() on the removal path. If
there is no entry, it will simply return with -EINVAL.

We'll adapt dax/kmem in a follow-up patch.

[1] https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-firmware-memmap

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
 include/linux/ioport.h         |  1 +
 include/linux/memory_hotplug.h |  2 ++
 mm/memory_hotplug.c            | 62 +++++++++++++++++++++++++++++++---
 3 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index a9b9170b5dd2..cc9a5b4593ca 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -103,6 +103,7 @@ struct resource {
 #define IORESOURCE_MEM_32BIT		(3<<3)
 #define IORESOURCE_MEM_SHADOWABLE	(1<<5)	/* dup: IORESOURCE_SHADOWABLE */
 #define IORESOURCE_MEM_EXPANSIONROM	(1<<6)
+#define IORESOURCE_MEM_DRIVER_MANAGED	(1<<7)
 
 /* PnP I/O specific bits (IORESOURCE_BITS) */
 #define IORESOURCE_IO_16BIT_ADDR	(1<<0)
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 93d9ada74ddd..4abb87b328fd 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -349,6 +349,8 @@ extern void __ref free_area_init_core_hotplug(int nid);
 extern int __add_memory(int nid, u64 start, u64 size);
 extern int add_memory(int nid, u64 start, u64 size);
 extern int add_memory_resource(int nid, struct resource *resource);
+extern int add_memory_driver_managed(int nid, u64 start, u64 size,
+				     const char *resource_name);
 extern void move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
 		unsigned long nr_pages, struct vmem_altmap *altmap);
 extern void remove_pfn_range_from_zone(struct zone *zone,
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index fc0aad0bc1f5..c2d084d7c9c0 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -98,11 +98,14 @@ void mem_hotplug_done(void)
 u64 max_mem_size = U64_MAX;
 
 /* add this memory to iomem resource */
-static struct resource *register_memory_resource(u64 start, u64 size)
+static struct resource *register_memory_resource(u64 start, u64 size,
+						 const char *resource_name)
 {
 	struct resource *res;
 	unsigned long flags =  IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
-	char *resource_name = "System RAM";
+
+	if (strcmp(resource_name, "System RAM"))
+		flags |= IORESOURCE_MEM_DRIVER_MANAGED;
 
 	/*
 	 * Make sure value parsed from 'mem=' only restricts memory adding
@@ -1060,7 +1063,8 @@ int __ref add_memory_resource(int nid, struct resource *res)
 	BUG_ON(ret);
 
 	/* create new memmap entry */
-	firmware_map_add_hotplug(start, start + size, "System RAM");
+	if (!strcmp(res->name, "System RAM"))
+		firmware_map_add_hotplug(start, start + size, "System RAM");
 
 	/* device_online() will take the lock when calling online_pages() */
 	mem_hotplug_done();
@@ -1085,7 +1089,7 @@ int __ref __add_memory(int nid, u64 start, u64 size)
 	struct resource *res;
 	int ret;
 
-	res = register_memory_resource(start, size);
+	res = register_memory_resource(start, size, "System RAM");
 	if (IS_ERR(res))
 		return PTR_ERR(res);
 
@@ -1107,6 +1111,56 @@ int add_memory(int nid, u64 start, u64 size)
 }
 EXPORT_SYMBOL_GPL(add_memory);
 
+/*
+ * Add special, driver-managed memory to the system as system RAM. Such
+ * memory is not exposed via the raw firmware-provided memmap as system
+ * RAM, instead, it is detected and added by a driver - during cold boot,
+ * after a reboot, and after kexec.
+ *
+ * Reasons why this memory should not be used for the initial memmap of a
+ * kexec kernel or for placing kexec images:
+ * - The booting kernel is in charge of determining how this memory will be
+ *   used (e.g., use persistent memory as system RAM)
+ * - Coordination with a hypervisor is required before this memory
+ *   can be used (e.g., inaccessible parts).
+ *
+ * For this memory, no entries in /sys/firmware/memmap ("raw firmware-provided
+ * memory map") are created. Also, the created memory resource is flagged
+ * with IORESOURCE_MEM_DRIVER_MANAGED, so in-kernel users can special-case
+ * this memory as well (esp., not place kexec images onto it).
+ *
+ * The resource_name (visible via /proc/iomem) has to have the format
+ * "System RAM ($DRIVER)".
+ */
+int add_memory_driver_managed(int nid, u64 start, u64 size,
+			      const char *resource_name)
+{
+	struct resource *res;
+	int rc;
+
+	if (!resource_name ||
+	    strstr(resource_name, "System RAM (") != resource_name ||
+	    resource_name[strlen(resource_name) - 1] != ')')
+		return -EINVAL;
+
+	lock_device_hotplug();
+
+	res = register_memory_resource(start, size, resource_name);
+	if (IS_ERR(res)) {
+		rc = PTR_ERR(res);
+		goto out_unlock;
+	}
+
+	rc = add_memory_resource(nid, res);
+	if (rc < 0)
+		release_memory_resource(res);
+
+out_unlock:
+	unlock_device_hotplug();
+	return rc;
+}
+EXPORT_SYMBOL_GPL(add_memory_driver_managed);
+
 #ifdef CONFIG_MEMORY_HOTREMOVE
 /*
  * A free page on the buddy free lists (not the per-cpu lists) has PageBuddy
-- 
2.25.4
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

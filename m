Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75915264113
	for <lists+linux-nvdimm@lfdr.de>; Thu, 10 Sep 2020 11:14:22 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 310921412EDA0;
	Thu, 10 Sep 2020 02:14:21 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.120; helo=us-smtp-1.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [205.139.110.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6C8EA1412ED9F
	for <linux-nvdimm@lists.01.org>; Thu, 10 Sep 2020 02:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1599729258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zFptVInSDSbB2nDLyh5K9NKtnygiDyhn7CU7AXmV4mo=;
	b=IBKab27k1ICJ1KYiypDLgdQI71YLC5+2OcbZBblOrOXVLmjKEuC7XphMpeOdaRWuCd9xnJ
	0+ZEcf0llpqbuiuTVAmfXMR8dk5vBxrLqa8b4Uv7gILn07XvY3EUlSRuStX5/xcfDJJvh4
	lIwDpL4sJeFrGuupUIvJVzr5DtH5RgY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-O9Y06Jz4OkiDaTZaHIbCkg-1; Thu, 10 Sep 2020 05:14:16 -0400
X-MC-Unique: O9Y06Jz4OkiDaTZaHIbCkg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0280418B9F00;
	Thu, 10 Sep 2020 09:14:14 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-88.ams2.redhat.com [10.36.113.88])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D920727CCC;
	Thu, 10 Sep 2020 09:14:08 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/7] kernel/resource: move and rename IORESOURCE_MEM_DRIVER_MANAGED
Date: Thu, 10 Sep 2020 11:13:35 +0200
Message-Id: <20200910091340.8654-3-david@redhat.com>
In-Reply-To: <20200910091340.8654-1-david@redhat.com>
References: <20200910091340.8654-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Message-ID-Hash: W4BKDAEOYI6FL6CI772IQHP2UFOJMRBM
X-Message-ID-Hash: W4BKDAEOYI6FL6CI772IQHP2UFOJMRBM
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: virtualization@lists.linux-foundation.org, linux-mm@kvack.org, linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ardb@kernel.org>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Baoquan He <bhe@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/W4BKDAEOYI6FL6CI772IQHP2UFOJMRBM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

IORESOURCE_MEM_DRIVER_MANAGED currently uses an unused PnP bit, which is
always set to 0 by hardware. This is far from beautiful (and confusing),
and the bit only applies to SYSRAM. So let's move it out of the
bus-specific (PnP) defined bits.

We'll add another SYSRAM specific bit soon. If we ever need more bits for
other purposes, we can steal some from "desc", or reshuffle/regroup what we
have.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kexec@lists.infradead.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/ioport.h | 4 +++-
 kernel/kexec_file.c    | 2 +-
 mm/memory_hotplug.c    | 4 ++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 52a91f5fa1a36..d7620d7c941a0 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -58,6 +58,9 @@ struct resource {
 #define IORESOURCE_EXT_TYPE_BITS 0x01000000	/* Resource extended types */
 #define IORESOURCE_SYSRAM	0x01000000	/* System RAM (modifier) */
 
+/* IORESOURCE_SYSRAM specific bits. */
+#define IORESOURCE_SYSRAM_DRIVER_MANAGED	0x02000000 /* Always detected via a driver. */
+
 #define IORESOURCE_EXCLUSIVE	0x08000000	/* Userland may not map this resource */
 
 #define IORESOURCE_DISABLED	0x10000000
@@ -103,7 +106,6 @@ struct resource {
 #define IORESOURCE_MEM_32BIT		(3<<3)
 #define IORESOURCE_MEM_SHADOWABLE	(1<<5)	/* dup: IORESOURCE_SHADOWABLE */
 #define IORESOURCE_MEM_EXPANSIONROM	(1<<6)
-#define IORESOURCE_MEM_DRIVER_MANAGED	(1<<7)
 
 /* PnP I/O specific bits (IORESOURCE_BITS) */
 #define IORESOURCE_IO_16BIT_ADDR	(1<<0)
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index ca40bef75a616..dfeeed1aed084 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -520,7 +520,7 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
 	/* Returning 0 will take to next memory range */
 
 	/* Don't use memory that will be detected and handled by a driver. */
-	if (res->flags & IORESOURCE_MEM_DRIVER_MANAGED)
+	if (res->flags & IORESOURCE_SYSRAM_DRIVER_MANAGED)
 		return 0;
 
 	if (sz < kbuf->memsz)
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 4c47b68a9f4b5..8e1cd18b5cf14 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -105,7 +105,7 @@ static struct resource *register_memory_resource(u64 start, u64 size,
 	unsigned long flags =  IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
 
 	if (strcmp(resource_name, "System RAM"))
-		flags |= IORESOURCE_MEM_DRIVER_MANAGED;
+		flags |= IORESOURCE_SYSRAM_DRIVER_MANAGED;
 
 	/*
 	 * Make sure value parsed from 'mem=' only restricts memory adding
@@ -1160,7 +1160,7 @@ EXPORT_SYMBOL_GPL(add_memory);
  *
  * For this memory, no entries in /sys/firmware/memmap ("raw firmware-provided
  * memory map") are created. Also, the created memory resource is flagged
- * with IORESOURCE_MEM_DRIVER_MANAGED, so in-kernel users can special-case
+ * with IORESOURCE_SYSRAM_DRIVER_MANAGED, so in-kernel users can special-case
  * this memory as well (esp., not place kexec images onto it).
  *
  * The resource_name (visible via /proc/iomem) has to have the format
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

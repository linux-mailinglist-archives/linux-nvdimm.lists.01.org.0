Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 416B7269BDB
	for <lists+linux-nvdimm@lfdr.de>; Tue, 15 Sep 2020 04:20:36 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 56A481402D37C;
	Mon, 14 Sep 2020 19:20:34 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=richard.weiyang@linux.alibaba.com; receiver=<UNKNOWN> 
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BBDD91402D37B
	for <linux-nvdimm@lists.01.org>; Mon, 14 Sep 2020 19:20:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0U9-sPIq_1600136424;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U9-sPIq_1600136424)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Sep 2020 10:20:24 +0800
Date: Tue, 15 Sep 2020 10:20:23 +0800
From: Wei Yang <richard.weiyang@linux.alibaba.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 2/7] kernel/resource: move and rename
 IORESOURCE_MEM_DRIVER_MANAGED
Message-ID: <20200915022023.GD2007@L-31X9LVDL-1304.local>
References: <20200908201012.44168-1-david@redhat.com>
 <20200908201012.44168-3-david@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200908201012.44168-3-david@redhat.com>
Message-ID-Hash: 4RSJX5LBH7Q5SX3XQCT5IFA5WNLSPI2E
X-Message-ID-Hash: 4RSJX5LBH7Q5SX3XQCT5IFA5WNLSPI2E
X-MailFrom: richard.weiyang@linux.alibaba.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ardb@kernel.org>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Baoquan He <bhe@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4RSJX5LBH7Q5SX3XQCT5IFA5WNLSPI2E/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Sep 08, 2020 at 10:10:07PM +0200, David Hildenbrand wrote:
>IORESOURCE_MEM_DRIVER_MANAGED currently uses an unused PnP bit, which is
>always set to 0 by hardware. This is far from beautiful (and confusing),
>and the bit only applies to SYSRAM. So let's move it out of the
>bus-specific (PnP) defined bits.
>
>We'll add another SYSRAM specific bit soon. If we ever need more bits for
>other purposes, we can steal some from "desc", or reshuffle/regroup what we
>have.

I think you make this definition because we use IORESOURCE_SYSRAM_RAM for
hotpluged memory? So we make them all in IORESOURCE_SYSRAM_XXX family?

>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Michal Hocko <mhocko@suse.com>
>Cc: Dan Williams <dan.j.williams@intel.com>
>Cc: Jason Gunthorpe <jgg@ziepe.ca>
>Cc: Kees Cook <keescook@chromium.org>
>Cc: Ard Biesheuvel <ardb@kernel.org>
>Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>Cc: Baoquan He <bhe@redhat.com>
>Cc: Wei Yang <richardw.yang@linux.intel.com>
>Cc: Eric Biederman <ebiederm@xmission.com>
>Cc: Thomas Gleixner <tglx@linutronix.de>
>Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Cc: kexec@lists.infradead.org
>Signed-off-by: David Hildenbrand <david@redhat.com>
>---
> include/linux/ioport.h | 4 +++-
> kernel/kexec_file.c    | 2 +-
> mm/memory_hotplug.c    | 4 ++--
> 3 files changed, 6 insertions(+), 4 deletions(-)
>
>diff --git a/include/linux/ioport.h b/include/linux/ioport.h
>index 52a91f5fa1a36..d7620d7c941a0 100644
>--- a/include/linux/ioport.h
>+++ b/include/linux/ioport.h
>@@ -58,6 +58,9 @@ struct resource {
> #define IORESOURCE_EXT_TYPE_BITS 0x01000000	/* Resource extended types */
> #define IORESOURCE_SYSRAM	0x01000000	/* System RAM (modifier) */
> 
>+/* IORESOURCE_SYSRAM specific bits. */
>+#define IORESOURCE_SYSRAM_DRIVER_MANAGED	0x02000000 /* Always detected via a driver. */
>+
> #define IORESOURCE_EXCLUSIVE	0x08000000	/* Userland may not map this resource */
> 
> #define IORESOURCE_DISABLED	0x10000000
>@@ -103,7 +106,6 @@ struct resource {
> #define IORESOURCE_MEM_32BIT		(3<<3)
> #define IORESOURCE_MEM_SHADOWABLE	(1<<5)	/* dup: IORESOURCE_SHADOWABLE */
> #define IORESOURCE_MEM_EXPANSIONROM	(1<<6)
>-#define IORESOURCE_MEM_DRIVER_MANAGED	(1<<7)
> 
> /* PnP I/O specific bits (IORESOURCE_BITS) */
> #define IORESOURCE_IO_16BIT_ADDR	(1<<0)
>diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>index ca40bef75a616..dfeeed1aed084 100644
>--- a/kernel/kexec_file.c
>+++ b/kernel/kexec_file.c
>@@ -520,7 +520,7 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
> 	/* Returning 0 will take to next memory range */
> 
> 	/* Don't use memory that will be detected and handled by a driver. */
>-	if (res->flags & IORESOURCE_MEM_DRIVER_MANAGED)
>+	if (res->flags & IORESOURCE_SYSRAM_DRIVER_MANAGED)
> 		return 0;
> 
> 	if (sz < kbuf->memsz)
>diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>index 4c47b68a9f4b5..8e1cd18b5cf14 100644
>--- a/mm/memory_hotplug.c
>+++ b/mm/memory_hotplug.c
>@@ -105,7 +105,7 @@ static struct resource *register_memory_resource(u64 start, u64 size,
> 	unsigned long flags =  IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> 
> 	if (strcmp(resource_name, "System RAM"))
>-		flags |= IORESOURCE_MEM_DRIVER_MANAGED;
>+		flags |= IORESOURCE_SYSRAM_DRIVER_MANAGED;
> 
> 	/*
> 	 * Make sure value parsed from 'mem=' only restricts memory adding
>@@ -1160,7 +1160,7 @@ EXPORT_SYMBOL_GPL(add_memory);
>  *
>  * For this memory, no entries in /sys/firmware/memmap ("raw firmware-provided
>  * memory map") are created. Also, the created memory resource is flagged
>- * with IORESOURCE_MEM_DRIVER_MANAGED, so in-kernel users can special-case
>+ * with IORESOURCE_SYSRAM_DRIVER_MANAGED, so in-kernel users can special-case
>  * this memory as well (esp., not place kexec images onto it).
>  *
>  * The resource_name (visible via /proc/iomem) has to have the format
>-- 
>2.26.2

-- 
Wei Yang
Help you, Help me
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

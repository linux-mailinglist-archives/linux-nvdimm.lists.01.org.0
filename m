Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B0D269C06
	for <lists+linux-nvdimm@lfdr.de>; Tue, 15 Sep 2020 04:43:59 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 345B41401B3E0;
	Mon, 14 Sep 2020 19:43:57 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=115.124.30.44; helo=out30-44.freemail.mail.aliyun.com; envelope-from=richard.weiyang@linux.alibaba.com; receiver=<UNKNOWN> 
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BEAB013D5CBA3
	for <linux-nvdimm@lists.01.org>; Mon, 14 Sep 2020 19:43:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=27;SR=0;TI=SMTPD_---0U9.4qNm_1600137829;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U9.4qNm_1600137829)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Sep 2020 10:43:49 +0800
Date: Tue, 15 Sep 2020 10:43:48 +0800
From: Wei Yang <richard.weiyang@linux.alibaba.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 5/8] mm/memory_hotplug: MEMHP_MERGE_RESOURCE to
 specify merging of System RAM resources
Message-ID: <20200915024348.GA2685@L-31X9LVDL-1304.local>
References: <20200911103459.10306-1-david@redhat.com>
 <20200911103459.10306-6-david@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200911103459.10306-6-david@redhat.com>
Message-ID-Hash: 34OU25IOTH7ZOZSP7CMDWRB2AESDUUNN
X-Message-ID-Hash: 34OU25IOTH7ZOZSP7CMDWRB2AESDUUNN
X-MailFrom: richard.weiyang@linux.alibaba.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>, Julien Grall <julien@xen.org>, Baoquan He <bhe@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/34OU25IOTH7ZOZSP7CMDWRB2AESDUUNN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2020 at 12:34:56PM +0200, David Hildenbrand wrote:
>Some add_memory*() users add memory in small, contiguous memory blocks.
>Examples include virtio-mem, hyper-v balloon, and the XEN balloon.
>
>This can quickly result in a lot of memory resources, whereby the actual
>resource boundaries are not of interest (e.g., it might be relevant for
>DIMMs, exposed via /proc/iomem to user space). We really want to merge
>added resources in this scenario where possible.
>
>Let's provide a flag (MEMHP_MERGE_RESOURCE) to specify that a resource
>either created within add_memory*() or passed via add_memory_resource()
>shall be marked mergeable and merged with applicable siblings.
>
>To implement that, we need a kernel/resource interface to mark selected
>System RAM resources mergeable (IORESOURCE_SYSRAM_MERGEABLE) and trigger
>merging.
>
>Note: We really want to merge after the whole operation succeeded, not
>directly when adding a resource to the resource tree (it would break
>add_memory_resource() and require splitting resources again when the
>operation failed - e.g., due to -ENOMEM).

Oops, the latest version is here.

BTW, I don't see patch 4. Not sure it is junked by my mail system?

>
>Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Michal Hocko <mhocko@suse.com>
>Cc: Dan Williams <dan.j.williams@intel.com>
>Cc: Jason Gunthorpe <jgg@ziepe.ca>
>Cc: Kees Cook <keescook@chromium.org>
>Cc: Ard Biesheuvel <ardb@kernel.org>
>Cc: Thomas Gleixner <tglx@linutronix.de>
>Cc: "K. Y. Srinivasan" <kys@microsoft.com>
>Cc: Haiyang Zhang <haiyangz@microsoft.com>
>Cc: Stephen Hemminger <sthemmin@microsoft.com>
>Cc: Wei Liu <wei.liu@kernel.org>
>Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>Cc: Juergen Gross <jgross@suse.com>
>Cc: Stefano Stabellini <sstabellini@kernel.org>
>Cc: Roger Pau Monn=E9 <roger.pau@citrix.com>
>Cc: Julien Grall <julien@xen.org>
>Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>Cc: Baoquan He <bhe@redhat.com>
>Cc: Wei Yang <richardw.yang@linux.intel.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>
>---
> include/linux/ioport.h         |  4 +++
> include/linux/memory_hotplug.h |  7 ++++
> kernel/resource.c              | 60 ++++++++++++++++++++++++++++++++++
> mm/memory_hotplug.c            |  7 ++++
> 4 files changed, 78 insertions(+)
>
>diff --git a/include/linux/ioport.h b/include/linux/ioport.h
>index d7620d7c941a0..7e61389dcb017 100644
>--- a/include/linux/ioport.h
>+++ b/include/linux/ioport.h
>@@ -60,6 +60,7 @@ struct resource {
>=20
> /* IORESOURCE_SYSRAM specific bits. */
> #define IORESOURCE_SYSRAM_DRIVER_MANAGED	0x02000000 /* Always detected vi=
a a driver. */
>+#define IORESOURCE_SYSRAM_MERGEABLE		0x04000000 /* Resource can be merged=
. */
>=20
> #define IORESOURCE_EXCLUSIVE	0x08000000	/* Userland may not map this reso=
urce */
>=20
>@@ -253,6 +254,9 @@ extern void __release_region(struct resource *, resour=
ce_size_t,
> extern void release_mem_region_adjustable(struct resource *, resource_siz=
e_t,
> 					  resource_size_t);
> #endif
>+#ifdef CONFIG_MEMORY_HOTPLUG
>+extern void merge_system_ram_resource(struct resource *res);
>+#endif
>=20
> /* Wrappers for managed devices */
> struct device;
>diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug=
.h
>index 33eb80fdba22f..d65c6fdc5cfc3 100644
>--- a/include/linux/memory_hotplug.h
>+++ b/include/linux/memory_hotplug.h
>@@ -62,6 +62,13 @@ typedef int __bitwise mhp_t;
>=20
> /* No special request */
> #define MHP_NONE		((__force mhp_t)0)
>+/*
>+ * Allow merging of the added System RAM resource with adjacent,
>+ * mergeable resources. After a successful call to add_memory_resource()
>+ * with this flag set, the resource pointer must no longer be used as it
>+ * might be stale, or the resource might have changed.
>+ */
>+#define MEMHP_MERGE_RESOURCE	((__force mhp_t)BIT(0))
>=20
> /*
>  * Extended parameters for memory hotplug:
>diff --git a/kernel/resource.c b/kernel/resource.c
>index 36b3552210120..7a91b935f4c20 100644
>--- a/kernel/resource.c
>+++ b/kernel/resource.c
>@@ -1363,6 +1363,66 @@ void release_mem_region_adjustable(struct resource =
*parent,
> }
> #endif	/* CONFIG_MEMORY_HOTREMOVE */
>=20
>+#ifdef CONFIG_MEMORY_HOTPLUG
>+static bool system_ram_resources_mergeable(struct resource *r1,
>+					   struct resource *r2)
>+{
>+	/* We assume either r1 or r2 is IORESOURCE_SYSRAM_MERGEABLE. */
>+	return r1->flags =3D=3D r2->flags && r1->end + 1 =3D=3D r2->start &&
>+	       r1->name =3D=3D r2->name && r1->desc =3D=3D r2->desc &&
>+	       !r1->child && !r2->child;
>+}
>+
>+/*
>+ * merge_system_ram_resource - mark the System RAM resource mergeable and=
 try to
>+ * merge it with adjacent, mergeable resources
>+ * @res: resource descriptor
>+ *
>+ * This interface is intended for memory hotplug, whereby lots of contigu=
ous
>+ * system ram resources are added (e.g., via add_memory*()) by a driver, =
and
>+ * the actual resource boundaries are not of interest (e.g., it might be
>+ * relevant for DIMMs). Only resources that are marked mergeable, that ha=
ve the
>+ * same parent, and that don't have any children are considered. All merg=
eable
>+ * resources must be immutable during the request.
>+ *
>+ * Note:
>+ * - The caller has to make sure that no pointers to resources that are
>+ *   marked mergeable are used anymore after this call - the resource mig=
ht
>+ *   be freed and the pointer might be stale!
>+ * - release_mem_region_adjustable() will split on demand on memory hotun=
plug
>+ */
>+void merge_system_ram_resource(struct resource *res)
>+{
>+	const unsigned long flags =3D IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
>+	struct resource *cur;
>+
>+	if (WARN_ON_ONCE((res->flags & flags) !=3D flags))
>+		return;
>+
>+	write_lock(&resource_lock);
>+	res->flags |=3D IORESOURCE_SYSRAM_MERGEABLE;
>+
>+	/* Try to merge with next item in the list. */
>+	cur =3D res->sibling;
>+	if (cur && system_ram_resources_mergeable(res, cur)) {
>+		res->end =3D cur->end;
>+		res->sibling =3D cur->sibling;
>+		free_resource(cur);
>+	}
>+
>+	/* Try to merge with previous item in the list. */
>+	cur =3D res->parent->child;
>+	while (cur && cur->sibling !=3D res)
>+		cur =3D cur->sibling;
>+	if (cur && system_ram_resources_mergeable(cur, res)) {
>+		cur->end =3D res->end;
>+		cur->sibling =3D res->sibling;
>+		free_resource(res);
>+	}
>+	write_unlock(&resource_lock);
>+}
>+#endif	/* CONFIG_MEMORY_HOTPLUG */
>+
> /*
>  * Managed region resource
>  */
>diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>index 8f0bd7c9a63a5..553c718226b3e 100644
>--- a/mm/memory_hotplug.c
>+++ b/mm/memory_hotplug.c
>@@ -1102,6 +1102,13 @@ int __ref add_memory_resource(int nid, struct resou=
rce *res, mhp_t mhp_flags)
> 	/* device_online() will take the lock when calling online_pages() */
> 	mem_hotplug_done();
>=20
>+	/*
>+	 * In case we're allowed to merge the resource, flag it and trigger
>+	 * merging now that adding succeeded.
>+	 */
>+	if (mhp_flags & MEMHP_MERGE_RESOURCE)
>+		merge_system_ram_resource(res);
>+
> 	/* online pages if requested */
> 	if (memhp_default_online_type !=3D MMOP_OFFLINE)
> 		walk_memory_blocks(start, size, NULL, online_memory_block);
>--=20
>2.26.2

--=20
Wei Yang
Help you, Help me
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

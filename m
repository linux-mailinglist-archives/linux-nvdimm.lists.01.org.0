Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CD423182D
	for <lists+linux-nvdimm@lfdr.de>; Wed, 29 Jul 2020 05:35:33 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2E7FF1143B072;
	Tue, 28 Jul 2020 20:35:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=justin.he@arm.com; receiver=<UNKNOWN> 
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by ml01.01.org (Postfix) with ESMTP id 060AF11001AB9
	for <linux-nvdimm@lists.01.org>; Tue, 28 Jul 2020 20:35:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22CD631B;
	Tue, 28 Jul 2020 20:35:28 -0700 (PDT)
Received: from localhost.localdomain (entos-thunderx2-02.shanghai.arm.com [10.169.212.213])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A76983F66E;
	Tue, 28 Jul 2020 20:35:20 -0700 (PDT)
From: Jia He <justin.he@arm.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Mike Rapoport <rppt@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>
Subject: [RFC PATCH 2/6] resource: export find_next_iomem_res() helper
Date: Wed, 29 Jul 2020 11:34:20 +0800
Message-Id: <20200729033424.2629-3-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729033424.2629-1-justin.he@arm.com>
References: <20200729033424.2629-1-justin.he@arm.com>
Message-ID-Hash: 7RP4CSUI4DOCLVXRJ7SS3YX6AR55NS3Q
X-Message-ID-Hash: 7RP4CSUI4DOCLVXRJ7SS3YX6AR55NS3Q
X-MailFrom: justin.he@arm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Steve Capper <steve.capper@arm.com>, Mark Rutland <mark.rutland@arm.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Hsin-Yi Wang <hsinyi@chromium.org>, Jason Gunthorpe <jgg@ziepe.ca>, Dave Hansen <dave.hansen@linux.intel.com>, Kees Cook <keescook@chromium.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Kaly Xin <Kaly.Xin@arm.com>, Jia He <justin.he@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7RP4CSUI4DOCLVXRJ7SS3YX6AR55NS3Q/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The helper is to find the lowest iomem resource that covers part of
[@start..@end]

It is useful when relaxing the alignment check for dax pmem kmem.

Signed-off-by: Jia He <justin.he@arm.com>
---
 include/linux/ioport.h | 3 +++
 kernel/resource.c      | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 6c2b06fe8beb..203fd16c9f45 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -247,6 +247,9 @@ extern struct resource * __request_region(struct resource *,
 
 extern void __release_region(struct resource *, resource_size_t,
 				resource_size_t);
+extern int find_next_iomem_res(resource_size_t start, resource_size_t end,
+			       unsigned long flags, unsigned long desc,
+			       bool first_lvl, struct resource *res);
 #ifdef CONFIG_MEMORY_HOTREMOVE
 extern int release_mem_region_adjustable(struct resource *, resource_size_t,
 				resource_size_t);
diff --git a/kernel/resource.c b/kernel/resource.c
index 841737bbda9e..57e6a6802a3d 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -338,7 +338,7 @@ EXPORT_SYMBOL(release_resource);
  * @first_lvl:	walk only the first level children, if set
  * @res:	return ptr, if resource found
  */
-static int find_next_iomem_res(resource_size_t start, resource_size_t end,
+int find_next_iomem_res(resource_size_t start, resource_size_t end,
 			       unsigned long flags, unsigned long desc,
 			       bool first_lvl, struct resource *res)
 {
@@ -391,6 +391,7 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 	read_unlock(&resource_lock);
 	return p ? 0 : -ENODEV;
 }
+EXPORT_SYMBOL(find_next_iomem_res);
 
 static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
 				 unsigned long flags, unsigned long desc,
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

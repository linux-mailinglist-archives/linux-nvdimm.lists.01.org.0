Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333C736747
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 Jun 2019 00:13:08 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0FEFA212909E3;
	Wed,  5 Jun 2019 15:13:07 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.120; helo=mga04.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id EF85D2128DD59
 for <linux-nvdimm@lists.01.org>; Wed,  5 Jun 2019 15:13:04 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Jun 2019 15:13:04 -0700
X-ExtLoop1: 1
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by fmsmga008.fm.intel.com with ESMTP; 05 Jun 2019 15:13:04 -0700
Subject: [PATCH v9 09/12] mm: Document ZONE_DEVICE memory-model implications
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Date: Wed, 05 Jun 2019 14:58:47 -0700
Message-ID: <155977192794.2443951.16177998596403034849.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155977186863.2443951.9036044808311959913.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155977186863.2443951.9036044808311959913.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
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
Cc: mhocko@suse.com, linux-nvdimm@lists.01.org,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org, osalvador@suse.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Explain the general mechanisms of 'ZONE_DEVICE' pages and list the users
of 'devm_memremap_pages()'.

Cc: Jonathan Corbet <corbet@lwn.net>
Reported-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/vm/memory-model.rst |   39 +++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/vm/memory-model.rst b/Documentation/vm/memory-model.rst
index 382f72ace1fc..e0af47e02e78 100644
--- a/Documentation/vm/memory-model.rst
+++ b/Documentation/vm/memory-model.rst
@@ -181,3 +181,42 @@ that is eventually passed to vmemmap_populate() through a long chain
 of function calls. The vmemmap_populate() implementation may use the
 `vmem_altmap` along with :c:func:`altmap_alloc_block_buf` helper to
 allocate memory map on the persistent memory device.
+
+ZONE_DEVICE
+===========
+The `ZONE_DEVICE` facility builds upon `SPARSEMEM_VMEMMAP` to offer
+`struct page` `mem_map` services for device driver identified physical
+address ranges. The "device" aspect of `ZONE_DEVICE` relates to the fact
+that the page objects for these address ranges are never marked online,
+and that a reference must be taken against the device, not just the page
+to keep the memory pinned for active use. `ZONE_DEVICE`, via
+:c:func:`devm_memremap_pages`, performs just enough memory hotplug to
+turn on :c:func:`pfn_to_page`, :c:func:`page_to_pfn`, and
+:c:func:`get_user_pages` service for the given range of pfns. Since the
+page reference count never drops below 1 the page is never tracked as
+free memory and the page's `struct list_head lru` space is repurposed
+for back referencing to the host device / driver that mapped the memory.
+
+While `SPARSEMEM` presents memory as a collection of sections,
+optionally collected into memory blocks, `ZONE_DEVICE` users have a need
+for smaller granularity of populating the `mem_map`. Given that
+`ZONE_DEVICE` memory is never marked online it is subsequently never
+subject to its memory ranges being exposed through the sysfs memory
+hotplug api on memory block boundaries. The implementation relies on
+this lack of user-api constraint to allow sub-section sized memory
+ranges to be specified to :c:func:`arch_add_memory`, the top-half of
+memory hotplug. Sub-section support allows for `PMD_SIZE` as the minimum
+alignment granularity for :c:func:`devm_memremap_pages`.
+
+The users of `ZONE_DEVICE` are:
+* pmem: Map platform persistent memory to be used as a direct-I/O target
+  via DAX mappings.
+
+* hmm: Extend `ZONE_DEVICE` with `->page_fault()` and `->page_free()`
+  event callbacks to allow a device-driver to coordinate memory management
+  events related to device-memory, typically GPU memory. See
+  Documentation/vm/hmm.rst.
+
+* p2pdma: Create `struct page` objects to allow peer devices in a
+  PCI/-E topology to coordinate direct-DMA operations between themselves,
+  i.e. bypass host memory.

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

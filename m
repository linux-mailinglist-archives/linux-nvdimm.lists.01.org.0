Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD192116B
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 May 2019 02:47:29 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 45B8F2125584C;
	Thu, 16 May 2019 17:47:27 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.88; helo=mga01.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E3F7121250447
 for <linux-nvdimm@lists.01.org>; Thu, 16 May 2019 17:47:25 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 May 2019 17:47:25 -0700
X-ExtLoop1: 1
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by orsmga008.jf.intel.com with ESMTP; 16 May 2019 17:47:25 -0700
Subject: [PATCH] libnvdimm/pmem: Bypass CONFIG_HARDENED_USERCOPY overhead
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Thu, 16 May 2019 17:33:38 -0700
Message-ID: <155805321833.867447.3864104616303535270.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Cc: Jeff Smits <jeff.smits@intel.com>, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Jeff discovered that performance improves from ~375K iops to ~519K iops
on a simple psync-write fio workload when moving the location of 'struct
page' from the default PMEM location to DRAM. This result is surprising
because the expectation is that 'struct page' for dax is only needed for
third party references to dax mappings. For example, a dax-mapped buffer
passed to another system call for direct-I/O requires 'struct page' for
sending the request down the driver stack and pinning the page. There is
no usage of 'struct page' for first party access to a file via
read(2)/write(2) and friends.

However, this "no page needed" expectation is violated by
CONFIG_HARDENED_USERCOPY and the check_copy_size() performed in
copy_from_iter_full_nocache() and copy_to_iter_mcsafe(). The
check_heap_object() helper routine assumes the buffer is backed by a
page-allocator DRAM page and applies some checks.  Those checks are
invalid, dax pages are not from the heap, and redundant,
dax_iomap_actor() has already validated that the I/O is within bounds.

Bypass this overhead and call the 'no check' versions of the
copy_{to,from}_iter operations directly.

Fixes: 0aed55af8834 ("x86, uaccess: introduce copy_from_iter_flushcache...")
Cc: Jan Kara <jack@suse.cz>
Cc: <stable@vger.kernel.org>
Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Matthew Wilcox <willy@infradead.org>
Reported-and-tested-by: Jeff Smits <jeff.smits@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/pmem.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 845c5b430cdd..c894f45e5077 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -281,16 +281,21 @@ static long pmem_dax_direct_access(struct dax_device *dax_dev,
 	return __pmem_direct_access(pmem, pgoff, nr_pages, kaddr, pfn);
 }
 
+/*
+ * Use the 'no check' versions of copy_from_iter_flushcache() and
+ * copy_to_iter_mcsafe() to bypass HARDENED_USERCOPY overhead. Bounds
+ * checking is handled by dax_iomap_actor()
+ */
 static size_t pmem_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff,
 		void *addr, size_t bytes, struct iov_iter *i)
 {
-	return copy_from_iter_flushcache(addr, bytes, i);
+	return _copy_from_iter_flushcache(addr, bytes, i);
 }
 
 static size_t pmem_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff,
 		void *addr, size_t bytes, struct iov_iter *i)
 {
-	return copy_to_iter_mcsafe(addr, bytes, i);
+	return _copy_to_iter_mcsafe(addr, bytes, i);
 }
 
 static const struct dax_operations pmem_dax_ops = {

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

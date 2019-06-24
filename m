Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D1B51AA1
	for <lists+linux-nvdimm@lfdr.de>; Mon, 24 Jun 2019 20:33:58 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4E1532129DBAD;
	Mon, 24 Jun 2019 11:33:57 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.43; helo=mga05.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 06CBF212909E0
 for <linux-nvdimm@lists.01.org>; Mon, 24 Jun 2019 11:33:55 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Jun 2019 11:33:55 -0700
X-IronPort-AV: E=Sophos;i="5.63,413,1557212400"; d="scan'208";a="184212692"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Jun 2019 11:33:54 -0700
Subject: [PATCH v4 02/10] acpi/numa/hmat: Skip publishing target info for
 nodes with no online memory
From: Dan Williams <dan.j.williams@intel.com>
To: x86@kernel.org
Date: Mon, 24 Jun 2019 11:19:37 -0700
Message-ID: <156140037770.2951909.3387200938880485927.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156140036490.2951909.1837804994781523185.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156140036490.2951909.1837804994781523185.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Cc: ard.biesheuvel@linaro.org, peterz@infradead.org,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, tglx@linutronix.de, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

There are multiple scenarios where the HMAT may contain information
about proximity domains that are not currently online. Rather than fail
to report any HMAT data just elide those offline domains.

If and when those domains are later onlined they can be added to the
HMEM reporting at that point.

This was found while testing EFI_MEMORY_SP support which reserves
"specific purpose" memory from the general allocation pool. If that
reservation results in an empty numa-node then the node is not marked
online leading a spurious:

    "acpi/hmat: Ignoring HMAT: Invalid table"

...result for HMAT parsing.

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/numa/hmat.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 96b7d39a97c6..2c220cb7b620 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -96,9 +96,6 @@ static __init void alloc_memory_target(unsigned int mem_pxm)
 {
 	struct memory_target *target;
 
-	if (pxm_to_node(mem_pxm) == NUMA_NO_NODE)
-		return;
-
 	target = find_mem_target(mem_pxm);
 	if (target)
 		return;
@@ -588,6 +585,17 @@ static __init void hmat_register_targets(void)
 	struct memory_target *target;
 
 	list_for_each_entry(target, &targets, node) {
+		int nid = pxm_to_node(target->memory_pxm);
+
+		/*
+		 * Skip offline nodes. This can happen when memory
+		 * marked EFI_MEMORY_SP, "specific purpose", is applied
+		 * to all the memory in a promixity domain leading to
+		 * the node being marked offline / unplugged, or if
+		 * memory-only "hotplug" node is offline.
+		 */
+		if (nid == NUMA_NO_NODE || !node_online(nid))
+			continue;
 		hmat_register_target_initiators(target);
 		hmat_register_target_perf(target);
 	}

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

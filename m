Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E54418EA68
	for <lists+linux-nvdimm@lfdr.de>; Sun, 22 Mar 2020 17:29:02 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C38FC10FC378A;
	Sun, 22 Mar 2020 09:29:51 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EE3CD10FC3789
	for <linux-nvdimm@lists.01.org>; Sun, 22 Mar 2020 09:29:49 -0700 (PDT)
IronPort-SDR: HmlFwYvJJYvmGMwN/HWHEIa1tMnLKTDN1XKEaARXrnmeVh3yM3ZxQUTumUHumtUu/x011Jqfob
 6DEULiJB5f3Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2020 09:28:59 -0700
IronPort-SDR: um5GE78ju4nfrA/VjdbZYcOGGU/BRuJmmu5A67WcdWOPvsUY1RVM1iFWn91ruJto9s2Xz6JB2p
 6PDNOOMfrC7g==
X-IronPort-AV: E=Sophos;i="5.72,293,1580803200";
   d="scan'208";a="239698755"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2020 09:28:59 -0700
Subject: [PATCH v2 5/6] resource: Report parent to walk_iomem_res_desc()
 callback
From: Dan Williams <dan.j.williams@intel.com>
To: linux-acpi@vger.kernel.org
Date: Sun, 22 Mar 2020 09:12:53 -0700
Message-ID: <158489357311.1457606.12568065258967741013.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158489354353.1457606.8327903161927980740.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158489354353.1457606.8327903161927980740.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: CXAUMS7LM4RWIKFAVYNDS3HT6JJTICNF
X-Message-ID-Hash: CXAUMS7LM4RWIKFAVYNDS3HT6JJTICNF
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jason Gunthorpe <jgg@ziepe.ca>, Dave Hansen <dave.hansen@linux.intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, peterz@infradead.org, ard.biesheuvel@linaro.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, x86@kernel.org, joao.m.martins@oracle.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CXAUMS7LM4RWIKFAVYNDS3HT6JJTICNF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In support of detecting whether a resource might have been been claimed,
report the parent to the walk_iomem_res_desc() callback. For example,
the ACPI HMAT parser publishes "hmem" platform devices per target range.
However, if the HMAT is disabled / missing a fallback driver can attach
devices to the raw memory ranges as a fallback if it sees unclaimed /
orphan "Soft Reserved" resources in the resource tree.

Otherwise, find_next_iomem_res() returns a resource with garbage data
from the stack allocation in __walk_iomem_res_desc() for the res->parent
field.

There are currently no users that expect ->child and ->sibling to be
valid, and the resource_lock would be needed to traverse them. Use a
compound literal to implicitly zero initialize the fields that are not
being returned in addition to setting ->parent.

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 kernel/resource.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 76036a41143b..f54ccf7a1009 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -382,10 +382,13 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 
 	if (p) {
 		/* copy data */
-		res->start = max(start, p->start);
-		res->end = min(end, p->end);
-		res->flags = p->flags;
-		res->desc = p->desc;
+		*res = (struct resource) {
+			.start = max(start, p->start),
+			.end = min(end, p->end),
+			.flags = p->flags,
+			.desc = p->desc,
+			.parent = p->parent,
+		};
 	}
 
 	read_unlock(&resource_lock);
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

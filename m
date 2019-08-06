Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C67828A9
	for <lists+linux-nvdimm@lfdr.de>; Tue,  6 Aug 2019 02:24:05 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 370402132997C;
	Mon,  5 Aug 2019 17:26:34 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.126; helo=mga18.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id EB33721329975
 for <linux-nvdimm@lists.01.org>; Mon,  5 Aug 2019 17:26:32 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Aug 2019 17:24:02 -0700
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; d="scan'208";a="373877399"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Aug 2019 17:24:00 -0700
Subject: [ndctl PATCH v5 7/7] ndctl/namespace: Report ENOSPC when regions
 are full
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Mon, 05 Aug 2019 17:09:42 -0700
Message-ID: <156505018281.848599.6510034459473826921.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156505014382.848599.16271067825582995055.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156505014382.848599.16271067825582995055.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

The create-namespace error message:

    failed to create namespace: Resource temporarily unavailable

...is misleading because the lack of capacity is permanent until the
user frees up space.

Trap EAGAIN and translate to ENOSPC in case the region capacity search
fails:

    failed to create namespace: No space left on device

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 ndctl/namespace.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index 5c457224cb13..89113f760bbf 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -1415,6 +1415,15 @@ static int do_xaction_namespace(const char *namespace,
 		}
 	}
 
+	if (action == ACTION_CREATE && rc == -EAGAIN) {
+		/*
+		 * Namespace creation searched through all candidate
+		 * regions and all of them said "nope, I don't have
+		 * enough capacity", so report -ENOSPC
+		 */
+		rc = -ENOSPC;
+	}
+
 	return rc;
 }
 

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

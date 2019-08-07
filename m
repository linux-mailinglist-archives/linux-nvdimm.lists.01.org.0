Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6A28559F
	for <lists+linux-nvdimm@lfdr.de>; Thu,  8 Aug 2019 00:18:23 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 83B252131D575;
	Wed,  7 Aug 2019 15:20:51 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.126; helo=mga18.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 8C6712131D565
 for <linux-nvdimm@lists.01.org>; Wed,  7 Aug 2019 15:20:50 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Aug 2019 15:18:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,358,1559545200"; d="scan'208";a="203354362"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.185])
 by fmsmga002.fm.intel.com with ESMTP; 07 Aug 2019 15:18:19 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH] Documentation/namespace-description: Clarify label-less
 restrictions
Date: Wed,  7 Aug 2019 16:18:15 -0600
Message-Id: <20190807221815.25782-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
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

In the ndctl-create-namespace (and related) man pages, add a
clarification note regarding some of the restrictions a user may see
when operating on label-less namespaces.

Link: https://github.com/pmem/ndctl/issues/52
Reported-by: Jane Chu <jane.chu@oracle.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 Documentation/ndctl/namespace-description.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/ndctl/namespace-description.txt b/Documentation/ndctl/namespace-description.txt
index 94999e5..5f294be 100644
--- a/Documentation/ndctl/namespace-description.txt
+++ b/Documentation/ndctl/namespace-description.txt
@@ -18,6 +18,12 @@ the kernel's 'memmap=ss!nn' command line option (see the nvdimm wiki on
 kernel.org), or NVDIMMs without a valid 'namespace index' in their label
 area.
 
+NOTE: Label-less namespaces lack many of the features of their label-rich
+cousins. For example, their size cannot be modified, or they cannot be
+'destroyed' (only disabled). The only operation supported on them is to
+change their 'mode', by adding on-media metadata which is then used to
+identify an address abstraction mechanism for the namespace.
+
 A namespace can be provisioned to operate in one of 4 modes, 'fsdax',
 'devdax', 'sector', and 'raw'. Here are the expected usage models for
 these modes:
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5B714E2DA
	for <lists+linux-nvdimm@lfdr.de>; Thu, 30 Jan 2020 20:02:44 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9B15A1007B1F3;
	Thu, 30 Jan 2020 11:06:00 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C61AE1007B8FB
	for <linux-nvdimm@lists.01.org>; Thu, 30 Jan 2020 11:05:58 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2020 10:56:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,382,1574150400";
   d="scan'208";a="402420327"
Received: from vverma7-desk1.amr.corp.intel.com (HELO vverma7-desk1.lm.intel.com) ([10.232.112.164])
  by orsmga005.jf.intel.com with ESMTP; 30 Jan 2020 10:56:48 -0800
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [ndctl PATCH] ndctl/lib: make dimm_ops in private.h extern
Date: Thu, 30 Jan 2020 11:56:31 -0700
Message-Id: <20200130185631.29817-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Message-ID-Hash: R5ZIST2JSMQU7Y7ZOTCUPRGZOU5IAEGY
X-Message-ID-Hash: R5ZIST2JSMQU7Y7ZOTCUPRGZOU5IAEGY
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/R5ZIST2JSMQU7Y7ZOTCUPRGZOU5IAEGY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

A toolchain update in Fedora 32 caused new compile errors due to
multiple definitions of dimm_ops structures. The declarations in
'private.h' for the various NFIT families are present so that libndctl
can find all the per-family dimm-ops. However they need to be declared
as extern because the actual definitions are in <family>.c

Cc: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 ndctl/lib/private.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/ndctl/lib/private.h b/ndctl/lib/private.h
index e445301..16bf8f9 100644
--- a/ndctl/lib/private.h
+++ b/ndctl/lib/private.h
@@ -343,10 +343,10 @@ struct ndctl_dimm_ops {
 	int (*xlat_firmware_status)(struct ndctl_cmd *);
 };
 
-struct ndctl_dimm_ops * const intel_dimm_ops;
-struct ndctl_dimm_ops * const hpe1_dimm_ops;
-struct ndctl_dimm_ops * const msft_dimm_ops;
-struct ndctl_dimm_ops * const hyperv_dimm_ops;
+extern struct ndctl_dimm_ops * const intel_dimm_ops;
+extern struct ndctl_dimm_ops * const hpe1_dimm_ops;
+extern struct ndctl_dimm_ops * const msft_dimm_ops;
+extern struct ndctl_dimm_ops * const hyperv_dimm_ops;
 
 static inline struct ndctl_bus *cmd_to_bus(struct ndctl_cmd *cmd)
 {
-- 
2.21.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

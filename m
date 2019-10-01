Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1A1C3EB8
	for <lists+linux-nvdimm@lfdr.de>; Tue,  1 Oct 2019 19:37:37 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DFC7310FC71FD;
	Tue,  1 Oct 2019 10:39:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BA23810FC71F8
	for <linux-nvdimm@lists.01.org>; Tue,  1 Oct 2019 10:38:59 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 10:37:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200";
   d="scan'208";a="392528614"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.164])
  by fmsmga006.fm.intel.com with ESMTP; 01 Oct 2019 10:37:31 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH] libdaxctl: fix memory leaks with daxctl_memory objects
Date: Tue,  1 Oct 2019 11:37:26 -0600
Message-Id: <20191001173726.21846-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Message-ID-Hash: HOIHSIO7TXP36EB5VXMRXASACJIS65HE
X-Message-ID-Hash: HOIHSIO7TXP36EB5VXMRXASACJIS65HE
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Michal Biesek <michal.biesek@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <>
List-Archive: <>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The daxctl_dev_alloc_mem() helper which is used to instantiate a new
memory object did so, but neglected to attach the memory object to the
parent 'dev' object. As a result, every invocation of
'daxctl_dev_get_memory() resulted in a new, orphan memory object being
created, which also resulted in libdaxctl leaking memory.

Fix the parent association for 'mem' objects, and in free_mem, remove
the check for 'dev' being present - mem objects will always associated
with a dev.

Additionally, we were neglecting to free 'mem->mem_buf' in free_mem, so
fix this up as well.

Fixes: e8bf803e359b ("libdaxctl: add a 'daxctl_memory' object for memory based operations")
Link: https://github.com/pmem/ndctl/issues/112
Reported-by: Michal Biesek <michal.biesek@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 daxctl/lib/libdaxctl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index 8abfd64..639224c 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -204,8 +204,9 @@ DAXCTL_EXPORT void daxctl_region_get_uuid(struct daxctl_region *region, uuid_t u
 
 static void free_mem(struct daxctl_dev *dev)
 {
-	if (dev && dev->mem) {
+	if (dev->mem) {
 		free(dev->mem->node_path);
+		free(dev->mem->mem_buf);
 		free(dev->mem);
 		dev->mem = NULL;
 	}
@@ -450,6 +451,7 @@ static struct daxctl_memory *daxctl_dev_alloc_mem(struct daxctl_dev *dev)
 		goto err_node;
 	mem->buf_len = strlen(node_base) + 256;
 
+	dev->mem = mem;
 	return mem;
 
 err_node:
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

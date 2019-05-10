Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 378871A356
	for <lists+linux-nvdimm@lfdr.de>; Fri, 10 May 2019 21:08:51 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E872A2126CF9C;
	Fri, 10 May 2019 12:08:48 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.88; helo=mga01.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 22962212377E1
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 12:08:45 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 May 2019 12:08:44 -0700
X-ExtLoop1: 1
Received: from vverma7-desk1.lm.intel.com ([10.232.112.185])
 by orsmga007.jf.intel.com with ESMTP; 10 May 2019 12:08:44 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH 4/4] ndctl/namespace.c: Fix a potential integer overflow
Date: Fri, 10 May 2019 13:08:39 -0600
Message-Id: <20190510190839.29637-5-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190510190839.29637-1-vishal.l.verma@intel.com>
References: <20190510190839.29637-1-vishal.l.verma@intel.com>
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

Static analysis warns that we may cause an integer overflow when
left-shifting bb->len in nstype_clear_badblocks(). While it is unlikely
to trigger this in real-world usage, since bb->len is limited by the
kernel, the fix is is a trivial cast, and it quells the warning, and
increases our robustness.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 ndctl/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index 31e6ecd..58a9e3c 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -1146,7 +1146,7 @@ static int nstype_clear_badblocks(struct ndctl_namespace *ndns,
 		unsigned long long bb_begin, bb_end, bb_len;
 
 		bb_begin = region_begin + (bb->offset << 9);
-		bb_len = bb->len << 9;
+		bb_len = (unsigned long long)bb->len << 9;
 		bb_end = bb_begin + bb_len - 1;
 
 		/* bb is not fully contained in the usable area */
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F4643249
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Jun 2019 05:10:43 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3FA1821296070;
	Wed, 12 Jun 2019 20:10:42 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.88; helo=mga01.intel.com;
 envelope-from=alison.schofield@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 3F8E721296069
 for <linux-nvdimm@lists.01.org>; Wed, 12 Jun 2019 20:10:39 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Jun 2019 20:10:38 -0700
X-ExtLoop1: 1
Received: from alison-desk.jf.intel.com ([10.54.74.53])
 by orsmga001.jf.intel.com with ESMTP; 12 Jun 2019 20:10:38 -0700
Date: Wed, 12 Jun 2019 20:13:51 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH] ndctl, test: move security.sh to the destructive test
 list
Message-ID: <20190613031351.GA19074@alison-desk.jf.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
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

security.sh changes the hosts key configuration. It is
not guaranteed to reach its cleanup phase and restore the
host configuration. Until we can isolate the test and host
configurations, move this to the ENABLE_DESTRUCTIVE set of
tests.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 test/Makefile.am | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/test/Makefile.am b/test/Makefile.am
index 42009c3..874c4bb 100644
--- a/test/Makefile.am
+++ b/test/Makefile.am
@@ -27,10 +27,6 @@ TESTS =\
 	max_available_extent_ns.sh \
 	pfn-meta-errors.sh
 
-if ENABLE_KEYUTILS
-TESTS += security.sh
-endif
-
 check_PROGRAMS =\
 	libndctl \
 	dsm-fail \
@@ -55,6 +51,10 @@ TESTS +=\
 	device-dax-fio.sh \
 	mmap.sh
 
+if ENABLE_KEYUTILS
+TESTS += security.sh
+endif
+
 check_PROGRAMS +=\
 	blk-ns \
 	pmem-ns \
-- 
2.21.0

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

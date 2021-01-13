Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 284402F44FB
	for <lists+linux-nvdimm@lfdr.de>; Wed, 13 Jan 2021 08:15:14 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C9583100EB326;
	Tue, 12 Jan 2021 23:15:12 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5A0C9100EB325
	for <linux-nvdimm@lists.01.org>; Tue, 12 Jan 2021 23:15:10 -0800 (PST)
IronPort-SDR: lJmW0lwIEoDFisvKaGsMptzxArfRvE4ZpwUEoXwJWp4bLRGg5Id5SDtiR5wskG13cty496QTtT
 PPcYPXyghUDQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="165250663"
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400";
   d="scan'208";a="165250663"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 23:15:09 -0800
IronPort-SDR: WvvCil86LLqhmtJueHzsSnDgcuBsx8a0kxDjsjKyr/heFFE9r6TMZVeWX62m8V8+WabYrWqVuo
 SP06PoL25bdA==
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400";
   d="scan'208";a="381739835"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 23:15:09 -0800
Subject: [ndctl PATCH 3/4] ndctl/test: Fix device-dax mremap() test
From: Dan Williams <dan.j.williams@intel.com>
To: vishal.l.verma@intel.com
Date: Tue, 12 Jan 2021 23:15:09 -0800
Message-ID: <161052210936.1804207.17896246772670985157.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161052209289.1804207.11599120961607513911.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161052209289.1804207.11599120961607513911.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: WMKP5N4EZAP7US3T46CGDK4WGRKLVR7N
X-Message-ID-Hash: WMKP5N4EZAP7US3T46CGDK4WGRKLVR7N
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WMKP5N4EZAP7US3T46CGDK4WGRKLVR7N/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The test_dax_remap() test is a regression check for mishandling of mremap()
in the presence of pmd_devmap(). My understanding is that it was a fuzzing
condition not something an application would want to do in practice.

On recent kernels with commit 73d5e0629919 ("mremap: check if it's possible
to split original vma"), the test fails for device-dax. That seems an
equally acceptable result of attempting this remap, so update the test
rather than ask the kernel to preserve the old behaviour.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test/dax-pmd.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/test/dax-pmd.c b/test/dax-pmd.c
index b1251db63041..7648e348b0a6 100644
--- a/test/dax-pmd.c
+++ b/test/dax-pmd.c
@@ -69,6 +69,11 @@ int test_dax_remap(struct ndctl_test *test, int dax_fd, unsigned long align, voi
 
 	remap = mremap(addr, REMAP_SIZE, REMAP_SIZE, MREMAP_MAYMOVE|MREMAP_FIXED, anon);
 
+	if (remap == MAP_FAILED) {
+		fprintf(stderr, "%s: mremap failed, that's ok too\n", __func__);
+		return 0;
+	}
+
 	if (remap != anon) {
 		rc = -ENXIO;
 		perror("mremap");
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

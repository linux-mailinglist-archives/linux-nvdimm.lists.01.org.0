Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FD322A46F
	for <lists+linux-nvdimm@lfdr.de>; Thu, 23 Jul 2020 03:18:29 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 846ED124B445E;
	Wed, 22 Jul 2020 18:18:27 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8AB87123323D2
	for <linux-nvdimm@lists.01.org>; Wed, 22 Jul 2020 18:18:25 -0700 (PDT)
IronPort-SDR: 6DkMM46T6iXroZACxaIY0KsFwCPJLzjsHQPbmSoO5E/K1xemdFE5lCueZySj4om941+vTTEOmx
 GhWLSDPIxOSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="150434263"
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800";
   d="scan'208";a="150434263"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 18:18:24 -0700
IronPort-SDR: TqB/ygLKZ5Ngd0Lm4i0UzCt5Rb2vPVBcLyo7hEM9TWy/GZBGZPVf6Td4tJ8qyuEYRYXwkoHtY3
 pFbA3zDuJEQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800";
   d="scan'208";a="272160023"
Received: from vverma7-mobl4.lm.intel.com ([10.255.75.57])
  by fmsmga008.fm.intel.com with ESMTP; 22 Jul 2020 18:18:24 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
	Santosh Sivaraj <santosh@fossix.org>
Subject: [ndctl PATCH] ndctl/lib: fix new symbol location in the symbol script
Date: Wed, 22 Jul 2020 19:00:34 -0600
Message-Id: <20200723010034.28561-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Message-ID-Hash: 6ATHMND3SXTYZQF5NCPYGVNIBR336UVI
X-Message-ID-Hash: 6ATHMND3SXTYZQF5NCPYGVNIBR336UVI
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6ATHMND3SXTYZQF5NCPYGVNIBR336UVI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The commit referenced below added a new symbol in an existing section in
the symbol script, which is incorrect. Move it to the new LIBNDCTL_24
section.

Fixes: 1e840d56f123 ("Skip region filtering if numa_node attribute is not present")
Cc: Santosh Sivaraj <santosh@fossix.org>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 ndctl/lib/libndctl.sym | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ndctl/lib/libndctl.sym b/ndctl/lib/libndctl.sym
index 805c3ca..7ba1dcc 100644
--- a/ndctl/lib/libndctl.sym
+++ b/ndctl/lib/libndctl.sym
@@ -430,10 +430,10 @@ LIBNDCTL_23 {
 	ndctl_region_get_target_node;
 	ndctl_region_get_align;
 	ndctl_region_set_align;
-	ndctl_region_has_numa;
 } LIBNDCTL_22;
 
 LIBNDCTL_24 {
 	ndctl_bus_has_of_node;
 	ndctl_bus_is_papr_scm;
+	ndctl_region_has_numa;
 } LIBNDCTL_23;
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

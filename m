Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5502F44F8
	for <lists+linux-nvdimm@lfdr.de>; Wed, 13 Jan 2021 08:15:03 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 80110100EB323;
	Tue, 12 Jan 2021 23:15:02 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6CF67100EB323
	for <linux-nvdimm@lists.01.org>; Tue, 12 Jan 2021 23:15:00 -0800 (PST)
IronPort-SDR: K1DsPY5PsOIdqkyQz5Ue1vpC+/+nwV6394f38qeo9zZXSVNtc/9HBCqqh7yixNcysY26PE6wjA
 0THCJcERNi1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="165838245"
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400";
   d="scan'208";a="165838245"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 23:14:59 -0800
IronPort-SDR: /bSuLbuqQuIqUVQI5dXxDNBvf9XoJRR1ktwkR9QVhy59N6TPj5wYnucTKLbkW2CeflQpXHACn+
 bZeUOC19HXWA==
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400";
   d="scan'208";a="345446680"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 23:14:58 -0800
Subject: [ndctl PATCH 1/4] ndctl/test: Fix btt expect table compile warning
From: Dan Williams <dan.j.williams@intel.com>
To: vishal.l.verma@intel.com
Date: Tue, 12 Jan 2021 23:14:58 -0800
Message-ID: <161052209839.1804207.11951679046842122849.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161052209289.1804207.11599120961607513911.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161052209289.1804207.11599120961607513911.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: AC6Q3F3Z4FSASXCGETQPKSPQIU3UYMRX
X-Message-ID-Hash: AC6Q3F3Z4FSASXCGETQPKSPQIU3UYMRX
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AC6Q3F3Z4FSASXCGETQPKSPQIU3UYMRX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

../test/libndctl.c:989:2: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
  989 |  unsigned long long expect_table[][2] = {
      |  ^~~~~~~~

...just move the declaration a few lines up.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test/libndctl.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/test/libndctl.c b/test/libndctl.c
index 24d72b382239..fc651499cc86 100644
--- a/test/libndctl.c
+++ b/test/libndctl.c
@@ -980,12 +980,6 @@ static int check_btt_size(struct ndctl_btt *btt)
 	struct ndctl_ctx *ctx = ndctl_btt_get_ctx(btt);
 	struct ndctl_test *test = ndctl_get_private_data(ctx);
 	struct ndctl_namespace *ndns = ndctl_btt_get_namespace(btt);
-
-	if (!ndns)
-		return -ENXIO;
-
-	ns_size = ndctl_namespace_get_size(ndns);
-	sect_size = ndctl_btt_get_sector_size(btt);
 	unsigned long long expect_table[][2] = {
 		[0] = {
 			[0] = 0x11b5400,
@@ -1001,6 +995,12 @@ static int check_btt_size(struct ndctl_btt *btt)
 		},
 	};
 
+	if (!ndns)
+		return -ENXIO;
+
+	ns_size = ndctl_namespace_get_size(ndns);
+	sect_size = ndctl_btt_get_sector_size(btt);
+
 	if (sect_size >= SZ_4K)
 		sect_select = 1;
 	else if (sect_size >= 512)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

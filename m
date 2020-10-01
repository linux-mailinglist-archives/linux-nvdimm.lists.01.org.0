Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3EB2807DB
	for <lists+linux-nvdimm@lfdr.de>; Thu,  1 Oct 2020 21:38:30 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2651C155D74EA;
	Thu,  1 Oct 2020 12:38:29 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C12D5155D74E9
	for <linux-nvdimm@lists.01.org>; Thu,  1 Oct 2020 12:38:26 -0700 (PDT)
IronPort-SDR: KJMqu4Y4pmLhmq+rQmOxcCOSkYSX1/U9EjuJN9k1FVWW7IaLmpiEkeQGCXWrXStoqz0h2JPpZC
 9pHrf9FSs9ow==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="226944934"
X-IronPort-AV: E=Sophos;i="5.77,324,1596524400";
   d="scan'208";a="226944934"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 12:38:23 -0700
IronPort-SDR: eKgkDWww0mzeNYx2OhFK+78ELAwMQs75cTF2UIhoXQyFR9A6Jz1bP9nd0EBPArQ6c0GlQDrGdw
 dGHjkOV39OVw==
X-IronPort-AV: E=Sophos;i="5.77,324,1596524400";
   d="scan'208";a="351279753"
Received: from loppedah-mobl.amr.corp.intel.com (HELO omniknight.intel.com) ([10.212.30.3])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 12:38:23 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH 2/2] ndctl/inject-error: remove logically dead code
Date: Thu,  1 Oct 2020 13:38:16 -0600
Message-Id: <20201001193816.975987-2-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001193816.975987-1-vishal.l.verma@intel.com>
References: <20201001193816.975987-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Message-ID-Hash: DJLG3EUYUWBSQ3UZPXC5O5SETTACIXIV
X-Message-ID-Hash: DJLG3EUYUWBSQ3UZPXC5O5SETTACIXIV
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DJLG3EUYUWBSQ3UZPXC5O5SETTACIXIV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Static analysis reports that the bb != NULL check is redundant because
ndctl_namespace_bb_foreach already uses that as a loop condition. Remove
it.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 ndctl/inject-error.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/ndctl/inject-error.c b/ndctl/inject-error.c
index fe599ef..f6be6a5 100644
--- a/ndctl/inject-error.c
+++ b/ndctl/inject-error.c
@@ -255,9 +255,6 @@ static int injection_status(struct ndctl_namespace *ndns)
 	}
 
 	ndctl_namespace_bb_foreach(ndns, bb) {
-		if (!bb)
-			break;
-
 		block = ndctl_bb_get_block(bb);
 		count = ndctl_bb_get_count(bb);
 		jbb = util_badblock_rec_to_json(block, count, ictx.json_flags);
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

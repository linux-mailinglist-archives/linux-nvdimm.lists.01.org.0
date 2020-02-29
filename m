Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6C4174937
	for <lists+linux-nvdimm@lfdr.de>; Sat, 29 Feb 2020 21:36:23 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 365F810FC33FC;
	Sat, 29 Feb 2020 12:37:14 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 494771003ECB6
	for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 12:37:12 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:36:20 -0800
X-IronPort-AV: E=Sophos;i="5.70,501,1574150400";
   d="scan'208";a="242720783"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:36:19 -0800
Subject: [ndctl PATCH 02/36] ndctl/docs: Fix mailing list sign-up link
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: vishal.l.verma@intel.com
Date: Sat, 29 Feb 2020 12:20:15 -0800
Message-ID: <158300761503.2141307.17033588170622633523.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: SZWYRPZ4YGUQSP3KBOWPDPLUQGTQFLFU
X-Message-ID-Hash: SZWYRPZ4YGUQSP3KBOWPDPLUQGTQFLFU
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SZWYRPZ4YGUQSP3KBOWPDPLUQGTQFLFU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

At some point 01.org switched its mailing list management software from
Mailman to Postorious. Update the stale mailman link.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 CONTRIBUTING.md |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
index 811a8c0ad7da..4c29d31e49e9 100644
--- a/CONTRIBUTING.md
+++ b/CONTRIBUTING.md
@@ -6,7 +6,7 @@ The following is a set of guidelines that we adhere to, and request that
 contributors follow.
 
 1. The libnvdimm (kernel subsystem) and ndctl developers primarily use
-   the [linux-nvdimm](https://lists.01.org/mailman/listinfo/linux-nvdimm)
+   the [linux-nvdimm](https://lists.01.org/postorius/lists/linux-nvdimm.lists.01.org/)
    mailing list for everything. It is recommended to send patches to
    **```linux-nvdimm@lists.01.org```**
 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

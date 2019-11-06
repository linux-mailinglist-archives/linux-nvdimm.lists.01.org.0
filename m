Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD333F1DC9
	for <lists+linux-nvdimm@lfdr.de>; Wed,  6 Nov 2019 19:50:59 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A8F02100DC3E7;
	Wed,  6 Nov 2019 10:53:30 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DA953100DC3E6
	for <linux-nvdimm@lists.01.org>; Wed,  6 Nov 2019 10:53:28 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 10:50:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400";
   d="scan'208";a="232977899"
Received: from vverma7-desk1.amr.corp.intel.com (HELO vverma7-desk1.lm.intel.com) ([10.232.112.164])
  by fmsmga002.fm.intel.com with ESMTP; 06 Nov 2019 10:50:54 -0800
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH] ndctl/README: Update kernel documentation URL
Date: Wed,  6 Nov 2019 11:50:52 -0700
Message-Id: <20191106185052.11889-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Message-ID-Hash: WCA42BWPPVD6WXW4RR3RDOIQXOUPD45O
X-Message-ID-Hash: WCA42BWPPVD6WXW4RR3RDOIQXOUPD45O
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WCA42BWPPVD6WXW4RR3RDOIQXOUPD45O/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Commit ae4a05027e2f ("docs: nvdimm: add it to the driver-api book") in
the kernel changes the location of the NVDIMM documentation. Use
this chance to update the documentation link in ndctl to the Sphinx
rendered HTML documentation hosted on kernel.org.

Link: https://github.com/pmem/ndctl/issues/120
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 README.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README.md b/README.md
index 690d152..d296c6b 100644
--- a/README.md
+++ b/README.md
@@ -26,7 +26,7 @@ Documentation
 =============
 See the latest documentation for the NVDIMM kernel sub-system here:
   
-https://git.kernel.org/cgit/linux/kernel/git/nvdimm/nvdimm.git/tree/Documentation/nvdimm/nvdimm.txt?h=libnvdimm-for-next
+https://www.kernel.org/doc/html/latest/driver-api/nvdimm/index.html
 
 A getting started guide is also available on the kernel.org nvdimm wiki:
 
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 934741B45CD
	for <lists+linux-nvdimm@lfdr.de>; Wed, 22 Apr 2020 15:05:49 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7674A100DCB83;
	Wed, 22 Apr 2020 06:05:30 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F061B100DCB82
	for <linux-nvdimm@lists.01.org>; Wed, 22 Apr 2020 06:05:25 -0700 (PDT)
IronPort-SDR: QYivWG5tLzdmGJjIX0yXnc6cf4vDMgA2NhAqgwBFl87OTCX9PFv/x7v/gh+vWiOULSDLHg7lEU
 ImkomNBpXaNw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 06:05:42 -0700
IronPort-SDR: 1VVwYofEwm+7xNQOaxbE+TCOJKj1R+Awu15slTuIyqZF482jOj/CUXhwbuBC+qsXLdGg/OhUXG
 xpMKxHIpHLxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,414,1580803200";
   d="scan'208";a="244509689"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 22 Apr 2020 06:05:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D97D758F; Wed, 22 Apr 2020 16:05:39 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	linux-nvdimm@lists.01.org
Subject: [PATCH v1] libnvdimm: Replace guid_copy() with import_guid() where it makes sense
Date: Wed, 22 Apr 2020 16:05:39 +0300
Message-Id: <20200422130539.45636-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Message-ID-Hash: JS2VTTHWCVGFMIWJYSPB4V3MCFCLH22K
X-Message-ID-Hash: JS2VTTHWCVGFMIWJYSPB4V3MCFCLH22K
X-MailFrom: andriy.shevchenko@linux.intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JS2VTTHWCVGFMIWJYSPB4V3MCFCLH22K/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

There is a specific API to treat raw data as GUID, i.e. import_guid().
Use it instead of guid_copy() with explicit casting.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/nfit/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index fa4500f9cfd13..7c138a4edc03e 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2293,7 +2293,7 @@ static int acpi_nfit_init_interleave_set(struct acpi_nfit_desc *acpi_desc,
 	nd_set = devm_kzalloc(dev, sizeof(*nd_set), GFP_KERNEL);
 	if (!nd_set)
 		return -ENOMEM;
-	guid_copy(&nd_set->type_guid, (guid_t *) spa->range_guid);
+	import_guid(&nd_set->type_guid, spa->range_guid);
 
 	info = devm_kzalloc(dev, sizeof_nfit_set_info(nr), GFP_KERNEL);
 	if (!info)
-- 
2.26.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

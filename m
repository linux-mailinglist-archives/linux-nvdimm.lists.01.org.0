Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E40BF360B2E
	for <lists+linux-nvdimm@lfdr.de>; Thu, 15 Apr 2021 15:58:59 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CDB92100EAB59;
	Thu, 15 Apr 2021 06:58:57 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=<UNKNOWN> 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9FA6C100EAB58
	for <linux-nvdimm@lists.01.org>; Thu, 15 Apr 2021 06:58:54 -0700 (PDT)
IronPort-SDR: znVKVLoLzUznXg9iEQO8v9AEpOytZKCaxQ6/vO52oGf3FKN51SI0tacpDEuRyCYY6KVYYuU3ix
 yr03DwdVeN5A==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="191665867"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400";
   d="scan'208";a="191665867"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 06:58:53 -0700
IronPort-SDR: 1Ero4IpCmY7zN/BTHjiLpTX2bZF4Yh00EOPhGr04YRY+PryaHh50jCkmxU7H3tJHVBvXgIoVkE
 ovqkuIFI+rDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400";
   d="scan'208";a="425186820"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 15 Apr 2021 06:58:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 7C258BA; Thu, 15 Apr 2021 16:59:05 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>,
	linux-nvdimm@lists.01.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] ACPI: NFIT: Import GUID before use
Date: Thu, 15 Apr 2021 16:59:01 +0300
Message-Id: <20210415135901.47131-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Message-ID-Hash: FOJVVCAJX6HFC2MMKER75JUDW5ECR233
X-Message-ID-Hash: FOJVVCAJX6HFC2MMKER75JUDW5ECR233
X-MailFrom: andriy.shevchenko@linux.intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FOJVVCAJX6HFC2MMKER75JUDW5ECR233/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Strictly speaking the comparison between guid_t and raw buffer
is not correct. Import GUID to variable of guid_t type and then
compare.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/nfit/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 958aaac869e8..6d8a1a93636a 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -678,10 +678,12 @@ static const char *spa_type_name(u16 type)
 
 int nfit_spa_type(struct acpi_nfit_system_address *spa)
 {
+	guid_t guid;
 	int i;
 
+	import_guid(&guid, spa->range_guid);
 	for (i = 0; i < NFIT_UUID_MAX; i++)
-		if (guid_equal(to_nfit_uuid(i), (guid_t *)&spa->range_guid))
+		if (guid_equal(to_nfit_uuid(i), &guid))
 			return i;
 	return -1;
 }
-- 
2.30.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

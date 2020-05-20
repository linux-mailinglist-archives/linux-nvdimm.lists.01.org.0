Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF23D1DC25A
	for <lists+linux-nvdimm@lfdr.de>; Thu, 21 May 2020 00:50:58 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EC56E11F4E931;
	Wed, 20 May 2020 15:47:29 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8F76D11F4E92C
	for <linux-nvdimm@lists.01.org>; Wed, 20 May 2020 15:47:28 -0700 (PDT)
IronPort-SDR: pc2FYexahHSDVBaIVditZySCsAQmbCtmU/LUm/o/2dqARZNHNV/MHS6tb7XqqCEDexRCjOz5ea
 Vzt0NWvZAmKw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 15:50:55 -0700
IronPort-SDR: P9eAfb7+H7rUdPwKIyyRqSs6DbejNQPD2A+cj7uzy7krKfx2UvrV2rPqXeXzoyC22VezhipXbl
 c/6FPNxqT2ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,415,1583222400";
   d="scan'208";a="308859546"
Received: from vverma7-mobl4.lm.intel.com ([10.251.149.210])
  by FMSMGA003.fm.intel.com with ESMTP; 20 May 2020 15:50:54 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH] nvdimm/region: always show the 'align' attribute
Date: Wed, 20 May 2020 16:50:26 -0600
Message-Id: <20200520225026.29426-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Message-ID-Hash: YVYV5RHEC7L3RWOL3XMGHKHTQK4OMXQT
X-Message-ID-Hash: YVYV5RHEC7L3RWOL3XMGHKHTQK4OMXQT
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YVYV5RHEC7L3RWOL3XMGHKHTQK4OMXQT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

It is possible that a platform that is capable of 'namespace labels'
comes up without the labels properly initialized. In this case, the
region's 'align' attribute is hidden. Howerver, once the user does
initialize he labels, the 'align' attribute still stays hidden, which is
unexpected.

The sysfs_update_group() API is meant to address this, and could be
called during region probe, but it has entanglements with the device
'lockdep_mutex'. Therefore, simply make the 'align' attribute always
visible. It doesn't matter what it says for label-less namespaces, since
it is not possible to change their allocation anyway.

Cc: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 drivers/nvdimm/region_devs.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index ccbb5b43b8b2..4502f9c4708d 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -679,18 +679,8 @@ static umode_t region_visible(struct kobject *kobj, struct attribute *a, int n)
 		return a->mode;
 	}
 
-	if (a == &dev_attr_align.attr) {
-		int i;
-
-		for (i = 0; i < nd_region->ndr_mappings; i++) {
-			struct nd_mapping *nd_mapping = &nd_region->mapping[i];
-			struct nvdimm *nvdimm = nd_mapping->nvdimm;
-
-			if (test_bit(NDD_LABELING, &nvdimm->flags))
-				return a->mode;
-		}
-		return 0;
-	}
+	if (a == &dev_attr_align.attr)
+		return a->mode;
 
 	if (a != &dev_attr_set_cookie.attr
 			&& a != &dev_attr_available_size.attr)
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

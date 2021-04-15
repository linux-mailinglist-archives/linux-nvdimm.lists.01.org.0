Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D3E360BF2
	for <lists+linux-nvdimm@lfdr.de>; Thu, 15 Apr 2021 16:37:50 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B381D100EAB60;
	Thu, 15 Apr 2021 07:37:48 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D7416100EAB5E
	for <linux-nvdimm@lists.01.org>; Thu, 15 Apr 2021 07:37:45 -0700 (PDT)
IronPort-SDR: Gyo8ZpL+q0VQfTafuKEoT79ZAr8dtEuJFRVukAvqwVW9nLdhD0uxVIGUNotQmbHEh1Ybky2IQA
 ol7tZdEQH20w==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="258822464"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400";
   d="scan'208";a="258822464"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 07:37:45 -0700
IronPort-SDR: BGvb9CnNE+3hJ44yKpVysWJC+0nWnLvDs07AdBmA8RvT2cyO9ZO2b/1AZAPc890tzjU2q07BEU
 W5yJm7549imQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400";
   d="scan'208";a="382745459"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 15 Apr 2021 07:37:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A7483BA; Thu, 15 Apr 2021 17:37:59 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-nvdimm@lists.01.org,
	linux-kernel@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v1 1/1] libnvdimm: Don't use GUID APIs against raw buffer
Date: Thu, 15 Apr 2021 17:37:54 +0300
Message-Id: <20210415143754.16553-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Message-ID-Hash: M25BLCI4X5MDRTPXM3RTDLJGGBMFZPKG
X-Message-ID-Hash: M25BLCI4X5MDRTPXM3RTDLJGGBMFZPKG
X-MailFrom: andriy.shevchenko@linux.intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/M25BLCI4X5MDRTPXM3RTDLJGGBMFZPKG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Strictly speaking the comparison between guid_t and raw buffer
is not correct. Return to plain memcmp() since the data structures
haven't changed to use uuid_t / guid_t the current state of affairs
is inconsistent. Either it should be changed altogether or left
as is.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/nvdimm/btt_devs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvdimm/btt_devs.c b/drivers/nvdimm/btt_devs.c
index 05feb97e11ce..82bcd2e86a18 100644
--- a/drivers/nvdimm/btt_devs.c
+++ b/drivers/nvdimm/btt_devs.c
@@ -244,13 +244,14 @@ struct device *nd_btt_create(struct nd_region *nd_region)
  */
 bool nd_btt_arena_is_valid(struct nd_btt *nd_btt, struct btt_sb *super)
 {
+	static const u8 null_uuid[16];
 	const u8 *parent_uuid = nd_dev_to_uuid(&nd_btt->ndns->dev);
 	u64 checksum;
 
 	if (memcmp(super->signature, BTT_SIG, BTT_SIG_LEN) != 0)
 		return false;
 
-	if (!guid_is_null((guid_t *)&super->parent_uuid))
+	if (memcmp(super->parent_uuid, null_uuid, 16) != 0)
 		if (memcmp(super->parent_uuid, parent_uuid, 16) != 0)
 			return false;
 
-- 
2.30.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

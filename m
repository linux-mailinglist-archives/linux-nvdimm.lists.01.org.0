Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5892F4548
	for <lists+linux-nvdimm@lfdr.de>; Wed, 13 Jan 2021 08:35:54 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7B99E100EB32F;
	Tue, 12 Jan 2021 23:35:53 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 10AA2100EB32F
	for <linux-nvdimm@lists.01.org>; Tue, 12 Jan 2021 23:35:51 -0800 (PST)
IronPort-SDR: Rd0q+RR+JxNXQlncllqY3Z6QXe6qgIihjxGEu/yc6brpGAcSELafV7K7T60uB6XFL3jatbtX01
 JkNdOBG7ZT5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="165252721"
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400";
   d="scan'208";a="165252721"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 23:35:50 -0800
IronPort-SDR: d8GujxA6lUoNjhNaAJz9tCcEE8MtX/S74Fsm93UPPhEDTmgKMmxzwKKQoyDeaITQtrNsVU9w4Y
 vwsXOaj6HKog==
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400";
   d="scan'208";a="404741126"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 23:35:50 -0800
Subject: [PATCH v3 6/6] libnvdimm/namespace: Fix visibility of namespace
 resource attribute
From: Dan Williams <dan.j.williams@intel.com>
To: linux-mm@kvack.org
Date: Tue, 12 Jan 2021 23:35:50 -0800
Message-ID: <161052334995.1805594.12054873528154362921.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161052331545.1805594.2356512831689786960.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161052331545.1805594.2356512831689786960.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: Q5X7SFFDMQMST6IB5ADMLJKUCWEM35EM
X-Message-ID-Hash: Q5X7SFFDMQMST6IB5ADMLJKUCWEM35EM
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: stable@vger.kernel.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Q5X7SFFDMQMST6IB5ADMLJKUCWEM35EM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Legacy pmem namespaces lost support for the "resource" attribute when
the code was cleaned up to put the permission visibility in the
declaration. Restore this by listing 'resource' in the default
attributes.

A new ndctl regression test for pfn_to_online_page() corner cases builds
on this fix.

Fixes: bfd2e9140656 ("libnvdimm: Simplify root read-only definition for the 'resource' attribute")
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/namespace_devs.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 6da67f4d641a..2403b71b601e 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1635,11 +1635,11 @@ static umode_t namespace_visible(struct kobject *kobj,
 		return a->mode;
 	}
 
-	if (a == &dev_attr_nstype.attr || a == &dev_attr_size.attr
-			|| a == &dev_attr_holder.attr
-			|| a == &dev_attr_holder_class.attr
-			|| a == &dev_attr_force_raw.attr
-			|| a == &dev_attr_mode.attr)
+	/* base is_namespace_io() attributes */
+	if (a == &dev_attr_nstype.attr || a == &dev_attr_size.attr ||
+	    a == &dev_attr_holder.attr || a == &dev_attr_holder_class.attr ||
+	    a == &dev_attr_force_raw.attr || a == &dev_attr_mode.attr ||
+	    a == &dev_attr_resource.attr)
 		return a->mode;
 
 	return 0;
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

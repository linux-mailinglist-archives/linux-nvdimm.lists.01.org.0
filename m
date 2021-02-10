Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A23A1315A81
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Feb 2021 01:03:43 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6652B100EAB0E;
	Tue,  9 Feb 2021 16:03:33 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D1C6A100EAAEA
	for <linux-nvdimm@lists.01.org>; Tue,  9 Feb 2021 16:03:27 -0800 (PST)
IronPort-SDR: UW6FDPH77xSkih8WivaN/Zs0l0wReBDLUTRI7xDEmQtOKuFo5AK4Fh8l9tmty4vppRvSLDKtJQ
 +2mTsjWRAVQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="201079169"
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400";
   d="scan'208";a="201079169"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 16:03:19 -0800
IronPort-SDR: RgDAq7rbdWEJyPimPAB/eix2qjwkUU2IkUZVZMfnXtB8PpeQi/gdZ86YE17/u5Sxkvk544yYzr
 mjPiZKJ1IK8Q==
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400";
   d="scan'208";a="419865880"
Received: from sitira7x-mobl1.gar.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.134.68])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 16:03:18 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: linux-cxl@vger.kernel.org
Subject: [PATCH v2 8/8] MAINTAINERS: Add maintainers of the CXL driver
Date: Tue,  9 Feb 2021 16:02:59 -0800
Message-Id: <20210210000259.635748-9-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210000259.635748-1-ben.widawsky@intel.com>
References: <20210210000259.635748-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Message-ID-Hash: CECXODF4H6IWAJ5E3YWDBXCAZSEB3UCN
X-Message-ID-Hash: CECXODF4H6IWAJ5E3YWDBXCAZSEB3UCN
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Ben Widawsky <ben.widawsky@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>, Alison Schofield <alison.schofield@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CECXODF4H6IWAJ5E3YWDBXCAZSEB3UCN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6eff4f720c72..93c8694a8f04 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4444,6 +4444,17 @@ M:	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
 S:	Maintained
 F:	include/linux/compiler_attributes.h
 
+COMPUTE EXPRESS LINK (CXL)
+M:	Alison Schofield <alison.schofield@intel.com>
+M:	Vishal Verma <vishal.l.verma@intel.com>
+M:	Ira Weiny <ira.weiny@intel.com>
+M:	Ben Widawsky <ben.widawsky@intel.com>
+M:	Dan Williams <dan.j.williams@intel.com>
+L:	linux-cxl@vger.kernel.org
+S:	Maintained
+F:	drivers/cxl/
+F:	include/uapi/linux/cxl_mem.h
+
 CONEXANT ACCESSRUNNER USB DRIVER
 L:	accessrunner-general@lists.sourceforge.net
 S:	Orphan
-- 
2.30.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E20231D469
	for <lists+linux-nvdimm@lfdr.de>; Wed, 17 Feb 2021 05:10:22 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B8FEC100EAB5C;
	Tue, 16 Feb 2021 20:10:17 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1A7E1100EAB65
	for <linux-nvdimm@lists.01.org>; Tue, 16 Feb 2021 20:10:15 -0800 (PST)
IronPort-SDR: gWokrPnzooo0G0cQtO8BTnJBOpuNWwVqdL01d/pDQGqNMxb48Ihg/qnahTyKtkKNVRez1wJMXV
 uPGKTV33kKKg==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="170229445"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400";
   d="scan'208";a="170229445"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 20:10:14 -0800
IronPort-SDR: nK2XZijp2iIhyQNYe85cCLUE9QbW6iMg4l7TMMDJAPd8dQNtFEm5amnnW+OI11gYjAWO8dbpfB
 bOldk/zgbxVQ==
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400";
   d="scan'208";a="384948871"
Received: from yxie-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.134.141])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 20:10:13 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: linux-cxl@vger.kernel.org
Subject: [PATCH v5 7/9] cxl/mem: Add set of informational commands
Date: Tue, 16 Feb 2021 20:09:56 -0800
Message-Id: <20210217040958.1354670-8-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210217040958.1354670-1-ben.widawsky@intel.com>
References: <20210217040958.1354670-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Message-ID-Hash: 23X66GSTJTK5E53KFXGSX7IG6DOPDXJM
X-Message-ID-Hash: 23X66GSTJTK5E53KFXGSX7IG6DOPDXJM
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Ben Widawsky <ben.widawsky@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/23X66GSTJTK5E53KFXGSX7IG6DOPDXJM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add initial set of formal commands beyond basic identify and command
enumeration.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> (v2)
---
 drivers/cxl/mem.c            | 9 +++++++++
 include/uapi/linux/cxl_mem.h | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index e31b3045e231..6d7d3870b5da 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -45,12 +45,16 @@
 enum opcode {
 	CXL_MBOX_OP_INVALID		= 0x0000,
 	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
+	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
 	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
 	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
 	CXL_MBOX_OP_GET_LOG		= 0x0401,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
+	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
 	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
+	CXL_MBOX_OP_GET_LSA		= 0x4102,
 	CXL_MBOX_OP_SET_LSA		= 0x4103,
+	CXL_MBOX_OP_GET_HEALTH_INFO	= 0x4200,
 	CXL_MBOX_OP_SET_SHUTDOWN_STATE	= 0x4204,
 	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
 	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
@@ -171,6 +175,11 @@ static struct cxl_mem_command mem_commands[] = {
 	CXL_CMD(RAW, ~0, ~0, 0),
 #endif
 	CXL_CMD(GET_SUPPORTED_LOGS, 0, ~0, CXL_CMD_FLAG_FORCE_ENABLE),
+	CXL_CMD(GET_FW_INFO, 0, 0x50, 0),
+	CXL_CMD(GET_PARTITION_INFO, 0, 0x20, 0),
+	CXL_CMD(GET_LSA, 0x8, ~0, 0),
+	CXL_CMD(GET_HEALTH_INFO, 0, 0x12, 0),
+	CXL_CMD(GET_LOG, 0x18, ~0, CXL_CMD_FLAG_FORCE_ENABLE),
 };
 
 /*
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 59227f82a4c1..3155382dfc9b 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -24,6 +24,11 @@
 	___C(IDENTIFY, "Identify Command"),                               \
 	___C(RAW, "Raw device command"),                                  \
 	___C(GET_SUPPORTED_LOGS, "Get Supported Logs"),                   \
+	___C(GET_FW_INFO, "Get FW Info"),                                 \
+	___C(GET_PARTITION_INFO, "Get Partition Information"),            \
+	___C(GET_LSA, "Get Label Storage Area"),                          \
+	___C(GET_HEALTH_INFO, "Get Health Info"),                         \
+	___C(GET_LOG, "Get Log"),                                         \
 	___C(MAX, "invalid / last command")
 
 #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
-- 
2.30.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A970931A77C
	for <lists+linux-nvdimm@lfdr.de>; Fri, 12 Feb 2021 23:26:07 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 753C9100EA2CD;
	Fri, 12 Feb 2021 14:26:01 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9DCAE100EB82A
	for <linux-nvdimm@lists.01.org>; Fri, 12 Feb 2021 14:25:58 -0800 (PST)
IronPort-SDR: 5ZZdWm+CpjiiVSDDN/HsIf5JLIl3j06fGCDlxw7UDakoBz6QNVg15cfshmi02ccun5W7bxvqH/
 EsdwOSIDHMbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9893"; a="246551494"
X-IronPort-AV: E=Sophos;i="5.81,174,1610438400";
   d="scan'208";a="246551494"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 14:25:58 -0800
IronPort-SDR: r6YZYqlYIvTty3eB86Tikw6LVEBlc0F4Xyl9ql4Ojc9awVKYH45lxFwkZ9J4lMXXmvybRrHcyb
 VJiJekJ3ko7A==
X-IronPort-AV: E=Sophos;i="5.81,174,1610438400";
   d="scan'208";a="587605404"
Received: from smandal1-mobl2.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.121])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 14:25:57 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: linux-cxl@vger.kernel.org
Subject: [RFC PATCH 9/9] cxl/mem: Add payload dumping for debug
Date: Fri, 12 Feb 2021 14:25:41 -0800
Message-Id: <20210212222541.2123505-10-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210212222541.2123505-1-ben.widawsky@intel.com>
References: <20210212222541.2123505-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Message-ID-Hash: 5ZZOYHPVWISS4XX2IUT3YGYOSIZROYBE
X-Message-ID-Hash: 5ZZOYHPVWISS4XX2IUT3YGYOSIZROYBE
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Ben Widawsky <ben.widawsky@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5ZZOYHPVWISS4XX2IUT3YGYOSIZROYBE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

It's often useful in debug scenarios to see what the hardware has dumped
out. As it stands today, any device error will result in the payload not
being copied out, so there is no way to triage commands which weren't
expected to fail (and sometimes the payload may have that information).

The functionality is protected by normal kernel security mechanisms as
well as a CONFIG option in the CXL driver.

This was extracted from the original version of the CXL enabling patch
series.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/Kconfig | 13 +++++++++++++
 drivers/cxl/mem.c   |  8 ++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 97dc4d751651..3eec9276e586 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -50,4 +50,17 @@ config CXL_MEM_RAW_COMMANDS
 	  potential impact to memory currently in use by the kernel.
 
 	  If developing CXL hardware or the driver say Y, otherwise say N.
+
+config CXL_MEM_INSECURE_DEBUG
+	bool "CXL.mem debugging"
+	depends on CXL_MEM
+	help
+	  Enable debug of all CXL command payloads.
+
+	  Some CXL devices and controllers support encryption and other
+	  security features. The payloads for the commands that enable
+	  those features may contain sensitive clear-text security
+	  material. Disable debug of those command payloads by default.
+	  If you are a kernel developer actively working on CXL
+	  security enabling say Y, otherwise say N.
 endif
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 3bca8451348a..09c11935b824 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -341,6 +341,14 @@ static int __cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
 
 	/* #5 */
 	rc = cxl_mem_wait_for_doorbell(cxlm);
+
+	if (!cxl_is_security_command(mbox_cmd->opcode) ||
+	    IS_ENABLED(CONFIG_CXL_MEM_INSECURE_DEBUG)) {
+		print_hex_dump_debug("Payload ", DUMP_PREFIX_OFFSET, 16, 1,
+				     mbox_cmd->payload_in, mbox_cmd->size_in,
+				     true);
+	}
+
 	if (rc == -ETIMEDOUT) {
 		cxl_mem_mbox_timeout(cxlm, mbox_cmd);
 		return rc;
-- 
2.30.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

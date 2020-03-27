Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82BD197415
	for <lists+linux-nvdimm@lfdr.de>; Mon, 30 Mar 2020 07:53:07 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 638F810FC36CB;
	Sun, 29 Mar 2020 22:53:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=66.55.73.32; helo=ushosting.nmnhosting.com; envelope-from=alastair@d-silva.org; receiver=<UNKNOWN> 
Received: from ushosting.nmnhosting.com (ushosting.nmnhosting.com [66.55.73.32])
	by ml01.01.org (Postfix) with ESMTP id 429341003ECB6
	for <linux-nvdimm@lists.01.org>; Sun, 29 Mar 2020 22:53:53 -0700 (PDT)
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
	by ushosting.nmnhosting.com (Postfix) with ESMTPS id 1A36B2DC685C;
	Mon, 30 Mar 2020 16:52:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
	s=201810a; t=1585547571;
	bh=7micxHdia2GvvQ4mY81c4jBHOqLOZ0TeAcVaPQleunM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QzIshqlFp53qA4DB8IAUutZabSbcugvEaXNKxzsAZpWDALJWJPENQ0mvFoELV93rV
	 xBDyaQhfw6Fw/7rbXS8HW2uZrWtaFnR2MvhNnl6jlQdn02p7u/PmP6ztacNKbuPyu9
	 85tmlez/p2Zxt6TIwBFgAqzZRWTRiMnUh4iIZthtCkmm6j6qHrQe0olItNDpyXKcuu
	 yrr563UM5DgGMo6LV7xzIIBif4ulFgC+/HkkjRqErrlhMI7zkwkMcxgPJBNiKUJris
	 O3eIA6Pue08VWVHyK7Rqs/DxlrIVWcyA5LmzmtJO8eECSw88MVxEtfzv905BcPf3kH
	 cMJ/o5fgzi/txiWRyh4RECCqzSOxZASTGF+B4aKQY9yDgE8tWr1RSDdkAgN9l5T7gK
	 XufI3qOWi3HWntScxvoGIljl4WlGsy2jHNnAP16md7cjStgYPxE+MIOngRuFz9G+ot
	 B0ZpigPUtr4kS4a5Zk/lekbvhIphRoTyFEEg27ngbAd4+R0Pdpi/03ray/974q6DRP
	 oj9yVUBjNPWt7kNYNnilPCHMODV6tOeY6nPwnd/5fUVYpIYO/0G0qRYicw3MoB+cMo
	 WNBBCFdNMn/eXciPsYoJgPiHCgAWonEXwlOPPECDtSKn/8ZevQqjdlygOvDl330WrX
	 giiKa7eoY/kFQHdeCMxIcNVE=
Received: from localhost.lan ([10.0.1.179])
	by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTP id 02R7C4Ax045934;
	Fri, 27 Mar 2020 18:12:20 +1100 (AEDT)
	(envelope-from alastair@d-silva.org)
From: "Alastair D'Silva" <alastair@d-silva.org>
To: alastair@d-silva.org
Subject: [PATCH v4 24/25] nvdimm/ocxl: Expose the serial number & firmware version in sysfs
Date: Fri, 27 Mar 2020 18:12:01 +1100
Message-Id: <20200327071202.2159885-25-alastair@d-silva.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327071202.2159885-1-alastair@d-silva.org>
References: <20200327071202.2159885-1-alastair@d-silva.org>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Fri, 27 Mar 2020 18:12:20 +1100 (AEDT)
Message-ID-Hash: CP57YFMUDSRSR7GUH7NPRHVEK2QQBEP2
X-Message-ID-Hash: CP57YFMUDSRSR7GUH7NPRHVEK2QQBEP2
X-MailFrom: alastair@d-silva.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.r
 u>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CP57YFMUDSRSR7GUH7NPRHVEK2QQBEP2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch exposes the serial number & firmware version in sysfs,
which will be used by ndctl in userspace to help users identify
the device.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/nvdimm/ocxl/main.c | 42 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/ocxl/main.c b/drivers/nvdimm/ocxl/main.c
index 92b4389e8cbb..1f422f0d51ef 100644
--- a/drivers/nvdimm/ocxl/main.c
+++ b/drivers/nvdimm/ocxl/main.c
@@ -235,6 +235,43 @@ static int reserve_metadata(struct ocxlpmem *ocxlpmem,
 	return 0;
 }
 
+static ssize_t serial_show(struct device *device, struct device_attribute *attr,
+			   char *buf)
+{
+	struct nvdimm *nvdimm = to_nvdimm(device);
+	struct ocxlpmem *ocxlpmem = nvdimm_provider_data(nvdimm);
+	const struct ocxl_fn_config *fn_config = ocxl_function_config(ocxlpmem->ocxl_fn);
+
+	return scnprintf(buf, PAGE_SIZE, "%llu\n", fn_config->serial);
+}
+static DEVICE_ATTR_RO(serial);
+
+static ssize_t fw_version_show(struct device *device,
+			       struct device_attribute *attr, char *buf)
+{
+	struct nvdimm *nvdimm = to_nvdimm(device);
+	struct ocxlpmem *ocxlpmem = nvdimm_provider_data(nvdimm);
+
+	return scnprintf(buf, PAGE_SIZE, "%s\n", ocxlpmem->fw_version);
+}
+static DEVICE_ATTR_RO(fw_version);
+
+static struct attribute *ocxl_pmem_attrs[] = {
+	&dev_attr_serial.attr,
+	&dev_attr_fw_version.attr,
+	NULL,
+};
+
+static const struct attribute_group ocxl_pmem_attribute_group = {
+	.name = "ocxlpmem",
+	.attrs = ocxl_pmem_attrs,
+};
+
+static const struct attribute_group *ocxl_pmem_dimm_attribute_groups[] = {
+	&ocxl_pmem_attribute_group,
+	NULL,
+};
+
 /**
  * register_lpc_mem() - Discover persistent memory on a device and register it with the NVDIMM subsystem
  * @ocxlpmem: the device metadata
@@ -291,8 +328,9 @@ static int register_lpc_mem(struct ocxlpmem *ocxlpmem)
 
 	snprintf(serial, sizeof(serial), "%llx", fn_config->serial);
 	nd_mapping_desc.nvdimm = nvdimm_create(ocxlpmem->nvdimm_bus, ocxlpmem,
-					       NULL, nvdimm_flags,
-					       nvdimm_cmd_mask, 0, NULL);
+					       ocxl_pmem_dimm_attribute_groups,
+					       nvdimm_flags, nvdimm_cmd_mask, 0,
+					       NULL);
 	if (!nd_mapping_desc.nvdimm)
 		return -ENOMEM;
 
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

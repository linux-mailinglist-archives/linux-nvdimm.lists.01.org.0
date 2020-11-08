Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2B22AAAEC
	for <lists+linux-nvdimm@lfdr.de>; Sun,  8 Nov 2020 13:18:36 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F12BA16217BAF;
	Sun,  8 Nov 2020 04:18:34 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CEE0116217BAD
	for <linux-nvdimm@lists.01.org>; Sun,  8 Nov 2020 04:18:32 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id e7so5405188pfn.12
        for <linux-nvdimm@lists.01.org>; Sun, 08 Nov 2020 04:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XzGhod8woKfhXI711oNxvDKA0cVgJcmN5j/L+8KyhPo=;
        b=vn56HhSVD97v3E257BeYskCRZoaycME0pH0dMcwP7A+JZpNCkVz32est2DxqLSalSd
         S0qKEG6pRWRh2zZGzkTaIxzt7zo1u2RmLYSaEoq4VDlmVql61z+FJjf46FOt0d12HrRk
         NIZqeSga5CmWdt2WvB0kWXCntarOwtNqSaBXKXpb34WFwZ2Hx51SmiL0CKoNpbTpHReM
         P7oN0jFKCuX3o4yPBYZwTXSVWZo/ENjZFricF555dbbQbatw6xanUpf4gbJh6Szx43oZ
         ODAZt2vP+aoT+9qR6skGkseb7IbBxwnWIEMDdunMoK0Qhnaw60cI7ClFsIjcDvunkRv0
         qhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XzGhod8woKfhXI711oNxvDKA0cVgJcmN5j/L+8KyhPo=;
        b=VYb3LhyVLT2S8gRSSPvGpGXK10zy2m5DX5PwjTCgmg5H/5mnBh8Ku7lRlloL7KZ4i2
         6OqSixYuObIsTSUCg8atO6DhQC9MvQCzZMcv3TngVCyIKghGRFU9U2IeLXOiKSIAygbf
         5XUqAzorwUSJMVtPzdue9FGGGf1jLfzO/05DAnfaksMnrfdidMtLkt2qcz1LP92qyGhQ
         lBRZrWPAyjC2TbvfNfSqY2FyfpqxWKVMuvyn5QtHA7sPVP1hbIMuBaHDQRBaDjfPeIGH
         Wbv6RU72/lL1FP8uDB8vFIc67DnPGm7JpBO34Y/6NFs3CLCoAaK1DZlyK3FIHsFQi+l+
         Cx9w==
X-Gm-Message-State: AOAM531PRtzXHbmoCgBwW3lYSMEjRX9UhWoouJp+35+w7v/ZwkPs7wgp
	B2sUDeWFDIQ3CT6lG1mgsTV/I3fsuUvJyg==
X-Google-Smtp-Source: ABdhPJw4mAiDcj7niTRC/jMFt80BX0P3CNFfD5ualacFkh6xRvLy9Lwoluysd8kd560YQDUTHowT3Q==
X-Received: by 2002:a65:6556:: with SMTP id a22mr9150373pgw.121.1604837911461;
        Sun, 08 Nov 2020 04:18:31 -0800 (PST)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id g1sm7668342pjl.33.2020.11.08.04.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 04:18:30 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [RFC v4 1/1] testing/nvdimm: Add test module for non-nfit platforms
Date: Sun,  8 Nov 2020 17:47:23 +0530
Message-Id: <20201108121723.2089939-2-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201108121723.2089939-1-santosh@fossix.org>
References: <20201108121723.2089939-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: F6Q355XV6PSWMZ65C4DNXUTCDNA7TJMD
X-Message-ID-Hash: F6Q355XV6PSWMZ65C4DNXUTCDNA7TJMD
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/F6Q355XV6PSWMZ65C4DNXUTCDNA7TJMD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The current test module cannot be used for testing platforms (make check)
that do not have support for NFIT. In order to get the ndctl tests working,
we need a module which can emulate NVDIMM devices without relying on
ACPI/NFIT.

The aim of this proposed module is to implement a similar functionality to
the existing module but without the ACPI dependencies.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 drivers/nvdimm/bus.c                |    1 +
 drivers/nvdimm/region_devs.c        |    5 +
 tools/testing/nvdimm/config_check.c |    3 +-
 tools/testing/nvdimm/test/Kbuild    |    6 +-
 tools/testing/nvdimm/test/ndtest.c  | 1168 +++++++++++++++++++++++++++
 tools/testing/nvdimm/test/ndtest.h  |   84 ++
 6 files changed, 1265 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/nvdimm/test/ndtest.c
 create mode 100644 tools/testing/nvdimm/test/ndtest.h

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 09087c38fabd..c8f4bb708ead 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -382,6 +382,7 @@ void nvdimm_bus_unregister(struct nvdimm_bus *nvdimm_bus)
 {
 	if (!nvdimm_bus)
 		return;
+
 	device_unregister(&nvdimm_bus->dev);
 }
 EXPORT_SYMBOL_GPL(nvdimm_bus_unregister);
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index c3237c2b03a6..ba7dcc0fc25c 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -1128,6 +1128,11 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 	dev->type = dev_type;
 	dev->groups = ndr_desc->attr_groups;
 	dev->of_node = ndr_desc->of_node;
+	if (!ndr_desc->res) {
+		pr_err("region%d: Resource is NULL\n", nd_region->id);
+		dump_stack();
+		return NULL;
+	}
 	nd_region->ndr_size = resource_size(ndr_desc->res);
 	nd_region->ndr_start = ndr_desc->res->start;
 	nd_region->align = default_align(nd_region);
diff --git a/tools/testing/nvdimm/config_check.c b/tools/testing/nvdimm/config_check.c
index cac891028cd1..3e3a5f518864 100644
--- a/tools/testing/nvdimm/config_check.c
+++ b/tools/testing/nvdimm/config_check.c
@@ -12,7 +12,8 @@ void check(void)
 	BUILD_BUG_ON(!IS_MODULE(CONFIG_ND_BTT));
 	BUILD_BUG_ON(!IS_MODULE(CONFIG_ND_PFN));
 	BUILD_BUG_ON(!IS_MODULE(CONFIG_ND_BLK));
-	BUILD_BUG_ON(!IS_MODULE(CONFIG_ACPI_NFIT));
+	if (IS_ENABLED(CONFIG_ACPI_NFIT))
+		BUILD_BUG_ON(!IS_MODULE(CONFIG_ACPI_NFIT));
 	BUILD_BUG_ON(!IS_MODULE(CONFIG_DEV_DAX));
 	BUILD_BUG_ON(!IS_MODULE(CONFIG_DEV_DAX_PMEM));
 }
diff --git a/tools/testing/nvdimm/test/Kbuild b/tools/testing/nvdimm/test/Kbuild
index 75baebf8f4ba..197bcb2b7f35 100644
--- a/tools/testing/nvdimm/test/Kbuild
+++ b/tools/testing/nvdimm/test/Kbuild
@@ -5,5 +5,9 @@ ccflags-y += -I$(srctree)/drivers/acpi/nfit/
 obj-m += nfit_test.o
 obj-m += nfit_test_iomap.o
 
-nfit_test-y := nfit.o
+ifeq  ($(CONFIG_ACPI_NFIT),m)
+	nfit_test-y := nfit.o
+else
+	nfit_test-y := ndtest.o
+endif
 nfit_test_iomap-y := iomap.o
diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/test/ndtest.c
new file mode 100644
index 000000000000..e21c5e436cd3
--- /dev/null
+++ b/tools/testing/nvdimm/test/ndtest.c
@@ -0,0 +1,1168 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/platform_device.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/genalloc.h>
+#include <linux/vmalloc.h>
+#include <linux/dma-mapping.h>
+#include <linux/list_sort.h>
+#include <linux/libnvdimm.h>
+#include <linux/ndctl.h>
+#include <nd-core.h>
+#include <linux/printk.h>
+#include <linux/seq_buf.h>
+
+#include "../watermark.h"
+#include "nfit_test.h"
+#include "ndtest.h"
+
+enum {
+	DIMM_SIZE = SZ_32M,
+	LABEL_SIZE = SZ_128K,
+	NUM_INSTANCES = 2,
+	NUM_DCR = 4,
+};
+
+/* SCM device is unable to persist memory contents */
+#define PAPR_PMEM_UNARMED                   (1ULL << (63 - 0))
+/* SCM device failed to persist memory contents */
+#define PAPR_PMEM_SHUTDOWN_DIRTY            (1ULL << (63 - 1))
+/* SCM device contents are not persisted from previous IPL */
+#define PAPR_PMEM_EMPTY                     (1ULL << (63 - 3))
+#define PAPR_PMEM_HEALTH_CRITICAL           (1ULL << (63 - 4))
+/* SCM device will be garded off next IPL due to failure */
+#define PAPR_PMEM_HEALTH_FATAL              (1ULL << (63 - 5))
+/* SCM contents cannot persist due to current platform health status */
+#define PAPR_PMEM_HEALTH_UNHEALTHY          (1ULL << (63 - 6))
+
+/* Bits status indicators for health bitmap indicating unarmed dimm */
+#define PAPR_PMEM_UNARMED_MASK (PAPR_PMEM_UNARMED |		\
+				PAPR_PMEM_HEALTH_UNHEALTHY)
+
+#define PAPR_PMEM_SAVE_FAILED                (1ULL << (63 - 10))
+
+/* Bits status indicators for health bitmap indicating unflushed dimm */
+#define PAPR_PMEM_BAD_SHUTDOWN_MASK (PAPR_PMEM_SHUTDOWN_DIRTY)
+
+/* Bits status indicators for health bitmap indicating unrestored dimm */
+#define PAPR_PMEM_BAD_RESTORE_MASK  (PAPR_PMEM_EMPTY)
+
+/* Bit status indicators for smart event notification */
+#define PAPR_PMEM_SMART_EVENT_MASK (PAPR_PMEM_HEALTH_CRITICAL | \
+				    PAPR_PMEM_HEALTH_FATAL |	\
+				    PAPR_PMEM_HEALTH_UNHEALTHY)
+
+#define PAPR_PMEM_SAVE_MASK                (PAPR_PMEM_SAVE_FAILED)
+
+#define NFIT_DIMM_HANDLE(node, socket, imc, chan, dimm)	 \
+	(((node & 0xfff) << 16) | ((socket & 0xf) << 12) \
+	 | ((imc & 0xf) << 8) | ((chan & 0xf) << 4) | (dimm & 0xf))
+
+static struct ndtest_dimm dimm_group1[] = {
+	{
+		.size = DIMM_SIZE,
+		.handle = NFIT_DIMM_HANDLE(0, 0, 0, 0, 0),
+		.uuid_str = "1e5c75d2-b618-11ea-9aa3-507b9ddc0f72",
+		.physical_id = 0,
+		.num_formats = 2,
+	},
+	{
+		.size = DIMM_SIZE,
+		.handle = NFIT_DIMM_HANDLE(0, 0, 0, 0, 1),
+		.uuid_str = "1c4d43ac-b618-11ea-be80-507b9ddc0f72",
+		.physical_id = 1,
+		.num_formats = 2,
+	},
+	{
+		.size = DIMM_SIZE,
+		.handle = NFIT_DIMM_HANDLE(0, 0, 1, 0, 0),
+		.uuid_str = "a9f17ffc-b618-11ea-b36d-507b9ddc0f72",
+		.physical_id = 2,
+		.num_formats = 2,
+	},
+	{
+		.size = DIMM_SIZE,
+		.handle = NFIT_DIMM_HANDLE(0, 0, 1, 0, 1),
+		.uuid_str = "b6b83b22-b618-11ea-8aae-507b9ddc0f72",
+		.physical_id = 3,
+		.num_formats = 2,
+	},
+	{
+		.size = DIMM_SIZE,
+		.handle = NFIT_DIMM_HANDLE(0, 1, 0, 0, 0),
+		.uuid_str = "bf9baaee-b618-11ea-b181-507b9ddc0f72",
+		.physical_id = 4,
+		.num_formats = 2,
+	},
+};
+
+static struct ndtest_dimm dimm_group2[] = {
+	{
+		.size = DIMM_SIZE,
+		.handle = NFIT_DIMM_HANDLE(1, 0, 0, 0, 0),
+		.uuid_str = "ca0817e2-b618-11ea-9db3-507b9ddc0f72",
+		.physical_id = 0,
+		.num_formats = 1,
+		.flags = PAPR_PMEM_UNARMED | PAPR_PMEM_EMPTY |
+			 PAPR_PMEM_SAVE_FAILED | PAPR_PMEM_SHUTDOWN_DIRTY |
+			 PAPR_PMEM_HEALTH_FATAL,
+	},
+};
+
+static struct ndtest_mapping region0_mapping[] = {
+	{
+		.dimm = 0,
+		.position = 0,
+		.start = 0,
+		.size = SZ_16M,
+	},
+	{
+		.dimm = 1,
+		.position = 1,
+		.start = 0,
+		.size = SZ_16M,
+	}
+};
+
+static struct ndtest_mapping region1_mapping[] = {
+	{
+		.dimm = 0,
+		.position = 0,
+		.start = SZ_16M,
+		.size = SZ_16M,
+	},
+	{
+		.dimm = 1,
+		.position = 1,
+		.start = SZ_16M,
+		.size = SZ_16M,
+	},
+	{
+		.dimm = 2,
+		.position = 2,
+		.start = SZ_16M,
+		.size = SZ_16M,
+	},
+	{
+		.dimm = 3,
+		.position = 3,
+		.start = SZ_16M,
+		.size = SZ_16M,
+	},
+};
+
+static struct ndtest_mapping region2_mapping[] = {
+	{
+		.dimm = 0,
+		.position = 0,
+		.start = 0,
+		.size = DIMM_SIZE,
+	},
+};
+
+static struct ndtest_mapping region3_mapping[] = {
+	{
+		.dimm = 1,
+		.start = 0,
+		.size = DIMM_SIZE,
+	}
+};
+
+static struct ndtest_mapping region4_mapping[] = {
+	{
+		.dimm = 2,
+		.start = 0,
+		.size = DIMM_SIZE,
+	}
+};
+
+static struct ndtest_mapping region5_mapping[] = {
+	{
+		.dimm = 3,
+		.start = 0,
+		.size = DIMM_SIZE,
+	}
+};
+
+static struct ndtest_region bus0_regions[] = {
+	{
+		.type = ND_DEVICE_NAMESPACE_PMEM,
+		.num_mappings = ARRAY_SIZE(region0_mapping),
+		.mapping = region0_mapping,
+		.size = DIMM_SIZE,
+		.range_index = 1,
+	},
+	{
+		.type = ND_DEVICE_NAMESPACE_PMEM,
+		.num_mappings = ARRAY_SIZE(region1_mapping),
+		.mapping = region1_mapping,
+		.size = DIMM_SIZE * 2,
+		.range_index = 2,
+	},
+	{
+		.type = ND_DEVICE_NAMESPACE_BLK,
+		.num_mappings = ARRAY_SIZE(region2_mapping),
+		.mapping = region2_mapping,
+		.size = DIMM_SIZE,
+		.range_index = 3,
+	},
+	{
+		.type = ND_DEVICE_NAMESPACE_BLK,
+		.num_mappings = ARRAY_SIZE(region3_mapping),
+		.mapping = region3_mapping,
+		.size = DIMM_SIZE,
+		.range_index = 4,
+	},
+	{
+		.type = ND_DEVICE_NAMESPACE_BLK,
+		.num_mappings = ARRAY_SIZE(region4_mapping),
+		.mapping = region4_mapping,
+		.size = DIMM_SIZE,
+		.range_index = 5,
+	},
+	{
+		.type = ND_DEVICE_NAMESPACE_BLK,
+		.num_mappings = ARRAY_SIZE(region5_mapping),
+		.mapping = region5_mapping,
+		.size = DIMM_SIZE,
+		.range_index = 6,
+	},
+};
+
+static struct ndtest_mapping region6_mapping[] = {
+	{
+		.dimm = 0,
+		.position = 0,
+		.start = 0,
+		.size = DIMM_SIZE,
+	},
+};
+
+static struct ndtest_region bus1_regions[] = {
+	{
+		.type = ND_DEVICE_NAMESPACE_IO,
+		.num_mappings = ARRAY_SIZE(region6_mapping),
+		.mapping = region6_mapping,
+		.size = DIMM_SIZE,
+		.range_index = 1,
+	},
+};
+
+static struct ndtest_config bus_configs[NUM_INSTANCES] = {
+	/* bus 1 */
+	{
+		.dimm_start = 0,
+		.dimm_count = ARRAY_SIZE(dimm_group1),
+		.dimms = dimm_group1,
+		.regions = bus0_regions,
+		.num_regions = ARRAY_SIZE(bus0_regions),
+	},
+	/* bus 2 */
+	{
+		.dimm_start = ARRAY_SIZE(dimm_group1),
+		.dimm_count = ARRAY_SIZE(dimm_group2),
+		.dimms = dimm_group2,
+		.regions = bus1_regions,
+		.num_regions = ARRAY_SIZE(bus1_regions),
+	},
+};
+
+static DEFINE_SPINLOCK(ndtest_lock);
+static struct ndtest_priv *instances[NUM_INSTANCES];
+static struct class *ndtest_dimm_class;
+static struct gen_pool *ndtest_pool;
+
+static inline struct ndtest_priv *to_ndtest_priv(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+
+	return container_of(pdev, struct ndtest_priv, pdev);
+}
+
+static int ndtest_config_get(struct ndtest_dimm *p, unsigned int buf_len,
+			     struct nd_cmd_get_config_data_hdr *hdr)
+{
+	unsigned int len;
+
+	if ((hdr->in_offset + hdr->in_length) > LABEL_SIZE)
+		return -EINVAL;
+
+	hdr->status = 0;
+	len = min(hdr->in_length, LABEL_SIZE - hdr->in_offset);
+	memcpy(hdr->out_buf, p->label_area + hdr->in_offset, len);
+
+	return buf_len - len;
+}
+
+static int ndtest_config_set(struct ndtest_dimm *p, unsigned int buf_len,
+			     struct nd_cmd_set_config_hdr *hdr)
+{
+	unsigned int len;
+
+	if ((hdr->in_offset + hdr->in_length) > LABEL_SIZE)
+		return -EINVAL;
+
+	len = min(hdr->in_length, LABEL_SIZE - hdr->in_offset);
+	memcpy(p->label_area + hdr->in_offset, hdr->in_buf, len);
+
+	return buf_len - len;
+}
+
+static int ndtest_get_config_size(struct ndtest_dimm *dimm, unsigned int buf_len,
+				  struct nd_cmd_get_config_size *size)
+{
+	size->status = 0;
+	size->max_xfer = 8;
+	size->config_size = dimm->config_size;
+
+	return 0;
+}
+
+static int ndtest_ctl(struct nvdimm_bus_descriptor *nd_desc,
+		      struct nvdimm *nvdimm, unsigned int cmd, void *buf,
+		      unsigned int buf_len, int *cmd_rc)
+{
+	struct ndtest_dimm *dimm;
+	int _cmd_rc;
+
+	if (!cmd_rc)
+		cmd_rc = &_cmd_rc;
+
+	*cmd_rc = 0;
+
+	if (!nvdimm)
+		return -EINVAL;
+
+	dimm = nvdimm_provider_data(nvdimm);
+	if (!dimm)
+		return -EINVAL;
+
+	switch (cmd) {
+	case ND_CMD_GET_CONFIG_SIZE:
+		*cmd_rc = ndtest_get_config_size(dimm, buf_len, buf);
+		break;
+	case ND_CMD_GET_CONFIG_DATA:
+		*cmd_rc = ndtest_config_get(dimm, buf_len, buf);
+		break;
+	case ND_CMD_SET_CONFIG_DATA:
+		*cmd_rc = ndtest_config_set(dimm, buf_len, buf);
+		break;
+	default:
+		dev_dbg(dimm->dev, "invalid command %u\n", cmd);
+		return -EINVAL;
+	}
+
+	/* Failures for a DIMM can be injected using fail_cmd and
+	 * fail_cmd_code, see the device attributes below
+	 */
+	if ((1 << cmd) & dimm->fail_cmd)
+		return dimm->fail_cmd_code ? dimm->fail_cmd_code : -EIO;
+
+	return 0;
+}
+
+static void put_dimms(void *data)
+{
+	struct ndtest_priv *p = data;
+	int i;
+
+	for (i = 0; i < p->config->dimm_count; i++)
+		if (p->config->dimms[i].dev) {
+			device_unregister(p->config->dimms[i].dev);
+			p->config->dimms[i].dev = NULL;
+		}
+}
+
+#define NDTEST_SCM_DIMM_CMD_MASK	   \
+	((1ul << ND_CMD_GET_CONFIG_SIZE) | \
+	 (1ul << ND_CMD_GET_CONFIG_DATA) | \
+	 (1ul << ND_CMD_SET_CONFIG_DATA) | \
+	 (1ul << ND_CMD_CALL))
+
+static int ndtest_blk_do_io(struct nd_blk_region *ndbr, resource_size_t dpa,
+		void *iobuf, u64 len, int rw)
+{
+	struct ndtest_dimm *dimm = ndbr->blk_provider_data;
+	struct ndtest_blk_mmio *mmio = dimm->mmio;
+	struct nd_region *nd_region = &ndbr->nd_region;
+	unsigned int lane;
+
+	if (!mmio)
+		return -ENOMEM;
+
+	lane = nd_region_acquire_lane(nd_region);
+	if (rw)
+		memcpy(mmio->base + dpa, iobuf, len);
+	else {
+		memcpy(iobuf, mmio->base + dpa, len);
+		arch_invalidate_pmem(mmio->base + dpa, len);
+	}
+
+	nd_region_release_lane(nd_region, lane);
+
+	return 0;
+}
+
+static int ndtest_blk_region_enable(struct nvdimm_bus *nvdimm_bus,
+				    struct device *dev)
+{
+	struct nd_blk_region *ndbr = to_nd_blk_region(dev);
+	struct nvdimm *nvdimm;
+	struct ndtest_dimm *dimm;
+	struct ndtest_blk_mmio *mmio;
+
+	nvdimm = nd_blk_region_to_dimm(ndbr);
+	dimm = nvdimm_provider_data(nvdimm);
+
+	nd_blk_region_set_provider_data(ndbr, dimm);
+	dimm->blk_region = to_nd_region(dev);
+
+	mmio = devm_kzalloc(dev, sizeof(struct ndtest_blk_mmio), GFP_KERNEL);
+	if (!mmio)
+		return -ENOMEM;
+
+	mmio->base = (void __iomem *) devm_nvdimm_memremap(
+		dev, dimm->address, 12, nd_blk_memremap_flags(ndbr));
+	if (!mmio->base) {
+		dev_err(dev, "%s failed to map blk dimm\n", nvdimm_name(nvdimm));
+		return -ENOMEM;
+	}
+	mmio->size = dimm->size;
+	mmio->base_offset = 0;
+
+	dimm->mmio = mmio;
+
+	return 0;
+}
+
+static struct nfit_test_resource *ndtest_resource_lookup(resource_size_t addr)
+{
+	int i;
+
+	for (i = 0; i < NUM_INSTANCES; i++) {
+		struct nfit_test_resource *n, *nfit_res = NULL;
+		struct ndtest_priv *t = instances[i];
+
+		if (!t)
+			continue;
+		spin_lock(&ndtest_lock);
+		list_for_each_entry(n, &t->resources, list) {
+			if (addr >= n->res.start && (addr < n->res.start
+						+ resource_size(&n->res))) {
+				nfit_res = n;
+				break;
+			} else if (addr >= (unsigned long) n->buf
+					&& (addr < (unsigned long) n->buf
+						+ resource_size(&n->res))) {
+				nfit_res = n;
+				break;
+			}
+		}
+		spin_unlock(&ndtest_lock);
+		if (nfit_res)
+			return nfit_res;
+	}
+
+	pr_warn("Failed to get resource\n");
+
+	return NULL;
+}
+
+static void ndtest_release_resource(void *data)
+{
+	struct nfit_test_resource *res  = data;
+
+	spin_lock(&ndtest_lock);
+	list_del(&res->list);
+	spin_unlock(&ndtest_lock);
+
+	if (resource_size(&res->res) >= DIMM_SIZE)
+		gen_pool_free(ndtest_pool, res->res.start,
+				resource_size(&res->res));
+	vfree(res->buf);
+	kfree(res);
+}
+
+static void *ndtest_alloc_resource(struct ndtest_priv *p, size_t size,
+				   dma_addr_t *dma)
+{
+	dma_addr_t __dma;
+	void *buf;
+	struct nfit_test_resource *res;
+	struct genpool_data_align data = {
+		.align = SZ_128M,
+	};
+
+	res = kzalloc(sizeof(*res), GFP_KERNEL);
+	if (!res)
+		return NULL;
+
+	buf = vmalloc(size);
+	if (size >= DIMM_SIZE)
+		__dma = gen_pool_alloc_algo(ndtest_pool, size,
+					    gen_pool_first_fit_align, &data);
+	else
+		__dma = (unsigned long) buf;
+
+	if (!__dma)
+		goto buf_err;
+
+	INIT_LIST_HEAD(&res->list);
+	res->dev = &p->pdev.dev;
+	res->buf = buf;
+	res->res.start = __dma;
+	res->res.end = __dma + size - 1;
+	res->res.name = "NFIT";
+	spin_lock_init(&res->lock);
+	INIT_LIST_HEAD(&res->requests);
+	spin_lock(&ndtest_lock);
+	list_add(&res->list, &p->resources);
+	spin_unlock(&ndtest_lock);
+
+	if (dma)
+		*dma = __dma;
+
+	if (!devm_add_action(&p->pdev.dev, ndtest_release_resource, res))
+		return res->buf;
+
+buf_err:
+	if (__dma && size >= DIMM_SIZE)
+		gen_pool_free(ndtest_pool, __dma, size);
+	if (buf)
+		vfree(buf);
+	kfree(res);
+
+	return NULL;
+}
+
+static ssize_t range_index_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nd_region *nd_region = to_nd_region(dev);
+	struct ndtest_region *region = nd_region_provider_data(nd_region);
+
+	return sprintf(buf, "%d\n", region->range_index);
+}
+static DEVICE_ATTR_RO(range_index);
+
+static struct attribute *ndtest_region_attributes[] = {
+	&dev_attr_range_index.attr,
+	NULL,
+};
+
+static const struct attribute_group ndtest_region_attribute_group = {
+	.attrs = ndtest_region_attributes,
+};
+
+static const struct attribute_group *ndtest_region_attribute_groups[] = {
+	&ndtest_region_attribute_group,
+	NULL,
+};
+
+#define NDTEST_MAX_MAPPING 6
+static int ndtest_create_region(struct ndtest_priv *p,
+				struct ndtest_region *region)
+{
+	struct nd_mapping_desc mappings[NDTEST_MAX_MAPPING];
+	struct nd_blk_region_desc ndbr_desc;
+	struct nd_interleave_set *nd_set;
+	struct nd_region_desc *ndr_desc;
+	struct resource res;
+	int i, ndimm = region->mapping[0].dimm;
+	u64 uuid[2];
+
+	memset(&res, 0, sizeof(res));
+	memset(&mappings, 0, sizeof(mappings));
+	memset(&ndbr_desc, 0, sizeof(ndbr_desc));
+	ndr_desc = &ndbr_desc.ndr_desc;
+
+	if (!ndtest_alloc_resource(p, region->size, &res.start))
+		return -ENOMEM;
+
+	res.end = res.start + region->size - 1;
+	ndr_desc->mapping = mappings;
+	ndr_desc->res = &res;
+	ndr_desc->provider_data = region;
+	ndr_desc->attr_groups = ndtest_region_attribute_groups;
+
+	if (uuid_parse(p->config->dimms[ndimm].uuid_str, (uuid_t *)uuid)) {
+		pr_err("failed to parse UUID\n");
+		return -ENXIO;
+	}
+
+	nd_set = devm_kzalloc(&p->pdev.dev, sizeof(*nd_set), GFP_KERNEL);
+	if (!nd_set)
+		return -ENOMEM;
+
+	nd_set->cookie1 = cpu_to_le64(uuid[0]);
+	nd_set->cookie2 = cpu_to_le64(uuid[1]);
+	nd_set->altcookie = nd_set->cookie1;
+	ndr_desc->nd_set = nd_set;
+
+	if (region->type == ND_DEVICE_NAMESPACE_BLK) {
+		mappings[0].start = 0;
+		mappings[0].size = DIMM_SIZE;
+		mappings[0].nvdimm = p->config->dimms[ndimm].nvdimm;
+
+		ndr_desc->mapping = &mappings[0];
+		ndr_desc->num_mappings = 1;
+		ndr_desc->num_lanes = 1;
+		ndbr_desc.enable = ndtest_blk_region_enable;
+		ndbr_desc.do_io = ndtest_blk_do_io;
+		region->region = nvdimm_blk_region_create(p->bus, ndr_desc);
+
+		goto done;
+	}
+
+	for (i = 0; i < region->num_mappings; i++) {
+		ndimm = region->mapping[i].dimm;
+		mappings[i].start = region->mapping[i].start;
+		mappings[i].size = region->mapping[i].size;
+		mappings[i].position = region->mapping[i].position;
+		mappings[i].nvdimm = p->config->dimms[ndimm].nvdimm;
+	}
+
+	ndr_desc->num_mappings = region->num_mappings;
+	region->region = nvdimm_pmem_region_create(p->bus, ndr_desc);
+
+done:
+	if (!region->region) {
+		dev_err(&p->pdev.dev, "Error registering region %pR\n",
+			ndr_desc->res);
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static int ndtest_init_regions(struct ndtest_priv *p)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < p->config->num_regions; i++) {
+		ret = ndtest_create_region(p, &p->config->regions[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static ssize_t handle_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct ndtest_dimm *dimm = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%#x\n", dimm->handle);
+}
+static DEVICE_ATTR_RO(handle);
+
+static ssize_t fail_cmd_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct ndtest_dimm *dimm = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%#x\n", dimm->fail_cmd);
+}
+
+static ssize_t fail_cmd_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t size)
+{
+	struct ndtest_dimm *dimm = dev_get_drvdata(dev);
+	unsigned long val;
+	ssize_t rc;
+
+	rc = kstrtol(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	dimm->fail_cmd = val;
+
+	return size;
+}
+static DEVICE_ATTR_RW(fail_cmd);
+
+static ssize_t fail_cmd_code_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct ndtest_dimm *dimm = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", dimm->fail_cmd_code);
+}
+
+static ssize_t fail_cmd_code_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t size)
+{
+	struct ndtest_dimm *dimm = dev_get_drvdata(dev);
+	unsigned long val;
+	ssize_t rc;
+
+	rc = kstrtol(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	dimm->fail_cmd_code = val;
+	return size;
+}
+static DEVICE_ATTR_RW(fail_cmd_code);
+
+static struct attribute *dimm_attributes[] = {
+	&dev_attr_handle.attr,
+	&dev_attr_fail_cmd.attr,
+	&dev_attr_fail_cmd_code.attr,
+	NULL,
+};
+
+static struct attribute_group dimm_attribute_group = {
+	.attrs = dimm_attributes,
+};
+
+static const struct attribute_group *dimm_attribute_groups[] = {
+	&dimm_attribute_group,
+	NULL,
+};
+
+static ssize_t phys_id_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvdimm *nvdimm = to_nvdimm(dev);
+	struct ndtest_dimm *dimm = nvdimm_provider_data(nvdimm);
+
+	return sprintf(buf, "%#x\n", dimm->physical_id);
+}
+static DEVICE_ATTR_RO(phys_id);
+
+static ssize_t vendor_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "0x1234567\n");
+}
+static DEVICE_ATTR_RO(vendor);
+
+static ssize_t id_show(struct device *dev,
+		       struct device_attribute *attr, char *buf)
+{
+	struct nvdimm *nvdimm = to_nvdimm(dev);
+	struct ndtest_dimm *dimm = nvdimm_provider_data(nvdimm);
+
+	return sprintf(buf, "%04x-%02x-%04x-%08x", 0xabcd,
+		       0xa, 2016, ~(dimm->handle));
+}
+static DEVICE_ATTR_RO(id);
+
+static ssize_t nvdimm_handle_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct nvdimm *nvdimm = to_nvdimm(dev);
+	struct ndtest_dimm *dimm = nvdimm_provider_data(nvdimm);
+
+	return sprintf(buf, "%#x\n", dimm->handle);
+}
+
+static struct device_attribute dev_attr_nvdimm_show_handle =  {
+	.attr	= { .name = "handle", .mode = 0444 },
+	.show	= nvdimm_handle_show,
+};
+
+static ssize_t subsystem_vendor_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "0x%04x\n", 0);
+}
+static DEVICE_ATTR_RO(subsystem_vendor);
+
+static ssize_t dirty_shutdown_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", 42);
+}
+static DEVICE_ATTR_RO(dirty_shutdown);
+
+static ssize_t formats_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvdimm *nvdimm = to_nvdimm(dev);
+	struct ndtest_dimm *dimm = nvdimm_provider_data(nvdimm);
+
+	return sprintf(buf, "%d\n", dimm->num_formats);
+}
+static DEVICE_ATTR_RO(formats);
+
+static ssize_t format_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvdimm *nvdimm = to_nvdimm(dev);
+	struct ndtest_dimm *dimm = nvdimm_provider_data(nvdimm);
+
+	if (dimm->num_formats > 1)
+		return sprintf(buf, "0x201\n");
+
+	return sprintf(buf, "0x101\n");
+}
+static DEVICE_ATTR_RO(format);
+
+static ssize_t format1_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	return sprintf(buf, "0x301\n");
+}
+static DEVICE_ATTR_RO(format1);
+
+static umode_t ndtest_nvdimm_attr_visible(struct kobject *kobj,
+					struct attribute *a, int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct nvdimm *nvdimm = to_nvdimm(dev);
+	struct ndtest_dimm *dimm = nvdimm_provider_data(nvdimm);
+
+	if (a == &dev_attr_format1.attr && dimm->num_formats <= 1)
+		return 0;
+
+	return a->mode;
+}
+
+static struct attribute *ndtest_nvdimm_attributes[] = {
+	&dev_attr_nvdimm_show_handle.attr,
+	&dev_attr_vendor.attr,
+	&dev_attr_id.attr,
+	&dev_attr_phys_id.attr,
+	&dev_attr_subsystem_vendor.attr,
+	&dev_attr_dirty_shutdown.attr,
+	&dev_attr_formats.attr,
+	&dev_attr_format.attr,
+	&dev_attr_format1.attr,
+	NULL,
+};
+
+static const struct attribute_group ndtest_nvdimm_attribute_group = {
+	.attrs = ndtest_nvdimm_attributes,
+	.is_visible = ndtest_nvdimm_attr_visible,
+};
+
+static ssize_t flags_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	struct nvdimm *nvdimm = to_nvdimm(dev);
+	struct ndtest_dimm *dimm = nvdimm_provider_data(nvdimm);
+	struct seq_buf s;
+	u64 flags;
+
+	flags = dimm->flags;
+
+	seq_buf_init(&s, buf, PAGE_SIZE);
+	if (flags & PAPR_PMEM_UNARMED_MASK)
+		seq_buf_printf(&s, "not_armed ");
+
+	if (flags & PAPR_PMEM_BAD_SHUTDOWN_MASK)
+		seq_buf_printf(&s, "flush_fail ");
+
+	if (flags & PAPR_PMEM_BAD_RESTORE_MASK)
+		seq_buf_printf(&s, "restore_fail ");
+
+	if (flags & PAPR_PMEM_SAVE_MASK)
+		seq_buf_printf(&s, "save_fail ");
+
+	if (flags & PAPR_PMEM_SMART_EVENT_MASK)
+		seq_buf_printf(&s, "smart_notify ");
+
+
+	if (seq_buf_used(&s))
+		seq_buf_printf(&s, "\n");
+
+	return seq_buf_used(&s);
+}
+static DEVICE_ATTR_RO(flags);
+
+static struct attribute *papr_dimm_attributes[] = {
+	&dev_attr_flags.attr,
+	NULL,
+};
+
+static struct attribute_group papr_dimm_attribute_group = {
+	.name = "papr",
+	.attrs = papr_dimm_attributes,
+};
+
+static const struct attribute_group *ndtest_nvdimm_attribute_groups[] = {
+	&ndtest_nvdimm_attribute_group,
+	&papr_dimm_attribute_group,
+	NULL,
+};
+
+static int ndtest_dimm_register(struct ndtest_priv *priv,
+				struct ndtest_dimm *dimm, int id)
+{
+	struct device *dev = &priv->pdev.dev;
+	unsigned long dimm_flags = dimm->flags;
+
+	if (dimm->num_formats > 1) {
+		set_bit(NDD_ALIASING, &dimm_flags);
+		set_bit(NDD_LABELING, &dimm_flags);
+	}
+
+	if (dimm->flags & PAPR_PMEM_UNARMED_MASK)
+		set_bit(NDD_UNARMED, &dimm_flags);
+
+	dimm->nvdimm = nvdimm_create(priv->bus, dimm,
+				    ndtest_nvdimm_attribute_groups, dimm_flags,
+				    NDTEST_SCM_DIMM_CMD_MASK, 0, NULL);
+	if (!dimm->nvdimm) {
+		dev_err(dev, "Error creating DIMM object for %pOF\n", priv->dn);
+		return -ENXIO;
+	}
+
+	dimm->dev = device_create_with_groups(ndtest_dimm_class,
+					     &priv->pdev.dev,
+					     0, dimm, dimm_attribute_groups,
+					     "test_dimm%d", id);
+	if (!dimm->dev) {
+		pr_err("Could not create dimm device attributes\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int ndtest_nvdimm_init(struct ndtest_priv *p)
+{
+	struct ndtest_dimm *d;
+	void *res;
+	int i, id;
+
+	for (i = 0; i < p->config->dimm_count; i++) {
+		d = &p->config->dimms[i];
+		d->id = id = p->config->dimm_start + i;
+		res = ndtest_alloc_resource(p, LABEL_SIZE, NULL);
+		if (!res)
+			return -ENOMEM;
+
+		d->label_area = res;
+		sprintf(d->label_area, "label%d", id);
+		d->config_size = LABEL_SIZE;
+
+		if (!ndtest_alloc_resource(p, d->size,
+					   &p->dimm_dma[id]))
+			return -ENOMEM;
+
+		if (!ndtest_alloc_resource(p, LABEL_SIZE,
+					   &p->label_dma[id]))
+			return -ENOMEM;
+
+		if (!ndtest_alloc_resource(p, LABEL_SIZE,
+					   &p->dcr_dma[id]))
+			return -ENOMEM;
+
+		d->address = p->dimm_dma[id];
+
+		ndtest_dimm_register(p, d, id);
+	}
+
+	return 0;
+}
+
+static ssize_t compatible_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "nvdimm_test");
+}
+static DEVICE_ATTR_RO(compatible);
+
+static struct attribute *of_node_attributes[] = {
+	&dev_attr_compatible.attr,
+	NULL
+};
+
+static const struct attribute_group of_node_attribute_group = {
+	.name = "of_node",
+	.attrs = of_node_attributes,
+};
+
+static const struct attribute_group *ndtest_attribute_groups[] = {
+	&of_node_attribute_group,
+	NULL,
+};
+
+static int ndtest_bus_register(struct ndtest_priv *p,
+			       struct ndtest_config *config)
+{
+	p->config = &config[p->pdev.id];
+
+	p->bus_desc.ndctl = ndtest_ctl;
+	p->bus_desc.module = THIS_MODULE;
+	p->bus_desc.provider_name = NULL;
+	p->bus_desc.attr_groups = ndtest_attribute_groups;
+
+	p->bus = nvdimm_bus_register(&p->pdev.dev, &p->bus_desc);
+	if (!p->bus) {
+		dev_err(&p->pdev.dev, "Error creating nvdimm bus %pOF\n", p->dn);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int ndtest_probe(struct platform_device *pdev)
+{
+	struct ndtest_priv *p;
+	int rc;
+
+	p = to_ndtest_priv(&pdev->dev);
+	if (ndtest_bus_register(p, bus_configs))
+		return -ENOMEM;
+
+	p->dcr_dma = devm_kcalloc(&p->pdev.dev, NUM_DCR,
+				 sizeof(dma_addr_t), GFP_KERNEL);
+	p->label_dma = devm_kcalloc(&p->pdev.dev, NUM_DCR,
+				   sizeof(dma_addr_t), GFP_KERNEL);
+	p->dimm_dma = devm_kcalloc(&p->pdev.dev, NUM_DCR,
+				  sizeof(dma_addr_t), GFP_KERNEL);
+
+	rc = ndtest_nvdimm_init(p);
+	if (rc)
+		goto err;
+
+	rc = ndtest_init_regions(p);
+	if (rc)
+		goto err;
+
+	rc = devm_add_action_or_reset(&pdev->dev, put_dimms, p);
+	if (rc)
+		goto err;
+
+	platform_set_drvdata(pdev, p);
+
+	return 0;
+
+err:
+	pr_err("%s:%d Failed nvdimm init\n", __func__, __LINE__);
+	kfree(p->bus_desc.provider_name);
+	return rc;
+}
+
+static int ndtest_remove(struct platform_device *pdev)
+{
+	struct ndtest_priv *p = to_ndtest_priv(&pdev->dev);
+
+	nvdimm_bus_unregister(p->bus);
+	return 0;
+}
+
+static const struct platform_device_id ndtest_id[] = {
+	{ KBUILD_MODNAME },
+	{ },
+};
+
+static struct platform_driver ndtest_driver = {
+	.probe = ndtest_probe,
+	.remove = ndtest_remove,
+	.driver = {
+		.name = KBUILD_MODNAME,
+	},
+	.id_table = ndtest_id,
+};
+
+static void ndtest_release(struct device *dev)
+{
+	struct ndtest_priv *p = to_ndtest_priv(dev);
+
+	kfree(p);
+}
+
+static void cleanup_devices(void)
+{
+	int i;
+
+	for (i = 0; i < NUM_INSTANCES; i++)
+		if (instances[i])
+			platform_device_unregister(&instances[i]->pdev);
+
+	nfit_test_teardown();
+
+	if (ndtest_pool)
+		gen_pool_destroy(ndtest_pool);
+
+	if (ndtest_dimm_class)
+		class_destroy(ndtest_dimm_class);
+}
+
+static __init int ndtest_init(void)
+{
+	int rc, i;
+
+	pmem_test();
+	libnvdimm_test();
+	device_dax_test();
+	dax_pmem_test();
+	dax_pmem_core_test();
+#ifdef CONFIG_DEV_DAX_PMEM_COMPAT
+	dax_pmem_compat_test();
+#endif
+
+	nfit_test_setup(ndtest_resource_lookup, NULL);
+
+	ndtest_dimm_class = class_create(THIS_MODULE, "nfit_test_dimm");
+	if (IS_ERR(ndtest_dimm_class)) {
+		rc = PTR_ERR(ndtest_dimm_class);
+		goto err_register;
+	}
+
+	ndtest_pool = gen_pool_create(ilog2(SZ_4M), NUMA_NO_NODE);
+	if (!ndtest_pool) {
+		rc = -ENOMEM;
+		goto err_register;
+	}
+
+	if (gen_pool_add(ndtest_pool, SZ_4G, SZ_4G, NUMA_NO_NODE)) {
+		rc = -ENOMEM;
+		goto err_register;
+	}
+
+	/* Each instance can be taken as a bus, which can have multiple dimms */
+	for (i = 0; i < NUM_INSTANCES; i++) {
+		struct ndtest_priv *priv;
+		struct platform_device *pdev;
+
+		priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+		if (!priv) {
+			rc = -ENOMEM;
+			goto err_register;
+		}
+
+		INIT_LIST_HEAD(&priv->resources);
+		pdev = &priv->pdev;
+		pdev->name = KBUILD_MODNAME;
+		pdev->id = i;
+		pdev->dev.release = ndtest_release;
+		rc = platform_device_register(pdev);
+		if (rc) {
+			put_device(&pdev->dev);
+			goto err_register;
+		}
+		get_device(&pdev->dev);
+
+		instances[i] = priv;
+	}
+
+	rc = platform_driver_register(&ndtest_driver);
+	if (rc)
+		goto err_register;
+
+	return 0;
+
+err_register:
+	pr_err("Error registering platform device\n");
+	cleanup_devices();
+
+	return rc;
+}
+
+static __exit void ndtest_exit(void)
+{
+	cleanup_devices();
+	platform_driver_unregister(&ndtest_driver);
+}
+
+module_init(ndtest_init);
+module_exit(ndtest_exit);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("IBM Corporation");
diff --git a/tools/testing/nvdimm/test/ndtest.h b/tools/testing/nvdimm/test/ndtest.h
new file mode 100644
index 000000000000..cee1f5b854af
--- /dev/null
+++ b/tools/testing/nvdimm/test/ndtest.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef NDTEST_H
+#define NDTEST_H
+
+#include <linux/platform_device.h>
+#include <linux/libnvdimm.h>
+
+enum dimm_type {
+	NDTEST_REGION_TYPE_PMEM = 0x0,
+	NDTEST_REGION_TYPE_BLK = 0x1,
+};
+
+struct ndtest_priv {
+	struct platform_device pdev;
+	struct device_node *dn;
+	struct list_head resources;
+	struct nvdimm_bus_descriptor bus_desc;
+	struct nvdimm_bus *bus;
+	struct ndtest_config *config;
+
+	dma_addr_t *dcr_dma;
+	dma_addr_t *label_dma;
+	dma_addr_t *dimm_dma;
+	bool is_volatile;
+	unsigned int flags;
+	unsigned int nblks;
+};
+
+struct ndtest_blk_mmio {
+	void __iomem *base;
+	u64 size;
+	u64 base_offset;
+	u32 line_size;
+	u32 num_lines;
+	u32 table_size;
+};
+
+struct ndtest_dimm {
+	struct device *dev;
+	struct nvdimm *nvdimm;
+	struct ndtest_blk_mmio *mmio;
+	struct nd_region *blk_region;
+
+	dma_addr_t address;
+	unsigned long long flags;
+	unsigned long config_size;
+	void *label_area;
+	char *uuid_str;
+
+	unsigned int size;
+	unsigned int handle;
+	unsigned int fail_cmd;
+	unsigned int physical_id;
+	unsigned int num_formats;
+	int id;
+	int fail_cmd_code;
+	u8 no_alias;
+};
+
+struct ndtest_mapping {
+	u64 start;
+	u64 size;
+	u8 position;
+	u8 dimm;
+};
+
+struct ndtest_region {
+	struct nd_region *region;
+	struct ndtest_mapping *mapping;
+	u64 size;
+	u8 type;
+	u8 num_mappings;
+	u8 range_index;
+};
+
+struct ndtest_config {
+	struct ndtest_dimm *dimms;
+	struct ndtest_region *regions;
+	unsigned int dimm_count;
+	unsigned int dimm_start;
+	u8 num_regions;
+};
+
+#endif /* NDTEST_H */
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

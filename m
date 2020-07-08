Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CCE2185D0
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jul 2020 13:15:15 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0946D11137ED2;
	Wed,  8 Jul 2020 04:15:14 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1043; helo=mail-pj1-x1043.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5CF9811137ED0
	for <linux-nvdimm@lists.01.org>; Wed,  8 Jul 2020 04:15:11 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id k5so1042456pjg.3
        for <linux-nvdimm@lists.01.org>; Wed, 08 Jul 2020 04:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cS3Sz/O653VCQe2m4JNdBsDP7XrmKFuyJqMnt0ciV14=;
        b=CxguBrai3xIBvDOKn3GonFIPTmQ88QmHPHBci8U93xeDlknyVjIAmwsy2tAq1YvWoF
         ts0EvqxgLM2YlRzoFQxyNWZHbbrftbZXk1/7riN3rpKhuXs8FuVzCopy52VaM4xlDTIC
         aMFd5/dxerAXaVMIdgEx6khhNL3GB5OEs8gLtjvYBxQR0Rl6ZcX1qRN5q/Hd7gqxsxyl
         dbb3t6kOR3ofUJuM/IeXjlAVeZjG3W4NCQIDbgY749ZzOuGtsc6kf4+eEUa03DkKxBly
         toNdNBHIeZH48UDU/RMeNZnqyJpTqmDPRTJ0SExeLhAxV+N/9SHHYE6gZKCkiBZ9ghkJ
         SrXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cS3Sz/O653VCQe2m4JNdBsDP7XrmKFuyJqMnt0ciV14=;
        b=frGsIeWoSCaAZsMe6vNPsOtKw41g/SdKzdv+vP6FlUNzq0PYYS3UzuZjPwogvTNZOC
         dk88v2/6BU0z39TuhzG//0UYv4Q8IdiZvBzFvownV4C7ZtzSpikjbFqdEoQ7euq6XmX4
         1ZKrj+zYFsSc6Ozj3OBSKcfAsiSn05Nqgi+50HgWli6DMzuIzmmch8irlb4vPExZsBTd
         Cq7ZE4SFgA3bY+XgdJWKhjo67rSvZxK/bJullruy1LCkvqQIZHSRW4GgtpdJ1fBv9qkN
         h0X6iNtXJaSX/mihM4gWRnnrJ0CORSRUJvt2zwB7Ffaqf1pVi3WgkGy1N0b99tFr0PlS
         H0fA==
X-Gm-Message-State: AOAM531NzUSBrBQRZfjysLs2QvY3VnVNIZ2P+hYpUXcWrWkt2QQOjPRs
	Reebx+OYYQBnESkDDdkVjjtY8lTxZmk=
X-Google-Smtp-Source: ABdhPJyeJMTK0I6FGdmcXkyIxZ+kSyLbLoC6tWNVagDv3E0izGYj+PW0lImNpsVDBW/tI//Pd2N85g==
X-Received: by 2002:a17:90b:3555:: with SMTP id lt21mr9604510pjb.234.1594206910168;
        Wed, 08 Jul 2020 04:15:10 -0700 (PDT)
Received: from santosiv.in.ibm.com.com ([203.223.190.240])
        by smtp.gmail.com with ESMTPSA id gn5sm5043780pjb.23.2020.07.08.04.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 04:15:09 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: linux-nvdimm@lists.01.org
Subject: [RFC v2] tools/testing/nvdimm: Add generic test module for non-nfit platforms
Date: Wed,  8 Jul 2020 16:44:51 +0530
Message-Id: <20200708111451.302196-1-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Message-ID-Hash: S4ET7XTDVPCAKVF27NVF34Q4STFAY36H
X-Message-ID-Hash: S4ET7XTDVPCAKVF27NVF34Q4STFAY36H
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Harish Sriram <harish@linux.ibm.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/S4ET7XTDVPCAKVF27NVF34Q4STFAY36H/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

We cannot use ndctl test facility (make check) in platforms that don't
support ACPI. In order to get the ndctl tests working, we need a module
which can emulate NVDIMM devices without relying on ACPI/NFIT, which the
current nfit_test module does.

The aim of this proposed module is to implement a similar functionality
to the existing module but without the ACPI dependencies. Currently two
regions are implemented without interleaving or error injection. Using
`make check` with this module passes 11 tests. The rest of tests are
mostly dependent on error injection or on the availability of 'nfit'.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 tools/testing/nvdimm/config_check.c |   3 +-
 tools/testing/nvdimm/test/Kbuild    |   6 +-
 tools/testing/nvdimm/test/ndtest.c  | 768 ++++++++++++++++++++++++++++
 tools/testing/nvdimm/test/ndtest.h  |  63 +++
 4 files changed, 838 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/nvdimm/test/ndtest.c
 create mode 100644 tools/testing/nvdimm/test/ndtest.h

diff --git a/tools/testing/nvdimm/config_check.c b/tools/testing/nvdimm/config_check.c
index cac891028cd1b..3e3a5f5188640 100644
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
index 75baebf8f4ba1..197bcb2b7f351 100644
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
index 0000000000000..f6c585113646d
--- /dev/null
+++ b/tools/testing/nvdimm/test/ndtest.c
@@ -0,0 +1,768 @@
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
+#define NFIT_DIMM_HANDLE(node, socket, imc, chan, dimm)	 \
+	(((node & 0xfff) << 16) | ((socket & 0xf) << 12) \
+	 | ((imc & 0xf) << 8) | ((chan & 0xf) << 4) | (dimm & 0xf))
+
+struct ndtest_dimm dimm_group1[] = {
+	{
+		.type = NDTEST_REGION_TYPE_BLK,
+		.size = DIMM_SIZE,
+		.handle = NFIT_DIMM_HANDLE(0, 0, 0, 0, 0),
+		.uuid_str = "1e5c75d2-b618-11ea-9aa3-507b9ddc0f72",
+	},
+	{
+		.type = NDTEST_REGION_TYPE_PMEM,
+		.size = DIMM_SIZE * 2,
+		.handle = NFIT_DIMM_HANDLE(0, 0, 0, 0, 1),
+		.uuid_str = "1c4d43ac-b618-11ea-be80-507b9ddc0f72",
+	},
+	{
+		.type = NDTEST_REGION_TYPE_PMEM,
+		.size = DIMM_SIZE,
+		.handle = NFIT_DIMM_HANDLE(0, 0, 1, 0, 0),
+		.uuid_str = "a9f17ffc-b618-11ea-b36d-507b9ddc0f72",
+	},
+	{
+		.type = NDTEST_REGION_TYPE_BLK,
+		.size = DIMM_SIZE,
+		.handle = NFIT_DIMM_HANDLE(0, 0, 1, 0, 1),
+		.uuid_str = "b6b83b22-b618-11ea-8aae-507b9ddc0f72",
+	},
+	{
+		.type = NDTEST_REGION_TYPE_PMEM,
+		.size = DIMM_SIZE,
+		.handle = NFIT_DIMM_HANDLE(0, 1, 0, 0, 0),
+		.uuid_str = "bf9baaee-b618-11ea-b181-507b9ddc0f72"
+	},
+};
+
+struct ndtest_dimm dimm_group2[] = {
+	{
+		.type = NDTEST_REGION_TYPE_PMEM,
+		.size = DIMM_SIZE * 2,
+		.handle = NFIT_DIMM_HANDLE(1, 0, 0, 0, 0),
+		.uuid_str = "ca0817e2-b618-11ea-9db3-507b9ddc0f72",
+	},
+};
+
+struct ndtest_config bus_configs[NUM_INSTANCES] = {
+	/* bus 1 */
+	{
+		.dimm_start = 0,
+		.dimm_count = ARRAY_SIZE(dimm_group1),
+		.dimm = dimm_group1,
+	},
+	/* bus 2 */
+	{
+		.dimm_start = ARRAY_SIZE(dimm_group1),
+		.dimm_count = ARRAY_SIZE(dimm_group2),
+		.dimm = dimm_group2,
+	},
+};
+
+static DEFINE_SPINLOCK(nfit_test_lock);
+struct ndtest_priv *instances[NUM_INSTANCES];
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
+int ndtest_config_get(struct ndtest_dimm *p, unsigned int buf_len,
+		      struct nd_cmd_get_config_data_hdr *hdr)
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
+int ndtest_config_set(struct ndtest_dimm *p, unsigned int buf_len,
+		      struct nd_cmd_set_config_hdr *hdr)
+{
+	unsigned int len;
+	if ((hdr->in_offset + hdr->in_length) > LABEL_SIZE)
+		return -EINVAL;
+
+	len = min(hdr->in_length, LABEL_SIZE - hdr->in_offset);
+	memcpy(p->label_area + hdr->in_offset, hdr->in_buf, len);
+
+	return buf_len - len;
+}
+
+static int ndtest_ctl(struct nvdimm_bus_descriptor *nd_desc,
+		     struct nvdimm *nvdimm, unsigned int cmd, void *buf,
+		     unsigned int buf_len, int *cmd_rc)
+{
+	struct nd_cmd_get_config_size *size;
+	struct ndtest_dimm *p;
+
+	if (!nvdimm)
+		return -EINVAL;
+
+	p = nvdimm_provider_data(nvdimm);
+	switch(cmd) {
+	case ND_CMD_GET_CONFIG_SIZE:
+		size = (struct nd_cmd_get_config_size *) buf;
+		size->status = 0;
+		size->max_xfer = 8;
+		size->config_size = p->config_size;
+		*cmd_rc = 0;
+		break;
+
+	case ND_CMD_GET_CONFIG_DATA:
+		*cmd_rc = ndtest_config_get(p, buf_len, buf);
+		break;
+
+	case ND_CMD_SET_CONFIG_DATA:
+		*cmd_rc = ndtest_config_set(p, buf_len, buf);
+		break;
+	default:
+		dev_dbg(p->dev, "invalid command %u\n", cmd);
+		return -EINVAL;
+	}
+
+	*cmd_rc = 0;
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
+DEVICE_ATTR_RO(handle);
+
+static ssize_t fail_cmd_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct ndtest_dimm *dimm = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%#lx\n", dimm->fail_cmd_flags);
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
+	dimm->fail_cmd_flags = val;
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
+static void put_dimms(void *data)
+{
+	struct ndtest_priv *p = data;
+	int i;
+
+	for (i = 0; i < p->config->dimm_count; i++)
+		if (p->config->dimm[i].dev) {
+			device_unregister(p->config->dimm[i].dev);
+			p->config->dimm[i].dev = NULL;
+		}
+}
+
+#define NDTEST_SCM_DIMM_CMD_MASK	   \
+	((1ul << ND_CMD_GET_CONFIG_SIZE) | \
+	 (1ul << ND_CMD_GET_CONFIG_DATA) | \
+	 (1ul << ND_CMD_SET_CONFIG_DATA))
+
+
+static ssize_t vendor_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+
+	return sprintf(buf, "0x1234567\n");
+}
+static DEVICE_ATTR_RO(vendor);
+
+static ssize_t id_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvdimm *nvdimm = to_nvdimm(dev);
+	struct ndtest_dimm *dimm = nvdimm_provider_data(nvdimm);
+
+	return sprintf(buf, "generic-test-dimm-%d\n", dimm->id);
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
+struct device_attribute dev_attr_nvdimm_show_handle =  {
+	.attr	= { .name = "handle", .mode = 0444 },
+	.show	= nvdimm_handle_show,
+};
+
+static struct attribute *ndtest_nvdimm_attributes[] = {
+	&dev_attr_nvdimm_show_handle.attr,
+	&dev_attr_vendor.attr,
+	&dev_attr_id.attr,
+	NULL,
+};
+
+static umode_t ndtest_nvdimm_attr_visible(struct kobject *kobj,
+					struct attribute *a, int n)
+{
+	return a->mode;
+}
+
+static const struct attribute_group ndtest_nvdimm_attribute_group = {
+	.name = "nfit",
+	.attrs = ndtest_nvdimm_attributes,
+	.is_visible = ndtest_nvdimm_attr_visible,
+};
+
+static const struct attribute_group *ndtest_nvdimm_attribute_groups[] = {
+	&ndtest_nvdimm_attribute_group,
+	NULL,
+};
+
+static int ndtest_blk_do_io(struct nd_blk_region *ndbr, resource_size_t dpa,
+		void *iobuf, u64 len, int rw)
+{
+	struct ndtest_dimm *dimm = ndbr->blk_provider_data;
+	struct ndtest_blk_mmio *mmio = dimm->mmio;
+	struct nd_region *nd_region = &ndbr->nd_region;
+	unsigned int lane;
+
+	pr_debug("blk-io: Writing into %p (rw: %d len: %llu)\n",
+		 mmio->base, rw, len);
+
+	lane = nd_region_acquire_lane(nd_region);
+
+	if (rw)
+		memcpy(mmio->base + dpa, iobuf, len);
+	else
+		memcpy(iobuf, mmio->base + dpa, len);
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
+	struct ndtest_dimm *p;
+	struct ndtest_blk_mmio *mmio;
+
+	nvdimm = nd_blk_region_to_dimm(ndbr);
+	p = nvdimm_provider_data(nvdimm);
+
+	nd_blk_region_set_provider_data(ndbr, p);
+	p->region = to_nd_region(dev);
+
+	mmio = devm_kzalloc(dev, sizeof(struct ndtest_blk_mmio), GFP_KERNEL);
+	if (!mmio)
+		return -ENOMEM;
+
+	mmio->base = devm_nvdimm_memremap(dev, p->address, 12,
+					 nd_blk_memremap_flags(ndbr));
+	if (!mmio->base) {
+		dev_err(dev, "%s failed to map blk dimm\n", nvdimm_name(nvdimm));
+		return -ENOMEM;
+	}
+
+	p->mmio = mmio;
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
+		spin_lock(&nfit_test_lock);
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
+		spin_unlock(&nfit_test_lock);
+		if (nfit_res)
+			return nfit_res;
+	}
+
+	pr_warn("Failed to get resource\n");
+
+	return NULL;
+}
+
+static void ndtest_release_resource(void * data)
+{
+	struct nfit_test_resource *res  = data;
+
+	spin_lock(&nfit_test_lock);
+	list_del(&res->list);
+	spin_unlock(&nfit_test_lock);
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
+		return 0;
+
+	buf = vmalloc(size);
+	if (size >= DIMM_SIZE)
+		__dma = gen_pool_alloc_algo(ndtest_pool, size,
+					  gen_pool_first_fit_align, &data);
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
+	spin_lock(&nfit_test_lock);
+	list_add(&res->list, &p->resources);
+	spin_unlock(&nfit_test_lock);
+
+	if (dma)
+		*dma = __dma;
+
+	if(!devm_add_action(&p->pdev.dev, ndtest_release_resource, res))
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
+int ndtest_dimm_register(struct ndtest_priv *priv, struct ndtest_dimm *dimm, int id)
+{
+	struct device *dev = &priv->pdev.dev;
+	struct nd_mapping_desc mapping;
+	struct nd_region_desc *ndr_desc;
+	struct nd_blk_region_desc ndbr_desc;
+	unsigned long dimm_flags = 0;
+
+	if (dimm->type == NDTEST_REGION_TYPE_PMEM) {
+		set_bit(NDD_ALIASING, &dimm_flags);
+		if (priv->pdev.id == 0)
+			set_bit(NDD_LABELING, &dimm_flags);
+	}
+
+	dimm->nvdimm = nvdimm_create(priv->bus, dimm,
+				    ndtest_nvdimm_attribute_groups, dimm_flags,
+				    NDTEST_SCM_DIMM_CMD_MASK, 0, NULL);
+	if (!dimm->nvdimm) {
+		dev_err(dev, "Error creating DIMM object for %pOF\n", priv->dn);
+		return -ENXIO;
+	}
+
+	memset(&mapping, 0, sizeof(mapping));
+	memset(&ndbr_desc, 0, sizeof(ndbr_desc));
+
+	/* now add the region */
+	memset(&mapping, 0, sizeof(mapping));
+	mapping.nvdimm = dimm->nvdimm;
+	mapping.start = dimm->res.start;
+	mapping.size = dimm->size;
+
+	ndr_desc = &ndbr_desc.ndr_desc;
+	memset(ndr_desc, 0, sizeof(*ndr_desc));
+	ndr_desc->res = &dimm->res;
+	ndr_desc->provider_data = dimm;
+	ndr_desc->mapping = &mapping;
+	ndr_desc->num_mappings = 1;
+	ndr_desc->nd_set = &dimm->nd_set;
+	ndr_desc->num_lanes = 1;
+
+	switch (dimm->type) {
+	case NDTEST_REGION_TYPE_PMEM:
+		dimm->region = nvdimm_pmem_region_create(priv->bus, ndr_desc);
+		break;
+	case NDTEST_REGION_TYPE_BLK:
+		ndbr_desc.enable = ndtest_blk_region_enable;
+		ndbr_desc.do_io = ndtest_blk_do_io;
+		dimm->region = nvdimm_blk_region_create(priv->bus, ndr_desc);
+		break;
+	default:
+		pr_err("Invalid region type\n");
+	}
+
+	if (!dimm->region) {
+		dev_err(dev, "Error registering region %pR\n", ndr_desc->res);
+		return -ENXIO;
+	}
+
+	dimm->dev = device_create_with_groups(ndtest_dimm_class,
+					     &priv->pdev.dev,
+					     0, dimm, dimm_attribute_groups,
+					     "test_dimm%d", id);
+	if (!dimm->dev)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int ndtest_nvdimm_init(struct ndtest_priv *p)
+{
+	struct ndtest_dimm *d;
+	u64 uuid[2];
+	void *res;
+	int i, id;
+
+	for (i = 0; i < p->config->dimm_count; i++) {
+		d = &p->config->dimm[i];
+		d->id = id= p->config->dimm_start + i;
+		res = ndtest_alloc_resource(p, LABEL_SIZE, NULL);
+		if (!res)
+			return -ENOMEM;
+
+		d->label_area = res;
+		sprintf(d->label_area, "label%d", id);
+		d->config_size = LABEL_SIZE;
+		d->res.name = p->pdev.name;
+
+		if (uuid_parse(d->uuid_str, (uuid_t *) uuid))
+			pr_err("failed to parse UUID\n");
+
+		d->nd_set.cookie1 = cpu_to_le64(uuid[0]);
+		d->nd_set.cookie2 = cpu_to_le64(uuid[1]);
+
+		switch (d->type) {
+		case NDTEST_REGION_TYPE_PMEM:
+			/* setup the resource */
+			res = ndtest_alloc_resource(p, d->size,
+						    &d->res.start);
+			if (!res)
+				return -ENOMEM;
+
+			d->res.end = d->res.start + d->size - 1;
+			break;
+		case NDTEST_REGION_TYPE_BLK:
+			WARN_ON(p->nblks > NUM_DCR);
+
+			if (!ndtest_alloc_resource(p, d->size,
+						   &p->dimm_dma[p->nblks]))
+				return -ENOMEM;
+
+			if (!ndtest_alloc_resource(p, LABEL_SIZE,
+				    &p->label_dma[p->nblks]))
+				return -ENOMEM;
+
+			if (!ndtest_alloc_resource(p, LABEL_SIZE,
+				    &p->dcr_dma[p->nblks]))
+				return -ENOMEM;
+
+			d->address = p->dcr_dma[p->nblks];
+			p->nblks++;
+
+			break;
+		}
+
+		ndtest_dimm_register(p, d, id);
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
+	p->config = &bus_configs[p->pdev.id];
+
+	p->bus_desc.ndctl = ndtest_ctl;
+	p->bus_desc.module = THIS_MODULE;
+	p->bus_desc.provider_name = NULL;
+
+	if (p->bus)
+		return 0;
+
+	p->bus = nvdimm_bus_register(&pdev->dev, &p->bus_desc);
+	if (!p->bus) {
+		dev_err(&pdev->dev, "Error creating nvdimm bus %pOF\n", p->dn);
+		return -ENOMEM;
+	}
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
+	rc = devm_add_action_or_reset(&pdev->dev, put_dimms, p);
+	if (rc)
+		goto err;
+
+	platform_set_drvdata(pdev, p);
+
+	return 0;
+
+err:
+	nvdimm_bus_unregister(p->bus);
+	kfree(p->bus_desc.provider_name);
+	put_device(&pdev->dev);
+	kfree(p);
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
+	if (ndtest_pool)
+		gen_pool_destroy(ndtest_pool);
+
+	for (i = 0; i < NUM_INSTANCES; i++)
+		if (instances[i])
+			platform_device_unregister(&instances[i]->pdev);
+
+	nfit_test_teardown();
+	for (i = 0; i < NUM_INSTANCES; i++)
+		if (instances[i])
+			put_device(&instances[i]->pdev.dev);
+
+	return rc;
+}
+
+static __exit void ndtest_exit(void)
+{
+	int i;
+
+	for (i = 0; i < NUM_INSTANCES; i++)
+		platform_device_unregister(&instances[i]->pdev);
+
+	platform_driver_unregister(&ndtest_driver);
+	nfit_test_teardown();
+
+	gen_pool_destroy(ndtest_pool);
+
+	for (i = 0; i < NUM_INSTANCES; i++)
+		put_device(&instances[i]->pdev.dev);
+	class_destroy(ndtest_dimm_class);
+}
+
+module_init(ndtest_init);
+module_exit(ndtest_exit);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("IBM Corporation");
diff --git a/tools/testing/nvdimm/test/ndtest.h b/tools/testing/nvdimm/test/ndtest.h
new file mode 100644
index 0000000000000..dfc7204ab3cc8
--- /dev/null
+++ b/tools/testing/nvdimm/test/ndtest.h
@@ -0,0 +1,63 @@
+#include <linux/platform_device.h>
+#include <linux/libnvdimm.h>
+
+typedef enum {
+	NDTEST_REGION_TYPE_PMEM = 0x0,
+	NDTEST_REGION_TYPE_BLK = 0x1,
+} nd_flags;
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
+	unsigned flags;
+	unsigned nblks;
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
+	struct resource res;
+	struct device *dev;
+	struct nvdimm *nvdimm;
+	struct nd_region *region;
+	struct nd_interleave_set nd_set;
+	struct ndtest_blk_mmio *mmio;
+
+	dma_addr_t address;
+	unsigned long config_size;
+	unsigned long fail_cmd_flags;
+	void *label_area;
+	char *uuid_str;
+	nd_flags type;
+	unsigned size;
+	unsigned handle;
+	int id;
+	int fail_cmd_code;
+};
+
+struct ndtest_region {
+	;
+};
+
+struct ndtest_config {
+	unsigned dimm_count;
+	unsigned dimm_start;
+	struct ndtest_dimm *dimm;
+	struct ndtest_region *region;
+};
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

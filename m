Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E441D2D01
	for <lists+linux-nvdimm@lfdr.de>; Thu, 14 May 2020 12:37:52 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5F31E11B5821B;
	Thu, 14 May 2020 03:35:07 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CF7471189270F
	for <linux-nvdimm@lists.01.org>; Thu, 14 May 2020 03:35:05 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y25so1143479pfn.5
        for <linux-nvdimm@lists.01.org>; Thu, 14 May 2020 03:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BZDGksl7xFnObCsrNZ+VZgXLVR7UMkTNcDbMGW+j9ms=;
        b=KhGby8fEw8go56NgQCkrg0eSvQrqC6vRcT3ZJ3joPydqTCSprVd27ZJRk/YAJv57jG
         Dzi5heLVdrj8KFEf3Bzav5ud1YVHkUApvlS71UtN2XbBWrXahJZiaA9E4FMqQohWfxki
         gJaywjzOkM3no5fDloYen3//6OpLe0GAbvzutZnXyAG0w3U+amP4AQpy9gTRR88qyPW4
         dWUbU0oaL6w+eitlCRtASnJKVKtv2iW/2fNaxgtPE5V4omNNdPztgn95CkugMsx5nnJS
         flC5DhIboYIrIfYEOu6diGcFWhPwx2uF0n+WMIL02WdntXNruw7rggiuABWF2PUAwWVV
         dp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BZDGksl7xFnObCsrNZ+VZgXLVR7UMkTNcDbMGW+j9ms=;
        b=BwzRWDUqC1VPnWvnLeeO0QzuiOK74sKAblXgKTzNU/HM57BkC7Y3IWZ8q+z8D90mkQ
         bAPvj17LSWjWn9u9aXNS9McQDm5l0CJwIbFPPWExXKc4OyoMjY0lvCyic0mZ0Y9gHUbT
         M9y2VvmPqMYt+liQDqYHXAwyiO/twmObcpsq8afvRbtuybtkuzD2srcKvWc+orkMupoo
         WhutzM2PQQaz4YepNGRCj3RisT39Yn0BdR2C5xMGPuZgRrzyNl6yS+ciMfKKOf1bobz/
         qpZMyuZQ1Ekt52aV8hdMHFg+o/TbzCVIlQXJHhEs269sdDYi9JIMIwng4a5x4HBAoauh
         Z/Og==
X-Gm-Message-State: AOAM530yaU/cjs+GCcc20Baedi++PeaG4Um05UQV7IVYAl/NCSwgk+ud
	jRtjPIk22PSHDv0KjP5xabjSOkHMBX4=
X-Google-Smtp-Source: ABdhPJxCd9nkKTxEm4RPtMqS2P6KaPQgPO5X30kHIxKEu/aGZglU+2UDAIJcrSDFtfZQE+qbfGjC1g==
X-Received: by 2002:aa7:943c:: with SMTP id y28mr3756695pfo.171.1589452666620;
        Thu, 14 May 2020 03:37:46 -0700 (PDT)
Received: from santosiv.in.ibm.com ([2401:4900:360d:dc14:f138:80ae:1e3f:627f])
        by smtp.gmail.com with ESMTPSA id a21sm2012809pfk.39.2020.05.14.03.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 03:37:46 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: linux-nvdimm@lists.01.org,
	Dan Williams <dan.j.williams@intel.com>
Subject: [RFC] tools/testing/nvdimm: Add generic test module for non-nfit platforms
Date: Thu, 14 May 2020 16:06:45 +0530
Message-Id: <20200514103645.800911-1-santosh@fossix.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Message-ID-Hash: 5RKSAQZP4ZLG3K2LJ65OUBMRFKTCQIEQ
X-Message-ID-Hash: 5RKSAQZP4ZLG3K2LJ65OUBMRFKTCQIEQ
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: harish@linux.ibm.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5RKSAQZP4ZLG3K2LJ65OUBMRFKTCQIEQ/>
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

In this proposed module, which is mostly a copy of nfit_test.c but without
the ACPI dependencies, two regions are implemented without interleaving or
error injection. Using `make check` with this module passes only three tests
because of the limited implementation.

Please comment if anything can be done differently or better.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 tools/testing/nvdimm/config_check.c |   3 +-
 tools/testing/nvdimm/test/Kbuild    |   4 +
 tools/testing/nvdimm/test/ndtest.c  | 603 ++++++++++++++++++++++++++++
 3 files changed, 609 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/nvdimm/test/ndtest.c

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
index 75baebf8f4ba..2607da1be2cc 100644
--- a/tools/testing/nvdimm/test/Kbuild
+++ b/tools/testing/nvdimm/test/Kbuild
@@ -5,5 +5,9 @@ ccflags-y += -I$(srctree)/drivers/acpi/nfit/
 obj-m += nfit_test.o
 obj-m += nfit_test_iomap.o
 
+ifeq  ($(CONFIG_ACPI),y)
 nfit_test-y := nfit.o
+else
+nfit_test-y := ndtest.o
+endif
 nfit_test_iomap-y := iomap.o
diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/test/ndtest.c
new file mode 100644
index 000000000000..19a077988cc3
--- /dev/null
+++ b/tools/testing/nvdimm/test/ndtest.c
@@ -0,0 +1,603 @@
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
+
+struct ndtest_priv {
+	struct platform_device pdev;
+	struct device_node *dn;
+	struct list_head resources;
+	unsigned long config_size;
+	bool is_volatile;
+	void *label_area;
+
+	void (*setup)(struct ndtest_priv *t);
+
+	struct nvdimm_bus_descriptor bus_desc;
+	struct nvdimm_bus *bus;
+	struct nvdimm *nvdimm;
+	struct resource res;
+	struct nd_region *region;
+	struct nd_interleave_set nd_set;
+	struct device *dimm_dev;
+};
+
+enum {
+	DIMM_SIZE = SZ_32M,
+	LABEL_SIZE = SZ_128K,
+	NUM_INSTANCES = 2,
+};
+
+static unsigned long dimm_fail_cmd_flags[6];
+static DEFINE_SPINLOCK(nfit_test_lock);
+struct ndtest_priv *instances[NUM_INSTANCES];
+static struct class *ndtest_dimm_class;
+static struct gen_pool *ndtest_pool;
+
+#define NFIT_DIMM_HANDLE(node, socket, imc, chan, dimm)	 \
+	(((node & 0xfff) << 16) | ((socket & 0xf) << 12) \
+	 | ((imc & 0xf) << 8) | ((chan & 0xf) << 4) | (dimm & 0xf))
+
+static u32 handle[] = {
+	[0] = NFIT_DIMM_HANDLE(0, 0, 0, 0, 0),
+	[1] = NFIT_DIMM_HANDLE(0, 0, 0, 0, 1),
+};
+
+int ndtest_config_get(struct ndtest_priv *p, unsigned int buf_len,
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
+int ndtest_config_set(struct ndtest_priv *p, unsigned int buf_len,
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
+	struct ndtest_priv *p;
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
+		dev_dbg(&p->pdev.dev, "invalid command %u\n", cmd);
+		return -EINVAL;
+	}
+
+	*cmd_rc = 0;
+	return 0;
+}
+
+static int dimm_name_to_id(struct device *dev)
+{
+	int dimm;
+
+	if (sscanf(dev_name(dev), "test_dimm%d", &dimm) != 1)
+		return -ENXIO;
+	return dimm;
+}
+
+static ssize_t handle_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	int dimm = dimm_name_to_id(dev);
+
+	if (dimm < 0)
+		return dimm;
+
+	return sprintf(buf, "%#x\n", handle[dimm]);
+}
+DEVICE_ATTR_RO(handle);
+
+static ssize_t fail_cmd_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	int dimm = dimm_name_to_id(dev);
+
+	if (dimm < 0)
+		return dimm;
+
+	return sprintf(buf, "%#lx\n", dimm_fail_cmd_flags[dimm]);
+}
+
+static ssize_t fail_cmd_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t size)
+{
+	int dimm = dimm_name_to_id(dev);
+	unsigned long val;
+	ssize_t rc;
+
+	if (dimm < 0)
+		return dimm;
+
+	rc = kstrtol(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	dimm_fail_cmd_flags[dimm] = val;
+	return size;
+}
+static DEVICE_ATTR_RW(fail_cmd);
+
+static struct attribute *ndtest_test_dimm_attributes[] = {
+	&dev_attr_handle.attr,
+	&dev_attr_fail_cmd.attr,
+	NULL,
+};
+
+static struct attribute_group ndtest_test_dimm_attribute_group = {
+	.attrs = ndtest_test_dimm_attributes,
+};
+
+static const struct attribute_group *ndtest_test_dimm_attribute_groups[] = {
+	&ndtest_test_dimm_attribute_group,
+	NULL,
+};
+
+static void put_dimms(void *data)
+{
+	struct ndtest_priv *p = data;
+
+	if (p->dimm_dev)
+		device_unregister(p->dimm_dev);
+}
+
+int ndtest_dimm_init(struct ndtest_priv *p)
+{
+	if (devm_add_action_or_reset(&p->pdev.dev, put_dimms, p))
+		return -ENOMEM;
+
+	p->dimm_dev = device_create_with_groups(ndtest_dimm_class, &p->pdev.dev,
+					       0, NULL,
+					       ndtest_test_dimm_attribute_groups,
+					       "test_dimm%d", p->pdev.id);
+
+	if (!p->dimm_dev)
+		return -ENOMEM;
+
+	return 0;
+}
+
+#define NDTEST_SCM_DIMM_CMD_MASK	   \
+	((1ul << ND_CMD_GET_CONFIG_SIZE) | \
+	 (1ul << ND_CMD_GET_CONFIG_DATA) | \
+	 (1ul << ND_CMD_SET_CONFIG_DATA))
+
+static ssize_t vendor_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+
+	return sprintf(buf, "0x1234567\n");
+}
+static DEVICE_ATTR_RO(vendor);
+
+static struct ndtest_priv *to_ndtest_priv(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+
+	return container_of(pdev, struct ndtest_priv, pdev);
+}
+
+static ssize_t id_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct ndtest_priv *p = to_ndtest_priv(dev);
+
+	return sprintf(buf, "ndtest%d\n", p->pdev.id);
+}
+static DEVICE_ATTR_RO(id);
+
+static struct attribute *ndtest_dimm_attributes[] = {
+	&dev_attr_vendor.attr,
+	&dev_attr_id.attr,
+	NULL,
+};
+
+static umode_t ndtest_dimm_attr_visible(struct kobject *kobj,
+					struct attribute *a, int n)
+{
+	return a->mode;
+}
+
+static const struct attribute_group ndtest_dimm_attribute_group = {
+	.name = "ndtest",
+	.attrs = ndtest_dimm_attributes,
+	.is_visible = ndtest_dimm_attr_visible,
+};
+
+static const struct attribute_group *ndtest_dimm_attribute_groups[] = {
+	&ndtest_dimm_attribute_group,
+	NULL,
+};
+
+static int ndtest_nvdimm_init(struct ndtest_priv *priv)
+{
+	struct device *dev = &priv->pdev.dev;
+	struct nd_mapping_desc mapping;
+	struct nd_region_desc ndr_desc;
+	unsigned long dimm_flags = 0;
+
+	priv->bus_desc.ndctl = ndtest_ctl;
+	priv->bus_desc.module = THIS_MODULE;
+	priv->bus_desc.provider_name = NULL;
+
+	priv->bus = nvdimm_bus_register(&priv->pdev.dev, &priv->bus_desc);
+	if (!priv->bus) {
+		dev_err(dev, "Error creating nvdimm bus %pOF\n", priv->dn);
+		return -ENXIO;
+	}
+
+	if (priv->pdev.id) {
+		set_bit(NDD_ALIASING, &dimm_flags);
+	}
+	set_bit(NDD_LABELING, &dimm_flags);
+
+	priv->nvdimm = nvdimm_create(priv->bus, priv,
+				    ndtest_dimm_attribute_groups, dimm_flags,
+				    NDTEST_SCM_DIMM_CMD_MASK, 0, NULL);
+	if (!priv->nvdimm) {
+		dev_err(dev, "Error creating DIMM object for %pOF\n", priv->dn);
+		goto err;
+	}
+
+	if (nvdimm_bus_check_dimm_count(priv->bus, 1))
+		goto err;
+
+	ndtest_dimm_init(priv);
+
+	/* now add the region */
+	memset(&mapping, 0, sizeof(mapping));
+	mapping.nvdimm = priv->nvdimm;
+	mapping.start = priv->res.start;
+	mapping.size = DIMM_SIZE;
+
+	memset(&ndr_desc, 0, sizeof(ndr_desc));
+	ndr_desc.res = &priv->res;
+	ndr_desc.provider_data = priv;
+	ndr_desc.mapping = &mapping;
+	ndr_desc.num_mappings = 1;
+	ndr_desc.nd_set = &priv->nd_set;
+
+	priv->region = nvdimm_pmem_region_create(priv->bus, &ndr_desc);
+	if (!priv->region) {
+		dev_err(dev, "Error registering region %pR\n", ndr_desc.res);
+		goto err;
+	}
+
+	return 0;
+
+err:
+	nvdimm_bus_unregister(priv->bus);
+	kfree(priv->bus_desc.provider_name);
+	return -ENXIO;
+}
+
+static void ndtest_release(struct device *dev)
+{
+	struct ndtest_priv *p = to_ndtest_priv(dev);
+
+	kfree(p);
+}
+
+static struct nfit_test_resource *ndtest_resource_lookup(resource_size_t addr)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(instances); i++) {
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
+struct nfit_test_resource *ndtest_get_resource(struct ndtest_priv *p, size_t size)
+{
+	struct nfit_test_resource *res;
+	struct genpool_data_align data = {
+		.align = SZ_128M,
+	};
+	unsigned long buf;
+
+	if (!size)
+		return NULL;
+
+	res = kzalloc(sizeof(*res), GFP_KERNEL);
+	if (!res)
+		return NULL;
+
+	buf = gen_pool_alloc_algo(ndtest_pool, DIMM_SIZE,
+				  gen_pool_first_fit_align, &data);
+	if (!buf) {
+		kfree(res);
+		return NULL;
+	}
+
+	INIT_LIST_HEAD(&res->list);
+	res->dev = &p->pdev.dev;
+
+	res->buf = vmalloc(size);
+	if (!res->buf)
+		goto buf_err;
+
+	res->res.start = buf;
+	res->res.end = buf + size - 1;
+	spin_lock_init(&res->lock);
+	INIT_LIST_HEAD(&res->requests);
+	spin_lock(&nfit_test_lock);
+	list_add(&res->list, &p->resources);
+	spin_unlock(&nfit_test_lock);
+
+	if(!devm_add_action(&p->pdev.dev, ndtest_release_resource, res))
+		return res;
+
+	kfree(res->buf);
+buf_err:
+	gen_pool_free(ndtest_pool, buf, size);
+	kfree(res);
+
+	return NULL;
+}
+
+#define UUID_NDTEST_BUS "2f10e7a4-9e91-11e4-89d3-123b93f75cba"
+static int ndtest_probe(struct platform_device *pdev)
+{
+	struct nfit_test_resource *res;
+	struct ndtest_priv *p;
+	u64 uuid[2];
+	int rc;
+
+
+	p = to_ndtest_priv(&pdev->dev);
+
+	/* We just need to ensure that set cookies are unique across */
+	uuid_parse(UUID_NDTEST_BUS, (uuid_t *) uuid);
+	/*
+	 * cookie1 and cookie2 are not really little endian
+	 * we store a little endian representation of the
+	 * uuid str so that we can compare this with the label
+	 * area cookie irrespective of the endian config with which
+	 * the kernel is built.
+	 */
+	p->nd_set.cookie1 = cpu_to_le64(uuid[0]);
+	p->nd_set.cookie2 = cpu_to_le64(uuid[1]);
+
+	/* setup the resource */
+	res = ndtest_get_resource(p, DIMM_SIZE);
+	if (!res) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	p->res.start = (resource_size_t) res->res.start;
+	p->res.end = res->res.end;
+	p->label_area = vmalloc(LABEL_SIZE);
+	sprintf(p->label_area, "label%d", p->pdev.id);
+	p->config_size = LABEL_SIZE;
+	p->res.name = pdev->name;
+	p->res.flags = IORESOURCE_MEM;
+
+	rc = ndtest_nvdimm_init(p);
+	if (rc)
+		goto err;
+
+	platform_set_drvdata(pdev, p);
+
+	return 0;
+
+err:
+	put_device(&pdev->dev);
+	kfree(p);
+	return rc;
+}
+
+static int ndtest_remove(struct platform_device *pdev)
+{
+	struct ndtest_priv *p = platform_get_drvdata(pdev);
+
+	nvdimm_bus_unregister(p->bus);
+	kfree(p);
+
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
+	for (i = 0; i < NUM_INSTANCES; ++i) {
+		struct ndtest_priv *priv;
+		struct platform_device *pdev;
+
+		instances[i] = kzalloc(sizeof(*priv), GFP_KERNEL);
+		if (!instances[i]) {
+			rc = -ENOMEM;
+			goto err_register;
+		}
+
+		priv = instances[i];
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
+	}
+
+	rc = platform_driver_register(&ndtest_driver);
+	if (rc)
+		goto err_register;
+
+	return 0;
+
+ err_register:
+	if (ndtest_pool)
+		gen_pool_destroy(ndtest_pool);
+
+	for (i = 0; i < NUM_INSTANCES; ++i) {
+		if (instances[i]) {
+			put_device(&instances[i]->pdev.dev);
+			platform_device_unregister(&instances[i]->pdev);
+			kfree(instances[i]);
+		}
+	}
+
+	*instances = NULL;
+
+	return rc;
+}
+
+static __exit void ndtest_exit(void)
+{
+	int i;
+
+	if (!*instances)
+		return;
+
+	for (i = 0; i < NUM_INSTANCES; ++i) {
+		if (instances[i]) {
+			put_device(&instances[i]->pdev.dev);
+			platform_device_unregister(&instances[i]->pdev);
+			kfree(instances[i]);
+		}
+	}
+
+	platform_driver_unregister(&ndtest_driver);
+	gen_pool_destroy(ndtest_pool);
+	class_destroy(ndtest_dimm_class);
+}
+
+module_init(ndtest_init);
+module_exit(ndtest_exit);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("IBM Corporation");
-- 
2.25.4
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

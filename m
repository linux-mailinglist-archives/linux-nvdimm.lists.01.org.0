Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B44B2E0553
	for <lists+linux-nvdimm@lfdr.de>; Tue, 22 Dec 2020 05:23:32 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 11CB8100EBBC3;
	Mon, 21 Dec 2020 20:23:31 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4C91B100EBB62
	for <linux-nvdimm@lists.01.org>; Mon, 21 Dec 2020 20:23:28 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id g18so7595683pgk.1
        for <linux-nvdimm@lists.01.org>; Mon, 21 Dec 2020 20:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vyk+/W4gCT3ZjMU2nmmSpWFfvsji8noZi+JidKel2dw=;
        b=scfhnLKmitE0kU9+rLFmGrEV9++lagpOvEwb0UGZM3j/tV6OqdvWgyVY5cJtpjWqRL
         prTMkMk+Ezw6NNe/RZcZKEjTJfEQyGADjcRsWRYvqJqJhVErK6Kg1Wnyz8fiA2Tt7Z5U
         Zsi3gYW3jQ6hL5KXssrUk67H4hjL0uvfYR8hrYiuiJQwZOPGqM8NG1HcsIWmem3fA4Ki
         ruqcKdM8eYAi0zjF9UkhR96jXjbvDXAv1xFLlWp+0xKI5bIIzUGhzYTZjKKYHQZrEW2a
         7CSVwR9vob5mI/EYH5nkiow7lvtsdT5lG0K5ztsZV+7h9xEMEhA5ZaFW6HczI0MFZsZo
         wfmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vyk+/W4gCT3ZjMU2nmmSpWFfvsji8noZi+JidKel2dw=;
        b=NRHWwmoLP5359kZXpyQ//V/i6b8kvILYsVtxM3RE39FVpZVAyhFiay8o6hcAsa9dNi
         q/0Rj8jxyi0COVhZgxwR5veJBB0Ft7WYNVk1Ks2mlGsd4gkkdvJxsN3bac1YgeCEt158
         qcAmkeI/DMrKv9W1uT7LVFH0jiHhqnJgAx2l/WVf821IBk/BDI62sMalAOXyKgMDcSqp
         4y1lD3xsjZxQMJsZSXA1WmXD6C7Do+bRJgmwNhjcV4fAGHin85OoBgFcqV6zsqrS0RIH
         NRj2jp5imu+OJX+PlPh6X/K2RIziNZGIsHIx/+u5UMnfCCt+DDIAHT4BUEPMfdywJaBj
         Gxmw==
X-Gm-Message-State: AOAM531xW2PyUahiXACDElPRv8ca4Ip7BuZhM04kk0hjK25Fi2CieQ1u
	so7OUfqpfyOZxLSDEDDyfzrG6Gf18P2LKQ==
X-Google-Smtp-Source: ABdhPJyj9o+UZLijB76+cN8Xv3HdmAMS18mbLJkxbkll2pdcg+E1aB7mADAUfydRyhG9sVSqzX/JBQ==
X-Received: by 2002:a63:2902:: with SMTP id p2mr18084383pgp.274.1608611007639;
        Mon, 21 Dec 2020 20:23:27 -0800 (PST)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id s5sm17909498pfh.5.2020.12.21.20.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 20:23:27 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [PATCH 3/7] ndtest: Add dimms to the two buses
Date: Tue, 22 Dec 2020 09:52:36 +0530
Message-Id: <20201222042240.2983755-4-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201222042240.2983755-1-santosh@fossix.org>
References: <20201222042240.2983755-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: HXRCPEPJECJ4FQTMWIHKK6WZGGD5K5WZ
X-Message-ID-Hash: HXRCPEPJECJ4FQTMWIHKK6WZGGD5K5WZ
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HXRCPEPJECJ4FQTMWIHKK6WZGGD5K5WZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

A config array is used to hold the dimms for each bus. These dimms are
registered with nvdimm, and new nvdimms are created on the buses.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 tools/testing/nvdimm/test/ndtest.c | 258 +++++++++++++++++++++++++++++
 tools/testing/nvdimm/test/ndtest.h |  36 ++++
 2 files changed, 294 insertions(+)

diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/test/ndtest.c
index 001527b37a23..a82790013f8a 100644
--- a/tools/testing/nvdimm/test/ndtest.c
+++ b/tools/testing/nvdimm/test/ndtest.c
@@ -25,8 +25,83 @@ enum {
 	NUM_DCR = 4,
 };
 
+#define NDTEST_SCM_DIMM_CMD_MASK	   \
+	((1ul << ND_CMD_GET_CONFIG_SIZE) | \
+	 (1ul << ND_CMD_GET_CONFIG_DATA) | \
+	 (1ul << ND_CMD_SET_CONFIG_DATA) | \
+	 (1ul << ND_CMD_CALL))
+
+#define NFIT_DIMM_HANDLE(node, socket, imc, chan, dimm)			\
+	(((node & 0xfff) << 16) | ((socket & 0xf) << 12)		\
+	 | ((imc & 0xf) << 8) | ((chan & 0xf) << 4) | (dimm & 0xf))
+
+static DEFINE_SPINLOCK(ndtest_lock);
 static struct ndtest_priv *instances[NUM_INSTANCES];
 static struct class *ndtest_dimm_class;
+static struct gen_pool *ndtest_pool;
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
+	},
+};
+
+static struct ndtest_config bus_configs[NUM_INSTANCES] = {
+	/* bus 1 */
+	{
+		.dimm_start = 0,
+		.dimm_count = ARRAY_SIZE(dimm_group1),
+		.dimms = dimm_group1,
+	},
+	/* bus 2 */
+	{
+		.dimm_start = ARRAY_SIZE(dimm_group1),
+		.dimm_count = ARRAY_SIZE(dimm_group2),
+		.dimms = dimm_group2,
+	},
+};
 
 static inline struct ndtest_priv *to_ndtest_priv(struct device *dev)
 {
@@ -65,6 +140,152 @@ static int ndtest_ctl(struct nvdimm_bus_descriptor *nd_desc,
 	return 0;
 }
 
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
+	dimm->nvdimm = nvdimm_create(priv->bus, dimm, NULL, dimm_flags,
+				    NDTEST_SCM_DIMM_CMD_MASK, 0, NULL);
+	if (!dimm->nvdimm) {
+		dev_err(dev, "Error creating DIMM object for %pOF\n", priv->dn);
+		return -ENXIO;
+	}
+
+	dimm->dev = device_create_with_groups(ndtest_dimm_class,
+					     &priv->pdev.dev,
+					     0, dimm, NULL,
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
 static ssize_t compatible_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
@@ -89,6 +310,8 @@ static const struct attribute_group *ndtest_attribute_groups[] = {
 
 static int ndtest_bus_register(struct ndtest_priv *p)
 {
+	p->config = &bus_configs[p->pdev.id];
+
 	p->bus_desc.ndctl = ndtest_ctl;
 	p->bus_desc.module = THIS_MODULE;
 	p->bus_desc.provider_name = NULL;
@@ -114,14 +337,34 @@ static int ndtest_remove(struct platform_device *pdev)
 static int ndtest_probe(struct platform_device *pdev)
 {
 	struct ndtest_priv *p;
+	int rc;
 
 	p = to_ndtest_priv(&pdev->dev);
 	if (ndtest_bus_register(p))
 		return -ENOMEM;
 
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
 	platform_set_drvdata(pdev, p);
 
 	return 0;
+
+err:
+	pr_err("%s:%d Failed nvdimm init\n", __func__, __LINE__);
+	return rc;
 }
 
 static const struct platform_device_id ndtest_id[] = {
@@ -155,6 +398,10 @@ static void cleanup_devices(void)
 
 	nfit_test_teardown();
 
+	if (ndtest_pool)
+		gen_pool_destroy(ndtest_pool);
+
+
 	if (ndtest_dimm_class)
 		class_destroy(ndtest_dimm_class);
 }
@@ -178,6 +425,17 @@ static __init int ndtest_init(void)
 		goto err_register;
 	}
 
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
 	/* Each instance can be taken as a bus, which can have multiple dimms */
 	for (i = 0; i < NUM_INSTANCES; i++) {
 		struct ndtest_priv *priv;
diff --git a/tools/testing/nvdimm/test/ndtest.h b/tools/testing/nvdimm/test/ndtest.h
index 831ac5c65f50..e607d72ffed1 100644
--- a/tools/testing/nvdimm/test/ndtest.h
+++ b/tools/testing/nvdimm/test/ndtest.h
@@ -5,12 +5,48 @@
 #include <linux/platform_device.h>
 #include <linux/libnvdimm.h>
 
+struct ndtest_config;
+
 struct ndtest_priv {
 	struct platform_device pdev;
 	struct device_node *dn;
 	struct list_head resources;
 	struct nvdimm_bus_descriptor bus_desc;
 	struct nvdimm_bus *bus;
+	struct ndtest_config *config;
+
+	dma_addr_t *dcr_dma;
+	dma_addr_t *label_dma;
+	dma_addr_t *dimm_dma;
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
+struct ndtest_config {
+	struct ndtest_dimm *dimms;
+	unsigned int dimm_count;
+	unsigned int dimm_start;
+	u8 num_regions;
 };
 
 #endif /* NDTEST_H */
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

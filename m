Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872372E0555
	for <lists+linux-nvdimm@lfdr.de>; Tue, 22 Dec 2020 05:23:38 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4FF0F100EBB68;
	Mon, 21 Dec 2020 20:23:37 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 98B3F100EBB63
	for <linux-nvdimm@lists.01.org>; Mon, 21 Dec 2020 20:23:34 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id n3so783948pjm.1
        for <linux-nvdimm@lists.01.org>; Mon, 21 Dec 2020 20:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rj9MDtinHeCpl48wt3tTfkEEof9dSThJzFQCTBSh9Kc=;
        b=wJNlkVhALCeyCapWNx2C8FA7vHzjvPBCZUBs6bet6FFywt8GmRURT+bisFoTXpFp+N
         NWGiT2JLeqkxNkUJjnEgUDqsKOrdMc8HwVnWEE7jAXu/58UBPui6nnDZPzCu70XvOG5S
         1TOUKDUQFF43LvxrcZnp+hwX6Gbl0Q07NmLBMaSNYtV7mGw5mBaqqWeO2MK+cgEIQ0sg
         xKUI7jK/dkAk0kd3q9xA9SfI0b/dw1qCv05sRMfJB1jjFg6SR2tOkVgCtnDohSmvoQa4
         as+3cymwaj3aWCjIG8LRBvnVjoCpXtRSSbu4h8bXCuovfaYtNMGNF1keWsHlDBv0+t3s
         +FuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rj9MDtinHeCpl48wt3tTfkEEof9dSThJzFQCTBSh9Kc=;
        b=nFd2IGccOLdXp/A0DqhhnZc2zCX2WbCz66TbHDJBHRegfkrTC6CUfo7rn7JyZKsnpk
         sZQHx78mNYjbDZbMitK8c4XUMMwvpdaX1Hpl2kJJUPnWOW2OdTAI5XGGfUSXr6Y++VCk
         sVSiGzlFuapNpUYdju4PB67fXeq5jVEJsYAYESP/eIyn4MfVQVwWDHRjcTs7GniwBhju
         tqYblmfA7Lr/BxLgcF2pFiqi0vHww3zl3AaTSFmTOfq8ftw/z6TujzSOWbjIz3/xeqlv
         Xs6pbMvaK7vOlLveJSZ2ttqnmTZ23/kY7IDoPMhqDVtkziqFhjCqymYBonVkQ/fPFrmu
         wI2g==
X-Gm-Message-State: AOAM531A6NX4L+zO2GlCG/7T1YOCtSCe83CP5NuWToKif6g2S4K3C8Ix
	Snwl+dZ0zIuEro00hBNB5idm5CKfTt5nqw==
X-Google-Smtp-Source: ABdhPJzH/zJbSk92SNzP9FcRQ/wrbV4bhxaIbQ8QUSjaqaWdfZEAiUy8XcJ1S/U7JbkyI1eucRXyEw==
X-Received: by 2002:a17:902:8216:b029:dc:1e79:e74c with SMTP id x22-20020a1709028216b02900dc1e79e74cmr19129321pln.5.1608611013945;
        Mon, 21 Dec 2020 20:23:33 -0800 (PST)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id s5sm17909498pfh.5.2020.12.21.20.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 20:23:33 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [PATCH 5/7] ndtest: Add regions and mappings to the test buses
Date: Tue, 22 Dec 2020 09:52:38 +0530
Message-Id: <20201222042240.2983755-6-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201222042240.2983755-1-santosh@fossix.org>
References: <20201222042240.2983755-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: EA6ZHIOSHTU3YGFE4MBS5U3GD2QIOKRU
X-Message-ID-Hash: EA6ZHIOSHTU3YGFE4MBS5U3GD2QIOKRU
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EA6ZHIOSHTU3YGFE4MBS5U3GD2QIOKRU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The bus config array is used to hold the regions and the respective
mappings. This config based interface enables to change the
dimm/region/namespace layouts easily.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 tools/testing/nvdimm/test/ndtest.c | 352 +++++++++++++++++++++++++++++
 tools/testing/nvdimm/test/ndtest.h |  26 +++
 2 files changed, 378 insertions(+)

diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/test/ndtest.c
index f7682e1d3efe..821296b59bdc 100644
--- a/tools/testing/nvdimm/test/ndtest.c
+++ b/tools/testing/nvdimm/test/ndtest.c
@@ -23,6 +23,7 @@ enum {
 	LABEL_SIZE = SZ_128K,
 	NUM_INSTANCES = 2,
 	NUM_DCR = 4,
+	NDTEST_MAX_MAPPING = 6,
 };
 
 #define NDTEST_SCM_DIMM_CMD_MASK	   \
@@ -88,18 +89,161 @@ static struct ndtest_dimm dimm_group2[] = {
 	},
 };
 
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
 static struct ndtest_config bus_configs[NUM_INSTANCES] = {
 	/* bus 1 */
 	{
 		.dimm_start = 0,
 		.dimm_count = ARRAY_SIZE(dimm_group1),
 		.dimms = dimm_group1,
+		.regions = bus0_regions,
+		.num_regions = ARRAY_SIZE(bus0_regions),
 	},
 	/* bus 2 */
 	{
 		.dimm_start = ARRAY_SIZE(dimm_group1),
 		.dimm_count = ARRAY_SIZE(dimm_group2),
 		.dimms = dimm_group2,
+		.regions = bus1_regions,
+		.num_regions = ARRAY_SIZE(bus1_regions),
 	},
 };
 
@@ -140,6 +284,95 @@ static int ndtest_ctl(struct nvdimm_bus_descriptor *nd_desc,
 	return 0;
 }
 
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
 static void ndtest_release_resource(void *data)
 {
 	struct nfit_test_resource *res  = data;
@@ -207,6 +440,119 @@ static void *ndtest_alloc_resource(struct ndtest_priv *p, size_t size,
 	return NULL;
 }
 
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
+	.name = "papr",
+	.attrs = ndtest_region_attributes,
+};
+
+static const struct attribute_group *ndtest_region_attribute_groups[] = {
+	&ndtest_region_attribute_group,
+	NULL,
+};
+
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
 static void put_dimms(void *data)
 {
 	struct ndtest_priv *p = data;
@@ -552,6 +898,10 @@ static int ndtest_probe(struct platform_device *pdev)
 	if (rc)
 		goto err;
 
+	rc = ndtest_init_regions(p);
+	if (rc)
+		goto err;
+
 	rc = devm_add_action_or_reset(&pdev->dev, put_dimms, p);
 	if (rc)
 		goto err;
@@ -617,6 +967,8 @@ static __init int ndtest_init(void)
 	dax_pmem_compat_test();
 #endif
 
+	nfit_test_setup(ndtest_resource_lookup, NULL);
+
 	ndtest_dimm_class = class_create(THIS_MODULE, "nfit_test_dimm");
 	if (IS_ERR(ndtest_dimm_class)) {
 		rc = PTR_ERR(ndtest_dimm_class);
diff --git a/tools/testing/nvdimm/test/ndtest.h b/tools/testing/nvdimm/test/ndtest.h
index e607d72ffed1..8f27ad6f7319 100644
--- a/tools/testing/nvdimm/test/ndtest.h
+++ b/tools/testing/nvdimm/test/ndtest.h
@@ -20,6 +20,15 @@ struct ndtest_priv {
 	dma_addr_t *dimm_dma;
 };
 
+struct ndtest_blk_mmio {
+	void __iomem *base;
+	u64 size;
+	u64 base_offset;
+	u32 line_size;
+	u32 num_lines;
+	u32 table_size;
+};
+
 struct ndtest_dimm {
 	struct device *dev;
 	struct nvdimm *nvdimm;
@@ -42,8 +51,25 @@ struct ndtest_dimm {
 	u8 no_alias;
 };
 
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
 struct ndtest_config {
 	struct ndtest_dimm *dimms;
+	struct ndtest_region *regions;
 	unsigned int dimm_count;
 	unsigned int dimm_start;
 	u8 num_regions;
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

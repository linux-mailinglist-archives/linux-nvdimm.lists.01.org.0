Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5D3382737
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 May 2021 10:40:39 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7831F100EB831;
	Mon, 17 May 2021 01:40:37 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 615EA100EB831
	for <linux-nvdimm@lists.01.org>; Mon, 17 May 2021 01:40:34 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d16so4435392pfn.12
        for <linux-nvdimm@lists.01.org>; Mon, 17 May 2021 01:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9dTjx1xcdhCQg8anHyE7el4qSg3ICYwRiR07kQ0CmXo=;
        b=WB1mLaH13Rw8NlmFlwpd7vuTgVM7QSBc4fKBbd4Xl1kdwhSEDnEvgNbhwqqvNBiyV+
         ZXoMEOna8pTOxSXwQGw1XOBQ4UfXGXfJQ72vpduVHVoyIFx9GdRQujS7HTxelflPg4xh
         f43Ri37FmeEugiY9SkqjkIgS2aBSAxY8s19S0XSzLuMgIS6I26shAEyoqz7FzDaBRZ13
         8zUvPuTZifyv/ExkuEb5RSL9vxNuGqiYC2WVbcPm/TQAFrWWUZEkd7EH+TKFieNy2QVo
         tlsPqhZr4loN1FijAyM+zAaEokrGmw5lvU/xQZ4FD8AmvJ1gQwRuBfi6plOL/33dEgEk
         bc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9dTjx1xcdhCQg8anHyE7el4qSg3ICYwRiR07kQ0CmXo=;
        b=Gzlt3GBkHg2xTlY9lbzSIWa0ISI7ePVQhDs+RnVkMQM73JqXU0tadeH4kSmHMgFtD3
         rTVrzFRTl6mj1mHKtSpgDbw7smZKM4dOmYRsjbM/oHQ/aOA8oWYybtVMSuyPXDbV+j8L
         tfZorkN95FRmuNLxzE+rbe3/X4ufBvcrSSd98VmiKyfWsNGygOmHDY/iTmvZo+3LWgnb
         S7iEvSgRmLCAbgegq36QUqhyvIQZq98FZJjhtSl640cLQa3QDU8x0cHROsuzdCLFyeJy
         prAskkGqmshCW2KpXKEPmjOkX2c4wTua1hn/nLYlG1kxji1XWUICqp5B7mOGZSjq9eNI
         21eA==
X-Gm-Message-State: AOAM530Zd/kAmvVTBERXHMaYpsZsqs+Sgibxhrm5NH9mFkVZM2i6JgFQ
	cG7ECjTEsHI0CXtR5yVmlxa2/eRHNpM7mA==
X-Google-Smtp-Source: ABdhPJzG83tBKR1CBiJNdJAbI5i1+H9YUKPTTp6t8uIiwQXlizmG4TFVU5j6b6+4wlKCZlMlRHpBlQ==
X-Received: by 2002:aa7:9885:0:b029:28e:9f7f:f23 with SMTP id r5-20020aa798850000b029028e9f7f0f23mr59843669pfl.75.1621240833524;
        Mon, 17 May 2021 01:40:33 -0700 (PDT)
Received: from desktop.fossix.local ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id u1sm1264361pfc.63.2021.05.17.01.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 01:40:33 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>
Subject: [v2 2/2] nvdimm/ndtest: Add support for error injection tests
Date: Mon, 17 May 2021 14:10:17 +0530
Message-Id: <20210517084017.180501-2-santosh@fossix.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517084017.180501-1-santosh@fossix.org>
References: <20210517084017.180501-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: ZTYW5GEYABXWF4UJTE2ABOJJIBOL4DOG
X-Message-ID-Hash: ZTYW5GEYABXWF4UJTE2ABOJJIBOL4DOG
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Shivaprasad G Bhat <sbhat@linux.ibm.com>, Harish Sriram <harish@linux.ibm.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZTYW5GEYABXWF4UJTE2ABOJJIBOL4DOG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add necessary support for error injection family of tests on non-acpi
platforms.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 tools/testing/nvdimm/test/ndtest.c | 455 ++++++++++++++++++++++++++++-
 tools/testing/nvdimm/test/ndtest.h |  25 ++
 2 files changed, 477 insertions(+), 3 deletions(-)

diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/test/ndtest.c
index bb47b145466d..09d98317bf4e 100644
--- a/tools/testing/nvdimm/test/ndtest.c
+++ b/tools/testing/nvdimm/test/ndtest.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#define pr_fmt(fmt) "ndtest :" fmt
 
 #include <linux/platform_device.h>
 #include <linux/device.h>
@@ -42,6 +42,7 @@ static DEFINE_SPINLOCK(ndtest_lock);
 static struct ndtest_priv *instances[NUM_INSTANCES];
 static struct class *ndtest_dimm_class;
 static struct gen_pool *ndtest_pool;
+static struct workqueue_struct *ndtest_wq;
 
 static const struct nd_papr_pdsm_health health_defaults = {
 	.dimm_unarmed = 0,
@@ -496,6 +497,139 @@ static int ndtest_pdsm_health_set_threshold(struct ndtest_dimm *dimm,
 	return 0;
 }
 
+static void ars_complete_all(struct ndtest_priv *p)
+{
+	int i;
+
+	for (i = 0; i < p->config->num_regions; i++) {
+		struct ndtest_region *region = &p->config->regions[i];
+
+		if (region->region)
+			nvdimm_region_notify(region->region,
+					     NVDIMM_REVALIDATE_POISON);
+	}
+}
+
+static void ndtest_scrub(struct work_struct *work)
+{
+	struct ndtest_priv *p = container_of(work, typeof(struct ndtest_priv),
+					     dwork.work);
+	struct badrange_entry *be;
+	int rc, i = 0;
+
+	spin_lock(&p->badrange.lock);
+	list_for_each_entry(be, &p->badrange.list, list) {
+		rc = nvdimm_bus_add_badrange(p->bus, be->start, be->length);
+		if (rc)
+			dev_err(&p->pdev.dev, "Failed to process ARS records\n");
+		else
+			i++;
+	}
+	spin_unlock(&p->badrange.lock);
+
+	if (i == 0) {
+		queue_delayed_work(ndtest_wq, &p->dwork, HZ);
+		return;
+	}
+
+	ars_complete_all(p);
+	p->scrub_count++;
+
+	mutex_lock(&p->ars_lock);
+	sysfs_notify_dirent(p->scrub_state);
+	clear_bit(ARS_BUSY, &p->scrub_flags);
+	clear_bit(ARS_POLL, &p->scrub_flags);
+	set_bit(ARS_VALID, &p->scrub_flags);
+	mutex_unlock(&p->ars_lock);
+
+}
+
+static int ndtest_scrub_notify(struct ndtest_priv *p)
+{
+	if (!test_and_set_bit(ARS_BUSY, &p->scrub_flags))
+		queue_delayed_work(ndtest_wq, &p->dwork, HZ);
+
+	return 0;
+}
+
+static int ndtest_ars_inject(struct ndtest_priv *p,
+			     struct nd_cmd_ars_err_inj *inj,
+			     unsigned int buf_len)
+{
+	int rc;
+
+	if (buf_len != sizeof(*inj)) {
+		dev_dbg(&p->bus->dev, "buflen: %u, inj size: %lu\n",
+			buf_len, sizeof(*inj));
+		rc = -EINVAL;
+		goto err;
+	}
+
+	rc =  badrange_add(&p->badrange, inj->err_inj_spa_range_base,
+			   inj->err_inj_spa_range_length);
+
+	if (inj->err_inj_options & (1 << ND_ARS_ERR_INJ_OPT_NOTIFY))
+		ndtest_scrub_notify(p);
+
+	inj->status = 0;
+
+	return 0;
+
+err:
+	inj->status = NFIT_ARS_INJECT_INVALID;
+	return rc;
+}
+
+static int ndtest_ars_inject_clear(struct ndtest_priv *p,
+				   struct nd_cmd_ars_err_inj_clr *inj,
+				   unsigned int buf_len)
+{
+	int rc;
+
+	if (buf_len != sizeof(*inj)) {
+		rc = -EINVAL;
+		goto err;
+	}
+
+	if (inj->err_inj_clr_spa_range_length <= 0) {
+		rc = -EINVAL;
+		goto err;
+	}
+
+	badrange_forget(&p->badrange, inj->err_inj_clr_spa_range_base,
+			inj->err_inj_clr_spa_range_length);
+
+	inj->status = 0;
+	return 0;
+
+err:
+	inj->status = NFIT_ARS_INJECT_INVALID;
+	return rc;
+}
+
+static int ndtest_ars_inject_status(struct ndtest_priv *p,
+				    struct nd_cmd_ars_err_inj_stat *stat,
+				    unsigned int buf_len)
+{
+	struct badrange_entry *be;
+	int max = SZ_4K / sizeof(struct nd_error_stat_query_record);
+	int i = 0;
+
+	stat->status = 0;
+	spin_lock(&p->badrange.lock);
+	list_for_each_entry(be, &p->badrange.list, list) {
+		stat->record[i].err_inj_stat_spa_range_base = be->start;
+		stat->record[i].err_inj_stat_spa_range_length = be->length;
+		i++;
+		if (i > max)
+			break;
+	}
+	spin_unlock(&p->badrange.lock);
+	stat->inj_err_rec_count = i;
+
+	return 0;
+}
+
 static int ndtest_dimm_cmd_call(struct ndtest_dimm *dimm, unsigned int buf_len,
 			   void *buf)
 {
@@ -519,6 +653,157 @@ static int ndtest_dimm_cmd_call(struct ndtest_dimm *dimm, unsigned int buf_len,
 	return 0;
 }
 
+static int ndtest_bus_cmd_call(struct nvdimm_bus_descriptor *nd_desc, void *buf,
+			       unsigned int buf_len, int *cmd_rc)
+{
+	struct nd_cmd_pkg *pkg = buf;
+	struct ndtest_priv *p = container_of(nd_desc, struct ndtest_priv,
+					     bus_desc);
+	void *payload = pkg->nd_payload;
+	unsigned int func = pkg->nd_command;
+	unsigned int len = pkg->nd_size_in + pkg->nd_size_out;
+
+	switch (func) {
+	case PAPR_PDSM_INJECT_SET:
+		return ndtest_ars_inject(p, payload, len);
+	case PAPR_PDSM_INJECT_CLEAR:
+		return ndtest_ars_inject_clear(p, payload, len);
+	case PAPR_PDSM_INJECT_GET:
+		return ndtest_ars_inject_status(p, payload, len);
+	}
+
+	return -ENOTTY;
+}
+
+static int ndtest_cmd_ars_cap(struct ndtest_priv *p, struct nd_cmd_ars_cap *cmd,
+			      unsigned int buf_len)
+{
+	int ars_recs;
+
+	if (buf_len < sizeof(*cmd))
+		return -EINVAL;
+
+	/* for testing, only store up to n records that fit within a page */
+	ars_recs = SZ_4K / sizeof(struct nd_ars_record);
+
+	cmd->max_ars_out = sizeof(struct nd_cmd_ars_status)
+		+ ars_recs * sizeof(struct nd_ars_record);
+	cmd->status = (ND_ARS_PERSISTENT | ND_ARS_VOLATILE) << 16;
+	cmd->clear_err_unit = 256;
+	p->max_ars = cmd->max_ars_out;
+
+	return 0;
+}
+
+static void post_ars_status(struct ars_state *state,
+			    struct badrange *badrange, u64 addr, u64 len)
+{
+	struct nd_cmd_ars_status *status;
+	struct nd_ars_record *record;
+	struct badrange_entry *be;
+	u64 end = addr + len - 1;
+	int i = 0;
+
+	state->deadline = jiffies + 1*HZ;
+	status = state->ars_status;
+	status->status = 0;
+	status->address = addr;
+	status->length = len;
+	status->type = ND_ARS_PERSISTENT;
+
+	spin_lock(&badrange->lock);
+	list_for_each_entry(be, &badrange->list, list) {
+		u64 be_end = be->start + be->length - 1;
+		u64 rstart, rend;
+
+		/* skip entries outside the range */
+		if (be_end < addr || be->start > end)
+			continue;
+
+		rstart = (be->start < addr) ? addr : be->start;
+		rend = (be_end < end) ? be_end : end;
+		record = &status->records[i];
+		record->handle = 0;
+		record->err_address = rstart;
+		record->length = rend - rstart + 1;
+		i++;
+	}
+	spin_unlock(&badrange->lock);
+
+	status->num_records = i;
+	status->out_length = sizeof(struct nd_cmd_ars_status)
+		+ i * sizeof(struct nd_ars_record);
+}
+
+#define NFIT_ARS_STATUS_BUSY (1 << 16)
+#define NFIT_ARS_START_BUSY 6
+
+static int ndtest_cmd_ars_start(struct ndtest_priv *priv,
+				struct nd_cmd_ars_start *start,
+				unsigned int buf_len, int *cmd_rc)
+{
+	if (buf_len < sizeof(*start))
+		return -EINVAL;
+
+	spin_lock(&priv->state.lock);
+	if (time_before(jiffies, priv->state.deadline)) {
+		start->status = NFIT_ARS_START_BUSY;
+		*cmd_rc = -EBUSY;
+	} else {
+		start->status = 0;
+		start->scrub_time = 1;
+		post_ars_status(&priv->state, &priv->badrange,
+				start->address, start->length);
+		*cmd_rc = 0;
+	}
+	spin_unlock(&priv->state.lock);
+
+	return 0;
+}
+
+static int ndtest_cmd_ars_status(struct ndtest_priv *priv,
+				 struct nd_cmd_ars_status *status,
+				 unsigned int buf_len, int *cmd_rc)
+{
+	if (buf_len < priv->state.ars_status->out_length)
+		return -EINVAL;
+
+	spin_lock(&priv->state.lock);
+	if (time_before(jiffies, priv->state.deadline)) {
+		memset(status, 0, buf_len);
+		status->status = NFIT_ARS_STATUS_BUSY;
+		status->out_length = sizeof(*status);
+		*cmd_rc = -EBUSY;
+	} else {
+		memcpy(status, priv->state.ars_status,
+		       priv->state.ars_status->out_length);
+		*cmd_rc = 0;
+	}
+	spin_unlock(&priv->state.lock);
+
+	return 0;
+}
+
+static int ndtest_cmd_clear_error(struct ndtest_priv *priv,
+				     struct nd_cmd_clear_error *inj,
+				     unsigned int buf_len, int *cmd_rc)
+{
+	const u64 mask = 255;
+
+	if (buf_len < sizeof(*inj))
+		return -EINVAL;
+
+	if ((inj->address & mask) || (inj->length & mask))
+		return -EINVAL;
+
+	badrange_forget(&priv->badrange, inj->address, inj->length);
+	inj->status = 0;
+	inj->cleared = inj->length;
+	*cmd_rc = 0;
+
+	return 0;
+}
+
 static int ndtest_ctl(struct nvdimm_bus_descriptor *nd_desc,
 		      struct nvdimm *nvdimm, unsigned int cmd, void *buf,
 		      unsigned int buf_len, int *cmd_rc)
@@ -531,8 +816,32 @@ static int ndtest_ctl(struct nvdimm_bus_descriptor *nd_desc,
 
 	*cmd_rc = 0;
 
-	if (!nvdimm)
-		return -EINVAL;
+	if (!nvdimm) {
+		struct ndtest_priv *priv;
+
+		if (!nd_desc)
+			return -ENOTTY;
+
+		priv = container_of(nd_desc, struct ndtest_priv, bus_desc);
+		switch (cmd) {
+		case ND_CMD_CALL:
+			return ndtest_bus_cmd_call(nd_desc, buf, buf_len,
+						   cmd_rc);
+		case ND_CMD_ARS_CAP:
+			return ndtest_cmd_ars_cap(priv, buf, buf_len);
+		case ND_CMD_ARS_START:
+			return ndtest_cmd_ars_start(priv, buf, buf_len, cmd_rc);
+		case ND_CMD_ARS_STATUS:
+			return ndtest_cmd_ars_status(priv, buf, buf_len,
+						     cmd_rc);
+		case ND_CMD_CLEAR_ERROR:
+			return ndtest_cmd_clear_error(priv, buf, buf_len,
+						      cmd_rc);
+		default:
+			dev_dbg(&priv->pdev.dev, "Invalid command\n");
+			return -ENOTTY;
+		}
+	}
 
 	dimm = nvdimm_provider_data(nvdimm);
 	if (!dimm)
@@ -683,6 +992,9 @@ static void *ndtest_alloc_resource(struct ndtest_priv *p, size_t size,
 		return NULL;
 
 	buf = vmalloc(size);
+	if (!buf)
+		return NULL;
+
 	if (size >= DIMM_SIZE)
 		__dma = gen_pool_alloc_algo(ndtest_pool, size,
 					    gen_pool_first_fit_align, &data);
@@ -1052,6 +1364,7 @@ static ssize_t flags_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(flags);
 
+
 #define PAPR_PMEM_DIMM_CMD_MASK				\
 	 ((1U << PAPR_PDSM_HEALTH)			\
 	 | (1U << PAPR_PDSM_HEALTH_INJECT)		\
@@ -1195,11 +1508,102 @@ static const struct attribute_group of_node_attribute_group = {
 	.attrs = of_node_attributes,
 };
 
+#define PAPR_PMEM_BUS_DSM_MASK				\
+	((1U << PAPR_PDSM_INJECT_SET)			\
+	 | (1U << PAPR_PDSM_INJECT_GET)			\
+	 | (1U << PAPR_PDSM_INJECT_CLEAR))
+
+static ssize_t bus_dsm_mask_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%#x\n", PAPR_PMEM_BUS_DSM_MASK);
+}
+static struct device_attribute dev_attr_bus_dsm_mask = {
+	.attr	= { .name = "dsm_mask", .mode = 0444 },
+	.show	= bus_dsm_mask_show,
+};
+
+static ssize_t scrub_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct nvdimm_bus_descriptor *nd_desc;
+	struct ndtest_priv *p;
+	ssize_t rc = -ENXIO;
+	bool busy = 0;
+
+	device_lock(dev);
+	nd_desc = dev_get_drvdata(dev);
+	if (!nd_desc) {
+		device_unlock(dev);
+		return rc;
+	}
+
+	p = container_of(nd_desc, struct ndtest_priv, bus_desc);
+
+	mutex_lock(&p->ars_lock);
+	busy = test_bit(ARS_BUSY, &p->scrub_flags) &&
+		!test_bit(ARS_CANCEL, &p->scrub_flags);
+	rc = sprintf(buf, "%d%s", p->scrub_count, busy ? "+\n" : "\n");
+	if (busy && capable(CAP_SYS_RAWIO) &&
+	    !test_and_set_bit(ARS_POLL, &p->scrub_flags))
+		mod_delayed_work(ndtest_wq, &p->dwork, HZ);
+
+	mutex_unlock(&p->ars_lock);
+
+	device_unlock(dev);
+	return rc;
+}
+
+static ssize_t scrub_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t size)
+{
+	struct nvdimm_bus_descriptor *nd_desc;
+	struct ndtest_priv *p;
+	ssize_t rc = 0;
+	long val;
+
+	rc = kstrtol(buf, 0, &val);
+	if (rc)
+		return rc;
+	if (val != 1)
+		return -EINVAL;
+	device_lock(dev);
+	nd_desc = dev_get_drvdata(dev);
+	if (nd_desc) {
+		p = container_of(nd_desc, struct ndtest_priv, bus_desc);
+
+		ndtest_scrub_notify(p);
+	}
+	device_unlock(dev);
+
+	return size;
+}
+static DEVICE_ATTR_RW(scrub);
+
+static struct attribute *ndtest_attributes[] = {
+	&dev_attr_bus_dsm_mask.attr,
+	&dev_attr_scrub.attr,
+	NULL,
+};
+
+static const struct attribute_group ndtest_attribute_group = {
+	.name = "papr",
+	.attrs = ndtest_attributes,
+};
+
 static const struct attribute_group *ndtest_attribute_groups[] = {
 	&of_node_attribute_group,
+	&ndtest_attribute_group,
 	NULL,
 };
 
+#define PAPR_PMEM_BUS_CMD_MASK				   \
+	(1UL << ND_CMD_ARS_CAP				   \
+	 | 1UL << ND_CMD_ARS_START			   \
+	 | 1UL << ND_CMD_ARS_STATUS			   \
+	 | 1UL << ND_CMD_CLEAR_ERROR			   \
+	 | 1UL << ND_CMD_CALL)
+
 static int ndtest_bus_register(struct ndtest_priv *p)
 {
 	p->config = &bus_configs[p->pdev.id];
@@ -1207,7 +1611,9 @@ static int ndtest_bus_register(struct ndtest_priv *p)
 	p->bus_desc.ndctl = ndtest_ctl;
 	p->bus_desc.module = THIS_MODULE;
 	p->bus_desc.provider_name = NULL;
+	p->bus_desc.cmd_mask = PAPR_PMEM_BUS_CMD_MASK;
 	p->bus_desc.attr_groups = ndtest_attribute_groups;
+	p->bus_desc.bus_family_mask = NVDIMM_FAMILY_PAPR;
 
 	set_bit(NVDIMM_FAMILY_PAPR, &p->bus_desc.dimm_family_mask);
 
@@ -1228,6 +1634,33 @@ static int ndtest_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int ndtest_init_ars(struct ndtest_priv *p)
+{
+	struct kernfs_node *papr_node;
+	struct device *bus_dev;
+
+	p->state.ars_status = devm_kzalloc(
+		&p->pdev.dev, sizeof(struct nd_cmd_ars_status) + SZ_4K,
+		GFP_KERNEL);
+	if (!p->state.ars_status)
+		return -ENOMEM;
+
+	bus_dev = to_nvdimm_bus_dev(p->bus);
+	papr_node = sysfs_get_dirent(bus_dev->kobj.sd, "papr");
+	if (!papr_node) {
+		dev_err(&p->pdev.dev, "sysfs_get_dirent 'papr' failed\n");
+		return -ENOENT;
+	}
+
+	p->scrub_state = sysfs_get_dirent(papr_node, "scrub");
+	if (!p->scrub_state) {
+		dev_err(&p->pdev.dev, "sysfs_get_dirent 'scrub' failed\n");
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
 static int ndtest_probe(struct platform_device *pdev)
 {
 	struct ndtest_priv *p;
@@ -1252,6 +1685,10 @@ static int ndtest_probe(struct platform_device *pdev)
 	if (rc)
 		goto err;
 
+	rc = ndtest_init_ars(p);
+	if (rc)
+		goto err;
+
 	rc = devm_add_action_or_reset(&pdev->dev, put_dimms, p);
 	if (rc)
 		goto err;
@@ -1299,6 +1736,7 @@ static void cleanup_devices(void)
 	if (ndtest_pool)
 		gen_pool_destroy(ndtest_pool);
 
+	destroy_workqueue(ndtest_wq);
 
 	if (ndtest_dimm_class)
 		class_destroy(ndtest_dimm_class);
@@ -1319,6 +1757,10 @@ static __init int ndtest_init(void)
 
 	nfit_test_setup(ndtest_resource_lookup, NULL);
 
+	ndtest_wq = create_singlethread_workqueue("nfit");
+	if (!ndtest_wq)
+		return -ENOMEM;
+
 	ndtest_dimm_class = class_create(THIS_MODULE, "nfit_test_dimm");
 	if (IS_ERR(ndtest_dimm_class)) {
 		rc = PTR_ERR(ndtest_dimm_class);
@@ -1348,6 +1790,7 @@ static __init int ndtest_init(void)
 		}
 
 		INIT_LIST_HEAD(&priv->resources);
+		badrange_init(&priv->badrange);
 		pdev = &priv->pdev;
 		pdev->name = KBUILD_MODNAME;
 		pdev->id = i;
@@ -1360,6 +1803,11 @@ static __init int ndtest_init(void)
 		get_device(&pdev->dev);
 
 		instances[i] = priv;
+
+		/* Everything about ARS here */
+		INIT_DELAYED_WORK(&priv->dwork, ndtest_scrub);
+		mutex_init(&priv->ars_lock);
+		spin_lock_init(&priv->state.lock);
 	}
 
 	rc = platform_driver_register(&ndtest_driver);
@@ -1377,6 +1825,7 @@ static __init int ndtest_init(void)
 
 static __exit void ndtest_exit(void)
 {
+	flush_workqueue(ndtest_wq);
 	cleanup_devices();
 	platform_driver_unregister(&ndtest_driver);
 }
diff --git a/tools/testing/nvdimm/test/ndtest.h b/tools/testing/nvdimm/test/ndtest.h
index d29638b6a332..d92c4f3df344 100644
--- a/tools/testing/nvdimm/test/ndtest.h
+++ b/tools/testing/nvdimm/test/ndtest.h
@@ -83,17 +83,34 @@ enum dimm_type {
 	NDTEST_REGION_TYPE_BLK = 0x1,
 };
 
+struct ars_state {
+	struct nd_cmd_ars_status *ars_status;
+	unsigned long deadline;
+	spinlock_t lock;
+};
+
 struct ndtest_priv {
 	struct platform_device pdev;
 	struct device_node *dn;
 	struct list_head resources;
 	struct nvdimm_bus_descriptor bus_desc;
+	struct delayed_work dwork;
+	struct mutex ars_lock;
 	struct nvdimm_bus *bus;
 	struct ndtest_config *config;
+	struct ars_state state;
+	struct badrange badrange;
+	struct nd_cmd_ars_status *ars_status;
+	struct kernfs_node *scrub_state;
 
 	dma_addr_t *dcr_dma;
 	dma_addr_t *label_dma;
 	dma_addr_t *dimm_dma;
+
+	unsigned long scrub_flags;
+	unsigned long ars_state;
+	unsigned int max_ars;
+	int scrub_count;
 };
 
 struct ndtest_blk_mmio {
@@ -235,4 +252,12 @@ struct nd_pkg_pdsm {
 	union nd_pdsm_payload payload;
 } __packed;
 
+enum scrub_flags {
+	ARS_BUSY,
+	ARS_CANCEL,
+	ARS_VALID,
+	ARS_POLL,
+	ARS_FAILED,
+};
+
 #endif /* NDTEST_H */
-- 
2.31.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

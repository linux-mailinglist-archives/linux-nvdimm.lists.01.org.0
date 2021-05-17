Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C980382736
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 May 2021 10:40:35 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5BDAD100EC1C8;
	Mon, 17 May 2021 01:40:33 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BE9CB100ED4BF
	for <linux-nvdimm@lists.01.org>; Mon, 17 May 2021 01:40:30 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id s4so1174563plg.12
        for <linux-nvdimm@lists.01.org>; Mon, 17 May 2021 01:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0BzoAIo2PeDq60VSn07VhjCCw8Fo6LWvUAs/Qq5ud30=;
        b=O1g8Cqv1pacBUza7PWvIbOplXq2HYpt9Cxeu+q58GStnABLvoTqUF4K6z8FpP8E+Ti
         o5eNyBK/d6dyIkvmCdSQ2ER4mv4pZ0VJEc0/eQJlyLUe2XlgeWhCPWknMiOjBw5T1o07
         lvXrh3IzZ8Nmi57RQUkO8hs8+AqCkmeJ6bagHUntv0HwhTsGM9S3ck8nWNKGcsxamXtM
         NbwyaIpUP3XNEuuYBj3oG4LuxYKf8HIN0vS1Rl297K0gao7ci8qcLqhx4qXjKrn/QKE7
         BBwBokUhMhN2Z55JMGmb484s1WOwxNUiCUWy/nG21yUs7IUwkGe0Xm32KgkaNT7hHe2M
         2Mwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0BzoAIo2PeDq60VSn07VhjCCw8Fo6LWvUAs/Qq5ud30=;
        b=hB4+eVrt13VNEJQ7k3c1CXTryrbdefzt8RfYsD4U+fMdV+OPcTJje/ceVZcHEaHvg9
         my3TT0sYMaC/0R5rNgC3+yB3Rk3VXmZ0cnGwoI8b8RZ3Yp1b4FHOjixKD1LyZRzHv59m
         3w6ylmrg9iV+tyNcY1q815ZD5IvbLbUcPQzJJIUB7l/hH5dmXufyv8jc26Cge0LuxYvL
         v5TawmH6RoObgvMpvvJcsQrhJdQ+nx+uL8pV5i4CYMC6OlQF2XrnMxn+wU75u6OIIoKT
         jnvMeDqbFK+iMNJOKVrptHOii9n//JR0EchbDvFRtwCFeeLL9uA8npQ9tfZ+qj8erB89
         e42w==
X-Gm-Message-State: AOAM533D9UsGx2tjuWp1Gfei5ax7KXKVI03OPWkWpJ6Ly4HmPgK9FyBv
	XALio5a13UyOQvhKDYEQpbGmfI2DfjXeEg==
X-Google-Smtp-Source: ABdhPJzjyDgWbmwT0uurJ/yekSGtk12rYC/sVRvLEKFx58+401Z66xb0LHWtLZdWbQpBjdx+O0uKBA==
X-Received: by 2002:a17:90a:4493:: with SMTP id t19mr19802723pjg.217.1621240827816;
        Mon, 17 May 2021 01:40:27 -0700 (PDT)
Received: from desktop.fossix.local ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id u1sm1264361pfc.63.2021.05.17.01.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 01:40:27 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>
Subject: [v2 1/2] tests/nvdimm/ndtest: Enable smart tests
Date: Mon, 17 May 2021 14:10:16 +0530
Message-Id: <20210517084017.180501-1-santosh@fossix.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Message-ID-Hash: DRYGWXBOFNIKEAL45Y3O3PB3TJMYIC5M
X-Message-ID-Hash: DRYGWXBOFNIKEAL45Y3O3PB3TJMYIC5M
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Shivaprasad G Bhat <sbhat@linux.ibm.com>, Harish Sriram <harish@linux.ibm.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DRYGWXBOFNIKEAL45Y3O3PB3TJMYIC5M/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>

The patch adds necessary health related dsm command implementations for
the ndctl inject-smart and monitor tests to pass.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
---
 tools/testing/nvdimm/test/ndtest.c | 258 +++++++++++++++++++++++++++++
 tools/testing/nvdimm/test/ndtest.h | 129 +++++++++++++++
 2 files changed, 387 insertions(+)

diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/test/ndtest.c
index 6862915f1fb0..bb47b145466d 100644
--- a/tools/testing/nvdimm/test/ndtest.c
+++ b/tools/testing/nvdimm/test/ndtest.c
@@ -30,6 +30,8 @@ enum {
 	((1ul << ND_CMD_GET_CONFIG_SIZE) | \
 	 (1ul << ND_CMD_GET_CONFIG_DATA) | \
 	 (1ul << ND_CMD_SET_CONFIG_DATA) | \
+	 (1ul << ND_CMD_SMART_THRESHOLD) | \
+	 (1uL << ND_CMD_SMART)           | \
 	 (1ul << ND_CMD_CALL))
 
 #define NFIT_DIMM_HANDLE(node, socket, imc, chan, dimm)			\
@@ -41,6 +43,21 @@ static struct ndtest_priv *instances[NUM_INSTANCES];
 static struct class *ndtest_dimm_class;
 static struct gen_pool *ndtest_pool;
 
+static const struct nd_papr_pdsm_health health_defaults = {
+	.dimm_unarmed = 0,
+	.dimm_bad_shutdown = 0,
+	.dimm_health = PAPR_PDSM_DIMM_UNHEALTHY,
+	.extension_flags = PDSM_DIMM_HEALTH_MEDIA_TEMPERATURE_VALID | PDSM_DIMM_HEALTH_ALARM_VALID |
+			   PDSM_DIMM_HEALTH_CTRL_TEMPERATURE_VALID | PDSM_DIMM_HEALTH_SPARES_VALID |
+			   PDSM_DIMM_HEALTH_RUN_GAUGE_VALID,
+	.dimm_fuel_gauge = 95,
+	.media_temperature = 23 * 16,
+	.ctrl_temperature = 25 * 16,
+	.spares = 75,
+	.alarm_flags = ND_PAPR_HEALTH_SPARE_TRIP |
+			ND_PAPR_HEALTH_TEMP_TRIP,
+};
+
 static struct ndtest_dimm dimm_group1[] = {
 	{
 		.size = DIMM_SIZE,
@@ -48,6 +65,16 @@ static struct ndtest_dimm dimm_group1[] = {
 		.uuid_str = "1e5c75d2-b618-11ea-9aa3-507b9ddc0f72",
 		.physical_id = 0,
 		.num_formats = 2,
+		.flags = PAPR_PMEM_HEALTH_NON_CRITICAL,
+		.extension_flags = health_defaults.extension_flags,
+		.dimm_fuel_gauge = health_defaults.dimm_fuel_gauge,
+		.media_temperature = health_defaults.media_temperature,
+		.ctrl_temperature = health_defaults.ctrl_temperature,
+		.spares = health_defaults.spares,
+		.alarm_flags = health_defaults.alarm_flags,
+		.media_temperature_threshold = 40 * 16,
+		.ctrl_temperature_threshold = 30 * 16,
+		.spares_threshold = 5,
 	},
 	{
 		.size = DIMM_SIZE,
@@ -55,6 +82,16 @@ static struct ndtest_dimm dimm_group1[] = {
 		.uuid_str = "1c4d43ac-b618-11ea-be80-507b9ddc0f72",
 		.physical_id = 1,
 		.num_formats = 2,
+		.flags = PAPR_PMEM_HEALTH_NON_CRITICAL,
+		.extension_flags = health_defaults.extension_flags,
+		.dimm_fuel_gauge = health_defaults.dimm_fuel_gauge,
+		.media_temperature = health_defaults.media_temperature,
+		.ctrl_temperature = health_defaults.ctrl_temperature,
+		.spares = health_defaults.spares,
+		.alarm_flags = health_defaults.alarm_flags,
+		.media_temperature_threshold = 40 * 16,
+		.ctrl_temperature_threshold = 30 * 16,
+		.spares_threshold = 5,
 	},
 	{
 		.size = DIMM_SIZE,
@@ -62,6 +99,16 @@ static struct ndtest_dimm dimm_group1[] = {
 		.uuid_str = "a9f17ffc-b618-11ea-b36d-507b9ddc0f72",
 		.physical_id = 2,
 		.num_formats = 2,
+		.flags = PAPR_PMEM_HEALTH_NON_CRITICAL,
+		.extension_flags = health_defaults.extension_flags,
+		.dimm_fuel_gauge = health_defaults.dimm_fuel_gauge,
+		.media_temperature = health_defaults.media_temperature,
+		.ctrl_temperature = health_defaults.ctrl_temperature,
+		.spares = health_defaults.spares,
+		.alarm_flags = health_defaults.alarm_flags,
+		.media_temperature_threshold = 40 * 16,
+		.ctrl_temperature_threshold = 30 * 16,
+		.spares_threshold = 5,
 	},
 	{
 		.size = DIMM_SIZE,
@@ -69,6 +116,16 @@ static struct ndtest_dimm dimm_group1[] = {
 		.uuid_str = "b6b83b22-b618-11ea-8aae-507b9ddc0f72",
 		.physical_id = 3,
 		.num_formats = 2,
+		.flags = PAPR_PMEM_HEALTH_NON_CRITICAL,
+		.extension_flags = health_defaults.extension_flags,
+		.dimm_fuel_gauge = health_defaults.dimm_fuel_gauge,
+		.media_temperature = health_defaults.media_temperature,
+		.ctrl_temperature = health_defaults.ctrl_temperature,
+		.spares = health_defaults.spares,
+		.alarm_flags = health_defaults.alarm_flags,
+		.media_temperature_threshold = 40 * 16,
+		.ctrl_temperature_threshold = 30 * 16,
+		.spares_threshold = 5,
 	},
 	{
 		.size = DIMM_SIZE,
@@ -296,6 +353,172 @@ static int ndtest_get_config_size(struct ndtest_dimm *dimm, unsigned int buf_len
 	return 0;
 }
 
+static int ndtest_pdsm_health(struct ndtest_dimm *dimm,
+			union nd_pdsm_payload *payload,
+			unsigned int buf_len)
+{
+	struct nd_papr_pdsm_health *health = &payload->health;
+
+	if (buf_len < sizeof(health))
+		return -EINVAL;
+
+	health->extension_flags = 0;
+	health->dimm_unarmed = !!(dimm->flags & PAPR_PMEM_UNARMED_MASK);
+	health->dimm_bad_shutdown = !!(dimm->flags & PAPR_PMEM_BAD_SHUTDOWN_MASK);
+	health->dimm_bad_restore = !!(dimm->flags & PAPR_PMEM_BAD_RESTORE_MASK);
+	health->dimm_health = PAPR_PDSM_DIMM_HEALTHY;
+
+	if (dimm->flags & PAPR_PMEM_HEALTH_FATAL)
+		health->dimm_health = PAPR_PDSM_DIMM_FATAL;
+	else if (dimm->flags & PAPR_PMEM_HEALTH_CRITICAL)
+		health->dimm_health = PAPR_PDSM_DIMM_CRITICAL;
+	else if (dimm->flags & PAPR_PMEM_HEALTH_UNHEALTHY ||
+		 dimm->flags & PAPR_PMEM_HEALTH_NON_CRITICAL)
+		health->dimm_health = PAPR_PDSM_DIMM_UNHEALTHY;
+
+	health->extension_flags = 0;
+	if (dimm->extension_flags & PDSM_DIMM_HEALTH_RUN_GAUGE_VALID) {
+		health->dimm_fuel_gauge = dimm->dimm_fuel_gauge;
+		health->extension_flags |= PDSM_DIMM_HEALTH_RUN_GAUGE_VALID;
+	}
+	if (dimm->extension_flags & PDSM_DIMM_HEALTH_MEDIA_TEMPERATURE_VALID) {
+		health->media_temperature = dimm->media_temperature;
+		health->extension_flags |= PDSM_DIMM_HEALTH_MEDIA_TEMPERATURE_VALID;
+	}
+	if (dimm->extension_flags & PDSM_DIMM_HEALTH_CTRL_TEMPERATURE_VALID) {
+		health->ctrl_temperature = dimm->ctrl_temperature;
+		health->extension_flags |= PDSM_DIMM_HEALTH_CTRL_TEMPERATURE_VALID;
+	}
+	if (dimm->extension_flags & PDSM_DIMM_HEALTH_SPARES_VALID) {
+		health->spares = dimm->spares;
+		health->extension_flags |= PDSM_DIMM_HEALTH_SPARES_VALID;
+	}
+	if (dimm->extension_flags & PDSM_DIMM_HEALTH_ALARM_VALID) {
+		health->alarm_flags = dimm->alarm_flags;
+		health->extension_flags |= PDSM_DIMM_HEALTH_ALARM_VALID;
+	}
+
+	return 0;
+}
+
+static void smart_notify(struct ndtest_dimm *dimm)
+{
+	struct device *bus = dimm->dev->parent;
+
+	if (((dimm->alarm_flags & ND_PAPR_HEALTH_SPARE_TRIP) &&
+	      dimm->spares <= dimm->spares_threshold) ||
+	    ((dimm->alarm_flags & ND_PAPR_HEALTH_TEMP_TRIP) &&
+	      dimm->media_temperature >= dimm->media_temperature_threshold) ||
+	    ((dimm->alarm_flags & ND_PAPR_HEALTH_CTEMP_TRIP) &&
+	     dimm->ctrl_temperature >= dimm->ctrl_temperature_threshold) ||
+	    !(dimm->flags & PAPR_PMEM_HEALTH_NON_CRITICAL) ||
+	    (dimm->flags & PAPR_PMEM_BAD_SHUTDOWN_MASK)) {
+		device_lock(bus);
+		/* send smart notification */
+		if (dimm->notify_handle)
+			sysfs_notify_dirent(dimm->notify_handle);
+		device_unlock(bus);
+	}
+}
+
+static int ndtest_pdsm_health_inject(struct ndtest_dimm *dimm,
+				union nd_pdsm_payload *payload,
+				unsigned int buf_len)
+{
+	struct nd_papr_pdsm_health_inject *inj = &payload->inject;
+
+	if (buf_len < sizeof(inj))
+		return -EINVAL;
+
+	if (inj->flags & ND_PAPR_HEALTH_INJECT_MTEMP) {
+		if (inj->mtemp_enable)
+			dimm->media_temperature = inj->media_temperature;
+		else
+			dimm->media_temperature = health_defaults.media_temperature;
+	}
+	if (inj->flags & ND_PAPR_HEALTH_INJECT_SPARE) {
+		if (inj->spares_enable)
+			dimm->spares = inj->spares;
+		else
+			dimm->spares = health_defaults.spares;
+	}
+	if (inj->flags & ND_PAPR_HEALTH_INJECT_FATAL) {
+		if (inj->fatal_enable)
+			dimm->flags |= PAPR_PMEM_HEALTH_FATAL;
+		else
+			dimm->flags &= ~PAPR_PMEM_HEALTH_FATAL;
+	}
+	if (inj->flags & ND_PAPR_HEALTH_INJECT_SHUTDOWN) {
+		if (inj->unsafe_shutdown_enable)
+			dimm->flags |= PAPR_PMEM_SHUTDOWN_DIRTY;
+		else
+			dimm->flags &= ~PAPR_PMEM_SHUTDOWN_DIRTY;
+	}
+	smart_notify(dimm);
+	inj->status = 0;
+
+	return 0;
+}
+
+static int ndtest_pdsm_health_threshold(struct ndtest_dimm *dimm,
+			union nd_pdsm_payload *payload,
+			unsigned int buf_len)
+{
+	struct nd_papr_pdsm_health_threshold *threshold = &payload->threshold;
+
+	if (buf_len < sizeof(threshold))
+		return -EINVAL;
+
+	threshold->media_temperature = dimm->media_temperature_threshold;
+	threshold->ctrl_temperature = dimm->ctrl_temperature_threshold;
+	threshold->spares = dimm->spares_threshold;
+	threshold->alarm_control = dimm->alarm_flags;
+
+	return 0;
+}
+
+static int ndtest_pdsm_health_set_threshold(struct ndtest_dimm *dimm,
+			union nd_pdsm_payload *payload,
+			unsigned int buf_len)
+{
+	struct nd_papr_pdsm_health_threshold *threshold = &payload->threshold;
+
+	if (buf_len < sizeof(threshold))
+		return -EINVAL;
+
+	dimm->media_temperature_threshold = threshold->media_temperature;
+	dimm->ctrl_temperature_threshold = threshold->ctrl_temperature;
+	dimm->spares_threshold = threshold->spares;
+	dimm->alarm_flags = threshold->alarm_control;
+
+	smart_notify(dimm);
+
+	return 0;
+}
+
+static int ndtest_dimm_cmd_call(struct ndtest_dimm *dimm, unsigned int buf_len,
+			   void *buf)
+{
+	struct nd_cmd_pkg *call_pkg = buf;
+	unsigned int len = call_pkg->nd_size_in + call_pkg->nd_size_out;
+	struct nd_pkg_pdsm *pdsm = (struct nd_pkg_pdsm *) call_pkg->nd_payload;
+	union nd_pdsm_payload *payload = &(pdsm->payload);
+	unsigned int func = call_pkg->nd_command;
+
+	switch (func) {
+	case PAPR_PDSM_HEALTH:
+		return ndtest_pdsm_health(dimm, payload, len);
+	case PAPR_PDSM_HEALTH_INJECT:
+		return ndtest_pdsm_health_inject(dimm, payload, len);
+	case PAPR_PDSM_HEALTH_THRESHOLD:
+		return ndtest_pdsm_health_threshold(dimm, payload, len);
+	case PAPR_PDSM_HEALTH_THRESHOLD_SET:
+		return ndtest_pdsm_health_set_threshold(dimm, payload, len);
+	}
+
+	return 0;
+}
+
 static int ndtest_ctl(struct nvdimm_bus_descriptor *nd_desc,
 		      struct nvdimm *nvdimm, unsigned int cmd, void *buf,
 		      unsigned int buf_len, int *cmd_rc)
@@ -325,6 +548,9 @@ static int ndtest_ctl(struct nvdimm_bus_descriptor *nd_desc,
 	case ND_CMD_SET_CONFIG_DATA:
 		*cmd_rc = ndtest_config_set(dimm, buf_len, buf);
 		break;
+	case ND_CMD_CALL:
+		*cmd_rc = ndtest_dimm_cmd_call(dimm, buf_len, buf);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -826,6 +1052,20 @@ static ssize_t flags_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(flags);
 
+#define PAPR_PMEM_DIMM_CMD_MASK				\
+	 ((1U << PAPR_PDSM_HEALTH)			\
+	 | (1U << PAPR_PDSM_HEALTH_INJECT)		\
+	 | (1U << PAPR_PDSM_HEALTH_THRESHOLD)		\
+	 | (1U << PAPR_PDSM_HEALTH_THRESHOLD_SET))
+
+
+static ssize_t dsm_mask_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%#x\n", PAPR_PMEM_DIMM_CMD_MASK);
+}
+static DEVICE_ATTR_RO(dsm_mask);
+
 static struct attribute *ndtest_nvdimm_attributes[] = {
 	&dev_attr_nvdimm_show_handle.attr,
 	&dev_attr_vendor.attr,
@@ -837,6 +1077,7 @@ static struct attribute *ndtest_nvdimm_attributes[] = {
 	&dev_attr_format.attr,
 	&dev_attr_format1.attr,
 	&dev_attr_flags.attr,
+	&dev_attr_dsm_mask.attr,
 	NULL,
 };
 
@@ -856,6 +1097,7 @@ static int ndtest_dimm_register(struct ndtest_priv *priv,
 {
 	struct device *dev = &priv->pdev.dev;
 	unsigned long dimm_flags = dimm->flags;
+	struct kernfs_node *papr_kernfs;
 
 	if (dimm->num_formats > 1) {
 		set_bit(NDD_ALIASING, &dimm_flags);
@@ -882,6 +1124,20 @@ static int ndtest_dimm_register(struct ndtest_priv *priv,
 		return -ENOMEM;
 	}
 
+	nd_synchronize();
+
+	papr_kernfs = sysfs_get_dirent(nvdimm_kobj(dimm->nvdimm)->sd, "papr");
+	if (!papr_kernfs) {
+		pr_err("Could not initialize the notifier handle\n");
+		return 0;
+	}
+
+	dimm->notify_handle = sysfs_get_dirent(papr_kernfs, "flags");
+	sysfs_put(papr_kernfs);
+	if (!dimm->notify_handle) {
+		pr_err("Could not initialize the notifier handle\n");
+		return 0;
+	}
 	return 0;
 }
 
@@ -953,6 +1209,8 @@ static int ndtest_bus_register(struct ndtest_priv *p)
 	p->bus_desc.provider_name = NULL;
 	p->bus_desc.attr_groups = ndtest_attribute_groups;
 
+	set_bit(NVDIMM_FAMILY_PAPR, &p->bus_desc.dimm_family_mask);
+
 	p->bus = nvdimm_bus_register(&p->pdev.dev, &p->bus_desc);
 	if (!p->bus) {
 		dev_err(&p->pdev.dev, "Error creating nvdimm bus %pOF\n", p->dn);
diff --git a/tools/testing/nvdimm/test/ndtest.h b/tools/testing/nvdimm/test/ndtest.h
index 2c54c9cbb90c..d29638b6a332 100644
--- a/tools/testing/nvdimm/test/ndtest.h
+++ b/tools/testing/nvdimm/test/ndtest.h
@@ -16,6 +16,8 @@
 #define PAPR_PMEM_HEALTH_FATAL              (1ULL << (63 - 5))
 /* SCM contents cannot persist due to current platform health status */
 #define PAPR_PMEM_HEALTH_UNHEALTHY          (1ULL << (63 - 6))
+/* SCM device is unable to persist memory contents in certain conditions */
+#define PAPR_PMEM_HEALTH_NON_CRITICAL       (1ULL << (63 - 7))
 
 /* Bits status indicators for health bitmap indicating unarmed dimm */
 #define PAPR_PMEM_UNARMED_MASK (PAPR_PMEM_UNARMED |		\
@@ -38,6 +40,49 @@
 
 struct ndtest_config;
 
+/* DIMM Health extension flag bits */
+#define PDSM_DIMM_HEALTH_RUN_GAUGE_VALID                (1 << 0)
+#define PDSM_DIMM_HEALTH_MEDIA_TEMPERATURE_VALID        (1 << 1)
+#define PDSM_DIMM_HEALTH_CTRL_TEMPERATURE_VALID         (1 << 2)
+#define PDSM_DIMM_HEALTH_SHUTDOWN_COUNT_VALID		(1 << 3)
+#define PDSM_DIMM_HEALTH_SPARES_VALID                   (1 << 4)
+#define PDSM_DIMM_HEALTH_ALARM_VALID                    (1 << 5)
+
+#define PAPR_PDSM_DIMM_HEALTHY           0
+
+#define ND_PAPR_HEALTH_SPARE_TRIP       (1 << 0)
+#define ND_PAPR_HEALTH_TEMP_TRIP        (1 << 1)
+#define ND_PAPR_HEALTH_CTEMP_TRIP       (1 << 2)
+
+/* DIMM Health inject flag bits */
+#define ND_PAPR_HEALTH_INJECT_MTEMP     (1 << 0)
+#define ND_PAPR_HEALTH_INJECT_SPARE     (1 << 1)
+#define ND_PAPR_HEALTH_INJECT_FATAL     (1 << 2)
+#define ND_PAPR_HEALTH_INJECT_SHUTDOWN  (1 << 3)
+
+/* Various nvdimm health indicators */
+#define PAPR_PDSM_DIMM_HEALTHY           0
+#define PAPR_PDSM_DIMM_UNHEALTHY         1
+#define PAPR_PDSM_DIMM_CRITICAL          2
+#define PAPR_PDSM_DIMM_FATAL             3
+
+enum papr_pdsm {
+	PAPR_PDSM_MIN = 0x0,
+	PAPR_PDSM_HEALTH,
+	PAPR_PDSM_INJECT_SET = 11,
+	PAPR_PDSM_INJECT_CLEAR = 12,
+	PAPR_PDSM_INJECT_GET = 13,
+	PAPR_PDSM_HEALTH_INJECT = 14,
+	PAPR_PDSM_HEALTH_THRESHOLD = 15,
+	PAPR_PDSM_HEALTH_THRESHOLD_SET = 16,
+	PAPR_PDSM_MAX,
+};
+
+enum dimm_type {
+	NDTEST_REGION_TYPE_PMEM = 0x0,
+	NDTEST_REGION_TYPE_BLK = 0x1,
+};
+
 struct ndtest_priv {
 	struct platform_device pdev;
 	struct device_node *dn;
@@ -80,6 +125,21 @@ struct ndtest_dimm {
 	int id;
 	int fail_cmd_code;
 	u8 no_alias;
+
+	struct kernfs_node *notify_handle;
+
+	/* SMART Health information */
+	unsigned long long extension_flags;
+	__u16 dimm_fuel_gauge;
+	__u16 media_temperature;
+	__u16 ctrl_temperature;
+	__u8 spares;
+	__u8 alarm_flags;
+
+	/* SMART Health thresholds */
+	__u16 media_temperature_threshold;
+	__u16 ctrl_temperature_threshold;
+	__u8 spares_threshold;
 };
 
 struct ndtest_mapping {
@@ -106,4 +166,73 @@ struct ndtest_config {
 	u8 num_regions;
 };
 
+#define ND_PDSM_PAYLOAD_MAX_SIZE 184
+
+struct nd_papr_pdsm_health {
+	union {
+		struct {
+			__u32 extension_flags;
+			__u8 dimm_unarmed;
+			__u8 dimm_bad_shutdown;
+			__u8 dimm_bad_restore;
+			__u8 dimm_scrubbed;
+			__u8 dimm_locked;
+			__u8 dimm_encrypted;
+			__u16 dimm_health;
+
+			/* Extension flag PDSM_DIMM_HEALTH_RUN_GAUGE_VALID */
+			__u16 dimm_fuel_gauge;
+			__u16 media_temperature;
+			__u16 ctrl_temperature;
+			__u8 spares;
+			__u16 alarm_flags;
+		};
+		__u8 buf[ND_PDSM_PAYLOAD_MAX_SIZE];
+	};
+};
+
+struct nd_papr_pdsm_health_threshold {
+	union {
+		struct {
+			__u16 alarm_control;
+			__u8 spares;
+			__u16 media_temperature;
+			__u16 ctrl_temperature;
+			__u32 status;
+		};
+		__u8 buf[ND_PDSM_PAYLOAD_MAX_SIZE];
+	};
+};
+
+struct nd_papr_pdsm_health_inject {
+	union {
+		struct {
+			__u64 flags;
+			__u8 mtemp_enable;
+			__u16 media_temperature;
+			__u8 ctemp_enable;
+			__u16 ctrl_temperature;
+			__u8 spares_enable;
+			__u8 spares;
+			__u8 fatal_enable;
+			__u8 unsafe_shutdown_enable;
+			__u32 status;
+		};
+		__u8 buf[ND_PDSM_PAYLOAD_MAX_SIZE];
+	};
+};
+
+union nd_pdsm_payload {
+	struct nd_papr_pdsm_health health;
+	struct nd_papr_pdsm_health_inject inject;
+	struct nd_papr_pdsm_health_threshold threshold;
+	__u8 buf[ND_PDSM_PAYLOAD_MAX_SIZE];
+} __packed;
+
+struct nd_pkg_pdsm {
+	__s32 cmd_status;       /* Out: Sub-cmd status returned back */
+	__u16 reserved[2];      /* Ignored and to be set as '0' */
+	union nd_pdsm_payload payload;
+} __packed;
+
 #endif /* NDTEST_H */
-- 
2.31.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

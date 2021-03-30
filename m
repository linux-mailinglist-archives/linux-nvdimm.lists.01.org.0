Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA7634EBDB
	for <lists+linux-nvdimm@lfdr.de>; Tue, 30 Mar 2021 17:14:22 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2B4DB100EC1DA;
	Tue, 30 Mar 2021 08:14:20 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A70F7100ED4BF
	for <linux-nvdimm@lists.01.org>; Tue, 30 Mar 2021 08:14:17 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12UF54EE030096;
	Tue, 30 Mar 2021 11:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : from : to : cc
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=HqyKQrPzmS8M0EwVwByDHHKOUOR6ojW2ZJdqxlTbfwg=;
 b=Jw+gboYlDLOHZxjjBabbbQubWI7jxbc/mU7nLP/6p45C16QtC73NPs5eVzQI+jCBFcUZ
 zaxjW4gXh8TWjaWmWrr5OnpSKPUV6p5Yu87J/L8frfdXV2YfnGkvuniXkEEfXAGr5Qff
 RmgIMGemKY9JrA4bXPWtBpZE4bQaQNNB/hFBPXJhG4DNuPA56mUKFFiVwm+dtQry5CbO
 D8gSc/mZO+cyeqiWDkBaKyjU9vvV9d6kvauJnBs5zCFqqvky3lwZKCjiydTc37BqVMTF
 xLWClhqFRMkXPf3QVIvp+H0Eh9JAhyzvWvSQ4qF31gTsFPrz5weNPEH7xBycA491RoxU yA==
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
	by mx0a-001b2d01.pphosted.com with ESMTP id 37jhm5wvhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Mar 2021 11:14:13 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
	by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12UFCQrn021345;
	Tue, 30 Mar 2021 15:14:11 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
	by ppma06ams.nl.ibm.com with ESMTP id 37huyhatyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Mar 2021 15:14:11 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12UFDn7H14221616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Mar 2021 15:13:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79977A4051;
	Tue, 30 Mar 2021 15:14:08 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 333A5A404D;
	Tue, 30 Mar 2021 15:14:07 +0000 (GMT)
Received: from [172.17.0.3] (unknown [9.40.192.207])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue, 30 Mar 2021 15:14:07 +0000 (GMT)
Subject: [PATCH] tools/testing/nvdimm: ndtest: Enable smart tests
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: linux-nvdimm@lists.01.org, vishal.l.verma@intel.com,
        aneesh.kumar@linux.ibm.com, vaibhav@linux.ibm.com,
        harish@linux.ibm.com, dan.j.williams@intel.com, santosh@fossix.org
Date: Tue, 30 Mar 2021 11:14:06 -0400
Message-ID: <161711723989.556.4220555988871072543.stgit@9add658da52e>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: y9jY7Xm9gSo8VlAkLl398zstZez4HvwB
X-Proofpoint-ORIG-GUID: y9jY7Xm9gSo8VlAkLl398zstZez4HvwB
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-30_05:2021-03-30,2021-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103300110
Message-ID-Hash: 5LE67NOK27GZFD63G5SG45LZQ635KOFW
X-Message-ID-Hash: 5LE67NOK27GZFD63G5SG45LZQ635KOFW
X-MailFrom: sbhat@linux.ibm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: sbhat@linux.vnet.ibm.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5LE67NOK27GZFD63G5SG45LZQ635KOFW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The patch adds all the necessary smart related dsm command
implementations. These dsm commands help the ndctl inject-smart
and monitor tests to pass.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
---
 tools/testing/nvdimm/test/ndtest.c |  257 ++++++++++++++++++++++++++++++++++++
 tools/testing/nvdimm/test/ndtest.h |  124 +++++++++++++++++
 2 files changed, 381 insertions(+)

diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/test/ndtest.c
index 6862915f1fb0..14832b07aa6a 100644
--- a/tools/testing/nvdimm/test/ndtest.c
+++ b/tools/testing/nvdimm/test/ndtest.c
@@ -30,6 +30,8 @@ enum {
 	((1ul << ND_CMD_GET_CONFIG_SIZE) | \
 	 (1ul << ND_CMD_GET_CONFIG_DATA) | \
 	 (1ul << ND_CMD_SET_CONFIG_DATA) | \
+	 (1ul << ND_CMD_SMART_THRESHOLD) | \
+	 (1ul << ND_CMD_SMART)           | \
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
@@ -826,6 +1052,19 @@ static ssize_t flags_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(flags);
 
+#define PAPR_PMEM_DIMM_CMD_MASK				\
+	 ((1U << PAPR_PDSM_HEALTH)			\
+	 | (1U << PAPR_PDSM_HEALTH_INJECT)		\
+	 | (1U << PAPR_PDSM_HEALTH_THRESHOLD)		\
+	 | (1U << PAPR_PDSM_HEALTH_THRESHOLD_SET))
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
@@ -837,6 +1076,7 @@ static struct attribute *ndtest_nvdimm_attributes[] = {
 	&dev_attr_format.attr,
 	&dev_attr_format1.attr,
 	&dev_attr_flags.attr,
+	&dev_attr_dsm_mask.attr,
 	NULL,
 };
 
@@ -856,6 +1096,7 @@ static int ndtest_dimm_register(struct ndtest_priv *priv,
 {
 	struct device *dev = &priv->pdev.dev;
 	unsigned long dimm_flags = dimm->flags;
+	struct kernfs_node *papr_kernfs;
 
 	if (dimm->num_formats > 1) {
 		set_bit(NDD_ALIASING, &dimm_flags);
@@ -882,6 +1123,20 @@ static int ndtest_dimm_register(struct ndtest_priv *priv,
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
 
@@ -953,6 +1208,8 @@ static int ndtest_bus_register(struct ndtest_priv *p)
 	p->bus_desc.provider_name = NULL;
 	p->bus_desc.attr_groups = ndtest_attribute_groups;
 
+	set_bit(NVDIMM_FAMILY_PAPR, &p->bus_desc.dimm_family_mask);
+
 	p->bus = nvdimm_bus_register(&p->pdev.dev, &p->bus_desc);
 	if (!p->bus) {
 		dev_err(&p->pdev.dev, "Error creating nvdimm bus %pOF\n", p->dn);
diff --git a/tools/testing/nvdimm/test/ndtest.h b/tools/testing/nvdimm/test/ndtest.h
index 2c54c9cbb90c..d2fc2f59db35 100644
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
@@ -38,6 +40,44 @@
 
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
 struct ndtest_priv {
 	struct platform_device pdev;
 	struct device_node *dn;
@@ -80,6 +120,21 @@ struct ndtest_dimm {
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
@@ -106,4 +161,73 @@ struct ndtest_config {
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

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

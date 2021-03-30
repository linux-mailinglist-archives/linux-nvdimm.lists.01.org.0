Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFA234EBF2
	for <lists+linux-nvdimm@lfdr.de>; Tue, 30 Mar 2021 17:17:55 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9BF95100EB833;
	Tue, 30 Mar 2021 08:17:52 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3868F100EC1DA
	for <linux-nvdimm@lists.01.org>; Tue, 30 Mar 2021 08:17:50 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12UFGRL8160532;
	Tue, 30 Mar 2021 11:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : from : to : cc
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=e3PMvTiyDJo8bE4rXNORxIu7Q0G15EoJRBx0ZDiBIBc=;
 b=U9qamQP9CkSpxocsHLX8Hol30IWD0zzoOQp841ntj+VZ9TdXVttSliadXmCCBWjU40cH
 jr1+Ozlds5NWPJGU62TArwNHFDSqrmd2lDIZPNcLCVjzhGxnRofTr5T9xh+AMnLuRQPO
 kx4uLmpEKxslKyU2lDEYgMZivKs9PNRj7rSTYnV8YbleiGrmAhteMNKngq6D/GuvHa/Z
 kk/Su4cFRovno/Kc487LiWMZc6IBLOIt1OCz71YVWukb44gHEzAhm+BFxwug52pKkTpw
 zPazGHVTnF2rysK0qe0VA6xd9pukVhd2MrZzwvoqdvZ72vO7aVk1v7T25Un+V8pv8vmV TQ==
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
	by mx0b-001b2d01.pphosted.com with ESMTP id 37jjb65nej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Mar 2021 11:17:46 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
	by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12UFCaae021381;
	Tue, 30 Mar 2021 15:17:44 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by ppma06ams.nl.ibm.com with ESMTP id 37huyhau2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Mar 2021 15:17:44 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12UFHgWj51249592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Mar 2021 15:17:42 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE77142041;
	Tue, 30 Mar 2021 15:17:41 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C87EE4203F;
	Tue, 30 Mar 2021 15:17:40 +0000 (GMT)
Received: from [172.17.0.3] (unknown [9.40.192.207])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue, 30 Mar 2021 15:17:40 +0000 (GMT)
Subject: [ndctl PATCH] papr: ndtest: Enable smart test cases
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: linux-nvdimm@lists.01.org, vishal.l.verma@intel.com, harish@linux.ibm.com,
        santosh@fossix.org, dan.j.williams@intel.com, vaibhav@linux.ibm.com
Date: Tue, 30 Mar 2021 11:17:39 -0400
Message-ID: <161711738576.593.320964839920955692.stgit@9add658da52e>
User-Agent: StGit/0.21
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aMADFSvw3ilnn3atI5X-oXZd7YzSjclp
X-Proofpoint-ORIG-GUID: aMADFSvw3ilnn3atI5X-oXZd7YzSjclp
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-30_05:2021-03-30,2021-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=886 bulkscore=0
 mlxscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103300110
Message-ID-Hash: ZPJYP23CUIFIDQUCOTEYQN2BFAJMEIUT
X-Message-ID-Hash: ZPJYP23CUIFIDQUCOTEYQN2BFAJMEIUT
X-MailFrom: sbhat@linux.ibm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: sbhat@linux.vnet.ibm.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZPJYP23CUIFIDQUCOTEYQN2BFAJMEIUT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The patch implements all necessary smart APIs for the
ndtest kernel driver.

Both inject-smart.sh and monitor.sh tests pass with the patch.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
---
The patche depends on the ndctl patchset
https://lore.kernel.org/linux-nvdimm/87eeg010sf.fsf@santosiv.in.ibm.com/T/

The ndtest driver support for this is posted at
https://lore.kernel.org/linux-nvdimm/161711723989.556.4220555988871072543.stgit@9add658da52e/T/#u

 ndctl/lib/papr.c      |  313 +++++++++++++++++++++++++++++++++++++++++++++++++
 ndctl/lib/papr.h      |    9 +
 ndctl/lib/papr_pdsm.h |   50 ++++++++
 3 files changed, 371 insertions(+), 1 deletion(-)

diff --git a/ndctl/lib/papr.c b/ndctl/lib/papr.c
index 9c6f2f0..34bad66 100644
--- a/ndctl/lib/papr.c
+++ b/ndctl/lib/papr.c
@@ -165,6 +165,18 @@ static unsigned int papr_smart_get_flags(struct ndctl_cmd *cmd)
 		if (health.extension_flags & PDSM_DIMM_HEALTH_RUN_GAUGE_VALID)
 			flags |= ND_SMART_USED_VALID;
 
+		if (health.extension_flags & PDSM_DIMM_HEALTH_MEDIA_TEMPERATURE_VALID)
+			flags |= ND_SMART_MTEMP_VALID;
+
+		if (health.extension_flags & PDSM_DIMM_HEALTH_CTRL_TEMPERATURE_VALID)
+			flags |= ND_SMART_CTEMP_VALID;
+
+		if (health.extension_flags & PDSM_DIMM_HEALTH_SPARES_VALID)
+			flags |= ND_SMART_SPARES_VALID;
+
+		if (health.extension_flags & PDSM_DIMM_HEALTH_ALARM_VALID)
+			flags |= ND_SMART_ALARM_VALID;
+
 		return flags;
 	}
 
@@ -201,6 +213,26 @@ static unsigned int papr_smart_get_health(struct ndctl_cmd *cmd)
 	return  !health.dimm_health ? 0 : 1 << (health.dimm_health - 1);
 }
 
+static int papr_pdsm_health_set_threshold_valid(struct ndctl_cmd *cmd)
+{
+	if (!cmd_is_valid(cmd) ||
+	    to_pdsm(cmd)->cmd_status != 0 ||
+	    to_pdsm_cmd(cmd) != PAPR_PDSM_HEALTH_THRESHOLD_SET) {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static unsigned int papr_cmd_smart_threshold_get_supported_alarms(struct ndctl_cmd *cmd)
+{
+	if (papr_pdsm_health_set_threshold_valid(cmd) < 0)
+		return 0;
+
+	return ND_SMART_SPARE_TRIP | ND_SMART_MTEMP_TRIP
+		| ND_SMART_CTEMP_TRIP;
+}
+
 static unsigned int papr_smart_get_shutdown_state(struct ndctl_cmd *cmd)
 {
 	struct nd_papr_pdsm_health health;
@@ -218,6 +250,126 @@ static unsigned int papr_smart_get_shutdown_state(struct ndctl_cmd *cmd)
 	return health.dimm_bad_shutdown;
 }
 
+static int papr_smart_inject_supported(struct ndctl_dimm *dimm)
+{
+	struct ndctl_ctx *ctx = ndctl_dimm_get_ctx(dimm);
+
+	if (!ndctl_dimm_is_cmd_supported(dimm, ND_CMD_CALL)) {
+		dbg(ctx, "unsupported cmd: %d\n", ND_CMD_CALL);
+		return -EOPNOTSUPP;
+	}
+
+	if (!test_dimm_dsm(dimm, PAPR_PDSM_HEALTH_INJECT)) {
+		dbg(ctx, "smart injection functions unsupported\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int papr_smart_inject_valid(struct ndctl_cmd *cmd)
+{
+	if (cmd->type != ND_CMD_CALL ||
+			to_pdsm(cmd)->cmd_status != 0 ||
+			to_pdsm_cmd(cmd) != PAPR_PDSM_HEALTH_INJECT)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int papr_cmd_smart_inject_media_temperature(struct ndctl_cmd *cmd,
+		bool enable, unsigned int mtemp)
+{
+	if (papr_smart_inject_valid(cmd) < 0)
+		return -EINVAL;
+
+	to_payload(cmd)->inject.flags |= ND_PAPR_SMART_INJECT_MTEMP;
+	to_payload(cmd)->inject.mtemp_enable = enable == true;
+	to_payload(cmd)->inject.media_temperature = mtemp;
+
+	return 0;
+}
+
+static int papr_cmd_smart_inject_ctrl_temperature(struct ndctl_cmd *cmd,
+		bool enable, unsigned int mtemp)
+{
+	if (papr_smart_inject_valid(cmd) < 0)
+		return -EINVAL;
+
+	to_payload(cmd)->inject.flags |= ND_PAPR_SMART_INJECT_MTEMP;
+	to_payload(cmd)->inject.ctemp_enable = enable == true;
+	to_payload(cmd)->inject.ctrl_temperature = mtemp;
+
+	return 0;
+}
+
+static int papr_cmd_smart_inject_spares(struct ndctl_cmd *cmd,
+		bool enable, unsigned int spares)
+{
+	if (papr_smart_inject_valid(cmd) < 0)
+		return -EINVAL;
+
+	to_payload(cmd)->inject.flags |= ND_PAPR_SMART_INJECT_SPARES;
+	to_payload(cmd)->inject.spares_enable = enable == true;
+	to_payload(cmd)->inject.spares = spares;
+
+	return 0;
+}
+
+static struct ndctl_cmd *papr_new_smart_inject(struct ndctl_dimm *dimm)
+{
+	struct ndctl_cmd *cmd;
+
+	cmd = allocate_cmd(dimm, PAPR_PDSM_HEALTH_INJECT,
+			sizeof(struct nd_papr_pdsm_health_inject));
+	if (!cmd)
+		return NULL;
+
+	return cmd;
+}
+
+static struct ndctl_cmd *papr_dimm_cmd_new_smart_set_threshold(
+		struct ndctl_cmd *threshold_cmd)
+{
+	struct ndctl_cmd *set_cmd;
+	struct nd_papr_pdsm_health_threshold thresh;
+
+	if (!cmd_is_valid(threshold_cmd) ||
+	    to_pdsm(threshold_cmd)->cmd_status != 0 ||
+	    to_pdsm_cmd(threshold_cmd) != PAPR_PDSM_HEALTH_THRESHOLD) {
+		return NULL;
+	}
+
+	thresh = to_payload(threshold_cmd)->threshold;
+
+	set_cmd = allocate_cmd(threshold_cmd->dimm, PAPR_PDSM_HEALTH_THRESHOLD_SET,
+			sizeof(struct nd_papr_pdsm_health_threshold));
+	if (!set_cmd)
+		return NULL;
+
+	set_cmd->source = threshold_cmd;
+	ndctl_cmd_ref(threshold_cmd);
+
+	to_payload(set_cmd)->threshold.alarm_control = thresh.alarm_control;
+	to_payload(set_cmd)->threshold.spares = thresh.spares;
+	to_payload(set_cmd)->threshold.media_temperature = thresh.media_temperature;
+	to_payload(set_cmd)->threshold.ctrl_temperature = thresh.ctrl_temperature;
+
+	return set_cmd;
+}
+
+static struct ndctl_cmd *papr_cmd_new_smart_threshold(struct ndctl_dimm *dimm)
+{
+	struct ndctl_cmd *cmd;
+
+	cmd = allocate_cmd(dimm, PAPR_PDSM_HEALTH_THRESHOLD,
+			sizeof(struct nd_papr_pdsm_health_threshold));
+	if (!cmd)
+		return NULL;
+
+	return cmd;
+}
+
 static unsigned int papr_smart_get_life_used(struct ndctl_cmd *cmd)
 {
 	struct nd_papr_pdsm_health health;
@@ -236,13 +388,174 @@ static unsigned int papr_smart_get_life_used(struct ndctl_cmd *cmd)
 		(100 - health.dimm_fuel_gauge) : 0;
 }
 
+static int papr_cmd_smart_inject_fatal(struct ndctl_cmd *cmd, bool enable)
+{
+	if (papr_smart_inject_valid(cmd) < 0)
+		return -EINVAL;
+
+	to_payload(cmd)->inject.flags |= ND_PAPR_SMART_INJECT_FATAL;
+	to_payload(cmd)->inject.fatal_enable = enable == true;
+
+	return 0;
+}
+
+static int papr_cmd_smart_inject_unsafe_shutdown(struct ndctl_cmd *cmd,
+							bool enable)
+{
+	if (papr_smart_inject_valid(cmd) < 0)
+		return -EINVAL;
+
+	to_payload(cmd)->inject.flags |= ND_PAPR_SMART_INJECT_SHUTDOWN;
+	to_payload(cmd)->inject.unsafe_shutdown_enable = enable == true;
+
+	return 0;
+}
+
+static unsigned int papr_cmd_smart_threshold_get_alarm_control(struct ndctl_cmd *cmd)
+{
+	int rc = 0;
+	unsigned int flags = 0;
+	struct nd_pkg_pdsm *pcmd = to_pdsm(cmd);
+	struct nd_papr_pdsm_health_threshold threshold;
+
+	if (!cmd_is_valid(cmd) ||
+	    to_pdsm(cmd)->cmd_status != 0 ||
+	    to_pdsm_cmd(cmd) != PAPR_PDSM_HEALTH_THRESHOLD) {
+		rc = -EINVAL;
+	}
+
+	if (rc < 0) {
+		errno = -rc;
+		return UINT_MAX;
+	}
+
+	threshold = pcmd->payload.threshold;
+	if (threshold.alarm_control & ND_PAPR_HEALTH_SPARE_TRIP)
+		flags |= ND_SMART_SPARE_TRIP;
+	if (threshold.alarm_control & ND_PAPR_HEALTH_TEMP_TRIP)
+		flags |= ND_SMART_TEMP_TRIP;
+	if (threshold.alarm_control & ND_PAPR_HEALTH_CTEMP_TRIP)
+		flags |= ND_SMART_CTEMP_TRIP;
+
+	return flags;
+}
+
+static int papr_smart_threshold_valid(struct ndctl_cmd *cmd)
+{
+	int rc = 0;
+
+	if (!cmd_is_valid(cmd) ||
+		to_pdsm(cmd)->cmd_status != 0 ||
+		to_pdsm_cmd(cmd) != PAPR_PDSM_HEALTH_THRESHOLD) {
+		rc = -EINVAL;
+	}
+
+	return rc;
+}
+
+#define papr_smart_threshold_get_field(cmd, field) \
+static unsigned int papr_cmd_smart_threshold_get_##field( \
+		struct ndctl_cmd *cmd) \
+{ \
+	int rc; \
+	struct nd_pkg_pdsm *pcmd = to_pdsm(cmd); \
+	rc = papr_smart_threshold_valid(cmd); \
+	if (rc < 0) { \
+		errno = -rc; \
+		return UINT_MAX; \
+	} \
+	return pcmd->payload.threshold.field; \
+}
+
+papr_smart_threshold_get_field(cmd, media_temperature)
+papr_smart_threshold_get_field(cmd, ctrl_temperature)
+papr_smart_threshold_get_field(cmd, spares)
+
+static int papr_smart_valid(struct ndctl_cmd *cmd)
+{
+	int rc = 0;
+
+	if (!cmd_is_valid(cmd) ||
+		to_pdsm(cmd)->cmd_status != 0 ||
+		to_pdsm_cmd(cmd) != PAPR_PDSM_HEALTH) {
+		rc = -EINVAL;
+	}
+
+	return rc;
+}
+
+
+#define papr_smart_get_field(cmd, field) \
+static unsigned int papr_cmd_smart_get_##field(struct ndctl_cmd *cmd) \
+{ \
+	int rc; \
+	struct nd_pkg_pdsm *pcmd = to_pdsm(cmd); \
+	rc = papr_smart_valid(cmd); \
+	if (rc < 0) { \
+		errno = -rc; \
+		return UINT_MAX; \
+	} \
+	return pcmd->payload.health.field; \
+}
+
+papr_smart_get_field(cmd, ctrl_temperature)
+papr_smart_get_field(cmd, media_temperature)
+papr_smart_get_field(cmd, alarm_flags)
+papr_smart_get_field(cmd, spares)
+
+#define papr_cmd_smart_threshold_set_field(field) \
+static int papr_cmd_smart_threshold_set_##field( \
+				struct ndctl_cmd *cmd, unsigned int val) \
+{ \
+	struct nd_pkg_pdsm *pcmd = to_pdsm(cmd); \
+	if (papr_pdsm_health_set_threshold_valid(cmd) < 0) \
+		return -EINVAL; \
+	pcmd->payload.threshold.field = val; \
+	return 0; \
+}
+
+papr_cmd_smart_threshold_set_field(alarm_control)
+papr_cmd_smart_threshold_set_field(media_temperature)
+papr_cmd_smart_threshold_set_field(ctrl_temperature)
+papr_cmd_smart_threshold_set_field(spares)
+
+
 struct ndctl_dimm_ops * const papr_dimm_ops = &(struct ndctl_dimm_ops) {
 	.cmd_is_supported = papr_cmd_is_supported,
+	.new_smart_inject = papr_new_smart_inject,
 	.smart_get_flags = papr_smart_get_flags,
+	.smart_inject_supported = papr_smart_inject_supported,
+	.smart_inject_media_temperature = papr_cmd_smart_inject_media_temperature,
+	.smart_inject_ctrl_temperature = papr_cmd_smart_inject_ctrl_temperature,
+	.smart_inject_spares = papr_cmd_smart_inject_spares,
+	.smart_inject_fatal = papr_cmd_smart_inject_fatal,
+	.smart_inject_unsafe_shutdown = papr_cmd_smart_inject_unsafe_shutdown,
+	.smart_get_ctrl_temperature = papr_cmd_smart_get_ctrl_temperature,
+	.smart_get_media_temperature = papr_cmd_smart_get_media_temperature,
+	.smart_get_alarm_flags = papr_cmd_smart_get_alarm_flags,
+	.smart_get_spares = papr_cmd_smart_get_spares,
 	.get_firmware_status =  papr_get_firmware_status,
 	.xlat_firmware_status = papr_xlat_firmware_status,
 	.new_smart = papr_new_smart_health,
 	.smart_get_health = papr_smart_get_health,
 	.smart_get_shutdown_state = papr_smart_get_shutdown_state,
 	.smart_get_life_used = papr_smart_get_life_used,
+	.new_smart_threshold = papr_cmd_new_smart_threshold,
+	.smart_threshold_get_alarm_control
+		= papr_cmd_smart_threshold_get_alarm_control,
+	.smart_threshold_get_media_temperature
+		= papr_cmd_smart_threshold_get_media_temperature,
+	.smart_threshold_get_ctrl_temperature
+		= papr_cmd_smart_threshold_get_ctrl_temperature,
+	.smart_threshold_get_spares = papr_cmd_smart_threshold_get_spares,
+	.new_smart_set_threshold = papr_dimm_cmd_new_smart_set_threshold,
+	.smart_threshold_get_supported_alarms
+		= papr_cmd_smart_threshold_get_supported_alarms,
+	.smart_threshold_set_alarm_control
+		= papr_cmd_smart_threshold_set_alarm_control,
+	.smart_threshold_set_media_temperature
+		= papr_cmd_smart_threshold_set_media_temperature,
+	.smart_threshold_set_ctrl_temperature
+		= papr_cmd_smart_threshold_set_ctrl_temperature,
+	.smart_threshold_set_spares = papr_cmd_smart_threshold_set_spares,
 };
diff --git a/ndctl/lib/papr.h b/ndctl/lib/papr.h
index 7757939..58ba81c 100644
--- a/ndctl/lib/papr.h
+++ b/ndctl/lib/papr.h
@@ -12,4 +12,13 @@ struct nd_pkg_papr {
 	struct nd_pkg_pdsm pdsm;
 };
 
+#define ND_PAPR_SMART_INJECT_MTEMP             (1 << 0)
+#define ND_PAPR_SMART_INJECT_SPARES            (1 << 1)
+#define ND_PAPR_SMART_INJECT_FATAL             (1 << 2)
+#define ND_PAPR_SMART_INJECT_SHUTDOWN          (1 << 3)
+
+#define ND_PAPR_HEALTH_SPARE_TRIP               (1 << 0)
+#define ND_PAPR_HEALTH_TEMP_TRIP                (1 << 1)
+#define ND_PAPR_HEALTH_CTEMP_TRIP               (1 << 2)
+
 #endif /* __PAPR_H__ */
diff --git a/ndctl/lib/papr_pdsm.h b/ndctl/lib/papr_pdsm.h
index 1bac8a7..8cf3643 100644
--- a/ndctl/lib/papr_pdsm.h
+++ b/ndctl/lib/papr_pdsm.h
@@ -73,7 +73,12 @@
 #define PAPR_PDSM_DIMM_FATAL         3
 
 /* Indicate that the 'dimm_fuel_gauge' field is valid */
-#define PDSM_DIMM_HEALTH_RUN_GAUGE_VALID 1
+#define PDSM_DIMM_HEALTH_RUN_GAUGE_VALID		(1 << 0)
+#define PDSM_DIMM_HEALTH_MEDIA_TEMPERATURE_VALID	(1 << 1)
+#define PDSM_DIMM_HEALTH_CTRL_TEMPERATURE_VALID		(1 << 2)
+#define PDSM_DIMM_HEALTH_SHUTDOWN_COUNT_VALID		(1 << 3)
+#define PDSM_DIMM_HEALTH_SPARES_VALID			(1 << 4)
+#define PDSM_DIMM_HEALTH_ALARM_VALID			(1 << 5)
 
 /*
  * Struct exchanged between kernel & ndctl in for PAPR_PDSM_HEALTH
@@ -103,6 +108,10 @@ struct nd_papr_pdsm_health {
 
 			/* Extension flag PDSM_DIMM_HEALTH_RUN_GAUGE_VALID */
 			__u16 dimm_fuel_gauge;
+			__u16 media_temperature;
+			__u16 ctrl_temperature;
+			__u8 spares;
+			__u16 alarm_flags;
 		};
 		__u8 buf[ND_PDSM_PAYLOAD_MAX_SIZE];
 	};
@@ -115,12 +124,51 @@ struct nd_papr_pdsm_health {
 enum papr_pdsm {
 	PAPR_PDSM_MIN = 0x0,
 	PAPR_PDSM_HEALTH,
+	PAPR_PDSM_INJECT_SET = 11,
+	PAPR_PDSM_INJECT_CLEAR = 12,
+	PAPR_PDSM_INJECT_GET = 13,
+	PAPR_PDSM_HEALTH_INJECT = 14,
+	PAPR_PDSM_HEALTH_THRESHOLD = 15,
+	PAPR_PDSM_HEALTH_THRESHOLD_SET = 16,
 	PAPR_PDSM_MAX,
 };
 
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
 /* Maximal union that can hold all possible payload types */
 union nd_pdsm_payload {
 	struct nd_papr_pdsm_health health;
+	struct nd_papr_pdsm_health_inject inject;
+	struct nd_papr_pdsm_health_threshold threshold;
 	__u8 buf[ND_PDSM_PAYLOAD_MAX_SIZE];
 } __attribute__((packed));
 

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

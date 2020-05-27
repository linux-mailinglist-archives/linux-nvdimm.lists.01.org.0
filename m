Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A601E3784
	for <lists+linux-nvdimm@lfdr.de>; Wed, 27 May 2020 06:49:09 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 48A2E1225F26E;
	Tue, 26 May 2020 21:44:59 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 49B4E1225F260
	for <linux-nvdimm@lists.01.org>; Tue, 26 May 2020 21:44:57 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04R4XQTf177623;
	Wed, 27 May 2020 00:49:01 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 317hejdgfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2020 00:49:01 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04R4Xnwm178526;
	Wed, 27 May 2020 00:49:01 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 317hejdgff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2020 00:49:00 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04R4jA9p028879;
	Wed, 27 May 2020 04:48:59 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
	by ppma03ams.nl.ibm.com with ESMTP id 316uf8753h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2020 04:48:59 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04R4lgSK64946676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2020 04:47:42 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C81EA405C;
	Wed, 27 May 2020 04:48:56 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E593A405B;
	Wed, 27 May 2020 04:48:52 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.121.50])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Wed, 27 May 2020 04:48:51 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Wed, 27 May 2020 10:18:49 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH v4 6/6] libndctl,papr_scm: Implement support for PAPR_SCM_PDSM_HEALTH
Date: Wed, 27 May 2020 10:17:37 +0530
Message-Id: <20200527044737.40615-7-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527044737.40615-1-vaibhav@linux.ibm.com>
References: <20200527044737.40615-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_01:2020-05-26,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 cotscore=-2147483648 bulkscore=0 mlxscore=0
 suspectscore=1 mlxlogscore=999 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005270033
Message-ID-Hash: SNOSNV2ZUUBD7NQPW5IOGUCS4POBTJDK
X-Message-ID-Hash: SNOSNV2ZUUBD7NQPW5IOGUCS4POBTJDK
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SNOSNV2ZUUBD7NQPW5IOGUCS4POBTJDK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add support for reporting DIMM health and shutdown state by issuing
PAPR_SCM_PDSM_HEALTH request to papr_scm module. It returns an
instance of 'struct nd_papr_pdsm_health' as defined in
'papr_scm_pdsm.h'. The patch provides support for dimm-ops
'new_smart', 'smart_get_health' & 'smart_get_shutdown_state' as newly
introduced functions papr_new_smart_health(), papr_smart_get_health()
& papr_smart_get_shutdown_state() respectively. These callbacks should
enable ndctl to report DIMM health.

Also a new member 'struct dimm_priv.health' is introduced which holds
the current health status of the dimm. This member is set inside newly
added function 'update_dimm_health_v1()' which parses the v1 payload
returned by the kernel after servicing PAPR_SCM_PDSM_HEALTH. The
function will also update dimm-flags viz 'struct ndctl_dimm.flags.f_*'
based on the flags set in the returned payload.

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
Changelog:

v3..v4:
* None

v2..v3:
* None

v1..v2:
* Squashed patch to report nvdimm bad shutdown state with this patch.
* Switched to new structs/enums as defined in papr_scm_pdsm.h
---
 ndctl/lib/papr_scm.c | 90 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 87 insertions(+), 3 deletions(-)

diff --git a/ndctl/lib/papr_scm.c b/ndctl/lib/papr_scm.c
index 4a2c2115dee5..4d01e1329a14 100644
--- a/ndctl/lib/papr_scm.c
+++ b/ndctl/lib/papr_scm.c
@@ -42,7 +42,9 @@
 
 /* Per dimm data. Holds per-dimm data parsed from the cmd_pkgs */
 struct dimm_priv {
-	/* Empty for now */
+
+	/* Cache the dimm health status */
+	struct nd_papr_pdsm_health health;
 };
 
 static bool papr_cmd_is_supported(struct ndctl_dimm *dimm, int cmd)
@@ -97,6 +99,43 @@ static bool cmd_is_valid(struct ndctl_dimm *dimm, struct ndctl_cmd *cmd)
 	return true;
 }
 
+/*
+ * Parse the nd_papr_pdsm_health_v1 payload embedded in ndctl_cmd and
+ * update dimm health/flags
+ */
+static int update_dimm_health_v1(struct ndctl_dimm *dimm, struct ndctl_cmd *cmd)
+{
+	struct nd_pdsm_cmd_pkg *pcmd = nd_to_pdsm_cmd_pkg(cmd->pkg);
+	struct dimm_priv *p = dimm->dimm_user_data;
+	const struct nd_papr_pdsm_health_v1 *health =
+		pdsm_cmd_to_payload(pcmd);
+
+	/* Update the dimm flags */
+	dimm->flags.f_arm = health->dimm_unarmed;
+	dimm->flags.f_flush = health->dimm_bad_shutdown;
+	dimm->flags.f_restore = health->dimm_bad_restore;
+	dimm->flags.f_smart = (health->dimm_health != 0);
+
+	/* Cache the dimm health information */
+	memcpy(&p->health, health, sizeof(*health));
+	return 0;
+}
+
+/* Check payload version returned and pass the packet to appropriate handler */
+static int update_dimm_health(struct ndctl_dimm *dimm, struct ndctl_cmd *cmd)
+{
+	const struct nd_pdsm_cmd_pkg *pcmd = nd_to_pdsm_cmd_pkg(cmd->pkg);
+
+	if (pcmd->payload_version == 1)
+		return update_dimm_health_v1(dimm, cmd);
+
+	/* unknown version */
+	papr_err(dimm, "Unknown payload version for dimm_health.\n");
+	papr_dbg(dimm, "dimm_health payload Ver=%d, Supported=%d\n",
+		 pcmd->payload_version, ND_PAPR_PDSM_HEALTH_VERSION);
+	return -EINVAL;
+}
+
 /* Parse a command payload and update dimm flags/private data */
 static int update_dimm_stats(struct ndctl_dimm *dimm, struct ndctl_cmd *cmd)
 {
@@ -122,6 +161,8 @@ static int update_dimm_stats(struct ndctl_dimm *dimm, struct ndctl_cmd *cmd)
 	/* Get the pdsm request and handle it */
 	pcmd = nd_to_pdsm_cmd_pkg(cmd->pkg);
 	switch (pcmd_to_pdsm(pcmd)) {
+	case PAPR_SCM_PDSM_HEALTH:
+		return update_dimm_health(dimm, cmd);
 	default:
 		papr_err(dimm, "Unhandled pdsm-request 0x%016llx\n",
 			 pcmd_to_pdsm(pcmd));
@@ -166,14 +207,54 @@ static struct ndctl_cmd *allocate_cmd(struct ndctl_dimm *dimm,
 	return cmd;
 }
 
+static struct ndctl_cmd *papr_new_smart_health(struct ndctl_dimm *dimm)
+{
+	struct ndctl_cmd *cmd_ret;
+
+	cmd_ret = allocate_cmd(dimm, PAPR_SCM_PDSM_HEALTH,
+			       sizeof(struct nd_papr_pdsm_health),
+			       ND_PAPR_PDSM_HEALTH_VERSION);
+	if (!cmd_ret) {
+		papr_err(dimm, "Unable to allocate smart_health command\n");
+		return NULL;
+	}
+
+	cmd_ret->pkg[0].nd_size_out = ND_PDSM_ENVELOPE_CONTENT_SIZE(
+		struct nd_papr_pdsm_health);
+
+	return cmd_ret;
+}
+
+static unsigned int papr_smart_get_health(struct ndctl_cmd *cmd)
+{
+	struct dimm_priv *p = cmd->dimm->dimm_user_data;
+
+	/*
+	 * Update the dimm stats and use some math to return one of
+	 * defined ND_SMART_*_HEALTH values
+	 */
+	if (update_dimm_stats(cmd->dimm, cmd) || !p->health.dimm_health)
+		return 0;
+	else
+		return 1 << (p->health.dimm_health - 1);
+}
+
+static unsigned int papr_smart_get_shutdown_state(struct ndctl_cmd *cmd)
+{
+	struct dimm_priv *p = cmd->dimm->dimm_user_data;
+
+	/* Update dimm state and return f_flush */
+	return update_dimm_stats(cmd->dimm, cmd) ?
+		0 : p->health.dimm_bad_shutdown;
+}
+
 static unsigned int papr_smart_get_flags(struct ndctl_cmd *cmd)
 {
 	/* In case of error return empty flags * */
 	if (update_dimm_stats(cmd->dimm, cmd))
 		return 0;
 
-	/* Return empty flags for now as no DSM support */
-	return 0;
+	return ND_SMART_HEALTH_VALID | ND_SMART_SHUTDOWN_VALID;
 }
 
 static int papr_dimm_init(struct ndctl_dimm *dimm)
@@ -214,4 +295,7 @@ struct ndctl_dimm_ops * const papr_scm_dimm_ops = &(struct ndctl_dimm_ops) {
 	.dimm_uninit = papr_dimm_uninit,
 	.smart_get_flags = papr_smart_get_flags,
 	.get_firmware_status =  papr_get_firmware_status,
+	.new_smart = papr_new_smart_health,
+	.smart_get_health = papr_smart_get_health,
+	.smart_get_shutdown_state = papr_smart_get_shutdown_state,
 };
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

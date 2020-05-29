Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2501E8AF2
	for <lists+linux-nvdimm@lfdr.de>; Sat, 30 May 2020 00:06:58 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F0939100EAB5B;
	Fri, 29 May 2020 15:02:29 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6B7BD100F2260
	for <linux-nvdimm@lists.01.org>; Fri, 29 May 2020 15:02:27 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04TM2b0T079261;
	Fri, 29 May 2020 18:06:49 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 31as1e7e8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2020 18:06:48 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04TM5DPD087127;
	Fri, 29 May 2020 18:06:48 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
	by mx0b-001b2d01.pphosted.com with ESMTP id 31as1e7e7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2020 18:06:48 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
	by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04TM5oSn000635;
	Fri, 29 May 2020 22:06:46 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by ppma02fra.de.ibm.com with ESMTP id 316uf8w6nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2020 22:06:46 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04TM6hfb59244576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2020 22:06:43 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 789DB11C066;
	Fri, 29 May 2020 22:06:43 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D14011C04C;
	Fri, 29 May 2020 22:06:40 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.199.34.115])
	by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Fri, 29 May 2020 22:06:40 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Sat, 30 May 2020 03:36:39 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH v5 6/6] libndctl,papr_scm: Implement support for PAPR_PDSM_HEALTH
Date: Sat, 30 May 2020 03:36:00 +0530
Message-Id: <20200529220600.225320-7-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200529220600.225320-1-vaibhav@linux.ibm.com>
References: <20200529220600.225320-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-29_10:2020-05-28,2020-05-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 cotscore=-2147483648 phishscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=1 adultscore=0
 mlxscore=0 clxscore=1015 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005290155
Message-ID-Hash: VK2IKUFGH3OPGGEDQVNIXJ7S3RF3JW4E
X-Message-ID-Hash: VK2IKUFGH3OPGGEDQVNIXJ7S3RF3JW4E
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VK2IKUFGH3OPGGEDQVNIXJ7S3RF3JW4E/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add support for reporting DIMM health and shutdown state by issuing
PAPR_PDSM_HEALTH request to papr_scm module. It returns an
instance of 'struct nd_papr_pdsm_health' as defined in
'papr_pdsm.h'. The patch provides support for dimm-ops
'new_smart', 'smart_get_health' & 'smart_get_shutdown_state' as newly
introduced functions papr_new_smart_health(), papr_smart_get_health()
& papr_smart_get_shutdown_state() respectively. These callbacks should
enable ndctl to report DIMM health.

Also a new member 'struct dimm_priv.health' is introduced which holds
the current health status of the dimm. This member is set inside newly
added function 'update_dimm_health_v1()' which parses the v1 payload
returned by the kernel after servicing PAPR_PDSM_HEALTH. The
function will also update dimm-flags viz 'struct ndctl_dimm.flags.f_*'
based on the flags set in the returned payload.

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
Changelog:

v4..v5:
* Updated patch description to reflect updated names of struct and
  defines that have the term 'scm' removed.

v3..v4:
* None

v2..v3:
* None

v1..v2:
* Squashed patch to report nvdimm bad shutdown state with this patch.
* Switched to new structs/enums as defined in papr_scm_pdsm.h
---
 ndctl/lib/papr.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 87 insertions(+), 3 deletions(-)

diff --git a/ndctl/lib/papr.c b/ndctl/lib/papr.c
index 1b7870beb631..cb7ff9e0d5bd 100644
--- a/ndctl/lib/papr.c
+++ b/ndctl/lib/papr.c
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
+	case PAPR_PDSM_HEALTH:
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
+	cmd_ret = allocate_cmd(dimm, PAPR_PDSM_HEALTH,
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
@@ -214,4 +295,7 @@ struct ndctl_dimm_ops * const papr_dimm_ops = &(struct ndctl_dimm_ops) {
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

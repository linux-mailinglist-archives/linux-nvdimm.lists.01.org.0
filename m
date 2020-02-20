Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEA2165C29
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Feb 2020 11:52:36 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AB22910FC35BB;
	Thu, 20 Feb 2020 02:53:27 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CFD1610097E1D
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 02:51:07 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01KAiaL2118921
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 05:50:14 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2y8uchpspp-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 05:50:14 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <vaibhav@linux.ibm.com>;
	Thu, 20 Feb 2020 10:50:12 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
	by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 20 Feb 2020 10:50:10 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01KAo8Vb28180524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2020 10:50:08 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0AB1A4055;
	Thu, 20 Feb 2020 10:50:08 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F514A404D;
	Thu, 20 Feb 2020 10:50:06 +0000 (GMT)
Received: from vajain21.in.ibm.com.com (unknown [9.199.53.128])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu, 20 Feb 2020 10:50:05 +0000 (GMT)
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH 7/8] libndctl,papr_scm: Implement support for DSM_PAPR_SCM_HEALTH
Date: Thu, 20 Feb 2020 16:19:27 +0530
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220104928.198625-1-vaibhav@linux.ibm.com>
References: <20200220104928.198625-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20022010-4275-0000-0000-000003A3BF14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022010-4276-0000-0000-000038B7CB60
Message-Id: <20200220104928.198625-8-vaibhav@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_02:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 suspectscore=1 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200079
Message-ID-Hash: CW65DFPK43LJ7OJQZUC7WKSOP3UTPDSQ
X-Message-ID-Hash: CW65DFPK43LJ7OJQZUC7WKSOP3UTPDSQ
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Alastair D'Silva <alastair@au1.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CW65DFPK43LJ7OJQZUC7WKSOP3UTPDSQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add support for reporting DIMM health by issuing DSM_PAPR_SCM_HEALTH
DSM. It returns an instance of '
struct nd_papr_scm_dimm_health_stat' as defined in
'papr_scm_dsm.h'. The patch provides support for dimm-ops 'new_smart' &
'smart_get_health' as papr_new_smart_health() &
papr_smart_get_health() respectively. This callbacks should enable
ndctl to report DIMM health.

Also a new member 'struct dimm_priv.health' is introduced which holds
the current health status of the dimm. This member is set inside newly
added function 'update_dimm_health_v1()' which parses the v1 payload
returned by the kernel after servicing DSM_PAPR_SCM_HEALTH. The
function will also update dimm-flags viz 'struct ndctl_dimm.flags.f_*'
based on the flags set in the returned payload.

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 ndctl/lib/papr_scm.c | 80 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 3 deletions(-)

diff --git a/ndctl/lib/papr_scm.c b/ndctl/lib/papr_scm.c
index 0a3857e2a4c4..a01649d3a9fe 100644
--- a/ndctl/lib/papr_scm.c
+++ b/ndctl/lib/papr_scm.c
@@ -40,7 +40,9 @@
 
 /* Per dimm data. Holds per-dimm data parsed from the cmd_pkgs */
 struct dimm_priv {
-	/* Empty for now */
+
+	/* Cache the dimm health status */
+	struct nd_papr_scm_dimm_health_stat health;
 };
 
 static bool papr_cmd_is_supported(struct ndctl_dimm *dimm, int cmd)
@@ -88,6 +90,43 @@ static bool cmd_is_valid(struct ndctl_dimm *dimm, struct ndctl_cmd *cmd)
 	return true;
 }
 
+/*
+ * Parse the nd_papr_scm_dimm_health_stat_v1 payload embedded in ndctl_cmd and
+ * update dimm health/flags
+ */
+static int update_dimm_health_v1(struct ndctl_dimm *dimm, struct ndctl_cmd *cmd)
+{
+	struct nd_papr_scm_cmd_pkg *pcmd = nd_to_papr_cmd_pkg(cmd->pkg);
+	struct dimm_priv *p = dimm->dimm_user_data;
+	const struct nd_papr_scm_dimm_health_stat_v1 *health =
+		papr_scm_pcmd_to_payload(pcmd);
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
+	const struct nd_papr_scm_cmd_pkg *pcmd = nd_to_papr_cmd_pkg(cmd->pkg);
+
+	if (pcmd->payload_version == 1)
+		return update_dimm_health_v1(dimm, cmd);
+
+	/* unknown version */
+	PAPR_ERR(dimm, "Unknown payload version for dimm_health."
+		 "Ver=%d, Supported=%d\n", pcmd->payload_version,
+		 ND_PAPR_SCM_DIMM_HEALTH_VERSION);
+	return -EINVAL;
+}
+
 /* Parse a command payload and update dimm flags/private data */
 static int update_dimm_stats(struct ndctl_dimm *dimm, struct ndctl_cmd *cmd)
 {
@@ -113,6 +152,8 @@ static int update_dimm_stats(struct ndctl_dimm *dimm, struct ndctl_cmd *cmd)
 	/* Get the command dsm and handle it */
 	pcmd = nd_to_papr_cmd_pkg(cmd->pkg);
 	switch (pcmd_to_dsm(pcmd)) {
+	case DSM_PAPR_SCM_HEALTH:
+		return update_dimm_health(dimm, cmd);
 	default:
 		PAPR_ERR(dimm, "Unhandled dsm-command 0x%016llx\n",
 			 pcmd_to_dsm(pcmd));
@@ -158,14 +199,45 @@ static struct ndctl_cmd *allocate_cmd(struct ndctl_dimm *dimm,
 	return cmd;
 }
 
+static struct ndctl_cmd *papr_new_smart_health(struct ndctl_dimm *dimm)
+{
+	struct ndctl_cmd *cmd_ret;
+
+	cmd_ret = allocate_cmd(dimm, DSM_PAPR_SCM_HEALTH,
+			       sizeof(struct nd_papr_scm_dimm_health_stat),
+			       ND_PAPR_SCM_DIMM_HEALTH_VERSION);
+	if (!cmd_ret) {
+		PAPR_ERR(dimm, "Unable to allocate smart_health command\n");
+		return NULL;
+	}
+
+	cmd_ret->pkg[0].nd_size_out = ND_PAPR_SCM_ENVELOPE_CONTENT_SIZE(
+		struct nd_papr_scm_dimm_health_stat);
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
 static unsigned int papr_smart_get_flags(struct ndctl_cmd *cmd)
 {
 	/* In case of error return empty flags * */
 	if (update_dimm_stats(cmd->dimm, cmd))
 		return 0;
 
-	/* Return empty flags for now as no DSM support */
-	return 0;
+	return ND_SMART_HEALTH_VALID;
 }
 
 static int papr_dimm_init(struct ndctl_dimm *dimm)
@@ -205,4 +277,6 @@ struct ndctl_dimm_ops * const papr_scm_dimm_ops = &(struct ndctl_dimm_ops) {
 	.dimm_init = papr_dimm_init,
 	.dimm_uninit = papr_dimm_uninit,
 	.smart_get_flags = papr_smart_get_flags,
+	.new_smart = papr_new_smart_health,
+	.smart_get_health = papr_smart_get_health,
 };
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

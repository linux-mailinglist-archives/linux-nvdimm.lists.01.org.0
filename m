Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3D91FEBDA
	for <lists+linux-nvdimm@lfdr.de>; Thu, 18 Jun 2020 09:01:50 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9F1F210FC546F;
	Thu, 18 Jun 2020 00:01:48 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5EB0E1009BAD1
	for <linux-nvdimm@lists.01.org>; Thu, 18 Jun 2020 00:01:47 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05I6WC63187089;
	Thu, 18 Jun 2020 03:01:45 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31qy9j6tuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2020 03:01:45 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05I6WPw3188401;
	Thu, 18 Jun 2020 03:01:44 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31qy9j6ttm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2020 03:01:44 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
	by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05I70n7q002280;
	Thu, 18 Jun 2020 07:01:42 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by ppma02fra.de.ibm.com with ESMTP id 31r0dvr35k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2020 07:01:42 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05I71cie8061298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2020 07:01:38 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 554AB5204E;
	Thu, 18 Jun 2020 07:01:38 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.105.7])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 7F60852051;
	Thu, 18 Jun 2020 07:01:34 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Thu, 18 Jun 2020 12:31:32 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH v7 5/5] libndctl,papr_scm: Implement support for PAPR_PDSM_HEALTH
Date: Thu, 18 Jun 2020 12:31:04 +0530
Message-Id: <20200618070104.239446-6-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200618070104.239446-1-vaibhav@linux.ibm.com>
References: <20200618070104.239446-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_03:2020-06-17,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 cotscore=-2147483648 suspectscore=1 phishscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006180046
Message-ID-Hash: BHFCN47NGHNUVISAEUGW56237V7C5X6Y
X-Message-ID-Hash: BHFCN47NGHNUVISAEUGW56237V7C5X6Y
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BHFCN47NGHNUVISAEUGW56237V7C5X6Y/>
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

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
Changelog:

v6..v7:
* None

v5..v6:
* Updated patch description to reflect removal of
  update_dimm_health().
* Update papr_smart_get_flags() to parse the 'struct ndctl_cmd'
  instance and return appropriate ND_SMART_XXX flags.
* Callbacks papr_smart_get_health() , papr_smart_get_shutdown_state()
  callbacks to use 'struct ndctl_cmd' instead of 'dimm_priv'.
* Added update_dimm_flags() to update 'struct ndctl_dimm' with the
  flags returned in 'struct nd_papr_psdm_health'.

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
 ndctl/lib/papr.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/ndctl/lib/papr.c b/ndctl/lib/papr.c
index ebf31bac9a23..d9ce253369b3 100644
--- a/ndctl/lib/papr.c
+++ b/ndctl/lib/papr.c
@@ -124,10 +124,23 @@ static struct ndctl_cmd *allocate_cmd(struct ndctl_dimm *dimm,
 	return cmd;
 }
 
+/* Parse the nd_papr_pdsm_health and update dimm flags */
+static int update_dimm_flags(struct ndctl_dimm *dimm, struct nd_papr_pdsm_health *health)
+{
+	/* Update the dimm flags */
+	dimm->flags.f_arm = health->dimm_unarmed;
+	dimm->flags.f_flush = health->dimm_bad_shutdown;
+	dimm->flags.f_restore = health->dimm_bad_restore;
+	dimm->flags.f_smart = (health->dimm_health != 0);
+
+	return 0;
+}
+
 /* Validate the ndctl_cmd and return applicable flags */
 static unsigned int papr_smart_get_flags(struct ndctl_cmd *cmd)
 {
 	struct nd_pkg_pdsm *pcmd;
+	struct nd_papr_pdsm_health health;
 
 	if (!cmd_is_valid(cmd))
 		return 0;
@@ -140,14 +153,72 @@ static unsigned int papr_smart_get_flags(struct ndctl_cmd *cmd)
 		return 0;
 	}
 
-	/* return empty flags for now */
+	/*
+	 * In case of nvdimm health PDSM, update dimm flags
+	 * and  return possible flags.
+	 */
+	if (to_pdsm_cmd(cmd) == PAPR_PDSM_HEALTH) {
+		health = pcmd->payload.health;
+		update_dimm_flags(cmd->dimm, &health);
+		return ND_SMART_HEALTH_VALID | ND_SMART_SHUTDOWN_VALID;
+	}
+
+	/* Else return empty flags */
 	return 0;
 }
 
+static struct ndctl_cmd *papr_new_smart_health(struct ndctl_dimm *dimm)
+{
+	struct ndctl_cmd *cmd;
+
+	cmd = allocate_cmd(dimm, PAPR_PDSM_HEALTH,
+			       sizeof(struct nd_papr_pdsm_health));
+	if (!cmd)
+		papr_err(dimm, "Unable to allocate smart_health command\n");
+
+	return cmd;
+}
+
+static unsigned int papr_smart_get_health(struct ndctl_cmd *cmd)
+{
+	struct nd_papr_pdsm_health health;
+
+	/* Ignore in case of error or invalid pdsm */
+	if (!cmd_is_valid(cmd) ||
+	    to_pdsm(cmd)->cmd_status != 0 ||
+	    to_pdsm_cmd(cmd) != PAPR_PDSM_HEALTH)
+		return 0;
+
+	/* get the payload from command */
+	health = to_payload(cmd)->health;
+
+	/* Use some math to return one of defined ND_SMART_*_HEALTH values */
+	return  !health.dimm_health ? 0 : 1 << (health.dimm_health - 1);
+}
+
+static unsigned int papr_smart_get_shutdown_state(struct ndctl_cmd *cmd)
+{
+	struct nd_papr_pdsm_health health;
+
+	/* Ignore in case of error or invalid pdsm */
+	if (!cmd_is_valid(cmd) ||
+	    to_pdsm(cmd)->cmd_status != 0 ||
+	    to_pdsm_cmd(cmd) != PAPR_PDSM_HEALTH)
+		return 0;
+
+	/* get the payload from command */
+	health = to_payload(cmd)->health;
+
+	/* return the bad shutdown flag returned from papr_scm */
+	return health.dimm_bad_shutdown;
+}
 
 struct ndctl_dimm_ops * const papr_dimm_ops = &(struct ndctl_dimm_ops) {
 	.cmd_is_supported = papr_cmd_is_supported,
 	.smart_get_flags = papr_smart_get_flags,
 	.get_firmware_status =  papr_get_firmware_status,
 	.xlat_firmware_status = papr_xlat_firmware_status,
+	.new_smart = papr_new_smart_health,
+	.smart_get_health = papr_smart_get_health,
+	.smart_get_shutdown_state = papr_smart_get_shutdown_state,
 };
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

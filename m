Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B501FA845
	for <lists+linux-nvdimm@lfdr.de>; Tue, 16 Jun 2020 07:31:31 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9968711139A40;
	Mon, 15 Jun 2020 22:31:30 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 74E5611139A02
	for <linux-nvdimm@lists.01.org>; Mon, 15 Jun 2020 22:31:28 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05G5VMGX137062;
	Tue, 16 Jun 2020 01:31:26 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31pjnaq5b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2020 01:31:25 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05G5VO16137276;
	Tue, 16 Jun 2020 01:31:25 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31pjnaq571-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2020 01:31:24 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
	by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05G5Psjb021241;
	Tue, 16 Jun 2020 05:31:06 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by ppma01fra.de.ibm.com with ESMTP id 31mpe7hwrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2020 05:31:06 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05G5V47J62062832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2020 05:31:04 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9F57AE055;
	Tue, 16 Jun 2020 05:31:03 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1516DAE056;
	Tue, 16 Jun 2020 05:31:00 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.199.40.156])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Tue, 16 Jun 2020 05:30:59 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Tue, 16 Jun 2020 11:00:58 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH v6 5/5] libndctl,papr_scm: Implement support for PAPR_PDSM_HEALTH
Date: Tue, 16 Jun 2020 11:00:29 +0530
Message-Id: <20200616053029.84731-6-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200616053029.84731-1-vaibhav@linux.ibm.com>
References: <20200616053029.84731-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-15_11:2020-06-15,2020-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 priorityscore=1501 cotscore=-2147483648 malwarescore=0 clxscore=1015
 suspectscore=1 lowpriorityscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006160035
Message-ID-Hash: RSYDAVFESPKCKSCJ2EU55YAY4WWVGDCX
X-Message-ID-Hash: RSYDAVFESPKCKSCJ2EU55YAY4WWVGDCX
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RSYDAVFESPKCKSCJ2EU55YAY4WWVGDCX/>
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
index aff294823e41..e1acc3c44295 100644
--- a/ndctl/lib/papr.c
+++ b/ndctl/lib/papr.c
@@ -118,10 +118,23 @@ static struct ndctl_cmd *allocate_cmd(struct ndctl_dimm *dimm,
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
@@ -134,14 +147,72 @@ static unsigned int papr_smart_get_flags(struct ndctl_cmd *cmd)
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

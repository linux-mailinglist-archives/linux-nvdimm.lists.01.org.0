Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32356210D01
	for <lists+linux-nvdimm@lfdr.de>; Wed,  1 Jul 2020 16:02:33 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7B5931103E37C;
	Wed,  1 Jul 2020 07:02:31 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F0B381003FD6D
	for <linux-nvdimm@lists.01.org>; Wed,  1 Jul 2020 07:02:29 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 061E1qQf129676;
	Wed, 1 Jul 2020 10:02:27 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
	by mx0a-001b2d01.pphosted.com with ESMTP id 320s226fhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2020 10:02:23 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
	by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 061DWIOw031071;
	Wed, 1 Jul 2020 14:01:10 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by ppma06ams.nl.ibm.com with ESMTP id 31wwch4mky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2020 14:01:10 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 061E179r50331698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2020 14:01:07 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84399A405B;
	Wed,  1 Jul 2020 14:01:07 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 258F5A404D;
	Wed,  1 Jul 2020 14:01:05 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.199.44.33])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Wed,  1 Jul 2020 14:01:04 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Wed, 01 Jul 2020 19:31:03 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH] libndctl/papr_scm: Add support for reporting "life_used_percentage" metric
Date: Wed,  1 Jul 2020 19:31:02 +0530
Message-Id: <20200701140102.7795-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_08:2020-07-01,2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 cotscore=-2147483648 spamscore=0 mlxscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007010100
Message-ID-Hash: KHDKD7LLRDD2R6BZHG6WCEYXJS7SXPV2
X-Message-ID-Hash: KHDKD7LLRDD2R6BZHG6WCEYXJS7SXPV2
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KHDKD7LLRDD2R6BZHG6WCEYXJS7SXPV2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This adds support for reporting 'life_used_percentage' metric in
nvdimm health state output. It indicates an approximate share of
usable life consumed for a given NVDIMM. NDCTL output reported
for papr-scm based NVDIMMs is of the form below:

$ sudo ndctl list -DH
[
  {
    "dev":"nmem0",
    "health":{
      "health_state":"ok",
      "life_used_percentage":0,
      "shutdown_state":"clean"
    }
  }
]

For papr-scm based NVDIMMs this can be retrieved via an updated
PAPR_PDSM_HEALTH pdsm payload that adds a new field 'dimm_fuel_gauge'
at the end of 'struct nd_papr_pdsm_health'. Presence of this field is
indicated by presence of PDSM_DIMM_HEALTH_RUN_GAUGE_VALID flag in
field 'struct nd_papr_pdsm_health.extensions_flags'. To calculate
'life_used_percentage' metric we simply follow this identity:

"life_used_percentage = 100 - dimm_fuel_gauge"

The patch updates papr_smart_get_flags() to check for existence of
flag PDSM_DIMM_HEALTH_RUN_GAUGE_VALID in 'struct
nd_papr_pdsm_health.extensions_flags' and if found also return
ND_SMART_USED_VALID flag from the dimm-op callback.

A new dimm-op papr_smart_get_life_used() is introduced that calculates
the value of 'life_used_percentage' from the PAPR_PDSM_HEALTH pdsm
payload and returns it back to libndctl for output.

The patch is based on existing work to add support for report health
information for papr-scm based NVDIMMs [1][2]

[1] commit 880901b45cdf ("libndctl,papr_scm: Implement support for
PAPR_PDSM_HEALTH")

[2] https://github.com/pmem/ndctl/commits/vj/papr_health

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 ndctl/lib/papr.c      | 28 +++++++++++++++++++++++++++-
 ndctl/lib/papr_pdsm.h |  7 +++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/ndctl/lib/papr.c b/ndctl/lib/papr.c
index d9ce253369b3..8145412dec7d 100644
--- a/ndctl/lib/papr.c
+++ b/ndctl/lib/papr.c
@@ -141,6 +141,7 @@ static unsigned int papr_smart_get_flags(struct ndctl_cmd *cmd)
 {
 	struct nd_pkg_pdsm *pcmd;
 	struct nd_papr_pdsm_health health;
+	unsigned int flags;
 
 	if (!cmd_is_valid(cmd))
 		return 0;
@@ -160,7 +161,13 @@ static unsigned int papr_smart_get_flags(struct ndctl_cmd *cmd)
 	if (to_pdsm_cmd(cmd) == PAPR_PDSM_HEALTH) {
 		health = pcmd->payload.health;
 		update_dimm_flags(cmd->dimm, &health);
-		return ND_SMART_HEALTH_VALID | ND_SMART_SHUTDOWN_VALID;
+		flags = ND_SMART_HEALTH_VALID | ND_SMART_SHUTDOWN_VALID;
+
+		/* check for extension flags */
+		if (health.extension_flags & PDSM_DIMM_HEALTH_RUN_GAUGE_VALID)
+			flags |= ND_SMART_USED_VALID;
+
+		return flags;
 	}
 
 	/* Else return empty flags */
@@ -213,6 +220,24 @@ static unsigned int papr_smart_get_shutdown_state(struct ndctl_cmd *cmd)
 	return health.dimm_bad_shutdown;
 }
 
+static unsigned int papr_smart_get_life_used(struct ndctl_cmd *cmd)
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
+	/* return dimm life remaining from the health payload */
+	return (health.extension_flags & PDSM_DIMM_HEALTH_RUN_GAUGE_VALID) ?
+		(100 - health.dimm_fuel_gauge) : 0;
+}
+
 struct ndctl_dimm_ops * const papr_dimm_ops = &(struct ndctl_dimm_ops) {
 	.cmd_is_supported = papr_cmd_is_supported,
 	.smart_get_flags = papr_smart_get_flags,
@@ -221,4 +246,5 @@ struct ndctl_dimm_ops * const papr_dimm_ops = &(struct ndctl_dimm_ops) {
 	.new_smart = papr_new_smart_health,
 	.smart_get_health = papr_smart_get_health,
 	.smart_get_shutdown_state = papr_smart_get_shutdown_state,
+	.smart_get_life_used = papr_smart_get_life_used,
 };
diff --git a/ndctl/lib/papr_pdsm.h b/ndctl/lib/papr_pdsm.h
index 4c7c06757053..1bac8a7fc933 100644
--- a/ndctl/lib/papr_pdsm.h
+++ b/ndctl/lib/papr_pdsm.h
@@ -72,6 +72,9 @@
 #define PAPR_PDSM_DIMM_CRITICAL      2
 #define PAPR_PDSM_DIMM_FATAL         3
 
+/* Indicate that the 'dimm_fuel_gauge' field is valid */
+#define PDSM_DIMM_HEALTH_RUN_GAUGE_VALID 1
+
 /*
  * Struct exchanged between kernel & ndctl in for PAPR_PDSM_HEALTH
  * Various flags indicate the health status of the dimm.
@@ -84,6 +87,7 @@
  * dimm_locked		: Contents of the dimm cant be modified until CEC reboot
  * dimm_encrypted	: Contents of dimm are encrypted.
  * dimm_health		: Dimm health indicator. One of PAPR_PDSM_DIMM_XXXX
+ * dimm_fuel_gauge	: Life remaining of DIMM as a percentage from 0-100
  */
 struct nd_papr_pdsm_health {
 	union {
@@ -96,6 +100,9 @@ struct nd_papr_pdsm_health {
 			__u8 dimm_locked;
 			__u8 dimm_encrypted;
 			__u16 dimm_health;
+
+			/* Extension flag PDSM_DIMM_HEALTH_RUN_GAUGE_VALID */
+			__u16 dimm_fuel_gauge;
 		};
 		__u8 buf[ND_PDSM_PAYLOAD_MAX_SIZE];
 	};
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

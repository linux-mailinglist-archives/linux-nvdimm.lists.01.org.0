Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BF2165C32
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Feb 2020 11:54:41 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2C6D610FC35BC;
	Thu, 20 Feb 2020 02:55:32 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4B06F10FC35BB
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 02:54:27 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01KArUgN077483
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 05:53:34 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2y8xdpnq1f-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 05:53:33 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <vaibhav@linux.ibm.com>;
	Thu, 20 Feb 2020 10:50:17 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
	by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 20 Feb 2020 10:50:13 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01KAoCsf48038088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2020 10:50:12 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E8E9A4057;
	Thu, 20 Feb 2020 10:50:12 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5274AA4055;
	Thu, 20 Feb 2020 10:50:09 +0000 (GMT)
Received: from vajain21.in.ibm.com.com (unknown [9.199.53.128])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu, 20 Feb 2020 10:50:08 +0000 (GMT)
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH 8/8] libndctl,papr_scm: Add support for reporting bad shutdown
Date: Thu, 20 Feb 2020 16:19:28 +0530
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220104928.198625-1-vaibhav@linux.ibm.com>
References: <20200220104928.198625-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20022010-0016-0000-0000-000002E88E73
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022010-0017-0000-0000-0000334BAA54
Message-Id: <20200220104928.198625-9-vaibhav@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_03:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 suspectscore=1 clxscore=1015 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002200081
Message-ID-Hash: WE767EVCMAPCPTWIRIIVXSWW2TLEWWVJ
X-Message-ID-Hash: WE767EVCMAPCPTWIRIIVXSWW2TLEWWVJ
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Alastair D'Silva <alastair@au1.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WE767EVCMAPCPTWIRIIVXSWW2TLEWWVJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Provide support for dimm-op 'smart_get_shutdown_state' implemented as
papr_smart_get_shutdown_state() to report a bad shutdown that couldn't
flush contents of nvdimm to flash memory properly.

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 ndctl/lib/papr_scm.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/ndctl/lib/papr_scm.c b/ndctl/lib/papr_scm.c
index a01649d3a9fe..8a6fec992aff 100644
--- a/ndctl/lib/papr_scm.c
+++ b/ndctl/lib/papr_scm.c
@@ -231,13 +231,22 @@ static unsigned int papr_smart_get_health(struct ndctl_cmd *cmd)
 		return 1 << (p->health.dimm_health - 1);
 }
 
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
 
-	return ND_SMART_HEALTH_VALID;
+	return ND_SMART_HEALTH_VALID | ND_SMART_SHUTDOWN_VALID;
 }
 
 static int papr_dimm_init(struct ndctl_dimm *dimm)
@@ -279,4 +288,5 @@ struct ndctl_dimm_ops * const papr_scm_dimm_ops = &(struct ndctl_dimm_ops) {
 	.smart_get_flags = papr_smart_get_flags,
 	.new_smart = papr_new_smart_health,
 	.smart_get_health = papr_smart_get_health,
+	.smart_get_shutdown_state = papr_smart_get_shutdown_state,
 };
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

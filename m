Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A52227F2C
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 Jul 2020 13:43:44 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B1A9712458EA8;
	Tue, 21 Jul 2020 04:43:42 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C86CF12458EA6
	for <linux-nvdimm@lists.01.org>; Tue, 21 Jul 2020 04:43:40 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06LBVxEg047277;
	Tue, 21 Jul 2020 07:43:38 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 32d91v3y0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2020 07:43:38 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06LBZKHm023915;
	Tue, 21 Jul 2020 11:43:36 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by ppma03ams.nl.ibm.com with ESMTP id 32brq7ktx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2020 11:43:35 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06LBhXB919202414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jul 2020 11:43:33 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FB694C052;
	Tue, 21 Jul 2020 11:43:33 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC3C84C050;
	Tue, 21 Jul 2020 11:43:29 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.102.17.203])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Tue, 21 Jul 2020 11:43:29 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Tue, 21 Jul 2020 17:13:28 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH] papr: Check for command type in papr_xlat_firmware_status()
Date: Tue, 21 Jul 2020 17:13:26 +0530
Message-Id: <20200721114326.305790-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-21_05:2020-07-21,2020-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=1 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007210077
Message-ID-Hash: 4RD5BUE7FHDMKFMP4IUGNPSURJWFUJUR
X-Message-ID-Hash: 4RD5BUE7FHDMKFMP4IUGNPSURJWFUJUR
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4RD5BUE7FHDMKFMP4IUGNPSURJWFUJUR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

We recently discovered intermittent failures while reading label-area
of PAPR-NVDimms and the command 'read-labels' would in such a case
generated empty output like below:

$ sudo ndctl read-labels -j nmem0
[
]
read 0 nmem

Upon investigation we found that this was caused by a spurious error
code returned from ndctl_cmd_submit_xlat() when its called from
ndctl_dimm_read_label_extent() while trying to read the label-area
contents of the NVDIMM.

Digging further it was relieved that ndctl_cmd_submit_xlat() would
always call papr_xlat_firmware_status() via pointer
'papr_dimm_ops->xlat_firmware_status' to retrieve translated firmware
status for all ndctl_cmds even though they arent really PAPR PDSM
commands.

In this case ndctl_cmd->type == ND_CMD_GET_CONFIG_DATA and was
represented by type 'struct nd_cmd_get_config_data_hdr' and
papr_xlat_firmware_status() incorrectly assumed it to be of type
'struct nd_pkg_pdsm' and wrongly dereferenced it returning an invalid
value.

A proper fix for this would probably need introducing a new ndctl_cmd
callback like 'ndctl_cmd.get_xlat_firmware_status' similar to one
introduced in [1]. However such a change could be disruptive, hence
the patch introduces a small workaround in papr_xlat_firmware_status()
that checks if the 'struct ndctl_cmd *' provided if of correct type
CMD_CALL and if not then it ignores it and return '0'

References:
[1]: commit fa754dd8acdb ("ndctl/dimm: Rework dimm command status
reporting")

Fixes: 151d2876c49e ("papr: Add scaffolding to issue and handle PDSM requests")
Reported-by: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 ndctl/lib/papr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/ndctl/lib/papr.c b/ndctl/lib/papr.c
index d9ce253369b3..63561f8f9797 100644
--- a/ndctl/lib/papr.c
+++ b/ndctl/lib/papr.c
@@ -56,9 +56,7 @@ static u32 papr_get_firmware_status(struct ndctl_cmd *cmd)
 
 static int papr_xlat_firmware_status(struct ndctl_cmd *cmd)
 {
-	const struct nd_pkg_pdsm *pcmd = to_pdsm(cmd);
-
-	return pcmd->cmd_status;
+	return (cmd->type == ND_CMD_CALL) ? to_pdsm(cmd)->cmd_status : 0;
 }
 
 /* Verify if the given command is supported and valid */
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

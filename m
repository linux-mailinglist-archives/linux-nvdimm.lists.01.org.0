Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F55A268160
	for <lists+linux-nvdimm@lfdr.de>; Sun, 13 Sep 2020 23:19:30 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B03AC13F5FB33;
	Sun, 13 Sep 2020 14:19:28 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9CC8E13A2201F
	for <linux-nvdimm@lists.01.org>; Sun, 13 Sep 2020 14:19:26 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08DL26hT132547;
	Sun, 13 Sep 2020 17:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=GaVExhh2fuV3sLgBobU5UHWtwLeHmR57GjEx7SaPh6A=;
 b=BK4qSTSC+SVKaQ1bvRdJ7cW63PS1IV2dzPskR2AXasERIFL578nc8ROyEIJ6YmRdPRH8
 AP80d9ZnV0LN/48TNt2+teumKHW4ZATl8F1HvhPdpGLoEB+dnajk/4U3GG4XBo6PdRpz
 mYGo5K33x+zzoxILGqPlXuf3iB1rIYJtPietJVlbyMg3qtbkKvIrHKMTE0fh1F1b2cSJ
 WRxPJbyu+cUxj1LPDiDFQSRPFCVLrnfoeEsJqg+86MTGNHhng9Lw22XCxhN/SQB6XAS3
 5A3qhIynfo/tK7zRCeH3516l5pMnvtqTknuqd95on2jwm+mLVJXkNHue46btNT3+CgMG +w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 33htfv0p6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Sep 2020 17:19:16 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08DLG7YB163782;
	Sun, 13 Sep 2020 17:19:16 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
	by mx0b-001b2d01.pphosted.com with ESMTP id 33htfv0p60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Sep 2020 17:19:16 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
	by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08DL7nuF004459;
	Sun, 13 Sep 2020 21:19:14 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by ppma06ams.nl.ibm.com with ESMTP id 33hb1j0n2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Sep 2020 21:19:14 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08DLJB459306568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 13 Sep 2020 21:19:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7AA7AE04D;
	Sun, 13 Sep 2020 21:19:11 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A392CAE045;
	Sun, 13 Sep 2020 21:19:08 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.199.56.137])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Sun, 13 Sep 2020 21:19:08 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Mon, 14 Sep 2020 02:49:07 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org
Subject: [PATCH] powerpc/papr_scm: Add PAPR command family to pass-through command-set
Date: Mon, 14 Sep 2020 02:49:04 +0530
Message-Id: <20200913211904.24472-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-13_08:2020-09-10,2020-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009130191
Message-ID-Hash: AY5NDTOY725EVH4ORML33FKM6WFVCDRJ
X-Message-ID-Hash: AY5NDTOY725EVH4ORML33FKM6WFVCDRJ
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AY5NDTOY725EVH4ORML33FKM6WFVCDRJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add NVDIMM_FAMILY_PAPR to the list of valid 'dimm_family_mask'
acceptable by papr_scm. This is needed as since commit
92fe2aa859f5 ("libnvdimm: Validate command family indices") libnvdimm
performs a validation of 'nd_cmd_pkg.nd_family' received as part of
ND_CMD_CALL processing to ensure only known command families can use
the general ND_CMD_CALL pass-through functionality.

Without this change the ND_CMD_CALL pass-through targeting
NVDIMM_FAMILY_PAPR error out with -EINVAL.

Fixes: 92fe2aa859f5 ("libnvdimm: Validate command family indices")
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/papr_scm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 5493bc847bd08..27268370dee00 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -898,6 +898,9 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
 	p->bus_desc.of_node = p->pdev->dev.of_node;
 	p->bus_desc.provider_name = kstrdup(p->pdev->name, GFP_KERNEL);
 
+	/* Set the dimm command family mask to accept PDSMs */
+	set_bit(NVDIMM_FAMILY_PAPR, &p->bus_desc.dimm_family_mask);
+
 	if (!p->bus_desc.provider_name)
 		return -ENOMEM;
 
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

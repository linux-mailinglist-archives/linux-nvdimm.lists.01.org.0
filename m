Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7220434CF02
	for <lists+linux-nvdimm@lfdr.de>; Mon, 29 Mar 2021 13:31:27 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DEA09100EBBB9;
	Mon, 29 Mar 2021 04:31:22 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 98F87100ED4AE
	for <linux-nvdimm@lists.01.org>; Mon, 29 Mar 2021 04:31:20 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12TB5Feq025347;
	Mon, 29 Mar 2021 07:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=frO64+ccnL78OUxeX8hkjQoL/xTSF64D+YxEws4n42c=;
 b=fCVa+tta1mfFS9D3T9dkFyThzzBlo3aiP8k20+jBWupQJpEmKTep6QFnbILU9aJQ2X6l
 ODl5ALYiALs05vZ/O8imJ+KnRB56jX/ylkrcaaeiXRUxbitFRkRC9NWYExlQOWOD2rCP
 BlmKJTZKM7NqKOddkJ2mO2qx6InfXiwwQ8CpiaCirsxPIz8k9GdA2LO789mNu7yA2Ylp
 AuXaO1FCHWP8jgRZ67KuNzvp1n2w4nNhUNpNg/S4/LKrGfKpZUl8AgULGBiWd9Fu+leJ
 XEhasxWUIg/wIeJYQNG0JD2FDM27VfLo3h2u1JF/CoJJWVwNuJ6dbBNt7ulVnumtUmJM YQ==
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
	by mx0a-001b2d01.pphosted.com with ESMTP id 37jhsamswg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Mar 2021 07:31:15 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
	by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12TBSw6p029128;
	Mon, 29 Mar 2021 11:31:13 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
	by ppma06ams.nl.ibm.com with ESMTP id 37huyh9rpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Mar 2021 11:31:13 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12TBUpt914811414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Mar 2021 11:30:51 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C6E9A405B;
	Mon, 29 Mar 2021 11:31:10 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78DE6A4054;
	Mon, 29 Mar 2021 11:31:07 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.199.32.234])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Mon, 29 Mar 2021 11:31:07 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Mon, 29 Mar 2021 17:01:06 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/papr_scm: Mark nvdimm as unarmed if needed during probe
Date: Mon, 29 Mar 2021 17:01:03 +0530
Message-Id: <20210329113103.476760-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xSElMSAwnJ6e2v4DhN7-T3j8gcP8U15O
X-Proofpoint-GUID: xSElMSAwnJ6e2v4DhN7-T3j8gcP8U15O
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-29_08:2021-03-26,2021-03-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 clxscore=1011 adultscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=936
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290086
Message-ID-Hash: OI54UZCV7LGRSSEGGPB3RTFF2TZPN6CX
X-Message-ID-Hash: OI54UZCV7LGRSSEGGPB3RTFF2TZPN6CX
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Shivaprasad G Bhat <sbhat@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OI54UZCV7LGRSSEGGPB3RTFF2TZPN6CX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In case an nvdimm is found to be unarmed during probe then set its
NDD_UNARMED flag before nvdimm_create(). This would enforce a
read-only access to the ndimm region. Presently even if an nvdimm is
unarmed its not marked as read-only on ppc64 guests.

The patch updates papr_scm_nvdimm_init() to force query of nvdimm
health via __drc_pmem_query_health() and if nvdimm is found to be
unarmed then set the nvdimm flag ND_UNARMED for nvdimm_create().

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/papr_scm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 835163f54244..7e8168e19427 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -914,6 +914,15 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
 	dimm_flags = 0;
 	set_bit(NDD_LABELING, &dimm_flags);
 
+	/*
+	 * Check if the nvdimm is unarmed. No locking needed as we are still
+	 * initializing. Ignore error encountered if any.
+	 */
+	__drc_pmem_query_health(p);
+
+	if (p->health_bitmap & PAPR_PMEM_UNARMED_MASK)
+		set_bit(NDD_UNARMED, &dimm_flags);
+
 	p->nvdimm = nvdimm_create(p->bus, p, papr_nd_attr_groups,
 				  dimm_flags, PAPR_SCM_DIMM_CMD_MASK, 0, NULL);
 	if (!p->nvdimm) {
-- 
2.30.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

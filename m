Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA6235F3FB
	for <lists+linux-nvdimm@lfdr.de>; Wed, 14 Apr 2021 14:40:51 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E3C7B100EB334;
	Wed, 14 Apr 2021 05:40:47 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 55BEC100ED4AB
	for <linux-nvdimm@lists.01.org>; Wed, 14 Apr 2021 05:40:45 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13ECY4F4152531;
	Wed, 14 Apr 2021 08:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=scXF9Obq903sykFBPVP7H/inXD9mYbcm58Y+M+RCWcI=;
 b=cXMqf+POb8AhEJZjNNXEjHY4VSuQs1gKLXetrIgXdKUfP00PVc5y5OAT02/ky3BqTNPy
 LilE85V3YlKbGlwI+PQ+7D/BuP0Ka3P4L2S/doZ2qYuyOiMP8ztq6gEMMQuBxo8p1//3
 KEJVKAEH1z46PtR5JgGpXXc64TOy59BasFW4e44n7rgymKyvKjyCrPTOEZgLE+HrP57x
 pwc1kxRgV5eXROr540ASV27+X61ffHMM14e7SOxJ/aas1p7M4qFCVHESmuJV44Z0l8Et
 eycLlOwV3d/NyMHnwjUKyTxVfwT6Q5KKg1n1MjGakTnt/4gmiOKNp/k3Vr/Li75VvNVQ qA==
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 37wvvy674t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Apr 2021 08:40:37 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
	by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13ECUPXQ026720;
	Wed, 14 Apr 2021 12:40:34 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by ppma03fra.de.ibm.com with ESMTP id 37u3n89s0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Apr 2021 12:40:34 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13ECeVLX54854124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Apr 2021 12:40:31 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99998A405C;
	Wed, 14 Apr 2021 12:40:31 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5F45A4054;
	Wed, 14 Apr 2021 12:40:28 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.85.72.167])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Wed, 14 Apr 2021 12:40:28 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Wed, 14 Apr 2021 18:10:27 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org
Subject: [PATCH] powerpc/papr_scm: Reduce error severity if nvdimm stats inaccessible
Date: Wed, 14 Apr 2021 18:10:26 +0530
Message-Id: <20210414124026.332472-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vzYH8jALvrzyK8oV-kI_YrsMVIlCvA1W
X-Proofpoint-ORIG-GUID: vzYH8jALvrzyK8oV-kI_YrsMVIlCvA1W
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-14_07:2021-04-14,2021-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 phishscore=0 mlxlogscore=982 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104140086
Message-ID-Hash: F2SX3H7IENBZOHZFBSN6SDJCZBWSOFR2
X-Message-ID-Hash: F2SX3H7IENBZOHZFBSN6SDJCZBWSOFR2
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/F2SX3H7IENBZOHZFBSN6SDJCZBWSOFR2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Currently drc_pmem_qeury_stats() generates a dev_err in case
"Enable Performance Information Collection" feature is disabled from
HMC. The error is of the form below:

papr_scm ibm,persistent-memory:ibm,pmemory@44104001: Failed to query
	 performance stats, Err:-10

This error message confuses users as it implies a possible problem
with the nvdimm even though its due to a disabled feature.

So we fix this by explicitly handling the H_AUTHORITY error from the
H_SCM_PERFORMANCE_STATS hcall and generating a warning instead of an
error, saying that "Performance stats in-accessible".

Fixes: 2d02bf835e57('powerpc/papr_scm: Fetch nvdimm performance stats from PHYP')
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/papr_scm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 835163f54244..9216424f8be3 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -277,6 +277,9 @@ static ssize_t drc_pmem_query_stats(struct papr_scm_priv *p,
 		dev_err(&p->pdev->dev,
 			"Unknown performance stats, Err:0x%016lX\n", ret[0]);
 		return -ENOENT;
+	} else if (rc == H_AUTHORITY) {
+		dev_warn(&p->pdev->dev, "Performance stats in-accessible");
+		return -EPERM;
 	} else if (rc != H_SUCCESS) {
 		dev_err(&p->pdev->dev,
 			"Failed to query performance stats, Err:%lld\n", rc);
-- 
2.30.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

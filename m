Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC3E37488F
	for <lists+linux-nvdimm@lfdr.de>; Wed,  5 May 2021 21:16:35 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C8590100F2245;
	Wed,  5 May 2021 12:16:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5B918100EB33B
	for <linux-nvdimm@lists.01.org>; Wed,  5 May 2021 12:16:29 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 145J3Mhc104219;
	Wed, 5 May 2021 15:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=wj/JFiXenkQ9cFj2JUGEFwnBmXSeGZ+OhsKC1KJBkZo=;
 b=oA+9YzPz+yz/ZHsOBueT8AMdaOSAnKdHwj3ArAUuUjNKEC2oKbp7MtqmAAVMgHgop0lN
 +h14siT/EeBeX6Q4+GzolHfwMMzWTSBlez7PHFu0Yn7a0Vko+zhYMJlrcunsRTk65bj6
 mWKooomHpg2Cvuar9DF1FKDFNg/rcUD04ecQHel1OIBi37JoOkp7Qs85ovOLQissOng+
 P0k+ihynP42LHKCu/6B5edSCeN9mYzvhClAiVt+taNVhFMcuUrCi/v+6ls9V3oOBW8X9
 bUviRHqJosEe4aaOBz2vySGEFzKKLNH6NIFYTyEotQuo1ryxImSERwYHuowzyc7uyjWe +w==
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
	by mx0b-001b2d01.pphosted.com with ESMTP id 38byd23bg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 May 2021 15:16:16 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
	by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 145Ir5dZ023694;
	Wed, 5 May 2021 19:16:14 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by ppma06ams.nl.ibm.com with ESMTP id 38bee58fqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 May 2021 19:16:14 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 145JGBs422413798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 May 2021 19:16:11 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8057DA405C;
	Wed,  5 May 2021 19:16:11 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94FC2A4054;
	Wed,  5 May 2021 19:16:08 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.85.88.241])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Wed,  5 May 2021 19:16:08 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Thu, 06 May 2021 00:46:07 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org
Subject: [PATCH v2] powerpc/papr_scm: Reduce error severity if nvdimm stats inaccessible
Date: Thu,  6 May 2021 00:46:06 +0530
Message-Id: <20210505191606.51666-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FWfRU6zLQIivcPLGwQkLKWWdVqqED2k5
X-Proofpoint-GUID: FWfRU6zLQIivcPLGwQkLKWWdVqqED2k5
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-05_09:2021-05-05,2021-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105050130
Message-ID-Hash: 45CNPXPVLMQ3IMVKBHPHZIJKHGZQZXAH
X-Message-ID-Hash: 45CNPXPVLMQ3IMVKBHPHZIJKHGZQZXAH
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/45CNPXPVLMQ3IMVKBHPHZIJKHGZQZXAH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Currently drc_pmem_qeury_stats() generates a dev_err in case
"Enable Performance Information Collection" feature is disabled from
HMC or performance stats are not available for an nvdimm. The error is
of the form below:

papr_scm ibm,persistent-memory:ibm,pmemory@44104001: Failed to query
	 performance stats, Err:-10

This error message confuses users as it implies a possible problem
with the nvdimm even though its due to a disabled/unavailable
feature. We fix this by explicitly handling the H_AUTHORITY and
H_UNSUPPORTED errors from the H_SCM_PERFORMANCE_STATS hcall.

In case of H_AUTHORITY error an info message is logged instead of an
error, saying that "Permission denied while accessing performance
stats". Also '-EACCES' error is return instead of -EPERM.

In case of H_UNSUPPORTED error we return a -EPERM error back from
drc_pmem_query_stats() indicating that performance stats-query
operation is not supported on this nvdimm.

Fixes: 2d02bf835e57('powerpc/papr_scm: Fetch nvdimm performance stats from PHYP')
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
Changelog

v2:
* Updated the message logged in case of H_AUTHORITY error [ Ira ]
* Switched from dev_warn to dev_info in case of H_AUTHORITY error.
* Instead of -EPERM return -EACCESS for H_AUTHORITY error.
* Added explicit handling of H_UNSUPPORTED error.
---
 arch/powerpc/platforms/pseries/papr_scm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index ef26fe40efb0..12f1513f0fca 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -310,6 +310,13 @@ static ssize_t drc_pmem_query_stats(struct papr_scm_priv *p,
 		dev_err(&p->pdev->dev,
 			"Unknown performance stats, Err:0x%016lX\n", ret[0]);
 		return -ENOENT;
+	} else if (rc == H_AUTHORITY) {
+		dev_info(&p->pdev->dev,
+			 "Permission denied while accessing performance stats");
+		return -EACCES;
+	} else if (rc == H_UNSUPPORTED) {
+		dev_dbg(&p->pdev->dev, "Performance stats unsupported\n");
+		return -EPERM;
 	} else if (rc != H_SUCCESS) {
 		dev_err(&p->pdev->dev,
 			"Failed to query performance stats, Err:%lld\n", rc);
-- 
2.31.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

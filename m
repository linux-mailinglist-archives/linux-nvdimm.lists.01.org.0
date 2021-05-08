Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F240E376F97
	for <lists+linux-nvdimm@lfdr.de>; Sat,  8 May 2021 06:37:20 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 25888100EAAEB;
	Fri,  7 May 2021 21:37:17 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 13D31100EC1C6
	for <linux-nvdimm@lists.01.org>; Fri,  7 May 2021 21:37:13 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1484YPf6067321;
	Sat, 8 May 2021 00:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=J015+afVlEQ33c36XPtW4avmXBQHeDgnCWaXqrlS8js=;
 b=lR0WkbQfrNowiAaUOghJRQqBAaZlEKjmT4bYcrIe767lVRYHcnMd4igCXidyLFTryAEV
 tCN/D/b7EXbU0zQHWZLjxKZEZLgwpyoDg7/Toz9IRxPLjvhLUMGIo/kDUR7/uq4jP2e9
 1kVi20ghXBmaYbmIA7OfZRLUbJi51zI52OsEt2dmPOAJow97ILAk1IKg1VvHBqGiHA3T
 dCgntqio5co43TOexgggDv/5wCkSJodB4QXVYjsdtgZ0MaqxphVbVyhJTINW92ZhmE1f
 TAvcUcm76kdB5yLYE7TuJNIdYyQThgpW9rZe8slFqrlYj03YRrIFlDpFwkOXHHq7ut3W +w==
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 38djnkgxmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 May 2021 00:37:03 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
	by ppma05fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1484RKND017435;
	Sat, 8 May 2021 04:37:02 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by ppma05fra.de.ibm.com with ESMTP id 38dj98g0bp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 May 2021 04:37:02 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1484awMq33489380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 8 May 2021 04:36:58 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA5224206E;
	Sat,  8 May 2021 04:36:58 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 035C042064;
	Sat,  8 May 2021 04:36:56 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.77.197.122])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Sat,  8 May 2021 04:36:55 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Sat, 08 May 2021 10:06:54 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org
Subject: [PATCH v3] powerpc/papr_scm: Reduce error severity if nvdimm stats inaccessible
Date: Sat,  8 May 2021 10:06:42 +0530
Message-Id: <20210508043642.114076-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 75Q6dyj18lEVbupR733Arw18RSvD1ut5
X-Proofpoint-GUID: 75Q6dyj18lEVbupR733Arw18RSvD1ut5
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-08_02:2021-05-06,2021-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 clxscore=1011 bulkscore=0 impostorscore=0
 mlxscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105080030
Message-ID-Hash: 3P6DNRRQLAOLYONTFRWVTJNFI7VCX4PH
X-Message-ID-Hash: 3P6DNRRQLAOLYONTFRWVTJNFI7VCX4PH
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3P6DNRRQLAOLYONTFRWVTJNFI7VCX4PH/>
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
stats" and an EPERM error is returned back.

In case of H_UNSUPPORTED error we return a EOPNOTSUPP error back from
drc_pmem_query_stats() indicating that performance stats-query
operation is not supported on this nvdimm.

Fixes: 2d02bf835e57('powerpc/papr_scm: Fetch nvdimm performance stats from PHYP')
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
Changelog

v3:
* Return EOPNOTSUPP error in case of H_UNSUPPORTED [ Ira ]
* Return EPERM in case of H_AUTHORITY [ Ira ]
* Updated patch description

v2:
* Updated the message logged in case of H_AUTHORITY error [ Ira ]
* Switched from dev_warn to dev_info in case of H_AUTHORITY error.
* Instead of -EPERM return -EACCESS for H_AUTHORITY error.
* Added explicit handling of H_UNSUPPORTED error.
---
 arch/powerpc/platforms/pseries/papr_scm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index ef26fe40efb0..e2b69cc3beaf 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -310,6 +310,13 @@ static ssize_t drc_pmem_query_stats(struct papr_scm_priv *p,
 		dev_err(&p->pdev->dev,
 			"Unknown performance stats, Err:0x%016lX\n", ret[0]);
 		return -ENOENT;
+	} else if (rc == H_AUTHORITY) {
+		dev_info(&p->pdev->dev,
+			 "Permission denied while accessing performance stats");
+		return -EPERM;
+	} else if (rc == H_UNSUPPORTED) {
+		dev_dbg(&p->pdev->dev, "Performance stats unsupported\n");
+		return -EOPNOTSUPP;
 	} else if (rc != H_SUCCESS) {
 		dev_err(&p->pdev->dev,
 			"Failed to query performance stats, Err:%lld\n", rc);
-- 
2.31.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

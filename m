Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EF9354B32
	for <lists+linux-nvdimm@lfdr.de>; Tue,  6 Apr 2021 05:22:56 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B7EA1100EB82F;
	Mon,  5 Apr 2021 20:22:54 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4F5E4100EB82F
	for <linux-nvdimm@lists.01.org>; Mon,  5 Apr 2021 20:22:52 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 136354vA013863;
	Mon, 5 Apr 2021 23:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=AIYxuCWzMqVB+Bj/ziy/+ms0dMl5BnfSJ9ERTnM9YS8=;
 b=H8h3104glCUWJM8T+l6Dm/+bxK0L2VH7y9HS0THYLm76FKdoOBigTKFyt/+POnoR7Foh
 pBejc83zKn/RybkKavW2xSHtZ/zxrlVv6YEsIsefzbHjWr5J24wJiyAiiZ036UGCtB6P
 dteOv7xH/ES7efrS6fatwmcMZIDIS7myuJ4jcrNHUGHyHsnyj3rBnq0J+naB0LVQ8tdK
 slG9SPlu8MEr/Mp5PnwKAd0c1aJvIBpE9ziAmYeUkPyb1f3isT+71x3RTOr5uW+fFE/8
 jxl/JTDN2ZJEZIXGk2OcDMOdlSXfSqWxnUiqsaMWZKzOL9yQH3yAg9gINqkdwcQPqDIu Ew==
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
	by mx0a-001b2d01.pphosted.com with ESMTP id 37q595dme0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Apr 2021 23:22:45 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
	by ppma02fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1363DdsY019182;
	Tue, 6 Apr 2021 03:22:41 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by ppma02fra.de.ibm.com with ESMTP id 37q2nm0wyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Apr 2021 03:22:41 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1363McZh32571796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Apr 2021 03:22:38 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9636342049;
	Tue,  6 Apr 2021 03:22:38 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72A7142041;
	Tue,  6 Apr 2021 03:22:35 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.102.0.175])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Tue,  6 Apr 2021 03:22:35 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Tue, 06 Apr 2021 08:52:34 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [PATCH v2] libnvdimm/region: Update nvdimm_has_flush() to handle ND_REGION_ASYNC
Date: Tue,  6 Apr 2021 08:52:33 +0530
Message-Id: <20210406032233.490596-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cto7mFedvnfaAhDn5Y7b-xqJrvBYScoy
X-Proofpoint-ORIG-GUID: cto7mFedvnfaAhDn5Y7b-xqJrvBYScoy
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-05_21:2021-04-01,2021-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 mlxlogscore=960 clxscore=1011
 priorityscore=1501 suspectscore=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104060019
Message-ID-Hash: EWIEQ4R4GRXL47HTHL5PUPRGBLB2437U
X-Message-ID-Hash: EWIEQ4R4GRXL47HTHL5PUPRGBLB2437U
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Shivaprasad G Bhat <sbhat@linux.ibm.com>, stable@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EWIEQ4R4GRXL47HTHL5PUPRGBLB2437U/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In case a platform doesn't provide explicit flush-hints but provides an
explicit flush callback via ND_REGION_ASYNC region flag, then
nvdimm_has_flush() still returns '0' indicating that writes do not
require flushing. This happens on PPC64 with patch at [1] applied,
where 'deep_flush' of a region was denied even though an explicit
flush function was provided.

Similar problem is also seen with virtio-pmem where the 'deep_flush'
sysfs attribute is not visible as in absence of any registered nvdimm,
'nd_region->ndr_mappings == 0'.

Fix this by updating nvdimm_has_flush() adding a condition to
nvdimm_has_flush() testing for ND_REGION_ASYNC flag on the region
and see if a 'region->flush' callback is assigned. Also remove
explicit test for 'nd_region->ndr_mapping' since regions can be marked
'ND_REGION_SYNC' without any explicit mappings as in case of
virtio-pmem.

References:
[1] "powerpc/papr_scm: Implement support for H_SCM_FLUSH hcall"
https://lore.kernel.org/linux-nvdimm/161703936121.36.7260632399	582101498.stgit@e1fbed493c87

Cc: <stable@vger.kernel.org>
Fixes: c5d4355d10d4 ("libnvdimm: nd_region flush callback support")
Reported-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
Changelog:

v2:
* Added the fixes tag and addressed the patch to stable tree [ Aneesh ]
* Updated patch description to address the virtio-pmem case.
* Removed test for 'nd_region->ndr_mappings' from beginning of
  nvdimm_has_flush() to handle the virtio-pmem case.
---
 drivers/nvdimm/region_devs.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index ef23119db574..cdf5eb6fa425 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -1234,11 +1234,15 @@ int nvdimm_has_flush(struct nd_region *nd_region)
 {
 	int i;
 
-	/* no nvdimm or pmem api == flushing capability unknown */
-	if (nd_region->ndr_mappings == 0
-			|| !IS_ENABLED(CONFIG_ARCH_HAS_PMEM_API))
+	/* no pmem api == flushing capability unknown */
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_PMEM_API))
 		return -ENXIO;
 
+	/* Test if an explicit flush function is defined */
+	if (test_bit(ND_REGION_ASYNC, &nd_region->flags) && nd_region->flush)
+		return 1;
+
+	/* Test if any flush hints for the region are available */
 	for (i = 0; i < nd_region->ndr_mappings; i++) {
 		struct nd_mapping *nd_mapping = &nd_region->mapping[i];
 		struct nvdimm *nvdimm = nd_mapping->nvdimm;
@@ -1249,8 +1253,8 @@ int nvdimm_has_flush(struct nd_region *nd_region)
 	}
 
 	/*
-	 * The platform defines dimm devices without hints, assume
-	 * platform persistence mechanism like ADR
+	 * The platform defines dimm devices without hints nor explicit flush,
+	 * assume platform persistence mechanism like ADR
 	 */
 	return 0;
 }
-- 
2.30.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

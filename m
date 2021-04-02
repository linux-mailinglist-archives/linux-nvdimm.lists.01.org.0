Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A4A3528A2
	for <lists+linux-nvdimm@lfdr.de>; Fri,  2 Apr 2021 11:26:17 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C84C9100EBBDA;
	Fri,  2 Apr 2021 02:26:15 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id ABDF5100EBBD7
	for <linux-nvdimm@lists.01.org>; Fri,  2 Apr 2021 02:26:13 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13292bRf100430;
	Fri, 2 Apr 2021 05:26:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=gk5VRd0UP5wkB56A9IIwNXM7D5qVdTdkNCdkJduRJzM=;
 b=mVdZcSyEC6xGBl3m88qqGIGZRCr3maQ0XHSeX68u/leAuu7286+dfacbVBn9s6fUKrAq
 Q7LNSTJwMJ5NdLOs5bOnQ/DkCmw4Y+YjR3SfObPy6i6P6S1fezfLQsXnOx+sdPcVJqpF
 sf53ViMnIqEf7mzXt3JKjBtQQz8bNkqZ3AePYRRWidDmBP48Oec/DTGa6+m3HxTYUj0z
 Bvw/0dyVLK1y9qvVHoFqYfDsM6+eEEn2DJQt57Xakw+K8b5LcwqB3LjXarfhPUR6geiA
 8Zq2wWh/BanaRdb5GgnQywxPMypMIUEcyLXWBuI9dGm1XTu3zCcEC+E9sRJL1gc3cRoe Og==
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 37n9mx9mfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Apr 2021 05:26:07 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1329DAEw014402;
	Fri, 2 Apr 2021 09:26:05 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by ppma04ams.nl.ibm.com with ESMTP id 37n28ts61r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Apr 2021 09:26:05 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1329Q2rH32571878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Apr 2021 09:26:02 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B367E52050;
	Fri,  2 Apr 2021 09:26:02 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.102.3.66])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 932015204E;
	Fri,  2 Apr 2021 09:25:59 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Fri, 02 Apr 2021 14:55:58 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [PATCH] libnvdimm/region: Update nvdimm_has_flush() to handle ND_REGION_ASYNC
Date: Fri,  2 Apr 2021 14:55:55 +0530
Message-Id: <20210402092555.208590-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: q3RCJ023Zyhscs0G4uWEKZjF46bisUm-
X-Proofpoint-ORIG-GUID: q3RCJ023Zyhscs0G4uWEKZjF46bisUm-
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-02_06:2021-04-01,2021-04-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1011 suspectscore=0 bulkscore=0 mlxlogscore=924
 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104020065
Message-ID-Hash: UXXZHGB5R7GQ35DB26WGU6NDWRSNZAHO
X-Message-ID-Hash: UXXZHGB5R7GQ35DB26WGU6NDWRSNZAHO
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V Ira Weiny" <"aneesh.kumar@linux.ibm.comira.weiny"@intel.com>, mpe@ellerman.id.au, Shivaprasad G Bhat <sbhat@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UXXZHGB5R7GQ35DB26WGU6NDWRSNZAHO/>
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

Fix this by adding a condition to nvdimm_has_flush() to test for the
ND_REGION_ASYNC flag on the region and see if a 'region->flush'
callback is assigned.

References:
[1] "powerpc/papr_scm: Implement support for H_SCM_FLUSH hcall"
https://lore.kernel.org/linux-nvdimm/161703936121.36.7260632399	582101498.stgit@e1fbed493c87

Reported-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 drivers/nvdimm/region_devs.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index ef23119db574..e05cc9f8a9fd 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -1239,6 +1239,11 @@ int nvdimm_has_flush(struct nd_region *nd_region)
 			|| !IS_ENABLED(CONFIG_ARCH_HAS_PMEM_API))
 		return -ENXIO;
 
+	/* Test if an explicit flush function is defined */
+	if (test_bit(ND_REGION_ASYNC, &nd_region->flags) && nd_region->flush)
+		return 1;
+
+	/* Test if any flush hints for the region are available */
 	for (i = 0; i < nd_region->ndr_mappings; i++) {
 		struct nd_mapping *nd_mapping = &nd_region->mapping[i];
 		struct nvdimm *nvdimm = nd_mapping->nvdimm;
@@ -1249,8 +1254,8 @@ int nvdimm_has_flush(struct nd_region *nd_region)
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

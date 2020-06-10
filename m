Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C65B1F4E22
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Jun 2020 08:24:49 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 009F7100A092C;
	Tue,  9 Jun 2020 23:24:48 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BD8EA100A302C
	for <linux-nvdimm@lists.01.org>; Tue,  9 Jun 2020 23:24:40 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05A63CIr061317;
	Wed, 10 Jun 2020 02:24:37 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31jbvjpcch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2020 02:24:37 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05A63GWg061868;
	Wed, 10 Jun 2020 02:24:36 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31jbvjpcc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2020 02:24:36 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
	by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05A6LBmI020406;
	Wed, 10 Jun 2020 06:24:35 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
	by ppma01dal.us.ibm.com with ESMTP id 31hygyagkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2020 06:24:35 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
	by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05A6OYYN43581876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2020 06:24:34 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC8D9AC05B;
	Wed, 10 Jun 2020 06:24:34 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB571AC05F;
	Wed, 10 Jun 2020 06:24:31 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.58.158])
	by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2020 06:24:31 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        linux-nvdimm@lists.01.org, dan.j.williams@intel.com
Subject: [PATCH v5 10/10] powerpc/pmem: Initialize pmem device on newer hardware
Date: Wed, 10 Jun 2020 11:53:43 +0530
Message-Id: <20200610062343.492293-11-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610062343.492293-1-aneesh.kumar@linux.ibm.com>
References: <20200610062343.492293-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-10_02:2020-06-10,2020-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 impostorscore=0
 cotscore=-2147483648 suspectscore=0 mlxscore=0 clxscore=1015 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006100046
Message-ID-Hash: SLEIYIHERRFVFQCYJB5HNKXX2776ALMP
X-Message-ID-Hash: SLEIYIHERRFVFQCYJB5HNKXX2776ALMP
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, msuchanek@suse.de, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SLEIYIHERRFVFQCYJB5HNKXX2776ALMP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

With kernel now supporting new pmem flush/sync instructions, we can now
enable the kernel to initialize the device. On P10 these devices would
appear with a new compatible string. For PAPR device we have

compatible       "ibm,pmemory-v2"

and for OF pmem device we have

compatible       "pmem-region-v2"

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/papr_scm.c | 1 +
 drivers/nvdimm/of_pmem.c                  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index b970d2dbe589..3efd827fe0ac 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -498,6 +498,7 @@ static int papr_scm_remove(struct platform_device *pdev)
 
 static const struct of_device_id papr_scm_match[] = {
 	{ .compatible = "ibm,pmemory" },
+	{ .compatible = "ibm,pmemory-v2" },
 	{ },
 };
 
diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
index a6cc3488e552..1e1585ab07c7 100644
--- a/drivers/nvdimm/of_pmem.c
+++ b/drivers/nvdimm/of_pmem.c
@@ -97,6 +97,7 @@ static int of_pmem_region_remove(struct platform_device *pdev)
 
 static const struct of_device_id of_pmem_region_match[] = {
 	{ .compatible = "pmem-region" },
+	{ .compatible = "pmem-region-v2" },
 	{ },
 };
 
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

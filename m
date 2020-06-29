Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B04E320CEF9
	for <lists+linux-nvdimm@lfdr.de>; Mon, 29 Jun 2020 15:58:19 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 67B4E111C7C4E;
	Mon, 29 Jun 2020 06:58:18 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DBDA4111C7C4D
	for <linux-nvdimm@lists.01.org>; Mon, 29 Jun 2020 06:58:16 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05TDY0xl086840;
	Mon, 29 Jun 2020 09:58:13 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31ydk91576-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2020 09:58:13 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05TDY6hq087443;
	Mon, 29 Jun 2020 09:58:13 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31ydk9156k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2020 09:58:12 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
	by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05TDtrHK013896;
	Mon, 29 Jun 2020 13:58:12 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
	by ppma04dal.us.ibm.com with ESMTP id 31wwr8kn1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2020 13:58:11 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
	by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05TDwBg525297228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jun 2020 13:58:11 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32E7AAE05F;
	Mon, 29 Jun 2020 13:58:11 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A52DFAE060;
	Mon, 29 Jun 2020 13:58:07 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.77.197.62])
	by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
	Mon, 29 Jun 2020 13:58:07 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        linux-nvdimm@lists.01.org, dan.j.williams@intel.com
Subject: [PATCH v6 8/8] powerpc/pmem: Initialize pmem device on newer hardware
Date: Mon, 29 Jun 2020 19:27:22 +0530
Message-Id: <20200629135722.73558-9-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200629135722.73558-1-aneesh.kumar@linux.ibm.com>
References: <20200629135722.73558-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-29_11:2020-06-29,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 cotscore=-2147483648
 impostorscore=0 spamscore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006290091
Message-ID-Hash: IU6ZONWQZONAZ2SWOWUNIJYQJDKU7AKZ
X-Message-ID-Hash: IU6ZONWQZONAZ2SWOWUNIJYQJDKU7AKZ
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, msuchanek@suse.de, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IU6ZONWQZONAZ2SWOWUNIJYQJDKU7AKZ/>
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
index 9a9a0766f8b6..617dfa4d7ec1 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -889,6 +889,7 @@ static int papr_scm_remove(struct platform_device *pdev)
 
 static const struct of_device_id papr_scm_match[] = {
 	{ .compatible = "ibm,pmemory" },
+	{ .compatible = "ibm,pmemory-v2" },
 	{ },
 };
 
diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
index 6826a274a1f1..10dbdcdfb9ce 100644
--- a/drivers/nvdimm/of_pmem.c
+++ b/drivers/nvdimm/of_pmem.c
@@ -90,6 +90,7 @@ static int of_pmem_region_remove(struct platform_device *pdev)
 
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

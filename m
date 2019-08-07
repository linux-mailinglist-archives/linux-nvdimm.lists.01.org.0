Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 557AA84315
	for <lists+linux-nvdimm@lfdr.de>; Wed,  7 Aug 2019 06:00:52 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 52B8B212FE8BD;
	Tue,  6 Aug 2019 21:03:20 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id AEBE6212FD41E
 for <linux-nvdimm@lists.01.org>; Tue,  6 Aug 2019 21:03:18 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x773udT9065564
 for <linux-nvdimm@lists.01.org>; Wed, 7 Aug 2019 00:00:47 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2u7nu72b2b-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvdimm@lists.01.org>; Wed, 07 Aug 2019 00:00:46 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-nvdimm@lists.01.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 7 Aug 2019 05:00:46 +0100
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
 by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 7 Aug 2019 05:00:42 +0100
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7740fQ654984992
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Aug 2019 04:00:41 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 87DFABE056;
 Wed,  7 Aug 2019 04:00:41 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7CB20BE054;
 Wed,  7 Aug 2019 04:00:39 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.35.167])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed,  7 Aug 2019 04:00:39 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com
Subject: [PATCH] nvdimm/of_pmem: Provide a unique name for bus provider
Date: Wed,  7 Aug 2019 09:30:29 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19080704-0004-0000-0000-000015330282
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011563; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01243196; UDB=6.00655799; IPR=6.01024666; 
 MB=3.00028075; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-07 04:00:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080704-0005-0000-0000-00008CC80DDE
Message-Id: <20190807040029.11344-1-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-07_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908070039
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

ndctl utility requires the ndbus to have unique names. If not while
enumerating the bus in userspace it drops bus with similar names.
This results in us not listing devices beneath the bus.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 drivers/nvdimm/of_pmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
index a0c8dcfa0bf9..97187d6c0bdb 100644
--- a/drivers/nvdimm/of_pmem.c
+++ b/drivers/nvdimm/of_pmem.c
@@ -42,7 +42,7 @@ static int of_pmem_region_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv->bus_desc.attr_groups = bus_attr_groups;
-	priv->bus_desc.provider_name = "of_pmem";
+	priv->bus_desc.provider_name = kstrdup(pdev->name, GFP_KERNEL);
 	priv->bus_desc.module = THIS_MODULE;
 	priv->bus_desc.of_node = np;
 
-- 
2.21.0

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

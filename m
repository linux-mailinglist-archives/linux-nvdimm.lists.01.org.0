Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CF187366
	for <lists+linux-nvdimm@lfdr.de>; Fri,  9 Aug 2019 09:48:27 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 332982130C4A8;
	Fri,  9 Aug 2019 00:50:56 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 36DE121309D34
 for <linux-nvdimm@lists.01.org>; Fri,  9 Aug 2019 00:50:55 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x797i23V070656
 for <linux-nvdimm@lists.01.org>; Fri, 9 Aug 2019 03:48:24 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2u92yhc2h6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvdimm@lists.01.org>; Fri, 09 Aug 2019 03:48:24 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-nvdimm@lists.01.org> from <aneesh.kumar@linux.ibm.com>;
 Fri, 9 Aug 2019 08:48:23 +0100
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
 by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 9 Aug 2019 08:48:22 +0100
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x797mKgD58524044
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 Aug 2019 07:48:20 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9AD197805F;
 Fri,  9 Aug 2019 07:48:20 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F10878066;
 Fri,  9 Aug 2019 07:48:19 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.36.73])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri,  9 Aug 2019 07:48:18 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com
Subject: [PATCH v5] mm/nvdimm: Use correct alignment when looking at first pfn
 from a region
Date: Fri,  9 Aug 2019 13:18:08 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19080907-0004-0000-0000-00001533952C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011574; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01244216; UDB=6.00656414; IPR=6.01025699; 
 MB=3.00028102; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-09 07:48:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080907-0005-0000-0000-00008CCF1A9E
Message-Id: <20190809074808.28063-1-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-09_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=816 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908090080
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

vmem_altmap_offset() adjust the section aligned base_pfn offset.
So we need to make sure we account for the same when computing base_pfn.

ie, for altmap_valid case, our pfn_first should be:

pfn_first = altmap->base_pfn + vmem_altmap_offset(altmap);

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
Changes from v4:
* rebase to latest kernel

 mm/memremap.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/mm/memremap.c b/mm/memremap.c
index 6ee03a816d67..6b8cd10e5e35 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -54,8 +54,16 @@ static void pgmap_array_delete(struct resource *res)
 
 static unsigned long pfn_first(struct dev_pagemap *pgmap)
 {
-	return PHYS_PFN(pgmap->res.start) +
-		vmem_altmap_offset(pgmap_altmap(pgmap));
+	const struct resource *res = &pgmap->res;
+	struct vmem_altmap *altmap = pgmap_altmap(pgmap);
+	unsigned long pfn;
+
+	if (altmap) {
+		pfn = altmap->base_pfn + vmem_altmap_offset(altmap);
+	} else
+		pfn = PHYS_PFN(res->start);
+
+	return pfn;
 }
 
 static unsigned long pfn_end(struct dev_pagemap *pgmap)
-- 
2.21.0

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

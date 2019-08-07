Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1586384370
	for <lists+linux-nvdimm@lfdr.de>; Wed,  7 Aug 2019 06:44:33 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C634721303081;
	Tue,  6 Aug 2019 21:47:01 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id EF2A2212FE8AC
 for <linux-nvdimm@lists.01.org>; Tue,  6 Aug 2019 21:47:00 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x774bEPt029826; Wed, 7 Aug 2019 00:44:29 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2u7qhv0ky8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Aug 2019 00:44:28 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x774dr5K026980;
 Wed, 7 Aug 2019 04:44:28 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma02dal.us.ibm.com with ESMTP id 2u51w64385-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Aug 2019 04:44:28 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x774iQ4T36504062
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Aug 2019 04:44:26 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 418D8124054;
 Wed,  7 Aug 2019 04:44:26 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 05EB5124053;
 Wed,  7 Aug 2019 04:44:25 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.35.167])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed,  7 Aug 2019 04:44:24 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com
Subject: [PATCH] ndctl: Use the same align value as original namespace on
 reconfigure
Date: Wed,  7 Aug 2019 10:14:16 +0530
Message-Id: <20190807044416.30799-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-07_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908070048
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

When using reconfigure command to add a `name` to the namespace we end
up updating the align attribute. Avoid this by using the value from
the original namespace. Do this only if we are keeping the namespace mode
same.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 ndctl/namespace.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index 1f212a2b3a9b..24e51bb35ae1 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -596,6 +596,22 @@ static int validate_namespace_options(struct ndctl_region *region,
 			return -ENXIO;
 		}
 	} else {
+
+		/*
+		 * If we are tryint to reconfigure with the same namespace mode
+		 * Use the align details from the origin namespace. Otherwise
+		 * pick the align details from seed namespace
+		 */
+		if (ndns && p->mode == ndctl_namespace_get_mode(ndns)) {
+			struct ndctl_pfn *ns_pfn = ndctl_namespace_get_pfn(ndns);
+			struct ndctl_dax *ns_dax = ndctl_namespace_get_dax(ndns);
+			if (ns_pfn)
+				p->align = ndctl_pfn_get_align(ns_pfn);
+			else if (ns_dax)
+				p->align = ndctl_dax_get_align(ns_dax);
+			else
+				p->align = sysconf(_SC_PAGE_SIZE);
+		} else
 		/*
 		 * Use the seed namespace alignment as the default if we need
 		 * one. If we don't then use PAGE_SIZE so the size_align
-- 
2.21.0

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

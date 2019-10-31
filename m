Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3A9EAE03
	for <lists+linux-nvdimm@lfdr.de>; Thu, 31 Oct 2019 11:57:59 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5C011100DC406;
	Thu, 31 Oct 2019 03:58:26 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D9F8D100DC404
	for <linux-nvdimm@lists.01.org>; Thu, 31 Oct 2019 03:58:23 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9VAv6TV002257;
	Thu, 31 Oct 2019 06:57:51 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2vyvwqk6v7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2019 06:57:50 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
	by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9VAsbTd015961;
	Thu, 31 Oct 2019 10:57:50 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
	by ppma03wdc.us.ibm.com with ESMTP id 2vxwh5efty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2019 10:57:50 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
	by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9VAvmrc47055120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Oct 2019 10:57:48 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FB457805F;
	Thu, 31 Oct 2019 10:57:48 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 233887805E;
	Thu, 31 Oct 2019 10:57:47 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.39.184])
	by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
	Thu, 31 Oct 2019 10:57:46 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com
Subject: [PATCH v4 1/2] libnvdimm/pfn_dev: Don't clear device memmap area during generic namespace probe
Date: Thu, 31 Oct 2019 16:27:40 +0530
Message-Id: <20191031105741.102793-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-31_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910310112
Message-ID-Hash: 2HWOXDHUJYFJRR3LORMNAO62WSC7AK3F
X-Message-ID-Hash: 2HWOXDHUJYFJRR3LORMNAO62WSC7AK3F
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2HWOXDHUJYFJRR3LORMNAO62WSC7AK3F/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

nvdimm core use nd_pfn_validate when looking for devdax or fsdax namespace. In this
case device resources are allocated against nd_namespace_io dev. In-order to
allow remap of range in nd_pfn_clear_memmap_error(), move the device memmap
area clearing while initializing pfn namespace. With this device
resource are allocated against nd_pfn and we can use nd_pfn->dev for remapping.

This also avoids calling nd_pfn_clear_mmap_errors twice. Once while probing the
namespace and second while initialzing a pfn namespace.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 drivers/nvdimm/pfn_devs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index 60d81fae06ee..fc2cd412861a 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -591,7 +591,7 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
 		return -ENXIO;
 	}
 
-	return nd_pfn_clear_memmap_errors(nd_pfn);
+	return 0;
 }
 EXPORT_SYMBOL(nd_pfn_validate);
 
@@ -730,7 +730,8 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
 
 	rc = nd_pfn_validate(nd_pfn, sig);
 	if (rc != -ENODEV)
-		return rc;
+		/* Clear the memap range of errors */
+		return nd_pfn_clear_memmap_errors(nd_pfn);
 
 	/* no info block, do init */;
 	memset(pfn_sb, 0, sizeof(*pfn_sb));
-- 
2.23.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

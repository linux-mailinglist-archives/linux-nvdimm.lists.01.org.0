Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6518BEBC5B
	for <lists+linux-nvdimm@lfdr.de>; Fri,  1 Nov 2019 04:27:42 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3FFC2100DC410;
	Thu, 31 Oct 2019 20:28:04 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EBDC0100DC40F
	for <linux-nvdimm@lists.01.org>; Thu, 31 Oct 2019 20:28:01 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA13Gogt047193;
	Thu, 31 Oct 2019 23:27:35 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2w0c9u0uh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2019 23:27:35 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
	by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xA13CD5L027408;
	Fri, 1 Nov 2019 03:27:38 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
	by ppma01wdc.us.ibm.com with ESMTP id 2vxwh5vve9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2019 03:27:38 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
	by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA13RXE144892428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Nov 2019 03:27:34 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2DFCAC05B;
	Fri,  1 Nov 2019 03:27:33 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1905BAC059;
	Fri,  1 Nov 2019 03:27:32 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.34.169])
	by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
	Fri,  1 Nov 2019 03:27:31 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com
Subject: [PATCH v5] libnvdimm/pfn_dev: Don't clear device memmap area during generic namespace probe
Date: Fri,  1 Nov 2019 08:57:28 +0530
Message-Id: <20191101032728.113001-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-31_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911010031
Message-ID-Hash: HQS54BCHMMMKHYYJU6CONVMRLEIV7PLO
X-Message-ID-Hash: HQS54BCHMMMKHYYJU6CONVMRLEIV7PLO
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HQS54BCHMMMKHYYJU6CONVMRLEIV7PLO/>
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
namespace and second while initializing a pfn namespace.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
Changes from v4:
* Make code changes suggested by Dan

 drivers/nvdimm/pfn_devs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index 60d81fae06ee..96727fd493f7 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -591,7 +591,7 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
 		return -ENXIO;
 	}
 
-	return nd_pfn_clear_memmap_errors(nd_pfn);
+	return 0;
 }
 EXPORT_SYMBOL(nd_pfn_validate);
 
@@ -729,6 +729,8 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
 		sig = PFN_SIG;
 
 	rc = nd_pfn_validate(nd_pfn, sig);
+	if (rc == 0)
+		return nd_pfn_clear_memmap_errors(nd_pfn);
 	if (rc != -ENODEV)
 		return rc;
 
@@ -796,6 +798,10 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
 	checksum = nd_sb_checksum((struct nd_gen_sb *) pfn_sb);
 	pfn_sb->checksum = cpu_to_le64(checksum);
 
+	rc = nd_pfn_clear_memmap_errors(nd_pfn);
+	if (rc)
+		return rc;
+
 	return nvdimm_write_bytes(ndns, SZ_4K, pfn_sb, sizeof(*pfn_sb), 0);
 }
 
-- 
2.23.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

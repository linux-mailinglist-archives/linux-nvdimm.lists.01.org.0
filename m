Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163DC142C5C
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Jan 2020 14:41:31 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6A73210097E08;
	Mon, 20 Jan 2020 05:44:47 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D90F310097DFB
	for <linux-nvdimm@lists.01.org>; Mon, 20 Jan 2020 05:44:44 -0800 (PST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00KDcqCM033717;
	Mon, 20 Jan 2020 08:41:25 -0500
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2xmg5s9ne9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2020 08:41:25 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00KDcu8x034309;
	Mon, 20 Jan 2020 08:41:25 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2xmg5s9ndj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2020 08:41:25 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
	by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00KDeYC8001923;
	Mon, 20 Jan 2020 13:41:23 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
	by ppma02wdc.us.ibm.com with ESMTP id 2xksn630wj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2020 13:41:23 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
	by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00KDfNIW51446056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2020 13:41:23 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F7F6124053;
	Mon, 20 Jan 2020 13:41:23 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58BB9124058;
	Mon, 20 Jan 2020 13:41:21 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.85.71.225])
	by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jan 2020 13:41:21 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com, vishal.l.verma@intel.com, jmoyer@redhat.com
Subject: [PATCH 1/2] test/libndctl: Update namespace size to take care of interleaved DIMMs
Date: Mon, 20 Jan 2020 19:11:11 +0530
Message-Id: <20200120134112.62945-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_02:2020-01-20,2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001200118
Message-ID-Hash: GX4JG6IM5E3DVFGS3HXHE5HCA74BQNYJ
X-Message-ID-Hash: GX4JG6IM5E3DVFGS3HXHE5HCA74BQNYJ
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GX4JG6IM5E3DVFGS3HXHE5HCA74BQNYJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The minimum size of a namespace should be SUB_SECTION_SIZE * interleaved DIMM
count. Update the test to use the correct size. Also, adjust the available size
of blk namespace using the same interleaved DIMMs to account for the new pmem
namespace size.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 test/libndctl.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/test/libndctl.c b/test/libndctl.c
index 02bb9ccaa465..adad66f8a34e 100644
--- a/test/libndctl.c
+++ b/test/libndctl.c
@@ -254,8 +254,9 @@ static unsigned long blk_sector_sizes[] = { 512, 520, 528, 4096, 4104, 4160, 422
 static unsigned long pmem_sector_sizes[] = { 512, 4096 };
 static unsigned long io_sector_sizes[] = { 0 };
 
+/* region 0 consist of two interleaved dimms*/
 static struct namespace namespace0_pmem0 = {
-	0, "namespace_pmem", &btt_settings, &pfn_settings, &dax_settings, SZ_18M,
+	0, "namespace_pmem", &btt_settings, &pfn_settings, &dax_settings, SZ_16M,
 	{ 1, 1, 1, 1,
 	  1, 1, 1, 1,
 	  1, 1, 1, 1,
@@ -263,8 +264,9 @@ static struct namespace namespace0_pmem0 = {
 	ARRAY_SIZE(pmem_sector_sizes), pmem_sector_sizes,
 };
 
+/* region 1 consist of 4 interleaved dimms*/
 static struct namespace namespace1_pmem0 = {
-	0, "namespace_pmem", &btt_settings, &pfn_settings, &dax_settings, SZ_20M,
+	0, "namespace_pmem", &btt_settings, &pfn_settings, &dax_settings, SZ_16M,
 	{ 2, 2, 2, 2,
 	  2, 2, 2, 2,
 	  2, 2, 2, 2,
@@ -349,7 +351,7 @@ static struct region regions0[] = {
 			[0] = &default_pfn,
 		},
 	},
-	{ { DIMM_HANDLE(0, 0, 0, 0, 0) }, 1, 1, "blk", SZ_18M, SZ_32M,
+	{ { DIMM_HANDLE(0, 0, 0, 0, 0) }, 1, 1, "blk", SZ_20M, SZ_32M,
 		.namespaces = {
 			[0] = &namespace2_blk0,
 			[1] = &namespace2_blk1,
@@ -358,7 +360,7 @@ static struct region regions0[] = {
 			[0] = &default_btt,
 		},
 	},
-	{ { DIMM_HANDLE(0, 0, 0, 0, 1) }, 1, 1, "blk", SZ_18M, SZ_32M,
+	{ { DIMM_HANDLE(0, 0, 0, 0, 1) }, 1, 1, "blk", SZ_20M, SZ_32M,
 		.namespaces = {
 			[0] = &namespace3_blk0,
 			[1] = &namespace3_blk1,
@@ -367,7 +369,7 @@ static struct region regions0[] = {
 			[0] = &default_btt,
 		},
 	},
-	{ { DIMM_HANDLE(0, 0, 1, 0, 0) }, 1, 1, "blk", SZ_27M, SZ_32M,
+	{ { DIMM_HANDLE(0, 0, 1, 0, 0) }, 1, 1, "blk", SZ_28M, SZ_32M,
 		.namespaces = {
 			[0] = &namespace4_blk0,
 		},
@@ -375,7 +377,7 @@ static struct region regions0[] = {
 			[0] = &default_btt,
 		},
 	},
-	{ { DIMM_HANDLE(0, 0, 1, 0, 1) }, 1, 1, "blk", SZ_27M, SZ_32M,
+	{ { DIMM_HANDLE(0, 0, 1, 0, 1) }, 1, 1, "blk", SZ_28M, SZ_32M,
 		.namespaces = {
 			[0] = &namespace5_blk0,
 		},
@@ -992,8 +994,8 @@ static int check_btt_size(struct ndctl_btt *btt)
 	int size_select, sect_select;
 	unsigned long long expect_table[][2] = {
 		[0] = {
-			[0] = 0x11b5400,
-			[1] = 0x8daa000,
+			[0] = 0xfb9400,
+			[1] = 0x7dca000,
 		},
 		[1] = {
 			[0] = 0x13b1400,
@@ -1017,7 +1019,7 @@ static int check_btt_size(struct ndctl_btt *btt)
 	}
 
 	switch (ns_size) {
-	case SZ_18M:
+	case SZ_16M:
 		size_select = 0;
 		break;
 	case SZ_20M:
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

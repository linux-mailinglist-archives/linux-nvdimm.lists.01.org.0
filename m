Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A37142C5D
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Jan 2020 14:41:36 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7D37810097DA8;
	Mon, 20 Jan 2020 05:44:53 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6598210097DA6
	for <linux-nvdimm@lists.01.org>; Mon, 20 Jan 2020 05:44:51 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00KDejqj043727;
	Mon, 20 Jan 2020 08:41:30 -0500
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2xmgh9syh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2020 08:41:30 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00KDew6s045190;
	Mon, 20 Jan 2020 08:41:30 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2xmgh9sygq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2020 08:41:30 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
	by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00KDe5V3000551;
	Mon, 20 Jan 2020 13:41:29 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
	by ppma04dal.us.ibm.com with ESMTP id 2xksn6fs3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2020 13:41:29 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
	by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00KDfShm51708316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2020 13:41:28 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B429712405C;
	Mon, 20 Jan 2020 13:41:28 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BB61124052;
	Mon, 20 Jan 2020 13:41:26 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.85.71.225])
	by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jan 2020 13:41:26 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com, vishal.l.verma@intel.com, jmoyer@redhat.com
Subject: [PATCH 2/2] test/dsm-fail: Update namespace size to take care of interleaved DIMMs
Date: Mon, 20 Jan 2020 19:11:12 +0530
Message-Id: <20200120134112.62945-2-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200120134112.62945-1-aneesh.kumar@linux.ibm.com>
References: <20200120134112.62945-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_02:2020-01-20,2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 mlxlogscore=999 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001200118
Message-ID-Hash: 22ONJ3TZWYXGFVUS6TYAICSRGZHX2NRM
X-Message-ID-Hash: 22ONJ3TZWYXGFVUS6TYAICSRGZHX2NRM
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/22ONJ3TZWYXGFVUS6TYAICSRGZHX2NRM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The minimum size of a namespace should be SUB_SECTION_SIZE * interleaved DIMM
count. Update the test to use the correct size.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 test/dsm-fail.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/test/dsm-fail.c b/test/dsm-fail.c
index 6e812aec008f..1bc15514e43c 100644
--- a/test/dsm-fail.c
+++ b/test/dsm-fail.c
@@ -228,11 +228,15 @@ static int do_test(struct ndctl_ctx *ctx, struct ndctl_test *test)
 	ndctl_region_foreach(bus, region) {
 		if (ndctl_region_get_type(region) != ND_DEVICE_REGION_PMEM)
 			continue;
+		/*
+		 * We have max 4 interleaved dimms in region1.
+		 * Hence size needs to be 8M
+		 */
 		ndctl_dimm_foreach_in_region(region, dimm) {
 			const char *argv[] = {
 				"__func__", "-v", "-r",
 				ndctl_region_get_devname(region),
-				"-s", "4M", "-m", "raw",
+				"-s", "8M", "-m", "raw",
 			};
 			struct ndctl_namespace *ndns;
 			int count, i;
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

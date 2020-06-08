Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 856711F2156
	for <lists+linux-nvdimm@lfdr.de>; Mon,  8 Jun 2020 23:12:21 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9C6D2100AA7B6;
	Mon,  8 Jun 2020 14:12:20 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 10B0310117609
	for <linux-nvdimm@lists.01.org>; Mon,  8 Jun 2020 14:12:17 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058L3WNX143615;
	Mon, 8 Jun 2020 17:11:43 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31g74tkhvr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2020 17:11:43 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 058L41Ux145977;
	Mon, 8 Jun 2020 17:11:42 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31g74tkhv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2020 17:11:42 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
	by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 058LA6Zd025387;
	Mon, 8 Jun 2020 21:11:40 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by ppma04fra.de.ibm.com with ESMTP id 31g2s7svyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2020 21:11:40 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 058LBb2j8651018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2020 21:11:37 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B17B52054;
	Mon,  8 Jun 2020 21:11:37 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.74.153])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id A64A352050;
	Mon,  8 Jun 2020 21:11:32 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Tue, 09 Jun 2020 02:41:31 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v12 1/6] powerpc: Document details on H_SCM_HEALTH hcall
Date: Tue,  9 Jun 2020 02:40:21 +0530
Message-Id: <20200608211026.67573-2-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200608211026.67573-1-vaibhav@linux.ibm.com>
References: <20200608211026.67573-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_17:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 cotscore=-2147483648 adultscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006080144
Message-ID-Hash: MAYTV5POGMOITZ5HAGOC3PXKQR2GBCYD
X-Message-ID-Hash: MAYTV5POGMOITZ5HAGOC3PXKQR2GBCYD
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MAYTV5POGMOITZ5HAGOC3PXKQR2GBCYD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add documentation to 'papr_hcalls.rst' describing the bitmap flags
that are returned from H_SCM_HEALTH hcall as per the PAPR-SCM
specification.

Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ira Weiny <ira.weiny@intel.com>
Acked-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
Changelog:

v11..v12:
* None

v10..v11:
* None

v9..v10:
* Added ack from Ira.

Resend:
* None

v8..v9:
* s/SCM/PMEM device. [ Dan Williams, Aneesh ]

v7..v8:
* Added a clarification on bit-ordering of Health Bitmap

Resend:
* None

v6..v7:
* None

v5..v6:
* New patch in the series
---
 Documentation/powerpc/papr_hcalls.rst | 46 ++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/Documentation/powerpc/papr_hcalls.rst b/Documentation/powerpc/papr_hcalls.rst
index 3493631a60f8..48fcf1255a33 100644
--- a/Documentation/powerpc/papr_hcalls.rst
+++ b/Documentation/powerpc/papr_hcalls.rst
@@ -220,13 +220,51 @@ from the LPAR memory.
 **H_SCM_HEALTH**
 
 | Input: drcIndex
-| Out: *health-bitmap, health-bit-valid-bitmap*
+| Out: *health-bitmap (r4), health-bit-valid-bitmap (r5)*
 | Return Value: *H_Success, H_Parameter, H_Hardware*
 
 Given a DRC Index return the info on predictive failure and overall health of
-the NVDIMM. The asserted bits in the health-bitmap indicate a single predictive
-failure and health-bit-valid-bitmap indicate which bits in health-bitmap are
-valid.
+the PMEM device. The asserted bits in the health-bitmap indicate one or more states
+(described in table below) of the PMEM device and health-bit-valid-bitmap indicate
+which bits in health-bitmap are valid. The bits are reported in
+reverse bit ordering for example a value of 0xC400000000000000
+indicates bits 0, 1, and 5 are valid.
+
+Health Bitmap Flags:
+
++------+-----------------------------------------------------------------------+
+|  Bit |               Definition                                              |
++======+=======================================================================+
+|  00  | PMEM device is unable to persist memory contents.                     |
+|      | If the system is powered down, nothing will be saved.                 |
++------+-----------------------------------------------------------------------+
+|  01  | PMEM device failed to persist memory contents. Either contents were   |
+|      | not saved successfully on power down or were not restored properly on |
+|      | power up.                                                             |
++------+-----------------------------------------------------------------------+
+|  02  | PMEM device contents are persisted from previous IPL. The data from   |
+|      | the last boot were successfully restored.                             |
++------+-----------------------------------------------------------------------+
+|  03  | PMEM device contents are not persisted from previous IPL. There was no|
+|      | data to restore from the last boot.                                   |
++------+-----------------------------------------------------------------------+
+|  04  | PMEM device memory life remaining is critically low                   |
++------+-----------------------------------------------------------------------+
+|  05  | PMEM device will be garded off next IPL due to failure                |
++------+-----------------------------------------------------------------------+
+|  06  | PMEM device contents cannot persist due to current platform health    |
+|      | status. A hardware failure may prevent data from being saved or       |
+|      | restored.                                                             |
++------+-----------------------------------------------------------------------+
+|  07  | PMEM device is unable to persist memory contents in certain conditions|
++------+-----------------------------------------------------------------------+
+|  08  | PMEM device is encrypted                                              |
++------+-----------------------------------------------------------------------+
+|  09  | PMEM device has successfully completed a requested erase or secure    |
+|      | erase procedure.                                                      |
++------+-----------------------------------------------------------------------+
+|10:63 | Reserved / Unused                                                     |
++------+-----------------------------------------------------------------------+
 
 **H_SCM_PERFORMANCE_STATS**
 
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

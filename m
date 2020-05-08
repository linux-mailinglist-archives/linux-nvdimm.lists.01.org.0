Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C341CA88F
	for <lists+linux-nvdimm@lfdr.de>; Fri,  8 May 2020 12:50:16 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8B5E711847EC0;
	Fri,  8 May 2020 03:48:10 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9214F11847EBB
	for <linux-nvdimm@lists.01.org>; Fri,  8 May 2020 03:48:08 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 048AWsZl137433;
	Fri, 8 May 2020 06:49:39 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 30vtsxgptt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2020 06:49:39 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 048AncFL176732;
	Fri, 8 May 2020 06:49:38 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 30vtsxgpt3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2020 06:49:38 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 048Ajbsb020608;
	Fri, 8 May 2020 10:49:36 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by ppma03ams.nl.ibm.com with ESMTP id 30s0g5w8nx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2020 10:49:35 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 048AnXc711796930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 May 2020 10:49:33 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 491F542049;
	Fri,  8 May 2020 10:49:33 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E67FA42045;
	Fri,  8 May 2020 10:49:29 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.93.12])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Fri,  8 May 2020 10:49:29 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Fri, 08 May 2020 16:19:28 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/5] powerpc: Document details on H_SCM_HEALTH hcall
Date: Fri,  8 May 2020 16:19:18 +0530
Message-Id: <20200508104922.72565-2-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508104922.72565-1-vaibhav@linux.ibm.com>
References: <20200508104922.72565-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-08_08:2020-05-07,2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 phishscore=0 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005080091
Message-ID-Hash: APRYCNWLBLRUWRMW52KHSWGG6Y5KEG6V
X-Message-ID-Hash: APRYCNWLBLRUWRMW52KHSWGG6Y5KEG6V
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/APRYCNWLBLRUWRMW52KHSWGG6Y5KEG6V/>
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

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
Changelog:

v6..v7:
* None

v5..v6
* New patch in the series
---
 Documentation/powerpc/papr_hcalls.rst | 43 ++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/Documentation/powerpc/papr_hcalls.rst b/Documentation/powerpc/papr_hcalls.rst
index 3493631a60f8..9a5ba5eaf323 100644
--- a/Documentation/powerpc/papr_hcalls.rst
+++ b/Documentation/powerpc/papr_hcalls.rst
@@ -220,13 +220,48 @@ from the LPAR memory.
 **H_SCM_HEALTH**
 
 | Input: drcIndex
-| Out: *health-bitmap, health-bit-valid-bitmap*
+| Out: *health-bitmap (r4), health-bit-valid-bitmap (r5)*
 | Return Value: *H_Success, H_Parameter, H_Hardware*
 
 Given a DRC Index return the info on predictive failure and overall health of
-the NVDIMM. The asserted bits in the health-bitmap indicate a single predictive
-failure and health-bit-valid-bitmap indicate which bits in health-bitmap are
-valid.
+the NVDIMM. The asserted bits in the health-bitmap indicate one or more states
+(described in table below) of the NVDIMM and health-bit-valid-bitmap indicate
+which bits in health-bitmap are valid.
+
+Health Bitmap Flags:
+
++------+-----------------------------------------------------------------------+
+|  Bit |               Definition                                              |
++======+=======================================================================+
+|  00  | SCM device is unable to persist memory contents.                      |
+|      | If the system is powered down, nothing will be saved.                 |
++------+-----------------------------------------------------------------------+
+|  01  | SCM device failed to persist memory contents. Either contents were not|
+|      | saved successfully on power down or were not restored properly on     |
+|      | power up.                                                             |
++------+-----------------------------------------------------------------------+
+|  02  | SCM device contents are persisted from previous IPL. The data from    |
+|      | the last boot were successfully restored.                             |
++------+-----------------------------------------------------------------------+
+|  03  | SCM device contents are not persisted from previous IPL. There was no |
+|      | data to restore from the last boot.                                   |
++------+-----------------------------------------------------------------------+
+|  04  | SCM device memory life remaining is critically low                    |
++------+-----------------------------------------------------------------------+
+|  05  | SCM device will be garded off next IPL due to failure                 |
++------+-----------------------------------------------------------------------+
+|  06  | SCM contents cannot persist due to current platform health status. A  |
+|      | hardware failure may prevent data from being saved or restored.       |
++------+-----------------------------------------------------------------------+
+|  07  | SCM device is unable to persist memory contents in certain conditions |
++------+-----------------------------------------------------------------------+
+|  08  | SCM device is encrypted                                               |
++------+-----------------------------------------------------------------------+
+|  09  | SCM device has successfully completed a requested erase or secure     |
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

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F751DA041
	for <lists+linux-nvdimm@lfdr.de>; Tue, 19 May 2020 21:01:54 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E49CC11E48A29;
	Tue, 19 May 2020 11:58:33 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9481D11E48A27
	for <linux-nvdimm@lists.01.org>; Tue, 19 May 2020 11:58:32 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04JIXUXq142820;
	Tue, 19 May 2020 15:01:17 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 312bg7kgcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2020 15:01:17 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04JIXVk5142941;
	Tue, 19 May 2020 15:01:17 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 312bg7kgbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2020 15:01:16 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04JJ0aoT004655;
	Tue, 19 May 2020 19:01:13 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
	by ppma04ams.nl.ibm.com with ESMTP id 313xehj6bs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2020 19:01:13 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04JJ1AxA65012106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2020 19:01:10 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8232A11C050;
	Tue, 19 May 2020 19:01:10 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37E3C11C04A;
	Tue, 19 May 2020 19:01:07 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.89.230])
	by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Tue, 19 May 2020 19:01:07 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Wed, 20 May 2020 00:31:06 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v7 1/5] powerpc: Document details on H_SCM_HEALTH hcall
Date: Wed, 20 May 2020 00:30:54 +0530
Message-Id: <20200519190058.257981-2-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519190058.257981-1-vaibhav@linux.ibm.com>
References: <20200519190058.257981-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-19_07:2020-05-19,2020-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 cotscore=-2147483648 malwarescore=0
 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005190157
Message-ID-Hash: ERGT2KW5Y4HYSWWJAANTPMQD7SRBA4Z4
X-Message-ID-Hash: ERGT2KW5Y4HYSWWJAANTPMQD7SRBA4Z4
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ERGT2KW5Y4HYSWWJAANTPMQD7SRBA4Z4/>
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

Resend:
* None

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

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C671D75FC
	for <lists+linux-nvdimm@lfdr.de>; Mon, 18 May 2020 13:08:41 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CB8B711E16CF4;
	Mon, 18 May 2020 04:05:29 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id ECD6E11E16CF2
	for <linux-nvdimm@lists.01.org>; Mon, 18 May 2020 04:05:26 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04IB4tCA060074;
	Mon, 18 May 2020 07:08:29 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 312c21xram-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2020 07:08:28 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04IB6DLs078031;
	Mon, 18 May 2020 07:08:28 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 312c21xr9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2020 07:08:28 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04IB5a7m030822;
	Mon, 18 May 2020 11:08:26 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by ppma03ams.nl.ibm.com with ESMTP id 3127t5kyhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2020 11:08:25 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04IB8NaR10420728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2020 11:08:23 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34D0C4C04E;
	Mon, 18 May 2020 11:08:23 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AA5A4C046;
	Mon, 18 May 2020 11:08:20 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.102.2.238])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Mon, 18 May 2020 11:08:20 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Mon, 18 May 2020 16:38:19 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org
Subject: [RFC PATCH 0/4] powerpc/papr_scm: Add support for reporting NVDIMM performance statistics
Date: Mon, 18 May 2020 16:38:10 +0530
Message-Id: <20200518110814.145644-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-18_04:2020-05-15,2020-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 cotscore=-2147483648 lowpriorityscore=0 adultscore=0 malwarescore=0
 mlxlogscore=676 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005180096
Message-ID-Hash: GMSLTRHV7LEEO5THDK533UPS6Y2VS3NQ
X-Message-ID-Hash: GMSLTRHV7LEEO5THDK533UPS6Y2VS3NQ
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GMSLTRHV7LEEO5THDK533UPS6Y2VS3NQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The patch-set proposes to add support for fetching and reporting
performance statistics for PAPR compliant NVDIMMs as described in
documentation for H_SCM_PERFORMANCE_STATS hcall Ref[1]. The patch-set
also implements mechanisms to expose NVDIMM performance stats via
sysfs and newly introduced PDSMs[2] for libndctl.

This patch-set combined with corresponding ndctl and libndctl changes
proposed at Ref[3] should enable user to fetch PAPR compliant NVDIMMs
using following command:

 # ndctl list -D --stats
[
  {
    "dev":"nmem0",
    "stats":{
      "Controller Reset Count":2,
      "Controller Reset Elapsed Time":603331,
      "Power-on Seconds":603931,
      "Life Remaining":"100%",
      "Critical Resource Utilization":"0%",
      "Host Load Count":5781028,
      "Host Store Count":8966800,
      "Host Load Duration":975895365,
      "Host Store Duration":716230690,
      "Media Read Count":0,
      "Media Write Count":6313,
      "Media Read Duration":0,
      "Media Write Duration":9679615,
      "Cache Read Hit Count":5781028,
      "Cache Write Hit Count":8442479,
      "Fast Write Count":8969912
    }
  }
]

The patchset is dependent on existing patch-set "[PATCH v7 0/5]
powerpc/papr_scm: Add support for reporting nvdimm health" available
at Ref[2] that adds support for reporting PAPR compliant NVDIMMs in
'papr_scm' kernel module.

Structure of the patch-set
==========================

The patch-set starts with implementing functionality in papr_scm
module to issue H_SCM_PERFORMANCE_STATS hcall, fetch & parse dimm
performance stats and exposing them as a PAPR specific libnvdimm
attribute named 'perf_stats'

Patch-2 introduces a new PDSM named FETCH_PERF_STATS that can be
issued by libndctl asking papr_scm to issue the
H_SCM_PERFORMANCE_STATS hcall using helpers introduced earlier and
storing the results in a dimm specific perf-stats-buffer.

Patch-3 introduces a new PDSM named READ_PERF_STATS that can be
issued by libndctl to read the perf-stats-buffer in an incremental
manner to workaround the 256-bytes envelop limitation of libnvdimm.

Finally Patch-4 introduces a new PDSM named GET_PERF_STAT that can be
issued by libndctl to read values of a specific NVDIMM performance
stat like "Life Remaining".

References
==========
[1] Documentation/powerpc/papr_hcals.rst

[2] https://lore.kernel.org/linux-nvdimm/20200508104922.72565-1-vaibhav@linux.ibm.com/

[3] https://github.com/vaibhav92/ndctl/tree/papr_scm_stats_v1

Vaibhav Jain (4):
  powerpc/papr_scm: Fetch nvdimm performance stats from PHYP
  powerpc/papr_scm: Add support for PAPR_SCM_PDSM_FETCH_PERF_STATS
  powerpc/papr_scm: Implement support for PAPR_SCM_PDSM_READ_PERF_STATS
  powerpc/papr_scm: Add support for PDSM GET_PERF_STAT

 Documentation/ABI/testing/sysfs-bus-papr-scm  |  27 ++
 arch/powerpc/include/uapi/asm/papr_scm_pdsm.h |  60 +++
 arch/powerpc/platforms/pseries/papr_scm.c     | 391 ++++++++++++++++++
 3 files changed, 478 insertions(+)

-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

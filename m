Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA201FEBDE
	for <lists+linux-nvdimm@lfdr.de>; Thu, 18 Jun 2020 09:02:09 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B765E10FC4F78;
	Thu, 18 Jun 2020 00:02:07 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9E93010FC4F78
	for <linux-nvdimm@lists.01.org>; Thu, 18 Jun 2020 00:02:04 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05I6Xnmh180410;
	Thu, 18 Jun 2020 03:02:02 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 31r3420pj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2020 03:02:02 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05I6j9IW020248;
	Thu, 18 Jun 2020 03:02:00 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 31r3420p2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2020 03:02:00 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05I7028p007317;
	Thu, 18 Jun 2020 07:01:14 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by ppma04ams.nl.ibm.com with ESMTP id 31qur60j58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2020 07:01:14 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05I71Aqq11469180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2020 07:01:11 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD8BD42045;
	Thu, 18 Jun 2020 07:01:10 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09B3142061;
	Thu, 18 Jun 2020 07:01:07 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.105.7])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Thu, 18 Jun 2020 07:01:06 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Thu, 18 Jun 2020 12:31:05 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH v7 0/5] Add support for reporting papr nvdimm health
Date: Thu, 18 Jun 2020 12:30:59 +0530
Message-Id: <20200618070104.239446-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_04:2020-06-17,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 cotscore=-2147483648 adultscore=4 spamscore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006180049
Message-ID-Hash: 2NTRYTXY2ENQCDRISFSYVUANPB22ITI6
X-Message-ID-Hash: 2NTRYTXY2ENQCDRISFSYVUANPB22ITI6
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2NTRYTXY2ENQCDRISFSYVUANPB22ITI6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Changes since v6 [1]:
* Removed a stale comment and assignment from 'add_dimm()'.
* Updated patch description for Patch-1,2 based on review comments on
  v6 patch-series.
* Updated links to kernel patch series in patch-2.

[1] https://lore.kernel.org/linux-nvdimm/20200616053029.84731-1-vaibhav@linux.ibm.com
---
This patch-set proposes changes to libndctl to add support for reporting
health for nvdimms that support the PAPR standard[2]. The standard defines
machenism (HCALL) through which a guest kernel can query and fetch health
and performance stats of an nvdimm attached to the hypervisor[3]. Until
now 'ndctl' was unable to report these stats for papr_scm dimms on PPC64
guests due to absence of ACPI/NFIT, a limitation which this patch-set tries
to address.

The patch-set introduces support for the new PAPR PDSM family
defined at [4] & [5] via a new dimm-ops named
'papr_dimm_ops'. Infrastructure to probe and distinguish papr-scm
dimms from other dimm families that may support ACPI/NFIT is
implemented by updating the 'struct ndctl_dimm' initialization
routines to bifurcate based on the nvdimm type. We also introduce two
new dimm-ops member for handling initialization of dimm specific data
for specific DSM families.

These changes coupled with proposed kernel changes located at Ref[1] should
provide a way for the user to retrieve NVDIMM health status using ndtcl for
pseries guests. Below is a sample output using proposed kernel + ndctl
changes:

 # ndctl list -DH
[
  {
    "dev":"nmem0",
    "flag_smart_event":true,
    "health":{
      "health_state":"fatal",
      "shutdown_state":"dirty"
    }
  }
]

Structure of the patchset
=========================

We start with a re-factoring patch that splits the 'add_dimm()' function
into two functions one that take care of allocating and initializing
'struct ndctl_dimm' and another that takes care of initializing nfit
specific dimm attributes.

Patch-2 introduces probe function of papr nvdimms and assigning
'papr_dimm_ops' defined in 'papr.c' to 'dimm->ops' if
needed. The patch also code to parse the dimm flags specific to
papr nvdimms

Patches-3,4 implements scaffolding to add support for PAPR PDSM
requests and pull in their definitions from the kernel.

Finally Patch-6 add support for issuing and handling the result of
'struct ndctl_cmd' to request dimm health stats from papr_scm kernel module
and returning appropriate health status to libndctl for reporting.

References
==========
[2] "Power Architecture Platform Reference"
https://en.wikipedia.org/wiki/Power_Architecture_Platform_Reference

[3] "Hypercall Op-codes (hcalls)"
https://github.com/torvalds/linux/blob/master/Documentation/powerpc/papr_hcalls.rst

[4] "powerpc/papr_scm: Add support for reporting nvdimm health"
https://lore.kernel.org/linux-nvdimm/20200615124407.32596-1-vaibhav@linux.ibm.com/

[5] "ndctl/papr_scm,uapi: Add support for PAPR nvdimm specific methods"
https://lore.kernel.org/linux-nvdimm/20200615124407.32596-6-vaibhav@linux.ibm.com/

Vaibhav Jain (5):
  libndctl: Refactor out add_dimm() to handle NFIT specific init
  libncdtl: Add initial support for NVDIMM_FAMILY_PAPR nvdimm family
  libndctl,papr_scm: Add definitions for PAPR nvdimm specific methods
  papr: Add scaffolding to issue and handle PDSM requests
  libndctl,papr_scm: Implement support for PAPR_PDSM_HEALTH

 ndctl/lib/Makefile.am  |   1 +
 ndctl/lib/libndctl.c   | 262 +++++++++++++++++++++++++++++------------
 ndctl/lib/libndctl.sym |   5 +
 ndctl/lib/papr.c       | 224 +++++++++++++++++++++++++++++++++++
 ndctl/lib/papr.h       |  15 +++
 ndctl/lib/papr_pdsm.h  | 132 +++++++++++++++++++++
 ndctl/lib/private.h    |   4 +
 ndctl/libndctl.h       |   2 +
 ndctl/ndctl.h          |   1 +
 9 files changed, 573 insertions(+), 73 deletions(-)
 create mode 100644 ndctl/lib/papr.c
 create mode 100644 ndctl/lib/papr.h
 create mode 100644 ndctl/lib/papr_pdsm.h

-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

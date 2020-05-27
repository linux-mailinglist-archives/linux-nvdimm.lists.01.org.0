Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 020E81E377E
	for <lists+linux-nvdimm@lfdr.de>; Wed, 27 May 2020 06:48:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8EC3D1225F25F;
	Tue, 26 May 2020 21:44:12 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EAFE61225F25D
	for <linux-nvdimm@lists.01.org>; Tue, 26 May 2020 21:44:09 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04R4XWdm018225;
	Wed, 27 May 2020 00:48:16 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 316ygbwnhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2020 00:48:16 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04R4YhOg022218;
	Wed, 27 May 2020 00:48:15 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 316ygbwnh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2020 00:48:15 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
	by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04R4kaJ6029003;
	Wed, 27 May 2020 04:48:13 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by ppma03fra.de.ibm.com with ESMTP id 316uf82vt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2020 04:48:12 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04R4mAVD1180042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2020 04:48:10 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 224DB4C04A;
	Wed, 27 May 2020 04:48:10 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0938D4C040;
	Wed, 27 May 2020 04:48:04 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.121.50])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Wed, 27 May 2020 04:48:03 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Wed, 27 May 2020 10:18:01 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH v4 0/6] Add support for reporting papr-scm nvdimm health
Date: Wed, 27 May 2020 10:17:31 +0530
Message-Id: <20200527044737.40615-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_01:2020-05-26,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 cotscore=-2147483648 spamscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015 malwarescore=0
 adultscore=65 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005270033
Message-ID-Hash: TKVYEQIZOPBFGN5OMA4Y6GQVNYXZ4KWW
X-Message-ID-Hash: TKVYEQIZOPBFGN5OMA4Y6GQVNYXZ4KWW
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TKVYEQIZOPBFGN5OMA4Y6GQVNYXZ4KWW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Changes since v3 [1]:
* Updated 'papr_scm_psdm.h' to recent kernel version that removes
  'payload_offset' field from 'struct nd_pdsm_cmd_pkg'.
* Changes to 'papr_scm.c' to remove code that was populating
  'payload_offset'.

[1] https://lore.kernel.org/linux-nvdimm/20200519190147.258142-1-vaibhav@linux.ibm.com

---
This patch-set proposes changes to libndctl to add support for reporting
health for nvdimms that support the PAPR standard[2]. The standard defines
machenism (HCALL) through which a guest kernel can query and fetch health
and performance stats of an nvdimm attached to the hypervisor[3]. Until
now 'ndctl' was unable to report these stats for papr_scm dimms on PPC64
guests due to absence of ACPI/NFIT, a limitation which this patch-set tries
to address.

The patch-set introduces support for the new PAPR-SCM PDSM family
defined at [4] via a new dimm-ops named
'papr_scm_dimm_ops'. Infrastructure to probe and distinguish papr-scm
dimms from other dimm families that may support ACPI/NFIT is
implemented by updating the 'struct ndctl_dimm' initialization
routines to bifurcate based on the nvdimm type. We also introduce two
new dimm-ops member for handling initialization of dimm specific data
for specific DSM families.

These changes coupled with proposed kernel changes located at Ref[1] should
provide a way for the user to retrieve NVDIMM health status using ndtcl for
papr_scm guests. Below is a sample output using proposed kernel + ndctl
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

Patch-2 introduces probe function of papr_scm nvdimms and assigning
'papr_scm_dimm_ops' defined in 'papr_scm.c' to 'dimm->ops' if
needed. The patch also code to parse the dimm flags specific to
papr-scm nvdimms

Patch-3 introduces new dimm ops 'dimm_init()' & 'dimm_uninit()' to handle
DSM family specific initialization of 'struct ndctl_dimm'.

Patches-4,5 implements scaffolding to add support for PAPR_SCM PDSM
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

[4] "ndctl/papr_scm,uapi: Add support for PAPR nvdimm specific methods"
https://lore.kernel.org/linux-nvdimm/20200527041244.37821-5-vaibhav@linux.ibm.com/

---
Vaibhav Jain (6):
  libndctl: Refactor out add_dimm() to handle NFIT specific init
  libncdtl: Add initial support for NVDIMM_FAMILY_PAPR_SCM dimm family
  libndctl: Introduce new dimm-ops dimm_init() & dimm_uninit()
  libndctl,papr_scm: Add definitions for PAPR nvdimm specific methods
  libndctl,papr_scm: Add scaffolding to issue and handle PDSM requests
  libndctl,papr_scm: Implement support for PAPR_SCM_PDSM_HEALTH

 ndctl/lib/Makefile.am     |   1 +
 ndctl/lib/libndctl.c      | 260 +++++++++++++++++++++++---------
 ndctl/lib/papr_scm.c      | 301 ++++++++++++++++++++++++++++++++++++++
 ndctl/lib/papr_scm_pdsm.h | 175 ++++++++++++++++++++++
 ndctl/lib/private.h       |   9 ++
 ndctl/libndctl.h          |   1 +
 ndctl/ndctl.h             |   1 +
 7 files changed, 678 insertions(+), 70 deletions(-)
 create mode 100644 ndctl/lib/papr_scm.c
 create mode 100644 ndctl/lib/papr_scm_pdsm.h

-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C531E8AEA
	for <lists+linux-nvdimm@lfdr.de>; Sat, 30 May 2020 00:06:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3B15A100F2261;
	Fri, 29 May 2020 15:01:55 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1C34F100F2260
	for <linux-nvdimm@lists.01.org>; Fri, 29 May 2020 15:01:52 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04TM2quu038798;
	Fri, 29 May 2020 18:06:16 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31as1kqqt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2020 18:06:16 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04TM2ulH039246;
	Fri, 29 May 2020 18:06:15 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31as1kqqsc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2020 18:06:15 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04TM5V3Y012353;
	Fri, 29 May 2020 22:06:14 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by ppma03ams.nl.ibm.com with ESMTP id 316uf8cq2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2020 22:06:13 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04TM6BLp47055018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2020 22:06:11 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E20452052;
	Fri, 29 May 2020 22:06:11 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.199.34.115])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 3F5F552051;
	Fri, 29 May 2020 22:06:06 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Sat, 30 May 2020 03:36:05 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH v5 0/6] Add support for reporting papr nvdimm health
Date: Sat, 30 May 2020 03:35:54 +0530
Message-Id: <20200529220600.225320-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-29_13:2020-05-28,2020-05-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 cotscore=-2147483648 malwarescore=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 bulkscore=0 adultscore=12 impostorscore=0
 phishscore=0 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005290159
Message-ID-Hash: FP7TXGZQU5VPN3IULVPGN6DYZ6KCSHF5
X-Message-ID-Hash: FP7TXGZQU5VPN3IULVPGN6DYZ6KCSHF5
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FP7TXGZQU5VPN3IULVPGN6DYZ6KCSHF5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Changes since v4 [1]:
* Updated proposed changes to remove usage of term 'SCM' due to
  ambiguity with 'PMEM' and 'NVDIMM'. [ Dan Williams ]
* Replaced the usage of term 'SCM' with 'PMEM' in most contexts.
  [ Aneesh ]
* Updates to various newly introduced identifiers in 'papr.c'
  removing the 'SCM' prefix from their names.
* Renamed NVDIMM_FAMILY_PAPR_SCM to NVDIMM_FAMILY_PAPR
* Renamed PAPR_SCM_PDSM_HEALTH PAPR_PDSM_HEALTH
* Renamed 'papr_scm.c' to 'papr.c'
* Renamed 'papr_scm_pdsm.h' to 'papr_pdsm.h'

[1] https://lore.kernel.org/linux-nvdimm/20200527044737.40615-1-vaibhav@linux.ibm.com

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

Patch-3 introduces new dimm ops 'dimm_init()' & 'dimm_uninit()' to handle
DSM family specific initialization of 'struct ndctl_dimm'.

Patches-4,5 implements scaffolding to add support for PAPR PDSM
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
https://lore.kernel.org/linux-nvdimm/20200529214719.223344-1-vaibhav@linux.ibm.com

[5] "ndctl/papr_scm,uapi: Add support for PAPR nvdimm specific methods"
https://lore.kernel.org/linux-nvdimm/20200529214719.223344-5-vaibhav@linux.ibm.com

Vaibhav Jain (6):
  libndctl: Refactor out add_dimm() to handle NFIT specific init
  libncdtl: Add initial support for NVDIMM_FAMILY_PAPR nvdimm family
  libndctl: Introduce new dimm-ops dimm_init() & dimm_uninit()
  libndctl,papr_scm: Add definitions for PAPR nvdimm specific methods
  papr: Add scaffolding to issue and handle PDSM requests
  libndctl,papr_scm: Implement support for PAPR_PDSM_HEALTH

 ndctl/lib/Makefile.am |   1 +
 ndctl/lib/libndctl.c  | 260 ++++++++++++++++++++++++++----------
 ndctl/lib/papr.c      | 301 ++++++++++++++++++++++++++++++++++++++++++
 ndctl/lib/papr_pdsm.h | 175 ++++++++++++++++++++++++
 ndctl/lib/private.h   |   9 ++
 ndctl/libndctl.h      |   1 +
 ndctl/ndctl.h         |   1 +
 7 files changed, 678 insertions(+), 70 deletions(-)
 create mode 100644 ndctl/lib/papr.c
 create mode 100644 ndctl/lib/papr_pdsm.h

-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

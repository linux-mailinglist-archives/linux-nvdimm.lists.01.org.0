Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F25ED1DA045
	for <lists+linux-nvdimm@lfdr.de>; Tue, 19 May 2020 21:02:03 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 342A911E48A2E;
	Tue, 19 May 2020 11:58:43 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9D52211E48A27
	for <linux-nvdimm@lists.01.org>; Tue, 19 May 2020 11:58:41 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04JI4UXq112640;
	Tue, 19 May 2020 15:01:59 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 313x639jwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2020 15:01:59 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04JINiRY029669;
	Tue, 19 May 2020 15:01:58 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
	by mx0a-001b2d01.pphosted.com with ESMTP id 313x639juv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2020 15:01:58 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
	by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04JJ12W0021959;
	Tue, 19 May 2020 19:01:55 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by ppma01fra.de.ibm.com with ESMTP id 313xcd0w6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2020 19:01:55 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04JJ1qQC36765756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2020 19:01:52 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A55DC4C04A;
	Tue, 19 May 2020 19:01:52 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D40774C052;
	Tue, 19 May 2020 19:01:49 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.89.230])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Tue, 19 May 2020 19:01:49 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Wed, 20 May 2020 00:31:48 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH v3 0/6] Add support for reporting papr-scm nvdimm health
Date: Wed, 20 May 2020 00:31:41 +0530
Message-Id: <20200519190147.258142-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-19_07:2020-05-19,2020-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 cotscore=-2147483648 malwarescore=0 clxscore=1015
 lowpriorityscore=0 adultscore=72 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005190153
Message-ID-Hash: FT4NQICUUUPFRNQB7RO4IMPGE3FH7K4K
X-Message-ID-Hash: FT4NQICUUUPFRNQB7RO4IMPGE3FH7K4K
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FT4NQICUUUPFRNQB7RO4IMPGE3FH7K4K/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch-set proposes changes to libndctl to add support for reporting
health for nvdimms that support the PAPR standard[1]. The standard defines
machenism (HCALL) through which a guest kernel can query and fetch health
and performance stats of an nvdimm attached to the hypervisor[2]. Until
now 'ndctl' was unable to report these stats for papr_scm dimms on PPC64
guests due to absence of ACPI/NFIT, a limitation which this patch-set tries
to address.

The patch-set introduces support for the new PAPR-SCM PDSM family
defined at [3] via a new dimm-ops named
'papr_scm_dimm_ops'. Infrastructure to probe and distinguish papr-scm
dimms from other dimm families that may support ACPI/NFIT is
implemented by updating the 'struct ndctl_dimm' initialization
routines to bifurcate based on the nvdimm type. We also introduce two
new dimm-ops member for handling initialization of dimm specific data
for specific DSM families.

These changes coupled with proposed kernel changes located at Ref[4] should
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

Changelog
=========
v2..v3:
* Rename of function add_of_pmem_dimm() to add_papr_dimm() [ Aneesh ]
* Added instance of 'struct nd_pdsm_cmd_pkg' to 'struct ndctl_cmd'.
* Update papr_scm_pdsm.h to proposed version in Ref[3].

v1..v2:
* Reordered and squashed couple of patches to reduce the patchset size.
* Addressed few offline review comments from Santosh Sivaraj.
* Updated the uapi header file for papr_scm_pdsm.h.
* Updated the struct names based on the new uapi header.

References
==========
[1] "Power Architecture Platform Reference"
https://en.wikipedia.org/wiki/Power_Architecture_Platform_Reference

[2] "Hypercall Op-codes (hcalls)"
https://github.com/torvalds/linux/blob/master/Documentation/powerpc/papr_hcalls.rst

[3] "[PATCH v7 3/4] ndctl/papr_scm,uapi: Add support for PAPR nvdimm
specific methods"
https://lore.kernel.org/linux-nvdimm/20200508104922.72565-5-vaibhav@linux.ibm.com/

[4] "powerpc/papr_scm: Add support for reporting nvdimm health"
https://lore.kernel.org/linux-nvdimm/20200508104922.72565-1-vaibhav@linux.ibm.com/

Vaibhav Jain (6):
  libndctl: Refactor out add_dimm() to handle NFIT specific init
  libncdtl: Add initial support for NVDIMM_FAMILY_PAPR_SCM dimm family
  libndctl: Introduce new dimm-ops dimm_init() & dimm_uninit()
  libndctl,papr_scm: Add definitions for PAPR nvdimm specific methods
  libndctl,papr_scm: Add scaffolding to issue and handle PDSM requests
  libndctl,papr_scm: Implement support for PAPR_SCM_PDSM_HEALTH

 ndctl/lib/Makefile.am     |   1 +
 ndctl/lib/libndctl.c      | 260 +++++++++++++++++++++++---------
 ndctl/lib/papr_scm.c      | 302 ++++++++++++++++++++++++++++++++++++++
 ndctl/lib/papr_scm_pdsm.h | 173 ++++++++++++++++++++++
 ndctl/lib/private.h       |   9 ++
 ndctl/libndctl.h          |   1 +
 ndctl/ndctl.h             |   1 +
 7 files changed, 677 insertions(+), 70 deletions(-)
 create mode 100644 ndctl/lib/papr_scm.c
 create mode 100644 ndctl/lib/papr_scm_pdsm.h

-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

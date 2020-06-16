Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3980F1FA83F
	for <lists+linux-nvdimm@lfdr.de>; Tue, 16 Jun 2020 07:30:50 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0396711139A02;
	Mon, 15 Jun 2020 22:30:48 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 65BDE11139A01
	for <linux-nvdimm@lists.01.org>; Mon, 15 Jun 2020 22:30:46 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05G53IEl070351;
	Tue, 16 Jun 2020 01:30:43 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31p5es8ymn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2020 01:30:43 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05G5LuxS129250;
	Tue, 16 Jun 2020 01:30:42 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31p5es8ykh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2020 01:30:42 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05G5Q2o5008568;
	Tue, 16 Jun 2020 05:30:40 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by ppma04ams.nl.ibm.com with ESMTP id 31mpe7vqa1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2020 05:30:40 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05G5UbTv66715808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2020 05:30:37 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67B8752050;
	Tue, 16 Jun 2020 05:30:37 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.199.40.156])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id C13B852051;
	Tue, 16 Jun 2020 05:30:33 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Tue, 16 Jun 2020 11:00:32 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH v6 0/5] Add support for reporting papr nvdimm health
Date: Tue, 16 Jun 2020 11:00:24 +0530
Message-Id: <20200616053029.84731-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-15_11:2020-06-15,2020-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=96 lowpriorityscore=0 mlxscore=0 malwarescore=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 cotscore=-2147483648 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006160033
Message-ID-Hash: 7254LWVVEQJP4D67IFMWYFYW6UJM2KKA
X-Message-ID-Hash: 7254LWVVEQJP4D67IFMWYFYW6UJM2KKA
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7254LWVVEQJP4D67IFMWYFYW6UJM2KKA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Changes since v5 [1]:
* Removed the patch introducing new dimm-ops 'dimm_init()' &
  'dimm_uninit()'. Corrosponding code that used the dimm private
  initialization is also removed.
* Updated various dimm ops callback to rely on 'struct ndctl_cmd' arg
  instead of dimm-private.
* Added ndctl_bus_has_of_node() and ndctl_bus_is_papr_scm() to library
  ld version script.
* Simplified probing of new papr compatible nvdimm based on
  introduction of new exported library function
  ndctl_bus_is_papr_scm().
* Reworked various dimm-ops callbacks based on update uapi interface
  with papr_scm as defined at [5].
* Introduced a new header 'papr.h' that defines 'struct nd_pkg_papr'
  that holds 'struct nd_cmd_pkg gen'  and 'struct nd_pkg_pdsm pdsm'
  together.

[1] https://lore.kernel.org/linux-nvdimm/20200529220600.225320-1-vaibhav@linux.ibm.com
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
 ndctl/lib/libndctl.c   | 264 +++++++++++++++++++++++++++++------------
 ndctl/lib/libndctl.sym |   5 +
 ndctl/lib/papr.c       | 218 ++++++++++++++++++++++++++++++++++
 ndctl/lib/papr.h       |  15 +++
 ndctl/lib/papr_pdsm.h  | 132 +++++++++++++++++++++
 ndctl/lib/private.h    |   4 +
 ndctl/libndctl.h       |   2 +
 ndctl/ndctl.h          |   1 +
 9 files changed, 569 insertions(+), 73 deletions(-)
 create mode 100644 ndctl/lib/papr.c
 create mode 100644 ndctl/lib/papr.h
 create mode 100644 ndctl/lib/papr_pdsm.h

-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

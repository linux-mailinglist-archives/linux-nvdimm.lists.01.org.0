Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC441B0382
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Apr 2020 09:56:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4533F100A026D;
	Mon, 20 Apr 2020 00:56:19 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 686FE10106300
	for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 00:56:14 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03K7VmaL048605
	for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 03:56:16 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 30gf5qkbys-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 03:56:16 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <vaibhav@linux.ibm.com>;
	Mon, 20 Apr 2020 08:55:29 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
	by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Mon, 20 Apr 2020 08:55:26 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03K7u9s258130506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2020 07:56:09 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E4E111C04C;
	Mon, 20 Apr 2020 07:56:09 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22BC811C05B;
	Mon, 20 Apr 2020 07:56:07 +0000 (GMT)
Received: from vajain21.in.ibm.com.com (unknown [9.199.35.142])
	by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Mon, 20 Apr 2020 07:56:06 +0000 (GMT)
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH v2 0/6] Add support for reporting papr-scm nvdimm health
Date: Mon, 20 Apr 2020 13:25:50 +0530
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20042007-0016-0000-0000-00000307CB13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20042007-0017-0000-0000-0000336BDB5E
Message-Id: <20200420075556.272174-1-vaibhav@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_02:2020-04-17,2020-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 spamscore=0 priorityscore=1501 adultscore=73 malwarescore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004200063
Message-ID-Hash: XOZKPHRLDIIAJLXLIZ3OPPJXFFNE3NTT
X-Message-ID-Hash: XOZKPHRLDIIAJLXLIZ3OPPJXFFNE3NTT
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XOZKPHRLDIIAJLXLIZ3OPPJXFFNE3NTT/>
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

[3] "[PATCH v6 3/4] ndctl/papr_scm,uapi: Add support for PAPR nvdimm
specific methods"
https://lore.kernel.org/linux-nvdimm/20200420070711.223545-4-vaibhav@linux.ibm.com/

[4] "powerpc/papr_scm: Add support for reporting nvdimm health"
https://lore.kernel.org/linux-nvdimm/20200420070711.223545-1-vaibhav@linux.ibm.com/

Vaibhav Jain (6):
  libndctl: Refactor out add_dimm() to handle NFIT specific init
  libncdtl: Add initial support for NVDIMM_FAMILY_PAPR_SCM dimm family
  libndctl: Introduce new dimm-ops dimm_init() & dimm_uninit()
  libndctl,papr_scm: Add definitions for PAPR nvdimm specific methods
  libndctl,papr_scm: Add scaffolding to issue and handle PDSM requests
  libndctl,papr_scm: Implement support for PAPR_SCM_PDSM_HEALTH

 ndctl/lib/Makefile.am     |   1 +
 ndctl/lib/libndctl.c      | 260 ++++++++++++++++++++++++---------
 ndctl/lib/papr_scm.c      | 293 ++++++++++++++++++++++++++++++++++++++
 ndctl/lib/papr_scm_pdsm.h | 192 +++++++++++++++++++++++++
 ndctl/lib/private.h       |   7 +
 ndctl/libndctl.h          |   1 +
 ndctl/ndctl.h             |   1 +
 7 files changed, 685 insertions(+), 70 deletions(-)
 create mode 100644 ndctl/lib/papr_scm.c
 create mode 100644 ndctl/lib/papr_scm_pdsm.h

-- 
2.25.3
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE801B0244
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Apr 2020 09:07:41 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C82DE10106325;
	Mon, 20 Apr 2020 00:07:37 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2FDFD10106323
	for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 00:07:35 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03K71sJ2105064
	for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 03:07:37 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 30gf5qj080-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 03:07:36 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <vaibhav@linux.ibm.com>;
	Mon, 20 Apr 2020 08:06:45 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
	by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Mon, 20 Apr 2020 08:06:41 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03K77TEn31588558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2020 07:07:29 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C23B2AE055;
	Mon, 20 Apr 2020 07:07:29 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7554AAE053;
	Mon, 20 Apr 2020 07:07:27 +0000 (GMT)
Received: from vajain21.in.ibm.com.com (unknown [9.199.35.142])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Mon, 20 Apr 2020 07:07:27 +0000 (GMT)
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org
Subject: [PATCH v6 0/4] powerpc/papr_scm: Add support for reporting nvdimm health
Date: Mon, 20 Apr 2020 12:37:07 +0530
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20042007-0020-0000-0000-000003CB0D11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20042007-0021-0000-0000-00002223FEC3
Message-Id: <20200420070711.223545-1-vaibhav@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_02:2020-04-17,2020-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004200058
Message-ID-Hash: 4MUJQOJAK22XP6G6SMRRC72IBDTWZXVH
X-Message-ID-Hash: 4MUJQOJAK22XP6G6SMRRC72IBDTWZXVH
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4MUJQOJAK22XP6G6SMRRC72IBDTWZXVH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The PAPR standard[1][3] provides mechanisms to query the health and
performance stats of an NVDIMM via various hcalls as described in
Ref[2].  Until now these stats were never available nor exposed to the
user-space tools like 'ndctl'. This is partly due to PAPR platform not
having support for ACPI and NFIT. Hence 'ndctl' is unable to query and
report the dimm health status and a user had no way to determine the
current health status of a NDVIMM.

To overcome this limitation, this patch-set updates papr_scm kernel
module to query and fetch nvdimm health stats using hcalls described
in Ref[2].  This health and performance stats are then exposed to
userspace via syfs and PAPR-nvDimm-Specific-Methods(PDSM) issued by
libndctl.

These changes coupled with proposed ndtcl changes located at Ref[4]
should provide a way for the user to retrieve NVDIMM health status
using ndtcl.

Below is a sample output using proposed kernel + ndctl for PAPR NVDIMM
in a emulation environment:

 # ndctl list -DH
[
  {
    "dev":"nmem0",
    "health":{
      "health_state":"fatal",
      "shutdown_state":"dirty"
    }
  }
]

Dimm health report output on a pseries guest lpar with vPMEM or HMS
based nvdimms that are in perfectly healthy conditions:

 # ndctl list -d nmem0 -H
[
  {
    "dev":"nmem0",
    "health":{
      "health_state":"ok",
      "shutdown_state":"clean"
    }
  }
]

PAPR nvDimm-Specific-Methods(PDSM)
==================================

PDSM requests are issued by vendor specific code in libndctl to
execute certain operations or fetch information from NVDIMMS. PDSMs
requests can be sent to papr_scm module via libndctl(userspace) and
libnvdimm (kernel) using the ND_CMD_CALL ioctl command which can be
handled in the dimm control function papr_scm_ndctl(). Current
patchset proposes a single PDSM to retrieve NVDIMM health, defined in
the newly introduced uapi header named 'papr_scm_pdsm.h'. Support for
more PDSMs will be added in future.

Structure of the patch-set
==========================

The patchset starts with implementing support for fetching nvdimm health
information from PHYP and partially exposing it to user-space via a nvdimm
sysfs flag.

Second & Third patches deal with implementing support for servicing PDSM
commands in papr_scm module.

Finally the Fourth patch implements support for servicing PDSM
'PAPR_SCM_PDSM_HEALTH' that returns the nvdimm health information to
libndctl.

Changelog:
==========

v5..v6:

* Incorporate review comments from Mpe and Dan Williams.
* Changed the usage of term DSM to PDSM as former conflicted with
  usage in ACPI context.
* UAPI updates to remove usage of bool and marking the structs 
  defined as 'packed'.
* Simplified the health-bitmap handling in papr_scm to use u64
  instead of __be64 integers.
* Caching of the health information so reading the dimm-flag file
  doesn't result in costly hcalls everytime.
* Changed dimm-flag 'save_fail' to 'flush_fail'
* Moved the dimm flag file from 'papr_flags' to 'papr/flags'.
* Added a patch to document H_SCM_HEALTH hcall return values.
* Added sysfs ABI documentation for newly introduce dimm-flag
  sysfs file 'papr/flags'

v4..v5:

* Fixed a bug in new implementation of papr_scm_ndctl() that was triggering
  a false error condition.

v3..v4:

* Restructured papr_scm_ndctl() to dispatch ND_CMD_CALL commands to a new
  function named papr_scm_service_dsm() to serivice DSM requests. [Aneesh]

v2..v3:

* Updated the papr_scm_dsm.h header to be more confimant general kernel
  guidelines for UAPI headers. [Aneesh]

* Changed the definition of macro PAPR_SCM_DIMM_UNARMED_MASK to not
  include case when the nvdimm is unarmed because its a vPMEM
  nvdimm. [Aneesh]

v1..v2:

* Restructured the patch-set based on review comments on V1 patch-set to
simplify the patch review. Multiple small patches have been combined into
single patches to reduce cross referencing that was needed in earlier
patch-set. Hence most of the patches in this patch-set as now new. [Aneesh]

* Removed the initial work done for fetch nvdimm performance statistics.
These changes will be re-proposed in a separate patch-set. [Aneesh]

* Simplified handling of versioning of 'struct
nd_papr_scm_dimm_health_stat_v1' as only one version of the structure is
currently in existence.

References:
[1] "Power Architecture Platform Reference"
      https://en.wikipedia.org/wiki/Power_Architecture_Platform_Reference
[2] commit 58b278f568f0
     ("powerpc: Provide initial documentation for PAPR hcalls")
[3] "Linux on Power Architecture Platform Reference"
     https://members.openpowerfoundation.org/document/dl/469
[4] https://patchwork.kernel.org/project/linux-nvdimm/list/?series=244625

Vaibhav Jain (4):
  powerpc: Document details on H_SCM_HEALTH hcall
  powerpc/papr_scm: Fetch nvdimm health information from PHYP
  ndctl/papr_scm,uapi: Add support for PAPR nvdimm specific methods
  powerpc/papr_scm: Implement support for PAPR_SCM_PDSM_HEALTH

 Documentation/ABI/testing/sysfs-bus-papr-scm  |  27 ++
 Documentation/powerpc/papr_hcalls.rst         |  43 ++-
 arch/powerpc/include/asm/papr_scm.h           |  49 +++
 arch/powerpc/include/uapi/asm/papr_scm_pdsm.h | 192 +++++++++++
 arch/powerpc/platforms/pseries/papr_scm.c     | 317 +++++++++++++++++-
 include/uapi/linux/ndctl.h                    |   1 +
 6 files changed, 617 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-papr-scm
 create mode 100644 arch/powerpc/include/asm/papr_scm.h
 create mode 100644 arch/powerpc/include/uapi/asm/papr_scm_pdsm.h

-- 
2.25.3
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

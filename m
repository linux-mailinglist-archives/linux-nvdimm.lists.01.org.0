Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF871DA040
	for <lists+linux-nvdimm@lfdr.de>; Tue, 19 May 2020 21:01:47 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CDB551007B1EA;
	Tue, 19 May 2020 11:58:26 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AA342100A0279
	for <linux-nvdimm@lists.01.org>; Tue, 19 May 2020 11:58:25 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04JIg8U5133343;
	Tue, 19 May 2020 15:01:11 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 312c23je6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2020 15:01:11 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04JIrPwh165803;
	Tue, 19 May 2020 15:01:10 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
	by mx0a-001b2d01.pphosted.com with ESMTP id 312c23je5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2020 15:01:10 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
	by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04JJ0qpW010824;
	Tue, 19 May 2020 19:01:09 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by ppma02fra.de.ibm.com with ESMTP id 313x2j0wux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2020 19:01:08 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04JJ16JM41222316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2020 19:01:06 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06B0B42041;
	Tue, 19 May 2020 19:01:06 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2AE042049;
	Tue, 19 May 2020 19:01:02 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.89.230])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Tue, 19 May 2020 19:01:02 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Wed, 20 May 2020 00:31:01 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v7 0/5] powerpc/papr_scm: Add support for reporting nvdimm health
Date: Wed, 20 May 2020 00:30:53 +0530
Message-Id: <20200519190058.257981-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-19_07:2020-05-19,2020-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 cotscore=-2147483648 lowpriorityscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005190153
Message-ID-Hash: LFKZPIAQP32DY66X7CZUJ7GMYGUDXESH
X-Message-ID-Hash: LFKZPIAQP32DY66X7CZUJ7GMYGUDXESH
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LFKZPIAQP32DY66X7CZUJ7GMYGUDXESH/>
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
module to query and fetch NVDIMM health stats using hcalls described
in Ref[2].  This health and performance stats are then exposed to
userspace via sysfs and PAPR-NVDIMM-Specific-Methods(PDSM) issued by
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
based NVDIMMs that are in perfectly healthy conditions:

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

PAPR NVDIMM-Specific-Methods(PDSM)
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

The patch-set starts with a doc patch documenting details of hcall
H_SCM_HEALTH. Second patch exports kernel symbol seq_buf_printf()
thats used in subsequent patches to generate sysfs attribute content.

Third patch implements support for fetching NVDIMM health information
from PHYP and partially exposing it to user-space via a NVDIMM sysfs
flag.

Fourth patches deal with implementing support for servicing PDSM
commands in papr_scm module.

Finally the last patch implements support for servicing PDSM
'PAPR_SCM_PDSM_HEALTH' that returns the NVDIMM health information to
libndctl.

Changelog:
==========

Resend:
* Added ack from Steven Rostedt on Patch-2 that exports kernel symbol
  seq_buf_printf()

v6..v7:

* Incorporate various review comments from Mpe.  Removed papr_scm.h
* Added a patch to export seq_buf_printf() [Mpe, Steven Rostedt]
* header file and moved its contents to papr_scm.c.
* Split function drc_pmem_query_health() into two functions, one that takes
  care of caching and concurrency and other one that doesn't.
* Fixed a possible incorrect way to make local copy of nvdimm health data.
* Some variable renames changed as suggested in previous review.
* Removed unused macros/defines from papr_scm_pdsm.h
* Updated papr_scm_pdsm.h to remove usage of __KERNEL__ define.
* Updated papr_scm_pdsm.h to remove redefinition of __packed macro.

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
  include case when the NVDIMM is unarmed because its a vPMEM
  NVDIMM. [Aneesh]

v1..v2:

* Restructured the patch-set based on review comments on V1 patch-set to
simplify the patch review. Multiple small patches have been combined into
single patches to reduce cross referencing that was needed in earlier
patch-set. Hence most of the patches in this patch-set as now new. [Aneesh]

* Removed the initial work done for fetch NVDIMM performance statistics.
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
[4] https://github.com/vaibhav92/ndctl/tree/papr_scm_health_v7

Vaibhav Jain (5):
  powerpc: Document details on H_SCM_HEALTH hcall
  seq_buf: Export seq_buf_printf() to external modules
  powerpc/papr_scm: Fetch nvdimm health information from PHYP
  ndctl/papr_scm,uapi: Add support for PAPR nvdimm specific methods
  powerpc/papr_scm: Implement support for PAPR_SCM_PDSM_HEALTH

 Documentation/ABI/testing/sysfs-bus-papr-scm  |  27 ++
 Documentation/powerpc/papr_hcalls.rst         |  43 ++-
 arch/powerpc/include/uapi/asm/papr_scm_pdsm.h | 173 +++++++++
 arch/powerpc/platforms/pseries/papr_scm.c     | 363 +++++++++++++++++-
 include/uapi/linux/ndctl.h                    |   1 +
 lib/seq_buf.c                                 |   1 +
 6 files changed, 595 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-papr-scm
 create mode 100644 arch/powerpc/include/uapi/asm/papr_scm_pdsm.h

-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

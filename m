Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3682196603
	for <lists+linux-nvdimm@lfdr.de>; Sat, 28 Mar 2020 13:10:50 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5CFA91007B1C4;
	Sat, 28 Mar 2020 05:11:39 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A52D510096CA7
	for <linux-nvdimm@lists.01.org>; Sat, 28 Mar 2020 05:11:36 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02SC3El3031671
	for <linux-nvdimm@lists.01.org>; Sat, 28 Mar 2020 08:10:46 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 30227tm9k1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Sat, 28 Mar 2020 08:10:45 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <vaibhav@linux.ibm.com>;
	Sat, 28 Mar 2020 12:10:39 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
	by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Sat, 28 Mar 2020 12:10:35 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02SCAcNn13500536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Mar 2020 12:10:38 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CA775204F;
	Sat, 28 Mar 2020 12:10:38 +0000 (GMT)
Received: from vajain21.in.ibm.com.com (unknown [9.199.51.209])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D512A5204E;
	Sat, 28 Mar 2020 12:10:35 +0000 (GMT)
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org
Subject: [PATCH v2 0/4] powerpc/papr_scm: Add support for reporting nvdimm health
Date: Sat, 28 Mar 2020 17:40:19 +0530
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20032812-0012-0000-0000-00000399AE3D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032812-0013-0000-0000-000021D6B21B
Message-Id: <20200328121023.160363-1-vaibhav@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-28_04:2020-03-27,2020-03-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 impostorscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003280114
Message-ID-Hash: IKCRAB43372Q2RLFO3AAD3LLRW7WMSCA
X-Message-ID-Hash: IKCRAB43372Q2RLFO3AAD3LLRW7WMSCA
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <ellerman@au1.ibm.com>, Alastair D'Silva <alastair@au1.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IKCRAB43372Q2RLFO3AAD3LLRW7WMSCA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The PAPR standard[1][3] provides mechanisms to query the health and
performance stats of an NVDIMM via various hcalls as described in Ref[2].
Until now these stats were never available nor exposed to the user-space
tools like 'ndctl'. This is partly due to PAPR platform not having support
for ACPI and NFIT. Hence 'ndctl' is unable to query and report the dimm
health status and a user had no way to determine the current health status
of a NDVIMM.

To overcome this limitation, this patch-set updates papr_scm kernel module
to query and fetch nvdimm health stats using hcalls described in Ref[2].
This health and performance stats are then exposed to userspace via syfs
and Dimm-Specific-Methods(DSM) issued by libndctl.

These changes coupled with proposed ndtcl changes located at Ref[4] should
provide a way for the user to retrieve NVDIMM health status using ndtcl.
Below is a sample output using proposed kernel + ndctl for PAPR NVDIMM in
a emulation environment:

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

PAPR Dimm-Specific-Methods(DSM)
================================

As the name suggests DSMs are used by vendor specific code in libndctl to
execute certain operations or fetch certain information for NVDIMMS. DSMs
can be sent to papr_scm module via libndctl (userspace) and libnvdimm
(kernel) using the ND_CMD_CALL ioctl which can be handled in the dimm
control function papr_scm_ndctl(). For PAPR this patchset proposes a single
DSM to retrieve DIMM health, defined in the newly introduced uapi header
named 'papr_scm_dsm.h'. Support for more DSMs will be added in future.

Structure of the patch-set
==========================

The patchset starts with implementing support for fetching nvdimm health
information from PHYP and partially exposing it to user-space via nvdimm
flags.

Second & Third patches deal with implementing support for servicing DSM
commands papr_scm.

Finally the Fourth patch implements support for servicing DSM
'DSM_PAPR_SCM_HEALTH' that returns the nvdimm health information to
libndctl.

Change-log
==========
v2..v1:

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
[1]: "Power Architecture Platform Reference"
      https://en.wikipedia.org/wiki/Power_Architecture_Platform_Reference
[2]: commit 58b278f568f0
     ("powerpc: Provide initial documentation for PAPR hcalls")
[3]: "Linux on Power Architecture Platform Reference"
     https://members.openpowerfoundation.org/document/dl/469
[4]: https://patchwork.kernel.org/project/linux-nvdimm/list/?series=244625

Vaibhav Jain (4):
  powerpc/papr_scm: Fetch nvdimm health information from PHYP
  UAPI: ndctl: Introduce NVDIMM_FAMILY_PAPR_SCM as a new NVDIMM DSM
    family
  powerpc/papr_scm,uapi: Add support for handling PAPR DSM commands
  powerpc/papr_scm: Implement support for DSM_PAPR_SCM_HEALTH

 arch/powerpc/include/asm/papr_scm.h          |  49 ++++
 arch/powerpc/include/uapi/asm/papr_scm_dsm.h | 203 ++++++++++++++
 arch/powerpc/platforms/pseries/papr_scm.c    | 269 ++++++++++++++++++-
 include/uapi/linux/ndctl.h                   |   1 +
 4 files changed, 513 insertions(+), 9 deletions(-)
 create mode 100644 arch/powerpc/include/asm/papr_scm.h
 create mode 100644 arch/powerpc/include/uapi/asm/papr_scm_dsm.h

-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B4D165ACE
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Feb 2020 10:59:53 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 529D510FC3403;
	Thu, 20 Feb 2020 02:00:44 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CD8721003E996
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 01:59:21 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01K9t4U3002413
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 04:58:28 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2y8ubwjdss-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 04:58:28 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <vaibhav@linux.ibm.com>;
	Thu, 20 Feb 2020 09:58:26 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
	by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 20 Feb 2020 09:58:25 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01K9wL1R28770454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2020 09:58:21 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 685DEA4059;
	Thu, 20 Feb 2020 09:58:21 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C07ECA4051;
	Thu, 20 Feb 2020 09:58:17 +0000 (GMT)
Received: from vajain21.in.ibm.com.com (unknown [9.199.53.128])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu, 20 Feb 2020 09:58:17 +0000 (GMT)
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org
Subject: [PATCH 0/7] powerpc/papr_scm: Add support for reporting nvdimm health
Date: Thu, 20 Feb 2020 15:27:57 +0530
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20022009-0016-0000-0000-000002E889E4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022009-0017-0000-0000-0000334BA581
Message-Id: <20200220095805.197229-1-vaibhav@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_02:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200073
Message-ID-Hash: 2UYKZ6U6B3CTLY4YUEPXKLWRKWV2OXCT
X-Message-ID-Hash: 2UYKZ6U6B3CTLY4YUEPXKLWRKWV2OXCT
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <ellerman@au1.ibm.com>, Alastair D'Silva <alastair@au1.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2UYKZ6U6B3CTLY4YUEPXKLWRKWV2OXCT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The PAPR standard[1][3] provides suitable mechanisms to query the health and
performance stats of an NVDIMM via various hcalls as described in Ref[2]. Until
now these stats were never available nor exposed to the user-space tools like
'ndctl'. This is partly due to PAPR platform not having support for ACPI and
NFIT. Hence 'ndctl' is unable to query and report the dimm health status and a
user had no way to determine the current health status of a NDVIMM.

To overcome this limitation this patch-set updates papr_scm kernel module to
query and fetch nvdimm health and performance stats using hcalls described in
Ref[2]. This health and performance stats are then exposed to userspace via
syfs and Dimm-Specific-Methods(DSM) issued by libndctl.

These changes coupled with proposed ndtcl changes located at Ref[4] should
provide a way for the user to retrieve NVDIMM health status using ndtcl. Below
is a sample output using proposed kernel + ndctl for PAPR NVDIMM in an
emulation environment:

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
can be sent to papr_scm module via libndctl (userspace) and libnvdimm(kernel)
using the ND_CMD_CALL ioctl which can be handled in the dimm control function
papr_scm_ndctl(). For PAPR this patchset proposes two DSMs defined in the newly
introduced uapi header named 'papr_scm_dsm.h', that directly map to hcalls
provided by PHYP to query NVDIMM health and stats. These DSMs are:

* DSM_PAPR_SCM_HEALTH: Which map to hcall H_SCM_HEALTH and returns dimm health.

* DSM_PAPR_SCM_STATS: Which map to hcall H_SCM_PERFORMANCE_STATS and returns
		      dimm performance stats.

P.S: The current patch-set only provides an implementation for servicing
DSM_PAPR_SCM_HEALTH and a future patch will add support for DSM_PAPR_SCM_STATS.

The ioctl ND_CMD_CALL can also transfer data between user-space and kernel via
'envelopes'. The envelop is part of a 'struct nd_cmd_pkg' which in return is
wrapped in a user defined struct which in our case is a newly introduced
'struct nd_papr_scm_cmd_pkg'. Apart from 'envelope header' this struct holds
'payload', 'payload offset', 'payload version' and 'command status'.

The 'payload' field of the envelop holds a struct depending on the DSM method
used and should be one of the structs defined in newly introduced uapi header
'papr_scm_dsm.h'. This makes it possible for libndctl/kernel to share the same
definitions for these DSM structs.

Earlier Work
============

An earlier RFC patch set titled "powerpc/papr_scm: Implement support for
reporting DIMM health and stats" [5] was proposed which tried to achieve
same functionality albeit with a different approach i.e papr_scm module
acted as a pass-through for the DSM calls from libndctl.

This patch-set however departs from that design by decoupling the
libndctl <--> papr_scm and papr_scm <--> phyp interfaces. This provides
more flexibility compared to earlier approach were these two interfaces were
coupled with each other.

Structure of the patch-set
==========================

The initial 3 patches of the patch-set add functionality of issuing necessary
HCALLs to PHYP to retrieve the dimm health/performance stats information and
exposing them to user-space via sysfs attributes.

Subsequent patches deal with defining and implementing support for
NVDIMM_FAMILY_PAPR_SCM DSM command family and implementing the payload
versioning scheme as mentioned above.

References:
[1]: "Power Architecture Platform Reference"
      https://en.wikipedia.org/wiki/Power_Architecture_Platform_Reference
[2]: "[DOC,v2] powerpc: Provide initial documentation for PAPR hcalls"
     https://patchwork.ozlabs.org/patch/1154292/
[3]: "Linux on Power Architecture Platform Reference"
     https://members.openpowerfoundation.org/document/dl/469
[4]: https://github.com/vaibhav92/ndctl/tree/papr_scm_health_v1
[5]: https://lore.kernel.org/linuxppc-dev/20200129152844.71286-1-vaibhav@linux.ibm.com/

Vaibhav Jain (8):
  powerpc: Add asm header 'papr_scm.h' describing the papr-scm interface
  powerpc/papr_scm: Provide support for fetching dimm health information
  powerpc/papr_scm: Fetch dimm performance stats from PHYP
  UAPI: ndctl: Introduce NVDIMM_FAMILY_PAPR_SCM as a new NVDIMM DSM
    family
  powerpc/uapi: Introduce uapi header 'papr_scm_dsm.h' for papr_scm DSMs
  powerpc/papr_scm: Add support for handling PAPR DSM commands
  powerpc/papr_scm: Re-implement 'papr_flags' using
    'nd_papr_scm_dimm_health_stat'
  powerpc/papr_scm: Implement support for DSM_PAPR_SCM_HEALTH

 arch/powerpc/include/asm/papr_scm.h          |  68 ++++
 arch/powerpc/include/uapi/asm/papr_scm_dsm.h | 143 +++++++
 arch/powerpc/platforms/pseries/papr_scm.c    | 399 ++++++++++++++++++-
 include/uapi/linux/ndctl.h                   |   1 +
 4 files changed, 602 insertions(+), 9 deletions(-)
 create mode 100644 arch/powerpc/include/asm/papr_scm.h
 create mode 100644 arch/powerpc/include/uapi/asm/papr_scm_dsm.h

-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

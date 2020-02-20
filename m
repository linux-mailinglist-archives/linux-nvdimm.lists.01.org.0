Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95845165C1F
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Feb 2020 11:50:44 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0C53610FC35B0;
	Thu, 20 Feb 2020 02:51:35 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7161A10FC35B0
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 02:50:45 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01KAihbC068686
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 05:49:52 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ubg444v-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 05:49:52 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <vaibhav@linux.ibm.com>;
	Thu, 20 Feb 2020 10:49:50 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
	by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 20 Feb 2020 10:49:47 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01KAnj2K27590990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2020 10:49:46 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCA6BA4057;
	Thu, 20 Feb 2020 10:49:45 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FFDBA404D;
	Thu, 20 Feb 2020 10:49:43 +0000 (GMT)
Received: from vajain21.in.ibm.com.com (unknown [9.199.53.128])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu, 20 Feb 2020 10:49:42 +0000 (GMT)
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH 0/8] Add support for reporting papr-scm nvdimm health
Date: Thu, 20 Feb 2020 16:19:20 +0530
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20022010-0028-0000-0000-000003DCB789
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022010-0029-0000-0000-000024A1C724
Message-Id: <20200220104928.198625-1-vaibhav@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_02:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200079
Message-ID-Hash: QWQ4DLUKF27DFB4KDT6MOAUP5TMTBJ23
X-Message-ID-Hash: QWQ4DLUKF27DFB4KDT6MOAUP5TMTBJ23
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Alastair D'Silva <alastair@au1.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QWQ4DLUKF27DFB4KDT6MOAUP5TMTBJ23/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch-set proposes changes to libndctl to add support for reporting
health for nvdimms that support the PAPR standard[1]. The standard defines
heathenism (HCALL) through which a guest kernel can query and fetch health
and performance stats of an nvdimm attached to the hypervisor[2]. Until
now 'ndctl' was unable to report these stats for papr_scm dimms on PPC64
guests due to absence of ACPI/NFIT, a limitation which this patch-set tries
to address.

The patch-set introduces support for the new PAPR-SCM DSM family defined at
[3] via a new dimm-ops named 'papr_scm_dimm_ops'. Infrastructure to probe
and distinguish papr-scm dimms from other dimm families that may support
ACPI/NFIT is implemented by updating the 'struct ndctl_dimm' initialization
routines to bifurcate based on the nvdimm type. We also introduce two new
dimm-ops for handling initialization of dimm specific data for specific DSM
families. 

These changes coupled with proposed ndtcl changes located at Ref[4] should
provide a way for the user to retrieve NVDIMM health status using ndtcl for
papr_scm guests. Below is a sample output using proposed kernel + ndctl
changes:

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

Structure of the patchset
=========================

We start with a re-factoring patch that splits the 'add_dimm()' function
into two functions one that take care of allocating and initializing
'struct ndctl_dimm' and another that takes care of initializing nfit
specific dimm attributes.

Patch-2 introduces new dimm ops 'dimm_init()' & 'dimm_uninit()' to handle
DSM family specific initialization of 'struct ndctl_dimm'.

Patch-3 introduces probe function of papr_scm nvdimms and assigning
'papr_scm_dimm_ops' to 'dimm->ops' if needed. Subsequent patch-4 adds
support for parsing papr_scm nvdimm flags and updating 'dimm->flags' with
them.

Patches-5,6 implements scaffolding to add support for PAPR_SCM DSM commands
and pull in their definitions from the kernel. This implementation resides
in newly added 'papr_scm.c' file.

Finally Patched-7,8 add support for issuing and handling the result of
'struct ndctl_cmd' to request dimm health stats from papr_scm kernel module
and returning appropriate health status to libndctl for reporting.

References:
[1]: "Power Architecture Platform Reference"
      https://en.wikipedia.org/wiki/Power_Architecture_Platform_Reference
[2]: "[DOC,v2] powerpc: Provide initial documentation for PAPR hcalls"
     https://patchwork.ozlabs.org/patch/1154292/
[3]: "[PATCH 5/8] powerpc/uapi: Introduce uapi header 'papr_scm_dsm.h' for
     papr_scm DSMs"
     https://patchwork.ozlabs.org/patch/1241352/
[4]: "powerpc/papr_scm: Add support for reporting nvdimm health"
     https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=159701     

Vaibhav Jain (8):
  libndctl: Refactor out add_dimm() to handle NFIT specific init
  libndctl: Introduce a new dimm-ops dimm_init() & dimm_uninit()
  libncdtl: Add initial support for NVDIMM_FAMILY_PAPR_SCM dimm family
  libndctl: Add support for parsing of_pmem dimm flags and monitor mode
  libndctl,papr_scm: Add definitions for PAPR_SCM DSM commands
  libndctl,papr_scm: Implement scaffolding to issue and handle DSM cmds
  libndctl,papr_scm: Implement support for DSM_PAPR_SCM_HEALTH
  libndctl,papr_scm: Add support for reporting bad shutdown

 ndctl/lib/Makefile.am    |   1 +
 ndctl/lib/libndctl.c     | 263 +++++++++++++++++++++++++----------
 ndctl/lib/papr_scm.c     | 292 +++++++++++++++++++++++++++++++++++++++
 ndctl/lib/papr_scm_dsm.h | 143 +++++++++++++++++++
 ndctl/lib/private.h      |   7 +
 ndctl/libndctl.h         |   1 +
 ndctl/ndctl.h            |   1 +
 7 files changed, 634 insertions(+), 74 deletions(-)
 create mode 100644 ndctl/lib/papr_scm.c
 create mode 100644 ndctl/lib/papr_scm_dsm.h

-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

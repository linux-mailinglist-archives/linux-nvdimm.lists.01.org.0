Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6EF1EEE54
	for <lists+linux-nvdimm@lfdr.de>; Fri,  5 Jun 2020 01:42:25 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9C0EA100A302D;
	Thu,  4 Jun 2020 16:37:16 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 87F0A100AA63F
	for <linux-nvdimm@lists.01.org>; Thu,  4 Jun 2020 16:37:14 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 054NVr2U055203;
	Thu, 4 Jun 2020 19:41:49 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 31f9dej2du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2020 19:41:49 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 054NZB1T064637;
	Thu, 4 Jun 2020 19:41:49 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 31f9dej2dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2020 19:41:48 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
	by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 054NflaP003405;
	Thu, 4 Jun 2020 23:41:47 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
	by ppma03fra.de.ibm.com with ESMTP id 31bf47ce9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2020 23:41:47 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 054NfiDv58458458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jun 2020 23:41:44 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B7D1A405C;
	Thu,  4 Jun 2020 23:41:44 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42CDCA405B;
	Thu,  4 Jun 2020 23:41:40 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.71.124])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Thu,  4 Jun 2020 23:41:39 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Fri, 05 Jun 2020 05:11:38 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 0/6] powerpc/papr_scm: Add support for reporting nvdimm health
Date: Fri,  5 Jun 2020 05:11:30 +0530
Message-Id: <20200604234136.253703-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-04_13:2020-06-04,2020-06-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 adultscore=0 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 cotscore=-2147483648 priorityscore=1501 mlxlogscore=988
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006040160
Message-ID-Hash: ENPBKAQOS24CRK3MB5NO7EYAC2NX6HPN
X-Message-ID-Hash: ENPBKAQOS24CRK3MB5NO7EYAC2NX6HPN
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ENPBKAQOS24CRK3MB5NO7EYAC2NX6HPN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Changes since v9 [1]:
* Addressed review comments from Ira and Dan Williams.
* Removed the contentious 'payload_version' field from struct
  nd_pdsm_cmd_pkg.
* Also removed code/defines related to handling of different version
  of a pdsm payload struct.  
* Consolidated validation checks for nd_pdsm_cmd_pkg in
  is_cmd_valid().
* Added a check in is_cmd_valid() to ensure reserved fields in struct
  nd_pdsm_cmd_pkg are set to '0'.
* Reworked papr_pdsm_health() to avoid removing code that was added in
  initial part of this patch-series.
* Added a new patch to the series to move out some proposed changes to
  papr_scm_ndctl() in an independent patch.
* Reworked papr_pdsm_health() to ensure correct payload_size in the
  pdsm command package.

[1] https://lore.kernel.org/linux-nvdimm/20200602101438.73929-1-vaibhav@linux.ibm.com
---

The PAPR standard[2][4] provides mechanisms to query the health and
performance stats of an NVDIMM via various hcalls as described in
Ref[3].  Until now these stats were never available nor exposed to the
user-space tools like 'ndctl'. This is partly due to PAPR platform not
having support for ACPI and NFIT. Hence 'ndctl' is unable to query and
report the dimm health status and a user had no way to determine the
current health status of a NDVIMM.

To overcome this limitation, this patch-set updates papr_scm kernel
module to query and fetch NVDIMM health stats using hcalls described
in Ref[3].  This health and performance stats are then exposed to
userspace via sysfs and PAPR-NVDIMM-Specific-Methods(PDSM) issued by
libndctl.

These changes coupled with proposed ndtcl changes located at Ref[5]
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
the newly introduced uapi header named 'papr_pdsm.h'. Support for
more PDSMs will be added in future.

Structure of the patch-set
==========================

The patch-set starts with a doc patch documenting details of hcall
H_SCM_HEALTH. Second patch exports kernel symbol seq_buf_printf()
thats used in subsequent patches to generate sysfs attribute content.

Third patch implements support for fetching NVDIMM health information
from PHYP and partially exposing it to user-space via a NVDIMM sysfs
flag.

Fourth patch updates papr_scm_ndctl() to handle a possible error case
and also improve debug logging.

Fifth patch deals with implementing support for servicing PDSM
commands in papr_scm module.

Finally the last patch implements support for servicing PDSM
'PAPR_PDSM_HEALTH' that returns the NVDIMM health information to
libndctl.

References:
[2] "Power Architecture Platform Reference"
      https://en.wikipedia.org/wiki/Power_Architecture_Platform_Reference
[3] commit 58b278f568f0
     ("powerpc: Provide initial documentation for PAPR hcalls")
[4] "Linux on Power Architecture Platform Reference"
     https://members.openpowerfoundation.org/document/dl/469
[5] https://github.com/vaibhav92/ndctl/tree/papr_scm_health_v10

---

Vaibhav Jain (6):
  powerpc: Document details on H_SCM_HEALTH hcall
  seq_buf: Export seq_buf_printf
  powerpc/papr_scm: Fetch nvdimm health information from PHYP
  powerpc/papr_scm: Improve error logging and handling papr_scm_ndctl()
  ndctl/papr_scm,uapi: Add support for PAPR nvdimm specific methods
  powerpc/papr_scm: Implement support for PAPR_PDSM_HEALTH

 Documentation/ABI/testing/sysfs-bus-papr-pmem |  27 ++
 Documentation/powerpc/papr_hcalls.rst         |  46 ++-
 arch/powerpc/include/uapi/asm/papr_pdsm.h     | 131 +++++++
 arch/powerpc/platforms/pseries/papr_scm.c     | 361 +++++++++++++++++-
 include/uapi/linux/ndctl.h                    |   1 +
 lib/seq_buf.c                                 |   1 +
 6 files changed, 554 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-papr-pmem
 create mode 100644 arch/powerpc/include/uapi/asm/papr_pdsm.h

-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 182F82104EA
	for <lists+linux-nvdimm@lfdr.de>; Wed,  1 Jul 2020 09:23:37 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 706771103E37C;
	Wed,  1 Jul 2020 00:23:35 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1094410FCD8FB
	for <linux-nvdimm@lists.01.org>; Wed,  1 Jul 2020 00:23:33 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06175YaA142713;
	Wed, 1 Jul 2020 03:23:29 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 32083f6g44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2020 03:23:29 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0617CIEw173984;
	Wed, 1 Jul 2020 03:23:28 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
	by mx0a-001b2d01.pphosted.com with ESMTP id 32083f6g3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2020 03:23:28 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
	by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0617Fw5o006331;
	Wed, 1 Jul 2020 07:23:27 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
	by ppma02dal.us.ibm.com with ESMTP id 31wwr95rqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2020 07:23:27 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
	by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0617NOll22807034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2020 07:23:24 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 432E013605D;
	Wed,  1 Jul 2020 07:23:26 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2755136059;
	Wed,  1 Jul 2020 07:23:22 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.79.220.179])
	by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2020 07:23:22 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        linux-nvdimm@lists.01.org, dan.j.williams@intel.com
Subject: [PATCH v7 0/7] Support new pmem flush and sync instructions for POWER
Date: Wed,  1 Jul 2020 12:52:28 +0530
Message-Id: <20200701072235.223558-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_03:2020-07-01,2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 cotscore=-2147483648
 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007010050
Message-ID-Hash: RF32SF5BGYT2P23FSXAFYMMALESJ3CQG
X-Message-ID-Hash: RF32SF5BGYT2P23FSXAFYMMALESJ3CQG
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, msuchanek@suse.de, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RF32SF5BGYT2P23FSXAFYMMALESJ3CQG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch series enables the usage os new pmem flush and sync instructions on POWER
architecture. POWER10 introduces two new variants of dcbf instructions (dcbstps and dcbfps)
that can be used to write modified locations back to persistent storage. Additionally,
POWER10 also introduce phwsync and plwsync which can be used to establish order of these
writes to persistent storage.
    
This series exposes these instructions to the rest of the kernel. The existing
dcbf and hwsync instructions in P8 and P9 are adequate to enable appropriate
synchronization with OpenCAPI-hosted persistent storage. Hence the new instructions
are added as a variant of the old ones that old hardware won't differentiate.

On POWER10, pmem devices will be represented by a different device tree compat
strings. This ensures that older kernels won't initialize pmem devices on POWER10.

With this:
1) vPMEM continues to work since it is a volatile region. That 
doesn't need any flush instructions.

2) pmdk and other user applications get updated to use new instructions
and updated packages are made available to all distributions

3) On newer hardware, the device will appear with a new compat string. 
Hence older distributions won't initialize pmem on newer hardware.

Changes from v6:
* rename flush barrier to pmem_wmb(). Update documentation. 
* Drop the WARN_ON in flush routines.
* Drop pap_scm ndr_region flush callback.

Changes from v5:
* Drop CONFIG_ARCH_MAP_SYNC_DISABLE and related changes

Changes from V4:
* Add namespace specific sychronous fault control.

Changes from V3:
* Add new compat string to be used for the device.
* Use arch_pmem_flush_barrier() in dm-writecache.
Aneesh Kumar K.V (7):
  powerpc/pmem: Restrict papr_scm to P8 and above.
  powerpc/pmem: Add new instructions for persistent storage and sync
  powerpc/pmem: Add flush routines using new pmem store and sync
    instruction
  libnvdimm/nvdimm/flush: Allow architecture to override the flush
    barrier
  powerpc/pmem: Update ppc64 to use the new barrier instruction.
  powerpc/pmem: Avoid the barrier in flush routines
  powerpc/pmem: Initialize pmem device on newer hardware

 Documentation/memory-barriers.txt         | 14 ++++++++
 arch/powerpc/include/asm/barrier.h        | 13 +++++++
 arch/powerpc/include/asm/cacheflush.h     |  1 +
 arch/powerpc/include/asm/ppc-opcode.h     | 12 +++++++
 arch/powerpc/lib/pmem.c                   | 44 ++++++++++++++++++++---
 arch/powerpc/platforms/pseries/papr_scm.c |  1 +
 arch/powerpc/platforms/pseries/pmem.c     |  6 ++++
 drivers/md/dm-writecache.c                |  2 +-
 drivers/nvdimm/of_pmem.c                  |  1 +
 drivers/nvdimm/region_devs.c              |  8 ++---
 include/asm-generic/barrier.h             | 10 ++++++
 11 files changed, 103 insertions(+), 9 deletions(-)

-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

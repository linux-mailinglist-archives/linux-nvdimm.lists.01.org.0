Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE6F1E755B
	for <lists+linux-nvdimm@lfdr.de>; Fri, 29 May 2020 07:28:48 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3C9BB1230AF0E;
	Thu, 28 May 2020 22:24:24 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EF5251230849F
	for <linux-nvdimm@lists.01.org>; Thu, 28 May 2020 22:24:21 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04T526kQ153537;
	Fri, 29 May 2020 01:28:37 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 31as1mv28u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2020 01:28:36 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04T54cbr161277;
	Fri, 29 May 2020 01:28:36 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
	by mx0b-001b2d01.pphosted.com with ESMTP id 31as1mv28g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2020 01:28:36 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
	by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04T5QCAt008991;
	Fri, 29 May 2020 05:28:35 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
	by ppma03wdc.us.ibm.com with ESMTP id 316uf9sfdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2020 05:28:35 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
	by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04T5SZjY50921818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2020 05:28:35 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 088FEBE051;
	Fri, 29 May 2020 05:28:35 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89593BE04F;
	Fri, 29 May 2020 05:28:32 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.85.84.128])
	by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2020 05:28:32 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        linux-nvdimm@lists.01.org
Subject: [PATCH v4 0/8] Support new pmem flush and sync instructions for POWER
Date: Fri, 29 May 2020 10:58:12 +0530
Message-Id: <20200529052820.151651-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-29_01:2020-05-28,2020-05-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 mlxlogscore=992 lowpriorityscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 impostorscore=0
 cotscore=-2147483648 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005290034
Message-ID-Hash: SRPNRMY5ZEBAHDITXDRF5KFL66GX5ZLE
X-Message-ID-Hash: SRPNRMY5ZEBAHDITXDRF5KFL66GX5ZLE
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SRPNRMY5ZEBAHDITXDRF5KFL66GX5ZLE/>
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

Changes from V3:
* Add new compat string to be used for the device.
* Use arch_pmem_flush_barrier() in dm-writecache.

Aneesh Kumar K.V (8):
  powerpc/pmem: Restrict papr_scm to P8 and above.
  powerpc/pmem: Add new instructions for persistent storage and sync
  powerpc/pmem: Add flush routines using new pmem store and sync
    instruction
  libnvdimm/nvdimm/flush: Allow architecture to override the flush
    barrier
  powerpc/pmem/of_pmem: Update of_pmem to use the new barrier
    instruction.
  powerpc/pmem: Avoid the barrier in flush routines
  powerpc/book3s/pmem: Add WARN_ONCE to catch the wrong usage of pmem
    flush functions.
  powerpc/pmem: Initialize pmem device on newer hardware

 arch/powerpc/include/asm/cacheflush.h     |  9 +++++
 arch/powerpc/include/asm/ppc-opcode.h     | 12 ++++++
 arch/powerpc/lib/pmem.c                   | 46 +++++++++++++++++++++--
 arch/powerpc/platforms/pseries/papr_scm.c | 14 +++++++
 arch/powerpc/platforms/pseries/pmem.c     |  6 +++
 drivers/md/dm-writecache.c                |  2 +-
 drivers/nvdimm/of_pmem.c                  |  1 +
 drivers/nvdimm/region_devs.c              |  8 ++--
 include/linux/libnvdimm.h                 |  4 ++
 9 files changed, 93 insertions(+), 9 deletions(-)

-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

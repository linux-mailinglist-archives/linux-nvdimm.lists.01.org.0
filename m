Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65B220CEFA
	for <lists+linux-nvdimm@lfdr.de>; Mon, 29 Jun 2020 15:58:29 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 83B68111C7C4E;
	Mon, 29 Jun 2020 06:58:28 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D9268111B33DC
	for <linux-nvdimm@lists.01.org>; Mon, 29 Jun 2020 06:58:25 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05TDaQ3A012548;
	Mon, 29 Jun 2020 09:58:20 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31xkqjp577-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2020 09:58:09 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05TDiZaY045886;
	Mon, 29 Jun 2020 09:57:52 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31xkqjp50f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2020 09:57:52 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
	by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05TDsVLB017950;
	Mon, 29 Jun 2020 13:57:40 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
	by ppma03wdc.us.ibm.com with ESMTP id 31wwr87r4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2020 13:57:40 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
	by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05TDvelr54002086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jun 2020 13:57:40 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4464BAE062;
	Mon, 29 Jun 2020 13:57:40 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14129AE05C;
	Mon, 29 Jun 2020 13:57:37 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.77.197.62])
	by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
	Mon, 29 Jun 2020 13:57:36 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        linux-nvdimm@lists.01.org, dan.j.williams@intel.com
Subject: [PATCH v6 0/8] Support new pmem flush and sync instructions for POWER
Date: Mon, 29 Jun 2020 19:27:14 +0530
Message-Id: <20200629135722.73558-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-29_11:2020-06-29,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 suspectscore=0 cotscore=-2147483648
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006290091
Message-ID-Hash: OFZ2BBJOT7MOABMEN4RITNIMETHJ3SJV
X-Message-ID-Hash: OFZ2BBJOT7MOABMEN4RITNIMETHJ3SJV
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, msuchanek@suse.de, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OFZ2BBJOT7MOABMEN4RITNIMETHJ3SJV/>
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

Changes from v5:
* Drop CONFIG_ARCH_MAP_SYNC_DISABLE and related changes

Changes from V4:
* Add namespace specific sychronous fault control.

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
  powerpc/pmem: Add WARN_ONCE to catch the wrong usage of pmem flush
    functions.
  powerpc/pmem: Initialize pmem device on newer hardware

 arch/powerpc/include/asm/cacheflush.h     | 10 +++++
 arch/powerpc/include/asm/ppc-opcode.h     | 12 ++++++
 arch/powerpc/lib/pmem.c                   | 46 +++++++++++++++++++++--
 arch/powerpc/platforms/pseries/papr_scm.c | 14 +++++++
 arch/powerpc/platforms/pseries/pmem.c     |  6 +++
 drivers/md/dm-writecache.c                |  2 +-
 drivers/nvdimm/of_pmem.c                  |  1 +
 drivers/nvdimm/region_devs.c              |  8 ++--
 include/asm-generic/cacheflush.h          |  4 ++
 9 files changed, 94 insertions(+), 9 deletions(-)

-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EB71F4E18
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Jun 2020 08:24:13 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 123F1100A457E;
	Tue,  9 Jun 2020 23:24:12 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 19874100A457D
	for <linux-nvdimm@lists.01.org>; Tue,  9 Jun 2020 23:24:05 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05A61s5T167325;
	Wed, 10 Jun 2020 02:24:00 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31gg82jhjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2020 02:24:00 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05A62WFv168497;
	Wed, 10 Jun 2020 02:23:59 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31gg82jhjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2020 02:23:59 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
	by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05A6KoO9023946;
	Wed, 10 Jun 2020 06:23:58 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
	by ppma02wdc.us.ibm.com with ESMTP id 31g2s8n8a8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2020 06:23:58 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
	by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05A6NwTs50004446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2020 06:23:58 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4981AC05B;
	Wed, 10 Jun 2020 06:23:57 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7552AC059;
	Wed, 10 Jun 2020 06:23:54 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.58.158])
	by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2020 06:23:54 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        linux-nvdimm@lists.01.org, dan.j.williams@intel.com
Subject: [PATCH v5 00/10] Support new pmem flush and sync instructions for POWER
Date: Wed, 10 Jun 2020 11:53:33 +0530
Message-Id: <20200610062343.492293-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-10_02:2020-06-10,2020-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 mlxlogscore=999 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006100041
Message-ID-Hash: OE62YDHNETO3LR6EWI7UF2TKDAR7EOP2
X-Message-ID-Hash: OE62YDHNETO3LR6EWI7UF2TKDAR7EOP2
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, msuchanek@suse.de, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OE62YDHNETO3LR6EWI7UF2TKDAR7EOP2/>
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

W.r.t userspace we want to make sure applications are enabled to use MAP_SYNC only
if they are using the new instructions. To avoid the wrong usage of MAP_SYNC on
newer hardware, we disable MAP_SYNC by default on newer hardware. The namespace specific
attribute /sys/block/pmem0/dax/sync_fault can be used to enable MAP_SYNC later.

With this:
1) vPMEM continues to work since it is a volatile region. That 
doesn't need any flush instructions.

2) pmdk and other user applications get updated to use new instructions
and updated packages are made available to all distributions

3) On newer hardware, the device will appear with a new compat string. 
Hence older distributions won't initialize pmem on newer hardware.

4) If we have a newer kernel with an older distro, we use the per 
namespace sysfs knob that prevents the usage of MAP_SYNC.

5) Sometime in the future, we mark the CONFIG_ARCH_MAP_SYNC_DISABLE=n
on ppc64 when we are confident that everybody is using the new flush 
instruction.

Chaanges from V4:
* Add namespace specific sychronous fault control.

Changes from V3:
* Add new compat string to be used for the device.
* Use arch_pmem_flush_barrier() in dm-writecache.

Aneesh Kumar K.V (10):
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
  libnvdimm/dax: Add a dax flag to control synchronous fault support
  powerpc/pmem: Disable synchronous fault by default
  powerpc/pmem: Initialize pmem device on newer hardware

 arch/powerpc/include/asm/cacheflush.h     | 10 ++++
 arch/powerpc/include/asm/ppc-opcode.h     | 12 ++++
 arch/powerpc/lib/pmem.c                   | 46 ++++++++++++--
 arch/powerpc/platforms/Kconfig.cputype    |  9 +++
 arch/powerpc/platforms/pseries/papr_scm.c | 31 +++++++++-
 arch/powerpc/platforms/pseries/pmem.c     |  6 ++
 drivers/dax/bus.c                         |  2 +-
 drivers/dax/super.c                       | 73 +++++++++++++++++++++++
 drivers/md/dm-writecache.c                |  2 +-
 drivers/nvdimm/of_pmem.c                  |  8 +++
 drivers/nvdimm/pmem.c                     |  4 ++
 drivers/nvdimm/region_devs.c              | 24 ++++++--
 include/linux/dax.h                       | 16 +++++
 include/linux/libnvdimm.h                 |  8 +++
 mm/Kconfig                                |  3 +
 15 files changed, 243 insertions(+), 11 deletions(-)

-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

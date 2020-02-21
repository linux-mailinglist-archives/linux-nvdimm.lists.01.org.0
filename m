Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2F6166D89
	for <lists+linux-nvdimm@lfdr.de>; Fri, 21 Feb 2020 04:28:26 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EEB0610FC3610;
	Thu, 20 Feb 2020 19:29:14 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 518791003E988
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 19:29:12 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01L3KJ95104874
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 22:28:19 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ubqh1hr-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 22:28:19 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Fri, 21 Feb 2020 03:28:16 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
	by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 21 Feb 2020 03:28:08 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01L3S7Xw51314800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2020 03:28:07 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BADFCA405C;
	Fri, 21 Feb 2020 03:28:07 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E1F6A4054;
	Fri, 21 Feb 2020 03:28:07 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Fri, 21 Feb 2020 03:28:07 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 82291A0209;
	Fri, 21 Feb 2020 14:28:02 +1100 (AEDT)
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: alastair@d-silva.org
Subject: [PATCH v3 00/27] Add support for OpenCAPI Persistent Memory devices
Date: Fri, 21 Feb 2020 14:26:53 +1100
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20022103-0020-0000-0000-000003AC220E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022103-0021-0000-0000-000022042A30
Message-Id: <20200221032720.33893-1-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_19:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=1 spamscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002210020
Message-ID-Hash: 2246NMSMADL2UVUMDLEZKFXCZQWJVTJD
X-Message-ID-Hash: 2246NMSMADL2UVUMDLEZKFXCZQWJVTJD
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.r
 u>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2246NMSMADL2UVUMDLEZKFXCZQWJVTJD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Alastair D'Silva <alastair@d-silva.org>

This series adds support for OpenCAPI Persistent Memory devices, exposing
them as nvdimms so that we can make use of the existing infrastructure.

Alastair D'Silva (27):
  powerpc: Add OPAL calls for LPC memory alloc/release
  mm/memory_hotplug: Allow check_hotplug_memory_addressable to be called
    from drivers
  powerpc: Map & release OpenCAPI LPC memory
  ocxl: Remove unnecessary externs
  ocxl: Address kernel doc errors & warnings
  ocxl: Tally up the LPC memory on a link & allow it to be mapped
  ocxl: Add functions to map/unmap LPC memory
  ocxl: Emit a log message showing how much LPC memory was detected
  ocxl: Save the device serial number in ocxl_fn
  powerpc: Add driver for OpenCAPI Persistent Memory
  powerpc: Enable the OpenCAPI Persistent Memory driver for
    powernv_defconfig
  powerpc/powernv/pmem: Add register addresses & status values to the
    header
  powerpc/powernv/pmem: Read the capability registers & wait for device
    ready
  powerpc/powernv/pmem: Add support for Admin commands
  powerpc/powernv/pmem: Add support for near storage commands
  powerpc/powernv/pmem: Register a character device for userspace to
    interact with
  powerpc/powernv/pmem: Implement the Read Error Log command
  powerpc/powernv/pmem: Add controller dump IOCTLs
  powerpc/powernv/pmem: Add an IOCTL to report controller statistics
  powerpc/powernv/pmem: Forward events to userspace
  powerpc/powernv/pmem: Add an IOCTL to request controller health & perf
    data
  powerpc/powernv/pmem: Implement the heartbeat command
  powerpc/powernv/pmem: Add debug IOCTLs
  powerpc/powernv/pmem: Expose SMART data via ndctl
  powerpc/powernv/pmem: Expose the serial number in sysfs
  powerpc/powernv/pmem: Expose the firmware version in sysfs
  MAINTAINERS: Add myself & nvdimm/ocxl to ocxl

 MAINTAINERS                                   |    3 +
 arch/powerpc/configs/powernv_defconfig        |    5 +
 arch/powerpc/include/asm/opal-api.h           |    2 +
 arch/powerpc/include/asm/opal.h               |    3 +
 arch/powerpc/include/asm/pnv-ocxl.h           |   40 +-
 arch/powerpc/platforms/powernv/Kconfig        |    3 +
 arch/powerpc/platforms/powernv/Makefile       |    1 +
 arch/powerpc/platforms/powernv/ocxl.c         |   43 +
 arch/powerpc/platforms/powernv/opal-call.c    |    2 +
 arch/powerpc/platforms/powernv/pmem/Kconfig   |   21 +
 arch/powerpc/platforms/powernv/pmem/Makefile  |    7 +
 arch/powerpc/platforms/powernv/pmem/ocxl.c    | 1991 +++++++++++++++++
 .../platforms/powernv/pmem/ocxl_internal.c    |  213 ++
 .../platforms/powernv/pmem/ocxl_internal.h    |  254 +++
 .../platforms/powernv/pmem/ocxl_sysfs.c       |   46 +
 drivers/misc/ocxl/config.c                    |   74 +-
 drivers/misc/ocxl/core.c                      |   61 +
 drivers/misc/ocxl/link.c                      |   53 +
 drivers/misc/ocxl/ocxl_internal.h             |   45 +-
 include/linux/memory_hotplug.h                |    5 +
 include/misc/ocxl.h                           |  122 +-
 include/uapi/linux/ndctl.h                    |    1 +
 include/uapi/nvdimm/ocxl-pmem.h               |  127 ++
 mm/memory_hotplug.c                           |    4 +-
 24 files changed, 3029 insertions(+), 97 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/pmem/Kconfig
 create mode 100644 arch/powerpc/platforms/powernv/pmem/Makefile
 create mode 100644 arch/powerpc/platforms/powernv/pmem/ocxl.c
 create mode 100644 arch/powerpc/platforms/powernv/pmem/ocxl_internal.c
 create mode 100644 arch/powerpc/platforms/powernv/pmem/ocxl_internal.h
 create mode 100644 arch/powerpc/platforms/powernv/pmem/ocxl_sysfs.c
 create mode 100644 include/uapi/nvdimm/ocxl-pmem.h

-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

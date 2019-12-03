Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E073110F5A9
	for <lists+linux-nvdimm@lfdr.de>; Tue,  3 Dec 2019 04:48:32 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 35FF310113662;
	Mon,  2 Dec 2019 19:51:53 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6F3FB10113637
	for <linux-nvdimm@lists.01.org>; Mon,  2 Dec 2019 19:51:50 -0800 (PST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB33km7l113886
	for <linux-nvdimm@lists.01.org>; Mon, 2 Dec 2019 22:48:26 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2wm6mxtn8w-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Mon, 02 Dec 2019 22:48:26 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Tue, 3 Dec 2019 03:48:24 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
	by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 3 Dec 2019 03:48:17 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB33mGp362390408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Dec 2019 03:48:16 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDB2B4203F;
	Tue,  3 Dec 2019 03:48:15 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 549B34204B;
	Tue,  3 Dec 2019 03:48:15 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue,  3 Dec 2019 03:48:15 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 30B52A01B6;
	Tue,  3 Dec 2019 14:48:12 +1100 (AEDT)
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: alastair@d-silva.org
Subject: [PATCH v2 00/27] Add support for OpenCAPI SCM devices
Date: Tue,  3 Dec 2019 14:46:28 +1100
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19120303-0008-0000-0000-0000033C0FDC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120303-0009-0000-0000-00004A5B2899
Message-Id: <20191203034655.51561-1-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_06:2019-11-29,2019-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=3 clxscore=1015 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912030032
Message-ID-Hash: MKK2FQE3IZGO3GX6N5SWEC4RQ4EJ2CVT
X-Message-ID-Hash: MKK2FQE3IZGO3GX6N5SWEC4RQ4EJ2CVT
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-dev@list
 s.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MKK2FQE3IZGO3GX6N5SWEC4RQ4EJ2CVT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Alastair D'Silva <alastair@d-silva.org>

This series adds support for OpenCAPI SCM devices, exposing
them as nvdimms so that we can make use of the existing
infrastructure.

V2:
  - "powerpc: Map & release OpenCAPI LPC memory"
      - Fix #if -> #ifdef
      - use pci_dev_id to get the bdfn
      - use __be64 to hold be data
      - indent check_hotplug_memory_addressable correctly 
      - Remove export of check_hotplug_memory_addressable
  - "ocxl: Conditionally bind SCM devices to the generic OCXL driver"
      - Improve patch description and remove redundant default
  - "nvdimm: Add driver for OpenCAPI Storage Class Memory"
      - Mark a few funcs as static as identified by the 0day bot
      - Add OCXL dependancies to OCXL_SCM
      - Use memcpy_mcsafe in scm_ndctl_config_read
      - Rename scm_foo_offset_0x00 to scm_foo_header_parse & add docs
      - Name DIMM attribs "ocxl" rather than "scm"
      - Split out into base + many feature patches
  - "powerpc: Enable OpenCAPI Storage Class Memory driver on bare metal"
      - Build DEV_DAX & friends as modules
  - "ocxl: Conditionally bind SCM devices to the generic OCXL driver"
      - Patch dropped (easy enough to maintain this out of tree for development)
  - "ocxl: Tally up the LPC memory on a link & allow it to be mapped"
      - Add a warning if an unmatched lpc_release is called
  - "ocxl: Add functions to map/unmap LPC memory"
      - Use EXPORT_SYMBOL_GPL


Alastair D'Silva (27):
  memory_hotplug: Add a bounds check to __add_pages
  nvdimm: remove prototypes for nonexistent functions
  powerpc: Add OPAL calls for LPC memory alloc/release
  mm/memory_hotplug: Allow check_hotplug_memory_addressable to be called
    from drivers
  powerpc: Map & release OpenCAPI LPC memory
  ocxl: Tally up the LPC memory on a link & allow it to be mapped
  ocxl: Add functions to map/unmap LPC memory
  ocxl: Save the device serial number in ocxl_fn
  ocxl: Free detached contexts in ocxl_context_detach_all()
  nvdimm: Add driver for OpenCAPI Storage Class Memory
  nvdimm/ocxl: Add register addresses & status values to header
  nvdimm/ocxl: Read the capability registers & wait for device ready
  nvdimm/ocxl: Add support for Admin commands
  nvdimm/ocxl: Add support for near storage commands
  nvdimm/ocxl: Register a character device for userspace to interact
    with
  nvdimm/ocxl: Implement the Read Error Log command
  nvdimm/ocxl: Add controller dump IOCTLs
  nvdimm/ocxl: Add an IOCTL to report controller statistics
  nvdimm/ocxl: Forward events to userspace
  nvdimm/ocxl: Add an IOCTL to request controller health & perf data
  nvdimm/ocxl: Support firmware update via sysfs
  nvdimm/ocxl: Implement the heartbeat command
  nvdimm/ocxl: Add debug IOCTLs
  nvdimm/ocxl: Implement Overwrite
  nvdimm/ocxl: Expose SMART data via ndctl
  powerpc: Enable OpenCAPI Storage Class Memory driver on bare metal
  MAINTAINERS: Add myself & nvdimm/ocxl to ocxl

 MAINTAINERS                                |    3 +
 arch/powerpc/configs/powernv_defconfig     |    4 +
 arch/powerpc/include/asm/opal-api.h        |    2 +
 arch/powerpc/include/asm/opal.h            |    3 +
 arch/powerpc/include/asm/pnv-ocxl.h        |    2 +
 arch/powerpc/platforms/powernv/ocxl.c      |   42 +
 arch/powerpc/platforms/powernv/opal-call.c |    2 +
 drivers/misc/ocxl/config.c                 |   50 +
 drivers/misc/ocxl/context.c                |    6 +-
 drivers/misc/ocxl/core.c                   |   60 +
 drivers/misc/ocxl/link.c                   |   60 +
 drivers/misc/ocxl/ocxl_internal.h          |   36 +
 drivers/nvdimm/Kconfig                     |    2 +
 drivers/nvdimm/Makefile                    |    2 +-
 drivers/nvdimm/nd-core.h                   |    4 -
 drivers/nvdimm/ocxl/Kconfig                |   21 +
 drivers/nvdimm/ocxl/Makefile               |    7 +
 drivers/nvdimm/ocxl/scm.c                  | 2220 ++++++++++++++++++++
 drivers/nvdimm/ocxl/scm_internal.c         |  238 +++
 drivers/nvdimm/ocxl/scm_internal.h         |  284 +++
 drivers/nvdimm/ocxl/scm_sysfs.c            |  163 ++
 include/linux/memory_hotplug.h             |    5 +
 include/misc/ocxl.h                        |   19 +
 include/uapi/nvdimm/ocxl-scm.h             |  127 ++
 mm/memory_hotplug.c                        |   21 +
 25 files changed, 3377 insertions(+), 6 deletions(-)
 create mode 100644 drivers/nvdimm/ocxl/Kconfig
 create mode 100644 drivers/nvdimm/ocxl/Makefile
 create mode 100644 drivers/nvdimm/ocxl/scm.c
 create mode 100644 drivers/nvdimm/ocxl/scm_internal.c
 create mode 100644 drivers/nvdimm/ocxl/scm_internal.h
 create mode 100644 drivers/nvdimm/ocxl/scm_sysfs.c
 create mode 100644 include/uapi/nvdimm/ocxl-scm.h

-- 
2.23.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B6FE429D
	for <lists+linux-nvdimm@lfdr.de>; Fri, 25 Oct 2019 06:48:46 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 74D74100EEBA9;
	Thu, 24 Oct 2019 21:50:00 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 198EE100EEBA6
	for <linux-nvdimm@lists.01.org>; Thu, 24 Oct 2019 21:49:55 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9P4leSt096967
	for <linux-nvdimm@lists.01.org>; Fri, 25 Oct 2019 00:48:36 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2vuqehvd5y-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Fri, 25 Oct 2019 00:48:36 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Fri, 25 Oct 2019 05:48:33 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
	by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 25 Oct 2019 05:48:25 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9P4mOAN42991730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2019 04:48:24 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 489635204F;
	Fri, 25 Oct 2019 04:48:24 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9AAC952051;
	Fri, 25 Oct 2019 04:48:23 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id C0730A0147;
	Fri, 25 Oct 2019 15:48:21 +1100 (AEDT)
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: alastair@d-silva.org
Subject: [PATCH 00/10] Add support for OpenCAPI SCM devices
Date: Fri, 25 Oct 2019 15:46:55 +1100
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19102504-0020-0000-0000-0000037E3ECB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102504-0021-0000-0000-000021D488E6
Message-Id: <20191025044721.16617-1-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-25_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=708 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910250045
Message-ID-Hash: ZZS6XEFHQEWLUER4DHXC7NHUR4NOMTBY
X-Message-ID-Hash: ZZS6XEFHQEWLUER4DHXC7NHUR4NOMTBY
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Masahiro Yamada <yamada.masahiro@socionext.com>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.com>, Michal Hocko 
 <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZZS6XEFHQEWLUER4DHXC7NHUR4NOMTBY/>
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

The first patch (in memory_hotplug) has reviews/acks, but has
not yet made it upstream.

Alastair D'Silva (10):
  memory_hotplug: Add a bounds check to __add_pages
  nvdimm: remove prototypes for nonexistent functions
  powerpc: Add OPAL calls for LPC memory alloc/release
  powerpc: Map & release OpenCAPI LPC memory
  ocxl: Tally up the LPC memory on a link & allow it to be mapped
  ocxl: Add functions to map/unmap LPC memory
  ocxl: Save the device serial number in ocxl_fn
  nvdimm: Add driver for OpenCAPI Storage Class Memory
  powerpc: Enable OpenCAPI Storage Class Memory driver on bare metal
  ocxl: Conditionally bind SCM devices to the generic OCXL driver

 arch/powerpc/configs/powernv_defconfig     |    4 +
 arch/powerpc/include/asm/opal-api.h        |    2 +
 arch/powerpc/include/asm/opal.h            |    3 +
 arch/powerpc/include/asm/pnv-ocxl.h        |    2 +
 arch/powerpc/platforms/powernv/ocxl.c      |   41 +
 arch/powerpc/platforms/powernv/opal-call.c |    2 +
 drivers/misc/ocxl/Kconfig                  |    7 +
 drivers/misc/ocxl/config.c                 |   50 +
 drivers/misc/ocxl/core.c                   |   60 +
 drivers/misc/ocxl/link.c                   |   60 +
 drivers/misc/ocxl/ocxl_internal.h          |   36 +
 drivers/misc/ocxl/pci.c                    |    3 +
 drivers/nvdimm/Kconfig                     |   17 +
 drivers/nvdimm/Makefile                    |    3 +
 drivers/nvdimm/nd-core.h                   |    4 -
 drivers/nvdimm/ocxl-scm.c                  | 2210 ++++++++++++++++++++
 drivers/nvdimm/ocxl-scm_internal.c         |  232 ++
 drivers/nvdimm/ocxl-scm_internal.h         |  331 +++
 drivers/nvdimm/ocxl-scm_sysfs.c            |  219 ++
 include/linux/memory_hotplug.h             |    5 +
 include/misc/ocxl.h                        |   19 +
 include/uapi/linux/ocxl-scm.h              |  128 ++
 mm/memory_hotplug.c                        |   22 +
 23 files changed, 3456 insertions(+), 4 deletions(-)
 create mode 100644 drivers/nvdimm/ocxl-scm.c
 create mode 100644 drivers/nvdimm/ocxl-scm_internal.c
 create mode 100644 drivers/nvdimm/ocxl-scm_internal.h
 create mode 100644 drivers/nvdimm/ocxl-scm_sysfs.c
 create mode 100644 include/uapi/linux/ocxl-scm.h

-- 
2.21.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

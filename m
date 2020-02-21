Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4DB166DA1
	for <lists+linux-nvdimm@lfdr.de>; Fri, 21 Feb 2020 04:28:53 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4496E10FC36C6;
	Thu, 20 Feb 2020 19:29:23 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2A40310FC3619
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 19:29:16 -0800 (PST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01L3JHNT067581
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 22:28:23 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ubvvvut-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 22:28:23 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Fri, 21 Feb 2020 03:28:20 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
	by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 21 Feb 2020 03:28:12 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01L3SBA740239416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2020 03:28:11 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D7105204E;
	Fri, 21 Feb 2020 03:28:11 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id C201652059;
	Fri, 21 Feb 2020 03:28:10 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 18E42A03E8;
	Fri, 21 Feb 2020 14:28:04 +1100 (AEDT)
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: alastair@d-silva.org
Subject: [PATCH v3 25/27] powerpc/powernv/pmem: Expose the serial number in sysfs
Date: Fri, 21 Feb 2020 14:27:18 +1100
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200221032720.33893-1-alastair@au1.ibm.com>
References: <20200221032720.33893-1-alastair@au1.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20022103-0016-0000-0000-000002E8CEC5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022103-0017-0000-0000-0000334BED98
Message-Id: <20200221032720.33893-26-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_19:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=928 bulkscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 mlxscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002210020
Message-ID-Hash: EKDRECFKL3JXN2Y3VHYWXWDMKRUOADMD
X-Message-ID-Hash: EKDRECFKL3JXN2Y3VHYWXWDMKRUOADMD
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.r
 u>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EKDRECFKL3JXN2Y3VHYWXWDMKRUOADMD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Alastair D'Silva <alastair@d-silva.org>

This information will be used by ndctl in userspace to help users identify
the device.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/powerpc/platforms/powernv/pmem/Makefile  |  2 +-
 arch/powerpc/platforms/powernv/pmem/ocxl.c    |  5 +++
 .../platforms/powernv/pmem/ocxl_internal.h    |  6 +++
 .../platforms/powernv/pmem/ocxl_sysfs.c       | 37 +++++++++++++++++++
 4 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/platforms/powernv/pmem/ocxl_sysfs.c

diff --git a/arch/powerpc/platforms/powernv/pmem/Makefile b/arch/powerpc/platforms/powernv/pmem/Makefile
index 4ceda25907d4..d02870806f30 100644
--- a/arch/powerpc/platforms/powernv/pmem/Makefile
+++ b/arch/powerpc/platforms/powernv/pmem/Makefile
@@ -4,4 +4,4 @@ ccflags-$(CONFIG_PPC_WERROR)	+= -Werror
 
 obj-$(CONFIG_OCXL_PMEM) += ocxlpmem.o
 
-ocxlpmem-y := ocxl.o ocxl_internal.o
+ocxlpmem-y := ocxl.o ocxl_internal.o ocxl_sysfs.o
diff --git a/arch/powerpc/platforms/powernv/pmem/ocxl.c b/arch/powerpc/platforms/powernv/pmem/ocxl.c
index 5cd1b6d78dd6..ec73713d05ad 100644
--- a/arch/powerpc/platforms/powernv/pmem/ocxl.c
+++ b/arch/powerpc/platforms/powernv/pmem/ocxl.c
@@ -1878,6 +1878,11 @@ static int probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err;
 	}
 
+	if (ocxlpmem_sysfs_add(ocxlpmem)) {
+		dev_err(&pdev->dev, "Could not create sysfs entries\n");
+		goto err;
+	}
+
 	elapsed = 0;
 	timeout = ocxlpmem->readiness_timeout + ocxlpmem->memory_available_timeout;
 	while (!is_usable(ocxlpmem, false)) {
diff --git a/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h b/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h
index 0eb7a35d24ae..12304ceace61 100644
--- a/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h
+++ b/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h
@@ -246,3 +246,9 @@ int ns_response_handled(const struct ocxlpmem *ocxlpmem);
  */
 void warn_status(const struct ocxlpmem *ocxlpmem, const char *message,
 		 u8 status);
+
+/**
+ * ocxlpmem_sysfs_add() - Create sysfs entries for an OpenCAPI persistent memory device
+ * @ocxlpmem: the device metadata
+ */
+int ocxlpmem_sysfs_add(struct ocxlpmem *ocxlpmem);
diff --git a/arch/powerpc/platforms/powernv/pmem/ocxl_sysfs.c b/arch/powerpc/platforms/powernv/pmem/ocxl_sysfs.c
new file mode 100644
index 000000000000..7829e4bc887d
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/pmem/ocxl_sysfs.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright 2018 IBM Corp.
+
+#include <linux/sysfs.h>
+#include <linux/capability.h>
+#include <linux/limits.h>
+#include <linux/firmware.h>
+#include "ocxl_internal.h"
+
+static ssize_t serial_show(struct device *device, struct device_attribute *attr,
+			   char *buf)
+{
+	struct ocxlpmem *ocxlpmem = container_of(device, struct ocxlpmem, dev);
+	const struct ocxl_fn_config *fn_config = ocxl_function_config(ocxlpmem->ocxl_fn);
+
+	return scnprintf(buf, PAGE_SIZE, "%llu\n", fn_config->serial);
+}
+
+static struct device_attribute attrs[] = {
+	__ATTR_RO(serial),
+};
+
+int ocxlpmem_sysfs_add(struct ocxlpmem *ocxlpmem)
+{
+	int i, rc;
+
+	for (i = 0; i < ARRAY_SIZE(attrs); i++) {
+		rc = device_create_file(&ocxlpmem->dev, &attrs[i]);
+		if (rc) {
+			for (; --i >= 0;)
+				device_remove_file(&ocxlpmem->dev, &attrs[i]);
+
+			return rc;
+		}
+	}
+	return 0;
+}
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184AB166D8A
	for <lists+linux-nvdimm@lfdr.de>; Fri, 21 Feb 2020 04:28:29 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 16A9910FC3614;
	Thu, 20 Feb 2020 19:29:15 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 975F810FC3608
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 19:29:12 -0800 (PST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01L3JGxn067466
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 22:28:20 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ubvvvt3-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 22:28:19 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Fri, 21 Feb 2020 03:28:16 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
	by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 21 Feb 2020 03:28:08 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01L3S89x51314814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2020 03:28:08 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE38F52052;
	Fri, 21 Feb 2020 03:28:07 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 45FC35204E;
	Fri, 21 Feb 2020 03:28:07 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id A59CDA027A;
	Fri, 21 Feb 2020 14:28:02 +1100 (AEDT)
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: alastair@d-silva.org
Subject: [PATCH v3 03/27] powerpc: Map & release OpenCAPI LPC memory
Date: Fri, 21 Feb 2020 14:26:56 +1100
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200221032720.33893-1-alastair@au1.ibm.com>
References: <20200221032720.33893-1-alastair@au1.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20022103-4275-0000-0000-000003A3FE60
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022103-4276-0000-0000-000038B80C78
Message-Id: <20200221032720.33893-4-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_19:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=494 bulkscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 mlxscore=0 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002210020
Message-ID-Hash: 3P6W74MO4WZE37YJKCFPQLYSY62JU3LS
X-Message-ID-Hash: 3P6W74MO4WZE37YJKCFPQLYSY62JU3LS
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.r
 u>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3P6W74MO4WZE37YJKCFPQLYSY62JU3LS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Alastair D'Silva <alastair@d-silva.org>

This patch adds platform support to map & release LPC memory.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/powerpc/include/asm/pnv-ocxl.h   |  4 +++
 arch/powerpc/platforms/powernv/ocxl.c | 43 +++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/powerpc/include/asm/pnv-ocxl.h b/arch/powerpc/include/asm/pnv-ocxl.h
index 7de82647e761..0b2a6707e555 100644
--- a/arch/powerpc/include/asm/pnv-ocxl.h
+++ b/arch/powerpc/include/asm/pnv-ocxl.h
@@ -32,5 +32,9 @@ extern int pnv_ocxl_spa_remove_pe_from_cache(void *platform_data, int pe_handle)
 
 extern int pnv_ocxl_alloc_xive_irq(u32 *irq, u64 *trigger_addr);
 extern void pnv_ocxl_free_xive_irq(u32 irq);
+#ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
+u64 pnv_ocxl_platform_lpc_setup(struct pci_dev *pdev, u64 size);
+void pnv_ocxl_platform_lpc_release(struct pci_dev *pdev);
+#endif
 
 #endif /* _ASM_PNV_OCXL_H */
diff --git a/arch/powerpc/platforms/powernv/ocxl.c b/arch/powerpc/platforms/powernv/ocxl.c
index 8c65aacda9c8..f2edbcc67361 100644
--- a/arch/powerpc/platforms/powernv/ocxl.c
+++ b/arch/powerpc/platforms/powernv/ocxl.c
@@ -475,6 +475,49 @@ void pnv_ocxl_spa_release(void *platform_data)
 }
 EXPORT_SYMBOL_GPL(pnv_ocxl_spa_release);
 
+#ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
+u64 pnv_ocxl_platform_lpc_setup(struct pci_dev *pdev, u64 size)
+{
+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
+	struct pnv_phb *phb = hose->private_data;
+	u32 bdfn = pci_dev_id(pdev);
+	__be64 base_addr_be64;
+	u64 base_addr;
+	int rc;
+
+	rc = opal_npu_mem_alloc(phb->opal_id, bdfn, size, &base_addr_be64);
+	if (rc) {
+		dev_warn(&pdev->dev,
+			 "OPAL could not allocate LPC memory, rc=%d\n", rc);
+		return 0;
+	}
+
+	base_addr = be64_to_cpu(base_addr_be64);
+
+	rc = check_hotplug_memory_addressable(base_addr >> PAGE_SHIFT,
+					      size >> PAGE_SHIFT);
+	if (rc)
+		return 0;
+
+	return base_addr;
+}
+EXPORT_SYMBOL_GPL(pnv_ocxl_platform_lpc_setup);
+
+void pnv_ocxl_platform_lpc_release(struct pci_dev *pdev)
+{
+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
+	struct pnv_phb *phb = hose->private_data;
+	u32 bdfn = pci_dev_id(pdev);
+	int rc;
+
+	rc = opal_npu_mem_release(phb->opal_id, bdfn);
+	if (rc)
+		dev_warn(&pdev->dev,
+			 "OPAL reported rc=%d when releasing LPC memory\n", rc);
+}
+EXPORT_SYMBOL_GPL(pnv_ocxl_platform_lpc_release);
+#endif
+
 int pnv_ocxl_spa_remove_pe_from_cache(void *platform_data, int pe_handle)
 {
 	struct spa_data *data = (struct spa_data *) platform_data;
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

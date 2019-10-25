Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D3AE42A4
	for <lists+linux-nvdimm@lfdr.de>; Fri, 25 Oct 2019 06:49:44 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E7FFF100EEBA9;
	Thu, 24 Oct 2019 21:50:59 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E0B33100EEBA6
	for <linux-nvdimm@lists.01.org>; Thu, 24 Oct 2019 21:50:57 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9P4lc0B035580
	for <linux-nvdimm@lists.01.org>; Fri, 25 Oct 2019 00:49:40 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2vus29t39n-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Fri, 25 Oct 2019 00:49:40 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Fri, 25 Oct 2019 05:49:37 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
	by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 25 Oct 2019 05:49:28 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9P4nRcY43188366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2019 04:49:27 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5BC94C044;
	Fri, 25 Oct 2019 04:49:27 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AD7A4C046;
	Fri, 25 Oct 2019 04:49:27 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Fri, 25 Oct 2019 04:49:27 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 6288AA0147;
	Fri, 25 Oct 2019 15:49:25 +1100 (AEDT)
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: alastair@d-silva.org
Subject: [PATCH 04/10] powerpc: Map & release OpenCAPI LPC memory
Date: Fri, 25 Oct 2019 15:46:59 +1100
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025044721.16617-1-alastair@au1.ibm.com>
References: <20191025044721.16617-1-alastair@au1.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19102504-0012-0000-0000-0000035D3A3C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102504-0013-0000-0000-000021986F33
Message-Id: <20191025044721.16617-5-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-25_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=876 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910250045
Message-ID-Hash: I5API2CEJLEVCY6VUV5EUWNUXTXBDNDO
X-Message-ID-Hash: I5API2CEJLEVCY6VUV5EUWNUXTXBDNDO
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Krzysztof Kozlowski <krzk@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Allison Randal <allison@lohutok.net>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>, Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.com>, Michal
  Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/I5API2CEJLEVCY6VUV5EUWNUXTXBDNDO/>
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
 arch/powerpc/include/asm/pnv-ocxl.h   |  2 ++
 arch/powerpc/platforms/powernv/ocxl.c | 41 +++++++++++++++++++++++++++
 include/linux/memory_hotplug.h        |  5 ++++
 mm/memory_hotplug.c                   |  3 +-
 4 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/pnv-ocxl.h b/arch/powerpc/include/asm/pnv-ocxl.h
index 7de82647e761..f8f8ffb48aa8 100644
--- a/arch/powerpc/include/asm/pnv-ocxl.h
+++ b/arch/powerpc/include/asm/pnv-ocxl.h
@@ -32,5 +32,7 @@ extern int pnv_ocxl_spa_remove_pe_from_cache(void *platform_data, int pe_handle)
 
 extern int pnv_ocxl_alloc_xive_irq(u32 *irq, u64 *trigger_addr);
 extern void pnv_ocxl_free_xive_irq(u32 irq);
+extern u64 pnv_ocxl_platform_lpc_setup(struct pci_dev *pdev, u64 size);
+extern void pnv_ocxl_platform_lpc_release(struct pci_dev *pdev);
 
 #endif /* _ASM_PNV_OCXL_H */
diff --git a/arch/powerpc/platforms/powernv/ocxl.c b/arch/powerpc/platforms/powernv/ocxl.c
index 8c65aacda9c8..c6d4234e0aba 100644
--- a/arch/powerpc/platforms/powernv/ocxl.c
+++ b/arch/powerpc/platforms/powernv/ocxl.c
@@ -475,6 +475,47 @@ void pnv_ocxl_spa_release(void *platform_data)
 }
 EXPORT_SYMBOL_GPL(pnv_ocxl_spa_release);
 
+u64 pnv_ocxl_platform_lpc_setup(struct pci_dev *pdev, u64 size)
+{
+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
+	struct pnv_phb *phb = hose->private_data;
+	u32 bdfn = (pdev->bus->number << 8) | pdev->devfn;
+	u64 base_addr = 0;
+	int rc;
+
+	rc = opal_npu_mem_alloc(phb->opal_id, bdfn, size, &base_addr);
+	if (rc) {
+		dev_warn(&pdev->dev,
+			 "OPAL could not allocate LPC memory, rc=%d\n", rc);
+		return 0;
+	}
+
+	base_addr = be64_to_cpu(base_addr);
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
+	u32 bdfn = (pdev->bus->number << 8) | pdev->devfn;
+	int rc;
+
+	rc = opal_npu_mem_release(phb->opal_id, bdfn);
+	if (rc)
+		dev_warn(&pdev->dev,
+			 "OPAL reported rc=%d when releasing LPC memory\n", rc);
+}
+EXPORT_SYMBOL_GPL(pnv_ocxl_platform_lpc_release);
+
+
 int pnv_ocxl_spa_remove_pe_from_cache(void *platform_data, int pe_handle)
 {
 	struct spa_data *data = (struct spa_data *) platform_data;
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index f46ea71b4ffd..3f5f1a642abe 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -339,6 +339,11 @@ static inline int remove_memory(int nid, u64 start, u64 size)
 static inline void __remove_memory(int nid, u64 start, u64 size) {}
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
+#if CONFIG_MEMORY_HOTPLUG_SPARSE
+int check_hotplug_memory_addressable(unsigned long pfn,
+		unsigned long nr_pages);
+#endif /* CONFIG_MEMORY_HOTPLUG_SPARSE */
+
 extern void __ref free_area_init_core_hotplug(int nid);
 extern int __add_memory(int nid, u64 start, u64 size);
 extern int add_memory(int nid, u64 start, u64 size);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 2cecf07b396f..b39827dbd071 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -278,7 +278,7 @@ static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
 	return 0;
 }
 
-static int check_hotplug_memory_addressable(unsigned long pfn,
+int check_hotplug_memory_addressable(unsigned long pfn,
 					    unsigned long nr_pages)
 {
 	const u64 max_addr = PFN_PHYS(pfn + nr_pages) - 1;
@@ -294,6 +294,7 @@ static int check_hotplug_memory_addressable(unsigned long pfn,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(check_hotplug_memory_addressable);
 
 /*
  * Reasonably generic function for adding memory.  It is
-- 
2.21.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

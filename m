Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DE01951C8
	for <lists+linux-nvdimm@lfdr.de>; Fri, 27 Mar 2020 08:12:41 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A577310FC3BC6;
	Fri, 27 Mar 2020 00:13:18 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=66.55.73.32; helo=ushosting.nmnhosting.com; envelope-from=alastair@d-silva.org; receiver=<UNKNOWN> 
Received: from ushosting.nmnhosting.com (ushosting.nmnhosting.com [66.55.73.32])
	by ml01.01.org (Postfix) with ESMTP id 57FA110FC3614
	for <linux-nvdimm@lists.01.org>; Fri, 27 Mar 2020 00:13:12 -0700 (PDT)
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
	by ushosting.nmnhosting.com (Postfix) with ESMTPS id 7A6E42DC682A;
	Fri, 27 Mar 2020 18:12:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
	s=201810a; t=1585293141;
	bh=+19ERjJVKb04vm4biVoKIgTzaFpr9UkwgZhCwlBFNZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kC/+/w081uhGq50IGkocqjNtFwFT1jfxjvZzedjpb8Zv7xxpRYbzhpwskvozUByYX
	 t1UJjPknJOIK7/+aPNJSLi6XUVox4iV1VJGSrm9Uj3vTDCzhS9i/TOfK53MveelFAp
	 bko/gKfzyjxtjuza/Zzfg3Lazv0GZ3jjrrXWCwg1vWGqkSIUVixWnbTR0MM7DkIYv3
	 zFps93hBiRICgFLlR41gopwn4qGl98D54wGKy1XO2IDsZXDn+oys9f7szHubl2erxM
	 98hazA7s2Hun5cwyF6UOwhIe8q33x097i9e5n+Rf5dLtx5rgNYv7jDOjsRKzeUUWlG
	 QJtJdRZQpQ31k0EmXeQHJNxR5CcCfaSVkJEql1R4IJPneJz+k6VO55PzRXId+c+3Px
	 jsmelTImM2q0z1bIl+aQUc38mZExstNx7apQSEylv5bAFmaRgbbpPWuz/9an1KZub8
	 Qzb9tJxzQmy5RvMKkAtuGKgUxYeA09K4wgOVNYnoBytc1Q07/DzuM4Np1Eq88rqcTp
	 81BizxxTLWlPoA9bTIfVasmLRUIxGJ5ZA+2wwklqRXTwAd2lZZB446Y4Rfva5ONbNx
	 2lC2CPiWB8qxGj796Eq1C0STbZHYpgpbtTNAlfrufYLT7q3aruf3ZSbLGO9v8DSjI7
	 /UOdhgZ/mEaSk8QieEOClM90=
Received: from localhost.lan ([10.0.1.179])
	by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTP id 02R7C4Ac045934;
	Fri, 27 Mar 2020 18:12:14 +1100 (AEDT)
	(envelope-from alastair@d-silva.org)
From: "Alastair D'Silva" <alastair@d-silva.org>
To: alastair@d-silva.org
Subject: [PATCH v4 03/25] powerpc/powernv: Map & release OpenCAPI LPC memory
Date: Fri, 27 Mar 2020 18:11:40 +1100
Message-Id: <20200327071202.2159885-4-alastair@d-silva.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327071202.2159885-1-alastair@d-silva.org>
References: <20200327071202.2159885-1-alastair@d-silva.org>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Fri, 27 Mar 2020 18:12:14 +1100 (AEDT)
Message-ID-Hash: VDTBKZR36JH7B6XH6ZNXL2MXSM3WVHG4
X-Message-ID-Hash: VDTBKZR36JH7B6XH6ZNXL2MXSM3WVHG4
X-MailFrom: alastair@d-silva.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.r
 u>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VDTBKZR36JH7B6XH6ZNXL2MXSM3WVHG4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch adds OPAL calls to powernv so that the OpenCAPI
driver can map & release LPC (Lowest Point of Coherency)  memory.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
---
 arch/powerpc/include/asm/pnv-ocxl.h   |  2 ++
 arch/powerpc/platforms/powernv/ocxl.c | 43 +++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/arch/powerpc/include/asm/pnv-ocxl.h b/arch/powerpc/include/asm/pnv-ocxl.h
index 7de82647e761..560a19bb71b7 100644
--- a/arch/powerpc/include/asm/pnv-ocxl.h
+++ b/arch/powerpc/include/asm/pnv-ocxl.h
@@ -32,5 +32,7 @@ extern int pnv_ocxl_spa_remove_pe_from_cache(void *platform_data, int pe_handle)
 
 extern int pnv_ocxl_alloc_xive_irq(u32 *irq, u64 *trigger_addr);
 extern void pnv_ocxl_free_xive_irq(u32 irq);
+u64 pnv_ocxl_platform_lpc_setup(struct pci_dev *pdev, u64 size);
+void pnv_ocxl_platform_lpc_release(struct pci_dev *pdev);
 
 #endif /* _ASM_PNV_OCXL_H */
diff --git a/arch/powerpc/platforms/powernv/ocxl.c b/arch/powerpc/platforms/powernv/ocxl.c
index 8c65aacda9c8..f13119a7c026 100644
--- a/arch/powerpc/platforms/powernv/ocxl.c
+++ b/arch/powerpc/platforms/powernv/ocxl.c
@@ -475,6 +475,49 @@ void pnv_ocxl_spa_release(void *platform_data)
 }
 EXPORT_SYMBOL_GPL(pnv_ocxl_spa_release);
 
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
+#ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
+	rc = check_hotplug_memory_addressable(base_addr >> PAGE_SHIFT,
+					      size >> PAGE_SHIFT);
+	if (rc)
+		return 0;
+#endif
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
+
 int pnv_ocxl_spa_remove_pe_from_cache(void *platform_data, int pe_handle)
 {
 	struct spa_data *data = (struct spa_data *) platform_data;
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

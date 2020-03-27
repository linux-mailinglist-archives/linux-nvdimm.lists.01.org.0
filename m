Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 362BD1951C1
	for <lists+linux-nvdimm@lfdr.de>; Fri, 27 Mar 2020 08:12:30 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E6DC910FC377E;
	Fri, 27 Mar 2020 00:13:15 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=66.55.73.32; helo=ushosting.nmnhosting.com; envelope-from=alastair@d-silva.org; receiver=<UNKNOWN> 
Received: from ushosting.nmnhosting.com (ushosting.nmnhosting.com [66.55.73.32])
	by ml01.01.org (Postfix) with ESMTP id D6F7410FC3614
	for <linux-nvdimm@lists.01.org>; Fri, 27 Mar 2020 00:13:11 -0700 (PDT)
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
	by ushosting.nmnhosting.com (Postfix) with ESMTPS id 738C32DC6829;
	Fri, 27 Mar 2020 18:12:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
	s=201810a; t=1585293141;
	bh=iql+P5xKXAK7D5i2p3DQ+jr9oIISWrdh7woNYcXPetQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l0xv6Qkr8VzM9ZG5lMS/tOu1JFQYeHTOxng+UyItI7K+BTfAdHAn5jl0Vc98MdH5L
	 svJHiChQtX5o8cTO3dd/fdihbcTq1JBv0lcp1/0c3Ilk5aLLpJOnQ1FQ15klXidcI9
	 HzlXm5cZbwJbsCl6Byo4R9vTIo8oGh+UAYH/OsCvx1PSCVjVWx1x/VXegbQyjMOR51
	 V4LP4dGgNfczNXy3uzX+jsLMyTr269zBNIgIk44+ayuhFugOXkoTzpijNadY64HMyY
	 8BwDM3tMr1Bi5xMuveddrROnBXS/aYhpLzKyHqCTZjwaY0YlGyMCNhgkHXqdKkM8/5
	 0ZIjsg3Sg0ou01WLekF/gpkzxV28dn8yvkIO0OcGrhzyxu4kmlzPyFEp1rskt5UCkv
	 N9C0oEHQG0GJR+e65zOkTmC8UkwdqUsHqI9kYTpXuJcrbPDSDPrsEljoPuI/NAibsH
	 GIm4KPDgwMdhe2CXHCLovQFSBQww6wbR+rGrzrWcwkr7P7ps+fjPRJYXnZjA8AkvVk
	 L//ADFtFERH1s3KlT4Xs2wPEdyiR6A3bFiTqt/0itt2K+YOTFn/gufrnwp3JV/eQJ5
	 XLE9vu40yNlig92V8LtkILAEFfP0NQDPOGhMQca160KxhQYz8l7pPQdHYe+9lxRZBJ
	 DGCfKUohqC6Ydh4+l1CuVtcI=
Received: from localhost.lan ([10.0.1.179])
	by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTP id 02R7C4Ag045934;
	Fri, 27 Mar 2020 18:12:15 +1100 (AEDT)
	(envelope-from alastair@d-silva.org)
From: "Alastair D'Silva" <alastair@d-silva.org>
To: alastair@d-silva.org
Subject: [PATCH v4 07/25] ocxl: Add functions to map/unmap LPC memory
Date: Fri, 27 Mar 2020 18:11:44 +1100
Message-Id: <20200327071202.2159885-8-alastair@d-silva.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327071202.2159885-1-alastair@d-silva.org>
References: <20200327071202.2159885-1-alastair@d-silva.org>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Fri, 27 Mar 2020 18:12:16 +1100 (AEDT)
Message-ID-Hash: QUFYV3PYVQB5UDLFGEYTLZIAU3UW7UK2
X-Message-ID-Hash: QUFYV3PYVQB5UDLFGEYTLZIAU3UW7UK2
X-MailFrom: alastair@d-silva.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.r
 u>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QUFYV3PYVQB5UDLFGEYTLZIAU3UW7UK2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add functions to map/unmap LPC memory

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>
---
 drivers/misc/ocxl/core.c          | 51 +++++++++++++++++++++++++++++++
 drivers/misc/ocxl/ocxl_internal.h |  3 ++
 include/misc/ocxl.h               | 21 +++++++++++++
 3 files changed, 75 insertions(+)

diff --git a/drivers/misc/ocxl/core.c b/drivers/misc/ocxl/core.c
index 2531c6cf19a0..75ff14e3882a 100644
--- a/drivers/misc/ocxl/core.c
+++ b/drivers/misc/ocxl/core.c
@@ -210,6 +210,56 @@ static void unmap_mmio_areas(struct ocxl_afu *afu)
 	release_fn_bar(afu->fn, afu->config.global_mmio_bar);
 }
 
+int ocxl_afu_map_lpc_mem(struct ocxl_afu *afu)
+{
+	struct pci_dev *dev = to_pci_dev(afu->fn->dev.parent);
+
+	if ((afu->config.lpc_mem_size + afu->config.special_purpose_mem_size) == 0)
+		return 0;
+
+	afu->lpc_base_addr = ocxl_link_lpc_map(afu->fn->link, dev);
+	if (afu->lpc_base_addr == 0)
+		return -EINVAL;
+
+	if (afu->config.lpc_mem_size > 0) {
+		afu->lpc_res.start = afu->lpc_base_addr + afu->config.lpc_mem_offset;
+		afu->lpc_res.end = afu->lpc_res.start + afu->config.lpc_mem_size - 1;
+	}
+
+	if (afu->config.special_purpose_mem_size > 0) {
+		afu->special_purpose_res.start = afu->lpc_base_addr +
+						 afu->config.special_purpose_mem_offset;
+		afu->special_purpose_res.end = afu->special_purpose_res.start +
+					       afu->config.special_purpose_mem_size - 1;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ocxl_afu_map_lpc_mem);
+
+struct resource *ocxl_afu_lpc_mem(struct ocxl_afu *afu)
+{
+	return &afu->lpc_res;
+}
+EXPORT_SYMBOL_GPL(ocxl_afu_lpc_mem);
+
+static void unmap_lpc_mem(struct ocxl_afu *afu)
+{
+	struct pci_dev *dev = to_pci_dev(afu->fn->dev.parent);
+
+	if (afu->lpc_res.start || afu->special_purpose_res.start) {
+		void *link = afu->fn->link;
+
+		// only release the link when the the last consumer calls release
+		ocxl_link_lpc_release(link, dev);
+
+		afu->lpc_res.start = 0;
+		afu->lpc_res.end = 0;
+		afu->special_purpose_res.start = 0;
+		afu->special_purpose_res.end = 0;
+	}
+}
+
 static int configure_afu(struct ocxl_afu *afu, u8 afu_idx, struct pci_dev *dev)
 {
 	int rc;
@@ -251,6 +301,7 @@ static int configure_afu(struct ocxl_afu *afu, u8 afu_idx, struct pci_dev *dev)
 
 static void deconfigure_afu(struct ocxl_afu *afu)
 {
+	unmap_lpc_mem(afu);
 	unmap_mmio_areas(afu);
 	reclaim_afu_pasid(afu);
 	reclaim_afu_actag(afu);
diff --git a/drivers/misc/ocxl/ocxl_internal.h b/drivers/misc/ocxl/ocxl_internal.h
index 2d7575225bd7..7b975a89db7b 100644
--- a/drivers/misc/ocxl/ocxl_internal.h
+++ b/drivers/misc/ocxl/ocxl_internal.h
@@ -52,6 +52,9 @@ struct ocxl_afu {
 	void __iomem *global_mmio_ptr;
 	u64 pp_mmio_start;
 	void *private;
+	u64 lpc_base_addr; /* Covers both LPC & special purpose memory */
+	struct resource lpc_res;
+	struct resource special_purpose_res;
 };
 
 enum ocxl_context_status {
diff --git a/include/misc/ocxl.h b/include/misc/ocxl.h
index 357ef1aadbc0..d8b0b4d46bfb 100644
--- a/include/misc/ocxl.h
+++ b/include/misc/ocxl.h
@@ -203,6 +203,27 @@ int ocxl_irq_set_handler(struct ocxl_context *ctx, int irq_id,
 
 // AFU Metadata
 
+/**
+ * ocxl_afu_map_lpc_mem() - Map the LPC system & special purpose memory for an AFU
+ * Do not call this during device discovery, as there may me multiple
+ * devices on a link, and the memory is mapped for the whole link, not
+ * just one device. It should only be called after all devices have
+ * registered their memory on the link.
+ *
+ * @afu: The AFU that has the LPC memory to map
+ *
+ * Returns 0 on success, negative on failure
+ */
+int ocxl_afu_map_lpc_mem(struct ocxl_afu *afu);
+
+/**
+ * ocxl_afu_lpc_mem() - Get the physical address range of LPC memory for an AFU
+ * @afu: The AFU associated with the LPC memory
+ *
+ * Returns a pointer to the resource struct for the physical address range
+ */
+struct resource *ocxl_afu_lpc_mem(struct ocxl_afu *afu);
+
 /**
  * ocxl_afu_config() - Get a pointer to the config for an AFU
  * @afu: a pointer to the AFU to get the config for
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

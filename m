Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE18166D8B
	for <lists+linux-nvdimm@lfdr.de>; Fri, 21 Feb 2020 04:28:29 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4AB8A10FC3619;
	Thu, 20 Feb 2020 19:29:16 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CF55D10FC360B
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 19:29:12 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01L3KI2v104777
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 22:28:19 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ubqh1hv-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 22:28:19 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Fri, 21 Feb 2020 03:28:17 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
	by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 21 Feb 2020 03:28:10 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01L3S9Kg59768916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2020 03:28:09 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 928ADAE045;
	Fri, 21 Feb 2020 03:28:09 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7655AE051;
	Fri, 21 Feb 2020 03:28:08 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Fri, 21 Feb 2020 03:28:08 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id EEA46A03B7;
	Fri, 21 Feb 2020 14:28:02 +1100 (AEDT)
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: alastair@d-silva.org
Subject: [PATCH v3 07/27] ocxl: Add functions to map/unmap LPC memory
Date: Fri, 21 Feb 2020 14:27:00 +1100
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200221032720.33893-1-alastair@au1.ibm.com>
References: <20200221032720.33893-1-alastair@au1.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20022103-0008-0000-0000-00000354F599
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022103-0009-0000-0000-00004A76073A
Message-Id: <20200221032720.33893-8-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_19:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=1 spamscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=808 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002210020
Message-ID-Hash: UGQZZ7SKWWTRVLDNO7ONZJ7YSBM257AS
X-Message-ID-Hash: UGQZZ7SKWWTRVLDNO7ONZJ7YSBM257AS
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.r
 u>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UGQZZ7SKWWTRVLDNO7ONZJ7YSBM257AS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Alastair D'Silva <alastair@d-silva.org>

Add functions to map/unmap LPC memory

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
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
index d0c8c4838f42..ce0cac1da416 100644
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

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B39B166D8C
	for <lists+linux-nvdimm@lfdr.de>; Fri, 21 Feb 2020 04:28:31 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6BFCF10FC3606;
	Thu, 20 Feb 2020 19:29:16 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1754810FC360A
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 19:29:14 -0800 (PST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01L3KR7K014756
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 22:28:21 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ubxwp4b-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 22:28:21 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Fri, 21 Feb 2020 03:28:17 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
	by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 21 Feb 2020 03:28:10 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01L3S9M755181326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2020 03:28:09 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 666E411C050;
	Fri, 21 Feb 2020 03:28:09 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4A3711C052;
	Fri, 21 Feb 2020 03:28:08 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Fri, 21 Feb 2020 03:28:08 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id DADBDA03B6;
	Fri, 21 Feb 2020 14:28:02 +1100 (AEDT)
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: alastair@d-silva.org
Subject: [PATCH v3 06/27] ocxl: Tally up the LPC memory on a link & allow it to be mapped
Date: Fri, 21 Feb 2020 14:26:59 +1100
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200221032720.33893-1-alastair@au1.ibm.com>
References: <20200221032720.33893-1-alastair@au1.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20022103-4275-0000-0000-000003A3FE62
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022103-4276-0000-0000-000038B80C79
Message-Id: <20200221032720.33893-7-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_19:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=3 malwarescore=0 mlxlogscore=892 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002210020
Message-ID-Hash: XBDRZWPM77ZEV22U32WUBNBFCLOMHPS5
X-Message-ID-Hash: XBDRZWPM77ZEV22U32WUBNBFCLOMHPS5
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.r
 u>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XBDRZWPM77ZEV22U32WUBNBFCLOMHPS5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Alastair D'Silva <alastair@d-silva.org>

Tally up the LPC memory on an OpenCAPI link & allow it to be mapped

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/misc/ocxl/core.c          | 10 ++++++
 drivers/misc/ocxl/link.c          | 53 +++++++++++++++++++++++++++++++
 drivers/misc/ocxl/ocxl_internal.h | 33 +++++++++++++++++++
 3 files changed, 96 insertions(+)

diff --git a/drivers/misc/ocxl/core.c b/drivers/misc/ocxl/core.c
index b7a09b21ab36..2531c6cf19a0 100644
--- a/drivers/misc/ocxl/core.c
+++ b/drivers/misc/ocxl/core.c
@@ -230,8 +230,18 @@ static int configure_afu(struct ocxl_afu *afu, u8 afu_idx, struct pci_dev *dev)
 	if (rc)
 		goto err_free_pasid;
 
+	if (afu->config.lpc_mem_size || afu->config.special_purpose_mem_size) {
+		rc = ocxl_link_add_lpc_mem(afu->fn->link, afu->config.lpc_mem_offset,
+					   afu->config.lpc_mem_size +
+					   afu->config.special_purpose_mem_size);
+		if (rc)
+			goto err_free_mmio;
+	}
+
 	return 0;
 
+err_free_mmio:
+	unmap_mmio_areas(afu);
 err_free_pasid:
 	reclaim_afu_pasid(afu);
 err_free_actag:
diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
index 58d111afd9f6..1e039cc5ebe5 100644
--- a/drivers/misc/ocxl/link.c
+++ b/drivers/misc/ocxl/link.c
@@ -84,6 +84,11 @@ struct ocxl_link {
 	int dev;
 	atomic_t irq_available;
 	struct spa *spa;
+	struct mutex lpc_mem_lock; /* protects lpc_mem & lpc_mem_sz */
+	u64 lpc_mem_sz; /* Total amount of LPC memory presented on the link */
+	u64 lpc_mem;
+	int lpc_consumers;
+
 	void *platform_data;
 };
 static struct list_head links_list = LIST_HEAD_INIT(links_list);
@@ -396,6 +401,8 @@ static int alloc_link(struct pci_dev *dev, int PE_mask, struct ocxl_link **out_l
 	if (rc)
 		goto err_spa;
 
+	mutex_init(&link->lpc_mem_lock);
+
 	/* platform specific hook */
 	rc = pnv_ocxl_spa_setup(dev, link->spa->spa_mem, PE_mask,
 				&link->platform_data);
@@ -711,3 +718,49 @@ void ocxl_link_free_irq(void *link_handle, int hw_irq)
 	atomic_inc(&link->irq_available);
 }
 EXPORT_SYMBOL_GPL(ocxl_link_free_irq);
+
+int ocxl_link_add_lpc_mem(void *link_handle, u64 offset, u64 size)
+{
+	struct ocxl_link *link = (struct ocxl_link *) link_handle;
+
+	// Check for overflow
+	if (offset > (offset + size))
+		return -EINVAL;
+
+	mutex_lock(&link->lpc_mem_lock);
+	link->lpc_mem_sz = max(link->lpc_mem_sz, offset + size);
+
+	mutex_unlock(&link->lpc_mem_lock);
+
+	return 0;
+}
+
+u64 ocxl_link_lpc_map(void *link_handle, struct pci_dev *pdev)
+{
+	struct ocxl_link *link = (struct ocxl_link *) link_handle;
+
+	mutex_lock(&link->lpc_mem_lock);
+
+	if(!link->lpc_mem)
+		link->lpc_mem = pnv_ocxl_platform_lpc_setup(pdev, link->lpc_mem_sz);
+
+	if(link->lpc_mem)
+		link->lpc_consumers++;
+	mutex_unlock(&link->lpc_mem_lock);
+
+	return link->lpc_mem;
+}
+
+void ocxl_link_lpc_release(void *link_handle, struct pci_dev *pdev)
+{
+	struct ocxl_link *link = (struct ocxl_link *) link_handle;
+
+	mutex_lock(&link->lpc_mem_lock);
+	WARN_ON(--link->lpc_consumers < 0);
+	if (link->lpc_consumers == 0) {
+		pnv_ocxl_platform_lpc_release(pdev);
+		link->lpc_mem = 0;
+	}
+
+	mutex_unlock(&link->lpc_mem_lock);
+}
diff --git a/drivers/misc/ocxl/ocxl_internal.h b/drivers/misc/ocxl/ocxl_internal.h
index 198e4e4bc51d..d0c8c4838f42 100644
--- a/drivers/misc/ocxl/ocxl_internal.h
+++ b/drivers/misc/ocxl/ocxl_internal.h
@@ -142,4 +142,37 @@ int ocxl_irq_offset_to_id(struct ocxl_context *ctx, u64 offset);
 u64 ocxl_irq_id_to_offset(struct ocxl_context *ctx, int irq_id);
 void ocxl_afu_irq_free_all(struct ocxl_context *ctx);
 
+/**
+ * ocxl_link_add_lpc_mem() - Increment the amount of memory required by an OpenCAPI link
+ *
+ * @link_handle: The OpenCAPI link handle
+ * @offset: The offset of the memory to add
+ * @size: The amount of memory to increment by
+ *
+ * Returns 0 on success, negative on overflow
+ */
+int ocxl_link_add_lpc_mem(void *link_handle, u64 offset, u64 size);
+
+/**
+ * ocxl_link_lpc_map() - Map the LPC memory for an OpenCAPI device
+ * Since LPC memory belongs to a link, the whole LPC memory available
+ * on the link must be mapped in order to make it accessible to a device.
+ * @link_handle: The OpenCAPI link handle
+ * @pdev: A device that is on the link
+ *
+ * Returns the address of the mapped LPC memory, or 0 on error
+ */
+u64 ocxl_link_lpc_map(void *link_handle, struct pci_dev *pdev);
+
+/**
+ * ocxl_link_lpc_release() - Release the LPC memory device for an OpenCAPI device
+ *
+ * Offlines LPC memory on an OpenCAPI link for a device. If this is the
+ * last device on the link to release the memory, unmap it from the link.
+ *
+ * @link_handle: The OpenCAPI link handle
+ * @pdev: A device that is on the link
+ */
+void ocxl_link_lpc_release(void *link_handle, struct pci_dev *pdev);
+
 #endif /* _OCXL_INTERNAL_H_ */
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

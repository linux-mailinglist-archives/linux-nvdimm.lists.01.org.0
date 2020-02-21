Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C141166D9C
	for <lists+linux-nvdimm@lfdr.de>; Fri, 21 Feb 2020 04:28:44 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9916E10FC363A;
	Thu, 20 Feb 2020 19:29:20 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9034410FC3606
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 19:29:15 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01L3KloG087240
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 22:28:23 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2y9ytr45eg-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 22:28:22 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Fri, 21 Feb 2020 03:28:18 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
	by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 21 Feb 2020 03:28:11 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01L3SAB843647038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2020 03:28:10 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F6F3AE04D;
	Fri, 21 Feb 2020 03:28:10 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC284AE051;
	Fri, 21 Feb 2020 03:28:09 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Fri, 21 Feb 2020 03:28:09 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 69933A03DC;
	Fri, 21 Feb 2020 14:28:03 +1100 (AEDT)
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: alastair@d-silva.org
Subject: [PATCH v3 15/27] powerpc/powernv/pmem: Add support for near storage commands
Date: Fri, 21 Feb 2020 14:27:08 +1100
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200221032720.33893-1-alastair@au1.ibm.com>
References: <20200221032720.33893-1-alastair@au1.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20022103-0012-0000-0000-00000388D1CF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022103-0013-0000-0000-000021C56A70
Message-Id: <20200221032720.33893-16-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_19:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=1 clxscore=1015 mlxlogscore=999 mlxscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210020
Message-ID-Hash: EGJILXPEUIULTNYXNULZ6VPHS24L7LBG
X-Message-ID-Hash: EGJILXPEUIULTNYXNULZ6VPHS24L7LBG
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.r
 u>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EGJILXPEUIULTNYXNULZ6VPHS24L7LBG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Alastair D'Silva <alastair@d-silva.org>

Similar to the previous patch, this adds support for near storage commands.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/powerpc/platforms/powernv/pmem/ocxl.c    |  6 +++
 .../platforms/powernv/pmem/ocxl_internal.c    | 41 +++++++++++++++++++
 .../platforms/powernv/pmem/ocxl_internal.h    | 37 +++++++++++++++++
 3 files changed, 84 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pmem/ocxl.c b/arch/powerpc/platforms/powernv/pmem/ocxl.c
index 4e782d22605b..b8bd7e703b19 100644
--- a/arch/powerpc/platforms/powernv/pmem/ocxl.c
+++ b/arch/powerpc/platforms/powernv/pmem/ocxl.c
@@ -259,12 +259,18 @@ static int setup_command_metadata(struct ocxlpmem *ocxlpmem)
 	int rc;
 
 	mutex_init(&ocxlpmem->admin_command.lock);
+	mutex_init(&ocxlpmem->ns_command.lock);
 
 	rc = extract_command_metadata(ocxlpmem, GLOBAL_MMIO_ACMA_CREQO,
 				      &ocxlpmem->admin_command);
 	if (rc)
 		return rc;
 
+	rc = extract_command_metadata(ocxlpmem, GLOBAL_MMIO_NSCMA_CREQO,
+					  &ocxlpmem->ns_command);
+	if (rc)
+		return rc;
+
 	return 0;
 }
 
diff --git a/arch/powerpc/platforms/powernv/pmem/ocxl_internal.c b/arch/powerpc/platforms/powernv/pmem/ocxl_internal.c
index 583f48023025..3e0b133feddf 100644
--- a/arch/powerpc/platforms/powernv/pmem/ocxl_internal.c
+++ b/arch/powerpc/platforms/powernv/pmem/ocxl_internal.c
@@ -133,6 +133,47 @@ int admin_response_handled(const struct ocxlpmem *ocxlpmem)
 				      OCXL_LITTLE_ENDIAN, GLOBAL_MMIO_CHI_ACRA);
 }
 
+int ns_command_request(struct ocxlpmem *ocxlpmem, u8 op_code)
+{
+	u64 val;
+	int rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu, GLOBAL_MMIO_CHI,
+					 OCXL_LITTLE_ENDIAN, &val);
+	if (rc)
+		return rc;
+
+	if (!(val & GLOBAL_MMIO_CHI_NSCRA))
+		return -EBUSY;
+
+	return scm_command_request(ocxlpmem, &ocxlpmem->ns_command, op_code);
+}
+
+int ns_response(const struct ocxlpmem *ocxlpmem)
+{
+	return command_response(ocxlpmem, &ocxlpmem->ns_command);
+}
+
+int ns_command_execute(const struct ocxlpmem *ocxlpmem)
+{
+	return ocxl_global_mmio_set64(ocxlpmem->ocxl_afu, GLOBAL_MMIO_HCI,
+				      OCXL_LITTLE_ENDIAN, GLOBAL_MMIO_HCI_NSCRW);
+}
+
+bool ns_command_complete(const struct ocxlpmem *ocxlpmem)
+{
+	u64 val = 0;
+	int rc = ocxlpmem_chi(ocxlpmem, &val);
+
+	WARN_ON(rc);
+
+	return (val & GLOBAL_MMIO_CHI_NSCRA) != 0;
+}
+
+int ns_response_handled(const struct ocxlpmem *ocxlpmem)
+{
+	return ocxl_global_mmio_set64(ocxlpmem->ocxl_afu, GLOBAL_MMIO_CHIC,
+				      OCXL_LITTLE_ENDIAN, GLOBAL_MMIO_CHI_NSCRA);
+}
+
 void warn_status(const struct ocxlpmem *ocxlpmem, const char *message,
 		     u8 status)
 {
diff --git a/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h b/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h
index 2fef68c71271..28e2020f6355 100644
--- a/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h
+++ b/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h
@@ -107,6 +107,7 @@ struct ocxlpmem {
 	struct ocxl_context *ocxl_context;
 	void *metadata_addr;
 	struct command_metadata admin_command;
+	struct command_metadata ns_command;
 	struct resource pmem_res;
 	struct nd_region *nd_region;
 	char fw_version[8+1];
@@ -175,6 +176,42 @@ int admin_command_complete_timeout(const struct ocxlpmem *ocxlpmem,
  */
 int admin_response_handled(const struct ocxlpmem *ocxlpmem);
 
+/**
+ * ns_command_request() - Issue a near storage command request
+ * @ocxlpmem: the device metadata
+ * @op_code: The op-code for the command
+ * Returns an identifier for the command, or negative on error
+ */
+int ns_command_request(struct ocxlpmem *ocxlpmem, u8 op_code);
+
+/**
+ * ns_response() - Validate a near storage response
+ * @ocxlpmem: the device metadata
+ * Returns the status code of the command, or negative on error
+ */
+int ns_response(const struct ocxlpmem *ocxlpmem);
+
+/**
+ * ns_command_execute() - Notify the controller to start processing a pending near storage command
+ * @ocxlpmem: the device metadata
+ * Returns 0 on success, negative on error
+ */
+int ns_command_execute(const struct ocxlpmem *ocxlpmem);
+
+/**
+ * ns_command_complete() - Is a near storage command executing
+ * @ocxlpmem: the device metadata
+ * Returns true if the previous admin command has completed
+ */
+bool ns_command_complete(const struct ocxlpmem *ocxlpmem);
+
+/**
+ * ns_response_handled() - Notify the controller that the near storage response has been handled
+ * @ocxlpmem: the device metadata
+ * Returns 0 on success, negative on failure
+ */
+int ns_response_handled(const struct ocxlpmem *ocxlpmem);
+
 /**
  * warn_status() - Emit a kernel warning showing a command status.
  * @ocxlpmem: the device metadata
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

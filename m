Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC64C10F5CD
	for <lists+linux-nvdimm@lfdr.de>; Tue,  3 Dec 2019 04:49:06 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5219B10097F0E;
	Mon,  2 Dec 2019 19:52:06 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4264410113673
	for <linux-nvdimm@lists.01.org>; Mon,  2 Dec 2019 19:51:55 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB33kkw9021117
	for <linux-nvdimm@lists.01.org>; Mon, 2 Dec 2019 22:48:32 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2wnehxj6um-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Mon, 02 Dec 2019 22:48:32 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Tue, 3 Dec 2019 03:48:28 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
	by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 3 Dec 2019 03:48:20 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB33mJeB45023540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Dec 2019 03:48:19 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DBB64204F;
	Tue,  3 Dec 2019 03:48:19 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 873FC42041;
	Tue,  3 Dec 2019 03:48:18 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue,  3 Dec 2019 03:48:18 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 96F42A03EE;
	Tue,  3 Dec 2019 14:48:13 +1100 (AEDT)
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: alastair@d-silva.org
Subject: [PATCH v2 24/27] nvdimm/ocxl: Implement Overwrite
Date: Tue,  3 Dec 2019 14:46:52 +1100
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191203034655.51561-1-alastair@au1.ibm.com>
References: <20191203034655.51561-1-alastair@au1.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19120303-4275-0000-0000-0000038A31E1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120303-4276-0000-0000-0000389DCDDC
Message-Id: <20191203034655.51561-25-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_06:2019-11-29,2019-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=1 impostorscore=0 mlxlogscore=999 priorityscore=1501
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912030032
Message-ID-Hash: E6CFGWA4QFSIB4RPU4BM6D5AGZ47NK2A
X-Message-ID-Hash: E6CFGWA4QFSIB4RPU4BM6D5AGZ47NK2A
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-dev@list
 s.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/E6CFGWA4QFSIB4RPU4BM6D5AGZ47NK2A/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Alastair D'Silva <alastair@d-silva.org>

The near storage command 'Secure Erase' overwrites all data on the
media.

This patch hooks it up to the security function 'overwrite'.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/nvdimm/ocxl/scm.c          | 164 ++++++++++++++++++++++++++++-
 drivers/nvdimm/ocxl/scm_internal.c |   1 +
 drivers/nvdimm/ocxl/scm_internal.h |  17 +++
 3 files changed, 180 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/ocxl/scm.c b/drivers/nvdimm/ocxl/scm.c
index a81eb5916eb3..8deb7862793c 100644
--- a/drivers/nvdimm/ocxl/scm.c
+++ b/drivers/nvdimm/ocxl/scm.c
@@ -169,6 +169,86 @@ static int scm_reserve_metadata(struct scm_data *scm_data,
 	return 0;
 }
 
+/**
+ * scm_overwrite() - Overwrite all data on the card
+ * @scm_data: The SCM device data
+ * Return: 0 on success
+ */
+int scm_overwrite(struct scm_data *scm_data)
+{
+	int rc;
+
+	mutex_lock(&scm_data->ns_command.lock);
+
+	rc = scm_ns_command_request(scm_data, NS_COMMAND_SECURE_ERASE);
+	if (rc)
+		goto out;
+
+	rc = scm_ns_command_execute(scm_data);
+	if (rc)
+		goto out;
+
+	scm_data->overwrite_state = SCM_OVERWRITE_BUSY;
+
+	return 0;
+
+out:
+	mutex_unlock(&scm_data->ns_command.lock);
+	return rc;
+}
+
+/**
+ * scm_secop_overwrite() - Overwrite all data on the card
+ * @nvdimm: The nvdimm representation of the SCM device to start the overwrite on
+ * @key_data: Unused (no security key implementation)
+ * Return: 0 on success
+ */
+static int scm_secop_overwrite(struct nvdimm *nvdimm,
+			       const struct nvdimm_key_data *key_data)
+{
+	struct scm_data *scm_data = nvdimm_provider_data(nvdimm);
+
+	return scm_overwrite(scm_data);
+}
+
+/**
+ * scm_secop_query_overwrite() - Get the current overwrite state
+ * @nvdimm: The nvdimm representation of the SCM device to start the overwrite on
+ * Return: 0 if successful or idle, -EBUSY if busy, -EFAULT if failed
+ */
+static int scm_secop_query_overwrite(struct nvdimm *nvdimm)
+{
+	struct scm_data *scm_data = nvdimm_provider_data(nvdimm);
+
+	if (scm_data->overwrite_state == SCM_OVERWRITE_BUSY)
+		return -EBUSY;
+
+	if (scm_data->overwrite_state == SCM_OVERWRITE_FAILED)
+		return -EFAULT;
+
+	return 0;
+}
+
+/**
+ * scm_secop_get_flags() - return the security flags for the SCM device
+ */
+static unsigned long scm_secop_get_flags(struct nvdimm *nvdimm,
+		enum nvdimm_passphrase_type ptype)
+{
+	struct scm_data *scm_data = nvdimm_provider_data(nvdimm);
+
+	if (scm_data->overwrite_state == SCM_OVERWRITE_BUSY)
+		return BIT(NVDIMM_SECURITY_OVERWRITE);
+
+	return BIT(NVDIMM_SECURITY_DISABLED);
+}
+
+static const struct nvdimm_security_ops sec_ops  = {
+	.get_flags = scm_secop_get_flags,
+	.overwrite = scm_secop_overwrite,
+	.query_overwrite = scm_secop_query_overwrite,
+};
+
 /**
  * scm_register_lpc_mem() - Discover persistent memory on a device and register it with the NVDIMM subsystem
  * @scm_data: The SCM device data
@@ -224,10 +304,10 @@ static int scm_register_lpc_mem(struct scm_data *scm_data)
 	set_bit(NDD_ALIASING, &nvdimm_flags);
 
 	snprintf(serial, sizeof(serial), "%llx", fn_config->serial);
-	nd_mapping_desc.nvdimm = nvdimm_create(scm_data->nvdimm_bus, scm_data,
+	nd_mapping_desc.nvdimm = __nvdimm_create(scm_data->nvdimm_bus, scm_data,
 				 scm_dimm_attribute_groups,
 				 nvdimm_flags, nvdimm_cmd_mask,
-				 0, NULL);
+				 0, NULL, serial, &sec_ops);
 	if (!nd_mapping_desc.nvdimm)
 		return -ENOMEM;
 
@@ -1530,6 +1610,83 @@ static void scm_dump_error_log(struct scm_data *scm_data)
 	kfree(buf);
 }
 
+static void scm_handle_nscra_doorbell(struct scm_data *scm_data)
+{
+	int rc;
+
+	if (scm_data->ns_command.op_code == NS_COMMAND_SECURE_ERASE) {
+		u64 success, attempted;
+
+
+		rc = scm_ns_response(scm_data);
+		if (rc < 0) {
+			scm_data->overwrite_state = SCM_OVERWRITE_FAILED;
+			mutex_unlock(&scm_data->ns_command.lock);
+			return;
+		}
+		if (rc != STATUS_SUCCESS)
+			scm_warn_status(scm_data, "Unexpected status from overwrite", rc);
+
+		rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+					     scm_data->ns_command.response_offset +
+					     NS_RESPONSE_SECURE_ERASE_ACCESSIBLE_SUCCESS,
+					     OCXL_HOST_ENDIAN, &success);
+		if (rc) {
+			scm_data->overwrite_state = SCM_OVERWRITE_FAILED;
+			mutex_unlock(&scm_data->ns_command.lock);
+			return;
+		}
+
+		rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+					     scm_data->ns_command.response_offset +
+					     NS_RESPONSE_SECURE_ERASE_ACCESSIBLE_ATTEMPTED,
+					     OCXL_HOST_ENDIAN, &attempted);
+		if (rc) {
+			scm_data->overwrite_state = SCM_OVERWRITE_FAILED;
+			mutex_unlock(&scm_data->ns_command.lock);
+			return;
+		}
+
+		scm_data->overwrite_state = SCM_OVERWRITE_SUCCESS;
+		if (success != attempted)
+			scm_data->overwrite_state = SCM_OVERWRITE_FAILED;
+
+		dev_info(&scm_data->dev,
+			 "Overwritten %llu/%llu accessible pages", success, attempted);
+
+		rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+					     scm_data->ns_command.response_offset +
+					     NS_RESPONSE_SECURE_ERASE_DEFECTIVE_SUCCESS,
+					     OCXL_HOST_ENDIAN, &success);
+		if (rc) {
+			scm_data->overwrite_state = SCM_OVERWRITE_FAILED;
+			mutex_unlock(&scm_data->ns_command.lock);
+			return;
+		}
+
+		rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+					     scm_data->ns_command.response_offset +
+					     NS_RESPONSE_SECURE_ERASE_DEFECTIVE_ATTEMPTED,
+					     OCXL_HOST_ENDIAN, &attempted);
+		if (rc) {
+			scm_data->overwrite_state = SCM_OVERWRITE_FAILED;
+			mutex_unlock(&scm_data->ns_command.lock);
+			return;
+		}
+
+		if (success != attempted)
+			scm_data->overwrite_state = SCM_OVERWRITE_FAILED;
+
+		dev_info(&scm_data->dev,
+			 "Overwritten %llu/%llu defective pages", success, attempted);
+
+		scm_ns_response_handled(scm_data);
+
+		mutex_unlock(&scm_data->ns_command.lock);
+		return;
+	}
+}
+
 static irqreturn_t scm_imn0_handler(void *private)
 {
 	struct scm_data *scm_data = private;
@@ -1537,6 +1694,9 @@ static irqreturn_t scm_imn0_handler(void *private)
 
 	(void)scm_chi(scm_data, &chi);
 
+	if (chi & GLOBAL_MMIO_CHI_NSCRA)
+		scm_handle_nscra_doorbell(scm_data);
+
 	if (chi & GLOBAL_MMIO_CHI_ELA) {
 		dev_warn(&scm_data->dev, "Error log is available\n");
 
diff --git a/drivers/nvdimm/ocxl/scm_internal.c b/drivers/nvdimm/ocxl/scm_internal.c
index 8fc849610eaa..db919a23c69b 100644
--- a/drivers/nvdimm/ocxl/scm_internal.c
+++ b/drivers/nvdimm/ocxl/scm_internal.c
@@ -173,6 +173,7 @@ int scm_ns_response_handled(const struct scm_data *scm_data)
 				      OCXL_LITTLE_ENDIAN, GLOBAL_MMIO_CHI_NSCRA);
 }
 
+
 void scm_warn_status(const struct scm_data *scm_data, const char *message,
 		     u8 status)
 {
diff --git a/drivers/nvdimm/ocxl/scm_internal.h b/drivers/nvdimm/ocxl/scm_internal.h
index af19813a7f75..4a29088612a9 100644
--- a/drivers/nvdimm/ocxl/scm_internal.h
+++ b/drivers/nvdimm/ocxl/scm_internal.h
@@ -70,6 +70,15 @@
 #define ADMIN_COMMAND_CMD_CAPS		0x08u
 #define ADMIN_COMMAND_MAX		0x08u
 
+#define NS_COMMAND_SECURE_ERASE	0x20ull
+
+#define NS_RESPONSE_SECURE_ERASE_ACCESSIBLE_SUCCESS 0x20
+#define NS_RESPONSE_SECURE_ERASE_ACCESSIBLE_ATTEMPTED 0x28
+#define NS_RESPONSE_SECURE_ERASE_DEFECTIVE_SUCCESS 0x30
+#define NS_RESPONSE_SECURE_ERASE_DEFECTIVE_ATTEMPTED 0x38
+
+
+
 #define STATUS_SUCCESS		0x00
 #define STATUS_MEM_UNAVAILABLE	0x20
 #define STATUS_BAD_OPCODE	0x50
@@ -99,6 +108,13 @@ struct scm_function_0 {
 	struct ocxl_fn *ocxl_fn;
 };
 
+enum overwrite_state {
+	SCM_OVERWRITE_IDLE = 0,
+	SCM_OVERWRITE_BUSY,
+	SCM_OVERWRITE_SUCCESS,
+	SCM_OVERWRITE_FAILED
+};
+
 struct scm_data {
 	struct device dev;
 	struct pci_dev *pdev;
@@ -116,6 +132,7 @@ struct scm_data {
 	void *metadata_addr;
 	struct command_metadata admin_command;
 	struct command_metadata ns_command;
+	enum overwrite_state overwrite_state;
 	struct resource scm_res;
 	struct nd_region *nd_region;
 	struct eventfd_ctx *ev_ctx;
-- 
2.23.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

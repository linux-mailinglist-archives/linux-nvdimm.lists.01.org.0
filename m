Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6AF10F5B6
	for <lists+linux-nvdimm@lfdr.de>; Tue,  3 Dec 2019 04:48:42 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 242661011367D;
	Mon,  2 Dec 2019 19:51:56 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D9D4710113660
	for <linux-nvdimm@lists.01.org>; Mon,  2 Dec 2019 19:51:52 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB33klVe001076
	for <linux-nvdimm@lists.01.org>; Mon, 2 Dec 2019 22:48:29 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2wm6myr92n-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Mon, 02 Dec 2019 22:48:29 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Tue, 3 Dec 2019 03:48:26 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
	by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 3 Dec 2019 03:48:18 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB33mHc547710208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Dec 2019 03:48:17 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AAED3AE056;
	Tue,  3 Dec 2019 03:48:17 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13FA0AE051;
	Tue,  3 Dec 2019 03:48:17 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue,  3 Dec 2019 03:48:17 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 178A2A03DF;
	Tue,  3 Dec 2019 14:48:13 +1100 (AEDT)
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: alastair@d-silva.org
Subject: [PATCH v2 13/27] nvdimm/ocxl: Add support for Admin commands
Date: Tue,  3 Dec 2019 14:46:41 +1100
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191203034655.51561-1-alastair@au1.ibm.com>
References: <20191203034655.51561-1-alastair@au1.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19120303-0008-0000-0000-0000033C0FDF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120303-0009-0000-0000-00004A5B289C
Message-Id: <20191203034655.51561-14-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_06:2019-11-29,2019-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=1 adultscore=0
 bulkscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912030032
Message-ID-Hash: PQPRX5GQRNGERYYMJJRQT7BLMCLHMU36
X-Message-ID-Hash: PQPRX5GQRNGERYYMJJRQT7BLMCLHMU36
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-dev@list
 s.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PQPRX5GQRNGERYYMJJRQT7BLMCLHMU36/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Alastair D'Silva <alastair@d-silva.org>

This patch requests the metadata required to issue admin commands, as well
as some helper functions to construct and check the completion of the
commands.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/nvdimm/ocxl/scm.c          |  67 +++++++++++++
 drivers/nvdimm/ocxl/scm_internal.c | 152 +++++++++++++++++++++++++++++
 drivers/nvdimm/ocxl/scm_internal.h |  62 ++++++++++++
 3 files changed, 281 insertions(+)

diff --git a/drivers/nvdimm/ocxl/scm.c b/drivers/nvdimm/ocxl/scm.c
index 8088f65c289e..1e175f3c3cf2 100644
--- a/drivers/nvdimm/ocxl/scm.c
+++ b/drivers/nvdimm/ocxl/scm.c
@@ -267,6 +267,58 @@ static int scm_register_lpc_mem(struct scm_data *scm_data)
 	return 0;
 }
 
+/**
+ * scm_extract_command_metadata() - Extract command data from MMIO & save it for further use
+ * @scm_data: a pointer to the SCM device data
+ * @offset: The base address of the command data structures (address of CREQO)
+ * @command_metadata: A pointer to the command metadata to populate
+ * Return: 0 on success, negative on failure
+ */
+static int scm_extract_command_metadata(struct scm_data *scm_data, u32 offset,
+					struct command_metadata *command_metadata)
+{
+	int rc;
+	u64 tmp;
+
+	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu, offset, OCXL_LITTLE_ENDIAN,
+				     &tmp);
+	if (rc)
+		return rc;
+
+	command_metadata->request_offset = tmp >> 32;
+	command_metadata->response_offset = tmp & 0xFFFFFFFF;
+
+	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu, offset + 8, OCXL_LITTLE_ENDIAN,
+				     &tmp);
+	if (rc)
+		return rc;
+
+	command_metadata->data_offset = tmp >> 32;
+	command_metadata->data_size = tmp & 0xFFFFFFFF;
+
+	command_metadata->id = 0;
+
+	return 0;
+}
+
+/**
+ * scm_setup_command_metadata() - Set up the command metadata
+ * @scm_data: a pointer to the SCM device data
+ */
+static int scm_setup_command_metadata(struct scm_data *scm_data)
+{
+	int rc;
+
+	mutex_init(&scm_data->admin_command.lock);
+
+	rc = scm_extract_command_metadata(scm_data, GLOBAL_MMIO_ACMA_CREQO,
+					  &scm_data->admin_command);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
 /**
  * scm_is_usable() - Is a controller usable?
  * @scm_data: a pointer to the SCM device data
@@ -276,6 +328,8 @@ static bool scm_is_usable(const struct scm_data *scm_data)
 {
 	u64 chi = 0;
 	int rc = scm_chi(scm_data, &chi);
+	if (rc)
+		return false;
 
 	if (!(chi & GLOBAL_MMIO_CHI_CRDY)) {
 		dev_err(&scm_data->dev, "SCM controller is not ready.\n");
@@ -502,6 +556,14 @@ static int scm_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 	scm_data->pdev = pdev;
 
+	scm_data->timeouts[ADMIN_COMMAND_ERRLOG] = 2000; // ms
+	scm_data->timeouts[ADMIN_COMMAND_HEARTBEAT] = 100; // ms
+	scm_data->timeouts[ADMIN_COMMAND_SMART] = 100; // ms
+	scm_data->timeouts[ADMIN_COMMAND_CONTROLLER_DUMP] = 1000; // ms
+	scm_data->timeouts[ADMIN_COMMAND_CONTROLLER_STATS] = 100; // ms
+	scm_data->timeouts[ADMIN_COMMAND_SHUTDOWN] = 1000; // ms
+	scm_data->timeouts[ADMIN_COMMAND_FW_UPDATE] = 16000; // ms
+
 	pci_set_drvdata(pdev, scm_data);
 
 	scm_data->ocxl_fn = ocxl_function_open(pdev);
@@ -543,6 +605,11 @@ static int scm_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err;
 	}
 
+	if (scm_setup_command_metadata(scm_data)) {
+		dev_err(&pdev->dev, "Could not read OCXL command matada\n");
+		goto err;
+	}
+
 	elapsed = 0;
 	timeout = scm_data->readiness_timeout + scm_data->memory_available_timeout;
 	while (!scm_is_usable(scm_data)) {
diff --git a/drivers/nvdimm/ocxl/scm_internal.c b/drivers/nvdimm/ocxl/scm_internal.c
index 72d3c0e7d846..7b11b56863fb 100644
--- a/drivers/nvdimm/ocxl/scm_internal.c
+++ b/drivers/nvdimm/ocxl/scm_internal.c
@@ -17,3 +17,155 @@ int scm_chi(const struct scm_data *scm_data, u64 *chi)
 
 	return 0;
 }
+
+static int scm_command_request(const struct scm_data *scm_data,
+			       struct command_metadata *cmd, u8 op_code)
+{
+	u64 val = op_code;
+	int rc;
+	u8 i;
+
+	cmd->op_code = op_code;
+	cmd->id++;
+
+	val |= ((u64)cmd->id) << 16;
+
+	rc = ocxl_global_mmio_write64(scm_data->ocxl_afu, cmd->request_offset,
+				      OCXL_LITTLE_ENDIAN, val);
+	if (rc)
+		return rc;
+
+	for (i = 0x08; i <= 0x38; i += 0x08) {
+		rc = ocxl_global_mmio_write64(scm_data->ocxl_afu,
+					      cmd->request_offset + i,
+					      OCXL_LITTLE_ENDIAN, 0);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+int scm_admin_command_request(struct scm_data *scm_data, u8 op_code)
+{
+	u64 val;
+	int rc = ocxl_global_mmio_read64(scm_data->ocxl_afu, GLOBAL_MMIO_CHI,
+					 OCXL_LITTLE_ENDIAN, &val);
+	if (rc)
+		return rc;
+
+	return scm_command_request(scm_data, &scm_data->admin_command, op_code);
+}
+
+static int scm_command_response(const struct scm_data *scm_data,
+			 const struct command_metadata *cmd)
+{
+	u64 val;
+	u16 id;
+	u8 status;
+	int rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+					 cmd->response_offset,
+					 OCXL_LITTLE_ENDIAN, &val);
+	if (rc)
+		return rc;
+
+	status = val & 0xff;
+	id = (val >> 16) & 0xffff;
+
+	if (id != cmd->id) {
+		dev_warn(&scm_data->dev,
+			 "Expected response for command %d, but received response for command %d instead.\n",
+			 cmd->id, id);
+	}
+
+	return status;
+}
+
+int scm_admin_response(const struct scm_data *scm_data)
+{
+	return scm_command_response(scm_data, &scm_data->admin_command);
+}
+
+
+int scm_admin_command_execute(const struct scm_data *scm_data)
+{
+	return ocxl_global_mmio_set64(scm_data->ocxl_afu, GLOBAL_MMIO_HCI,
+				      OCXL_LITTLE_ENDIAN, GLOBAL_MMIO_HCI_ACRW);
+}
+
+static bool scm_admin_command_complete(const struct scm_data *scm_data)
+{
+	u64 val = 0;
+
+	int rc = scm_chi(scm_data, &val);
+
+	WARN_ON(rc);
+
+	return (val & GLOBAL_MMIO_CHI_ACRA) != 0;
+}
+
+int scm_admin_command_complete_timeout(const struct scm_data *scm_data,
+				       int command)
+{
+	u32 timeout = scm_data->timeouts[command];
+	// 32 is the next power of 2 greater than the 20ms minimum for msleep
+#define TIMEOUT_SLEEP_MILLIS 32
+	timeout /= TIMEOUT_SLEEP_MILLIS;
+	if (!timeout)
+		timeout = SCM_DEFAULT_TIMEOUT / TIMEOUT_SLEEP_MILLIS;
+
+	while (timeout-- > 0) {
+		if (scm_admin_command_complete(scm_data))
+			return 0;
+		msleep(TIMEOUT_SLEEP_MILLIS);
+	}
+
+	if (scm_admin_command_complete(scm_data))
+		return 0;
+
+	return -EBUSY;
+}
+
+int scm_admin_response_handled(const struct scm_data *scm_data)
+{
+	return ocxl_global_mmio_set64(scm_data->ocxl_afu, GLOBAL_MMIO_CHIC,
+				      OCXL_LITTLE_ENDIAN, GLOBAL_MMIO_CHI_ACRA);
+}
+
+void scm_warn_status(const struct scm_data *scm_data, const char *message,
+		     u8 status)
+{
+	const char *text = "Unknown";
+
+	switch (status) {
+	case STATUS_SUCCESS:
+		text = "Success";
+		break;
+
+	case STATUS_MEM_UNAVAILABLE:
+		text = "Persistent memory unavailable";
+		break;
+
+	case STATUS_BAD_OPCODE:
+		text = "Bad opcode";
+		break;
+
+	case STATUS_BAD_REQUEST_PARM:
+		text = "Bad request parameter";
+		break;
+
+	case STATUS_BAD_DATA_PARM:
+		text = "Bad data parameter";
+		break;
+
+	case STATUS_DEBUG_BLOCKED:
+		text = "Debug action blocked";
+		break;
+
+	case STATUS_FAIL:
+		text = "Failed";
+		break;
+	}
+
+	dev_warn(&scm_data->dev, "%s: %s (%x)\n", message, text, status);
+}
diff --git a/drivers/nvdimm/ocxl/scm_internal.h b/drivers/nvdimm/ocxl/scm_internal.h
index 584450f55e30..9bff684cd069 100644
--- a/drivers/nvdimm/ocxl/scm_internal.h
+++ b/drivers/nvdimm/ocxl/scm_internal.h
@@ -6,6 +6,8 @@
 #include <linux/libnvdimm.h>
 #include <linux/mm.h>
 
+#define SCM_DEFAULT_TIMEOUT 100
+
 #define GLOBAL_MMIO_CHI		0x000
 #define GLOBAL_MMIO_CHIC	0x008
 #define GLOBAL_MMIO_CHIE	0x010
@@ -80,6 +82,16 @@
 
 #define SCM_LABEL_AREA_SIZE	(1UL << PA_SECTION_SHIFT)
 
+struct command_metadata {
+	u32 request_offset;
+	u32 response_offset;
+	u32 data_offset;
+	u32 data_size;
+	struct mutex lock;
+	u16 id;
+	u8 op_code;
+};
+
 struct scm_function_0 {
 	struct pci_dev *pdev;
 	struct ocxl_fn *ocxl_fn;
@@ -95,9 +107,11 @@ struct scm_data {
 	struct ocxl_afu *ocxl_afu;
 	struct ocxl_context *ocxl_context;
 	void *metadata_addr;
+	struct command_metadata admin_command;
 	struct resource scm_res;
 	struct nd_region *nd_region;
 	char fw_version[8+1];
+	u32 timeouts[ADMIN_COMMAND_MAX+1];
 
 	u32 max_controller_dump_size;
 	u16 scm_revision; // major/minor
@@ -122,3 +136,51 @@ struct scm_data {
  * Returns 0 on success, negative on error
  */
 int scm_chi(const struct scm_data *scm_data, u64 *chi);
+
+/**
+ * scm_admin_command_request() - Issue an admin command request
+ * @scm_data: a pointer to the SCM device data
+ * @op_code: The op-code for the command
+ *
+ * Returns an identifier for the command, or negative on error
+ */
+int scm_admin_command_request(struct scm_data *scm_data, u8 op_code);
+
+/**
+ * scm_admin_response() - Validate an admin response
+ * @scm_data: a pointer to the SCM device data
+ * Returns the status code of the command, or negative on error
+ */
+int scm_admin_response(const struct scm_data *scm_data);
+
+/**
+ * scm_admin_command_execute() - Notify the controller to start processing a pending admin command
+ * @scm_data: a pointer to the SCM device data
+ * Returns 0 on success, negative on error
+ */
+int scm_admin_command_execute(const struct scm_data *scm_data);
+
+/**
+ * scm_admin_command_complete_timeout() - Wait for an admin command to finish executing
+ * @scm_data: a pointer to the SCM device data
+ * @command: the admin command to wait for completion (determines the timeout)
+ * Returns 0 on success, -EBUSY on timeout
+ */
+int scm_admin_command_complete_timeout(const struct scm_data *scm_data,
+				       int command);
+
+/**
+ * scm_admin_response_handled() - Notify the controller that the admin response has been handled
+ * @scm_data: a pointer to the SCM device data
+ * Returns 0 on success, negative on failure
+ */
+int scm_admin_response_handled(const struct scm_data *scm_data);
+
+/**
+ * scm_warn_status() - Emit a kernel warning showing a command status.
+ * @scm_data: a pointer to the SCM device data
+ * @message: A message to accompany the warning
+ * @status: The command status
+ */
+void scm_warn_status(const struct scm_data *scm_data, const char *message,
+		     u8 status);
-- 
2.23.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6B910F5C0
	for <lists+linux-nvdimm@lfdr.de>; Tue,  3 Dec 2019 04:48:54 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4127810113695;
	Mon,  2 Dec 2019 19:52:00 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A46E210113666
	for <linux-nvdimm@lists.01.org>; Mon,  2 Dec 2019 19:51:53 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB33kk7K006770
	for <linux-nvdimm@lists.01.org>; Mon, 2 Dec 2019 22:48:30 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2wm6cy9se7-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Mon, 02 Dec 2019 22:48:30 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Tue, 3 Dec 2019 03:48:27 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
	by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 3 Dec 2019 03:48:20 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB33mJmA39256506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Dec 2019 03:48:19 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24ABEAE051;
	Tue,  3 Dec 2019 03:48:19 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 842B4AE055;
	Tue,  3 Dec 2019 03:48:18 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue,  3 Dec 2019 03:48:18 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 6FC63A03E9;
	Tue,  3 Dec 2019 14:48:13 +1100 (AEDT)
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: alastair@d-silva.org
Subject: [PATCH v2 21/27] nvdimm/ocxl: Support firmware update via sysfs
Date: Tue,  3 Dec 2019 14:46:49 +1100
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191203034655.51561-1-alastair@au1.ibm.com>
References: <20191203034655.51561-1-alastair@au1.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19120303-0028-0000-0000-000003C3CC75
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120303-0029-0000-0000-00002486E435
Message-Id: <20191203034655.51561-22-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_06:2019-11-29,2019-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 priorityscore=1501 suspectscore=1 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912030032
Message-ID-Hash: R7GSYEVWTFR2I6HHBDPBX5QUVEQNKGZL
X-Message-ID-Hash: R7GSYEVWTFR2I6HHBDPBX5QUVEQNKGZL
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-dev@list
 s.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/R7GSYEVWTFR2I6HHBDPBX5QUVEQNKGZL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Alastair D'Silva <alastair@d-silva.org>

This patch allows the firmware of an OpenCAPI SCM card to be update by
writing a firmware file to a file in sysfs.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/nvdimm/ocxl/Makefile       |   2 +-
 drivers/nvdimm/ocxl/scm.c          |   5 +
 drivers/nvdimm/ocxl/scm_internal.c |  25 +++++
 drivers/nvdimm/ocxl/scm_internal.h |  14 +++
 drivers/nvdimm/ocxl/scm_sysfs.c    | 163 +++++++++++++++++++++++++++++
 5 files changed, 208 insertions(+), 1 deletion(-)
 create mode 100644 drivers/nvdimm/ocxl/scm_sysfs.c

diff --git a/drivers/nvdimm/ocxl/Makefile b/drivers/nvdimm/ocxl/Makefile
index 9b6e31f0eb3e..b172cef39de4 100644
--- a/drivers/nvdimm/ocxl/Makefile
+++ b/drivers/nvdimm/ocxl/Makefile
@@ -4,4 +4,4 @@ ccflags-$(CONFIG_PPC_WERROR)	+= -Werror
 
 obj-$(CONFIG_OCXL_SCM) += ocxlscm.o
 
-ocxlscm-y := scm.o scm_internal.o
+ocxlscm-y := scm.o scm_internal.o scm_sysfs.o
diff --git a/drivers/nvdimm/ocxl/scm.c b/drivers/nvdimm/ocxl/scm.c
index d482b3213a02..8a30c887b5ed 100644
--- a/drivers/nvdimm/ocxl/scm.c
+++ b/drivers/nvdimm/ocxl/scm.c
@@ -1503,6 +1503,11 @@ static int scm_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err;
 	}
 
+	if (scm_sysfs_add(scm_data)) {
+		dev_err(&pdev->dev, "Could not create SCM sysfs entries\n");
+		goto err;
+	}
+
 	elapsed = 0;
 	timeout = scm_data->readiness_timeout + scm_data->memory_available_timeout;
 	while (!scm_is_usable(scm_data)) {
diff --git a/drivers/nvdimm/ocxl/scm_internal.c b/drivers/nvdimm/ocxl/scm_internal.c
index c405f1d8afb8..8fc849610eaa 100644
--- a/drivers/nvdimm/ocxl/scm_internal.c
+++ b/drivers/nvdimm/ocxl/scm_internal.c
@@ -210,3 +210,28 @@ void scm_warn_status(const struct scm_data *scm_data, const char *message,
 
 	dev_warn(&scm_data->dev, "%s: %s (%x)\n", message, text, status);
 }
+
+void scm_warn_status_fw_update(const struct scm_data *scm_data,
+			       const char *message, u8 status)
+{
+	const char *text;
+
+	switch (status) {
+	case STATUS_FW_UPDATE_BLOCKED:
+		text = "Firmware update is blocked, please try again later";
+		break;
+
+	case STATUS_FW_ARG_INVALID:
+		text = "Internal error in SCM firmware update mechanism";
+		break;
+
+	case STATUS_FW_INVALID:
+		text = "Firmware content is invalid, please verify firmware update file";
+		break;
+
+	default:
+		return scm_warn_status(scm_data, message, status);
+	}
+
+	dev_warn(&scm_data->dev, "%s: %s (%x)\n", message, text, status);
+}
diff --git a/drivers/nvdimm/ocxl/scm_internal.h b/drivers/nvdimm/ocxl/scm_internal.h
index 693fd59f8bde..af19813a7f75 100644
--- a/drivers/nvdimm/ocxl/scm_internal.h
+++ b/drivers/nvdimm/ocxl/scm_internal.h
@@ -137,6 +137,12 @@ struct scm_data {
 			   */
 };
 
+/**
+ * Create sysfs entries for an SCM device
+ * scm_data: The SCM metadata
+ */
+int scm_sysfs_add(struct scm_data *scm_data);
+
 /**
  * scm_chi() - Get the value of the CHI register
  * @scm_data: The SCM metadata
@@ -230,3 +236,11 @@ int scm_ns_response_handled(const struct scm_data *scm_data);
 void scm_warn_status(const struct scm_data *scm_data, const char *message,
 		     u8 status);
 
+/**
+ * scm_warn_status_fw_update() - Emit a kernel warning showing a command status.
+ * @scm_data: a pointer to the SCM device data
+ * @message: A message to accompany the warning
+ * @status: The command status
+ */
+void scm_warn_status_fw_update(const struct scm_data *scm_data,
+			       const char *message, u8 status);
diff --git a/drivers/nvdimm/ocxl/scm_sysfs.c b/drivers/nvdimm/ocxl/scm_sysfs.c
new file mode 100644
index 000000000000..a04e8a74d0c5
--- /dev/null
+++ b/drivers/nvdimm/ocxl/scm_sysfs.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright 2018 IBM Corp.
+
+#include <linux/sysfs.h>
+#include <linux/capability.h>
+#include <linux/limits.h>
+#include <linux/firmware.h>
+#include "scm_internal.h"
+
+static ssize_t fw_version_show(struct device *device,
+			       struct device_attribute *attr, char *buf)
+{
+	struct scm_data *scm_data = container_of(device, struct scm_data, dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%s\n", scm_data->fw_version);
+}
+
+#define SCM_FWUPDATE_BLOCK_SIZE	32768
+
+/**
+ * scm_update_firmware() - Write a 32kB block of data to firmware
+ * The block may be less than 32kB if it is the last one
+ *
+ * scm_data the SCM device metadata
+ * offset: the offset of the start of the block
+ * buf: the block data
+ * size: the size of the block
+ */
+static ssize_t scm_update_firmware(struct scm_data *scm_data, size_t offset,
+				   const char *buf, size_t size)
+{
+	int rc;
+	size_t i;
+	u64 val;
+
+	if (size > SCM_FWUPDATE_BLOCK_SIZE)
+		return -EINVAL;
+
+	rc = scm_admin_command_request(scm_data, ADMIN_COMMAND_FW_UPDATE);
+	if (rc)
+		return rc;
+
+	val = (((u64)offset) << 32) | size;
+	rc = ocxl_global_mmio_write64(scm_data->ocxl_afu,
+				      scm_data->admin_command.request_offset + 8,
+				      OCXL_LITTLE_ENDIAN, val);
+	if (rc)
+		return rc;
+
+	for (i = 0; i < size; i += 8) {
+		val = *(u64 *)(buf + i);
+		rc = ocxl_global_mmio_write64(scm_data->ocxl_afu,
+					      scm_data->admin_command.data_offset + i,
+					      OCXL_HOST_ENDIAN, val);
+		if (rc)
+			return rc;
+	}
+
+	rc = scm_admin_command_execute(scm_data);
+	if (rc)
+		return rc;
+
+	rc = scm_admin_command_complete_timeout(scm_data,
+						ADMIN_COMMAND_FW_UPDATE);
+	if (rc < 0) {
+		dev_err(&scm_data->dev, "Firmware update timeout\n");
+		return rc;
+	}
+
+	rc = scm_admin_response(scm_data);
+	if (rc < 0)
+		return rc;
+	if (rc != STATUS_SUCCESS) {
+		scm_warn_status_fw_update(scm_data, "FW Update", rc);
+		return rc;
+	}
+
+	return 0;
+}
+
+/*
+ * Parse out a firmware filename from sysfs, retrieve it's contents and write it
+ * to the SCM device firmware storage
+ */
+static ssize_t fw_update_filename_store(struct device *device,
+					struct device_attribute *attr,
+					const char *buf, size_t size)
+{
+	char path[NAME_MAX+1];
+	const char *end;
+	const struct firmware *firmware = NULL;
+	size_t offset;
+	int rc;
+	struct scm_data *scm_data = container_of(device, struct scm_data, dev);
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	end = strnchr(buf, size, '\n');
+	if (end == NULL)
+		end = buf + strnlen(buf, size);
+
+	if ((end - buf) > NAME_MAX) {
+		dev_err(device, "Firmware filename '%-.*s' too long\n",
+			(int)(end - buf), buf);
+		return -EIO;
+	}
+
+	memcpy(path, buf, end - buf);
+	path[end - buf] = '\0';
+
+	if (request_firmware(&firmware, path, device)) {
+		dev_err(device, "Firmware file %s not found\n", path);
+		return -EIO;
+	}
+
+	if (firmware->size % 8) {
+		release_firmware(firmware);
+		dev_err(device, "Firmware '%s' should be a multiple of 8 bytes", path);
+		return -EINVAL;
+	}
+
+	mutex_lock(&scm_data->admin_command.lock);
+
+	for (offset = 0; offset < firmware->size; offset += SCM_FWUPDATE_BLOCK_SIZE) {
+		size_t remainder = firmware->size - offset;
+		size_t block_size;
+
+		block_size = (remainder > SCM_FWUPDATE_BLOCK_SIZE) ?
+			      SCM_FWUPDATE_BLOCK_SIZE : remainder;
+		rc = scm_update_firmware(scm_data, offset,
+					 firmware->data + offset, block_size);
+		if (rc) {
+			mutex_unlock(&scm_data->admin_command.lock);
+			return -EFAULT;
+		}
+	}
+
+	mutex_unlock(&scm_data->admin_command.lock);
+
+	return size;
+}
+
+static struct device_attribute scm_attrs[] = {
+	__ATTR_RO(fw_version),
+	__ATTR_WO(fw_update_filename),
+};
+
+int scm_sysfs_add(struct scm_data *scm_data)
+{
+	int i, rc;
+
+	for (i = 0; i < ARRAY_SIZE(scm_attrs); i++) {
+		rc = device_create_file(&scm_data->dev, &scm_attrs[i]);
+		if (rc) {
+			for (; --i >= 0;)
+				device_remove_file(&scm_data->dev, &scm_attrs[i]);
+
+			return rc;
+		}
+	}
+	return 0;
+}
-- 
2.23.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

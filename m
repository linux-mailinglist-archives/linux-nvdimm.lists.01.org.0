Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB723198EFD
	for <lists+linux-nvdimm@lfdr.de>; Tue, 31 Mar 2020 10:59:37 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4213410FC3892;
	Tue, 31 Mar 2020 02:00:26 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=66.55.73.32; helo=ushosting.nmnhosting.com; envelope-from=alastair@d-silva.org; receiver=<UNKNOWN> 
Received: from ushosting.nmnhosting.com (ushosting.nmnhosting.com [66.55.73.32])
	by ml01.01.org (Postfix) with ESMTP id 3B49210FC3886
	for <linux-nvdimm@lists.01.org>; Tue, 31 Mar 2020 02:00:24 -0700 (PDT)
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
	by ushosting.nmnhosting.com (Postfix) with ESMTPS id 4BCB92DC6849;
	Mon, 30 Mar 2020 16:53:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
	s=201810a; t=1585547583;
	bh=4YGi5cIVTJtyQ3RAuYeIobqzlKnYrZhy+tDNyNbmbBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kalaxq5zVXcqXTV+7cShrpQDd+DPjZ0pPj3T9DCz6pKgtR1jC4i1QdZ4SEX5u98e8
	 mKVtVWsG0B4kjkBeXSf6ADl11fwAI/lJGptO7Tf+KvP3OWculqcOsJiOhWP/8WY0Mj
	 YR9egnccj5YS2nT1mNHiRYvl+hfcbxFCe2QQnIAm0pnpRLBt5DP3TOBWlcReFrz7mR
	 Vpy6p0JeKxz7QzJyGl5TtfstdMotqraAwA3yafv3XyqrYpXf0mzjw/Ypq6sRf+jyoD
	 3AclM8QlsKopRJ5p03zihQ4NjOKFUTGcAblvp3FJrml3mxvQgH8cNtpmsD+i/2ni4b
	 YiUOoudKtzWsjftqEx3J/ZkF49wCnIG9Jdz6uT10iPY2K371GsYcxNmQOqSNfmOQ/r
	 W1LReKTP0Rpv1vxZAyq4KSphvzy4rOjiQwSTpdVwVmA1yMFA412VOuZaAUD4pBudtt
	 aLsEbJ/C7y/SDEGhxgz+KPhJByXpDmpN64EBQ8Q5oWbrBtYktHR4O6mR69Fmty4HeM
	 aOfCKx0hdaJQ3THwIrsnPhX7aWWvs0U1KMN9vVKbgO1aezYhhjSdR+FEItYQdhRnUp
	 OHl1LYLkwGFzo+zpxHnP+j8wleROH4fR17cfK6tCa/NmWejDWYK23qZP1t+SqmGftV
	 sCXgC3b2hOmfKrutn8Fut04Y=
Received: from localhost.lan ([10.0.1.179])
	by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTP id 02R7C4Ap045934;
	Fri, 27 Mar 2020 18:12:18 +1100 (AEDT)
	(envelope-from alastair@d-silva.org)
From: "Alastair D'Silva" <alastair@d-silva.org>
To: alastair@d-silva.org
Subject: [PATCH v4 16/25] nvdimm/ocxl: Implement the Read Error Log command
Date: Fri, 27 Mar 2020 18:11:53 +1100
Message-Id: <20200327071202.2159885-17-alastair@d-silva.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327071202.2159885-1-alastair@d-silva.org>
References: <20200327071202.2159885-1-alastair@d-silva.org>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Fri, 27 Mar 2020 18:12:18 +1100 (AEDT)
Message-ID-Hash: 3WC4BUKBZ3W7FXD4O4YS2F6ZEZHR5KAG
X-Message-ID-Hash: 3WC4BUKBZ3W7FXD4O4YS2F6ZEZHR5KAG
X-MailFrom: alastair@d-silva.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.r
 u>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3WC4BUKBZ3W7FXD4O4YS2F6ZEZHR5KAG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The read error log command extracts information from the controller's
internal error log.

This patch exposes this information in 2 ways:
- During probe, if an error occurs & a log is available, print it to the
  console
- After probe, make the error log available to userspace via an IOCTL.
  Userspace is notified of pending error logs in a later patch
  ("powerpc/powernv/pmem: Forward events to userspace")

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 drivers/nvdimm/ocxl/main.c                    | 240 ++++++++++++++++++
 include/uapi/nvdimm/ocxlpmem.h                |  46 ++++
 3 files changed, 287 insertions(+)
 create mode 100644 include/uapi/nvdimm/ocxlpmem.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 9425377615ce..ba0ce7dca643 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -340,6 +340,7 @@ Code  Seq#    Include File                                           Comments
 0xC0  00-0F  linux/usb/iowarrior.h
 0xCA  00-0F  uapi/misc/cxl.h
 0xCA  10-2F  uapi/misc/ocxl.h
+0xCA  30-3F  uapi/nvdimm/ocxlpmem.h                                  OpenCAPI Persistent Memory
 0xCA  80-BF  uapi/scsi/cxlflash_ioctl.h
 0xCB  00-1F                                                          CBM serial IEC bus in development:
                                                                      <mailto:michael.klein@puffin.lb.shuttle.de>
diff --git a/drivers/nvdimm/ocxl/main.c b/drivers/nvdimm/ocxl/main.c
index 9b85fcd3f1c9..e6be0029f658 100644
--- a/drivers/nvdimm/ocxl/main.c
+++ b/drivers/nvdimm/ocxl/main.c
@@ -13,6 +13,7 @@
 #include <linux/fs.h>
 #include <linux/mm_types.h>
 #include <linux/memory_hotplug.h>
+#include <uapi/nvdimm/ocxlpmem.h>
 #include "ocxlpmem.h"
 
 static const struct pci_device_id pci_tbl[] = {
@@ -401,10 +402,190 @@ static int file_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+/**
+ * error_log_header_parse() - Parse the first 64 bits of the error log command response
+ * @ocxlpmem: the device metadata
+ * @length: out, returns the number of bytes in the response (excluding the 64 bit header)
+ */
+static int error_log_header_parse(struct ocxlpmem *ocxlpmem, u16 *length)
+{
+	int rc;
+	u64 val;
+	u16 data_identifier;
+	u32 data_length;
+
+	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
+				     ocxlpmem->admin_command.data_offset,
+				     OCXL_LITTLE_ENDIAN, &val);
+	if (rc)
+		return rc;
+
+	data_identifier = val >> 48;
+	data_length = val & 0xFFFF;
+
+	if (data_identifier != 0x454C) { // 'EL'
+		dev_err(&ocxlpmem->dev,
+			"Bad data identifier for error log data, expected 'EL', got '%2s' (%#x), data_length=%u\n",
+			(char *)&data_identifier,
+			(unsigned int)data_identifier, data_length);
+		return -EINVAL;
+	}
+
+	*length = data_length;
+	return 0;
+}
+
+static int read_error_log(struct ocxlpmem *ocxlpmem,
+			  struct ioctl_ocxlpmem_error_log *log,
+			  bool buf_is_user)
+{
+	u64 val;
+	u16 user_buf_length;
+	u16 buf_length;
+	u64 *buf = (u64 *)log->buf_ptr;
+	u16 i;
+	int rc;
+
+	if (log->buf_size % 8)
+		return -EINVAL;
+
+	rc = ocxlpmem_chi(ocxlpmem, &val);
+	if (rc)
+		return rc;
+
+	if (!(val & GLOBAL_MMIO_CHI_ELA))
+		return -EAGAIN;
+
+	user_buf_length = log->buf_size;
+
+	mutex_lock(&ocxlpmem->admin_command.lock);
+
+	rc = admin_command_execute(ocxlpmem, ADMIN_COMMAND_ERRLOG);
+	if (rc != STATUS_SUCCESS) {
+		warn_status(ocxlpmem,
+			    "Unexpected status from retrieve error log", rc);
+		goto out;
+	}
+
+	rc = error_log_header_parse(ocxlpmem, &log->buf_size);
+	if (rc)
+		goto out;
+	// log->buf_size now contains the returned buffer size, not the user size
+
+	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
+				     ocxlpmem->admin_command.data_offset + 0x08,
+				     OCXL_LITTLE_ENDIAN, &val);
+	if (rc)
+		goto out;
+
+	log->log_identifier = val >> 32;
+	log->program_reference_code = val & 0xFFFFFFFF;
+
+	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
+				     ocxlpmem->admin_command.data_offset + 0x10,
+				     OCXL_LITTLE_ENDIAN, &val);
+	if (rc)
+		goto out;
+
+	log->error_log_type = val >> 56;
+	log->action_flags = (log->error_log_type == OCXLPMEM_ERROR_LOG_TYPE_GENERAL) ?
+			    (val >> 32) & 0xFFFFFF : 0;
+	log->power_on_seconds = val & 0xFFFFFFFF;
+
+	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
+				     ocxlpmem->admin_command.data_offset + 0x18,
+				     OCXL_LITTLE_ENDIAN, &log->timestamp);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
+				     ocxlpmem->admin_command.data_offset + 0x20,
+				     OCXL_LITTLE_ENDIAN, &log->wwid[0]);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
+				     ocxlpmem->admin_command.data_offset + 0x28,
+				     OCXL_LITTLE_ENDIAN, &log->wwid[1]);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
+				     ocxlpmem->admin_command.data_offset + 0x30,
+				     OCXL_HOST_ENDIAN, (u64 *)log->fw_revision);
+	if (rc)
+		goto out;
+	log->fw_revision[8] = '\0';
+
+	buf_length = (user_buf_length < log->buf_size) ?
+		      user_buf_length : log->buf_size;
+	for (i = 0; i < buf_length / (sizeof(u64)); i++) {
+		rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
+					     ocxlpmem->admin_command.data_offset +
+							i * sizeof(u64),
+					     OCXL_HOST_ENDIAN, &val);
+		if (rc)
+			goto out;
+
+		if (buf_is_user) {
+			if (copy_to_user((u64 __user *)&buf[i], &val,
+					 sizeof(u64))) {
+				rc = -EFAULT;
+				goto out;
+			}
+		} else {
+			buf[i] = val;
+		}
+	}
+
+	rc = admin_response_handled(ocxlpmem);
+	if (rc)
+		goto out;
+
+out:
+	mutex_unlock(&ocxlpmem->admin_command.lock);
+	return rc;
+}
+
+static int ioctl_error_log(struct ocxlpmem *ocxlpmem,
+			   struct ioctl_ocxlpmem_error_log __user *uarg)
+{
+	struct ioctl_ocxlpmem_error_log args;
+	int rc;
+
+	if (copy_from_user(&args, uarg, sizeof(args)))
+		return -EFAULT;
+
+	rc = read_error_log(ocxlpmem, &args, true);
+	if (rc)
+		return rc;
+
+	if (copy_to_user(uarg, &args, sizeof(args)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long file_ioctl(struct file *file, unsigned int cmd, unsigned long args)
+{
+	struct ocxlpmem *ocxlpmem = file->private_data;
+	int rc = -EINVAL;
+
+	switch (cmd) {
+	case IOCTL_OCXLPMEM_ERROR_LOG:
+		rc = ioctl_error_log(ocxlpmem,
+				     (struct ioctl_ocxlpmem_error_log __user *)args);
+		break;
+	}
+	return rc;
+}
+
 static const struct file_operations fops = {
 	.owner		= THIS_MODULE,
 	.open		= file_open,
 	.release	= file_release,
+	.unlocked_ioctl = file_ioctl,
+	.compat_ioctl   = file_ioctl,
 };
 
 /**
@@ -493,6 +674,60 @@ static int read_device_metadata(struct ocxlpmem *ocxlpmem)
 	return 0;
 }
 
+static const char *decode_error_log_type(u8 error_log_type)
+{
+	switch (error_log_type) {
+	case 0x00:
+		return "general";
+	case 0x01:
+		return "predictive failure";
+	case 0x02:
+		return "thermal warning";
+	case 0x03:
+		return "data loss";
+	case 0x04:
+		return "health & performance";
+	default:
+		return "unknown";
+	}
+}
+
+static void dump_error_log(struct ocxlpmem *ocxlpmem)
+{
+	struct ioctl_ocxlpmem_error_log log;
+	u32 buf_size;
+	u8 *buf;
+	int rc;
+
+	if (ocxlpmem->admin_command.data_size == 0)
+		return;
+
+	buf_size = ocxlpmem->admin_command.data_size - 0x48;
+	buf = kzalloc(buf_size, GFP_KERNEL);
+	if (!buf)
+		return;
+
+	log.buf_ptr = (u64)buf;
+	log.buf_size = buf_size;
+
+	rc = read_error_log(ocxlpmem, &log, false);
+	if (rc < 0)
+		goto out;
+
+	dev_warn(&ocxlpmem->dev,
+		 "OCXL PMEM Error log: WWID=0x%016llx%016llx LID=0x%x PRC=%x type=0x%x %s, Uptime=%u seconds timestamp=0x%llx\n",
+		 log.wwid[0], log.wwid[1],
+		 log.log_identifier, log.program_reference_code,
+		 log.error_log_type,
+		 decode_error_log_type(log.error_log_type),
+		 log.power_on_seconds, log.timestamp);
+	print_hex_dump(KERN_WARNING, "buf", DUMP_PREFIX_OFFSET, 16, 1, buf,
+		       log.buf_size, false);
+
+out:
+	kfree(buf);
+}
+
 /**
  * probe_function0() - Set up function 0 for an OpenCAPI persistent memory device
  * This is important as it enables templates higher than 0 across all other
@@ -656,6 +891,11 @@ static int probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_set_drvdata(pdev, NULL);
 
 err:
+	if (ocxlpmem &&
+	    (ocxlpmem_chi(ocxlpmem, &chi) == 0) &&
+	    (chi & GLOBAL_MMIO_CHI_ELA))
+		dump_error_log(ocxlpmem);
+
 	/*
 	 * Further cleanup is done in the release handler via free_ocxlpmem()
 	 * This allows us to keep the character device live to handle IOCTLs to
diff --git a/include/uapi/nvdimm/ocxlpmem.h b/include/uapi/nvdimm/ocxlpmem.h
new file mode 100644
index 000000000000..5d3a03ea1e08
--- /dev/null
+++ b/include/uapi/nvdimm/ocxlpmem.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/* Copyright 2020 IBM Corp. */
+#ifndef _UAPI_OCXL_SCM_H
+#define _UAPI_OCXL_SCM_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#define OCXLPMEM_ERROR_LOG_ACTION_RESET	(1 << (32 - 32))
+#define OCXLPMEM_ERROR_LOG_ACTION_CHKFW	(1 << (53 - 32))
+#define OCXLPMEM_ERROR_LOG_ACTION_REPLACE	(1 << (54 - 32))
+#define OCXLPMEM_ERROR_LOG_ACTION_DUMP		(1 << (55 - 32))
+
+#define OCXLPMEM_ERROR_LOG_TYPE_GENERAL		(0x00)
+#define OCXLPMEM_ERROR_LOG_TYPE_PREDICTIVE_FAILURE	(0x01)
+#define OCXLPMEM_ERROR_LOG_TYPE_THERMAL_WARNING	(0x02)
+#define OCXLPMEM_ERROR_LOG_TYPE_DATA_LOSS		(0x03)
+#define OCXLPMEM_ERROR_LOG_TYPE_HEALTH_PERFORMANCE	(0x04)
+
+struct ioctl_ocxlpmem_error_log {
+	__u32 log_identifier; /* out */
+	__u32 program_reference_code; /* out */
+	__u32 action_flags; /* out, recommended course of action */
+	__u32 power_on_seconds; /* out, Number of seconds the controller has been on when the error occurred */
+	__u64 timestamp; /* out, relative time since the current IPL */
+	__u64 wwid[2]; /* out, the NAA formatted WWID associated with the controller */
+	char  fw_revision[8 + 1]; /* out, firmware revision as null terminated text */
+	__u8  reserved0[7];
+	__u16 buf_size; /* in/out, buffer size provided/required.
+			 * If required is greater than provided, the buffer
+			 * will be truncated to the amount provided. If its
+			 * less, then only the required bytes will be populated.
+			 * If it is 0, then there are no more error log entries.
+			 */
+	__u8  error_log_type;
+	__u8  reserved1[5];
+	__u64 buf_ptr; /* coerced pointer to output buffer */
+	__u64 reserved2[2];
+};
+
+/* ioctl numbers */
+#define OCXLPMEM_MAGIC 0xCA
+/* OpenCAPI Persistent memory devices */
+#define IOCTL_OCXLPMEM_ERROR_LOG			_IOWR(OCXLPMEM_MAGIC, 0x30, struct ioctl_ocxlpmem_error_log)
+
+#endif /* _UAPI_OCXL_SCM_H */
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

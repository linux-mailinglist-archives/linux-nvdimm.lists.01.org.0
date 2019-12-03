Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E334B10F5BA
	for <lists+linux-nvdimm@lfdr.de>; Tue,  3 Dec 2019 04:48:46 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 87E9B10113685;
	Mon,  2 Dec 2019 19:51:57 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 714CD10113666
	for <linux-nvdimm@lists.01.org>; Mon,  2 Dec 2019 19:51:53 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB33klkl032879
	for <linux-nvdimm@lists.01.org>; Mon, 2 Dec 2019 22:48:30 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2wm6snr95b-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Mon, 02 Dec 2019 22:48:30 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Tue, 3 Dec 2019 03:48:25 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
	by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 3 Dec 2019 03:48:19 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB33mI1Z30146586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Dec 2019 03:48:18 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82817AE051;
	Tue,  3 Dec 2019 03:48:18 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E249CAE04D;
	Tue,  3 Dec 2019 03:48:17 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue,  3 Dec 2019 03:48:17 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 4411CA03E2;
	Tue,  3 Dec 2019 14:48:13 +1100 (AEDT)
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: alastair@d-silva.org
Subject: [PATCH v2 16/27] nvdimm/ocxl: Implement the Read Error Log command
Date: Tue,  3 Dec 2019 14:46:44 +1100
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191203034655.51561-1-alastair@au1.ibm.com>
References: <20191203034655.51561-1-alastair@au1.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19120303-0012-0000-0000-000003701289
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120303-0013-0000-0000-000021ABCCBF
Message-Id: <20191203034655.51561-17-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_06:2019-11-29,2019-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=3 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912030032
Message-ID-Hash: IVM4ZUD2K6JTNN7SJDRVUNIEW546T2Q7
X-Message-ID-Hash: IVM4ZUD2K6JTNN7SJDRVUNIEW546T2Q7
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-dev@list
 s.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IVM4ZUD2K6JTNN7SJDRVUNIEW546T2Q7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Alastair D'Silva <alastair@d-silva.org>

The read error log command extracts information from the controller's
internal error log.

This patch exposes this information in 2 ways:
- During probe, if an error occurs & a log is available, print it to the
  console
- After probe, make the error log available to userspace via an IOCTL.
  Userspace is notified of pending error logs in a later patch
  ("nvdimm/ocxl: Forward events to userspace")

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/nvdimm/ocxl/scm.c          | 270 +++++++++++++++++++++++++++++
 drivers/nvdimm/ocxl/scm_internal.h |   1 +
 include/uapi/nvdimm/ocxl-scm.h     |  46 +++++
 3 files changed, 317 insertions(+)
 create mode 100644 include/uapi/nvdimm/ocxl-scm.h

diff --git a/drivers/nvdimm/ocxl/scm.c b/drivers/nvdimm/ocxl/scm.c
index c313a473a28e..0bbe1a14291e 100644
--- a/drivers/nvdimm/ocxl/scm.c
+++ b/drivers/nvdimm/ocxl/scm.c
@@ -495,10 +495,220 @@ static int scm_file_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+/**
+ * scm_error_log_header_parse() - Parse the first 64 bits of the error log command response
+ * @scm_data: the SCM metadata
+ * @length: out, returns the number of bytes in the response (excluding the 64 bit header)
+ */
+static int scm_error_log_header_parse(struct scm_data *scm_data, u16 *length)
+{
+	int rc;
+	u64 val;
+
+	u16 data_identifier;
+	u32 data_length;
+
+	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+				     scm_data->admin_command.data_offset,
+				     OCXL_LITTLE_ENDIAN, &val);
+	if (rc)
+		return rc;
+
+	data_identifier = val >> 48;
+	data_length = val & 0xFFFF;
+
+	if (data_identifier != 0x454C) {
+		dev_err(&scm_data->dev,
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
+static int scm_error_log_offset_0x08(struct scm_data *scm_data,
+				     u32 *log_identifier, u32 *program_ref_code)
+{
+	int rc;
+	u64 val;
+
+	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+				     scm_data->admin_command.data_offset + 0x08,
+				     OCXL_LITTLE_ENDIAN, &val);
+	if (rc)
+		return rc;
+
+	*log_identifier = val >> 32;
+	*program_ref_code = val & 0xFFFFFFFF;
+
+	return 0;
+}
+
+static int scm_read_error_log(struct scm_data *scm_data,
+			      struct scm_ioctl_error_log *log, bool buf_is_user)
+{
+	u64 val;
+	u16 user_buf_length;
+	u16 buf_length;
+	u16 i;
+	int rc;
+
+	if (log->buf_size % 8)
+		return -EINVAL;
+
+	rc = scm_chi(scm_data, &val);
+	if (rc)
+		goto out;
+
+	if (!(val & GLOBAL_MMIO_CHI_ELA))
+		return -EAGAIN;
+
+	user_buf_length = log->buf_size;
+
+	mutex_lock(&scm_data->admin_command.lock);
+
+	rc = scm_admin_command_request(scm_data, ADMIN_COMMAND_ERRLOG);
+	if (rc)
+		goto out;
+
+	rc = scm_admin_command_execute(scm_data);
+	if (rc)
+		goto out;
+
+	rc = scm_admin_command_complete_timeout(scm_data, ADMIN_COMMAND_ERRLOG);
+	if (rc < 0) {
+		dev_warn(&scm_data->dev, "Read error log timed out\n");
+		goto out;
+	}
+
+	rc = scm_admin_response(scm_data);
+	if (rc < 0)
+		goto out;
+	if (rc != STATUS_SUCCESS) {
+		scm_warn_status(scm_data, "Unexpected status from retrieve error log", rc);
+		goto out;
+	}
+
+
+	rc = scm_error_log_header_parse(scm_data, &log->buf_size);
+	if (rc)
+		goto out;
+	// log->buf_size now contains the scm buffer size, not the user size
+
+	rc = scm_error_log_offset_0x08(scm_data, &log->log_identifier,
+				       &log->program_reference_code);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+				     scm_data->admin_command.data_offset + 0x10,
+				     OCXL_LITTLE_ENDIAN, &val);
+	if (rc)
+		goto out;
+
+	log->error_log_type = val >> 56;
+	log->action_flags = (log->error_log_type == SCM_ERROR_LOG_TYPE_GENERAL) ?
+			    (val >> 32) & 0xFFFFFF : 0;
+	log->power_on_seconds = val & 0xFFFFFFFF;
+
+	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+				     scm_data->admin_command.data_offset + 0x18,
+				     OCXL_LITTLE_ENDIAN, &log->timestamp);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+				     scm_data->admin_command.data_offset + 0x20,
+				     OCXL_HOST_ENDIAN, &log->wwid[0]);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+				     scm_data->admin_command.data_offset + 0x28,
+				     OCXL_HOST_ENDIAN, &log->wwid[1]);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+				     scm_data->admin_command.data_offset + 0x30,
+				     OCXL_HOST_ENDIAN, (u64 *)log->fw_revision);
+	if (rc)
+		goto out;
+	log->fw_revision[8] = '\0';
+
+	buf_length = (user_buf_length < log->buf_size) ?
+		     user_buf_length : log->buf_size;
+	for (i = 0; i < buf_length + 0x48; i += 8) {
+		u64 val;
+
+		rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+					     scm_data->admin_command.data_offset + i,
+					     OCXL_HOST_ENDIAN, &val);
+		if (rc)
+			goto out;
+
+		if (buf_is_user) {
+			if (copy_to_user(&log->buf[i], &val, sizeof(u64))) {
+				rc = -EFAULT;
+				goto out;
+			}
+		} else
+			log->buf[i] = val;
+	}
+
+	rc = scm_admin_response_handled(scm_data);
+	if (rc)
+		goto out;
+
+out:
+	mutex_unlock(&scm_data->admin_command.lock);
+	return rc;
+
+}
+
+static int scm_ioctl_error_log(struct scm_data *scm_data,
+			       struct scm_ioctl_error_log __user *uarg)
+{
+	struct scm_ioctl_error_log args;
+	int rc;
+
+	if (copy_from_user(&args, uarg, sizeof(args)))
+		return -EFAULT;
+
+	rc = scm_read_error_log(scm_data, &args, true);
+	if (rc)
+		return rc;
+
+	if (copy_to_user(uarg, &args, sizeof(args)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long scm_file_ioctl(struct file *file, unsigned int cmd,
+			   unsigned long args)
+{
+	struct scm_data *scm_data = file->private_data;
+	int rc = -EINVAL;
+
+	switch (cmd) {
+	case SCM_IOCTL_ERROR_LOG:
+		rc = scm_ioctl_error_log(scm_data,
+					 (struct scm_ioctl_error_log __user *)args);
+		break;
+	}
+	return rc;
+}
+
 static const struct file_operations scm_fops = {
 	.owner		= THIS_MODULE,
 	.open		= scm_file_open,
 	.release	= scm_file_release,
+	.unlocked_ioctl = scm_file_ioctl,
+	.compat_ioctl   = scm_file_ioctl,
 };
 
 /**
@@ -575,6 +785,60 @@ static int read_device_metadata(struct scm_data *scm_data)
 	return 0;
 }
 
+static const char *scm_decode_error_log_type(u8 error_log_type)
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
+static void scm_dump_error_log(struct scm_data *scm_data)
+{
+	struct scm_ioctl_error_log log;
+	u32 buf_size;
+	u8 *buf;
+	int rc;
+
+	if (scm_data->admin_command.data_size == 0)
+		return;
+
+	buf_size = scm_data->admin_command.data_size - 0x48;
+	buf = kzalloc(buf_size, GFP_KERNEL);
+	if (!buf)
+		return;
+
+	log.buf = buf;
+	log.buf_size = buf_size;
+
+	rc = scm_read_error_log(scm_data, &log, false);
+	if (rc < 0)
+		goto out;
+
+	dev_warn(&scm_data->dev,
+		 "SCM Error log: WWID=0x%016llx%016llx LID=0x%x PRC=%x type=0x%x %s, Uptime=%u seconds timestamp=0x%llx\n",
+		 log.wwid[0], log.wwid[1],
+		 log.log_identifier, log.program_reference_code,
+		 log.error_log_type,
+		 scm_decode_error_log_type(log.error_log_type),
+		 log.power_on_seconds, log.timestamp);
+	print_hex_dump(KERN_WARNING, "buf", DUMP_PREFIX_OFFSET, 16, 1, buf,
+		       log.buf_size, false);
+
+out:
+	kfree(buf);
+}
+
 /**
  * scm_probe_function_0 - Set up function 0 for an OpenCAPI Storage Class Memory device
  * This is important as it enables templates higher than 0 across all other functions,
@@ -617,6 +881,7 @@ static int scm_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct scm_data *scm_data = NULL;
 	int elapsed;
 	u16 timeout;
+	u64 chi;
 
 	if (PCI_FUNC(pdev->devfn) == 0)
 		return scm_probe_function_0(pdev);
@@ -707,6 +972,11 @@ static int scm_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return 0;
 
 err:
+	if (scm_data &&
+		    (scm_chi(scm_data, &chi) == 0) &&
+		    (chi & GLOBAL_MMIO_CHI_ELA))
+		scm_dump_error_log(scm_data);
+
 	/*
 	 * Further cleanup is done in the release handler via free_scm()
 	 * This allows us to keep the character device live to handle IOCTLs to
diff --git a/drivers/nvdimm/ocxl/scm_internal.h b/drivers/nvdimm/ocxl/scm_internal.h
index 57491dbee1a4..9bf8fcf30ea6 100644
--- a/drivers/nvdimm/ocxl/scm_internal.h
+++ b/drivers/nvdimm/ocxl/scm_internal.h
@@ -5,6 +5,7 @@
 #include <linux/cdev.h>
 #include <misc/ocxl.h>
 #include <linux/libnvdimm.h>
+#include <uapi/linux/ocxl-scm.h>
 #include <linux/mm.h>
 
 #define SCM_DEFAULT_TIMEOUT 100
diff --git a/include/uapi/nvdimm/ocxl-scm.h b/include/uapi/nvdimm/ocxl-scm.h
new file mode 100644
index 000000000000..b34dd1ba06ff
--- /dev/null
+++ b/include/uapi/nvdimm/ocxl-scm.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/* Copyright 2017 IBM Corp. */
+#ifndef _UAPI_OCXL_SCM_H
+#define _UAPI_OCXL_SCM_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#define SCM_ERROR_LOG_ACTION_RESET	(1 << (32-32))
+#define SCM_ERROR_LOG_ACTION_CHKFW	(1 << (53-32))
+#define SCM_ERROR_LOG_ACTION_REPLACE	(1 << (54-32))
+#define SCM_ERROR_LOG_ACTION_DUMP	(1 << (55-32))
+
+#define SCM_ERROR_LOG_TYPE_GENERAL		(0x00)
+#define SCM_ERROR_LOG_TYPE_PREDICTIVE_FAILURE	(0x01)
+#define SCM_ERROR_LOG_TYPE_THERMAL_WARNING	(0x02)
+#define SCM_ERROR_LOG_TYPE_DATA_LOSS		(0x03)
+#define SCM_ERROR_LOG_TYPE_HEALTH_PERFORMANCE	(0x04)
+
+struct scm_ioctl_error_log {
+	__u32 log_identifier; // out
+	__u32 program_reference_code; // out
+	__u32 action_flags; //out, recommended course of action
+	__u32 power_on_seconds; // out, Number of seconds the controller has been on when the error occurred
+	__u64 timestamp; // out, relative time since the current IPL
+	__u64 wwid[2]; // out, the NAA formatted WWID associated with the controller
+	char  fw_revision[8+1]; // out, firmware revision as null terminated text
+	__u16 buf_size; /* in/out, buffer size provided/required.
+			 * If required is greater than provided, the buffer
+			 * will be truncated to the amount provided. If its
+			 * less, then only the required bytes will be populated.
+			 * If it is 0, then there are no more error log entries.
+			 */
+	__u8  error_log_type;
+	__u8  reserved1;
+	__u32 reserved2;
+	__u64 reserved3[2];
+	__u8 *buf; // pointer to output buffer
+};
+
+/* ioctl numbers */
+#define SCM_MAGIC 0x5C
+/* SCM devices */
+#define SCM_IOCTL_ERROR_LOG	_IOWR(SCM_MAGIC, 0x01, struct scm_ioctl_error_log)
+
+#endif /* _UAPI_OCXL_SCM_H */
-- 
2.23.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

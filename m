Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF497166D9E
	for <lists+linux-nvdimm@lfdr.de>; Fri, 21 Feb 2020 04:28:47 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D8D8610FC363D;
	Thu, 20 Feb 2020 19:29:21 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DE35110FC3617
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 19:29:15 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01L3KJUu104881
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 22:28:23 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ubqh1k9-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 22:28:22 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Fri, 21 Feb 2020 03:28:19 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
	by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 21 Feb 2020 03:28:12 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01L3RFqH44302716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2020 03:27:15 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F21A511C04C;
	Fri, 21 Feb 2020 03:28:10 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02DE611C050;
	Fri, 21 Feb 2020 03:28:10 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Fri, 21 Feb 2020 03:28:09 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 92484A03DE;
	Fri, 21 Feb 2020 14:28:03 +1100 (AEDT)
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: alastair@d-silva.org
Subject: [PATCH v3 17/27] powerpc/powernv/pmem: Implement the Read Error Log command
Date: Fri, 21 Feb 2020 14:27:10 +1100
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200221032720.33893-1-alastair@au1.ibm.com>
References: <20200221032720.33893-1-alastair@au1.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20022103-0012-0000-0000-00000388D1D0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022103-0013-0000-0000-000021C56A73
Message-Id: <20200221032720.33893-18-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_19:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=3 spamscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002210020
Message-ID-Hash: 2HFMAS2YA5XSPLUAIGOZ5CZIHGLYHCOH
X-Message-ID-Hash: 2HFMAS2YA5XSPLUAIGOZ5CZIHGLYHCOH
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.r
 u>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2HFMAS2YA5XSPLUAIGOZ5CZIHGLYHCOH/>
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
  ("powerpc/powernv/pmem: Forward events to userspace")

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/powerpc/platforms/powernv/pmem/ocxl.c    | 269 ++++++++++++++++++
 .../platforms/powernv/pmem/ocxl_internal.h    |   1 +
 include/uapi/nvdimm/ocxl-pmem.h               |  46 +++
 3 files changed, 316 insertions(+)
 create mode 100644 include/uapi/nvdimm/ocxl-pmem.h

diff --git a/arch/powerpc/platforms/powernv/pmem/ocxl.c b/arch/powerpc/platforms/powernv/pmem/ocxl.c
index 63109a870d2c..2b64504f9129 100644
--- a/arch/powerpc/platforms/powernv/pmem/ocxl.c
+++ b/arch/powerpc/platforms/powernv/pmem/ocxl.c
@@ -447,10 +447,219 @@ static int file_release(struct inode *inode, struct file *file)
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
+
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
+static int error_log_offset_0x08(struct ocxlpmem *ocxlpmem,
+				 u32 *log_identifier, u32 *program_ref_code)
+{
+	int rc;
+	u64 val;
+
+	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
+				     ocxlpmem->admin_command.data_offset + 0x08,
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
+static int read_error_log(struct ocxlpmem *ocxlpmem,
+			  struct ioctl_ocxl_pmem_error_log *log, bool buf_is_user)
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
+	rc = ocxlpmem_chi(ocxlpmem, &val);
+	if (rc)
+		goto out;
+
+	if (!(val & GLOBAL_MMIO_CHI_ELA))
+		return -EAGAIN;
+
+	user_buf_length = log->buf_size;
+
+	mutex_lock(&ocxlpmem->admin_command.lock);
+
+	rc = admin_command_request(ocxlpmem, ADMIN_COMMAND_ERRLOG);
+	if (rc)
+		goto out;
+
+	rc = admin_command_execute(ocxlpmem);
+	if (rc)
+		goto out;
+
+	rc = admin_command_complete_timeout(ocxlpmem, ADMIN_COMMAND_ERRLOG);
+	if (rc < 0) {
+		dev_warn(&ocxlpmem->dev, "Read error log timed out\n");
+		goto out;
+	}
+
+	rc = admin_response(ocxlpmem);
+	if (rc < 0)
+		goto out;
+	if (rc != STATUS_SUCCESS) {
+		warn_status(ocxlpmem, "Unexpected status from retrieve error log", rc);
+		goto out;
+	}
+
+
+	rc = error_log_header_parse(ocxlpmem, &log->buf_size);
+	if (rc)
+		goto out;
+	// log->buf_size now contains the returned buffer size, not the user size
+
+	rc = error_log_offset_0x08(ocxlpmem, &log->log_identifier,
+				       &log->program_reference_code);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
+				     ocxlpmem->admin_command.data_offset + 0x10,
+				     OCXL_LITTLE_ENDIAN, &val);
+	if (rc)
+		goto out;
+
+	log->error_log_type = val >> 56;
+	log->action_flags = (log->error_log_type == OCXL_PMEM_ERROR_LOG_TYPE_GENERAL) ?
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
+				     OCXL_HOST_ENDIAN, &log->wwid[0]);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
+				     ocxlpmem->admin_command.data_offset + 0x28,
+				     OCXL_HOST_ENDIAN, &log->wwid[1]);
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
+		     user_buf_length : log->buf_size;
+	for (i = 0; i < buf_length + 0x48; i += 8) {
+		u64 val;
+
+		rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
+					     ocxlpmem->admin_command.data_offset + i,
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
+	rc = admin_response_handled(ocxlpmem);
+	if (rc)
+		goto out;
+
+out:
+	mutex_unlock(&ocxlpmem->admin_command.lock);
+	return rc;
+
+}
+
+static int ioctl_error_log(struct ocxlpmem *ocxlpmem,
+		struct ioctl_ocxl_pmem_error_log __user *uarg)
+{
+	struct ioctl_ocxl_pmem_error_log args;
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
+	case IOCTL_OCXL_PMEM_ERROR_LOG:
+		rc = ioctl_error_log(ocxlpmem,
+				     (struct ioctl_ocxl_pmem_error_log __user *)args);
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
@@ -527,6 +736,60 @@ static int read_device_metadata(struct ocxlpmem *ocxlpmem)
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
+	struct ioctl_ocxl_pmem_error_log log;
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
+	log.buf = buf;
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
  * This is important as it enables templates higher than 0 across all other functions,
@@ -568,6 +831,7 @@ static int probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct ocxlpmem *ocxlpmem;
 	int rc;
 	u16 elapsed, timeout;
+	u64 chi;
 
 	if (PCI_FUNC(pdev->devfn) == 0)
 		return probe_function0(pdev);
@@ -667,6 +931,11 @@ static int probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return 0;
 
 err:
+	if (ocxlpmem &&
+		    (ocxlpmem_chi(ocxlpmem, &chi) == 0) &&
+		    (chi & GLOBAL_MMIO_CHI_ELA))
+		dump_error_log(ocxlpmem);
+
 	/*
 	 * Further cleanup is done in the release handler via free_ocxlpmem()
 	 * This allows us to keep the character device live to handle IOCTLs to
diff --git a/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h b/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h
index d2d81fec7bb1..b953ee522ed4 100644
--- a/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h
+++ b/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h
@@ -5,6 +5,7 @@
 #include <linux/cdev.h>
 #include <misc/ocxl.h>
 #include <linux/libnvdimm.h>
+#include <uapi/nvdimm/ocxl-pmem.h>
 #include <linux/mm.h>
 
 #define LABEL_AREA_SIZE	(1UL << PA_SECTION_SHIFT)
diff --git a/include/uapi/nvdimm/ocxl-pmem.h b/include/uapi/nvdimm/ocxl-pmem.h
new file mode 100644
index 000000000000..b10f8ac0c20f
--- /dev/null
+++ b/include/uapi/nvdimm/ocxl-pmem.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/* Copyright 2017 IBM Corp. */
+#ifndef _UAPI_OCXL_SCM_H
+#define _UAPI_OCXL_SCM_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#define OCXL_PMEM_ERROR_LOG_ACTION_RESET	(1 << (32-32))
+#define OCXL_PMEM_ERROR_LOG_ACTION_CHKFW	(1 << (53-32))
+#define OCXL_PMEM_ERROR_LOG_ACTION_REPLACE	(1 << (54-32))
+#define OCXL_PMEM_ERROR_LOG_ACTION_DUMP		(1 << (55-32))
+
+#define OCXL_PMEM_ERROR_LOG_TYPE_GENERAL		(0x00)
+#define OCXL_PMEM_ERROR_LOG_TYPE_PREDICTIVE_FAILURE	(0x01)
+#define OCXL_PMEM_ERROR_LOG_TYPE_THERMAL_WARNING	(0x02)
+#define OCXL_PMEM_ERROR_LOG_TYPE_DATA_LOSS		(0x03)
+#define OCXL_PMEM_ERROR_LOG_TYPE_HEALTH_PERFORMANCE	(0x04)
+
+struct ioctl_ocxl_pmem_error_log {
+	__u32 log_identifier; /* out */
+	__u32 program_reference_code; /* out */
+	__u32 action_flags; /* out, recommended course of action */
+	__u32 power_on_seconds; /* out, Number of seconds the controller has been on when the error occurred */
+	__u64 timestamp; /* out, relative time since the current IPL */
+	__u64 wwid[2]; /* out, the NAA formatted WWID associated with the controller */
+	char  fw_revision[8+1]; /* out, firmware revision as null terminated text */
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
+	__u8 *buf; /* pointer to output buffer */
+};
+
+/* ioctl numbers */
+#define OCXL_PMEM_MAGIC 0x5C
+/* SCM devices */
+#define IOCTL_OCXL_PMEM_ERROR_LOG			_IOWR(OCXL_PMEM_MAGIC, 0x01, struct ioctl_ocxl_pmem_error_log)
+
+#endif /* _UAPI_OCXL_SCM_H */
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

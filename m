Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF41166DA5
	for <lists+linux-nvdimm@lfdr.de>; Fri, 21 Feb 2020 04:28:56 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6F1B610FC3638;
	Thu, 20 Feb 2020 19:29:24 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 80A7010FC361F
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 19:29:16 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01L3JnaE013326
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 22:28:23 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2y8uc21hka-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 22:28:23 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Fri, 21 Feb 2020 03:28:19 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
	by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 21 Feb 2020 03:28:11 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01L3SAl045154318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2020 03:28:11 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE07CA4054;
	Fri, 21 Feb 2020 03:28:10 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 432DBA405F;
	Fri, 21 Feb 2020 03:28:10 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Fri, 21 Feb 2020 03:28:10 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id EF840A03E6;
	Fri, 21 Feb 2020 14:28:03 +1100 (AEDT)
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: alastair@d-silva.org
Subject: [PATCH v3 23/27] powerpc/powernv/pmem: Add debug IOCTLs
Date: Fri, 21 Feb 2020 14:27:16 +1100
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200221032720.33893-1-alastair@au1.ibm.com>
References: <20200221032720.33893-1-alastair@au1.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20022103-0012-0000-0000-00000388D1D1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022103-0013-0000-0000-000021C56A72
Message-Id: <20200221032720.33893-24-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_19:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 phishscore=0 impostorscore=0 mlxscore=0 mlxlogscore=885 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=1 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002210020
Message-ID-Hash: FNMTAPI7VKE7FMCKKXS5AGMZ2OKK5S7X
X-Message-ID-Hash: FNMTAPI7VKE7FMCKKXS5AGMZ2OKK5S7X
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.r
 u>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FNMTAPI7VKE7FMCKKXS5AGMZ2OKK5S7X/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Alastair D'Silva <alastair@d-silva.org>

These IOCTLs provide low level access to the card to aid in debugging
controller/FPGA firmware.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/powerpc/platforms/powernv/pmem/Kconfig |   6 +
 arch/powerpc/platforms/powernv/pmem/ocxl.c  | 249 ++++++++++++++++++++
 include/uapi/nvdimm/ocxl-pmem.h             |  32 +++
 3 files changed, 287 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pmem/Kconfig b/arch/powerpc/platforms/powernv/pmem/Kconfig
index c5d927520920..3f44429d70c9 100644
--- a/arch/powerpc/platforms/powernv/pmem/Kconfig
+++ b/arch/powerpc/platforms/powernv/pmem/Kconfig
@@ -12,4 +12,10 @@ config OCXL_PMEM
 
 	  Select N if unsure.
 
+config OCXL_PMEM_DEBUG
+	bool "OpenCAPI Persistent Memory debugging"
+	depends on OCXL_PMEM
+	help
+	  Enables low level IOCTLs for OpenCAPI Persistent Memory firmware development
+
 endif
diff --git a/arch/powerpc/platforms/powernv/pmem/ocxl.c b/arch/powerpc/platforms/powernv/pmem/ocxl.c
index e01f6f9fc180..d4ce5e9e0521 100644
--- a/arch/powerpc/platforms/powernv/pmem/ocxl.c
+++ b/arch/powerpc/platforms/powernv/pmem/ocxl.c
@@ -1050,6 +1050,235 @@ int req_controller_health_perf(struct ocxlpmem *ocxlpmem)
 				      GLOBAL_MMIO_HCI_REQ_HEALTH_PERF);
 }
 
+#ifdef CONFIG_OCXL_PMEM_DEBUG
+/**
+ * enable_fwdebug() - Enable FW debug on the controller
+ * @ocxlpmem: the device metadata
+ * Return: 0 on success, negative on failure
+ */
+static int enable_fwdebug(const struct ocxlpmem *ocxlpmem)
+{
+	return ocxl_global_mmio_set64(ocxlpmem->ocxl_afu, GLOBAL_MMIO_HCI,
+				      OCXL_LITTLE_ENDIAN,
+				      GLOBAL_MMIO_HCI_FW_DEBUG);
+}
+
+/**
+ * disable_fwdebug() - Disable FW debug on the controller
+ * @ocxlpmem: the device metadata
+ * Return: 0 on success, negative on failure
+ */
+static int disable_fwdebug(const struct ocxlpmem *ocxlpmem)
+{
+	return ocxl_global_mmio_set64(ocxlpmem->ocxl_afu, GLOBAL_MMIO_HCIC,
+				      OCXL_LITTLE_ENDIAN,
+				      GLOBAL_MMIO_HCI_FW_DEBUG);
+}
+
+static int ioctl_fwdebug(struct ocxlpmem *ocxlpmem,
+			     struct ioctl_ocxl_pmem_fwdebug __user *uarg)
+{
+	struct ioctl_ocxl_pmem_fwdebug args;
+	u64 val;
+	int i;
+	int rc;
+
+	if (copy_from_user(&args, uarg, sizeof(args)))
+		return -EFAULT;
+
+	// Buffer size must be a multiple of 8
+	if ((args.buf_size & 0x07))
+		return -EINVAL;
+
+	if (args.buf_size > ocxlpmem->admin_command.data_size)
+		return -EINVAL;
+
+	mutex_lock(&ocxlpmem->admin_command.lock);
+
+	rc = enable_fwdebug(ocxlpmem);
+	if (rc)
+		goto out;
+
+	rc = admin_command_request(ocxlpmem, ADMIN_COMMAND_FW_DEBUG);
+	if (rc)
+		goto out;
+
+	// Write DebugAction & FunctionCode
+	val = ((u64)args.debug_action << 56) | ((u64)args.function_code << 40);
+
+	rc = ocxl_global_mmio_write64(ocxlpmem->ocxl_afu,
+				      ocxlpmem->admin_command.request_offset + 0x08,
+				      OCXL_LITTLE_ENDIAN, val);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_write64(ocxlpmem->ocxl_afu,
+				      ocxlpmem->admin_command.request_offset + 0x10,
+				      OCXL_LITTLE_ENDIAN, args.debug_parameter_1);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_write64(ocxlpmem->ocxl_afu,
+				      ocxlpmem->admin_command.request_offset + 0x18,
+				      OCXL_LITTLE_ENDIAN, args.debug_parameter_2);
+	if (rc)
+		goto out;
+
+	for (i = 0x20; i < 0x38; i += 0x08)
+		rc = ocxl_global_mmio_write64(ocxlpmem->ocxl_afu,
+					      ocxlpmem->admin_command.request_offset + i,
+					      OCXL_LITTLE_ENDIAN, 0);
+	if (rc)
+		goto out;
+
+
+	// Populate admin command buffer
+	if (args.buf_size) {
+		for (i = 0; i < args.buf_size; i += sizeof(u64)) {
+			u64 val;
+
+			if (copy_from_user(&val, &args.buf[i], sizeof(u64)))
+				return -EFAULT;
+
+			rc = ocxl_global_mmio_write64(ocxlpmem->ocxl_afu,
+						      ocxlpmem->admin_command.data_offset + i,
+						      OCXL_HOST_ENDIAN, val);
+			if (rc)
+				goto out;
+		}
+	}
+
+	rc = admin_command_execute(ocxlpmem);
+	if (rc)
+		goto out;
+
+	rc = admin_command_complete_timeout(ocxlpmem,
+					    ocxlpmem->timeouts[ADMIN_COMMAND_FW_DEBUG]);
+	if (rc < 0)
+		goto out;
+
+	rc = admin_response(ocxlpmem);
+	if (rc < 0)
+		goto out;
+	if (rc != STATUS_SUCCESS) {
+		warn_status(ocxlpmem, "Unexpected status from FW Debug", rc);
+		goto out;
+	}
+
+	if (args.buf_size) {
+		for (i = 0; i < args.buf_size; i += sizeof(u64)) {
+			u64 val;
+
+			rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
+						     ocxlpmem->admin_command.data_offset + i,
+						     OCXL_HOST_ENDIAN, &val);
+			if (rc)
+				goto out;
+
+			if (copy_to_user(&args.buf[i], &val, sizeof(u64))) {
+				rc = -EFAULT;
+				goto out;
+			}
+		}
+	}
+
+	rc = admin_response_handled(ocxlpmem);
+	if (rc)
+		goto out;
+
+	rc = disable_fwdebug(ocxlpmem);
+	if (rc)
+		goto out;
+
+out:
+	mutex_unlock(&ocxlpmem->admin_command.lock);
+	return rc;
+}
+
+static int ioctl_shutdown(struct ocxlpmem *ocxlpmem)
+{
+	int rc;
+
+	mutex_lock(&ocxlpmem->admin_command.lock);
+
+	rc = admin_command_request(ocxlpmem, ADMIN_COMMAND_SHUTDOWN);
+	if (rc)
+		goto out;
+
+	rc = admin_command_execute(ocxlpmem);
+	if (rc)
+		goto out;
+
+	rc = admin_command_complete_timeout(ocxlpmem, ADMIN_COMMAND_SHUTDOWN);
+	if (rc < 0) {
+		dev_warn(&ocxlpmem->dev, "Shutdown timed out\n");
+		goto out;
+	}
+
+	rc = 0;
+	goto out;
+
+out:
+	mutex_unlock(&ocxlpmem->admin_command.lock);
+	return rc;
+}
+
+static int ioctl_mmio_write(struct ocxlpmem *ocxlpmem,
+				struct ioctl_ocxl_pmem_mmio __user *uarg)
+{
+	struct scm_ioctl_mmio args;
+
+	if (copy_from_user(&args, uarg, sizeof(args)))
+		return -EFAULT;
+
+	return ocxl_global_mmio_write64(ocxlpmem->ocxl_afu, args.address,
+					OCXL_LITTLE_ENDIAN, args.val);
+}
+
+static int ioctl_mmio_read(struct ocxlpmem *ocxlpmem,
+				     struct ioctl_ocxl_pmem_mmio __user *uarg)
+{
+	struct ioctl_ocxl_pmem_mmio args;
+	int rc;
+
+	if (copy_from_user(&args, uarg, sizeof(args)))
+		return -EFAULT;
+
+	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu, args.address,
+				     OCXL_LITTLE_ENDIAN, &args.val);
+	if (rc)
+		return rc;
+
+	if (copy_to_user(uarg, &args, sizeof(args)))
+		return -EFAULT;
+
+	return 0;
+}
+#else /* CONFIG_OCXL_PMEM_DEBUG */
+static int ioctl_fwdebug(struct ocxlpmem *ocxlpmem,
+			     struct ioctl_ocxl_pmem_fwdebug __user *uarg)
+{
+	return -EPERM;
+}
+
+static int ioctl_shutdown(struct ocxlpmem *ocxlpmem)
+{
+	return -EPERM;
+}
+
+static int ioctl_mmio_write(struct ocxlpmem *ocxlpmem,
+				struct ioctl_ocxl_pmem_mmio __user *uarg)
+{
+	return -EPERM;
+}
+
+static int ioctl_mmio_read(struct ocxlpmem *ocxlpmem,
+			       struct ioctl_ocxl_pmem_mmio __user *uarg)
+{
+	return -EPERM;
+}
+#endif /* CONFIG_OCXL_PMEM_DEBUG */
+
 static long file_ioctl(struct file *file, unsigned int cmd, unsigned long args)
 {
 	struct ocxlpmem *ocxlpmem = file->private_data;
@@ -1091,6 +1320,26 @@ static long file_ioctl(struct file *file, unsigned int cmd, unsigned long args)
 	case IOCTL_OCXL_PMEM_REQUEST_HEALTH:
 		rc = req_controller_health_perf(ocxlpmem);
 		break;
+
+	case IOCTL_OCXL_PMEM_FWDEBUG:
+		rc = ioctl_fwdebug(ocxlpmem,
+				   (struct ioctl_ocxl_pmem_fwdebug __user *)args);
+		break;
+
+	case IOCTL_OCXL_PMEM_SHUTDOWN:
+		rc = ioctl_shutdown(ocxlpmem);
+		break;
+
+	case IOCTL_OCXL_PMEM_MMIO_WRITE:
+		rc = ioctl_mmio_write(ocxlpmem,
+				      (struct ioctl_ocxl_pmem_mmio __user *)args);
+		break;
+
+	case IOCTL_OCXL_PMEM_MMIO_READ:
+		rc = ioctl_mmio_read(ocxlpmem,
+				     (struct ioctl_ocxl_pmem_mmio __user *)args);
+		break;
+
 	}
 
 	return rc;
diff --git a/include/uapi/nvdimm/ocxl-pmem.h b/include/uapi/nvdimm/ocxl-pmem.h
index 0d03abb44001..e20a4f8be82a 100644
--- a/include/uapi/nvdimm/ocxl-pmem.h
+++ b/include/uapi/nvdimm/ocxl-pmem.h
@@ -6,6 +6,28 @@
 #include <linux/types.h>
 #include <linux/ioctl.h>
 
+enum ocxlpmem_fwdebug_action {
+	OCXL_PMEM_FWDEBUG_READ_CONTROLLER_MEMORY = 0x01,
+	OCXL_PMEM_FWDEBUG_WRITE_CONTROLLER_MEMORY = 0x02,
+	OCXL_PMEM_FWDEBUG_ENABLE_FUNCTION = 0x03,
+	OCXL_PMEM_FWDEBUG_DISABLE_FUNCTION = 0x04,
+	OCXL_PMEM_FWDEBUG_GET_PEL = 0x05, // Retrieve Persistent Error Log
+};
+
+struct ioctl_ocxl_pmem_buffer_info {
+	__u32	admin_command_buffer_size; // out
+	__u32	near_storage_buffer_size; // out
+};
+
+struct ioctl_ocxl_pmem_fwdebug { // All args are inputs
+	enum ocxlpmem_fwdebug_action debug_action;
+	__u16 function_code;
+	__u16 buf_size; // Size of optional data buffer
+	__u64 debug_parameter_1;
+	__u64 debug_parameter_2;
+	__u8 *buf; // Pointer to optional in/out data buffer
+};
+
 #define OCXL_PMEM_ERROR_LOG_ACTION_RESET	(1 << (32-32))
 #define OCXL_PMEM_ERROR_LOG_ACTION_CHKFW	(1 << (53-32))
 #define OCXL_PMEM_ERROR_LOG_ACTION_REPLACE	(1 << (54-32))
@@ -66,6 +88,11 @@ struct ioctl_ocxl_pmem_controller_stats {
 	__u64 cache_write_latency; /* nanoseconds */
 };
 
+struct ioctl_ocxl_pmem_mmio {
+	__u64 address; /* Offset in global MMIO space */
+	__u64 val; /* value to write/was read */
+};
+
 struct ioctl_ocxl_pmem_eventfd {
 	__s32 eventfd;
 	__u32 reserved;
@@ -92,4 +119,9 @@ struct ioctl_ocxl_pmem_eventfd {
 #define IOCTL_OCXL_PMEM_EVENT_CHECK			_IOR(OCXL_PMEM_MAGIC, 0x07, __u64)
 #define IOCTL_OCXL_PMEM_REQUEST_HEALTH			_IO(OCXL_PMEM_MAGIC, 0x08)
 
+#define IOCTL_OCXL_PMEM_FWDEBUG		_IOWR(OCXL_PMEM_MAGIC, 0xf0, struct ioctl_ocxl_pmem_fwdebug)
+#define IOCTL_OCXL_PMEM_MMIO_WRITE	_IOW(OCXL_PMEM_MAGIC, 0xf1, struct ioctl_ocxl_pmem_mmio)
+#define IOCTL_OCXL_PMEM_MMIO_READ	_IOWR(OCXL_PMEM_MAGIC, 0xf2, struct ioctl_ocxl_pmem_mmio)
+#define IOCTL_OCXL_PMEM_SHUTDOWN	_IO(OCXL_PMEM_MAGIC, 0xf3)
+
 #endif /* _UAPI_OCXL_SCM_H */
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

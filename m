Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2513B10F5CE
	for <lists+linux-nvdimm@lfdr.de>; Tue,  3 Dec 2019 04:49:08 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 774A810097F12;
	Mon,  2 Dec 2019 19:52:06 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 75EF610113688
	for <linux-nvdimm@lists.01.org>; Mon,  2 Dec 2019 19:51:58 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB33kc7C087993
	for <linux-nvdimm@lists.01.org>; Mon, 2 Dec 2019 22:48:35 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2wkm47b7vv-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Mon, 02 Dec 2019 22:48:34 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Tue, 3 Dec 2019 03:48:26 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
	by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 3 Dec 2019 03:48:19 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB33mIc063111208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Dec 2019 03:48:18 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97C144C04E;
	Tue,  3 Dec 2019 03:48:18 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0002A4C044;
	Tue,  3 Dec 2019 03:48:17 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue,  3 Dec 2019 03:48:17 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 8DC01A03EB;
	Tue,  3 Dec 2019 14:48:13 +1100 (AEDT)
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: alastair@d-silva.org
Subject: [PATCH v2 23/27] nvdimm/ocxl: Add debug IOCTLs
Date: Tue,  3 Dec 2019 14:46:51 +1100
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191203034655.51561-1-alastair@au1.ibm.com>
References: <20191203034655.51561-1-alastair@au1.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19120303-4275-0000-0000-0000038A31DF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120303-4276-0000-0000-0000389DCDDA
Message-Id: <20191203034655.51561-24-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_06:2019-11-29,2019-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 impostorscore=0 adultscore=0 suspectscore=1 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912030032
Message-ID-Hash: GJJJJFYI357YFAAC6HARQY54MFN2MJXN
X-Message-ID-Hash: GJJJJFYI357YFAAC6HARQY54MFN2MJXN
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-dev@list
 s.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GJJJJFYI357YFAAC6HARQY54MFN2MJXN/>
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
 drivers/nvdimm/ocxl/Kconfig    |   6 +
 drivers/nvdimm/ocxl/scm.c      | 249 +++++++++++++++++++++++++++++++++
 include/uapi/nvdimm/ocxl-scm.h |  32 +++++
 3 files changed, 287 insertions(+)

diff --git a/drivers/nvdimm/ocxl/Kconfig b/drivers/nvdimm/ocxl/Kconfig
index 24099b300f5e..1df030cdd958 100644
--- a/drivers/nvdimm/ocxl/Kconfig
+++ b/drivers/nvdimm/ocxl/Kconfig
@@ -12,4 +12,10 @@ config OCXL_SCM
 
 	  Select N if unsure.
 
+config OCXL_SCM_DEBUG
+	bool "OpenCAPI Storage Class Memory debugging"
+	depends on OCXL_SCM
+	help
+	  Enables low level IOCTLs for OpenCAPI SCM firmware development
+
 endif
diff --git a/drivers/nvdimm/ocxl/scm.c b/drivers/nvdimm/ocxl/scm.c
index e8b34262f397..a81eb5916eb3 100644
--- a/drivers/nvdimm/ocxl/scm.c
+++ b/drivers/nvdimm/ocxl/scm.c
@@ -1098,6 +1098,235 @@ int scm_req_controller_health_perf(struct scm_data *scm_data)
 				      GLOBAL_MMIO_HCI_REQ_HEALTH_PERF);
 }
 
+#ifdef CONFIG_OCXL_SCM_DEBUG
+/**
+ * scm_enable_fwdebug() - Enable FW debug on the controller
+ * @scm_data: a pointer to the SCM device data
+ * Return: 0 on success, negative on failure
+ */
+static int scm_enable_fwdebug(const struct scm_data *scm_data)
+{
+	return ocxl_global_mmio_set64(scm_data->ocxl_afu, GLOBAL_MMIO_HCI,
+				      OCXL_LITTLE_ENDIAN,
+				      GLOBAL_MMIO_HCI_FW_DEBUG);
+}
+
+/**
+ * scm_disable_fwdebug() - Disable FW debug on the controller
+ * @scm_data: a pointer to the SCM device data
+ * Return: 0 on success, negative on failure
+ */
+static int scm_disable_fwdebug(const struct scm_data *scm_data)
+{
+	return ocxl_global_mmio_set64(scm_data->ocxl_afu, GLOBAL_MMIO_HCIC,
+				      OCXL_LITTLE_ENDIAN,
+				      GLOBAL_MMIO_HCI_FW_DEBUG);
+}
+
+static int scm_ioctl_fwdebug(struct scm_data *scm_data,
+			     struct scm_ioctl_fwdebug __user *uarg)
+{
+	struct scm_ioctl_fwdebug args;
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
+	if (args.buf_size > scm_data->admin_command.data_size)
+		return -EINVAL;
+
+	mutex_lock(&scm_data->admin_command.lock);
+
+	rc = scm_enable_fwdebug(scm_data);
+	if (rc)
+		goto out;
+
+	rc = scm_admin_command_request(scm_data, ADMIN_COMMAND_FW_DEBUG);
+	if (rc)
+		goto out;
+
+	// Write DebugAction & FunctionCode
+	val = ((u64)args.debug_action << 56) | ((u64)args.function_code << 40);
+
+	rc = ocxl_global_mmio_write64(scm_data->ocxl_afu,
+				      scm_data->admin_command.request_offset + 0x08,
+				      OCXL_LITTLE_ENDIAN, val);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_write64(scm_data->ocxl_afu,
+				      scm_data->admin_command.request_offset + 0x10,
+				      OCXL_LITTLE_ENDIAN, args.debug_parameter_1);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_write64(scm_data->ocxl_afu,
+				      scm_data->admin_command.request_offset + 0x18,
+				      OCXL_LITTLE_ENDIAN, args.debug_parameter_2);
+	if (rc)
+		goto out;
+
+	for (i = 0x20; i < 0x38; i += 0x08)
+		rc = ocxl_global_mmio_write64(scm_data->ocxl_afu,
+					      scm_data->admin_command.request_offset + i,
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
+			rc = ocxl_global_mmio_write64(scm_data->ocxl_afu,
+						      scm_data->admin_command.data_offset + i,
+						      OCXL_HOST_ENDIAN, val);
+			if (rc)
+				goto out;
+		}
+	}
+
+	rc = scm_admin_command_execute(scm_data);
+	if (rc)
+		goto out;
+
+	rc = scm_admin_command_complete_timeout(scm_data,
+						scm_data->timeouts[ADMIN_COMMAND_FW_DEBUG]);
+	if (rc < 0)
+		goto out;
+
+	rc = scm_admin_response(scm_data);
+	if (rc < 0)
+		goto out;
+	if (rc != STATUS_SUCCESS) {
+		scm_warn_status(scm_data, "Unexpected status from FW Debug", rc);
+		goto out;
+	}
+
+	if (args.buf_size) {
+		for (i = 0; i < args.buf_size; i += sizeof(u64)) {
+			u64 val;
+
+			rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+						     scm_data->admin_command.data_offset + i,
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
+	rc = scm_admin_response_handled(scm_data);
+	if (rc)
+		goto out;
+
+	rc = scm_disable_fwdebug(scm_data);
+	if (rc)
+		goto out;
+
+out:
+	mutex_unlock(&scm_data->admin_command.lock);
+	return rc;
+}
+
+static int scm_ioctl_shutdown(struct scm_data *scm_data)
+{
+	int rc;
+
+	mutex_lock(&scm_data->admin_command.lock);
+
+	rc = scm_admin_command_request(scm_data, ADMIN_COMMAND_SHUTDOWN);
+	if (rc)
+		goto out;
+
+	rc = scm_admin_command_execute(scm_data);
+	if (rc)
+		goto out;
+
+	rc = scm_admin_command_complete_timeout(scm_data, ADMIN_COMMAND_SHUTDOWN);
+	if (rc < 0) {
+		dev_warn(&scm_data->dev, "Shutdown timed out\n");
+		goto out;
+	}
+
+	rc = 0;
+	goto out;
+
+out:
+	mutex_unlock(&scm_data->admin_command.lock);
+	return rc;
+}
+
+static int scm_ioctl_mmio_write(struct scm_data *scm_data,
+				struct scm_ioctl_mmio __user *uarg)
+{
+	struct scm_ioctl_mmio args;
+
+	if (copy_from_user(&args, uarg, sizeof(args)))
+		return -EFAULT;
+
+	return ocxl_global_mmio_write64(scm_data->ocxl_afu, args.address,
+					OCXL_LITTLE_ENDIAN, args.val);
+}
+
+static int scm_ioctl_mmio_read(struct scm_data *scm_data,
+			       struct scm_ioctl_mmio __user *uarg)
+{
+	struct scm_ioctl_mmio args;
+	int rc;
+
+	if (copy_from_user(&args, uarg, sizeof(args)))
+		return -EFAULT;
+
+	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu, args.address,
+				     OCXL_LITTLE_ENDIAN, &args.val);
+	if (rc)
+		return rc;
+
+	if (copy_to_user(uarg, &args, sizeof(args)))
+		return -EFAULT;
+
+	return 0;
+}
+#else /* CONFIG_OCXL_SCM_DEBUG */
+static int scm_ioctl_fwdebug(struct scm_data *scm_data,
+			     struct scm_ioctl_fwdebug __user *uarg)
+{
+	return -EPERM;
+}
+
+static int scm_ioctl_shutdown(struct scm_data *scm_data)
+{
+	return -EPERM;
+}
+
+static int scm_ioctl_mmio_write(struct scm_data *scm_data,
+				struct scm_ioctl_mmio __user *uarg)
+{
+	return -EPERM;
+}
+
+static int scm_ioctl_mmio_read(struct scm_data *scm_data,
+			       struct scm_ioctl_mmio __user *uarg)
+{
+	return -EPERM;
+}
+#endif /* CONFIG_OCXL_SCM_DEBUG */
+
 static long scm_file_ioctl(struct file *file, unsigned int cmd,
 			   unsigned long args)
 {
@@ -1140,6 +1369,26 @@ static long scm_file_ioctl(struct file *file, unsigned int cmd,
 	case SCM_IOCTL_REQUEST_HEALTH:
 		rc = scm_req_controller_health_perf(scm_data);
 		break;
+
+	case SCM_IOCTL_FWDEBUG:
+		rc = scm_ioctl_fwdebug(scm_data,
+				       (struct scm_ioctl_fwdebug __user *)args);
+		break;
+
+	case SCM_IOCTL_SHUTDOWN:
+		rc = scm_ioctl_shutdown(scm_data);
+		break;
+
+	case SCM_IOCTL_MMIO_WRITE:
+		rc = scm_ioctl_mmio_write(scm_data,
+					  (struct scm_ioctl_mmio __user *)args);
+		break;
+
+	case SCM_IOCTL_MMIO_READ:
+		rc = scm_ioctl_mmio_read(scm_data,
+					 (struct scm_ioctl_mmio __user *)args);
+		break;
+
 	}
 
 	return rc;
diff --git a/include/uapi/nvdimm/ocxl-scm.h b/include/uapi/nvdimm/ocxl-scm.h
index 55a7ad59d614..6e0f25c5f9f3 100644
--- a/include/uapi/nvdimm/ocxl-scm.h
+++ b/include/uapi/nvdimm/ocxl-scm.h
@@ -6,6 +6,28 @@
 #include <linux/types.h>
 #include <linux/ioctl.h>
 
+enum scm_fwdebug_action {
+	SCM_FWDEBUG_READ_CONTROLLER_MEMORY = 0x01,
+	SCM_FWDEBUG_WRITE_CONTROLLER_MEMORY = 0x02,
+	SCM_FWDEBUG_ENABLE_FUNCTION = 0x03,
+	SCM_FWDEBUG_DISABLE_FUNCTION = 0x04,
+	SCM_FWDEBUG_GET_PEL = 0x05, // Retrieve Persistent Error Log
+};
+
+struct scm_ioctl_buffer_info {
+	__u32	admin_command_buffer_size; // out
+	__u32	near_storage_buffer_size; // out
+};
+
+struct scm_ioctl_fwdebug { // All args are inputs
+	enum scm_fwdebug_action debug_action;
+	__u16 function_code;
+	__u16 buf_size; // Size of optional data buffer
+	__u64 debug_parameter_1;
+	__u64 debug_parameter_2;
+	__u8 *buf; // Pointer to optional in/out data buffer
+};
+
 #define SCM_ERROR_LOG_ACTION_RESET	(1 << (32-32))
 #define SCM_ERROR_LOG_ACTION_CHKFW	(1 << (53-32))
 #define SCM_ERROR_LOG_ACTION_REPLACE	(1 << (54-32))
@@ -66,6 +88,11 @@ struct scm_ioctl_controller_stats {
 	__u64 cache_write_latency; // nanoseconds
 };
 
+struct scm_ioctl_mmio {
+	__u64 address; // Offset in global MMIO space
+	__u64 val; // value to write/was read
+};
+
 struct scm_ioctl_eventfd {
 	__s32 eventfd;
 	__u32 reserved;
@@ -92,4 +119,9 @@ struct scm_ioctl_eventfd {
 #define SCM_IOCTL_EVENT_CHECK	_IOR(SCM_MAGIC, 0x07, __u64)
 #define SCM_IOCTL_REQUEST_HEALTH _IO(SCM_MAGIC, 0x08)
 
+#define SCM_IOCTL_FWDEBUG	_IOWR(SCM_MAGIC, 0xf0, struct scm_ioctl_fwdebug)
+#define SCM_IOCTL_MMIO_WRITE	_IOW(SCM_MAGIC, 0xf1, struct scm_ioctl_mmio)
+#define SCM_IOCTL_MMIO_READ	_IOWR(SCM_MAGIC, 0xf2, struct scm_ioctl_mmio)
+#define SCM_IOCTL_SHUTDOWN	_IO(SCM_MAGIC, 0xf3)
+
 #endif /* _UAPI_OCXL_SCM_H */
-- 
2.23.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97F1166DA2
	for <lists+linux-nvdimm@lfdr.de>; Fri, 21 Feb 2020 04:28:54 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5A6B910FC362A;
	Thu, 20 Feb 2020 19:29:23 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3708510FC3606
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 19:29:16 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01L3JEZx020263
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 22:28:23 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2y8ubxhfj2-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 22:28:23 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Fri, 21 Feb 2020 03:28:19 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
	by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 21 Feb 2020 03:28:12 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01L3SB5N31981874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2020 03:28:11 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3697A52050;
	Fri, 21 Feb 2020 03:28:11 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8A24B5204E;
	Fri, 21 Feb 2020 03:28:10 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id A30CDA03DF;
	Fri, 21 Feb 2020 14:28:03 +1100 (AEDT)
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: alastair@d-silva.org
Subject: [PATCH v3 18/27] powerpc/powernv/pmem: Add controller dump IOCTLs
Date: Fri, 21 Feb 2020 14:27:11 +1100
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200221032720.33893-1-alastair@au1.ibm.com>
References: <20200221032720.33893-1-alastair@au1.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20022103-0016-0000-0000-000002E8CEC4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022103-0017-0000-0000-0000334BED97
Message-Id: <20200221032720.33893-19-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_19:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=74 mlxscore=74 bulkscore=0
 lowpriorityscore=0 spamscore=74 suspectscore=1 mlxlogscore=-44
 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210020
Message-ID-Hash: CTIMOEWHFKUSLK4YQ4G2BENNVI2V6XUG
X-Message-ID-Hash: CTIMOEWHFKUSLK4YQ4G2BENNVI2V6XUG
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.r
 u>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CTIMOEWHFKUSLK4YQ4G2BENNVI2V6XUG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Alastair D'Silva <alastair@d-silva.org>

This patch adds IOCTLs to allow userspace to request & fetch dumps
of the internal controller state.

This is useful during debugging or when a fatal error on the controller
has occurred.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/powerpc/platforms/powernv/pmem/ocxl.c | 132 +++++++++++++++++++++
 include/uapi/nvdimm/ocxl-pmem.h            |  15 +++
 2 files changed, 147 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pmem/ocxl.c b/arch/powerpc/platforms/powernv/pmem/ocxl.c
index 2b64504f9129..2cabafe1fc58 100644
--- a/arch/powerpc/platforms/powernv/pmem/ocxl.c
+++ b/arch/powerpc/platforms/powernv/pmem/ocxl.c
@@ -640,6 +640,124 @@ static int ioctl_error_log(struct ocxlpmem *ocxlpmem,
 	return 0;
 }
 
+static int ioctl_controller_dump_data(struct ocxlpmem *ocxlpmem,
+		struct ioctl_ocxl_pmem_controller_dump_data __user *uarg)
+{
+	struct ioctl_ocxl_pmem_controller_dump_data args;
+	u16 i;
+	u64 val;
+	int rc;
+
+	if (copy_from_user(&args, uarg, sizeof(args)))
+		return -EFAULT;
+
+	if (args.buf_size % 8)
+		return -EINVAL;
+
+	if (args.buf_size > ocxlpmem->admin_command.data_size)
+		return -EINVAL;
+
+	mutex_lock(&ocxlpmem->admin_command.lock);
+
+	rc = admin_command_request(ocxlpmem, ADMIN_COMMAND_CONTROLLER_DUMP);
+	if (rc)
+		goto out;
+
+	val = ((u64)args.offset) << 32;
+	val |= args.buf_size;
+	rc = ocxl_global_mmio_write64(ocxlpmem->ocxl_afu,
+				      ocxlpmem->admin_command.request_offset + 0x08,
+				      OCXL_LITTLE_ENDIAN, val);
+	if (rc)
+		goto out;
+
+	rc = admin_command_execute(ocxlpmem);
+	if (rc)
+		goto out;
+
+	rc = admin_command_complete_timeout(ocxlpmem,
+					    ADMIN_COMMAND_CONTROLLER_DUMP);
+	if (rc < 0) {
+		dev_warn(&ocxlpmem->dev, "Controller dump timed out\n");
+		goto out;
+	}
+
+	rc = admin_response(ocxlpmem);
+	if (rc < 0)
+		goto out;
+	if (rc != STATUS_SUCCESS) {
+		warn_status(ocxlpmem,
+			    "Unexpected status from retrieve error log",
+			    rc);
+		goto out;
+	}
+
+	for (i = 0; i < args.buf_size; i += 8) {
+		u64 val;
+
+		rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
+					     ocxlpmem->admin_command.data_offset + i,
+					     OCXL_HOST_ENDIAN, &val);
+		if (rc)
+			goto out;
+
+		if (copy_to_user(&args.buf[i], &val, sizeof(u64))) {
+			rc = -EFAULT;
+			goto out;
+		}
+	}
+
+	if (copy_to_user(uarg, &args, sizeof(args))) {
+		rc = -EFAULT;
+		goto out;
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
+int request_controller_dump(struct ocxlpmem *ocxlpmem)
+{
+	int rc;
+	u64 busy = 1;
+
+	rc = ocxl_global_mmio_set64(ocxlpmem->ocxl_afu, GLOBAL_MMIO_CHIC,
+				    OCXL_LITTLE_ENDIAN,
+				    GLOBAL_MMIO_CHI_CDA);
+
+
+	rc = ocxl_global_mmio_set64(ocxlpmem->ocxl_afu, GLOBAL_MMIO_HCI,
+				    OCXL_LITTLE_ENDIAN,
+				    GLOBAL_MMIO_HCI_CONTROLLER_DUMP);
+	if (rc)
+		return rc;
+
+	while (busy) {
+		rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
+					     GLOBAL_MMIO_HCI,
+					     OCXL_LITTLE_ENDIAN, &busy);
+		if (rc)
+			return rc;
+
+		busy &= GLOBAL_MMIO_HCI_CONTROLLER_DUMP;
+		cond_resched();
+	}
+
+	return 0;
+}
+
+static int ioctl_controller_dump_complete(struct ocxlpmem *ocxlpmem)
+{
+	return ocxl_global_mmio_set64(ocxlpmem->ocxl_afu, GLOBAL_MMIO_HCI,
+				    OCXL_LITTLE_ENDIAN,
+				    GLOBAL_MMIO_HCI_CONTROLLER_DUMP_COLLECTED);
+}
+
 static long file_ioctl(struct file *file, unsigned int cmd, unsigned long args)
 {
 	struct ocxlpmem *ocxlpmem = file->private_data;
@@ -650,7 +768,21 @@ static long file_ioctl(struct file *file, unsigned int cmd, unsigned long args)
 		rc = ioctl_error_log(ocxlpmem,
 				     (struct ioctl_ocxl_pmem_error_log __user *)args);
 		break;
+
+	case IOCTL_OCXL_PMEM_CONTROLLER_DUMP:
+		rc = request_controller_dump(ocxlpmem);
+		break;
+
+	case IOCTL_OCXL_PMEM_CONTROLLER_DUMP_DATA:
+		rc = ioctl_controller_dump_data(ocxlpmem,
+						(struct ioctl_ocxl_pmem_controller_dump_data __user *)args);
+		break;
+
+	case IOCTL_OCXL_PMEM_CONTROLLER_DUMP_COMPLETE:
+		rc = ioctl_controller_dump_complete(ocxlpmem);
+		break;
 	}
+
 	return rc;
 }
 
diff --git a/include/uapi/nvdimm/ocxl-pmem.h b/include/uapi/nvdimm/ocxl-pmem.h
index b10f8ac0c20f..d4d8512d03f7 100644
--- a/include/uapi/nvdimm/ocxl-pmem.h
+++ b/include/uapi/nvdimm/ocxl-pmem.h
@@ -38,9 +38,24 @@ struct ioctl_ocxl_pmem_error_log {
 	__u8 *buf; /* pointer to output buffer */
 };
 
+struct ioctl_ocxl_pmem_controller_dump_data {
+	__u8 *buf; /* pointer to output buffer */
+	__u16 buf_size; /* in/out, buffer size provided/required.
+			 * If required is greater than provided, the buffer
+			 * will be truncated to the amount provided. If its
+			 * less, then only the required bytes will be populated.
+			 * If it is 0, then there is no more dump data available.
+			 */
+	__u32 offset; /* in, Offset within the dump */
+	__u64 reserved[8];
+};
+
 /* ioctl numbers */
 #define OCXL_PMEM_MAGIC 0x5C
 /* SCM devices */
 #define IOCTL_OCXL_PMEM_ERROR_LOG			_IOWR(OCXL_PMEM_MAGIC, 0x01, struct ioctl_ocxl_pmem_error_log)
+#define IOCTL_OCXL_PMEM_CONTROLLER_DUMP			_IO(OCXL_PMEM_MAGIC, 0x02)
+#define IOCTL_OCXL_PMEM_CONTROLLER_DUMP_DATA		_IOWR(OCXL_PMEM_MAGIC, 0x03, struct ioctl_ocxl_pmem_controller_dump_data)
+#define IOCTL_OCXL_PMEM_CONTROLLER_DUMP_COMPLETE	_IO(OCXL_PMEM_MAGIC, 0x04)
 
 #endif /* _UAPI_OCXL_SCM_H */
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

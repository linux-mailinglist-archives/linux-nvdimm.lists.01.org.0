Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1444E10F5BF
	for <lists+linux-nvdimm@lfdr.de>; Tue,  3 Dec 2019 04:48:53 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2DB771011368A;
	Mon,  2 Dec 2019 19:52:00 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9EEE010113669
	for <linux-nvdimm@lists.01.org>; Mon,  2 Dec 2019 19:51:53 -0800 (PST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB33kmRn076422
	for <linux-nvdimm@lists.01.org>; Mon, 2 Dec 2019 22:48:30 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2wm6s60fp8-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Mon, 02 Dec 2019 22:48:30 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Tue, 3 Dec 2019 03:48:26 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
	by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 3 Dec 2019 03:48:20 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB33mJe930998776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Dec 2019 03:48:19 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2870F4C052;
	Tue,  3 Dec 2019 03:48:19 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 802D44C046;
	Tue,  3 Dec 2019 03:48:18 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue,  3 Dec 2019 03:48:18 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 5663FA03E6;
	Tue,  3 Dec 2019 14:48:13 +1100 (AEDT)
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: alastair@d-silva.org
Subject: [PATCH v2 18/27] nvdimm/ocxl: Add an IOCTL to report controller statistics
Date: Tue,  3 Dec 2019 14:46:46 +1100
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191203034655.51561-1-alastair@au1.ibm.com>
References: <20191203034655.51561-1-alastair@au1.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19120303-0016-0000-0000-000002D0158D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120303-0017-0000-0000-000033320CA8
Message-Id: <20191203034655.51561-19-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_06:2019-11-29,2019-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=722 suspectscore=1 clxscore=1015 priorityscore=1501
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912030032
Message-ID-Hash: LXC5UBUGU3PBPOROXZ52HXKVERSTQWSM
X-Message-ID-Hash: LXC5UBUGU3PBPOROXZ52HXKVERSTQWSM
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-dev@list
 s.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LXC5UBUGU3PBPOROXZ52HXKVERSTQWSM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Alastair D'Silva <alastair@d-silva.org>

The controller can report a number of statistics that are useful
in evaluating the performance and reliability of the card.

This patch exposes this information via an IOCTL.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/nvdimm/ocxl/scm.c      | 185 +++++++++++++++++++++++++++++++++
 include/uapi/nvdimm/ocxl-scm.h |  17 +++
 2 files changed, 202 insertions(+)

diff --git a/drivers/nvdimm/ocxl/scm.c b/drivers/nvdimm/ocxl/scm.c
index a520f209d626..54a2bac1cab7 100644
--- a/drivers/nvdimm/ocxl/scm.c
+++ b/drivers/nvdimm/ocxl/scm.c
@@ -806,6 +806,186 @@ static int scm_ioctl_controller_dump_complete(struct scm_data *scm_data)
 				    GLOBAL_MMIO_HCI_CONTROLLER_DUMP_COLLECTED);
 }
 
+/**
+ * scm_controller_stats_header_parse() - Parse the first 64 bits of the controller stats admin command response
+ * @scm_data: the SCM metadata
+ * @length: out, returns the number of bytes in the response (excluding the 64 bit header)
+ */
+static int scm_controller_stats_header_parse(struct scm_data *scm_data,
+	u32 *length)
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
+	data_length = val & 0xFFFFFFFF;
+
+	if (data_identifier != 0x4353) {
+		dev_err(&scm_data->dev,
+			"Bad data identifier for controller stats, expected 'CS', got '%-.*s'\n",
+			2, (char *)&data_identifier);
+		return -EINVAL;
+	}
+
+	*length = data_length;
+	return 0;
+}
+
+static int scm_ioctl_controller_stats(struct scm_data *scm_data,
+				      struct scm_ioctl_controller_stats __user *uarg)
+{
+	struct scm_ioctl_controller_stats args;
+	u32 length;
+	int rc;
+	u64 val;
+
+	memset(&args, '\0', sizeof(args));
+
+	mutex_lock(&scm_data->admin_command.lock);
+
+	rc = scm_admin_command_request(scm_data, ADMIN_COMMAND_CONTROLLER_STATS);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_write64(scm_data->ocxl_afu,
+				      scm_data->admin_command.request_offset + 0x08,
+				      OCXL_LITTLE_ENDIAN, 0);
+	if (rc)
+		goto out;
+
+	rc = scm_admin_command_execute(scm_data);
+	if (rc)
+		goto out;
+
+
+	rc = scm_admin_command_complete_timeout(scm_data,
+						ADMIN_COMMAND_CONTROLLER_STATS);
+	if (rc < 0) {
+		dev_warn(&scm_data->dev, "Controller stats timed out\n");
+		goto out;
+	}
+
+	rc = scm_admin_response(scm_data);
+	if (rc < 0)
+		goto out;
+	if (rc != STATUS_SUCCESS) {
+		scm_warn_status(scm_data,
+				"Unexpected status from controller stats", rc);
+		goto out;
+	}
+
+	rc = scm_controller_stats_header_parse(scm_data, &length);
+	if (rc)
+		goto out;
+
+	if (length != 0x140)
+		scm_warn_status(scm_data,
+				"Unexpected length for controller stats data, expected 0x140, got 0x%x",
+				length);
+
+	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+				     scm_data->admin_command.data_offset + 0x08 + 0x08,
+				     OCXL_LITTLE_ENDIAN, &val);
+	if (rc)
+		goto out;
+
+	args.reset_count = val >> 32;
+	args.reset_uptime = val & 0xFFFFFFFF;
+
+	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+				     scm_data->admin_command.data_offset + 0x08 + 0x10,
+				     OCXL_LITTLE_ENDIAN, &val);
+	if (rc)
+		goto out;
+
+	args.power_on_uptime = val >> 32;
+
+	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+				     scm_data->admin_command.data_offset + 0x08 + 0x40 + 0x08,
+				     OCXL_LITTLE_ENDIAN, &args.host_load_count);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+				     scm_data->admin_command.data_offset + 0x08 + 0x40 + 0x10,
+				     OCXL_LITTLE_ENDIAN, &args.host_store_count);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+				     scm_data->admin_command.data_offset + 0x08 + 0x40 + 0x18,
+				     OCXL_LITTLE_ENDIAN, &args.media_read_count);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+				     scm_data->admin_command.data_offset + 0x08 + 0x40 + 0x20,
+				     OCXL_LITTLE_ENDIAN, &args.media_write_count);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+				     scm_data->admin_command.data_offset + 0x08 + 0x40 + 0x28,
+				     OCXL_LITTLE_ENDIAN, &args.cache_hit_count);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+				     scm_data->admin_command.data_offset + 0x08 + 0x40 + 0x30,
+				     OCXL_LITTLE_ENDIAN, &args.cache_miss_count);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+				     scm_data->admin_command.data_offset + 0x08 + 0x40 + 0x38,
+				     OCXL_LITTLE_ENDIAN, &args.media_read_latency);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+				     scm_data->admin_command.data_offset + 0x08 + 0x40 + 0x40,
+				     OCXL_LITTLE_ENDIAN, &args.media_write_latency);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+				     scm_data->admin_command.data_offset + 0x08 + 0x40 + 0x48,
+				     OCXL_LITTLE_ENDIAN, &args.cache_read_latency);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
+				     scm_data->admin_command.data_offset + 0x08 + 0x40 + 0x50,
+				     OCXL_LITTLE_ENDIAN, &args.cache_write_latency);
+	if (rc)
+		goto out;
+
+	if (copy_to_user(uarg, &args, sizeof(args))) {
+		rc = -EFAULT;
+		goto out;
+	}
+
+	rc = scm_admin_response_handled(scm_data);
+	if (rc)
+		goto out;
+
+	rc = 0;
+	goto out;
+
+out:
+	mutex_unlock(&scm_data->admin_command.lock);
+	return rc;
+}
+
 static long scm_file_ioctl(struct file *file, unsigned int cmd,
 			   unsigned long args)
 {
@@ -830,6 +1010,11 @@ static long scm_file_ioctl(struct file *file, unsigned int cmd,
 	case SCM_IOCTL_CONTROLLER_DUMP_COMPLETE:
 		rc = scm_ioctl_controller_dump_complete(scm_data);
 		break;
+
+	case SCM_IOCTL_CONTROLLER_STATS:
+		rc = scm_ioctl_controller_stats(scm_data,
+						(struct scm_ioctl_controller_stats __user *)args);
+		break;
 	}
 
 	return rc;
diff --git a/include/uapi/nvdimm/ocxl-scm.h b/include/uapi/nvdimm/ocxl-scm.h
index abd2dc9ea112..0a5de46c5acd 100644
--- a/include/uapi/nvdimm/ocxl-scm.h
+++ b/include/uapi/nvdimm/ocxl-scm.h
@@ -50,6 +50,22 @@ struct scm_ioctl_controller_dump_data {
 	__u64 reserved[8];
 };
 
+struct scm_ioctl_controller_stats {
+	__u32 reset_count;
+	__u32 reset_uptime; // seconds
+	__u32 power_on_uptime; // seconds
+	__u64 host_load_count;
+	__u64 host_store_count;
+	__u64 media_read_count;
+	__u64 media_write_count;
+	__u64 cache_hit_count;
+	__u64 cache_miss_count;
+	__u64 media_read_latency; // nanoseconds
+	__u64 media_write_latency; // nanoseconds
+	__u64 cache_read_latency; // nanoseconds
+	__u64 cache_write_latency; // nanoseconds
+};
+
 /* ioctl numbers */
 #define SCM_MAGIC 0x5C
 /* SCM devices */
@@ -57,5 +73,6 @@ struct scm_ioctl_controller_dump_data {
 #define SCM_IOCTL_CONTROLLER_DUMP _IO(SCM_MAGIC, 0x02)
 #define SCM_IOCTL_CONTROLLER_DUMP_DATA _IOWR(SCM_MAGIC, 0x03, struct scm_ioctl_controller_dump_data)
 #define SCM_IOCTL_CONTROLLER_DUMP_COMPLETE _IO(SCM_MAGIC, 0x04)
+#define SCM_IOCTL_CONTROLLER_STATS _IO(SCM_MAGIC, 0x05)
 
 #endif /* _UAPI_OCXL_SCM_H */
-- 
2.23.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

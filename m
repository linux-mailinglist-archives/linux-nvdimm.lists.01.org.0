Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FB0198EFC
	for <lists+linux-nvdimm@lfdr.de>; Tue, 31 Mar 2020 10:59:30 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1F04910FC3890;
	Tue, 31 Mar 2020 02:00:19 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=66.55.73.32; helo=ushosting.nmnhosting.com; envelope-from=alastair@d-silva.org; receiver=<UNKNOWN> 
Received: from ushosting.nmnhosting.com (ushosting.nmnhosting.com [66.55.73.32])
	by ml01.01.org (Postfix) with ESMTP id 3D20E10FC388F
	for <linux-nvdimm@lists.01.org>; Tue, 31 Mar 2020 02:00:17 -0700 (PDT)
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
	by ushosting.nmnhosting.com (Postfix) with ESMTPS id BFE3E2DC6864;
	Mon, 30 Mar 2020 16:52:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
	s=201810a; t=1585547580;
	bh=c5YZBYO+yginh2wx+CLNIvIUORNFUjOABhnB4YY2rcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H7bb13EmE2VTz/xNCZFvHIKXPP3TeNvxDkuS5IRaBtVx57jSBYN2U2LYEtdHLKsJ3
	 w4c2EU9+WAnUbQQnn2xp5vsvkGT1oVzYp2Z/e9qG1S8bNA5QKVc7iJZO9lmsj3Qm4k
	 YIxHdAmnT7hBPI3FtB6+r7Ep+eYY2O7BpcwMIEw17UqxBr0Ip3WA1RahjZq5SGA5Ao
	 I23uOXicZiWYalDfMaAP2NyfLEbCxHY0EdojnqMAP/6/Tf+OvBKt2S3ukyx4Pr7N3r
	 6phOUFhEe0kGDr8SDz4olli9RICvKa9rm5WkiTQCTRUSDQb79fCJRSVqKQf6L7vh2K
	 CmuLTORzjDMeh9R9eyh8U6bRW8ofSvDfs5LP7/FcGukxTIsv83kPhH7UTN/r2SoUx4
	 0TAiI6GwCc26okqemO+Q+PxHryoajtYkGAdoiaHm03kfiZinubmAkuDC9YGhE8celo
	 fgVtJABORQ9OQtMPr394ZBKILzYYqr1Lx6qdvZrvB2OLIfP7Qu/LC0d1Ggjro7FRFo
	 nfEOFx2RlxtY/oMHljhuxCRnhvchR1YYea6iUPgWi01teicDbR1nfWmsbl5z+TTcD4
	 uyXvwNNJ98kh/UfzbI6Nzah+vwR8aHhe7kl+nvFRZHKmQQknMxkZ+Q/HK/UX9vOF4N
	 yWRGXpaYIXGr/tLjjgQJvnFQ=
Received: from localhost.lan ([10.0.1.179])
	by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTP id 02R7C4Ar045934;
	Fri, 27 Mar 2020 18:12:19 +1100 (AEDT)
	(envelope-from alastair@d-silva.org)
From: "Alastair D'Silva" <alastair@d-silva.org>
To: alastair@d-silva.org
Subject: [PATCH v4 18/25] nvdimm/ocxl: Add an IOCTL to report controller statistics
Date: Fri, 27 Mar 2020 18:11:55 +1100
Message-Id: <20200327071202.2159885-19-alastair@d-silva.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327071202.2159885-1-alastair@d-silva.org>
References: <20200327071202.2159885-1-alastair@d-silva.org>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Fri, 27 Mar 2020 18:12:19 +1100 (AEDT)
Message-ID-Hash: CZSE6DLAUTVKKG2RGDVDNCQPD5QX6RRQ
X-Message-ID-Hash: CZSE6DLAUTVKKG2RGDVDNCQPD5QX6RRQ
X-MailFrom: alastair@d-silva.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.r
 u>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CZSE6DLAUTVKKG2RGDVDNCQPD5QX6RRQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The controller can report a number of statistics that are useful
in evaluating the performance and reliability of the card.

This patch exposes this information via an IOCTL.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/nvdimm/ocxl/main.c     | 220 +++++++++++++++++++++++++++++++++
 include/uapi/nvdimm/ocxlpmem.h |  21 ++++
 2 files changed, 241 insertions(+)

diff --git a/drivers/nvdimm/ocxl/main.c b/drivers/nvdimm/ocxl/main.c
index d0db358ded43..0040fc09cceb 100644
--- a/drivers/nvdimm/ocxl/main.c
+++ b/drivers/nvdimm/ocxl/main.c
@@ -713,6 +713,221 @@ static int ioctl_controller_dump_complete(struct ocxlpmem *ocxlpmem)
 				    GLOBAL_MMIO_HCI_CONTROLLER_DUMP_COLLECTED);
 }
 
+/**
+ * controller_stats_header_parse() - Parse the first 64 bits of the controller stats admin command response
+ * @ocxlpmem: the device metadata
+ * @length: out, returns the number of bytes in the response (excluding the 64 bit header)
+ */
+static int controller_stats_header_parse(struct ocxlpmem *ocxlpmem,
+					 u32 *length)
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
+	data_length = val & 0xFFFFFFFF;
+
+	if (data_identifier != 0x4353) { // 'CS'
+		dev_err(&ocxlpmem->dev,
+			"Bad data identifier for error log data, expected 'CS', got '%2s' (%#x), data_length=%u\n",
+			(char *)&data_identifier,
+			(unsigned int)data_identifier, data_length);
+		return -EINVAL;
+	}
+
+	*length = data_length;
+	return 0;
+}
+
+static int ioctl_controller_stats(struct ocxlpmem *ocxlpmem,
+				  struct ioctl_ocxlpmem_controller_stats __user *uarg)
+{
+	struct ioctl_ocxlpmem_controller_stats args;
+	u32 length;
+	int rc;
+	u64 val;
+
+	memset(&args, '\0', sizeof(args));
+
+	mutex_lock(&ocxlpmem->admin_command.lock);
+
+	rc = ocxl_global_mmio_write64(ocxlpmem->ocxl_afu,
+				      ocxlpmem->admin_command.request_offset + 0x08,
+				      OCXL_LITTLE_ENDIAN, 0);
+	if (rc)
+		goto out;
+
+	rc = admin_command_execute(ocxlpmem, ADMIN_COMMAND_CONTROLLER_STATS);
+	if (rc < 0)
+		goto out;
+	if (rc != STATUS_SUCCESS) {
+		warn_status(ocxlpmem,
+			    "Unexpected status from controller stats", rc);
+		goto out;
+	}
+
+	rc = controller_stats_header_parse(ocxlpmem, &length);
+	if (rc)
+		goto out;
+
+	if (length != 0x140) // Documented length of controller stats response
+		warn_status(ocxlpmem,
+			    "Unexpected length for controller stats data, expected 0x140, got 0x%x",
+			    length);
+
+#define SPID1_OFFSET		(ocxlpmem->admin_command.data_offset + 0x08)
+#define SPID2_OFFSET		(ocxlpmem->admin_command.data_offset + 0x48)
+#define RESET_INFO		(SPID1_OFFSET + 0x08)
+#define UPTIME_LIFE		(SPID1_OFFSET + 0x10)
+#define CRITICAL_UTIL		(SPID2_OFFSET + 0x08)
+#define HOST_LOAD_COUNT		(SPID2_OFFSET + 0x10)
+#define HOST_STORE_COUNT	(SPID2_OFFSET + 0x18)
+#define HOST_LOAD_DURATION	(SPID2_OFFSET + 0x20)
+#define HOST_STORE_DURATION	(SPID2_OFFSET + 0x28)
+#define MEDIA_READ_COUNT	(SPID2_OFFSET + 0x50)
+#define MEDIA_WRITE_COUNT	(SPID2_OFFSET + 0x58)
+#define MEDIA_READ_DURATION	(SPID2_OFFSET + 0x60)
+#define MEDIA_WRITE_DURATION	(SPID2_OFFSET + 0x68)
+#define CACHE_READ_HIT_COUNT	(SPID2_OFFSET + 0x90)
+#define CACHE_WRITE_HIT_COUNT	(SPID2_OFFSET + 0x98)
+#define FAST_WRITE_COUNT	(SPID2_OFFSET + 0xA0)
+
+	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu, SPID1_OFFSET,
+				     OCXL_LITTLE_ENDIAN, &val);
+	if (rc)
+		goto out;
+	if ((val >> 56) != 0x01) { // Check the parameter ID
+		rc = -ENODEV;
+		goto out;
+	}
+	if ((val & 0xFFFFFFFF) != 0x38) { // Check the length
+		rc = -ENODEV;
+		goto out;
+	}
+
+	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu, RESET_INFO,
+				     OCXL_LITTLE_ENDIAN, &val);
+	if (rc)
+		goto out;
+
+	args.reset_count = val >> 32;
+	args.reset_uptime = val & 0xFFFFFFFF;
+
+	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu, UPTIME_LIFE,
+				     OCXL_LITTLE_ENDIAN, &val);
+	if (rc)
+		goto out;
+
+	args.power_on_uptime = val >> 32;
+	args.life_remaining = val & 0xFF;
+
+	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu, SPID2_OFFSET,
+				     OCXL_LITTLE_ENDIAN, &val);
+	if (rc)
+		goto out;
+	if ((val >> 56) != 0x02) { // Check the parameter ID
+		rc = -ENODEV;
+		goto out;
+	}
+	if ((val & 0xFFFFFFFF) != 0xF8) { // Check the length
+		rc = -ENODEV;
+		goto out;
+	}
+
+	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu, CRITICAL_UTIL,
+				     OCXL_LITTLE_ENDIAN, &val);
+	if (rc)
+		goto out;
+
+	args.critical_resource_utilization = val & 0xff;
+
+	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu, HOST_LOAD_COUNT,
+				     OCXL_LITTLE_ENDIAN,
+				     &args.host_load_count);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu, HOST_STORE_COUNT,
+				     OCXL_LITTLE_ENDIAN,
+				     &args.host_store_count);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu, HOST_LOAD_DURATION,
+				     OCXL_LITTLE_ENDIAN,
+				     &args.host_load_duration);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu, HOST_STORE_DURATION,
+				     OCXL_LITTLE_ENDIAN,
+				     &args.host_store_duration);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu, MEDIA_READ_COUNT,
+				     OCXL_LITTLE_ENDIAN,
+				     &args.media_read_count);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu, MEDIA_WRITE_COUNT,
+				     OCXL_LITTLE_ENDIAN,
+				     &args.media_write_count);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu, MEDIA_READ_DURATION,
+				     OCXL_LITTLE_ENDIAN,
+				     &args.media_read_duration);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu, MEDIA_WRITE_DURATION,
+				     OCXL_LITTLE_ENDIAN,
+				     &args.media_write_duration);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu, CACHE_READ_HIT_COUNT,
+				     OCXL_LITTLE_ENDIAN,
+				     &args.cache_read_hit_count);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu, CACHE_WRITE_HIT_COUNT,
+				     OCXL_LITTLE_ENDIAN,
+				     &args.cache_write_hit_count);
+	if (rc)
+		goto out;
+
+	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu, FAST_WRITE_COUNT,
+				     OCXL_LITTLE_ENDIAN,
+				     &args.fast_write_count);
+	if (rc)
+		goto out;
+
+	if (copy_to_user(uarg, &args, sizeof(args))) {
+		rc = -EFAULT;
+		goto out;
+	}
+
+	rc = admin_response_handled(ocxlpmem);
+
+out:
+	mutex_unlock(&ocxlpmem->admin_command.lock);
+	return rc;
+}
+
 static long file_ioctl(struct file *file, unsigned int cmd, unsigned long args)
 {
 	struct ocxlpmem *ocxlpmem = file->private_data;
@@ -736,6 +951,11 @@ static long file_ioctl(struct file *file, unsigned int cmd, unsigned long args)
 	case IOCTL_OCXLPMEM_CONTROLLER_DUMP_COMPLETE:
 		rc = ioctl_controller_dump_complete(ocxlpmem);
 		break;
+
+	case IOCTL_OCXLPMEM_CONTROLLER_STATS:
+		rc = ioctl_controller_stats(ocxlpmem,
+					    (struct ioctl_ocxlpmem_controller_stats __user *)args);
+		break;
 	}
 
 	return rc;
diff --git a/include/uapi/nvdimm/ocxlpmem.h b/include/uapi/nvdimm/ocxlpmem.h
index 05e2b3f7b27c..ca3a7098fa9d 100644
--- a/include/uapi/nvdimm/ocxlpmem.h
+++ b/include/uapi/nvdimm/ocxlpmem.h
@@ -51,6 +51,26 @@ struct ioctl_ocxlpmem_controller_dump_data {
 	__u64 reserved[8];
 };
 
+struct ioctl_ocxlpmem_controller_stats {
+	__u32 reset_count;
+	__u32 reset_uptime; /* seconds */
+	__u32 power_on_uptime; /* seconds */
+	__u8 life_remaining; /* percentage, 0-100 */
+	__u8 critical_resource_utilization; /* percentage, 0-100 */
+	__u8 reserved[2];
+	__u64 host_load_count;
+	__u64 host_store_count;
+	__u64 host_load_duration; /* nanoseconds, total */
+	__u64 host_store_duration; /* nanoseconds, total */
+	__u64 media_read_count;
+	__u64 media_write_count;
+	__u64 media_read_duration; /* nanoseconds, total */
+	__u64 media_write_duration; /* nanoseconds, total */
+	__u64 cache_read_hit_count;
+	__u64 cache_write_hit_count;
+	__u64 fast_write_count;
+};
+
 /* ioctl numbers */
 #define OCXLPMEM_MAGIC 0xCA
 /* OpenCAPI Persistent memory devices */
@@ -58,5 +78,6 @@ struct ioctl_ocxlpmem_controller_dump_data {
 #define IOCTL_OCXLPMEM_CONTROLLER_DUMP			_IO(OCXLPMEM_MAGIC, 0x31)
 #define IOCTL_OCXLPMEM_CONTROLLER_DUMP_DATA		_IOWR(OCXLPMEM_MAGIC, 0x32, struct ioctl_ocxlpmem_controller_dump_data)
 #define IOCTL_OCXLPMEM_CONTROLLER_DUMP_COMPLETE		_IO(OCXLPMEM_MAGIC, 0x33)
+#define IOCTL_OCXLPMEM_CONTROLLER_STATS			_IO(OCXLPMEM_MAGIC, 0x34)
 
 #endif /* _UAPI_OCXL_SCM_H */
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

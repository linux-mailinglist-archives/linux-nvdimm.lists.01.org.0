Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 524C419741C
	for <lists+linux-nvdimm@lfdr.de>; Mon, 30 Mar 2020 07:53:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D757610FC3797;
	Sun, 29 Mar 2020 22:54:11 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=66.55.73.32; helo=ushosting.nmnhosting.com; envelope-from=alastair@d-silva.org; receiver=<UNKNOWN> 
Received: from ushosting.nmnhosting.com (ushosting.nmnhosting.com [66.55.73.32])
	by ml01.01.org (Postfix) with ESMTP id 4F41510FC3795
	for <linux-nvdimm@lists.01.org>; Sun, 29 Mar 2020 22:54:09 -0700 (PDT)
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
	by ushosting.nmnhosting.com (Postfix) with ESMTPS id 23A0E2DC6861;
	Mon, 30 Mar 2020 16:52:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
	s=201810a; t=1585547576;
	bh=8s7da4KbOpaV4mqdxyxNi6aCXQRjcGL9fg5XH8aq39A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NrRTkA2bxZwFMeoCf0Wr6Odf6o65lo0QM+ThRM66hf/7Tb+pvtJVuQxJN394NTysC
	 VgilHFKK5xR1f6lDBP0QlOXi2EJtvYeXpa6JFreVlZ03HY/0O6eVn0cvRH8pvqRpyo
	 cdzWDRkWYXg1MPX4tN1fXYDXGdiYygmqECTUp+0YnDPD6LfGx+xx+gategBGRubdAL
	 L0JRYtfskZ/D5Zw0QaK/Tz53JgYEGDdF037VYvOeTQp7vuawto13Te3Rm7pe7J0n3j
	 H6iwZUTYry2yNKsgzOEM59Q5V7lk5UymbYbT6X5deJlY236MnLO6jpfeBIjPT8WeYG
	 zbyXaR3DorudKtfRcOMCYngpMoCzEzYlFjON6mwdALYIvaxuWIpUi0eUv4wErujoca
	 ev2YxG6LJtlTTbFLoAYDap+my1DyfAet2uXwgjOsEAogxT/DBD0646Y0yGqEn2L3J6
	 hinFHFG49vIm36L/NCftTmxqx7+9UfvO5s+VkIilw2q9UHK+gBNkJiRQVDG1yFm5Rn
	 co+eZdxegSRaD39VqYwEY+iKgvu/Jb1w0cb0ho+kiB03px14BmTNlQk4Tof0LqmFNk
	 7tVG7Vgv/QEAcjH8bPZwH8sZw7WayGyD+FfKrWAwVv7XeAsc2mBHBKPSE++URXQ1Nz
	 MdXl8DGDe8LMBnwkv+CQ57LQ=
Received: from localhost.lan ([10.0.1.179])
	by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTP id 02R7C4Aw045934;
	Fri, 27 Mar 2020 18:12:20 +1100 (AEDT)
	(envelope-from alastair@d-silva.org)
From: "Alastair D'Silva" <alastair@d-silva.org>
To: alastair@d-silva.org
Subject: [PATCH v4 23/25] nvdimm/ocxl: Expose SMART data via ndctl
Date: Fri, 27 Mar 2020 18:12:00 +1100
Message-Id: <20200327071202.2159885-24-alastair@d-silva.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327071202.2159885-1-alastair@d-silva.org>
References: <20200327071202.2159885-1-alastair@d-silva.org>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Fri, 27 Mar 2020 18:12:20 +1100 (AEDT)
Message-ID-Hash: J5ASZDBHX72SLXCVWSZJ3Y5LCNSWWBVD
X-Message-ID-Hash: J5ASZDBHX72SLXCVWSZJ3Y5LCNSWWBVD
X-MailFrom: alastair@d-silva.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.r
 u>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/J5ASZDBHX72SLXCVWSZJ3Y5LCNSWWBVD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch retrieves proprietary formatted SMART data and makes it
available via ndctl. A later contribution will be made to ndctl to
parse this data.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/nvdimm/ocxl/main.c     | 113 +++++++++++++++++++++++++++++++++
 drivers/nvdimm/ocxl/ocxlpmem.h |  18 ++++++
 include/uapi/linux/ndctl.h     |   1 +
 3 files changed, 132 insertions(+)

diff --git a/drivers/nvdimm/ocxl/main.c b/drivers/nvdimm/ocxl/main.c
index 2811bf7efbab..92b4389e8cbb 100644
--- a/drivers/nvdimm/ocxl/main.c
+++ b/drivers/nvdimm/ocxl/main.c
@@ -82,6 +82,114 @@ static int ndctl_config_size(struct nd_cmd_get_config_size *command)
 	return 0;
 }
 
+/**
+ * smart_header_parse() - Parse the first 64 bits of the SMART admin command response
+ * @ocxlpmem: the device metadata
+ * @length: out, returns the number of bytes in the response (excluding the 64 bit header)
+ */
+static int smart_header_parse(struct ocxlpmem *ocxlpmem, u32 *length)
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
+	if (data_identifier != 0x534D) { // 'SM'
+		dev_err(&ocxlpmem->dev,
+			"Bad data identifier for smart data, expected 'SM', got '%2s'\n",
+			(char *)&data_identifier);
+		return -EINVAL;
+	}
+
+	*length = data_length;
+	return 0;
+}
+
+static int ndctl_smart(struct ocxlpmem *ocxlpmem, struct nd_cmd_pkg *pkg)
+{
+	u32 length, i;
+	struct nd_ocxl_smart *out;
+	int rc;
+
+	mutex_lock(&ocxlpmem->admin_command.lock);
+
+	rc = admin_command_execute(ocxlpmem, ADMIN_COMMAND_SMART);
+	if (rc < 0)
+		goto out;
+	if (rc != STATUS_SUCCESS) {
+		warn_status(ocxlpmem, "Unexpected status from SMART", rc);
+		goto out;
+	}
+
+	rc = smart_header_parse(ocxlpmem, &length);
+	if (rc)
+		goto out;
+
+	pkg->nd_fw_size = length + offsetof(struct nd_ocxl_smart, attribs);
+
+	length = min(length, (u32)(pkg->nd_size_out -
+		     offsetof(struct nd_ocxl_smart, attribs))); // bytes
+	out = (struct nd_ocxl_smart *)pkg->nd_payload;
+	// Each SMART attribute is 2 * 64 bits
+	out->count = length / (2 * sizeof(u64)); // attributes
+
+	for (i = 0; i < length; i += sizeof(u64)) {
+		rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
+					     ocxlpmem->admin_command.data_offset +
+					     sizeof(u64) + i,
+					     OCXL_LITTLE_ENDIAN,
+					     &out->attribs[i / sizeof(u64)]);
+		if (rc)
+			goto out;
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
+static int ndctl_call(struct ocxlpmem *ocxlpmem, void *buf,
+		      unsigned int buf_len)
+{
+	struct nd_cmd_pkg *pkg = buf;
+
+	if (buf_len < sizeof(struct nd_cmd_pkg)) {
+		dev_err(&ocxlpmem->dev, "Invalid ND_CALL size=%u\n", buf_len);
+		return -EINVAL;
+	}
+
+	if (pkg->nd_family != NVDIMM_FAMILY_OCXL) {
+		dev_err(&ocxlpmem->dev, "Invalid ND_CALL family=0x%llx\n",
+			pkg->nd_family);
+		return -EINVAL;
+	}
+
+	switch (pkg->nd_command) {
+	case ND_CMD_OCXL_SMART:
+		return ndctl_smart(ocxlpmem, pkg);
+	default:
+		dev_err(&ocxlpmem->dev, "Invalid ND_CALL command=0x%llx\n",
+			pkg->nd_command);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int ndctl(struct nvdimm_bus_descriptor *nd_desc,
 		 struct nvdimm *nvdimm,
 		 unsigned int cmd, void *buf, unsigned int buf_len, int *cmd_rc)
@@ -90,6 +198,10 @@ static int ndctl(struct nvdimm_bus_descriptor *nd_desc,
 						 struct ocxlpmem, bus_desc);
 
 	switch (cmd) {
+	case ND_CMD_CALL:
+		*cmd_rc = ndctl_call(ocxlpmem, buf, buf_len);
+		return 0;
+
 	case ND_CMD_GET_CONFIG_SIZE:
 		*cmd_rc = ndctl_config_size(buf);
 		return 0;
@@ -173,6 +285,7 @@ static int register_lpc_mem(struct ocxlpmem *ocxlpmem)
 	set_bit(ND_CMD_GET_CONFIG_SIZE, &nvdimm_cmd_mask);
 	set_bit(ND_CMD_GET_CONFIG_DATA, &nvdimm_cmd_mask);
 	set_bit(ND_CMD_SET_CONFIG_DATA, &nvdimm_cmd_mask);
+	set_bit(ND_CMD_CALL, &nvdimm_cmd_mask);
 
 	set_bit(NDD_ALIASING, &nvdimm_flags);
 
diff --git a/drivers/nvdimm/ocxl/ocxlpmem.h b/drivers/nvdimm/ocxl/ocxlpmem.h
index c8794e7775ec..ebaf11692c09 100644
--- a/drivers/nvdimm/ocxl/ocxlpmem.h
+++ b/drivers/nvdimm/ocxl/ocxlpmem.h
@@ -6,6 +6,7 @@
 #include <misc/ocxl.h>
 #include <linux/libnvdimm.h>
 #include <linux/mm.h>
+#include <linux/ndctl.h>
 
 #define LABEL_AREA_SIZE	BIT_ULL(PA_SECTION_SHIFT)
 #define DEFAULT_TIMEOUT 100
@@ -101,6 +102,23 @@ struct command_metadata {
 	u8 op_code;
 };
 
+struct nd_ocxl_smart {
+	__u8 count;
+	__u8 reserved[7];
+	__u64 attribs[0];
+} __packed;
+
+struct nd_pkg_ocxl {
+	struct nd_cmd_pkg gen;
+	union {
+		struct nd_ocxl_smart smart;
+	};
+};
+
+enum nd_cmd_ocxl {
+	ND_CMD_OCXL_SMART = 1,
+};
+
 struct ocxlpmem {
 	struct device dev;
 	struct pci_dev *pdev;
diff --git a/include/uapi/linux/ndctl.h b/include/uapi/linux/ndctl.h
index de5d90212409..2885052e7f40 100644
--- a/include/uapi/linux/ndctl.h
+++ b/include/uapi/linux/ndctl.h
@@ -244,6 +244,7 @@ struct nd_cmd_pkg {
 #define NVDIMM_FAMILY_HPE2 2
 #define NVDIMM_FAMILY_MSFT 3
 #define NVDIMM_FAMILY_HYPERV 4
+#define NVDIMM_FAMILY_OCXL 6
 
 #define ND_IOCTL_CALL			_IOWR(ND_IOCTL, ND_CMD_CALL,\
 					struct nd_cmd_pkg)
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3017021643F
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jul 2020 04:57:52 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E89CD1108E903;
	Mon,  6 Jul 2020 19:57:50 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EE1631108DEA6
	for <linux-nvdimm@lists.01.org>; Mon,  6 Jul 2020 19:57:48 -0700 (PDT)
IronPort-SDR: scg6Q0H8fkdFT9J30/l9rUe8wXibA0BGUXGA15VDKHHoE8q229/u276B155IEjPfkOr/ANH6/8
 gS6ECCLzYdRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="127124263"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800";
   d="scan'208";a="127124263"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:57:48 -0700
IronPort-SDR: oUDXhrteFfPVnlhVuYFZortyIVJatw4AQnSORfq6b07uz0N6UukNv2FdE8L9hX9jAKIsboEAQV
 4ryDWc9nBJCg==
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800";
   d="scan'208";a="305503413"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:57:48 -0700
Subject: [ndctl PATCH 14/16] ndctl: Refactor nfit.h to acpi.h
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: vishal.l.verma@intel.com
Date: Mon, 06 Jul 2020 19:41:32 -0700
Message-ID: <159408969293.2386154.5394525810090499368.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159408961822.2386154.888266173771881937.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159408961822.2386154.888266173771881937.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: XTSQIVKY7CZKXKYNI4KSDKD6TGGGCPRS
X-Message-ID-Hash: XTSQIVKY7CZKXKYNI4KSDKD6TGGGCPRS
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XTSQIVKY7CZKXKYNI4KSDKD6TGGGCPRS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In preparation for adding other acpi table creation helper utilities
make a common acpi.h header with common helpers and definitions.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 acpi.h              |  110 +++++++++++++++++++++++++++++++++++++++++++++++++++
 ndctl/create-nfit.c |   66 ++++++-------------------------
 nfit.h              |   65 ------------------------------
 3 files changed, 124 insertions(+), 117 deletions(-)
 create mode 100644 acpi.h
 delete mode 100644 nfit.h

diff --git a/acpi.h b/acpi.h
new file mode 100644
index 000000000000..06685aa2c90a
--- /dev/null
+++ b/acpi.h
@@ -0,0 +1,110 @@
+/*
+ * ACPI Table Definitions
+ *
+ * Copyright(c) 2013-2017 Intel Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+#ifndef __ACPI_H__
+#define __ACPI_H__
+#include <stdint.h>
+#include <linux/uuid.h>
+
+static inline void nfit_spa_uuid_pm(void *uuid)
+{
+	uuid_le uuid_pm = UUID_LE(0x66f0d379, 0xb4f3, 0x4074, 0xac, 0x43, 0x0d,
+			0x33, 0x18, 0xb7, 0x8c, 0xdb);
+	memcpy(uuid, &uuid_pm, 16);
+}
+
+enum {
+	NFIT_TABLE_SPA = 0,
+	SRAT_TABLE_MEM = 1,
+	SRAT_MEM_ENABLED = (1<<0),
+	SRAT_MEM_HOT_PLUGGABLE = (1<<1),
+	SRAT_MEM_NON_VOLATILE = (1<<2),
+};
+
+/**
+ * struct nfit - Nvdimm Firmware Interface Table
+ * @signature: "ACPI"
+ * @length: sum of size of this table plus all appended subtables
+ */
+struct acpi_header {
+	uint8_t signature[4];
+	uint32_t length;
+	uint8_t revision;
+	uint8_t checksum;
+	uint8_t oemid[6];
+	uint64_t oem_tbl_id;
+	uint32_t oem_revision;
+	uint32_t asl_id;
+	uint32_t asl_revision;
+} __attribute__((packed));
+
+struct nfit {
+	struct acpi_header h;
+	uint32_t reserved;
+} __attribute__((packed));
+
+/**
+ * struct nfit_spa - System Physical Address Range Descriptor Table
+ */
+struct nfit_spa {
+	uint16_t type;
+	uint16_t length;
+	uint16_t range_index;
+	uint16_t flags;
+	uint32_t reserved;
+	uint32_t proximity_domain;
+	uint8_t type_uuid[16];
+	uint64_t spa_base;
+	uint64_t spa_length;
+	uint64_t mem_attr;
+} __attribute__((packed));
+
+static inline unsigned char acpi_checksum(void *buf, size_t size)
+{
+        unsigned char sum, *data = buf;
+        size_t i;
+
+        for (sum = 0, i = 0; i < size; i++)
+                sum += data[i];
+        return 0 - sum;
+}
+
+static inline void writeq(uint64_t v, void *a)
+{
+	uint64_t *p = a;
+
+	*p = htole64(v);
+}
+
+static inline void writel(uint32_t v, void *a)
+{
+	uint32_t *p = a;
+
+	*p = htole32(v);
+}
+
+static inline void writew(unsigned short v, void *a)
+{
+	unsigned short *p = a;
+
+	*p = htole16(v);
+}
+
+static inline void writeb(unsigned char v, void *a)
+{
+	unsigned char *p = a;
+
+	*p = v;
+}
+#endif /* __ACPI_H__ */
diff --git a/ndctl/create-nfit.c b/ndctl/create-nfit.c
index 53319182d8a4..8f05eab81494 100644
--- a/ndctl/create-nfit.c
+++ b/ndctl/create-nfit.c
@@ -22,7 +22,7 @@
 #include <util/parse-options.h>
 #include <util/size.h>
 
-#include <nfit.h>
+#include <acpi.h>
 
 #define DEFAULT_NFIT "local_nfit.bin"
 static const char *nfit_file = DEFAULT_NFIT;
@@ -68,44 +68,6 @@ static int parse_add_spa(const struct option *option, const char *__arg, int uns
 	return rc;
 }
 
-static unsigned char nfit_checksum(void *buf, size_t size)
-{
-        unsigned char sum, *data = buf;
-        size_t i;
-
-        for (sum = 0, i = 0; i < size; i++)
-                sum += data[i];
-        return 0 - sum;
-}
-
-static void writeq(unsigned long long v, void *a)
-{
-	unsigned long long *p = a;
-
-	*p = htole64(v);
-}
-
-static void writel(unsigned long v, void *a)
-{
-	unsigned long *p = a;
-
-	*p = htole32(v);
-}
-
-static void writew(unsigned short v, void *a)
-{
-	unsigned short *p = a;
-
-	*p = htole16(v);
-}
-
-static void writeb(unsigned char v, void *a)
-{
-	unsigned char *p = a;
-
-	*p = v;
-}
-
 static struct nfit *create_nfit(struct list_head *spa_list)
 {
 	struct nfit_spa *nfit_spa;
@@ -124,15 +86,15 @@ static struct nfit *create_nfit(struct list_head *spa_list)
 		return NULL;
 
 	/* nfit header */
-	nfit = (struct nfit *) buf;
-	memcpy(nfit->signature, "NFIT", 4);
-	writel(size, &nfit->length);
-	writeb(1, &nfit->revision);
-	memcpy(nfit->oemid, "LOCAL", 6);
-	writew(1, &nfit->oem_tbl_id);
-	writel(1, &nfit->oem_revision);
-	writel(0x80860000, &nfit->creator_id);
-	writel(1, &nfit->creator_revision);
+	nfit = (typeof(nfit)) buf;
+	memcpy(nfit->h.signature, "NFIT", 4);
+	writel(size, &nfit->h.length);
+	writeb(1, &nfit->h.revision);
+	memcpy(nfit->h.oemid, "LOCAL", 6);
+	writew(1, &nfit->h.oem_tbl_id);
+	writel(1, &nfit->h.oem_revision);
+	writel(0x80860000, &nfit->h.asl_id);
+	writel(1, &nfit->h.asl_revision);
 
 	nfit_spa = (struct nfit_spa *) (buf + sizeof(*nfit));
 	i = 1;
@@ -146,7 +108,7 @@ static struct nfit *create_nfit(struct list_head *spa_list)
 		nfit_spa++;
 	}
 
-	writeb(nfit_checksum(buf, size), &nfit->checksum);
+	writeb(acpi_checksum(buf, size), &nfit->h.checksum);
 
 	return nfit;
 }
@@ -170,7 +132,7 @@ static int write_nfit(struct nfit *nfit, const char *file, int force)
 		return -errno;
 	}
 
-	rc = write(fd, nfit, le32toh(nfit->length));
+	rc = write(fd, nfit, le32toh(nfit->h.length));
 	close(fd);
 	return rc;
 }
@@ -210,9 +172,9 @@ int cmd_create_nfit(int argc, const char **argv, struct ndctl_ctx *ctx)
 		goto out;
 
 	rc = write_nfit(nfit, nfit_file, force);
-	if ((unsigned int) rc == le32toh(nfit->length)) {
+	if ((unsigned int) rc == le32toh(nfit->h.length)) {
 		fprintf(stderr, "wrote %d bytes to %s\n",
-				le32toh(nfit->length), nfit_file);
+				le32toh(nfit->h.length), nfit_file);
 		rc = 0;
 	}
 
diff --git a/nfit.h b/nfit.h
deleted file mode 100644
index 9815d2143a9e..000000000000
--- a/nfit.h
+++ /dev/null
@@ -1,65 +0,0 @@
-/*
- * NVDIMM Firmware Interface Table - NFIT
- *
- * Copyright(c) 2013-2016 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
-#ifndef __NFIT_H__
-#define __NFIT_H__
-#include <stdint.h>
-#include <linux/uuid.h>
-
-static inline void nfit_spa_uuid_pm(void *uuid)
-{
-	uuid_le uuid_pm = UUID_LE(0x66f0d379, 0xb4f3, 0x4074, 0xac, 0x43, 0x0d,
-			0x33, 0x18, 0xb7, 0x8c, 0xdb);
-	memcpy(uuid, &uuid_pm, 16);
-}
-
-enum {
-	NFIT_TABLE_SPA = 0,
-};
-
-/**
- * struct nfit - Nvdimm Firmware Interface Table
- * @signature: "NFIT"
- * @length: sum of size of this table plus all appended subtables
- */
-struct nfit {
-	uint8_t signature[4];
-	uint32_t length;
-	uint8_t revision;
-	uint8_t checksum;
-	uint8_t oemid[6];
-	uint64_t oem_tbl_id;
-	uint32_t oem_revision;
-	uint32_t creator_id;
-	uint32_t creator_revision;
-	uint32_t reserved;
-} __attribute__((packed));
-
-/**
- * struct nfit_spa - System Physical Address Range Descriptor Table
- */
-struct nfit_spa {
-	uint16_t type;
-	uint16_t length;
-	uint16_t range_index;
-	uint16_t flags;
-	uint32_t reserved;
-	uint32_t proximity_domain;
-	uint8_t type_uuid[16];
-	uint64_t spa_base;
-	uint64_t spa_length;
-	uint64_t mem_attr;
-} __attribute__((packed));
-
-#endif /* __NFIT_H__ */
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

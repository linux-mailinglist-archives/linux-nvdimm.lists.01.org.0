Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A220216440
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jul 2020 04:57:58 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 104E11108DED3;
	Mon,  6 Jul 2020 19:57:57 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1DD211108E908
	for <linux-nvdimm@lists.01.org>; Mon,  6 Jul 2020 19:57:54 -0700 (PDT)
IronPort-SDR: 5lDvzUsnqZEcieqt8BNSfyYqSzaKG8jO1vwSlPsVReoPCzmziiyzE3/W3W46+MMJ4YwpkNftGO
 N/FzCYEjzKYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="149041634"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800";
   d="scan'208";a="149041634"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:57:53 -0700
IronPort-SDR: pvLt1ODivURvR7nuOsjgu5VYDsSyQBwIwz0fkxoPOWIQF62wu1g5iagZ8ZN006KsLvLBkWd7TH
 UcDWArTy9aOw==
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800";
   d="scan'208";a="283240417"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:57:53 -0700
Subject: [ndctl PATCH 15/16] daxctl: Add 'split-acpi' command to generate
 custom ACPI tables
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: vishal.l.verma@intel.com
Date: Mon, 06 Jul 2020 19:41:38 -0700
Message-ID: <159408969833.2386154.11644733036864637055.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159408961822.2386154.888266173771881937.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159408961822.2386154.888266173771881937.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: GK6M2AOROFXB65I7HOLOFBSFXBWPTUKJ
X-Message-ID-Hash: GK6M2AOROFXB65I7HOLOFBSFXBWPTUKJ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GK6M2AOROFXB65I7HOLOFBSFXBWPTUKJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

While the numa_emulation (fake-numa) driver allows *all* physical nodes to
be split by a given ratio / size, sometimes what is desired is to split a
single memory range into multiple nodes. Also, numa_emulation can only do
this for injecting a fake SRAT, but splitting a NUMA node may also involve
splitting the NFIT. ACPI table injection is more flexible and capable than
what can be described on the kernel command line to the numa_emulation
driver.

Add support to the daxctl utility for splitting SRAT, SLIT, and NFIT by
proximity domain. Yes, this might be a better fit in acpica-tools, but out
of laziness and familiarity I picked daxctl.

Also, for simplicity, this only supports dividing a node by a power-of-2
factor. Conceivably this could later be extended for custom splits, but for
now this covers the most likely common case of "split in half".

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 acpi.h             |  132 ++++++++
 daxctl/Makefile.am |    1 
 daxctl/acpi.c      |  870 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 daxctl/builtin.h   |    1 
 daxctl/daxctl.c    |    1 
 5 files changed, 1002 insertions(+), 3 deletions(-)
 create mode 100644 daxctl/acpi.c

diff --git a/acpi.h b/acpi.h
index 06685aa2c90a..e714e28e2354 100644
--- a/acpi.h
+++ b/acpi.h
@@ -17,11 +17,12 @@
 #include <stdint.h>
 #include <linux/uuid.h>
 
+static const uuid_le uuid_pmem = UUID_LE(0x66f0d379, 0xb4f3, 0x4074, 0xac, 0x43, 0x0d,
+			0x33, 0x18, 0xb7, 0x8c, 0xdb);
+
 static inline void nfit_spa_uuid_pm(void *uuid)
 {
-	uuid_le uuid_pm = UUID_LE(0x66f0d379, 0xb4f3, 0x4074, 0xac, 0x43, 0x0d,
-			0x33, 0x18, 0xb7, 0x8c, 0xdb);
-	memcpy(uuid, &uuid_pm, 16);
+	memcpy(uuid, &uuid_pmem, 16);
 }
 
 enum {
@@ -54,6 +55,18 @@ struct nfit {
 	uint32_t reserved;
 } __attribute__((packed));
 
+enum acpi_nfit_type {
+	ACPI_NFIT_TYPE_SYSTEM_ADDRESS = 0,
+	ACPI_NFIT_TYPE_MEMORY_MAP = 1,
+	ACPI_NFIT_TYPE_INTERLEAVE = 2,
+	ACPI_NFIT_TYPE_SMBIOS = 3,
+	ACPI_NFIT_TYPE_CONTROL_REGION = 4,
+	ACPI_NFIT_TYPE_DATA_REGION = 5,
+	ACPI_NFIT_TYPE_FLUSH_ADDRESS = 6,
+	ACPI_NFIT_TYPE_CAPABILITIES = 7,
+	ACPI_NFIT_TYPE_RESERVED = 8     /* 8 and greater are reserved */
+};
+
 /**
  * struct nfit_spa - System Physical Address Range Descriptor Table
  */
@@ -70,6 +83,91 @@ struct nfit_spa {
 	uint64_t mem_attr;
 } __attribute__((packed));
 
+struct nfit_map {
+	uint16_t type;
+	uint16_t length;
+	uint32_t device_handle;
+	uint16_t physical_id;
+	uint16_t region_id;
+	uint16_t range_index;
+	uint16_t region_index;
+	uint64_t region_size;
+	uint64_t region_offset;
+	uint64_t address;
+	uint16_t interleave_index;
+	uint16_t interleave_ways;
+	uint16_t flags;
+	uint16_t reserved;           /* Reserved, must be zero */
+} __attribute__((packed));
+
+struct srat {
+	struct acpi_header h;
+	uint32_t revision;
+	uint64_t reserved;
+} __attribute__((packed));
+
+enum acpi_srat_type {
+	ACPI_SRAT_TYPE_CPU_AFFINITY = 0,
+	ACPI_SRAT_TYPE_MEMORY_AFFINITY = 1,
+	ACPI_SRAT_TYPE_X2APIC_CPU_AFFINITY = 2,
+	ACPI_SRAT_TYPE_GICC_AFFINITY = 3,
+	ACPI_SRAT_TYPE_GIC_ITS_AFFINITY = 4,    /* ACPI 6.2 */
+	ACPI_SRAT_TYPE_GENERIC_AFFINITY = 5,    /* ACPI 6.3 */
+	ACPI_SRAT_TYPE_RESERVED = 6     /* 5 and greater are reserved */
+};
+
+struct srat_cpu {
+	uint8_t type;
+	uint8_t length;
+	uint8_t proximity_domain_lo;
+	uint8_t apic_id;
+	uint32_t flags;
+	uint8_t local_sapic_eid;
+	uint8_t proximity_domain_hi[3];
+	uint32_t clock_domain;
+} __attribute__((packed));
+
+struct srat_generic {
+	uint8_t type;
+	uint8_t length;
+	uint8_t reserved;
+	uint8_t device_handle_type;
+	uint32_t proximity_domain;
+	uint8_t device_handle[16];
+	uint32_t flags;
+	uint32_t reserved1;
+} __attribute__((packed));
+
+struct srat_mem {
+	uint8_t type;
+	uint8_t length;
+	uint32_t proximity_domain;
+	uint16_t reserved;
+	uint64_t spa_base;
+	uint64_t spa_length;
+	uint32_t reserved1;
+	uint32_t flags;
+	uint64_t reserved2;
+} __attribute__((packed));
+
+struct acpi_subtable8 {
+	uint8_t type;
+	uint8_t length;
+	uint8_t buf[];
+} __attribute__((packed));
+
+struct acpi_subtable16 {
+	uint16_t type;
+	uint16_t length;
+	uint8_t buf[];
+} __attribute__((packed));
+
+struct slit {
+	struct acpi_header h;
+	uint64_t count;
+	uint8_t entry[]; /* size = count^2 */
+} __attribute__((packed));
+
 static inline unsigned char acpi_checksum(void *buf, size_t size)
 {
         unsigned char sum, *data = buf;
@@ -107,4 +205,32 @@ static inline void writeb(unsigned char v, void *a)
 
 	*p = v;
 }
+
+static inline uint64_t readq(void *a)
+{
+	uint64_t *p = a;
+
+	return le64toh(*p);
+}
+
+static inline uint32_t readl(void *a)
+{
+	uint32_t *p = a;
+
+	return le32toh(*p);
+}
+
+static inline uint16_t readw(void *a)
+{
+	uint16_t *p = a;
+
+	return le16toh(*p);
+}
+
+static inline uint8_t readb(void *a)
+{
+	uint8_t *p = a;
+
+	return *p;
+}
 #endif /* __ACPI_H__ */
diff --git a/daxctl/Makefile.am b/daxctl/Makefile.am
index ca1b86748bfb..9b1313ac547f 100644
--- a/daxctl/Makefile.am
+++ b/daxctl/Makefile.am
@@ -13,6 +13,7 @@ config.h: $(srcdir)/Makefile.am
 
 daxctl_SOURCES =\
 		daxctl.c \
+		acpi.c \
 		list.c \
 		migrate.c \
 		device.c \
diff --git a/daxctl/acpi.c b/daxctl/acpi.c
new file mode 100644
index 000000000000..5d0e3df15aa9
--- /dev/null
+++ b/daxctl/acpi.c
@@ -0,0 +1,870 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2017-2020 Intel Corporation. All rights reserved. */
+#include <stdio.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <endian.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <ccan/list/list.h>
+#include <util/bitmap.h>
+#include <ccan/minmax/minmax.h>
+#include <util/parse-options.h>
+#include <util/size.h>
+
+#include <acpi.h>
+
+static bool verbose;
+
+struct srat_container {
+	struct srat *srat;
+	struct list_head ents;
+};
+
+struct srat_ent {
+	struct list_node list;
+	struct acpi_subtable8 *tbl;
+};
+
+struct nfit_container {
+	struct nfit *nfit;
+	struct list_head ents;
+};
+
+struct nfit_ent {
+	struct list_node list;
+	struct acpi_subtable16 *tbl;
+};
+
+static void free_srat_container(struct srat_container *container)
+{
+	struct srat_ent *ent, *_e;
+
+	if (!container)
+		return;
+
+	list_for_each_safe(&container->ents, ent, _e, list) {
+		list_del_from(&container->ents, &ent->list);
+		free(ent);
+	}
+	free(container->srat);
+	free(container);
+}
+
+static void free_nfit_container(struct nfit_container *container)
+{
+	struct nfit_ent *ent, *_e;
+
+	if (!container)
+		return;
+
+	list_for_each_safe(&container->ents, ent, _e, list) {
+		list_del_from(&container->ents, &ent->list);
+		free(ent);
+	}
+	free(container->nfit);
+	free(container);
+}
+
+static void *read_table(int fd, const char *sig)
+{
+	int rc, len;
+	uint8_t checksum;
+	struct acpi_header hdr;
+	struct acpi_header *data = NULL;
+
+	rc = read(fd, &hdr, sizeof(hdr));
+	if (rc < (int) sizeof(hdr)) {
+		error("failed to read header\n");
+		rc = rc < 0 ? -errno : -EINVAL;
+		goto out;
+	}
+
+	if (strncmp((char *) hdr.signature, sig, 4) != 0) {
+		error("invalid %s header\n", sig);
+		rc = -EINVAL;
+		goto out;
+	}
+
+	data = calloc(1, hdr.length);
+	if (!data) {
+		error("failed to alloc %d bytes\n", hdr.length);
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	for (len = hdr.length; len > 0;) {
+		int offset = hdr.length - len;
+
+		rc = pread(fd, ((char *) data) + offset, len, offset);
+		if (rc < 0)
+			break;
+		len -= rc;
+	}
+
+	if (rc < 0) {
+		error("failed to read %s\n", sig);
+		rc = rc < 0 ? -errno : -EINVAL;
+		goto out;
+	}
+
+	checksum = data->checksum;
+	data->checksum = 0;
+	if (acpi_checksum(data, data->length) != checksum) {
+		error("bad %s checksum\n", sig);
+		rc = -EINVAL;
+		goto out;
+	}
+out:
+	close(fd);
+	if (rc < 0) {
+		free(data);
+		data = NULL;
+	}
+	return data;
+}
+
+static struct nfit_container *read_nfit(int fd)
+{
+	void *buf;
+	int rc = 0;
+	unsigned int length;
+	struct nfit *nfit = NULL;
+	struct nfit_container *container = NULL;
+
+	nfit = read_table(fd, "NFIT");
+	if (!nfit)
+		return NULL;
+
+	container = calloc(1, sizeof(*container));
+	if (!container) {
+		error("failed to alloc %d bytes\n", nfit->h.length);
+		rc = -ENOMEM;
+		goto out;
+	}
+	list_head_init(&container->ents);
+	container->nfit = nfit;
+
+	length = nfit->h.length - sizeof(*nfit);
+	if (!length) {
+		error("no sub-tables found in SRAT\n");
+		rc = -EINVAL;
+		goto out;
+	}
+
+	buf = nfit + 1;
+	while (length) {
+		struct nfit_ent *ent = calloc(1, sizeof(*ent));
+
+		if (!ent) {
+			error("failed to alloc %zd bytes\n", sizeof(*ent));
+			rc = -ENOMEM;
+			goto out;
+		}
+		ent->tbl = (struct acpi_subtable16 *) buf;
+		list_add_tail(&container->ents, &ent->list);
+		if (readw(&ent->tbl->length) > length
+				|| !readw(&ent->tbl->length)) {
+			error("failed to validate all SRAT entries\n");
+			rc = -EINVAL;
+			goto out;
+		}
+		length -= readw(&ent->tbl->length);
+		buf += readw(&ent->tbl->length);
+	}
+out:
+	if (rc < 0) {
+		if (container)
+			free_nfit_container(container);
+		else
+			free(nfit);
+		container = NULL;
+	}
+	return container;
+}
+
+static struct srat_container *read_srat(int fd)
+{
+	void *buf;
+	int rc = 0;
+	unsigned int length;
+	struct srat *srat = NULL;
+	struct srat_container *container = NULL;
+
+	srat = read_table(fd, "SRAT");
+	if (!srat)
+		return NULL;
+
+	container = calloc(1, sizeof(*container));
+	if (!container) {
+		error("failed to alloc %d bytes\n", srat->h.length);
+		rc = -ENOMEM;
+		goto out;
+	}
+	list_head_init(&container->ents);
+	container->srat = srat;
+
+	length = srat->h.length - sizeof(*srat);
+	if (!length) {
+		error("no sub-tables found in SRAT\n");
+		rc = -EINVAL;
+		goto out;
+	}
+
+	buf = srat + 1;
+	while (length) {
+		struct srat_ent *ent = calloc(1, sizeof(*ent));
+
+		if (!ent) {
+			error("failed to alloc %zd bytes\n", sizeof(*ent));
+			rc = -ENOMEM;
+			goto out;
+		}
+		ent->tbl = (struct acpi_subtable8 *) buf;
+		list_add_tail(&container->ents, &ent->list);
+		if (readb(&ent->tbl->length) > length
+				|| !readb(&ent->tbl->length)) {
+			error("failed to validate all SRAT entries\n");
+			rc = -EINVAL;
+			goto out;
+		}
+		length -= readb(&ent->tbl->length);
+		buf += readb(&ent->tbl->length);
+	}
+out:
+	if (rc < 0) {
+		if (container)
+			free_srat_container(container);
+		else
+			free(srat);
+		container = NULL;
+	}
+	return container;
+}
+
+enum acpi_table {
+	ACPI_SRAT,
+	ACPI_SLIT,
+	ACPI_NFIT,
+	ACPI_TABLES,
+};
+
+static const char *acpi_table_name(enum acpi_table id)
+{
+	const char *names[ACPI_TABLES] = {
+		[ACPI_SRAT] = "srat",
+		[ACPI_SLIT] = "slit",
+		[ACPI_NFIT] = "nfit",
+	};
+
+	return names[id];
+}
+
+struct parameters {
+	char *table[ACPI_TABLES];
+	char *new_table[ACPI_TABLES];
+	int in_fd[ACPI_TABLES];
+	int out_fd[ACPI_TABLES];
+	int nodes;
+	int pxm;
+	const char *path;
+} param = {
+	.nodes = 2,
+};
+
+struct split_context {
+	uint64_t address;
+	uint64_t length;
+	int max_pxm;
+	int max_region_id;
+	int max_range_index;
+};
+
+static int create_nfit(struct parameters *p, struct nfit_container *container,
+		struct list_head *mems)
+{
+	unsigned int oem_revision;
+	size_t orig_size, size;
+	struct nfit_ent *ent;
+	struct nfit *nfit;
+	void *buf;
+	int rc;
+
+	orig_size = readl(&container->nfit->h.length);
+	size = orig_size;
+	list_for_each(mems, ent, list)
+		size += readw(&ent->tbl->length);
+
+	buf = calloc(1, size);
+	if (!buf)
+		return -ENOMEM;
+
+	nfit = buf;
+	memcpy(nfit, container->nfit, sizeof(*nfit));
+	writel(size, &nfit->h.length);
+	oem_revision = readl(&nfit->h.oem_revision);
+	writel(oem_revision + 1, &nfit->h.oem_revision);
+	buf += sizeof(*nfit);
+
+	list_append_list(&container->ents, mems);
+	list_for_each(&container->ents, ent, list) {
+		memcpy(buf, ent->tbl, readw(&ent->tbl->length));
+		buf += readw(&ent->tbl->length);
+	}
+
+	writeb(acpi_checksum(nfit, size), &nfit->h.checksum);
+
+	rc = write(p->out_fd[ACPI_NFIT], nfit, size);
+	free(nfit);
+
+	if (rc < 0)
+		return -errno;
+	return 0;
+}
+
+static int create_srat(struct parameters *p, struct srat_container *container,
+		struct list_head *mems)
+{
+	unsigned int oem_revision;
+	size_t orig_size, size;
+	struct srat_ent *ent;
+	struct srat *srat;
+	void *buf;
+	int rc;
+
+	orig_size = readl(&container->srat->h.length);
+	size = orig_size;
+	list_for_each(mems, ent, list)
+		size += readb(&ent->tbl->length);
+
+	buf = calloc(1, size);
+	if (!buf)
+		return -ENOMEM;
+
+	srat = buf;
+	memcpy(srat, container->srat, sizeof(*srat));
+	writel(size, &srat->h.length);
+	oem_revision = readl(&srat->h.oem_revision);
+	writel(oem_revision + 1, &srat->h.oem_revision);
+	buf += sizeof(*srat);
+
+	list_append_list(&container->ents, mems);
+	list_for_each(&container->ents, ent, list) {
+		memcpy(buf, ent->tbl, readb(&ent->tbl->length));
+		buf += readb(&ent->tbl->length);
+	}
+
+	writeb(acpi_checksum(srat, size), &srat->h.checksum);
+
+	rc = write(p->out_fd[ACPI_SRAT], srat, size);
+	free(srat);
+
+	if (rc < 0)
+		return -errno;
+	return 0;
+}
+
+#define dbg(fmt, ...) \
+	({if (verbose) { \
+		fprintf(stderr, fmt, ##__VA_ARGS__); \
+	} else { \
+		do { } while (0); \
+	}})
+
+static int split_srat(struct parameters *p, struct split_context *split)
+{
+	struct srat_container *srat = read_srat(p->in_fd[ACPI_SRAT]);
+	struct srat_ent *ent, *found_ent = NULL;
+	int count = 0, max_pxm = 0, i, rc;
+	uint64_t length, address;
+	struct srat_mem *m;
+	LIST_HEAD(mems);
+
+	list_for_each(&srat->ents, ent, list) {
+		struct srat_generic *g;
+		struct srat_cpu *c;
+		int pxm, type;
+
+		type = readb(&ent->tbl->type);
+		switch (type) {
+		case ACPI_SRAT_TYPE_MEMORY_AFFINITY:
+			m = (struct srat_mem *) ent->tbl;
+			pxm = readl(&m->proximity_domain);
+			break;
+		case ACPI_SRAT_TYPE_CPU_AFFINITY:
+			c = (struct srat_cpu *) ent->tbl;
+			pxm = readb(&c->proximity_domain_lo);
+			pxm |= readw(&c->proximity_domain_hi[0]) << 8;
+			pxm |= readb(&c->proximity_domain_hi[2]) << 24;
+			break;
+		case ACPI_SRAT_TYPE_GENERIC_AFFINITY:
+			g = (struct srat_generic *) ent->tbl;
+			pxm = readl(&g->proximity_domain);
+			break;
+		default:
+			pxm = -1;
+			break;
+		}
+		max_pxm = max(pxm, max_pxm);
+
+		if (type != ACPI_SRAT_TYPE_MEMORY_AFFINITY)
+			continue;
+
+		if (p->pxm == pxm) {
+			found_ent = ent;
+			count++;
+		}
+
+		if (count > 1) {
+			error("SRAT: no support for splitting multiple entry proximity domains\n");
+			return -ENXIO;
+		}
+
+	}
+
+	if (!found_ent) {
+		error("SRAT: proximity domain to split not found\n");
+		free_srat_container(srat);
+		return -ENOENT;
+	}
+	ent = found_ent;
+	m = (struct srat_mem *) ent->tbl;
+	address = readq(&m->spa_base);
+	length = readq(&m->spa_length);
+
+	*split = (struct split_context) {
+		.address = address,
+		.length = length,
+		.max_pxm = max_pxm,
+	};
+
+	length /= p->nodes;
+	writeq(length, &m->spa_length);
+	dbg("SRAT: edit: %#llx@%#llx pxm: %d\n", (unsigned long long) length,
+			(unsigned long long) address, p->pxm);
+
+	address += length;
+
+	for (i = 0; i < p->nodes - 1; i++) {
+		struct srat_mem *srat_mem = calloc(1, sizeof(*srat_mem));
+
+		if (!srat_mem) {
+			error("failed to alloc srat entry\n");
+			return -ENOMEM;
+		}
+
+		ent = calloc(1, sizeof(*ent));
+		if (!ent) {
+			error("failed to alloc srat entry\n");
+			free(srat_mem);
+			return -ENOMEM;
+		}
+
+		ent->tbl = (struct acpi_subtable8 *) srat_mem;
+                writeb(ACPI_SRAT_TYPE_MEMORY_AFFINITY, &srat_mem->type);
+                writeb(sizeof(*srat_mem), &srat_mem->length);
+                writel(max_pxm + 1 + i, &srat_mem->proximity_domain);
+                writeq(address, &srat_mem->spa_base);
+                writeq(length, &srat_mem->spa_length);
+		srat_mem->flags = m->flags;
+		dbg("SRAT:  add: %#llx@%#llx pxm: %d\n",
+				(unsigned long long) length,
+				(unsigned long long) address, max_pxm + 1 + i);
+
+		address += length;
+		list_add_tail(&mems, &ent->list);
+	}
+
+	rc = create_srat(p, srat, &mems);
+	free_srat_container(srat);
+	if (rc < 0)
+		return rc;
+	return max_pxm;
+}
+
+static int split_slit(struct parameters *p, struct split_context *split)
+{
+	unsigned int oem_revision;
+	int max_pxm = split->max_pxm;
+	int nodes = max_pxm + p->nodes;
+	struct slit *slit, *slit_old;
+	int old_nodes, rc, i, j;
+	size_t size;
+
+	size = sizeof(*slit) + nodes * nodes;
+	slit = calloc(1, size);
+	if (!slit) {
+		error("failed to allocated %zd bytes\n", size);
+		return -ENOMEM;
+	}
+
+	slit_old = read_table(p->in_fd[ACPI_SLIT], "SLIT");
+	if (!slit_old) {
+		error("failed to read SLIT\n");
+		free(slit);
+		return -ENOMEM;
+	}
+
+	*slit = *slit_old;
+	old_nodes = readq(&slit_old->count);
+	writeq(nodes, &slit->count);
+	writel(size, &slit->h.length);
+	oem_revision = readl(&slit->h.oem_revision);
+	writel(oem_revision + 1, &slit->h.oem_revision);
+	for (i = 0; i < nodes; i++)
+		for (j = 0; j < nodes; j++) {
+			u8 val = 10;
+
+			if (i > max_pxm && j > max_pxm)
+				val = 10;
+			else if (i <= max_pxm && j <= max_pxm)
+				val = slit_old->entry[i * old_nodes + j];
+			else if (i > max_pxm)
+				val = slit_old->entry[p->pxm * old_nodes + j];
+			else if (j > max_pxm)
+				val = slit_old->entry[i * old_nodes + p->pxm];
+
+			/*
+			 * Linux requires distance 10 for the i == j
+			 * case and rejects distance 10 rejects the SLIT
+			 * if 10 is found anywhere else. Fixup val per
+			 * these constraints.
+			 */
+			if (val == 10 && i != j)
+				val = 11;
+
+			slit->entry[i * nodes + j] = val;
+		}
+	writeb(acpi_checksum(slit, size), &slit->h.checksum);
+
+	rc = write(p->out_fd[ACPI_SLIT], slit, size);
+	free(slit);
+	free(slit_old);
+	return rc;
+}
+
+static int split_nfit_map(struct parameters *p, struct nfit_map *map,
+		struct list_head *maps, struct split_context *split)
+{
+	int rc, i, max_region_id = split->max_region_id,
+	    max_range_index = split->max_range_index;
+	uint64_t region_offset, region_size;
+	struct nfit_ent *ent, *_ent;
+
+	region_offset = readq(&map->region_offset);
+	region_size = readq(&map->region_size);
+	region_size /= p->nodes;
+	writeq(region_size, &map->region_size);
+	dbg("NFIT: edit: %#llx@%#llx region_id: %d\n",
+			(unsigned long long) region_size,
+			(unsigned long long) region_offset,
+			readw(&map->region_id));
+	region_offset += region_size;
+
+	for (i = 0; i < p->nodes - 1; i++) {
+		struct nfit_map *nfit_map = calloc(1, sizeof(*nfit_map));
+
+		if (!nfit_map) {
+			error("failed to alloc nfit entry\n");
+			rc = -ENOMEM;
+			break;
+		}
+
+		ent = calloc(1, sizeof(*ent));
+		if (!ent) {
+			error("failed to alloc nfit entry\n");
+			free(nfit_map);
+			rc = -ENOMEM;
+			break;
+		}
+
+		ent->tbl = (struct acpi_subtable16 *) nfit_map;
+		*nfit_map = *map;
+		writew(max_region_id + 1 + i, &nfit_map->region_id);
+		writew(max_range_index + 1 + i, &nfit_map->range_index);
+		writeq(region_size, &nfit_map->region_size);
+		writeq(region_offset, &nfit_map->region_offset);
+
+		dbg("NFIT:  add: %#llx@%#llx region_id: %d\n",
+				(unsigned long long) region_size,
+				(unsigned long long) region_offset,
+				max_region_id + 1 + i);
+
+		region_offset += region_size;
+		list_add_tail(maps, &ent->list);
+	}
+
+	if (i < p->nodes - 1)
+		list_for_each_safe(maps, ent, _ent, list) {
+			list_del(&ent->list);
+			free(ent->tbl);
+			free(ent);
+			return rc;
+		}
+
+	split->max_region_id = max_region_id + i;
+	return 0;
+}
+
+static int split_nfit(struct parameters *p, struct split_context *split)
+{
+	int count = 0, max_pxm = split->max_pxm, i, rc, max_range_index = 0,
+	    max_region_id = 0;
+	struct nfit_container *nfit = read_nfit(p->in_fd[ACPI_NFIT]);
+	struct nfit_ent *ent, *_ent, *found_ent = NULL;
+	uint64_t length, address;
+	struct nfit_spa *spa;
+	struct nfit_map *map;
+	LIST_HEAD(new_maps);
+	LIST_HEAD(mems);
+	LIST_HEAD(maps);
+
+	list_for_each(&nfit->ents, ent, list) {
+		int pxm, type, range_index, region_id;
+
+		type = readw(&ent->tbl->type);
+		if (type == ACPI_NFIT_TYPE_MEMORY_MAP) {
+			map = (struct nfit_map *) ent->tbl;
+			region_id = readw(&map->region_id);
+			max_region_id = max(max_region_id, region_id);
+			continue;
+		}
+
+		if (type != ACPI_NFIT_TYPE_SYSTEM_ADDRESS)
+			continue;
+
+		spa = (struct nfit_spa *) ent->tbl;
+		range_index = readw(&spa->range_index);
+		max_range_index = max(range_index, max_range_index);
+
+		if (memcmp(&spa->type_uuid, &uuid_pmem, sizeof(uuid_pmem)) != 0)
+			continue;
+
+		pxm = readl(&spa->proximity_domain);
+		if (pxm != p->pxm)
+			continue;
+
+		if (split->address != readq(&spa->spa_base))
+			continue;
+
+		if (split->length != readq(&spa->spa_length))
+			continue;
+
+		found_ent = ent;
+		count++;
+
+		if (count > 1) {
+			error("NFIT: no support for splitting multiple entry proximity domains\n");
+			return -ENXIO;
+		}
+	}
+
+	if (!found_ent) {
+		dbg("NFIT: proximity domain to split not found\n");
+		free_nfit_container(nfit);
+		return -ENOENT;
+	}
+	ent = found_ent;
+	spa = (struct nfit_spa *) ent->tbl;
+	address = readq(&spa->spa_base);
+	length = readq(&spa->spa_length) / p->nodes;
+	writeq(length, &spa->spa_length);
+	dbg("NFIT: edit: %#llx@%#llx pxm: %d\n", (unsigned long long) length,
+			(unsigned long long) address, p->pxm);
+	address += length;
+
+	for (i = 0; i < p->nodes - 1; i++) {
+		struct nfit_spa *nfit_spa = calloc(1, sizeof(*nfit_spa));
+
+		if (!nfit_spa) {
+			error("failed to alloc nfit entry\n");
+			rc = -ENOMEM;
+			break;
+		}
+
+		ent = calloc(1, sizeof(*ent));
+		if (!ent) {
+			error("failed to alloc nfit entry\n");
+			free(nfit_spa);
+			rc = -ENOMEM;
+			break;
+		}
+
+		ent->tbl = (struct acpi_subtable16 *) nfit_spa;
+		*nfit_spa = *spa;
+		writew(max_range_index + i + 1, &nfit_spa->range_index);
+                writel(max_pxm + 1 + i, &nfit_spa->proximity_domain);
+		writeq(address, &nfit_spa->spa_base);
+		writeq(length, &nfit_spa->spa_length);
+
+		dbg("NFIT:  add: %#llx@%#llx pxm: %d\n",
+				(unsigned long long) length,
+				(unsigned long long) address, max_pxm + 1 + i);
+
+		address += length;
+		list_add_tail(&mems, &ent->list);
+	}
+
+	if (i < p->nodes - 1)
+		list_for_each_safe(&mems, ent, _ent, list) {
+			list_del(&ent->list);
+			free(ent->tbl);
+			free(ent);
+			return rc;
+		}
+
+	/*
+	 * Find and split the maps that might be referring to split
+	 * address range.
+	 */
+	split->max_region_id = max_region_id;
+	split->max_range_index = max_range_index;
+	list_for_each_safe(&nfit->ents, ent, _ent, list) {
+		unsigned int type;
+
+		type = readw(&ent->tbl->type);
+		if (type != ACPI_NFIT_TYPE_MEMORY_MAP)
+			continue;
+		map = (struct nfit_map *) ent->tbl;
+		if (map->range_index != spa->range_index)
+			continue;
+		list_del_from(&nfit->ents, &ent->list);
+		list_add_tail(&maps, &ent->list);
+	}
+
+	list_for_each(&maps, ent, list) {
+		map = (struct nfit_map *) ent->tbl;
+		rc = split_nfit_map(p, map, &new_maps, split);
+		if (rc)
+			return rc;
+	}
+
+	list_append_list(&maps, &new_maps);
+	list_append_list(&mems, &maps);
+
+	rc = create_nfit(p, nfit, &mems);
+	free_nfit_container(nfit);
+	if (rc < 0)
+		return rc;
+	return max_pxm;
+}
+
+static int do_split(struct parameters *p)
+{
+	struct split_context split;
+	int rc = split_srat(p, &split);
+
+	if (rc < 0)
+		return rc;
+	fprintf(stderr, "created: %s\n", p->new_table[ACPI_SRAT]);
+
+	rc = split_slit(p, &split);
+	if (rc < 0)
+		return rc;
+	fprintf(stderr, "created: %s\n", p->new_table[ACPI_SLIT]);
+
+	rc = split_nfit(p, &split);
+	if (rc == -ENOENT) {
+		unlink(p->new_table[ACPI_NFIT]);
+		return 0;
+	}
+
+	if (rc < 0)
+		return rc;
+
+	fprintf(stderr, "created: %s\n", p->new_table[ACPI_NFIT]);
+	return 0;
+}
+
+int cmd_split_acpi(int argc, const char **argv, void *ctx)
+{
+	int i, rc = 0;
+	const char * const u[] = {
+		"daxctl split-acpi <options>",
+		NULL
+	};
+	const struct option options[] = {
+	OPT_STRING('d', "directory", &param.path, "path",
+			"Path to ACPI tables dumped by \"acpixtract -a\""),
+	OPT_INTEGER('p', "pxm", &param.pxm,
+			"Proximity domain to split"),
+	OPT_INTEGER('n', "nodes", &param.nodes,
+			"Number of nodes to split capacity (default 2)"),
+	OPT_BOOLEAN('v', "verbose", &verbose, "Enable verbose output"),
+	OPT_END(),
+	};
+
+        argc = parse_options(argc, argv, options, u, 0);
+
+	for (i = 0; i < argc; i++) {
+		error("unknown parameter \"%s\"\n", argv[i]);
+		rc = -EINVAL;
+	}
+
+	if (param.nodes < 2) {
+		error("--nodes=%d, must be greater than 2\n", param.nodes);
+		rc = -EINVAL;
+	}
+
+	if (!is_power_of_2(param.nodes)) {
+		error("--nodes=%d, must be power of 2\n", param.nodes);
+		rc = -EINVAL;
+	}
+
+	if (rc)
+		usage_with_options(u, options);
+
+	for (i = 0; i < ACPI_TABLES; i++) {
+		rc = asprintf(&param.table[i], "%s/%s.dat", param.path
+				? param.path : ".", acpi_table_name(i));
+		if (rc < 0) {
+			error("failed to allocate path for %s\n",
+					acpi_table_name(i));
+			break;
+		}
+
+		rc = open(param.table[i], O_RDONLY);
+		if (rc < 0 && i > ACPI_SLIT) {
+			error("failed to open required %s\n", param.table[i]);
+			break;
+		}
+
+		if (rc < 0)
+			continue;
+		param.in_fd[i] = rc;
+
+		rc = asprintf(&param.new_table[i], "%s/%s.dat.new", param.path
+				? param.path : ".", acpi_table_name(i));
+		if (rc < 0) {
+			error("failed to allocate path for %s.new\n",
+					acpi_table_name(i));
+			break;
+		}
+
+		rc = open(param.new_table[i], O_RDWR | O_TRUNC | O_CREAT, 0640);
+		if (rc < 0 && i <= ACPI_SLIT) {
+			error("failed to open %s\n", param.new_table[i]);
+			break;
+		}
+		param.out_fd[i] = rc;
+	}
+
+	if (rc < 0) {
+		rc = EXIT_FAILURE;
+		goto out;
+	}
+
+	rc = do_split(&param);
+out:
+	for (i = 0; i < ACPI_TABLES; i++) {
+		free(param.table[i]);
+		free(param.new_table[i]);
+		if (param.in_fd[i] > 0)
+			close(param.in_fd[i]);
+		if (param.out_fd[i] > 0)
+			close(param.out_fd[i]);
+	}
+	return rc;
+}
diff --git a/daxctl/builtin.h b/daxctl/builtin.h
index f5a0147f0e11..cbee984971cf 100644
--- a/daxctl/builtin.h
+++ b/daxctl/builtin.h
@@ -9,4 +9,5 @@ int cmd_migrate(int argc, const char **argv, struct daxctl_ctx *ctx);
 int cmd_reconfig_device(int argc, const char **argv, struct daxctl_ctx *ctx);
 int cmd_online_memory(int argc, const char **argv, struct daxctl_ctx *ctx);
 int cmd_offline_memory(int argc, const char **argv, struct daxctl_ctx *ctx);
+int cmd_split_acpi(int argc, const char **argv, struct daxctl_ctx *ctx);
 #endif /* _DAXCTL_BUILTIN_H_ */
diff --git a/daxctl/daxctl.c b/daxctl/daxctl.c
index 1ab073200313..ec366dd71707 100644
--- a/daxctl/daxctl.c
+++ b/daxctl/daxctl.c
@@ -70,6 +70,7 @@ static struct cmd_struct commands[] = {
 	{ "version", .d_fn = cmd_version },
 	{ "list", .d_fn = cmd_list },
 	{ "help", .d_fn = cmd_help },
+	{ "split-acpi", .d_fn = cmd_split_acpi, },
 	{ "migrate-device-model", .d_fn = cmd_migrate },
 	{ "reconfigure-device", .d_fn = cmd_reconfig_device },
 	{ "online-memory", .d_fn = cmd_online_memory },
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

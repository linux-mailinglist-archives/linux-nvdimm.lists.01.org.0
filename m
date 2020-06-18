Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E31AF1FEBD4
	for <lists+linux-nvdimm@lfdr.de>; Thu, 18 Jun 2020 09:01:35 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 64EDD10FC4F79;
	Thu, 18 Jun 2020 00:01:34 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7A24710FC4F78
	for <linux-nvdimm@lists.01.org>; Thu, 18 Jun 2020 00:01:31 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05I6VsWR168554;
	Thu, 18 Jun 2020 03:01:27 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31qt6gx47j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2020 03:01:27 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05I6gIFL003464;
	Thu, 18 Jun 2020 03:01:27 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31qt6gx46j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2020 03:01:27 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05I7028s007317;
	Thu, 18 Jun 2020 07:01:25 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
	by ppma04ams.nl.ibm.com with ESMTP id 31qur60j5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2020 07:01:25 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05I71LBL60555678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2020 07:01:21 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BC0911C054;
	Thu, 18 Jun 2020 07:01:21 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9813811C052;
	Thu, 18 Jun 2020 07:01:17 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.105.7])
	by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Thu, 18 Jun 2020 07:01:17 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Thu, 18 Jun 2020 12:31:16 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH v7 2/5] libncdtl: Add initial support for NVDIMM_FAMILY_PAPR nvdimm family
Date: Thu, 18 Jun 2020 12:31:01 +0530
Message-Id: <20200618070104.239446-3-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200618070104.239446-1-vaibhav@linux.ibm.com>
References: <20200618070104.239446-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_03:2020-06-17,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 cotscore=-2147483648 mlxlogscore=999 spamscore=0 adultscore=0
 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006180046
Message-ID-Hash: OTAXEYSI5TBXEKXUAGUQS2UD77QGWTZX
X-Message-ID-Hash: OTAXEYSI5TBXEKXUAGUQS2UD77QGWTZX
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OTAXEYSI5TBXEKXUAGUQS2UD77QGWTZX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add necessary scaffolding in libndctl for dimms that support the
papr_scm specification[1]. Since there can be platforms that support
Open-Firmware[2] but not the papr_scm specification, the changes
proposed first add support for probing if the dimm bus supports
Open-Firmware. This is done by querying for the sysfs attribute
'of_node' in dimm device sysfs directory. If available newly
introduced member 'struct ndctl_bus.has_of_node' is set. During
'add_dimm()', the newly introduced add_papr_dimm() is called if dimm
bus reports supports Open-Firmware.

Function add_papr_dimm() queries the 'compatible' device tree
attribute via newly introduced ndctl_bus_is_papr_scm() and based on
its value assigns NVDIMM_FAMILY_PAPR to the dimm command family. In
the future, based on the contents of 'compatible' attribute more
of_pmem dimm families can be queried.

Additionally add support for parsing the dimm flags for
NVDIMM_FAMILY_PAPR supporting nvdimms as described at [3]. A newly
introduced function parse_papr_flags() reads the contents of this
flag file and sets appropriate flag bits in 'struct
ndctl_dimm.flags'.

Also, advertise support for monitor mode.

References:
[1] Documentation/powerpc/papr_hcalls.rst
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/powerpc/papr_hcalls.rst

[2] https://en.wikipedia.org/wiki/Open_Firmware

[3] Documentation/ABI/testing/sysfs-bus-papr-pmem
https://git.kernel.org/nvdimm/nvdimm/c/b791abf3201d724ac372c2ba1fa6e90d192e1dbf

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
Changelog:

v6..v7:
* Updated patch description based of review comments on v6 [ Vishal ]
* Updated links in patch description to current version. [ Vishal ]
* Added the missing copyright text in 'papr.c'

v5..v6:
* Updated various dbg messages to use consistent dimm device name
  rather than dimm-id. [Vishal]
* Minor changes to log messages in add_papr_dimm() [ Vishal ]
* Minor change in parse_papr_flags() to aid in code readability [Vishal]
* Added ndctl_bus_has_of_node() to library ld version script. [Vishal]
* Added new library function ndctl_bus_is_papr_scm() that checks the
  device tree compatible field [Vishal]
* Updated add_papr_dimm() to use ndctl_bus_is_papr_scm() [Vishal]
* Updated the license header of 'papr.c' to LGPL 2.1

v4..v5:
* Renamed file 'papr_scm.c' to 'papr.c'
* s/NVDIMM_FAMILY_PAPR_SCM/NVDIMM_FAMILY_PAPR/g
* s/papr_scm_dimm_ops/papr_dimm_ops/g
* s/parse_papr_scm_flags()/parse_papr_flags()/g
* Updated patch description & title to reflect new command family name
  and file-names.

v3..v4:
* None

v2..v3:
* Renamed add_of_pmem() to add_papr_dimm() [ Aneesh ]

v1..v2:
* Squashed the patch to parse dimm flags
* Updated the dimm flags parsing to add case for 'restore_fail' and
  'flush_fail'.
* Renamed parse_of_pmem_flags() to parse_papr_scm_flags().
* Updated the path to dimm flags file to 'papr/flags'.
* Introduced 'papr_scm.c' file in this patch rather than later in the
  patch series.
* Update add_of_pmem_dimm() to parse dimm flags and enable monitoring
  only if 'ibm,pmemory' compatible nvdimm is found.
---
 ndctl/lib/Makefile.am  |  1 +
 ndctl/lib/libndctl.c   | 84 ++++++++++++++++++++++++++++++++++++++++++
 ndctl/lib/libndctl.sym |  5 +++
 ndctl/lib/papr.c       | 28 ++++++++++++++
 ndctl/lib/private.h    |  2 +
 ndctl/libndctl.h       |  2 +
 ndctl/ndctl.h          |  1 +
 7 files changed, 123 insertions(+)
 create mode 100644 ndctl/lib/papr.c

diff --git a/ndctl/lib/Makefile.am b/ndctl/lib/Makefile.am
index d6be5c3acd26..e15bb2288575 100644
--- a/ndctl/lib/Makefile.am
+++ b/ndctl/lib/Makefile.am
@@ -23,6 +23,7 @@ libndctl_la_SOURCES =\
 	hpe1.c \
 	msft.c \
 	hyperv.c \
+	papr.c \
 	ars.c \
 	firmware.c \
 	libndctl.c \
diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index 5f6dad71975b..24ae27d5979e 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -799,6 +799,28 @@ static void parse_nfit_mem_flags(struct ndctl_dimm *dimm, char *flags)
 				ndctl_dimm_get_devname(dimm), flags);
 }
 
+static void parse_papr_flags(struct ndctl_dimm *dimm, char *flags)
+{
+	struct ndctl_ctx *ctx = ndctl_dimm_get_ctx(dimm);
+	char *start, *end;
+
+	start = flags;
+	while ((end = strchr(start, ' '))) {
+		*end = '\0';
+		if (strcmp(start, "not_armed") == 0)
+			dimm->flags.f_arm = 1;
+		else if (strcmp(start, "flush_fail") == 0)
+			dimm->flags.f_flush = 1;
+		else if (strcmp(start, "restore_fail") == 0)
+			dimm->flags.f_restore = 1;
+		else if (strcmp(start, "smart_notify") == 0)
+			dimm->flags.f_smart = 1;
+		start = end + 1;
+	}
+	if (end != start)
+		dbg(ctx, "%s: Flags:%s\n", ndctl_dimm_get_devname(dimm), flags);
+}
+
 static void parse_dimm_flags(struct ndctl_dimm *dimm, char *flags)
 {
 	char *start, *end;
@@ -856,6 +878,12 @@ static void *add_bus(void *parent, int id, const char *ctl_base)
 		bus->revision = strtoul(buf, NULL, 0);
 	}
 
+	sprintf(path, "%s/device/of_node/compatible", ctl_base);
+	if (sysfs_read_attr(ctx, path, buf) < 0)
+		bus->has_of_node = 0;
+	else
+		bus->has_of_node = 1;
+
 	sprintf(path, "%s/device/nfit/dsm_mask", ctl_base);
 	if (sysfs_read_attr(ctx, path, buf) < 0)
 		bus->nfit_dsm_mask = 0;
@@ -964,6 +992,23 @@ NDCTL_EXPORT int ndctl_bus_has_nfit(struct ndctl_bus *bus)
 	return bus->has_nfit;
 }
 
+NDCTL_EXPORT int ndctl_bus_has_of_node(struct ndctl_bus *bus)
+{
+	return bus->has_of_node;
+}
+
+NDCTL_EXPORT int ndctl_bus_is_papr_scm(struct ndctl_bus *bus)
+{
+	char buf[SYSFS_ATTR_SIZE];
+
+	snprintf(bus->bus_buf, bus->buf_len,
+		 "%s/of_node/compatible", bus->bus_path);
+	if (sysfs_read_attr(bus->ctx, bus->bus_buf, buf) < 0)
+		return 0;
+
+	return (strcmp(buf, "ibm,pmemory") == 0);
+}
+
 /**
  * ndctl_bus_get_major - nd bus character device major number
  * @bus: ndctl_bus instance returned from ndctl_bus_get_{first|next}
@@ -1441,6 +1486,40 @@ static int ndctl_bind(struct ndctl_ctx *ctx, struct kmod_module *module,
 static int ndctl_unbind(struct ndctl_ctx *ctx, const char *devpath);
 static struct kmod_module *to_module(struct ndctl_ctx *ctx, const char *alias);
 
+static int add_papr_dimm(struct ndctl_dimm *dimm, const char *dimm_base)
+{
+	int rc = -ENODEV;
+	char buf[SYSFS_ATTR_SIZE];
+	struct ndctl_ctx *ctx = dimm->bus->ctx;
+	char *path = calloc(1, strlen(dimm_base) + 100);
+	const char * const devname = ndctl_dimm_get_devname(dimm);
+
+	dbg(ctx, "%s: Probing of_pmem dimm at %s\n", devname, dimm_base);
+
+	if (!path)
+		return -ENOMEM;
+
+	/* construct path to the papr compatible dimm flags file */
+	sprintf(path, "%s/papr/flags", dimm_base);
+
+	if (ndctl_bus_is_papr_scm(dimm->bus) &&
+	    sysfs_read_attr(ctx, path, buf) == 0) {
+
+		dbg(ctx, "%s: Adding papr-scm dimm flags:\"%s\"\n", devname, buf);
+		dimm->cmd_family = NVDIMM_FAMILY_PAPR;
+
+		/* Parse dimm flags */
+		parse_papr_flags(dimm, buf);
+
+		/* Allocate monitor mode fd */
+		dimm->health_eventfd = open(path, O_RDONLY|O_CLOEXEC);
+		rc = 0;
+	}
+
+	free(path);
+	return rc;
+}
+
 static int add_nfit_dimm(struct ndctl_dimm *dimm, const char *dimm_base)
 {
 	int i, rc = -1;
@@ -1619,6 +1698,8 @@ static void *add_dimm(void *parent, int id, const char *dimm_base)
 	if (ndctl_bus_has_nfit(bus)) {
 		dimm->formats = formats;
 		rc = add_nfit_dimm(dimm, dimm_base);
+	} else if (ndctl_bus_has_of_node(bus)) {
+		rc = add_papr_dimm(dimm, dimm_base);
 	}
 
 	if (rc == -ENODEV) {
@@ -1636,6 +1717,9 @@ static void *add_dimm(void *parent, int id, const char *dimm_base)
 		dimm->ops = msft_dimm_ops;
 	if (dimm->cmd_family == NVDIMM_FAMILY_HYPERV)
 		dimm->ops = hyperv_dimm_ops;
+	if (dimm->cmd_family == NVDIMM_FAMILY_PAPR)
+		dimm->ops = papr_dimm_ops;
+
  out:
 	if (rc) {
 		err(ctx, "%s: probe failed: %s\n", ndctl_dimm_get_devname(dimm),
diff --git a/ndctl/lib/libndctl.sym b/ndctl/lib/libndctl.sym
index ac575a23d035..9cfaccf5d3b7 100644
--- a/ndctl/lib/libndctl.sym
+++ b/ndctl/lib/libndctl.sym
@@ -431,3 +431,8 @@ LIBNDCTL_23 {
 	ndctl_region_get_align;
 	ndctl_region_set_align;
 } LIBNDCTL_22;
+
+LIBNDCTL_24 {
+	ndctl_bus_has_of_node;
+	ndctl_bus_is_papr_scm;
+} LIBNDCTL_23;
diff --git a/ndctl/lib/papr.c b/ndctl/lib/papr.c
new file mode 100644
index 000000000000..2d1be73e455f
--- /dev/null
+++ b/ndctl/lib/papr.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: LGPL-2.1
+/*
+ * libndctl support for PAPR-SCM based NVDIMMs
+ *
+ * (C) Copyright IBM 2020
+ *
+ */
+
+#include <stdint.h>
+#include <stdlib.h>
+#include <limits.h>
+#include <util/log.h>
+#include <ndctl.h>
+#include <ndctl/libndctl.h>
+#include <lib/private.h>
+
+static bool papr_cmd_is_supported(struct ndctl_dimm *dimm, int cmd)
+{
+	/* Handle this separately to support monitor mode */
+	if (cmd == ND_CMD_SMART)
+		return true;
+
+	return !!(dimm->cmd_mask & (1ULL << cmd));
+}
+
+struct ndctl_dimm_ops * const papr_dimm_ops = &(struct ndctl_dimm_ops) {
+	.cmd_is_supported = papr_cmd_is_supported,
+};
diff --git a/ndctl/lib/private.h b/ndctl/lib/private.h
index 2e537f0a8649..d90236b1f98b 100644
--- a/ndctl/lib/private.h
+++ b/ndctl/lib/private.h
@@ -167,6 +167,7 @@ struct ndctl_bus {
 	int dimms_init;
 	int regions_init;
 	int has_nfit;
+	int has_of_node;
 	char *bus_path;
 	char *bus_buf;
 	size_t buf_len;
@@ -352,6 +353,7 @@ extern struct ndctl_dimm_ops * const intel_dimm_ops;
 extern struct ndctl_dimm_ops * const hpe1_dimm_ops;
 extern struct ndctl_dimm_ops * const msft_dimm_ops;
 extern struct ndctl_dimm_ops * const hyperv_dimm_ops;
+extern struct ndctl_dimm_ops * const papr_dimm_ops;
 
 static inline struct ndctl_bus *cmd_to_bus(struct ndctl_cmd *cmd)
 {
diff --git a/ndctl/libndctl.h b/ndctl/libndctl.h
index 2580f433ade8..e16fb7eaf34b 100644
--- a/ndctl/libndctl.h
+++ b/ndctl/libndctl.h
@@ -119,6 +119,8 @@ struct ndctl_bus *ndctl_bus_get_next(struct ndctl_bus *bus);
              bus = ndctl_bus_get_next(bus))
 struct ndctl_ctx *ndctl_bus_get_ctx(struct ndctl_bus *bus);
 int ndctl_bus_has_nfit(struct ndctl_bus *bus);
+int ndctl_bus_has_of_node(struct ndctl_bus *bus);
+int ndctl_bus_is_papr_scm(struct ndctl_bus *bus);
 unsigned int ndctl_bus_get_major(struct ndctl_bus *bus);
 unsigned int ndctl_bus_get_minor(struct ndctl_bus *bus);
 const char *ndctl_bus_get_devname(struct ndctl_bus *bus);
diff --git a/ndctl/ndctl.h b/ndctl/ndctl.h
index 008f81cdeb9f..3b64f66d58cc 100644
--- a/ndctl/ndctl.h
+++ b/ndctl/ndctl.h
@@ -263,6 +263,7 @@ struct nd_cmd_pkg {
 #define NVDIMM_FAMILY_HPE2 2
 #define NVDIMM_FAMILY_MSFT 3
 #define NVDIMM_FAMILY_HYPERV 4
+#define NVDIMM_FAMILY_PAPR 5
 
 #define ND_IOCTL_CALL			_IOWR(ND_IOCTL, ND_CMD_CALL,\
 					struct nd_cmd_pkg)
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

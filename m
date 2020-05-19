Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC531DA049
	for <lists+linux-nvdimm@lfdr.de>; Tue, 19 May 2020 21:02:16 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A450711E48A2B;
	Tue, 19 May 2020 11:58:55 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 145FB100A027A
	for <linux-nvdimm@lists.01.org>; Tue, 19 May 2020 11:58:53 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04JIXWbO143013;
	Tue, 19 May 2020 15:02:06 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 312bg7khex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2020 15:02:06 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04JIYJXB145777;
	Tue, 19 May 2020 15:02:05 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 312bg7khdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2020 15:02:05 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04JJ0Vc6004647;
	Tue, 19 May 2020 19:02:03 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by ppma04ams.nl.ibm.com with ESMTP id 313xehj6du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2020 19:02:03 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04JJ20vn56754306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2020 19:02:00 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 915EF4C046;
	Tue, 19 May 2020 19:02:00 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF89D4C044;
	Tue, 19 May 2020 19:01:57 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.89.230])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Tue, 19 May 2020 19:01:57 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Wed, 20 May 2020 00:31:57 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH v3 2/6] libncdtl: Add initial support for NVDIMM_FAMILY_PAPR_SCM dimm family
Date: Wed, 20 May 2020 00:31:43 +0530
Message-Id: <20200519190147.258142-3-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519190147.258142-1-vaibhav@linux.ibm.com>
References: <20200519190147.258142-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-19_07:2020-05-19,2020-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 cotscore=-2147483648 malwarescore=0
 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005190157
Message-ID-Hash: AWSGE5NXVHMVIYVY4WX6UM6VAA6TZP4Y
X-Message-ID-Hash: AWSGE5NXVHMVIYVY4WX6UM6VAA6TZP4Y
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AWSGE5NXVHMVIYVY4WX6UM6VAA6TZP4Y/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add necessary scaffolding in libndctl for dimms that support papr_scm
specification[1]. Since there can be platforms that support
Open-Firmware[2] but not the papr_scm specification, hence the changes
proposed first add support for probing if the dimm bus supports
Open-Firmware. This is done via querying for sysfs attribute 'of_node'
in dimm device sysfs directory. If available newly introduced member
'struct ndctl_bus.has_of_node' is set. During the probe of the dimm
and execution of add_dimm(), the newly introduced add_papr_dimm()
is called if dimm bus reports supports Open-Firmware.

Function add_papr_dimm() queries the 'compatible' device tree
attribute and based on its value assign NVDIMM_FAMILY_PAPR_SCM to the
dimm command family. In future, based on the contents of 'compatible'
attribute more of_pmem dimm families can be queried.

We also add support for parsing the dimm flags for
NVDIMM_FAMILY_PAPR_SCM supporting nvdimms as described at [3]. A newly
introduced function parse_papr_scm_flags() reads the contents of this
flag file and sets appropriate flag bits in 'struct
ndctl_dimm.flags'.

Also we advertise support for monitor mode by allocating a file
descriptor to the dimm 'flags' file and assigning it to 'struct
ndctl_dimm.health_event_fd'.

The dimm-ops implementation for NVDIMM_FAMILY_PAPR_SCM is
available in global variable 'papr_scm_dimm_ops' which points to
skeleton implementation in newly introduced file 'lib/papr_scm.c'.

References:
[1] Documentation/powerpc/papr_hcalls.rst
https://lore.kernel.org/linux-nvdimm/20200420070711.223545-2-vaibhav@linux.ibm.com/

[2] https://en.wikipedia.org/wiki/Open_Firmware

[3] Documentation/ABI/testing/sysfs-bus-papr-scm
https://lore.kernel.org/linux-nvdimm/20200420070711.223545-3-vaibhav@linux.ibm.com/

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
Changelog:

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
 ndctl/lib/Makefile.am |  1 +
 ndctl/lib/libndctl.c  | 78 +++++++++++++++++++++++++++++++++++++++++++
 ndctl/lib/papr_scm.c  | 32 ++++++++++++++++++
 ndctl/lib/private.h   |  2 ++
 ndctl/libndctl.h      |  1 +
 ndctl/ndctl.h         |  1 +
 6 files changed, 115 insertions(+)
 create mode 100644 ndctl/lib/papr_scm.c

diff --git a/ndctl/lib/Makefile.am b/ndctl/lib/Makefile.am
index d6be5c3acd26..90ba680bee56 100644
--- a/ndctl/lib/Makefile.am
+++ b/ndctl/lib/Makefile.am
@@ -23,6 +23,7 @@ libndctl_la_SOURCES =\
 	hpe1.c \
 	msft.c \
 	hyperv.c \
+	papr_scm.c \
 	ars.c \
 	firmware.c \
 	libndctl.c \
diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index d76dbf7e17de..a627661852eb 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -799,6 +799,28 @@ static void parse_nfit_mem_flags(struct ndctl_dimm *dimm, char *flags)
 				ndctl_dimm_get_devname(dimm), flags);
 }
 
+static void parse_papr_scm_flags(struct ndctl_dimm *dimm, char *flags)
+{
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
+		dbg(ndctl_dimm_get_ctx(dimm), "%s: %s\n",
+				ndctl_dimm_get_devname(dimm), flags);
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
@@ -964,6 +992,10 @@ NDCTL_EXPORT int ndctl_bus_has_nfit(struct ndctl_bus *bus)
 	return bus->has_nfit;
 }
 
+NDCTL_EXPORT int ndctl_bus_has_of_node(struct ndctl_bus *bus)
+{
+	return bus->has_of_node;
+}
 /**
  * ndctl_bus_get_major - nd bus character device major number
  * @bus: ndctl_bus instance returned from ndctl_bus_get_{first|next}
@@ -1441,6 +1473,47 @@ static int ndctl_bind(struct ndctl_ctx *ctx, struct kmod_module *module,
 static int ndctl_unbind(struct ndctl_ctx *ctx, const char *devpath);
 static struct kmod_module *to_module(struct ndctl_ctx *ctx, const char *alias);
 
+static int add_papr_dimm(struct ndctl_dimm *dimm, const char *dimm_base)
+{
+	int rc = -ENODEV;
+	char buf[SYSFS_ATTR_SIZE];
+	struct ndctl_ctx *ctx = dimm->bus->ctx;
+	char *path = calloc(1, strlen(dimm_base) + 100);
+
+	dbg(ctx, "Probing of_pmem dimm %d at %s\n", dimm->id, dimm_base);
+
+	if (!path)
+		return -ENOMEM;
+
+	sprintf(path, "%s/../of_node/compatible", dimm_base);
+	if (sysfs_read_attr(ctx, path, buf) < 0)
+		goto out;
+
+
+	dbg(ctx, "Compatible of_pmem dimm %d at %s\n", dimm->id, buf);
+	/* construct path to the papr compatible dimm flags file */
+	sprintf(path, "%s/papr/flags", dimm_base);
+
+	if (strcmp(buf, "ibm,pmemory") == 0 &&
+	    sysfs_read_attr(ctx, path, buf) == 0) {
+
+		dbg(ctx, "Found papr_scm dimm %d at %s\n", dimm->id, buf);
+		dimm->cmd_family = NVDIMM_FAMILY_PAPR_SCM;
+
+		/* Parse dimm flags */
+		parse_papr_scm_flags(dimm, buf);
+
+		/* Allocate monitor mode fd */
+		dimm->health_eventfd = open(path, O_RDONLY|O_CLOEXEC);
+		rc = 0;
+	}
+	/* Ignore dimm if unknown type */
+
+ out:
+	free(path);
+	return rc;
+}
+
 static int add_nfit_dimm(struct ndctl_dimm *dimm, const char *dimm_base)
 {
 	int i, rc = -1;
@@ -1619,6 +1692,8 @@ static void *add_dimm(void *parent, int id, const char *dimm_base)
 	if (ndctl_bus_has_nfit(bus)) {
 		dimm->formats = formats;
 		rc = add_nfit_dimm(dimm, dimm_base);
+	} else if (ndctl_bus_has_of_node(bus)) {
+		rc = add_papr_dimm(dimm, dimm_base);
 	}
 
 	if (rc == -ENODEV) {
@@ -1636,6 +1711,9 @@ static void *add_dimm(void *parent, int id, const char *dimm_base)
 		dimm->ops = msft_dimm_ops;
 	if (dimm->cmd_family == NVDIMM_FAMILY_HYPERV)
 		dimm->ops = hyperv_dimm_ops;
+	if (dimm->cmd_family == NVDIMM_FAMILY_PAPR_SCM)
+		dimm->ops = papr_scm_dimm_ops;
+
  out:
 	if (rc) {
 		err(ctx, "Unable to probe dimm:%d. Err:%d\n", id, rc);
diff --git a/ndctl/lib/papr_scm.c b/ndctl/lib/papr_scm.c
new file mode 100644
index 000000000000..14ff8879f627
--- /dev/null
+++ b/ndctl/lib/papr_scm.c
@@ -0,0 +1,32 @@
+/*
+ * Copyright (C) 2020 IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU Lesser General Public License,
+ * version 2.1, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT ANY
+ * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
+ * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
+ * more details.
+ */
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
+struct ndctl_dimm_ops * const papr_scm_dimm_ops = &(struct ndctl_dimm_ops) {
+	.cmd_is_supported = papr_cmd_is_supported,
+};
diff --git a/ndctl/lib/private.h b/ndctl/lib/private.h
index 2e537f0a8649..05c703ed71b4 100644
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
+extern struct ndctl_dimm_ops * const papr_scm_dimm_ops;
 
 static inline struct ndctl_bus *cmd_to_bus(struct ndctl_cmd *cmd)
 {
diff --git a/ndctl/libndctl.h b/ndctl/libndctl.h
index 2580f433ade8..daf11b8ce4ea 100644
--- a/ndctl/libndctl.h
+++ b/ndctl/libndctl.h
@@ -119,6 +119,7 @@ struct ndctl_bus *ndctl_bus_get_next(struct ndctl_bus *bus);
              bus = ndctl_bus_get_next(bus))
 struct ndctl_ctx *ndctl_bus_get_ctx(struct ndctl_bus *bus);
 int ndctl_bus_has_nfit(struct ndctl_bus *bus);
+int ndctl_bus_has_of_node(struct ndctl_bus *bus);
 unsigned int ndctl_bus_get_major(struct ndctl_bus *bus);
 unsigned int ndctl_bus_get_minor(struct ndctl_bus *bus);
 const char *ndctl_bus_get_devname(struct ndctl_bus *bus);
diff --git a/ndctl/ndctl.h b/ndctl/ndctl.h
index 008f81cdeb9f..426708e1fd9b 100644
--- a/ndctl/ndctl.h
+++ b/ndctl/ndctl.h
@@ -263,6 +263,7 @@ struct nd_cmd_pkg {
 #define NVDIMM_FAMILY_HPE2 2
 #define NVDIMM_FAMILY_MSFT 3
 #define NVDIMM_FAMILY_HYPERV 4
+#define NVDIMM_FAMILY_PAPR_SCM 5
 
 #define ND_IOCTL_CALL			_IOWR(ND_IOCTL, ND_CMD_CALL,\
 					struct nd_cmd_pkg)
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

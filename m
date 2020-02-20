Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E19165C25
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Feb 2020 11:52:13 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7C44910FC35B6;
	Thu, 20 Feb 2020 02:53:04 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3B79C10097E1D
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 02:51:01 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01KAiZ6S118252
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 05:50:08 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2y8uchpsk4-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 05:50:08 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <vaibhav@linux.ibm.com>;
	Thu, 20 Feb 2020 10:50:06 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
	by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 20 Feb 2020 10:50:03 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01KAo2wE12845260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2020 10:50:02 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37CEAA4051;
	Thu, 20 Feb 2020 10:50:02 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1E9DA404D;
	Thu, 20 Feb 2020 10:49:59 +0000 (GMT)
Received: from vajain21.in.ibm.com.com (unknown [9.199.53.128])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu, 20 Feb 2020 10:49:59 +0000 (GMT)
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH 5/8] libndctl,papr_scm: Add definitions for PAPR_SCM DSM commands
Date: Thu, 20 Feb 2020 16:19:25 +0530
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220104928.198625-1-vaibhav@linux.ibm.com>
References: <20200220104928.198625-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20022010-4275-0000-0000-000003A3BF12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022010-4276-0000-0000-000038B7CB5E
Message-Id: <20200220104928.198625-6-vaibhav@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_02:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 suspectscore=1 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200079
Message-ID-Hash: J4YLWVTFQJJV6L3HQ5AAEUGUO3C2FR5X
X-Message-ID-Hash: J4YLWVTFQJJV6L3HQ5AAEUGUO3C2FR5X
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Alastair D'Silva <alastair@au1.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/J4YLWVTFQJJV6L3HQ5AAEUGUO3C2FR5X/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Pull the kernel definition of PAPR_SCM DSM command which is located in
the kernel tree at Ref[1]. Also add an implementation of
'papr_scm_dimm_ops' in a new file named 'papr_scm.c'. For now only an
implementation of 'dimm_ops.cmd_is_supported' is provided.

References:
[1]: arch/powerpc/include/uapi/asm/papr_scm_dsm.h

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 ndctl/lib/Makefile.am    |   1 +
 ndctl/lib/papr_scm.c     |  34 ++++++++++
 ndctl/lib/papr_scm_dsm.h | 143 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 178 insertions(+)
 create mode 100644 ndctl/lib/papr_scm.c
 create mode 100644 ndctl/lib/papr_scm_dsm.h

diff --git a/ndctl/lib/Makefile.am b/ndctl/lib/Makefile.am
index e4eb0060bca4..3943541e435d 100644
--- a/ndctl/lib/Makefile.am
+++ b/ndctl/lib/Makefile.am
@@ -21,6 +21,7 @@ libndctl_la_SOURCES =\
 	hpe1.c \
 	msft.c \
 	hyperv.c \
+	papr_scm.c \
 	ars.c \
 	firmware.c \
 	libndctl.c
diff --git a/ndctl/lib/papr_scm.c b/ndctl/lib/papr_scm.c
new file mode 100644
index 000000000000..878698a5a8b4
--- /dev/null
+++ b/ndctl/lib/papr_scm.c
@@ -0,0 +1,34 @@
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
+#include <endian.h>
+#include <util/log.h>
+#include <ndctl.h>
+#include <ndctl/libndctl.h>
+#include <lib/private.h>
+#include <papr_scm_dsm.h>
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
diff --git a/ndctl/lib/papr_scm_dsm.h b/ndctl/lib/papr_scm_dsm.h
new file mode 100644
index 000000000000..aacced453579
--- /dev/null
+++ b/ndctl/lib/papr_scm_dsm.h
@@ -0,0 +1,143 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/*
+ * PAPR SCM Device specific methods for libndctl and ndctl
+ *
+ * (C) Copyright IBM 2020
+ *
+ * Author: Vaibhav Jain <vaibhav at linux.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _UAPI_ASM_POWERPC_PAPR_SCM_DSM_H_
+#define _UAPI_ASM_POWERPC_PAPR_SCM_DSM_H_
+
+#include <linux/types.h>
+
+#ifdef __KERNEL__
+#include <linux/ndctl.h>
+#else
+#include <ndctl.h>
+#endif
+
+/*
+ * Sub commands for ND_CMD_CALL. To prevent overlap from ND_CMD_*, values for
+ * these enums start at 0x10000. These values are then returned from
+ * cmd_to_func() making it easy to implement the switch-case block in
+ * papr_scm_ndctl()
+ */
+enum dsm_papr_scm {
+	DSM_PAPR_SCM_MIN =  0x10000,
+	DSM_PAPR_SCM_HEALTH,
+	DSM_PAPR_SCM_STATS,
+	DSM_PAPR_SCM_MAX,
+};
+
+enum dsm_papr_scm_dimm_health {
+	DSM_PAPR_SCM_DIMM_HEALTHY,
+	DSM_PAPR_SCM_DIMM_UNHEALTHY,
+	DSM_PAPR_SCM_DIMM_CRITICAL,
+	DSM_PAPR_SCM_DIMM_FATAL,
+};
+
+/* Papr-scm-header + payload expected with ND_CMD_CALL ioctl from libnvdimm */
+struct nd_papr_scm_cmd_pkg {
+	struct nd_cmd_pkg hdr;		/* Package header containing sub-cmd */
+	int32_t cmd_status;		/* Out: Sub-cmd status returned back */
+	uint16_t payload_offset;	/* In: offset from start of struct */
+	uint16_t payload_version;	/* In/Out: version of the payload */
+	uint8_t payload[];		/* In/Out: Sub-cmd data buffer */
+};
+
+/* Helpers to evaluate the size of PAPR_SCM envelope */
+/* Calculate the papr_scm-header size */
+#define ND_PAPR_SCM_ENVELOPE_CONTENT_HDR_SIZE \
+	(sizeof(struct nd_papr_scm_cmd_pkg) - sizeof(struct nd_cmd_pkg))
+/*
+ * Given a type calculate the envelope size
+ * (nd-header + papr_scm-header + payload)
+ */
+#define ND_PAPR_SCM_ENVELOPE_SIZE(_type_)	\
+	(sizeof(_type_) + sizeof(struct nd_papr_scm_cmd_pkg))
+
+/* Given a type envelope-content size (papr_scm-header + payload) */
+#define ND_PAPR_SCM_ENVELOPE_CONTENT_SIZE(_type_)	\
+	(sizeof(_type_) + ND_PAPR_SCM_ENVELOPE_CONTENT_HDR_SIZE)
+
+/*
+ * Struct exchanged between kernel & ndctl in for PAPR_DSM_PAPR_SMART_HEALTH
+ * Various bitflags indicate the health status of the dimm.
+ */
+struct nd_papr_scm_dimm_health_stat_v1 {
+	/* Dimm not armed. So contents wont persist */
+	bool dimm_unarmed;
+	/* Previous shutdown did not persist contents */
+	bool dimm_bad_shutdown;
+	/* Contents from previous shutdown werent restored */
+	bool dimm_bad_restore;
+	/* Contents of the dimm have been scrubbed */
+	bool dimm_scrubbed;
+	/* Contents of the dimm cant be modified until CEC reboot */
+	bool dimm_locked;
+	/* Contents of dimm are encrypted */
+	bool dimm_encrypted;
+
+	enum dsm_papr_scm_dimm_health dimm_health;
+};
+
+/*
+ * Typedef the current struct for dimm_health so that any application
+ * or kernel recompiled after introducing a new version autometically
+ * supports the new version.
+ */
+#define nd_papr_scm_dimm_health_stat nd_papr_scm_dimm_health_stat_v1
+
+/* Current version number for the dimm health struct */
+#define ND_PAPR_SCM_DIMM_HEALTH_VERSION 1
+
+/* Struct holding a single performance metric */
+struct nd_papr_scm_perf_stat {
+	u64 statistic_id;
+	u64 statistic_value;
+};
+
+/* Struct exchanged between kernel and ndctl reporting drc perf stats */
+struct nd_papr_scm_perf_stats_v1 {
+	/* Number of stats following */
+	u32 num_statistics;
+
+	/* zero or more performance matrics */
+	struct nd_papr_scm_perf_stat scm_statistics[];
+};
+
+/*
+ * Typedef the current struct for dimm_stats so that any application
+ * or kernel recompiled after introducing a new version autometically
+ * supports the new version.
+ */
+#define nd_papr_scm_perf_stats nd_papr_scm_perf_stats_v1
+#define ND_PAPR_SCM_DIMM_PERF_STATS_VERSION 1
+
+/* Convert a libnvdimm nd_cmd_pkg to papr_scm specific pkg */
+static struct nd_papr_scm_cmd_pkg *nd_to_papr_cmd_pkg(struct nd_cmd_pkg *cmd)
+{
+	return (struct nd_papr_scm_cmd_pkg *) cmd;
+}
+
+/* Return the payload pointer for a given pcmd */
+static void *papr_scm_pcmd_to_payload(struct nd_papr_scm_cmd_pkg *pcmd)
+{
+	if (pcmd->hdr.nd_size_in == 0 && pcmd->hdr.nd_size_out == 0)
+		return NULL;
+	else
+		return (void *)((u8 *) pcmd + pcmd->payload_offset);
+}
+#endif /* _UAPI_ASM_POWERPC_PAPR_SCM_DSM_H_ */
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

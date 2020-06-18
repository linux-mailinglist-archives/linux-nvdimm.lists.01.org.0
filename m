Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC3B1FEBDF
	for <lists+linux-nvdimm@lfdr.de>; Thu, 18 Jun 2020 09:02:37 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D44C410FC4F77;
	Thu, 18 Jun 2020 00:02:35 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 044F010FC4F77
	for <linux-nvdimm@lists.01.org>; Thu, 18 Jun 2020 00:02:32 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05I72DY0192272;
	Thu, 18 Jun 2020 03:02:29 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 31r3cnr7g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2020 03:02:29 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05I72S94194262;
	Thu, 18 Jun 2020 03:02:28 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 31r3cnr6p8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2020 03:02:24 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05I7077j007996;
	Thu, 18 Jun 2020 07:01:30 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by ppma04ams.nl.ibm.com with ESMTP id 31qur60j5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2020 07:01:30 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05I71Rmh57082044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2020 07:01:27 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0C56AE04D;
	Thu, 18 Jun 2020 07:01:26 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07A33AE056;
	Thu, 18 Jun 2020 07:01:23 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.105.7])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Thu, 18 Jun 2020 07:01:22 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Thu, 18 Jun 2020 12:31:21 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH v7 3/5] libndctl,papr_scm: Add definitions for PAPR nvdimm specific methods
Date: Thu, 18 Jun 2020 12:31:02 +0530
Message-Id: <20200618070104.239446-4-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200618070104.239446-1-vaibhav@linux.ibm.com>
References: <20200618070104.239446-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_04:2020-06-17,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 cotscore=-2147483648 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006180049
Message-ID-Hash: 5WJCAOEHSGIL56VAQAPPFTKETNLTNODD
X-Message-ID-Hash: 5WJCAOEHSGIL56VAQAPPFTKETNLTNODD
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5WJCAOEHSGIL56VAQAPPFTKETNLTNODD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Pull the kernel definition of PAPR nvdimm specific methods which is
located in the proposed kernel tree patches at Ref[1] & [2].

Add a new header file 'papr.h' that introduces defines 'struct
nd_pkg_papr' that holds an instance of 'struct nd_cmd_pkg' and 'struct
nd_pkg_pdsm' together. Also add an instance of 'struct nd_pkg_pdsm' to
'struct ndctl_cmd' named as 'papr'.

References:
[1] "powerpc/papr_scm: Add support for reporting nvdimm health"
https://lore.kernel.org/linux-nvdimm/20200615124407.32596-1-vaibhav@linux.ibm.com/

[2] "ndctl/papr_scm,uapi: Add support for PAPR nvdimm specific methods"
https://lore.kernel.org/linux-nvdimm/20200615124407.32596-6-vaibhav@linux.ibm.com/

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
Changelog:

v6..v7:
* None

v5..v6:
* Updated 'papr_pdsm.h' to recent kernel-uapi version.
* Introduced a new header 'papr.h' and 'struct nd_pkg_papr'.
* Updated patch description.

v4..v5:
* Renamed 'papr_scm_pdsm.h' to 'papr_pdsm.h'
* Updated 'papr_pdsm.h' to recent kernel-uapi version.

v3..v4:
* Updated the definition of 'struct nd_pdsm_cmd_pkg' and
  pdsm_cmd_to_payload() to remove 'payload_offset' field. [ Aneesh ]

v2..v3:
* Added instance of 'struct nd_pdsm_cmd_pkg' to 'struct ndctl_cmd'
* Updated commit description.
* Updated the papr_scm_pdsm.h header to recently proposed kernel
  version.

v1..v2:
* Switched from obsolete papr_scm_dsm.h to recent papr_scm_pdsm.h that
  describes the ND_CMD_CALL interface between libndctl and papr_scm
  module.
---
 ndctl/lib/papr.c      |   1 +
 ndctl/lib/papr.h      |  15 +++++
 ndctl/lib/papr_pdsm.h | 132 ++++++++++++++++++++++++++++++++++++++++++
 ndctl/lib/private.h   |   2 +
 4 files changed, 150 insertions(+)
 create mode 100644 ndctl/lib/papr.h
 create mode 100644 ndctl/lib/papr_pdsm.h

diff --git a/ndctl/lib/papr.c b/ndctl/lib/papr.c
index 2d1be73e455f..42372c3e2f7f 100644
--- a/ndctl/lib/papr.c
+++ b/ndctl/lib/papr.c
@@ -13,6 +13,7 @@
 #include <ndctl.h>
 #include <ndctl/libndctl.h>
 #include <lib/private.h>
+#include "papr.h"
 
 static bool papr_cmd_is_supported(struct ndctl_dimm *dimm, int cmd)
 {
diff --git a/ndctl/lib/papr.h b/ndctl/lib/papr.h
new file mode 100644
index 000000000000..77579396a7bd
--- /dev/null
+++ b/ndctl/lib/papr.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: LGPL-2.1 */
+/* (C) Copyright IBM 2020 */
+
+#ifndef __PAPR_H__
+#define __PAPR_H__
+
+#include <papr_pdsm.h>
+
+/* Wraps a nd_cmd generic header with pdsm header */
+struct nd_pkg_papr {
+	struct nd_cmd_pkg gen;
+	struct nd_pkg_pdsm pdsm;
+};
+
+#endif /* __PAPR_H__ */
diff --git a/ndctl/lib/papr_pdsm.h b/ndctl/lib/papr_pdsm.h
new file mode 100644
index 000000000000..4c7c06757053
--- /dev/null
+++ b/ndctl/lib/papr_pdsm.h
@@ -0,0 +1,132 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * PAPR nvDimm Specific Methods (PDSM) and structs for libndctl
+ *
+ * (C) Copyright IBM 2020
+ *
+ * Author: Vaibhav Jain <vaibhav at linux.ibm.com>
+ */
+
+#ifndef _UAPI_ASM_POWERPC_PAPR_PDSM_H_
+#define _UAPI_ASM_POWERPC_PAPR_PDSM_H_
+
+#include <linux/types.h>
+#include <linux/ndctl.h>
+
+/*
+ * PDSM Envelope:
+ *
+ * The ioctl ND_CMD_CALL exchange data between user-space and kernel via
+ * envelope which consists of 2 headers sections and payload sections as
+ * illustrated below:
+ *  +-----------------+---------------+---------------------------+
+ *  |   64-Bytes      |   8-Bytes     |       Max 184-Bytes       |
+ *  +-----------------+---------------+---------------------------+
+ *  | ND-HEADER       |  PDSM-HEADER  |      PDSM-PAYLOAD         |
+ *  +-----------------+---------------+---------------------------+
+ *  | nd_family       |               |                           |
+ *  | nd_size_out     | cmd_status    |                           |
+ *  | nd_size_in      | reserved      |     nd_pdsm_payload       |
+ *  | nd_command      | payload   --> |                           |
+ *  | nd_fw_size      |               |                           |
+ *  | nd_payload ---> |               |                           |
+ *  +---------------+-----------------+---------------------------+
+ *
+ * ND Header:
+ * This is the generic libnvdimm header described as 'struct nd_cmd_pkg'
+ * which is interpreted by libnvdimm before passed on to papr_scm. Important
+ * member fields used are:
+ * 'nd_family'		: (In) NVDIMM_FAMILY_PAPR_SCM
+ * 'nd_size_in'		: (In) PDSM-HEADER + PDSM-IN-PAYLOAD (usually 0)
+ * 'nd_size_out'        : (In) PDSM-HEADER + PDSM-RETURN-PAYLOAD
+ * 'nd_command'         : (In) One of PAPR_PDSM_XXX
+ * 'nd_fw_size'         : (Out) PDSM-HEADER + size of actual payload returned
+ *
+ * PDSM Header:
+ * This is papr-scm specific header that precedes the payload. This is defined
+ * as nd_cmd_pdsm_pkg.  Following fields aare available in this header:
+ *
+ * 'cmd_status'		: (Out) Errors if any encountered while servicing PDSM.
+ * 'reserved'		: Not used, reserved for future and should be set to 0.
+ * 'payload'            : A union of all the possible payload structs
+ *
+ * PDSM Payload:
+ *
+ * The layout of the PDSM Payload is defined by various structs shared between
+ * papr_scm and libndctl so that contents of payload can be interpreted. As such
+ * its defined as a union of all possible payload structs as
+ * 'union nd_pdsm_payload'. Based on the value of 'nd_cmd_pkg.nd_command'
+ * appropriate member of the union is accessed.
+ */
+
+/* Max payload size that we can handle */
+#define ND_PDSM_PAYLOAD_MAX_SIZE 184
+
+/* Max payload size that we can handle */
+#define ND_PDSM_HDR_SIZE \
+	(sizeof(struct nd_pkg_pdsm) - ND_PDSM_PAYLOAD_MAX_SIZE)
+
+/* Various nvdimm health indicators */
+#define PAPR_PDSM_DIMM_HEALTHY       0
+#define PAPR_PDSM_DIMM_UNHEALTHY     1
+#define PAPR_PDSM_DIMM_CRITICAL      2
+#define PAPR_PDSM_DIMM_FATAL         3
+
+/*
+ * Struct exchanged between kernel & ndctl in for PAPR_PDSM_HEALTH
+ * Various flags indicate the health status of the dimm.
+ *
+ * extension_flags	: Any extension fields present in the struct.
+ * dimm_unarmed		: Dimm not armed. So contents wont persist.
+ * dimm_bad_shutdown	: Previous shutdown did not persist contents.
+ * dimm_bad_restore	: Contents from previous shutdown werent restored.
+ * dimm_scrubbed	: Contents of the dimm have been scrubbed.
+ * dimm_locked		: Contents of the dimm cant be modified until CEC reboot
+ * dimm_encrypted	: Contents of dimm are encrypted.
+ * dimm_health		: Dimm health indicator. One of PAPR_PDSM_DIMM_XXXX
+ */
+struct nd_papr_pdsm_health {
+	union {
+		struct {
+			__u32 extension_flags;
+			__u8 dimm_unarmed;
+			__u8 dimm_bad_shutdown;
+			__u8 dimm_bad_restore;
+			__u8 dimm_scrubbed;
+			__u8 dimm_locked;
+			__u8 dimm_encrypted;
+			__u16 dimm_health;
+		};
+		__u8 buf[ND_PDSM_PAYLOAD_MAX_SIZE];
+	};
+};
+
+/*
+ * Methods to be embedded in ND_CMD_CALL request. These are sent to the kernel
+ * via 'nd_cmd_pkg.nd_command' member of the ioctl struct
+ */
+enum papr_pdsm {
+	PAPR_PDSM_MIN = 0x0,
+	PAPR_PDSM_HEALTH,
+	PAPR_PDSM_MAX,
+};
+
+/* Maximal union that can hold all possible payload types */
+union nd_pdsm_payload {
+	struct nd_papr_pdsm_health health;
+	__u8 buf[ND_PDSM_PAYLOAD_MAX_SIZE];
+} __attribute__((packed));
+
+/*
+ * PDSM-header + payload expected with ND_CMD_CALL ioctl from libnvdimm
+ * Valid member of union 'payload' is identified via 'nd_cmd_pkg.nd_command'
+ * that should always precede this struct when sent to papr_scm via CMD_CALL
+ * interface.
+ */
+struct nd_pkg_pdsm {
+	__s32 cmd_status;	/* Out: Sub-cmd status returned back */
+	__u16 reserved[2];	/* Ignored and to be set as '0' */
+	union nd_pdsm_payload payload;
+} __attribute__((packed));
+
+#endif /* _UAPI_ASM_POWERPC_PAPR_PDSM_H_ */
diff --git a/ndctl/lib/private.h b/ndctl/lib/private.h
index d90236b1f98b..c3d5fd7ac9a9 100644
--- a/ndctl/lib/private.h
+++ b/ndctl/lib/private.h
@@ -32,6 +32,7 @@
 #include "hpe1.h"
 #include "msft.h"
 #include "hyperv.h"
+#include "papr.h"
 #include "libndctl-nfit.h"
 
 struct nvdimm_data {
@@ -277,6 +278,7 @@ struct ndctl_cmd {
 		struct ndn_pkg_msft msft[0];
 		struct nd_pkg_hyperv hyperv[0];
 		struct nd_pkg_intel intel[0];
+		struct nd_pkg_papr papr[0];
 		struct nd_cmd_get_config_size get_size[0];
 		struct nd_cmd_get_config_data_hdr get_data[0];
 		struct nd_cmd_set_config_hdr set_data[0];
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

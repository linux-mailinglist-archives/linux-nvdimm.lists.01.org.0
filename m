Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1705F1E3782
	for <lists+linux-nvdimm@lfdr.de>; Wed, 27 May 2020 06:48:53 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 086451225F268;
	Tue, 26 May 2020 21:44:43 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E609A1225F266
	for <linux-nvdimm@lists.01.org>; Tue, 26 May 2020 21:44:40 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04R4VP7q039179;
	Wed, 27 May 2020 00:48:47 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 319etmuqf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2020 00:48:47 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04R4lHEi090254;
	Wed, 27 May 2020 00:48:46 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 319etmuqee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2020 00:48:46 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
	by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04R4khA8029052;
	Wed, 27 May 2020 04:48:44 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by ppma03fra.de.ibm.com with ESMTP id 316uf82vtc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2020 04:48:44 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04R4mfDX54526154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2020 04:48:41 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA07A42042;
	Wed, 27 May 2020 04:48:41 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBABF42041;
	Wed, 27 May 2020 04:48:36 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.121.50])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Wed, 27 May 2020 04:48:36 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Wed, 27 May 2020 10:18:34 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH v4 4/6] libndctl,papr_scm: Add definitions for PAPR nvdimm specific methods
Date: Wed, 27 May 2020 10:17:35 +0530
Message-Id: <20200527044737.40615-5-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527044737.40615-1-vaibhav@linux.ibm.com>
References: <20200527044737.40615-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-26_04:2020-05-26,2020-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 cotscore=-2147483648 impostorscore=0 spamscore=0
 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005270028
Message-ID-Hash: ZW6HD2UAVTVSKMCR7E7CEI5Z3GFRUPCA
X-Message-ID-Hash: ZW6HD2UAVTVSKMCR7E7CEI5Z3GFRUPCA
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZW6HD2UAVTVSKMCR7E7CEI5Z3GFRUPCA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Pull the kernel definition of PAPR_SCM DSM command which is located in
the proposed kernel tree patches at Ref[1] & [2].

Also add instance of 'struct nd_pdsm_cmd_pkg' to 'struct ndctl_cmd'
named as 'papr'.

References:
[1] "powerpc/papr_scm: Add support for reporting nvdimm health"
https://lore.kernel.org/linux-nvdimm/20200527041244.37821-1-vaibhav@linux.ibm.com

[2] "ndctl/papr_scm,uapi: Add support for PAPR nvdimm specific methods"
https://lore.kernel.org/linux-nvdimm/20200527041244.37821-5-vaibhav@linux.ibm.com/

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
Changelog:

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
 ndctl/lib/papr_scm.c      |   1 +
 ndctl/lib/papr_scm_pdsm.h | 175 ++++++++++++++++++++++++++++++++++++++
 ndctl/lib/private.h       |   2 +
 3 files changed, 178 insertions(+)
 create mode 100644 ndctl/lib/papr_scm_pdsm.h

diff --git a/ndctl/lib/papr_scm.c b/ndctl/lib/papr_scm.c
index 14ff8879f627..57ae943c0260 100644
--- a/ndctl/lib/papr_scm.c
+++ b/ndctl/lib/papr_scm.c
@@ -17,6 +17,7 @@
 #include <ndctl.h>
 #include <ndctl/libndctl.h>
 #include <lib/private.h>
+#include <papr_scm_pdsm.h>
 
 static bool papr_cmd_is_supported(struct ndctl_dimm *dimm, int cmd)
 {
diff --git a/ndctl/lib/papr_scm_pdsm.h b/ndctl/lib/papr_scm_pdsm.h
new file mode 100644
index 000000000000..5d8947fb71c5
--- /dev/null
+++ b/ndctl/lib/papr_scm_pdsm.h
@@ -0,0 +1,175 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/*
+ * PAPR-SCM Dimm specific methods (PDSM) and structs for libndctl
+ *
+ * (C) Copyright IBM 2020
+ *
+ * Author: Vaibhav Jain <vaibhav at linux.ibm.com>
+ */
+
+#ifndef _UAPI_ASM_POWERPC_PAPR_SCM_PDSM_H_
+#define _UAPI_ASM_POWERPC_PAPR_SCM_PDSM_H_
+
+#include <linux/types.h>
+
+/*
+ * PDSM Envelope:
+ *
+ * The ioctl ND_CMD_CALL transfers data between user-space and kernel via
+ * envelope which consists of a header and user-defined payload sections.
+ * The header is described by 'struct nd_pdsm_cmd_pkg' which expects a
+ * payload following it and accessible via 'nd_pdsm_cmd_pkg.payload' field.
+ * There is reserved field that can used to introduce new fields to the
+ * structure in future. It also tries to ensure that 'nd_pdsm_cmd_pkg.payload'
+ * lies at a 8-byte boundary.
+ *
+ *  +-------------+---------------------+---------------------------+
+ *  |   64-Bytes  |       16-Bytes      |       Max 176-Bytes       |
+ *  +-------------+---------------------+---------------------------+
+ *  |               nd_pdsm_cmd_pkg     |                           |
+ *  |-------------+                     |                           |
+ *  |  nd_cmd_pkg |                     |                           |
+ *  +-------------+---------------------+---------------------------+
+ *  | nd_family   |                     |                           |
+ *  | nd_size_out | cmd_status          |                           |
+ *  | nd_size_in  | payload_version     |     payload               |
+ *  | nd_command  | reserved            |                           |
+ *  | nd_fw_size  |                     |                           |
+ *  +-------------+---------------------+---------------------------+
+ *
+ * PDSM Header:
+ *
+ * The header is defined as 'struct nd_pdsm_cmd_pkg' which embeds a
+ * 'struct nd_cmd_pkg' instance. The PDSM command is assigned to member
+ * 'nd_cmd_pkg.nd_command'. Apart from size information of the envelope which is
+ * contained in 'struct nd_cmd_pkg', the header also has members following
+ * members:
+ *
+ * 'cmd_status'		: (Out) Errors if any encountered while servicing PDSM.
+ * 'payload_version'	: (In/Out) Version number associated with the payload.
+ * 'reserved'		: Not used and reserved for future.
+ *
+ * PDSM Payload:
+ *
+ * The layout of the PDSM Payload is defined by various structs shared between
+ * papr_scm and libndctl so that contents of payload can be interpreted. During
+ * servicing of a PDSM the papr_scm module will read input args from the payload
+ * field by casting its contents to an appropriate struct pointer based on the
+ * PDSM command. Similarly the output of servicing the PDSM command will be
+ * copied to the payload field using the same struct.
+ *
+ * 'libnvdimm' enforces a hard limit of 256 bytes on the envelope size, which
+ * leaves around 176 bytes for the envelope payload (ignoring any padding that
+ * the compiler may silently introduce).
+ *
+ * Payload Version:
+ *
+ * A 'payload_version' field is present in PDSM header that indicates a specific
+ * version of the structure present in PDSM Payload for a given PDSM command.
+ * This provides backward compatibility in case the PDSM Payload structure
+ * evolves and different structures are supported by 'papr_scm' and 'libndctl'.
+ *
+ * When sending a PDSM Payload to 'papr_scm', 'libndctl' should send the version
+ * of the payload struct it supports via 'payload_version' field. The 'papr_scm'
+ * module when servicing the PDSM envelope checks the 'payload_version' and then
+ * uses 'payload struct version' == MIN('payload_version field',
+ * 'max payload-struct-version supported by papr_scm') to service the PDSM.
+ * After servicing the PDSM, 'papr_scm' put the negotiated version of payload
+ * struct in returned 'payload_version' field.
+ *
+ * Libndctl on receiving the envelope back from papr_scm again checks the
+ * 'payload_version' field and based on it use the appropriate version dsm
+ * struct to parse the results.
+ *
+ * Backward Compatibility:
+ *
+ * Above scheme of exchanging different versioned PDSM struct between libndctl
+ * and papr_scm should provide backward compatibility until following two
+ * assumptions/conditions when defining new PDSM structs hold:
+ *
+ * Let T(X) = { set of attributes in PDSM struct 'T' versioned X }
+ *
+ * 1. T(X) is a proper subset of T(Y) if Y > X.
+ *    i.e Each new version of PDSM struct should retain existing struct
+ *    attributes from previous version
+ *
+ * 2. If an entity (libndctl or papr_scm) supports a PDSM struct T(X) then
+ *    it should also support T(1), T(2)...T(X - 1).
+ *    i.e When adding support for new version of a PDSM struct, libndctl
+ *    and papr_scm should retain support of the existing PDSM struct
+ *    version they support.
+ */
+
+/* Papr-scm-header + payload expected with ND_CMD_CALL ioctl from libnvdimm */
+struct nd_pdsm_cmd_pkg {
+	struct nd_cmd_pkg hdr;	/* Package header containing sub-cmd */
+	__s32 cmd_status;	/* Out: Sub-cmd status returned back */
+	__u16 reserved[5];	/* Ignored and to be used in future */
+	__u16 payload_version;	/* In/Out: version of the payload */
+	__u8 payload[];		/* In/Out: Sub-cmd data buffer */
+} __attribute__((packed));
+
+/*
+ * Methods to be embedded in ND_CMD_CALL request. These are sent to the kernel
+ * via 'nd_pdsm_cmd_pkg.hdr.nd_command' member of the ioctl struct
+ */
+enum papr_scm_pdsm {
+	PAPR_SCM_PDSM_MIN = 0x0,
+	PAPR_SCM_PDSM_HEALTH,
+	PAPR_SCM_PDSM_MAX,
+};
+
+/* Convert a libnvdimm nd_cmd_pkg to pdsm specific pkg */
+static inline struct nd_pdsm_cmd_pkg *nd_to_pdsm_cmd_pkg(struct nd_cmd_pkg *cmd)
+{
+	return (struct nd_pdsm_cmd_pkg *) cmd;
+}
+
+/* Return the payload pointer for a given pcmd */
+static inline void *pdsm_cmd_to_payload(struct nd_pdsm_cmd_pkg *pcmd)
+{
+	if (pcmd->hdr.nd_size_in == 0 && pcmd->hdr.nd_size_out == 0)
+		return NULL;
+	else
+		return (void *)(pcmd->payload);
+}
+
+/* Various scm-dimm health indicators */
+#define PAPR_PDSM_DIMM_HEALTHY       0
+#define PAPR_PDSM_DIMM_UNHEALTHY     1
+#define PAPR_PDSM_DIMM_CRITICAL      2
+#define PAPR_PDSM_DIMM_FATAL         3
+
+/*
+ * Struct exchanged between kernel & ndctl in for PAPR_SCM_PDSM_HEALTH
+ * Various flags indicate the health status of the dimm.
+ *
+ * dimm_unarmed		: Dimm not armed. So contents wont persist.
+ * dimm_bad_shutdown	: Previous shutdown did not persist contents.
+ * dimm_bad_restore	: Contents from previous shutdown werent restored.
+ * dimm_scrubbed	: Contents of the dimm have been scrubbed.
+ * dimm_locked		: Contents of the dimm cant be modified until CEC reboot
+ * dimm_encrypted	: Contents of dimm are encrypted.
+ * dimm_health		: Dimm health indicator. One of PAPR_PDSM_DIMM_XXXX
+ */
+struct nd_papr_pdsm_health_v1 {
+	__u8 dimm_unarmed;
+	__u8 dimm_bad_shutdown;
+	__u8 dimm_bad_restore;
+	__u8 dimm_scrubbed;
+	__u8 dimm_locked;
+	__u8 dimm_encrypted;
+	__u16 dimm_health;
+} __attribute__((packed));
+
+/*
+ * Typedef the current struct for dimm_health so that any application
+ * or kernel recompiled after introducing a new version automatically
+ * supports the new version.
+ */
+#define nd_papr_pdsm_health nd_papr_pdsm_health_v1
+
+/* Current version number for the dimm health struct */
+#define ND_PAPR_PDSM_HEALTH_VERSION 1
+
+#endif /* _UAPI_ASM_POWERPC_PAPR_SCM_PDSM_H_ */
diff --git a/ndctl/lib/private.h b/ndctl/lib/private.h
index 679e359a1070..37c45088059a 100644
--- a/ndctl/lib/private.h
+++ b/ndctl/lib/private.h
@@ -32,6 +32,7 @@
 #include "hpe1.h"
 #include "msft.h"
 #include "hyperv.h"
+#include "papr_scm_pdsm.h"
 #include "libndctl-nfit.h"
 
 struct nvdimm_data {
@@ -278,6 +279,7 @@ struct ndctl_cmd {
 		struct ndn_pkg_msft msft[0];
 		struct nd_pkg_hyperv hyperv[0];
 		struct nd_pkg_intel intel[0];
+		struct nd_pdsm_cmd_pkg papr[0];
 		struct nd_cmd_get_config_size get_size[0];
 		struct nd_cmd_get_config_data_hdr get_data[0];
 		struct nd_cmd_set_config_hdr set_data[0];
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A561FA844
	for <lists+linux-nvdimm@lfdr.de>; Tue, 16 Jun 2020 07:31:10 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7F2E2111661B8;
	Mon, 15 Jun 2020 22:31:09 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0D9E2111661B4
	for <linux-nvdimm@lists.01.org>; Mon, 15 Jun 2020 22:31:06 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05G53paB188104;
	Tue, 16 Jun 2020 01:31:04 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 31mtxfhsdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2020 01:31:03 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05G5Il1h033765;
	Tue, 16 Jun 2020 01:31:03 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 31mtxfhsd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2020 01:31:03 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
	by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05G5PK01008203;
	Tue, 16 Jun 2020 05:31:01 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by ppma05fra.de.ibm.com with ESMTP id 31mpe81wak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2020 05:31:01 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05G5Uwoq57737276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2020 05:30:58 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D479A405B;
	Tue, 16 Jun 2020 05:30:58 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B6D7A4051;
	Tue, 16 Jun 2020 05:30:55 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.199.40.156])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Tue, 16 Jun 2020 05:30:55 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Tue, 16 Jun 2020 11:00:54 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH v6 4/5] papr: Add scaffolding to issue and handle PDSM requests
Date: Tue, 16 Jun 2020 11:00:28 +0530
Message-Id: <20200616053029.84731-5-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200616053029.84731-1-vaibhav@linux.ibm.com>
References: <20200616053029.84731-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-15_11:2020-06-15,2020-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=1
 phishscore=0 lowpriorityscore=0 mlxscore=0 cotscore=-2147483648
 bulkscore=0 adultscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006160035
Message-ID-Hash: S2MANMPQ7PWPW7VO6LIQUPLWUW45OCYY
X-Message-ID-Hash: S2MANMPQ7PWPW7VO6LIQUPLWUW45OCYY
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/S2MANMPQ7PWPW7VO6LIQUPLWUW45OCYY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch implement necessary infrastructure inside 'papr.c' to
issue and handle PDSM requests. Changes implemented are:

* New helper function allocate_cmd() to allocate command packages for
  a specific PDSM command and payload size.

* Provide a skeleton implementation of 'dimm_ops->smart_get_flags' to
  check the submitted command for any errors. Presently no flags are
  returned from this callback and future patch will update this
  callback function to check submitted ndctl_cmd instance and return
  appropriate flags.

* cmd_is_valid() to validate submitted 'struct ndctl_cmd' instance for
  correct command family and PDSM command id.

* Implement callbacks for 'dimm_ops->get_firmware_status' and
  'dimm_ops->get_xlat_firmware_status' to return translated firmware
  command status from 'struct ndctl_cmd'.

* Logging helpers for papr_scm that use the underlying libndctl
  provided logging.

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
Changelog:
v5..v6:
* Reworked the patch based on recent changes introduced for layout
  changes to  'struct nd_cmd_pkg'.
* Removed function update_dimm_stats() and papr_dimm_init/uninit() as
  they depended on an now a defunct patch "libndctl: Introduce new
  dimm-ops dimm_init() & dimm_uninit()"
* Introduced various helper macros to_pdsm(), to_ndcmd(), to_payload()
  and to_pdsm_cmd().

v4..v5:
* Updated papr_dbg/err macros to remove the 'scm' suffix.
* s/NVDIMM_FAMILY_PAPR_SCM/NVDIMM_FAMILY_PAPR/g
* s/PAPR_SCM_PDSM_*/PAPR_PDSM_*/g
* Minor changes to various comments and patch-description to remove
  usage of term 'scm'.

v3..v4:
* Remove the initialization of 'nd_pdsm_cmd_pkg.payload_offset' field
  from allocate_cmd(). [ Aneesh ]

v2..v3:
* None

v1..v2:
* Added new dimm callback 'papr_get_firmware_status'
* Switched to new papr_scm interface as described by papr_scm_dsm.h
* Changed the case of logging functions [ Santosh Sivaraj ]
* Removed redundant logging functions.
* Minor updates to patch description to s/DSM/PDSM/
---
 ndctl/lib/papr.c | 124 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/ndctl/lib/papr.c b/ndctl/lib/papr.c
index 37b4c4c78709..aff294823e41 100644
--- a/ndctl/lib/papr.c
+++ b/ndctl/lib/papr.c
@@ -9,6 +9,29 @@
 #include <lib/private.h>
 #include "papr.h"
 
+/* Utility logging maros for simplify logging */
+#define papr_dbg(_dimm, _format_str, ...) dbg(_dimm->bus->ctx,		\
+					      "%s:" _format_str,	\
+					      ndctl_dimm_get_devname(_dimm), \
+					      ##__VA_ARGS__)
+
+#define papr_err(_dimm, _format_str, ...) err(_dimm->bus->ctx,		\
+					      "%s:" _format_str,	\
+					      ndctl_dimm_get_devname(_dimm), \
+					      ##__VA_ARGS__)
+
+/* Convert a ndctl_cmd to pdsm package */
+#define to_pdsm(C)  (&(C)->papr[0].pdsm)
+
+/* Convert a ndctl_cmd to nd_cmd_pkg */
+#define to_ndcmd(C)  (&(C)->papr[0].gen)
+
+/* Return payload from a ndctl_cmd */
+#define to_payload(C) (&(C)->papr[0].pdsm.payload)
+
+/* return the pdsm command */
+#define to_pdsm_cmd(C) ((enum papr_pdsm)to_ndcmd(C)->nd_command)
+
 static bool papr_cmd_is_supported(struct ndctl_dimm *dimm, int cmd)
 {
 	/* Handle this separately to support monitor mode */
@@ -18,6 +41,107 @@ static bool papr_cmd_is_supported(struct ndctl_dimm *dimm, int cmd)
 	return !!(dimm->cmd_mask & (1ULL << cmd));
 }
 
+static u32 papr_get_firmware_status(struct ndctl_cmd *cmd)
+{
+	const struct nd_pkg_pdsm *pcmd = to_pdsm(cmd);
+
+	return (u32) pcmd->cmd_status;
+}
+
+static int papr_xlat_firmware_status(struct ndctl_cmd *cmd)
+{
+	const struct nd_pkg_pdsm *pcmd = to_pdsm(cmd);
+
+	return pcmd->cmd_status;
+}
+
+/* Verify if the given command is supported and valid */
+static bool cmd_is_valid(struct ndctl_cmd *cmd)
+{
+	const struct nd_cmd_pkg  *ncmd = NULL;
+
+	if (cmd == NULL)
+		return false;
+
+	ncmd = to_ndcmd(cmd);
+
+	/* Verify the command family */
+	if (ncmd->nd_family != NVDIMM_FAMILY_PAPR) {
+		papr_err(cmd->dimm, "Invalid command family:0x%016llx\n",
+			 ncmd->nd_family);
+		return false;
+	}
+
+	/* Verify the PDSM */
+	if (ncmd->nd_command <= PAPR_PDSM_MIN ||
+	    ncmd->nd_command >= PAPR_PDSM_MAX) {
+		papr_err(cmd->dimm, "Invalid command :0x%016llx\n",
+			 ncmd->nd_command);
+		return false;
+	}
+
+	return true;
+}
+
+/* Allocate a struct ndctl_cmd for given pdsm request with payload size */
+static struct ndctl_cmd *allocate_cmd(struct ndctl_dimm *dimm,
+				      enum papr_pdsm pdsm_cmd,
+				      size_t payload_size)
+{
+	struct ndctl_cmd *cmd;
+
+	/* Verify that payload size is within acceptable range */
+	if (payload_size > ND_PDSM_PAYLOAD_MAX_SIZE) {
+		papr_err(dimm, "Requested payload size too large %lu bytes\n",
+			 payload_size);
+		return NULL;
+	}
+
+	cmd = calloc(1, sizeof(struct ndctl_cmd) + sizeof(struct nd_pkg_papr));
+	if (!cmd)
+		return NULL;
+
+	ndctl_cmd_ref(cmd);
+	cmd->dimm = dimm;
+	cmd->type = ND_CMD_CALL;
+	cmd->status = 0;
+	cmd->get_firmware_status = &papr_get_firmware_status;
+
+	/* Populate the nd_cmd_pkg contained in nd_pkg_pdsm */
+	*to_ndcmd(cmd) =  (struct nd_cmd_pkg) {
+		.nd_family = NVDIMM_FAMILY_PAPR,
+		.nd_command = pdsm_cmd,
+		.nd_size_in = 0,
+		.nd_size_out = ND_PDSM_HDR_SIZE + payload_size,
+		.nd_fw_size = 0,
+	};
+	return cmd;
+}
+
+/* Validate the ndctl_cmd and return applicable flags */
+static unsigned int papr_smart_get_flags(struct ndctl_cmd *cmd)
+{
+	struct nd_pkg_pdsm *pcmd;
+
+	if (!cmd_is_valid(cmd))
+		return 0;
+
+	pcmd = to_pdsm(cmd);
+	/* If error reported then return empty flags */
+	if (pcmd->cmd_status) {
+		papr_err(cmd->dimm, "PDSM(0x%x) reported error:%d\n",
+			 to_pdsm_cmd(cmd), pcmd->cmd_status);
+		return 0;
+	}
+
+	/* return empty flags for now */
+	return 0;
+}
+
+
 struct ndctl_dimm_ops * const papr_dimm_ops = &(struct ndctl_dimm_ops) {
 	.cmd_is_supported = papr_cmd_is_supported,
+	.smart_get_flags = papr_smart_get_flags,
+	.get_firmware_status =  papr_get_firmware_status,
+	.xlat_firmware_status = papr_xlat_firmware_status,
 };
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

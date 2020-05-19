Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF781DA04C
	for <lists+linux-nvdimm@lfdr.de>; Tue, 19 May 2020 21:02:24 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EF47111E48A2D;
	Tue, 19 May 2020 11:59:03 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6D6E111E48A38
	for <linux-nvdimm@lists.01.org>; Tue, 19 May 2020 11:59:01 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04JI4XbT112812;
	Tue, 19 May 2020 15:02:19 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 313x639kad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2020 15:02:19 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04JJ2HQX137643;
	Tue, 19 May 2020 15:02:18 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 313x639k99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2020 15:02:18 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04JJ0QWg012442;
	Tue, 19 May 2020 19:02:15 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
	by ppma03ams.nl.ibm.com with ESMTP id 313xas26rs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2020 19:02:15 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04JJ10qL54133192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2020 19:01:00 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0F20AE051;
	Tue, 19 May 2020 19:02:12 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09A65AE057;
	Tue, 19 May 2020 19:02:10 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.89.230])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Tue, 19 May 2020 19:02:09 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Wed, 20 May 2020 00:32:09 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH v3 5/6] libndctl,papr_scm: Add scaffolding to issue and handle PDSM requests
Date: Wed, 20 May 2020 00:31:46 +0530
Message-Id: <20200519190147.258142-6-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519190147.258142-1-vaibhav@linux.ibm.com>
References: <20200519190147.258142-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-19_07:2020-05-19,2020-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=3 cotscore=-2147483648 malwarescore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005190153
Message-ID-Hash: FMPWBVMMW7HGLHMFHTKUEZ4OBUC7BSCJ
X-Message-ID-Hash: FMPWBVMMW7HGLHMFHTKUEZ4OBUC7BSCJ
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FMPWBVMMW7HGLHMFHTKUEZ4OBUC7BSCJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch implement necessary infrastructure inside 'papr_scm.c' to
issue and handle PDSM requests. Changes implemented are:

* Implement dimm initialization/un-initialization functions
  papr_dimm_init()/unint() to allocate a per-dimm 'struct dimm_priv'
  instance.

* New helper function allocate_cmd() to allocate command packages for
  a specific PDSM command and payload size.

* New function update_dimm_state() to parse a given command payload
  and update per dimm 'struct dimm_priv'.

* Provide an implementation of 'dimm_ops->smart_get_flags' to send the
  submitted instance of 'struct ndctl_cmd' to update_dimm_state().

* Logging helpers for papr_scm that use the underlying libndctl
  provided logging.

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
Changelog:

v2..v3:
* None

v1..v2:
* Added new dimm callback 'papr_get_firmware_status'
* Switched to new papr_scm interface as described by papr_scm_dsm.h
* Changed the case of logging functions [ Santosh Sivaraj ]
* Removed redundant logging functions.
* Minor updates to patch description to s/DSM/PDSM/
---
 ndctl/lib/papr_scm.c | 185 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 185 insertions(+)

diff --git a/ndctl/lib/papr_scm.c b/ndctl/lib/papr_scm.c
index 57ae943c0260..78d88e84efd8 100644
--- a/ndctl/lib/papr_scm.c
+++ b/ndctl/lib/papr_scm.c
@@ -19,6 +19,32 @@
 #include <lib/private.h>
 #include <papr_scm_pdsm.h>
 
+/* Utility logging maros for simplify logging */
+#define papr_dbg(_dimm_, _format_str_, ...) dbg(_dimm_->bus->ctx,	\
+					      "papr_scm:"#_format_str_,	\
+					      ##__VA_ARGS__)
+#define papr_err(_dimm_, _format_str_, ...) err(_dimm_->bus->ctx,	\
+					      "papr_scm:"#_format_str_,	\
+					      ##__VA_ARGS__)
+
+/* Helpers to evaluate the size of PDSM envelope */
+/* Calculate the papr_scm-header size */
+#define ND_PDSM_ENVELOPE_CONTENT_HDR_SIZE \
+	(sizeof(struct nd_pdsm_cmd_pkg) - sizeof(struct nd_cmd_pkg))
+
+/* Given a type calculate envelope-content size (papr_scm-header + payload) */
+#define ND_PDSM_ENVELOPE_CONTENT_SIZE(_type_)	\
+	(sizeof(_type_) + ND_PDSM_ENVELOPE_CONTENT_HDR_SIZE)
+
+/* Command flags to indicate if a given command is parsed of not */
+#define CMD_PKG_SUBMITTED 1
+#define CMD_PKG_PARSED 2
+
+/* Per dimm data. Holds per-dimm data parsed from the cmd_pkgs */
+struct dimm_priv {
+	/* Empty for now */
+};
+
 static bool papr_cmd_is_supported(struct ndctl_dimm *dimm, int cmd)
 {
 	/* Handle this separately to support monitor mode */
@@ -28,6 +54,165 @@ static bool papr_cmd_is_supported(struct ndctl_dimm *dimm, int cmd)
 	return !!(dimm->cmd_mask & (1ULL << cmd));
 }
 
+static __u64 pcmd_to_pdsm(const struct nd_pdsm_cmd_pkg *pcmd)
+{
+	return pcmd->hdr.nd_command;
+}
+
+static u32 papr_get_firmware_status(struct ndctl_cmd *cmd)
+{
+	const struct nd_pdsm_cmd_pkg *pcmd = nd_to_pdsm_cmd_pkg(cmd->pkg);
+
+	return (u32) pcmd->cmd_status;
+}
+
+/* Verify if the given command is supported and valid */
+static bool cmd_is_valid(struct ndctl_dimm *dimm, struct ndctl_cmd *cmd)
+{
+	const struct nd_pdsm_cmd_pkg *pcmd = nd_to_pdsm_cmd_pkg(cmd->pkg);
+
+	if (dimm == NULL)
+		return false;
+
+	if (cmd == NULL) {
+		papr_err(dimm, "Invalid command\n");
+		return false;
+	}
+
+	/* Verify the command family */
+	if (pcmd->hdr.nd_family != NVDIMM_FAMILY_PAPR_SCM) {
+		papr_err(dimm, "Invalid command family:0x%016llx\n",
+			 pcmd->hdr.nd_family);
+		return false;
+	}
+
+	/* Verify the PDSM */
+	if (pcmd_to_pdsm(pcmd) <= PAPR_SCM_PDSM_MIN ||
+	    pcmd_to_pdsm(pcmd) >= PAPR_SCM_PDSM_MAX) {
+		papr_err(dimm, "Invalid command :0x%016llx\n",
+			 pcmd->hdr.nd_command);
+		return false;
+	}
+
+	return true;
+}
+
+/* Parse a command payload and update dimm flags/private data */
+static int update_dimm_stats(struct ndctl_dimm *dimm, struct ndctl_cmd *cmd)
+{
+	const struct nd_pdsm_cmd_pkg *pcmd;
+
+	if (!cmd_is_valid(dimm, cmd))
+		return -EINVAL;
+
+	/*
+	 * Silently prevent parsing of an already parsed ndctl_cmd else
+	 * mark the command as parsed.
+	 */
+	if (cmd->status >= CMD_PKG_PARSED) {
+		return 0;
+	} else if (cmd->status < 0) {
+		papr_err(dimm, "Command error %d\n", cmd->status);
+		return -ENXIO;
+	}
+
+	/* Mark the command as parsed */
+	cmd->status = CMD_PKG_PARSED;
+
+	/* Get the pdsm request and handle it */
+	pcmd = nd_to_pdsm_cmd_pkg(cmd->pkg);
+	switch (pcmd_to_pdsm(pcmd)) {
+	default:
+		papr_err(dimm, "Unhandled pdsm-request 0x%016llx\n",
+			 pcmd_to_pdsm(pcmd));
+		return -ENOENT;
+	}
+}
+
+/* Allocate a struct ndctl_cmd for given pdsm request with payload size */
+static struct ndctl_cmd *allocate_cmd(struct ndctl_dimm *dimm,
+				      __u64 pdsm_cmd, size_t payload_size,
+				      uint16_t payload_version)
+{
+	struct ndctl_cmd *cmd;
+	struct nd_pdsm_cmd_pkg *pcmd;
+	size_t size;
+
+	size = sizeof(struct ndctl_cmd) +
+		sizeof(struct nd_pdsm_cmd_pkg) + payload_size;
+	cmd = calloc(1, size);
+	if (!cmd)
+		return NULL;
+	pcmd = nd_to_pdsm_cmd_pkg(cmd->pkg);
+
+	ndctl_cmd_ref(cmd);
+	cmd->dimm = dimm;
+	cmd->type = ND_CMD_CALL;
+	cmd->size = size;
+	cmd->status = CMD_PKG_SUBMITTED;
+	cmd->get_firmware_status = &papr_get_firmware_status;
+
+	/* Populate the nd_cmd_pkg contained in nd_pdsm_cmd_pkg */
+	pcmd->hdr.nd_family = NVDIMM_FAMILY_PAPR_SCM;
+	pcmd->hdr.nd_command = pdsm_cmd;
+
+	pcmd->payload_version = payload_version;
+	pcmd->payload_offset = sizeof(struct nd_pdsm_cmd_pkg);
+
+	/* Keep payload size empty. To be populated by called */
+	pcmd->hdr.nd_fw_size = 0;
+	pcmd->hdr.nd_size_out = 0;
+	pcmd->hdr.nd_size_in = 0;
+
+	return cmd;
+}
+
+static unsigned int papr_smart_get_flags(struct ndctl_cmd *cmd)
+{
+	/* In case of error return empty flags * */
+	if (update_dimm_stats(cmd->dimm, cmd))
+		return 0;
+
+	/* Return empty flags for now as no DSM support */
+	return 0;
+}
+
+static int papr_dimm_init(struct ndctl_dimm *dimm)
+{
+	struct dimm_priv *p;
+
+	if (dimm->dimm_user_data) {
+		papr_dbg(dimm, "Dimm already initialized !!\n");
+		return 0;
+	}
+
+	p = calloc(1, sizeof(struct dimm_priv));
+	if (!p) {
+		papr_err(dimm, "Unable to allocate memory for dimm-private\n");
+		return -1;
+	}
+
+	dimm->dimm_user_data = p;
+	return 0;
+}
+
+static void papr_dimm_uninit(struct ndctl_dimm *dimm)
+{
+	struct dimm_priv *p = dimm->dimm_user_data;
+
+	if (!p) {
+		papr_dbg(dimm, "Dimm already un-initialized !!\n");
+		return;
+	}
+
+	dimm->dimm_user_data = NULL;
+	free(p);
+}
+
 struct ndctl_dimm_ops * const papr_scm_dimm_ops = &(struct ndctl_dimm_ops) {
 	.cmd_is_supported = papr_cmd_is_supported,
+	.dimm_init = papr_dimm_init,
+	.dimm_uninit = papr_dimm_uninit,
+	.smart_get_flags = papr_smart_get_flags,
+	.get_firmware_status =  papr_get_firmware_status,
 };
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

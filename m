Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FC8165C28
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Feb 2020 11:52:27 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9443610FC35BB;
	Thu, 20 Feb 2020 02:53:18 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B4AC610097E1D
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 02:51:06 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01KAnMFT087334
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 05:50:13 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ucmxmsa-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 05:50:13 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <vaibhav@linux.ibm.com>;
	Thu, 20 Feb 2020 10:50:08 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
	by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 20 Feb 2020 10:50:06 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01KAo5hF39518394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2020 10:50:05 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53029A4040;
	Thu, 20 Feb 2020 10:50:05 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3653A4053;
	Thu, 20 Feb 2020 10:50:02 +0000 (GMT)
Received: from vajain21.in.ibm.com.com (unknown [9.199.53.128])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu, 20 Feb 2020 10:50:02 +0000 (GMT)
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH 6/8] libndctl,papr_scm: Implement scaffolding to issue and handle DSM cmds
Date: Thu, 20 Feb 2020 16:19:26 +0530
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220104928.198625-1-vaibhav@linux.ibm.com>
References: <20200220104928.198625-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20022010-0028-0000-0000-000003DCB79B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022010-0029-0000-0000-000024A1C737
Message-Id: <20200220104928.198625-7-vaibhav@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_03:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 suspectscore=3 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200079
Message-ID-Hash: 3ERGACHWZQBYCOFZBU7POOMSW5HUDLSU
X-Message-ID-Hash: 3ERGACHWZQBYCOFZBU7POOMSW5HUDLSU
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Alastair D'Silva <alastair@au1.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3ERGACHWZQBYCOFZBU7POOMSW5HUDLSU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch implement necessary infrastructure inside 'papr_scm.c' to
issue and handle DSM commands. Changed implemented are:

* Implement dimm initialization/un-initialization functions
  papr_dimm_init()/unint() to allocate a per-dimm 'struct dimm_priv'
  instance.

* New helper function allocate_cmd() to allocate command packages for
  a specific DSM command and payload size.

* New function update_dimm_state() to parse a given command payload
  and update per dimm 'struct dimm_priv'.

* Provide an implementation of 'dimm_ops->smart_get_flags' to send the
  submitted instance of 'struct ndctl_cmd' to update_dimm_state().

* Logging helpers for papr_scm that use the underlying libndctl
  provided logging.

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 ndctl/lib/papr_scm.c | 174 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 174 insertions(+)

diff --git a/ndctl/lib/papr_scm.c b/ndctl/lib/papr_scm.c
index 878698a5a8b4..0a3857e2a4c4 100644
--- a/ndctl/lib/papr_scm.c
+++ b/ndctl/lib/papr_scm.c
@@ -20,6 +20,29 @@
 #include <lib/private.h>
 #include <papr_scm_dsm.h>
 
+/* Utility logging maros for simplify logging */
+#define PAPR_DBG(_dimm_, _format_str_, ...) dbg(_dimm_->bus->ctx,	\
+					      "papr_scm:"#_format_str_,	\
+					      ##__VA_ARGS__)
+#define PAPR_INFO(_dimm_, _format_str_, ...) info(_dimm_->bus->ctx,	\
+						"papr_scm:"#_format_str_, \
+						##__VA_ARGS__)
+#define PAPR_ERR(_dimm_, _format_str_, ...) err(_dimm_->bus->ctx,	\
+					      "papr_scm:"#_format_str_,	\
+					      ##__VA_ARGS__)
+#define PAPR_NOTICE(_dimm_, _format_str_, ...) notice(_dimm_->bus->ctx,	\
+						    "papr_scm:"#_format_str_, \
+						    ##__VA_ARGS__)
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
@@ -29,6 +52,157 @@ static bool papr_cmd_is_supported(struct ndctl_dimm *dimm, int cmd)
 	return !!(dimm->cmd_mask & (1ULL << cmd));
 }
 
+static __u64 pcmd_to_dsm(const struct nd_papr_scm_cmd_pkg *pcmd)
+{
+	return pcmd->hdr.nd_command;
+}
+
+/* Verify if the given command is supported and valid */
+static bool cmd_is_valid(struct ndctl_dimm *dimm, struct ndctl_cmd *cmd)
+{
+	const struct nd_papr_scm_cmd_pkg *pcmd = nd_to_papr_cmd_pkg(cmd->pkg);
+
+	if (dimm == NULL)
+		return false;
+
+	if (cmd == NULL) {
+		PAPR_ERR(dimm, "Invalid command\n");
+		return false;
+	}
+
+	/* Verify the command family */
+	if (pcmd->hdr.nd_family != NVDIMM_FAMILY_PAPR_SCM) {
+		PAPR_ERR(dimm, "Invalid command family:0x%016llx\n",
+			 pcmd->hdr.nd_family);
+		return false;
+	}
+
+	/* Verify the DSM */
+	if (pcmd_to_dsm(pcmd) <= DSM_PAPR_SCM_MIN ||
+	    pcmd_to_dsm(pcmd) >= DSM_PAPR_SCM_MAX) {
+		PAPR_ERR(dimm, "Invalid command :0x%016llx\n",
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
+	const struct nd_papr_scm_cmd_pkg *pcmd;
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
+		PAPR_ERR(dimm, "Command error %d\n", cmd->status);
+		return -ENXIO;
+	}
+
+	/* Mark the command as parsed */
+	cmd->status = CMD_PKG_PARSED;
+
+	/* Get the command dsm and handle it */
+	pcmd = nd_to_papr_cmd_pkg(cmd->pkg);
+	switch (pcmd_to_dsm(pcmd)) {
+	default:
+		PAPR_ERR(dimm, "Unhandled dsm-command 0x%016llx\n",
+			 pcmd_to_dsm(pcmd));
+		return -ENOENT;
+	}
+}
+
+/* Allocate a struct ndctl_cmd for given dsm command with payload size */
+static struct ndctl_cmd *allocate_cmd(struct ndctl_dimm *dimm,
+				      __u64 dsm_cmd, size_t payload_size,
+				      uint16_t payload_version)
+{
+	struct ndctl_cmd *cmd;
+	struct nd_papr_scm_cmd_pkg *pcmd;
+	size_t size;
+
+	size = sizeof(struct ndctl_cmd) +
+		sizeof(struct nd_papr_scm_cmd_pkg) + payload_size;
+	cmd = calloc(1, size);
+	if (!cmd)
+		return NULL;
+	pcmd = nd_to_papr_cmd_pkg(cmd->pkg);
+
+	ndctl_cmd_ref(cmd);
+	cmd->dimm = dimm;
+	cmd->type = ND_CMD_CALL;
+	cmd->size = size;
+	cmd->status = CMD_PKG_SUBMITTED;
+	cmd->firmware_status = (u32 *) &pcmd->cmd_status;
+
+	/* Populate the nd_cmd_pkg contained in nd_papr_scm_cmd_pkg */
+	pcmd->hdr.nd_family = NVDIMM_FAMILY_PAPR_SCM;
+	pcmd->hdr.nd_command = dsm_cmd;
+
+	pcmd->payload_version = payload_version;
+	pcmd->payload_offset = sizeof(struct nd_papr_scm_cmd_pkg);
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
+		PAPR_DBG(dimm, "Dimm already initialized !!\n");
+		return 0;
+	}
+
+	p = calloc(1, sizeof(struct dimm_priv));
+	if (!p) {
+		PAPR_ERR(dimm, "Unable to allocate memory for dimm-private\n");
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
+		PAPR_DBG(dimm, "Dimm already un-initialized !!\n");
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
 };
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

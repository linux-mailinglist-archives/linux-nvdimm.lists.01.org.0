Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0B31D76B7
	for <lists+linux-nvdimm@lfdr.de>; Mon, 18 May 2020 13:20:47 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 813A511E16D18;
	Mon, 18 May 2020 04:17:35 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5056511E16CF7
	for <linux-nvdimm@lists.01.org>; Mon, 18 May 2020 04:17:32 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04IB3gje059503;
	Mon, 18 May 2020 07:20:40 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 312cqkvwm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2020 07:20:40 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04IBKQoj024321;
	Mon, 18 May 2020 11:20:38 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by ppma04ams.nl.ibm.com with ESMTP id 3127t5m101-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2020 11:20:37 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04IBKZN914024918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2020 11:20:35 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05EC611C058;
	Mon, 18 May 2020 11:20:35 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 839F611C04A;
	Mon, 18 May 2020 11:20:32 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.102.2.238])
	by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Mon, 18 May 2020 11:20:32 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Mon, 18 May 2020 16:50:31 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl RFC-PATCH 2/4] papr_scm: Add support for fetching dimm-stats
Date: Mon, 18 May 2020 16:50:21 +0530
Message-Id: <20200518112023.147139-3-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518112023.147139-1-vaibhav@linux.ibm.com>
References: <20200518112023.147139-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-18_04:2020-05-15,2020-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=4 lowpriorityscore=0 clxscore=1015 cotscore=-2147483648
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005180100
Message-ID-Hash: 6RUET7JHCZI3NVTBUINWDSHS2JWXKPXH
X-Message-ID-Hash: 6RUET7JHCZI3NVTBUINWDSHS2JWXKPXH
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6RUET7JHCZI3NVTBUINWDSHS2JWXKPXH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add support for fetching dimm-stats from 'papr_scm' module by
implementing newly introduced dimm-op 'new_stats' as
papr_new_stats(). The function uses two pdsm to fetch dimm-stats.

* PAPR_SCM_PDSM_FETCH_PERF_STATS:
  Asks 'papr_scm' module to request fresh values of all dimm-stats
  from PHYP and store then in its perf-stats buffer. It returns the
  size of the perf-stats buffer as bytes in command package 'struct
  nd_pdsm_fetch_perf_stats'.

* PAPR_SCM_PDSM_READ_PERF_STATS:
  Once dimm-stats are placed in 'papr_scm' perf-stats buffer, this
  pdsm is issued to read it contents and copy then to libndctl
  user-space memory using 'struct nd_pdsm_read_perf_stats'
  payload. Since libnvdimm enforces a envelope size limit of 256
  bytes, this pdsm uses libndctl command iterator functionality to
  incrementally copy the entire perf-stat buffer content from
  'papr_scm' module.

The patch introduces new members in 'struct dimm_priv' to hold the
dimm-stat information fetched from 'papr_scm' module. A new function
update_perf_stat_size() is introduced that handles response to pdsm
FETCH_PERF_STATS and allocate enough memory to 'dimm_priv.perf_stats'
to hold all dimm-stats.

When papr_new_stats() is called by libndctl in response to '--stats'
arg being given to ndctl-list command, following sequence is executed:

1. Allocate and submit ndctl_cmd to issue pdsm FETCH_PERF_STATS.
2. On success call update_dimm_stats() that in return calls
   update_perf_stat_size() to allocate buffer 'dimm_priv.perf_stats'
   needed to store dimm-stats.
3. Allocate ndctl_cmd to issue pdsm READ_PERF_STATS.
4. Setup the command iterator pointing to dimm_priv.perf_stats to hold
   the entire data and setting the total length of the read operation.
5. Setup the various get/set callback functions for command 'xfer' and
   'offset' access.
6. Return this command back to libndctl that will then submit the
   command to libnvdimm.

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 ndctl/lib/papr_scm.c      | 169 ++++++++++++++++++++++++++++++++++++++
 ndctl/lib/papr_scm_pdsm.h |  48 +++++++++++
 2 files changed, 217 insertions(+)

diff --git a/ndctl/lib/papr_scm.c b/ndctl/lib/papr_scm.c
index 562262111c91..14fb6d48c12a 100644
--- a/ndctl/lib/papr_scm.c
+++ b/ndctl/lib/papr_scm.c
@@ -14,6 +14,7 @@
 #include <stdlib.h>
 #include <limits.h>
 #include <util/log.h>
+#include <util/util.h>
 #include <ndctl.h>
 #include <ndctl/libndctl.h>
 #include <lib/private.h>
@@ -40,11 +41,19 @@
 #define CMD_PKG_SUBMITTED 1
 #define CMD_PKG_PARSED 2
 
+/* Number of bytes to transffer in each ioctl for pdsm READ_PERF_STATS */
+#define GET_PERF_STAT_XFER_SIZE 16
+
 /* Per dimm data. Holds per-dimm data parsed from the cmd_pkgs */
 struct dimm_priv {
 
 	/* Cache the dimm health status */
 	struct nd_papr_pdsm_health health;
+
+	/* Cache the dimm perf-stats buffer, length in bytes, count */
+	ssize_t len_perf_stats;
+	ssize_t count_perf_stats;
+	struct nd_pdsm_perf_stat *perf_stats;
 };
 
 static bool papr_cmd_is_supported(struct ndctl_dimm *dimm, int cmd)
@@ -136,6 +145,45 @@ static int update_dimm_health(struct ndctl_dimm *dimm, struct ndctl_cmd *cmd)
 	return -EINVAL;
 }
 
+/* Parse the PAPR_SCM_PDSM_FETCH_PERF_STATS command package */
+static int update_perf_stat_size(struct ndctl_dimm *dimm, struct ndctl_cmd *cmd)
+{
+	struct nd_pdsm_cmd_pkg *pcmd = nd_to_pdsm_cmd_pkg(cmd->pkg);
+	struct dimm_priv *p = dimm->dimm_user_data;
+	const struct nd_pdsm_fetch_perf_stats * psize =
+		pdsm_cmd_to_payload(pcmd);
+
+	/* is it an unknown version */
+	if (pcmd->payload_version != 1) {
+		papr_err(dimm, "Unknown payload version for perf stat size\n");
+		return -EBADE;
+	}
+
+	/* Update the perf_size and reallocate the buffer if needed */
+	if (p->len_perf_stats < psize->max_stats_size) {
+		struct nd_pdsm_perf_stat *new_stats, *old_stats;
+		old_stats = p->perf_stats;
+
+		new_stats = (struct nd_pdsm_perf_stat *)
+			calloc(1, psize->max_stats_size);
+		if (!new_stats) {
+			papr_err(dimm, "Unable to allocate new perf_stats buffer\n");
+			return -ENOMEM;
+		}
+		if (old_stats) {
+			/* Copy the old buffer contents to new */
+			memcpy(new_stats, old_stats, p->len_perf_stats);
+			free(old_stats);
+		}
+		p->perf_stats = new_stats;
+	}
+
+	p->len_perf_stats = psize->max_stats_size;
+	papr_dbg(dimm, "dimm perf stats size =%lu\n",
+		 p->len_perf_stats);
+	return 0;
+}
+
 /* Parse a command payload and update dimm flags/private data */
 static int update_dimm_stats(struct ndctl_dimm *dimm, struct ndctl_cmd *cmd)
 {
@@ -163,6 +211,8 @@ static int update_dimm_stats(struct ndctl_dimm *dimm, struct ndctl_cmd *cmd)
 	switch (pcmd_to_pdsm(pcmd)) {
 	case PAPR_SCM_PDSM_HEALTH:
 		return update_dimm_health(dimm, cmd);
+	case PAPR_SCM_PDSM_FETCH_PERF_STATS:
+		return update_perf_stat_size(dimm, cmd);
 	default:
 		papr_err(dimm, "Unhandled pdsm-request 0x%016llx\n",
 			 pcmd_to_pdsm(pcmd));
@@ -286,10 +336,128 @@ static void papr_dimm_uninit(struct ndctl_dimm *dimm)
 		return;
 	}
 
+	if (p->perf_stats)
+		free(p->perf_stats);
+
 	dimm->dimm_user_data = NULL;
 	free(p);
 }
 
+/*
+ * Check if the given command is of type PDSM_READ_PERF_STATS and return
+ * 'struct nd_pdsm_read_perf_stats *' otherwise return NULL.
+ */
+static struct nd_pdsm_read_perf_stats *cmd_to_read_perf(struct ndctl_cmd *cmd)
+{
+	struct nd_pdsm_cmd_pkg *pcmd = nd_to_pdsm_cmd_pkg(cmd->pkg);
+
+	if (cmd && cmd_is_valid(cmd->dimm, cmd) &&
+	    pcmd_to_pdsm(pcmd) == PAPR_SCM_PDSM_READ_PERF_STATS)
+		return (struct nd_pdsm_read_perf_stats *)
+			(pdsm_cmd_to_payload(pcmd));
+	else
+		return NULL;
+}
+
+/* Callbacks from libndctl core to handle iterable read_perf_stats command */
+static u32 papr_get_xfer(struct ndctl_cmd *cmd)
+{
+	struct nd_pdsm_read_perf_stats *stats = cmd_to_read_perf(cmd);
+	if (stats == NULL)
+		papr_err(cmd->dimm, "Invalid command\n");
+	return stats ? stats->in_length : 0;
+}
+
+static u32 papr_get_offset(struct ndctl_cmd *cmd)
+{
+	struct nd_pdsm_read_perf_stats *stats = cmd_to_read_perf(cmd);
+	if (stats == NULL)
+		papr_err(cmd->dimm, "Invalid command\n");
+	return stats ? stats->in_offset : 0;
+}
+
+static void papr_set_xfer(struct ndctl_cmd *cmd, u32 xfer)
+{
+	struct nd_pdsm_read_perf_stats *stats = cmd_to_read_perf(cmd);
+	if (stats == NULL)
+		papr_err(cmd->dimm, "Invalid command\n");
+	stats->in_length = xfer;
+}
+
+static void papr_set_offset(struct ndctl_cmd *cmd, u32 offset)
+{
+	struct nd_pdsm_read_perf_stats *stats = cmd_to_read_perf(cmd);
+	if (stats == NULL)
+		papr_err(cmd->dimm, "Invalid command\n");
+	stats->in_offset = offset;
+}
+
+/* Fetch dimm stats and return a command to read them */
+static struct ndctl_cmd * papr_new_stats(struct ndctl_dimm * dimm)
+{
+	struct dimm_priv * p = dimm->dimm_user_data;
+	struct ndctl_cmd * cmd = NULL;
+	int rc;
+
+	/*
+	 * Submit a pdsm FETCH_PERF_STATS to get the latest stats fetched from
+	 * PHYP and have their length returned to libndctl. Next allocate
+	 * suitable size buffer in dimm private buffer 'perf_stats' and create
+	 * an iterable command for pdsm READ_PERF_STATS to read these stats
+	 * from kernel to 'perf_stats'
+	 */
+	cmd = allocate_cmd(dimm, PAPR_SCM_PDSM_FETCH_PERF_STATS,
+			   sizeof (struct nd_pdsm_fetch_perf_stats),
+			   ND_PDSM_FETCH_PERF_STATS_VERSION);
+	if (!cmd) {
+		papr_err(dimm, "Unable to allocate cmd for perf_stats size\n");
+		return NULL;
+	}
+
+	papr_dbg(dimm, "Fetching dimm stats from papr_scm\n");
+	cmd->pkg[0].nd_size_out = ND_PDSM_ENVELOPE_CONTENT_SIZE(
+		struct nd_pdsm_fetch_perf_stats);
+
+	/* If successful update the dimm data with length of dimm stats */
+	rc = ndctl_cmd_submit_xlat(cmd);
+	rc = rc ? rc : update_dimm_stats(dimm, cmd);
+
+	ndctl_cmd_unref(cmd);
+	if (rc) {
+		papr_err(dimm, "Error fetching perf stats. Err=%d\n", rc);
+		return NULL;
+	}
+
+	/* allocate pdsm READ_PERF_STATS command having tail xfer buffer */
+	cmd = allocate_cmd(dimm, PAPR_SCM_PDSM_READ_PERF_STATS,
+			   sizeof(struct nd_pdsm_read_perf_stats) + GET_PERF_STAT_XFER_SIZE,
+			   ND_PDSM_READ_PERF_STATS_VERSION);
+	if (!cmd) {
+		papr_err(dimm, "Unable to allocated read_perf_stats cmd\n");
+		return NULL;
+	}	/* Update the expected out size from the papr_scm module */
+
+        cmd->pkg[0].nd_size_out =
+		ND_PDSM_ENVELOPE_CONTENT_SIZE(struct nd_pdsm_read_perf_stats) +
+		GET_PERF_STAT_XFER_SIZE;
+
+        /* Setup the iterators */
+	cmd->iter.total_buf = (char *) p->perf_stats;
+	cmd->iter.init_offset = 0;
+	cmd->iter.max_xfer = GET_PERF_STAT_XFER_SIZE;
+	cmd->iter.total_xfer = p->len_perf_stats;
+	cmd->iter.dir = READ;
+	cmd->iter.data = (u8*)cmd_to_read_perf(cmd)->stats_data;
+
+	/* setup the callbacks */
+	cmd->get_xfer = papr_get_xfer;
+	cmd->get_offset = papr_get_offset;
+	cmd->set_xfer = papr_set_xfer;
+	cmd->set_offset = papr_set_offset;
+
+	return cmd;
+}
+
 struct ndctl_dimm_ops * const papr_scm_dimm_ops = &(struct ndctl_dimm_ops) {
 	.cmd_is_supported = papr_cmd_is_supported,
 	.dimm_init = papr_dimm_init,
@@ -299,4 +467,5 @@ struct ndctl_dimm_ops * const papr_scm_dimm_ops = &(struct ndctl_dimm_ops) {
 	.new_smart = papr_new_smart_health,
 	.smart_get_health = papr_smart_get_health,
 	.smart_get_shutdown_state = papr_smart_get_shutdown_state,
+	.new_stats = papr_new_stats,
 };
diff --git a/ndctl/lib/papr_scm_pdsm.h b/ndctl/lib/papr_scm_pdsm.h
index 9b1fdd894a6e..f9f463e6b7dd 100644
--- a/ndctl/lib/papr_scm_pdsm.h
+++ b/ndctl/lib/papr_scm_pdsm.h
@@ -114,6 +114,8 @@ struct nd_pdsm_cmd_pkg {
 enum papr_scm_pdsm {
 	PAPR_SCM_PDSM_MIN = 0x0,
 	PAPR_SCM_PDSM_HEALTH,
+	PAPR_SCM_PDSM_FETCH_PERF_STATS,
+	PAPR_SCM_PDSM_READ_PERF_STATS,
 	PAPR_SCM_PDSM_MAX,
 };
 
@@ -170,4 +172,50 @@ struct nd_papr_pdsm_health_v1 {
 /* Current version number for the dimm health struct */
 #define ND_PAPR_PDSM_HEALTH_VERSION 1
 
+/*
+ * Return the maximum buffer size needed to hold all performance state.
+ * max_stats_size: The buffer size needed to hold all stat entries
+ */
+struct nd_pdsm_fetch_perf_stats_v1 {
+	__u32 max_stats_size;
+	__u8 reserved[4];
+} __attribute__((packed));
+
+#define nd_pdsm_fetch_perf_stats nd_pdsm_fetch_perf_stats_v1
+#define ND_PDSM_FETCH_PERF_STATS_VERSION 1
+
+/*
+ * Holds a single performance stat. papr_scm owns a buffer that holds an array
+ * of all the available stats and their values. Access to the buffer is provided
+ * via PERF_STAT_SIZE and READ_PERF_STATS psdm.
+ * id : id of the performance stat. Usually acsii encode stat name.
+ * val : Non normalized value of the id.
+ */
+
+struct nd_pdsm_perf_stat {
+	__u64 id;
+	__u64 val;
+};
+
+/*
+ * Returns a chunk of performance stats buffer data to libndctl.
+ * This is needed to overcome the 256 byte envelope size limit enforced by
+ * libnvdimm.
+ * in_offset: The starting offset to perf stats data buffer.
+ * in_length: Length of data to be copied to 'stats_data'
+ * stats_data: Holds the chunk of requested perf stats data buffer.
+ *
+ * Note: To prevent races in reading performance stats, in_offset and in_length
+ * should multiple of 16-Bytes. If they are not then papr_scm will return an
+ * -EINVAL error.
+ */
+struct nd_pdsm_read_perf_stats_v1 {
+	__u32 in_offset;
+	__u32 in_length;
+ 	struct nd_pdsm_perf_stat stats_data[];
+} __attribute__((packed));
+
+#define nd_pdsm_read_perf_stats nd_pdsm_read_perf_stats_v1
+#define ND_PDSM_READ_PERF_STATS_VERSION 1
+
 #endif /* _UAPI_ASM_POWERPC_PAPR_SCM_PDSM_H_ */
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

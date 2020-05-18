Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BB21D76B8
	for <lists+linux-nvdimm@lfdr.de>; Mon, 18 May 2020 13:20:49 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9596811E16D16;
	Mon, 18 May 2020 04:17:37 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7C32B11E16D12
	for <linux-nvdimm@lists.01.org>; Mon, 18 May 2020 04:17:35 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04IB3VkY087177;
	Mon, 18 May 2020 07:20:44 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 312cp7nkyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2020 07:20:44 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
	by ppma05fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04IBKbpj008479;
	Mon, 18 May 2020 11:20:41 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
	by ppma05fra.de.ibm.com with ESMTP id 3127t5hm0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2020 11:20:41 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04IBKcZc62390746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2020 11:20:38 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93505A4040;
	Mon, 18 May 2020 11:20:38 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26895A4051;
	Mon, 18 May 2020 11:20:36 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.102.2.238])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Mon, 18 May 2020 11:20:35 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Mon, 18 May 2020 16:50:35 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl RFC-PATCH 3/4] papr_scm: Implement parsing and clean-up for fetched dimm stats
Date: Mon, 18 May 2020 16:50:22 +0530
Message-Id: <20200518112023.147139-4-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518112023.147139-1-vaibhav@linux.ibm.com>
References: <20200518112023.147139-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-18_04:2020-05-15,2020-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=1
 adultscore=0 mlxlogscore=999 bulkscore=0 cotscore=-2147483648
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005180096
Message-ID-Hash: 43IBDWYCQEVDFMURSZ37Z6JNKLG6PZ5Q
X-Message-ID-Hash: 43IBDWYCQEVDFMURSZ37Z6JNKLG6PZ5Q
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/43IBDWYCQEVDFMURSZ37Z6JNKLG6PZ5Q/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Previous commit added functionality to fetch the dimm stats from
kernel 'papr_scm' module and store them into dimm private
struct. However these fetched values may contain stats which are
currently unknown to libndctl.

Hence this patch implements mechanism to parse and clean-up these
fetched dimm stats in a new function update_read_perf_stats(). Also a
new array of known stat-ids and their corresponding names and types is
introduced with a lookup function get_dimm_stat_desc().

Also since libndctl tends to deallocate the cmd->iter.total_buf on its
own when ndctl_cmd is freed, update_read_perf_stats() set it to NULL
to prevent this from happening.

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 ndctl/lib/papr_scm.c | 95 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 1 deletion(-)

diff --git a/ndctl/lib/papr_scm.c b/ndctl/lib/papr_scm.c
index 14fb6d48c12a..d27bacaa7d2c 100644
--- a/ndctl/lib/papr_scm.c
+++ b/ndctl/lib/papr_scm.c
@@ -44,6 +44,13 @@
 /* Number of bytes to transffer in each ioctl for pdsm READ_PERF_STATS */
 #define GET_PERF_STAT_XFER_SIZE 16
 
+/* Structure that holds single dimm stat retrived from kernel */
+struct dimm_stat {
+	u64 id;
+	const char *name;
+	int type;
+};
+
 /* Per dimm data. Holds per-dimm data parsed from the cmd_pkgs */
 struct dimm_priv {
 
@@ -56,6 +63,40 @@ struct dimm_priv {
 	struct nd_pdsm_perf_stat *perf_stats;
 };
 
+/* List of all known dimm_stat descriptors */
+static const struct dimm_stat dimm_stats[] = {
+	{ 0x74437365526c7443ULL, "Controller Reset Count", STAT_TYPE_INT },
+	{ 0x6D547365526C7443ULL, "Controller Reset Elapsed Time", STAT_TYPE_INT},
+	{ 0x20736365536e6f50ULL, "Power-on Seconds", STAT_TYPE_INT64 },
+	{ 0x206566694c6d654dULL, "Life Remaining", STAT_TYPE_PERCENT },
+	{ 0x5563735274697243ULL, "Critical Resource Utilization", STAT_TYPE_PERCENT },
+	{ 0x746e434c74736f48ULL, "Host Load Count", STAT_TYPE_INT64 },
+	{ 0x746e435374736f48ULL, "Host Store Count", STAT_TYPE_INT64 },
+	{ 0x7275444c74736f48ULL, "Host Load Duration", STAT_TYPE_INT64 },
+	{ 0x7275445374736f48ULL, "Host Store Duration", STAT_TYPE_INT64 },
+	{ 0x20746e435264654dULL, "Media Read Count", STAT_TYPE_INT64 },
+	{ 0x20746e435764654dULL, "Media Write Count", STAT_TYPE_INT64 },
+	{ 0x207275445264654dULL, "Media Read Duration", STAT_TYPE_INT64 },
+	{ 0x207275445764654dULL, "Media Write Duration", STAT_TYPE_INT64 },
+	{ 0x746e434852686343ULL, "Cache Read Hit Count", STAT_TYPE_INT64 },
+	{ 0x746e434857686343ULL, "Cache Write Hit Count", STAT_TYPE_INT64 },
+	{ 0x746e435774736146ULL, "Fast Write Count", STAT_TYPE_INT64 },
+};
+
+/* Given a stat-id find the corrosponding descriptor */
+static const struct dimm_stat *get_dimm_stat_desc(u64 id)
+{
+	unsigned index;
+	if (id) {
+		for (index = 0; index < ARRAY_SIZE(dimm_stats); ++index) {
+			if (dimm_stats[index].id == id)
+				return &dimm_stats[index];
+		}
+	}
+
+	return NULL;
+}
+
 static bool papr_cmd_is_supported(struct ndctl_dimm *dimm, int cmd)
 {
 	/* Handle this separately to support monitor mode */
@@ -184,6 +225,47 @@ static int update_perf_stat_size(struct ndctl_dimm *dimm, struct ndctl_cmd *cmd)
 	return 0;
 }
 
+/* Parse the pdsm READ_PERF_STATS command package */
+static int update_read_perf_stats(struct ndctl_dimm *dimm, struct ndctl_cmd *cmd)
+{
+	struct nd_pdsm_cmd_pkg *pcmd = nd_to_pdsm_cmd_pkg(cmd->pkg);
+	struct dimm_priv *p = dimm->dimm_user_data;
+	struct nd_pdsm_perf_stat *stat_src, *stat_dest;
+
+	/* Prevent libndctl from freeing pointer to cmd->iter.total_buf */
+	cmd->iter.total_buf = NULL;
+
+	if (pcmd->cmd_status) {
+		/* Indicate no stats are available */
+		p->count_perf_stats = 0;
+		return pcmd->cmd_status;
+	}
+
+	/* is it an unknown version ? */
+	if (pcmd->payload_version != 1) {
+		papr_err(dimm, "Unknown payload version for perf stats\n");
+		return -EBADE;
+	}
+
+	/* count number of stats available and remove any unknown stats */
+	for(stat_dest = stat_src = p->perf_stats;
+	    (void *)stat_src < (void *)p->perf_stats + p->len_perf_stats;
+	    stat_src++) {
+
+		if (stat_src != stat_dest)
+			*stat_dest = *stat_src;
+
+		/* Skip unknown dimm stats */
+		if (get_dimm_stat_desc(stat_dest->id) != NULL)
+			stat_dest++;
+	}
+
+	/* Update the stats count that we received */
+	p->count_perf_stats = (stat_dest - p->perf_stats);
+
+	return 0;
+}
+
 /* Parse a command payload and update dimm flags/private data */
 static int update_dimm_stats(struct ndctl_dimm *dimm, struct ndctl_cmd *cmd)
 {
@@ -213,6 +295,8 @@ static int update_dimm_stats(struct ndctl_dimm *dimm, struct ndctl_cmd *cmd)
 		return update_dimm_health(dimm, cmd);
 	case PAPR_SCM_PDSM_FETCH_PERF_STATS:
 		return update_perf_stat_size(dimm, cmd);
+	case PAPR_SCM_PDSM_READ_PERF_STATS:
+		return update_read_perf_stats(dimm, cmd);
 	default:
 		papr_err(dimm, "Unhandled pdsm-request 0x%016llx\n",
 			 pcmd_to_pdsm(pcmd));
@@ -301,11 +385,20 @@ static unsigned int papr_smart_get_shutdown_state(struct ndctl_cmd *cmd)
 
 static unsigned int papr_smart_get_flags(struct ndctl_cmd *cmd)
 {
+	struct nd_pdsm_cmd_pkg *pcmd = nd_to_pdsm_cmd_pkg(cmd->pkg);
+
 	/* In case of error return empty flags * */
 	if (update_dimm_stats(cmd->dimm, cmd))
 		return 0;
 
-	return ND_SMART_HEALTH_VALID | ND_SMART_SHUTDOWN_VALID;
+	switch (pcmd_to_pdsm(pcmd)) {
+	case PAPR_SCM_PDSM_HEALTH:
+		return ND_SMART_HEALTH_VALID | ND_SMART_SHUTDOWN_VALID;
+	case PAPR_SCM_PDSM_READ_PERF_STATS:
+		return ND_SMART_STATS_VALID;
+	default:
+		return 0;
+	}
 }
 
 static int papr_dimm_init(struct ndctl_dimm *dimm)
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

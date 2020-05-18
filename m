Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 770BA1D76B9
	for <lists+linux-nvdimm@lfdr.de>; Mon, 18 May 2020 13:20:52 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B030511E16D18;
	Mon, 18 May 2020 04:17:40 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D873A11E16D11
	for <linux-nvdimm@lists.01.org>; Mon, 18 May 2020 04:17:38 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04IB4rhI059632;
	Mon, 18 May 2020 07:20:46 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 312c21y36f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2020 07:20:46 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04IBKWFg024334;
	Mon, 18 May 2020 11:20:45 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by ppma04ams.nl.ibm.com with ESMTP id 3127t5m104-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2020 11:20:44 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04IBKgq657933868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2020 11:20:42 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 491534204C;
	Mon, 18 May 2020 11:20:42 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0D764204B;
	Mon, 18 May 2020 11:20:39 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.102.2.238])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Mon, 18 May 2020 11:20:39 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Mon, 18 May 2020 16:50:38 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl RFC-PATCH 4/4] papr_scm: Implement dimm op 'get_stat'
Date: Mon, 18 May 2020 16:50:23 +0530
Message-Id: <20200518112023.147139-5-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518112023.147139-1-vaibhav@linux.ibm.com>
References: <20200518112023.147139-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-18_04:2020-05-15,2020-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 cotscore=-2147483648 lowpriorityscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=1
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005180096
Message-ID-Hash: QTLLPEOVLMMN6VYUBQTT7ZW7GETTGU3D
X-Message-ID-Hash: QTLLPEOVLMMN6VYUBQTT7ZW7GETTGU3D
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QTLLPEOVLMMN6VYUBQTT7ZW7GETTGU3D/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Previous patches implemented functionality to fetch the dimm-stats
from kernel by implementing dimm-op 'new_stats'. However in absence of
dimm-op 'get_stat' the fetched dimm-stats are never passed on to ndctl
json presentation layer.

This patch implements dimm-op 'get_stat' as function papr_get_stat()
that incremently returns populated 'struct ndctl_dimm_stat' instances
back to ndctl json util function util_dimm_stats_to_json() which then
creates a json-object out of them.

In order to keep track of last returned dimm-stat, papr_get_stat()
utilizes ndctl_cmd.private_data to store the next index of 'struct
nd_pdsm_perf_stat' to be returned from array dimm_priv.perf_stats.

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 ndctl/lib/papr_scm.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/ndctl/lib/papr_scm.c b/ndctl/lib/papr_scm.c
index d27bacaa7d2c..46f8992508b2 100644
--- a/ndctl/lib/papr_scm.c
+++ b/ndctl/lib/papr_scm.c
@@ -551,6 +551,41 @@ static struct ndctl_cmd * papr_new_stats(struct ndctl_dimm * dimm)
 	return cmd;
 }
 
+/* Return a single dimm-stat from the command until ret */
+static int papr_get_stat(struct ndctl_cmd *cmd, struct ndctl_dimm_stat * stat)
+{
+	/* Store the next stat index in stat->provider_private */
+	int next_index;
+	struct dimm_priv * p = cmd->dimm->dimm_user_data;
+	struct nd_pdsm_cmd_pkg *pcmd;
+	const struct dimm_stat *stat_desc;
+
+	if (!stat || !cmd)
+		return -EINVAL;
+
+	pcmd = nd_to_pdsm_cmd_pkg(cmd->pkg);
+	if (pcmd_to_pdsm(pcmd) != PAPR_SCM_PDSM_READ_PERF_STATS)
+		return -EINVAL;
+
+	/* Fetch the next_index from cmd and check bounds */
+	next_index = (cmd->private_data - (void*)0);
+	if (next_index >= p->count_perf_stats)
+		return -ENOENT;
+
+	stat_desc = get_dimm_stat_desc(p->perf_stats[next_index].id);
+	if (!stat_desc)
+		return -EINVAL;
+
+	/* populate theprovided struct */
+	stat->name = stat_desc->name;
+	stat->type = stat_desc->type;
+	stat->val.int64_val = p->perf_stats[next_index].val;
+
+	/* update the stored next index in the struct ndctl_cmd */
+	cmd->private_data = (void*)0 + next_index + 1;
+	return 0;
+}
+
 struct ndctl_dimm_ops * const papr_scm_dimm_ops = &(struct ndctl_dimm_ops) {
 	.cmd_is_supported = papr_cmd_is_supported,
 	.dimm_init = papr_dimm_init,
@@ -561,4 +596,5 @@ struct ndctl_dimm_ops * const papr_scm_dimm_ops = &(struct ndctl_dimm_ops) {
 	.smart_get_health = papr_smart_get_health,
 	.smart_get_shutdown_state = papr_smart_get_shutdown_state,
 	.new_stats = papr_new_stats,
+	.get_stat = papr_get_stat,
 };
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

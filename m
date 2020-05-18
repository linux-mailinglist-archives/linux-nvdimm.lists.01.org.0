Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 068D81D76B6
	for <lists+linux-nvdimm@lfdr.de>; Mon, 18 May 2020 13:20:43 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5D81C11E16D16;
	Mon, 18 May 2020 04:17:30 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 23ECD11E16D0E
	for <linux-nvdimm@lists.01.org>; Mon, 18 May 2020 04:17:28 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04IB3fYh059474;
	Mon, 18 May 2020 07:20:37 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 312cqkvwja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2020 07:20:36 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
	by ppma05fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04IBKVWo008469;
	Mon, 18 May 2020 11:20:34 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by ppma05fra.de.ibm.com with ESMTP id 3127t5hm0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2020 11:20:34 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04IBKVln8257958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2020 11:20:31 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B0774C044;
	Mon, 18 May 2020 11:20:31 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3E644C04E;
	Mon, 18 May 2020 11:20:28 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.102.2.238])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Mon, 18 May 2020 11:20:28 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Mon, 18 May 2020 16:50:28 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl RFC-PATCH 1/4] ndctl,libndctl: Implement new dimm-ops 'new_stats' and 'get_stat'
Date: Mon, 18 May 2020 16:50:20 +0530
Message-Id: <20200518112023.147139-2-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518112023.147139-1-vaibhav@linux.ibm.com>
References: <20200518112023.147139-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-18_04:2020-05-15,2020-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=1 lowpriorityscore=0 clxscore=1015 cotscore=-2147483648
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005180100
Message-ID-Hash: 6VTRAOROJKU275NISVNBOVKXLCIFCB74
X-Message-ID-Hash: 6VTRAOROJKU275NISVNBOVKXLCIFCB74
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6VTRAOROJKU275NISVNBOVKXLCIFCB74/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Do necessary ndctl, libndctl changes to add support for two new dimm-ops
namely 'new_stats' and 'get_stat' that can be implemented by dimm
providers to expose dimm statistics for e.g "Controller Reset Count"
etc, to ndctl. These dimm-ops are called when newly introduced command
line argument '-S' or '--stats' is provided on with ndctl-list
command.

Following are the semantics of these new dimm-ops:

* struct ndctl_cmd *(*new_stats)(struct ndctl_dimm *):

  Return a ndctl command that can be sent to libnvdimm to fetch
  dimm-stats from kernel. On successful submission
  'dimm_ops->smart_get_flags' is called to check if ND_SMART_STATS_VALID
  flag is set which indicates dimm-stats successfully fetched from
  libnvdimm.

* int (*get_stat)(struct ndctl_cmd *, struct ndctl_dimm_stat *):

  If ND_SMART_STATS_VALID flag was returned for a command from
  'dimm-ops->smart_get_flags' then this dimm-op is called to
  incrementally retrieve dimm-stats. For each call the dimm-op
  implementer is expected to populate the provided instance of 'struct
  ndctl_dimm_stat *' with a info on name, type and value of a
  dimm-stat. In case no more dimm-stats are available the dimm-op
  should return an error.

The newly introduced 'struct ndctl_dimm_stat' holds Name, type and
value information of a single dimm-stat. The ndctl_dimm_stat.type
information is used to appropriately format the dimm-stat value in the
json output.

The patch also updates 'util/json-smart.c' introducing new function
util_dimm_stats_to_json() thats called when '--stats' command line arg
is provided, and it drives the calls to dimm-ops 'new_stats' and
'get_stat'. The function does follows this sequence:

1. Generates a new json-object named 'stats' in the json output
2. Use 'dimm_ops->new_stats' to get a ndctl_cmd instance.
3. Submit the command to libndctl.
4. In case of successful submission, retrieve flags associated with the
   command.
4. In case flag ND_SMART_STATS_VALID use dimm-op 'get_stat' to retrieve
   available dimm-stats.
5. Creates new json-object for each 'struct ndctl_dimm_stat' returned
   from dimm-op 'get_stat' based on the type of dimm-stat.
6. Adds the above create json-object as child node of the 'stats'
   json-object.
7. Return the 'stats' json object from the function.

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 Documentation/ndctl/ndctl-list.txt | 24 ++++++++++
 ndctl/lib/libndctl.sym             |  5 ++
 ndctl/lib/private.h                |  6 +++
 ndctl/lib/smart.c                  | 26 +++++++++++
 ndctl/libndctl.h                   | 23 ++++++++++
 ndctl/list.c                       |  9 ++++
 ndctl/util/json-smart.c            | 73 ++++++++++++++++++++++++++++++
 util/json.h                        |  1 +
 8 files changed, 167 insertions(+)

diff --git a/Documentation/ndctl/ndctl-list.txt b/Documentation/ndctl/ndctl-list.txt
index 7c7e3ac9d05c..4ba58b96fb74 100644
--- a/Documentation/ndctl/ndctl-list.txt
+++ b/Documentation/ndctl/ndctl-list.txt
@@ -129,6 +129,30 @@ include::xable-bus-options.txt[]
     "shutdown_state":"clean"
   }
 }
+-S::
+--stats::
+	Include dimm statistics in the listing. For example:
+[verse]
+{
+  "dev":"nmem0"
+  "stats":{
+    "Controller Reset Count":2,
+    "Controller Reset Elapsed Time":50800,
+    "Power-on Seconds":51400,
+    "Critical Resource Utilization":"0%",
+    "Host Load Count":4056485,
+    "Host Store Count":8956850,
+    "Host Load Duration":765053890,
+    "Host Store Duration":715390700,
+    "Media Read Count":0,
+    "Media Write Count":6178,
+    "Media Read Duration":0,
+    "Media Write Duration":9468375,
+    "Cache Read Hit Count":4056485,
+    "Cache Write Hit Count":8432554,
+    "Fast Write Count":8959962
+  }
+}
 
 -F::
 --firmware::
diff --git a/ndctl/lib/libndctl.sym b/ndctl/lib/libndctl.sym
index ac575a23d035..5b8eabc1b9d5 100644
--- a/ndctl/lib/libndctl.sym
+++ b/ndctl/lib/libndctl.sym
@@ -431,3 +431,8 @@ LIBNDCTL_23 {
 	ndctl_region_get_align;
 	ndctl_region_set_align;
 } LIBNDCTL_22;
+
+LIBNDCTL_24 {
+	ndctl_dimm_cmd_new_stats;
+	ndctl_dimm_get_stat;
+} LIBNDCTL_23;
\ No newline at end of file
diff --git a/ndctl/lib/private.h b/ndctl/lib/private.h
index 679e359a1070..c4d1f42f7ac2 100644
--- a/ndctl/lib/private.h
+++ b/ndctl/lib/private.h
@@ -238,6 +238,7 @@ struct ndctl_namespace {
  * @status: negative if failed, 0 if success, > 0 if never submitted
  * @get_firmware_status: per command firmware status field retrieval
  * @iter: iterator for multi-xfer commands
+ * @private_data: Used by dimm-provider to store private data
  * @source: source cmd of an inherited iter.total_buf
  *
  * For dynamically sized commands like 'get_config', 'set_config', or
@@ -266,6 +267,7 @@ struct ndctl_cmd {
 		u32 total_xfer;
 		int dir;
 	} iter;
+	void *private_data;
 	struct ndctl_cmd *source;
 	union {
 		struct nd_cmd_ars_cap ars_cap[0];
@@ -352,6 +354,10 @@ struct ndctl_dimm_ops {
 	int (*dimm_init)(struct ndctl_dimm *);
 	/* Called just before struct ndctl_dimm is de-allocated */
 	void (*dimm_uninit)(struct ndctl_dimm *);
+	/* Return a command to fetch dimm stats */
+	struct ndctl_cmd *(*new_stats)(struct ndctl_dimm *);
+	/* Return a single dimm-stat from the command until error */
+	int (*get_stat)(struct ndctl_cmd *, struct ndctl_dimm_stat *);
 };
 
 extern struct ndctl_dimm_ops * const intel_dimm_ops;
diff --git a/ndctl/lib/smart.c b/ndctl/lib/smart.c
index 0e180cff5a3e..fbb1248c08a9 100644
--- a/ndctl/lib/smart.c
+++ b/ndctl/lib/smart.c
@@ -31,6 +31,32 @@ NDCTL_EXPORT struct ndctl_cmd *ndctl_dimm_cmd_new_smart(
 		return NULL;
 }
 
+NDCTL_EXPORT struct ndctl_cmd *ndctl_dimm_cmd_new_stats(
+		struct ndctl_dimm *dimm)
+{
+	struct ndctl_dimm_ops *ops = dimm->ops;
+
+	if (ops && ops->new_stats)
+		return ops->new_stats(dimm);
+	else
+		return NULL;
+}
+
+NDCTL_EXPORT int ndctl_dimm_get_stat(struct ndctl_cmd *cmd,
+				      struct ndctl_dimm_stat * stat)
+{
+	struct ndctl_dimm_ops *ops;
+
+	if (!cmd || !cmd->dimm)
+		return -EINVAL;
+	ops = cmd->dimm->ops;
+
+	if (ops && ops->get_stat)
+		return ops->get_stat(cmd, stat);
+	else
+		return -ENOENT;
+}
+
 NDCTL_EXPORT struct ndctl_cmd *ndctl_dimm_cmd_new_smart_threshold(
 		struct ndctl_dimm *dimm)
 {
diff --git a/ndctl/libndctl.h b/ndctl/libndctl.h
index daf11b8ce4ea..9fab2097a920 100644
--- a/ndctl/libndctl.h
+++ b/ndctl/libndctl.h
@@ -247,6 +247,7 @@ int ndctl_cmd_ars_stat_get_flag_overflow(struct ndctl_cmd *ars_stat);
 #define ND_SMART_ALARM_VALID	(1 << 9)
 #define ND_SMART_SHUTDOWN_VALID	(1 << 10)
 #define ND_SMART_VENDOR_VALID	(1 << 11)
+#define ND_SMART_STATS_VALID	(1 << 12)
 #define ND_SMART_SPARE_TRIP	(1 << 0)
 #define ND_SMART_MTEMP_TRIP	(1 << 1)
 #define ND_SMART_TEMP_TRIP	ND_SMART_MTEMP_TRIP
@@ -341,6 +342,28 @@ int ndctl_cmd_get_status(struct ndctl_cmd *cmd);
 unsigned int ndctl_cmd_get_firmware_status(struct ndctl_cmd *cmd);
 int ndctl_cmd_submit(struct ndctl_cmd *cmd);
 
+/* Holds a single dimm stat which can be retrived */
+struct ndctl_dimm_stat {
+        const char *name;
+        enum {
+		STAT_TYPE_BOOL,
+		STAT_TYPE_INT,
+		STAT_TYPE_INT64,
+		STAT_TYPE_DOUBLE,
+		STAT_TYPE_STR,
+		STAT_TYPE_PERCENT,
+	} type;
+	union {
+		bool bool_val;
+		int int_val;
+		long long int64_val;
+		double double_val;
+		char str_val[32];
+	} val;
+};
+
+struct ndctl_cmd *ndctl_dimm_cmd_new_stats(struct ndctl_dimm *dimm);
+int ndctl_dimm_get_stat(struct ndctl_cmd *cmd, struct ndctl_dimm_stat *stat);
 struct badblock {
 	unsigned long long offset;
 	unsigned int len;
diff --git a/ndctl/list.c b/ndctl/list.c
index 31fb1b9593a2..cda3493c2ffc 100644
--- a/ndctl/list.c
+++ b/ndctl/list.c
@@ -32,6 +32,7 @@ static struct {
 	bool namespaces;
 	bool idle;
 	bool health;
+	bool stats;
 	bool dax;
 	bool media_errors;
 	bool human;
@@ -367,6 +368,13 @@ static void filter_dimm(struct ndctl_dimm *dimm, struct util_filter_ctx *ctx)
 		}
 	}
 
+	if (list.stats) {
+		struct json_object *jstats;
+
+		jstats = util_dimm_stats_to_json(dimm);
+		json_object_object_add(jdimm, "stats", jstats);
+	}
+
 	if (list.firmware) {
 		struct json_object *jfirmware;
 
@@ -479,6 +487,7 @@ int cmd_list(int argc, const char **argv, struct ndctl_ctx *ctx)
 		OPT_BOOLEAN('D', "dimms", &list.dimms, "include dimm info"),
 		OPT_BOOLEAN('F', "firmware", &list.firmware, "include firmware info"),
 		OPT_BOOLEAN('H', "health", &list.health, "include dimm health"),
+		OPT_BOOLEAN('S', "stats", &list.stats, "include dimm stats"),
 		OPT_BOOLEAN('R', "regions", &list.regions,
 				"include region info"),
 		OPT_BOOLEAN('N', "namespaces", &list.namespaces,
diff --git a/ndctl/util/json-smart.c b/ndctl/util/json-smart.c
index a9bd17b37b4e..1312439453ee 100644
--- a/ndctl/util/json-smart.c
+++ b/ndctl/util/json-smart.c
@@ -221,3 +221,76 @@ struct json_object *util_dimm_health_to_json(struct ndctl_dimm *dimm)
 		ndctl_cmd_unref(cmd);
 	return jhealth;
 }
+
+struct json_object *util_dimm_stats_to_json(struct ndctl_dimm *dimm)
+{
+	struct json_object *jstat = json_object_new_object();
+	struct json_object *jobj;
+	struct ndctl_cmd *cmd;
+	struct ndctl_dimm_stat stat = { 0 };
+	char format_buffer[32] = { 0 };
+	int rc;
+	unsigned int flags;
+
+	if (!jstat)
+		return NULL;
+
+	cmd = ndctl_dimm_cmd_new_stats(dimm);
+	if (!cmd)
+		goto err;
+
+	rc = ndctl_cmd_submit_xlat(cmd);
+	if (rc < 0) {
+		jobj = json_object_new_string("unknown");
+		if (jobj)
+			json_object_object_add(jstat, "stats", jobj);
+		goto out;
+	}
+
+	/* Check if any stats are reported */
+	flags = ndctl_cmd_smart_get_flags(cmd);
+	if (!(flags & ND_SMART_STATS_VALID))
+		goto out;
+
+	/* Iterate through the reported stats list */
+	while (ndctl_dimm_get_stat(cmd, &stat) == 0) {
+		switch(stat.type) {
+		case STAT_TYPE_BOOL:
+			jobj = json_object_new_boolean(stat.val.bool_val);
+			break;
+		case STAT_TYPE_INT:
+			jobj = json_object_new_int(stat.val.int_val);
+			break;
+		case STAT_TYPE_INT64:
+			jobj = json_object_new_int64(stat.val.int64_val);
+			break;
+		case STAT_TYPE_DOUBLE:
+			jobj = json_object_new_double(stat.val.double_val);
+			break;
+		case STAT_TYPE_STR:
+			jobj = json_object_new_string(stat.val.str_val);
+			break;
+		case STAT_TYPE_PERCENT:
+			snprintf(format_buffer, sizeof(format_buffer) - 1,
+				 "%u%%",stat.val.int_val);
+			format_buffer[sizeof(format_buffer) - 1] = '\0';
+			jobj = json_object_new_string(format_buffer);
+			break;
+		default:
+			jobj = json_object_new_string("unknown-type");
+			break;
+		};
+
+		if (jobj)
+			json_object_object_add(jstat, stat.name, jobj);
+	}
+	ndctl_cmd_unref(cmd);
+	return jstat;
+ err:
+	json_object_put(jstat);
+	jstat = NULL;
+ out:
+	if (cmd)
+		ndctl_cmd_unref(cmd);
+	return jstat;
+}
diff --git a/util/json.h b/util/json.h
index 6d39d3aa4693..e678596e1aab 100644
--- a/util/json.h
+++ b/util/json.h
@@ -56,6 +56,7 @@ struct json_object *util_json_object_size(unsigned long long size,
 struct json_object *util_json_object_hex(unsigned long long val,
 		unsigned long flags);
 struct json_object *util_dimm_health_to_json(struct ndctl_dimm *dimm);
+struct json_object *util_dimm_stats_to_json(struct ndctl_dimm *dimm);
 struct json_object *util_dimm_firmware_to_json(struct ndctl_dimm *dimm,
 		unsigned long flags);
 struct json_object *util_region_capabilities_to_json(struct ndctl_region *region);
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

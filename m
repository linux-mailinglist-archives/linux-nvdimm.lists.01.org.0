Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 574252DDCD1
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Dec 2020 03:15:11 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0D9B1100EB322;
	Thu, 17 Dec 2020 18:15:10 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F1EC6100EB85C
	for <linux-nvdimm@lists.01.org>; Thu, 17 Dec 2020 18:15:07 -0800 (PST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BI2DuUk012449;
	Fri, 18 Dec 2020 02:15:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=568+5jShrNbw5FxMAj7MkwEXhKoo+U/+eWhVE4kNsWw=;
 b=RX2dX9NwyeDkjBWgTiGyz2BHW6/RHAgzb+ScWOd5kJ3+dNwBiYW6w8PqE+gAEdHN2GA4
 8NiJvMAofTiEMxg4mbeKvBVQs9resTnrGFzw1RO4J1qZH138RG/3L/x2sv6szpeXB8w1
 nwsMVXs0eg7HNJ+x426BYe6UdPiLB0jJX6fa8UzcdKUOxhYvMdicsi8g/nLEZlMJxLG5
 +ebjwMyR+rMKO42/MydJeN1A0lajwsj3r2kZj2Nkt6Pr5Z142SnKsC8oLLvYfoVyHXj4
 xoyj6sTm1+lwA1A3sA8bkPIE9HhxoEb2R8gpkRkmpC6GT/kFhOBnOroJLOeLiNpOn+1I eA==
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by aserp2120.oracle.com with ESMTP id 35cntmg95t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 18 Dec 2020 02:15:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BI26ICA194854;
	Fri, 18 Dec 2020 02:15:04 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userp3030.oracle.com with ESMTP id 35d7t180sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Dec 2020 02:15:03 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BI2F2rF021988;
	Fri, 18 Dec 2020 02:15:02 GMT
Received: from paddy.uk.oracle.com (/10.175.180.204)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 17 Dec 2020 18:15:02 -0800
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Subject: [PATCH daxctl v2 4/5] daxctl: allow creating devices from input json
Date: Fri, 18 Dec 2020 02:14:37 +0000
Message-Id: <20201218021438.8926-5-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201218021438.8926-1-joao.m.martins@oracle.com>
References: <20201218021438.8926-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9838 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012180012
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9838 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012180013
Message-ID-Hash: 5OBZJMW244UHL625643D3FX2JCV7W3FH
X-Message-ID-Hash: 5OBZJMW244UHL625643D3FX2JCV7W3FH
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5OBZJMW244UHL625643D3FX2JCV7W3FH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add an option namely --input which passes a parameter
which is a JSON file path. The JSON file contains the
data usually returned by:

	$ daxctl list -d dax0.1 | jq -er '.[]' > device.json
	{
	  "chardev":"dax0.1",
	  "size":34359738368,
	  "target_node":0,
	  "align":1073741824,
	  "mode":"devdax",
	  "mappings":[
	    {
	      "page_offset":4194304,
	      "start":25769803776,
	      "end":42949672959,
	      "size":17179869184
	    },
	    {
	      "page_offset":0,
	      "start":8589934592,
	      "end":25769803775,
	      "size":17179869184
	    }
	  ]
	}

The input values in the mapping json are decimal
for now. A device can then be created by specifying this same data
to re-create it e.g.

	$ daxctl create-device -u --input device.json
	{
	  "chardev":"dax0.1",
	  "size":"32.00 GiB (34.36 GB)",
	  "target_node":0,
	  "align":"1024.00 MiB (1073.74 MB)",
	  "mode":"devdax",
	}

	$ daxctl list -d dax0.1
	{
	  "chardev":"dax0.1",
	  "size":34359738368,
	  "target_node":0,
	  "align":1073741824,
	  "mode":"devdax",
	  "mappings":[
	    {
	      "page_offset":4194304,
	      "start":25769803776,
	      "end":42949672959,
	      "size":17179869184
	    },
	    {
	      "page_offset":0,
	      "start":8589934592,
	      "end":25769803775,
	      "size":17179869184
	    }
	  ]
	}

	created 1 device

This means we can restore/recreate previously established mappings.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 Documentation/daxctl/daxctl-create-device.txt |  13 +++
 daxctl/device.c                               | 128 +++++++++++++++++++++++++-
 2 files changed, 136 insertions(+), 5 deletions(-)

diff --git a/Documentation/daxctl/daxctl-create-device.txt b/Documentation/daxctl/daxctl-create-device.txt
index 7f64719d16f2..05f4dbd9d61c 100644
--- a/Documentation/daxctl/daxctl-create-device.txt
+++ b/Documentation/daxctl/daxctl-create-device.txt
@@ -90,6 +90,19 @@ include::region-option.txt[]
 	to 2M. Note that "devdax" mode enforces all mappings to be
 	aligned to this value, i.e. it fails unaligned mapping attempts.
 
+--input::
+	Applications that want to select ranges assigned to a device-dax
+	instance, or wanting to establish previously created devices, can
+	pass an input JSON file. The file option lets a user pass a JSON
+	object similar to the one listed with "daxctl list".
+
+	The device name is not re-created, but if a "chardev" is passed in
+	the JSON file, it will use that to get the region id.
+
+	Note that the JSON content in the file cannot be an array of
+	JSON objects but rather a single JSON object i.e. without the
+	array enclosing brackets.
+
 include::human-option.txt[]
 
 include::verbose-option.txt[]
diff --git a/daxctl/device.c b/daxctl/device.c
index 3c2d4e3d8b48..fe4291199312 100644
--- a/daxctl/device.c
+++ b/daxctl/device.c
@@ -13,6 +13,7 @@
 #include <util/json.h>
 #include <util/filter.h>
 #include <json-c/json.h>
+#include <json-c/json_util.h>
 #include <daxctl/libdaxctl.h>
 #include <util/parse-options.h>
 #include <ccan/array_size/array_size.h>
@@ -23,6 +24,7 @@ static struct {
 	const char *region;
 	const char *size;
 	const char *align;
+	const char *input;
 	bool no_online;
 	bool no_movable;
 	bool force;
@@ -36,10 +38,16 @@ enum dev_mode {
 	DAXCTL_DEV_MODE_RAM,
 };
 
+struct mapping {
+	unsigned long long start, end, pgoff;
+};
+
 static enum dev_mode reconfig_mode = DAXCTL_DEV_MODE_UNKNOWN;
 static long long align = -1;
 static long long size = -1;
 static unsigned long flags;
+static struct mapping *maps = NULL;
+static long long nmaps = -1;
 
 enum memory_zone {
 	MEM_ZONE_MOVABLE,
@@ -71,7 +79,8 @@ OPT_BOOLEAN('f', "force", &param.force, \
 
 #define CREATE_OPTIONS() \
 OPT_STRING('s', "size", &param.size, "size", "size to switch the device to"), \
-OPT_STRING('a', "align", &param.align, "align", "alignment to switch the device to")
+OPT_STRING('a', "align", &param.align, "align", "alignment to switch the device to"), \
+OPT_STRING('\0', "input", &param.input, "input", "input device JSON file")
 
 #define DESTROY_OPTIONS() \
 OPT_BOOLEAN('f', "force", &param.force, \
@@ -124,6 +133,94 @@ static const struct option destroy_options[] = {
 	OPT_END(),
 };
 
+static int sort_mappings(const void *a, const void *b)
+{
+	json_object **jsoa, **jsob;
+	struct json_object *va, *vb;
+	unsigned long long pga, pgb;
+
+	jsoa = (json_object **)a;
+	jsob = (json_object **)b;
+	if (!*jsoa && !*jsob)
+		return 0;
+
+	if (!json_object_object_get_ex(*jsoa, "page_offset", &va) ||
+	    !json_object_object_get_ex(*jsob, "page_offset", &vb))
+		return 0;
+
+	pga = json_object_get_int64(va);
+	pgb = json_object_get_int64(vb);
+
+	return pga > pgb;
+}
+
+static int parse_device_file(const char *filename)
+{
+	struct json_object *jobj, *jval = NULL, *jmappings = NULL;
+	int i, len, rc = -EINVAL, region_id, id;
+	const char *chardev;
+	char  *region = NULL;
+	struct mapping *m;
+
+	jobj = json_object_from_file(filename);
+	if (!jobj)
+		return rc;
+
+	if (!json_object_object_get_ex(jobj, "align", &jval))
+		return rc;
+	param.align = json_object_get_string(jval);
+
+	if (!json_object_object_get_ex(jobj, "size", &jval))
+		return rc;
+	param.size = json_object_get_string(jval);
+
+	if (!json_object_object_get_ex(jobj, "chardev", &jval))
+		return rc;
+	chardev = json_object_get_string(jval);
+	if (sscanf(chardev, "dax%u.%u", &region_id, &id) != 2)
+		return rc;
+	if (asprintf(&region, "%u", region_id) < 0)
+		return rc;
+	param.region = region;
+
+	if (!json_object_object_get_ex(jobj, "mappings", &jmappings))
+		return rc;
+	json_object_array_sort(jmappings, sort_mappings);
+
+	len = json_object_array_length(jmappings);
+	m = calloc(len, sizeof(*m));
+	if (!m)
+		return -ENOMEM;
+
+	for (i = 0; i < len; i++) {
+		struct json_object *j, *val;
+
+		j = json_object_array_get_idx(jmappings, i);
+		if (!j)
+			goto err;
+
+		if (!json_object_object_get_ex(j, "start", &val))
+			goto err;
+		m[i].start = json_object_get_int64(val);
+
+		if (!json_object_object_get_ex(j, "end", &val))
+			goto err;
+		m[i].end = json_object_get_int64(val);
+
+		if (!json_object_object_get_ex(j, "page_offset", &val))
+			goto err;
+		m[i].pgoff = json_object_get_int64(val);
+	}
+	maps = m;
+	nmaps = len;
+	rc = 0;
+
+err:
+	if (!maps)
+		free(m);
+	return rc;
+}
+
 static const char *parse_device_options(int argc, const char **argv,
 		enum device_action action, const struct option *options,
 		const char *usage, struct daxctl_ctx *ctx)
@@ -214,6 +311,13 @@ static const char *parse_device_options(int argc, const char **argv,
 		}
 		break;
 	case ACTION_CREATE:
+		if (param.input &&
+		    (rc = parse_device_file(param.input)) != 0) {
+			fprintf(stderr,
+				"error: failed to parse device file: %s\n",
+				strerror(-rc));
+			break;
+		}
 		if (param.size)
 			size = __parse_size64(param.size, &units);
 		if (param.align)
@@ -525,7 +629,8 @@ static int do_create(struct daxctl_region *region, long long val,
 {
 	struct json_object *jdev;
 	struct daxctl_dev *dev;
-	int rc = 0;
+	int i, rc = 0;
+	long long alloc = 0;
 
 	if (daxctl_region_create_dev(region))
 		return -ENOSPC;
@@ -546,9 +651,22 @@ static int do_create(struct daxctl_region *region, long long val,
 			return rc;
 	}
 
-	rc = daxctl_dev_set_size(dev, val);
-	if (rc < 0)
-		return rc;
+	/* @maps is ordered by page_offset */
+	for (i = 0; i < nmaps; i++) {
+		rc = daxctl_dev_set_mapping(dev, maps[i].start, maps[i].end);
+		if (rc < 0)
+			return rc;
+		alloc += (maps[i].end - maps[i].start + 1);
+	}
+
+	if (nmaps > 0 && val > 0 && alloc != val) {
+		fprintf(stderr, "%s: allocated %lld but specified size %lld\n",
+			daxctl_dev_get_devname(dev), alloc, val);
+	} else {
+		rc = daxctl_dev_set_size(dev, val);
+		if (rc < 0)
+			return rc;
+	}
 
 	rc = daxctl_dev_enable_devdax(dev);
 	if (rc) {
-- 
1.8.3.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

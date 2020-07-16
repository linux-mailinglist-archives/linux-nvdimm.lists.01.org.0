Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F39E7222B39
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 Jul 2020 20:47:53 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2916B11571BE9;
	Thu, 16 Jul 2020 11:47:52 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5D2C11108EF26
	for <linux-nvdimm@lists.01.org>; Thu, 16 Jul 2020 11:47:50 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06GIcC5e059656;
	Thu, 16 Jul 2020 18:47:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=Y2Bv2dxeFkdqyYlI+JrtzhTtExT1WznUOd8+/Xsn90Q=;
 b=vH1RMHlr86to8+vO4ovikBux16WRz/+oVgyaKhiU4UUhEm8aZjU6VGgilLdSjmZntybd
 NQXXnLmlNkSOavzZxJyhyYrYrYRu9Omr6O3tcFjBAkM8HPuuSeDGgU0rHE8Kivs4EKTc
 o1xjvNANE+jjA5l1Q/YWBNhN6mi5fi43SBlZvojMJBfmyS5UR8H3TvpBwPZr2/ETSIz/
 sFZmyAcrJqcAg43vFNS1MyqEp825IoRByZeLEbKNyRcNa/tROn439rLoSd3XfRyo3w+/
 3Ex8nyzouSfpUySWYvjp9ih5EBnVb3uuPMPM+NIGGdLogcuw9VcGBjUp89g6pTLuHQ2v eg==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2130.oracle.com with ESMTP id 3274urk8nw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 Jul 2020 18:47:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06GIbjRM096023;
	Thu, 16 Jul 2020 18:47:48 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3030.oracle.com with ESMTP id 327q0u0bu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2020 18:47:47 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06GIlkFW011728;
	Thu, 16 Jul 2020 18:47:46 GMT
Received: from paddy.uk.oracle.com (/10.175.173.87)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 16 Jul 2020 11:47:46 -0700
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Subject: [PATCH ndctl v1 8/8] daxctl: Allow restore devices from JSON metadata
Date: Thu, 16 Jul 2020 19:47:07 +0100
Message-Id: <20200716184707.23018-9-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200716184707.23018-1-joao.m.martins@oracle.com>
References: <20200716184707.23018-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9684 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007160131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9684 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 suspectscore=3 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007160131
Message-ID-Hash: 2465OSDYIIQZVXSKIYLMNFIFEZJ76BHQ
X-Message-ID-Hash: 2465OSDYIIQZVXSKIYLMNFIFEZJ76BHQ
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jason Zeng <jason.zeng@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2465OSDYIIQZVXSKIYLMNFIFEZJ76BHQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add an option namely --restore which passes a parameter
which is a JSON file path. The JSON file contains the
data usually returned by:

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

For purposes of RFC, the input values in the mapping json are decimal
for now. A device can then be created by specifying this same data
to restore it e.g.

	daxctl create-device -u --restore device.json
	{
	  "chardev":"dax0.1",
	  "size":"32.00 GiB (34.36 GB)",
	  "target_node":0,
	  "align":"1024.00 MiB (1073.74 MB)",
	  "mode":"devdax",
	  "mappings":[
	    {
	      "page_offset":"0x400000",
	      "start":"0x600000000",
	      "end":"0x9ffffffff",
	      "size":"16.00 GiB (17.18 GB)"
	    },
	    {
	      "page_offset":"0",
	      "start":"0x200000000",
	      "end":"0x5ffffffff",
	      "size":"16.00 GiB (17.18 GB)"
	    }
	  ]
	}

	created 1 device

This is handy as we are able to kexec and restore previously mappings
that we had established.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 daxctl/device.c | 129 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 124 insertions(+), 5 deletions(-)

diff --git a/daxctl/device.c b/daxctl/device.c
index 3a844462829b..fe34f0e44569 100644
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
+	const char *restore;
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
@@ -71,7 +79,9 @@ OPT_BOOLEAN('f', "force", &param.force, \
 
 #define CREATE_OPTIONS() \
 OPT_STRING('s', "size", &param.size, "size", "size to switch the device to"), \
-OPT_STRING('a', "align", &param.align, "align", "alignment to switch the device to")
+OPT_STRING('a', "align", &param.align, "align", "alignment to switch the device to"), \
+OPT_STRING('\0', "restore", &param.restore, "restore", \
+		"restore the device from device JSON")
 
 #define DESTROY_OPTIONS() \
 OPT_BOOLEAN('f', "force", &param.force, \
@@ -124,6 +134,94 @@ static const struct option destroy_options[] = {
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
@@ -213,6 +311,13 @@ static const char *parse_device_options(int argc, const char **argv,
 			align = __parse_size64(param.align, &units);
 		break;
 	case ACTION_CREATE:
+		if (param.restore &&
+		    (rc = parse_device_file(param.restore)) != 0) {
+			fprintf(stderr,
+				"error: failed to parse device file: %s\n",
+				strerror(-rc));
+			break;
+		}
 		if (param.size)
 			size = __parse_size64(param.size, &units);
 		if (param.align)
@@ -524,7 +629,8 @@ static int do_create(struct daxctl_region *region, long long val,
 {
 	struct json_object *jdev;
 	struct daxctl_dev *dev;
-	int rc = 0;
+	int i, rc = 0;
+	long long alloc = 0;
 
 	if (daxctl_region_create_dev(region))
 		return -ENOSPC;
@@ -545,9 +651,22 @@ static int do_create(struct daxctl_region *region, long long val,
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

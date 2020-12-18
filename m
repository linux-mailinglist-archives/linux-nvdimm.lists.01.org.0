Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 763C92DDCCF
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Dec 2020 03:15:04 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E82B2100EB324;
	Thu, 17 Dec 2020 18:15:02 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.79; helo=aserp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9DAD5100EB85D
	for <linux-nvdimm@lists.01.org>; Thu, 17 Dec 2020 18:15:00 -0800 (PST)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BI2E5j2070189;
	Fri, 18 Dec 2020 02:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=i9+hp0ynoCYWyuzNCYHjrATZU9rsLmvfD0HKd2ID5/0=;
 b=XXxY/52VNsr9TY8jNbOraEpY3IS0tvN/eeaqutNAXaZzyCUBcF0wRyPCyDjrBMEiiZks
 Mzfa8iGaXF/fCcnkSz8L4n1JsZZMdooVXCDPQCHb2SAPx59s1VY2lxyi//ut4i3eDHzq
 hGK9H7AR4UIPT9xtVwJ9Ue4n0o1aMWexpxduaBU1y976BUZJ34niz6OKsrGUhR8sPd3W
 p6lWZQc+Krl/8FJxLR/d5ZgcMR52FVJD09EGmWjsQ0lPrHQZoWrXyvOTFUZ1kNEMFQer
 wWVkYZx/y0l/dLwaKg/DhPjbsjohfUYOLwipvBhBPz6vGTNBQ8izVxfeL76jK5jEI5bZ gQ==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by aserp2130.oracle.com with ESMTP id 35ckcbrfx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 18 Dec 2020 02:14:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BI25KSV013798;
	Fri, 18 Dec 2020 02:14:58 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3030.oracle.com with ESMTP id 35d7erq72t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Dec 2020 02:14:58 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BI2EwBg021959;
	Fri, 18 Dec 2020 02:14:58 GMT
Received: from paddy.uk.oracle.com (/10.175.180.204)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 17 Dec 2020 18:14:57 -0800
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Subject: [PATCH daxctl v2 2/5] daxctl: include mappings when listing
Date: Fri, 18 Dec 2020 02:14:35 +0000
Message-Id: <20201218021438.8926-3-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201218021438.8926-1-joao.m.martins@oracle.com>
References: <20201218021438.8926-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9838 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012180012
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9838 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012180013
Message-ID-Hash: 6GATPF4BI4UUO3P7RD3FDBJJXWW6KGLN
X-Message-ID-Hash: 6GATPF4BI4UUO3P7RD3FDBJJXWW6KGLN
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6GATPF4BI4UUO3P7RD3FDBJJXWW6KGLN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Iterate over the device mappings and print @page_offset,
 @start, @end and a computed size, but only if user
 passes -M|--mappings to daxctl list as the output can
get verbose with a lot of mapping entries.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 Documentation/daxctl/daxctl-list.txt |  4 +++
 daxctl/list.c                        |  4 +++
 util/json.c                          | 57 +++++++++++++++++++++++++++++++++++-
 util/json.h                          |  4 +++
 4 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/Documentation/daxctl/daxctl-list.txt b/Documentation/daxctl/daxctl-list.txt
index cb82c3cc6fb2..5a6a98e73849 100644
--- a/Documentation/daxctl/daxctl-list.txt
+++ b/Documentation/daxctl/daxctl-list.txt
@@ -67,6 +67,10 @@ OPTIONS
 --devices::
 	Include device-dax instance info in the listing (default)
 
+-M::
+--mappings::
+	Include device-dax instance mappings info in the listing
+
 -R::
 --regions::
 	Include region info in the listing
diff --git a/daxctl/list.c b/daxctl/list.c
index 6c6251b4de37..6860a460e4c0 100644
--- a/daxctl/list.c
+++ b/daxctl/list.c
@@ -25,6 +25,7 @@
 static struct {
 	bool devs;
 	bool regions;
+	bool mappings;
 	bool idle;
 	bool human;
 } list;
@@ -35,6 +36,8 @@ static unsigned long listopts_to_flags(void)
 
 	if (list.devs)
 		flags |= UTIL_JSON_DAX_DEVS;
+	if (list.mappings)
+		flags |= UTIL_JSON_DAX_MAPPINGS;
 	if (list.idle)
 		flags |= UTIL_JSON_IDLE;
 	if (list.human)
@@ -70,6 +73,7 @@ int cmd_list(int argc, const char **argv, struct daxctl_ctx *ctx)
 				"filter by dax device instance name"),
 		OPT_BOOLEAN('D', "devices", &list.devs, "include dax device info"),
 		OPT_BOOLEAN('R', "regions", &list.regions, "include dax region info"),
+		OPT_BOOLEAN('M', "mappings", &list.mappings, "include dax mappings info"),
 		OPT_BOOLEAN('i', "idle", &list.idle, "include idle devices"),
 		OPT_BOOLEAN('u', "human", &list.human,
 				"use human friendly number formats "),
diff --git a/util/json.c b/util/json.c
index 357dff20d6be..dcc927294e4f 100644
--- a/util/json.c
+++ b/util/json.c
@@ -454,7 +454,8 @@ struct json_object *util_daxctl_dev_to_json(struct daxctl_dev *dev,
 {
 	struct daxctl_memory *mem = daxctl_dev_get_memory(dev);
 	const char *devname = daxctl_dev_get_devname(dev);
-	struct json_object *jdev, *jobj;
+	struct json_object *jdev, *jobj, *jmappings = NULL;
+	struct daxctl_mapping *mapping = NULL;
 	int node, movable, align;
 
 	jdev = json_object_new_object();
@@ -508,6 +509,25 @@ struct json_object *util_daxctl_dev_to_json(struct daxctl_dev *dev,
 			json_object_object_add(jdev, "state", jobj);
 	}
 
+	if (!(flags & UTIL_JSON_DAX_MAPPINGS))
+		return jdev;
+
+	daxctl_mapping_foreach(dev, mapping) {
+		struct json_object *jmapping;
+
+		if (!jmappings) {
+			jmappings = json_object_new_array();
+			if (!jmappings)
+				continue;
+
+			json_object_object_add(jdev, "mappings", jmappings);
+		}
+
+		jmapping = util_daxctl_mapping_to_json(mapping, flags);
+		if (!jmapping)
+			continue;
+		json_object_array_add(jmappings, jmapping);
+	}
 	return jdev;
 }
 
@@ -1357,6 +1377,41 @@ struct json_object *util_mapping_to_json(struct ndctl_mapping *mapping,
 	return NULL;
 }
 
+struct json_object *util_daxctl_mapping_to_json(struct daxctl_mapping *mapping,
+		unsigned long flags)
+{
+	struct json_object *jmapping = json_object_new_object();
+	struct json_object *jobj;
+
+	if (!jmapping)
+		return NULL;
+
+	jobj = util_json_object_hex(daxctl_mapping_get_offset(mapping), flags);
+	if (!jobj)
+		goto err;
+	json_object_object_add(jmapping, "page_offset", jobj);
+
+	jobj = util_json_object_hex(daxctl_mapping_get_start(mapping), flags);
+	if (!jobj)
+		goto err;
+	json_object_object_add(jmapping, "start", jobj);
+
+	jobj = util_json_object_hex(daxctl_mapping_get_end(mapping), flags);
+	if (!jobj)
+		goto err;
+	json_object_object_add(jmapping, "end", jobj);
+
+	jobj = util_json_object_size(daxctl_mapping_get_size(mapping), flags);
+	if (!jobj)
+		goto err;
+	json_object_object_add(jmapping, "size", jobj);
+
+	return jmapping;
+ err:
+	json_object_put(jmapping);
+	return NULL;
+}
+
 struct json_object *util_badblock_rec_to_json(u64 block, u64 count,
 		unsigned long flags)
 {
diff --git a/util/json.h b/util/json.h
index 39a33789bac9..e26875a5ecd8 100644
--- a/util/json.h
+++ b/util/json.h
@@ -15,6 +15,7 @@
 #include <stdio.h>
 #include <stdbool.h>
 #include <ndctl/libndctl.h>
+#include <daxctl/libdaxctl.h>
 #include <ccan/short_types/short_types.h>
 
 enum util_json_flags {
@@ -27,6 +28,7 @@ enum util_json_flags {
 	UTIL_JSON_CAPABILITIES	= (1 << 6),
 	UTIL_JSON_CONFIGURED	= (1 << 7),
 	UTIL_JSON_FIRMWARE	= (1 << 8),
+	UTIL_JSON_DAX_MAPPINGS	= (1 << 9),
 };
 
 struct json_object;
@@ -38,6 +40,8 @@ struct json_object *util_dimm_to_json(struct ndctl_dimm *dimm,
 		unsigned long flags);
 struct json_object *util_mapping_to_json(struct ndctl_mapping *mapping,
 		unsigned long flags);
+struct json_object *util_daxctl_mapping_to_json(struct daxctl_mapping *mapping,
+		unsigned long flags);
 struct json_object *util_namespace_to_json(struct ndctl_namespace *ndns,
 		unsigned long flags);
 struct json_object *util_badblock_rec_to_json(u64 block, u64 count,
-- 
1.8.3.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

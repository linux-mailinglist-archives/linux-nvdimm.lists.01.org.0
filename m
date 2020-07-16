Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B21E7222B37
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 Jul 2020 20:47:51 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DA83911571BF5;
	Thu, 16 Jul 2020 11:47:48 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 16CC411571BF3
	for <linux-nvdimm@lists.01.org>; Thu, 16 Jul 2020 11:47:47 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06GIcg3I059855;
	Thu, 16 Jul 2020 18:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=t2P2AIAk4ZNLW6HyD2mHfc2ay8bdG1XLlb49iW8oaZ8=;
 b=r3jAv9ItRPFqgvu53i0ldUZufjWhcwuq+paCnfnHIUFFmxkvextHGsrG0aFyf94/pCMy
 1Fg+sByylSmOgtxr/mWBVopJ2ucomQk/Q6c4nIZyHi1SBPm0C1PRrlNAeXLqiG9qibYB
 WJDCdCW6LmMAbb0KsI9az9pTjhybZ5ZXVCmljh9zckyskXUESSgIVV6jS0ecfSpUxlh7
 Qak9lZFpd4YVHOu7U+65yw/1kQvZzmWMY2nua0MRARyhQD54HkNbTyPM6tTSPzeL4H/i
 8bUSBfvVInTVRfK4fsfhibpaRtjtS1SkQ0xSX2I8xRKhwBd73squeVIYVSNY5J14WOIq Ew==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2130.oracle.com with ESMTP id 3274urk8n9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 Jul 2020 18:47:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06GIbisM163891;
	Thu, 16 Jul 2020 18:47:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3020.oracle.com with ESMTP id 327qbc787e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2020 18:47:43 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06GIlhva000567;
	Thu, 16 Jul 2020 18:47:43 GMT
Received: from paddy.uk.oracle.com (/10.175.173.87)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 16 Jul 2020 11:47:43 -0700
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH ndctl v1 6/8] daxctl: include mappings when listing
Date: Thu, 16 Jul 2020 19:47:05 +0100
Message-Id: <20200716184707.23018-7-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200716184707.23018-1-joao.m.martins@oracle.com>
References: <20200716184707.23018-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9684 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 spamscore=0 phishscore=0 suspectscore=1 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007160131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9684 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 suspectscore=1 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007160131
Message-ID-Hash: 6J2LKZTNW3BYXJHNEJRNF5PJ2UKQJOZJ
X-Message-ID-Hash: 6J2LKZTNW3BYXJHNEJRNF5PJ2UKQJOZJ
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6J2LKZTNW3BYXJHNEJRNF5PJ2UKQJOZJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Iterate over the device mappings and print @page_offset,
 @start, @end and a computed size.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
Perhaps hiding it behind a -v|--verbose?
---
 util/json.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 util/json.h |  3 +++
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/util/json.c b/util/json.c
index 4d9787381d6b..c814298ad0dc 100644
--- a/util/json.c
+++ b/util/json.c
@@ -277,7 +277,8 @@ struct json_object *util_daxctl_dev_to_json(struct daxctl_dev *dev,
 {
 	struct daxctl_memory *mem = daxctl_dev_get_memory(dev);
 	const char *devname = daxctl_dev_get_devname(dev);
-	struct json_object *jdev, *jobj;
+	struct json_object *jdev, *jobj, *jmappings = NULL;
+	struct daxctl_mapping *mapping = NULL;
 	int node, movable, align;
 
 	jdev = json_object_new_object();
@@ -331,6 +332,22 @@ struct json_object *util_daxctl_dev_to_json(struct daxctl_dev *dev,
 			json_object_object_add(jdev, "state", jobj);
 	}
 
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
 
@@ -1180,6 +1197,41 @@ struct json_object *util_mapping_to_json(struct ndctl_mapping *mapping,
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
index 6d39d3aa4693..c32074939068 100644
--- a/util/json.h
+++ b/util/json.h
@@ -15,6 +15,7 @@
 #include <stdio.h>
 #include <stdbool.h>
 #include <ndctl/libndctl.h>
+#include <daxctl/libdaxctl.h>
 #include <ccan/short_types/short_types.h>
 
 enum util_json_flags {
@@ -36,6 +37,8 @@ struct json_object *util_dimm_to_json(struct ndctl_dimm *dimm,
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

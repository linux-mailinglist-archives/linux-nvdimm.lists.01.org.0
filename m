Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC312DC937
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Dec 2020 23:48:55 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C1C8B100EBB6E;
	Wed, 16 Dec 2020 14:48:53 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3416E100EBB6E
	for <linux-nvdimm@lists.01.org>; Wed, 16 Dec 2020 14:48:51 -0800 (PST)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGMicVb066012;
	Wed, 16 Dec 2020 22:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=XZbzwTXaiQTpHDUeesyrTUXf0qLJLCr6qUqVFjKldRM=;
 b=FycuOJmHnDmL9pyGIU+xgcNud4x3DKaAoNEcqy6ahQX57FCcbPe2+ikWP0Kneiys6AkO
 FL62Yq8+ioqcKveIYkUCBJqE3Ts0SMqtXDdTJklF8dt0duPTUKndeP0njIzlYvm02lSE
 7ftdXnMF3jINB/O1MN7xwsM9QZhXhO8m+LmFfYR7vtyCGHnvR5CqQTqzQlOr0ewodE4J
 /Osh/rYv52tqqr2kyU0H/Xhs+Tc1Ad5/b+BpNLsyaa0Fd/iJakVDX9rWIpe/EbN9ZGNw
 MQjncxOfg0/oXJcUnfG5K5fX7vUGm737JPyGup0UDCOhryH/MLFoHnaNfwiIEYKREBOB sQ==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2130.oracle.com with ESMTP id 35cn9rjtr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Dec 2020 22:48:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGMjGwB062346;
	Wed, 16 Dec 2020 22:48:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3030.oracle.com with ESMTP id 35d7eq5273-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Dec 2020 22:48:48 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BGMmmkt003059;
	Wed, 16 Dec 2020 22:48:48 GMT
Received: from paddy.uk.oracle.com (/10.175.172.71)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 16 Dec 2020 14:48:47 -0800
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Subject: [PATCH daxctl v2 2/5] util/json: Print device align
Date: Wed, 16 Dec 2020 22:48:30 +0000
Message-Id: <20201216224833.6229-3-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201216224833.6229-1-joao.m.martins@oracle.com>
References: <20201216224833.6229-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012160141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160141
Message-ID-Hash: 4TZJ7YR6JL3ODS6T2IZJWRAANSJDAMRT
X-Message-ID-Hash: 4TZJ7YR6JL3ODS6T2IZJWRAANSJDAMRT
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4TZJ7YR6JL3ODS6T2IZJWRAANSJDAMRT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Fetch device align and include it on listings.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 util/json.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/util/json.c b/util/json.c
index 77bd4781551d..357dff20d6be 100644
--- a/util/json.c
+++ b/util/json.c
@@ -455,7 +455,7 @@ struct json_object *util_daxctl_dev_to_json(struct daxctl_dev *dev,
 	struct daxctl_memory *mem = daxctl_dev_get_memory(dev);
 	const char *devname = daxctl_dev_get_devname(dev);
 	struct json_object *jdev, *jobj;
-	int node, movable;
+	int node, movable, align;
 
 	jdev = json_object_new_object();
 	if (!devname || !jdev)
@@ -476,6 +476,13 @@ struct json_object *util_daxctl_dev_to_json(struct daxctl_dev *dev,
 			json_object_object_add(jdev, "target_node", jobj);
 	}
 
+	align = daxctl_dev_get_align(dev);
+	if (align > 0) {
+		jobj = util_json_object_size(daxctl_dev_get_align(dev), flags);
+		if (jobj)
+			json_object_object_add(jdev, "align", jobj);
+	}
+
 	if (mem)
 		jobj = json_object_new_string("system-ram");
 	else
-- 
1.8.3.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

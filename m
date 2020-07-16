Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C5A222B32
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 Jul 2020 20:47:46 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6A27211078326;
	Thu, 16 Jul 2020 11:47:43 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C7A1A11078320
	for <linux-nvdimm@lists.01.org>; Thu, 16 Jul 2020 11:47:40 -0700 (PDT)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06GIb28w145415;
	Thu, 16 Jul 2020 18:47:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=oO/NCJa1NM2AEyBMOoJYFiIR4tLvVx5LwL/Nn7xIoaw=;
 b=aQlDMZAC+mX06h5v+MtHgBEG9UfRa1J1G78gB3iDJX6A7L+hQAVrrBuVZUOWZPUhNTqo
 IyBKhHFcefn5fXGTVebWMwwEj/hSssrxVQc2xJaZQ/mQwzDnEoZkUdFGxbUSGmU6rAXc
 IcXPqf2BNcggjYPtdekRbe79d7uSmpalnSF4r4z9FRFaz3zeyOHS69hhRis0doU8/utt
 Xgdi6MYt40bnVlds+fl9I9gop3dYmPI5KQR8J3VWSw2a8Mrpolk2GCcFsht6GK1bthAY
 UdLz2+7sV/7F7i15MDQrDEZiHz+GpyB4H3fplQxdHOcMXYQYHIJeRQRqGOhXVx33Q+RA Dg==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by aserp2120.oracle.com with ESMTP id 3275cmk6jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 Jul 2020 18:47:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06GIbhFf163601;
	Thu, 16 Jul 2020 18:47:38 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3020.oracle.com with ESMTP id 327qbc77y0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2020 18:47:38 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06GIlbfm025607;
	Thu, 16 Jul 2020 18:47:37 GMT
Received: from paddy.uk.oracle.com (/10.175.173.87)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 16 Jul 2020 11:47:37 -0700
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH ndctl v1 2/8] util/json: Print device align
Date: Thu, 16 Jul 2020 19:47:01 +0100
Message-Id: <20200716184707.23018-3-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200716184707.23018-1-joao.m.martins@oracle.com>
References: <20200716184707.23018-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9684 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 spamscore=0 phishscore=0 suspectscore=1 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007160131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9684 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007160131
Message-ID-Hash: MTVEQ52AQNSS7VOLB4HH3XAWIL2G6WRX
X-Message-ID-Hash: MTVEQ52AQNSS7VOLB4HH3XAWIL2G6WRX
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MTVEQ52AQNSS7VOLB4HH3XAWIL2G6WRX/>
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
index 21ab25674624..4d9787381d6b 100644
--- a/util/json.c
+++ b/util/json.c
@@ -278,7 +278,7 @@ struct json_object *util_daxctl_dev_to_json(struct daxctl_dev *dev,
 	struct daxctl_memory *mem = daxctl_dev_get_memory(dev);
 	const char *devname = daxctl_dev_get_devname(dev);
 	struct json_object *jdev, *jobj;
-	int node, movable;
+	int node, movable, align;
 
 	jdev = json_object_new_object();
 	if (!devname || !jdev)
@@ -299,6 +299,13 @@ struct json_object *util_daxctl_dev_to_json(struct daxctl_dev *dev,
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

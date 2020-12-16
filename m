Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1862DC939
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Dec 2020 23:48:59 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 00FEA100EBB74;
	Wed, 16 Dec 2020 14:48:58 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C4DB0100EBBD1
	for <linux-nvdimm@lists.01.org>; Wed, 16 Dec 2020 14:48:55 -0800 (PST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGMiB5B059573;
	Wed, 16 Dec 2020 22:48:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=wAQw+4QInu6tOFOABusdsR0LsPM8ejMpk0WBflQiKuw=;
 b=OTuyim1kgEC/aF6+JvIIcwbjNqW6U5Vmd3gSItRae6nx1xgk4As6EsBgYiWAWaSoPPZJ
 lnWCrh7pdl95zkFN5g5PM5VnwwjztOnpBF+YeOOm67LGBzaSloyZk0jpi8hRU04tU3YJ
 8wyJltbJUCZQE/ZsfrUITqBvQxnzxMyZo3JJnsqwlmUNjw01vJvR+WOYgC3rYPBv0KeT
 03q5oxMaAxnttUtxm/HXxphYkQNYsWrQEauQEKylLQ8kC0GGh5FZ7hSVuyuJ0WKT2HY3
 liyXFR9dOMXCZPJE1M4peFgdt+TzfFu3LEQSEcuzJ/wY/oS6i2vFYrUYTd++tukPAcTX OA==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by aserp2120.oracle.com with ESMTP id 35cntmarvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Dec 2020 22:48:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGMjGet062233;
	Wed, 16 Dec 2020 22:48:53 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by aserp3030.oracle.com with ESMTP id 35d7eq528q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Dec 2020 22:48:53 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BGMmqts017711;
	Wed, 16 Dec 2020 22:48:52 GMT
Received: from paddy.uk.oracle.com (/10.175.172.71)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 16 Dec 2020 14:48:51 -0800
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Subject: [PATCH daxctl v2 4/5] daxctl: add align support in create-device
Date: Wed, 16 Dec 2020 22:48:32 +0000
Message-Id: <20201216224833.6229-5-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201216224833.6229-1-joao.m.martins@oracle.com>
References: <20201216224833.6229-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012160141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012160141
Message-ID-Hash: D3POIO75LANG6BV2EZAPAZOITVQNH5KN
X-Message-ID-Hash: D3POIO75LANG6BV2EZAPAZOITVQNH5KN
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/D3POIO75LANG6BV2EZAPAZOITVQNH5KN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Allow changing devices alignment when creating
a new child device.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 Documentation/daxctl/daxctl-create-device.txt | 8 ++++++++
 daxctl/device.c                               | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/daxctl/daxctl-create-device.txt b/Documentation/daxctl/daxctl-create-device.txt
index 648d2541f833..adc7b395125e 100644
--- a/Documentation/daxctl/daxctl-create-device.txt
+++ b/Documentation/daxctl/daxctl-create-device.txt
@@ -87,6 +87,14 @@ OPTIONS
 
 	The size must be a multiple of the region alignment.
 
+-a::
+--align::
+	Applications that want to establish dax memory mappings with
+	page table entries greater than system base page size (4K on
+	x86) need a device that is sufficiently aligned. This defaults
+	to 2M. Note that "devdax" mode enforces all mappings to be
+	aligned to this value, i.e. it fails unaligned mapping attempts.
+
 -u::
 --human::
 	By default the command will output machine-friendly raw-integer
diff --git a/daxctl/device.c b/daxctl/device.c
index a5394577908d..3c2d4e3d8b48 100644
--- a/daxctl/device.c
+++ b/daxctl/device.c
@@ -216,6 +216,8 @@ static const char *parse_device_options(int argc, const char **argv,
 	case ACTION_CREATE:
 		if (param.size)
 			size = __parse_size64(param.size, &units);
+		if (param.align)
+			align = __parse_size64(param.align, &units);
 		/* fall through */
 	case ACTION_ONLINE:
 		if (param.no_movable)
@@ -538,6 +540,12 @@ static int do_create(struct daxctl_region *region, long long val,
 	if (val <= 0)
 		return -ENOSPC;
 
+	if (align > 0) {
+		rc = daxctl_dev_set_align(dev, align);
+		if (rc < 0)
+			return rc;
+	}
+
 	rc = daxctl_dev_set_size(dev, val);
 	if (rc < 0)
 		return rc;
-- 
1.8.3.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

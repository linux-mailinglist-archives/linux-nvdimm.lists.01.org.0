Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D97ED222B34
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 Jul 2020 20:47:48 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9D76811571BED;
	Thu, 16 Jul 2020 11:47:44 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CF6FE11078320
	for <linux-nvdimm@lists.01.org>; Thu, 16 Jul 2020 11:47:41 -0700 (PDT)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06GIb2mj145391;
	Thu, 16 Jul 2020 18:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=BsagXx+EkIVuvdKfzPULeXePpGdW9sRMAiW64NoPUjw=;
 b=JCXfRDTvgoxYpZgN7CEZxBYwItO/BnFYzAMzP0dB7zHO/UWle4zPmvlb5DKQeonYtEBz
 jmKVkXhfWf3EuFHvp+f6G/80HqTj9mFdxZAgqwCWeykCUbRwKggjeo+rvK2B7ySkh/uC
 CgjUs3gbi9jozJAPzvjk8Uj1qESxP+RxXMIQ37FowyXA/E//NrvAmft46M33qh1ap8Xx
 sxVaYpna1gRD/hcTmXqFWoChMJFbxFUp8k7SDasLEsafov11ESsvxF5Oq/Rt1USTHAV+
 dOGI8A5KvOrzJpefkJRHcPVcTlLDn/S9MTyt3OVSVD/UlflRw4KpZgaUZHOaacWfSw35 Vg==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by aserp2120.oracle.com with ESMTP id 3275cmk6k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 Jul 2020 18:47:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06GIbiOg163822;
	Thu, 16 Jul 2020 18:47:39 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3020.oracle.com with ESMTP id 327qbc7818-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2020 18:47:39 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06GIldJn025612;
	Thu, 16 Jul 2020 18:47:39 GMT
Received: from paddy.uk.oracle.com (/10.175.173.87)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 16 Jul 2020 11:47:38 -0700
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH ndctl v1 3/8] daxctl: add align support in reconfigure-device
Date: Thu, 16 Jul 2020 19:47:02 +0100
Message-Id: <20200716184707.23018-4-joao.m.martins@oracle.com>
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
Message-ID-Hash: 7UPGFWF4SNBEIYNGGJRE634GZXKYV2QN
X-Message-ID-Hash: 7UPGFWF4SNBEIYNGGJRE634GZXKYV2QN
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7UPGFWF4SNBEIYNGGJRE634GZXKYV2QN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add an alignment option to reconfigure-device and use the newly added
libdaxctl API to set the alignment of the device prior to setting size.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 daxctl/device.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/daxctl/device.c b/daxctl/device.c
index 05293d6c38ee..9d82ea12aca2 100644
--- a/daxctl/device.c
+++ b/daxctl/device.c
@@ -22,6 +22,7 @@ static struct {
 	const char *mode;
 	const char *region;
 	const char *size;
+	const char *align;
 	bool no_online;
 	bool no_movable;
 	bool force;
@@ -36,6 +37,7 @@ enum dev_mode {
 };
 
 static enum dev_mode reconfig_mode = DAXCTL_DEV_MODE_UNKNOWN;
+static long long align = -1;
 static long long size = -1;
 static unsigned long flags;
 
@@ -68,7 +70,8 @@ OPT_BOOLEAN('f', "force", &param.force, \
 		"attempt to offline memory sections before reconfiguration")
 
 #define CREATE_OPTIONS() \
-OPT_STRING('s', "size", &param.size, "size", "size to switch the device to")
+OPT_STRING('s', "size", &param.size, "size", "size to switch the device to"), \
+OPT_STRING('a', "align", &param.align, "align", "alignment to switch the device to")
 
 #define DESTROY_OPTIONS() \
 OPT_BOOLEAN('f', "force", &param.force, \
@@ -185,8 +188,10 @@ static const char *parse_device_options(int argc, const char **argv,
 	/* Handle action-specific options */
 	switch (action) {
 	case ACTION_RECONFIG:
-		if (!param.size && !param.mode) {
-			fprintf(stderr, "error: a 'mode' or 'size' option is required\n");
+		if (!param.size &&
+		    !param.align &&
+		    !param.mode) {
+			fprintf(stderr, "error: a 'align', 'mode' or 'size' option is required\n");
 			usage_with_options(u, reconfig_options);
 			rc = -EINVAL;
 		}
@@ -204,6 +209,8 @@ static const char *parse_device_options(int argc, const char **argv,
 				rc =  -EINVAL;
 			}
 		}
+		if (param.align)
+			align = __parse_size64(param.align, &units);
 		break;
 	case ACTION_CREATE:
 		if (param.size)
@@ -558,6 +565,12 @@ static int do_reconfig(struct daxctl_dev *dev, enum dev_mode mode,
 	struct json_object *jdev;
 	int rc = 0;
 
+	if (align > 0) {
+		rc = daxctl_dev_set_align(dev, align);
+		if (rc < 0)
+			return rc;
+	}
+
 	if (size >= 0) {
 		rc = dev_resize(dev, size);
 		return rc;
-- 
1.8.3.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

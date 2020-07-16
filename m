Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0FC222B35
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 Jul 2020 20:47:50 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B514611571BEC;
	Thu, 16 Jul 2020 11:47:46 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2654011078321
	for <linux-nvdimm@lists.01.org>; Thu, 16 Jul 2020 11:47:43 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06GIcDXu059674;
	Thu, 16 Jul 2020 18:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=aBSi1lpzBMIY87jld3MWKzOCHTPvU/b8jx1r4Uu5aNQ=;
 b=NmBRkEnfFyUOud7vqUO+AyxcwW4MXodOtixCuexmM5/VUwamJSfHKOcDWHFnCSFgs4bh
 OrkP9NNYE0Np4515aRJ7vY5YeeKMmy2MDnCVhhCAQwv43ZwyhVXtFbCpp5E1Np0+jbo9
 jM7xxsbsnCN4mJ4Tlj4iEX8ncFpKBb76KPdxxWclY77RLpgwhsLANwBilCYMRELHJsuV
 hoP/aYChd8us6oaiIq0DM6F1UyP5gtgxYomTrcshlpUPUqtmv+BCSSYBw751yLn1dy/5
 /PjG5oBsqIqGRqlGfz3J2IhwFoKzXY5q4jXaJjNUi/6JLhZxg5TewiAFDrfMDZL6t1qG Mg==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2130.oracle.com with ESMTP id 3274urk8mx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 Jul 2020 18:47:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06GIbmZ4167687;
	Thu, 16 Jul 2020 18:47:41 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userp3020.oracle.com with ESMTP id 32akr3vv3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2020 18:47:41 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06GIlefO011692;
	Thu, 16 Jul 2020 18:47:40 GMT
Received: from paddy.uk.oracle.com (/10.175.173.87)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 16 Jul 2020 11:47:40 -0700
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH ndctl v1 4/8] daxctl: add align support in create-device
Date: Thu, 16 Jul 2020 19:47:03 +0100
Message-Id: <20200716184707.23018-5-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200716184707.23018-1-joao.m.martins@oracle.com>
References: <20200716184707.23018-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9684 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=1 mlxlogscore=999 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007160131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9684 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 suspectscore=1 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007160131
Message-ID-Hash: UN4PZ4WUZ6H4XRM42B6HVZ3WWIYSZ5BU
X-Message-ID-Hash: UN4PZ4WUZ6H4XRM42B6HVZ3WWIYSZ5BU
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UN4PZ4WUZ6H4XRM42B6HVZ3WWIYSZ5BU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

And thus allow changing devices alignment when creating
a new child device.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 daxctl/device.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/daxctl/device.c b/daxctl/device.c
index 9d82ea12aca2..3a844462829b 100644
--- a/daxctl/device.c
+++ b/daxctl/device.c
@@ -215,6 +215,8 @@ static const char *parse_device_options(int argc, const char **argv,
 	case ACTION_CREATE:
 		if (param.size)
 			size = __parse_size64(param.size, &units);
+		if (param.align)
+			align = __parse_size64(param.align, &units);
 		/* fall through */
 	case ACTION_ONLINE:
 		if (param.no_movable)
@@ -537,6 +539,12 @@ static int do_create(struct daxctl_region *region, long long val,
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

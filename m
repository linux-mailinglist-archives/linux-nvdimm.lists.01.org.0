Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E16C321DB3C
	for <lists+linux-nvdimm@lfdr.de>; Mon, 13 Jul 2020 18:09:03 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3BA80118128FB;
	Mon, 13 Jul 2020 09:09:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6BC3A118128FA
	for <linux-nvdimm@lists.01.org>; Mon, 13 Jul 2020 09:08:59 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DG2oGV153718;
	Mon, 13 Jul 2020 16:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=lpVMQgHXWEwziqNXeWi4pHdjy+sddg5bwh4bUJlXqI0=;
 b=Hi2uKJpgJ/H+RdEBXP78eHFnDchCgSFJ/eGAxtPjzYTDNqMPnDPb8azXpZCvXMoZokqB
 YuYq6ffGO8MxesuUS9olZYLJEg+uVmoSXEq9P0ymTTF2XmjXxS+TK71LCRGdkhwJkE9d
 /P1Wob6fB1oXPw5d2Q2KEEhow6y/d8JAMy25Zgwph00Ii/4wRiw0DX0CDj4s/XaYqIOq
 oTuoCnT98WVyt+CU902dRwcsdD/QbcM5lREPjm7QaC4H+s7GcsFxEthz/GlJoJ9RYX5G
 KJq6KVC+IV0eeTdiWLB2bM8fvnL/302pQp5EzbCv9sX4plADB2EpTWABRMYQ3LkIww9u TQ==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2120.oracle.com with ESMTP id 32762n7v1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Jul 2020 16:08:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DG3XUk138226;
	Mon, 13 Jul 2020 16:08:56 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3030.oracle.com with ESMTP id 327q0mhxb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2020 16:08:56 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06DG8tlq027581;
	Mon, 13 Jul 2020 16:08:55 GMT
Received: from paddy.uk.oracle.com (/10.175.167.147)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 13 Jul 2020 09:08:54 -0700
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH ndctl v2 01/10] daxctl: Cleanup whitespace
Date: Mon, 13 Jul 2020 17:08:28 +0100
Message-Id: <20200713160837.13774-2-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200713160837.13774-1-joao.m.martins@oracle.com>
References: <20200713160837.13774-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 suspectscore=1 phishscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130119
Message-ID-Hash: 3C2OPXCRKSYRRMGDTVOZGGASKOQN6MJK
X-Message-ID-Hash: 3C2OPXCRKSYRRMGDTVOZGGASKOQN6MJK
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3C2OPXCRKSYRRMGDTVOZGGASKOQN6MJK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Dan Williams <dan.j.williams@intel.com>

Re-indent util_daxctl_region_filter() to match expectations.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 util/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/filter.c b/util/filter.c
index af72793929e2..7d0159f8cef6 100644
--- a/util/filter.c
+++ b/util/filter.c
@@ -344,7 +344,7 @@ struct daxctl_region *util_daxctl_region_filter(struct daxctl_region *region,
 		return region;
 
 	if ((sscanf(ident, "%d", &region_id) == 1
-       || sscanf(ident, "region%d", &region_id) == 1)
+				|| sscanf(ident, "region%d", &region_id) == 1)
 			&& daxctl_region_get_id(region) == region_id)
 		return region;
 
-- 
1.8.3.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

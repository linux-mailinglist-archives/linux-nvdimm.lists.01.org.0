Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6AC2DDCD2
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Dec 2020 03:15:12 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2710F100EB327;
	Thu, 17 Dec 2020 18:15:11 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 594F3100EB85D
	for <linux-nvdimm@lists.01.org>; Thu, 17 Dec 2020 18:15:08 -0800 (PST)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BI2EeT3110085;
	Fri, 18 Dec 2020 02:15:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=QSAlX6peOVryBnEhb24N/QLanHIAnoP2De/C9296E54=;
 b=iQNDy0v7ghwJkxFRbNaZtHBfFBVC3a/MzJ22NHrtmkOASC6amIMBK6yBwIxTymTMy0/m
 oLF8Z6bE/pkqyPsT3b5B7gO5HInKZivz5S4+9umXsDpUo+x7LK9H0wW1ltXqhjZelVGo
 27vLg9yH6kcKE0KLRWhROlpVy2GT+Lcuu0LZzSC2cgoL+HVuFMy2eZD20y276r2oDxq9
 KY8NZ2SZ4dLzsxATGhiyyDEjOzwW7kExnkiNis+gu3P0mMVcerYD1HTAdQt9f/E2u2ON
 WD0HfeQXIUcwNI2qJrGX3JDv2hmTbCuAkg0cQCIv1JiVcDLMvrNFAZTX58uCwdOjb4Pj TQ==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2130.oracle.com with ESMTP id 35cn9rrb04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 18 Dec 2020 02:15:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BI25Jg4101608;
	Fri, 18 Dec 2020 02:15:06 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by aserp3020.oracle.com with ESMTP id 35e6eu4b2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Dec 2020 02:15:06 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BI2F5VK014367;
	Fri, 18 Dec 2020 02:15:05 GMT
Received: from paddy.uk.oracle.com (/10.175.180.204)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 17 Dec 2020 18:15:04 -0800
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Subject: [PATCH daxctl v2 5/5] daxctl/test: add a test for daxctl-create with input file
Date: Fri, 18 Dec 2020 02:14:38 +0000
Message-Id: <20201218021438.8926-6-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201218021438.8926-1-joao.m.martins@oracle.com>
References: <20201218021438.8926-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9838 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012180012
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9838 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012180013
Message-ID-Hash: LJMZU6D5YYIIAVJQ2ZRPJFBNB3AH7XDI
X-Message-ID-Hash: LJMZU6D5YYIIAVJQ2ZRPJFBNB3AH7XDI
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LJMZU6D5YYIIAVJQ2ZRPJFBNB3AH7XDI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The test creates a multi-range device (4 mappings) using the
same setup as one of the tests. Afterwards we validate that
the size/nr-mappings are the same as the original test.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 test/daxctl-create.sh | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/test/daxctl-create.sh b/test/daxctl-create.sh
index 41d5ba5888f7..e1d733916851 100755
--- a/test/daxctl-create.sh
+++ b/test/daxctl-create.sh
@@ -199,6 +199,7 @@ daxctl_test_multi()
 daxctl_test_multi_reconfig()
 {
 	local ncfgs=$1
+	local dump=$2
 	local daxdev
 
 	size=$((available / ncfgs))
@@ -226,6 +227,10 @@ daxctl_test_multi_reconfig()
 	test "$(daxctl_get_nr_mappings "$testdev")" -eq $((ncfgs / 2))
 	test "$(daxctl_get_nr_mappings "$daxdev_1")" -eq $((ncfgs / 2))
 
+	if [[ $dump ]]; then
+		"$DAXCTL" list -M -d "$daxdev_1" | jq -er '.[]' > $dump
+	fi
+
 	fail_if_available
 
 	"$DAXCTL" disable-device "$daxdev_1" && "$DAXCTL" destroy-device "$daxdev_1"
@@ -328,7 +333,7 @@ daxctl_test3()
 # pick at the end of the region
 daxctl_test4()
 {
-	daxctl_test_multi_reconfig 8
+	daxctl_test_multi_reconfig 8 ""
 	clear_dev
 	test_pass
 }
@@ -371,6 +376,29 @@ daxctl_test6()
 	test_pass
 }
 
+# Test 7: input device
+# Successfully creates a device with an input file from the multi-range
+# device test, and checking that we have the same number of mappings/size.
+daxctl_test7()
+{
+	daxctl_test_multi_reconfig 8 "input.json"
+
+	# The parameter should parse the region_id from the chardev entry
+	# therefore using the same region_id as test4
+	daxdev_1=$("$DAXCTL" create-device --input input.json | jq -er '.[].chardev')
+
+	# Validate if it's the same mappings as done by test4
+	# It also validates the size computed from the mappings
+	# A zero value means it failed, and four mappings is what's
+	# created by daxctl_test4
+	test "$(daxctl_get_nr_mappings "$daxdev_1")" -eq 4
+
+	"$DAXCTL" disable-device "$daxdev_1" && "$DAXCTL" destroy-device "$daxdev_1"
+
+	clear_dev
+	test_pass
+}
+
 find_testdev
 rc=1
 setup_dev
@@ -381,5 +409,6 @@ daxctl_test3
 daxctl_test4
 daxctl_test5
 daxctl_test6
+daxctl_test7
 reset_dev
 exit 0
-- 
1.8.3.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

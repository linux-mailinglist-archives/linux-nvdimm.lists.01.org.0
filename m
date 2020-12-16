Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C67F2DC93A
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Dec 2020 23:49:01 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 310D4100EBB7E;
	Wed, 16 Dec 2020 14:49:00 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.79; helo=aserp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5B621100EBB7D
	for <linux-nvdimm@lists.01.org>; Wed, 16 Dec 2020 14:48:58 -0800 (PST)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGMhuRi019507;
	Wed, 16 Dec 2020 22:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=Z8wNzpdqIek7YIWH57hOp04dnlIzX9QH7xitsoR+9Ls=;
 b=qo9IZDTEGgUHwx3z373vBrNNjt66DH1r7PDdRQROynOEtUKXyeb3wvaEuTWby6PThYvI
 +j1pZguyiQNO1B5j/FhEL8iR15sKeVxQZVPfJJ2C24BW2LNknmiFcvKzJvCf/AHka3mP
 Q0NiVLJgcC4rU4kta+EZ+wI38VWSHcqvn5BjtrteGRz9g+O2vaxFWCbawykutrxdwgeE
 oJfwbq5TncR7/MxjMpZSsY/lEU3hfekmrEL4fQhs1KL1d06eR8RyZr5RFJ52cUBDhel6
 s4faUsypautHkFLOEkXqBr4rw3fD8AELX8slQI7Yawy6nYhie2MmZ9Ktc1XCEFKmJyqD ow==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by aserp2130.oracle.com with ESMTP id 35ckcbjyta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Dec 2020 22:48:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGMjGsZ062302;
	Wed, 16 Dec 2020 22:48:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3030.oracle.com with ESMTP id 35d7eq529e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Dec 2020 22:48:55 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BGMmsni000710;
	Wed, 16 Dec 2020 22:48:54 GMT
Received: from paddy.uk.oracle.com (/10.175.172.71)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 16 Dec 2020 14:48:54 -0800
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Subject: [PATCH daxctl v2 5/5] daxctl/test: Add a test for daxctl-create with align
Date: Wed, 16 Dec 2020 22:48:33 +0000
Message-Id: <20201216224833.6229-6-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201216224833.6229-1-joao.m.martins@oracle.com>
References: <20201216224833.6229-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=940 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012160141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=951
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160141
Message-ID-Hash: 6JTNT3TQ3WE2GYMZTSAMKOPL63QEUWCT
X-Message-ID-Hash: 6JTNT3TQ3WE2GYMZTSAMKOPL63QEUWCT
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6JTNT3TQ3WE2GYMZTSAMKOPL63QEUWCT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a test which uses the newly added --align property
which allows a device created with daxctl create-device
to select its page size. If the available size is bigger
than 1G then use 1G as page size, otherwise use 2M.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 test/daxctl-create.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/test/daxctl-create.sh b/test/daxctl-create.sh
index 0d35112b4119..5598e5a89aaf 100755
--- a/test/daxctl-create.sh
+++ b/test/daxctl-create.sh
@@ -281,6 +281,34 @@ daxctl_test5()
 	test_pass
 }
 
+# Test 6: align
+# Successfully creates a device with a align property
+daxctl_test6()
+{
+	local daxdev
+	local align
+	local size
+
+	# Available size
+	size=$available
+
+	# Use 2M by default or 1G if supported
+	align=2097152
+	if [[ $((available >= 1073741824 )) ]]; then
+		align=1073741824
+		size=$align
+	fi
+
+	daxdev=$("$DAXCTL" create-device -r 0 -s $size -a $align | jq -er '.[].chardev')
+
+	test -n "$daxdev"
+
+	"$DAXCTL" disable-device "$daxdev" && "$DAXCTL" destroy-device "$daxdev"
+
+	clear_dev
+	test_pass
+}
+
 find_testdev
 rc=1
 setup_dev
@@ -290,5 +318,6 @@ daxctl_test2
 daxctl_test3
 daxctl_test4
 daxctl_test5
+daxctl_test6
 reset_dev
 exit 0
-- 
1.8.3.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

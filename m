Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7135123B04F
	for <lists+linux-nvdimm@lfdr.de>; Tue,  4 Aug 2020 00:41:58 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 83FBB129CD3B0;
	Mon,  3 Aug 2020 15:41:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=jane.chu@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 80F4D129CD37B
	for <linux-nvdimm@lists.01.org>; Mon,  3 Aug 2020 15:41:54 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 073MbQVp072566;
	Mon, 3 Aug 2020 22:41:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=lFsx27GcMAb6M+HPbhV7YgCeHD9h46fDEAYwzzxawRY=;
 b=KL8cTaCZbKMpTXoTjUQ0Dn9Dt/bgySKmrn7zt6fTe1R7oIF4vC+O/HK7gjt8oFMfiivT
 lKG27MtYue9kOE/AoqP6nJfAv4k2pqDzRGqtPk16Z+x5NHZAcXw7N+FS8O1WZphMc3gq
 6Xa4CUqMFhrN0YLnZj0CssaOvyZ9/YJQUv2oRqrqn2QOWNjDEmkN1uv/e3mgxfoffrNW
 wODbIjyiKVyDYGb+fe8s881po36GasIn6Pdy15Pu14nLwWlej5d+/pkZhC73z7cbTkMK
 PKgJrreYLFTxMl1nhonQ4f35q0zzzqqBznWhpTXfe3eZJxu9WLGHP/cVyZh0TNuUJUiu Sg==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2130.oracle.com with ESMTP id 32pdnq4dts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 03 Aug 2020 22:41:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 073McntC063213;
	Mon, 3 Aug 2020 22:41:51 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3020.oracle.com with ESMTP id 32pdnp07d9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Aug 2020 22:41:51 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 073Mfo26026448;
	Mon, 3 Aug 2020 22:41:50 GMT
Received: from brm-x32-03.us.oracle.com (/10.80.150.35)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 03 Aug 2020 15:41:50 -0700
From: Jane Chu <jane.chu@oracle.com>
To: dan.j.williams@intel.com, vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, jmoyer@redhat.com, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Cc: jane.chu@oracle.com
Subject: [PATCH v2 1/3] libnvdimm/security: fix a typo
Date: Mon,  3 Aug 2020 16:41:37 -0600
Message-Id: <1596494499-9852-1-git-send-email-jane.chu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030155
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030155
Message-ID-Hash: 7U5IRVQPWPVNUWRGSZWPE2DDZOZFS46T
X-Message-ID-Hash: 7U5IRVQPWPVNUWRGSZWPE2DDZOZFS46T
X-MailFrom: jane.chu@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7U5IRVQPWPVNUWRGSZWPE2DDZOZFS46T/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

commit d78c620a2e82 ("libnvdimm/security: Introduce a 'frozen' attribute")
introduced a typo, causing a 'nvdimm->sec.flags' update being overwritten
by the subsequent update meant for 'nvdimm->sec.ext_flags'.

Cc: Dan Williams <dan.j.williams@intel.com>
Fixes: d78c620a2e82 ("libnvdimm/security: Introduce a 'frozen' attribute")
Signed-off-by: Jane Chu <jane.chu@oracle.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/nvdimm/security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
index 4cef69b..8f3971c 100644
--- a/drivers/nvdimm/security.c
+++ b/drivers/nvdimm/security.c
@@ -457,7 +457,7 @@ void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
 	clear_bit(NDD_WORK_PENDING, &nvdimm->flags);
 	put_device(&nvdimm->dev);
 	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
-	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_MASTER);
+	nvdimm->sec.ext_flags = nvdimm_security_flags(nvdimm, NVDIMM_MASTER);
 }
 
 void nvdimm_security_overwrite_query(struct work_struct *work)
-- 
1.8.3.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

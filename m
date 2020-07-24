Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A56422CA98
	for <lists+linux-nvdimm@lfdr.de>; Fri, 24 Jul 2020 18:11:32 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A7CD0124B6CDE;
	Fri, 24 Jul 2020 09:11:30 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=jane.chu@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D573B124953CB
	for <linux-nvdimm@lists.01.org>; Fri, 24 Jul 2020 09:11:27 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06OG2oQZ078805;
	Fri, 24 Jul 2020 16:11:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=WMp6kqTxYWGFRT/ot1iZ7DJpa+AfJh3DHPgpyzjSXbE=;
 b=B4BlKfbmGkrr4ajeKkxrPNbrQpEoayl5/YajI350Ge3teyZxKxvsYvo8I4iDv9fquzhx
 YuAudkKyo//A/BGNczJ6vbQ7MJ2HbAXtOiVN6UR4q5DxJ1KMrHG4sLvEaomfdICyNlsu
 dqJxM4j7CGXIyNpeByAc/iYV1ExhPqqWasrTfpci3iOXxNsAGB+n0c5QAeosEURnUN05
 ioXtnrPH3to+G2UiVlb0yGWKb9qSfALL1NjbZnms/UhwS2KUlBVFtAn3FlVwvouq2Pci
 fVe8dmQQeuki2SwJa8XVeqdnnOvQ7AnjJxDh1ZDFFZU6ikP4Euj1I74XJXau5vWxZiXm Zw==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2130.oracle.com with ESMTP id 32brgs00ae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 Jul 2020 16:11:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06OG4ORI058161;
	Fri, 24 Jul 2020 16:09:26 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by userp3020.oracle.com with ESMTP id 32fswssb5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2020 16:09:25 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06OG9On1003112;
	Fri, 24 Jul 2020 16:09:24 GMT
Received: from brm-x32-03.us.oracle.com (/10.80.150.35)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Fri, 24 Jul 2020 16:09:24 +0000
From: Jane Chu <jane.chu@oracle.com>
To: dan.j.williams@intel.com, vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, jmoyer@redhat.com, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Cc: jane.chu@oracle.com
Subject: [PATCH 2/2] libnvdimm/security: ensure sysfs poll thread woke up and fetch updated attr
Date: Fri, 24 Jul 2020 10:09:19 -0600
Message-Id: <1595606959-8516-2-git-send-email-jane.chu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1595606959-8516-1-git-send-email-jane.chu@oracle.com>
References: <1595606959-8516-1-git-send-email-jane.chu@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9692 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007240127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9692 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007240126
Message-ID-Hash: GHFHLNTYPQ4PMTLVQLCUJ5ZK5TFVZQ2L
X-Message-ID-Hash: GHFHLNTYPQ4PMTLVQLCUJ5ZK5TFVZQ2L
X-MailFrom: jane.chu@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GHFHLNTYPQ4PMTLVQLCUJ5ZK5TFVZQ2L/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

commit 7d988097c546 ("acpi/nfit, libnvdimm/security: Add security DSM overwrite support")
adds a sysfs_notify_dirent() to wake up userspace poll thread when the "overwrite"
operation has completed. But the notification is issued before the internal
dimm security state and flags have been updated, so the userspace poll thread
wakes up and fetches the not-yet-updated attr and falls back to sleep, forever.
But if user from another terminal issue "ndctl wait-overwrite nmemX" again,
the command returns instantly.

Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Fixes: 7d988097c546 ("acpi/nfit, libnvdimm/security: Add security DSM overwrite support")
Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 drivers/nvdimm/security.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
index 8f3971c..4b80150 100644
--- a/drivers/nvdimm/security.c
+++ b/drivers/nvdimm/security.c
@@ -450,14 +450,19 @@ void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
 	else
 		dev_dbg(&nvdimm->dev, "overwrite completed\n");
 
-	if (nvdimm->sec.overwrite_state)
-		sysfs_notify_dirent(nvdimm->sec.overwrite_state);
+	/*
+	 * Mark the overwrite work done and update dimm security flags,
+	 * then send a sysfs event notification to wake up userspace
+	 * poll threads to picked up the changed state.
+	 */
 	nvdimm->sec.overwrite_tmo = 0;
 	clear_bit(NDD_SECURITY_OVERWRITE, &nvdimm->flags);
 	clear_bit(NDD_WORK_PENDING, &nvdimm->flags);
-	put_device(&nvdimm->dev);
 	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
 	nvdimm->sec.ext_flags = nvdimm_security_flags(nvdimm, NVDIMM_MASTER);
+	if (nvdimm->sec.overwrite_state)
+		sysfs_notify_dirent(nvdimm->sec.overwrite_state);
+	put_device(&nvdimm->dev);
 }
 
 void nvdimm_security_overwrite_query(struct work_struct *work)
-- 
1.8.3.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

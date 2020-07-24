Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0A622CA63
	for <lists+linux-nvdimm@lfdr.de>; Fri, 24 Jul 2020 18:09:32 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6D792124A92B7;
	Fri, 24 Jul 2020 09:09:30 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=jane.chu@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A415D124A92B5
	for <linux-nvdimm@lists.01.org>; Fri, 24 Jul 2020 09:09:28 -0700 (PDT)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06OG1R3d040171;
	Fri, 24 Jul 2020 16:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=NdHEC4itFa22ofate1mFXVI4T3rcTTOAPX7QEG7yQZI=;
 b=VsSPLqKATTJS9rGEBfGKvy7FqiKAflaIfs6DKkqPspilgK+ytEEd8G1K1KyKwQLd1wdf
 pmHS0BRfpCQtkECrTMRQQtVHp1vQF1/716e64rtAdWQ9H9MQliPdCH7eIZmiEX90iQdw
 rb4ioAWS4B9nBkjgy/isopL3490hct/8KR0vlHXwJ86J+g6wlUSoCyIH4pzq2WNECUY0
 8XOLuWQCj8BYrzBI/UDJ//rOxcZzA4HQRCczOoG06CSZoMZIo2Z7fJnA3kEQ2Uab/hkX
 R8A64dPUYFmR1D/eJzv487iq9b2yv5r2C2rMPgNGyeXTHWvLam4sYqqauOIpXzv+ZNiI fQ==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by aserp2120.oracle.com with ESMTP id 32bs1myxg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 Jul 2020 16:09:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06OG4Uxj048444;
	Fri, 24 Jul 2020 16:09:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3030.oracle.com with ESMTP id 32fsr7jbxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2020 16:09:25 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06OG9OuY006837;
	Fri, 24 Jul 2020 16:09:24 GMT
Received: from brm-x32-03.us.oracle.com (/10.80.150.35)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Fri, 24 Jul 2020 16:09:24 +0000
From: Jane Chu <jane.chu@oracle.com>
To: dan.j.williams@intel.com, vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, jmoyer@redhat.com, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Cc: jane.chu@oracle.com
Subject: [PATCH 1/2] libnvdimm/security: 'security' attr never show 'overwrite' state
Date: Fri, 24 Jul 2020 10:09:18 -0600
Message-Id: <1595606959-8516-1-git-send-email-jane.chu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9692 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007240127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9692 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007240126
Message-ID-Hash: VW5V3SPGZ7V65I5ZDAJJK2QNEVWBROPQ
X-Message-ID-Hash: VW5V3SPGZ7V65I5ZDAJJK2QNEVWBROPQ
X-MailFrom: jane.chu@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VW5V3SPGZ7V65I5ZDAJJK2QNEVWBROPQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Since
commit d78c620a2e82 ("libnvdimm/security: Introduce a 'frozen' attribute"),
when issue
 # ndctl sanitize-dimm nmem0 --overwrite
then immediately check the 'security' attribute,
 # cat /sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus0/nmem0/security
 unlocked
Actually the attribute stays 'unlocked' through out the entire overwrite
operation, never changed.  That's because 'nvdimm->sec.flags' is a bitmap
that has both bits set indicating 'overwrite' and 'unlocked'.
But security_show() checks the mutually exclusive bits before it checks
the 'overwrite' bit at last. The order should be reversed.

The commit also has a typo: in one occasion, 'nvdimm->sec.ext_state'
assignment is replaced with 'nvdimm->sec.flags' assignment for
the NVDIMM_MASTER type.

Cc: Dan Williams <dan.j.williams@intel.com>
Fixes: d78c620a2e82 ("libnvdimm/security: Introduce a 'frozen' attribute")
Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 drivers/nvdimm/dimm_devs.c | 4 ++--
 drivers/nvdimm/security.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index b7b77e8..5d72026 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -363,14 +363,14 @@ __weak ssize_t security_show(struct device *dev,
 {
 	struct nvdimm *nvdimm = to_nvdimm(dev);
 
+	if (test_bit(NVDIMM_SECURITY_OVERWRITE, &nvdimm->sec.flags))
+		return sprintf(buf, "overwrite\n");
 	if (test_bit(NVDIMM_SECURITY_DISABLED, &nvdimm->sec.flags))
 		return sprintf(buf, "disabled\n");
 	if (test_bit(NVDIMM_SECURITY_UNLOCKED, &nvdimm->sec.flags))
 		return sprintf(buf, "unlocked\n");
 	if (test_bit(NVDIMM_SECURITY_LOCKED, &nvdimm->sec.flags))
 		return sprintf(buf, "locked\n");
-	if (test_bit(NVDIMM_SECURITY_OVERWRITE, &nvdimm->sec.flags))
-		return sprintf(buf, "overwrite\n");
 	return -ENOTTY;
 }
 
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

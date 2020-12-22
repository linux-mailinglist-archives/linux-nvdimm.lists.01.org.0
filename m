Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 864B72E039A
	for <lists+linux-nvdimm@lfdr.de>; Tue, 22 Dec 2020 01:57:18 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C58FD100EBBC7;
	Mon, 21 Dec 2020 16:57:16 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=jane.chu@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7BE64100EC1F2
	for <linux-nvdimm@lists.01.org>; Mon, 21 Dec 2020 16:57:14 -0800 (PST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BM0h7m1166876
	for <linux-nvdimm@lists.01.org>; Tue, 22 Dec 2020 00:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=utPpbVTl4xehy6vUf6NONlUP4+vVKC+d41d6c5h1vPs=;
 b=KT7EgSyx+HgHR0DA71nC4Ey2/0wkfyA5Fq7uDNpH1mOt65nRzA62ksfz+LLEWQIs5kLL
 ZbPYrRDe2mBH+r3Cp6VKyo6QrFF6hn540YCYWFd75KoodQU0a3+30CiRKrHH/kNLsdYc
 8KWWO/oTerjrv75vCJGo+g6fTQdOxeAaPgGBiqNNY8hhvfiOX4wQM1CPXoUBPx51RypP
 MPQM4vJ4dQCnfU1z0Oij3PDe9IhyF1zH+Xs7kLrbQgMGDpP653nkjAwToA+Zyzx8USV1
 vIz2oISOnGNOJ2TYS2C7j6kYOowBveCxloHu7H7WLahx/pwqrhYdbKqofFZyx4dt66dN 6Q==
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by aserp2120.oracle.com with ESMTP id 35k0cw19xn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-nvdimm@lists.01.org>; Tue, 22 Dec 2020 00:57:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BM0aUMU194806
	for <linux-nvdimm@lists.01.org>; Tue, 22 Dec 2020 00:57:12 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by userp3030.oracle.com with ESMTP id 35k0erwnh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvdimm@lists.01.org>; Tue, 22 Dec 2020 00:57:12 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BM0vBXT018590
	for <linux-nvdimm@lists.01.org>; Tue, 22 Dec 2020 00:57:11 GMT
Received: from brm-x62-16.us.oracle.com (/10.80.150.37)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 21 Dec 2020 16:57:11 -0800
From: Jane Chu <jane.chu@oracle.com>
To: linux-nvdimm@lists.01.org
Cc: jane.chu@oracle.com
Subject: [ndctl PATCH] ndctl/dimm: Fix submit_abort_firmware()
Date: Mon, 21 Dec 2020 17:57:04 -0700
Message-Id: <20201222005704.2355076-1-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9842 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012220002
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9842 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012220002
Message-ID-Hash: WCFPCMTQLZIRLGUC3EFGRMEJMWI7GBQI
X-Message-ID-Hash: WCFPCMTQLZIRLGUC3EFGRMEJMWI7GBQI
X-MailFrom: jane.chu@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WCFPCMTQLZIRLGUC3EFGRMEJMWI7GBQI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

commit f86369ea29e2 ("ndctl: merge firmware-update into dimm.c as another dimm operation")
introduces submit_abort_firmware() that calls
ndctl_cmd_fw_xlat_firmware_status() to parse status returned
from a firmware abort action. The callee returns FW_ notion of enum,
but the caller checks for ND_CMD_STATUS_FIN_ABORTED which is a bit mask.
So firmware abort always "fails" even when it succeeds.

Fixes: f86369ea29e2 ("ndctl: merge firmware-update into dimm.c as another dimm operation")
Tested-by: Mark Baker <mark.a.baker@oracle.com>
Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 ndctl/dimm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ndctl/dimm.c b/ndctl/dimm.c
index 8bb7f672e35c..255dbe156a34 100644
--- a/ndctl/dimm.c
+++ b/ndctl/dimm.c
@@ -531,7 +531,7 @@ static int submit_abort_firmware(struct ndctl_dimm *dimm,
 		goto out;
 
 	status = ndctl_cmd_fw_xlat_firmware_status(cmd);
-	if (!(status & ND_CMD_STATUS_FIN_ABORTED)) {
+	if (status != FW_ABORTED) {
 		fprintf(stderr,
 			"Firmware update abort on DIMM %s failed: %#x\n",
 			ndctl_dimm_get_devname(dimm), status);
-- 
2.18.4
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

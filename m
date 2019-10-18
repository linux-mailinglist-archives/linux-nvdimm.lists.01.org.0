Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE19DC51D
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Oct 2019 14:37:59 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D65F710FC66D8;
	Fri, 18 Oct 2019 05:40:05 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=dan.carpenter@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 870BB10FC66D7
	for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 05:40:02 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9ICY1Te041516;
	Fri, 18 Oct 2019 12:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=jjxfyzdJ1DBzufbew6BAqGAiJy4K7X6iQAV3wpA/e8Q=;
 b=cxa/ORzpbTVYnDdbYC6MD5SKE3vjaqqgIwwL3n82CIp1PBpzp2Rd0IPa2nLBUToR/YJ0
 gFnqF63JkHJCZSDlg951JFzqO7eRPDZ0EVR7Uk81oKshMGSiIqzi+CUcPPmY7WjtmE9O
 mfrBnBtY8YFPDCrutVSKZVi0qOdnieLPXhqz80jHG4eKoWJYo198POj2YSQ3Z9SD8yuI
 zjo5oVAy+6eqKhOpfQn2BW2WRhC9Nj1OK62RJXUH6/aHP+R0FQxM8ftbFf3DhEJsMlvi
 38dXJqMOc9mdPHbeP36IDxBDOgqBibo0o0LPo4NqXt86UchqnR8tbAXEC6mYEdV7rGY6 3A==
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by userp2130.oracle.com with ESMTP id 2vq0q4bnr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2019 12:37:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9ICX7vw133010;
	Fri, 18 Oct 2019 12:35:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by userp3030.oracle.com with ESMTP id 2vq0dxfwr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2019 12:35:46 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9ICZiws009665;
	Fri, 18 Oct 2019 12:35:44 GMT
Received: from mwanda (/41.57.98.10)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Fri, 18 Oct 2019 12:35:44 +0000
Date: Fri, 18 Oct 2019 15:35:34 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] acpi/nfit: unlock on error in scrub_show()
Message-ID: <20191018123534.GA6549@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910180118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910180118
Message-ID-Hash: NNM5L3E4VFJOTFXBJEHB6F6VGX6L3365
X-Message-ID-Hash: NNM5L3E4VFJOTFXBJEHB6F6VGX6L3365
X-MailFrom: dan.carpenter@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NNM5L3E4VFJOTFXBJEHB6F6VGX6L3365/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

We change the locking in this function and forgot to update this error
path so we are accidentally still holding the "dev->lockdep_mutex".

Fixes: 87a30e1f05d7 ("driver-core, libnvdimm: Let device subsystems add local lockdep coverage")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/acpi/nfit/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 1413324982f0..14e68f202f81 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1322,7 +1322,7 @@ static ssize_t scrub_show(struct device *dev,
 	nfit_device_lock(dev);
 	nd_desc = dev_get_drvdata(dev);
 	if (!nd_desc) {
-		device_unlock(dev);
+		nfit_device_unlock(dev);
 		return rc;
 	}
 	acpi_desc = to_acpi_desc(nd_desc);
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

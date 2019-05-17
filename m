Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5845212C2
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 May 2019 06:08:32 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1686421962301;
	Thu, 16 May 2019 21:08:31 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=156.151.31.86; helo=userp2130.oracle.com;
 envelope-from=jane.chu@oracle.com; receiver=linux-nvdimm@lists.01.org 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D188F2122C2EF
 for <linux-nvdimm@lists.01.org>; Thu, 16 May 2019 21:08:28 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4H44FtQ155156;
 Fri, 17 May 2019 04:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=fbs2klJYRwSjh6U92tbSHWsFn2CAbHAkPfwjVASkuvs=;
 b=GtFN8KxHn6BoVU9RO4RbeGh9sRr4R5Oqr7OqunHBPO0lQAOucqb2LpUXXiro7vHZBTpl
 zn18pgC9Ba/pf8L/cAM2wqXlfUTy/kH0wctwMu+ijNvbOCB09Xx4LTYN9GoTMsBVKNTa
 RpqfKvYj/5mGspglKTyxP8OSob8A7li66BNNR/n2bRooyGDYJTzIgQ1k1sHzcDb1j4r6
 F59pNJl70JWFYpgmMrHQvLi5OkjzSRywaXlkYQG1B2mrvXCyvItJbSXjelKlaninmeQA
 igjxy5kXNurF9PKFc7MYWrKOFbbkoAwPrz8gzAU102QwDIbmOiZpZd5p4Cljgyga+WV3 ng== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2sdntu76t2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 May 2019 04:08:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4H47PEL073951;
 Fri, 17 May 2019 04:08:23 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2sgp33ca87-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 May 2019 04:08:23 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4H48Lbi020359;
 Fri, 17 May 2019 04:08:22 GMT
Received: from brm-x32-03.us.oracle.com (/10.80.150.35)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 17 May 2019 04:08:21 +0000
From: Jane Chu <jane.chu@oracle.com>
To: n-horiguchi@ah.jp.nec.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm, memory-failure: clarify error message
Date: Thu, 16 May 2019 22:08:15 -0600
Message-Id: <1558066095-9495-1-git-send-email-jane.chu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9259
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=954
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905170025
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9259
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=984 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905170025
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: linux-nvdimm@lists.01.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Some user who install SIGBUS handler that does longjmp out
therefore keeping the process alive is confused by the error
message
  "[188988.765862] Memory failure: 0x1840200: Killing
   cellsrv:33395 due to hardware memory corruption"
Slightly modify the error message to improve clarity.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 mm/memory-failure.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index fc8b517..14de5e2 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -216,10 +216,9 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
 	short addr_lsb = tk->size_shift;
 	int ret;
 
-	pr_err("Memory failure: %#lx: Killing %s:%d due to hardware memory corruption\n",
-		pfn, t->comm, t->pid);
-
 	if ((flags & MF_ACTION_REQUIRED) && t->mm == current->mm) {
+		pr_err("Memory failure: %#lx: Killing %s:%d due to hardware memory "
+			"corruption\n", pfn, t->comm, t->pid);
 		ret = force_sig_mceerr(BUS_MCEERR_AR, (void __user *)tk->addr,
 				       addr_lsb, current);
 	} else {
@@ -229,6 +228,8 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
 		 * This could cause a loop when the user sets SIGBUS
 		 * to SIG_IGN, but hopefully no one will do that?
 		 */
+		pr_err("Memory failure: %#lx: Sending SIGBUS to %s:%d due to hardware "
+			"memory corruption\n", pfn, t->comm, t->pid);
 		ret = send_sig_mceerr(BUS_MCEERR_AO, (void __user *)tk->addr,
 				      addr_lsb, t);  /* synchronous? */
 	}
-- 
1.8.3.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

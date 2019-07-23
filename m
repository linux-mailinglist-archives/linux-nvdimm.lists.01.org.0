Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 167CF7232C
	for <lists+linux-nvdimm@lfdr.de>; Wed, 24 Jul 2019 01:40:46 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 106BC212CFED3;
	Tue, 23 Jul 2019 16:43:11 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=156.151.31.85; helo=userp2120.oracle.com;
 envelope-from=jane.chu@oracle.com; receiver=linux-nvdimm@lists.01.org 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 413F72128D681
 for <linux-nvdimm@lists.01.org>; Tue, 23 Jul 2019 16:43:09 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6NNdoDw129407;
 Tue, 23 Jul 2019 23:40:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=iTXW+qBxgmscyKRDm4rDkuaYwhXnZofHvZ2R9R8Uz4Y=;
 b=nxXOuLKiK8KoaSaGs7WwtVuXIxEyT+156pDFlni3kjDMe2aGUD46IyZQ0/xQ5MywwPHD
 aaWqIhjaI2ew3auUiZTPhITyyJF/X1qqOCmzquOy+haoGTxs6WyWdaIjEHvILb2Lz8Fk
 eHB0EmIc8PTGBeYwa4c0bJZUfQfSgLsZfpLgANh5oCxrwlhqqCJkzy+x1zo+YtnXo4S/
 xDHSJephx28gkPt7u5yN7SSqS1Cyt+0Ehr666YrLCbHeK8roWc6j5OOQ28hq241R+9B0
 XXWrUZ/TIwOizrVD4vnYSDzi1mYSkvyC88Js5FLzhC6joSvwdf0EvuKQw3hfBB+QWyax xg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2tx61bsseb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2019 23:40:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6NNbZXj183349;
 Tue, 23 Jul 2019 23:38:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2tx60xh2f6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2019 23:38:37 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6NNcaGA013920;
 Tue, 23 Jul 2019 23:38:36 GMT
Received: from brm-x32-03.us.oracle.com (/10.80.150.35)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 23 Jul 2019 16:38:36 -0700
From: Jane Chu <jane.chu@oracle.com>
To: n-horiguchi@ah.jp.nec.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/memory-failure: Poison read receives SIGKILL instead of
 SIGBUS if mmaped more than once
Date: Tue, 23 Jul 2019 17:38:30 -0600
Message-Id: <1563925110-19359-1-git-send-email-jane.chu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9327
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907230244
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9327
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907230244
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

Mmap /dev/dax more than once, then read the poison location using address
from one of the mappings. The other mappings due to not having the page
mapped in will cause SIGKILLs delivered to the process. SIGKILL succeeds
over SIGBUS, so user process looses the opportunity to handle the UE.

Although one may add MAP_POPULATE to mmap(2) to work around the issue,
MAP_POPULATE makes mapping 128GB of pmem several magnitudes slower, so
isn't always an option.

Details -

ndctl inject-error --block=10 --count=1 namespace6.0

./read_poison -x dax6.0 -o 5120 -m 2
mmaped address 0x7f5bb6600000
mmaped address 0x7f3cf3600000
doing local read at address 0x7f3cf3601400
Killed

Console messages in instrumented kernel -

mce: Uncorrected hardware memory error in user-access at edbe201400
Memory failure: tk->addr = 7f5bb6601000
Memory failure: address edbe201: call dev_pagemap_mapping_shift
dev_pagemap_mapping_shift: page edbe201: no PUD
Memory failure: tk->size_shift == 0
Memory failure: Unable to find user space address edbe201 in read_poison
Memory failure: tk->addr = 7f3cf3601000
Memory failure: address edbe201: call dev_pagemap_mapping_shift
Memory failure: tk->size_shift = 21
Memory failure: 0xedbe201: forcibly killing read_poison:22434 because of failure to unmap corrupted page
  => to deliver SIGKILL
Memory failure: 0xedbe201: Killing read_poison:22434 due to hardware memory corruption
  => to deliver SIGBUS

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 mm/memory-failure.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index d9cc660..7038abd 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -315,7 +315,6 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
 
 	if (*tkc) {
 		tk = *tkc;
-		*tkc = NULL;
 	} else {
 		tk = kmalloc(sizeof(struct to_kill), GFP_ATOMIC);
 		if (!tk) {
@@ -331,16 +330,21 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
 		tk->size_shift = compound_order(compound_head(p)) + PAGE_SHIFT;
 
 	/*
-	 * In theory we don't have to kill when the page was
-	 * munmaped. But it could be also a mremap. Since that's
-	 * likely very rare kill anyways just out of paranoia, but use
-	 * a SIGKILL because the error is not contained anymore.
+	 * Indeed a page could be mmapped N times within a process. And it's possible
+	 * that not all of those N VMAs contain valid mapping for the page. In which
+	 * case we don't want to send SIGKILL to the process on behalf of the VMAs
+	 * that don't have the valid mapping, because doing so will eclipse the SIGBUS
+	 * delivered on behalf of the active VMA.
 	 */
 	if (tk->addr == -EFAULT || tk->size_shift == 0) {
 		pr_info("Memory failure: Unable to find user space address %lx in %s\n",
 			page_to_pfn(p), tsk->comm);
-		tk->addr_valid = 0;
+		if (tk != *tkc)
+			kfree(tk);
+		return;
 	}
+	if (tk == *tkc)
+		*tkc = NULL;
 	get_task_struct(tsk);
 	tk->tsk = tsk;
 	list_add_tail(&tk->nd, to_kill);
-- 
1.8.3.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

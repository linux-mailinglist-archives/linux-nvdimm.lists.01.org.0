Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93936759F6
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Jul 2019 00:01:57 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8BA80212E13A5;
	Thu, 25 Jul 2019 15:04:20 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=141.146.126.78; helo=aserp2120.oracle.com;
 envelope-from=jane.chu@oracle.com; receiver=linux-nvdimm@lists.01.org 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 0D503212E13A3
 for <linux-nvdimm@lists.01.org>; Thu, 25 Jul 2019 15:04:18 -0700 (PDT)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6PLoH8w134030;
 Thu, 25 Jul 2019 22:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=USs7rUihppQ+KmFVpj5iXh+Jz7d53J97VjHquobjd/U=;
 b=SljRE8Qj9gelicXhw/gG/A2koi2CSJTQqQ2xnTXwrmS4qkCOMfxcHsnfXu4PQbigWPwi
 n3I1jeVIFAwKNjos8gZnUUV9IS3nz0CcfnjMoNVjxlZrsad8yeVRaEIBnQDRBhKLC1zd
 sRg6qVs5+JC3e6zUmd0AvUNwjvRRvNTPeOg6pd5AMe8+TAID0WGFcWm0jncw13TEN6a1
 n5CFt0TML+sYFWSxSTcTo9sZksgO+adab+Uox6n7Jr+NoSKFH5O7rqP2GhcCjbS1d1D1
 Z+OmTmhhDtJ4TMWdhd7fEKdM53CBvr74PZNLmgHFzKiGQUmgpfcpWUaGDC1pQSooZhMK cw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2tx61c6r0y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jul 2019 22:01:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6PLqP8Z107764;
 Thu, 25 Jul 2019 22:01:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2tycv78jmg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jul 2019 22:01:47 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6PM1k4u021541;
 Thu, 25 Jul 2019 22:01:46 GMT
Received: from brm-x32-03.us.oracle.com (/10.80.150.35)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 25 Jul 2019 15:01:46 -0700
From: Jane Chu <jane.chu@oracle.com>
To: n-horiguchi@ah.jp.nec.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] mm/memory-failure: Poison read receives SIGKILL
 instead of SIGBUS if mmaped more than once
Date: Thu, 25 Jul 2019 16:01:41 -0600
Message-Id: <1564092101-3865-3-git-send-email-jane.chu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1564092101-3865-1-git-send-email-jane.chu@oracle.com>
References: <1564092101-3865-1-git-send-email-jane.chu@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9329
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907250263
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9329
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907250263
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
Suggested-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
---
 mm/memory-failure.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 51d5b20..f668c88 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -199,7 +199,6 @@ struct to_kill {
 	struct task_struct *tsk;
 	unsigned long addr;
 	short size_shift;
-	char addr_valid;
 };
 
 /*
@@ -318,22 +317,27 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
 	}
 
 	tk->addr = page_address_in_vma(p, vma);
-	tk->addr_valid = 1;
 	if (is_zone_device_page(p))
 		tk->size_shift = dev_pagemap_mapping_shift(p, vma);
 	else
 		tk->size_shift = compound_order(compound_head(p)) + PAGE_SHIFT;
 
 	/*
-	 * In theory we don't have to kill when the page was
-	 * munmaped. But it could be also a mremap. Since that's
-	 * likely very rare kill anyways just out of paranoia, but use
-	 * a SIGKILL because the error is not contained anymore.
+	 * Send SIGKILL if "tk->addr == -EFAULT". Also, as
+	 * "tk->size_shift" is always non-zero for !is_zone_device_page(),
+	 * so "tk->size_shift == 0" effectively checks no mapping on
+	 * ZONE_DEVICE. Indeed, when a devdax page is mmapped N times
+	 * to a process' address space, it's possible not all N VMAs
+	 * contain mappings for the page, but at least one VMA does.
+	 * Only deliver SIGBUS with payload derived from the VMA that
+	 * has a mapping for the page.
 	 */
-	if (tk->addr == -EFAULT || tk->size_shift == 0) {
+	if (tk->addr == -EFAULT) { 
 		pr_info("Memory failure: Unable to find user space address %lx in %s\n",
 			page_to_pfn(p), tsk->comm);
-		tk->addr_valid = 0;
+	} else if (tk->size_shift == 0) {
+		kfree(tk);
+		return;
 	}
 
 	get_task_struct(tsk);
@@ -361,7 +365,7 @@ static void kill_procs(struct list_head *to_kill, int forcekill, bool fail,
 			 * make sure the process doesn't catch the
 			 * signal and then access the memory. Just kill it.
 			 */
-			if (fail || tk->addr_valid == 0) {
+			if (fail || tk->addr == -EFAULT) {
 				pr_err("Memory failure: %#lx: forcibly killing %s:%d because of failure to unmap corrupted page\n",
 				       pfn, tk->tsk->comm, tk->tsk->pid);
 				do_send_sig_info(SIGKILL, SEND_SIG_PRIV,
-- 
1.8.3.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

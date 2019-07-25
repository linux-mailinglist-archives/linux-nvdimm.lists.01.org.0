Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A16F759F5
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Jul 2019 00:01:56 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0135F212E13A8;
	Thu, 25 Jul 2019 15:04:20 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=156.151.31.86; helo=userp2130.oracle.com;
 envelope-from=jane.chu@oracle.com; receiver=linux-nvdimm@lists.01.org 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id BEB2F212E13A1
 for <linux-nvdimm@lists.01.org>; Thu, 25 Jul 2019 15:04:17 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6PLnBY4047100;
 Thu, 25 Jul 2019 22:01:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=7FptRZmjEs2pVIwTHSlVNGQPR98w4TY5Ui3dappIUrg=;
 b=zelHaYCV1Eo2luXTb4NIC4ATeklX43FoLNIg+/v93pLzkx4YdPoO3fyCiM3L0fPupdyi
 U852W0/B/wTmHXmjk2GwVN78cODCp6JFURtLPB/JVE5cNpCMDJU5izjBJ52Pf04F4POy
 bv4XKNPSKbv1P/Wmn0xTL6YZeNo+iPnhKDOvgWpma4fbUlMbmdnA5r8PXxPLv2+9KB7O
 tNfOWJi83IepiGbtaooOLI6NBnqJwhGiSyaYAQ7vnSKXLxkPBTdhx96K7Q/hQWzx5lt5
 iroEHCwjWevK5I1aeJgvH6+PlR/vjvWG7DK9jwhcmMB/BjD7IkfxzgCngaJL+pzplMCB tQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2tx61c6r9g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jul 2019 22:01:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6PLqUDr117787;
 Thu, 25 Jul 2019 22:01:47 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 2tx60yjmj1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jul 2019 22:01:47 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6PM1jni011429;
 Thu, 25 Jul 2019 22:01:45 GMT
Received: from brm-x32-03.us.oracle.com (/10.80.150.35)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 25 Jul 2019 15:01:45 -0700
From: Jane Chu <jane.chu@oracle.com>
To: n-horiguchi@ah.jp.nec.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] mm/memory-failure: Poison read receives SIGKILL
 instead of SIGBUS issue 
Date: Thu, 25 Jul 2019 16:01:39 -0600
Message-Id: <1564092101-3865-1-git-send-email-jane.chu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9329
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=968
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

Changes in v3:
 - move **tk cleanup to its own patch

Changes in v2:
 - move 'tk' allocations internal to add_to_kill(), suggested by Dan;
 - ran checkpatch.pl check, pointed out by Matthew;
 - Noaya pointed out that v1 would have missed the SIGKILL
   if "tk->addr == -EFAULT", since the code returns early.
   Incorporated Noaya's suggestion, also, skip VMAs where
   "tk->size_shift == 0" for zone device page, and deliver SIGBUS
   when "tk->size_shift != 0" so the payload is helpful;
 - added Suggested-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

Jane Chu (2):
  mm/memory-failure.c clean up around tk pre-allocation
  mm/memory-failure: Poison read receives SIGKILL instead of SIGBUS if
    mmaped more than once

 mm/memory-failure.c | 62 ++++++++++++++++++++++-------------------------------
 1 file changed, 26 insertions(+), 36 deletions(-)

-- 
1.8.3.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

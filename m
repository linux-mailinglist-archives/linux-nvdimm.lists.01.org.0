Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 555703962F
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 Jun 2019 21:52:49 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2E3CD21290DEE;
	Fri,  7 Jun 2019 12:52:47 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=156.151.31.85; helo=userp2120.oracle.com;
 envelope-from=larry.bassel@oracle.com; receiver=linux-nvdimm@lists.01.org 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id AB5FA21290DE1
 for <linux-nvdimm@lists.01.org>; Fri,  7 Jun 2019 12:52:45 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x57JiKEL098463;
 Fri, 7 Jun 2019 19:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=2Hqgg1/dO7uDJAgCGo7yaezXbdAI6xjToJ1CY+fruaU=;
 b=O4Q4lH3bRZ7MwIrivSjLjEanSp/1BldkeSoNEhDGZB9H8i68MirSK5kT1G9vfxNC3u4G
 tobWGASbTP9Drb1g9Mp6AfG8qM1rx37y+y4jziC7fhhXc85/r1nyZdjc0AvVPgR6CHSx
 mIG1Ihxno+1jVFyxrLhM0kOMgrsCEXUfm8XfDOuuOU7vnXmbp6UA1fNJI3jhDUe7a+Kj
 2hmnQAljFlUykUzJfFxc07Lcm1cms6sQ9cH5eVDN5A51sxAKeJHRt4ypV3oFix9CV0pf
 SvSI14XmrW8h5CL/zA1fBwxGuMoBQ9DLdBog4cttYZAO5Rx24YoPOe0lSjwY171+j0cH Eg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2suj0r05yx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Jun 2019 19:52:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x57JpA1j022963;
 Fri, 7 Jun 2019 19:52:33 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 2swngn8kcn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Jun 2019 19:52:32 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x57JqRQt020424;
 Fri, 7 Jun 2019 19:52:28 GMT
Received: from oracle.com (/75.80.107.76)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 07 Jun 2019 12:52:27 -0700
From: Larry Bassel <larry.bassel@oracle.com>
To: mike.kravetz@oracle.com, willy@infradead.org, dan.j.williams@intel.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: [RFC PATCH v2 0/2] Share PMDs for FS/DAX on x86
Date: Fri,  7 Jun 2019 12:51:01 -0700
Message-Id: <1559937063-8323-1-git-send-email-larry.bassel@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9281
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=641
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906070132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9281
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=682 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906070132
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Changes from v1 to v2:

* Rebased on v5.2-rc3

* An incorrect reference to "page table entries" was fixed (pointed
out by Kirill Shutemov)

* Renamed CONFIG_ARCH_WANT_HUGE_PMD_SHARE
to CONFIG_ARCH_HAS_HUGE_PMD_SHARE instead of introducing
a new config option (suggested by Dan Williams)

* Removed some unnecessary #ifdef stubs (suggested by Matt Wilcox)

* A previously overlooked case involving mprotect() is now handled
properly (pointed out by Mike Kravetz)

---

This patchset implements sharing of page tables pointing
to 2MiB pages (PMDs) for FS/DAX on x86.

Only shared mmapings of files (i.e. neither private mmapings nor
anonymous pages) are eligible for PMD sharing.

Due to the characteristics of DAX, this code is simpler and
less intrusive than the general case would be.

In our use case (high end Oracle database using DAX/XFS/PMEM/2MiB
pages) there would be significant memory savings.

A future system might have 6 TiB of PMEM on it and
there might be 10000 processes each mapping all of this 6 TiB.
Here the savings would be approximately
(6 TiB / 2 MiB) * 8 bytes (page table size) * 10000 = 240 GiB
(and these page tables themselves would probably be in
non-PMEM (ordinary RAM)).

There would also be a reduction in page faults because in
some cases the page fault has already been satisfied and
the page table entry has been filled in (and so the processes
after the first would not take a fault).

The code for detecting whether PMDs can be shared and
the implementation of sharing and unsharing is based
on, but somewhat different than that in mm/hugetlb.c,
though some of the code from this file could be reused and
thus was made non-static.

Larry Bassel (2):
  Rename CONFIG_ARCH_WANT_HUGE_PMD_SHARE to
    CONFIG_ARCH_HAS_HUGE_PMD_SHARE
  Implement sharing/unsharing of PMDs for FS/DAX

 arch/arm64/Kconfig          |   2 +-
 arch/arm64/mm/hugetlbpage.c |   2 +-
 arch/x86/Kconfig            |   2 +-
 include/linux/hugetlb.h     |   4 ++
 mm/huge_memory.c            |  37 +++++++++++++++
 mm/hugetlb.c                |  14 +++---
 mm/memory.c                 | 108 +++++++++++++++++++++++++++++++++++++++++++-
 7 files changed, 158 insertions(+), 11 deletions(-)

-- 
1.8.3.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

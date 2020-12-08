Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47822D311E
	for <lists+linux-nvdimm@lfdr.de>; Tue,  8 Dec 2020 18:32:34 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9B0CF100EB832;
	Tue,  8 Dec 2020 09:32:33 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.79; helo=aserp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 74198100EB827
	for <linux-nvdimm@lists.01.org>; Tue,  8 Dec 2020 09:32:31 -0800 (PST)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8HPMUw083135;
	Tue, 8 Dec 2020 17:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=WoY4HOqMj06rCLo4dIjKOPfVIQ3qLKDAu362zSgScJI=;
 b=sWoU+UY5s7EsXk511arHMDL3g7cz5f8K/A0OPTZpR/bdAV1JdyxP/k9GLMajtu+uA3S4
 2iZb+uxAVoCXLu7rvUfX6rm1ZM8+8Rx+y670qxH++4dzWi5kO4IzFRSrkRyx8GUQdnX2
 QFfPH8NOcZU1NoxuSC80Eki1Y5HDBZfcDQEvJjLjm56UXAngjbsGXIv2Fx11ZCQ2hE3R
 IrXO/NPmgRVkDNYxKHQ2jWaVYjpErgqY46Xp5jj/+n2sPykDEKUuniBOMGu8pxJ16V3O
 8l5XaFevJFtGZA5wGQN+LKMUCTYsZurXC+EBnzEVeRg935OxwdY/HgSIF0I37e4H45jS lA==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by aserp2130.oracle.com with ESMTP id 357yqbv4pu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 08 Dec 2020 17:32:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8HOVjl195412;
	Tue, 8 Dec 2020 17:30:22 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by aserp3020.oracle.com with ESMTP id 358m3y2f2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Dec 2020 17:30:22 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B8HUFxA025859;
	Tue, 8 Dec 2020 17:30:16 GMT
Received: from paddy.uk.oracle.com (/10.175.194.215)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 08 Dec 2020 09:30:14 -0800
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-mm@kvack.org
Subject: [PATCH RFC 0/9] mm, sparse-vmemmap: Introduce compound pagemaps
Date: Tue,  8 Dec 2020 17:28:51 +0000
Message-Id: <20201208172901.17384-1-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080107
Message-ID-Hash: DMBQM5TVUOWCJKHA4TTUJYRJJHGG5NS4
X-Message-ID-Hash: DMBQM5TVUOWCJKHA4TTUJYRJJHGG5NS4
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DMBQM5TVUOWCJKHA4TTUJYRJJHGG5NS4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hey,

This small series, attempts at minimizing 'struct page' overhead by
pursuing a similar approach as Muchun Song series "Free some vmemmap
pages of hugetlb page"[0] but applied to devmap/ZONE_DEVICE. 

[0] https://lore.kernel.org/linux-mm/20201130151838.11208-1-songmuchun@bytedance.com/

The link above describes it quite nicely, but the idea is to reuse tail
page vmemmap areas, particular the area which only describes tail pages.
So a vmemmap page describes 64 struct pages, and the first page for a given
ZONE_DEVICE vmemmap would contain the head page and 63 tail pages. The second
vmemmap page would contain only tail pages, and that's what gets reused across
the rest of the subsection/section. The bigger the page size, the bigger the
savings (2M hpage -> save 6 vmemmap pages; 1G hpage -> save 4094 vmemmap pages).

In terms of savings, per 1Tb of memory, the struct page cost would go down
with compound pagemap:

* with 2M pages we lose 4G instead of 16G (0.39% instead of 1.5% of total memory)
* with 1G pages we lose 8MB instead of 16G (0.0007% instead of 1.5% of total memory)

Along the way I've extended it past 'struct page' overhead *trying* to address a
few performance issues we knew about for pmem, specifically on the
{pin,get}_user_pages* function family with device-dax vmas which are really
slow even of the fast variants. THP is great on -fast variants but all except
hugetlbfs perform rather poorly on non-fast gup.

So to summarize what the series does:

Patches 1-5: Much like Muchun series, we reuse tail page areas across a given
page size (namely @align was referred by remaining memremap/dax code) and
enabling of memremap to initialize the ZONE_DEVICE pages as compound pages or a
given @align order. The main difference though, is that contrary to the hugetlbfs
series, there's no vmemmap for the area, because we are onlining it. IOW no
freeing of pages of already initialized vmemmap like the case for hugetlbfs,
which simplifies the logic (besides not being arch-specific). After these,
there's quite visible region bootstrap of pmem memmap given that we would
initialize fewer struct pages depending on the page size.

    NVDIMM namespace bootstrap improves from ~750ms to ~190ms/<=1ms on emulated NVDIMMs
    with 2M and 1G respectivally. The net gain in improvement is similarly observed
    in proportion when running on actual NVDIMMs.

Patch 6 - 8: Optimize grabbing/release a page refcount changes given that we
are working with compound pages i.e. we do 1 increment/decrement to the head
page for a given set of N subpages compared as opposed to N individual writes.
{get,pin}_user_pages_fast() for zone_device with compound pagemap consequently
improves considerably, and unpin_user_pages() improves as well when passed a
set of consecutive pages:

                                           before          after
    (get_user_pages_fast 1G;2M page size) ~75k  us -> ~3.2k ; ~5.2k us
    (pin_user_pages_fast 1G;2M page size) ~125k us -> ~3.4k ; ~5.5k us

The RDMA patch (patch 8/9) is to demonstrate the improvement for an existing
user. For unpin_user_pages() we have an additional test to demonstrate the
improvement.  The test performs MR reg/unreg continuously and measuring its
rate for a given period. So essentially ib_mem_get and ib_mem_release being
stress tested which at the end of day means: pin_user_pages_longterm() and
unpin_user_pages() for a scatterlist:

    Before:
    159 rounds in 5.027 sec: 31617.923 usec / round (device-dax)
    466 rounds in 5.009 sec: 10748.456 usec / round (hugetlbfs)
	        
    After:
    305 rounds in 5.010 sec: 16426.047 usec / round (device-dax)
    1073 rounds in 5.004 sec: 4663.622 usec / round (hugetlbfs)

Patch 9: Improves {pin,get}_user_pages() and its longterm counterpart. It
is very experimental, and I imported most of follow_hugetlb_page(), except
that we do the same trick as gup-fast. In doing the patch I feel this batching
should live in follow_page_mask() and having that being changed to return a set
of pages/something-else when walking over PMD/PUDs for THP / devmap pages. This
patch then brings the previous test of mr reg/unreg (above) on parity
between device-dax and hugetlbfs.

Some of the patches are a little fresh/WIP (specially patch 3 and 9) and we are
still running tests. Hence the RFC, asking for comments and general direction
of the work before continuing.

Patches apply on top of linux-next tag next-20201208 (commit a9e26cb5f261).

Comments and suggestions very much appreciated!

Thanks,
	Joao

Joao Martins (9):
  memremap: add ZONE_DEVICE support for compound pages
  sparse-vmemmap: Consolidate arguments in vmemmap section populate
  sparse-vmemmap: Reuse vmemmap areas for a given page size
  mm/page_alloc: Reuse tail struct pages for compound pagemaps
  device-dax: Compound pagemap support
  mm/gup: Grab head page refcount once for group of subpages
  mm/gup: Decrement head page once for group of subpages
  RDMA/umem: batch page unpin in __ib_mem_release()
  mm: Add follow_devmap_page() for devdax vmas

 drivers/dax/device.c           |  54 ++++++---
 drivers/infiniband/core/umem.c |  25 +++-
 include/linux/huge_mm.h        |   4 +
 include/linux/memory_hotplug.h |  16 ++-
 include/linux/memremap.h       |   2 +
 include/linux/mm.h             |   6 +-
 mm/gup.c                       | 130 ++++++++++++++++-----
 mm/huge_memory.c               | 202 +++++++++++++++++++++++++++++++++
 mm/memory_hotplug.c            |  13 ++-
 mm/memremap.c                  |  13 ++-
 mm/page_alloc.c                |  28 ++++-
 mm/sparse-vmemmap.c            |  97 +++++++++++++---
 mm/sparse.c                    |  16 +--
 13 files changed, 531 insertions(+), 75 deletions(-)

-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

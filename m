Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16BC2D49DE
	for <lists+linux-nvdimm@lfdr.de>; Wed,  9 Dec 2020 20:14:11 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1A959100ED4A4;
	Wed,  9 Dec 2020 11:14:10 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=203.18.50.4; helo=nat-hk.nvidia.com; envelope-from=jgg@nvidia.com; receiver=<UNKNOWN> 
Received: from nat-hk.nvidia.com (nat-hk.nvidia.com [203.18.50.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3599B100ED48A
	for <linux-nvdimm@lists.01.org>; Wed,  9 Dec 2020 11:14:06 -0800 (PST)
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
	id <B5fd121fc0000>; Thu, 10 Dec 2020 03:14:04 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Dec
 2020 19:14:02 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 9 Dec 2020 19:14:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9z3F5Z8JD/xazIwA61jRxweiadyROmjZaLdKevnI8gz1Nt/qwyB9ynJYQ31g008pXY7R7B+BPNcSWs6jbHq6gfZ/iwiCX/ZS95jgHB5eHOECz+nE0TpmaEvYJ+R+gIQzSLuqC03bo977h0wR+X0CyYkcPc4bfyI+ALK/InG3TWJuDCEV4v6VjjMGMGSWKGC7YocLQmkezPmsMRrpeAtxK21IPQEBktVtyY6kyEFZxNqNzBc0WN3QyyyMZageMbP2nSzDqOGfE5m4xj6Ldwd/xuEHBpdBfRqdh4BkMpcSzJngrdg77BC8g7LmG6JJf+i5YAkK9j8GHVo73MctuVdqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3BX9Jwc16zekV5Ibh8ze6U16P1/HoaHFHOn3XrVCqI=;
 b=f/hvPPCTvO01m+oKMiM2gnfrzG6Rd6/AXtbtMVF+LtSoWvGfAQufccvDNRWCLEO5AliZNRMeSXkdDL9ncw/iWZw90yIgqrHVqJSTMrpmarY+GSjZeNVOV+G6k6nwHBrXp4rFEwAXVAjRyMhW9RRHg4dVb3S/WYq0vgWiliXEfu6W3u0bBKD30e1pD+poJ93Oh7rdg7QPKjQCQCNXJBusSjCrtO8F3MDA+Mm5EWbw7s1r4h3bl8pzGYJTP6Hy4Hpduy4GJTJion5rjfGnQxndsyga/8k+sCZ0sKYXxqCt+IKw+N9RaixMb/h0tKuWJw3iMt9v11ZJ/oQuG5B8juW/Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Wed, 9 Dec
 2020 19:14:00 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3632.023; Wed, 9 Dec 2020
 19:14:00 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>, John Hubbard
	<jhubbard@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>, linux-mm
	<linux-mm@kvack.org>
Subject: [PATCH] mm/up: combine put_compound_head() and unpin_user_page()
Date: Wed, 9 Dec 2020 15:13:57 -0400
Message-ID: <0-v1-6730d4ee0d32+40e6-gup_combine_put_jgg@nvidia.com>
X-ClientProxiedBy: BL0PR1501CA0023.namprd15.prod.outlook.com
 (2603:10b6:207:17::36) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR1501CA0023.namprd15.prod.outlook.com (2603:10b6:207:17::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Wed, 9 Dec 2020 19:13:59 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from <jgg@nvidia.com>)	id 1kn4uT-008LPW-Nf; Wed, 09 Dec 2020 15:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
	t=1607541244; bh=zQMHQXsQtGedge4gZRlhKJzlElHxG4P94ErKUH8x4dQ=;
	h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
	 CC:Subject:Date:Message-ID:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType;
	b=cH89ztZk5xX5CE3NKfFnEYVk/UygCI5m5tK7xg1ysr2HQD695o4jowEsfNwVu29Re
	 ydw6/IMclBpj+qHCd+ctFhWSl7Jsar8h/oepFOX7qekwsi0abnrNM7XfabKu623UrL
	 LHWH4TateucrsQVVCH+RIQzUJ9VK3mMVf7WQIhcWrO8LMsVU43aEYkkq8zKaq5Kf7v
	 rOfuMedEJ/XG9CS+OQylqQyfBEmPpd7Hhl0Whj50BLUmy7/ojVN1akqTRA/erGd1LR
	 sTSGZDnXFLMTuYaGpAe5Az5PuQkGlR4pynJiezO8Di1Mcfls5ECCEtLOzh7oat9jRU
	 sxR+Zi6Mwmsqw==
Message-ID-Hash: RZFT7XLFQCR4LKXWGV52EEIX6UKGONXB
X-Message-ID-Hash: RZFT7XLFQCR4LKXWGV52EEIX6UKGONXB
X-MailFrom: jgg@nvidia.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jonathan Corbet <corbet@lwn.net>, Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-nvdimm@lists.01.org, Michal Hocko <mhocko@suse.com>, Mike Kravetz <mike.kravetz@oracle.com>, Shuah Khan <shuah@kernel.org>, Muchun Song <songmuchun@bytedance.com>, Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RZFT7XLFQCR4LKXWGV52EEIX6UKGONXB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

These functions accomplish the same thing but have different
implementations.

unpin_user_page() has a bug where it calls mod_node_page_state() after
calling put_page() which creates a risk that the page could have been
hot-uplugged from the system.

Fix this by using put_compound_head() as the only implementation.

__unpin_devmap_managed_user_page() and related can be deleted as well in
favour of the simpler, but slower, version in put_compound_head() that has
an extra atomic page_ref_sub, but always calls put_page() which internally
contains the special devmap code.

Move put_compound_head() to be directly after try_grab_compound_head() so
people can find it in future.

Fixes: 1970dc6f5226 ("mm/gup: /proc/vmstat: pin_user_pages (FOLL_PIN) reporting")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 mm/gup.c | 103 +++++++++++++------------------------------------------
 1 file changed, 23 insertions(+), 80 deletions(-)

With Matt's folio idea I'd next to go to make a
  put_folio(folio, refs)

Which would cleanly eliminate that extra atomic here without duplicating the
devmap special case.

This should also be called 'ungrab_compound_head' as we seem to be using the
word 'grab' to mean 'pin or get' depending on GUP flags.

diff --git a/mm/gup.c b/mm/gup.c
index 98eb8e6d2609c3..7b33b7d4b324d7 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -123,6 +123,28 @@ static __maybe_unused struct page *try_grab_compound_head(struct page *page,
 	return NULL;
 }
 
+static void put_compound_head(struct page *page, int refs, unsigned int flags)
+{
+	if (flags & FOLL_PIN) {
+		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_RELEASED,
+				    refs);
+
+		if (hpage_pincount_available(page))
+			hpage_pincount_sub(page, refs);
+		else
+			refs *= GUP_PIN_COUNTING_BIAS;
+	}
+
+	VM_BUG_ON_PAGE(page_ref_count(page) < refs, page);
+	/*
+	 * Calling put_page() for each ref is unnecessarily slow. Only the last
+	 * ref needs a put_page().
+	 */
+	if (refs > 1)
+		page_ref_sub(page, refs - 1);
+	put_page(page);
+}
+
 /**
  * try_grab_page() - elevate a page's refcount by a flag-dependent amount
  *
@@ -177,41 +199,6 @@ bool __must_check try_grab_page(struct page *page, unsigned int flags)
 	return true;
 }
 
-#ifdef CONFIG_DEV_PAGEMAP_OPS
-static bool __unpin_devmap_managed_user_page(struct page *page)
-{
-	int count, refs = 1;
-
-	if (!page_is_devmap_managed(page))
-		return false;
-
-	if (hpage_pincount_available(page))
-		hpage_pincount_sub(page, 1);
-	else
-		refs = GUP_PIN_COUNTING_BIAS;
-
-	count = page_ref_sub_return(page, refs);
-
-	mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_RELEASED, 1);
-	/*
-	 * devmap page refcounts are 1-based, rather than 0-based: if
-	 * refcount is 1, then the page is free and the refcount is
-	 * stable because nobody holds a reference on the page.
-	 */
-	if (count == 1)
-		free_devmap_managed_page(page);
-	else if (!count)
-		__put_page(page);
-
-	return true;
-}
-#else
-static bool __unpin_devmap_managed_user_page(struct page *page)
-{
-	return false;
-}
-#endif /* CONFIG_DEV_PAGEMAP_OPS */
-
 /**
  * unpin_user_page() - release a dma-pinned page
  * @page:            pointer to page to be released
@@ -223,28 +210,7 @@ static bool __unpin_devmap_managed_user_page(struct page *page)
  */
 void unpin_user_page(struct page *page)
 {
-	int refs = 1;
-
-	page = compound_head(page);
-
-	/*
-	 * For devmap managed pages we need to catch refcount transition from
-	 * GUP_PIN_COUNTING_BIAS to 1, when refcount reach one it means the
-	 * page is free and we need to inform the device driver through
-	 * callback. See include/linux/memremap.h and HMM for details.
-	 */
-	if (__unpin_devmap_managed_user_page(page))
-		return;
-
-	if (hpage_pincount_available(page))
-		hpage_pincount_sub(page, 1);
-	else
-		refs = GUP_PIN_COUNTING_BIAS;
-
-	if (page_ref_sub_and_test(page, refs))
-		__put_page(page);
-
-	mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_RELEASED, 1);
+	put_compound_head(compound_head(page), 1, FOLL_PIN);
 }
 EXPORT_SYMBOL(unpin_user_page);
 
@@ -2062,29 +2028,6 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
  * This code is based heavily on the PowerPC implementation by Nick Piggin.
  */
 #ifdef CONFIG_HAVE_FAST_GUP
-
-static void put_compound_head(struct page *page, int refs, unsigned int flags)
-{
-	if (flags & FOLL_PIN) {
-		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_RELEASED,
-				    refs);
-
-		if (hpage_pincount_available(page))
-			hpage_pincount_sub(page, refs);
-		else
-			refs *= GUP_PIN_COUNTING_BIAS;
-	}
-
-	VM_BUG_ON_PAGE(page_ref_count(page) < refs, page);
-	/*
-	 * Calling put_page() for each ref is unnecessarily slow. Only the last
-	 * ref needs a put_page().
-	 */
-	if (refs > 1)
-		page_ref_sub(page, refs - 1);
-	put_page(page);
-}
-
 #ifdef CONFIG_GUP_GET_PTE_LOW_HIGH
 
 /*
-- 
2.29.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

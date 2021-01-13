Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814FE2F4546
	for <lists+linux-nvdimm@lfdr.de>; Wed, 13 Jan 2021 08:35:44 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 43DD7100EB331;
	Tue, 12 Jan 2021 23:35:43 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2E8E9100EB332
	for <linux-nvdimm@lists.01.org>; Tue, 12 Jan 2021 23:35:40 -0800 (PST)
IronPort-SDR: X6j2BdEGHViL8DbUF2/R2d1/cp8WrHDg5DXnfXiF3otULwHUYoZ1uN5KZf0RcXqYKxkC+YsaKj
 lpH24j2lPGKw==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="239705248"
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400";
   d="scan'208";a="239705248"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 23:35:40 -0800
IronPort-SDR: ezqcf/6BUl4DeaFj02snXJ1RB3gza6UdaG1mXU+AXURDPOlEORbq7fRGK5E8JXNg2KsddJlPwd
 vbMgW9RkpGMg==
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400";
   d="scan'208";a="389412785"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 23:35:39 -0800
Subject: [PATCH v3 4/6] mm: Fix page reference leak in soft_offline_page()
From: Dan Williams <dan.j.williams@intel.com>
To: linux-mm@kvack.org
Date: Tue, 12 Jan 2021 23:35:38 -0800
Message-ID: <161052333875.1805594.3046789655044320351.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161052331545.1805594.2356512831689786960.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161052331545.1805594.2356512831689786960.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: 4A2VJJPEHTXVIGKEQW42G4WQMRIQKFLA
X-Message-ID-Hash: 4A2VJJPEHTXVIGKEQW42G4WQMRIQKFLA
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Andrew Morton <akpm@linux-foundation.org>, Naoya Horiguchi <nao.horiguchi@gmail.com>, Michal Hocko <mhocko@kernel.org>, David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>, stable@vger.kernel.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4A2VJJPEHTXVIGKEQW42G4WQMRIQKFLA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The conversion to move pfn_to_online_page() internal to
soft_offline_page() missed that the get_user_pages() reference taken by
the madvise() path needs to be dropped when pfn_to_online_page() fails.
Note the direct sysfs-path to soft_offline_page() does not perform a
get_user_pages() lookup.

When soft_offline_page() is handed a pfn_valid() &&
!pfn_to_online_page() pfn the kernel hangs at dax-device shutdown due to
a leaked reference.

Fixes: feec24a6139d ("mm, soft-offline: convert parameter to pfn")
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Michal Hocko <mhocko@kernel.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 mm/memory-failure.c |   20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 5a38e9eade94..78b173c7190c 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1885,6 +1885,12 @@ static int soft_offline_free_page(struct page *page)
 	return rc;
 }
 
+static void put_ref_page(struct page *page)
+{
+	if (page)
+		put_page(page);
+}
+
 /**
  * soft_offline_page - Soft offline a page.
  * @pfn: pfn to soft-offline
@@ -1910,20 +1916,26 @@ static int soft_offline_free_page(struct page *page)
 int soft_offline_page(unsigned long pfn, int flags)
 {
 	int ret;
-	struct page *page;
 	bool try_again = true;
+	struct page *page, *ref_page = NULL;
+
+	WARN_ON_ONCE(!pfn_valid(pfn) && (flags & MF_COUNT_INCREASED));
 
 	if (!pfn_valid(pfn))
 		return -ENXIO;
+	if (flags & MF_COUNT_INCREASED)
+		ref_page = pfn_to_page(pfn);
+
 	/* Only online pages can be soft-offlined (esp., not ZONE_DEVICE). */
 	page = pfn_to_online_page(pfn);
-	if (!page)
+	if (!page) {
+		put_ref_page(ref_page);
 		return -EIO;
+	}
 
 	if (PageHWPoison(page)) {
 		pr_info("%s: %#lx page already poisoned\n", __func__, pfn);
-		if (flags & MF_COUNT_INCREASED)
-			put_page(page);
+		put_ref_page(ref_page);
 		return 0;
 	}
 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

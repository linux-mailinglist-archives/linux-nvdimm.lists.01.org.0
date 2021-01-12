Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7661B2F2B5A
	for <lists+linux-nvdimm@lfdr.de>; Tue, 12 Jan 2021 10:35:03 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0B17D100EBB8D;
	Tue, 12 Jan 2021 01:35:02 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 73625100EBB8D
	for <linux-nvdimm@lists.01.org>; Tue, 12 Jan 2021 01:34:59 -0800 (PST)
IronPort-SDR: VBk57gnbyfL27WA6Cel22jqWUX5H4TEN8PUoTOGQ+rQ+pZqvAh9a9zZPnFg2i5QpN1pqPOtxJp
 KJNL2NvYY2Tg==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="157788142"
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400";
   d="scan'208";a="157788142"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 01:34:58 -0800
IronPort-SDR: 4TSrFpjxdyLfaLml0thLClygScVZvIKkcaXY0+AZZr2Jl3jmQhCIG29P4PmSL8NQX5bZfRWq/5
 4B8qgPvs6sjw==
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400";
   d="scan'208";a="571641600"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 01:34:58 -0800
Subject: [PATCH v2 4/5] mm: Fix page reference leak in soft_offline_page()
From: Dan Williams <dan.j.williams@intel.com>
To: linux-mm@kvack.org
Date: Tue, 12 Jan 2021 01:34:58 -0800
Message-ID: <161044409809.1482714.11965583624142790079.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161044407603.1482714.16630477578392768273.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161044407603.1482714.16630477578392768273.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: 6RROSYKQXFDK36PRHCTVZVPMEO4G3V65
X-Message-ID-Hash: 6RROSYKQXFDK36PRHCTVZVPMEO4G3V65
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Andrew Morton <akpm@linux-foundation.org>, Naoya Horiguchi <nao.horiguchi@gmail.com>, David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@kernel.org>, Oscar Salvador <osalvador@suse.de>, stable@vger.kernel.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6RROSYKQXFDK36PRHCTVZVPMEO4G3V65/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The conversion to move pfn_to_online_page() internal to
soft_offline_page() missed that the get_user_pages() reference needs to
be dropped when pfn_to_online_page() fails.

When soft_offline_page() is handed a pfn_valid() &&
!pfn_to_online_page() pfn the kernel hangs at dax-device shutdown due to
a leaked reference.

Fixes: feec24a6139d ("mm, soft-offline: convert parameter to pfn")
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
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

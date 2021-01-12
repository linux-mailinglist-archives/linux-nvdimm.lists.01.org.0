Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C102F2B58
	for <lists+linux-nvdimm@lfdr.de>; Tue, 12 Jan 2021 10:34:52 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D540F100EBB85;
	Tue, 12 Jan 2021 01:34:50 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D56F4100EBB76
	for <linux-nvdimm@lists.01.org>; Tue, 12 Jan 2021 01:34:48 -0800 (PST)
IronPort-SDR: cUczfSqptBmy+zy+sD0ObBIisFPeLkv0YFXaBuYwywAeHZOBbUlYYfO8LBRCGdBuZJVZZ9DxXp
 Nfg8zi508ubg==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="239553843"
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400";
   d="scan'208";a="239553843"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 01:34:48 -0800
IronPort-SDR: F+QHxLFNOOiU2I7WoXCiKIDJj6S1wHU/yGPTRdWIb32AROKUSDXxZnOHt8KVKHCCGYMkr7zU2f
 ZIsgw8hhmZsQ==
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400";
   d="scan'208";a="400110663"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 01:34:47 -0800
Subject: [PATCH v2 2/5] mm: Teach pfn_to_online_page() to consider
 subsection validity
From: Dan Williams <dan.j.williams@intel.com>
To: linux-mm@kvack.org
Date: Tue, 12 Jan 2021 01:34:47 -0800
Message-ID: <161044408728.1482714.9086710868634042303.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161044407603.1482714.16630477578392768273.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161044407603.1482714.16630477578392768273.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: NPTDGNUI2Y3GNFICOL7CXZ5GQXVJFRW4
X-Message-ID-Hash: NPTDGNUI2Y3GNFICOL7CXZ5GQXVJFRW4
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NPTDGNUI2Y3GNFICOL7CXZ5GQXVJFRW4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

pfn_section_valid() determines pfn validity on subsection granularity.

pfn_valid_within() internally uses pfn_section_valid(), but gates it
with early_section() to preserve the traditional behavior of pfn_valid()
before subsection support was added.

pfn_to_online_page() wants the explicit precision that pfn_valid() does
not offer, so use pfn_section_valid() directly. Since
pfn_to_online_page() already open codes the validity of the section
number vs NR_MEM_SECTIONS, there's not much value to using
pfn_valid_within(), just use pfn_section_valid(). This loses the
valid_section() check that pfn_valid_within() was performing, but that
was already redundant with the online check.

Fixes: b13bc35193d9 ("mm/hotplug: invalid PFNs from pfn_to_online_page()")
Cc: Qian Cai <cai@lca.pw>
Cc: Michal Hocko <mhocko@suse.com>
Reported-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 55a69d4396e7..a845b3979bc0 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -308,11 +308,19 @@ static int check_hotplug_memory_addressable(unsigned long pfn,
 struct page *pfn_to_online_page(unsigned long pfn)
 {
 	unsigned long nr = pfn_to_section_nr(pfn);
+	struct mem_section *ms;
+
+	if (nr >= NR_MEM_SECTIONS)
+		return NULL;
+
+	ms = __nr_to_section(nr);
+	if (!online_section(ms))
+		return NULL;
+
+	if (!pfn_section_valid(ms, pfn))
+		return NULL;
 
-	if (nr < NR_MEM_SECTIONS && online_section_nr(nr) &&
-	    pfn_valid_within(pfn))
-		return pfn_to_page(pfn);
-	return NULL;
+	return pfn_to_page(pfn);
 }
 EXPORT_SYMBOL_GPL(pfn_to_online_page);
 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

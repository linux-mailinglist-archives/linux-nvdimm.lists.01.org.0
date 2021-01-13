Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 871B32F4540
	for <lists+linux-nvdimm@lfdr.de>; Wed, 13 Jan 2021 08:35:27 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BADB2100EB329;
	Tue, 12 Jan 2021 23:35:25 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1B673100EB327
	for <linux-nvdimm@lists.01.org>; Tue, 12 Jan 2021 23:35:23 -0800 (PST)
IronPort-SDR: e6+KnCyA1j149H0LfAdGRra5Nuoav2AG1DxLMY8ybDNOzPGJnSdFUDwrPqwaXmHDXsSu2jpezE
 X+DzDIub+rQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="239705221"
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400";
   d="scan'208";a="239705221"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 23:35:22 -0800
IronPort-SDR: 7ft/S9SXYS17BgAO+zRFAtUO6aO7vn7AS1CmXPcxiVz1u10rMW79+z0AuIJEE2A/4jQI83e5p8
 fgd+P8bO38Nw==
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400";
   d="scan'208";a="404741003"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 23:35:22 -0800
Subject: [PATCH v3 1/6] mm: Move pfn_to_online_page() out of line
From: Dan Williams <dan.j.williams@intel.com>
To: linux-mm@kvack.org
Date: Tue, 12 Jan 2021 23:35:21 -0800
Message-ID: <161052332150.1805594.6767273540561236770.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161052331545.1805594.2356512831689786960.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161052331545.1805594.2356512831689786960.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: ZEAESEYPTSEVD4PFQU4J4HGHNZRK6NNC
X-Message-ID-Hash: ZEAESEYPTSEVD4PFQU4J4HGHNZRK6NNC
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Michal Hocko <mhocko@kernel.org>, David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZEAESEYPTSEVD4PFQU4J4HGHNZRK6NNC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

pfn_to_online_page() is already too large to be a macro or an inline
function. In anticipation of further logic changes / growth, move it out
of line.

No functional change, just code movement.

Reported-by: Michal Hocko <mhocko@kernel.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/memory_hotplug.h |   17 +----------------
 mm/memory_hotplug.c            |   16 ++++++++++++++++
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 15acce5ab106..3d99de0db2dd 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -16,22 +16,7 @@ struct resource;
 struct vmem_altmap;
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-/*
- * Return page for the valid pfn only if the page is online. All pfn
- * walkers which rely on the fully initialized page->flags and others
- * should use this rather than pfn_valid && pfn_to_page
- */
-#define pfn_to_online_page(pfn)					   \
-({								   \
-	struct page *___page = NULL;				   \
-	unsigned long ___pfn = pfn;				   \
-	unsigned long ___nr = pfn_to_section_nr(___pfn);	   \
-								   \
-	if (___nr < NR_MEM_SECTIONS && online_section_nr(___nr) && \
-	    pfn_valid_within(___pfn))				   \
-		___page = pfn_to_page(___pfn);			   \
-	___page;						   \
-})
+struct page *pfn_to_online_page(unsigned long pfn);
 
 /*
  * Types for free bootmem stored in page->lru.next. These have to be in
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index f9d57b9be8c7..55a69d4396e7 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -300,6 +300,22 @@ static int check_hotplug_memory_addressable(unsigned long pfn,
 	return 0;
 }
 
+/*
+ * Return page for the valid pfn only if the page is online. All pfn
+ * walkers which rely on the fully initialized page->flags and others
+ * should use this rather than pfn_valid && pfn_to_page
+ */
+struct page *pfn_to_online_page(unsigned long pfn)
+{
+	unsigned long nr = pfn_to_section_nr(pfn);
+
+	if (nr < NR_MEM_SECTIONS && online_section_nr(nr) &&
+	    pfn_valid_within(pfn))
+		return pfn_to_page(pfn);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(pfn_to_online_page);
+
 /*
  * Reasonably generic function for adding memory.  It is
  * expected that archs that support memory hotplug will
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

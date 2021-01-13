Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC622F4542
	for <lists+linux-nvdimm@lfdr.de>; Wed, 13 Jan 2021 08:35:33 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ED925100EB330;
	Tue, 12 Jan 2021 23:35:31 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 720CA100EB32C
	for <linux-nvdimm@lists.01.org>; Tue, 12 Jan 2021 23:35:29 -0800 (PST)
IronPort-SDR: QQEYEx5Bzn2ekRiKTsn7KWF9bTiliQgG7LOFiXm4NY3T5ymzJfl08VPyqbs44aUmdD7JMUyxxH
 GmC/iScxjZ8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="177387882"
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400";
   d="scan'208";a="177387882"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 23:35:28 -0800
IronPort-SDR: TxaCVHWg9sHbgbbnmaJoX83Ad9yllXRKmlOa04N3hMfRvtzA0XjaxcTjtdpq8+VY66nf+DHuVm
 hoYIkt//vKDw==
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400";
   d="scan'208";a="397639445"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 23:35:28 -0800
Subject: [PATCH v3 2/6] mm: Teach pfn_to_online_page() to consider
 subsection validity
From: Dan Williams <dan.j.williams@intel.com>
To: linux-mm@kvack.org
Date: Tue, 12 Jan 2021 23:35:27 -0800
Message-ID: <161052332755.1805594.9846390935351758277.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161052331545.1805594.2356512831689786960.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161052331545.1805594.2356512831689786960.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: O5UB4Q3W6Q6CS7CROU5Z6RH44P6SMWZI
X-Message-ID-Hash: O5UB4Q3W6Q6CS7CROU5Z6RH44P6SMWZI
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@redhat.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/O5UB4Q3W6Q6CS7CROU5Z6RH44P6SMWZI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

pfn_section_valid() determines pfn validity on subsection granularity
where pfn_valid() may be limited to coarse section granularity.
Explicitly validate subsections after pfn_valid() succeeds.

Fixes: b13bc35193d9 ("mm/hotplug: invalid PFNs from pfn_to_online_page()")
Cc: Qian Cai <cai@lca.pw>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Reported-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 mm/memory_hotplug.c |   24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 55a69d4396e7..9f37f8a68da4 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -308,11 +308,27 @@ static int check_hotplug_memory_addressable(unsigned long pfn,
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
+	/*
+	 * Save some code text when online_section() +
+	 * pfn_section_valid() are sufficient.
+	 */
+	if (IS_ENABLED(CONFIG_HAVE_ARCH_PFN_VALID))
+		if (!pfn_valid(pfn))
+			return NULL;
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

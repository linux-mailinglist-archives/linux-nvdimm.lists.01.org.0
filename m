Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3586B156AC
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 May 2019 01:53:38 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E2CD5212377F6;
	Mon,  6 May 2019 16:53:36 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.136; helo=mga12.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id CC4122121493D
 for <linux-nvdimm@lists.01.org>; Mon,  6 May 2019 16:53:34 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 May 2019 16:53:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,439,1549958400"; d="scan'208";a="149329731"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by fmsmga007.fm.intel.com with ESMTP; 06 May 2019 16:53:34 -0700
Subject: [PATCH v8 04/12] mm/hotplug: Prepare shrink_{zone,
 pgdat}_span for sub-section removal
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Date: Mon, 06 May 2019 16:39:47 -0700
Message-ID: <155718598766.130019.2843092676507694047.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155718596657.130019.17139634728875079809.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155718596657.130019.17139634728875079809.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
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
Cc: mhocko@suse.com, Pavel Tatashin <pasha.tatashin@soleen.com>,
 linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Vlastimil Babka <vbabka@suse.cz>, osalvador@suse.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Sub-section hotplug support reduces the unit of operation of hotplug
from section-sized-units (PAGES_PER_SECTION) to sub-section-sized units
(PAGES_PER_SUBSECTION). Teach shrink_{zone,pgdat}_span() to consider
PAGES_PER_SUBSECTION boundaries as the points where pfn_valid(), not
valid_section(), can toggle.

Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 mm/memory_hotplug.c |   29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index a76fc6a6e9fe..393ab2b9c3f7 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -325,12 +325,8 @@ static unsigned long find_smallest_section_pfn(int nid, struct zone *zone,
 				     unsigned long start_pfn,
 				     unsigned long end_pfn)
 {
-	struct mem_section *ms;
-
-	for (; start_pfn < end_pfn; start_pfn += PAGES_PER_SECTION) {
-		ms = __pfn_to_section(start_pfn);
-
-		if (unlikely(!valid_section(ms)))
+	for (; start_pfn < end_pfn; start_pfn += PAGES_PER_SUBSECTION) {
+		if (unlikely(!pfn_valid(start_pfn)))
 			continue;
 
 		if (unlikely(pfn_to_nid(start_pfn) != nid))
@@ -350,15 +346,12 @@ static unsigned long find_biggest_section_pfn(int nid, struct zone *zone,
 				    unsigned long start_pfn,
 				    unsigned long end_pfn)
 {
-	struct mem_section *ms;
 	unsigned long pfn;
 
 	/* pfn is the end pfn of a memory section. */
 	pfn = end_pfn - 1;
-	for (; pfn >= start_pfn; pfn -= PAGES_PER_SECTION) {
-		ms = __pfn_to_section(pfn);
-
-		if (unlikely(!valid_section(ms)))
+	for (; pfn >= start_pfn; pfn -= PAGES_PER_SUBSECTION) {
+		if (unlikely(!pfn_valid(pfn)))
 			continue;
 
 		if (unlikely(pfn_to_nid(pfn) != nid))
@@ -380,7 +373,6 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
 	unsigned long z = zone_end_pfn(zone); /* zone_end_pfn namespace clash */
 	unsigned long zone_end_pfn = z;
 	unsigned long pfn;
-	struct mem_section *ms;
 	int nid = zone_to_nid(zone);
 
 	zone_span_writelock(zone);
@@ -417,10 +409,8 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
 	 * it check the zone has only hole or not.
 	 */
 	pfn = zone_start_pfn;
-	for (; pfn < zone_end_pfn; pfn += PAGES_PER_SECTION) {
-		ms = __pfn_to_section(pfn);
-
-		if (unlikely(!valid_section(ms)))
+	for (; pfn < zone_end_pfn; pfn += PAGES_PER_SUBSECTION) {
+		if (unlikely(!pfn_valid(pfn)))
 			continue;
 
 		if (page_zone(pfn_to_page(pfn)) != zone)
@@ -448,7 +438,6 @@ static void shrink_pgdat_span(struct pglist_data *pgdat,
 	unsigned long p = pgdat_end_pfn(pgdat); /* pgdat_end_pfn namespace clash */
 	unsigned long pgdat_end_pfn = p;
 	unsigned long pfn;
-	struct mem_section *ms;
 	int nid = pgdat->node_id;
 
 	if (pgdat_start_pfn == start_pfn) {
@@ -485,10 +474,8 @@ static void shrink_pgdat_span(struct pglist_data *pgdat,
 	 * has only hole or not.
 	 */
 	pfn = pgdat_start_pfn;
-	for (; pfn < pgdat_end_pfn; pfn += PAGES_PER_SECTION) {
-		ms = __pfn_to_section(pfn);
-
-		if (unlikely(!valid_section(ms)))
+	for (; pfn < pgdat_end_pfn; pfn += PAGES_PER_SUBSECTION) {
+		if (unlikely(!pfn_valid(pfn)))
 			continue;
 
 		if (pfn_to_nid(pfn) != nid)

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

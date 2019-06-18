Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7854E4970E
	for <lists+linux-nvdimm@lfdr.de>; Tue, 18 Jun 2019 03:42:52 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DAA0F21295B08;
	Mon, 17 Jun 2019 18:42:50 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=192.55.52.115;
 helo=mga14.intel.com; envelope-from=richardw.yang@linux.intel.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id DFAF22128D698
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 18:42:48 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Jun 2019 18:42:48 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga005.fm.intel.com with ESMTP; 17 Jun 2019 18:42:46 -0700
Date: Tue, 18 Jun 2019 09:42:23 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v9 03/12] mm/hotplug: Prepare shrink_{zone, pgdat}_span
 for sub-section removal
Message-ID: <20190618014223.GD18161@richard>
References: <155977186863.2443951.9036044808311959913.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155977188458.2443951.9573565800736334460.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <155977188458.2443951.9573565800736334460.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: mhocko@suse.com, Pavel Tatashin <pasha.tatashin@soleen.com>,
 linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 akpm@linux-foundation.org, Vlastimil Babka <vbabka@suse.cz>, osalvador@suse.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jun 05, 2019 at 02:58:04PM -0700, Dan Williams wrote:
>Sub-section hotplug support reduces the unit of operation of hotplug
>from section-sized-units (PAGES_PER_SECTION) to sub-section-sized units
>(PAGES_PER_SUBSECTION). Teach shrink_{zone,pgdat}_span() to consider
>PAGES_PER_SUBSECTION boundaries as the points where pfn_valid(), not
>valid_section(), can toggle.
>
>Cc: Michal Hocko <mhocko@suse.com>
>Cc: Vlastimil Babka <vbabka@suse.cz>
>Cc: Logan Gunthorpe <logang@deltatee.com>
>Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
>Reviewed-by: Oscar Salvador <osalvador@suse.de>
>Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>---
> mm/memory_hotplug.c |   29 ++++++++---------------------
> 1 file changed, 8 insertions(+), 21 deletions(-)
>
>diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>index 7b963c2d3a0d..647859a1d119 100644
>--- a/mm/memory_hotplug.c
>+++ b/mm/memory_hotplug.c
>@@ -318,12 +318,8 @@ static unsigned long find_smallest_section_pfn(int nid, struct zone *zone,
> 				     unsigned long start_pfn,
> 				     unsigned long end_pfn)
> {
>-	struct mem_section *ms;
>-
>-	for (; start_pfn < end_pfn; start_pfn += PAGES_PER_SECTION) {
>-		ms = __pfn_to_section(start_pfn);
>-
>-		if (unlikely(!valid_section(ms)))
>+	for (; start_pfn < end_pfn; start_pfn += PAGES_PER_SUBSECTION) {
>+		if (unlikely(!pfn_valid(start_pfn)))
> 			continue;

Hmm, we change the granularity of valid section from SECTION to SUBSECTION.
But we didn't change the granularity of node id and zone information.

For example, we found the node id of a pfn mismatch, we can skip the whole
section instead of a subsection.

Maybe this is not a big deal.

> 
> 		if (unlikely(pfn_to_nid(start_pfn) != nid))
>@@ -343,15 +339,12 @@ static unsigned long find_biggest_section_pfn(int nid, struct zone *zone,
> 				    unsigned long start_pfn,
> 				    unsigned long end_pfn)
> {
>-	struct mem_section *ms;
> 	unsigned long pfn;
> 
> 	/* pfn is the end pfn of a memory section. */
> 	pfn = end_pfn - 1;
>-	for (; pfn >= start_pfn; pfn -= PAGES_PER_SECTION) {
>-		ms = __pfn_to_section(pfn);
>-
>-		if (unlikely(!valid_section(ms)))
>+	for (; pfn >= start_pfn; pfn -= PAGES_PER_SUBSECTION) {
>+		if (unlikely(!pfn_valid(pfn)))
> 			continue;
> 
> 		if (unlikely(pfn_to_nid(pfn) != nid))
>@@ -373,7 +366,6 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
> 	unsigned long z = zone_end_pfn(zone); /* zone_end_pfn namespace clash */
> 	unsigned long zone_end_pfn = z;
> 	unsigned long pfn;
>-	struct mem_section *ms;
> 	int nid = zone_to_nid(zone);
> 
> 	zone_span_writelock(zone);
>@@ -410,10 +402,8 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
> 	 * it check the zone has only hole or not.
> 	 */
> 	pfn = zone_start_pfn;
>-	for (; pfn < zone_end_pfn; pfn += PAGES_PER_SECTION) {
>-		ms = __pfn_to_section(pfn);
>-
>-		if (unlikely(!valid_section(ms)))
>+	for (; pfn < zone_end_pfn; pfn += PAGES_PER_SUBSECTION) {
>+		if (unlikely(!pfn_valid(pfn)))
> 			continue;
> 
> 		if (page_zone(pfn_to_page(pfn)) != zone)
>@@ -441,7 +431,6 @@ static void shrink_pgdat_span(struct pglist_data *pgdat,
> 	unsigned long p = pgdat_end_pfn(pgdat); /* pgdat_end_pfn namespace clash */
> 	unsigned long pgdat_end_pfn = p;
> 	unsigned long pfn;
>-	struct mem_section *ms;
> 	int nid = pgdat->node_id;
> 
> 	if (pgdat_start_pfn == start_pfn) {
>@@ -478,10 +467,8 @@ static void shrink_pgdat_span(struct pglist_data *pgdat,
> 	 * has only hole or not.
> 	 */
> 	pfn = pgdat_start_pfn;
>-	for (; pfn < pgdat_end_pfn; pfn += PAGES_PER_SECTION) {
>-		ms = __pfn_to_section(pfn);
>-
>-		if (unlikely(!valid_section(ms)))
>+	for (; pfn < pgdat_end_pfn; pfn += PAGES_PER_SUBSECTION) {
>+		if (unlikely(!pfn_valid(pfn)))
> 			continue;
> 
> 		if (pfn_to_nid(pfn) != nid)
>
>_______________________________________________
>Linux-nvdimm mailing list
>Linux-nvdimm@lists.01.org
>https://lists.01.org/mailman/listinfo/linux-nvdimm

-- 
Wei Yang
Help you, Help me
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

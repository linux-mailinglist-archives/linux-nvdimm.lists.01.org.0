Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A765497CD
	for <lists+linux-nvdimm@lfdr.de>; Tue, 18 Jun 2019 05:36:15 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6A07321297043;
	Mon, 17 Jun 2019 20:36:13 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=134.134.136.65;
 helo=mga03.intel.com; envelope-from=richardw.yang@linux.intel.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id DA66321290DE3
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 20:36:11 -0700 (PDT)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Jun 2019 20:36:11 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga001.fm.intel.com with ESMTP; 17 Jun 2019 20:36:09 -0700
Date: Tue, 18 Jun 2019 11:35:46 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v9 06/12] mm: Kill is_dev_zone() helper
Message-ID: <20190618033546.GE18161@richard>
References: <155977186863.2443951.9036044808311959913.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155977191260.2443951.15908146523735681570.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <155977191260.2443951.15908146523735681570.stgit@dwillia2-desk3.amr.corp.intel.com>
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
 linux-nvdimm@lists.01.org, David Hildenbrand <david@redhat.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
 osalvador@suse.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jun 05, 2019 at 02:58:32PM -0700, Dan Williams wrote:
>Given there are no more usages of is_dev_zone() outside of 'ifdef
>CONFIG_ZONE_DEVICE' protection, kill off the compilation helper.
>
>Cc: Michal Hocko <mhocko@suse.com>
>Cc: Logan Gunthorpe <logang@deltatee.com>
>Acked-by: David Hildenbrand <david@redhat.com>
>Reviewed-by: Oscar Salvador <osalvador@suse.de>
>Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
>Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

>---
> include/linux/mmzone.h |   12 ------------
> mm/page_alloc.c        |    2 +-
> 2 files changed, 1 insertion(+), 13 deletions(-)
>
>diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>index 6dd52d544857..49e7fb452dfd 100644
>--- a/include/linux/mmzone.h
>+++ b/include/linux/mmzone.h
>@@ -855,18 +855,6 @@ static inline int local_memory_node(int node_id) { return node_id; };
>  */
> #define zone_idx(zone)		((zone) - (zone)->zone_pgdat->node_zones)
> 
>-#ifdef CONFIG_ZONE_DEVICE
>-static inline bool is_dev_zone(const struct zone *zone)
>-{
>-	return zone_idx(zone) == ZONE_DEVICE;
>-}
>-#else
>-static inline bool is_dev_zone(const struct zone *zone)
>-{
>-	return false;
>-}
>-#endif
>-
> /*
>  * Returns true if a zone has pages managed by the buddy allocator.
>  * All the reclaim decisions have to use this function rather than
>diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>index bd773efe5b82..5dff3f49a372 100644
>--- a/mm/page_alloc.c
>+++ b/mm/page_alloc.c
>@@ -5865,7 +5865,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
> 	unsigned long start = jiffies;
> 	int nid = pgdat->node_id;
> 
>-	if (WARN_ON_ONCE(!pgmap || !is_dev_zone(zone)))
>+	if (WARN_ON_ONCE(!pgmap || zone_idx(zone) != ZONE_DEVICE))
> 		return;
> 
> 	/*
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

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C736112E8F
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 May 2019 14:56:43 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E4C792124B908;
	Fri,  3 May 2019 05:56:41 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=osalvador@suse.de;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 666F921244A78
 for <linux-nvdimm@lists.01.org>; Fri,  3 May 2019 05:56:39 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 91E0EAD62;
 Fri,  3 May 2019 12:56:37 +0000 (UTC)
Date: Fri, 3 May 2019 14:56:34 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v7 09/12] mm/sparsemem: Support sub-section hotplug
Message-ID: <20190503125634.GH15740@linux>
References: <155677652226.2336373.8700273400832001094.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155677657023.2336373.4452495266651002382.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <155677657023.2336373.4452495266651002382.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Cc: Michal Hocko <mhocko@suse.com>, linux-nvdimm@lists.01.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
 Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, May 01, 2019 at 10:56:10PM -0700, Dan Williams wrote:
> The libnvdimm sub-system has suffered a series of hacks and broken
> workarounds for the memory-hotplug implementation's awkward
> section-aligned (128MB) granularity. For example the following backtrace
> is emitted when attempting arch_add_memory() with physical address
> ranges that intersect 'System RAM' (RAM) with 'Persistent Memory' (PMEM)
> within a given section:
> 
>  WARNING: CPU: 0 PID: 558 at kernel/memremap.c:300 devm_memremap_pages+0x3b5/0x4c0
>  devm_memremap_pages attempted on mixed region [mem 0x200000000-0x2fbffffff flags 0x200]
>  [..]
>  Call Trace:
>    dump_stack+0x86/0xc3
>    __warn+0xcb/0xf0
>    warn_slowpath_fmt+0x5f/0x80
>    devm_memremap_pages+0x3b5/0x4c0
>    __wrap_devm_memremap_pages+0x58/0x70 [nfit_test_iomap]
>    pmem_attach_disk+0x19a/0x440 [nd_pmem]
> 
> Recently it was discovered that the problem goes beyond RAM vs PMEM
> collisions as some platform produce PMEM vs PMEM collisions within a
> given section. The libnvdimm workaround for that case revealed that the
> libnvdimm section-alignment-padding implementation has been broken for a
> long while. A fix for that long-standing breakage introduces as many
> problems as it solves as it would require a backward-incompatible change
> to the namespace metadata interpretation. Instead of that dubious route
> [1], address the root problem in the memory-hotplug implementation.
> 
> [1]: https://lore.kernel.org/r/155000671719.348031.2347363160141119237.stgit@dwillia2-desk3.amr.corp.intel.com
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  mm/sparse.c |  223 ++++++++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 150 insertions(+), 73 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 198371e5fc87..419a3620af6e 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -83,8 +83,15 @@ static int __meminit sparse_index_init(unsigned long section_nr, int nid)
>  	unsigned long root = SECTION_NR_TO_ROOT(section_nr);
>  	struct mem_section *section;
>  
> +	/*
> +	 * An existing section is possible in the sub-section hotplug
> +	 * case. First hot-add instantiates, follow-on hot-add reuses
> +	 * the existing section.
> +	 *
> +	 * The mem_hotplug_lock resolves the apparent race below.
> +	 */
>  	if (mem_section[root])
> -		return -EEXIST;
> +		return 0;

Just a sidenote: we do not bail out on -EEXIST, so it should be fine if we
stick with it.
But if not, I would then clean up sparse_add_section:

--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -901,13 +901,12 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
        int ret;
 
        ret = sparse_index_init(section_nr, nid);
-       if (ret < 0 && ret != -EEXIST)
+       if (ret < 0)
                return ret;
 
        memmap = section_activate(nid, start_pfn, nr_pages, altmap);
        if (IS_ERR(memmap))
                return PTR_ERR(memmap);
-       ret = 0;


> +
> +	if (!mask)
> +		rc = -EINVAL;
> +	else if (mask & ms->usage->map_active)

	else if (ms->usage->map_active) should be enough?

> +		rc = -EEXIST;
> +	else
> +		ms->usage->map_active |= mask;
> +
> +	if (rc) {
> +		if (usage)
> +			ms->usage = NULL;
> +		kfree(usage);
> +		return ERR_PTR(rc);
> +	}
> +
> +	/*
> +	 * The early init code does not consider partially populated
> +	 * initial sections, it simply assumes that memory will never be
> +	 * referenced.  If we hot-add memory into such a section then we
> +	 * do not need to populate the memmap and can simply reuse what
> +	 * is already there.
> +	 */

This puzzles me a bit.
I think we cannot have partially populated early sections, can we?
And how we even come to hot-add memory into those?

Could you please elaborate a bit here?

> +	ms = __pfn_to_section(start_pfn);
>  	section_mark_present(ms);
> -	sparse_init_one_section(ms, section_nr, memmap, usage);
> +	sparse_init_one_section(ms, section_nr, memmap, ms->usage);
>  
> -out:
> -	if (ret < 0) {
> -		kfree(usage);
> -		depopulate_section_memmap(start_pfn, PAGES_PER_SECTION, altmap);
> -	}
> +	if (ret < 0)
> +		section_deactivate(start_pfn, nr_pages, nid, altmap);

Uhm, if my eyes do not trick me, ret is only used for the return value from
sparse_index_init(), so this is not needed. Can we get rid of it?

Unfortunately I am running out of time, but I plan to keep reviewing this patch
in the next few days.

-- 
Oscar Salvador
SUSE L3
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

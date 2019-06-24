Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C30651C93
	for <lists+linux-nvdimm@lfdr.de>; Mon, 24 Jun 2019 22:45:36 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E76BC21296707;
	Mon, 24 Jun 2019 13:45:34 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=osalvador@suse.de;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 73DF72126D808
 for <linux-nvdimm@lists.01.org>; Mon, 24 Jun 2019 13:45:33 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id CC8C4AE34;
 Mon, 24 Jun 2019 20:45:31 +0000 (UTC)
Message-ID: <1561409129.3058.1.camel@suse.de>
Subject: Re: [PATCH v10 09/13] mm/sparsemem: Support sub-section hotplug
From: Oscar Salvador <osalvador@suse.de>
To: Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
Date: Mon, 24 Jun 2019 22:45:29 +0200
In-Reply-To: <156092354368.979959.6232443923440952359.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156092349300.979959.17603710711957735135.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156092354368.979959.6232443923440952359.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Mailer: Evolution 3.26.1 
Mime-Version: 1.0
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
Cc: Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>,
 linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, 2019-06-18 at 22:52 -0700, Dan Williams wrote:
> The libnvdimm sub-system has suffered a series of hacks and broken
> workarounds for the memory-hotplug implementation's awkward
> section-aligned (128MB) granularity. For example the following
> backtrace
> is emitted when attempting arch_add_memory() with physical address
> ranges that intersect 'System RAM' (RAM) with 'Persistent Memory'
> (PMEM)
> within a given section:
> 
>     # cat /proc/iomem | grep -A1 -B1 Persistent\ Memory
>     100000000-1ffffffff : System RAM
>     200000000-303ffffff : Persistent Memory (legacy)
>     304000000-43fffffff : System RAM
>     440000000-23ffffffff : Persistent Memory
>     2400000000-43bfffffff : Persistent Memory
>       2400000000-43bfffffff : namespace2.0
> 
>     WARNING: CPU: 38 PID: 928 at arch/x86/mm/init_64.c:850
> add_pages+0x5c/0x60
>     [..]
>     RIP: 0010:add_pages+0x5c/0x60
>     [..]
>     Call Trace:
>      devm_memremap_pages+0x460/0x6e0
>      pmem_attach_disk+0x29e/0x680 [nd_pmem]
>      ? nd_dax_probe+0xfc/0x120 [libnvdimm]
>      nvdimm_bus_probe+0x66/0x160 [libnvdimm]
> 
> It was discovered that the problem goes beyond RAM vs PMEM collisions
> as
> some platform produce PMEM vs PMEM collisions within a given section.
> The libnvdimm workaround for that case revealed that the libnvdimm
> section-alignment-padding implementation has been broken for a long
> while. A fix for that long-standing breakage introduces as many
> problems
> as it solves as it would require a backward-incompatible change to
> the
> namespace metadata interpretation. Instead of that dubious route [1],
> address the root problem in the memory-hotplug implementation.
> 
> Note that EEXIST is no longer treated as success as that is how
> sparse_add_section() reports subsection collisions, it was also
> obviated
> by recent changes to perform the request_region() for 'System RAM'
> before arch_add_memory() in the add_memory() sequence.
> 
> [1]: https://lore.kernel.org/r/155000671719.348031.234736316014111923
> 7.stgit@dwillia2-desk3.amr.corp.intel.com
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE L3
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

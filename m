Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1166E4D46C
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Jun 2019 19:00:46 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 94E6D2194EB70;
	Thu, 20 Jun 2019 10:00:44 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=osalvador@suse.de;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id AF6A62129EB9A
 for <linux-nvdimm@lists.01.org>; Thu, 20 Jun 2019 10:00:42 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 89D3BAFC3;
 Thu, 20 Jun 2019 17:00:40 +0000 (UTC)
Date: Thu, 20 Jun 2019 19:00:35 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v10 00/13] mm: Sub-section memory hotplug support
Message-ID: <20190620170027.GA7126@linux>
References: <156092349300.979959.17603710711957735135.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <156092349300.979959.17603710711957735135.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Cc: Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>,
 David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, stable@vger.kernel.org,
 Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, Qian Cai <cai@lca.pw>,
 akpm@linux-foundation.org, Vlastimil Babka <vbabka@suse.cz>,
 linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Jun 18, 2019 at 10:51:33PM -0700, Dan Williams wrote:
> Changes since v9 [1]:
> - Fix multiple issues related to the fact that pfn_valid() has
>   traditionally returned true for any pfn in an 'early' (onlined at
>   boot) section regardless of whether that pfn represented 'System RAM'.
>   Teach pfn_valid() to maintain its traditional behavior in the presence
>   of subsections. Specifically, subsection precision for pfn_valid() is
>   only considered for non-early / hot-plugged sections. (Qian)
> 
> - Related to the first item introduce a SECTION_IS_EARLY
>   (->section_mem_map flag) to remove the existing hacks for determining
>   an early section by looking at whether the usemap was allocated from the
>   slab.
> 
> - Kill off the EEXIST hackery in __add_pages(). It breaks
>   (arch_add_memory() false-positive) the detection of subsection
>   collisions reported by section_activate(). It is also obviated by
>   David's recent reworks to move the 'System RAM' request_region() earlier
>   in the add_memory() sequence().
> 
> - Switch to an arch-independent / static subsection-size of 2MB.
>   Otherwise, a per-arch subsection-size is a roadblock on the path to
>   persistent memory namespace compatibility across archs. (Jeff)
> 
> - Update the changelog for "libnvdimm/pfn: Fix fsdax-mode namespace
>   info-block zero-fields" to clarify that the "Cc: stable" is only there
>   as safety measure for a distro that decides to backport "libnvdimm/pfn:
>   Stop padding pmem namespaces to section alignment", otherwise there is
>   no known bug exposure in older kernels. (Andrew)
>   
> - Drop some redundant subsection checks (Oscar)
> 
> - Collect some reviewed-bys
> 
> [1]: https://lore.kernel.org/lkml/155977186863.2443951.9036044808311959913.stgit@dwillia2-desk3.amr.corp.intel.com/

Hi Dan,

I am planning to give it a final review later tomorrow.
Now that this work is settled, I took the chance to dust off and push my
vmemmap-hotplug, and I am working on that right now.
But I would definetely come back to this tomorrow.

Thanks for the work

-- 
Oscar Salvador
SUSE L3
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

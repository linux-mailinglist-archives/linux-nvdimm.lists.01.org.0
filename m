Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7622F2D52
	for <lists+linux-nvdimm@lfdr.de>; Tue, 12 Jan 2021 12:00:37 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D1772100EB82E;
	Tue, 12 Jan 2021 03:00:35 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=osalvador@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 87C69100EB82C
	for <linux-nvdimm@lists.01.org>; Tue, 12 Jan 2021 03:00:32 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 1D567AD18;
	Tue, 12 Jan 2021 11:00:31 +0000 (UTC)
Date: Tue, 12 Jan 2021 12:00:28 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 3/5] mm: Teach pfn_to_online_page() about ZONE_DEVICE
 section collisions
Message-ID: <20210112110028.GB12956@linux>
References: <161044407603.1482714.16630477578392768273.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161044409294.1482714.434561066315039753.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <161044409294.1482714.434561066315039753.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: M2LAMT62X5U3SKUXOJGSN5GTON4LK4FK
X-Message-ID-Hash: M2LAMT62X5U3SKUXOJGSN5GTON4LK4FK
X-MailFrom: osalvador@suse.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/M2LAMT62X5U3SKUXOJGSN5GTON4LK4FK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jan 12, 2021 at 01:34:53AM -0800, Dan Williams wrote:
> While pfn_to_online_page() is able to determine pfn_valid() at
> subsection granularity it is not able to reliably determine if a given
> pfn is also online if the section is mixes ZONE_{NORMAL,MOVABLE} with
> ZONE_DEVICE. This means that pfn_to_online_page() may return invalid
> @page objects. For example with a memory map like:
> 
> 100000000-1fbffffff : System RAM
>   142000000-143002e16 : Kernel code
>   143200000-143713fff : Kernel rodata
>   143800000-143b15b7f : Kernel data
>   144227000-144ffffff : Kernel bss
> 1fc000000-2fbffffff : Persistent Memory (legacy)
>   1fc000000-2fbffffff : namespace0.0
> 
> This command:
> 
> echo 0x1fc000000 > /sys/devices/system/memory/soft_offline_page
> 
> ...succeeds when it should fail. When it succeeds it touches
> an uninitialized page and may crash or cause other damage (see
> dissolve_free_huge_page()).

[...]
 
> Because the collision case is rare, and for simplicity, the
> SECTION_TAINT_ZONE_DEVICE flag is never cleared once set.
> 
> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Reported-by: Michal Hocko <mhocko@suse.com>
> Reported-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

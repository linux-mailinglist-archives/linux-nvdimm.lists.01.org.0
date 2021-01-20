Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 157622FCDD6
	for <lists+linux-nvdimm@lfdr.de>; Wed, 20 Jan 2021 11:30:14 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 722F7100EB835;
	Wed, 20 Jan 2021 02:30:12 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=mhocko@suse.com; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1DED6100EB82F
	for <linux-nvdimm@lists.01.org>; Wed, 20 Jan 2021 02:30:09 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1611138608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TEgO1GiA+c7h1rID5iKJ8FX+fU7rvgRZ7C7qLuJdxAY=;
	b=QHseIHGBZwT1U8a1+qwSPIYif1TxRiJNTDz4zgFPq4rwwayfaNyrfwPpFDe16HQdRc9+jW
	MpH3YLBsd7TVu3DpRayjJDsxjweSGfbv78TwjpYzzj8hwuMzB7MXTBMJlteMHCunWLFfab
	iX5YSThVs8TyNElXQMBoRNSbEQxcRxw=
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 522FCAC97;
	Wed, 20 Jan 2021 10:30:08 +0000 (UTC)
Date: Wed, 20 Jan 2021 11:30:07 +0100
From: Michal Hocko <mhocko@suse.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 3/5] mm: Teach pfn_to_online_page() about ZONE_DEVICE
 section collisions
Message-ID: <20210120103007.GH9371@dhcp22.suse.cz>
References: <161058499000.1840162.702316708443239771.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161058500675.1840162.7887862152161279354.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <161058500675.1840162.7887862152161279354.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID-Hash: P754NNCLHCOTNGZZZFI24S2LWZBK5BM5
X-Message-ID-Hash: P754NNCLHCOTNGZZZFI24S2LWZBK5BM5
X-MailFrom: mhocko@suse.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: akpm@linux-foundation.org, David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/P754NNCLHCOTNGZZZFI24S2LWZBK5BM5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed 13-01-21 16:43:26, Dan Williams wrote:
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
> 
> While the memory map above is contrived via the memmap=ss!nn kernel
> command line option, the collision happens in practice on shipping
> platforms. The memory controller resources that decode spans of
> physical address space are a limited resource. One technique
> platform-firmware uses to conserve those resources is to share a decoder
> across 2 devices to keep the address range contiguous. Unfortunately the
> unit of operation of a decoder is 64MiB while the Linux section size is
> 128MiB. This results in situations where, without subsection hotplug
> memory mappings with different lifetimes collide into one object that
> can only express one lifetime.

Thank you this is a very useful insight to have in the changelog.

> Update move_pfn_range_to_zone() to flag (SECTION_TAINT_ZONE_DEVICE) a
> section that mixes ZONE_DEVICE pfns with other online pfns. With
> SECTION_TAINT_ZONE_DEVICE to delineate, pfn_to_online_page() can fall
> back to a slow-path check for ZONE_DEVICE pfns in an online section. In
> the fast path online_section() for a full ZONE_DEVICE section returns
> false.
> 
> Because the collision case is rare, and for simplicity, the
> SECTION_TAINT_ZONE_DEVICE flag is never cleared once set.
> 
> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Reported-by: Michal Hocko <mhocko@suse.com>
> Reported-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Michal Hocko <mhocko@suse.com>

I do not want to bikeshed but online_device_section is quite confusing.
device_mixed_section would sound like a better name to me.
-- 
Michal Hocko
SUSE Labs
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

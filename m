Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5112411026
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 May 2019 01:25:25 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 60F0E212377F7;
	Wed,  1 May 2019 16:25:23 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::844; helo=mail-qt1-x844.google.com;
 envelope-from=pasha.tatashin@soleen.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 0A80621B02822
 for <linux-nvdimm@lists.01.org>; Wed,  1 May 2019 16:25:20 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id p20so470186qtc.9
 for <linux-nvdimm@lists.01.org>; Wed, 01 May 2019 16:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=AH9bebtrf3dfxBIvf5hyUAJKcC8A07SNFaz6GXtYOok=;
 b=BXpRmV+6OvhC688uYI7duSFxoIJaSy5qGca6z3Jg/huzWFwaDds/rsuOmCgs+X/2D6
 nBypKSCBxfF4R11Now1TSKhdmOMcrt3KkOdbhBH0StpDAk0pUqh67sdtSS9SmVYGhDUk
 /99rNYVp/l9SQQD1woxx4wplZpwQh7L398wBwiSgokkpiSyf3soHy/rfnupj45f8qETL
 3Zbbo4Qv4rbnpxEJ3d7hMOa96+c1exFDA5YIp3AA2vuT6pZa8bi7DOkFM2mh3N66ok6F
 IOCT3T8WXbGp8+s6DBvFxEJp6jdS5SHiiuzhxHnHHGQ0ViVh7R+puVcqX8lGPsNsV6j6
 gf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=AH9bebtrf3dfxBIvf5hyUAJKcC8A07SNFaz6GXtYOok=;
 b=fvcOo/mZZw99kTMHXw3gHqpg145E3cXqj5hpjmlXtDbR+F+WfuLLHUyhhZ15m8/jVY
 DENB8JgeBNowHXk+U2VUxFqY6UL3AJAeoM1ryhG9P3q0lvCc/f8gLvYY+8iFXimvu8pA
 YzO6I1ZvW00YKfpNA9YJqJ1WuX9U8CQ2UGvPl8dkRg1zIV3hhBkcjG7/4zhScpeob8cY
 95hIUlAWjPWpHHt5wFmL3Dt0RupV34/iSzD3oqmAYcCZBXQzG1jcVVtnVdLZzZvQf5AP
 JenoLasO6+vle/mriTKXVb84xlVEpJvstAlj6mtFOOb3rMvnyTFchWaw9vqyVt9aTqZW
 hdkQ==
X-Gm-Message-State: APjAAAVnRGoiEbTaCFA6JeE/toL2IYBgr7uMkdQpIrQvi1eRLXIX9mdG
 BHGJMjqVxcH+CweaZK1lGSkzKg==
X-Google-Smtp-Source: APXvYqz0BDqKG+Q2jzUmKI5xzLPAvNPYQjFLDLv988MLkpQr6Ryuk0h2Lnb2Pj89t7Bct/URoLhIMw==
X-Received: by 2002:ac8:27aa:: with SMTP id w39mr658332qtw.227.1556753119438; 
 Wed, 01 May 2019 16:25:19 -0700 (PDT)
Received: from soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net
 ([40.117.208.181])
 by smtp.gmail.com with ESMTPSA id 62sm13373216qtf.89.2019.05.01.16.25.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 01 May 2019 16:25:18 -0700 (PDT)
Date: Wed, 1 May 2019 23:25:17 +0000
From: Pavel Tatashin <pasha.tatashin@soleen.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v6 01/12] mm/sparsemem: Introduce struct mem_section_usage
Message-ID: <20190501232517.crbmgcuk7u4gvujr@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155552634075.2015392.3371070426600230054.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <155552634075.2015392.3371070426600230054.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: NeoMutt/20180716
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
Cc: Michal Hocko <mhocko@suse.com>, linux-nvdimm@lists.01.org, david@redhat.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
 Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 19-04-17 11:39:00, Dan Williams wrote:
> Towards enabling memory hotplug to track partial population of a
> section, introduce 'struct mem_section_usage'.
> 
> A pointer to a 'struct mem_section_usage' instance replaces the existing
> pointer to a 'pageblock_flags' bitmap. Effectively it adds one more
> 'unsigned long' beyond the 'pageblock_flags' (usemap) allocation to
> house a new 'map_active' bitmap.  The new bitmap enables the memory
> hot{plug,remove} implementation to act on incremental sub-divisions of a
> section.
> 
> The primary motivation for this functionality is to support platforms
> that mix "System RAM" and "Persistent Memory" within a single section,
> or multiple PMEM ranges with different mapping lifetimes within a single
> section. The section restriction for hotplug has caused an ongoing saga
> of hacks and bugs for devm_memremap_pages() users.
> 
> Beyond the fixups to teach existing paths how to retrieve the 'usemap'
> from a section, and updates to usemap allocation path, there are no
> expected behavior changes.
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/linux/mmzone.h |   23 ++++++++++++--
>  mm/memory_hotplug.c    |   18 ++++++-----
>  mm/page_alloc.c        |    2 +
>  mm/sparse.c            |   81 ++++++++++++++++++++++++------------------------
>  4 files changed, 71 insertions(+), 53 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 70394cabaf4e..f0bbd85dc19a 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1160,6 +1160,19 @@ static inline unsigned long section_nr_to_pfn(unsigned long sec)
>  #define SECTION_ALIGN_UP(pfn)	(((pfn) + PAGES_PER_SECTION - 1) & PAGE_SECTION_MASK)
>  #define SECTION_ALIGN_DOWN(pfn)	((pfn) & PAGE_SECTION_MASK)
>  
> +#define SECTION_ACTIVE_SIZE ((1UL << SECTION_SIZE_BITS) / BITS_PER_LONG)
> +#define SECTION_ACTIVE_MASK (~(SECTION_ACTIVE_SIZE - 1))
> +
> +struct mem_section_usage {
> +	/*
> +	 * SECTION_ACTIVE_SIZE portions of the section that are populated in
> +	 * the memmap
> +	 */
> +	unsigned long map_active;

I think this should be proportional to section_size / subsection_size.
For example, on intel section size = 128M, and subsection is 2M, so
64bits work nicely. But, on arm64 section size if 1G, so subsection is
16M.

On the other hand 16M is already much better than what we have: with 1G
section size and 2M pmem alignment we guaranteed to loose 1022M. And
with 16M subsection it is only 14M.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

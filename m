Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7513B100BB2
	for <lists+linux-nvdimm@lfdr.de>; Mon, 18 Nov 2019 19:45:35 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DA123100DC2A4;
	Mon, 18 Nov 2019 10:46:28 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A5E39100DC3FD
	for <linux-nvdimm@lists.01.org>; Mon, 18 Nov 2019 10:46:26 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id m15so15442939otq.7
        for <linux-nvdimm@lists.01.org>; Mon, 18 Nov 2019 10:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ojwNV7qRLqZeN1a5CxXJeGJOgRABSewsVVNOXcM0vKc=;
        b=IMAA9N+YudO3YAIdgOGoya/FONOIdEabjT+1yINPKxJqlTkaRSEtwyybwPL7CeykZf
         SipgE/qBPZ553Q10eYkgfQBQExBr6KcY5eOswAqLT26FcLUbrI6G/dPj1ogC/uhqsLxn
         Q1Xq9alggNKMLnXEou3J39PdiJGASGQ3QPQ5yIw6pShio70mjbFq2/IbqdDWyUvVUG7J
         neNspFdNch1m3wZrS//eTGj2J2LprzfOmXAOgVkd5JHfyI70GsldRcDK9kNMgHprBRvT
         GZUC1oCVESbWPwJD0B4+Q4ZGd+EXr4fPZfe8QzXuP4m5cU94Qdm2rmrWXMHYfKCBi9oE
         Kc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ojwNV7qRLqZeN1a5CxXJeGJOgRABSewsVVNOXcM0vKc=;
        b=evteUBQybYKnqg1y3NMYBlvjjod8ZrHJCMMA3bgIUStO1GN/jGibQAjTAn85TAOhwf
         M80n+TebVSJr60HDwpqsfMotMVkfGBbUXhyoc9x60uREDdfaa/6cM6bl73H9D8b9pQ4q
         mncpzCqdelr/aCmXIY4z62DOQuGdlwwtFcUqjox8uoZpmKwDyUM7mN+Nr+goQehGJztq
         vnEebrnu4AxaJ7BWUzvi3WDfnvBFrCQBQILLhIyQoI7Mu9MQXmN5P6A2eeUSjylfnedq
         r6x1fqlGgnVk12gw+095xvDhziHniCN53gnAWL6oMeS2qGH0OcLGDOh5st4IYPDNRXDk
         RMRg==
X-Gm-Message-State: APjAAAU7otQPTKn0TB9a4tdnYMadeG/t3ET0Rr6SKvIvbtO6gPIO4mmM
	dUaRUjWq+3OwoZs6HgPSHLl+bBr+XnbnWtfb0le3f+mMNMA=
X-Google-Smtp-Source: APXvYqy+/lHyvxwtb1J4RO8yzQj0Uzm8eoZw1lPppdBpE3VKjpr0g0rD+bnc+NAtQu64j02ImaNDD6VJc6GhU8m0Ob8=
X-Received: by 2002:a9d:2d89:: with SMTP id g9mr552124otb.126.1574102728187;
 Mon, 18 Nov 2019 10:45:28 -0800 (PST)
MIME-Version: 1.0
References: <157401267421.43284.2135775608523385279.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157401276776.43284.12396353118982684546.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157401276776.43284.12396353118982684546.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 18 Nov 2019 10:45:17 -0800
Message-ID: <CAPcyv4g91QYmmkQKVQ+hrROHnd7vDhTMgfSZ_Z0d-9kF_ZaNMg@mail.gmail.com>
Subject: Re: [PATCH v2 17/18] x86/numa: Provide a range-to-target_node lookup facility
To: linux-nvdimm <linux-nvdimm@lists.01.org>
Message-ID-Hash: KRO2VJI2EMNRA3F4G672ZSUDLBRCMDAM
X-Message-ID-Hash: KRO2VJI2EMNRA3F4G672ZSUDLBRCMDAM
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, kbuild test robot <lkp@intel.com>, Christoph Hellwig <hch@lst.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux ACPI <linux-acpi@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KRO2VJI2EMNRA3F4G672ZSUDLBRCMDAM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Nov 17, 2019 at 10:00 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> The DEV_DAX_KMEM facility is a generic mechanism to allow device-dax
> instances, fronting performance-differentiated-memory like pmem, to be
> added to the System RAM pool. The numa node for that hot-added memory is
> derived from the device-dax instance's 'target_node' attribute.
>
> Recall that the 'target_node' is the ACPI-PXM-to-node translation for
> memory when it comes online whereas the 'numa_node' attribute of the
> device represents the closest online cpu node.
>
> Presently useful target_node information from the ACPI SRAT is discarded
> with the expectation that "Reserved" memory will never be onlined. Now,
> DEV_DAX_KMEM violates that assumption, there is a need to retain the
> translation. Move, rather than discard, numa_memblk data to a secondary
> array that memory_add_physaddr_to_target_node() may consider at a later
> point in time.
>
> Note that memory_add_physaddr_to_nid() is currently only available on
> CONFIG_MEMORY_HOTPLUG=y platforms whereas the target node information
> may be useful on CONFIG_MEMORY_HOTPLUG=n builds, hence why it is calling
> phys_to_target_node() and optionally defined by asm/io.h rather than a
> memory_add_physaddr_to_target_nid() helper that lives in
> include/linux/memory_hotplug.h.
>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: <x86@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  arch/x86/mm/numa.c   |   76 +++++++++++++++++++++++++++++++++++++++++++++++---
>  include/linux/numa.h |    8 +++++
>  mm/mempolicy.c       |    5 +++
>  3 files changed, 83 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 4123100e0eaf..f4f02ac0c465 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -31,6 +31,24 @@ __initdata
>  #endif
>  ;
>
> +/*
> + * Presently, DEV_DAX_KMEM is the only kernel facility that might
> + * convert Reserved or Soft Reserved memory to System RAM.
> + */
> +#if IS_ENABLED(CONFIG_DEV_DAX_KMEM)
> +static struct numa_meminfo __numa_reserved_meminfo;
> +
> +static struct numa_meminfo *numa_reserved_meminfo(void)
> +{
> +       return &__numa_reserved_meminfo;
> +}
> +#else
> +static struct numa_meminfo *numa_reserved_meminfo(void)
> +{
> +       return NULL;
> +}
> +#endif
> +
>  static int numa_distance_cnt;
>  static u8 *numa_distance;
>
> @@ -168,6 +186,26 @@ void __init numa_remove_memblk_from(int idx, struct numa_meminfo *mi)
>                 (mi->nr_blks - idx) * sizeof(mi->blk[0]));
>  }
>
> +/**
> + * numa_move_memblk - Move one numa_memblk from one numa_meminfo to another
> + * @dst: numa_meminfo to move block to
> + * @idx: Index of memblk to remove
> + * @src: numa_meminfo to remove memblk from
> + *
> + * If @dst is non-NULL add it at the @dst->nr_blks index and increment
> + * @dst->nr_blks, then remove it from @src.
> + */
> +static void __init numa_move_memblk(struct numa_meminfo *dst, int idx,
> +               struct numa_meminfo *src)
> +{
> +       if (dst) {
> +               memcpy(&dst->blk[dst->nr_blks], &src->blk[idx],
> +                               sizeof(struct numa_memblk));
> +               dst->nr_blks++;
> +       }
> +       numa_remove_memblk_from(idx, src);
> +}
> +
>  /**
>   * numa_add_memblk - Add one numa_memblk to numa_meminfo
>   * @nid: NUMA node ID of the new memblk
> @@ -245,7 +283,7 @@ int __init numa_cleanup_meminfo(struct numa_meminfo *mi)
>                 if (bi->start >= bi->end ||
>                     !memblock_overlaps_region(&memblock.memory,
>                         bi->start, bi->end - bi->start))
> -                       numa_remove_memblk_from(i--, mi);
> +                       numa_move_memblk(numa_reserved_meminfo(), i--, mi);
>         }
>
>         /* merge neighboring / overlapping entries */
> @@ -881,16 +919,44 @@ EXPORT_SYMBOL(cpumask_of_node);
>
>  #endif /* !CONFIG_DEBUG_PER_CPU_MAPS */
>
> +static int meminfo_to_nid(struct numa_meminfo *mi, u64 start, int *nid)
> +{
> +       int i;
> +
> +       for (i = 0; mi && i < mi->nr_blks; i++)
> +               if (mi->blk[i].start <= start && mi->blk[i].end > start) {
> +                       *nid = mi->blk[i].nid;
> +                       break;
> +               }
> +       return i;
> +}
> +
> +int phys_to_target_node(phys_addr_t start)
> +{
> +       struct numa_meminfo *mi = &numa_meminfo;
> +       int nid = mi->blk[0].nid;
> +       int i = meminfo_to_nid(mi, start, &nid);
> +
> +       /*
> +        * Prefer online nodes, but if reserved memory might be
> +        * hot-added continue the search with reserved ranges.
> +        */
> +       if (i < mi->nr_blks)
> +               return nid;
> +
> +       mi = numa_reserved_meminfo();
> +       meminfo_to_nid(mi, start, &nid);
> +       return nid;
> +}

The kbuild-robot points out that this function causes a section
mismatch warning in the CONFIG_MEMORY_HOTPLUG=n case. It touches
numa_meminfo which gets marked __init in that configuration. Given the
numa information is useful independent of memory hotplug I am going to
add a patch to add a CONFIG_KEEP_NUMA configuration symbol that is
selected by CONFIG_MEMORY_HOTPLUG, or any driver that wants to use
phys_to_target_node(). Then use CONFIG_KEEP_NUMA to gate whether
numa_meminfo is marked __init, or not.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

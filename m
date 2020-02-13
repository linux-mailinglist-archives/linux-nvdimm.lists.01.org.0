Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3353015BBC5
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Feb 2020 10:37:06 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7729410FC33E2;
	Thu, 13 Feb 2020 01:40:21 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::343; helo=mail-wm1-x343.google.com; envelope-from=mingo.kernel.org@gmail.com; receiver=<UNKNOWN> 
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4C4BE10FC33E0
	for <linux-nvdimm@lists.01.org>; Thu, 13 Feb 2020 01:40:18 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a9so5787471wmj.3
        for <linux-nvdimm@lists.01.org>; Thu, 13 Feb 2020 01:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ddOOU7ADcvoppp6eAulmSphKMiop/CEQ61m/8NvcqDQ=;
        b=NDdGL9fs7cw3ugwN8ScXvJ7UBvAn3vIVsNOgwgQ6ZGQZCsu78t1TVqWKx8whA4ZN2z
         ++otcIVJj9A6pjMNGGsHNDbXlwIhabm/CoWR+DYf682VTfrJD9lUCT37OcZj0TIJPJ9p
         QrFNqU6AB4PHIIkL8SHU8xKbDb6PdXd/uw04of9FF+q/fTwrkMjEBtAK9xR4Z17vcG50
         RvaDlWe2GcNa4R3qM7yVjiF8Y9TKt0gwXJdRBT3QU9KbGxWEEjR3x/iLFWC42TLI2GFc
         onmmlGymk8ih6mdB0j4CZfgn17rDB4eg573xHcbqs/pq5M5Dkp+pDWBoxJD8rBzRQYZ4
         SCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ddOOU7ADcvoppp6eAulmSphKMiop/CEQ61m/8NvcqDQ=;
        b=TPs0bKzSHgEsZEkOwE4+dFD7LyFejher56GvEXMk2EdCK5BPbLytkC6WsjxMCo8hbT
         Y+gU+/g/O0UrhExyvYyFyPexflGBPedw8dlh9Oz/M1mopYa/MbG9m0OhK2UshRHdCGA5
         Ox6+eTzU2UZ5oy6GptxoxBztTd5Vv2t8Timr/DHPGD6kZjHz/6Q80HRyZMw2ylfP2/IB
         h4VIdS632yWcbY5S0j06ru+7V63HlqBOs2D8K4rxh/GGqjCG3OKSd4U0+aoIJDbI94XI
         5hNExE+rsV+zKhFBG1iFXrop/tVnZRpn8I7YRRv/ClbDTTTRN103DeWT1b7ddrt8HGUk
         MPcg==
X-Gm-Message-State: APjAAAVtmnky1OF0zluLxkTdlxxb6Zpz+k1E8dNv05qbVUsZJHuxUFW0
	alCs43FkazQLDNgRLHvICrE=
X-Google-Smtp-Source: APXvYqyHpONbd0AeqhQgm0Eh89qHgNmDNdfLCOP3KT6yQpoin8+qpBUxwcEIsqVhVCAOzNndm3EcSA==
X-Received: by 2002:a05:600c:34b:: with SMTP id u11mr4735092wmd.69.1581586619722;
        Thu, 13 Feb 2020 01:36:59 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id q14sm2117512wrj.81.2020.02.13.01.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 01:36:59 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 13 Feb 2020 10:36:56 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 5/6] x86/numa: Provide a range-to-target_node lookup
 facility
Message-ID: <20200213093656.GB90266@gmail.com>
References: <157966227494.2508551.7206194169374588977.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157966230092.2508551.3905721944859436879.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <157966230092.2508551.3905721944859436879.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: SV2DZD4DSZ7MWOQKJNDCFORUTJ7UHIMX
X-Message-ID-Hash: SV2DZD4DSZ7MWOQKJNDCFORUTJ7UHIMX
X-MailFrom: mingo.kernel.org@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: tglx@linutronix.de, mingo@redhat.com, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, kbuild test robot <lkp@intel.com>, hch@lst.de, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SV2DZD4DSZ7MWOQKJNDCFORUTJ7UHIMX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


* Dan Williams <dan.j.williams@intel.com> wrote:

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
>  arch/x86/mm/numa.c   |   68 +++++++++++++++++++++++++++++++++++++++++++-------
>  include/linux/numa.h |    8 +++++-
>  mm/mempolicy.c       |    5 ++++
>  3 files changed, 70 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 5289d9d6799a..f2c8fca36f28 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -26,6 +26,7 @@ struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
>  EXPORT_SYMBOL(node_data);
>  
>  static struct numa_meminfo numa_meminfo __initdata_numa;
> +static struct numa_meminfo numa_reserved_meminfo __initdata_numa;
>  
>  static int numa_distance_cnt;
>  static u8 *numa_distance;
> @@ -164,6 +165,26 @@ void __init numa_remove_memblk_from(int idx, struct numa_meminfo *mi)
>  		(mi->nr_blks - idx) * sizeof(mi->blk[0]));
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
> +		struct numa_meminfo *src)

Nit, this is obviously not how we format function definitions if 
checkpatch complains about the col80 limit.


> +{
> +	if (dst) {
> +		memcpy(&dst->blk[dst->nr_blks], &src->blk[idx],
> +				sizeof(struct numa_memblk));

This linebreak is actually unnecessary ...

Thanks,

	Ingo
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

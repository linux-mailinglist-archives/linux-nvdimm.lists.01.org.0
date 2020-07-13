Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EFF21DAB9
	for <lists+linux-nvdimm@lfdr.de>; Mon, 13 Jul 2020 17:48:45 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B01F6117FA5AF;
	Mon, 13 Jul 2020 08:48:43 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 47406117FA5AD
	for <linux-nvdimm@lists.01.org>; Mon, 13 Jul 2020 08:48:39 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id a8so14119054edy.1
        for <linux-nvdimm@lists.01.org>; Mon, 13 Jul 2020 08:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W36OcjXryM8jgoewQfeJp3IZBi2EgGKHyNoHZfcaUKg=;
        b=NB7aPTPiP9qMPZ0y5PyZjEZciyC3DGD/+k/bgqBjuSVN7xIiMDgNbsaF6/pgADNch+
         Ppp6lmsRYZBZaFrRPXfH/OKEHROSUnQaiibSBid42105KDuiFDu1QwTgOqxAL6c2lRjW
         MB7BlEtHL+kZqmH7hAMfNq/xbtRyDjIYnMpKNKQ38wZaBZBH3mGvzkSQ9nxlcL+jduGt
         GFhsoxForK/GfjOiwcjP4X5Npt3KHapXh9bsKOxwM98za+n3VD8+3bVQ2bTLNFDGInhy
         BOsBa2M/13YjYvQeW8U+bOZfC3IeaBPpjGLKUN+S0b/5sR0Bwju5V17YorGeaFaOIYCu
         VGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W36OcjXryM8jgoewQfeJp3IZBi2EgGKHyNoHZfcaUKg=;
        b=OSlobem7ZzsX7awbWpCzfJ1v2LWcKoJKm3gL1ZCh+V/Eong4lspva4ccluTtYk551w
         QEZe/8cPW74EXYNAKTxHfsOXgYSkGHgD6cEFWrpzLM5ta5dmtPgeKm1+73pT9g6fpKYE
         52AOACkcvlP8sM5JLaAZ9wU4BdNhM8tvn2TpuLOu7AQwRKPdbxaSEJi+5K5beAX8ugNC
         dyfY8BQRMB22ooU3Aqp/z1qthPYVP1JoYkexqbgtBh8nT1wbVfJ36weKoTs+1vd+zOFz
         W7XzrXYwSstx4OGsbXfi9GW6hHCu7Cs1LhC4EHaVtIS0UTSUIEhdAutaFA4LWOsxmELI
         ClVA==
X-Gm-Message-State: AOAM532ltrc5/F7iqLPRFFc51A8cf4bo+M+gMsDEe1+xB1xvQ0w9F6Fx
	4ARig2gCS4DTSJjQeqxBGqasA/4uCv0ZYdU/+Hl0vA==
X-Google-Smtp-Source: ABdhPJy9eW9eIp+1KepqCPSTRPe76Dr5VVVESCrZMoaRV0JKP6GTk/JYXKXYNywspxI5vIOjjZtqBIKR4ru2y3M6GsE=
X-Received: by 2002:aa7:d043:: with SMTP id n3mr73787edo.102.1594655318157;
 Mon, 13 Jul 2020 08:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159457120893.754248.7783260004248722175.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200713070304.GC11000@linux.ibm.com>
In-Reply-To: <20200713070304.GC11000@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 13 Jul 2020 08:48:27 -0700
Message-ID: <CAPcyv4iRJRz==VRgq=M_FYz0TfNKqKASOD1+NRfMLcHzEOBApQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/22] memblock: Introduce a generic phys_addr_to_target_node()
To: Mike Rapoport <rppt@linux.ibm.com>
Message-ID-Hash: U5MAETUGTEGFACJWSZYTE53COCP3GQGK
X-Message-ID-Hash: U5MAETUGTEGFACJWSZYTE53COCP3GQGK
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Jia He <justin.he@arm.com>, Will Deacon <will@kernel.org>, David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Linux MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/U5MAETUGTEGFACJWSZYTE53COCP3GQGK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jul 13, 2020 at 12:04 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> Hi Dan,
>
> On Sun, Jul 12, 2020 at 09:26:48AM -0700, Dan Williams wrote:
> > Similar to how generic memory_add_physaddr_to_nid() interrogates
> > memblock data for numa information, introduce
> > get_reserved_pfn_range_from_nid() to enable the same operation for
> > reserved memory ranges. Example memory ranges that are reserved, but
> > still have associated numa-info are persistent memory or Soft Reserved
> > (EFI_MEMORY_SP) memory.
>
> Here again, I would prefer to add a weak default for
> phys_to_target_node() because the "generic" implementation is not really
> generic.
>
> The fallback to reserved ranges is x86 specfic because on x86 most of the
> reserved areas is not in memblock.memory. AFAIK, no other architecture
> does this.

True, I was pre-fetching ARM using the new EFI "Special Purpose"
memory attribute. However, until that becomes something that platforms
deploy in practice I'm ok with not solving that problem for now.

> And x86 anyway has implementation of phys_to_target_node().

Sure, let's go with the default stub for non-x86.

Justin, do you think it would make sense to fold your dax_kmem
enabling for arm64 series into my enabling of dax_hmem for all
memory-hotplug archs?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

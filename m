Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE672E7FBB
	for <lists+linux-nvdimm@lfdr.de>; Tue, 29 Oct 2019 06:30:17 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7FDA8100EA52B;
	Mon, 28 Oct 2019 22:31:01 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B91E3100EA529
	for <linux-nvdimm@lists.01.org>; Mon, 28 Oct 2019 22:30:59 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 89so8700732oth.13
        for <linux-nvdimm@lists.01.org>; Mon, 28 Oct 2019 22:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GG2mcENYWoyxz0HNqi7Mitc9AmGpMgCrZSMeTfYnJmI=;
        b=EiH/Xcim9gHQq6PZe6LwWSymVTM+KWidfBecd0ug/41NEvs9izWgB9AVlvFKAudq4d
         106KVG/DHM0LafAJ/kHgnSUcU++L8VRa+Pl1WQNGt+jigS2UD5VpN5dJ89hE6EjpCr4h
         ex3UA6vtYDxCPlXMS5DREDB9tb/2BVpSWOP5rIQU0KUmz59/5jqbmpJ/9HonbXmcXBep
         450QC0rhm3GQ7K+59t1iIrWtTAnt2svjrD5qobiLr+PXqmEyFRerwVOjGiEWA1SNd36Q
         5yrmsYpyy7UtjrkCrHKxu6kS/rmjKp6DJU3iu2eb0tN/q+PqMo4FSiz+JxAI7JEVkHV4
         LATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GG2mcENYWoyxz0HNqi7Mitc9AmGpMgCrZSMeTfYnJmI=;
        b=UlajAIFUCfFCfCxTp1IrN2ngCqXxXzljaQBeE2Xr36DhNu+kRuqjXbg1ZPyLy5jxNl
         umZ/yjyFgZzi5crBK5HU5e5/ggpFREVCGc+Z5Z0hWnfSPNS4Sp0ZMUfE/1DBZQRcZ2b/
         q6GMROsM68Z+5xuDNdwMpth5tFT0nQZl4ympmLWe1pIFcqe9vUNa3ByQBca7R1xNjyVg
         r8piGIbQkP/36hlUvVQtzgWRP/3U8BESY8dvxTCw0/aRfr07MXOSs8M6nyt8zaIfDFQJ
         biFmpEKK5Ncet1xNxbhiCYrC3vbYlHlTxqKISr67ZJBjH39LZ6B0Ir/tvBKPhI+ul200
         8VQw==
X-Gm-Message-State: APjAAAUiNWL+XMCJzqYvqHlzBd40xPLOvNy3RcaqQejblRh6JqQoLvp9
	NaKsc+BKpV4m3PVj4N8N+EDlTdN8vkO1nvXj+UAVgQ==
X-Google-Smtp-Source: APXvYqw195Mv9lFqxjCruWKF+YPhN/OmmyHjafORJua6VrEG9aYz4zJdSJPSKMTJF20Ez7P/nC2GadPG/MOFax3QCic=
X-Received: by 2002:a05:6830:18d1:: with SMTP id v17mr2544942ote.71.1572327012510;
 Mon, 28 Oct 2019 22:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <20191028094825.21448-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4gZ=wKzwscu_nch8VUtNTHusKzjmMhYZWo+Se=BPO9q8g@mail.gmail.com> <6f85f4af-788d-aaef-db64-ab8d3faf6b1b@linux.ibm.com>
In-Reply-To: <6f85f4af-788d-aaef-db64-ab8d3faf6b1b@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 28 Oct 2019 22:30:01 -0700
Message-ID: <CAPcyv4gMnSe26QfSBABx0zj3XuFqy=K1XaGnmE3h3sP3Y76nRw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] libnvdimm/namespace: Make namespace size
 validation arch dependent
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: 25XBL6V4XR3HX63LKR3IK7NVEFKMB2IP
X-Message-ID-Hash: 25XBL6V4XR3HX63LKR3IK7NVEFKMB2IP
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Michael Ellerman <mpe@ellerman.id.au>, linux-nvdimm <linux-nvdimm@lists.01.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/25XBL6V4XR3HX63LKR3IK7NVEFKMB2IP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Oct 28, 2019 at 9:35 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 10/29/19 4:38 AM, Dan Williams wrote:
> > On Mon, Oct 28, 2019 at 2:48 AM Aneesh Kumar K.V
> > <aneesh.kumar@linux.ibm.com> wrote:
> >>
> >> The page size used to map the namespace is arch dependent. For example
> >> architectures like ppc64 use 16MB page size for direct-mapping. If the namespace
> >> size is not aligned to the mapping page size, we can observe kernel crash
> >> during namespace init and destroy.
> >>
> >> This is due to kernel doing partial map/unmap of the resource range
> >>
> >> BUG: Unable to handle kernel data access at 0xc001000406000000
> >> Faulting instruction address: 0xc000000000090790
> >> NIP [c000000000090790] arch_add_memory+0xc0/0x130
> >> LR [c000000000090744] arch_add_memory+0x74/0x130
> >> Call Trace:
> >>   arch_add_memory+0x74/0x130 (unreliable)
> >>   memremap_pages+0x74c/0xa30
> >>   devm_memremap_pages+0x3c/0xa0
> >>   pmem_attach_disk+0x188/0x770
> >>   nvdimm_bus_probe+0xd8/0x470
> >>   really_probe+0x148/0x570
> >>   driver_probe_device+0x19c/0x1d0
> >>   device_driver_attach+0xcc/0x100
> >>   bind_store+0x134/0x1c0
> >>   drv_attr_store+0x44/0x60
> >>   sysfs_kf_write+0x74/0xc0
> >>   kernfs_fop_write+0x1b4/0x290
> >>   __vfs_write+0x3c/0x70
> >>   vfs_write+0xd0/0x260
> >>   ksys_write+0xdc/0x130
> >>   system_call+0x5c/0x68
> >>
> >> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> >> ---
> >>   arch/arm64/mm/flush.c     | 11 +++++++++++
> >>   arch/powerpc/lib/pmem.c   | 21 +++++++++++++++++++--
> >>   arch/x86/mm/pageattr.c    | 12 ++++++++++++
> >>   include/linux/libnvdimm.h |  1 +
> >>   4 files changed, 43 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
> >> index ac485163a4a7..90c54c600023 100644
> >> --- a/arch/arm64/mm/flush.c
> >> +++ b/arch/arm64/mm/flush.c
> >> @@ -91,4 +91,15 @@ void arch_invalidate_pmem(void *addr, size_t size)
> >>          __inval_dcache_area(addr, size);
> >>   }
> >>   EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
> >> +
> >> +unsigned long arch_validate_namespace_size(unsigned int ndr_mappings, unsigned long size)
> >> +{
> >> +       u32 remainder;
> >> +
> >> +       div_u64_rem(size, PAGE_SIZE * ndr_mappings, &remainder);
> >> +       if (remainder)
> >> +               return PAGE_SIZE * ndr_mappings;
> >> +       return 0;
> >> +}
> >> +EXPORT_SYMBOL_GPL(arch_validate_namespace_size);
> >>   #endif
> >> diff --git a/arch/powerpc/lib/pmem.c b/arch/powerpc/lib/pmem.c
> >> index 377712e85605..2e661a08dae5 100644
> >> --- a/arch/powerpc/lib/pmem.c
> >> +++ b/arch/powerpc/lib/pmem.c
> >> @@ -17,14 +17,31 @@ void arch_wb_cache_pmem(void *addr, size_t size)
> >>          unsigned long start = (unsigned long) addr;
> >>          flush_dcache_range(start, start + size);
> >>   }
> >> -EXPORT_SYMBOL(arch_wb_cache_pmem);
> >> +EXPORT_SYMBOL_GPL(arch_wb_cache_pmem);
> >>
> >>   void arch_invalidate_pmem(void *addr, size_t size)
> >>   {
> >>          unsigned long start = (unsigned long) addr;
> >>          flush_dcache_range(start, start + size);
> >>   }
> >> -EXPORT_SYMBOL(arch_invalidate_pmem);
> >> +EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
> >> +
> >> +unsigned long arch_validate_namespace_size(unsigned int ndr_mappings, unsigned long size)
> >> +{
> >> +       u32 remainder;
> >> +       unsigned long linear_map_size;
> >> +
> >> +       if (radix_enabled())
> >> +               linear_map_size = PAGE_SIZE;
> >> +       else
> >> +               linear_map_size = (1UL << mmu_psize_defs[mmu_linear_psize].shift);
> >
> > This seems more a "supported_alignments" problem, and less a namespace
> > size or PAGE_SIZE problem, because if the starting address is
> > misaligned this size validation can still succeed when it shouldn't.
> >
>
>
> Isn't supported_alignments an indication of how user want the namespace
> to be mapped to applications?  Ie, with the above restrictions we can
> still do both 64K and 16M mapping of the namespace to userspace.

True, for the pfn device and the device-dax mapping size, but I'm
suggesting adding another instance of alignment control at the raw
namespace level. That would need to be disconnected from the
device-dax page mapping granularity.

>
> Also for supported alignment the huge page mapping is further  dependent
> on the THP feature.
>
> The restrictions here are mostly w.r.t the direct-mapping page size used
> by some architecture.

Right, that's a base requirement for the namespace that can be
independent of the user page mapping size for device-dax.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

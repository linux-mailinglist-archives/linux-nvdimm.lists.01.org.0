Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4161513F1
	for <lists+linux-nvdimm@lfdr.de>; Tue,  4 Feb 2020 02:24:36 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8886710FC3387;
	Mon,  3 Feb 2020 17:27:52 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0C46F10FC3385
	for <linux-nvdimm@lists.01.org>; Mon,  3 Feb 2020 17:27:50 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id a142so16813899oii.7
        for <linux-nvdimm@lists.01.org>; Mon, 03 Feb 2020 17:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zaDofTomGFH7niMxAvlM4SlRadN36KR0v+tIdhJo7+Q=;
        b=IsfOtT9+NHHnq/sKg7+EGZj8H1jckeyOm5iMgQuY93l7vwexXpoM0gI8kVp2DFyCVP
         aBgE/cTY6vrnR2MaC5QILyfCNFv9AIq/986DLz/syRYLB9a5SVa/AeVxohJSnv3e3bvV
         dPx+gMnFD39YXULqYcXGvEV8+eDltTXa3qQgwvBNNzNRz8er2J2JmL/h3JfA8fRHDblz
         6kt72a040EluXNLpv56fFzhkVmpekmFUDV/xB/mk+ay9eZU09EBifqzI493jIszzyxk5
         5iQbeJHlA2IyrtQHWbudM6Vl1M4ChcY2PNFkV+yfOYcGwYHEe8lt+Bd2oHpXUW3GQo8e
         EnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zaDofTomGFH7niMxAvlM4SlRadN36KR0v+tIdhJo7+Q=;
        b=Wwfa8DpOhV/f6wCWVS/cwZP29S3X3hxD8itOKMvU4AIViVT6Kd+pj6OORNRyeBxtk6
         u3JsXmAJUX9WdQOfhFFvusI42k6VeZLPJpb0nN3hL8gQnQ92vnoZFJ9supMpiH0j3m8s
         tpj0jtydzGaMD5YkR5qPVig6/pvX8GH1ZeR+U4FGiKrtDCoIMDCkzy+p39eAKwEiibps
         g5OAkA0naX9GR9DBtnUhMGqeSUXRNsAHJshyST3VuOxJ39GOH2RqPZOM45C+sPLC7jjx
         qVqQoGZUbRlrCQwQLdwCJmGMwLcXurVCiEcys2qw1e+JQ/JwDL54f5waY0kMqAoKUPOb
         asKw==
X-Gm-Message-State: APjAAAVvCP98KTng7ED0bw2oL62K7aAAZFg7MpB3siJtFaeZMTS1pkbW
	mVstaN6srRqWa5IyPNbZx+N6s3ItlDO8zImTuawvgw==
X-Google-Smtp-Source: APXvYqzH9aFwvXGqQNNkgrqsOiweMxROzznWHNNlwVOwzZcx0XlCLCOCWsgCWH6sPG1tYrPlD3IQpJGN4iYEgXuBuS4=
X-Received: by 2002:aca:aa0e:: with SMTP id t14mr1557357oie.149.1580779471936;
 Mon, 03 Feb 2020 17:24:31 -0800 (PST)
MIME-Version: 1.0
References: <20200110190313.17144-1-joao.m.martins@oracle.com>
In-Reply-To: <20200110190313.17144-1-joao.m.martins@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 3 Feb 2020 17:24:20 -0800
Message-ID: <CAPcyv4g__yY-Gj1S7usijmMXYh8QbD5qtnMhyB27E7UtkK_ffQ@mail.gmail.com>
Subject: Re: [PATCH RFC 00/10] device-dax: Support devices without PFN metadata
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: MS76HUASMJA4HVBOFCWQG4DKPFHAXG5U
X-Message-ID-Hash: MS76HUASMJA4HVBOFCWQG4DKPFHAXG5U
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck <cohuck@redhat.com>, KVM list <kvm@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, Liran Alon <liran.alon@oracle.com>, Nikita Leshenko <nikita.leshchenko@oracle.com>, Barret Rhoden <brho@google.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Matthew Wilcox <willy@infradead.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MS76HUASMJA4HVBOFCWQG4DKPFHAXG5U/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jan 10, 2020 at 11:06 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> Hey,

Hi Joao,

>
> Presented herewith a small series which allows device-dax to work without
> struct page to be used to back KVM guests memory. It's an RFC, and there's
> still some items we're looking at (see TODO below);

So it turns out I already have some patches in flight that address
discontiguous allocation item. Here's a WIP branch that I'll be
sending out after the merge window closes.

https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git/log/?h=libnvdimm-pending

> but wondering if folks
> would be OK carving some time out of their busy schedules to provide feedback
> direction-wise on this work.

...apologies I did not get to this sooner. Please feel free to ping me
after a week if you're awaiting comment on anything in the nvdimm or
device-dax area.

> In virtualized environments (specially those with no kernel-backed PV
> interfaces, and just SR-IOV), memory is largelly assigned to guests: either
> persistent with NVDIMMs or volatile for regular RAM. The kernel
> (hypervisor) tracks it with 'struct page' (64b) for each 4K page. Overall
> we're spending 16GB for each 1Tb of host memory tracked that the kernel won't
> need  which could instead be used to create other guests. One of motivations of
> this series is to then get that memory used for 'struct page', when it is meant
> to solely be used by userspace.

Do you mean reclaim it for the guest to use for 'struct page' capacity
since the host hypervisor has reduced need for it?

> This is also useful for the case of memory
> backing guests virtual NVDIMMs. The other neat side effect is that the
> hypervisor has no virtual mapping of the guest and hence code gadgets (if
> found) are limited in their effectiveness.

You mean just the direct-map? qemu still gets a valid virtual address,
or are you proposing it's not mapped there either?

> It is expected that a smaller (instead of total) amount of host memory is
> defined for the kernel (with mem=X or memmap=X!Y). For KVM userspace VMM (e.g.
> QEMU), the main thing that is needed is a device which open + mmap + close with
> a certain alignment (4K, 2M, 1G). That made us look at device-dax which does
> just that and so the work comprised here was improving what's there and the
> interfaces it uses.

In general I think this "'struct page'-less device-dax" capability
makes sense, why suffer 1.6% capacity loss when that memory is going
unused? My main concerns are:

1/ Use of memmap=nn!ss when none of the persistent memory
infrastructure is needed.

2/ Auditing the new usage of VM_PFNMAP and what that means for
memory-error handling and applications that expect 'struct page'
services to be present.

3/ "page-less" dreams have been dashed on the rocks in the past. The
slow drip of missing features (ptrace(), direct-I/O, fork()...) is why
the kernel now requires them by default for dax.

For 1/ I have a proposal, for 2/ I need to dig in to what you have
here, but maybe I can trade you some review on the discontiguous
allocation patches. For 3/ can you say a bit more about why the
overhead is intolerable?

The proposal for 1/ is please let's not build more on top of
memmap=nn!ss. It's fragile because there's no facility to validate
that it is correct, the assumption is that the user overriding the
memmap knows to pick address that don't collide and have real memory
backing. Practice has shown that people get it wrong often enough that
we need something better. It's also confusing that applications start
seeing "Persistent Memory" in /proc/iomem when it's only there to
shunt memory over to device-dax.

The alternative is "efi_fake_mem=nn@ss:0x40000" and the related
'soft-reservation' enabling that bypasses the persistent memory
enabling and assigns memory to device-dax directly. EFI attribute
override is safer because this attribute is only honored when applied
to existing EFI conventional memory.

Have a look at that branch just be warned it's not polished, or just
wait for me to send them out with a proper cover letter, and I'll take
a look at what you have below.

>
> The series is divided as follows:
>
>  * Patch 1 , 3: Preparatory work for patch 7 for adding support for
>                vmf_insert_{pmd,pud} with dax pfn flags PFN_DEV|PFN_SPECIAL
>
>  * Patch 2 , 4: Preparatory work for patch 7 for adding support for
>                follow_pfn() to work with 2M/1G huge pages, which is
>                what KVM uses for VM_PFNMAP.
>
>  * Patch 5 - 7: One bugfix and device-dax support for PFN_DEV|PFN_SPECIAL,
>                which encompasses mainly dealing with the lack of devmap,
>                and creating a VM_PFNMAP vma.
>
>  * Patch 8: PMEM support for no PFN metadata only for device-dax namespaces.
>            At the very end of the cover letter (after scissors mark),
>            there's a patch for ndctl to be able to create namespaces
>            with '--mode devdax --map none'.
>
>  * Patch 9: Let VFIO handle VM_PFNMAP without relying on vm_pgoff being
>             a PFN.
>
>  * Patch 10: The actual end consumer example for RAM case. The patch just adds a
>              label storage area which consequently allows namespaces to be
>              created. We picked PMEM legacy for starters.
>
> Thoughts, coments appreciated.
>         Joao
>
> P.S. As an example to try this out:
>
>  1) add 'memmap=48G!16G' to the kernel command line, on a host with 64G,
>  and kernel has 16G.
>
>  2) create a devdax namespace with 1G hugepages:
>
>  $ ndctl create-namespace --verbose --mode devdax --map none --size 32G --align 1G -r 0
>  {
>   "dev":"namespace0.0",
>   "mode":"devdax",
>   "map":"none",
>   "size":"32.00 GiB (34.36 GB)",
>   "uuid":"dfdd05cd-2611-46ac-8bcd-10b6194f32d4",
>   "daxregion":{
>     "id":0,
>     "size":"32.00 GiB (34.36 GB)",
>     "align":1073741824,
>     "devices":[
>       {
>         "chardev":"dax0.0",
>         "size":"32.00 GiB (34.36 GB)",
>         "target_node":0,
>         "mode":"devdax"
>       }
>     ]
>   },
>   "align":1073741824
>  }
>
>  3) Add this to your qemu params:
>   -m 32G
>   -object memory-backend-file,id=mem,size=32G,mem-path=/dev/dax0.0,share=on,align=1G
>   -numa node,memdev=mem
>
> TODO:
>
>  * Discontiguous regions/namespaces: The work above is limited to max
> contiguous extent, coming from nvdimm dpa allocation heuristics -- which I take
> is because of what specs allow for persistent namespaces. But for volatile RAM
> case we would need handling of discontiguous extents (hence a region would represent
> more than a resource) to be less bound to how guests are placed on the system.
> I played around with multi-resource for device-dax, but I'm wondering about
> UABI: 1) whether nvdimm DPA allocation heuristics should be relaxed for RAM
> case (under certain nvdimm region bits); or if 2) device-dax would have it's
> own separate UABI to be used by daxctl (which would be also useful for hmem
> devices?).
>
>  * MCE handling: For contiguous regions vm_pgoff could be set to the pfn in
> device-dax, which would allow collect_procs() to find the processes solely based
> on the PFN. But for discontiguous namespaces, not sure if this would work; perhaps
> looking at the dax-region pfn range for each DAX vma.

You mean, make the memory error handling device-dax aware?

>
>  * NUMA: For now excluded setting the target_node; while these two patches
>  are being worked on[1][2].
>
>  [1] https://lore.kernel.org/lkml/157401276776.43284.12396353118982684546.stgit@dwillia2-desk3.amr.corp.intel.com/
>  [2] https://lore.kernel.org/lkml/157401277293.43284.3805106435228534675.stgit@dwillia2-desk3.amr.corp.intel.com/

I'll ping x86 folks again after the merge window. I expect they have
just not had time to ack them yet.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

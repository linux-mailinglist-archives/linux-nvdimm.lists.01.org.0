Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3AB24ACC2
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Aug 2020 03:54:30 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8E8331351C48A;
	Wed, 19 Aug 2020 18:54:28 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::644; helo=mail-ej1-x644.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 783B613515B61
	for <linux-nvdimm@lists.01.org>; Wed, 19 Aug 2020 18:54:11 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id bo3so698073ejb.11
        for <linux-nvdimm@lists.01.org>; Wed, 19 Aug 2020 18:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M2856byAPxR8wC0hiTcV4Eu6Vwp5zHAzX+5RXykLdZ8=;
        b=lZ/K4yVK00w07TAWoz4NrJ7bh2SQj0QlEXGy+16Uvv+KVxUgjz3B3Iv7EDFWqB1Pdr
         DuqS0vl9GBWbYe7Tv0iQX9ujEvHAFPuKsnBXPYGFMmNAlAMmAGkWwywfwrjoKzj7KHaq
         9x9L9GAliRR0hzTYRqnJnP0AEzhhN86hMJ/tfa5N1nZQYhNMWXesPPOB/n1sQBmB9iFO
         1gldSVsbODRKjEwdNvNll8hWpTbiqQ6XVTWltCogzN6iGXyVjZR5g3DVI13dx5mRUp7V
         PQNTIep7dDdU8pcLAQzgJrYbrZcCxhZ6TJ0/WHGSPo2V8rXXnajEPWLIdfd2u3CPbZ4m
         C4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M2856byAPxR8wC0hiTcV4Eu6Vwp5zHAzX+5RXykLdZ8=;
        b=CowVhVnhUwfp3AR5WpOFp8ZAJRf4akddc6Fjb+VDmVV5y2ggJjN1yN4Xr5TY4yobte
         L//jx7/42MmfqL43spjP8bqCKWUxbbZe8Wcrk5/alBrW9vozvN4V2fA763QRPbPWQ6Jt
         tZrpxWDiVAT4O+L3eGoGd6LHRZFjtE5+1x/RGQhOIK7jyltjfGLRdq+qbolVlNPZNEZ/
         uFK5oH9XwOsgKCcVxSW79DLxm3+LCrJ4HmrRaKk/2Tr2+7StaFpx56xb4SciSVdEndb3
         50TlAuhgHEgEUt2toM6qhyBJICR2oFwmTdb5e2XC/C0nEPnOVdpRfHBp/wRQSOL5LiQZ
         KOfA==
X-Gm-Message-State: AOAM530ZvSoQ3NKd+2l0dyJSI0dt89u8I8ZKWSR2Jr9T5EwtXQP1ZuNV
	DupFmpYz7eUbg0xIEcK3VQKDYThGbHeorNnjjSTc3A==
X-Google-Smtp-Source: ABdhPJzvu8YTM6DfS52cWqhkmKxDgLU8iC/mKftCXZJ19EZWyjZICrR61eKB8x5hnqIA1r8PziL6kB6a/+obAqDoPt8=
X-Received: by 2002:a17:906:413:: with SMTP id d19mr1123427eja.523.1597888448722;
 Wed, 19 Aug 2020 18:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
 <c59111f9-7c94-8b9e-2b8c-4cb96b9aa848@redhat.com>
In-Reply-To: <c59111f9-7c94-8b9e-2b8c-4cb96b9aa848@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 19 Aug 2020 18:53:57 -0700
Message-ID: <CAPcyv4j8-5nWU5GPDBoFicwR84qM=hWRtd78DkcCg4PW-8i6Vg@mail.gmail.com>
Subject: Re: [PATCH v4 00/23] device-dax: Support sub-dividing soft-reserved ranges
To: David Hildenbrand <david@redhat.com>
Message-ID-Hash: 5OHNEA3HYEB44LJMSPOABSBU2AEU7HKF
X-Message-ID-Hash: 5OHNEA3HYEB44LJMSPOABSBU2AEU7HKF
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Andrew Morton <akpm@linux-foundation.org>, Ard Biesheuvel <ardb@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, David Airlie <airlied@linux.ie>, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Joao Martins <joao.m.martins@oracle.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Tatashin <pasha.tatashin@soleen.com>, Peter Zijlstra <peterz@infradead.org>, Ben Skeggs <bskeggs@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jason Gunthorpe <jgg@mellanox.com>, Jia He <justin.he@arm.com>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Paul Mackerras <paulus@ozlabs.org>, Brice Goglin <Brice.Goglin@inr
 ia.fr>, Michael Ellerman <mpe@ellerman.id.au>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Vetter <daniel@ffwll.ch>, Andy Lutomirski <luto@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5OHNEA3HYEB44LJMSPOABSBU2AEU7HKF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Aug 3, 2020 at 12:48 AM David Hildenbrand <david@redhat.com> wrote:
>
> [...]
>
> > Well, no v5.8-rc8 to line this up for v5.9, so next best is early
> > integration into -mm before other collisions develop.
> >
> > Chatted with Justin offline and it currently appears that the missing
> > numa information is the fault of the platform firmware to populate all
> > the necessary NUMA data in the NFIT.
>
> I'm planning on looking at some bits of this series this week, but some
> questions upfront ...
>
> >
> > ---
> > Cover:
> >
> > The device-dax facility allows an address range to be directly mapped
> > through a chardev, or optionally hotplugged to the core kernel page
> > allocator as System-RAM. It is the mechanism for converting persistent
> > memory (pmem) to be used as another volatile memory pool i.e. the
> > current Memory Tiering hot topic on linux-mm.
> >
> > In the case of pmem the nvdimm-namespace-label mechanism can sub-divide
> > it, but that labeling mechanism is not available / applicable to
> > soft-reserved ("EFI specific purpose") memory [3]. This series provides
> > a sysfs-mechanism for the daxctl utility to enable provisioning of
> > volatile-soft-reserved memory ranges.
> >
> > The motivations for this facility are:
> >
> > 1/ Allow performance differentiated memory ranges to be split between
> >    kernel-managed and directly-accessed use cases.
> >
> > 2/ Allow physical memory to be provisioned along performance relevant
> >    address boundaries. For example, divide a memory-side cache [4] along
> >    cache-color boundaries.
> >
> > 3/ Parcel out soft-reserved memory to VMs using device-dax as a security
> >    / permissions boundary [5]. Specifically I have seen people (ab)using
> >    memmap=nn!ss (mark System-RAM as Persistent Memory) just to get the
> >    device-dax interface on custom address ranges. A follow-on for the VM
> >    use case is to teach device-dax to dynamically allocate 'struct page' at
> >    runtime to reduce the duplication of 'struct page' space in both the
> >    guest and the host kernel for the same physical pages.
>
>
> I think I am missing some important pieces. Bear with me.

No worries, also bear with me, I'm going to be offline intermittently
until at least mid-September. Hopefully Joao and/or Vishal can jump in
on this discussion.

>
> 1. On x86-64, e820 indicates "soft-reserved" memory. This memory is not
> automatically used in the buddy during boot, but remains untouched
> (similar to pmem). But as it involves ACPI as well, it could also be
> used on arm64 (-e820), correct?

Correct, arm64 also gets the EFI support for enumerating memory this
way. However, I would clarify that whether soft-reserved is given to
the buddy allocator by default or not is the kernel's policy choice,
"buddy-by-default" is ok and is what will happen anyways with older
kernels on platforms that enumerate a memory range this way.

> 2. Soft-reserved memory is volatile RAM with differing performance
> characteristics ("performance differentiated memory"). What would be
> examples of such memory?

Likely the most prominent one that drove the creation of the "EFI
Specific Purpose" attribute bit is high-bandwidth memory. One concrete
example of that was a platform called Knights Landing [1] that ended
up shipping firmware that lied to the OS about the latency
characteristics of the memory to try to reverse engineer OS behavior
to not allocate from that memory range by default. With the EFI
attribute firmware performance tables can tell the truth about the
performance characteristics of the memory range *and* indicate that
the OS not use it for general purpose allocations by default.

[1]: https://software.intel.com/content/www/us/en/develop/blogs/an-intro-to-mcdram-high-bandwidth-memory-on-knights-landing.html

> Like, memory that is faster than RAM (scratch
> pad), or slower (pmem)? Or both? :)

Both, but note that PMEM is already hard-reserved by default.
Soft-reserved is about a memory range that, for example, an
administrator may want to reserve 100% for a weather simulation where
if even a small amount of memory was stolen for the page cache the
application may not meet its performance targets. It could also be a
memory range that is so slow that only applications with higher
latency tolerances would be prepared to consume it.

In other words the soft-reserved memory can be used to indicate memory
that is either too precious, or too slow for general purpose OS
allocations.

> Is it a valid use case to use pmem
> in a hypervisor to back this memory?

Depends on the pmem. That performance capability is indicated by the
ACPI HMAT, not the EFI soft-reserved designation.

> 3. There seem to be use cases where "soft-reserved" memory is used via
> DAX. What is an example use case? I assume it's *not* to treat it like
> PMEM but instead e.g., use it as a fast buffer inside applications or
> similar.

Right, in that weather-simulation example that application could just
mmap /dev/daxX.Y and never worry about contending for the "fast
memory" resource on the platform. Alternatively if that resource needs
to be shared and/or over-commited then kernel memory-management
services are needed and that dax-device can be assigned to kmem.

> 4. There seem to be use cases where some part of "soft-reserved" memory
> is used via DAX, some other is given to the buddy. What is an example
> use case? Is this really necessary or only some theoretical use case?

It's as necessary as pmem namespace partitioning, or the inclusion of
dax-kmem upstream in the first place. In that kmem case the motivation
was that some users want a portion of pmem provisioned for storage and
some for volatile usage. The motivation is similar here, platform
firmware can only identify memory attributes on coarse boundaries,
finer grained provisioning decisions are up to the administrator /
platform-owner and the kernel is a just a facilitator of that policy.

>
> 5. The "provisioned along performance relevant address boundaries." part
> is unclear to me. Can you give an example of how this would look like
> from user space? Like, split that memory in blocks of size X with
> alignment Y and give them to separate applications?

One example of platform address boundaries are the memory address
ranges that alias in a direct-mapped memory-side-cache. In the
direct-map-cache aliasing may repeat every N GBs where N is the ratio
of far-to-near memory. ("Near memory" ==  cache "Far memory" ==
backing memory). Also refer back to the background in the page
allocator shuffling patches [2]. With this partitioning mechanism you
could, for one example use case, assign different VMs to exclusive
colors in the memory side cache.

[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e900a918b098

> 6. If you add such memory to the buddy, is there any way the system can
> differentiate it from other memory? E.g., via fake/other NUMA nodes?

Numa node numbers / are how performance differentiated memory ranges
are enumerated. The expectation is that all distinct performance
memory targets have unique ACPI proximity domains and Linux numa node
numbers as a result.

> Also, can you give examples of how kmem-added memory is represented in
> /proc/iomem for a) pmem and b) soft-resered memory after this series
> (skimming over the patches, I think there is a change for pmem, right?)?

I don't expect a change. The only difference is the parent resource
will be marked "Soft Reserved" instead of "Persistent Memory".

> I am really wondering if it's the right approach to squeeze this into
> our pmem/nvdimm infrastructure just because it's easy to do. E.g., man
> "ndctl" - "ndctl - Manage "libnvdimm" subsystem devices (Non-volatile
> Memory)" speaks explicitly about non-volatile memory.

In fact it's not squeezed into PMEM infrastructure. dax-kmem and
device-dax are independent of PMEM. PMEM is one source of potential
device-dax instances, soft-reserved memory is another orthogonal
source. This is why device-dax needs its own userspace policy directed
partitioning mechanism because there is no PMEM to store the
configuration for partitioned higph-bandwidth memory. The userspace
tooling for this mechanism is targeted for a tool called daxctl that
has no PMEM dependencies. Look to Joao's use case that is using this
infrastructure independent of PMEM with manual soft-reservations
specified on the kernel command-line.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

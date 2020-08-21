Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 670C424DF7E
	for <lists+linux-nvdimm@lfdr.de>; Fri, 21 Aug 2020 20:28:40 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EDE9E122146BE;
	Fri, 21 Aug 2020 11:28:36 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.208.68; helo=mail-ed1-f68.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A7798122146BD
	for <linux-nvdimm@lists.01.org>; Fri, 21 Aug 2020 11:28:15 -0700 (PDT)
Received: by mail-ed1-f68.google.com with SMTP id b2so2239857edw.5
        for <linux-nvdimm@lists.01.org>; Fri, 21 Aug 2020 11:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=shQPOS/D8M4JXXfHHqbOPcw2UQKwykbpQIY4dcI2U7Y=;
        b=ikEqxcCd/y/+zxCU3xzhcSEWvCbwaJlbGlOLU2haz4TMsmbxrj69tC+ooBZKr1P46K
         Y/7oKiPoeLuokNW96KPRtAis1XU6MgYlKWUKvQfz8bSKiVBb67RiS0n0+HRUObc5MDsW
         Hr3XRWSkRsygWIu9BTIsi89UxDTlWl8Jx9e2TdeSI6TKHW9SjyD7428aN8ZO1JgSF/V0
         +Brg8zgjea9I5lp6ABFKyqv+3kw+5eJlt3SUzM8JbPrdtocIn8IqPjTZ6pdIonV414Jr
         hemzvtz9IMppAPXxjRI7BvSPqSEEqKaV80yw0+UV60kLQjbkHtoPrvueFGux9mlE+28a
         SxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=shQPOS/D8M4JXXfHHqbOPcw2UQKwykbpQIY4dcI2U7Y=;
        b=Nn7l8Z33dmAOWbPUSNZUHCFJjgxGzhINRwfdxzgqX5VWKbe1IVaztOabzR0elkgPax
         VYK6WsIf9kEtN6kRKhA8IOLCdIRzdaH+ZrRKh9O5lXxi87RSpK9+t3FGauB/hnXk90Pz
         8ZPlPgYty1r+CEEM8kb5ch29ClzaCiD4lLXhmnw/Ru/4lvSFsUjICKzI81UykwQD2fOQ
         tQTGb1R+UQvgnrLuX83WQS7QaNEsRCD+wvlZCuThwfSlntpPOJG6R/kmPjyl/pJo651y
         rptAzqAtjQHD5+zkIgoE76mGtSSxwFg1LU1xl7EIbAomA+fq7V+dnM9dGaiOw9XNVw3F
         smcg==
X-Gm-Message-State: AOAM533Vx4n4KMQT9XHhijmfdQiX/xZ0mAS88CaWGdG3h/F8zF3+VF2O
	sM/C6unfduYW2Sn2nLP63S4GiT1vOcQwqGfCikWWgA==
X-Google-Smtp-Source: ABdhPJybztVE4gXLhNJ22ci71mCL3Z3O9B1wFb6gumUxHdS4tr+MkLUxFoeUsR3zIwYETLG65En3MWLdGKGctB6CK1k=
X-Received: by 2002:a05:6402:30a5:: with SMTP id df5mr4051980edb.18.1598034434104;
 Fri, 21 Aug 2020 11:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
 <c59111f9-7c94-8b9e-2b8c-4cb96b9aa848@redhat.com> <CAPcyv4j8-5nWU5GPDBoFicwR84qM=hWRtd78DkcCg4PW-8i6Vg@mail.gmail.com>
 <6af3de0d-ffdc-8942-3922-ebaeef20dd63@redhat.com>
In-Reply-To: <6af3de0d-ffdc-8942-3922-ebaeef20dd63@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 21 Aug 2020 11:27:02 -0700
Message-ID: <CAPcyv4h=oBnzmP2PHAFX6H2jsNq8zSUzQLYySj0Ke7FAqZwb0A@mail.gmail.com>
Subject: Re: [PATCH v4 00/23] device-dax: Support sub-dividing soft-reserved ranges
To: David Hildenbrand <david@redhat.com>
Message-ID-Hash: NQ6MQYPEKTWOIR2INUPSAUMFLPWRQMFR
X-Message-ID-Hash: NQ6MQYPEKTWOIR2INUPSAUMFLPWRQMFR
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Andrew Morton <akpm@linux-foundation.org>, Ard Biesheuvel <ardb@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, David Airlie <airlied@linux.ie>, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Joao Martins <joao.m.martins@oracle.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Tatashin <pasha.tatashin@soleen.com>, Peter Zijlstra <peterz@infradead.org>, Ben Skeggs <bskeggs@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jason Gunthorpe <jgg@mellanox.com>, Jia He <justin.he@arm.com>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Paul Mackerras <paulus@ozlabs.org>, Brice Goglin <Brice.Goglin@inr
 ia.fr>, Michael Ellerman <mpe@ellerman.id.au>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Vetter <daniel@ffwll.ch>, Andy Lutomirski <luto@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NQ6MQYPEKTWOIR2INUPSAUMFLPWRQMFR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Aug 21, 2020 at 3:15 AM David Hildenbrand <david@redhat.com> wrote:
>
> >>
> >> 1. On x86-64, e820 indicates "soft-reserved" memory. This memory is not
> >> automatically used in the buddy during boot, but remains untouched
> >> (similar to pmem). But as it involves ACPI as well, it could also be
> >> used on arm64 (-e820), correct?
> >
> > Correct, arm64 also gets the EFI support for enumerating memory this
> > way. However, I would clarify that whether soft-reserved is given to
> > the buddy allocator by default or not is the kernel's policy choice,
> > "buddy-by-default" is ok and is what will happen anyways with older
> > kernels on platforms that enumerate a memory range this way.
>
> Is "soft-reserved" then the right terminology for that? It sounds very
> x86-64/e820 specific. Maybe a compressed for of "performance
> differentiated memory" might be a better fit to expose to user space, no?

No. The EFI "Specific Purpose" bit is an attribute independent of
e820, it's x86-Linux that entangles those together. There is no
requirement for platform firmware to use that designation even for
drastic performance differentiation between ranges, and conversely
there is no requirement that memory *with* that designation has any
performance difference compared to the default memory pool. So it
really is a reservation policy about a memory range to keep out of the
buddy allocator by default.

[..]
> > Both, but note that PMEM is already hard-reserved by default.
> > Soft-reserved is about a memory range that, for example, an
> > administrator may want to reserve 100% for a weather simulation where
> > if even a small amount of memory was stolen for the page cache the
> > application may not meet its performance targets. It could also be a
> > memory range that is so slow that only applications with higher
> > latency tolerances would be prepared to consume it.
> >
> > In other words the soft-reserved memory can be used to indicate memory
> > that is either too precious, or too slow for general purpose OS
> > allocations.
>
> Right, so actually performance-differentiated in any way :)

... or not differentiated at all which is Joao's use case for example.

[..]
> > Numa node numbers / are how performance differentiated memory ranges
> > are enumerated. The expectation is that all distinct performance
> > memory targets have unique ACPI proximity domains and Linux numa node
> > numbers as a result.
>
> Makes sense to me (although it's somehow weird, because memory of the
> same socket/node would be represented via different NUMA nodes), thanks!

Yes, numa ids as only physical socket identifiers is no longer a
reliable assumption since the introduction of the ACPI HMAT.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF05F24E28B
	for <lists+linux-nvdimm@lfdr.de>; Fri, 21 Aug 2020 23:19:05 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1A3F3123AD633;
	Fri, 21 Aug 2020 14:18:34 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.218.68; helo=mail-ej1-f68.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4A12E123AD62F
	for <linux-nvdimm@lists.01.org>; Fri, 21 Aug 2020 14:18:31 -0700 (PDT)
Received: by mail-ej1-f68.google.com with SMTP id a26so4084747ejc.2
        for <linux-nvdimm@lists.01.org>; Fri, 21 Aug 2020 14:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Czkv47Mapytq1xHY+oPYH574MMmQySGYRJkgBW3lM+E=;
        b=GXn5QvE0B4fW4XfVmy6nF7VEmR25ramQstv7uYApzkRaODFrVdOXnM1zTZ6Wsmibwy
         dPfmTNTs899e7OIe+phFR2chos0Ft2tgG9zqM01uVVZPmE29arGNgsIzosvPzhSWUnGe
         J3wNyPfrnyhgIVWAU45//p0AhY4mBc6FUmzeNpTdQDSCbuWVi6ai4sl/4TKN7Bd6ypw8
         5lZeOIWb5H2+OaFKo947ypFBddehhnskfMBHe4gMQN+LdPUupi+433hVBX7NeDX/oBC5
         TgSqJ5flLj3v0348Ps+2DpHLbXs1TxDkDp2CaVgcTvVCd7lwN8q+51xsM4whGP0VMhL1
         x6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Czkv47Mapytq1xHY+oPYH574MMmQySGYRJkgBW3lM+E=;
        b=i+NA9OlTWByetq/iahyf5q0ylnOMFPAj07mNoJC+FwhklIQBreQptutoNbV9LZu7cr
         zv8Z/V2EO0i+AwLdGFGEdOvx+vtTBwkZy+mX9nz0aV938D5bhaMEkrqczBmy+Zk1ecO8
         5TNLolczcJyq0+HGDVVZGBEsMzvVlVhiVMyWjF69at1AlaPsR5xUzWwg+3lOHKEnXK+r
         UZWoMRQNvXxKGcVAU3QSoYg7tP6tXjgKEEYmOyCDmnHjeAsMatP6dNV21CAyN5ui4Rcw
         bSDom/SZPJCaklWPvvXX88VSEWdTCZmVmn3JE4jseSQrgLfDI3PoD+BFulEnQ5NWOGof
         2dAQ==
X-Gm-Message-State: AOAM5320SNs5smCeuKv2R2snI0xiDOPcAanCPBj+oktktPZu9SlSC5Tw
	bURbkTy+Jhpq0PnJg+3X/O4Wx01fco3ZLvvoZE85Lg==
X-Google-Smtp-Source: ABdhPJw7R+XywZgNxGuYeGtmKWkV2KF0ClltQZXGVP6GBaNPhi5e1DOir94iWrkYJw3POQerQKgrC5Sthl/6YvvLxa0=
X-Received: by 2002:a17:907:10d9:: with SMTP id rv25mr4570332ejb.264.1598044649266;
 Fri, 21 Aug 2020 14:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
 <c59111f9-7c94-8b9e-2b8c-4cb96b9aa848@redhat.com> <CAPcyv4j8-5nWU5GPDBoFicwR84qM=hWRtd78DkcCg4PW-8i6Vg@mail.gmail.com>
 <6af3de0d-ffdc-8942-3922-ebaeef20dd63@redhat.com> <CAPcyv4h=oBnzmP2PHAFX6H2jsNq8zSUzQLYySj0Ke7FAqZwb0A@mail.gmail.com>
 <3dfde5e3-e1e2-2097-afa1-303042de5e07@redhat.com>
In-Reply-To: <3dfde5e3-e1e2-2097-afa1-303042de5e07@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 21 Aug 2020 14:17:18 -0700
Message-ID: <CAPcyv4gTJgZ0jM3oRM8Exs7MKwyNHF5yWNceAFrX7k8KfFcBig@mail.gmail.com>
Subject: Re: [PATCH v4 00/23] device-dax: Support sub-dividing soft-reserved ranges
To: David Hildenbrand <david@redhat.com>
Message-ID-Hash: 7HA3AYHO4DGYUEOBPVM4R2AE6AH5YVB6
X-Message-ID-Hash: 7HA3AYHO4DGYUEOBPVM4R2AE6AH5YVB6
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Andrew Morton <akpm@linux-foundation.org>, Ard Biesheuvel <ardb@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, David Airlie <airlied@linux.ie>, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Joao Martins <joao.m.martins@oracle.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Tatashin <pasha.tatashin@soleen.com>, Peter Zijlstra <peterz@infradead.org>, Ben Skeggs <bskeggs@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jason Gunthorpe <jgg@mellanox.com>, Jia He <justin.he@arm.com>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Paul Mackerras <paulus@ozlabs.org>, Brice Goglin <Brice.Goglin@inr
 ia.fr>, Michael Ellerman <mpe@ellerman.id.au>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Vetter <daniel@ffwll.ch>, Andy Lutomirski <luto@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7HA3AYHO4DGYUEOBPVM4R2AE6AH5YVB6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Aug 21, 2020 at 11:30 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 21.08.20 20:27, Dan Williams wrote:
> > On Fri, Aug 21, 2020 at 3:15 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >>>>
> >>>> 1. On x86-64, e820 indicates "soft-reserved" memory. This memory is not
> >>>> automatically used in the buddy during boot, but remains untouched
> >>>> (similar to pmem). But as it involves ACPI as well, it could also be
> >>>> used on arm64 (-e820), correct?
> >>>
> >>> Correct, arm64 also gets the EFI support for enumerating memory this
> >>> way. However, I would clarify that whether soft-reserved is given to
> >>> the buddy allocator by default or not is the kernel's policy choice,
> >>> "buddy-by-default" is ok and is what will happen anyways with older
> >>> kernels on platforms that enumerate a memory range this way.
> >>
> >> Is "soft-reserved" then the right terminology for that? It sounds very
> >> x86-64/e820 specific. Maybe a compressed for of "performance
> >> differentiated memory" might be a better fit to expose to user space, no?
> >
> > No. The EFI "Specific Purpose" bit is an attribute independent of
> > e820, it's x86-Linux that entangles those together. There is no
> > requirement for platform firmware to use that designation even for
> > drastic performance differentiation between ranges, and conversely
> > there is no requirement that memory *with* that designation has any
> > performance difference compared to the default memory pool. So it
> > really is a reservation policy about a memory range to keep out of the
> > buddy allocator by default.
>
> Okay, still "soft-reserved" is x86-64 specific, no?

There's nothing preventing other EFI archs, or a similar designation
in another firmware spec, picking up this policy.

>   (AFAIK,
> "soft-reserved" will be visible in /proc/iomem, or am I confusing
> stuff?)

No, you're correct.

> IOW, it "performance differentiated" is not universally
> applicable, maybe  "specific purpose memory" is ?

Those bikeshed colors don't seem an improvement to me.

"Soft-reserved" actually tells you something about the kernel policy
for the memory. The criticism of "specific purpose" that led to
calling it "soft-reserved" in Linux is the fact that "specific" is
undefined as far as the firmware knows, and "specific" may have
different applications based on the platform user. "Soft-reserved"
like "Reserved" tells you that a driver policy might be in play for
that memory.

Also note that the current color of the bikeshed has already shipped since v5.5:

   262b45ae3ab4 x86/efi: EFI soft reservation to E820 enumeration
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

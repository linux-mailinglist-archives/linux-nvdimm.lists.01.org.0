Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA6517C780
	for <lists+linux-nvdimm@lfdr.de>; Fri,  6 Mar 2020 22:05:45 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8ED3110FC3405;
	Fri,  6 Mar 2020 13:06:35 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 00FBC10FC3404
	for <linux-nvdimm@lists.01.org>; Fri,  6 Mar 2020 13:06:33 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id f21so3804910otp.12
        for <linux-nvdimm@lists.01.org>; Fri, 06 Mar 2020 13:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a1kF/OZzMQLactEcP2uvKaRdr9m2gxg0zsQwgDcUpS8=;
        b=zHeO+NASipBgaWDXKZxHQ9T6Qk7JyQTufn1LqoKL9eCvWxA6ERYUyq5brfvaGK2Q2T
         O/1XtzLEJ1OB063KrHNDlljqirAy6dSyKF1iCoBOl1Vku6umli7wybNDN4liHG6HiEkL
         iJQBdSeZVh2iwysFc31yvgGzAfDguHevXnkROYvBITGUqkec3Q6DiV6vn3qAjCSwkC6V
         7yLNzobtVea45nRJ6F+O3pxCAX7i2s3r6qp0ctkisp7YTbLrPNxHKjQpvGQULi0khAfv
         gHd+Vg6XcX50oieboKdVEQSwY9XXXxKOGwnkGWC6OtC68at4+VqDSlJ0yEpTWQIPL97W
         CziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a1kF/OZzMQLactEcP2uvKaRdr9m2gxg0zsQwgDcUpS8=;
        b=luMPWnm2IKBrkXUsgS2LceG56Scca18piT0ObUVVH3K4GDV6P9k0Y2JXUZPK6rAgp2
         +BtgECWx8KFRwDDaroV879R2BSxoIxD/TkyJC+bFjFtbUWYhT/IoRI16NKnvZydeBswI
         7TM7g0OswXE4k8RGnbyI/duJc2HAYF59IY8OeZ5cx9BTxyrwNGRe9cVffQMyLZtMHmRu
         1fUqdSyL8Zhp2cb7NF1rNBJTfe5yYieUgkhExpRgPTuLOz0WUKg2hwIqTwQfPgTLW76H
         qUhDU88xl3DKXNuvfyvSNSP3zzeNgJAOgjWP4hqdkC0NnNceoeucvMqOtmckQbPRW/a/
         nYuA==
X-Gm-Message-State: ANhLgQ3ltoZhXCa9PUVFEp/Wc+hu4z6KR+ENd8jxe1OjeZt4zpbOW2fv
	zdvQdU0sFNX577sdHiCPrKE6keNQ+9d7kOAyLPeMvw==
X-Google-Smtp-Source: ADFU+vu3caJkxN5foYyF0GPM62BSitG6fiBBhbRTadus2AVityefuk0oEkE1SzZK3vy+IUU4Bmf/G7dorCK3e8I7x8s=
X-Received: by 2002:a05:6830:1313:: with SMTP id p19mr763057otq.126.1583528741694;
 Fri, 06 Mar 2020 13:05:41 -0800 (PST)
MIME-Version: 1.0
References: <158318759687.2216124.4684754859068906007.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x49a74tnt6n.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49a74tnt6n.fsf@segfault.boston.devel.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 6 Mar 2020 13:05:30 -0800
Message-ID: <CAPcyv4jCWtPf0XEHfw6GGGE80k0_wKpoaruopRFJwKcsHk18gw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Manual definition of Soft Reserved memory devices
To: Jeff Moyer <jmoyer@redhat.com>
Message-ID-Hash: G2NIE3ISTRUPYKKHRJFZR6NU5HKHAG4T
X-Message-ID-Hash: G2NIE3ISTRUPYKKHRJFZR6NU5HKHAG4T
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux ACPI <linux-acpi@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Brice Goglin <Brice.Goglin@inria.fr>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Andy Lutomirski <luto@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/G2NIE3ISTRUPYKKHRJFZR6NU5HKHAG4T/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Mar 6, 2020 at 12:07 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > Given the current dearth of systems that supply an ACPI HMAT table, and
> > the utility of being able to manually define device-dax "hmem" instances
> > via the efi_fake_mem= option, relax the requirements for creating these
> > devices. Specifically, add an option (numa=nohmat) to optionally disable
> > consideration of the HMAT and update efi_fake_mem= to behave like
> > memmap=nn!ss in terms of delimiting device boundaries.
>
> So, am I correct in deducing that your primary motivation is testing
> without hardware/firmware support?

My primary motivation is making the dax_kmem facility useful to
shipping platforms that have performance differentiated memory, but
may not have EFI-defined soft-reservations / HMAT (or
non-EFI-ACPI-platform equivalent). I'm anticipating HMAT enabled
platforms where the platform firmware policy for what is
soft-reserved, or not, is not the policy the system owner would pick.
I'd also highlight Joao's work [1] (see the TODO section) as an
indication of the demand for custom carving memory resources and
applying the device-dax memory management interface.

> This looks like a bit of a hack to
> me, and I think maybe it would be better to just emulate the HMAT using
> qemu.  I don't have a strong objection, though.

Yeah, qemu emulation does not help when you, the system owner, have a
different use case than what the bare-metal platform-firmware
envisioned for "specific-purpose memory".

[1]: https://lore.kernel.org/lkml/20200110190313.17144-1-joao.m.martins@oracle.com/
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

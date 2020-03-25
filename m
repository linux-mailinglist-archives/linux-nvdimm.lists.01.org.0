Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5C51924F3
	for <lists+linux-nvdimm@lfdr.de>; Wed, 25 Mar 2020 11:03:15 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 40E1210FC3603;
	Wed, 25 Mar 2020 03:04:04 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.167.195; helo=mail-oi1-f195.google.com; envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN> 
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E010310FC3192
	for <linux-nvdimm@lists.01.org>; Wed, 25 Mar 2020 03:04:01 -0700 (PDT)
Received: by mail-oi1-f195.google.com with SMTP id w13so1556343oih.4
        for <linux-nvdimm@lists.01.org>; Wed, 25 Mar 2020 03:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RbxsF3iTBYd8Alr5a+AtfnDNHQ5nhFVuguNGxWvurh0=;
        b=Dwp/3YmUYTaV77Oucd0mT1bzg82U1VI3d8dEeX366DHDPOEH/lOjx49w9vBDCFDNuP
         u0AyFUXZ2j5eDWnQIYaMwIDS0DnyIefSGw4ZQ2jf/oEXAGCU9TJepfM54NTOL77hZdf3
         fl2aoEv/a3T5qliZ2BakkufcP7UzgdM0f9D08izWDCpFekUehAa0TUY0a3D5sTF1gMPh
         0n90FmE8dZVdRYpr+MNrPTTjAaZTOLRf7aKjlEsgdp8hM6NX1YF1LEPfGgLTYzb41Lrf
         83qcOVoUJ8A7khIS1zYKZwWf5Epg/8TQ5puTgj9acmo5lGFtn6JCHFGJvWOACacNyXFT
         nUDg==
X-Gm-Message-State: ANhLgQ3uJrx+rSRxmuxa8MQ3R5l5kBS+zvdugsAcJiGM05K8Y3grYWOm
	uqU/15Xtov57jjYVRdGcuPu7hz9wWxF4b+6Bsho=
X-Google-Smtp-Source: ADFU+vtK7XJIlmRTJBKFQ3UQeLQAPRvyeRH/mRzKTpmVW/rXoTpLQXCBWXpdUAN8zvQ1FBWw76QivKVZ5CBpzMoO6GI=
X-Received: by 2002:aca:f07:: with SMTP id 7mr207477oip.68.1585130590326; Wed,
 25 Mar 2020 03:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <158489354353.1457606.8327903161927980740.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158489354353.1457606.8327903161927980740.stgit@dwillia2-desk3.amr.corp.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 25 Mar 2020 11:02:58 +0100
Message-ID: <CAJZ5v0jqKu2AFEoCPa7h-UQqzprkB1pcs9hKzu2BdQB6kRB3vQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Manual definition of Soft Reserved memory devices
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: JX3QXWO42DIZZ3O74PP2OF5XVF5ODWQO
X-Message-ID-Hash: JX3QXWO42DIZZ3O74PP2OF5XVF5ODWQO
X-MailFrom: rjwysocki@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Borislav Petkov <bp@alien8.de>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Brice Goglin <Brice.Goglin@inria.fr>, Thomas Gleixner <tglx@linutronix.de>, Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Andy Lutomirski <luto@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JX3QXWO42DIZZ3O74PP2OF5XVF5ODWQO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Mar 22, 2020 at 5:28 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Changes since v1 [1]:
> - Kill the ifdef'ery in arch/x86/mm/numa.c (Rafael)
>
> - Add a dummy phys_to_target_node() for ARM64 (0day-robot)
>
> - Initialize ->child and ->sibling to NULL in the resource returned by
>   find_next_iomem_res() (Inspired by Tom's feedback even though it does
>   not set them like he suggested)
>
> - Collect Ard's Ack
>
> [1]: http://lore.kernel.org/r/158318759687.2216124.4684754859068906007.stgit@dwillia2-desk3.amr.corp.intel.com
>
> ---
>
> My primary motivation is making the dax_kmem facility useful to
> shipping platforms that have performance differentiated memory, but
> may not have EFI-defined soft-reservations / HMAT (or
> non-EFI-ACPI-platform equivalent). I'm anticipating HMAT enabled
> platforms where the platform firmware policy for what is
> soft-reserved, or not, is not the policy the system owner would pick.
> I'd also highlight Joao's work [2] (see the TODO section) as an
> indication of the demand for custom carving memory resources and
> applying the device-dax memory management interface.
>
> Given the current dearth of systems that supply an ACPI HMAT table, and
> the utility of being able to manually define device-dax "hmem" instances
> via the efi_fake_mem= option, relax the requirements for creating these
> devices. Specifically, add an option (numa=nohmat) to optionally disable
> consideration of the HMAT and update efi_fake_mem= to behave like
> memmap=nn!ss in terms of delimiting device boundaries.
>
> [2]: https://lore.kernel.org/lkml/20200110190313.17144-1-joao.m.martins@oracle.com/
>
> With Ard's and Rafael's ack I'd feel ok taking this through the nvdimm
> tree, please holler if anything still needs some fixups.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

for the whole series.

Thanks!
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

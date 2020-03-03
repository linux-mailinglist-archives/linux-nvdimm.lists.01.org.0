Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 672341770A0
	for <lists+linux-nvdimm@lfdr.de>; Tue,  3 Mar 2020 09:01:26 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 550AB10FC3601;
	Tue,  3 Mar 2020 00:02:16 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::342; helo=mail-wm1-x342.google.com; envelope-from=ard.biesheuvel@linaro.org; receiver=<UNKNOWN> 
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 00F6C10FC3415
	for <linux-nvdimm@lists.01.org>; Tue,  3 Mar 2020 00:02:13 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 6so1921840wmi.5
        for <linux-nvdimm@lists.01.org>; Tue, 03 Mar 2020 00:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1KFVCRDxDtzub9zZu4H3xTogihEXNQAo7KqjGf/X5ds=;
        b=EIYNgH7ltAnh/xuunt1NPohmKiypqOkqB+g7AB19td4meB3xEI9LzjrtpsSEUoFA5m
         k93KAhkLIKXtXdu7WekEm5Ofn7EhY8huVn18GNJ8633kgdpWpBuy6oHiZ1K+n5AqYgQR
         r7BvnXMo2/BIDIYw95KSNU/+OQ60UQ5SnAwOZjrN0WTKL/2dE1yBSMn/wJTVX4Uk9wcx
         dxXcZtrLUfz1BbCJLrvANf3UVMyKyjWC7UMrixWttACi937C0WGvGAFkZ1tZ/vTI8IeT
         XULbHPuvRIn69wpxyQ/CKRMwi4sR1bIN8ikjjR57ijE3aQMmVAlYzj8Sf7nJk7v+ZNXA
         grqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1KFVCRDxDtzub9zZu4H3xTogihEXNQAo7KqjGf/X5ds=;
        b=NfECvzhpirpmfe2SfsDyoov5iZeSg6wjoKpF0kAkhBsGNPUHbHDb5QY5tfDrgqVqKD
         Pm7SUkSv0B3pNHyZv8C2HkdQ4rlcIgACeqwUeDmpXafm57cXrdqlehXuGVn/OgQ3NnIf
         LRK+voLqBSrt/GwKSFHxEepuXVJbcpKtvFjE3aj3Wr00NY/ER/C3Lf67YYmbAoEsVoSF
         RYRHuqUpcu416K8YQri1lsczym4lkP7uiODqG4Svo68Bgp8+Pfe8G9Mr9q3WeVKey+aZ
         JSCwEPFB5iMEi6KbAjBp34ivISXT+R92nQkHdNTcH0bL7AnkAkznmsrLcrEaD1rblwwN
         O9lw==
X-Gm-Message-State: ANhLgQ3v+9aRRmRzyFpuCG/XbJbhZW6ZNQyaeEwPUFKPo5+FvLJbWsun
	ffbvwe37gB4H43Cnuda5gxsQK7VYO4ZMDQSpDwDPUQ==
X-Google-Smtp-Source: ADFU+vtMD9Hn+PWCo8WlKQENvA+VrRYcQgo1HZGruvYLZljw/sATAP3ygGaVLtX5UMG/zzD28ojIn4NQgBpDcfFk/dI=
X-Received: by 2002:a05:600c:24b:: with SMTP id 11mr2902120wmj.1.1583222480788;
 Tue, 03 Mar 2020 00:01:20 -0800 (PST)
MIME-Version: 1.0
References: <158318759687.2216124.4684754859068906007.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158318760967.2216124.7838939599184768260.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158318760967.2216124.7838939599184768260.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 3 Mar 2020 09:01:09 +0100
Message-ID: <CAKv+Gu_Erea9q4Ay2wmq70EQ8844baBtvVQsv0T1DM8U8eHY6Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] efi/fake_mem: Arrange for a resource entry per
 efi_fake_mem instance
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: VDEHSUEQ5HHR2AXSGBITMOFWKEREJEZS
X-Message-ID-Hash: VDEHSUEQ5HHR2AXSGBITMOFWKEREJEZS
X-MailFrom: ard.biesheuvel@linaro.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VDEHSUEQ5HHR2AXSGBITMOFWKEREJEZS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2 Mar 2020 at 23:36, Dan Williams <dan.j.williams@intel.com> wrote:
>
> In preparation for attaching a platform device per iomem resource teach
> the efi_fake_mem code to create an e820 entry per instance. Similar to
> E820_TYPE_PRAM, bypass merging resource when the e820 map is sanitized.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/x86/kernel/e820.c              |   16 +++++++++++++++-
>  drivers/firmware/efi/x86_fake_mem.c |   12 +++++++++---
>  2 files changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index c5399e80c59c..96babb3a6629 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -305,6 +305,20 @@ static int __init cpcompare(const void *a, const void *b)
>         return (ap->addr != ap->entry->addr) - (bp->addr != bp->entry->addr);
>  }
>
> +static bool e820_nomerge(enum e820_type type)
> +{
> +       /*
> +        * These types may indicate distinct platform ranges aligned to
> +        * numa node, protection domain, performance domain, or other
> +        * boundaries. Do not merge them.
> +        */
> +       if (type == E820_TYPE_PRAM)
> +               return true;
> +       if (type == E820_TYPE_SOFT_RESERVED)
> +               return true;
> +       return false;
> +}
> +
>  int __init e820__update_table(struct e820_table *table)
>  {
>         struct e820_entry *entries = table->entries;
> @@ -380,7 +394,7 @@ int __init e820__update_table(struct e820_table *table)
>                 }
>
>                 /* Continue building up new map based on this information: */
> -               if (current_type != last_type || current_type == E820_TYPE_PRAM) {
> +               if (current_type != last_type || e820_nomerge(current_type)) {
>                         if (last_type != 0)      {
>                                 new_entries[new_nr_entries].size = change_point[chg_idx]->addr - last_addr;
>                                 /* Move forward only if the new size was non-zero: */
> diff --git a/drivers/firmware/efi/x86_fake_mem.c b/drivers/firmware/efi/x86_fake_mem.c
> index e5d6d5a1b240..0bafcc1bb0f6 100644
> --- a/drivers/firmware/efi/x86_fake_mem.c
> +++ b/drivers/firmware/efi/x86_fake_mem.c
> @@ -38,7 +38,7 @@ void __init efi_fake_memmap_early(void)
>                 m_start = mem->range.start;
>                 m_end = mem->range.end;
>                 for_each_efi_memory_desc(md) {
> -                       u64 start, end;
> +                       u64 start, end, size;
>
>                         if (md->type != EFI_CONVENTIONAL_MEMORY)
>                                 continue;
> @@ -58,11 +58,17 @@ void __init efi_fake_memmap_early(void)
>                          */
>                         start = max(start, m_start);
>                         end = min(end, m_end);
> +                       size = end - start + 1;
>
>                         if (end <= start)
>                                 continue;
> -                       e820__range_update(start, end - start + 1, E820_TYPE_RAM,
> -                                       E820_TYPE_SOFT_RESERVED);
> +
> +                       /*
> +                        * Ensure each efi_fake_mem instance results in
> +                        * a unique e820 resource
> +                        */
> +                       e820__range_remove(start, size, E820_TYPE_RAM, 1);
> +                       e820__range_add(start, size, E820_TYPE_SOFT_RESERVED);
>                         e820__update_table(e820_table);
>                 }
>         }
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

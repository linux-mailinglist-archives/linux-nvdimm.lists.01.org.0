Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CE7203A17
	for <lists+linux-nvdimm@lfdr.de>; Mon, 22 Jun 2020 16:56:18 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3F9EB10FC72A1;
	Mon, 22 Jun 2020 07:56:17 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com; envelope-from=andy.shevchenko@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 31E2010FC729F
	for <linux-nvdimm@lists.01.org>; Mon, 22 Jun 2020 07:56:15 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r18so8235235pgk.11
        for <linux-nvdimm@lists.01.org>; Mon, 22 Jun 2020 07:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xjagLTgBdJuS+lxCzj+HJEcO0dILS8d3HH+uOW/jYtg=;
        b=Md8aji7v9v0IesqnKaESVzP6xZdACvIez0GIkPpCPmtWFsewspfffLO15ZBS7ofNeu
         i5H6dE4LJi6O1A7RSHmuZV7nLXinxR9H7+KvrUlooYEHr0Aho3aIMdQBF+L2sXNjFY0Q
         Gh3B3cagl5QtXpxT+COfqGy3PV+KOXHuG4NH1Uel+v8fSPemDaWeTlsS66xv1B1raMhj
         hwwZkHtRYkYbQiX9vMs0U4oAYXI3hPYLW1fttm9Az0WpH9SpcI96Hsx+A8vJEbcEYtTY
         motBNPnQH1XLgb+g1Es5sQUsaGzcdvH04dcVsVHiVlXm0B/C8j0Kl7aCzhOciJwAKT4l
         3EcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xjagLTgBdJuS+lxCzj+HJEcO0dILS8d3HH+uOW/jYtg=;
        b=IspM8dAg6yBG1lVfQ8F/yFPtdr+RPDF8ZvRU/ulp/IATOhZkF3UgFEO30WwkQKe1y0
         6GmUjdJW5tXhshwk4xKoVOOlPR1WhEu2zLhb9wJoAfXwX2ttd1UHYTluWdVrM2LzpnrM
         G79G5/g3Aoa6pTVu8BbPDFLM1r9OGAo84gOO0xUefdDAJ4YKoWCwiaRAd5bgC4kzKrYI
         IAhciG+E+4Ml3ZvCq8WmrQb0aFI87VDL34pdNC9VGYaE2N8dstubL3U6UuOV0SAjColf
         lD3S1d6zk3XPqRCo3kpUf3eFNXQBfcpDPR7mbICXisbajKg+JbwS5N5kcuDlsa1b8rET
         VCTg==
X-Gm-Message-State: AOAM531OYZt1Paf3beJfDraE/wuF17OOYK+geq0sqETcWysVHXh5avYy
	nWiv67epPsTHkqJLy7AHvqvfwnssiqMBD/nqce8=
X-Google-Smtp-Source: ABdhPJw6mQ+zxmpMSkJb+dlDQRkhgtNZHBFjiCPSrtowB9pYMq4Z4oApxfCZkPSIP1wpDoaef47WoTMB7FRH5DO4Uyo=
X-Received: by 2002:a62:3103:: with SMTP id x3mr20128249pfx.130.1592837774307;
 Mon, 22 Jun 2020 07:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <2713141.s8EVnczdoM@kreacher> <1821880.vZFEW4x2Ui@kreacher>
In-Reply-To: <1821880.vZFEW4x2Ui@kreacher>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 22 Jun 2020 17:56:01 +0300
Message-ID: <CAHp75VePDyPevCAOntFpTajf5zd9ocwjeWRz80WmCNtiDicpLg@mail.gmail.com>
Subject: Re: [RFT][PATCH v2 2/4] ACPI: OSL: Add support for deferred unmapping
 of ACPI memory
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Message-ID-Hash: FGG5FHHQD6DZGPMNA5EPLTLF7MPTJ6IY
X-Message-ID-Hash: FGG5FHHQD6DZGPMNA5EPLTLF7MPTJ6IY
X-MailFrom: andy.shevchenko@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Erik Kaneda <erik.kaneda@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Myron Stowe <myron.stowe@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-nvdimm@lists.01.org, Bob Moore <robert.moore@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FGG5FHHQD6DZGPMNA5EPLTLF7MPTJ6IY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jun 22, 2020 at 5:06 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> Implement acpi_os_unmap_deferred() and
> acpi_os_release_unused_mappings() and set ACPI_USE_DEFERRED_UNMAPPING
> to allow ACPICA to use deferred unmapping of memory in
> acpi_ex_system_memory_space_handler() so as to avoid RCU-related
> performance issues with memory opregions.

...

> +static bool acpi_os_drop_map_ref(struct acpi_ioremap *map, bool defer)
>  {
> -       unsigned long refcount = --map->refcount;
> +       if (--map->track.refcount)
> +               return true;
>
> -       if (!refcount)
> -               list_del_rcu(&map->list);
> -       return refcount;
> +       list_del_rcu(&map->list);
> +

> +       if (defer) {
> +               INIT_LIST_HEAD(&map->track.gc);
> +               list_add_tail(&map->track.gc, &unused_mappings);

> +               return true;
> +       }
> +
> +       return false;

A nit:

Effectively it returns a value of defer.

  return defer;

>  }

...

> @@ -416,26 +421,102 @@ void __ref acpi_os_unmap_iomem(void __iomem *virt, acpi_size size)
>         }
>
>         mutex_lock(&acpi_ioremap_lock);
> +
>         map = acpi_map_lookup_virt(virt, size);

A nit: should it be somewhere else (I mean in another patch)?

>         if (!map) {

...

> +       /* Release the unused mappings in the list. */
> +       while (!list_empty(&list)) {
> +               struct acpi_ioremap *map;
> +
> +               map = list_entry(list.next, struct acpi_ioremap, track.gc);

A nt: if __acpi_os_map_cleanup() (actually acpi_unmap() according to
the code) has no side effects, can we use list_for_each_entry_safe()
here?

> +               list_del(&map->track.gc);
> +               __acpi_os_map_cleanup(map);
> +       }
> +}

...

> @@ -472,16 +552,18 @@ void acpi_os_unmap_generic_address(struct acpi_generic_address *gas)
>                 return;
>
>         mutex_lock(&acpi_ioremap_lock);
> +
>         map = acpi_map_lookup(addr, gas->bit_width / 8);

A nit: should it be somewhere else (I mean in another patch)?

-- 
With Best Regards,
Andy Shevchenko
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

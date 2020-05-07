Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D5E1C9F00
	for <lists+linux-nvdimm@lfdr.de>; Fri,  8 May 2020 01:13:15 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 307541181F3BA;
	Thu,  7 May 2020 16:11:13 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 08B0F1181F3B8
	for <linux-nvdimm@lists.01.org>; Thu,  7 May 2020 16:11:10 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id f12so6881946edn.12
        for <linux-nvdimm@lists.01.org>; Thu, 07 May 2020 16:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hOgoGFfrQiuxoVLXtR6ns0cA7T4PnQXjD00h0lBOWe4=;
        b=hrgYnUmsGdoaS3xDvgxUWyQB+Y5ou6argIEx1l1Kr98VcT/PuZNB21w7VF4wNyOf3b
         ZTR3HijaDV+aYn7AVymILBM1HG6SsF3OBVQw+NaTDBW7yCAUHp+xDTo+d2HF2cWV62Kx
         J0RHUmvKSo3QkxABUHofYEIYdck5hZ1pQ6TIdTqfGuRxHAfc9lc9WoKNSXaf5jd4sGH6
         5zsj2CdRwbHBtEc5v/2QRCkRx3FkrQQQfcWJEBhPumdfcYetulcFpdZ2IUdvb+Ej1ldh
         tWc0dThiiOgWTKPjGS8u0xo8v7dsvuhAFMjWHTib/xrlps+UHajnDWMLelWRkA9TeCdP
         2JmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hOgoGFfrQiuxoVLXtR6ns0cA7T4PnQXjD00h0lBOWe4=;
        b=BeDekkyErX5dsX6VwuKq+mTkWRYDZQmUTcxlg2YOudY/xTm2bMARHllmUwZY+P1SSn
         AeCvqP538IjwHnfo9Fnc/Xis7GsNWyZMP/JxtDGrmQaMrqIKgWMTz44Y5bVeR84wAX3B
         tXhampCXElJRXLh5wYx3jSLQOFJqt4r5eWnvGt+FmV0RuJpQUfBDSQ5UZMRn9R7Aaqic
         N8Dl6yf/GZ1Zwq1eUR+8k8bn8ISmGY/d2U14m4VLtjpr3xOkotAzeKNPaiqGHzo79+2+
         yLdcRG/34apTpKCvojW8sCIUYDB74UAe/eJxLC1lXWttfwBZdDnaHNvRa8mO+iScwzJ8
         UjXQ==
X-Gm-Message-State: AGi0PuYV35ES1wIvrriEgnMYNv0DoYdDz21zcza0OgtlQyX3BeaGmFe1
	pHSNh8AcPi4OUnu2Mb/Y8DUvdfQ93pzQXDeCkUHVlQ==
X-Google-Smtp-Source: APiQypLKOsixtTx2ArZFZo5Vte0u7Uot4DdFVW14d0f8hZF71PsBU1ityGME4xeFTnZmsoCmyniMyBMwVkOsZylK9MA=
X-Received: by 2002:a05:6402:3136:: with SMTP id dd22mr13983824edb.165.1588893188370;
 Thu, 07 May 2020 16:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <158880834905.2183490.15616329469420234017.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAHp75Vf0zBnwHubK+C265M9nh3Y5K2K=8ck61HQtnW+021bgwQ@mail.gmail.com>
In-Reply-To: <CAHp75Vf0zBnwHubK+C265M9nh3Y5K2K=8ck61HQtnW+021bgwQ@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 7 May 2020 16:12:57 -0700
Message-ID: <CAPcyv4gOxrOZUKfA4cObKUaZRkkjRyQFkS+=Q9FXziK00CE8yA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Drop rcu usage for MMIO mappings
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Message-ID-Hash: D4KQJFQOO5RU7UXOEWKRDOWNWJZS5VYJ
X-Message-ID-Hash: D4KQJFQOO5RU7UXOEWKRDOWNWJZS5VYJ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Stable <stable@vger.kernel.org>, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Erik Kaneda <erik.kaneda@intel.com>, Myron Stowe <myron.stowe@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/D4KQJFQOO5RU7UXOEWKRDOWNWJZS5VYJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, May 7, 2020 at 2:25 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, May 7, 2020 at 3:21 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > Recently a performance problem was reported for a process invoking a
> > non-trival ASL program. The method call in this case ends up
> > repetitively triggering a call path like:
> >
> >     acpi_ex_store
> >     acpi_ex_store_object_to_node
> >     acpi_ex_write_data_to_field
> >     acpi_ex_insert_into_field
> >     acpi_ex_write_with_update_rule
> >     acpi_ex_field_datum_io
> >     acpi_ex_access_region
> >     acpi_ev_address_space_dispatch
> >     acpi_ex_system_memory_space_handler
> >     acpi_os_map_cleanup.part.14
> >     _synchronize_rcu_expedited.constprop.89
> >     schedule
> >
> > The end result of frequent synchronize_rcu_expedited() invocation is
> > tiny sub-millisecond spurts of execution where the scheduler freely
> > migrates this apparently sleepy task. The overhead of frequent scheduler
> > invocation multiplies the execution time by a factor of 2-3X.
> >
> > For example, performance improves from 16 minutes to 7 minutes for a
> > firmware update procedure across 24 devices.
> >
> > Perhaps the rcu usage was intended to allow for not taking a sleeping
> > lock in the acpi_os_{read,write}_memory() path which ostensibly could be
> > called from an APEI NMI error interrupt? Neither rcu_read_lock() nor
> > ioremap() are interrupt safe, so add a WARN_ONCE() to validate that rcu
> > was not serving as a mechanism to avoid direct calls to ioremap(). Even
> > the original implementation had a spin_lock_irqsave(), but that is not
> > NMI safe.
> >
> > APEI itself already has some concept of avoiding ioremap() from
> > interrupt context (see erst_exec_move_data()), if the new warning
> > triggers it means that APEI either needs more instrumentation like that
> > to pre-emptively fail, or more infrastructure to arrange for pre-mapping
> > the resources it needs in NMI context.
>
> ...
>
> > +static void __iomem *acpi_os_rw_map(acpi_physical_address phys_addr,
> > +                                   unsigned int size, bool *did_fallback)
> > +{
> > +       void __iomem *virt_addr = NULL;
>
> Assignment is not needed as far as I can see.

True, holdover from a previous version, will drop.

>
> > +       if (WARN_ONCE(in_interrupt(), "ioremap in interrupt context\n"))
> > +               return NULL;
> > +
> > +       /* Try to use a cached mapping and fallback otherwise */
> > +       *did_fallback = false;
> > +       mutex_lock(&acpi_ioremap_lock);
> > +       virt_addr = acpi_map_vaddr_lookup(phys_addr, size);
> > +       if (virt_addr)
> > +               return virt_addr;
> > +       mutex_unlock(&acpi_ioremap_lock);
> > +
> > +       virt_addr = acpi_os_ioremap(phys_addr, size);
> > +       *did_fallback = true;
> > +
> > +       return virt_addr;
> > +}
>
> I'm wondering if Sparse is okay with this...

Seems like it is:

$ sparse --version
v0.6.1-191-gc51a0382202e

$ cat out | grep osl\.c
  CHECK   drivers/acpi/osl.c
drivers/acpi/osl.c:373:17: warning: cast removes address space
'<asn:2>' of expression

...was the only warning I got.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 680131C859F
	for <lists+linux-nvdimm@lfdr.de>; Thu,  7 May 2020 11:25:06 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3829F11760A09;
	Thu,  7 May 2020 02:23:08 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com; envelope-from=andy.shevchenko@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9CEF611760A08
	for <linux-nvdimm@lists.01.org>; Thu,  7 May 2020 02:23:05 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k19so1840583pll.9
        for <linux-nvdimm@lists.01.org>; Thu, 07 May 2020 02:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GySnMOCjEwjmYKLw1ybYlhgVtoYAht9uSjW2oEXIKIo=;
        b=AfOowyx/OkmjNQUa65VECiO/+/o4o6RBP4CsdAGU1pv7F5oGZguv4qpvECbO2DsLRm
         /s+Bawlqy3JPH7s9dsf8VqDxrucmGUm+2Kyf8MK45fdwAfHl9v1UM8gil57A6xVFFZ/1
         74/V0q4KY50NRk/mssMxuQM4RWJ5NkkymbfmzPa7uvMJ2kVpyC5JjC0qNfEJ5G4AujYo
         uY1Dlv7PsEC5GoglrLdQucCkcXNh80X3UDShw6LeDf1nEBzbfIVPMkI2kMq+l/JQ8Azq
         gA3FCW4SWsn8juJT+7kj68gwXc4uP+CFPTHLZR+OmCl6soyeziW+7XyxLKo/CXURipft
         DmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GySnMOCjEwjmYKLw1ybYlhgVtoYAht9uSjW2oEXIKIo=;
        b=S4n0Oo/GlCx5zSn4aQ44uet4FRxrCjOdyBqGy7HxgVS+RRUuaedf/GQpBDHu4ByvMM
         MF5mCpLh8PzY6NocuUdx5SDOfhZcqldmWpuf7iVbdva316/v8tj6SgkjhiVRaoGmsuRR
         Qk895wch6fgQPMqyfLl+BhkgTa6hGwAKibXTBBIp+YOfn5Ey409/EFqbzO8ZMlgk/n5E
         Qo+6Z1Do6GNTq2s3+npgdMZl7UWbQGnRLjf1c0sccIIon9nOeHX0INsbR3DOyH+SamKm
         urQBu+3DUiwvWBT6Wk5MJIcyvgH5NLtXkccpGJiAHCCjyLsIqgregPIs5FNxbi+w+KLT
         WSCA==
X-Gm-Message-State: AGi0PuZm6hXhI+hUTBu+tcf6W7Xuqt4WB287CVydF2MFmGsm2hjHSpYa
	u25mRD82gH/4M76rxMlkybuQld6jNyfqPJF3J+K9rhMdtFo=
X-Google-Smtp-Source: APiQypLCo11VtyxLxVipMJet+Uc/jH+bliGdPTuMeaMs+hQVOZgfSQlXQ/Vm47iIhfVrJzInVwy52114mBZs8kv8eGk=
X-Received: by 2002:a17:90a:fa81:: with SMTP id cu1mr14771332pjb.25.1588843501300;
 Thu, 07 May 2020 02:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <158880834905.2183490.15616329469420234017.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158880834905.2183490.15616329469420234017.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 7 May 2020 12:24:49 +0300
Message-ID: <CAHp75Vf0zBnwHubK+C265M9nh3Y5K2K=8ck61HQtnW+021bgwQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Drop rcu usage for MMIO mappings
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: TZNUWI2JT4A55F36RQHZIRVRNUH6DKND
X-Message-ID-Hash: TZNUWI2JT4A55F36RQHZIRVRNUH6DKND
X-MailFrom: andy.shevchenko@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Stable <stable@vger.kernel.org>, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Erik Kaneda <erik.kaneda@intel.com>, Myron Stowe <myron.stowe@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TZNUWI2JT4A55F36RQHZIRVRNUH6DKND/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, May 7, 2020 at 3:21 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Recently a performance problem was reported for a process invoking a
> non-trival ASL program. The method call in this case ends up
> repetitively triggering a call path like:
>
>     acpi_ex_store
>     acpi_ex_store_object_to_node
>     acpi_ex_write_data_to_field
>     acpi_ex_insert_into_field
>     acpi_ex_write_with_update_rule
>     acpi_ex_field_datum_io
>     acpi_ex_access_region
>     acpi_ev_address_space_dispatch
>     acpi_ex_system_memory_space_handler
>     acpi_os_map_cleanup.part.14
>     _synchronize_rcu_expedited.constprop.89
>     schedule
>
> The end result of frequent synchronize_rcu_expedited() invocation is
> tiny sub-millisecond spurts of execution where the scheduler freely
> migrates this apparently sleepy task. The overhead of frequent scheduler
> invocation multiplies the execution time by a factor of 2-3X.
>
> For example, performance improves from 16 minutes to 7 minutes for a
> firmware update procedure across 24 devices.
>
> Perhaps the rcu usage was intended to allow for not taking a sleeping
> lock in the acpi_os_{read,write}_memory() path which ostensibly could be
> called from an APEI NMI error interrupt? Neither rcu_read_lock() nor
> ioremap() are interrupt safe, so add a WARN_ONCE() to validate that rcu
> was not serving as a mechanism to avoid direct calls to ioremap(). Even
> the original implementation had a spin_lock_irqsave(), but that is not
> NMI safe.
>
> APEI itself already has some concept of avoiding ioremap() from
> interrupt context (see erst_exec_move_data()), if the new warning
> triggers it means that APEI either needs more instrumentation like that
> to pre-emptively fail, or more infrastructure to arrange for pre-mapping
> the resources it needs in NMI context.

...

> +static void __iomem *acpi_os_rw_map(acpi_physical_address phys_addr,
> +                                   unsigned int size, bool *did_fallback)
> +{
> +       void __iomem *virt_addr = NULL;

Assignment is not needed as far as I can see.

> +       if (WARN_ONCE(in_interrupt(), "ioremap in interrupt context\n"))
> +               return NULL;
> +
> +       /* Try to use a cached mapping and fallback otherwise */
> +       *did_fallback = false;
> +       mutex_lock(&acpi_ioremap_lock);
> +       virt_addr = acpi_map_vaddr_lookup(phys_addr, size);
> +       if (virt_addr)
> +               return virt_addr;
> +       mutex_unlock(&acpi_ioremap_lock);
> +
> +       virt_addr = acpi_os_ioremap(phys_addr, size);
> +       *did_fallback = true;
> +
> +       return virt_addr;
> +}

I'm wondering if Sparse is okay with this...

> +static void acpi_os_rw_unmap(void __iomem *virt_addr, bool did_fallback)
> +{
> +       if (did_fallback) {
> +               /* in the fallback case no lock is held */
> +               iounmap(virt_addr);
> +               return;
> +       }
> +
> +       mutex_unlock(&acpi_ioremap_lock);
> +}

...and this functions from locking perspective.

-- 
With Best Regards,
Andy Shevchenko
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

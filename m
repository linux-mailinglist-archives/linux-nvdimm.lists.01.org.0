Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9021C9D22
	for <lists+linux-nvdimm@lfdr.de>; Thu,  7 May 2020 23:20:48 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E0B1511816D6F;
	Thu,  7 May 2020 14:18:46 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 50BE611816D6D
	for <linux-nvdimm@lists.01.org>; Thu,  7 May 2020 14:18:43 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id a8so6707329edv.2
        for <linux-nvdimm@lists.01.org>; Thu, 07 May 2020 14:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PHG6yTghcibf497dWa0jTcy5wb1cOxvUkXcsCAAAnu0=;
        b=hhdJwocmiOmhRbStlbTJF+p2HOJLzKjtHBW7/pWc2QtLmrhNBExIXrUO2uQY5aJFic
         NPqwRqO/FhcKBHF/m/7sj8CrG7BnmqViC07cpNI3aHZjYqvifvmstOVxRyhtVNXzcaw/
         odCvKvCvH1ts+K/benGuSU6XoYNbAe9XYRePBEsMfRJi35r79vMwY/Cf/d9exGoIO/cM
         i0K74AdGR8TY4T7Qk9WwZjhxA1Y5OmygaBA8PACbgoOiEb3IK8NwuA9XAFhB6Kl4J0w5
         r81WRBbrVsb5OZs5KYgcZZylE6FCNIL9AkQr2yo6e9K3nuwFOmCkxlf5SdIXs7sUpoAI
         LMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PHG6yTghcibf497dWa0jTcy5wb1cOxvUkXcsCAAAnu0=;
        b=Z/TecEVWBpEbi0NPeYGXLdpa/oObrq6OUysbHC4qbv8GQNzkP+XQmFvL3v8aeLFwz+
         HXi78BF+aXWz1Z6RCVcrMBPdMA4tpNAwdNq6NUPdEt6MWqKvHvsw3yEAfoZ4J4ESTXP5
         PheAgyZfOlFkAq1KOApJbAB2sKYqFO7f4FAK9FmX7JOxHncQUl+mzqFAvs2PTkKhkR6D
         k1d0beKh7lwm2yWHukSl/sEU1EypseamdaWvY5KfqmqVlkZOkhFSVtFCJFH2nDDHPOrn
         6HMm/TNJ+5tnQlEjCIfuLpgZvcjRTPOyZeMep/4GM9sATyYLPv0l7wmQkHHmY7MQiXyT
         VZfg==
X-Gm-Message-State: AGi0Puap+oZabUUpBhh6Mh2qpRX2l0c8m6ZdBCmobvN1m3/A+Z9A2a7b
	bvQTn2BW9bK+eVj+KE3NJpSHFfPvOGAJDLFWxYDhKA==
X-Google-Smtp-Source: APiQypIDiQajRa4tQ5UpB7rmME33WGj2fRXc8YbBkxmSYjWsrm7ee61hgisYO4/M3hOn/3+7xRKMFnT6KU6LZryG7mc=
X-Received: by 2002:aa7:c643:: with SMTP id z3mr13702521edr.154.1588886441435;
 Thu, 07 May 2020 14:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <158880834905.2183490.15616329469420234017.stgit@dwillia2-desk3.amr.corp.intel.com>
 <bd3963f3-c6d6-f138-331c-9ac065633491@intel.com>
In-Reply-To: <bd3963f3-c6d6-f138-331c-9ac065633491@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 7 May 2020 14:20:30 -0700
Message-ID: <CAPcyv4ikWy9E8ScM2k1wdxUuPegftvOFwyLr86MupYpHsmxnUg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Drop rcu usage for MMIO mappings
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Message-ID-Hash: W56IPXOTCT5RYBAJ7COSKLH2CEVIUEQF
X-Message-ID-Hash: W56IPXOTCT5RYBAJ7COSKLH2CEVIUEQF
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: stable <stable@vger.kernel.org>, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Erik Kaneda <erik.kaneda@intel.com>, Myron Stowe <myron.stowe@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/W56IPXOTCT5RYBAJ7COSKLH2CEVIUEQF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, May 7, 2020 at 9:43 AM Rafael J. Wysocki
<rafael.j.wysocki@intel.com> wrote:
>
> On 5/7/2020 1:39 AM, Dan Williams wrote:
> > Recently a performance problem was reported for a process invoking a
> > non-trival ASL program. The method call in this case ends up
> > repetitively triggering a call path like:
> >
> >      acpi_ex_store
> >      acpi_ex_store_object_to_node
> >      acpi_ex_write_data_to_field
> >      acpi_ex_insert_into_field
> >      acpi_ex_write_with_update_rule
> >      acpi_ex_field_datum_io
> >      acpi_ex_access_region
> >      acpi_ev_address_space_dispatch
> >      acpi_ex_system_memory_space_handler
> >      acpi_os_map_cleanup.part.14
> >      _synchronize_rcu_expedited.constprop.89
> >      schedule
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
> >
> > Cc: <stable@vger.kernel.org>
> > Fixes: 620242ae8c3d ("ACPI: Maintain a list of ACPI memory mapped I/O remappings")
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: James Morse <james.morse@arm.com>
> > Cc: Erik Kaneda <erik.kaneda@intel.com>
> > Cc: Myron Stowe <myron.stowe@redhat.com>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> linux-acpi is kind of relevant for this too, so please CC it.

Whoops, my bad. Will resend with some of Andy's cleanup suggestions.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5BB1EF913
	for <lists+linux-nvdimm@lfdr.de>; Fri,  5 Jun 2020 15:32:34 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CB093100A05D5;
	Fri,  5 Jun 2020 06:27:18 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.210.68; helo=mail-ot1-f68.google.com; envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DB6CF100DEFFD
	for <linux-nvdimm@lists.01.org>; Fri,  5 Jun 2020 06:27:15 -0700 (PDT)
Received: by mail-ot1-f68.google.com with SMTP id h7so7621708otr.3
        for <linux-nvdimm@lists.01.org>; Fri, 05 Jun 2020 06:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r5xkCx6S6H0OEEUFi5jI6heu9Q5+k1PSszipZkD4qO4=;
        b=KLxKpoI2q1eiXtxk0xBwvgSUbi2rojYj6nhzhPbBumshJVxHTkMLj/T3e/zLSkvsS4
         uYKoMJATW4qRON/1W56KTlkh4udrn1M8n0vM6Ad9rTkQZLog3suGVobz46AorF5XqqIG
         N/ZWK8gVVCcC1lHErcaVNmggUkIsp9a988cA9KpgDu5NWs4imwG8Ly0xPqpPudO35jNI
         3bfOyf4gt/MjGQyZ4EeY4UGqoOY6zLcoJAq4hQcziErF9YKkDOzsoQAuI/4AySqk8UeW
         CPcEmQM9FZcS5os9iD+MUFweVO9+AD6wqfg9fVTIcRx/Zs4bwzWMu3Gh1DDiTqOoaiLj
         sv7w==
X-Gm-Message-State: AOAM532cZtQOvXs74XpBSnQ3TI7D2wokLsOjVxOe0hsJ+uBKHECJv01X
	iu14yYMDK0zAJQR18S0isphAHsyLb9GvlRKaEtE=
X-Google-Smtp-Source: ABdhPJx/2s0YSjL0Yoa1CBlVQPXNsAgX1/mFvRuZ/AKVx+jsfWoonKouaBjMJfpsxJ/XGbfSXMxS1pgNexk4kOj/N9M=
X-Received: by 2002:a05:6830:20d1:: with SMTP id z17mr7336449otq.167.1591363945478;
 Fri, 05 Jun 2020 06:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Jun 2020 15:32:14 +0200
Message-ID: <CAJZ5v0gq55A7880dOJD7skwx7mnjsqbCqEGFvEo552U9W2zH3Q@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: Drop rcu usage for MMIO mappings
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: EKL32YY5M2QEUQKC6SLVVTCJKASCSNSF
X-Message-ID-Hash: EKL32YY5M2QEUQKC6SLVVTCJKASCSNSF
X-MailFrom: rjwysocki@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Rafael Wysocki <rafael.j.wysocki@intel.com>, Stable <stable@vger.kernel.org>, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Erik Kaneda <erik.kaneda@intel.com>, Myron Stowe <myron.stowe@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EKL32YY5M2QEUQKC6SLVVTCJKASCSNSF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, May 8, 2020 at 1:55 AM Dan Williams <dan.j.williams@intel.com> wrote:
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
> called from an APEI NMI error interrupt?

Not really.

acpi_os_{read|write}_memory() end up being called from non-NMI
interrupt context via acpi_hw_{read|write}(), respectively, and quite
obviously ioremap() cannot be run from there, but in those cases the
mappings in question are there in the list already in all cases and so
the ioremap() isn't used then.

RCU is there to protect these users from walking the list while it is
being updated.

> Neither rcu_read_lock() nor ioremap() are interrupt safe, so add a WARN_ONCE() to validate that rcu
> was not serving as a mechanism to avoid direct calls to ioremap().

But it would produce false-positives if the IRQ context was not NMI,
wouldn't it?

> Even the original implementation had a spin_lock_irqsave(), but that is not
> NMI safe.

Which is not a problem (see above).

> APEI itself already has some concept of avoiding ioremap() from
> interrupt context (see erst_exec_move_data()), if the new warning
> triggers it means that APEI either needs more instrumentation like that
> to pre-emptively fail, or more infrastructure to arrange for pre-mapping
> the resources it needs in NMI context.

Well, I'm not sure about that.

Thanks!
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8901EFD76
	for <lists+linux-nvdimm@lfdr.de>; Fri,  5 Jun 2020 18:21:47 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 623FB1009F039;
	Fri,  5 Jun 2020 09:16:33 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.210.66; helo=mail-ot1-f66.google.com; envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 83B0E1009F038
	for <linux-nvdimm@lists.01.org>; Fri,  5 Jun 2020 09:16:30 -0700 (PDT)
Received: by mail-ot1-f66.google.com with SMTP id 69so8057017otv.2
        for <linux-nvdimm@lists.01.org>; Fri, 05 Jun 2020 09:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tNm/MEsuRiThlj0w2Ep6hniygV5tFbfb9SR7Z3GLj9Y=;
        b=jd7fMn1fCtCgDdej5ietuIqOPePKdvGvONfTL8cMW3fqsPdpWmJx2WQ4MwjnYFlF0A
         Mg7l36RJGjZYUD+Q9XGQJ0N8wrplkkDf5CxESZpZ0QLkPjZUCoEprgjfIKBXVC5ehVRk
         eMqgTRqQoD7q4I0/gn5sfx+Gx8200zzQdb0C4RS3zal3wR4P/VZONuQWBvmDC1a8X0Tx
         RlUGiek5eNqaJVDpcsMkXwA6umXYoVEx+jkMgk8qLcK0SqOOAcwALsBE2aT2BTZ6HDWW
         Fp/cZP+nQ6VReu27rx1eheZ87iL7/k8vYrCXtG++ivAGeT/Di1FlAJSOTVtFcwbqeUhK
         0wiQ==
X-Gm-Message-State: AOAM532kmHQhQOjiYd031y/uY51L59w4AkFpc8+kFS9BenzHq6BLDvAW
	pBJcwuDC8btpeZj9eQhSUz/Hg0wBWDOeoAmOeAg=
X-Google-Smtp-Source: ABdhPJwGbBmx3OnMsin8+/tCfwolPcXpa3AYr4pgSORGQmWTl8u3ZgO7Zkxncv+YIFsOCyUUBnNaQR6wgbRYJGe3OY4=
X-Received: by 2002:a05:6830:20d1:: with SMTP id z17mr7872068otq.167.1591374101775;
 Fri, 05 Jun 2020 09:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAJZ5v0gq55A7880dOJD7skwx7mnjsqbCqEGFvEo552U9W2zH3Q@mail.gmail.com> <CAPcyv4gQNPNOmSVrp7epS5_10qLUuGbutQ2xz7LXnpEhkWeA_w@mail.gmail.com>
In-Reply-To: <CAPcyv4gQNPNOmSVrp7epS5_10qLUuGbutQ2xz7LXnpEhkWeA_w@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Jun 2020 18:21:30 +0200
Message-ID: <CAJZ5v0g-TSk+7d-b0j5THeNtuSDeSJmKZHcG3mBesVZgkCyJOg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: Drop rcu usage for MMIO mappings
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: Q6PNBOHCIIBFZYMRXSJ4LXEH7FNCG7GR
X-Message-ID-Hash: Q6PNBOHCIIBFZYMRXSJ4LXEH7FNCG7GR
X-MailFrom: rjwysocki@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Stable <stable@vger.kernel.org>, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Erik Kaneda <erik.kaneda@intel.com>, Myron Stowe <myron.stowe@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Q6PNBOHCIIBFZYMRXSJ4LXEH7FNCG7GR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jun 5, 2020 at 6:18 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, Jun 5, 2020 at 6:32 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Fri, May 8, 2020 at 1:55 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > Recently a performance problem was reported for a process invoking a
> > > non-trival ASL program. The method call in this case ends up
> > > repetitively triggering a call path like:
> > >
> > >     acpi_ex_store
> > >     acpi_ex_store_object_to_node
> > >     acpi_ex_write_data_to_field
> > >     acpi_ex_insert_into_field
> > >     acpi_ex_write_with_update_rule
> > >     acpi_ex_field_datum_io
> > >     acpi_ex_access_region
> > >     acpi_ev_address_space_dispatch
> > >     acpi_ex_system_memory_space_handler
> > >     acpi_os_map_cleanup.part.14
> > >     _synchronize_rcu_expedited.constprop.89
> > >     schedule
> > >
> > > The end result of frequent synchronize_rcu_expedited() invocation is
> > > tiny sub-millisecond spurts of execution where the scheduler freely
> > > migrates this apparently sleepy task. The overhead of frequent scheduler
> > > invocation multiplies the execution time by a factor of 2-3X.
> > >
> > > For example, performance improves from 16 minutes to 7 minutes for a
> > > firmware update procedure across 24 devices.
> > >
> > > Perhaps the rcu usage was intended to allow for not taking a sleeping
> > > lock in the acpi_os_{read,write}_memory() path which ostensibly could be
> > > called from an APEI NMI error interrupt?
> >
> > Not really.
> >
> > acpi_os_{read|write}_memory() end up being called from non-NMI
> > interrupt context via acpi_hw_{read|write}(), respectively, and quite
> > obviously ioremap() cannot be run from there, but in those cases the
> > mappings in question are there in the list already in all cases and so
> > the ioremap() isn't used then.
> >
> > RCU is there to protect these users from walking the list while it is
> > being updated.
> >
> > > Neither rcu_read_lock() nor ioremap() are interrupt safe, so add a WARN_ONCE() to validate that rcu
> > > was not serving as a mechanism to avoid direct calls to ioremap().
> >
> > But it would produce false-positives if the IRQ context was not NMI,
> > wouldn't it?
> >
> > > Even the original implementation had a spin_lock_irqsave(), but that is not
> > > NMI safe.
> >
> > Which is not a problem (see above).
> >
> > > APEI itself already has some concept of avoiding ioremap() from
> > > interrupt context (see erst_exec_move_data()), if the new warning
> > > triggers it means that APEI either needs more instrumentation like that
> > > to pre-emptively fail, or more infrastructure to arrange for pre-mapping
> > > the resources it needs in NMI context.
> >
> > Well, I'm not sure about that.
>
> Right, this patch set is about 2-3 generations behind the architecture
> of the fix we are discussing internally, you might mention that.

Yes, sorry.

> The fix we are looking at now is to pre-map operation regions in a
> similar manner as the way APEI resources are pre-mapped. The
> pre-mapping would arrange for synchronize_rcu_expedited() to be elided
> on each dynamic mapping attempt. The other piece is to arrange for
> operation-regions to be mapped at their full size at once rather than
> a page at a time.

However, if the RCU usage in ACPI OSL can be replaced with an rwlock,
some of the ACPICA changes above may not be necessary anymore (even
though some of them may still be worth making).
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

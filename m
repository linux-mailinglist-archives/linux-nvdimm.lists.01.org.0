Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD541EFD64
	for <lists+linux-nvdimm@lfdr.de>; Fri,  5 Jun 2020 18:18:26 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 183581009F038;
	Fri,  5 Jun 2020 09:13:13 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::644; helo=mail-ej1-x644.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C14CD1009F036
	for <linux-nvdimm@lists.01.org>; Fri,  5 Jun 2020 09:13:10 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id l27so10758173ejc.1
        for <linux-nvdimm@lists.01.org>; Fri, 05 Jun 2020 09:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vpo49UJFTmSx2mVUsrH28W7y/nNRaB3b36oLAS+p92Q=;
        b=aHJYJsMb22tG8d+gaPHApZ/tpiU+Utl/q5ezXcD7IBh6i14VFMTNAn3iKGTYzl9+oZ
         fXMlTcG2luZhZla1FdD+RJp2R5ShgCq/lzOj9Uild832J5HmD4Oe5Zcn4qTJ9D1sFJ5R
         o61nFJEdB/JCfG1Rr5kUUl7T//qEt2dyJp/hBhG96v7ghOCEzSJ7nyY+SMoxHw4YSR38
         weJDn3jbdMQH4CUxySkqrBPY1tGSS0up8IS6usWN93qdJbFSHWZJSJpz5gHU9EDb+I9N
         8xc4edyapwLnCSTxPiYhIu1JUw26ZUqPTrCzMGqqXVPXT44/qpynOg2FUMaXC8dpB2n/
         HoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vpo49UJFTmSx2mVUsrH28W7y/nNRaB3b36oLAS+p92Q=;
        b=U7Uqyo3cvseKfLxPx6qRpCwpNqZpslaro+/gKB3Ld2z6t40rlmy8Xsi96BPDSYPYg/
         astFmZop4sC5kJiIYKB2X+OQ9Z0hsZfH1oiyfQ2yBVXsm0D8AxYL4qLTCs/WwBg0UHy7
         vkDIrN0ISW/aI5pk1czxZWi//0vZ43rUr8J69HQFRvl9Qc2lEFPfNm4t7Um/0Zeyid0L
         QoM0ESnc0e+tyXjbRuX79ValmtWLFbTF8xkYLYLXxpBMlPoxGcm2KAvMhpoYp+z/YEka
         t8l6GpbvB9bQGqYFXGYhdQc4fR50JFWOzccYWBsJVqbB4wx2/ijXQ2yU+Gkdm0UFt/CP
         Scsg==
X-Gm-Message-State: AOAM530ZX1TA6HYyFF94BdZ4VyfeJ9D496W4kTkmgQDj5KVH694A1RjO
	ywagUAUxgzslP3f4FMkpslivrUTW+QV5H5Yk7VDGBA==
X-Google-Smtp-Source: ABdhPJw1DRbILjMBDs/PGCB8WikMVjkwtv8vwPKMzkgz902Ioiz5SZnc1WlrFrqZ7fC4TSn++yU0F1pQ9TBruhSDbsQ=
X-Received: by 2002:a17:906:bcfc:: with SMTP id op28mr4055950ejb.237.1591373900985;
 Fri, 05 Jun 2020 09:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAJZ5v0gq55A7880dOJD7skwx7mnjsqbCqEGFvEo552U9W2zH3Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0gq55A7880dOJD7skwx7mnjsqbCqEGFvEo552U9W2zH3Q@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 5 Jun 2020 09:18:09 -0700
Message-ID: <CAPcyv4gQNPNOmSVrp7epS5_10qLUuGbutQ2xz7LXnpEhkWeA_w@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: Drop rcu usage for MMIO mappings
To: "Rafael J. Wysocki" <rafael@kernel.org>
Message-ID-Hash: WXHBAY5DF3MW7MGSNFN7BRYGEI2QFQV2
X-Message-ID-Hash: WXHBAY5DF3MW7MGSNFN7BRYGEI2QFQV2
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Rafael Wysocki <rafael.j.wysocki@intel.com>, Stable <stable@vger.kernel.org>, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Erik Kaneda <erik.kaneda@intel.com>, Myron Stowe <myron.stowe@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WXHBAY5DF3MW7MGSNFN7BRYGEI2QFQV2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jun 5, 2020 at 6:32 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, May 8, 2020 at 1:55 AM Dan Williams <dan.j.williams@intel.com> wrote:
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
> > called from an APEI NMI error interrupt?
>
> Not really.
>
> acpi_os_{read|write}_memory() end up being called from non-NMI
> interrupt context via acpi_hw_{read|write}(), respectively, and quite
> obviously ioremap() cannot be run from there, but in those cases the
> mappings in question are there in the list already in all cases and so
> the ioremap() isn't used then.
>
> RCU is there to protect these users from walking the list while it is
> being updated.
>
> > Neither rcu_read_lock() nor ioremap() are interrupt safe, so add a WARN_ONCE() to validate that rcu
> > was not serving as a mechanism to avoid direct calls to ioremap().
>
> But it would produce false-positives if the IRQ context was not NMI,
> wouldn't it?
>
> > Even the original implementation had a spin_lock_irqsave(), but that is not
> > NMI safe.
>
> Which is not a problem (see above).
>
> > APEI itself already has some concept of avoiding ioremap() from
> > interrupt context (see erst_exec_move_data()), if the new warning
> > triggers it means that APEI either needs more instrumentation like that
> > to pre-emptively fail, or more infrastructure to arrange for pre-mapping
> > the resources it needs in NMI context.
>
> Well, I'm not sure about that.

Right, this patch set is about 2-3 generations behind the architecture
of the fix we are discussing internally, you might mention that.

The fix we are looking at now is to pre-map operation regions in a
similar manner as the way APEI resources are pre-mapped. The
pre-mapping would arrange for synchronize_rcu_expedited() to be elided
on each dynamic mapping attempt. The other piece is to arrange for
operation-regions to be mapped at their full size at once rather than
a page at a time.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

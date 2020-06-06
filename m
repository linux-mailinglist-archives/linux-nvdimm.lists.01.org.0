Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB271F0585
	for <lists+linux-nvdimm@lfdr.de>; Sat,  6 Jun 2020 08:56:41 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 957CD1009EA3B;
	Fri,  5 Jun 2020 23:56:39 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.210.65; helo=mail-ot1-f65.google.com; envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1F2E81009EA39
	for <linux-nvdimm@lists.01.org>; Fri,  5 Jun 2020 23:56:38 -0700 (PDT)
Received: by mail-ot1-f65.google.com with SMTP id k15so9497315otp.8
        for <linux-nvdimm@lists.01.org>; Fri, 05 Jun 2020 23:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NQUek8YBI/Ra2tT9dStFeBAAq+j/b7SMm32naih+7IE=;
        b=NqslYFPi3GUfWISIO/2yaNOyFNfBBNfMC4wk99pi7WsePllrVmsMwitXzBYLYNVc46
         pG9so3HsYITY2NlqESAfvqlvU722/h0hY4FIxuag1e6RR25sQn97sVUAiPXPRkO9681o
         Lwly3fwr0JESTV0AlbSdPeAWZg4eHt/97oILY8CAVdQ2rqwaszK5gXObS9Bdb3QDkRee
         xcWmi9lLLXS2pubVGRfbKx7os7CcrRvy+1n/qv4qOp2zsnPQ0/PFR8yvLoVlNEZY7G5g
         rvYqpFVfU1Ma5Yl/Vm4lgJSdF/71UpGS3Qby6q1YDep7eSTu+MvFtjYnsp06HGHb9kAP
         /Bww==
X-Gm-Message-State: AOAM5338VZpxrWfxarWTx7P05BtE+fG1ewVELvDc0+aCqx6538FTUcRG
	mLRO60q1bVpmgaxPHX7LyNOrpIudohpnpicknaE=
X-Google-Smtp-Source: ABdhPJy5G9cnRHYIUiUNNY9zRXhvU1FrRDkIKTt5EqvrkkpoPAAkazH16Q+MOIvluty4GDmy6mdsJACPkDR8keWm4k0=
X-Received: by 2002:a9d:39f5:: with SMTP id y108mr3763834otb.262.1591426597228;
 Fri, 05 Jun 2020 23:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <2643462.teTRrieJB7@kreacher> <CAPcyv4hWLKP7fdLhWLn8vxf5rJKvKyU0yLfDs0XMjW-9U9tM-g@mail.gmail.com>
In-Reply-To: <CAPcyv4hWLKP7fdLhWLn8vxf5rJKvKyU0yLfDs0XMjW-9U9tM-g@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 6 Jun 2020 08:56:26 +0200
Message-ID: <CAJZ5v0gAJyCi4YiVP4LuH3sCBWMArODDxkjKqk28Svug1+bTtw@mail.gmail.com>
Subject: Re: [RFT][PATCH] ACPI: OSL: Use rwlock instead of RCU for memory management
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: 3HXZ7U2M55TWCACKMSIYAS4DT7Y63GVN
X-Message-ID-Hash: 3HXZ7U2M55TWCACKMSIYAS4DT7Y63GVN
X-MailFrom: rjwysocki@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, stable <stable@vger.kernel.org>, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Erik Kaneda <erik.kaneda@intel.com>, Myron Stowe <myron.stowe@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3HXZ7U2M55TWCACKMSIYAS4DT7Y63GVN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jun 5, 2020 at 7:09 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, Jun 5, 2020 at 7:06 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Subject: [PATCH] ACPI: OSL: Use rwlock instead of RCU for memory management
> >
> > The ACPI OS layer uses RCU to protect the list of ACPI memory
> > mappings from being walked while it is updated.  Among other
> > situations, that list can be walked in non-NMI interrupt context,
> > so using a sleeping lock to protect it is not an option.
> >
> > However, performance issues related to the RCU usage in there
> > appear, as described by Dan Williams:
> >
> > "Recently a performance problem was reported for a process invoking
> > a non-trival ASL program. The method call in this case ends up
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
> > migrates this apparently sleepy task. The overhead of frequent
> > scheduler invocation multiplies the execution time by a factor
> > of 2-3X."
> >
> > In order to avoid these issues, replace the RCU in the ACPI OS
> > layer by an rwlock.
> >
> > That rwlock should not be frequently contended, so the performance
> > impact of it is not expected to be significant.
> >
> > Reported-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > Hi Dan,
> >
> > This is a possible fix for the ACPI OSL RCU-related performance issues, but
> > can you please arrange for the testing of it on the affected systems?
>
> Ugh, is it really this simple? I did not realize the read-side is NMI
> safe. I'll take a look.

But if an NMI triggers while the lock is being held for writing, it
will deadlock, won't it?

OTOH, according to the RCU documentation it is valid to call
rcu_read_[un]lock() from an NMI handler (see Interrupts and NMIs in
Documentation/RCU/Design/Requirements/Requirements.rst) so we are good
from this perspective today.

Unless we teach APEI to avoid mapping lookups from
apei_{read|write}(), which wouldn't be unreasonable by itself, we need
to hold on to the RCU in ACPI OSL, so it looks like addressing the
problem in ACPICA is the best way to do it (and the current ACPICA
code in question is suboptimal, so it would be good to rework it
anyway).

Cheers!
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A851EFE6F
	for <lists+linux-nvdimm@lfdr.de>; Fri,  5 Jun 2020 19:02:40 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 838231009F039;
	Fri,  5 Jun 2020 09:57:26 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.210.66; helo=mail-ot1-f66.google.com; envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E30F41009F036
	for <linux-nvdimm@lists.01.org>; Fri,  5 Jun 2020 09:57:23 -0700 (PDT)
Received: by mail-ot1-f66.google.com with SMTP id o13so8148181otl.5
        for <linux-nvdimm@lists.01.org>; Fri, 05 Jun 2020 10:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wTZiSOR+igC/gRCry3GVm0Zp9Ahw3ee9N7yu1QHMPRc=;
        b=MuI6tG8Gqn6sR/MBfW7NMZV1aM9kjLL2Is1LvyQq5bLkreLtSMt3oPXq+ZGnJAPi/Y
         +qxGTExxjf/4NA9VjUauLm4ikYtb060Ntj0QuxPV+RLZ8IVqMt+J3oITRHWgTc49fGGt
         7PDLW34QFHsRZCcgv3Y7LzCSvAfkOM4XBGs9VJ6TJdGlLD/gPLunVprs5wHaFlNNZJUX
         NayH1gXPLwusfKnenvcDZdFRkNAhFYlVmlxmJKCHl1L/7EkDwyj+c5e9QYNITy2bmQ0X
         Y4oBbPfZchPSdMqdIO2KMrRtIWgRc0TLRNul1Q8eehAM8CdYISJbLdz2PHLGKsnXSolI
         fiIg==
X-Gm-Message-State: AOAM531qv7WdmpVej2pot0mGW3FYzeGM9jFaEeH8eOKU5o16oxrhUGJE
	q6RelT6eE7UTyO2ckFCHSsVq6Om16xvM4VTNuCE=
X-Google-Smtp-Source: ABdhPJwS8cBnOQWNPzEMxfpCbrXxhygVWp3mt32v/HYym+XE4ggBkygQ0R0aKSiHguylxsBfEP6pBBRYzxoafwh8WA0=
X-Received: by 2002:a05:6830:20d1:: with SMTP id z17mr7997880otq.167.1591376555389;
 Fri, 05 Jun 2020 10:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAJZ5v0gq55A7880dOJD7skwx7mnjsqbCqEGFvEo552U9W2zH3Q@mail.gmail.com>
 <CAPcyv4gQNPNOmSVrp7epS5_10qLUuGbutQ2xz7LXnpEhkWeA_w@mail.gmail.com>
 <CAJZ5v0g-TSk+7d-b0j5THeNtuSDeSJmKZHcG3mBesVZgkCyJOg@mail.gmail.com> <CAPcyv4iECAzRjAUJ1hymOzZRjBYQ_baFrSz=2ah=2pfehn9S_g@mail.gmail.com>
In-Reply-To: <CAPcyv4iECAzRjAUJ1hymOzZRjBYQ_baFrSz=2ah=2pfehn9S_g@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Jun 2020 19:02:24 +0200
Message-ID: <CAJZ5v0iAwDpFYgOa+1=7_wdt4jHVftzS-o=xTJzJSVjceqhzwQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: Drop rcu usage for MMIO mappings
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: J7KHQVEPAU4RXFGSLJM663JIYDRBAUNW
X-Message-ID-Hash: J7KHQVEPAU4RXFGSLJM663JIYDRBAUNW
X-MailFrom: rjwysocki@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Stable <stable@vger.kernel.org>, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Erik Kaneda <erik.kaneda@intel.com>, Myron Stowe <myron.stowe@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/J7KHQVEPAU4RXFGSLJM663JIYDRBAUNW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jun 5, 2020 at 6:39 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, Jun 5, 2020 at 9:22 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> [..]
> > > The fix we are looking at now is to pre-map operation regions in a
> > > similar manner as the way APEI resources are pre-mapped. The
> > > pre-mapping would arrange for synchronize_rcu_expedited() to be elided
> > > on each dynamic mapping attempt. The other piece is to arrange for
> > > operation-regions to be mapped at their full size at once rather than
> > > a page at a time.
> >
> > However, if the RCU usage in ACPI OSL can be replaced with an rwlock,
> > some of the ACPICA changes above may not be necessary anymore (even
> > though some of them may still be worth making).
>
> I don't think you can replace the RCU usage in ACPI OSL and still
> maintain NMI lookups in a dynamic list.

I'm not sure what NMI lookups have to do with the issue at hand.

If acpi_os_{read|write}_memory() is used from NMI, that is a bug
already in there which is unrelated to the performance problem with
opregions.

> However, there are 3 solutions I see:
>
> - Prevent acpi_os_map_cleanup() from triggering at high frequency by
> pre-mapping and never unmapping operation-regions resources (internal
> discussion in progress)

Yes, that can be done, if necessary.

> - Prevent walks of the 'acpi_ioremaps' list (acpi_map_lookup_virt())
> from NMI context by re-writing the physical addresses in the APEI
> tables with pre-mapped virtual address, i.e. remove rcu_read_lock()
> and list_for_each_entry_rcu() from NMI context.

That sounds a bit convoluted to me.

> - Split operation-region resources into a separate mapping mechanism
> than APEI resources so that typical locking can be used for the
> sleepable resources and let the NMI accessible resources be managed
> separately.
>
> That last one is one we have not discussed internally, but it occurred
> to me when you mentioned replacing RCU.

So NMI cannot use acpi_os_{read|write}_memory() safely which you have
pointed out for a few times.

But even if NMI resources are managed separately, the others will
still not be sleepable (at least not all of them).

Cheers!
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

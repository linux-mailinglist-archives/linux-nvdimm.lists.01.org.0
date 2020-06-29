Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C3F20CE9A
	for <lists+linux-nvdimm@lfdr.de>; Mon, 29 Jun 2020 15:02:52 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 69C7A111AFBAD;
	Mon, 29 Jun 2020 06:02:49 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.210.66; helo=mail-ot1-f66.google.com; envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9B640111AFBAB
	for <linux-nvdimm@lists.01.org>; Mon, 29 Jun 2020 06:02:47 -0700 (PDT)
Received: by mail-ot1-f66.google.com with SMTP id d4so15397579otk.2
        for <linux-nvdimm@lists.01.org>; Mon, 29 Jun 2020 06:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7nlhWJJwNwhWkeMdSwXObsiOh2VHz3Q74vTd3L4F/E4=;
        b=a/ce2kzwRv9GrY+M7m2L+t6HNLNmkIu+lEuk4Uie8P3DfEftgZR/tyZEr2wcnhK3Vy
         0RAW1XXtVBnr+aLWNl0ImNAkga2/WUOWHRhtuour2BaKGlkst44stFdjPe+GRjN0Rhyz
         LPHou+bjZEgnXk0kqsoZ/vsr9LQUIhNffkThC5dbDf2fHEJXwazT7aWv/K+OZpkU9Yqn
         7GMZgSxxwpkshlV4E0Eqn89ozLie3KXiF1BUuiaQ3xU0HpiPCJNEpDjk+znFOhyBiyx2
         +NkedGVzCAFOlkDzXNL9Tke7KKON9o4B1h6UEtsZkgYVGv1EM++SHgE4sVUZXjpkEApj
         8asw==
X-Gm-Message-State: AOAM533l1uFiU2TrDx35vVFW5HsL2HJq0Mb12yI2w4XdLg/oShcKlW4S
	iwkGB1b9O8b0DGuqiT6UG0mJykfqloCesOiZ4YM=
X-Google-Smtp-Source: ABdhPJzIQwbdDVQsoe/mDFdG+UuqRokNsn9twuQiuHEM1ZLnII4nXYOarqbPDTLCqJLyUEpbS+m1QKmIfJ6D/m1WVN0=
X-Received: by 2002:a9d:7d15:: with SMTP id v21mr12817982otn.118.1593435766462;
 Mon, 29 Jun 2020 06:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <2713141.s8EVnczdoM@kreacher> <13749323.0m2ImmhSHx@kreacher> <MWHPR11MB1599FBA57730E5C74B9B4588F0930@MWHPR11MB1599.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB1599FBA57730E5C74B9B4588F0930@MWHPR11MB1599.namprd11.prod.outlook.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 29 Jun 2020 15:02:31 +0200
Message-ID: <CAJZ5v0iXzYVb6RAR9p2mH=RjSjo4c9g39T7uaccXMm6uoLWDzw@mail.gmail.com>
Subject: Re: [RFT][PATCH v2 3/4] ACPICA: Preserve memory opregion mappings if
 supported by OS
To: "Kaneda, Erik" <erik.kaneda@intel.com>
Message-ID-Hash: VWJG6426JVC3LG5W6SSABDMYFZLCWOPT
X-Message-ID-Hash: VWJG6426JVC3LG5W6SSABDMYFZLCWOPT
X-MailFrom: rjwysocki@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Myron Stowe <myron.stowe@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VWJG6426JVC3LG5W6SSABDMYFZLCWOPT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Jun 27, 2020 at 12:53 AM Kaneda, Erik <erik.kaneda@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Sent: Monday, June 22, 2020 7:02 AM
> > To: Williams, Dan J <dan.j.williams@intel.com>; Kaneda, Erik
> > <erik.kaneda@intel.com>
> > Cc: Wysocki, Rafael J <rafael.j.wysocki@intel.com>; Len Brown
> > <lenb@kernel.org>; Borislav Petkov <bp@alien8.de>; Weiny, Ira
> > <ira.weiny@intel.com>; James Morse <james.morse@arm.com>; Myron
> > Stowe <myron.stowe@redhat.com>; Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com>; linux-kernel@vger.kernel.org; linux-
> > acpi@vger.kernel.org; linux-nvdimm@lists.01.org; Moore, Robert
> > <robert.moore@intel.com>
> > Subject: [RFT][PATCH v2 3/4] ACPICA: Preserve memory opregion mappings
> > if supported by OS
> >
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > The ACPICA's strategy with respect to the handling of memory mappings
> > associated with memory operation regions is to avoid mapping the
> > entire region at once which may be problematic at least in principle
> > (for example, it may lead to conflicts with overlapping mappings
> > having different attributes created by drivers).  It may also be
> > wasteful, because memory opregions on some systems take up vast
> > chunks of address space while the fields in those regions actually
> > accessed by AML are sparsely distributed.
> >
> > For this reason, a one-page "window" is mapped for a given opregion
> > on the first memory access through it and if that "window" does not
> > cover an address range accessed through that opregion subsequently,
> > it is unmapped and a new "window" is mapped to replace it.  Next,
> > if the new "window" is not sufficient to access memory through the
> > opregion in question in the future, it will be replaced with yet
> > another "window" and so on.  That may lead to a suboptimal sequence
> > of memory mapping and unmapping operations, for example if two fields
> > in one opregion separated from each other by a sufficiently wide
> > chunk of unused address space are accessed in an alternating pattern.
> >
> > The situation may still be suboptimal if the deferred unmapping
> > introduced previously is supported by the OS layer.  For instance,
> > the alternating memory access pattern mentioned above may produce
> > a relatively long list of mappings to release with substantial
> > duplication among the entries in it, which could be avoided if
> > acpi_ex_system_memory_space_handler() did not release the mapping
> > used by it previously as soon as the current access was not covered
> > by it.
> >
> > In order to improve that, modify acpi_ex_system_memory_space_handler()
> > to take advantage of the memory mappings reference counting at the OS
> > level if a suitable interface is provided.
> >
> Hi,
>
> > Namely, if ACPI_USE_FAST_PATH_MAPPING is set, the OS is expected to
> > implement acpi_os_map_memory_fast_path() that will return NULL if
> > there is no mapping covering the given address range known to it.
> > If such a mapping is there, however, its reference counter will be
> > incremented and a pointer representing the requested virtual address
> > will be returned right away without any additional consequences.
>
> I do not fully understand why this is under a #ifdef. Is this to support operating systems that might not want to add support for this behavior?

Yes, and to protect the ones that have not added support for it just yet.

Without the "fast-path" mapping support, ACPICA has no way to obtain
additional references to known-existing mappings and the new code
won't work as expected without it, so it is better to avoid building
that code at all in those cases IMO.

> Also, instead of using the terminology fast_path, I think it would be easier to use terminology that describes the mechanism..
> It might be easier for other Operating systems to understand something like acpi_os_map_preserved_memory or acpi_os_map_sysmem_opregion_memory.

Well, the naming is not particularly important to me to be honest, but
this is mostly about being able to get a new reference to a
known-existing memory mapping.

So something like acpi_os_ref_memory_map() perhaps?

But I'm thinking that this can be implemented without the "fast-path"
mapping support too, let me try to do that.

Cheers!
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

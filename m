Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 292AD2253A4
	for <lists+linux-nvdimm@lfdr.de>; Sun, 19 Jul 2020 21:14:42 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1D8E31232CAD5;
	Sun, 19 Jul 2020 12:14:40 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.210.67; helo=mail-ot1-f67.google.com; envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5E94A116BF606
	for <linux-nvdimm@lists.01.org>; Sun, 19 Jul 2020 12:14:36 -0700 (PDT)
Received: by mail-ot1-f67.google.com with SMTP id h13so10601231otr.0
        for <linux-nvdimm@lists.01.org>; Sun, 19 Jul 2020 12:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/vgePeYsDGdOfYJ+zrhF6ulRCJSEh7r7GG7PhUNcyLQ=;
        b=E4Nt73xL9gYwx5Z9tU99RPbzsTqRCR7JV327XrqqhpoeJiM8cFkQIuVrKeTnvtlOlE
         DZ+O0DjnI0M4qq9funqKDPFm3CpTGitoER8ukhw13q+aMuEb1ci53T8kBLHgSgmeZtPP
         x4tDaEneSEozBsId4ZaNXokQaFaE4xepY/L2gtDr8Gw0yGGHlRR3J+RByDJmom6tBF66
         Dfxji+ygflif17HP9euiTpWt77GZYpJ87pa69IfrR/WejMPZTtinL2o643jR6P+yJ+G1
         zAEk/zuP2n85BcT1rVPH2XD9fad1uZBj1o1uGqYcnxQPKfTXE12iMjkV9N3l7myhy0Y4
         zhXA==
X-Gm-Message-State: AOAM532LbdPVu1PxXGmcW9vjmzwkntjlpOdZIEIzAK6zjHAIjAy2S0Ca
	+wS0XarUMJt70twCzhnkdjyRxg8lc1DnFs9BN0E=
X-Google-Smtp-Source: ABdhPJwNclm9vK0RlcGozdCrMYwS4qEdXErvuUT3XWaBD09UNJEHHHmrT266kjioUmRdyYj0HIAkNxsHHJ4QFXCh6OE=
X-Received: by 2002:a9d:590a:: with SMTP id t10mr17201578oth.262.1595186075072;
 Sun, 19 Jul 2020 12:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <2788992.3K7huLjdjL@kreacher> <1666722.UopIai5n7p@kreacher>
 <1794490.F2OrUDcHQn@kreacher> <1738949fd49e9804722bf82d790e3022fc714677.camel@intel.com>
In-Reply-To: <1738949fd49e9804722bf82d790e3022fc714677.camel@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 19 Jul 2020 21:14:23 +0200
Message-ID: <CAJZ5v0ga+j4iK7oTbkFPDmN=UpUMHfbmQMyBnP-LvG-xSj50kQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] ACPICA: Preserve memory opregion mappings
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Message-ID-Hash: PU6KFAWJOTBHP34ICACXDOXT246OFJ3U
X-Message-ID-Hash: PU6KFAWJOTBHP34ICACXDOXT246OFJ3U
X-MailFrom: rjwysocki@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Kaneda, Erik" <erik.kaneda@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "james.morse@arm.com" <james.morse@arm.com>, "lenb@kernel.org" <lenb@kernel.org>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "myron.stowe@redhat.com" <myron.stowe@redhat.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PU6KFAWJOTBHP34ICACXDOXT246OFJ3U/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jul 16, 2020 at 9:22 PM Verma, Vishal L
<vishal.l.verma@intel.com> wrote:
>
> On Mon, 2020-06-29 at 18:33 +0200, Rafael J. Wysocki wrote:
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
> > if the new "window" is not sufficient to acess memory through the
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
> > to preserve all of the memory mappings created by it until the memory
> > regions associated with them go away.
> >
> > Accordingly, update acpi_ev_system_memory_region_setup() to unmap all
> > memory associated with memory opregions that go away.
> >
> > Reported-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/acpi/acpica/evrgnini.c | 14 ++++----
> >  drivers/acpi/acpica/exregion.c | 65 ++++++++++++++++++++++++----------
> >  include/acpi/actypes.h         | 12 +++++--
> >  3 files changed, 64 insertions(+), 27 deletions(-)
> >
>
> Hi Rafael,
>
> Picking up from Dan while he's out - I had these patches tested by the
> original reporter, and they work fine. I see you had them staged in the
> acpica-osl branch. Is that slated to go in during the 5.9 merge window?

Yes, it is.

> You can add:
> Tested-by: Xiang Li <xiang.z.li@intel.com>

Thank you!
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

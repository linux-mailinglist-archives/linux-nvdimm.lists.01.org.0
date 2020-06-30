Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D637F20FD20
	for <lists+linux-nvdimm@lfdr.de>; Tue, 30 Jun 2020 21:57:15 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 390EF111FF494;
	Tue, 30 Jun 2020 12:57:14 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.61; helo=us-smtp-delivery-1.mimecast.com; envelope-from=ahs3@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [205.139.110.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D92C5111F92BE
	for <linux-nvdimm@lists.01.org>; Tue, 30 Jun 2020 12:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1593547029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8peczmOjkvXgzXVhg5q0ss4VmbvHVfsXM1bbPnSBRlo=;
	b=GcOoWCraJ3RWkVPBgvtvgcVdsRAKTsdneCS7oVW+K+lccnv3WVOOZOKTi5cSDMv82bj2Zu
	fHZQVoUlnmHK0M7ZtOoH9SRc1QfRTnCDhqujvnSnolbT3hvHF+Xc3c5ZfXmUOWqxE1W58n
	JIDzxYTYtjbbFaiV9A3XoImtbmKFOLU=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-TUrKjn0SPOCF-6rl7MFRpw-1; Tue, 30 Jun 2020 15:57:07 -0400
X-MC-Unique: TUrKjn0SPOCF-6rl7MFRpw-1
Received: by mail-ot1-f71.google.com with SMTP id 10so6733476otp.20
        for <linux-nvdimm@lists.01.org>; Tue, 30 Jun 2020 12:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8peczmOjkvXgzXVhg5q0ss4VmbvHVfsXM1bbPnSBRlo=;
        b=lgTnAOxY+wsMX8P8xGat1qfsiz02EONTe/cQF+J15YWTIJDy/d1RWv8PMws9l/PDKM
         IWaNO6vX2zia61AW/lrtZYaxmw5016gwOg7SRNz8aWpvEqDsVdsqgKN1v6E7r+MrvinN
         gorISZSlKHf1eGPx5+YVim/a7ErrbakE9X59FOCgzGen6dNGklto9e8lOzP2lsLY6JI7
         mV98qich3Jll7DY1CslgoFiU4s7vohGkij8mWypsRcz2avz/k2EhIKKYk/kFhqA9H1oJ
         it/5TUVmxfMLTlT4zu92d5nB0PxgP7hB70FDLQxpZ5WGXlktsb22Fh8PFF7Nb2PRR6rd
         HrkQ==
X-Gm-Message-State: AOAM532z/Ccb03bWoHi/pvNfzNcrTttcJRMOI3u+5UJSi+stMIoZr7FQ
	yRQ6VR5rOHhtU85kW8U1Z4Y0GnWWj7X3+P/ErzvNu/gu8B9/hbDthip8IWuRxwmUPuv6lF40gNl
	vKdsYg0CkLOmLYrgEkEqc
X-Received: by 2002:aca:a905:: with SMTP id s5mr6028052oie.109.1593547026197;
        Tue, 30 Jun 2020 12:57:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzx+iWq7sqw0t2cpyoH4JTi7Pv74IcQOJpIyoHS5aapIUo/dHxUgKnBSWYDO0pdHqwtlLRLDw==
X-Received: by 2002:aca:a905:: with SMTP id s5mr6027978oie.109.1593547023682;
        Tue, 30 Jun 2020 12:57:03 -0700 (PDT)
Received: from localhost (c-67-165-232-89.hsd1.co.comcast.net. [67.165.232.89])
        by smtp.gmail.com with ESMTPSA id i24sm950519oov.11.2020.06.30.12.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 12:57:03 -0700 (PDT)
Date: Tue, 30 Jun 2020 13:57:02 -0600
From: Al Stone <ahs3@redhat.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 2/2] ACPICA: Preserve memory opregion mappings
Message-ID: <20200630195702.GV1237914@redhat.com>
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <2788992.3K7huLjdjL@kreacher>
 <1666722.UopIai5n7p@kreacher>
 <1794490.F2OrUDcHQn@kreacher>
 <20200629205708.GK1237914@redhat.com>
 <CAJZ5v0hiAVfgWTLcP2N5PWLsqL7mpHbuL1_de79svYYhd3R57A@mail.gmail.com>
 <20200630153127.GP1237914@redhat.com>
 <CAJZ5v0hpe2pB76h=p+E4GpOFrDAP5ZGrreyQ-QVtga=08HQNUA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hpe2pB76h=p+E4GpOFrDAP5ZGrreyQ-QVtga=08HQNUA@mail.gmail.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ahs3@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Message-ID-Hash: U3MOWYE7JGE4CS5SZIGFXPUGL3IOG6T4
X-Message-ID-Hash: U3MOWYE7JGE4CS5SZIGFXPUGL3IOG6T4
X-MailFrom: ahs3@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Erik Kaneda <erik.kaneda@intel.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Myron Stowe <myron.stowe@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Bob Moore <robert.moore@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/U3MOWYE7JGE4CS5SZIGFXPUGL3IOG6T4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 30 Jun 2020 17:52, Rafael J. Wysocki wrote:
> On Tue, Jun 30, 2020 at 5:31 PM Al Stone <ahs3@redhat.com> wrote:
> >
> > On 30 Jun 2020 13:44, Rafael J. Wysocki wrote:
> > > On Mon, Jun 29, 2020 at 10:57 PM Al Stone <ahs3@redhat.com> wrote:
> > > >
> > > > On 29 Jun 2020 18:33, Rafael J. Wysocki wrote:
> > > > > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > > > >
> > > > > The ACPICA's strategy with respect to the handling of memory mappings
> > > > > associated with memory operation regions is to avoid mapping the
> > > > > entire region at once which may be problematic at least in principle
> > > > > (for example, it may lead to conflicts with overlapping mappings
> > > > > having different attributes created by drivers).  It may also be
> > > > > wasteful, because memory opregions on some systems take up vast
> > > > > chunks of address space while the fields in those regions actually
> > > > > accessed by AML are sparsely distributed.
> > > > >
> > > > > For this reason, a one-page "window" is mapped for a given opregion
> > > > > on the first memory access through it and if that "window" does not
> > > > > cover an address range accessed through that opregion subsequently,
> > > > > it is unmapped and a new "window" is mapped to replace it.  Next,
> > > > > if the new "window" is not sufficient to acess memory through the
> > > > > opregion in question in the future, it will be replaced with yet
> > > > > another "window" and so on.  That may lead to a suboptimal sequence
> > > > > of memory mapping and unmapping operations, for example if two fields
> > > > > in one opregion separated from each other by a sufficiently wide
> > > > > chunk of unused address space are accessed in an alternating pattern.
> > > > >
> > > > > The situation may still be suboptimal if the deferred unmapping
> > > > > introduced previously is supported by the OS layer.  For instance,
> > > > > the alternating memory access pattern mentioned above may produce
> > > > > a relatively long list of mappings to release with substantial
> > > > > duplication among the entries in it, which could be avoided if
> > > > > acpi_ex_system_memory_space_handler() did not release the mapping
> > > > > used by it previously as soon as the current access was not covered
> > > > > by it.
> > > > >
> > > > > In order to improve that, modify acpi_ex_system_memory_space_handler()
> > > > > to preserve all of the memory mappings created by it until the memory
> > > > > regions associated with them go away.
> > > > >
> > > > > Accordingly, update acpi_ev_system_memory_region_setup() to unmap all
> > > > > memory associated with memory opregions that go away.
> > > > >
> > > > > Reported-by: Dan Williams <dan.j.williams@intel.com>
> > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > ---
> > > > >  drivers/acpi/acpica/evrgnini.c | 14 ++++----
> > > > >  drivers/acpi/acpica/exregion.c | 65 ++++++++++++++++++++++++----------
> > > > >  include/acpi/actypes.h         | 12 +++++--
> > > > >  3 files changed, 64 insertions(+), 27 deletions(-)
> > > > >
> > > > > diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
> > > > > index aefc0145e583..89be3ccdad53 100644
> > > > > --- a/drivers/acpi/acpica/evrgnini.c
> > > > > +++ b/drivers/acpi/acpica/evrgnini.c
> > > > > @@ -38,6 +38,7 @@ acpi_ev_system_memory_region_setup(acpi_handle handle,
> > > > >       union acpi_operand_object *region_desc =
> > > > >           (union acpi_operand_object *)handle;
> > > > >       struct acpi_mem_space_context *local_region_context;
> > > > > +     struct acpi_mem_mapping *mm;
> > > > >
> > > > >       ACPI_FUNCTION_TRACE(ev_system_memory_region_setup);
> > > > >
> > > > > @@ -46,13 +47,14 @@ acpi_ev_system_memory_region_setup(acpi_handle handle,
> > > > >                       local_region_context =
> > > > >                           (struct acpi_mem_space_context *)*region_context;
> > > > >
> > > > > -                     /* Delete a cached mapping if present */
> > > > > +                     /* Delete memory mappings if present */
> > > > >
> > > > > -                     if (local_region_context->mapped_length) {
> > > > > -                             acpi_os_unmap_memory(local_region_context->
> > > > > -                                                  mapped_logical_address,
> > > > > -                                                  local_region_context->
> > > > > -                                                  mapped_length);
> > > > > +                     while (local_region_context->first_mm) {
> > > > > +                             mm = local_region_context->first_mm;
> > > > > +                             local_region_context->first_mm = mm->next_mm;
> > > > > +                             acpi_os_unmap_memory(mm->logical_address,
> > > > > +                                                  mm->length);
> > > > > +                             ACPI_FREE(mm);
> > > > >                       }
> > > > >                       ACPI_FREE(local_region_context);
> > > > >                       *region_context = NULL;
> > > > > diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
> > > > > index d15a66de26c0..fd68f2134804 100644
> > > > > --- a/drivers/acpi/acpica/exregion.c
> > > > > +++ b/drivers/acpi/acpica/exregion.c
> > > > > @@ -41,6 +41,7 @@ acpi_ex_system_memory_space_handler(u32 function,
> > > > >       acpi_status status = AE_OK;
> > > > >       void *logical_addr_ptr = NULL;
> > > > >       struct acpi_mem_space_context *mem_info = region_context;
> > > > > +     struct acpi_mem_mapping *mm = mem_info->cur_mm;
> > > > >       u32 length;
> > > > >       acpi_size map_length;
> > > >
> > > > I think this needs to be:
> > > >
> > > >         acpi_size map_length = mem_info->length;
> > > >
> > > > since it now gets used in the ACPI_ERROR() call below.
> > >
> > > No, it's better to print the length value in the message.
> >
> > Yeah, that was the other option.
> >
> > > >  I'm getting a "maybe used unitialized" error on compilation.
> > >
> > > Thanks for reporting!
> > >
> > > I've updated the commit in the acpica-osl branch with the fix.
> >
> > Thanks, Rafael.
> >
> > Do you have a generic way of testing this?  I can see a way to do it
> > -- timing a call of a method in a dynamically loaded SSDT -- but if
> > you had a test case laying around, I could continue to be lazy :).
> 
> I don't check the timing, but instrument the code to see if what
> happens is what is expected.

Ah, okay.  Thanks.

> Now, the overhead reduction resulting from this change in Linux is
> quite straightforward: Every time the current mapping doesn't cover
> the request at hand, an unmap is carried out by the original code,
> which involves a linear search through acpi_ioremaps, and which
> generally is (at least a bit) more expensive than the linear search
> through the list of opregion-specific mappings introduced by the
> $subject patch, because quite likely the acpi_ioremaps list holds more
> items.  And, of course, if the opregion in question holds many fields
> and they are not covered by one mapping, each of them needs to be
> mapped just once per the opregion life cycle.

Right.  What I was debating as a generic test was something to try to
force an OpRegion through mapping and unmapping repeatedly with the
current code to determine a rough average elapsed time.  Then, apply
the patch to see what the change does.  Granted, a completely synthetic
scenario, and specifically designed to exaggerate the overhead, but
I'm just curious.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

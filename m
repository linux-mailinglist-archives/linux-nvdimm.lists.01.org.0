Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2942C20F852
	for <lists+linux-nvdimm@lfdr.de>; Tue, 30 Jun 2020 17:31:38 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7A77E111F3707;
	Tue, 30 Jun 2020 08:31:36 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=ahs3@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C32BF111C7C56
	for <linux-nvdimm@lists.01.org>; Tue, 30 Jun 2020 08:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1593531092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PBKI1wC0EuMeGlMbsqBq9OEOnaCFXkQPIi7EgKbzMjY=;
	b=FITHPolaPaePnODpPoD2ugghgTwlBozXZrpVisyoyYslACWfOvFSr8im0d75s1qDHxIt5y
	seBkvI8DJMhKsp/1sd3jy59Jn7az5CJCW5GxSasiTmxJavWpzfgTM5JxXm13vY3Bupdugs
	23xV3C4K4E8r9AM1RYEP+Tb/X2VsfHM=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-ioP-2MUQNiu3tVKfJ94w-w-1; Tue, 30 Jun 2020 11:31:30 -0400
X-MC-Unique: ioP-2MUQNiu3tVKfJ94w-w-1
Received: by mail-ot1-f71.google.com with SMTP id 40so13375715otc.17
        for <linux-nvdimm@lists.01.org>; Tue, 30 Jun 2020 08:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PBKI1wC0EuMeGlMbsqBq9OEOnaCFXkQPIi7EgKbzMjY=;
        b=FFz6yfdwu3kOU7CkVzWyylOhxWLyZFiGJWPCILNuQObLbYLL2GJe9jx7o+vWfIQGuc
         7Hh0Ml6B8yS/Yjj2zxtG+vRSmDPjzEtF/QGtcaOdMd3Gx8DjPGL7IklhuM+LhMHUBYxk
         urbYlktwZjUKxXkdvr0MpTR7DNw8NgM9alewFju7he8XJOZCJ4ieSb6/Hb9eBKM3hGwO
         s+rp6JxCw76JtndW9JB1ixth10fbawSGxS4zQwR/NUIk8U83LAo//1+TEHQjoEFIAqZI
         r2SzkbjHqJsfPoid33NOzNkOvXPCpzs7AA6xk7YfDANbYL95s1amvXBDXwmtXxvhl8uJ
         +NYg==
X-Gm-Message-State: AOAM531Om/QAsGnsNnXEMHmvDBoCphNNRELEO3ZZBz0gRymzAf6GV/vc
	yNBk961cRbLnykq1qtnczHTfozRaQ9imHWKe8SrBBChiV/OoIyYlrVW5oWX+oX+Jxflx8TBqtc6
	learTGLOdi2EhmeAeF3vj
X-Received: by 2002:a9d:904:: with SMTP id 4mr18989739otp.339.1593531089592;
        Tue, 30 Jun 2020 08:31:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUIjP8aNkaGnNl54laVK9WUVYeVxAerVTjXDpA8fj551U6q8mWoUYLYsFhCJT6XWllk8jyZg==
X-Received: by 2002:a9d:904:: with SMTP id 4mr18989675otp.339.1593531089054;
        Tue, 30 Jun 2020 08:31:29 -0700 (PDT)
Received: from localhost (c-67-165-232-89.hsd1.co.comcast.net. [67.165.232.89])
        by smtp.gmail.com with ESMTPSA id y14sm767795ooq.24.2020.06.30.08.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 08:31:28 -0700 (PDT)
Date: Tue, 30 Jun 2020 09:31:27 -0600
From: Al Stone <ahs3@redhat.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 2/2] ACPICA: Preserve memory opregion mappings
Message-ID: <20200630153127.GP1237914@redhat.com>
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <2788992.3K7huLjdjL@kreacher>
 <1666722.UopIai5n7p@kreacher>
 <1794490.F2OrUDcHQn@kreacher>
 <20200629205708.GK1237914@redhat.com>
 <CAJZ5v0hiAVfgWTLcP2N5PWLsqL7mpHbuL1_de79svYYhd3R57A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hiAVfgWTLcP2N5PWLsqL7mpHbuL1_de79svYYhd3R57A@mail.gmail.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ahs3@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Message-ID-Hash: P7EF6EVJIEQVWRFPVGDDJ5SDUIVD2UGZ
X-Message-ID-Hash: P7EF6EVJIEQVWRFPVGDDJ5SDUIVD2UGZ
X-MailFrom: ahs3@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Erik Kaneda <erik.kaneda@intel.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Myron Stowe <myron.stowe@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Bob Moore <robert.moore@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/P7EF6EVJIEQVWRFPVGDDJ5SDUIVD2UGZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 30 Jun 2020 13:44, Rafael J. Wysocki wrote:
> On Mon, Jun 29, 2020 at 10:57 PM Al Stone <ahs3@redhat.com> wrote:
> >
> > On 29 Jun 2020 18:33, Rafael J. Wysocki wrote:
> > > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > >
> > > The ACPICA's strategy with respect to the handling of memory mappings
> > > associated with memory operation regions is to avoid mapping the
> > > entire region at once which may be problematic at least in principle
> > > (for example, it may lead to conflicts with overlapping mappings
> > > having different attributes created by drivers).  It may also be
> > > wasteful, because memory opregions on some systems take up vast
> > > chunks of address space while the fields in those regions actually
> > > accessed by AML are sparsely distributed.
> > >
> > > For this reason, a one-page "window" is mapped for a given opregion
> > > on the first memory access through it and if that "window" does not
> > > cover an address range accessed through that opregion subsequently,
> > > it is unmapped and a new "window" is mapped to replace it.  Next,
> > > if the new "window" is not sufficient to acess memory through the
> > > opregion in question in the future, it will be replaced with yet
> > > another "window" and so on.  That may lead to a suboptimal sequence
> > > of memory mapping and unmapping operations, for example if two fields
> > > in one opregion separated from each other by a sufficiently wide
> > > chunk of unused address space are accessed in an alternating pattern.
> > >
> > > The situation may still be suboptimal if the deferred unmapping
> > > introduced previously is supported by the OS layer.  For instance,
> > > the alternating memory access pattern mentioned above may produce
> > > a relatively long list of mappings to release with substantial
> > > duplication among the entries in it, which could be avoided if
> > > acpi_ex_system_memory_space_handler() did not release the mapping
> > > used by it previously as soon as the current access was not covered
> > > by it.
> > >
> > > In order to improve that, modify acpi_ex_system_memory_space_handler()
> > > to preserve all of the memory mappings created by it until the memory
> > > regions associated with them go away.
> > >
> > > Accordingly, update acpi_ev_system_memory_region_setup() to unmap all
> > > memory associated with memory opregions that go away.
> > >
> > > Reported-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/acpi/acpica/evrgnini.c | 14 ++++----
> > >  drivers/acpi/acpica/exregion.c | 65 ++++++++++++++++++++++++----------
> > >  include/acpi/actypes.h         | 12 +++++--
> > >  3 files changed, 64 insertions(+), 27 deletions(-)
> > >
> > > diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
> > > index aefc0145e583..89be3ccdad53 100644
> > > --- a/drivers/acpi/acpica/evrgnini.c
> > > +++ b/drivers/acpi/acpica/evrgnini.c
> > > @@ -38,6 +38,7 @@ acpi_ev_system_memory_region_setup(acpi_handle handle,
> > >       union acpi_operand_object *region_desc =
> > >           (union acpi_operand_object *)handle;
> > >       struct acpi_mem_space_context *local_region_context;
> > > +     struct acpi_mem_mapping *mm;
> > >
> > >       ACPI_FUNCTION_TRACE(ev_system_memory_region_setup);
> > >
> > > @@ -46,13 +47,14 @@ acpi_ev_system_memory_region_setup(acpi_handle handle,
> > >                       local_region_context =
> > >                           (struct acpi_mem_space_context *)*region_context;
> > >
> > > -                     /* Delete a cached mapping if present */
> > > +                     /* Delete memory mappings if present */
> > >
> > > -                     if (local_region_context->mapped_length) {
> > > -                             acpi_os_unmap_memory(local_region_context->
> > > -                                                  mapped_logical_address,
> > > -                                                  local_region_context->
> > > -                                                  mapped_length);
> > > +                     while (local_region_context->first_mm) {
> > > +                             mm = local_region_context->first_mm;
> > > +                             local_region_context->first_mm = mm->next_mm;
> > > +                             acpi_os_unmap_memory(mm->logical_address,
> > > +                                                  mm->length);
> > > +                             ACPI_FREE(mm);
> > >                       }
> > >                       ACPI_FREE(local_region_context);
> > >                       *region_context = NULL;
> > > diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
> > > index d15a66de26c0..fd68f2134804 100644
> > > --- a/drivers/acpi/acpica/exregion.c
> > > +++ b/drivers/acpi/acpica/exregion.c
> > > @@ -41,6 +41,7 @@ acpi_ex_system_memory_space_handler(u32 function,
> > >       acpi_status status = AE_OK;
> > >       void *logical_addr_ptr = NULL;
> > >       struct acpi_mem_space_context *mem_info = region_context;
> > > +     struct acpi_mem_mapping *mm = mem_info->cur_mm;
> > >       u32 length;
> > >       acpi_size map_length;
> >
> > I think this needs to be:
> >
> >         acpi_size map_length = mem_info->length;
> >
> > since it now gets used in the ACPI_ERROR() call below.
> 
> No, it's better to print the length value in the message.

Yeah, that was the other option.

> >  I'm getting a "maybe used unitialized" error on compilation.
> 
> Thanks for reporting!
> 
> I've updated the commit in the acpica-osl branch with the fix.

Thanks, Rafael.

Do you have a generic way of testing this?  I can see a way to do it
-- timing a call of a method in a dynamically loaded SSDT -- but if
you had a test case laying around, I could continue to be lazy :).

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

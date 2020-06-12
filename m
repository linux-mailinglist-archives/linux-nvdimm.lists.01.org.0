Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 517691F77A0
	for <lists+linux-nvdimm@lfdr.de>; Fri, 12 Jun 2020 14:05:22 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A95E91007A840;
	Fri, 12 Jun 2020 05:05:20 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.167.194; helo=mail-oi1-f194.google.com; envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN> 
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3A9DA1007A829
	for <linux-nvdimm@lists.01.org>; Fri, 12 Jun 2020 05:05:18 -0700 (PDT)
Received: by mail-oi1-f194.google.com with SMTP id x202so8411749oix.11
        for <linux-nvdimm@lists.01.org>; Fri, 12 Jun 2020 05:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vFwhiYEH8oFfrk8TNiw5uMiuVfFehhn4UASR2l6vNwU=;
        b=VM9MrB3Nob1DPttEU4bfsF4jxj1FWcyTfpUJSK0qsogfxaDrq8ok5d9hKv7aWeZVtW
         QUbYXAgBC5icXRjf76iCjDl/DHdyipLd/dlSmu/6fGbNCeATAdtVr6APta3LB22AaGwB
         CmsxjzrIpeqqQJWVaJZzpG7zY3eoAhQ5EJzvO5ZPUnd/LCfVkyXuQPpPwdqwRwvRTTLT
         PJizmDqMdqKK8frSGxykqAyd6kS3NQRtKGwNtG0fgKGJmFeJN6Yz4Smtz4Uf609TupRi
         Ed++rNDE4WA7Oe8DTmcSd6jg6094uMUB3qfpNRbmSENRAG0JeOimrOtiI2KaYlBkkbf+
         C07g==
X-Gm-Message-State: AOAM530x6A1iYBY0WXFA5y5Gobf5eHQBojII6+HZMrAqLnw+iNXnkVAO
	qMgLh1eREny4g/klOUSnurbRn0amtYZOhTdyIPc=
X-Google-Smtp-Source: ABdhPJzzratWFEFnCI62Qa2Ya16bGmtMS72/S8i52Q1nskzw+ZVCcqsmcmX3yUortj+kqoj/uHbWSu+vHMfgewzhpGs=
X-Received: by 2002:aca:ab92:: with SMTP id u140mr1819440oie.68.1591963516898;
 Fri, 12 Jun 2020 05:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <318372766.6LKUBsbRXE@kreacher> <3974162.pZLctmZ5Iv@kreacher> <BYAPR11MB30963CB784B940A5CD58C4FAF0810@BYAPR11MB3096.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB30963CB784B940A5CD58C4FAF0810@BYAPR11MB3096.namprd11.prod.outlook.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 12 Jun 2020 14:05:01 +0200
Message-ID: <CAJZ5v0h0ax4N-Tk+MfAeAyJ_tDYPW5vseqUU49UShBKZ4+F6Bw@mail.gmail.com>
Subject: Re: [RFT][PATCH 2/3] ACPICA: Remove unused memory mappings on
 interpreter exit
To: "Kaneda, Erik" <erik.kaneda@intel.com>
Message-ID-Hash: 4TDPDVRTOYBWQA4Z66MJKZHI76N6G2Z2
X-Message-ID-Hash: 4TDPDVRTOYBWQA4Z66MJKZHI76N6G2Z2
X-MailFrom: rjwysocki@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Myron Stowe <myron.stowe@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "Moore, Robert" <robert.moore@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4TDPDVRTOYBWQA4Z66MJKZHI76N6G2Z2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jun 12, 2020 at 2:12 AM Kaneda, Erik <erik.kaneda@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Sent: Wednesday, June 10, 2020 5:22 AM
> > To: Williams, Dan J <dan.j.williams@intel.com>
> > Cc: Kaneda, Erik <erik.kaneda@intel.com>; Wysocki, Rafael J
> > <rafael.j.wysocki@intel.com>; Len Brown <lenb@kernel.org>; Borislav
> > Petkov <bp@alien8.de>; Weiny, Ira <ira.weiny@intel.com>; James Morse
> > <james.morse@arm.com>; Myron Stowe <myron.stowe@redhat.com>;
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com>; linux-
> > kernel@vger.kernel.org; linux-acpi@vger.kernel.org; linux-
> > nvdimm@lists.01.org; Moore, Robert <robert.moore@intel.com>
> > Subject: [RFT][PATCH 2/3] ACPICA: Remove unused memory mappings on
> > interpreter exit
> >
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > For transient memory opregions that are created dynamically under
> > the namespace and interpreter mutexes and go away quickly, there
> > still is the problem that removing their memory mappings may take
> > significant time and so doing that while holding the mutexes should
> > be avoided.
> >
> > For example, unmapping a chunk of memory associated with a memory
> > opregion in Linux involves running synchronize_rcu_expedited()
> > which really should not be done with the namespace mutex held.
> >
> > To address that problem, notice that the unused memory mappings left
> > behind by the "dynamic" opregions that went away need not be unmapped
> > right away when the opregion is deactivated.  Instead, they may be
> > unmapped when exiting the interpreter, after the namespace and
> > interpreter mutexes have been dropped (there's one more place dealing
> > with opregions in the debug code that can be treated analogously).
> >
> > Accordingly, change acpi_ev_system_memory_region_setup() to put
> > the unused mappings into a global list instead of unmapping them
> > right away and add acpi_ev_system_release_memory_mappings() to
> > be called when leaving the interpreter in order to unmap the
> > unused memory mappings in the global list (which is protected
> > by the namespace mutex).
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/acpi/acpica/acevents.h |  2 ++
> >  drivers/acpi/acpica/dbtest.c   |  3 ++
> >  drivers/acpi/acpica/evrgnini.c | 51
> > ++++++++++++++++++++++++++++++++--
> >  drivers/acpi/acpica/exutils.c  |  3 ++
> >  drivers/acpi/acpica/utxface.c  | 23 +++++++++++++++
> >  include/acpi/acpixf.h          |  1 +
> >  6 files changed, 80 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
> > index 79f292687bd6..463eb9124765 100644
> > --- a/drivers/acpi/acpica/acevents.h
> > +++ b/drivers/acpi/acpica/acevents.h
> > @@ -197,6 +197,8 @@ acpi_ev_execute_reg_method(union
> > acpi_operand_object *region_obj, u32 function);
> >  /*
> >   * evregini - Region initialization and setup
> >   */
> > +void acpi_ev_system_release_memory_mappings(void);
> > +
> >  acpi_status
> >  acpi_ev_system_memory_region_setup(acpi_handle handle,
> >                                  u32 function,
> > diff --git a/drivers/acpi/acpica/dbtest.c b/drivers/acpi/acpica/dbtest.c
> > index 6db44a5ac786..7dac6dae5c48 100644
> > --- a/drivers/acpi/acpica/dbtest.c
> > +++ b/drivers/acpi/acpica/dbtest.c
> > @@ -8,6 +8,7 @@
> >  #include <acpi/acpi.h>
> >  #include "accommon.h"
> >  #include "acdebug.h"
> > +#include "acevents.h"
> >  #include "acnamesp.h"
> >  #include "acpredef.h"
> >  #include "acinterp.h"
> > @@ -768,6 +769,8 @@ acpi_db_test_field_unit_type(union
> > acpi_operand_object *obj_desc)
> >               acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
> >               acpi_ut_release_mutex(ACPI_MTX_INTERPRETER);
> >
> > +             acpi_ev_system_release_memory_mappings();
> > +
> >               bit_length = obj_desc->common_field.bit_length;
> >               byte_length =
> > ACPI_ROUND_BITS_UP_TO_BYTES(bit_length);
> >
> > diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
> > index 48a5e6eaf9b9..946c4eef054d 100644
> > --- a/drivers/acpi/acpica/evrgnini.c
> > +++ b/drivers/acpi/acpica/evrgnini.c
> > @@ -16,6 +16,52 @@
> >  #define _COMPONENT          ACPI_EVENTS
> >  ACPI_MODULE_NAME("evrgnini")
> >
> > +#ifdef ACPI_OS_MAP_MEMORY_FAST_PATH
> > +static struct acpi_mem_mapping *unused_memory_mappings;
> > +
> > +/*********************************************************
> > **********************
> > + *
> > + * FUNCTION:    acpi_ev_system_release_memory_mappings
> > + *
> > + * PARAMETERS:  None
> > + *
> > + * RETURN:      None
> > + *
> > + * DESCRIPTION: Release all of the unused memory mappings in the queue
> > + *              under the interpreter mutex.
> > + *
> > +
> > **********************************************************
> > ********************/
> > +void acpi_ev_system_release_memory_mappings(void)
> > +{
> > +     struct acpi_mem_mapping *mapping;
> > +
> > +
> >       ACPI_FUNCTION_TRACE(acpi_ev_system_release_memory_mappin
> > gs);
> > +
> > +     acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
> > +
> > +     while (unused_memory_mappings) {
> > +             mapping = unused_memory_mappings;
> > +             unused_memory_mappings = mapping->next;
> > +
> > +             acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
> > +
> > +             acpi_os_unmap_memory(mapping->logical_address,
> > mapping->length);
>
> acpi_os_unmap_memory calls synchronize_rcu_expedited(). I'm no RCU expert but the
> definition of this function states:
>
> * Although this is a great improvement over previous expedited
>  * implementations, it is still unfriendly to real-time workloads, so is
>  * thus not recommended for any sort of common-case code.  In fact, if
>  * you are using synchronize_rcu_expedited() in a loop, please restructure
>  * your code to batch your updates, and then use a single synchronize_rcu()
>  * instead.

If this really ends up being a loop, the code without this patch will
also call synchronize_rcu_expedited() in a loop, but indirectly and
under the namespace and interpreter mutexes.

While I agree that this is still somewhat suboptimal, improving this
would require more changes in the OSL code.

Cheers!
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

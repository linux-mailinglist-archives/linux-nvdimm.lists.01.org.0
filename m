Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C83951F84EA
	for <lists+linux-nvdimm@lfdr.de>; Sat, 13 Jun 2020 21:28:59 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 17151100AA7B4;
	Sat, 13 Jun 2020 12:28:58 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.96.170.134; helo=cloudserver094114.home.pl; envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN> 
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6479410106A08
	for <linux-nvdimm@lists.01.org>; Sat, 13 Jun 2020 12:28:55 -0700 (PDT)
Received: from 89-77-60-66.dynamic.chello.pl (89.77.60.66) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id db32435290b12ab0; Sat, 13 Jun 2020 21:28:53 +0200
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: "Kaneda, Erik" <erik.kaneda@intel.com>
Subject: Re: [RFT][PATCH 2/3] ACPICA: Remove unused memory mappings on interpreter exit
Date: Sat, 13 Jun 2020 21:28:52 +0200
Message-ID: <34641620.ChEHEh4gq6@kreacher>
In-Reply-To: <CAJZ5v0h0ax4N-Tk+MfAeAyJ_tDYPW5vseqUU49UShBKZ4+F6Bw@mail.gmail.com>
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com> <BYAPR11MB30963CB784B940A5CD58C4FAF0810@BYAPR11MB3096.namprd11.prod.outlook.com> <CAJZ5v0h0ax4N-Tk+MfAeAyJ_tDYPW5vseqUU49UShBKZ4+F6Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-ID-Hash: H6PF5RLMDLOQPICTMHFJATZJE65GC5OU
X-Message-ID-Hash: H6PF5RLMDLOQPICTMHFJATZJE65GC5OU
X-MailFrom: rjw@rjwysocki.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Rafael J. Wysocki" <rafael@kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Myron Stowe <myron.stowe@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "Moore, Robert" <robert.moore@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/H6PF5RLMDLOQPICTMHFJATZJE65GC5OU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

On Friday, June 12, 2020 2:05:01 PM CEST Rafael J. Wysocki wrote:
> On Fri, Jun 12, 2020 at 2:12 AM Kaneda, Erik <erik.kaneda@intel.com> wrote:
> >
> >
> >
> > > -----Original Message-----
> > > From: Rafael J. Wysocki <rjw@rjwysocki.net>
> > > Sent: Wednesday, June 10, 2020 5:22 AM
> > > To: Williams, Dan J <dan.j.williams@intel.com>
> > > Cc: Kaneda, Erik <erik.kaneda@intel.com>; Wysocki, Rafael J
> > > <rafael.j.wysocki@intel.com>; Len Brown <lenb@kernel.org>; Borislav
> > > Petkov <bp@alien8.de>; Weiny, Ira <ira.weiny@intel.com>; James Morse
> > > <james.morse@arm.com>; Myron Stowe <myron.stowe@redhat.com>;
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com>; linux-
> > > kernel@vger.kernel.org; linux-acpi@vger.kernel.org; linux-
> > > nvdimm@lists.01.org; Moore, Robert <robert.moore@intel.com>
> > > Subject: [RFT][PATCH 2/3] ACPICA: Remove unused memory mappings on
> > > interpreter exit
> > >
> > > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > >
> > > For transient memory opregions that are created dynamically under
> > > the namespace and interpreter mutexes and go away quickly, there
> > > still is the problem that removing their memory mappings may take
> > > significant time and so doing that while holding the mutexes should
> > > be avoided.
> > >
> > > For example, unmapping a chunk of memory associated with a memory
> > > opregion in Linux involves running synchronize_rcu_expedited()
> > > which really should not be done with the namespace mutex held.
> > >
> > > To address that problem, notice that the unused memory mappings left
> > > behind by the "dynamic" opregions that went away need not be unmapped
> > > right away when the opregion is deactivated.  Instead, they may be
> > > unmapped when exiting the interpreter, after the namespace and
> > > interpreter mutexes have been dropped (there's one more place dealing
> > > with opregions in the debug code that can be treated analogously).
> > >
> > > Accordingly, change acpi_ev_system_memory_region_setup() to put
> > > the unused mappings into a global list instead of unmapping them
> > > right away and add acpi_ev_system_release_memory_mappings() to
> > > be called when leaving the interpreter in order to unmap the
> > > unused memory mappings in the global list (which is protected
> > > by the namespace mutex).
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/acpi/acpica/acevents.h |  2 ++
> > >  drivers/acpi/acpica/dbtest.c   |  3 ++
> > >  drivers/acpi/acpica/evrgnini.c | 51
> > > ++++++++++++++++++++++++++++++++--
> > >  drivers/acpi/acpica/exutils.c  |  3 ++
> > >  drivers/acpi/acpica/utxface.c  | 23 +++++++++++++++
> > >  include/acpi/acpixf.h          |  1 +
> > >  6 files changed, 80 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
> > > index 79f292687bd6..463eb9124765 100644
> > > --- a/drivers/acpi/acpica/acevents.h
> > > +++ b/drivers/acpi/acpica/acevents.h
> > > @@ -197,6 +197,8 @@ acpi_ev_execute_reg_method(union
> > > acpi_operand_object *region_obj, u32 function);
> > >  /*
> > >   * evregini - Region initialization and setup
> > >   */
> > > +void acpi_ev_system_release_memory_mappings(void);
> > > +
> > >  acpi_status
> > >  acpi_ev_system_memory_region_setup(acpi_handle handle,
> > >                                  u32 function,
> > > diff --git a/drivers/acpi/acpica/dbtest.c b/drivers/acpi/acpica/dbtest.c
> > > index 6db44a5ac786..7dac6dae5c48 100644
> > > --- a/drivers/acpi/acpica/dbtest.c
> > > +++ b/drivers/acpi/acpica/dbtest.c
> > > @@ -8,6 +8,7 @@
> > >  #include <acpi/acpi.h>
> > >  #include "accommon.h"
> > >  #include "acdebug.h"
> > > +#include "acevents.h"
> > >  #include "acnamesp.h"
> > >  #include "acpredef.h"
> > >  #include "acinterp.h"
> > > @@ -768,6 +769,8 @@ acpi_db_test_field_unit_type(union
> > > acpi_operand_object *obj_desc)
> > >               acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
> > >               acpi_ut_release_mutex(ACPI_MTX_INTERPRETER);
> > >
> > > +             acpi_ev_system_release_memory_mappings();
> > > +
> > >               bit_length = obj_desc->common_field.bit_length;
> > >               byte_length =
> > > ACPI_ROUND_BITS_UP_TO_BYTES(bit_length);
> > >
> > > diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
> > > index 48a5e6eaf9b9..946c4eef054d 100644
> > > --- a/drivers/acpi/acpica/evrgnini.c
> > > +++ b/drivers/acpi/acpica/evrgnini.c
> > > @@ -16,6 +16,52 @@
> > >  #define _COMPONENT          ACPI_EVENTS
> > >  ACPI_MODULE_NAME("evrgnini")
> > >
> > > +#ifdef ACPI_OS_MAP_MEMORY_FAST_PATH
> > > +static struct acpi_mem_mapping *unused_memory_mappings;
> > > +
> > > +/*********************************************************
> > > **********************
> > > + *
> > > + * FUNCTION:    acpi_ev_system_release_memory_mappings
> > > + *
> > > + * PARAMETERS:  None
> > > + *
> > > + * RETURN:      None
> > > + *
> > > + * DESCRIPTION: Release all of the unused memory mappings in the queue
> > > + *              under the interpreter mutex.
> > > + *
> > > +
> > > **********************************************************
> > > ********************/
> > > +void acpi_ev_system_release_memory_mappings(void)
> > > +{
> > > +     struct acpi_mem_mapping *mapping;
> > > +
> > > +
> > >       ACPI_FUNCTION_TRACE(acpi_ev_system_release_memory_mappin
> > > gs);
> > > +
> > > +     acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
> > > +
> > > +     while (unused_memory_mappings) {
> > > +             mapping = unused_memory_mappings;
> > > +             unused_memory_mappings = mapping->next;
> > > +
> > > +             acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
> > > +
> > > +             acpi_os_unmap_memory(mapping->logical_address,
> > > mapping->length);
> >
> > acpi_os_unmap_memory calls synchronize_rcu_expedited(). I'm no RCU expert but the
> > definition of this function states:
> >
> > * Although this is a great improvement over previous expedited
> >  * implementations, it is still unfriendly to real-time workloads, so is
> >  * thus not recommended for any sort of common-case code.  In fact, if
> >  * you are using synchronize_rcu_expedited() in a loop, please restructure
> >  * your code to batch your updates, and then use a single synchronize_rcu()
> >  * instead.
> 
> If this really ends up being a loop, the code without this patch will
> also call synchronize_rcu_expedited() in a loop, but indirectly and
> under the namespace and interpreter mutexes.
> 
> While I agree that this is still somewhat suboptimal, improving this
> would require more changes in the OSL code.

After writing the above I started to think about the extra changes needed
to improve that and I realized that it would take making the OS layer
support deferred memory unmapping, such that the unused mappings would be
queued up for later removal and then released in one go at a suitable time.

However, that would be sufficient to address the issue addressed by this
series, because the deferred unmapping could be used in
acpi_ev_system_memory_region_setup() right away and that would be a much
simpler change than the one made in patch [1/3].

So I went ahead and implemented this and the result is there in the
acpica-osl branch in my tree, but it hasn't been built yet, so caveat
emptor.  Anyway, please feel free to have a look at it still.

Cheers!


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

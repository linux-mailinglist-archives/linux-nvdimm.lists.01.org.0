Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 520AE23174D
	for <lists+linux-nvdimm@lfdr.de>; Wed, 29 Jul 2020 03:35:27 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 34C54125B9668;
	Tue, 28 Jul 2020 18:35:25 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F0379125B9667
	for <linux-nvdimm@lists.01.org>; Tue, 28 Jul 2020 18:35:22 -0700 (PDT)
IronPort-SDR: efrsnXiLC9q4t+qJQCoT5Us+hnjpHrOPiyXpFg8JF9tnG5Ccbp0Fsr02HEjhMS/XnWL0EBy0nG
 CcuM58s83j5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="139362279"
X-IronPort-AV: E=Sophos;i="5.75,408,1589266800";
   d="scan'208";a="139362279"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 18:35:10 -0700
IronPort-SDR: YNsFNSmhqfBBgmI35x/2O7/pNXoR+a/bwag1n6Mwd4MKRcnT4XpSjxN7jGO6jeRF7/XLdB/SmJ
 NIW6+0gsiTZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,408,1589266800";
   d="scan'208";a="364700282"
Received: from vverma7-mobl4.lm.intel.com (HELO localhost6.localdomain6) ([10.254.21.148])
  by orsmga001.jf.intel.com with ESMTP; 28 Jul 2020 18:35:09 -0700
Message-ID: <25cb1c0c35d2ea2aa233c1db726abd86dadc54c0.camel@intel.com>
Subject: Re: [PATCH v3 10/11] PM, libnvdimm: Add runtime firmware activation
 support
From: Vishal Verma <vishal.l.verma@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Dan Williams
	 <dan.j.williams@intel.com>
Date: Tue, 28 Jul 2020 19:35:09 -0600
In-Reply-To: <CAJZ5v0jb87PnwVXKuvgFeP=c-BGstc4YmANGpbOOnXi-b1oL8w@mail.gmail.com>
References: 
	<159528284411.993790.11733759435137949717.stgit@dwillia2-desk3.amr.corp.intel.com>
	 <159528289856.993790.11787167534159675987.stgit@dwillia2-desk3.amr.corp.intel.com>
	 <CAJZ5v0jb87PnwVXKuvgFeP=c-BGstc4YmANGpbOOnXi-b1oL8w@mail.gmail.com>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Message-ID-Hash: R2R4624BXK4YGFA4UUTSJG3OIZ6L7FFB
X-Message-ID-Hash: R2R4624BXK4YGFA4UUTSJG3OIZ6L7FFB
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Jonathan Corbet <corbet@lwn.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/R2R4624BXK4YGFA4UUTSJG3OIZ6L7FFB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2020-07-27 at 14:37 +0200, Rafael J. Wysocki wrote:
> On Tue, Jul 21, 2020 at 12:24 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > Abstract platform specific mechanics for nvdimm firmware activation
> > behind a handful of generic ops. At the bus level ->activate_state()
> > indicates the unified state (idle, busy, armed) of all DIMMs on the bus,
> > and ->capability() indicates the system state expectations for activate.
> > At the DIMM level ->activate_state() indicates the per-DIMM state,
> > ->activate_result() indicates the outcome of the last activation
> > attempt, and ->arm() attempts to transition the DIMM from 'idle' to
> > 'armed'.
> > 
> > A new hibernate_quiet_exec() facility is added to support firmware
> > activation in an OS defined system quiesce state. It leverages the fact
> > that the hibernate-freeze state wants to assert that a memory
> > hibernation snapshot can be taken. This is in contrast to a platform
> > firmware defined quiesce state that may forcefully quiet the memory
> > controller independent of whether an individual device-driver properly
> > supports hibernate-freeze.
> > 
> > The libnvdimm sysfs interface is extended to support detection of a
> > firmware activate capability. The mechanism supports enumeration and
> > triggering of firmware activate, optionally in the
> > hibernate_quiet_exec() context.
> > 
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > [rafael: hibernate_quiet_exec() proposal]
> > Co-developed-by: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> 
> IMO it's better to change this to
> 
> Co-developed-by: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> and please to add
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> to it as per the development process documentation.

Thanks Rafael, I've fixed this up in the branch I've prepared for the pull
request:

https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/log/?h=libnvdimm-for-next

> 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-nvdimm         |    2
> >  .../driver-api/nvdimm/firmware-activate.rst        |   86 ++++++++++++
> >  drivers/nvdimm/core.c                              |  149 ++++++++++++++++++++
> >  drivers/nvdimm/dimm_devs.c                         |  115 +++++++++++++++
> >  drivers/nvdimm/nd-core.h                           |    1
> >  include/linux/libnvdimm.h                          |   44 ++++++
> >  include/linux/suspend.h                            |    6 +
> >  kernel/power/hibernate.c                           |   97 +++++++++++++
> >  8 files changed, 500 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-nvdimm
> >  create mode 100644 Documentation/driver-api/nvdimm/firmware-activate.rst
> > 

[..]

> > @@ -464,6 +466,10 @@ static inline void hibernation_set_ops(const struct platform_hibernation_ops *op
> >  static inline int hibernate(void) { return -ENOSYS; }
> >  static inline bool system_entering_hibernation(void) { return false; }
> >  static inline bool hibernation_available(void) { return false; }
> > +
> > +static inline hibernate_quiet_exec(int (*func)(void *data), void *data) {
> 
> This needs to be "static inline int".
> 
Yep I got a build warning for this and also fixed it up.

Thanks,
-Vishal

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

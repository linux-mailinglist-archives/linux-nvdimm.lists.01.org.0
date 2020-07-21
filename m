Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAD4227440
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 Jul 2020 02:58:30 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 572C31243CEA7;
	Mon, 20 Jul 2020 17:58:28 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::644; helo=mail-ej1-x644.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 31B141243CEA5
	for <linux-nvdimm@lists.01.org>; Mon, 20 Jul 2020 17:58:26 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id y10so19946245eje.1
        for <linux-nvdimm@lists.01.org>; Mon, 20 Jul 2020 17:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9b/dWUWcmQC3VAaa8Cg/JXLF0cqmH/Md5xiTM9HBxjQ=;
        b=diD3DVsxMCkiIzevO0+JCae+FxhUk569wVXPS1cRfwY3pETJzf/3PLI2b9XoEyyDXw
         Z6pIGGBxBMkmAlVBQm50HIbkZdAdYypcaSuf2iweirUt0+XxTecetCnlyXELdL4/FXQ6
         ZtByrRngf2shBc+YkqWZXmfq/VNYmsdECRyVRYNOTFuP5ZbE7MWjafb2IOGH4lvfjWlY
         0xwxrGDdqnFGd8YAt+vtLlH832ackygwFGBll/6y5Rd31R23/PkltkHtKhhl591wxg2I
         mbBQ8L1UeYeUq4JBvECQc9/KD5MZQXx4FT2ZnxOf49iS7J0f2FjmwtZNPjp78WlmkSk/
         +GCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9b/dWUWcmQC3VAaa8Cg/JXLF0cqmH/Md5xiTM9HBxjQ=;
        b=RGwaIubVcR5ezkblpoWrTdvHELjWb+R+kIe8+BfRNdpz9dEaK5Qj311Dr3+rZmfzxI
         reOEz5XFmL4sbr661brwGE2uHpQMSrHhlil0tdvOehCeMGmM14fLXp9/brUuLD7RPQ12
         Pn/3gTRaxbe0gyFDYLg7BsXYBHPQt2MCrXxJ5Ip4zPLagWMky4FbTtwjIjPs0ymvH3qh
         sjmOEh/3pVeHIox31v97gUDExx+CH1tPLEut3AKJS8/b7qk8t3mMLD+uCObQuPNE+0fg
         uPAeMRCgg5ejkOFaGpykAQzMvXTXkIpMxUvtKN/a3fz0lojH4Tk6HS8dehBQKXgKpILN
         G34w==
X-Gm-Message-State: AOAM531a3gmSdnsSDh5aUqUhRPGx4XIzuwBmRB6GlpGmgIQj2UMkPyy+
	DJ+Kgco3N/+OWtM4hso6/w+/xpi15XAaus0DJTbEow==
X-Google-Smtp-Source: ABdhPJzoQSfYVuoYj/q/5PLCGBYC0RqZLxVuTJwpzD7nytQF786FNvLF+fxJvZkRGx5IT+BM217aX8JbzPPX4acm0As=
X-Received: by 2002:a17:906:cc0e:: with SMTP id ml14mr22733669ejb.432.1595293103436;
 Mon, 20 Jul 2020 17:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <159528284411.993790.11733759435137949717.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159528289856.993790.11787167534159675987.stgit@dwillia2-desk3.amr.corp.intel.com>
 <c825b5ee-ec03-7aa8-e380-6003f33fa113@infradead.org>
In-Reply-To: <c825b5ee-ec03-7aa8-e380-6003f33fa113@infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 20 Jul 2020 17:58:12 -0700
Message-ID: <CAPcyv4giEEAJiX5PSUy6KJSaNgvbmt6XVALmaD-J4p_FqQBY-w@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] PM, libnvdimm: Add runtime firmware activation support
To: Randy Dunlap <rdunlap@infradead.org>
Message-ID-Hash: CZOEBHD55PDVCL2RECJ462I6HLRFKZPP
X-Message-ID-Hash: CZOEBHD55PDVCL2RECJ462I6HLRFKZPP
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Jonathan Corbet <corbet@lwn.net>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CZOEBHD55PDVCL2RECJ462I6HLRFKZPP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jul 20, 2020 at 5:02 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi Dan,
>
> Documentation comments below:
>
> On 7/20/20 3:08 PM, Dan Williams wrote:
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
>
>
> > diff --git a/Documentation/driver-api/nvdimm/firmware-activate.rst b/Documentation/driver-api/nvdimm/firmware-activate.rst
> > new file mode 100644
> > index 000000000000..9eb98aa833c5
> > --- /dev/null
> > +++ b/Documentation/driver-api/nvdimm/firmware-activate.rst
> > @@ -0,0 +1,86 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +==================================
> > +NVDIMM Runtime Firmware Activation
> > +==================================
> > +
> > +Some persistent memory devices run a firmware locally on the device /
>
>                                   run firmware

That works too. I was going to say "run a firmware image", but "run
firmware" is clearer.

>
> > +"DIMM" to perform tasks like media management, capacity provisioning,
> > +and health monitoring. The process of updating that firmware typically
> > +involves a reboot because it has implications for in-flight memory
> > +transactions. However, reboots are disruptive and at least the Intel
> > +persistent memory platform implementation, described by the Intel ACPI
> > +DSM specification [1], has added support for activating firmware at
>
> that's an Intel spec?  just checking.

Correct. It's a public specification of the ACPI methods that Intel
platform BIOS or virtual-machine BIOS deploys to talk to NVDIMM
devices.

>
> > +runtime.
> > +
> > +A native sysfs interface is implemented in libnvdimm to allow platform
>
>                                                                  platforms

Ack.

>
> > +to advertise and control their local runtime firmware activation
> > +capability.
> > +
> > +The libnvdimm bus object, ndbusX, implements an ndbusX/firmware/activate
> > +attribute that shows the state of the firmware activation as one of 'idle',
> > +'armed', 'overflow', and 'busy'.
>
>                         or

Yup.

>
> > +
> > +- idle:
> > +  No devices are set / armed to activate firmware
> > +
> > +- armed:
> > +  At least one device is armed
> > +
> > +- busy:
> > +  In the busy state armed devices are in the process of transitioning
> > +  back to idle and completing an activation cycle.
> > +
> > +- overflow:
> > +  If the platform has a concept of incremental work needed to perform
> > +  the activation it could be the case that too many DIMMs are armed for
> > +  activation. In that scenario the potential for firmware activation to
> > +  timeout is indicated by the 'overflow' state.
> > +
> > +The 'ndbusX/firmware/activate' property can be written with a value of
> > +either 'live', or 'quiesce'. A value of 'quiesce' triggers the kernel to
> > +run firmware activation from within the equivalent of the hibernation
> > +'freeze' state where drivers and applications are notified to stop their
> > +modifications of system memory. A value of 'live' attempts
> > +firmware-activation without this hibernation cycle. The
>
>   no hyphen^^

Agree.

>
> > +'ndbusX/firmware/activate' property will be elided completely if no
> > +firmware activation capability is detected.
> > +
> > +Another property 'ndbusX/firmware/capability' indicates a value of
> > +'live', or 'quiesce'. Where 'live' indicates that the firmware
>
> no comma. no period. So this:
>
> +'live' or 'quiesce', where

Ok.

>
> > +does not require or inflict any quiesce period on the system to update
> > +firmware. A capability value of 'quiesce' indicates that firmware does
> > +expect and injects a quiet period for the memory controller, but 'live'
> > +may still be written to 'ndbusX/firmware/activate' as an override to
> > +assume the risk of racing firmware update with in-flight device and
> > +application activity. The 'ndbusX/firmware/capability' property will be
> > +elided completely if no firmware activation capability is detected.
> > +
> > +The libnvdimm memory-device / DIMM object, nmemX, implements
> > +'nmemX/firmware/activate' and 'nmemX/firmware/result' attributes to
> > +communicate the per-device firmware activation state. Similar to the
> > +'ndbusX/firmware/activate' attribute, the 'nmemX/firmware/activate'
> > +attribute indicates 'idle', 'armed', or 'busy'. The state transitions
> > +from 'armed' to 'idle' when the system is prepared to activate firmware,
> > +firmware staged + state set to armed, and 'ndbusX/firmware/activate' is
> > +triggered. After that activation event the nmemX/firmware/result
> > +attribute reflects the state of the last activation as one of:
> > +
> > +- none:
> > +  No runtime activation triggered since the last time the device was reset
> > +
> > +- success:
> > +  The last runtime activation completed successfully.
> > +
> > +- fail:
> > +  The last runtime activation failed for device-specific reasons.
> > +
> > +- not_staged:
> > +  The last runtime activation failed due to a sequencing error of the
> > +  firmware image not being staged.
> > +
> > +- need_reset:
> > +  Runtime firmware activation failed, but the firmware can still be
> > +  activated via the legacy method of power-cycling the system.
> > +
> > +[1]: https://docs.pmem.io/persistent-memory/
>
>
> thanks.
> --
> ~Randy

Thanks Randy.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603D4227365
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 Jul 2020 02:02:36 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 88AEB1243C6BD;
	Mon, 20 Jul 2020 17:02:34 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 782CC1243B19F
	for <linux-nvdimm@lists.01.org>; Mon, 20 Jul 2020 17:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=O8Y/+nsNJHbgYqWOOnWf55XQh5kSU6RsCQr/mG4GMiI=; b=NPqWf5rMuVq6zxbo0VR7p0NyfS
	0nCJycXHEPlbEVuSy5pIrKWVQfChD3zPAHe6jQSOIyYQX2dymRXeJgs5N/tkeCC6k6TH0epLPMA9o
	8iKHfDXIc9yb/cCqiMNVew1gy5257dc2wU4u8E3PoW9DI87TH2F+ZVHCUqIWbW2XtPWovP8pyZwDT
	UxlfEHFzQ1stoGPJ1uL9PjCJg9M7SeNDeOFXqGP0TuvfCDgqNZzIcT3k//T7fqYVITtYWWTH3fVd3
	fWlYkkVjUMhqr+76br50FiFucTEwIB0C15hK2q62P1qJTLUSQuGHukNCYgR2yUCmD8rnWRbu4SzqS
	eJiCC6tQ==;
Received: from [2601:1c0:6280:3f0::19c2]
	by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jxfjc-0004JH-TY; Tue, 21 Jul 2020 00:02:17 +0000
Subject: Re: [PATCH v3 10/11] PM, libnvdimm: Add runtime firmware activation
 support
To: Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
References: <159528284411.993790.11733759435137949717.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159528289856.993790.11787167534159675987.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c825b5ee-ec03-7aa8-e380-6003f33fa113@infradead.org>
Date: Mon, 20 Jul 2020 17:02:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <159528289856.993790.11787167534159675987.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Language: en-US
Message-ID-Hash: WFAYRJDGTEJHBSAXKHCJJH446WZKWMKG
X-Message-ID-Hash: WFAYRJDGTEJHBSAXKHCJJH446WZKWMKG
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Jonathan Corbet <corbet@lwn.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WFAYRJDGTEJHBSAXKHCJJH446WZKWMKG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Dan,

Documentation comments below:

On 7/20/20 3:08 PM, Dan Williams wrote:
> Abstract platform specific mechanics for nvdimm firmware activation
> behind a handful of generic ops. At the bus level ->activate_state()
> indicates the unified state (idle, busy, armed) of all DIMMs on the bus,
> and ->capability() indicates the system state expectations for activate.
> At the DIMM level ->activate_state() indicates the per-DIMM state,
> ->activate_result() indicates the outcome of the last activation
> attempt, and ->arm() attempts to transition the DIMM from 'idle' to
> 'armed'.
> 
> A new hibernate_quiet_exec() facility is added to support firmware
> activation in an OS defined system quiesce state. It leverages the fact
> that the hibernate-freeze state wants to assert that a memory
> hibernation snapshot can be taken. This is in contrast to a platform
> firmware defined quiesce state that may forcefully quiet the memory
> controller independent of whether an individual device-driver properly
> supports hibernate-freeze.
> 
> The libnvdimm sysfs interface is extended to support detection of a
> firmware activate capability. The mechanism supports enumeration and
> triggering of firmware activate, optionally in the
> hibernate_quiet_exec() context.
> 
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> [rafael: hibernate_quiet_exec() proposal]
> Co-developed-by: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-nvdimm         |    2 
>  .../driver-api/nvdimm/firmware-activate.rst        |   86 ++++++++++++
>  drivers/nvdimm/core.c                              |  149 ++++++++++++++++++++
>  drivers/nvdimm/dimm_devs.c                         |  115 +++++++++++++++
>  drivers/nvdimm/nd-core.h                           |    1 
>  include/linux/libnvdimm.h                          |   44 ++++++
>  include/linux/suspend.h                            |    6 +
>  kernel/power/hibernate.c                           |   97 +++++++++++++
>  8 files changed, 500 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-nvdimm
>  create mode 100644 Documentation/driver-api/nvdimm/firmware-activate.rst


> diff --git a/Documentation/driver-api/nvdimm/firmware-activate.rst b/Documentation/driver-api/nvdimm/firmware-activate.rst
> new file mode 100644
> index 000000000000..9eb98aa833c5
> --- /dev/null
> +++ b/Documentation/driver-api/nvdimm/firmware-activate.rst
> @@ -0,0 +1,86 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==================================
> +NVDIMM Runtime Firmware Activation
> +==================================
> +
> +Some persistent memory devices run a firmware locally on the device /

                                  run firmware

> +"DIMM" to perform tasks like media management, capacity provisioning,
> +and health monitoring. The process of updating that firmware typically
> +involves a reboot because it has implications for in-flight memory
> +transactions. However, reboots are disruptive and at least the Intel
> +persistent memory platform implementation, described by the Intel ACPI
> +DSM specification [1], has added support for activating firmware at

that's an Intel spec?  just checking.

> +runtime.
> +
> +A native sysfs interface is implemented in libnvdimm to allow platform

                                                                 platforms

> +to advertise and control their local runtime firmware activation
> +capability.
> +
> +The libnvdimm bus object, ndbusX, implements an ndbusX/firmware/activate
> +attribute that shows the state of the firmware activation as one of 'idle',
> +'armed', 'overflow', and 'busy'.

                        or

> +
> +- idle:
> +  No devices are set / armed to activate firmware
> +
> +- armed:
> +  At least one device is armed
> +
> +- busy:
> +  In the busy state armed devices are in the process of transitioning
> +  back to idle and completing an activation cycle.
> +
> +- overflow:
> +  If the platform has a concept of incremental work needed to perform
> +  the activation it could be the case that too many DIMMs are armed for
> +  activation. In that scenario the potential for firmware activation to
> +  timeout is indicated by the 'overflow' state.
> +
> +The 'ndbusX/firmware/activate' property can be written with a value of
> +either 'live', or 'quiesce'. A value of 'quiesce' triggers the kernel to
> +run firmware activation from within the equivalent of the hibernation
> +'freeze' state where drivers and applications are notified to stop their
> +modifications of system memory. A value of 'live' attempts
> +firmware-activation without this hibernation cycle. The

  no hyphen^^

> +'ndbusX/firmware/activate' property will be elided completely if no
> +firmware activation capability is detected.
> +
> +Another property 'ndbusX/firmware/capability' indicates a value of
> +'live', or 'quiesce'. Where 'live' indicates that the firmware

no comma. no period. So this:

+'live' or 'quiesce', where

> +does not require or inflict any quiesce period on the system to update
> +firmware. A capability value of 'quiesce' indicates that firmware does
> +expect and injects a quiet period for the memory controller, but 'live'
> +may still be written to 'ndbusX/firmware/activate' as an override to
> +assume the risk of racing firmware update with in-flight device and
> +application activity. The 'ndbusX/firmware/capability' property will be
> +elided completely if no firmware activation capability is detected.
> +
> +The libnvdimm memory-device / DIMM object, nmemX, implements
> +'nmemX/firmware/activate' and 'nmemX/firmware/result' attributes to
> +communicate the per-device firmware activation state. Similar to the
> +'ndbusX/firmware/activate' attribute, the 'nmemX/firmware/activate'
> +attribute indicates 'idle', 'armed', or 'busy'. The state transitions
> +from 'armed' to 'idle' when the system is prepared to activate firmware,
> +firmware staged + state set to armed, and 'ndbusX/firmware/activate' is
> +triggered. After that activation event the nmemX/firmware/result
> +attribute reflects the state of the last activation as one of:
> +
> +- none:
> +  No runtime activation triggered since the last time the device was reset
> +
> +- success:
> +  The last runtime activation completed successfully.
> +
> +- fail:
> +  The last runtime activation failed for device-specific reasons.
> +
> +- not_staged:
> +  The last runtime activation failed due to a sequencing error of the
> +  firmware image not being staged.
> +
> +- need_reset:
> +  Runtime firmware activation failed, but the firmware can still be
> +  activated via the legacy method of power-cycling the system.
> +
> +[1]: https://docs.pmem.io/persistent-memory/


thanks.
-- 
~Randy
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

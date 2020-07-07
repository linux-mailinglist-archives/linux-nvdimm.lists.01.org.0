Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACBE2163B0
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jul 2020 04:14:55 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C38F410FE042C;
	Mon,  6 Jul 2020 19:14:53 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1013E1003FD6A
	for <linux-nvdimm@lists.01.org>; Mon,  6 Jul 2020 19:14:49 -0700 (PDT)
IronPort-SDR: 4cFS5OKaP7tk6+VA/T4VuNRINmVwmoWnnDVTKHocLA3+Yy92S101IFINHFfxhlzJB4caNhwBcW
 nsrrXP3RfA4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="149038818"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800";
   d="scan'208";a="149038818"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:14:49 -0700
IronPort-SDR: aM/DQzSNXqXoRKoo+f4FUPP8V+ChlSee823io9y6Qo1rVJETAQmGsTUduAc04a83jMqLOfZryy
 ZkPdDP7hyB/w==
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800";
   d="scan'208";a="427299087"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:14:49 -0700
Subject: [PATCH v2 00/12] ACPI/NVDIMM: Runtime Firmware Activation
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Mon, 06 Jul 2020 18:58:33 -0700
Message-ID: <159408711335.2385045.2567600405906448375.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: ZICUKMUZVXBWY43HWNG3UKWYTDZ4MLGL
X-Message-ID-Hash: ZICUKMUZVXBWY43HWNG3UKWYTDZ4MLGL
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Doug Ledford <dledford@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@mellanox.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, stable@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZICUKMUZVXBWY43HWNG3UKWYTDZ4MLGL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Changes since v1 [1]:
- Move the syscore callback from 'suspend' path to the 'hibernate' path
  (Rafael)

- Add a new PM debug test mode, 'mem-quiet' to disable some unnecessary
  hibernation steps (memory image preparation) and debug sleeps when the
  hibernation code is just being used to quiet the system for firmware
  activation. (Rafael)

- Greg already applied "driver-core: Introduce
  DEVICE_ATTR_ADMIN_{RO,RW}" to driver-core-next, so I'll need to
  duplicate that commit in nvdimm.git, or work out a common branch
  baseline with Greg for this topic and driver-core-next to share.

[1]: http://lore.kernel.org/r/159312902033.1850128.1712559453279208264.stgit@dwillia2-desk3.amr.corp.intel.com

---

Quoting the documentation:

    Some persistent memory devices run a firmware locally on the device /
    "DIMM" to perform tasks like media management, capacity provisioning,
    and health monitoring. The process of updating that firmware typically
    involves a reboot because it has implications for in-flight memory
    transactions. However, reboots are disruptive and at least the Intel
    persistent memory platform implementation, described by the Intel ACPI
    DSM specification [1], has added support for activating firmware at
    runtime.

    [1]: https://docs.pmem.io/persistent-memory/

The approach taken is to abstract the Intel platform specific mechanism
behind a libnvdimm-generic sysfs interface. The interface could support
runtime-firmware-activation on another architecture without need to
change userspace tooling.

The ACPI NFIT implementation involves a set of device-specific-methods
(DSMs) to 'arm' individual devices for activation and bus-level
'trigger' method to execute the activation. Informational / enumeration
methods are also provided at the bus and device level.

One complicating aspect of the memory device firmware activation is that
the memory controller may need to be quiesced, no memory cycles, during
the activation. While the platform has mechanisms to support holding off
in-flight DMA during the activation, the device response to that delay
is potentially undefined. The platform may reject a runtime firmware
update if, for example a PCI-E device does not support its completion
timeout value being increased to meet the activation time. Outside of
device timeouts the quiesce period may also violate application
timeouts.

Given the above device and application timeout considerations the
implementation defaults to hooking into the hibernation path to trigger
the activation, i.e. that a hibernate-resume cycle (at least up to the
syscore mem-quiet point) is required. That default policy ensures that
the system is in a quiescent state before ceasing memory controller
responses for the activate. However, if desired, runtime activation
without the hibernate freeze can be forced as an override.

The ndctl utility grows the following extensions / commands to drive
this mechanism:

1/ The existing update-firmware command will 'arm' devices where the
   firmware image is staged by default.

    ndctl update-firmware all -f firmware_image.bin

2/ The existing ability to enumerate firmware-update capabilities now
   includes firmware activate capabilities at the 'bus' and 'dimm/device'
   level:

    ndctl list -BDF -b nfit_test.0
    [
      {
        "provider":"nfit_test.0",
        "dev":"ndbus2",
        "scrub_state":"idle",
        "firmware":{
          "activate_method":"suspend",
          "activate_state":"idle"
        },
        "dimms":[
          {
            "dev":"nmem1",
            "id":"cdab-0a-07e0-ffffffff",
            "handle":0,
            "phys_id":0,
            "security":"disabled",
            "firmware":{
              "current_version":0,
              "can_update":true
            }
          },
    ...

3/ When the system can support activation without quiesce, or when the
   hibernate-resume requirement is going to be suppressed, the new
   activate-firmware command wraps that functionality:

    ndctl activate-firmware nfit_test.0 --force

   Otherwise, if activate_method is "suspend" then the activation can be
   triggered by the mem-quiet hibernate debug state, or a full hibernate
   resume:

    echo mem-quiet > /sys/power/pm_debug
    echo disk > /sys/power/state

---

Dan Williams (12):
      libnvdimm: Validate command family indices
      ACPI: NFIT: Move bus_dsm_mask out of generic nvdimm_bus_descriptor
      ACPI: NFIT: Define runtime firmware activation commands
      tools/testing/nvdimm: Cleanup dimm index passing
      tools/testing/nvdimm: Add command debug messages
      tools/testing/nvdimm: Prepare nfit_ctl_test() for ND_CMD_CALL emulation
      tools/testing/nvdimm: Emulate firmware activation commands
      driver-core: Introduce DEVICE_ATTR_ADMIN_{RO,RW}
      libnvdimm: Convert to DEVICE_ATTR_ADMIN_RO()
      libnvdimm: Add runtime firmware activation sysfs interface
      PM, libnvdimm: Add 'mem-quiet' state and callback for firmware activation
      ACPI: NFIT: Add runtime firmware activate support


 Documentation/ABI/testing/sysfs-bus-nfit           |   35 ++
 Documentation/ABI/testing/sysfs-bus-nvdimm         |    2 
 .../driver-api/nvdimm/firmware-activate.rst        |   74 +++
 drivers/acpi/nfit/core.c                           |  146 +++++--
 drivers/acpi/nfit/intel.c                          |  426 ++++++++++++++++++++
 drivers/acpi/nfit/intel.h                          |   61 +++
 drivers/acpi/nfit/nfit.h                           |   39 ++
 drivers/base/syscore.c                             |   21 +
 drivers/nvdimm/bus.c                               |   46 ++
 drivers/nvdimm/core.c                              |  103 +++++
 drivers/nvdimm/dimm_devs.c                         |   99 +++++
 drivers/nvdimm/namespace_devs.c                    |    2 
 drivers/nvdimm/nd-core.h                           |    1 
 drivers/nvdimm/pfn_devs.c                          |    2 
 drivers/nvdimm/region_devs.c                       |    2 
 include/linux/device.h                             |    4 
 include/linux/libnvdimm.h                          |   53 ++
 include/linux/syscore_ops.h                        |    2 
 include/linux/sysfs.h                              |    7 
 include/uapi/linux/ndctl.h                         |    5 
 kernel/power/hibernate.c                           |   17 +
 kernel/power/main.c                                |    1 
 kernel/power/power.h                               |    7 
 kernel/power/snapshot.c                            |   13 +
 kernel/power/suspend.c                             |   12 +
 tools/testing/nvdimm/test/nfit.c                   |  367 ++++++++++++++---
 26 files changed, 1427 insertions(+), 120 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-nvdimm
 create mode 100644 Documentation/driver-api/nvdimm/firmware-activate.rst
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

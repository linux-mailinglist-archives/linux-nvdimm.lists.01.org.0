Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8D3216430
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jul 2020 04:56:38 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7582A1108DEA8;
	Mon,  6 Jul 2020 19:56:36 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E56CC1108C539
	for <linux-nvdimm@lists.01.org>; Mon,  6 Jul 2020 19:56:34 -0700 (PDT)
IronPort-SDR: Zd1UPA+xrMwOKld4g1MIHOilwg2eoI79YIAuq9+6YccyArEaaRO1bpnvk2VC3VxrYpiYV46ekd
 aE8ltS8q//CA==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="149041545"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800";
   d="scan'208";a="149041545"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:56:34 -0700
IronPort-SDR: TbbmSAJsOHfgHJErKFfK6Nn32dC/6i0JfgT92nX2++JRMlRtWhTeqy7FEAmuvFK5i7HEgvgJOE
 jA8XFTZE2IcA==
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800";
   d="scan'208";a="279463923"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:56:33 -0700
Subject: [ndctl PATCH 00/16] Firmware Activation and Test Updates
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: Dave Jiang <dave.jiang@intel.com>, vishal.l.verma@intel.com
Date: Mon, 06 Jul 2020 19:40:18 -0700
Message-ID: <159408961822.2386154.888266173771881937.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: TTY2EM72VEQIA44BYCXCDCPIAFKJQNMI
X-Message-ID-Hash: TTY2EM72VEQIA44BYCXCDCPIAFKJQNMI
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TTY2EM72VEQIA44BYCXCDCPIAFKJQNMI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Some persistent memory devices run a firmware locally on the device /
"DIMM" to perform tasks like media management, capacity provisioning,
and health monitoring. The process of updating that firmware typically
involves a reboot because it has implications for in-flight memory
transactions. However, reboots are disruptive and at least the Intel
persistent memory platform implementation, described by the Intel ACPI
DSM specification [1], has added support for activating firmware at
runtime.

As mentioned in the kernel patches adding support for firmware-activate
[2], ndctl is extended with the following functionality:

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

In addition to firmware activate support this patch-set also includes
some miscellaneous test updates and build fixes.

[1]: https://pmem.io/documents/IntelOptanePMem_DSM_Interface-V2.0.pdf
[2]: http://lore.kernel.org/r/159408711335.2385045.2567600405906448375.stgit@dwillia2-desk3.amr.corp.intel.com

---

Dan Williams (16):
      ndctl/build: Fix zero-length array warnings
      ndctl/dimm: Fix chatty status messages
      ndctl/list: Indicate firmware update capability
      ndctl/dimm: Detect firmware-update vs ARS conflict
      ndctl/dimm: Improve firmware-update failure message
      ndctl/dimm: Prepare to emit dimm json object after firmware update
      ndctl/dimm: Emit dimm firmware details after update
      ndctl/list: Add firmware activation enumeration
      ndctl/dimm: Auto-arm firmware activation
      ndctl/bus: Add 'activate-firmware' command
      ndctl/docs: Update copyright date
      ndctl/test: Test firmware-activation interface
      test: Validate strict iomem protections of pmem
      ndctl: Refactor nfit.h to acpi.h
      daxctl: Add 'split-acpi' command to generate custom ACPI tables
      test/ndctl: mremap pmd confusion


 Documentation/copyright.txt                     |    2 
 Documentation/ndctl/Makefile.am                 |    3 
 Documentation/ndctl/ndctl-activate-firmware.txt |  130 +++
 Documentation/ndctl/ndctl-list.txt              |   39 +
 Documentation/ndctl/ndctl-update-firmware.txt   |   40 +
 acpi.h                                          |  236 ++++++
 daxctl/Makefile.am                              |    1 
 daxctl/acpi.c                                   |  870 +++++++++++++++++++++++
 daxctl/builtin.h                                |    1 
 daxctl/daxctl.c                                 |    1 
 ndctl/Makefile.am                               |    1 
 ndctl/action.h                                  |    1 
 ndctl/builtin.h                                 |    1 
 ndctl/bus.c                                     |  173 ++++-
 ndctl/create-nfit.c                             |   66 --
 ndctl/dimm.c                                    |  278 +++++--
 ndctl/firmware-update.h                         |    1 
 ndctl/lib/hpe1.h                                |    4 
 ndctl/lib/libndctl.c                            |  258 +++++++
 ndctl/lib/libndctl.sym                          |   14 
 ndctl/lib/msft.h                                |    2 
 ndctl/lib/private.h                             |    3 
 ndctl/libndctl.h                                |   35 +
 ndctl/list.c                                    |   13 
 ndctl/ndctl.c                                   |    1 
 ndctl/ndctl.h                                   |    2 
 ndctl/util/json-firmware.c                      |   80 --
 nfit.h                                          |   65 --
 test.h                                          |    2 
 test/Makefile.am                                |    9 
 test/dax-dev.c                                  |    4 
 test/dax-pmd.c                                  |   99 +++
 test/device-dax.c                               |    7 
 test/firmware-update.sh                         |   50 +
 test/revoke-devmem.c                            |  143 ++++
 util/json.c                                     |  181 +++++
 util/json.h                                     |   20 -
 37 files changed, 2509 insertions(+), 327 deletions(-)
 create mode 100644 Documentation/ndctl/ndctl-activate-firmware.txt
 create mode 100644 acpi.h
 create mode 100644 daxctl/acpi.c
 delete mode 100644 ndctl/util/json-firmware.c
 delete mode 100644 nfit.h
 create mode 100644 test/revoke-devmem.c

base-commit: c7767834871f7ce50a2abe1da946e9e16fb08eda
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

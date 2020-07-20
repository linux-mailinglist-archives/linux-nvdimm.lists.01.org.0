Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC5D227351
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 Jul 2020 01:54:12 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4FB231242E171;
	Mon, 20 Jul 2020 16:54:10 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AC6D912404ADA
	for <linux-nvdimm@lists.01.org>; Mon, 20 Jul 2020 16:54:08 -0700 (PDT)
IronPort-SDR: bYc4FfSHGJqsD4OgfmNCeadpObDss8ZPDLnzgkkfoxzXqUi1S8eDmHA7IqyffQNINWt1stwDoS
 DEMn+XJ6U3OA==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="168172076"
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800";
   d="scan'208";a="168172076"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 16:54:08 -0700
IronPort-SDR: A9tisiUuAa/rA4fsUnKNWRWj6v/aWuTuYfQ28lOMODeIvKZQN18kDtt0wcrH8Va/ujOeAvWYow
 jHm3DPppP3ng==
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800";
   d="scan'208";a="487893537"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 16:54:08 -0700
Subject: [ndctl PATCH v2 0/4] Firmware Activation and Test Updates
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: vishal.l.verma@intel.com
Date: Mon, 20 Jul 2020 16:37:51 -0700
Message-ID: <159528827109.994840.13180558014653471832.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: BOTQRVZ4HQD2PB6LYS67MD3KBKR3EYUE
X-Message-ID-Hash: BOTQRVZ4HQD2PB6LYS67MD3KBKR3EYUE
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BOTQRVZ4HQD2PB6LYS67MD3KBKR3EYUE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Changes since v1 [1]:
- Update the firmware-activation patches per v3 of the kernel support
  series. Specifically handle the rename of
  {ndbusX,nmemX}/firmware_activate to {ndbusX,nmemX}/firmware/activate,
  add support for ndbusX/firmware/capability, and account for ability to
  specify "quiesce" or "live" to ndbusX/firmware/activate to select the
  activation method.

- This series replaces patch 8, 9, 10, and 12 from the v1 posting.

[1]: http://lore.kernel.org/r/159408961822.2386154.888266173771881937.stgit@dwillia2-desk3.amr.corp.intel.com

---

Some persistent memory devices run a firmware locally on the device /
"DIMM" to perform tasks like media management, capacity provisioning,
and health monitoring. The process of updating that firmware typically
involves a reboot because it has implications for in-flight memory
transactions. However, reboots are disruptive and at least the Intel
persistent memory platform implementation, described by the Intel ACPI
DSM specification [2], has added support for activating firmware at
runtime.

As mentioned in the kernel patches adding support for firmware-activate
[3], ndctl is extended with the following functionality:

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


3/ The new activate-firmware command triggers firmware activation per
   the platform enumerated context, "suspend" vs "live", or can be forced
   to "live" if there is explicit knowledge that allowing applications
   and devices to race the quiesce timeout will have no adverse effects.

    ndctl activate-firmware nfit_test.0 [--force]

[2]: https://pmem.io/documents/IntelOptanePMem_DSM_Interface-V2.0.pdf
[3]: http://lore.kernel.org/r/159528284411.993790.11733759435137949717.stgit@dwillia2-desk3.amr.corp.intel.com 

---

Dan Williams (4):
      ndctl/list: Add firmware activation enumeration
      ndctl/dimm: Auto-arm firmware activation
      ndctl/bus: Add 'activate-firmware' command
      ndctl/test: Test firmware-activation interface


 Documentation/ndctl/Makefile.am                 |    3 
 Documentation/ndctl/ndctl-activate-firmware.txt |  146 +++++++++++++
 Documentation/ndctl/ndctl-list.txt              |   39 +++
 Documentation/ndctl/ndctl-update-firmware.txt   |   16 +
 ndctl/action.h                                  |    1 
 ndctl/builtin.h                                 |    1 
 ndctl/bus.c                                     |  158 +++++++++++++-
 ndctl/dimm.c                                    |  125 ++++++++++-
 ndctl/lib/libndctl.c                            |  257 +++++++++++++++++++++++
 ndctl/lib/libndctl.sym                          |   14 +
 ndctl/lib/private.h                             |    4 
 ndctl/libndctl.h                                |   35 +++
 ndctl/list.c                                    |    3 
 ndctl/ndctl.c                                   |    1 
 test/firmware-update.sh                         |   47 ++++
 util/json.c                                     |  117 +++++++++-
 util/json.h                                     |    3 
 17 files changed, 920 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/ndctl/ndctl-activate-firmware.txt
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

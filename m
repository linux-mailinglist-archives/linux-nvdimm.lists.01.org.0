Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E339B36660F
	for <lists+linux-nvdimm@lfdr.de>; Wed, 21 Apr 2021 09:05:34 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 25979100EAB41;
	Wed, 21 Apr 2021 00:05:33 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C8DD5100F225F
	for <linux-nvdimm@lists.01.org>; Wed, 21 Apr 2021 00:05:30 -0700 (PDT)
IronPort-SDR: +8nRJQRD06Ppl5wnaFKEqjtz4beyfmv/F1VCma2o8Ryrpn5gx4WyFeTHLw7lGqr25YYMy6nOpp
 vTJEihuz4G2w==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="175758426"
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400";
   d="scan'208";a="175758426"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 00:05:29 -0700
IronPort-SDR: WUI6B6A2c1385Mjp3QwBr7DCDjFLPz6hbPrJAmTtPnqqn7pKBakBTUI7ilMc/lUVEP/zYlaiMi
 II+qu07Imt7Q==
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400";
   d="scan'208";a="463482473"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 00:05:28 -0700
Subject: [PATCH] MAINTAINERS: Move nvdimm mailing list
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Wed, 21 Apr 2021 00:05:28 -0700
Message-ID: <161898872871.3406469.4054282559340528393.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: CAAP5VWAZYF4V4GXGIQATY5K72OYHXBU
X-Message-ID-Hash: CAAP5VWAZYF4V4GXGIQATY5K72OYHXBU
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CAAP5VWAZYF4V4GXGIQATY5K72OYHXBU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

After seeing some users have subscription management trouble, more spam
than other Linux development lists, and considering some of the benefits
of kernel.org hosted lists, nvdimm and persistent memory development is
moving to nvdimm@lists.linux.dev.

The old list will remain up until v5.14-rc1 and shutdown thereafter.

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Oliver O'Halloran <oohall@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/obsolete/sysfs-class-dax    |    2 +
 Documentation/ABI/removed/sysfs-bus-nfit      |    2 +
 Documentation/ABI/testing/sysfs-bus-nfit      |   40 +++++++++++++------------
 Documentation/ABI/testing/sysfs-bus-papr-pmem |    4 +--
 Documentation/driver-api/nvdimm/nvdimm.rst    |    2 +
 MAINTAINERS                                   |   14 ++++-----
 6 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/Documentation/ABI/obsolete/sysfs-class-dax b/Documentation/ABI/obsolete/sysfs-class-dax
index 0faf1354cd05..5bcce27458e3 100644
--- a/Documentation/ABI/obsolete/sysfs-class-dax
+++ b/Documentation/ABI/obsolete/sysfs-class-dax
@@ -1,7 +1,7 @@
 What:           /sys/class/dax/
 Date:           May, 2016
 KernelVersion:  v4.7
-Contact:        linux-nvdimm@lists.01.org
+Contact:        nvdimm@lists.linux.dev
 Description:	Device DAX is the device-centric analogue of Filesystem
 		DAX (CONFIG_FS_DAX).  It allows memory ranges to be
 		allocated and mapped without need of an intervening file
diff --git a/Documentation/ABI/removed/sysfs-bus-nfit b/Documentation/ABI/removed/sysfs-bus-nfit
index ae8c1ca53828..277437005def 100644
--- a/Documentation/ABI/removed/sysfs-bus-nfit
+++ b/Documentation/ABI/removed/sysfs-bus-nfit
@@ -1,7 +1,7 @@
 What:		/sys/bus/nd/devices/regionX/nfit/ecc_unit_size
 Date:		Aug, 2017
 KernelVersion:	v4.14 (Removed v4.18)
-Contact:	linux-nvdimm@lists.01.org
+Contact:	nvdimm@lists.linux.dev
 Description:
 		(RO) Size of a write request to a DIMM that will not incur a
 		read-modify-write cycle at the memory controller.
diff --git a/Documentation/ABI/testing/sysfs-bus-nfit b/Documentation/ABI/testing/sysfs-bus-nfit
index 63ef0b9ecce7..e7282d184a74 100644
--- a/Documentation/ABI/testing/sysfs-bus-nfit
+++ b/Documentation/ABI/testing/sysfs-bus-nfit
@@ -5,7 +5,7 @@ Interface Table (NFIT)' section in the ACPI specification
 What:		/sys/bus/nd/devices/nmemX/nfit/serial
 Date:		Jun, 2015
 KernelVersion:	v4.2
-Contact:	linux-nvdimm@lists.01.org
+Contact:	nvdimm@lists.linux.dev
 Description:
 		(RO) Serial number of the NVDIMM (non-volatile dual in-line
 		memory module), assigned by the module vendor.
@@ -14,7 +14,7 @@ Description:
 What:		/sys/bus/nd/devices/nmemX/nfit/handle
 Date:		Apr, 2015
 KernelVersion:	v4.2
-Contact:	linux-nvdimm@lists.01.org
+Contact:	nvdimm@lists.linux.dev
 Description:
 		(RO) The address (given by the _ADR object) of the device on its
 		parent bus of the NVDIMM device containing the NVDIMM region.
@@ -23,7 +23,7 @@ Description:
 What:		/sys/bus/nd/devices/nmemX/nfit/device
 Date:		Apr, 2015
 KernelVersion:	v4.1
-Contact:	linux-nvdimm@lists.01.org
+Contact:	nvdimm@lists.linux.dev
 Description:
 		(RO) Device id for the NVDIMM, assigned by the module vendor.
 
@@ -31,7 +31,7 @@ Description:
 What:		/sys/bus/nd/devices/nmemX/nfit/rev_id
 Date:		Jun, 2015
 KernelVersion:	v4.2
-Contact:	linux-nvdimm@lists.01.org
+Contact:	nvdimm@lists.linux.dev
 Description:
 		(RO) Revision of the NVDIMM, assigned by the module vendor.
 
@@ -39,7 +39,7 @@ Description:
 What:		/sys/bus/nd/devices/nmemX/nfit/phys_id
 Date:		Apr, 2015
 KernelVersion:	v4.2
-Contact:	linux-nvdimm@lists.01.org
+Contact:	nvdimm@lists.linux.dev
 Description:
 		(RO) Handle (i.e., instance number) for the SMBIOS (system
 		management BIOS) Memory Device structure describing the NVDIMM
@@ -49,7 +49,7 @@ Description:
 What:		/sys/bus/nd/devices/nmemX/nfit/flags
 Date:		Jun, 2015
 KernelVersion:	v4.2
-Contact:	linux-nvdimm@lists.01.org
+Contact:	nvdimm@lists.linux.dev
 Description:
 		(RO) The flags in the NFIT memory device sub-structure indicate
 		the state of the data on the nvdimm relative to its energy
@@ -68,7 +68,7 @@ What:		/sys/bus/nd/devices/nmemX/nfit/format1
 What:		/sys/bus/nd/devices/nmemX/nfit/formats
 Date:		Apr, 2016
 KernelVersion:	v4.7
-Contact:	linux-nvdimm@lists.01.org
+Contact:	nvdimm@lists.linux.dev
 Description:
 		(RO) The interface codes indicate support for persistent memory
 		mapped directly into system physical address space and / or a
@@ -84,7 +84,7 @@ Description:
 What:		/sys/bus/nd/devices/nmemX/nfit/vendor
 Date:		Apr, 2016
 KernelVersion:	v4.7
-Contact:	linux-nvdimm@lists.01.org
+Contact:	nvdimm@lists.linux.dev
 Description:
 		(RO) Vendor id of the NVDIMM.
 
@@ -92,7 +92,7 @@ Description:
 What:		/sys/bus/nd/devices/nmemX/nfit/dsm_mask
 Date:		May, 2016
 KernelVersion:	v4.7
-Contact:	linux-nvdimm@lists.01.org
+Contact:	nvdimm@lists.linux.dev
 Description:
 		(RO) The bitmask indicates the supported device specific control
 		functions relative to the NVDIMM command family supported by the
@@ -102,7 +102,7 @@ Description:
 What:		/sys/bus/nd/devices/nmemX/nfit/family
 Date:		Apr, 2016
 KernelVersion:	v4.7
-Contact:	linux-nvdimm@lists.01.org
+Contact:	nvdimm@lists.linux.dev
 Description:
 		(RO) Displays the NVDIMM family command sets. Values
 		0, 1, 2 and 3 correspond to NVDIMM_FAMILY_INTEL,
@@ -118,7 +118,7 @@ Description:
 What:		/sys/bus/nd/devices/nmemX/nfit/id
 Date:		Apr, 2016
 KernelVersion:	v4.7
-Contact:	linux-nvdimm@lists.01.org
+Contact:	nvdimm@lists.linux.dev
 Description:
 		(RO) ACPI specification 6.2 section 5.2.25.9, defines an
 		identifier for an NVDIMM, which refelects the id attribute.
@@ -127,7 +127,7 @@ Description:
 What:		/sys/bus/nd/devices/nmemX/nfit/subsystem_vendor
 Date:		Apr, 2016
 KernelVersion:	v4.7
-Contact:	linux-nvdimm@lists.01.org
+Contact:	nvdimm@lists.linux.dev
 Description:
 		(RO) Sub-system vendor id of the NVDIMM non-volatile memory
 		subsystem controller.
@@ -136,7 +136,7 @@ Description:
 What:		/sys/bus/nd/devices/nmemX/nfit/subsystem_rev_id
 Date:		Apr, 2016
 KernelVersion:	v4.7
-Contact:	linux-nvdimm@lists.01.org
+Contact:	nvdimm@lists.linux.dev
 Description:
 		(RO) Sub-system revision id of the NVDIMM non-volatile memory subsystem
 		controller, assigned by the non-volatile memory subsystem
@@ -146,7 +146,7 @@ Description:
 What:		/sys/bus/nd/devices/nmemX/nfit/subsystem_device
 Date:		Apr, 2016
 KernelVersion:	v4.7
-Contact:	linux-nvdimm@lists.01.org
+Contact:	nvdimm@lists.linux.dev
 Description:
 		(RO) Sub-system device id for the NVDIMM non-volatile memory
 		subsystem controller, assigned by the non-volatile memory
@@ -156,7 +156,7 @@ Description:
 What:		/sys/bus/nd/devices/ndbusX/nfit/revision
 Date:		Jun, 2015
 KernelVersion:	v4.2
-Contact:	linux-nvdimm@lists.01.org
+Contact:	nvdimm@lists.linux.dev
 Description:
 		(RO) ACPI NFIT table revision number.
 
@@ -164,7 +164,7 @@ Description:
 What:		/sys/bus/nd/devices/ndbusX/nfit/scrub
 Date:		Sep, 2016
 KernelVersion:	v4.9
-Contact:	linux-nvdimm@lists.01.org
+Contact:	nvdimm@lists.linux.dev
 Description:
 		(RW) This shows the number of full Address Range Scrubs (ARS)
 		that have been completed since driver load time. Userspace can
@@ -177,7 +177,7 @@ Description:
 What:		/sys/bus/nd/devices/ndbusX/nfit/hw_error_scrub
 Date:		Sep, 2016
 KernelVersion:	v4.9
-Contact:	linux-nvdimm@lists.01.org
+Contact:	nvdimm@lists.linux.dev
 Description:
 		(RW) Provides a way to toggle the behavior between just adding
 		the address (cache line) where the MCE happened to the poison
@@ -196,7 +196,7 @@ Description:
 What:		/sys/bus/nd/devices/ndbusX/nfit/dsm_mask
 Date:		Jun, 2017
 KernelVersion:	v4.13
-Contact:	linux-nvdimm@lists.01.org
+Contact:	nvdimm@lists.linux.dev
 Description:
 		(RO) The bitmask indicates the supported bus specific control
 		functions. See the section named 'NVDIMM Root Device _DSMs' in
@@ -205,7 +205,7 @@ Description:
 What:		/sys/bus/nd/devices/ndbusX/nfit/firmware_activate_noidle
 Date:		Apr, 2020
 KernelVersion:	v5.8
-Contact:	linux-nvdimm@lists.01.org
+Contact:	nvdimm@lists.linux.dev
 Description:
 		(RW) The Intel platform implementation of firmware activate
 		support exposes an option let the platform force idle devices in
@@ -225,7 +225,7 @@ Description:
 What:		/sys/bus/nd/devices/regionX/nfit/range_index
 Date:		Jun, 2015
 KernelVersion:	v4.2
-Contact:	linux-nvdimm@lists.01.org
+Contact:	nvdimm@lists.linux.dev
 Description:
 		(RO) A unique number provided by the BIOS to identify an address
 		range. Used by NVDIMM Region Mapping Structure to uniquely refer
diff --git a/Documentation/ABI/testing/sysfs-bus-papr-pmem b/Documentation/ABI/testing/sysfs-bus-papr-pmem
index 8316c33862a0..92e2db0e2d3d 100644
--- a/Documentation/ABI/testing/sysfs-bus-papr-pmem
+++ b/Documentation/ABI/testing/sysfs-bus-papr-pmem
@@ -1,7 +1,7 @@
 What:		/sys/bus/nd/devices/nmemX/papr/flags
 Date:		Apr, 2020
 KernelVersion:	v5.8
-Contact:	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm@lists.01.org,
+Contact:	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, nvdimm@lists.linux.dev,
 Description:
 		(RO) Report flags indicating various states of a
 		papr-pmem NVDIMM device. Each flag maps to a one or
@@ -36,7 +36,7 @@ Description:
 What:		/sys/bus/nd/devices/nmemX/papr/perf_stats
 Date:		May, 2020
 KernelVersion:	v5.9
-Contact:	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm@lists.01.org,
+Contact:	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, nvdimm@lists.linux.dev,
 Description:
 		(RO) Report various performance stats related to papr-scm NVDIMM
 		device.  Each stat is reported on a new line with each line
diff --git a/Documentation/driver-api/nvdimm/nvdimm.rst b/Documentation/driver-api/nvdimm/nvdimm.rst
index ef6d59e0978e..1d8302b89bd4 100644
--- a/Documentation/driver-api/nvdimm/nvdimm.rst
+++ b/Documentation/driver-api/nvdimm/nvdimm.rst
@@ -4,7 +4,7 @@ LIBNVDIMM: Non-Volatile Devices
 
 libnvdimm - kernel / libndctl - userspace helper library
 
-linux-nvdimm@lists.01.org
+nvdimm@lists.linux.dev
 
 Version 13
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 9450e052f1b1..4d18fa67f71b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5146,7 +5146,7 @@ DEVICE DIRECT ACCESS (DAX)
 M:	Dan Williams <dan.j.williams@intel.com>
 M:	Vishal Verma <vishal.l.verma@intel.com>
 M:	Dave Jiang <dave.jiang@intel.com>
-L:	linux-nvdimm@lists.01.org
+L:	nvdimm@lists.linux.dev
 S:	Supported
 F:	drivers/dax/
 
@@ -6887,7 +6887,7 @@ M:	Dan Williams <dan.j.williams@intel.com>
 R:	Matthew Wilcox <willy@infradead.org>
 R:	Jan Kara <jack@suse.cz>
 L:	linux-fsdevel@vger.kernel.org
-L:	linux-nvdimm@lists.01.org
+L:	nvdimm@lists.linux.dev
 S:	Supported
 F:	fs/dax.c
 F:	include/linux/dax.h
@@ -10146,7 +10146,7 @@ LIBNVDIMM BLK: MMIO-APERTURE DRIVER
 M:	Dan Williams <dan.j.williams@intel.com>
 M:	Vishal Verma <vishal.l.verma@intel.com>
 M:	Dave Jiang <dave.jiang@intel.com>
-L:	linux-nvdimm@lists.01.org
+L:	nvdimm@lists.linux.dev
 S:	Supported
 Q:	https://patchwork.kernel.org/project/linux-nvdimm/list/
 P:	Documentation/nvdimm/maintainer-entry-profile.rst
@@ -10157,7 +10157,7 @@ LIBNVDIMM BTT: BLOCK TRANSLATION TABLE
 M:	Vishal Verma <vishal.l.verma@intel.com>
 M:	Dan Williams <dan.j.williams@intel.com>
 M:	Dave Jiang <dave.jiang@intel.com>
-L:	linux-nvdimm@lists.01.org
+L:	nvdimm@lists.linux.dev
 S:	Supported
 Q:	https://patchwork.kernel.org/project/linux-nvdimm/list/
 P:	Documentation/nvdimm/maintainer-entry-profile.rst
@@ -10167,7 +10167,7 @@ LIBNVDIMM PMEM: PERSISTENT MEMORY DRIVER
 M:	Dan Williams <dan.j.williams@intel.com>
 M:	Vishal Verma <vishal.l.verma@intel.com>
 M:	Dave Jiang <dave.jiang@intel.com>
-L:	linux-nvdimm@lists.01.org
+L:	nvdimm@lists.linux.dev
 S:	Supported
 Q:	https://patchwork.kernel.org/project/linux-nvdimm/list/
 P:	Documentation/nvdimm/maintainer-entry-profile.rst
@@ -10175,7 +10175,7 @@ F:	drivers/nvdimm/pmem*
 
 LIBNVDIMM: DEVICETREE BINDINGS
 M:	Oliver O'Halloran <oohall@gmail.com>
-L:	linux-nvdimm@lists.01.org
+L:	nvdimm@lists.linux.dev
 S:	Supported
 Q:	https://patchwork.kernel.org/project/linux-nvdimm/list/
 F:	Documentation/devicetree/bindings/pmem/pmem-region.txt
@@ -10186,7 +10186,7 @@ M:	Dan Williams <dan.j.williams@intel.com>
 M:	Vishal Verma <vishal.l.verma@intel.com>
 M:	Dave Jiang <dave.jiang@intel.com>
 M:	Ira Weiny <ira.weiny@intel.com>
-L:	linux-nvdimm@lists.01.org
+L:	nvdimm@lists.linux.dev
 S:	Supported
 Q:	https://patchwork.kernel.org/project/linux-nvdimm/list/
 P:	Documentation/nvdimm/maintainer-entry-profile.rst
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
